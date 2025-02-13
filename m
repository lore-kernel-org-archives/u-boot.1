Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1BAC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 23:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB7180F7C;
	Fri, 14 Feb 2025 00:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MPgtoRd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1DC80C77; Fri, 14 Feb 2025 00:42:20 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B34980ECB
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 00:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6efe4e3d698so13587997b3.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739490137; x=1740094937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2iYA0ulnAcXo5VR+eMwgV9ocPG/i3j9dma6I9HZ3l/A=;
 b=MPgtoRd2ARCfEwewDFQgp6KKVO2rLjpdQkV2+2ufPzleN7ArU2EPwicmIYnRU5P0g4
 cCRJfxatKJI9i+OA76S2Cn2M30qSAwbkpC4Gsf3wYjLQGRKYWHm+0cwHbNPqJtilnMD9
 EBLRC86ODr5h7ff4arEs6bX0RvQOZiEqrk4+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739490137; x=1740094937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iYA0ulnAcXo5VR+eMwgV9ocPG/i3j9dma6I9HZ3l/A=;
 b=W5HDdligDMpUENcMtZID7ikMKoinwJf0fiTzc6gWKzcD5Z0botbsmmXFVc9AIzQsu/
 i+T6PIDcP8Mj3agw0E3aS937HVGIUB8o+/uS1coywspH/cyHqfI4un8tJcSLAMc6KZln
 YC3ZMuwmQC0KmJXaIagK4XV2R9MOaoT74jRDbGBeHq00q5cY4+4z6Iogb64XxAXoBIST
 rltNNrofNXL33Dxy68VkgyV7juFhO7BETXIrwawyuxKh3lUEo3kJttVpuVRLaTZr3s4k
 SJIDjzDy300DAONQvE5+V5TJ0VTRcwv/br4yaJ+tI0aUpnpzp7d+DmVwECug9vSmEX1T
 MzdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeCAgqnb4KHiwK1kEhT4bzHZSGqxfbLB53l0DUTBAo9PSLCiqSN9eFsgGYVu1s+UvHlTCP7hg=@lists.denx.de
X-Gm-Message-State: AOJu0YwNRUEXQ9zo4pLimjTnJ0clOEbBY7DJ/kcSCEa8kXibd1X7z4VG
 sXUByHKajrkATKTHbXN0TQUbryccjOFJhwYrvGbO2t+4wgy0rHqny+powVbqigjkB4AuCPpJbPa
 9
X-Gm-Gg: ASbGncstVeFCXPogy9VQ9Dg+Xw/4qGvvm2x5Wir0J3Yf3sREhWXGX2e/g8y/7c9K3QC
 UdG/h4pZrWIzSltdhxu1CK9RFVE8rGci+wSgu4Y+BhgzYpRc3B9sfdQAWRREgJ2D8YwgZ8AI85j
 SUW7of33y4ot/xvES/XOg7WssJpqb2SieTRuAqIHO9Z0OzG+GLRSuVsReqFsWcUoipUzSgoPNsI
 n74Z4uAH1UgQ38potJPgfGycUV7HoZefawRWv2eBl3ESmLn/iThTJCTcGB4y9k6jW17gbYSVv1D
 QK//FHdrJmMqpxY=
X-Google-Smtp-Source: AGHT+IG8L7LR4lEPtnpmxsbchH8QMHE3l6wHDQkjB3j4rzyOKsU2ZZzG5EE/J+tzIMH9iUB1HTkPng==
X-Received: by 2002:a05:690c:a86:b0:6ef:8122:282f with SMTP id
 00721157ae682-6fb1f286688mr88501967b3.24.1739490136710; 
 Thu, 13 Feb 2025 15:42:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb361bbc6asm5287497b3.98.2025.02.13.15.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 15:42:15 -0800 (PST)
Date: Thu, 13 Feb 2025 17:42:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 marek.vasut+renesas@mailbox.org
Subject: Re: Generic U-Boot (was: Re: xPL Proposal)
Message-ID: <20250213234212.GD1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <b5d2bd37-4424-4660-b5c3-d505e5485ced@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JxRJRcbG1UHiUnt8"
Content-Disposition: inline
In-Reply-To: <b5d2bd37-4424-4660-b5c3-d505e5485ced@linaro.org>
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


--JxRJRcbG1UHiUnt8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 03:03:29PM +0000, Caleb Connolly wrote:
> Hi all,
>=20
> On 2/12/25 17:41, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > >=20
> > > > The way I see it, both schemes remove the ambiguity. Mine retains a
> > > > single deconfig file and a single 'make menuconfig' for each board.
> > > > Yours feels more like building independent U-Boot images.
> > >=20
> > > It is explicitly building independent U-Boot images, yes. With a wrap=
per
> > > around "make all of the images for a given platform". So much of our
> > > confusing and messy code is because we aren't doing that. And since m=
ost
> > > modern SoCs can work as (mostly )generic SPL selects correct DTB for =
PPL
> > > we really could have fewer overall build configurations.
>=20
> Big +1 for this. Most Qualcomm platforms in the wild today that would
> benefit from chainloading U-Boot will NEVER be able to run any stage exce=
pt
> PPL due to codesigning. For these I would ideally never like to even think
> about non-PPL stages since they only added confusion.
>=20
> At the same time, it would be great to eventually have U-Boot SPL for
> Qualcomm platforms that can replace Qualcomm's proprietary sbl1, and maybe
> event some even smaller/earlier secure TPL(?) stage that replaces their
> xbl_sec.
>=20
> I would very much prefer that these be distinct, since they vary in how
> board specific they need to be (see below).
>=20
> Folks who are just contributing support for their device/soc (a few quirks
> or simple driver ports from Linux in most cases) are going to have the be=
st
> experience when the learning curve from Linux to U-Boot is minimal. Mixing
> up various boot stages into a single defconfig and having custom kbuild
> infrastructure is the opposite of that, and seems unnecessary.
>=20
> >=20
> > I'd really like to see a generic aarch64 U-Boot for PPL, although it
> > would be quite large with all the drivers. Perhaps we could start by
> > having a generic Rockchip one, for example.
>=20
> We already have this for Qualcomm. Some small QoL things still need to go
> upstream but you can build a single U-Boot binary and boot it on a bunch =
of
> differences devices just by using the right DTB. See this build script for
> example which builds for just a few devices:
>=20
> https://gitlab.com/sdm845-mainline/validation/-/blob/main/build_uboot.sh
>=20
> I think a bunch of things in mach-snapdragon could be moved to a generic
> mach-aarch64 that could also target other SoCs like Rockchip or Mediatek.
> I'd be super interested in helping to make this happen.
>=20
> Probably would even want to put more things into common code so other
> architectures can adopt it (and make themselves smaller), then mach-aarch=
64
> can just be a stub for devices that are fully generic.

I'm not sure how this works, exactly. Setting aside "U-Boot as EFI
application" (which could use EFI API calls for device specific
implementation of things like reading storage devices), there's still
the case of someone somewhere needs to do the device details. What I
had in mind is later in the email.

> The other potential concern with a generic aarch64 target is that we then
> lose track of what devices are actually supported. It would be nice to ha=
ve
> something like a list of DTBs either in U-Boot or in some associated
> infrastructure we use to build reference images.
>=20
> Which all ties back to the goal of providing distro-agnostic U-Boot images
> to make Qualcomm (and other?) Android phones capable of running more Linux
> distros.
>=20
> Sorry for the big thought-dump, this has been on my mind for a while and
> since it seems like something you're both also interested in I just wanted
> to offer my perspective as a device and distro maintainer as well.

It's good to have more thoughts about all of this, especially from
someone that worries about that from more than just the bootloader
itself use case. Implementation wise, we could in theory start with
something like:
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index da6f11749343..111e3c4b6059 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -600,6 +600,10 @@ choice
 	prompt "Target select"
 	default TARGET_HIKEY
=20
+config ARCH_MULTI_V8
+	bool "Multiple Aarch64 SoC support"
+	select ARCH_SNAPDRAGON
+
 config ARCH_AT91
 	bool "Atmel AT91"
 	select GPIO_EXTRA_HEADER
@@ -1099,27 +1103,6 @@ config ARCH_RENESAS
 	imply SYS_THUMB_BUILD
 	imply ARCH_MISC_INIT if DISPLAY_CPUINFO
=20
-config ARCH_SNAPDRAGON
-	bool "Qualcomm Snapdragon SoCs"
-	select ARM64
-	select DM
-	select DM_GPIO
-	select DM_SERIAL
-	select DM_RESET
-	select POWER_DOMAIN
-	select GPIO_EXTRA_HEADER
-	select MSM_SMEM
-	select OF_CONTROL
-	select OF_SEPARATE
-	select SMEM
-	select SPMI
-	select BOARD_LATE_INIT
-	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
-	imply OF_UPSTREAM
-	imply CMD_DM
-
 config ARCH_SOCFPGA
 	bool "Altera SOCFPGA family"
 	select ARCH_EARLY_INIT_R
@@ -1977,19 +1960,6 @@ config ARCH_UNIPHIER
 	  Support for UniPhier SoC family developed by Socionext Inc.
 	  (formerly, System LSI Business Division of Panasonic Corporation)
=20
-config ARCH_SYNQUACER
-	bool "Socionext SynQuacer SoCs"
-	select ARM64
-	select DM
-	select GIC_V3
-	select PSCI_RESET
-	select SYSRESET
-	select SYSRESET_PSCI
-	select OF_CONTROL
-	help
-	  Support for SynQuacer SoC family developed by Socionext Inc.
-	  This SoC is used on 96boards EE DeveloperBox.
-
 config ARCH_STM32
 	bool "Support STMicroelectronics STM32 MCU with cortex M"
 	select CPU_V7M
@@ -2169,6 +2139,45 @@ config ARCH_GXP
=20
 endchoice
=20
+menu "Aarch64 Multiple Platform SoC options"
+	depends on ARCH_MULTI_V8
+
+config ARCH_SNAPDRAGON
+	bool "Qualcomm Snapdragon SoCs"
+	select ARM64
+	select DM
+	select DM_GPIO
+	select DM_SERIAL
+	select DM_RESET
+	select POWER_DOMAIN
+	select GPIO_EXTRA_HEADER
+	select MSM_SMEM
+	select OF_CONTROL
+	select OF_SEPARATE
+	select SMEM
+	select SPMI
+	select BOARD_LATE_INIT
+	select OF_BOARD
+	select SAVE_PREV_BL_FDT_ADDR
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	imply OF_UPSTREAM
+	imply CMD_DM
+
+config ARCH_SYNQUACER
+	bool "Socionext SynQuacer SoCs"
+	select ARM64
+	select DM
+	select GIC_V3
+	select PSCI_RESET
+	select SYSRESET
+	select SYSRESET_PSCI
+	select OF_CONTROL
+	help
+	  Support for SynQuacer SoC family developed by Socionext Inc.
+	  This SoC is used on 96boards EE DeveloperBox.
+
+endmenu
+
 config SUPPORT_PASSING_ATAGS
 	bool "Support pre-devicetree ATAG-based booting"
 	depends on !ARM64


Which for qcom_defconfig (and now ARCH_MULTI_V8=3Dy) and ARCH_SYNQUACER=3Dy
only fails to build because our cpu reset drivers aren't quite namespace
clean enough. But that's an easy fix. However, I picked ARCH_SYNQUACER
because it's one of the platforms that doesn't have a lot of additional
code (there is no arch directory) for conflicts to arise in, and there's
no "now, SPL?" to worry about too.

But the above is where I'd start implementing, along with documenting
the run time entry requirements and some other important details. We
likely need to do some splitting up symbols so that a platform can
opt-out of ARCH_MULTI_V8, which might be required for "do care about
SPL", at least for some period of time.

--=20
Tom

--JxRJRcbG1UHiUnt8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeug1EACgkQFHw5/5Y0
tyztogwAudmkFnT+A88p4v4ru/AXfFvEc1eoQQZGGJsI3kc7nyWYUbRuoIxzPhZj
Q1daPTXN9eJkumkDwu3TnNeo90o3K8Hd44ntLn/Kbz8hdMXsF/zmvSUVRFQco2HJ
DHwCSnjUryvRjGKJVs8GQqADP0uj3faOK0TEeMEogM+dE7+IZ32fXbyAo1lxKvMl
b+phAvDK5Wtl6KjtLSUnCtr8LBAEtkDxu1WjAZcRf4TgfoZvwX0YeInP2BOy2qdM
XY3gdAv5fDFNaFZTf45PkUyBeiE0D5tRf4k1K8LpRQ6yJxDcoihJxFwdNuS6Q1Qj
kN7m6387FbfoYVltPa4mOaab2XBf3ywovy1ycjhd1t/YCepop3pWfizLnAKNkLk5
vsYaBjoY6O/eoaacbuAMKtf/Ee+UnEh2ZF+MZ25n8uUuKaT2X6mClmty4NL457XR
Dggmvsw4icP00UazJq0Q0L0v1c6NOHBZMQaeI5jrsig0GcYgRw8H89dj/ZCBbqih
71dbnZpR
=uO15
-----END PGP SIGNATURE-----

--JxRJRcbG1UHiUnt8--
