Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A606C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 15:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F2387F2A;
	Thu, 11 Apr 2024 17:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T/9QmyKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C8487F2A; Thu, 11 Apr 2024 17:36:12 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DB487DB1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 17:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c5fdd1598fso700084b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712849768; x=1713454568; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TCVvTNHpEdExalrrWAJKOzPkOZcZnNFXe8MFzmVxu8s=;
 b=T/9QmyKvXC0inZN3oa52TAc7q+wVy19XuwuwMqxsRQZQ51EMIbVnkpsGsYL59mkibT
 SdI9S+hrSdyFEmoD58RtjZH2qIZWahZ+/JyKnqvqwq6sKV1Emg4aZCddTNkgcR4ret06
 4w7NsaRepzZoMHXHwjYhriWS+GIUuyOIlqHlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712849768; x=1713454568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCVvTNHpEdExalrrWAJKOzPkOZcZnNFXe8MFzmVxu8s=;
 b=gcfI+dyGOAM2Iz/sOQyezL+ck+XwVsMDKLJTclxB8Di0iwgizz5hdgrdWinoXAqrZL
 ALpjvSq/0muUdiDodPiMwNsjLEP915LP0OVSh2i2/aHqvR0RqAHgoFPXTPBafVaw3pFQ
 P3+o081G6lz5HnD7KVCcl0SXBQvrd+p8qbK6qfqnJR8wFBorJe4q9lAc5+fttjPWCmNR
 ytDO6t3ucpObndnzV5dr+0wMAbHnyiD4n+LIrqiZZTwxjbeZByOxR8d099maydbUVxuM
 Ur1FelQI9sEWBnMmOZiHqOD2XysdgcuGTYs3vof5MjYCVcxaeDWrLuYRVvhxPgKAEFh8
 SjRg==
X-Gm-Message-State: AOJu0Yx+Iq8+GAJ6ErQzekPYNUsTspir51qOvSEYv2M6t2UVIoBEm2Mk
 60hG7NZem57R82MvVHkR7mBQLxDr0WtA+L9o5Vojp40v0VWgk0wlQyY2O1kpww4=
X-Google-Smtp-Source: AGHT+IHiFO1sn1cg/E4vOxC0pIy4KBYJ4L+vn/l8w3BGjEHL4uftEjeZJFH4/I645ZNl3OVjmzm3eg==
X-Received: by 2002:a05:6808:1524:b0:3c6:943:d47c with SMTP id
 u36-20020a056808152400b003c60943d47cmr6883252oiw.40.1712849768017; 
 Thu, 11 Apr 2024 08:36:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 d24-20020ac85358000000b004364d940d3dsm1026014qto.96.2024.04.11.08.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 08:36:07 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:36:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 00/19] x86: expo: Add support for editing coreboot
 CMOS RAM settings
Message-ID: <20240411153604.GA280191@bill-the-cat>
References: <20240104151152.697855-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FCkw4ZusAiNtNJ6k"
Content-Disposition: inline
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
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


--FCkw4ZusAiNtNJ6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 08:11:33AM -0700, Simon Glass wrote:

> U-Boot provides support for editing settings with an 'expo', as well as
> reading and writing settings to CMOS RAM.
>=20
> This series integrates expo functionality with coreboot, using the
> sysinfo table to get a list of settings, creating an expo with them and
> allowing them to be edited.
>=20
> A new CI test provides coverage for some coreboot-related commands. For
> this to work, a number of minor tweaks are made to existing tests, so
> that they pass on coreboot (x86) or at least are skipped when they
> cannot pass. Likely most of these fixes will apply to other boards too.
>=20
> It includes several other fixes and improvements:
> - new -m flag for 'bootflow scan' so it can display a menu automatically
> - Fix for video-scrolling crash with Truetype
> - menu items can now have individual integer values
> - menu items are lined up according to the width of all menu labels

This needs to be rebased on top of master where I suspect the biggest
problem is that we need to reconfigure coreboot that we build now? All
of the new tests fail:
https://source.denx.de/u-boot/u-boot/-/jobs/814728
and we're just building a standard defconfig for coreboot now.

--=20
Tom

--FCkw4ZusAiNtNJ6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYYA14ACgkQFHw5/5Y0
tyzNNwv+KhPNLADO6vFo7uvr7DnbT4WvisLRDAz7p9Zb0HqppZlrdjkcs4/PYEIy
fw0LiFJmDmhS1vDTXntTYdiiAvS4rBPKdvFjd/9howByqSeV/xAsZn7BDhYlRgW+
YaSHsacA18A3OZCMOgOEnLt4B6O3aevc+SLDC8IwDWFnuSJY20hjUqwx62+RNzF6
hLcHZA9LC7+/P/gA8YUnNLwk43z3N/Li4jh+4VFUYcNEvHGD8LIGLnZBWtjVqRGP
3E0AcYmviNsywuV5NWiiio3q1YIK+u7mIb1WrGrbbeRmRRqgfMkYVK9W0VHJeNIz
HvZL+GgJ1CbpBUhitjm96eyW3ur46pUjSJtQbFTnoZ6YYN5jVBmhtX6teEBEJEAj
WXRuTzTl1GWV+WuvDNJ4D3HbMoBpijv1RwldvOkPz6c1YMad2UhhYPbs2DiTEPJS
10zI0UpNhmCUuiKa+73wYkqx3rb5gP7wHLUrjfg8GrAYwJ2W71sijWpIFW+mr/01
NnOfME5H
=j2Fi
-----END PGP SIGNATURE-----

--FCkw4ZusAiNtNJ6k--
