Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A50C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5858C80EC0;
	Sat, 25 Jan 2025 22:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mrm0LjLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970BC80EF4; Sat, 25 Jan 2025 22:51:07 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3728280C91
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so280483785a.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737841862; x=1738446662; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RCItPAumNi3YkPwAhGuoBy61cd38EX/U8qv2kfxS+Pg=;
 b=mrm0LjLDQkiQvh4Vx7iYhvn2iMgeiN+A4hcbsHbw+Juevk/XzEvKMJrA9SRQJ+47Or
 +V7ejiLRJEWy7LMumUhKJ6Ilre7WOQ5CkwPZozCHEOAM2htImGxXVANaW/WfaA0AHrYR
 X8GVnmyfNvF5NYX0FwzKHnEwOM7HkHtD3V7mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737841862; x=1738446662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCItPAumNi3YkPwAhGuoBy61cd38EX/U8qv2kfxS+Pg=;
 b=gtQFIAvmqbz6itgQjLcZxFQG01RSJwSpeiJJhRlkTEdAg5SH+lh1dx2W5o2WMgVVnl
 hfJjsWdHEjQu6Don/ZF6bbYLpCh9ei1NWUBN3UyT09sB1A3ql+NigHdNA5XasEXyXvki
 mnc1Uks0pnFDveauKewpW2/posBaKR/CwJoqSUz7YSjSCUL2Vrn+VfYRADbZG3L+rMuM
 RdXVBpy7taicSpknXSM/yee8QjIGsAPPwj5ZEpC0DvBk6zcPAU8WeAtqAUtyikLCRD/y
 yTFT59zHvNaUG+CpzWGN1Udt/pQTgAKEzIzqFl8KvWpwu9z4MmgJlTl8KbpUIOOGsWin
 OAAg==
X-Gm-Message-State: AOJu0YxsP0Ysb+cYdR3H6mB8a4RZmEdkNAruy2d7RO9ugXTqjon/JyVF
 Q2qDAp1S+r236Uwp1pksElxZFEuZaxjrhPaB4QLlR3q5/+/5chH5P+aCIISiK6k=
X-Gm-Gg: ASbGncsK1BbGi5QPERj6lj6ZkHJ4wps4qDBbmHng2Np3cZ0yAFUt1WP1ZKDBUEwwxjI
 d/8XjZ1U7zIss5gkp1kEqZefh+yfJ/sibkJYyAEBPTEHQSW2rRvbCco8n0LHYIt9k8A8xur37eo
 wifhXxeC0nM9ZGQqPT9A+t6ts2GqdR1GVoJn79twlRIqW583wtjWJZVeHcZANMuL8yPiyxKUtqZ
 w7kD56fjN00NS3Hc/yWtf4oz54TW4pGyUAReUP4WZAVGXF6MCxlOoJoTL5+tB+2z97BjjIqm+6J
 i29h
X-Google-Smtp-Source: AGHT+IHeK4cv2sXskxlDG8IFY7pxHg4PO1aDJJb7l3aMTWxfgOQSxnxX4eBZRNGqvA1WVhOADmEFgg==
X-Received: by 2002:a05:620a:19a1:b0:7b6:6701:7a4d with SMTP id
 af79cd13be357-7be6328a7e0mr5997376585a.56.1737841861972; 
 Sat, 25 Jan 2025 13:51:01 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae975a3sm230948485a.49.2025.01.25.13.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:51:00 -0800 (PST)
Date: Sat, 25 Jan 2025 15:50:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huang Jianan <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
Message-ID: <20250125215055.GF60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cKP0ipwRxRNGqurb"
Content-Disposition: inline
In-Reply-To: <20250125213150.1608395-2-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--cKP0ipwRxRNGqurb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:

> This fixture name is quite long and results in lots of verbose code.
> We know this is U-Boot so the 'u_boot_' part is not necessary.
>=20
> But it is also a bit of a misnomer, since it provides access to all the
> information available to tests. It is not just the console.
>=20
> It would be too confusing to use con as it would be confused with
> config and it is probably too short.
>=20
> So shorten it to 'ubpy'.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
>  102 files changed, 2591 insertions(+), 2591 deletions(-)

First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
it's how we interact with the stdin/stdout of the running U-Boot. And
indeed it provides more than that. But ubpy is too abstract and unclear,
and looking at the diffstat, I don't know that big global rename is
justified to save text space.

--=20
Tom

--cKP0ipwRxRNGqurb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVXL8ACgkQFHw5/5Y0
tywwUgwAmCv9+cbELcIz5xmY51Ptx1hbkOc8rIb+WeKSZQ7cFhIqTVMnzhhYZSq+
BGT6YUm5pkX+YBrSPSfhMGnPQ+ih5s/gAeVukiMGx75yqDF0fo5WHlnw/VgUHTnL
IpB5ey0sUWUXvhC1BvnKY8gT1SQpdP3594C1NYujUz4sExWJ7Q6mPHSnuxs7Lcax
6dJiKJyLsGEQPVtcH28uj9UOyJumdF7XG/ixgON5Pwzlw9koypzLGmOSz+9OXXHI
VnK4MwurWUuwzGguelnngfsDgmDPYtpVm5DxPlpSedHNRhMF6AisqQUqRdV6XbCp
yLncbxFCRRjDlSl8i+4GmZgN8Pm6hKGQ/qBQw/z0veGuzuBp8fpFqEfp0EXubtwl
ZeWvOjHnnM+MHDd05U6aArTstWj4pDAOeD8FfwSFEXhtJ/MyVdVSTM9955hyaUB9
Ss0c4xTDiX21fPpDaoV1zQIy+B0dT0bVcmoUL0PFKD4lTRhMn6xfaGiY1fOPXYuG
5luOhSNh
=P8FY
-----END PGP SIGNATURE-----

--cKP0ipwRxRNGqurb--
