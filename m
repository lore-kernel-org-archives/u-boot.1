Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB94CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF2C83837;
	Mon, 27 Oct 2025 07:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WlPrTvZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DB8836B2; Mon, 27 Oct 2025 07:14:59 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FFA80422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c0e8367d4eso1428167a34.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545696; x=1762150496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+qWqD/MuGNmLURMENnGWSQHxuhIbHeoSLTu4iCcsJ4=;
 b=WlPrTvZr4hMAEEZLmGyx3b3NzaDoKshP/T0A8+M0UIkiatWvhUGGtaWkYDsUwRlkCZ
 UtclgW/MOdsJcYkUzsggh6nuVuNh4zAcExaOJC9EKrYr596e7xydd2+yyO0re7NXxB0O
 VnNNsOWtE6dM5fZ1eay806UVg2UTMCMmsvWxRDLUQT0+wGEx1X+J5beT+XDzoL8/UazN
 e72eGTcId+zxXWe6BPYIdxxtrjrriKX8+at9dh/my6t9ofiTUqCbWHtZQO7YBgqox+xE
 dsp4JzAIFOPYZqXkJ111kjktIUrdTt3H/eL+kJoD/zinQkDHmwyPINnBMWjTCMPxoUp3
 F/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545696; x=1762150496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+qWqD/MuGNmLURMENnGWSQHxuhIbHeoSLTu4iCcsJ4=;
 b=TVbw/Hbb9cFZQhPE61Z72l1DAf40O9TROOy1uCs/XkAwap2jbV8DbImCXfE2LGGmM6
 dIzKxaEgm1qB7EHVBbfiCJHZ5ckl1ra5YFbYPTwMgLRl/aRyfyBn6d2QSsDNsHTfpWCN
 +H82OcWCZ07eif/3/gZdHRsrwzwfwl2nu0zcg7Hyv580NqGXGu3ew1mtFsjJkfxosCwe
 pkXEUOyrwKJBCoZKdo+hZDA1A5WgSDH2kJOA+ULTmD19uApmZeWqLF1hwJruAjCb0Equ
 4l7yxj6JlJCt9HzNzYqK8lgvASXZ6fLbO6DJsjvRuj2SctdooZsTpCovU6Y0pKOJTrdT
 jKkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwO6WbHDc9pCCdEXW9Ih4IwN18zxfRczJ49W7c1oqYEfDEJY23R5X+tXvhayZvFl3luJ0uPno=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/ZNy+ZzKoKJawBkR1l03unbTzdJuGIx6tOAxeMnLkwaDrMhsB
 o7qvwDvTynBavQVXd3tp4R4FLxgKNn5RASMgfmoj3C8rSu5jn0jp500EpoiQbEeTw5DHrtnocVU
 b+Bu/
X-Gm-Gg: ASbGncuCQWCWI/goUJNr612W7I9ltoNai4ij7tk/N5WTOSzbCIEOtD/WROUtls/9oLd
 dw7hnb9OKGCaha9Nv2UOw+PCk1paAxaL4XEjAJ/qZBYxRUz4rv130PKDNgwroI/JFaw5hT1sPXi
 9e6VfeiTuZx3sr/T7myK+2TWWzNKGl4b3tVoJdfPpj3swrqFdwO/JMIfMhcm5ZHfJvwPg+IHsY/
 MR5/H+I0MIS1UdQ2PbzO2yLzllrRAl8+GgIkTWMJGSbMCea2iqHCAl/gwKKz6yzgwd7ORWgHumY
 Wkzaq0DueCLvIfRq/AckPxvbvBF5/YyasaeTTbgBsyOPeqDNvEynoNBQ5Vh3tvV+vXjOk6WHoNd
 vPQeRcDKnqzvaa6STknqPVpnguabvQGdo53Sce2JtY2BbGMPIWg09hju1XofWIGzd4rUyEFcg4X
 DeKTzIsnf1qw9MlxPjKy+xtzFsxTwAQTw=
X-Google-Smtp-Source: AGHT+IG+TuNCQHVbMpoNk6ex5ue4SEk7glJM6rfTsBh4WRPJG6St5655epQJFfPEzwrbzUumG6Dl9A==
X-Received: by 2002:a05:6830:4111:b0:758:85e2:99ce with SMTP id
 46e09a7af769-7c52413cdb7mr6157096a34.23.1761545696213; 
 Sun, 26 Oct 2025 23:14:56 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c53014c660sm1985187a34.15.2025.10.26.23.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 23:14:55 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/5] board: samsung: e850-96: Split LDFW loading and init
Date: Mon, 27 Oct 2025 01:14:50 -0500
Message-Id: <20251027061452.21165-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027061452.21165-1-semen.protsenko@linaro.org>
References: <20251027061452.21165-1-semen.protsenko@linaro.org>
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
Changes in v2:
  - (none)

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

