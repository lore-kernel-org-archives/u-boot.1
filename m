Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB389C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A02E87C83;
	Sun, 29 Oct 2023 04:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIA/xPm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A4787C72; Sun, 29 Oct 2023 04:49:06 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BA687C61
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77897c4ac1fso247477485a.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551342; x=1699156142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTr4BRzHcVhTsDtZcf8iE8IW5O/nrDEC+lc3/LxEiyc=;
 b=hIA/xPm0PRZEo0k73X14wJHFBcwlvXhO2nVtRe/URomtp6/p69N0PWsmI2o2RK04Cq
 dTaTbnRYJVlfz/PYFtoe+fXLIWdC5iwhQo3ta07yRFONrFz1OLqfYmOPReCa6+fPuPJp
 1Hj9XzaImmkJMFPozQTJurm5fwOyf7nkxdK8sVyHaPWP5doYc8FIKLNTlO89Q09IreD6
 JMH7M0K8YsCrRSzep+2yYhJopwH15jboSpUEnBOUDn6T70+eYXvREArIdQ3GcjC+GZa/
 Hib83O8sh03OgWQjCGTrTBglw5/dVmG3TZ1ADVSqcEn0qsrkMTgdJ7tkqjnbpu4rmDxQ
 YfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551342; x=1699156142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTr4BRzHcVhTsDtZcf8iE8IW5O/nrDEC+lc3/LxEiyc=;
 b=lbRLqolv9XywBjdo2UMAjxffXMNGfpTaRV8yGm5W70TO+W2i3OGjpVmCzzavB+UquT
 +23HS+7/Y2VjNdYZRf+z/ebtNFdVGidYx0m2k3YgCCTUbqaMSNNrNNU6Tx3g8cm7JrQA
 jrVLnYsNeAM1xVegH5eDY7erg0nQ+ZUi5fPPc2bYOr2eglQTjm85mSF0vSAMkyRvCSnN
 84v0urwJczkEnuMxirbMcswbIspkRtF6bDK4YsDlSHBeAqwXD6YJscHl3ZevDPPlrPHH
 vQMvRhGY3yCcA/CQrf/N49s/N7uweSBS1EkoWs5n8ApRsJSMde15C1j8KZt371NJeVdk
 BEzA==
X-Gm-Message-State: AOJu0Ywc5joAcfY+I51bHBFt0QQfrZnxfeWzIlBVLins0uuxyOtaKcUR
 WPeHQ6s6V+I84cyczqct4op9Ot4gDzhaUg==
X-Google-Smtp-Source: AGHT+IF3qBXR8nm4sDyyvzHbnSqmqvJ/jcSa1xzPjy1Tm2BINn6i2xi9X+oh4CKfjy2aX6RAhHqSfA==
X-Received: by 2002:a05:620a:4050:b0:775:9026:31ac with SMTP id
 i16-20020a05620a405000b00775902631acmr7309293qko.9.1698551341136; 
 Sat, 28 Oct 2023 20:49:01 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 br44-20020a05620a462c00b0076cda7eab11sm2087246qkb.133.2023.10.28.20.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:49:00 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 10/15] mtd: Add some fallbacks for add/del_mtd_device
Date: Sat, 28 Oct 2023 23:48:40 -0400
Message-Id: <20231029034845.1169614-11-seanga2@gmail.com>
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

This allows using these functions without ifdefs. OneNAND depends on MTD,
so this ifdef was redundant in the first place.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/mtd/nand/raw/nand.c         |  2 --
 drivers/mtd/onenand/onenand_uboot.c |  2 --
 include/linux/mtd/mtd.h             | 12 ++++++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index 4da41438790..3abd82068fb 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -60,13 +60,11 @@ int nand_register(int devnum, struct mtd_info *mtd)
 	sprintf(dev_name[devnum], "nand%d", devnum);
 	mtd->name = dev_name[devnum];
 
-#ifdef CONFIG_MTD
 	/*
 	 * Add MTD device so that we can reference it later
 	 * via the mtdcore infrastructure (e.g. ubi).
 	 */
 	add_mtd_device(mtd);
-#endif
 
 	total_nand_size += mtd->size / 1024;
 
diff --git a/drivers/mtd/onenand/onenand_uboot.c b/drivers/mtd/onenand/onenand_uboot.c
index 04791df69bb..ecacabefadc 100644
--- a/drivers/mtd/onenand/onenand_uboot.c
+++ b/drivers/mtd/onenand/onenand_uboot.c
@@ -44,14 +44,12 @@ void onenand_init(void)
 			puts("Flex-");
 		puts("OneNAND: ");
 
-#ifdef CONFIG_MTD
 		/*
 		 * Add MTD device so that we can reference it later
 		 * via the mtdcore infrastructure (e.g. ubi).
 		 */
 		onenand_mtd.name = dev_name;
 		add_mtd_device(&onenand_mtd);
-#endif
 	}
 	print_size(onenand_chip.chipsize, "\n");
 }
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 09f52698877..7a66c7af749 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -552,8 +552,20 @@ unsigned mtd_mmap_capabilities(struct mtd_info *mtd);
 
 #ifdef __UBOOT__
 /* drivers/mtd/mtdcore.h */
+#if CONFIG_IS_ENABLED(MTD)
 int add_mtd_device(struct mtd_info *mtd);
 int del_mtd_device(struct mtd_info *mtd);
+#else
+static inline int add_mtd_device(struct mtd_info *mtd)
+{
+	return -ENOSYS;
+}
+
+static inline int del_mtd_device(struct mtd_info *mtd)
+{
+	return -ENOSYS;
+}
+#endif
 
 #ifdef CONFIG_MTD_PARTITIONS
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
-- 
2.37.1

