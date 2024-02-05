Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C034CC48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD5FB8792D;
	Mon,  5 Feb 2024 19:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oldMgr3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7435687944; Mon,  5 Feb 2024 19:14:20 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC7287887
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d5a6b1dd60so1849457241.3
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707156857; x=1707761657; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BDnT3riII5jId56yG3HynEtkLu/8pc3mnfz1SmaZEJg=;
 b=oldMgr3g/SND+2Wf3/jE64KXyMGkQHXxi5a8qOiCexR1NVxCYyQu6N9r5GMNG9HBUv
 Ows5iDHyfndj0X3TdiFsblATGcsKRtWqsgLVyxBwA/MiE0+J7v3YtOlfU1dQXKpNJQSa
 W+gU2e1Jyo9KSm1U47u6Vw4SzkSg0RseLQ/6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707156857; x=1707761657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDnT3riII5jId56yG3HynEtkLu/8pc3mnfz1SmaZEJg=;
 b=MG6fwovq4fZ/JBmHciNrcMVzIXyFdRBhWKzEmuEoU2IFlYwShiXN8rbWZYM87XyaBx
 Tx5tGs6lcdc23wgO8ntnWHa3MWfCKxcc3VVBMZe8cku+DI0s14ggSTat4vRxWO7O5q+V
 0De3ZS8rGojR7GH6jihzjZgvGH5+itl5Yh6mhx/0vX3tWo9Zjns9sOYUrVpMYp2fW4Qq
 ZY1+7F0SON+Cfv0wTysJK3GGRMPK/YZCQI+0gFAfxcU9hpAcJZWRQsc2osN/ySFp5pg+
 ZBQMqahyuZOizhNmMl+QJ05N4GNSfZ3IDnkag3l4JlMC/Z4ObrnulzRcJoHg33bXQNU1
 ADMg==
X-Gm-Message-State: AOJu0YwyLd/bwxjrVQbAO+7kbvcjaSk9M+w8ileIARkpEAISj00ogfgy
 xHbVe3VqtdYHP5s83IzwoF8PtM8OQpTWRfvL68IWN4yLQf3ium+iWty6O3eHxu4=
X-Google-Smtp-Source: AGHT+IEKybu4orm8ZQCaZ8tc8rRmSxAKwrFzNF6rlsfXybOplos1XyAuz+kZ1s5Zq1t7loFkSj0fKA==
X-Received: by 2002:a67:fb56:0:b0:46d:3621:3c57 with SMTP id
 e22-20020a67fb56000000b0046d36213c57mr772697vsr.1.1707156856957; 
 Mon, 05 Feb 2024 10:14:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXrDBcKmYwlCGZ6dF7Sa/vFnd9j+kqQls07/RLQyjMG10xdwQplzn4MOMX2BJeQGuqoJJ5cJa8zU8gP1MVQOZvZi77BHLuR+OfZFQdmFVI2d2ElfgvRn6iq+NqD8yKO/+s4NDvMqU+PLbtnuK7+1xJiGZ2XGxFz2moiJrG7fDHaDKLLHG8+Bjm/HBnry5ddCM5idClMgtg7tUWXaoySCZ+BXHdPvGMpasapVCd6HR72pj5c1VHcH1ixdifj/pUEDIJ+t5746SHN/Sgn7A9ojt1fQHUrHs4Y1A/v0koIm8Q00PHSvssP6/H2aR3I1yb+SQ==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 qj11-20020a056214320b00b006869485d9eesm198049qvb.82.2024.02.05.10.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 10:14:16 -0800 (PST)
Date: Mon, 5 Feb 2024 13:14:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/3] cmd: rng: Add rng list command
Message-ID: <20240205181413.GA1539941@bill-the-cat>
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-4-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q4O4y51AZ4Ifw9E/"
Content-Disposition: inline
In-Reply-To: <20240131141426.34926-4-o451686892@gmail.com>
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


--q4O4y51AZ4Ifw9E/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 02:14:26PM +0000, Weizhao Ouyang wrote:

> The 'rng list' command probes all RNG devices and list those devices
> that are successfully probed. Also update the help info.
>=20
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> ---
>  cmd/rng.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Please update doc/usage/cmd/rng.rst as well, thanks.

--=20
Tom

--q4O4y51AZ4Ifw9E/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXBJXIACgkQFHw5/5Y0
tyxMXwv9HUlWIJhF1fsndoYaZiv+1gyVD6CXMep9WcWW2ZTG//P3hTh+kbDYdjXD
9hbLtwra/CCn74M2EB5KpkrPqyBaeBrPfq9BSsVTV79+40nDmkIVt7dgVtXdf5fi
v9JFRneesdaM3rP6opMw0VBWvmwC+lizcpIQmX8IkQhX2edOiXLeCFzR9kN+oDWx
1uC5KhWKGXd8tNmvzsQOvZndU+d1sGOqXq28YExSc9GvqvX7haUr5P0RT4OzZ5Eu
ccB1LjKql/M6wxjjITQqEvhQJvvMsXkHDTiMA/puUqi6a+o7cvCgI+BoFe9C1JIe
cU3j6mKFPSMI3fFirjhrkqIeWhheDM22w/h4JdauPCs5CGEIZmT1Vpuw+M5zN74z
n/fkvL/t2MLYc+FN9dt/j1V34V84N4Ep9BZ6p0zCiwqbfPDYkV1THJcEhBU1E+GM
TI1+c3rLixQrFthQaJGInPgiyGzJxICrenk8VH313Eq7tbpv68b8SVJ4MRxbT3Qc
z9m1N9Q1
=SpPM
-----END PGP SIGNATURE-----

--q4O4y51AZ4Ifw9E/--
