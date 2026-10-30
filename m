Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81070606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mp6xjGR4;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZPhCcO59
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52F15606B0;
	Fri, 30 Oct 2026 10:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2kzRhJmp1Kx; Fri, 30 Oct 2026 10:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EF326062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793356765;
	b=N01p66scxtdPSlYZTf84S94kucK4Eb34diU5Tt/CSPRdQ0QkgNXyWXQg8b1jQL5jik93
	 ARw1pjrUh9ovqOOOBHClE2OpX+5RAvdZrAfAkk8BzNGyN77YUGMYYwR6AU6DilRXgDWlk
	 XPhfj6hn8prlvqjUC+gcQvJjgbebEU0SWyen7KmGzzWTZqjHvaX0hNnAXrUWNGN5xrUFN
	 H8rTSeP9QIsbX5R3JPYm05644ET0YWtssqPAJpMG2xgOqZzbDxuL4cKiaKjE2KG42YTCp
	 t2BdeepdMMAUcHD7GNjiB2HRiLxBSdRLCTaOL8Q+xr2KwGGismbkORLzje8WMf1dXUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793356765;
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
	bh=yDOtiMOHMjr4+5cC3HRSmh/2cgewQDtq9daNejjLbQI=;
	b=MWYlYeM+5HIE4BuDKCReWFhKcUuVSxBeNtszUsXsXYr17qG7LANoML6Ok29Gd1XVtO0R
	 V3pPbXU7xouFzWLCm6OCIJ9ENJvX8bWPNpOejb2PjIb/ps1eoRzrFsJ/Vr/0c6g8RrrfD
	 kVhMoaMXLR4HtBLbX3ARCTRQoLfhx+UNpy6KLniyUBL4uq2WF0uXFjh7y6rXzjkOpnd+F
	 OhwaG5bEr8uZoWqNrTpiVflJpAB+26dhcCMUjbDWEWu8mXQ411BF8jhVexP864y6qvcIX
	 zNdaj0tqat7codvlY5Nf/HmNPf9VNEXDmyWqHt/GzHPmjGGfnkYOvCoWyvOs5KgCzCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793356765;
	bh=yDOtiMOHMjr4+5cC3HRSmh/2cgewQDtq9daNejjLbQI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mp6xjGR45XB5ZMkLndSN4x61jYC+sjPUooxzDoBWKD9uPMJyqfGvNyhgrnxrrZEFt
	 QYDLpOiTfojCBXK27BakMF04WMrss6cyIBJsubSlQgrG0Uiv4S3Z7KIAQEmwZC40Ng
	 ZWcJ6mBrKx/+9+pnUigCSbkhxkkig2GJa9HOk/icQWtVWf1FHPRPuGT0GpU6xrUJi+
	 w07xPx8qc0Y+fFpb1YRonhikwQaBNfjq6bJsEToFwcfxc0+ncwrxhQ+K9gpdSWjxOm
	 wy6Wz4ERS1GGRWrIyPEGZwMOw1mLPO3ZsU89N8rA8hXbv3BI43dtoFbQ834zjtWPSq
	 kO+j9oB6NATgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EF326062C;
	Fri, 30 Oct 2026 10:39:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55B6E3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47199400B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLOqhKApfxyf for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 10:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3A46940063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793356761;
 b=FKA7I6L9wyJJn4065UJ5Ufa4LFuHK68Y26xLb1ic3iACcO9IRZ0KkvQYNEyJPQl/NvVI
 aa0pPg2rzxq06YV1gS5Ri/8X6+IjQi6QBAPTtSHLht/K4Wk70V+sTI0vQj3G2OPcUifCa
 ngyl40Q2PHwtBsvAJF4K/4PYgiHPeo/Twv/K4NXYQkMimTlBnAp4vDFnweo7z9it6sv9t
 Of+7AQOxwouce/ODO9cseovzQfwFXgnXkDOxPvs+qfBDqak/Z522NwEtCdReRSP74WYcL
 t4byTXEopKlu/nkcnjmkH9msxoMVj4VY62YopQ2PjLm7aSgNJhy9WKHYT9has4k1N4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793356761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=yDOtiMOHMjr4+5cC3HRSmh/2cgewQDtq9daNejjLbQI=;
 b=RYd5M+U/WKdZDplU/4s07opo2IiBV4yd3U2vNFP6S8bESPmqtmcKXrOAnO2Ukgj5GcPA
 6t/bzBikXpCKv1gRWHV5GA3/S+1heMNWpZkPNy9mAasjRH+RwrgoipK+yiunXtNqUZRsW
 6+aIbVXbIiLsHAtT1T9QFju+bdLEhj5SxeoDRW3+Q6MYwQeP1n+JV7okcLovRB+cNQCE4
 GRu5JKy5TPpz5nYst14XSrCtVMZVnQ9wGEth6GcdkyLYJxfpjrJIFPQTbDiGYslbLUt4C
 e/Q2Ie4Lr9IQ4DqrMs+EolrWOKCsP9sWmcvwGvjmaHYqlU2MXlXXRzmUlHwasdujwig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZPhCcO59; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZPhCcO59
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A46940063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:39:18 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so3863935e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793356756; x=1793961556;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yDOtiMOHMjr4+5cC3HRSmh/2cgewQDtq9daNejjLbQI=;
 b=ZPhCcO59baGmdpiYIJ/G9fdhh9ToHl5f6obR14nLU/g2wkYz09i5U9RuDrEyeEKCkj
 m84rFBcHW14CRuLqP1E21PWUWwZlCZ24C/DTzz4TtpT4LjCXbDcB4QFqxU0xv9tYi1s3
 I8ik91PU4+os70T8VDKWSHd195GJhDh/g6XrDqrVn55DS/V/uKEIGKkIm4WIlvyTajj+
 9+FBadILNDiWO6Ij4kabAT0lg6EVviHdEu+fpJcwVrGptwyV7skErq26XwLSSaZqLWot
 NaO8IVjuRVLinwUyKA1x9QV9U0fgnjbmLI6vxbKCZMe+twFR97ZTBT9qCOI7Ur48L/EY
 +FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356756; x=1793961556;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yDOtiMOHMjr4+5cC3HRSmh/2cgewQDtq9daNejjLbQI=;
 b=jv/o6+Rk4K63IxZxeztIg7WsvHcKPEGt1bmvHAiDbuVkrjWztZ8FAxfTmVyisqstdQ
 lgPwpvl4h9+cUpOc52ezGLXiRf+MQK3+8gUz+R9PczWTRuGrUY9SsUQmN5eGDyI0vQ6R
 Yy2DTUNYJRYmHX1BoEaYZbKoJuzSzPsME5mqJdYC1s6sofEiZQKo89TrxFlNID4t2orq
 rC8dmvUyMSHMv/lUA1cAQQD4y8rzFcunPvge+yqmtP0YMWoVDI0YmKuS7en9YVoT35Sf
 mzoyaH2vFya8tHTLf1q+4TGS+Ux/i2GFeBjhGY2S6Lr6kT7qLOtWZlpTXfRUZ3vX7CGZ
 LMyg==
X-Forwarded-Encrypted: i=1;
 AKwUvByd90U3MUc1nXyko0itZT9D5goms86FHA8xlh0Zj8AB53/xRxjITpY+rJUSiIqXBQAuQDuU+0Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIs+a6CB6mukr0Bjr9qUugPUjEYaaYgCqp/Sf9P8VlreUOnjsot
 7RSVC0uj+uJ4LohOB1L15z9AgLCWHOEaOU6qMiZgEPHkU74Fea1KDtb3KsPZrCtHOXk=
X-Gm-Gg: AYBFou23aLsEYvRZFM/+SHyZMDLQ5UQszgvpMP0ZeZlpp0/bhk27zrq0N1UjfMNUYuo
 /35OpTpIbq1VkZAgL0n2NogOdJc8a4ReYfK2MBJ5Pw6a9ei6KgwmZdoqJ0gxQ/deHQIyAKeWESu
 w5+C9I8tQrwUmOvcYGWVnqosp/2itMIAlZkKZLZ80pdXSeBLTFcToaPznZ04I/wkfi9JvEigWrR
 1Py4q+wFaw2I82L5C5c9os0W1YglV3QVoOZW3wKRKQMfLJgZm3t6iDptT/HsUYuOvkHDSPwHZb0
 AGcqdIyuoEeCER9WFk45yw2bd6GYtrvEKkhZqBzZXxNC9XDeK9KrKZVsUxrEdJK9QkahtyS1TAZ
 tiYzxMXacNNmSwFlgW7KtuR8uK4yQqeISK0neaDvkKAdcs4tVThHc4vUIY2N5jxMo8EwrJaRW9q
 d96D2ERU7fp9xcbejGYrJSpcTa+L1a6R+CQqc+7Qrz24M9mN38Qvkj9kW4nTRFK1eUCklFv5ItC
 s7CO8oXv46yIC5bUPtdFaMEX+9lpeCrxvNh1p05h+HIhwAnxkHDo+F6Tzh+Ue+iZHHwxd2uQ028
 SeJsKctsqUwBTEXOhHxFM2ILDKAkGTgJekqhvHk2EDjb2oSm9qhJn0gFi5nP64ztuE9rhhalQWY
 qTWQqFcbkyT0n6Nx8GYtd0LEncd+fxKBCDZDQCiljFu07nuNygWWT8fgkXzY6lPx8+A6CsF2FqT
 FN/CkwEdSZuw==
X-Received: by 2002:a05:600c:3d8d:b0:4a2:cbe:beac with SMTP id
 5b1f17b1804b1-4ac18a89393mr38116795e9.23.1793356756212; 
 Fri, 30 Oct 2026 03:39:16 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm130073175e9.4.2026.10.30.03.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 03:39:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/4] configs: mt8188: enable USB host support
From: Julien Stephan <jstephan@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20261029-ccaione-upstream-mtk-g700-usb-v1-4-6b0dda25be38@baylibre.com>
References: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
 <20261029-ccaione-upstream-mtk-g700-usb-v1-4-6b0dda25be38@baylibre.com>
Date: Fri, 30 Oct 2026 11:39:35 +0100
Message-Id: <179335677539.4117849.3115175029896252352.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1793356778; l=1580;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=g8zCDz6roXYzmf+YoFKPJX/D2GHFAG4S+fBBP9sBo34=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPZZ/Mz2QkS1P5bmAju5/81Nf2JSdFV9gTZEKkATXocana1v/UVmQr34Bsey3artznYVfAOrYiO
 ru3KN5gd0LgU=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The Genio 510 and 700 EVKs use the same USB host controller, PHY, PMIC
> and onboard hub. Enable the required drivers in their shared MT8188
> configuration fragment so both boards can use the USB-C PD host port.
>
> Enable the MediaTek xHCI/MTU3 host and T-PHY drivers together with the
> PMIC, regulator and onboard-hub support. Enable the USB command and
> mass-storage driver to discover and read removable media using the
> existing USB stack.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> diff --git a/configs/mt8188.config b/configs/mt8188.config
> index cd5e68dbca3..26c1a972d27 100644
> --- a/configs/mt8188.config
> +++ b/configs/mt8188.config
> @@ -13,16 +13,31 @@ CONFIG_BOOTSTD_FULL=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>  CONFIG_OF_UPSTREAM=y
>  CONFIG_CLK=y
> +CONFIG_DM_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_MMC_MTK=y
>  CONFIG_PHY=y
> +CONFIG_PHY_MTK_TPHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_POWER_DOMAIN=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_MTK_PWRAP=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_MT6359=y
>  CONFIG_BAUDRATE=921600
>  CONFIG_DM_SERIAL=y
>  CONFIG_MTK_SERIAL=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_MTK=y
> +CONFIG_USB_MTU3=y
> +CONFIG_USB_MTU3_HOST=y

Nit: CONFIG_USB_MTU3_HOST is selected by default and can be dropped:
USB_XHCI_HCD selects USB_HOST, and USB_GADGET is not set, so the MTU3
mode choice already defaults to USB_MTU3_HOST.

-- 
Julien Stephan <jstephan@baylibre.com>
