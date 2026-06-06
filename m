Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D598CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD84984911;
	Sat,  6 Jun 2026 14:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RLCMZElx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE9E68466E; Sat,  6 Jun 2026 14:03:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF2D8063E
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 14:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso22782325e9.0
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780747419; x=1781352219; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xn0WdN35XCw48fwgpUBFX7a0XpnbfNRb7aDYz9DVLvA=;
 b=RLCMZElx2icyCD5aHWeqpfZ0hvuCLKaD1GQNbLKnNVOs7A1HYzP2kjk/uFsgyQxK/l
 aI9zy3u+byo7l/6FNRdXyikMIuORHrI4rg8C3VgFCB1GtI7gB7HaFaClYhZWOLsS9IXd
 WJE4kNB6XEaXL+xsoVTgUFuCcrjdVtGmpKOz1xzGkJocSK2Cs+z6jsQagATa2iSZpPT2
 grNP4M2RWN/73I1XV+0m7/pY2G3Gu9/g4xDGSh/gYqzp5nvZ6FbZ/6wBo3JKlmSB0jF2
 P/nGL0CcNHuIPo3iTfT3aD7qQ1eIPmPjLUNJNwz+H9cZRFHe8PjtHKqeVsA4Nw25kJZx
 ERKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780747419; x=1781352219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xn0WdN35XCw48fwgpUBFX7a0XpnbfNRb7aDYz9DVLvA=;
 b=q5FZgFUMs5QtY1Hjnk6U3jH25HhQYiJydAdCFU+S3LVJ4wwp3wfK+T3JfF7ZIkE/ab
 OhcFafJCA3qOUeKwJYa75PEUrkGc6bYrth/Av6sY9d2GmmhbmfTL9N60da7AYj2kicsh
 UL6yRWaHCLMiopKLkKGrLYOxMT32jYaUl4fsUG+yYqQcAhrPkyzWCwUP/jnvs0gnfTiY
 KD3VHDmv80H8PePCENNgUnG8ayY224FhQrkVpfT9x2OWSwqn18sBfXQfz6imemG0I21D
 i8kF1mc73fjHSBeWYwoFBCoNi64zgUyJRSAILoXQLg5yVW97mG97odSuTUF/L2QsF3oi
 NYvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IAIbQLwCy0ojFUp94EYvS3QGGGAKqTBg/iW+QyPZpB1p+WVpHsxLBzHXWvykHZ9V1u3X2eFQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3rX9GMA4OKlwuPkCzJDr5hF60HO3s8Z7CHUqD67v37B7pqTYt
 yZN9o8YdtdlZAr025P9sIvPvUj+PDjpA8vgmMosOi7mTU5GbAQMdokAQnrpLSk2DcrA=
X-Gm-Gg: Acq92OHtDejqtmbF4sH9H8wDDlECDeD4XiGXBKjUiwASd/iB/XeuWH60/UyeKTa8ehh
 676z5iypvToTCESUz4oMX71LLG0xpXXsdticXF7gEdznwZEhlhvu7gk3IPEjQoOtNmppMePSCZ+
 o3Q1YIa/HnyBPQnuCfTlecYsQoOO8Fh7xismCDsvQAs08gD0sBKRuSsdE9tQoHyDN0OLYHDvpF3
 gTcBO4/vvzgS9oX+L9K6HX6/gKyaROBwGcur/X0psY3pCeuIhbOStZc6hVe0HJ+IEKli7601kxP
 ycPEeDjB+1Bp1to401qaJBqNFlyzLIII28bVW7A3ykON6yoeGHvsGonySg/x8eLXxf5XHolEM39
 C7hl5RqGNuCV92kPL1lVRe0yr0B0TgFBTQ5RzWFk04ad9OnC37RrGawW81HLrKvHAfxVkGbMkk+
 JMT+IhwvFX9EYdww0nJ1upHLUrdOsGodE0u76ASsDJBpUADJA4RZkGD877kf+lCFNiOiBDk/3Nz
 EOo1OpyJA==
X-Received: by 2002:a05:600c:8b68:b0:490:bad7:3634 with SMTP id
 5b1f17b1804b1-490c25e1104mr130694605e9.19.1780747418965; 
 Sat, 06 Jun 2026 05:03:38 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:fc76:d61e:2fec:91ec?
 ([2a0e:c5c1:0:100:fc76:d61e:2fec:91ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c15cesm237968865e9.5.2026.06.06.05.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2026 05:03:38 -0700 (PDT)
Message-ID: <e21e557b-1573-472f-9666-2bffdb0f4e86@linaro.org>
Date: Sat, 6 Jun 2026 14:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Generate Android boot images with binman
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, Denis Mukhin
 <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:34 +0200
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

Hi Sam,

On 6/6/26 02:52, Sam Day via B4 Relay wrote:
> U-Boot is seeing increasing adoption on pocket computers, many of which
> (sadly) have fused bootloader chains. Many of these bootloaders have a
> very rigid definition of what a "valid" downstream payload looks like.
> Sometimes it's just a boring old v0/v2 Android boot image. Sometimes
> it's something decidedly more grotesque.
> 
> To date, this last-mile packaging step has been trapped in downstream CI
> pipelines, blogposts, documentation, etc. This patch series aims to
> gather up all that esoterica and institutional knowledge and codify it
> in U-Boot's build system, using binman.

Awesome!!! :D

So happy to see this being worked on, it's a huge benefit to have this 
here in the build system.

That said, I think we need a bit of discussion around binman, I 
previously worked on using it for teaching the build system to emit .mbn 
files (see [1]), in the end getting binman to co-operate was a bunch of 
really annoying work and I wound up with a sub-par result.

The new approach which made a whole lot more sense is to use a vendor 
Makefile fragment to add a custom build target, skip dealing with binman 
and just have the necessary info in Python (since adding a table entry 
to a Python script is really no different to adding a binman DTB node). 
That's in [2].

I'm really not in favour of adding a binman node to the DTB that U-Boot 
uses, and I think it's kinda dumb that this is the only sensible way to 
configure binman today...

The way that mkmbn works is it just has all the device-specific config 
in a dictionary where the key is the compatible string, it finds the DTB 
in the U-Boot image and gets the appropriate mbn config from there.

I see you've clearly put a lot of effort into this, and I hate to ask 
you to do a lot more, but I'd really like to avoid using binman, would 
you be willing to rework this to put the config in Python and just have 
a custom make target like in the mkmbn patches? You can probably base it 
on top.

This way it avoids the need to add stuff to the dtb, you can just parse 
`u-boot.dtb` to determine the device and pick the right config.

[1]: 
https://lore.kernel.org/u-boot/20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org/

[2]: 
https://lore.kernel.org/u-boot/20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org/

> 
> Put differently: an overwhelming majority of these pocket computer
> devices have a "canonical" payload format that U-Boot currently has no
> support for. Let's fix that.
> 
> The first patches in this series introduce an `android_boot` etype. To
> begin with, this is a "typical" abootimg, as defined by canonical AOSP
> sources and reference `fastboot`/`mkbootimg` implementation. There's
> plenty of devices out there with a sane(-ish, nothing in Android-land is
> ever truly sane) bootloader that will happily chain a U-Boot rolled into
> the kernel section of an abootimg.
> 
> With that out of the way, the cursed bootloaders are next to be
> supported. Binman etypes for Qualcomm's "QCDT" and Samsung's "DTBH"
> formats are implemented. These are non-standard vendor-specific
> devicetree containers, which the previous bootloader uses to pick a FDT
> to boot the downstream with.
> 
> In both cases, these vendor-specific formats are tacked on to the end of
> a v0 abootimg, with the header_version being hijacked to encode the
> length of this following payload. Thus, the android_boot etype is
> retrofitted to allow these shenanigans.
> 
> Binman configs that produce flashable boot artifacts are introduced for
> the following devices:
> 
>   * google-sargo (vanilla v2)
>   * oneplus-fajita (vanilla v2)
>   * samsung-a5u-eur (QCDT v0)
>   * samsung-gt510 (QCDT v0)
>   * samsung-j7xelte (DTBH v0)
> 
> I also successfully tested a vanilla v0 on my samsung-expressltexx, in
> conjunction with the qcom-armv7 series already on the list. However,
> since that work is still in-flight and the expressltexx DTS is
> downstream, I opted not to include it here.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
> Sam Day (13):
>        binman: Android boot image support
>        .gitignore: ignore binman-generated blobs
>        arch: arm: qcom: google-sargo binman config
>        qcom: arch: arm: qcom: sdm845-fajita binman configs
>        mach-snapdragon: enable BINMAN
>        binman: android_boot: vendor-dt support
>        binman: Add QCDT support
>        binman: android_boot: SEANDROIDENFORCE support
>        arch: arm: qcom: samsung-a5u-eur binman config
>        arch: arm: qcom: samsung-gt510 binman config
>        binman: Add DTBH support
>        arch: arm: exynos: add j7xelte binman config
>        configs: exynos-mobile: pull in BINMAN
> 
>   .gitignore                                         |   1 +
>   arch/arm/Kconfig                                   |   1 +
>   arch/arm/dts/exynos-mobile.dtsi                    |   5 +
>   arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi        |  24 ++
>   arch/arm/dts/msm8916-samsung-a5u-eur-u-boot.dtsi   |  39 ++
>   arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi     |  39 ++
>   arch/arm/dts/qcom.dtsi                             |   5 +
>   arch/arm/dts/sdm670-google-sargo-u-boot.dtsi       |  27 ++
>   arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi     |  25 ++
>   arch/arm/mach-exynos/Kconfig                       |   1 +
>   configs/exynos-mobile_defconfig                    |   1 +
>   configs/qcom_defconfig                             |   1 +
>   tools/binman/etype/android_boot.py                 | 408 +++++++++++++++++++++
>   tools/binman/etype/dtbh.py                         | 173 +++++++++
>   tools/binman/etype/qcdt.py                         | 160 ++++++++
>   tools/binman/ftest.py                              | 127 +++++++
>   .../test/vendor/android_boot_seandroidenforce.dts  |  22 ++
>   tools/binman/test/vendor/android_boot_v0.dts       |  29 ++
>   tools/binman/test/vendor/android_boot_v2.dts       |  46 +++
>   .../binman/test/vendor/android_boot_vendor_dt.dts  |  27 ++
>   tools/binman/test/vendor/dtbh.dts                  |  29 ++
>   tools/binman/test/vendor/dtbh_bad_model_info.dts   |  19 +
>   tools/binman/test/vendor/qcdt.dts                  |  20 +
>   tools/binman/test/vendor/qcdt_bad_msm_id.dts       |  17 +
>   24 files changed, 1246 insertions(+)
> ---
> base-commit: a4c8728f225b0d7d591fb9199ce7efb72f48290e
> change-id: 20260604-android-binman-ad7a43f4e99d
> 
> Best regards,

