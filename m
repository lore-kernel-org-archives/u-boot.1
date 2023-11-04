Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACDAC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D8E87271;
	Sat,  4 Nov 2023 21:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YuwT/g0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5256A8700D; Sat,  4 Nov 2023 21:38:18 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2D8870EB
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cc7379b23so19153291cf.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130290; x=1699735090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrIye3PU1MN7zwCLCY4dFeJRly06fsZ0VksNIStD2QE=;
 b=YuwT/g0RCq8TRqieUSHRQ2kjI1soKipAAHYt+pgdWt4wsq3jEuNgl0QarIL4CQla/2
 QaJ48pQ3e8h0BfXASEo7iD7EzTfIilPNf3lftDs5Tc+/WiANFbwObJJaxTsIvyguHPP7
 pAxXkLCeCNTkb8rCxX4vMuKDKiOYfmu1TIPidIPm+W2RH6SpRbI2hQJRBB6WwVkOvLX2
 EHZfv4lDZz4J71CwBqYYSU89bm/IyfJVXtVFelxVG3VbXmqQmCNkXPeZk/GLALf69rFV
 CBfvA8TMfYVTG29ouIy2lZZaoX1qQHgElyp7fmicEbmtgvazBBqPkYpPghw2eC0CLn0s
 rUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130290; x=1699735090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrIye3PU1MN7zwCLCY4dFeJRly06fsZ0VksNIStD2QE=;
 b=sUNLbT90UdlfekNdJhGt6xdCXmaaTCEWD970UvMEa99BWGeLjvO7/H6em6e7+xo4ac
 Ano74cheRvEE9TzLksVBSuuoT8dGBMeuyTvsc8Hi8g5b2AdMyA+e2pRSlaTA0ryzdxzw
 0XFuRynt1ZLxNLOpt56IYntBeeztNovuDZdKZ7YId+Sq5KXK8UgqZW35qqcdn1SjhES8
 pVvh+CBMzZk0yXB2P93sbcfqlgMyc4DBeKSRtNQ+QmEs+ya1ADjlyF29ZdOgr1jNDUPD
 r/3D62Hh8cxTgO+uoya1wFUJ/hZia6zhJAE3MylTRGZ0C6zs7mTwkrYRqXrbOCN4XgU4
 bM5A==
X-Gm-Message-State: AOJu0Yx+DTZV8jOlOGoI4sAS7Rukh2S7bNy3zvii81VRAn1ZNeQmgfeO
 vSA9LnUr8KGfreSR+0SwGA33Yf7KfHieQQ==
X-Google-Smtp-Source: AGHT+IFVQ8vNAWXaXnbb66NrPtKK1lVmqd+Hv4g7KEAlkiJndbodLpsmfTEd3Dn47ILT1+1fShSkbg==
X-Received: by 2002:ac8:5954:0:b0:41e:28d1:c8ff with SMTP id
 20-20020ac85954000000b0041e28d1c8ffmr33894059qtz.51.1699130289903; 
 Sat, 04 Nov 2023 13:38:09 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 ge9-20020a05622a5c8900b0041815bcea29sm1920185qtb.19.2023.11.04.13.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:09 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 12/15] nand: Allow reinitialization
Date: Sat,  4 Nov 2023 16:37:50 -0400
Message-Id: <20231104203753.1579217-13-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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
Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

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

