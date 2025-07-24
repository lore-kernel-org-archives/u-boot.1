Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285DEC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 15:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2158283612;
	Thu, 24 Jul 2025 17:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VHY8Z1wC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0278483894; Thu, 24 Jul 2025 17:19:28 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFA680C59
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 17:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so19035095e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753370365; x=1753975165; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZVJOSIiDHxxHy8YIdXkcsn7hB7v21/JQ/L2kih9aWQ=;
 b=VHY8Z1wCIwBTVYWqx1cX1uTxT+gnxbFOiwIRi6kdBTSojinbwueHFNxDwtlN3U6bNY
 edp7+FeQ6nHVwuA6e1zHW08Af4LmA6aulJyL9L9F+VPhN7KmJJxniX3GXHvmKYeR2IFd
 uqrsULfLQ+Ny5BJI62TLfDIvSfiMBtVrntmFwGlQCPlRhPPsk30TIuoJghJDx8kJn2kv
 4meEIbdwj4TxmlJ5sWBGS9oKtnKC8g/aRRDt9Ymd78VS0VzJrverl7jHVl9r0aPCi7nF
 Hbv8ro2vLyR8CO5yX+iJJw5V0P7xz12P/kVCAbJfjmkqsmNIY2gAqO+9BbiwCzpYyLIA
 rJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753370365; x=1753975165;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZVJOSIiDHxxHy8YIdXkcsn7hB7v21/JQ/L2kih9aWQ=;
 b=bak9K+eQ/klsujAc6PEMYfdN7uw7gIkp882LPT/gf753J6dDC65V5BS95X8XwcbwL/
 aY1BVW7qIChy83vHgEHs7+iuwz7g1sNJqyeJXGWeNG/Kx0Ck+4C7IwjiS+pZypk+Eud4
 HYN88mSWnLG4Pta8WovQpo8iyTFGOMTrvdqmSbIxevRX/4ty0Udq2kurtPBzpqJOh284
 2nNbvF2TvgP8Jce/SY2DsNNvogS83dNG3/+JzhDu9uPhpsBrBYEOfkuCVCgs0TOwy5Ee
 vNQHjYg4aOCogJSZ7W7uYmOI5rJht0XPCP0mYDzOoT/UgPNVGOZdxS1p46X/YTVD5mVH
 D6Gg==
X-Gm-Message-State: AOJu0YzxklHSB4h0AdVJ0rp55RJC3/XIZUcdqijRNDrf7Q3EragdrKZF
 1WpoxsjcBIZyD3k1XmOhTdZxs+kPTq7a8YfmI83M7Z/JZ/wAYUl6c8GPiU0OuFkPbTQ=
X-Gm-Gg: ASbGncthX+p8cWLmCmQH78JMNpIvG5eBzilhuV5JSFPJ0UJp3QmTFX2nwDN5QW6VSKA
 P7bAkvS4PWvtSMj1VE9RtN4wbGAHkyD8Woo0fs1LM+za2UrfBNyyT9XEv9LYy0z6wxlsdInBHrN
 V/jBH/4f57ceGOzJtX0pWVz6yN7zxel/d8zm8MqJk4HpXrv0jiwOcgSx9RAHPFyPa1ycXuXPol/
 uMoa1lH6dbRnfq2BGXmmUo42m7KC5yyRVbb+h8hfcCugb6wyKvX5NAYBfPza0OtPVUS2nODqrZz
 ekKQsRqe2K6H/TvaNBogVSrEZm+Dk5M1MeLWMMI3ncaX2xEoWFCrWIwZGaObLaM0o9zFlNqGDLj
 V5A56R+U8eMAKyFQZZaz1xe48AH/xKXKsEWZgl80MDJ4KtGf3U8k=
X-Google-Smtp-Source: AGHT+IEOx9e8peR5EbReghSCwrNDm4Sr7AxfedTfakom9pM1vzCAw+dfJKteWSfNAcGDweYdYDYKwA==
X-Received: by 2002:a05:600c:4f87:b0:456:1a79:49a0 with SMTP id
 5b1f17b1804b1-45870547e37mr27134885e9.8.1753370365155; 
 Thu, 24 Jul 2025 08:19:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc77259sm2417823f8f.33.2025.07.24.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 08:19:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 24 Jul 2025 16:19:24 +0100
Subject: [PATCH] ddr: altera: n5x: size_t cannot be less than 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-sdram_n5x-v1-1-239cea915813@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPtOgmgC/x2NQQqDQAxFryJZd0AzlYJXKVIyJtYsHEsiIoh3d
 +zy8d/nHeBiKg5ddYDJpq5LLtA8Khgmyl8JyoUBa2zrFz6Ds9H8ye0eIjLGMXHDRFD8RC4hGeV
 huh8z+Sp2Dz+TUfd/5N2f5wUIXPgydAAAAA==
To: Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The function socfpga_get_handoff_size returns an int so make the struct
fields used to accept the return value also an int so that testing for
less than 0 is then valid.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ddr/altera/sdram_n5x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index d1fc93b6bdd..17ec6afa82b 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -346,25 +346,25 @@ struct ddr_handoff {
 	phys_addr_t cntlr_base;
 	size_t cntlr_total_length;
 	enum ddr_type cntlr_t;
-	size_t cntlr_handoff_length;
+	int cntlr_handoff_length;
 
 	/* Second controller attributes*/
 	phys_addr_t cntlr2_handoff_base;
 	phys_addr_t cntlr2_base;
 	size_t cntlr2_total_length;
 	enum ddr_type cntlr2_t;
-	size_t cntlr2_handoff_length;
+	int cntlr2_handoff_length;
 
 	/* PHY attributes */
 	phys_addr_t phy_handoff_base;
 	phys_addr_t phy_base;
 	size_t phy_total_length;
-	size_t phy_handoff_length;
+	int phy_handoff_length;
 
 	/* PHY engine attributes */
 	phys_addr_t phy_engine_handoff_base;
 	size_t phy_engine_total_length;
-	size_t phy_engine_handoff_length;
+	int phy_engine_handoff_length;
 
 	/* Calibration attributes */
 	phys_addr_t train_imem_base;

---
base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
change-id: 20250724-sdram_n5x-32d23fbd1daa

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

