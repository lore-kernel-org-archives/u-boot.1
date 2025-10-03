Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F932CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7185483919;
	Fri,  3 Oct 2025 22:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z+aTivjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C15183826; Fri,  3 Oct 2025 22:39:31 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8647B83900
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-42f5f2d237dso9270735ab.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523967; x=1760128767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=B34zbaIZWUXTNF7+CSyBUH3g2E3yZMuljQgRXo84m5M=;
 b=Z+aTivjIUtplkjr0tR5sjlPcBuclKI2Emhsiw8QlaW1pcvDZe2B/kC6kDKsaSIqZ11
 EbcEyhE5vpF5e6feYi+fSr006laCSW2QYWGXOdqQDbFSh4zqOh7QMd/uVixaQIG8T2lE
 qfTL0g0xUgra9sBezej01XG7zPofQ2NYmWq0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523967; x=1760128767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B34zbaIZWUXTNF7+CSyBUH3g2E3yZMuljQgRXo84m5M=;
 b=ZVtvuBw5OuV+t8UYtq+Wni94/r2MzWzBO+F4M0o48CnSsGmFFxPplxbByf5BaKTnaS
 9qHbPHHalvmHQiCeZtxyyPfsD9npjxNIYmGsg5m2cz1u527Z+hIduKD9CXxp7X+XIdwL
 MNn30K8EffIGLR2lH6z9TJauzUayniTOKVyV8RFQsPhS1r9jG4zmG9DfM1F54nwKH/YP
 Zl2j2sWWacwDSb3h93/K8IBB9sBwTsV3fvy0l4leyvLQvPNyAMFi9weRsCaaJyt45ZFI
 5byyV4TkHRskxpPbgIvctRXTl9XAXW3Z0Dbm4ALlDcb/k9jtgKAJeIx2pkp0ZjdTKWad
 F28w==
X-Gm-Message-State: AOJu0Yzh9dXbEuxlLe/rObE5Sf4WYDXEzUUttOIf3EIJ4oI5t/gyD9zW
 MtBNPN+St6xfgC9abXR4vwWADvAEu9STas/45nzXcm87G7FV/31ivo8kHmMYDJIJ/G7vnhQGOzN
 aiTMJRco=
X-Gm-Gg: ASbGncsEGbo/hLTda10yi8h5tp7XkivCtw9E3MsX0WJMuYNjlX1eFwh6tuqqPW0XhJ7
 urxM3RpAysK9mtLRFCiiKRSCOQM6FGRYkMJpXaowXrf4siAt7/n0aIDbexEUV2WP/hRuh9RD//M
 ovu0XgLSzySVbUfmbqyTVF16NsE2K5lu8MQXQLUAOKdxxhMWdgFhpdr+hxMtcHev7jNJzbKyHcw
 Gxb131YlMk4ozAmCKRjM1apy++gJglCCUoZ8pV77+675lrEh/W12qgbYbPONigZCAll3Ri+enxC
 UiO6JBVOFMp79L2WwxkTLEpMwwNUGyejSzYK8BV01GG4PLqU+OBeboHurR5Q9fhFL8iZLRUI/vM
 NUK+vqrAmPPOlpaj/qaSTcK1rLeDa25SvV/zDKmZ6rKAPXvAgY1IoJpSl79pj0UgA92GNZ48HlL
 hvcai5xvO+KXE+
X-Google-Smtp-Source: AGHT+IGLUmHZpcommkShiDKMnB1V7DEMHOq8QpiWm+SHQpxcuc4hQYjAoL8X7t2gS+d6oNmEPc1Puw==
X-Received: by 2002:a05:6e02:1989:b0:42e:72b5:f900 with SMTP id
 e9e14a558f8ab-42e7ac36ef1mr58136455ab.0.1759523967302; 
 Fri, 03 Oct 2025 13:39:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc86f1sm2301266173.44.2025.10.03.13.39.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mmc: cv1800b_sdhci: Fix possible warning with
 MMC_SUPPORTS_TUNING=n
Date: Fri,  3 Oct 2025 14:39:25 -0600
Message-ID: <20251003203925.1030037-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The function cv1800b_set_tap_delay is only called by
cv1800b_execute_tuning. The latter is where we currently have the #if
guard around MMC_SUPPORTS_TUNING, and so with the option disabled we
have an unused function warning. Move the guard to cover both functions.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mmc/cv1800b_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index 377e6a887df5..036e798f3741 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -19,6 +19,7 @@ struct cv1800b_sdhci_plat {
 	struct mmc mmc;
 };
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static void cv1800b_set_tap_delay(struct sdhci_host *host, u16 tap)
 {
 	sdhci_writel(host, PHY_TX_SRC_INVERT | tap << 16, SDHCI_PHY_TX_RX_DLY);
@@ -31,7 +32,6 @@ static void cv1800b_sdhci_reset(struct sdhci_host *host, u8 mask)
 		udelay(10);
 }
 
-#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 {
 	struct sdhci_host *host = dev_get_priv(mmc->dev);
-- 
2.43.0

