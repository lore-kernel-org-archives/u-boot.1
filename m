Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB00C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0180182C2F;
	Tue, 24 Jun 2025 15:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HJBdrgX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE4882C4C; Tue, 24 Jun 2025 15:48:52 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4405282BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-610db3f3f90so196489eaf.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 06:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750772929; x=1751377729;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:resent-to:resent-message-id:resent-date:resent-from
 :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEkE+gnItmXhA1830d3qnwfVsMFplE/Gc2BeKNQHZ4g=;
 b=m24g80jrNXQ8JGWabcwWLyV9U/jDSvB83kcx279+4I9Zar75/4rXWF8ZxRTh3RKlKg
 dbzMu6F3tCgtY5hg/iExgHlyho/7yOAXOA+xVentZym2YhBHs7siXSA8z48gljNO6/qe
 CujCqL5UhoRmgZ82infN54C0WYRzG/gTn7YS1fs1OQwE1EQSKECitZDbGuP4QuXcrR2l
 7w38DZAJvhUvbKwPvChxfzoRwavI/kwwnpqT+rhrrbHJefYz5CxJURt4c6nVDjO3oWTX
 q9OL+6AVekwkxPZkkTglT2OIHu8imgz6o+xm8hjYCAImBp+J6Qm3o36vgQXD5ow8+S5G
 +6Hg==
X-Forwarded-Encrypted: i=2;
 AJvYcCXttFkY+N5fSbaa0m7wx+DAUcWj2lsBH369ONdgRsDJsskwrkrAyFegzDx1i9lb/ZpUw1orR7M=@lists.denx.de
X-Gm-Message-State: AOJu0YydQyYXXU1qSfnmVMG/QD6MVmIr+DpoL5PrmEumEl4z0+oQWAyF
 9IPk6QUfstHFXS7WnDhMbeTg8ZJAk1Gg0mBn3iikVZVB/AAGbfBbT89slBHBde7cxJ9ioNW289y
 BbChoev4=
X-Gm-Gg: ASbGncuqaUk7t6qq3lYPznYKFMu4dl2LM29DFH12XznliXw8l9rjSPuiy3gu+ouVnXh
 6H4zb+5LBYMd+y3wTObFAr4viMiKdtewZR2UQ1RcZ11Ltjj6x75GmPH07HIjo6+MNFusAenMVD8
 9LCr+Cx+GTRiozj0AW9lId7F4CGkt3bN4hZFWUKRDRPzYQkL/q9ZLH0iSGEFQh1SQieo6CorN+9
 tppOi3QqfRIrKTCZmr/DT8E84xKorrRMapeDoEA2HwfkRW94Hc45ISET1jBG3cjv9/i3P6CbqY3
 lqc2u7LJk5iMJwIeMwIo2nVPp8ROEpXzyoNunQunmkX5b8H9dpSV54gDezgQeWr9fu0halNb670
 BFFaTtOcG8LduDsRHqmjOqpM=
X-Google-Smtp-Source: AGHT+IHlYxGmhDsUDiRrBR3VPwti9D63orScD1oxEwUtFrtDfhMcEhUkGhBeFV7zLOmrVGqE+Fvy5w==
X-Received: by 2002:a05:6820:208:b0:60b:cd81:9079 with SMTP id
 006d021491bc7-6115bab4802mr11259957eaf.5.1750772928845; 
 Tue, 24 Jun 2025 06:48:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b52f0c6sm1352358eaf.0.2025.06.24.06.48.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 06:48:48 -0700 (PDT)
From: Casey Connolly <trini@konsulko.com>
X-Google-Original-From: Casey Connolly <casey.connolly@linaro.org>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Tue, 24 Jun 2025 07:48:46 -0600
Resent-Message-ID: <20250624134846.GI4003484@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:45a4:b0:a6:f736:36be with SMTP id cf36csp3178202dlb; 
 Tue, 24 Jun 2025 03:12:31 -0700 (PDT)
X-Received: by 2002:a5d:584e:0:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3a6d12d8c86mr12816264f8f.33.1750759951101; 
 Tue, 24 Jun 2025 03:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1750759951; cv=none;
 d=google.com; s=arc-20240605;
 b=JSNdWX7JAwf+0jF/ZsQWzPwH3v4kpGlmiZTk4EHdDA1AFR4tCUh4xT1zo0xgcw0hso
 +9bu/A0LMK757V+su2GViBS1TYst86zt7xgMmZUAjsVzyvgiIgKO13qsP8D7N808JBQd
 sCRm7RYratgRnLe+9gUojoPM0DErLSPLM277+4nWcdOlBDcgRcW9FdVVsmUWPabIXW51
 V2joxKn/SDWDHzNmAnJsVLiHOT8gOVd26RR9vTlz8z1gemjAf6o4fPFMKNavnP+WkYsB
 BqCCQHX9H5nxpsOmAH48+CqpuMsTzNEXIQHyNIhW97b1FcLracMVlDnM5Ol/qZNjHjCr
 3UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature;
 bh=SEkE+gnItmXhA1830d3qnwfVsMFplE/Gc2BeKNQHZ4g=;
 fh=3N7JxDTlQn05TErvEWIF3kYvc+Edf5Cy7I6XfM0GvTM=;
 b=Jkmz2TAPFoVV6Y1tEajatxYvtZf0kjx4ZiFc79LLBAaBSK6YdWpPsiyJZXEnz7El8u
 ZUPyAWYk5ec/Zk4xkjOX/6hb4CWZtaSKt+xGfac+FGG4EmskiFfSnwCdIitHenmRhwf9
 hx7WUxSruL6W0TICOHmwHrYIb/dR2NgF3slc+UIvADpmbEBJdaDr3KwhV/JUXf5SkTl9
 ghziDo1qDWjOJkhI4pY4Je6zqbfdl2J+0n1/wBicW8RekUEjZFw3upQsYjMqhs5ssSso
 JM55WEGi6LZnWgc3F9Z+lxjPsDUOOXLh6PPdWSuUKFMhbxh4U9fl9LJG+VTbyO+1YolD
 GJ3A==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
 dkim=pass header.i=@linaro.org header.s=google header.b=HJBdrgX7;
 spf=pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) smtp.mailfrom=casey.connolly@linaro.org; 
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org;
 dara=pass header.i=@konsulko.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com.
 [209.85.220.41]) by mx.google.com with SMTPS id
 ffacd0b85a97d-3a6d135204csor2496806f8f.0.2025.06.24.03.12.30
 for <trini@konsulko.com> (Google Transport Security);
 Tue, 24 Jun 2025 03:12:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) client-ip=209.85.220.41; 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750759950; x=1751364750; darn=konsulko.com;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEkE+gnItmXhA1830d3qnwfVsMFplE/Gc2BeKNQHZ4g=;
 b=HJBdrgX71VYmYiZve2oACIuSeTijCmX3lFh+Q0Pplk6O1ZDQy2xyJEl0c3pcI0xSWt
 HbEiJiLjkfc6+uXflqTsgWkUnJil+BmvLQmTkgccuztlEvZK+lSEjEIfAaQD0JTkjjsH
 7pYe3Kwv/t2JhNjGog1xPTo211VT0+yJ8RoHxE6tcTUglBvzvz0hz9cs0+zmOwd3rCQS
 oeBKKv61Z8MQbqRMIY+EmE1RQ6j9Mxg2WqovaCOaqpRipCtnfVMlChiotiyzuo6Gj1R3
 dC6ZBNZaDAYeAuyj9rFW8d3H7ZQ9uCrBU4r4i7cM0JAa035kzo6zmKu/VfbaPyVfkFGW
 WyCA==
X-Received: by 2002:a05:6000:2a87:b0:3a5:7904:b959 with SMTP id
 ffacd0b85a97d-3a6d12fa0a5mr8941155f8f.58.1750759950035; 
 Tue, 24 Jun 2025 03:12:30 -0700 (PDT)
Received: from [192.168.1.159] ([213.240.182.18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8050cc1sm1608016f8f.10.2025.06.24.03.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 03:12:29 -0700 (PDT)
Message-ID: <f45d2fed-eee2-42d9-a4d9-1adc49d8acaa@linaro.org>
Date: Tue, 24 Jun 2025 12:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Please pull qcom-next-23Jun-1
To: Tom Rini <trini@konsulko.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 George Chan <gchan9527@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20250623234640.126706-1-casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20250623234640.126706-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

Please could you drop ("78f177fcc2ed qcom_defconfig: Enable 
AUTOBOOT_KEYED support") from this PR when you apply it, it was picked 
by mistake. Sorry about that.

Kind regards,

On 6/24/25 01:45, Casey Connolly wrote:
> Hi Tom,
> 
> sorry this one took a while, still figuring out a good cadence for
> this...
> 
> This PR introduces 3 new platforms, two from the new Dragonwing IQx
> series (QCS615 and QCS8300) as well as the IPQ5424.
> 
> Additionally:
> 
> * Support for booting downstream Android boot images on some phones is added
> * Capsule update support is expanded to be more generic, determining which partition U-Boot was flashed to automatically and supporting many more boards.
> * Minor capsule update bugs are fixed
> * A watchdog driver is added and gets timeout support
> * Autoboot now requires pressing "space" specifically to stop booting as a workaround for some boards getting rogue key presses which would cause autoboot to fail
> * Documentation is added for the Dragonwing boards
> * The RB1/2 now use USB gadget mode rather than host
> * A bug is fixed where GPIO reads could return incorrect values
> 
> The following changes since commit dbf7fd557a73ded3141db3c2cf5c572989378825:
> 
>    Merge patch series "Consistent Kconfig environment options CONFIG_ENV_ prefix" (2025-06-20 12:57:47 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-23Jun-1
> 
> for you to fetch changes up to c4c08cc21448aa97328b4dac17fb54c4f657ce80:
> 
>    doc: board/qualcomm: remove signing references from dragonwing.rst (2025-06-23 18:50:41 +0200)
> 
> ----------------------------------------------------------------
> Aswin Murugan (7):
>        gpio: msm_gpio: return correct value for gpio read
>        dts: qcs615-ride-u-boot.dtsi: Add memory entry to bootup
>        phy: qcom: Enable QMP UFS PHY driver for QCS615
>        clk/qcom: qcs615: Add GCC clock driver for QCS615
>        qcom_defconfig: Enable QCS615 clock driver
>        configs: add qcom_qcs615_defconfig
>        board: qualcomm: Add MAINTAINERS entries for Dragonwing platforms
> 
> Balaji Selvanathan (7):
>        drivers: watchdog: qcom: Add timeout configuration support in watchdog
>        doc: board: qualcomm: document Dragonwing board building/flashing
>        dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
>        clk/qcom: qcs8300: Add GCC clock driver for QCS8300
>        phy: qcom: Enable QMP UFS PHY driver for QCS8300
>        qcom_defconfig: Enable QCS8300 clock driver
>        configs: add qcom_qcs8300_defconfig
> 
> Casey Connolly (7):
>        watchdog: qcom: introduce qcom-wdt driver
>        board: qualcomm: add a MAINTAINERS file
>        mach-snapdragon: track boot source
>        mach-snapdragon: CapsuleUpdate: support all boot methods
>        dfu: scsi: don't call scsi_scan()
>        qcom_defconfig: enable capsule update support
>        doc: board/qualcomm: remove signing references from dragonwing.rst
> 
> George Chan (3):
>        boot/image-android: Workaround kernel/ramdisk invalid addr
>        mach-snapdragon: Enable workaround of ignoring androidboot addr
>        mach-snapdragon: Enhance android image handling memory footprint
> 
> Luca Weiss (5):
>        doc: board/qualcomm: Fix commands for compilation missing CROSS_COMPILE
>        doc: board/qualcomm: Replace buildman build instructions
>        doc: board/qualcomm: Add example for boot image version 2
>        clk/qcom: sc7280: Fix variable name of msm_clk_data
>        clk/qcom: sm8250: Fix variable name of msm_clk_data
> 
> Sumit Garg (2):
>        mach-snapdragon: of_fixup: Drop USB dr_mode override for RB1/2
>        qcom_defconfig: Enable AUTOBOOT_KEYED support
> 
> Varadarajan Narayanan (5):
>        dts: ipq5424-rdp466-u-boot: add override dtsi
>        doc: board/qualcomm: Update RDP signing instructions
>        clk/qcom: add initial clock driver for ipq5424
>        pinctrl: qcom: Add ipq5424 pinctrl driver
>        configs: add qcom_ipq5424_mmc_defconfig
> 
>   arch/arm/Kconfig                          |   1 +
>   arch/arm/dts/ipq5424-rdp466-u-boot.dtsi   |  37 ++++
>   arch/arm/dts/qcs615-ride-u-boot.dtsi      |  14 ++
>   arch/arm/dts/qcs8300-ride-u-boot.dtsi     |  19 ++
>   arch/arm/mach-snapdragon/board.c          |  34 +++-
>   arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++-----
>   arch/arm/mach-snapdragon/of_fixup.c       |  13 --
>   arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
>   board/qualcomm/MAINTAINERS                |  24 +++
>   boot/Kconfig                              |  11 +
>   boot/image-android.c                      |   9 +-
>   configs/qcm6490_defconfig                 |   6 -
>   configs/qcom_defconfig                    |  10 +
>   configs/qcom_ipq5424_mmc_defconfig        |  83 ++++++++
>   configs/qcom_qcs615_defconfig             |  22 ++
>   configs/qcom_qcs8300_defconfig            |  21 ++
>   doc/board/qualcomm/board.rst              |  21 +-
>   doc/board/qualcomm/dragonwing.rst         |  49 +++++
>   doc/board/qualcomm/index.rst              |   1 +
>   doc/board/qualcomm/rdp.rst                |  15 +-
>   drivers/clk/qcom/Kconfig                  |  24 +++
>   drivers/clk/qcom/Makefile                 |   3 +
>   drivers/clk/qcom/clock-ipq5424.c          |  96 +++++++++
>   drivers/clk/qcom/clock-qcom.h             |   1 +
>   drivers/clk/qcom/clock-qcs615.c           | 163 +++++++++++++++
>   drivers/clk/qcom/clock-qcs8300.c          | 146 ++++++++++++++
>   drivers/clk/qcom/clock-sc7280.c           |   4 +-
>   drivers/clk/qcom/clock-sm8250.c           |   4 +-
>   drivers/dfu/dfu_scsi.c                    |   5 -
>   drivers/gpio/msm_gpio.c                   |   2 +-
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c       | 128 ++++++++++++
>   drivers/pinctrl/qcom/Kconfig              |   7 +
>   drivers/pinctrl/qcom/Makefile             |   1 +
>   drivers/pinctrl/qcom/pinctrl-ipq5424.c    | 322 ++++++++++++++++++++++++++++++
>   drivers/watchdog/Kconfig                  |   9 +
>   drivers/watchdog/Makefile                 |   1 +
>   drivers/watchdog/qcom-wdt.c               | 137 +++++++++++++
>   37 files changed, 1632 insertions(+), 99 deletions(-)
>   create mode 100644 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
>   create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
>   create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
>   create mode 100644 board/qualcomm/MAINTAINERS
>   create mode 100644 configs/qcom_ipq5424_mmc_defconfig
>   create mode 100644 configs/qcom_qcs615_defconfig
>   create mode 100644 configs/qcom_qcs8300_defconfig
>   create mode 100644 doc/board/qualcomm/dragonwing.rst
>   create mode 100644 drivers/clk/qcom/clock-ipq5424.c
>   create mode 100644 drivers/clk/qcom/clock-qcs615.c
>   create mode 100644 drivers/clk/qcom/clock-qcs8300.c
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5424.c
>   create mode 100644 drivers/watchdog/qcom-wdt.c

-- 
Casey (she/they)

