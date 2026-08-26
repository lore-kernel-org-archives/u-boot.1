Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B9C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 17:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB05B80AEF;
	Wed, 26 Aug 2026 17:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0P4IasOBFgsJ; Wed, 26 Aug 2026 17:20:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787764802;
	bh=Vksdnb/kKLMxEsVTTfcFpnU9lHql5q6i/HfIJrBVX4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cb2jZAVsVRD2Uod6KI4YZVsV37gtyttKCgCC/ZtGGWmo75m7MN74a/MX6Vz/v1Mdn
	 F/o36xOvanzXzyQ4qjpOyJczdqZppP0l9w9mrHjDEhnWdFtlYHboNpRZRskLM3w3iq
	 mjtL519n+F4N5/ONDS4aCaVcyHRaT2kfN39tDPuLC6R0wIuU3UIqa5L+n53p9EVRox
	 coVYc8A/V9poXRNzt6N1STKyW0Ees+cUkCmZu6WB3HHV2pZ9TEPEGJDBADFFa1QDN8
	 /2ppOqzrgoYXTyU/vlbelW06jl8AMwtKouprsJ8Dfk6AvZeqDP0rJnfCmrsETxSd2/
	 WfTvg+P/CaeFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AABE280A91;
	Wed, 26 Aug 2026 17:20:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C40E230
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D0374052A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IeDGT-ig9L73 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 17:20:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lulxxFa/
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 953B540503
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:20:00 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7ec58fa3e01so1159371a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787764799; x=1788369599;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vksdnb/kKLMxEsVTTfcFpnU9lHql5q6i/HfIJrBVX4k=;
 b=lulxxFa/y+5H4y6e8uISXWRfz4jn0DiaE9DgtsVNrrTKlHvhl3ZlPvg00tACss4nBc
 649zvvQvOruXXYhnAiT9Qw/hFnptMTKJbwEl3uQVGguNUF4rkWSKJQGhiZdgdZ1f7SEl
 UIoRRm98nxoevu8fhccUk4SPzYielH/R8RCoej8XIoxXIPpOdhHaoyq53Ibt6B9CDRrK
 HDt59VmT+D1DAwUsznRNWDZmPSLUBwdNC87qDwmXYmRlZHgKc+JQLXEHzlukEzxBZJeU
 qDwun0vLBfDkcmAzYNfgP0Im5MVWmJOlyXBuEtNmwgV2zCq8GltIua7t4Nj/6Jjzgc/O
 b5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764799; x=1788369599;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vksdnb/kKLMxEsVTTfcFpnU9lHql5q6i/HfIJrBVX4k=;
 b=bUvVry2xQvMwGHQ213soeMeY49GVcjECbPr+TXY44T6bjUE1CF5n/AS5vwHY46PhZO
 xLfBRG8Nj4dXmcoNGFFn1ZE1/IAhsbj4tYl/hpyQ9np/8Kf04kPrbMlvi/In9B83OLY5
 vOhliw9fP5sGzulVYATD0NQ2UTX2w3GmNKMIOHPniu3na6FPidDiGel+/cSvhMDRG1rY
 B306lMOHCGIMdDaZnmPfh9VLKQGNrCNaIahoIOnknSLkhWLmUWvJBVgebu49qr5NcD6+
 ymM0lSVShK7ANE1zl5uUzJOImYa94ONWU92L938jG9wKYroq8SYdTfyYaKvshFyF1+I1
 FQ2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoB1ybFbTCWaXGMsKQdYsQp1auhb5amXuhtBA5mBrYJfEbF8cZk6RAJ6JPgo/fMdEv8uM8nmfo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kL6Vf8YO6hGAsAW7iXnRNe46jsGPH08CqLDa4k4OKk/vr9d1Pw
 ge7/WnstWpI1Ech4TYI41+flb86AEbxLbWcVAZ9Wzb37PiNrWG1mqDr3R7YXaAvGWhk=
X-Gm-Gg: AR+sD11co2TWWBmJrUSh5NCKl9ukqIzoLQdH6x6OKCV/5re4pvwhoR0vN/ZnmL2LDIG
 3iba13o0iBF6ZB8ExNzeobrhc/vMshm2lMGpBLMwJMuF/w/+xTgVdE9rISaxGkFx1Ibc9l1YUPP
 FecgNZbg4kbSzd2UaceQwcNsowHeJtu6XdD921vpTgotAdYoyuTlPPdYv3npDgZr2L+U8J1qMxW
 MG0JiOXluv6CoWgQJMcN0QtqdLCKLl5F9pLHSGJLdh0n9JDQGGJn2tnFX+b+2iK4vw7S8LAZLxq
 iRrpv5lVpouv94ircFfHy2WXqi3tTQIrP3koYfcR/EaMtdEBqaPZ3nZhIAkXvZB1f2fWlarjvZR
 XMOK5xQkqon//X9onse57+rqvs5W0FKvbG//ceCIwV4GymgHM6nSL4bMawW8pW3WM0HARPH6eXn
 LyvOGnMWUTtkU9vuYFfpSUa2JxxkXeHFSE3Jyb9dhzDteHu3AwPJ/9eq/mkX2sxGO66WTZflCn7
 udT4xwt8ZhW7zHiQqEO7Yiq/7+pANi+YdWEB03utbXxKkh7VA==
X-Received: by 2002:a05:6820:5707:10b0:6b1:332a:9185 with SMTP id
 006d021491bc7-6b1a0501d47mr6405708eaf.28.1787764798933; 
 Wed, 26 Aug 2026 10:19:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465ad9f7b80sm2674499fac.2.2026.08.26.10.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:19:57 -0700 (PDT)
Message-ID: <6a2f566a-f855-4d91-a657-153f7073ae57@baylibre.com>
Date: Wed, 26 Aug 2026 12:19:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] configs: mediatek: mt8188: enable hdmi pipeline
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-14-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-14-68ebb1bf17df@baylibre.com>
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> Enable the configuration required for the HDMI pipeline on MT8188
> based boards such as the Genio 510 EVK (MT8370) and Genio 700 EVK
> (MT8390): video, the MediaTek HDMI driver, DM I2C for the DDC bus,
> the PHY uclass and splash screen support.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  configs/mt8188.config | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/configs/mt8188.config b/configs/mt8188.config
> index 29e2b3db878..9d7cf13a191 100644
> --- a/configs/mt8188.config
> +++ b/configs/mt8188.config
> @@ -9,13 +9,18 @@ CONFIG_TARGET_MT8188=y
>  CONFIG_SYS_LOAD_ADDR=0x4c000000
>  CONFIG_FIT=y
>  CONFIG_BOOTSTD_FULL=y
> +# CONFIG_EXPO is not set

Why disabling this?

>  # CONFIG_BOARD_INIT is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_BMP=y
>  CONFIG_OF_UPSTREAM=y
>  CONFIG_CLK=y
> +CONFIG_DM_I2C=y
>  CONFIG_MMC_MTK=y
> +CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
>  CONFIG_PINCTRL_MT8188=y
> @@ -25,6 +30,13 @@ CONFIG_BAUDRATE=921600
>  CONFIG_DM_SERIAL=y
>  CONFIG_MTK_SERIAL=y
>  # CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_MEDIATEK_HDMI=y
> +CONFIG_SPLASH_SCREEN=y

Since upstream doesn't have everything needed to actually make the splash
screen work, I was thinking we should just set VIDEO_LOGO=y here instead.

> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_SPLASH_SOURCE=y
> +CONFIG_VIDEO_BMP_RLE8=y
> +CONFIG_BMP_24BPP=y
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y
>  # CONFIG_RANDOM_UUID is not set
> 

