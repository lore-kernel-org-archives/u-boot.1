Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CD3CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DF883A94;
	Wed, 19 Nov 2025 00:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dlzPeTZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF17E83B8B; Wed, 19 Nov 2025 00:21:27 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF60D81D6A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4503ee5c160so2846290b6e.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508083; x=1764112883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4mzL1kQ8ZHIdPpJ9RoR9slDVS9HsUbfYYHIWpX0nxM=;
 b=dlzPeTZv3WQ3Ej503m/cut3BCEqnVdY/ErxqZMSsG/07nmchjvBvmk/IU1F3MTgywF
 yNmayHH5N9VUZNB9PcDNcBs2qDtDShi4ShaYIG1NxjPWIXzhDOQcOB1qN4goZrrp/Ezo
 jCi9I2cpz7CFOdgpq8Rm1WqvCAPy2to1VjO5T+mVZeBd1DIpr0OlIcr+m7wiCh/IFwgg
 59GNUVp/HVYGeugisGaWsAe3ij/0xxYHAVv2YtTrA+L5Sz4ngHVJFDkqciHDUGsFf99a
 Osx3Tjs/cohrPZrGbCC1AR3+TkYrcCjq2OT9nrCu/mopR/Zxx1dmiA9h16Is8mZC3gvg
 nWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508083; x=1764112883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m4mzL1kQ8ZHIdPpJ9RoR9slDVS9HsUbfYYHIWpX0nxM=;
 b=aagC0JnBFEUYoKgmezg6fEMkv09VYw9cyWyOfbyVt0EXRiPue5AVTmbezOEKkG16kD
 6hFoMXpwaQCIyVobePmdIR+Wt+YaNstpqYy5GqycRcm/O0ipRE7FNFvE3sNrwSl5czCj
 doKXCK+iyvFJ+eQKTBj0kNzm7hy2L+ZxpIbZCeGfoIKEuByvrv15Kv1m/yY3zy82lflz
 jBVf9ubkzJA68+v0gokVRaSMbLaW12Frsm089JomudFkUSc9idWjD9PKJ3wxYSOWsPRt
 Wvc3ivv6Aul4bbpe9An61ouNxN4BWNUsZJINT5tVYAM4rrhMKa0262VSLPSJO03rH1Zh
 RN7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeQmrsRF04wBXBmQYWH8LTEF00hJurIc2JM7S3Sm7ErsYyJp3gNgfIatYzGEONFKGNKjUpl2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxXTcJx/URA3bnKWzqzf7hiXRmLugGEYAu6OZyukdfTqlXV18Wl
 vWsKeE/V4Z/dbfTlCvyWzPxweE9zcTiTEHUaqCFNk4rnqFSd5UslW3aYw4ZrMYWsE0w=
X-Gm-Gg: ASbGncug1/pB3Rbscv5E9e+g7hpclQo3aAN9RMPTgqf63S0UbYpmIQv8LmDdcJen5vX
 CsDGAaJ8flQYct0HSZwDP6GoWQzzlYU4DgS+2Z39iwAmHOca66YaaOMrP4ijDhLPZ69s/w76wBZ
 QrmgdEIRZ1TNheOXVt7NRO4zRpjNpJlHccPwnukOiyyb8v7Xts8/lhYrYAYDUzk8mcvn7WxBCCV
 s0UmheVDsHysA6Imj9pYbjQzImuWQ3hcmnIGm2CBw1wSsnQziroJXpPFoPVPVVa/3SjlMxGRx9C
 q8Q33z7i1JdUWdCASuTk/mohfTquzh+D4PRpd0TTI9uW78ggxcK32q9dimQbV5It9H1bGNwyiJG
 Q7HLZmyo/MOHRVSbVCcnPE7LIB4N3yy2yEvvEEm0McxoQYS0wmbBeLBWWwIw32U9TQSDFZhueY4
 nEMtrymKB4SIlG/oxI+ywx
X-Google-Smtp-Source: AGHT+IFHRxFZ21VGuiAVhVnc+n+Xp+0q8sYt+V5Jft3ISBtzNa+9Q7jqX+F9EpgTTVABbUiK0lfokA==
X-Received: by 2002:a05:6808:6a82:b0:439:af2f:d1d5 with SMTP id
 5614622812f47-450974b31f7mr8772690b6e.39.1763508083357; 
 Tue, 18 Nov 2025 15:21:23 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-3e89865b118sm3903133fac.9.2025.11.18.15.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:22 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 3/6] board: samsung: e850-96: Split LDFW loading and init
Date: Tue, 18 Nov 2025 17:21:16 -0600
Message-ID: <20251118232119.17928-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - (none)

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
2.47.3

