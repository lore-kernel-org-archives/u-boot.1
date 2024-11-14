Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1643CD6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D6589584;
	Thu, 14 Nov 2024 19:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlVrNBnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F4289620; Thu, 14 Nov 2024 19:02:51 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89578926E
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ee53b30470so528140eaf.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731607368; x=1732212168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gGfxJfHsEkAWod/oYXjX6Hh0DPHMjaSnmJTGD2IASYY=;
 b=AlVrNBnwm5z/7AOwqVAhPO14t/3XAwkcVvtuEeT2J8mzWir+wXZD+pHXkwslDtoU40
 9ppVE8yHSYQBa68Twa9OVNzFulh2b5h4YEkpkLBZgkp+huYKGumpjjlr3FAesoLNbZkt
 HCgo15oJJDJkS0R/qWUiANjZ9HMwJtGFKoXXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607368; x=1732212168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGfxJfHsEkAWod/oYXjX6Hh0DPHMjaSnmJTGD2IASYY=;
 b=r7hSjbzDzEMgk7DOmZTiuX8bneDzHkaBRh0CK75Sqn4kwtyZv1gcPWGAnaCvViYmBE
 zFxuh0lUzVLqAHdn7lb1/X3oS3Q7f8utclydmspuZUeEroJ2eaXMbBtcMgg46lPSqQrq
 P53+Df6SQgeOGjrlOeAaU9c43CJc3EbeXwzeO8jGA3cXzbZLqBWk5vCiwcDkrP34sIi5
 QRn6ntATINIbtu6Rq+GlraTssm/gIS1azaRI6YJCwWjdi+ouQPmgB1ssOhXwdTkoJTzT
 RO9JCfSeDOe8rXhS3k/olS1zxKYRN9nWES0q0HiHUGfCRVIbkvQ60CvRqxxSQxBF9YiW
 mZTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQa7MhumWHAIiUOyCY/BJpvoguOGT8keSPBeze7U8Jy5uMUnisLx2zL5Ntb0JHlNIKJzDRNpM=@lists.denx.de
X-Gm-Message-State: AOJu0YwHL8sH+xdZxIiVa6hv/MJMhrqphCJ8cLVB3+N09H0k8AfXnjLs
 3gY6XvagGebcUrT+CP9srdqIpTlM+m93EjUUcLIMvX1CKX3ga06a9Yy6hRPIYas=
X-Google-Smtp-Source: AGHT+IGvlzbQgEH6rkacu27APXX4XGdjm/Xgmn2FbvasURw1z4w8L9yYCxko5jKAuovDr9HxK8zNBQ==
X-Received: by 2002:a05:6871:10e:b0:288:4823:fe1b with SMTP id
 586e51a60fabf-295ccfd946dmr11905654fac.17.1731607368344; 
 Thu, 14 Nov 2024 10:02:48 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-296109c7782sm682518fac.32.2024.11.14.10.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:02:47 -0800 (PST)
Date: Thu, 14 Nov 2024 12:02:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Message-ID: <20241114180244.GK3600562@bill-the-cat>
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
 <20241113142437.GM3600562@bill-the-cat>
 <5fb2f6ab-c47d-4ea0-83bf-a14d8e737cb1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eLBtVxMHpIJoVvNq"
Content-Disposition: inline
In-Reply-To: <5fb2f6ab-c47d-4ea0-83bf-a14d8e737cb1@linaro.org>
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


--eLBtVxMHpIJoVvNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 03:47:16PM +0100, Caleb Connolly wrote:
>=20
>=20
> On 13/11/2024 15:24, Tom Rini wrote:
> > On Wed, Nov 13, 2024 at 06:30:08AM +0100, Caleb Connolly wrote:
> >=20
> >> It may be the case that MMC support is enabled even though the board
> >> we're booting on doesn't have any MMC devices. Move the print over to
> >> the print_mmc_devices() function where we can only print it if we
> >> actually have MMC devices.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >=20
> > I'm not sure I like this. What we do / don't find on startup is part of
> > the not-exactly-API. It's true that if we don't print an MMC line at
> > all, and we should have MMC, the user (and any scripts that parse
> > console output) but now we're also increasing the code size a little bit
> > too. I can be convinced this is a good idea, but I'm not there yet.
>=20
> Hmm, fair enough. I'll offer some more context, maybe there's a smarter
> approach here I'm not seeing.
>=20
> The main place this shows up is on Qualcomm boards. Since all Qualcomm
> armv8 targets are supported with qcom_defconfig (just by adjusting which
> DTB is used), we can't know at build time whether the board has MMC.
>=20
> I guess my thinking behind this patch comes from a bigger picture desire
> to get UFS and MMC more aligned. The number of devices with UFS is
> definitely going up, and I would argue that U-Boot's inconsistent
> treatment of these two storage classes (obviously a result of their
> relative age and support in the codebase) is really unintuitive and
> weird for users (nevermind that the "scsi" command is used for UFS
> devices, cute though it is).
>=20
> I'm really wary to open this whole can of worms, since I guess it would
> require some larger efforts and collaboration to fix. But maybe this
> patch (or one like it) would be better suited in the context of some
> larger effort to unify storage backends?

I get it now, thanks. And yeah, this is part of our inconsistency in
printing information. I'd rather leave things alone here (assuming the
MMC: printout is reasonable in the case of no devices, similar to how
the Net: printout is reasonable in that case) and wait for a longer term
/ high level solution wherein for example as we go down the device tree
we give some consistent level of information for everything (and more or
less info depending on verbosity configured perhaps).

--=20
Tom

--eLBtVxMHpIJoVvNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2OzkACgkQFHw5/5Y0
tyzB2AwAiSWdGQMtP0KDNFEwRHto7avYRSNaFy2PwBE4XSo6M0AGVtr3lYm0VfiV
ZdSylIkx+4Gn6SvVXBUdAiehw/voVpb3JIN+8U6lp3XYmWQW7uNTYYNbNPYwyuKY
KmtgRDqt0WI89yWEXUJuEDCyjQcn9H87lyMPfsAaCbSuM9UCYDDjJSy9M7yd7a9n
jqGYtCVJiaZQg9eS1OAGOcBoEuiYto0i2hKwEtvz4+c/rzOaVpDskEPRbDCVvMin
6L9TYRJOAMQAnShiIkRU8rXihh48BR5bA+z7lBb7z2nYucK/cnO2LZdFkpd1KTV6
NVzypeAgbPsW3hLRtq5dehnymurddSsHxtRy6lFt0Dj+h/1JMJpRyBHuQ82pvJhB
6f9Q4mxrKMs7x/5WcmNtd1TZVw+M2qu6SiEtUkayrn6zFUHjdP78xJhcL6ta+1S4
UhaLoWjDkohqLR5xNaEbp9PhL1QYRw/YC/An8V5mJ5NBgAvDiEqr8AHLR1UXHpK8
1c70eTiY
=75uE
-----END PGP SIGNATURE-----

--eLBtVxMHpIJoVvNq--
