Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF922CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69F2A80ED5;
	Tue, 29 Sep 2026 15:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mq9xBYD9EZBJ; Tue, 29 Sep 2026 15:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56D2B80EBB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694045;
	b=KGV8AU7fCkSSbC9GEuyxtIg0Z+SJ+E1qGDi1ewMqnqp37A13yUGLMgSxD4XidDEyrTgT
	 npwU5BbJU5NLmtnJMkoGIr1+1cG3O61aXVHkm2LxNdag/LS7r/q0Y+BciL1JkzMM5TM78
	 RcEIaWME5J8mDU0eJOaPdAd7LGqXKEovK7l3eDMB+SjN2lPO/BwyEDU2kakkX7xP5pOL2
	 DWQkpWk5M9OA+WFutcmIZARdEEe2Su2QdJgq47h6f1FeY0c5wBur4JH37ZAMaZDXEIt5U
	 AJdNfMSOHimrRVI19qTkmz1WQIv52oiWqJbFZ0ozm6QRK6ZBh2HtdEkvI3nVGlmwDtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5FDlkbsp1G/RJKi5Ih82jUIMxZAkXLQO/NeefX7rqAg=;
	b=Az5fpwr4Z8AVi0Kyguai6P8iInzesJU/8qcMwakMZcV01RHg/A4h/VNGcEzAYubu1BzB
	 qnlSri6PMjR5I5W44bzHhAT+VwedSqRUMRX8/Twf0u+pWXfFs/G/ZJQNYUjZYv0XJ2Uh5
	 7Jf/S/0x58pGjxiz6sHoSUqdyagEFCXeIy/2R2KiD6mx1ZMa8o+OJ38JhjvNAKVEPrtFo
	 U7o9QJVrBagX7rnSkbcsotb6KHDP8UgAVaAXqX9Kr+X1+aP2cazvtwdgfnCLltWhgu4GZ
	 WPNpv4lYMxG5Q+RdoI7y80G+tfMU3yxgaf3fGoKbSDcgDp8/uYu3TKJD0VuHnFGOPuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790694045;
	bh=5FDlkbsp1G/RJKi5Ih82jUIMxZAkXLQO/NeefX7rqAg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZxcD0KEhExeil1+iqGbSm9k/GoZn3j35GgdpKBvhy5lFJYslXcKDki33y3LnX03W
	 CU/IHkSIe6nUhTC7TtRFrvvOnPVCIDEzGEJFEbYPGw74czXgIHrMxoevuMoGMnTg/S
	 ZdiMQG+yILNr7ghkiTRyoI0WORjFK8ABoLxPwu7W1WdkOG8uX8QWuUffk83BkgnXnT
	 tXEiy1OEP7EGGGKUh10fBEDKhk9Jw4l0dzBirTLS9uPUa+MVzUZVNSykR5T1jGIjZh
	 Ha5M88vrNSiUKvtNXpTX9xtnicFyueOhkKQXwac3n7oHtW34r+QqY85dQ6pd47OEa5
	 4FfRa8DiMjF7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56D2B80EBB;
	Tue, 29 Sep 2026 15:00:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D81B532F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEB7B4032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqM8sAhL6-uQ for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:00:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 99B014031B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694042;
 b=KcI39WnG9fnvLAg7+uZEbObKbaKi/nYsSaiHkmgBGDGRbzz1Z++j+w+pcKASvhQLk8jc
 34ZsWEmukvBSNFRNwTa7Y6cM0x5je2V/JGK79eCAAYqsLacNt05C+8f4rDgX2gXFc1VAJ
 ipssHlt2krE2uu3UN72ghFlm6sTXp1q6bHrCz5iTh014YGZJuofy+/p/3crVGU9eODTvC
 1izPR/p4JhppDV6OdzB2JHarSfaCfUMNOv4HIOKUjeZiRFZyCX4J9QkQgHoTGoVq+8Xsv
 QqYp+Ccchkm2jsqbfFL2MzKRDuHByCvRdLMLTpsXEhk/GEBIhdLcT/rDogX3B5rQFQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694042;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=5FDlkbsp1G/RJKi5Ih82jUIMxZAkXLQO/NeefX7rqAg=;
 b=nZQaKB11n0TnZVu9Ptf9AB+3AfM9PCjnz85WR8FxAIPkE02ufgGzM8RdkFkpjx7Z49PB
 IQWDt5SY+PFAsWm0mEdr9RaoyrVDyv+RJjzP9bEdSmfv9KI02W8RqlxwUcTrdTDZTBYGo
 leVa5AbhAu9aUE/0NT5Ztth8TZsCK50xlNHmBYsXfHDqqMY9+8taBHWLKrRT2FYORw8fD
 Qw4EVtLBWVUFmN9Gqlji7pZr7HaVju9HuOkv6QAWQYxFXbXY6gdJ6FUY7cFDPeekAQnNB
 3w0GnoRLiWk0l/JZwU8t0H/NjGd9YPz926ZHkmGkiVrCetZiPy10hLI+m/oCmR9xsxA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=itcLymoO; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=itcLymoO
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99B014031B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:00:40 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso23276705e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790694038; x=1791298838;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5FDlkbsp1G/RJKi5Ih82jUIMxZAkXLQO/NeefX7rqAg=;
 b=itcLymoOOPLITM43YIQsSxdR2lmrHkON6PesiX3OZRYNgx422yPhlNtjtVkHpyMT9v
 kWv/cbBJHYXMUrrp/YWyYPDYkJwFSE89Z9iJZMAUQxUja0Tsb5RrAymjjwCztZ2/gJMH
 d0SGKfJIG1S3OmrrACpBnrUFKCoVG5gVPL86QCL32YpscOzYqHzkzQmo1yqPphyy0tg9
 +Jf7mEmFR9+Tig9+WzYgmSQFCgTL2ZMQ6j69L5s0/SxRsr6twpJ15ihqzDmY6M19fiT7
 A5qtaELidq5PrtNUNORCtHMjzYDz4jeeuP1izHvVWfIk2kmxkD5pQ2S4nhQqCuiiteiO
 aKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694038; x=1791298838;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5FDlkbsp1G/RJKi5Ih82jUIMxZAkXLQO/NeefX7rqAg=;
 b=ADDBZEzPBI3eTUO8IUca8/+rW15sWKLBYksQFor4AY5ydeduzr5WHI1WUiRtRZhQWG
 h17kT9HqwraMJ2Pqao//WByT62k8+RIiwJ12yz+eD9BahZW7PmbS57iu7jX4IRol7+aC
 BSIHDloDT3hct9+dQMI6Gj0pF2FP7qbPYSkeGtoabNapZfYfplgZtSSMH5v8FAuR/t6T
 iXQBnPdUvLZAHWpXvBoDOuXRmrPSpgoUPqAyYeZxYvQXmW1Mvd/QDxBAd6VPLZniHhZu
 58XcshrS0iEHydCe3zK8A9cvf/qlZ/LqnXMc3Cef+ioqlgKKK5a2PodqBBqgJkvsEvGR
 Kwyg==
X-Forwarded-Encrypted: i=1;
 AKwUvByDgo9RHJadypv/hlL6QwaCpAkGalzTKFlHBmOJsKBK3CJuVgYjdAeSY00Gm7+D43H6VZ77XU8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mHcnM9Nxf/8ZqA32cI0AZnH/23JQsOpO+TzB71Ff86laLVy0co
 jt6Dftik9/MQp01TislwEdOWBVeOBpw01k5plBmJKhCtW4NKYso67TKiV2BnmySIj4M=
X-Gm-Gg: AYBFou2QxAwM2Fwz+ZM+2hLVEBMRepEoErelvu63hJZUdGTWNdG9rbZPSx9D+tPYZsu
 wyfWIj9hanJUu79jaad4yylx7iWKz0+ADmZ8jAZXkPCY2qrJ/8qnmNYkQmC/nDQMpIiGAUF110B
 UmRZ3B+ewDD8KLY/zeMwcWd8rY0KgK4BhoFwoQ2PHiXDJSICSPZJ6lO7VmMHbQUJBLx3EQwW3zM
 E+wC9ojo+TVTuCS76qh3qjTmct1+csFxklEPRZdv0abJIr1AYkuQDn6QLl12HXe7CnezBm7B6wH
 CCeRoz4Eak2b7A11TPdBFV6JeriREj7/iy4J6l1b4A8LMFBoTUUU2qpS654oZSGMhb9X9x69M+c
 DKPx3tTfjOCiFs0SmT4TRKtCue4Z9UFr7v8T/aZoXkRdVnO8liiW6KKq5tMnCb/eBDx8+JtR2Hl
 ESrnDCoecj6wXBfvuH22cTU8qNPEywh9eDW4i0U3SjESg2I3gyMZMVCymaksRhHuoGP8C3rxxjL
 VAg6AkJLIm3P8YPsJvV7Qf596iFbIw3pwuiUJqTYQ04TKamtJFJe2ogECc+vGM6c7Vneup45z+e
 A6J68A/4ylpxzGAEE3wJq4DQUqlVbk+amQWuwRNre4rbg+gx3+txySo=
X-Received: by 2002:a05:600c:34c3:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-49fe66abcebmr286253375e9.3.1790694038346; 
 Tue, 29 Sep 2026 08:00:38 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf868b5sm119351065e9.1.2026.09.29.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:00:37 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] video: panel-startek-kd070fhfid078: new driver
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260918-mtk-video-panel-startek-078-v3-1-631a63ce255c@baylibre.com>
References: <20260918-mtk-video-panel-startek-078-v3-1-631a63ce255c@baylibre.com>
Date: Tue, 29 Sep 2026 17:02:50 +0200
Message-Id: <179069417031.1887049.8619892190348130386.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790694174; l=8146;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=rWi51hhFfetb4zVZEg1lebEi/8pHfQEPWJ1U6UbZ2m4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB1pqY5mYTNM/2asUk7ksqlgU7Mz+eSN9kMKqPMtKYLOF3DZ0cxVDjeMDAW4/MVfYS60i4vcfYX
 SOTPxqUO1OAM=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
> used on the MediaTek Genio 360 EVK board.
>
> The display mode and DSI mode flags follow the upstream Linux driver
> panel-himax-hx8279.c, which is what the "himax,hx8279" fallback
> compatible in the device tree binds to.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1e09c7d087..0af0957e5b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1671,6 +1671,12 @@ R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>  S:	Maintained
>  F:	drivers/video/panel-startek-kd070fhfid015.c
>
> +STARTEK KD070FHFID078 PANEL

open question: what about merging this with KD070FHFID015 just above?

> +M:	David Lechner <dlechner@baylibre.com>
> +R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> +S:	Maintained
> +F:	drivers/video/panel-startek-kd070fhfid078.c
> +
>  TARGET_BCMNS3
>  M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>  S:	Maintained
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index cfa3cccb911..500a8a54192 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -330,6 +330,16 @@ config PANEL_STARTEK_KD070FHFID015
>  	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
>  	  built-in LED backlight and touch controller.
>
> +config PANEL_STARTEK_KD070FHFID078
> +	bool "STARTEK KD070FHFID078 panel"
> +	depends on PANEL && BACKLIGHT && DM_GPIO && DM_REGULATOR
> +	select VIDEO_MIPI_DSI
> +	help
> +	  Say Y here if you want to enable support for STARTEK KD070FHFID078
> +	  DSI panel. The panel is a 7-inch TFT LCD display with a resolution of
> +	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
> +	  built-in LED backlight and touch controller.
> +
>  config VIDEO_BOCHS
>  	bool "Enable Bochs video emulation for QEMU"
>  	help
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 16e9ee2c11c..a4b28f3b3d8 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
>  obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
>  obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
>  obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) += panel-startek-kd070fhfid015.o
> +obj-$(CONFIG_PANEL_STARTEK_KD070FHFID078) += panel-startek-kd070fhfid078.o
>  obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
>
>  obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
> diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/panel-startek-kd070fhfid078.c
> new file mode 100644
> index 00000000000..b86d5197ab4
> --- /dev/null
> +++ b/drivers/video/panel-startek-kd070fhfid078.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 MediaTek Inc.
> + * Copyright (C) 2026 BayLibre, SAS
> + *
> + * Authors:
> + * - Guillaume La Roque <glaroque@baylibre.com>
> + * - Jitao Shi <jitao.shi@mediatek.com>
> + * - David Lechner <dlechner@baylibre.com>
> + */
> +
> +#include <asm-generic/gpio.h>
> +#include <backlight.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>

nit: <errno.h> is unused. You can drop it.

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <mipi_dsi.h>
> +#include <panel.h>
> +#include <power/regulator.h>
> +
> +struct stk078_panel {
> +	struct gpio_desc *enable_gpio;
> +	struct gpio_desc *reset_gpio;
> +	struct mipi_dsi_device *dsi;
> +	struct udevice *iovcc;
> +	struct udevice *vdd;
> +	struct udevice *backlight;
> +};
> +
> +static const struct drm_display_mode default_mode = {
> +	.clock = 156458,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 50,
> +	.hsync_end = 1200 + 50 + 24,
> +	.htotal = 1200 + 50 + 24 + 66,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 14,
> +	.vsync_end = 1920 + 14 + 2,
> +	.vtotal = 1920 + 14 + 2 + 10,
> +};
> +
> +static int stk078_panel_init(struct stk078_panel *stk)
> +{
> +	struct mipi_dsi_device *dsi = stk->dsi;
> +	int ret;
> +
> +	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x05);
> +	mipi_dsi_generic_write_seq(dsi, 0xB3, 0x52);
> +	mipi_dsi_generic_write_seq(dsi, 0xB8, 0x7F);
> +	mipi_dsi_generic_write_seq(dsi, 0xBC, 0x20);
> +	mipi_dsi_generic_write_seq(dsi, 0xD6, 0x7F);
> +	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x01);
> +	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x0D);
> +	mipi_dsi_generic_write_seq(dsi, 0xC1, 0x0D);
> +	mipi_dsi_generic_write_seq(dsi, 0xC2, 0x06);
> +	mipi_dsi_generic_write_seq(dsi, 0xC3, 0x06);
> +	mipi_dsi_generic_write_seq(dsi, 0xC4, 0x08);
> +	mipi_dsi_generic_write_seq(dsi, 0xC5, 0x08);
> +	mipi_dsi_generic_write_seq(dsi, 0xC6, 0x0A);
> +	mipi_dsi_generic_write_seq(dsi, 0xC7, 0x0A);
> +	mipi_dsi_generic_write_seq(dsi, 0xC8, 0x0C);
> +	mipi_dsi_generic_write_seq(dsi, 0xC9, 0x0C);
> +	mipi_dsi_generic_write_seq(dsi, 0xCA, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xCB, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xCC, 0x0E);
> +	mipi_dsi_generic_write_seq(dsi, 0xCD, 0x0E);
> +	mipi_dsi_generic_write_seq(dsi, 0xCE, 0x01);
> +	mipi_dsi_generic_write_seq(dsi, 0xCF, 0x01);
> +	mipi_dsi_generic_write_seq(dsi, 0xD0, 0x04);
> +	mipi_dsi_generic_write_seq(dsi, 0xD1, 0x04);
> +	mipi_dsi_generic_write_seq(dsi, 0xD2, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xD3, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xD4, 0x0D);
> +	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x0D);
> +	mipi_dsi_generic_write_seq(dsi, 0xD6, 0x05);
> +	mipi_dsi_generic_write_seq(dsi, 0xD7, 0x05);
> +	mipi_dsi_generic_write_seq(dsi, 0xD8, 0x07);
> +	mipi_dsi_generic_write_seq(dsi, 0xD9, 0x07);
> +	mipi_dsi_generic_write_seq(dsi, 0xDA, 0x09);
> +	mipi_dsi_generic_write_seq(dsi, 0xDB, 0x09);
> +	mipi_dsi_generic_write_seq(dsi, 0xDC, 0x0B);
> +	mipi_dsi_generic_write_seq(dsi, 0xDD, 0x0B);
> +	mipi_dsi_generic_write_seq(dsi, 0xDE, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xDF, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xE0, 0x0E);
> +	mipi_dsi_generic_write_seq(dsi, 0xE1, 0x0E);
> +	mipi_dsi_generic_write_seq(dsi, 0xE2, 0x01);
> +	mipi_dsi_generic_write_seq(dsi, 0xE3, 0x01);
> +	mipi_dsi_generic_write_seq(dsi, 0xE4, 0x03);
> +	mipi_dsi_generic_write_seq(dsi, 0xE5, 0x03);
> +	mipi_dsi_generic_write_seq(dsi, 0xE6, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xE7, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x03);
> +	mipi_dsi_generic_write_seq(dsi, 0xBA, 0xF0);
> +	mipi_dsi_generic_write_seq(dsi, 0xC8, 0x07);
> +	mipi_dsi_generic_write_seq(dsi, 0xC9, 0x03);
> +	mipi_dsi_generic_write_seq(dsi, 0xCA, 0x41);
> +	mipi_dsi_generic_write_seq(dsi, 0xD2, 0x01);
> +	mipi_dsi_generic_write_seq(dsi, 0xD3, 0x05);
> +	mipi_dsi_generic_write_seq(dsi, 0xD4, 0x05);
> +	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x8A);
> +	mipi_dsi_generic_write_seq(dsi, 0xE4, 0xC0);
> +	mipi_dsi_generic_write_seq(dsi, 0xE5, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xBF, 0x1F);
> +	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x12);
> +	mipi_dsi_generic_write_seq(dsi, 0xC2, 0x1E);
> +	mipi_dsi_generic_write_seq(dsi, 0xC4, 0x1E);
> +	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x06);
> +	mipi_dsi_generic_write_seq(dsi, 0xB8, 0xA5);
> +	mipi_dsi_generic_write_seq(dsi, 0xC0, 0xA5);
> +	mipi_dsi_generic_write_seq(dsi, 0xBC, 0x11);
> +	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x48);
> +	mipi_dsi_generic_write_seq(dsi, 0xB8, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x00);
> +

Looking at panel-himax-hx8279.c in the kernel, it looks like all of
these commands already have named defines. Can you use them?

> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0)
> +		return ret;
> +
> +	mdelay(120);

Nit: Linux hx8279_prepare() waits 130 ms after exit_sleep_mode
anyreason to have 120 here?

> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0)
> +		return ret;
> +
> +	mdelay(20);

any reason to wait again 20 ms? Looks like the kernel does not

-- 
Julien Stephan <jstephan@baylibre.com>
