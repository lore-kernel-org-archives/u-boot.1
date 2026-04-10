Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57335F36BAB
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 04:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B20C8414B;
	Fri, 10 Apr 2026 06:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtpBnW3P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f/aJbT4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EBF84120; Fri, 10 Apr 2026 06:42:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2B184099
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639Kh1aM1729917
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OXnYcTBC4HEfafJiJVVvbDvz0dAVoDd4Gq7qLw2NCn8=; b=BtpBnW3PRiRLRtsD
 pTlMVzdog78JHTL7J5CKfcadr/6Oyp2ClDjmWNcThXLQ140079fUBOhOD/TOgvjz
 7x8HvPK5zFH+r2B/k9vn1gzNUkjGaJUZ2HmP5sopzNu9EMJu86TQGW8cKQH2p7iR
 HROe2LcUuwivm0zrUo5QOYyG866EvOTlrvwcLXJpCj25ihVoM5MOwxy9inJ/n/mO
 ESOCskGoZkQjaMnC6CjoCRT/yJY5U4cc5oI/EverFlE4uq7lZU4057o1Jnxhw/C1
 6YKRsBmQnbPKR/QJhEbDyx+1GcoxKdLWMTbsJ64J7B2c8sRRQyVc8xBFmTtcfjbb
 fG6PPQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxjpef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:42:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76bfd7b9cdso754849a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 21:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775796132; x=1776400932; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OXnYcTBC4HEfafJiJVVvbDvz0dAVoDd4Gq7qLw2NCn8=;
 b=f/aJbT4P/TGXEPw02Dh/6FoIYBtqJXv0gGFFCkjUpCS87E6g42ox6j9erkBg9GGpmD
 MLcQHtIhcFVOupNV3rD9zq0n905I5+fY2pW01eLuWLekP6XPHTvUvTq9rvXY9z9jua/H
 HpOeLiYYLr2mHylIUQww7fdJxUPXR9d2BC9HqvbllM7RykZRvwH6590INTbIDb35Jdv0
 gHx8Ikz85ajJANEherrgSUyT2vKsBbqWjnY9igl0KEY5YMMnPdOoYjCrOcOiDhwlbxEe
 gHosOntbo+xV/PVyett2wCTqek6bvzcJ3a/A81x38SjX3YSZYs7MiNb/wzR3OsJ5tp9k
 JPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775796132; x=1776400932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OXnYcTBC4HEfafJiJVVvbDvz0dAVoDd4Gq7qLw2NCn8=;
 b=LKmsPtyKzSS4D+5bpsUcQH7In/vzMK+Xc5JeVwkGyH/dI44FrgeDNFnhOrYEMFBzWl
 dbK2Hamuq1//vTt691Vy6cJQwh+XJ/+gmZ0qwG/z936wh9mFSHbarBKBDggSDQ5jxYw/
 pFzjG/vfPEUqicxw19gx5lQZ9dQcWvjh3vaL4aak5DJMUBmYZ4A+dJSZ2nNL8wWq52o8
 EfeY8i6j0aa5Xgg+lis18fXSLeVNBQgFQhicdH4gi4cK1ro9f3DYId4XctBCibG6JA65
 UI7FjEeuT3p4e1XDp4HcoXv8MKruUhZGszE1CqaRJ95OsecAAyssDpNdTiJOoo7Vlzng
 4laA==
X-Gm-Message-State: AOJu0YwnRydCbCgqda8lYz0Ds4lwz/P1w4VngfN4Ffl753YfSbiEMEvj
 KQv2EtYjQ9qeDOjtnbd2aNG766/EBvrcGWYweTeSGK3IMBZLgifzom863yqKQIGy22QNmpO0re3
 XHNPdC9/h8o8kvo9nANx5UNLdmcX02r7JfsRkIBXMznf6x/ji7THYWz52
X-Gm-Gg: AeBDietCgr9v67vTY9VPfmycLi1DbfgpkyVO3njPuhKzXstQfOAcYCKiTGFCCqTRiuQ
 kMZdErszs32LmKXhvqC5Az7r7FzE2xIrRH0iDk2uxFyBfCmvx9EL9Jw/nPsXFVEEZJDOcvFoFVv
 iEgP3Bu/tp2/91ieVcuWaZcQrZpVyrCsBRUJ3mh0+s37Zjk+3IqFaTO240P6W3j21QEBv2aJkJW
 ar2w0iLc35/6luLsWFlE/lLTi7HdCARDGAehfjUcWhFgBH+m4zhHVwct5XrBghmFVx/zUaABnkG
 9QOlOg5C2/L25waDcECBHWqJd9IVNeQkR5XvotvARXj5/ruG69G8zvRd99hTLBtSGCOJOaUIEIH
 k8g6U/iosKW1ON2f8wKkEMFG59ZJ4mP/C8xKXXZ3eUgfmfcYhYZF1ViAfTEBiKFogZG3TZXskru
 vIAzSNQ+FM1JCHawvbX39l+SVnLQu54SF9ss59X1vLLHKbv64MhA==
X-Received: by 2002:a05:6a00:2e9d:b0:82c:7767:5ba9 with SMTP id
 d2e1a72fcca58-82f0c2987a5mr1827723b3a.26.1775796131776; 
 Thu, 09 Apr 2026 21:42:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9d:b0:82c:7767:5ba9 with SMTP id
 d2e1a72fcca58-82f0c2987a5mr1827701b3a.26.1775796131258; 
 Thu, 09 Apr 2026 21:42:11 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b3b29sm1198815b3a.36.2026.04.09.21.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 21:42:10 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 10:12:00 +0530
Subject: [PATCH 1/2] fastboot: block: Add GPT/MBR support and device
 selection syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fb_block-v1-1-68f0c976fe0e@oss.qualcomm.com>
References: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
In-Reply-To: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775796123; l=9792;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=UvAFFTtOej36I1FijaioxXa2XYPesSwOH6Q0n7gUmvc=;
 b=uFRludJJ0hhJZWlSsEFWN/hcGaPxPb12gzn8A73C3IKnEBcmOcGnKRQLiixnidV8KK2ld0LKc
 UtNXJVqgvvzDdHj/wIsgquldyNbduv5gEVXnHQE354RZHijzb66k51b
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: e6mFiJcFFwK7u8cAVzpKxT2fb9FDrAVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA0MCBTYWx0ZWRfX78WYv1AeUUdC
 1dE4vrGewHRo7/rw81SDGoycWN1hrwwib0S4j/eoMlUVMbbN5GIy6WLRUdE2J2pZxZjNPRYDqAf
 KIWuyv30OoCvFOHLanKfSdDuaYVbqK3nXVX7Cqt95z8ICl+DjdW1J9LoyPJ49OxTpzcr3fM0J83
 e6yrVhCvVO+FC1oj1t5MfKXOWMDh/kFd6aiRJAUeeIjJK824Av4hVlFGEIrpmML2WPQk+d86bOv
 frZbC5JMTb2T6GjqgQYM6cxmkxoRzkwE9vFrOH0+3XLXEifum6lJDbInqDPG8tuNmaHCgg1ojuu
 zmnDN1hnEd6nvpmrZjR2vjPl5kDtwFOPy7Zwb9aQvHXOtx7UkQqszBGHS8afwiudHOFlin4aoR/
 7OqcHaPfe+fEwqQsHGyhxAeu1BqqpV/4eLeLCmUa1HYIpRDmqd3BOcM+fiTZ4XUMBxGsD/oKkFd
 NlP6dCrsDDWmXFP+xlg==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d87fa4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mB1rp7TKJbXamDPS5sgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: e6mFiJcFFwK7u8cAVzpKxT2fb9FDrAVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100040
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

Implement device selection syntax allowing users to specify the
target block device using "N:partition" format, where N is the
device number. This enables operations like "fastboot flash 0:gpt"
to write partition tables to specific devices. When no device is
specified, the default from CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID
is used.

Example usage for partition flashing:
  fastboot flash 0:boot boot.img      # Flash to device 0
  fastboot flash 1:system system.img  # Flash to device 1
  fastboot flash boot boot.img        # Use default device

Example usage for GPT/MBR operations:
  fastboot flash 0:gpt gpt.img        # Write GPT to device 0
  fastboot flash 1:mbr mbr.img        # Write MBR to device 1

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig    |   4 +-
 drivers/fastboot/fb_block.c | 196 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 186 insertions(+), 14 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 576c3ef8a45..43d83265df4 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -227,7 +227,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
 
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
-	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
 	default "gpt"
 	help
 	  The fastboot "flash" command supports writing the downloaded
@@ -240,7 +240,7 @@ config FASTBOOT_GPT_NAME
 
 config FASTBOOT_MBR_NAME
 	string "Target name for updating MBR"
-	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && DOS_PARTITION
 	default "mbr"
 	help
 	  The fastboot "flash" command allows to write the downloaded image
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 51d1abb18c7..c2c3a285d77 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -11,6 +11,7 @@
 #include <image-sparse.h>
 #include <malloc.h>
 #include <part.h>
+#include <vsprintf.h>
 
 /**
  * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
@@ -124,6 +125,79 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
 	return blkcnt;
 }
 
+/**
+ * parse_device_partition() - Parse device:partition format
+ * @part_name: Input string in format "N:partition" or "partition"
+ * @device: Output device number
+ * @partition_name: Output partition name pointer
+ *
+ * Parses the input string to extract device number and partition name.
+ * If no device is specified, uses the default from config.
+ */
+static void parse_device_partition(const char *part_name, int *device,
+				   const char **partition_name)
+{
+	const char *colon_pos;
+
+	/* Default: no device specified, use config default */
+	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	*partition_name = part_name;
+
+	/* Override if device:partition format detected */
+	colon_pos = strchr(part_name, ':');
+	if (colon_pos && colon_pos > part_name) {
+		*device = simple_strtoul(part_name, NULL, 10);
+		*partition_name = colon_pos + 1;
+	}
+}
+
+/**
+ * get_block_device() - Get block device descriptor
+ * @interface: Block interface name (e.g., "mmc", "scsi")
+ * @device: Device number
+ * @response: Fastboot response buffer
+ *
+ * Returns: Block device descriptor or NULL on error
+ */
+static struct blk_desc *get_block_device(const char *interface, int device,
+					 char *response)
+{
+	struct blk_desc *dev_desc;
+
+	if (!interface || !strcmp(interface, "")) {
+		fastboot_fail("block interface isn't provided", response);
+		return NULL;
+	}
+
+	dev_desc = blk_get_dev(interface, device);
+	if (!dev_desc)
+		fastboot_fail("no such device", response);
+
+	return dev_desc;
+}
+
+/**
+ * is_partition_table_name() - Check if name matches partition table target
+ * @part_name: Partition name to check
+ * @table_name: Config name for partition table (e.g., "gpt", "mbr")
+ *
+ * Returns: true if part_name matches table_name (with or without device prefix)
+ */
+static bool is_partition_table_name(const char *part_name, const char *table_name)
+{
+	const char *colon_pos;
+
+	if (strcmp(part_name, table_name) == 0)
+		return true;
+
+	colon_pos = strchr(part_name, ':');
+	if (colon_pos && strcmp(colon_pos + 1, table_name) == 0)
+		return true;
+
+	return false;
+}
+
 int fastboot_block_get_part_info(const char *part_name,
 				 struct blk_desc **dev_desc,
 				 struct disk_partition *part_info,
@@ -133,25 +207,21 @@ int fastboot_block_get_part_info(const char *part_name,
 	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
 						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
 						   NULL);
-	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	int device;
+	const char *partition_name;
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
 		return -ENOENT;
 	}
-	if (!interface || !strcmp(interface, "")) {
-		fastboot_fail("block interface isn't provided", response);
-		return -EINVAL;
-	}
 
-	*dev_desc = blk_get_dev(interface, device);
-	if (!dev_desc) {
-		fastboot_fail("no such device", response);
+	parse_device_partition(part_name, &device, &partition_name);
+
+	*dev_desc = get_block_device(interface, device, response);
+	if (!*dev_desc)
 		return -ENODEV;
-	}
 
-	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
+	ret = part_get_info_by_name(*dev_desc, partition_name, part_info);
 	if (ret < 0)
 		fastboot_fail("failed to get partition info", response);
 
@@ -310,12 +380,114 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
 		fastboot_okay(NULL, response);
 }
 
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+/**
+ * flash_gpt_partition_table() - Flash GPT partition table
+ * @part_name: Partition name (format: "gpt" or "N:gpt")
+ * @download_buffer: Buffer containing GPT data
+ * @response: Fastboot response buffer
+ */
+static void flash_gpt_partition_table(const char *part_name, void *download_buffer,
+				      char *response)
+{
+	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						   NULL);
+	struct blk_desc *dev_desc;
+	int device;
+	const char *partition_name;
+
+	parse_device_partition(part_name, &device, &partition_name);
+
+	dev_desc = get_block_device(interface, device, response);
+	if (!dev_desc)
+		return;
+
+	printf("%s: updating MBR, Primary and Backup GPT(s) on %s device %d\n",
+	       __func__, interface, dev_desc->devnum);
+
+	if (is_valid_gpt_buf(dev_desc, download_buffer)) {
+		printf("%s: invalid GPT - refusing to write to flash\n", __func__);
+		fastboot_fail("invalid GPT partition", response);
+		return;
+	}
+
+	if (write_mbr_and_gpt_partitions(dev_desc, download_buffer)) {
+		printf("%s: writing GPT partitions failed\n", __func__);
+		fastboot_fail("writing GPT partitions failed", response);
+		return;
+	}
+
+	part_init(dev_desc);
+	printf("........ success\n");
+	fastboot_okay(NULL, response);
+}
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+/**
+ * flash_mbr_partition_table() - Flash MBR partition table
+ * @part_name: Partition name (format: "mbr" or "N:mbr")
+ * @download_buffer: Buffer containing MBR data
+ * @response: Fastboot response buffer
+ */
+static void flash_mbr_partition_table(const char *part_name, void *download_buffer,
+				      char *response)
+{
+	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						   NULL);
+	struct blk_desc *dev_desc;
+	int device;
+	const char *partition_name;
+
+	parse_device_partition(part_name, &device, &partition_name);
+
+	dev_desc = get_block_device(interface, device, response);
+	if (!dev_desc)
+		return;
+
+	printf("%s: updating MBR on %s device %d\n", __func__, interface,
+	       dev_desc->devnum);
+
+	if (is_valid_dos_buf(download_buffer)) {
+		printf("%s: invalid MBR - refusing to write to flash\n", __func__);
+		fastboot_fail("invalid MBR partition", response);
+		return;
+	}
+
+	if (write_mbr_sector(dev_desc, download_buffer)) {
+		printf("%s: writing MBR partition failed\n", __func__);
+		fastboot_fail("writing MBR partition failed", response);
+		return;
+	}
+
+	part_init(dev_desc);
+	printf("........ success\n");
+	fastboot_okay(NULL, response);
+}
+#endif
+
 void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 				u32 download_bytes, char *response)
 {
 	struct blk_desc *dev_desc;
 	struct disk_partition part_info;
 
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
+		flash_gpt_partition_table(part_name, download_buffer, response);
+		return;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
+		flash_mbr_partition_table(part_name, download_buffer, response);
+		return;
+	}
+#endif
+
 	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
 		return;
 
@@ -326,4 +498,4 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 		fastboot_block_write_raw_image(dev_desc, &part_info, part_name,
 					       download_buffer, download_bytes, response);
 	}
-}
+}
\ No newline at end of file

-- 
2.34.1

