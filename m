Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A65AD2A539
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 17:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A00E588D9A;
	Wed, 16 Oct 2024 19:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Km5ftD3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E9F88D91; Wed, 16 Oct 2024 19:48:05 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF1988C05
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 19:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbf0769512so588016d6.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729100882; x=1729705682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cm20DOJ6T+X3j++fEw1iV+HRMTMEzTqsS0/ji9pmbKg=;
 b=Km5ftD3NRylRhYz56/ZvChvCEJtwbiy9X1jLr6Ba01feCM1nRBhBok5QT6Xlj/UpHL
 i/qhJ9nXbiWvwKncA5bFMA0fbdtANCQH/YKYPjFUajv7zHgWlCy0U2yx/O5rD5IG6j/x
 71Vct5L554FAh3OedBYsRnk3AG4/MVpa1aPEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729100882; x=1729705682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cm20DOJ6T+X3j++fEw1iV+HRMTMEzTqsS0/ji9pmbKg=;
 b=WozMZZUG5ODrGJMjAyqtm3BMyDViJEGaXQpk/emSc7DFxqPEsTufrydWVefwWSGlv0
 xHiFKF9+LZNzmOQ21hP1drEA2N3yYDvgviwJqXTUkFbHUO7mrKVtE+/gmKHSCTLVXMsZ
 kSniKN4dH5bvN3LZ/2tnLUIpXg/zpW75AM/WF4WhHV8fvvCd0iMNnAEAmHGieDJ2zWVU
 qqsgacXWDeGxZcOZHV4SGwzqDgsG5wKS5SJto8ybY4m5A9mjbb3FYrSLhXbyLZI9a5C6
 QR+KGMkwijtoGqK80nfzX1JvOFPdqQv+RDY6HDQZvh6q6qMyd+gFdwVzOxrWRmBLyMAf
 qbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxkqr87jdwdXoAHvnE4vp2jVSvri5lP8F1iuuP4nQhxTjuvTalFvXcA8SY2WgfUUPsoMQv2+Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8IMGEiGnPJfM8bV4dmtgux2qcNylz6WzANA6KYPjiiwQmwzQR
 OaosQsdxUAJE3Rj8vjwWSRl22VL9ql6CPO94PFURTSPuq4kJyRX9m4jew/Pj+eU=
X-Google-Smtp-Source: AGHT+IGihuMTnIZaii28dT4O+3bltoMo9Hw8S9PHOPTVsA0+1H7LkuXbWssXAzdF9DM0qwYgfDA8kg==
X-Received: by 2002:a05:6214:2f10:b0:6c3:5496:3e06 with SMTP id
 6a1803df08f44-6cbefffdfe6mr311837676d6.10.1729100882003; 
 Wed, 16 Oct 2024 10:48:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290fa71sm19939026d6.27.2024.10.16.10.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 10:48:00 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:47:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 14/17] imx95_evk: add i.MX95 19x19 EVK board basic support
Message-ID: <20241016174757.GB4959@bill-the-cat>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
 <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bsTZ7jVPKvuotl9E"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
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


--bsTZ7jVPKvuotl9E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 08:36:12AM -0300, Fabio Estevam wrote:
> Hi Alice,
>=20
> On Wed, Oct 16, 2024 at 4:19=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.com>=
 wrote:
> >
> > From: Ye Li <ye.li@nxp.com>
> >
> > This patch adds i.MX95 19x19 EVK board basic support.
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
[snip]
> > +       "initrd_addr=3D0x93800000\0" \
> > +       "initrd_high=3D0xffffffffffffffff\0" \
> > +       "emmc_dev=3D0\0"\
> > +       "sd_dev=3D1\0" \
> > +       "prepare_mcore=3Dsetenv mcore_clk clk-imx95.mcore_booted;\0" \
> > +       "scriptaddr=3D0x93500000\0" \
> > +       "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> > +       "image=3DImage\0" \
> > +       "splashimage=3D0xA0000000\0" \
> > +       "console=3DttyLP0,115200 earlycon\0" \
> > +       "fdt_addr_r=3D0x93000000\0"                       \
> > +       "fdt_addr=3D0x93000000\0"                 \
> > +       "fdt_high=3D0xffffffffffffffff\0"         \
[snip]
> Move this to board/freescale/imx95_evk/imx95_evk.env

And disabling relocation with fdt_high / initrd_high is not allowed and
checkpatch.pl calls this an error too.

--=20
Tom

--bsTZ7jVPKvuotl9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcP/E0ACgkQFHw5/5Y0
tywlCQwAk2iKdU7NCJC4gDVIwoJ9uNk0ObWi55JLlezbAFE7znXTAUV5yWZS2N6f
RVVLIXCgFdagLOw1x6JWILUmKOUKhiqTro3pJG+qw+gMaO2vwS9a/XxC5e7HyKp8
iTev31TqNGKQIw6XQq2zMk8eylSFpTPq3qIPnMjhTcI1yPj4oA4ae2bkQP4taePJ
S01jsVb8zOlyLlxc94aeqmPQJqlSQth1cttZq7W4cMYz1weAmjwvXNHWcEkudeX/
wsUIJDR1MLerQrFAkW4J88uGmZeUFWedLjdNXkugXs45ofdGAlpkrSryZ4EsuDZD
5Yiem47ANmi9SuVGv3p/nz9NMWeAPSDrNC3oB666DbkfYfVg+DsYv8Bs38qvS3g1
ImFDSpzlaOPOOqzwrpTGrrbj24fctr2kFs7o3OH8bprXgo1JC35RmmQ62XdLXPCQ
YEC4Ss1ndKY+W/LGEKNA+N3uN/6Fg6K48gUyBKWC1Vh4Y5XrejLS7CRdODtvyarX
0LFQo8um
=8GqN
-----END PGP SIGNATURE-----

--bsTZ7jVPKvuotl9E--
