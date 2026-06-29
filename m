Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9DCC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621E884A92;
	Mon, 29 Jun 2026 21:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZW1rAZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC9684AB5; Mon, 29 Jun 2026 21:23:51 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F3A849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2117475f8f.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782761027; x=1783365827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6H96OXDY/59nduyKiBxDlmzxLCEwrBE6xgjbuMxR3wg=;
 b=KZW1rAZHpAReO0mVPd7vW+OME8/9UbyRc4uGoS1QHqSzd9CJMlLfLbFpBI6jqEzKqo
 s//UqKD+1N6byQAEpFj1m47FNePBZB4UDVi6enV7SawnsxI3cxCNn3dny4uuWUU36sSi
 ZXZM6ag75TMVbcR/pjaREyRrlH3PnZ82SPF9gFjdhbrMHz63+oXr3YC/9oADWZ/itwO2
 S1MeNQL2qANHS54MhAo7KPfDRhKszWbAXSyA+nIInguKdFTkxUDLiJNX3eiN26bd32z7
 yutnJvaiYmUZstsFcmw9NNffVjTsfLNmnLYEyK9O/tg42SPt5N/dfK+L8w0yKcsCJqx/
 wEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782761027; x=1783365827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6H96OXDY/59nduyKiBxDlmzxLCEwrBE6xgjbuMxR3wg=;
 b=KtjCGPvXVQp2xlFBSI593/2ZSxVViSPnzFzqnA0+Z4qfh6EGjHgIelzg+rcb7H7VoL
 sqCuPTB1OW8DXgfduu/rYiDyLGLCkwKwfa7rakzCYRCt9lMOsJuXmztv0gQ1DvUZN6PR
 vLsBqV4ARxU0IYup/segpPtRFC3vaEYIBF1xu+dIwL6TL3RbiuelO04ytvjw7eukyuzg
 OlekyaIFEETi1kCVcVdSM0AbMOT/AEjq+5B6wYES9FL4oQqxplnnNKWj+j9eLzHbVl5K
 ThupwbdRZV0JEUXhZQKSIUoxFKgVuZjVpyilf8aDnlZ5QF8mKAUrdekASz4oe68vJnPc
 xkgw==
X-Gm-Message-State: AOJu0Yx8O+zjMrWTa9QD3J040aIFHOKomh5LzaKWDwHXTTwbsP1/0II4
 8qKQQigHFHnEE+S9l+3yZ4g5aP3QCEP1gBFfhmMYWtSL+JLz/WRmXt91eNVWLR0X
X-Gm-Gg: AfdE7ckoK1+Yt0iin7ubRZKbM1N8XkBljH6ou0DHmQw6aGvZHm3CWTreADtdNWPHEkp
 nTHwnI/4KjHkCItC21krzscq355pmy1mwMpvzq0Nd5EcNce8HGNVBDB1mH4fZ56gbiGF82KfB21
 ESBXKsyfmu58dLBmhpIwQjIyMtvMmc6UxFlpB1ab2uMoJvDt4C1WXo5hG87n9sMo4YxV3g47JMn
 ASqKzIJjYqcG7AR8DFHLJbdQhzIetIm2z89RWnaqZKFmsgHULN42EyV4n4zxgLvXv6D6h7xqwhu
 8BfoIVyg9RfvG8RO3dAS/RHBEDRhbHKxaZ5HviT8xtfFG8JHkWkYjegWuiLRH6RJ+FykaADkp0d
 q3l5m2R/Ygk/AgBHMQHDoMihwigshm6N2l1fYFW+ePqSBGDIs++41tt2/UilAqzhD10UGENWBU4
 0ckfK9cALh6fcci+b8eQr0/MfpDJtGN36iY2gMizcYYfWSn9rbFnOF4KcS+7tbSlg=
X-Received: by 2002:a05:600c:3e8d:b0:492:454c:347c with SMTP id
 5b1f17b1804b1-493b827f59fmr15155145e9.7.1782761027178; 
 Mon, 29 Jun 2026 12:23:47 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8b1csm8734785e9.9.2026.06.29.12.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:23:46 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v4 3/4] rockchip: rk3568: imply DESIGNWARE_WATCHDOG
Date: Mon, 29 Jun 2026 21:23:35 +0200
Message-ID: <20260629192336.1555651-4-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
References: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The rk3566/rk3568 has a DesignWare watchdog, so make its driver the
default for the SoC family The imply only takes effect once a board
enables CONFIG_WDT, so it does not change any existing board.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e..950c282fbf7 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -426,6 +426,7 @@ config ROCKCHIP_RK3568
 	select DM_REGULATOR_FIXED
 	select DM_RESET
 	imply BOOTSTD_FULL
+	imply DESIGNWARE_WATCHDOG
 	imply DM_RNG
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
-- 
2.53.0

