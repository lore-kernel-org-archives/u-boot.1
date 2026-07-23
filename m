Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5D4C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 17:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4863C60AB2;
	Thu, 23 Jul 2026 17:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7MFzuyyw_u7; Thu, 23 Jul 2026 17:37:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76FAD60AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784828250;
	bh=6H96OXDY/59nduyKiBxDlmzxLCEwrBE6xgjbuMxR3wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTXEfIA0lWvHQIJWJ1a/+7wuQ8eUME8b5PcFarGRiKQK4QgW0ykgENIEIgSU3iQhI
	 FaFh8Bw7TcX9PVQwh0kUbEN5RbM2A84RW7w/0fCpfURgcXxZpsMnLWD7vbpYX2uiYU
	 rRrApbE7aP2gMspuTneFC1MHhm0qEMqKKTLbtFNIFy+ac7Ky9MkNVLsYdkFf97e/84
	 I5ST1obAPf5W0s8rBVA8nIpvP6Du/1mh/HcCoZ4HLfJuDbmR3rL6+NzDH9j2ifDd/0
	 HjG3C1CeC842XPlYg3jP5wbXg0b+POgyJW64EcgVDRyHFR2pu7ZUfdzN46dxRL7GZx
	 vJ3Qa3e5qO/Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76FAD60AD2;
	Thu, 23 Jul 2026 17:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C15CD42A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D53481101
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WZWWpoHtSTA for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 17:37:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=andreas.zdziarstek@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A2F54810FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2F54810FF
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2F54810FF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:17 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so7153745e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828235; x=1785433035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6H96OXDY/59nduyKiBxDlmzxLCEwrBE6xgjbuMxR3wg=;
 b=P/AhUghempugWA5NjeUskDUFy2rdcyOesHoncsgGbrYVE+yOXVbRWB0bAS+tfJOBd9
 ClJT6LP2dkmyG/q6FakewvgxAJB7Pv/k2zYJI7dKuEWULeA0UHvPaiIB9ty2dqeMjVN2
 /IVjckzKJePMKBpfCQ+gTVGQ8SkjhkqIGuxLrWutYiWWGQKciFJxmIEezrgxM5/1RNju
 /Zp7vZdtNh8o0kHFl3x4ufx4jRMgzNcH901D+HLjaiHXyNlBEOihh+x5rEJFtkO7JcSM
 NBVXCaHR2df5ujRf/oMo0pvW93sJwSeBsFSmKU21TBq/PsDuoY6YLJKPpjHt0ra9FdXa
 CUvQ==
X-Gm-Message-State: AOJu0Yyy+JiEBl3E9/whMkI60Uv2rCTX9U9CxNMCWO+wkHgADcRTNDcM
 4xe+tTtSt3rFmIb0gfIkdx1TVbeOsXTt02/QcAjzawmCjr0LKasLOsiYnkFtdDWf
X-Gm-Gg: AR+sD12cSBphVNrFGlPK/qpH8LnGg1TxWPUXcCx0/Ji+PRcbrl4+XzH9onqotbPo1XX
 ZcNbQT4wmSydoHqU5rHmJW3+vliExwpyE/hIOYoUu8jGgqbhvISJ2+BzrkiHuaMxpJl9DiAQ7CZ
 XbeJwqVtHIhwP4hkA7YrMXywaRPomDv8zMjqeq4uof9wr8BHVwTcSJzLx8x7MdKwMeope5CQULL
 DY9/Lm6ieLKRGFJyV5fgLsgSO2uEW4IcKmCLv+y1fGvIdbyd/lfyNCSqihhTmIvxJJo/G02PKHj
 EXHgaxNUuWLnhU120AEGc3OuoqU5ATzCpr3mG+Vl6LWeTviF3RsjvhjGW68ptRgvkUbpP+dK1Yf
 TyYugEUo4kphPVQKMUHz4DpPx6In0SB/nrismnnAXfQmAG4Mu73KykWauLK/gGb2wiDZXUztpzm
 keUzRuoHBH+lMrBs0NyaAuk1NaMReAmdYNc98/HfmOwv2wCG4NWwHA
X-Received: by 2002:a05:600c:8b35:b0:493:f6c1:2f09 with SMTP id
 5b1f17b1804b1-49573cc2b80mr38136275e9.6.1784828235121; 
 Thu, 23 Jul 2026 10:37:15 -0700 (PDT)
Received: from turbine.fritz.box (p5787a491.dip0.t-ipconnect.de.
 [87.135.164.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af914a9sm8497645e9.15.2026.07.23.10.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:37:14 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v5 3/4] rockchip: rk3568: imply DESIGNWARE_WATCHDOG
Date: Thu, 23 Jul 2026 19:36:43 +0200
Message-ID: <20260723173644.234688-4-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
References: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828235; x=1785433035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6H96OXDY/59nduyKiBxDlmzxLCEwrBE6xgjbuMxR3wg=;
 b=GWj5v6kcquWQsPGGDY7tUADxOQ48bRNDm95s9czWlxzBgTXNMMXUy1XxSSbLNMqUlx
 P/gsK73FKYAi0OZX0/6n5xfVqfLE7V7rIAjtw1pA4LIeQfyTlwfmacncpb4hKNlFCA7F
 Q2/+AF+eslpFkr0nP+lw3p6dQBDq/z7Xg3ebSqavy0dNlerEeQeEawZL8ejCXLTe82DF
 oHltENBjalNow8DQOj25ccYDxEp10LLQWGFSMuHBssltlzJ/couPK+9fM/F5bIPzFnT9
 csQ2RtguRkIcPByN5WxyYqwIS381L71tZOCVdKLrBNugwUuq1YBOxpIsZy2AWegADdOh
 04Xg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GWj5v6kc
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

