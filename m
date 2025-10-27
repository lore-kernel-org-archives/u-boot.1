Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37F7CCD1A5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18AA982C7F;
	Mon, 27 Oct 2025 06:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hKMouJs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD35836B4; Mon, 27 Oct 2025 06:51:12 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB3E836B4
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c53400935fso1101944a34.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761544268; x=1762149068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBgRYZP5h43rgnuK7g6spWyi6yrdSWxPs3ceLKxWl5Y=;
 b=hKMouJs8gqIFYCZbQBNQ4zMtO8bhk2Lfn8pRh4vZbhuap1oNS4fnsDvd2a787O/o+T
 gRoeADNOUyDXTA/6N3qhAtytJNT5k0zShEt2sL6/ipVx3n8yU5TQDKq23Q4mizwzBGgz
 EpnON9k8L33DjoMhOy4ZWm/0sp6AiJb17afBkkWq9K0nETb69CIiN2S77Ki5HzdBgTJq
 OvOiJHrVWj7j9nX5KgDDjUqfryM1yelobepVN792KTxQ+tOtzVkaycgOrayGpWfchgAS
 eO2Oq0HvUHcrYQprQvOWuMGylhzURHHgaBEqkUtJsSVfwrKHIsEV1zfFB3JaaTVI/6fr
 XOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544268; x=1762149068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBgRYZP5h43rgnuK7g6spWyi6yrdSWxPs3ceLKxWl5Y=;
 b=WYpIOn4LM9kW2mLPm3wNhpfbJkkQZ/wvs4Hb/EKkdTAz45AwgL7lpBEUXoGN5twPKG
 Dyh1n5s/+kRu39CKW/Nqz6Q3tVmVYTkutL/JDA10UAUqVw++hqVmzEE22b/i2REWU8qv
 3f2syMny0mE0/8fsZDwQIa0Cm1JpfXMrgBxoycGiWfaEurQCx0wYEEmFhlIs5m1j9Atg
 +dP5xUp4GKfj08viOnRI0De1A44gU/CmzLvEQdLoQSMXOg36/22IgTg6EujjAgoQfikr
 Q1pG/tqXhIwddVk8z2JRCu9hDXP+dfyMcGlE502czKDp9QIazp5gXnxchXHMcZkC8wMs
 xa8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV3Ru4bkgHucRu9jm4N2NQGDZIvf7JEgNsHilvgZvOfDr3cNcRZTRSCiCp4QgR3Ynx9f5OPG0=@lists.denx.de
X-Gm-Message-State: AOJu0YzkK5L8j8Y+uP2Nq78jtVXg8rvKn1Qeo2QqnFn4yh/K0SSrpmmz
 Gtj2gDZhyf0eXwoPC9dpVgN+3x5JjbQcbsVFv0XHW28ildpOA8NlYG2QirSESMKk1dY=
X-Gm-Gg: ASbGncuaJlhxY4PcS2ILxMDmPaMHiHgm7py9/+YbRIWqGMYhmY7qo+V8ggkzLpOAvER
 IHvVL/cPNV3eWsJOWpR7x7WFqYbLF2GqDX+k2Mty2TJaAxPuckVXsIDzhxMPbE5GPyL2VVJd/nK
 5TgD0HUsNXkkh83ve0TXXwJGKFr0t9kEgDI4UeO7ctL4Eycgpqed9Wd8F/6SaHnGtYPHktNWp1p
 JjO8NkeCP3uQWA+2fREc8fXfIN2SIx3ZSTfiq/qOG3jMNDL7KRz7ObEEppDCyqaFZLewBwiuVEE
 B7leNNuzDsYl2W1CJriylp6DGtjHsQ86rlgSYpTQZJ7jEdpaOU/gjuKLiffbu+WupFLqqjsJCvz
 DN99qoOohX+4nNBWUaLipWDxEjIzBkjJbnp612mAi1ET3noExx/zoOLd5GIji730LJEumpJbcgE
 IjgrRaTiBUoifF/13oeQLK
X-Google-Smtp-Source: AGHT+IEfz/MryyLqPi7X/l+0TZ+swaeoqmgL15wUhj+Gj+9IWPgaBSOKX29/gB5f0c6Toi8wpvZTZQ==
X-Received: by 2002:a05:6830:2a06:b0:797:97d1:de29 with SMTP id
 46e09a7af769-7c52307797amr5740159a34.13.1761544268482; 
 Sun, 26 Oct 2025 22:51:08 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5301189d4sm2004670a34.2.2025.10.26.22.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 22:51:08 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/5] board: samsung: e850-96: Split LDFW loading and init
Date: Mon, 27 Oct 2025 00:51:03 -0500
Message-Id: <20251027055105.720-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027055105.720-1-semen.protsenko@linaro.org>
References: <20251027055105.720-1-semen.protsenko@linaro.org>
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

The LDFW firmware loading is done in two steps:

  1. Read the firmware binary from some block device
  2. Provide it to EL3 monitor software via an SMC call, so it can copy
     it to a Secure World memory and start using it

Let's split the load_ldfw() function by two functions correspondingly,
to reflect that process better:

  - load_ldfw_from_blk()
  - init_ldfw()

It can be useful in case when the LDFW binary should be obtained from
some different media, e.g. downloaded over USB during USB boot.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c |  9 ++++++--
 board/samsung/e850-96/fw.c      | 37 ++++++++++++++++++++++-----------
 board/samsung/e850-96/fw.h      |  3 ++-
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 34e01914032c..3cf98a01b703 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -151,9 +151,14 @@ void load_firmware(void)
 	}
 
 	printf("Loading LDFW firmware (from %s %ld)...\n", ifname, dev);
-	err = load_ldfw(ifname, dev, part, LDFW_NWD_ADDR);
-	if (err)
+	err = load_ldfw_from_blk(ifname, dev, part, LDFW_NWD_ADDR);
+	if (err) {
 		printf("ERROR: LDFW loading failed (%d)\n", err);
+		return;
+	}
+	err = init_ldfw(LDFW_NWD_ADDR);
+	if (err)
+		printf("ERROR: LDFW init failed (%d)\n", err);
 }
 
 int dram_init(void)
diff --git a/board/samsung/e850-96/fw.c b/board/samsung/e850-96/fw.c
index 64235c01a254..2d52433e38ad 100644
--- a/board/samsung/e850-96/fw.c
+++ b/board/samsung/e850-96/fw.c
@@ -94,7 +94,7 @@ static int read_fw_from_raw(const char *ifname, int dev, const char *part_name,
 }
 
 /**
- * load_ldfw - Load the loadable firmware (LDFW)
+ * load_ldfw_from_blk - Load the loadable firmware (LDFW) from block device
  * @ifname: Interface name of the block device to load the firmware from
  * @dev: Device number
  * @part: Partition number
@@ -102,24 +102,37 @@ static int read_fw_from_raw(const char *ifname, int dev, const char *part_name,
  *
  * Return: 0 on success or a negative value on error.
  */
-int load_ldfw(const char *ifname, int dev, int part, phys_addr_t addr)
+int load_ldfw_from_blk(const char *ifname, int dev, int part, phys_addr_t addr)
 {
-	struct ldfw_header *hdr;
-	struct arm_smccc_res res;
 	void *buf = (void *)addr;
-	u64 size = 0;
-	int err, i;
+	int err;
 
 	/* First try to read LDFW from EFI partition, then from the raw one */
 	err = read_fw_from_fat(ifname, dev, part, LDFW_FAT_PATH, buf);
-	if (err) {
-		err = read_fw_from_raw(ifname, dev, LDFW_RAW_PART, buf);
-		if (err)
-			return err;
-	}
+	if (err)
+		return read_fw_from_raw(ifname, dev, LDFW_RAW_PART, buf);
+
+	return 0;
+}
+
+/**
+ * init_ldfw - Provide the LDFW (loaded to RAM) to EL3 monitor to make use of it
+ * @addr: Memory address where LDFW resides
+ *
+ * EL3 monitor will copy the LDFW from the provided Normal World memory @addr to
+ * Secure World location, and start using it.
+ *
+ * Return: 0 on success or a negative value on error.
+ */
+int init_ldfw(phys_addr_t addr)
+{
+	struct ldfw_header *hdr;
+	struct arm_smccc_res res;
+	u64 size = 0;
+	int err, i;
 
 	/* Validate LDFW by magic number in its header */
-	hdr = buf;
+	hdr = (struct ldfw_header *)addr;
 	if (hdr->magic != LDFW_MAGIC) {
 		debug("%s: Wrong LDFW magic; is LDFW flashed?\n", __func__);
 		return -EINVAL;
diff --git a/board/samsung/e850-96/fw.h b/board/samsung/e850-96/fw.h
index 73d9615d4a9c..b061abc4df69 100644
--- a/board/samsung/e850-96/fw.h
+++ b/board/samsung/e850-96/fw.h
@@ -9,6 +9,7 @@
 
 #include <asm/types.h>
 
-int load_ldfw(const char *ifname, int dev, int part, phys_addr_t addr);
+int load_ldfw_from_blk(const char *ifname, int dev, int part, phys_addr_t addr);
+int init_ldfw(phys_addr_t addr);
 
 #endif /* __E850_96_FW_H */
-- 
2.39.5

