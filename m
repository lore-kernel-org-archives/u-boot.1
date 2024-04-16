Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D99C04FF9
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABC488421;
	Tue, 16 Apr 2024 14:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROUaj5jF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A621882AC; Tue, 16 Apr 2024 09:31:49 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551C9882C4
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so3197849b3a.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713252705; x=1713857505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CpSs/r3TQRB8nxirByyoh41K83sFtyR4AK4PynULv1Q=;
 b=ROUaj5jF7vMJrK3309CPmuVg3iAdQpUc8bROGIdI8lumDHXaLFq93ZCEaVybsPrvFB
 Ix/xpeLA2FTdy+4VhdK50YBHPDoF8p/v3Qz8e9juJRcSB99s8RLmQQEFXfC6dORJYV+g
 CsI4//drMhJh+L0N1m+f+HxaBRT3yFfd5SsqpXHwbyEWGWKDQOvtXV5VvFIa/kMMO7sb
 dYzb8V9bVlnksxJomo+iuLmImOjeK3kZ+XvPDwXEd0yKR2HhoyL7jdbFB3FADYKjZon6
 MHQcHXwMGRjL6b4g9G7yIY7HngbxXAwIuDUkYTl0QI3ijrTEF+H5UPHTr2LeR5cmRQvP
 02MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713252705; x=1713857505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpSs/r3TQRB8nxirByyoh41K83sFtyR4AK4PynULv1Q=;
 b=qL1ga8MAqQjFaozYLZaap3wdE8Rdtyly0OlRwQ9ObLoG6VU7PeRmBR4OJEw+9Y19X1
 Eqczh53P68sMgh7jXHcCUmleGwYQOMqh5ZHuTjM18dmBvSLN5xrMSx6NpPZ3mXWeoFuC
 pGpxd/RiyTUDq3Hep9snskJ7odGP9/gppF+uK28k+Mval02sBodkrHy8ae1XE4/MKC7G
 bTeR5Ul6h+tVs4OKEowF38iwT9VBixUNfRPkOwQsHQZOv3ZT6t5PC2I2Y1TlPegK7ZEF
 09HVLn4hh6XHJu+0g4sHGzZg8bCIefGd1EW9X1euE/FNW02yt5YNOpkPHAHQM0BynM3v
 psxA==
X-Gm-Message-State: AOJu0YyO6IXNN3O0klbLTQB3eiYDeK7RIYcdGY9J/VzcxlGV3jwRSl75
 WDWL5ZZG7h8/vDjmWfHcsKfuoclz3sc9oZMjH4lGmhlSjT9MnrvJXiYyIm1xRio=
X-Google-Smtp-Source: AGHT+IGAM3xqujt1kpmRuUewlE6Vtdekx+GhXqNPWXV9+fXSBiZmIdoqXQ9ST0GWGwSkHMHLold17w==
X-Received: by 2002:a05:6a00:acc:b0:6ed:1c7:8c5e with SMTP id
 c12-20020a056a000acc00b006ed01c78c5emr13321165pfl.12.1713252704947; 
 Tue, 16 Apr 2024 00:31:44 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 x21-20020aa79195000000b006efbc365de9sm4384847pfa.121.2024.04.16.00.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 00:31:44 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: cv1800b: Add transmit tap delay config to fix write error
Date: Tue, 16 Apr 2024 15:31:05 +0800
Message-ID: <20240416073131.8527-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

Currently, only the receive delay is configured while the transmit delay
is not set, which may result in errors when writing to the file. This issue
can be resolved by setting PHY_TX_SRC_INVERT to SDHCI_PHY_TX_RX_DLY.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 drivers/mmc/cv1800b_sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index 2275c53777..a50f4cff0d 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -12,6 +12,8 @@
 #define MMC_MAX_CLOCK        375000000
 #define TUNE_MAX_PHCODE      128
 
+#define PHY_TX_SRC_INVERT  BIT(8)
+
 struct cv1800b_sdhci_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
@@ -19,7 +21,7 @@ struct cv1800b_sdhci_plat {
 
 static void cv1800b_set_tap_delay(struct sdhci_host *host, u16 tap)
 {
-	sdhci_writel(host, tap << 16, SDHCI_PHY_TX_RX_DLY);
+	sdhci_writel(host, PHY_TX_SRC_INVERT | tap << 16, SDHCI_PHY_TX_RX_DLY);
 }
 
 static void cv1800b_sdhci_reset(struct sdhci_host *host, u8 mask)
-- 
2.41.0

