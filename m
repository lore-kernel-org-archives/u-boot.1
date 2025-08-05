Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0AEC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E51835FE;
	Tue,  5 Aug 2025 11:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tp7DddGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED91D835CD; Tue,  5 Aug 2025 11:20:14 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B03835B0
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso3334262b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385610; x=1754990410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExyaCLbCO/QKYLdCwquBrl2RvysdKhk4M+4+jYNP32M=;
 b=Tp7DddGCItCk6W7kX8mTkep2IIt+RNQ9cZAlb75XTJZys6q1vsnmfGt/BgdKzKuEDn
 dq4QYPjpsJ5/3Bjv3x9vQvq1UFhX4XVXICR9UM3Gbw4Vsg1G6GaDk5VpqcZQqICNhP0i
 1f6vhqyn1CkoSW0aYCV91hX+CTR7f3ILJuLJTYIOoQiF8QrRS1c+8lqmLSf1HvJIz8+5
 2Ho0WXT2HaHwyd87DFhYmpZCaeuhf0GyEXm1Ihab1syTN+tbTK2g74Rh19DkgMEG9lRe
 7vtvhMFck8EWnGKoIYJ9sCQ3MJ4+y13XfduLtdSr7601rUQU4op1LP9TaZqlCtAbFNt6
 89uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385610; x=1754990410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExyaCLbCO/QKYLdCwquBrl2RvysdKhk4M+4+jYNP32M=;
 b=VB9c3SgfOUGXDbsYXjNAzlinYUOYNgStJJDHs2Ugsh5K51GKGvW45kgx+rAZFUMbWs
 86ZGulhLEP2FZruyQc4qCD/ybjrpLa2E4Npsk0lU872FhXpcqW5DbdIMNIAsh0p1Cl+m
 VeWI6TS8JMy4nd5Q/pLZQd2klBNYB1vnxAbA1JXBI/5/Xc79rE+iPDXy1QjW0GnHMlmZ
 CSshoRF60Li9UzQKZVB1/Q0/OaaxjSR4Mz2kL4uhGrOk+yFcB6d6g3yeSozKOZjbGg8e
 NHeHs3aJuMKvVt+bYKPsFmt+kgi3wldUs09oSHHnu/beneFc/fLZVsTvwhs8rausDX5o
 Bhtw==
X-Gm-Message-State: AOJu0Ywnqm7cHetd4r+3rbwLM+PngQ5KK1FJ1PGA73dkzE26c51ACCs+
 25Y7DFneaPZ+faPDNmU5majM8YWIZVOYjZw8AEKWvscdjtF/n52f6rlT
X-Gm-Gg: ASbGncuIcmP6gjfsNreupXrGhs3/Cc5AqM0+tiGkQKtaUpeCljR1/N0084cjzOYzOIp
 BKxVcmqzqLD9lB6PqIRrVDEIYw3f0DM24JCIz95XljC8vbXKWIq/JaSxs28QUtztesbQN6Kw/nD
 PhC5umA97YkZH+ge9Z/xmi+7aCQJytr4UZUnrvCC0nueJ3Rvv7dAIhtw0TbBxAbwLrtSf/8g67h
 9ifByu4HtlP9vMlH2EHls2LkariL0DG0gDQlPpJNpXiuC7s2Pl7gsfGBdqx4z/M4iZ4vUTuXrsV
 WCjaV50S1ZqjYvXViwN7id2LZiCymgZ8JgxWLKgpYid69e/ZfPwrS4ltmHO8dChpqMtUflYuDKT
 fkiODkxI6Y0u0Jv2ONoD7lnchmNm7S4oEZQ==
X-Google-Smtp-Source: AGHT+IHVwYadJBnDXFPIYzk2upwU2jm2aNw9yJmNhUuW30TZQ1DY6CrM0G6A0x/quKqYS68oer1+JQ==
X-Received: by 2002:a05:6a00:1907:b0:76b:c5bd:aec7 with SMTP id
 d2e1a72fcca58-76bec30aa51mr16053113b3a.8.1754385610539; 
 Tue, 05 Aug 2025 02:20:10 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:20:10 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 7/9] misc: npcm_host_intf: Add Arbel eSPI workaround
Date: Tue,  5 Aug 2025 17:18:48 +0800
Message-Id: <20250805091850.2051096-8-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

Enabling an eSPI channel(e.g. Peripheral Channel) during
an eSPI transaction might cause the BMC eSPI module to
transition to a wrong state and therefore respond with
FATAL_ERROR on incoming transaction.
Add workaround to avoid the module getting into the wrong
state.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/misc/npcm_host_intf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/misc/npcm_host_intf.c b/drivers/misc/npcm_host_intf.c
index 58bab888c3c..2c89bd7a167 100644
--- a/drivers/misc/npcm_host_intf.c
+++ b/drivers/misc/npcm_host_intf.c
@@ -22,6 +22,8 @@
 /* ESPI Register offsets */
 #define ESPICFG			0x4
 #define ESPIHINDP		0x80
+#define ESPI_TEN		0xF0
+#define ESPI_ENG		0xF1
 
 /* MFSEL bit fileds */
 #define MFSEL1_LPCSEL		BIT(26)
@@ -40,6 +42,9 @@
 #define AUTO_HS2		BIT(12)
 #define AUTO_HS3		BIT(16)
 
+#define ESPI_TEN_ENABLE		0x55
+#define ESPI_TEN_DISABLE	0
+
 static int npcm_host_intf_bind(struct udevice *dev)
 {
 	struct regmap *syscon;
@@ -83,6 +88,13 @@ static int npcm_host_intf_bind(struct udevice *dev)
 		val &= ~(CHSUPP_MASK | IOMODE_MASK | MAXFREQ_MASK);
 		val |= IOMODE_SDQ | MAXFREQ_33MHZ | FIELD_PREP(CHSUPP_MASK, ch_supp);
 		writel(val, base + ESPICFG);
+
+		if (device_is_compatible(dev, "nuvoton,npcm845-host-intf")) {
+			/* Workaround: avoid eSPI module getting into wrong state */
+			writeb(ESPI_TEN_ENABLE, base + ESPI_TEN);
+			writeb(BIT(6), base + ESPI_ENG);
+			writeb(ESPI_TEN_DISABLE, base + ESPI_TEN);
+		}
 	} else if (!strcmp(type, "lpc")) {
 		/* Select LPC pin function */
 		regmap_update_bits(syscon, MFSEL4, MFSEL4_ESPISEL, 0);
-- 
2.34.1

