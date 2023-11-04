Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913B4C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD94687206;
	Sat,  4 Nov 2023 21:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZ+gPoGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431FE86F63; Sat,  4 Nov 2023 21:38:17 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781A486FC3
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-778a20df8c3so211549685a.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130288; x=1699735088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifdrhWx0YYuLsf5NMajrl1yoes448CH9J/17pHE3j3Y=;
 b=UZ+gPoGtmxR8HOGf+H0Yj2Hbnx4XaoUFfa2noE+KlwOSXgJqKSTzXjEC6UqeqkuGpF
 owXEi0iDeDh9iT1KeyC7sYcZy8ALIzVMkr09X0ami04qLVucl7u57E8qSVb2QyWd4zLr
 4WJO3SYxs4AypKgAqCE1doZUuLPBdeogyVOGV5mRSv9mFG701tvjxLkiSCV6ftuG4yuf
 BDxOKquSmgGt8ORLtUau3dspkeOKCAwivIkFucZ+jpAdOZQRHHbzcIn1DoNzTYzQnYWx
 2dgkv/ysxl9bKVZ80rZfICTt85h1oe2uWal0bdbGz+4DrVQ79cu1qDvXYT7Ao2s6YbdZ
 C8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130288; x=1699735088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifdrhWx0YYuLsf5NMajrl1yoes448CH9J/17pHE3j3Y=;
 b=PUS3c/2/om0RSRc6ukajZ4s0JrJT5L0RhqPGEpPsOGzrf+VOZYW9Pmu5oKPE6p+QXm
 eVBMJS67FP4B8wEkkEV+0DPEEiyOMKUUVYyHVq8stnynINe7JvzAOxHnd3uRoO8N3gOR
 /92z8ZySXORf/LNW25EbKCHEGAVDE3VbSGfn9cnu195jKr4Dpn4Onn5Ih+szAnH+30+z
 aE8U6g0UNsDlFk5A+WYG6bkyboD6lXv6vgXNIsgS1NUqScxjzGCc+Bpmt/pUHml4FQNK
 P9qshwNQOs5j8xbnWxtj3w1jXsb2dikrKr9qlJxi2LLPyQTYgsZtuNTmjka1IcyR5EJb
 CwsQ==
X-Gm-Message-State: AOJu0Ywq9lgOiISyotCRVniRU9esxVIZzBAtuG1KxytTBxanRzH7si0p
 k4Dajbig9ra4TflqUK9kHyDb3op6YmNfbQ==
X-Google-Smtp-Source: AGHT+IHPuZkDusD65E6xRwlgybDqjRZl2hJsM4P+yXJUAqI2+l+bZSqm2R6Z3G2l1tTVIv0IGaJZCA==
X-Received: by 2002:a05:620a:172b:b0:777:74b9:219f with SMTP id
 az43-20020a05620a172b00b0077774b9219fmr32237973qkb.8.1699130287833; 
 Sat, 04 Nov 2023 13:38:07 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 br40-20020a05620a462800b007758ffab58asm1849891qkb.8.2023.11.04.13.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:07 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 10/15] mtd: Add some fallbacks for add/del_mtd_device
Date: Sat,  4 Nov 2023 16:37:48 -0400
Message-Id: <20231104203753.1579217-11-seanga2@gmail.com>
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

This allows using these functions without ifdefs. OneNAND depends on MTD,
so this ifdef was redundant in the first place.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

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

