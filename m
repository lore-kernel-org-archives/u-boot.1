Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6744DC52D6F
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC34B88D59;
	Tue, 20 Aug 2024 02:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LHnPfebz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F85088D43; Tue, 20 Aug 2024 02:29:46 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7469588D4F
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3dc16d00ba6so2989021b6e.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113783; x=1724718583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CKdQxubC3OGLjoPDLLXCbH1PZV0noK7zcvIvdvwP6yg=;
 b=LHnPfebzLg4hrAGBuf4GDEiX6ZrlmHoeOivrc2/zrHDymrbeEKaWv78cE5IZRR5L2S
 wHoNoGWdGUWH+F474I9Wc/tBV3dtqcfZBovYeSUAu5m+g9XETlw/rBDL6VGSbAd3ad7C
 CpuQGrfameeJKWfayNNIEY9RKo/JviSWlPVb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113783; x=1724718583;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKdQxubC3OGLjoPDLLXCbH1PZV0noK7zcvIvdvwP6yg=;
 b=Kh8HCLFbMTpIJIdrCxbsp6hEb6Udd5xkgbPryLxL64yfECBaPl2mZFE2zHiBgOCpkc
 1BaHFexe3aKdv+LtQrJ378pv6ks8xFvJX9zvwzYf9YJ8BICDkO4QX2tO+oCAVV9OXnRR
 dAGLLCcBSDRAKovQUED7AOW+fEQNLcMaolGGau+qvBqU3ojyvhDAF14HNrf8CzIJacmS
 4AomBY5Acagk0i4/9yfBOuYNnXZMWVp63gEAscOgtyqj+6MCqEuoIHwXLTvrowZET/8s
 L78b+q0TXP1lnFtsuxhiwjgD1+lj+3lFvPFGcTEXy6QUv/LZezJyxm1oyKlkTyn0ie+0
 tfRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZRAAXFpxHl8gJOxke8fKhTGvE1q6+DJInuM8ZZlJOcv7WQUmaatpL6huqzGObY93QBrnPZc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+gPh/cQjWa7BxjHzwOqomnDOHMbRMeetD6yWn9CwAMBFs1Vw5
 jOhNo8cG90VTHH3XmenMxj6W0nScSnlaOHCvJj1Em9hC7POpYLjU6GWsZx0hnOw=
X-Google-Smtp-Source: AGHT+IGb78KIzK3AOMoiEDN7nlak75BForHuWU0AN0A7G3mbPV7eJFTZ+VGJi6gvKSgKN1yu39GXNA==
X-Received: by 2002:a05:6870:d8c6:b0:260:ffaf:8126 with SMTP id
 586e51a60fabf-2701c345f24mr14029675fac.9.1724113783164; 
 Mon, 19 Aug 2024 17:29:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a6208sm3319572fac.27.2024.08.19.17.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:29:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Crispin John <john@phrozen.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 00/14] clk: mediatek: mt7981: clk migration for OF_UPSTREAM
Message-Id: <172411378201.165406.15697655279217840534.b4-ty@konsulko.com>
Date: Mon, 19 Aug 2024 18:29:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 02 Aug 2024 15:53:01 +0200, Christian Marangi wrote:

> These are all the required patches to migrate clk and correctly support
> OF_UPSTREAM. This will align the clk index to upstream to support the same
> clk implementation with downstream and upstream DTS.
> 
> Christian Marangi (14):
>   clk: mediatek: mt7981: add missing clock for infra_ipcie_pipe
>   clk: mediatek: mt7981: fix typo for infra_i2c0_ck
>   clk: mediatek: mt7981: fix wrong mux width for pwm2 and pwm1 clock
>   clk: mediatek: mt7981: fix wrong clock definition for spi2
>   clk: mediatek: mt7981: add missing clock for spi1 node
>   clk: mediatek: mt7981: swap wrong clock-names for spi nodes
>   clk: mediatek: mt7981: fix wrong parent for TOP_FAUD clock
>   clk: mediatek: mt7981: fix wrong parent list for INFRA_PWM1_SEL mux
>   clk: mediatek: mt7981: implement sgmii0/1 clock
>   clk: mediatek: mt7981: drop 1/1 spurious factor
>   clk: mediatek: mt7981: replace infracfg ID with upstream linux
>   clk: mediatek: mt7981: fix support for pwm3 clock
>   clk: mediatek: mt7981: convert to unified infracfg gates + muxes
>   clk: mediatek: mt7981: rename CK to CLK
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


