Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62FDC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5F280713;
	Fri, 17 Jan 2025 00:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L8IPzr2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C6180726; Fri, 17 Jan 2025 00:01:42 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC31D80713
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e565708beso836503a34.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068499; x=1737673299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrfgxcFwNvdOF9sDqxRCvp0D3dnFqVKZKtyf/eaT5Jg=;
 b=L8IPzr2Sb8oY6AmBmovrrYOI0W1BnsawRkbTSCdXW7beYw3IWxPWeqmqSeLcPH3+OD
 HuKxWqkafBQcG4NAVBjM/p5iz+CTEMyPYdeH/ny2NqC2iCt/79KkEmZ99/rSzI1cMs0a
 mOEWSLJRxC6f7RAZQnnRc8m0dMW/+nxhnfHido58lkTf7UhsXZFRqPQVM/PK3d6BVPlx
 +jM7ByYS5HvIux+LFudkW+aB6onIIXpOOUj7Bjl0nwlAy11Jp1m8g18PnVfpsRg+ezU6
 km2QJTS9Dd/2M8CSfPDorrRu8VFqgHopNnexZwj8hHNQQyg3nd/CfFzakZhurPvNKa8+
 SeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068499; x=1737673299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrfgxcFwNvdOF9sDqxRCvp0D3dnFqVKZKtyf/eaT5Jg=;
 b=bkisaM9n8dIb/o43atkhZo4dkE4vaOZaB5kRYVx6cHKioUPnD4P4k6cLk5oUfs/Wdl
 T5oI38WhPVBAxC+LO6lFHVUwsLIf3TZUCi0eMiOZwxYUQ197lIpCzlRzcatdSoKuhghx
 OZDKe7xGI0pRQCMOGGpQdwYA/zhBSp/nJqxqdDhzpZ1vb9X2A0P2MzF528eGwH3h+tnY
 47WRdngMDODxBkr5co/z4fOdN38P1gEVV52I5fklrxj10UF4B9kV8VqXFt6Ob/XmuBF6
 6jynBQyQc2lNMyy3tvvCAv/aMUgMSGnV78uD4N0Qb9ecq3xGu0WC1c0weH1/OQN7nPCz
 9RsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+5a8WKSJUCnTeFdpOv0fnoyifC/+ZGrzfOYtcr43rV+AaOlzgAPpxSXtRNVblMwIG8Php+A=@lists.denx.de
X-Gm-Message-State: AOJu0YyfGPuWjDExIl6UO5gVsxW1KlRqcozfBzN0rThbZPOtus1Osx5P
 u6gU2oVCTV8ZwuNoH+5egpiva8t1Pic8vXPwrwBzyNvGGh7nPPzYLzWUu78VgTg=
X-Gm-Gg: ASbGncvK6CVnECTvk6BmannxyUTDu97+Dl4UBayzH6gt0QoPcJyYn5sAY23ywoZEaxh
 evBwadtlXh8YXRFpbj0Hwzq2DaAPgpjbDb3qBusAot195+taCUMH05N4C2QzEqd5PlRNE3IiBdD
 s0hOXckBlHbBZKYzv9ck8yzwe4J3ZIfGM8Jf1yX1s5/sJXk9hlUflX/jalhAtVN1mXhYMGG35Nh
 9KBlQVRZ6aCszZWrSFMv52ZLVHkcq1a7ZaZBsvsVmAl53w+fsn1kt+n6sTTJ7zO71M=
X-Google-Smtp-Source: AGHT+IEI+DCpxoO74UfvaVJ1CNqaKASzndY3F7zfvRssmR5fUzHP3exz+vlQi8qF/wqdXlFwhZvsFw==
X-Received: by 2002:a05:6830:6213:b0:71d:f239:c0a8 with SMTP id
 46e09a7af769-7249da56afemr212876a34.6.1737068498743; 
 Thu, 16 Jan 2025 15:01:38 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fa35ed8befsm405149eaf.5.2025.01.16.15.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:38 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 5/7] board: samsung: e850-96: Load LDFW from EFI partition
Date: Thu, 16 Jan 2025 17:01:28 -0600
Message-Id: <20250116230130.3337-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
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

In case when EFI System Partition is present it can be used to store
firmware binaries, instead of keeping those on separate dedicated
partitions. That simplifies the partition table and makes it more
standard. Rework the firmware loader code to look for LDFW binary at
/EFI/firmware/ldfw.bin on ESP first, and if either the partition or the
file doesn't exist -- fallback to reading it from 'ldfw' partition. This
way backward compatibility can be kept, and Android partition tables
without ESP partition can be handled too.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/fw.c | 45 ++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/board/samsung/e850-96/fw.c b/board/samsung/e850-96/fw.c
index 82a0b224c670..8f64e759b431 100644
--- a/board/samsung/e850-96/fw.c
+++ b/board/samsung/e850-96/fw.c
@@ -7,14 +7,16 @@
  */
 
 #include <part.h>
+#include <fs.h>
 #include <linux/arm-smccc.h>
 #include "fw.h"
 
 #define EMMC_IFACE		"mmc"
 #define EMMC_DEV_NUM		0
+#define LDFW_RAW_PART		"ldfw"
+#define LDFW_FAT_PART		"esp"
+#define LDFW_FAT_PATH		"/EFI/firmware/ldfw.bin"
 
-/* LDFW constants */
-#define LDFW_PART_NAME		"ldfw"
 #define LDFW_NWD_ADDR		0x88000000
 #define LDFW_MAGIC		0x10adab1e
 #define SMC_CMD_LOAD_LDFW	-0x500
@@ -36,7 +38,33 @@ struct ldfw_header {
 	char fw_name[16];
 };
 
-static int read_fw(const char *part_name, void *buf)
+/* Load LDFW binary as a file from FAT partition */
+static int read_fw_from_fat(const char *part_name, const char *path, void *buf)
+{
+	char dev_part_str[8];
+	loff_t len_read;
+	int err;
+
+	snprintf(dev_part_str, sizeof(dev_part_str), "%d#%s", EMMC_DEV_NUM,
+		 LDFW_FAT_PART);
+
+	err = fs_set_blk_dev(EMMC_IFACE, dev_part_str, FS_TYPE_FAT);
+	if (err) {
+		debug("%s: Can't set block device\n", __func__);
+		return -ENODEV;
+	}
+
+	err = fs_read(path, (ulong)buf, 0, 0, &len_read);
+	if (err) {
+		debug("%s: Can't read LDFW file\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Load LDFW binary from raw partition on block device into RAM buffer */
+static int read_fw_from_raw(const char *part_name, void *buf)
 {
 	struct blk_desc *blk_desc;
 	struct disk_partition part;
@@ -73,10 +101,13 @@ int load_ldfw(void)
 	u64 size = 0;
 	int err, i;
 
-	/* Load LDFW from the block device partition into RAM buffer */
-	err = read_fw(LDFW_PART_NAME, buf);
-	if (err)
-		return err;
+	/* First try to read LDFW from EFI partition, then from the raw one */
+	err = read_fw_from_fat(LDFW_FAT_PART, LDFW_FAT_PATH, buf);
+	if (err) {
+		err = read_fw_from_raw(LDFW_RAW_PART, buf);
+		if (err)
+			return err;
+	}
 
 	/* Validate LDFW by magic number in its header */
 	hdr = buf;
-- 
2.39.5

