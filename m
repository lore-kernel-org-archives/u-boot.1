Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F92C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4349887C8B;
	Sun, 29 Oct 2023 04:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VjfQrQzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F71E87751; Sun, 29 Oct 2023 04:49:07 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06EE987C5D
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67131800219so5179386d6.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551343; x=1699156143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2BMBtgS6xiCu13NHAzka6oeMXF45J090qYY//OT7Lo=;
 b=VjfQrQztK+1aUXnOIqAwpkeok9uTbguXm4pRDzrdZqmUrlBIyexCDWsxMcL0xzLmJH
 DFkEDisvuJzZcnEier3331VzjWBr5+sXTAlYUM6ohzpenFFcxr57vXUGnZ7M+m0tNLbb
 EjgJGisCqbmTqcxGjy7WfzF1h+RJvgKDrN0QAevnut/lKWo9QIQtfGro0NpLDKfEFZ1J
 xHkEEkZ76l79Xlix0vSI5Ybm4QG5ew2Ke6Kpbg56RrQZkA9LYlRgGBYesJjLd4JrHtmt
 eZiex+fPZBG1tDn9hv9MQyLHG1UZOsyjQIea0z70ZnzxKtu8NDviBdaf1axBoTkFn1+X
 3Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551343; x=1699156143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2BMBtgS6xiCu13NHAzka6oeMXF45J090qYY//OT7Lo=;
 b=Pj0ssakGUjhLEv3syu8RPRRX8Z+OWfYO1Hu2aQZfCr92PwuTYbQbKc5ZE2YWUOSyTS
 hOOaimfSTyUtO3OaLhFV+sebc56t/3/hAd2969RbEWNJVcAL9wJwHi0R1JnRQbSeu7kU
 wqvKtveezzidbQFbJLkVnlmnrnh4paUdGolUG3EDSKMLq3+5HDDY4kIQgBtHEEBs7djJ
 QO09sUpdxS4j0eXcTl5w7U/1l+LnHX4k0ohDzKruzSVVCaOR7xlMth4LnuZO7KOviFwr
 6hBK/5slZx/TCXvQZ2tFbsgGB0z/1YFcetTVJvEWF4GDaKsCabwXrgOcDurPWO9A0kec
 zpQQ==
X-Gm-Message-State: AOJu0YyhcqxFiDRkQCIF2btpegjIL82IFyVSjhwWGiqpKCQ/E7G+bDr6
 dyH2rOcjc4/DfxQvIT8YrkU8IAFSauFv+A==
X-Google-Smtp-Source: AGHT+IHHFkxo1bMIauOOqEiP2tYnzwrVDdOQW1YPMJ60aRV3bCdQemQkkF0XCy4a1TveGqtTm/Lg4g==
X-Received: by 2002:a05:6214:19eb:b0:670:9cc7:2f03 with SMTP id
 q11-20020a05621419eb00b006709cc72f03mr4607690qvc.43.1698551343565; 
 Sat, 28 Oct 2023 20:49:03 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 y11-20020a056214016b00b0066d1d860cd1sm2188516qvs.19.2023.10.28.20.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:49:03 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 12/15] nand: Allow reinitialization
Date: Sat, 28 Oct 2023 23:48:42 -0400
Message-Id: <20231029034845.1169614-13-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

NAND devices are destroyed in between unit tests. Provide a function to
reinitialize the subsystem at the beginning of each test.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/mtd/nand/raw/nand.c | 40 ++++++++++++++++++++++++++++++-------
 include/nand.h              |  1 +
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index 80017b3dddd..4c18861aa25 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -115,6 +115,8 @@ static void nand_init_chip(int i)
 #endif
 
 #ifdef CONFIG_MTD_CONCAT
+struct mtd_info *concat_mtd;
+
 static void create_mtd_concat(void)
 {
 	struct mtd_info *nand_info_list[CONFIG_SYS_MAX_NAND_DEVICE];
@@ -129,28 +131,40 @@ static void create_mtd_concat(void)
 		}
 	}
 	if (nand_devices_found > 1) {
-		struct mtd_info *mtd;
 		char c_mtd_name[16];
 
 		/*
 		 * We detected multiple devices. Concatenate them together.
 		 */
 		sprintf(c_mtd_name, "nand%d", nand_devices_found);
-		mtd = mtd_concat_create(nand_info_list, nand_devices_found,
-					c_mtd_name);
+		concat_mtd = mtd_concat_create(nand_info_list,
+					       nand_devices_found, c_mtd_name);
 
-		if (mtd == NULL)
+		if (!concat_mtd)
 			return;
 
-		nand_register(nand_devices_found, mtd);
+		nand_register(nand_devices_found, concat_mtd);
 	}
 
 	return;
 }
+
+static void destroy_mtd_concat(void)
+{
+	if (!concat_mtd)
+		return;
+
+	mtd_concat_destroy(concat_mtd);
+	concat_mtd = NULL;
+}
 #else
 static void create_mtd_concat(void)
 {
 }
+
+static void destroy_mtd_concat(void)
+{
+}
 #endif
 
 unsigned long nand_size(void)
@@ -158,10 +172,10 @@ unsigned long nand_size(void)
 	return total_nand_size;
 }
 
+static int initialized;
+
 void nand_init(void)
 {
-	static int initialized;
-
 	/*
 	 * Avoid initializing NAND Flash multiple times,
 	 * otherwise it will calculate a wrong total size.
@@ -190,6 +204,18 @@ void nand_init(void)
 	create_mtd_concat();
 }
 
+void nand_reinit(void)
+{
+	int i;
+
+	destroy_mtd_concat();
+	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++)
+		assert(!nand_info[i]);
+
+	initialized = 0;
+	nand_init();
+}
+
 unsigned int nand_page_size(void)
 {
 	struct mtd_info *mtd = get_nand_dev_by_index(nand_curr_device);
diff --git a/include/nand.h b/include/nand.h
index fc584f5ef7a..220ffa202ef 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -11,6 +11,7 @@
 #include <config.h>
 
 extern void nand_init(void);
+void nand_reinit(void);
 unsigned long nand_size(void);
 unsigned int nand_page_size(void);
 
-- 
2.37.1

