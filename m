Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378A3C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 18:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6375D87E99;
	Fri,  9 Feb 2024 19:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jEGErPOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ECBA87E99; Fri,  9 Feb 2024 19:34:05 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E116B87E7E
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 19:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-290c5c705d5so240396a91.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707503641; x=1708108441; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/g56Osi8dXsvVS8DzkHie9bL5IA5xlk5FZdIuMZdXo=;
 b=jEGErPObNWYfw4xevkA1qCEKg2g7YcvW7wuKpbIgD1BLfoZfGz7rPab6Y9UNHBS4NF
 wZaQ2zW5fl4P5vwxmOhbxdZktsVHETpiBxj7TshQFNSWdQ4LQGCXfCIt4InjoDM6vLl/
 KwuZTonpfhZny3eYlcxB5MOwccdRLLJls0qsfYCa+IO5tZ1HiS/NDE2mDVApFEiSb8OP
 BwFOHZFEd/FzJsOo58wO5M5Lvpo80cdJe2gkijCEJ7ETQ6ENEJcHit99Yohn4LnN+Qvs
 PQQ0tYUtWLGeFpSERMgxOsp4oblbcpCSq+DW3cCPN9ggwyM4ploTdV7xaOgIY/ekuh9b
 PN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707503641; x=1708108441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/g56Osi8dXsvVS8DzkHie9bL5IA5xlk5FZdIuMZdXo=;
 b=TEF+R5WT91Ofioj5OxEyChA6RIglUlFkFmhnjJX56uODJrGX8UoM3Smz9Di19RO+dY
 k7deic86KQUr9dkuaswygPf4nUH+yQv33sORC/jzvmYjZNWk2nTAl18h+woB0zbt6/Qr
 QjFUuLrTzHMhgfEoIFw0CQiL9fdW5JWXzB3C955IKEOpK4xOAYTFSlB4XBRB4bh7Kdym
 +M+hzC3cvvus8rx/r/e+9CvVrT3ex++0oEP7CvM7FcyNTeKMxFQNfDxbL7E9Fq9VrXmF
 dm6AGvUpZ2vR4vpc35f83ooJEth2iSlmNtrz1Y+1QeQ4jyRM+IjGxdrUTMse28MdnDKv
 4tKw==
X-Gm-Message-State: AOJu0Yzi1XNeMqW1hpxOP6INcn/pe9ebOenlpOxvIzuM/9+HVGUhMOqf
 gjTCnWUuT7Nbx9LFkdiJWJ7o+GW7jn/t7t1YODx2c1nUZPyqQeamP3t4DM3+sxqNpJlyFj811Di
 Wqa8aVH3C2MM/vdp1JwFxASUn/j0=
X-Google-Smtp-Source: AGHT+IGGHP5y/3/thVPgxjb8rh/f1aHLAZ49AKK8shbE6opx80UKoRUQe5tf4S6vZIUl5QxthPXmEB5n9DpCxZPXU7Y=
X-Received: by 2002:a17:90a:7409:b0:296:9c2a:e7da with SMTP id
 a9-20020a17090a740900b002969c2ae7damr2179210pjg.2.1707503641150; Fri, 09 Feb
 2024 10:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
 <CAOMZO5CHMYZ5LFz9xCukrZ_BeF-Knt=Pbe9Qs7wrOnr0-ZSP_A@mail.gmail.com>
 <CAJFTR8Q_D361vUu5vQ1zHjwG0A6V+9zKj_w5P-x9LFqVch+QsQ@mail.gmail.com>
In-Reply-To: <CAJFTR8Q_D361vUu5vQ1zHjwG0A6V+9zKj_w5P-x9LFqVch+QsQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Feb 2024 15:33:49 -0300
Message-ID: <CAOMZO5AiEictCbFJ6GXx=sCBgnSFO6=t2qz7D0pHc8y-fNOAzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse T <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 9, 2024 at 3:27=E2=80=AFPM Jesse T <mr.bossman075@gmail.com> wr=
ote:

> These errors also happen on master.

There are no errors in master, otherwise they would not pass the CI build.

> I will submit a patch to fix these soon.

Just to clarify: on master we do get the following warnings (not errors):

arch/arm/dts/imxrt1170-evk.dtb: Warning (reg_format):
/memory/ocram@20240000:reg: property has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/dts/imxrt1170-evk.dtb: Warning (reg_format):
/memory/sdram@80000000:reg: property has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/dts/imxrt1170-evk.dtb: Warning (avoid_default_addr_size):
/memory/ocram@20240000: Relying on default #address-cells value
arch/arm/dts/imxrt1170-evk.dtb: Warning (avoid_default_addr_size):
/memory/ocram@20240000: Relying on default #size-cells value
arch/arm/dts/imxrt1170-evk.dtb: Warning (avoid_default_addr_size):
/memory/sdram@80000000: Relying on default #address-cells value
arch/arm/dts/imxrt1170-evk.dtb: Warning (avoid_default_addr_size):
/memory/sdram@80000000: Relying on default #size-cells value
  SHIPPED dts/dt.dtb

The error I was referring to was:

make imxrt1020-evk_defconfig
make
1221+binman: Device tree 'u-boot.dtb' does not have a 'binman' node
1222+make[1]: *** [Makefile:1125: .binman_stamp] Error 1
1223+make: *** [Makefile:177: sub-make] Error 2

If you can fix both the warnings and the errors, that would be great.

Thanks
