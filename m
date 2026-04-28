Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1774FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A000846C6;
	Tue, 28 Apr 2026 20:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="AbFtcmsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4376884692; Tue, 28 Apr 2026 20:21:22 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F390846C6
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4756e74f8edso8189577b6e.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777400478; x=1778005278;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MXCE/iIPNSxOv+kt/V51Y8CggbPVH2B5rc7LCk04dw=;
 b=AbFtcmsKWpirJjAS2GwXZVHIzSpQyv+3zb5ZxAIav43LT3TEWPU6dOo6itxBm0cxDk
 KP6K9AiCiXmwjXDZ7HhnYKINtXAunVT4HRrmwBE1ZWxRRdliwXH8EBLMME3xK/6eIuJS
 hsS4hqvdsPVyacdo6Eeyv4XOC3vFaBPq/+6L/z6dY2ZJMJW3p/SE+dKIPzXQ4HSaHev0
 V2pWWXFycdGzAJKBTEW/u0ZbRSH4cGW9t1aQJ4wo64Hse1pVkqC1fUmjPKShRwYxHwhe
 v2i2YzTWjqYXIAd9EPAcVbFibfB9DHP+yOrPvopp99NPKVmobo4EyDm2APMGrx0jSMnj
 S6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400478; x=1778005278;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8MXCE/iIPNSxOv+kt/V51Y8CggbPVH2B5rc7LCk04dw=;
 b=JSEZQ0ALGLKnNEpipIw9aursUG/Kw5W9dV4/iP9vDt6VG5ukxwwPZxpjtIsJiae+Vu
 hAE+Up5sMfjVE6MnXGG6Ec5WKaH2tYlroH882I3gsosX4C0c6KdCjaA1SCr/7OEqXzqF
 QLk1StGVst/jOKAsurCEmCA/sq7AfuOMD3DOxCZOrBZ5zUrobbMJRyiOTFSyogqJBS2Y
 Ajk1KzeCZOzrxKqaTCqjks/LuQIAYH2jucWR6KM9e4iGmTKQ7UzKF46BkwV6aUccFb0S
 UsGwFX5R4Mfw6kZqjuD0ZeGS0xOHR/8uEoBqZnwiC3g4pFWe1gjSL0lkqo3EW6mQv0Sh
 mKcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lsCOYDxcmhhhxTuvV7FbG9OSy5+q2y9we6ulTdzFKXvbnfkQvrM+l/6xWk3bWtws/MBV7du4=@lists.denx.de
X-Gm-Message-State: AOJu0YyFhcxrp3J8hWHeSnAP3BNc5tXZ4a/k54M5KwlXk6VMYoLsn4bE
 cGAHofrKa0+7FFWE+LKFUXkY1vHgmPbl64VVlr3KBpdXpvL/QxcxCCI4bXGKuxk68BI=
X-Gm-Gg: AeBDieuDICPcSQtpy279JkmhuWdmS5jKEF5ypHVct4dv9YOkutvY9cjFVEj+ipy8iAG
 CM9rUA4LewmKnU8/K90WzkF89YeTHa6pZ5aFI9+szYmtvEmMapsZv+NlKg+qx5WuAii+/wNr4Xs
 SbXCkDdr0Eco2cz5OsAWF9+hEkvLLZ3grZjWpD/H0yhFMDJrxHFP1vR9knV7LVvbaeUassX3YhZ
 2P+WzjmSxbOzuQY5EYDf3FQMkO9tZYz8A8QL2Wh++y1yK+A/Ggej/8GrlHEwCpkhZBcvHMMV96U
 Xd3kZqff15XbPzOY0TyIlavWMkgT3TCayZo02ZrfsnU6sT1VLYFz1pGbh0VMdGeFxI0MfXvjI3K
 1J3xUQtFGfB0eLshkls3snXBStAm0nll5voMZ1ktc+JAQn0rPm0aB4bF/Jn4Lrw7pf13CY5jvDc
 e5gZBz9FGw+kYfi0RaJKuQGLGo0lG22Aq5himv/oDJLruXLuvqYg==
X-Received: by 2002:a05:6808:2216:b0:479:da60:7dd4 with SMTP id
 5614622812f47-47c3db2b543mr316807b6e.30.1777400478038; 
 Tue, 28 Apr 2026 11:21:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de984bdde3sm2331173a34.2.2026.04.28.11.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:21:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
References: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
Subject: Re: [PATCH 0/2] arm: mediatek: enable SNOR on Genio 520/720 EVK
Message-Id: <177740046658.3382222.457526816346541368.b4-ty@b4>
Date: Tue, 28 Apr 2026 13:21:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=MSaSFDt52C4IKyHCBGSCPIKoXRYL9NNKXJ4iWuF608Y=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp8PqV6dDMCTZzeDUv2lIPRmAdM5vTk/qyICR/3
 EhodbrHH52JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafD6lRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADaMH/jWqQtLQBYxeT59mNLF0OxyR65FtwYFMBWxitWb
 X8XDxyub3TSguuCKLElRokND5QHBc4svVRYIn86oBrjQCeCKbcoBqwiZH6WVLs9sZwIpmV1bSvP
 cjDVD8F8pVStgrcdI6uFVp7C0ilSePEPQ1r2zSN8P3oRKjCQJZw5cGVIRloxzAyJevilqYpyGc6
 k35LN2ICKYpf7kQk34q4Dz4eEwnOXmU8/LgviSmSOqjErBrTm03hMD8mIEA4pFsYphGCikTYI6A
 ArmvCTS3mFgWKz2/eXcDBc+RaHEQZlpX5FekTbbNCBeUCSlS89pmNGTuy+YKOmfu8NWN1TtPMr8
 F3Ck=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 06 Apr 2026 15:37:08 -0500, David Lechner wrote:
> arm: mediatek: enable SNOR on Genio 520/720 EVK
> 
> Add required devicetree nodes and configuration options to enable SNOR
> on Genio 520 and 720 EVKs.
> 
> For now, the common config for these boards is in the mt8189.config
> file since there aren't any other boards using it. If more boards are
> added in the future, we may want to split some of that out. I think it
> is better to wait to do that though so it is more clear what is common
> and what is not.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/2] arm: dts: mediatek: add Genio 520/720 SNOR support
      commit: f1b077c512b566a3a7bf1cf89ecb1ff49791ebd1
[2/2] configs: mediatek: add required config for SNOR on Genio 520/720 EVK
      commit: 8c15436fb2191294162deaf2c94fbe030fee9455

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

