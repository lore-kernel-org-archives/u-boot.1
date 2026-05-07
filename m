Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D14BCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 17:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72F084B5D;
	Thu,  7 May 2026 19:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bvlIHCD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6E884B65; Thu,  7 May 2026 17:32:21 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E079A84A44
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so136696366b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167938; cv=none;
 d=google.com; s=arc-20240605;
 b=cV03XpCpFSIVWwiU0xcPhUCPogdeowj/iLvtAJ/44PtEAZqs8/yIPkragnKbyAcE5R
 fad6yrPTcpaOeiWydf1+jx3+jYPt07icVzNq+K1tVY8xl0Lh+jGM7rCeBMQaPh/70h72
 Q/4lSaKX8vcfhk9z25oZCBwgxMkH8HSaVYTjY9p9OFHknc+SrTU+s5+NypqCcyCMIZ6i
 F7uJcMcsUSmiXFgA7SZAQsjnCLPx55lVtoJ49JhJ/MpNnpLAKQthVgBgLX3OmlK35VEx
 epyDKWjyqA1XseaaB0XM6+Sm26UotRU4WsLvun9D0YEk4vpGi/le/JeaBqfIBkXnTQl1
 jlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gg04fXFYhyEWNyRGVstKERhzNearXthzgxxXeBxg35Q=;
 fh=HPtz8JIY3cZNeFbppdzWgt62f9EBFmH9ZfXqIWzchS4=;
 b=clz6edwiGxKYlU0NgH9MgpBUB6rZ4EB51VCl5wPgrP3x9stXCBJIvCp2iqYw+5gTum
 4Wo6/xoNuT+f/8yhbMVHedUQD7cGZ3uCgH0dObH1vPVFhriOpro2yQPWOPILwvxc6sde
 9Lf2y/z+jEdYhqZBVIiCFdTHC+NRWI1RtJhEV9Qd4ESxrU5l/2VZtzMu2diX+beAqgZX
 vwTKnFypZAFWO7Vw5DOaCoWNrz75PGAhswqAVGo5vtLnlrJGHhKxK5mU7uk6/LGXo3gA
 4vTpshKvGOGO+oo3BY1aYvK6kfPnIfNV5xToJaK8LcwBT8FX+ZsGbGEYVfyxZYhy+X5s
 Ww1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167938; x=1778772738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gg04fXFYhyEWNyRGVstKERhzNearXthzgxxXeBxg35Q=;
 b=bvlIHCD8BXjh5BpIpEOzzcX9/Uf7eKbKk40z77qFlTy56j8NQ+Vxshaz67JsrZ50gY
 rGe6yYExQxb2zYZ68/AGRxgkdJl0mXUpExQFzrkrqu8Ek8zcwF5CxVY3hidT7GXkFSpb
 uMKWQ42FR5U2OEZzAM/axNDe0+qPwWNBY+22M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167938; x=1778772738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gg04fXFYhyEWNyRGVstKERhzNearXthzgxxXeBxg35Q=;
 b=EV5nGf5HZfj6aWjy/byq3rU2f7hxw9Rc5j3oq1JU3m+JUiF3WlHEWWXks3eGd/irvN
 RLsgDP4jqRTyiMelv37xfX0oG2cSW2lJi776pLZU6MJwQO3fse4lq1Gy7o3XoFm2cHMZ
 new5O2r3VgBE8SPed86AcQDvC8HFX/l//ohdysJkGND/Cmo2uy5VGnIUUnaJ0GQrp4JL
 86QhEhwq9J6g2VTtPfSuzdLkEosPQpVERLBV0plFWoqLAj5dAvfXUYP31O+2DGIs+UiJ
 GNwQWDS4PLTooIQ3qsasnKh2yW0Bx+WSaexpBmBliuDst7Jn/u0/naHt11tyEooOVc98
 ITjA==
X-Gm-Message-State: AOJu0YybyOTNfvaFufYPAdfBz+rbFAz/CPigbEkKWLqvxmlxDY0gne1N
 D8rAQd5JeB/bE3kfUrzDmUwxiXeRtee3ohZZoUpKvopvOehI+O4uoR2LZc3EfXC3PrwRU1YFAFI
 uKXjKM9E//mNbve8XQK1leCwR0gFLvbGD6xrb0ISk
X-Gm-Gg: AeBDievEVkSHJOOH3B1fYKlooFtmBUeZjy1Sg5D2G/34v7Q5Vu48SJSsTZ5r46h6OVu
 +kLZCWRHTUxbwIPxJFYRbxTzQx8BbipcNBFMgTqWfF8zk8Fco3PhIdn9BPLK/pm6g6Tj6brmcIa
 pZyPImJ1J/RTpoz6IJUN+cu+ESrweJSiKLFl24hpUabShnEOsHx3DWb3J2oD21HzzlwwJFFupW2
 TkznsA1zpu8mMCaAr2DE5idu6n1zV7gzmlsRLPwpPE1jvW2jH8J1ao55o8V5cn5Q8Xnozn/abOT
 /b1UjlV2WuG0KsLE
X-Received: by 2002:a17:907:3f24:b0:bc6:2bd3:8176 with SMTP id
 a640c23a62f3a-bc62bd388e2mr397140666b.35.1778167935598; Thu, 07 May 2026
 08:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-7-11817415d664@seznam.cz>
 <CAFLszTjUniOCbnGdR9_d8HmQrt8SFV_u8dDonPvOEyCeOUZCTA@mail.gmail.com>
 <51026c36-deae-4f80-9247-fab9c6fff518@seznam.cz>
In-Reply-To: <51026c36-deae-4f80-9247-fab9c6fff518@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:32:03 -0600
X-Gm-Features: AVHnY4KekvyXk-2P6YOtjqCs2lTIzkkdhEFZNIei3hCDtSvf7Ax4H5aAbBebMGA
Message-ID: <CAFLszTj94JHUJg6Bj915YRPzEYJW+kby=XBGV1rA=RYUrMvU8g@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 07 May 2026 19:10:36 +0200
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

Hi Michael,

On Tue, 5 May 2026 at 11:21, Michael Srba <Michael.Srba@seznam.cz> wrote:
>
> Hi,
>
> On 5/5/26 16:02, Simon Glass wrote:
> > Hi Michael,
> >
> > On 2026-05-05T00:47:48, Michael Srba <michael.srba@seznam.cz> wrote:
> >> mach-snapdragon: Kconfig: changes / additions to support SPL
> >>
> >> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
> >> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
> >>
> >> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> >>
> >> arch/arm/Kconfig                 | 34 +++++++++++++++++++++++++++++++++-
> >>   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
> >>   2 files changed, 43 insertions(+), 1 deletion(-)
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> @@ -1149,9 +1150,40 @@ config ARCH_SNAPDRAGON
> >>        select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> >>        select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> >>        select SYSRESET
> >> -     select SYSRESET_PSCI
> >> +     select SYSRESET_PSCI if !SPL
> >>        select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> >>        select MMU_PGPROT
> >> +     select SUPPORT_SPL
> >> +
> >> +     select OF_LIVE if USB_DWC3_GENERIC
> >> +     select SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
> >> +     select ARMV8_SPL_EXCEPTION_VECTORS if SPL
> > The commit message only mentions SUPPORT_SPL and SYSRESET_PSCI, but
> > this hunk adds ~30 selects plus default overrides in
> > mach-snapdragon/Kconfig. Please expand the message to cover the rest -
> > in particular the OF_LIVE/SPL_OF_LIVE and DM_EVENT/SPL_EVENT
> > selections gated on (SPL_)USB_DWC3_GENERIC are not obvious; readers
> > will want to know what breaks without them.
> >
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> @@ -1135,6 +1135,7 @@ config ARCH_SNAPDRAGON
> >>        bool "Qualcomm Snapdragon SoCs"
> >>        select ARM64
> >>        select DM
> >> +     select DM_EVENT if USB_DWC3_GENERIC
> > Just to check - does u-boot proper genuinely need DM_EVENT/OF_LIVE
> > pulled in by USB_DWC3_GENERIC, or is this only required for SPL? DWC3
> > has worked on Snapdragon without these so far. If it's only an SPL
> > requirement, the proper-side selects should drop.
> The dt fixup for usb needs it, it registers a callback on an event and
> proceeds to patch the dt. I'm not sure if it's needed on absolutely every
> SoC, but the code does get compiled on every SoC so it might as well work.
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> @@ -1149,9 +1150,40 @@ config ARCH_SNAPDRAGON
> >> +     select SPL_OF_REAL if SPL
> >> +     select SPL_OF_CONTROL if SPL
> > SPL_OF_REAL is already selected by SPL_OF_CONTROL (when
> > SPL_OF_PLATDATA is not set) in dts/Kconfig, so this line is redundant.
> > Also swap the order so SPL_OF_CONTROL comes first, since that's the
> > option doing the work.

> uhm, so do you prefer removing SPL_OF_REAL or swapping the lines around?
> "this is redundant" and "it should be swapped" are mixed signals...

Right...you should be able to remove it, but if not (something I am
missing?) then please swap the order.

> > Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
