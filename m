Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E78DC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37A488BA0;
	Fri,  2 Aug 2024 00:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEb2EQ78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F89788B5A; Fri,  2 Aug 2024 00:57:50 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC8288B78
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-260f863109cso4422814fac.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553067; x=1723157867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+wbbiR2DsqMcfwWVlzMARpIirB2s+fT0oUwDEJpfpY=;
 b=NEb2EQ787QYclwyDar6/+8/oF6M0aIM1ExZqB9AYuWpiwbxAqCCmmcuNnA979apBiq
 qAWSKkOpP05Ry6jODb/KxqICv1HufMVNja5dqjgpG4QG7FIoOAZdKaAVTfrBZbbJEaXD
 sx533c8Ocz2Eruhb8M0BXK3bVIPk5RgLnHwocYdHrd/Xop1r9nH/gg7gVzPwaVTzvuGc
 bH0BOQLGDHYYEXEsNXNzYTcoeDIFtf5oKmoPa4W94BA4hnKapkqySbFcZtmTW3K64pCh
 H2Fv4cLnmPo7BQPUnQq0WqwlZN4TZvSIbsiQXRiI1n3PsJuQ4eeHtMfdVTvXNSY2JUBW
 kNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553067; x=1723157867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+wbbiR2DsqMcfwWVlzMARpIirB2s+fT0oUwDEJpfpY=;
 b=BwwMJHSw/yGLDDWGIgjAerD4uqbPAIiS0bBTnHRMkQRxtbcDR8Wn5cJphpuvG5I2My
 c9VnA9F4tTuaxwjvp2q63e98A+/sc0Rn0LpsC2Uh00NwZx8BZi5NdTOR3dlfXHZOBZSm
 puYvNB/kD+Sa6vgppI4wc8FuTufTCQ/dcUemnvo2O+1cPuecKsejupZTVBtf+DcuYyBJ
 iglLydkx+S9DFnMNzkijl98nEJ8F0yTIms9SWFyM2z5/I12sy7ojzT21em1jQfdQBIhL
 fqhl3J8w7aqCROal2i2zJ28mWz4WKCBaIZEKhQCc3Jjf0l6+0UudxUdpD/dIz3VdKusC
 q8Bw==
X-Gm-Message-State: AOJu0YwUpQqHvlpOr2/9eovgNNIu6G9FvYFI+w86KR3td6q07wXU3SUQ
 rtOgzZPPgMhykHsOW+djEooXYarBh2AYYBPI0+RnpJRVOswBFKRPXqOOAg==
X-Google-Smtp-Source: AGHT+IEhilMXDGrQmrJM7TZ3J4afmDEW9MPCgZlA5dpFnMGqg7V5uDsnn0KHrabs4zX1pXOr6HPnig==
X-Received: by 2002:a05:6871:7825:b0:260:fc8c:2d28 with SMTP id
 586e51a60fabf-26891d6561emr1951969fac.22.1722553066624; 
 Thu, 01 Aug 2024 15:57:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:46 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 6/9] sunxi: H616: DRAM: Adjust size scan procedure
Date: Thu,  1 Aug 2024 17:55:16 -0500
Message-Id: <20240801225519.336667-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801225519.336667-1-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

It's safer to start scanning for columns first and then rows. Columns
reside on LSB address pins, which means that second configuration will
already have all needed row pins active.

This is also preparation for introducing DDR4 support, which need scan
for banks and bank groups too.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 31 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index aec561cc94..3075d9c80d 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1373,28 +1373,33 @@ static void mctl_auto_detect_rank_width(const struct dram_para *para,
 static void mctl_auto_detect_dram_size(const struct dram_para *para,
 				       struct dram_config *config)
 {
-	/* detect row address bits */
-	config->cols = 8;
-	config->rows = 18;
+	unsigned int shift;
+
+	/* max. config for columns, but not rows */
+	config->cols = 11;
+	config->rows = 13;
 	mctl_core_init(para, config);
 
-	for (config->rows = 13; config->rows < 18; config->rows++) {
-		/* 8 banks, 8 bit per byte and 16/32 bit width */
-		if (mctl_mem_matches((1 << (config->rows + config->cols +
-					    4 + config->bus_full_width))))
+	shift = config->bus_full_width + 1;
+
+	/* detect column address bits */
+	for (config->cols = 8; config->cols < 11; config->cols++) {
+		if (mctl_mem_matches(1ULL << (config->cols + shift)))
 			break;
 	}
+	debug("detected %u columns\n", config->cols);
 
-	/* detect column address bits */
-	config->cols = 11;
+	/* reconfigure to make sure that all active rows are accessible */
+	config->rows = 18;
 	mctl_core_init(para, config);
 
-	for (config->cols = 8; config->cols < 11; config->cols++) {
-		/* 8 bits per byte and 16/32 bit width */
-		if (mctl_mem_matches(1 << (config->cols + 1 +
-					   config->bus_full_width)))
+	/* detect row address bits */
+	shift = config->bus_full_width + 4 + config->cols;
+	for (config->rows = 13; config->rows < 18; config->rows++) {
+		if (mctl_mem_matches(1ULL << (config->rows + shift)))
 			break;
 	}
+	debug("detected %u rows\n", config->rows);
 }
 
 static unsigned long mctl_calc_size(const struct dram_config *config)
-- 
2.34.1

