Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4FACA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 00:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C94D40BFA;
	Fri,  2 Oct 2026 00:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Ytf2c_eQ4kH; Fri,  2 Oct 2026 00:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B996640B68
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790901905;
	b=j1VdShHtd5vMOUP5/elmc73iaA5Zx6/rt47yeM+CtdcWK+xxK7KWRA16msgYPU7cfCbp
	 aHiwMGrzP+fjN7zWrl+xXp8PvlaXwz3o4/fNhV4yrRDdZjtOIW9466KdOin/m6pNgwv4z
	 jxVEustrk6N69QAmOYVrAkl2J23bT9nzsu/Wer5dTN9z7NWouHxqROqBoj34g5DOLdy4P
	 2l/l06yRorYV0F9R6nHv99H068tUW1XO2KKiRGtzTGh6+SxHdBJIRphSpBvvUv0xeyJki
	 54V01/YOQ99F3m8Gd3m9M1dNbUq/VxYrg5YwAb7r0ddCu360d9Q9coacRqfZhlbQWYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790901905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cV+Y07iu1RNkRK0aosNKsl6CSJGVFzeqWI7s0a9NE6Y=;
	b=DdVEoC5Ov7ckNEF2ZdcVC7U5I5Wc3BSjVMoAhYcfinus0GzWtva4x/MneYyJNmv16cHe
	 vuhSsBqsnVdCjPjfaz4+2O7QPPmQ9/R/5e0WDZGhEqGpHREmcows1IEMxg06vzab7beFZ
	 PtM3FJ8McuEs8HGcEGWvJ2L+Jde8IFS07w63M3luqWdizBNhIvGb1mGcdDrmkzWb5y7WG
	 CxgVH5Ghvqvs9yeZupa8AtSCb8GVwtFttBSU0Mt5VlnY7S9uCbyGH7kkpCkM/P78eLF30
	 IjzNAGvMnnFrhHQdSmKaYEhAFf71qJVrR43J1Zr7KfDd2cfxN96TDZsxLxH/txZs48g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790901905;
	bh=cV+Y07iu1RNkRK0aosNKsl6CSJGVFzeqWI7s0a9NE6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gLLiEyVOvzchpHDnxrhUk//SlmWXB8EHkZFzUWdDeYgKbgijCqglJ1ozUPEJJc82e
	 pSfVRRwA7sO5IK8VFe85bZMnf12pOfragkC92DkQ4P2aQinXdnisRNBlxMkpcGRwx0
	 c9pskK/XGK1sp4KO+H/NGSLU9BhjWMONTgrDzK0zSIYBB/qy770btumcPRqHLB0Akg
	 K8O5iX5d4ruuqqG6AHUx0vYOQcPUAzKnZfUYpyYi3mbZg38bx6Zg3fCnNwSeNP8xtV
	 bzCM+L8OnDoq60T8kBmItg8aMGQNuqc35t0fBZMDVIv9x/fofIUz2ojnSBHkXcSbO7
	 g5z/0+cfQ9VrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B996640B68;
	Fri,  2 Oct 2026 00:45:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0942B282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDAAF607F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_ufXA4yCMBY for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 00:45:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B8A1560B5C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790901903;
 b=baNPpf4H/4Cn5Z443Q1xiFlfV671j9KI0sSHQUBBmmChWgKNfAO20wF53tYxSrHphWGJ
 qrHCZu9m6PlkDrjCuOHCxAPTtIIdBPbJ/56W/zXX2nlbBE1tX5kFE0bfrGalkH1NbM6a4
 jeao0aNdQHRM2+8++/kAWV42F7IiireY3lF9kOePTI1NRZRurR3tpi/9K50VkQxMssgoB
 1OkEh0zuW7JdZ0r+y7WMmwRmOHT7pCP+fvtB1p7VuHko1x3BoSZntbAZ/1sLBCFpeSuy/
 D6wBuHTRJfa9Kdv1lcyxDG+94QORq+muDzV+FRSGAs6ybwAYAlyv88INMeaSErQMBHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790901903;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=cV+Y07iu1RNkRK0aosNKsl6CSJGVFzeqWI7s0a9NE6Y=;
 b=DRx/47bSKYcPNP6iI9c4ZiG2syeeo/49khFQK3M0RCySRCq9U7KVdbqk8P1iuH1VCJ2P
 gYn0DSkTCNQzFAUgQI2lMiD/fQpSSJM+95p0Jij8BD6MROouycWRqFfXmBFfH9hdcLp4H
 2ribH1p2MpdXGwDqFlBeKteGmWa1gbrHGga3PsqkXAqi4ZkZlBAA/xXmnc5ZyHLcFcPDC
 Rs1ULS1zms5TPDDD7DGLGoQBMjLTDjM08eVBN6u9MVGug5YpG6iy+duAAP9BxQzIyQlYp
 JDFUh0jCuXad63ba4+DHstnGAATFsRZrhcqWZNJCiMX6rnWNrffsvVyHtHq8kfxr44Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=U8vjfTM7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=U8vjfTM7
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8A1560B5C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:45:00 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a368895so4097028b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 17:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790901900; x=1791506700;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cV+Y07iu1RNkRK0aosNKsl6CSJGVFzeqWI7s0a9NE6Y=;
 b=U8vjfTM7DASQwyk22/M4/SleXhxrYglRsHTJqv059U+I+gqR9wpp97vzt/qzSQm0IQ
 oi8GY9leFHlAFwT80+dQI4/iasXwfVLxNI+mDveIhXTX0pF4P5vqVoG/KBdDLGJVVwcW
 bE2gqgxDm4j3GlZofosom8HEI95kwT1Hibx2aqKGUk6uywwpoxcBT7qCpF9xCuDd96ry
 opZ7q09gj1yE1eRDBZAp85m8cOE9jxvfXo8ILVMP5EYMj47xbvWOVT5WV11cBY2lE8UM
 vV0GtxzelFQkmLlGfXWAZWvQ5ZquPqRxsKiHDfTQDxDeIYPkBplRD5JMqXnEh/uXprFR
 fWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790901900; x=1791506700;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cV+Y07iu1RNkRK0aosNKsl6CSJGVFzeqWI7s0a9NE6Y=;
 b=JGI+GrxD6t2Qq6a/JDrGpnx6Fee/0cMxMq9hRNDVzqmB7RA/xSU8qIGDe/D20ornFD
 X1qudgKQfBlA37x399+bkbcx5pJeatNkPHZ+SPu+I3uAha5zmJvphFrZdYsqsW/9jeWh
 a6a5MNYccm0NdnX81gAj1VUVgMaKpqqO0uyKDAGjPAyGdesLyCvjyDl/RTEndifyZZKd
 kf6KcU7SI/O+t09peZyVOSxQqdwL4fYuop2ZU+idcj3tayC0pLWPW5McwGJLSRl54OPF
 ghvLhw+/ikPy78PdI/sA1sXE/NQjXY7VJKRlyKcji8wAzhYDB2kivZWHDRlh/oIH7d/A
 g3mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXMzsmDNU2AswWX7CVzHl8pkwZZfU2c95V200msam6tu34/2//BZnmDTJPxQwPZ3lTJ1dLtG0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nmq6lFRhx1KAbI00DUlfTLc6eNOO3J/IforjRXi7WwA8y2pmT7
 pjKN+6B2DmarP+VwCFYiVWFmOipYsqUH/ubNORZD5s9teqYEIQaHnIQZs0tRCx27PYE=
X-Gm-Gg: AYBFou3i9va5zptLJ3MLNZnXJCVDZ/khZSBzevQKEgT8QLBgZmTO9U+CVtfZsHSCJEH
 LNhJaeNbAh6e3dkfo1SQ0AbVtmdlRACiXKAL+gtimQ7xRfnJOQXPJX9swNf9tMXgS0lfcGXwdKC
 ASbOtLnHNhG5IpDgr6EtFNLEIhw034Ir6spZLTYAXl+d/o3ZZE4f3TOESSdp/ML5SszMbt7rBs0
 bI3jPav3IjPKtMaGUP/kIt0BEcSq8DCSW0/mh7+ArflSTiq+AknwI+TJRFuH9fr16h2u2soPflL
 NY+N71QVGrXvc1EyAOd1EGvWYI29HDnMBzjAJKx+dGT2RLXV1OUuGCKe3iPoZhcJpxof4HvM7oZ
 z0PeEKNBfHrp4aclwKsUKRcd8ZGaydqm3VGpNiHgRRn9N1oyColvE2MMDtMx855U03wWJ+O2OZ7
 +kp3dQlHReHWoneuEAWrzdDkIQcNc9u8ICahkbRQeOwYCjSG428aOttADCGEkfrt/IxwV5Z2gtG
 7i+7ONOGwr/Dx+RGemXFyYy8+UWTOzM4n/qlT8lvKuc2tS0
X-Received: by 2002:a05:6808:1a0e:b0:4b9:a8ac:489 with SMTP id
 5614622812f47-4f52aa7e917mr809383b6e.39.1790901899995; 
 Thu, 01 Oct 2026 17:44:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b543:49c5:7c72:a244?
 ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16e577c0sm1172833fac.10.2026.10.01.17.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 17:44:58 -0700 (PDT)
Message-ID: <35b32dd3-e2f7-46d2-825a-f3deac33e311@baylibre.com>
Date: Thu, 1 Oct 2026 19:44:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] configs: mediatek: mt8365_evk: enable dsi pipeline
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
 <20260928-mt8365-mt8366-add-dsi-support-v1-12-212f51b1742b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-12-212f51b1742b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/28/26 10:08 AM, Julien Stephan wrote:
> Enable the configuration required for the DSI pipeline on Genio 350 EVK:
> video, regulator fixed, dm_gpio, the MediaTek DSI driver, the PHY uclass
> and the startek kd070fhfid015 panel which is the default display for the
> Genio 350 EVK. That panel drives its reset and enable lines through
> GPIOs only, so no backlight driver is needed.
> 
> Everything else the driver needs, the MIPI DSI PHY included, is selected
> by CONFIG_VIDEO_MEDIATEK_DSI. The U-Boot logo is not enabled by a symbol
> of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
> CONFIG_VIDEO=y already brings it in.
> 
> CONFIG_VIDEO also turns CONFIG_CONSOLE_MUX and CONFIG_CMD_CLS on by
> default. Both are turned back off: the display is only there for the
> boot logo, the console stays on the serial port.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  configs/mt8365_evk_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
> index cc01dcf434c..8d47e4b4b97 100644
> --- a/configs/mt8365_evk_defconfig
> +++ b/configs/mt8365_evk_defconfig
> @@ -5,6 +5,7 @@ CONFIG_POSITION_INDEPENDENT=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_TEXT_BASE=0x4c000000
>  CONFIG_NR_DRAM_BANKS=1
> +CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8365-evk"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_TARGET_MT8365=y
> @@ -12,24 +13,31 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
>  CONFIG_FIT=y
>  CONFIG_BOOTSTD_FULL=y
>  CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
> +# CONFIG_CONSOLE_MUX is not set

Why do we need to turn this off?

>  # CONFIG_BOARD_INIT is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> +# CONFIG_CMD_CLS is not set

Why do we care about turning this command off?

>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_UPSTREAM=y
>  CONFIG_CLK=y
>  CONFIG_MMC_MTK=y
> +CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_POWER_DOMAIN=y
>  CONFIG_DM_PMIC=y
>  CONFIG_DM_PMIC_MTK_PWRAP=y
>  CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_REGULATOR_MT6357=y
>  CONFIG_BAUDRATE=921600
>  CONFIG_DM_SERIAL=y
>  CONFIG_MTK_SERIAL=y
> +CONFIG_VIDEO=y
> +CONFIG_PANEL_STARTEK_KD070FHFID015=y
> +CONFIG_VIDEO_MEDIATEK_DSI=y
>  # CONFIG_WATCHDOG_AUTOSTART is not set
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y
> 

