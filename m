Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E3CEFD03
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BECC83FC1;
	Tue,  6 Jan 2026 21:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jeMHsP3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A1D83FDE; Tue,  6 Jan 2026 21:16:20 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5483D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c95936e43cso562700a34.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767730576; x=1768335376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv7DR3RCv4oJMfjaO2cEsArux5VeN/JpyS8Mpo8jQGg=;
 b=jeMHsP3JeCoXp7j3a/RONo54ffRGTABO4Ys5PiBv13JeW7nevkLoEdRl0s95dexhEu
 vi674PSp/HVvIaYJmAqwOzmwqHil8AOrCzO00KmgjBp7D9MGDPA1UHgml5AuoZx5J+FA
 CyZPxKrj6NH91NBpEPuKglwLYnDUqhUZ0+Ylw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767730576; x=1768335376;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yv7DR3RCv4oJMfjaO2cEsArux5VeN/JpyS8Mpo8jQGg=;
 b=gjzeb0nEt2rdRtC+45AwYT1W4yXAl3eyENhe4DGcF+exRHn2pLTbAoLlZVcLbZNLC/
 Bw1t6TmEHyL3AyPRJQzS4VMvm6DvilQ42D+6TCSP2Jb4oHhLwgbQEnjqEWM20DaOw5tr
 zsvugyQEisbHCz8i3v6k17K1NGfYXHXz+iunIQbN+fVko2DWgFQQoe+58hOrBW0jSYWi
 bIPlC3Yasar+b4YT4omStTjNok0pC4Xwp+RnYOR9agLuNgLofw3QhRJ+slLEckZM/RK5
 nmOJfOdA7xTyT5XKX6uH6GbpNISnuu2V/jHRDJYQ5R1EwdF5a7s/Q/DraoMW8nzQtWDa
 KTLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYJCuVN/me7A4rKxR50y4eM+8Y5jmABpM8LACVoxVGsF3bSCiIHqVu4UzHoCjLEl06cQbeFFc=@lists.denx.de
X-Gm-Message-State: AOJu0YxITzfyDaZch96mDsLRbGnplKUN78NiAX5e3hJmgZPREf2y0lty
 I+uxEieyLdqlU1s1+kxQ6q54yE/vvLzJ3KsPL8+fVyVGsINjZIGJBbDR0gOYd1JHqk0=
X-Gm-Gg: AY/fxX7vhqqDGnP8m53V8cr00oaIJfOG8jt6ZjrNsahvrPfmOh24YHVS8NWCGx8TLNk
 UJRoFHxrIWu+tm0FocevlHaxQOFp3I32EWBqBn49VD8o3jWJGMbEJEU0JjuUZ+xHLT3J7VISuFk
 phZTImFOZS4UtUvUDjpdAwFy95M+CSWmK6XZ+DAMCdzk4AOlgbbtrI9Y0Pl1NTlIjG0a3gbVQTL
 1Q1JILhwmnbLRBiEnrBVr7YrP8IyRwxDxT3F9B0E2PQ3PQ8b+MVnzOLLQaq6cp9Zk8xScltsbuz
 GUuNiyfZ5wwH7JFCMgkHl6Ej6+Ff58GV1dkbwqvtcY4IUFQh750WoGluncXn14J0ugD0NQHVnrG
 IIuxNxNVHhlZq+L0dEdRvYdQ2Eh1JWbjkXmQfxj9KvcJU1Sfd1hnpz+uoAxUHmXdKP+Nwzwhcqf
 G7xPy7riwC/m04tAdg8I1UkTrSgvNMmjfEeADl4354HCMTq9pmpBIrhf5G0xZyvyGnS7faMCuax
 FLwAyoIg8rtF5GEehD8Vx+ABGbJwvmkqNo1IOS0XijtpXWw
X-Google-Smtp-Source: AGHT+IH9cM2WJE1aSuF/Tw+7tv4qc7LFARCAmSCkkJ64VaFL36ctyfE1z4E0LVcmZK6URKnt8nzTTQ==
X-Received: by 2002:a05:6830:4ac5:b0:7c7:53bc:54ac with SMTP id
 46e09a7af769-7ce509186c9mr224067a34.13.1767730576391; 
 Tue, 06 Jan 2026 12:16:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1962355a34.16.2026.01.06.12.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:16:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Jerome Forissier <jerome@forissier.org>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
Subject: Re: [PATCH v2 0/2] Add support for MT8188
Message-Id: <176773057436.3765597.4508727327020479325.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 14:16:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 09 Dec 2025 11:22:23 +0100, Julien Stephan wrote:

> The MediaTek MT8188 is a ARM64-based SoC with a dual-core Cortex-A78
> cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
> USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
> several LPDDR3 and LPDDR4 options.
> 
> This series adds basic support for MT8188.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arm: mediatek: add support for MediaTek MT8188 SoC
      commit: 633e5602aa38df43420ced7ca324ab0a0ddfd726
[2/2] clk: mediatek: add MT8188 clock driver
      commit: 11f3cc46322a5d759b91a598aa89927ed7d6ad4e
-- 
Tom


