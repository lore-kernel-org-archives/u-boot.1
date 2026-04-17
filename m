Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16269F43698
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B4A8428C;
	Fri, 17 Apr 2026 14:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6GuMWhc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CLgUpnw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAEC8428C; Fri, 17 Apr 2026 14:11:26 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E92D842A4
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H80L8t1872640
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p2ECGlyWwxS
 gIvsL0wEOoDmQMzp6g2LREOsPUY/1mM4=; b=o6GuMWhcLnWqbd1uagfri421Mb5
 hbGi7BMHrqGXHUNXcf00wLy4JqTLq8PrLcpBW7JRON4jVJaCjR+kdQG3qNth8OQt
 oI+Z1M2PNSZWTzqAnlmAnQPvAWzr6c6wNm74gvz+t8mbNqlEEKxoFrnBKkebSr9A
 M5+r6yh3IU9SjUtBPebxPvWPvwkdDPwqAQ/jYdGr1VNDn27FDdXUOvyjk7Ef9P1T
 sP7CuFmQfdJ4fJTACKco2xd/+SEIQV3Usj7Cc9Si6rPJDpfv6ugx/GdJFc/KltC2
 dkWVdtblLjxMG6/kxZwB9RWSfTR5OPsx0lUTcX8CPNP4jpvhBDR1IoBVFkA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2knby0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f0f2b2641so440942b3a.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427882; x=1777032682; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p2ECGlyWwxSgIvsL0wEOoDmQMzp6g2LREOsPUY/1mM4=;
 b=CLgUpnw2GdsPYhS/XDAltCL8cQ2xXohcHLms84KrrVdyj3QgQwLezmdIc5MVnH/ltR
 X/qbQuNwnnaCeIEtCHI3v8M4/pyvbszs96KF/JDcbLnjVWJwU3jfzPsOScblTiin8m05
 0zhj+2FrBgwfIxnVjjGW31CLChxrYHu8aOJUTkjMmbYP2XUCoseFc/WTrjuo5tVLc+v8
 lOLAfAC/ok6oLz3gk0Cln3JJwfxrxdlDVCKqxBujvpqVNqCDCl7mc5LCQd2odUsD2bOG
 v+JSyHAYMfZFcKKbl4/68ohOXab70ZB0jU0LlwhD8Z7rAokrswkV8B4uyzP7PWYR9ZQH
 RewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427882; x=1777032682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p2ECGlyWwxSgIvsL0wEOoDmQMzp6g2LREOsPUY/1mM4=;
 b=Tdv/Qqguo/NdFyz5SBf+SX3HQZjD1L6d5pTrE9hxl31YFlaA/c+Nfbh4xoKRzBUNav
 1CTdpKZJAiCBaJ0NIvpRmfYHDHUsuDszdjactlqr+UTyvYSU/BPCO9liGh4syljlgUTC
 zgruPIpAGT3q9G4Jthoa4QlcK4OmPNKwPkk2K+l09bEYGZXk7JiLlCIupkjGMuHI2Ene
 jN6ebVJiBf7pEYM0c1WbDYSEPMASCrwB10ZmeGiEw3apvSxrV5g06yylfLzlJyHHd2WJ
 QCEZk2DgQd6E7TMcgqZXUGziCUGr4FVOKjJsYpiO/VN8YiFouKyeiAadz42HFoUxmkHZ
 qKhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ogBx9Sy3j5fIN0C3zOvR1JWx8NBSF/1ZbnzekmYvqrUdl/bJb2AZG0L+GfStRzms1Tywdgms=@lists.denx.de
X-Gm-Message-State: AOJu0YxpTkmxU0+44G8nGu6xEZROOz6APUEEDnjges/SufbhMuqCsIJV
 WKWYLpees06iLrgkUfibzTDgGrLFTl8uR5zpZBK8I/ppB61HDxP2xgiouwNVhQwULFsb5rDzWa8
 gyVV+REXpzBOg9JMKdGvZTVTIOY+mHj8VvghZpeQ4VIHAI5vf6nBnvu4R
X-Gm-Gg: AeBDieuufa8O2r0Xivo/tM0MfZiWqfFn6OOWH+/+eUvvAKHXjMphgg1BTcIZSFrqJeu
 o7sa9u4DuVGBvj1IW6XBoB1vlnLN6y7+cd6Li+/jYiRJMrBmKrE79rL0n7xhdMqctOKl2Aa2xqp
 i7ICYNA7xCKLmdez2pQjiNy9c3AuWs1V+30/S8H3NWFQef1rlB+fODO/mXdU8IYpwPvbsPqx5ib
 tXl5I8st8mcpB79qa6hI0myUAgEjXnysJnyK5vJF7oKAN2n1Dem3IrimImLAPZGTXSHl3FKhdzc
 AkQ3PEJHIwNPLHxvwoNv4y3RicjiRkCVxG4JNKQNF8lJ/bvKomwl/lmKQTi84wP2QmTaqnBiP/v
 ClWBT8SCfTbaBM073nPzF9CIN60Drun4pqHMsXvRRrKKz8FO1hkJMk3eO4DNQ5u8L4S3Veit3Nk
 KXNzGiKCM/l53uO8U9WORwsaGdasDGy577AuoVMFfpjto57q0hUIE=
X-Received: by 2002:a05:6a00:90a8:b0:82c:7eb1:4d61 with SMTP id
 d2e1a72fcca58-82f8c8bb03amr2376597b3a.32.1776427881366; 
 Fri, 17 Apr 2026 05:11:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a8:b0:82c:7eb1:4d61 with SMTP id
 d2e1a72fcca58-82f8c8bb03amr2376549b3a.32.1776427880757; 
 Fri, 17 Apr 2026 05:11:20 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:11:20 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 5/7] mkimage: add fatfs image type for FAT partition images
Date: Fri, 17 Apr 2026 17:39:49 +0530
Message-Id: <20260417120951.3454249-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9guJCkTujK2BCnxjF4SsvTOKHv-X1EWC
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e2236a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=KD3lojeL17VxHfHb3aMA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 9guJCkTujK2BCnxjF4SsvTOKHv-X1EWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfX+PEoFuyWtjzt
 xlDdteVi7Xa2KPOlGMDgf5WSuD5g3aYHyIEsCGnzLTr7ZppzT7Tp/GdTtl4pLD0SDiibyfDzhaw
 5UKbpgJgXa6v20mrGvUnM2sy3d+VbELCBLaYK0V5OsGLHYIqOzUqDvpvXx5vBVXKv/E4iEtnvIy
 ZaDHqgEr4zGVcZ08rA51RNWQwUS+gTqK4s/F3Qaz1GpvU563Sc6BDY+d+CVazsJof4jZD3aefmL
 bYU8K3zM2j5UXJck8cBE1ZMsf9t5FJqNQrDURD7gEyzEXecAstqLXjUV825xuJl0Np9YTkH532f
 Lc6D4kW3dwJKYoIX+xiv/BZy4MviODOUX8LwLhEW4xqIuF06ntIOKqjV7oaAP2MZZvnkYtLdqis
 mQVMCWuFLUjeBhhbyCXRM0Z911Ge93GaZlheNt9YlqbY/pL8uUfCiqRWprg8mgdwwZCgtXmxfNe
 ICjx6W69rv1r42ySfyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170122
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

Add a new mkimage image type 'fatfs' that creates a raw FAT
filesystem partition image from a directory of files.

The image handler (fatimage.c) uses mkfs.vfat (dosfstools)
to format the image and mcopy (mtools) to populate it. The
image size is calculated automatically from the input
directory size plus FAT metadata overhead.

New long options added to mkimage:
  --fat-extra-space <KB>  extra padding (default: 512 KB)
  --fat-type <0|12|16|32> FAT type (0 = auto-detect)
  --fat-volume-id <label> volume label (default: BOOT)
  --fat-mkfs-opts <opts>  extra mkfs.vfat options

Usage:
  mkimage -T fatfs -d <input-dir> \
      --fat-extra-space 512 \
      --fat-volume-id "MYBOOT" \
      --fat-mkfs-opts "-S 512 -a" \
      output.img

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 tools/Makefile   |   1 +
 tools/fatimage.c | 495 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/fatimage.h |  25 +++
 tools/mkimage.c  |  21 ++
 tools/mkimage.h  |  15 ++
 5 files changed, 557 insertions(+)
 create mode 100644 tools/fatimage.c
 create mode 100644 tools/fatimage.h

diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecda..2f6c9363209 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -112,6 +112,7 @@ ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
 dumpimage-mkimage-objs := aisimage.o \
 			amlimage.o \
 			atmelimage.o \
+			fatimage.o \
 			$(FIT_OBJS-y) \
 			$(FIT_SIG_OBJS-y) \
 			$(FIT_CIPHER_OBJS-y) \
diff --git a/tools/fatimage.c b/tools/fatimage.c
new file mode 100644
index 00000000000..6a199c70f5b
--- /dev/null
+++ b/tools/fatimage.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FAT Filesystem Image support for mkimage
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries
+ *
+ * This tool creates FAT filesystem images from a directory of files.
+ * It uses system tools (mkfs.vfat and mcopy from mtools) to create
+ * the filesystem image.
+ */
+
+#include "imagetool.h"
+#include "mkimage.h"
+#include "fatimage.h"
+#include <image.h>
+#include <sys/stat.h>
+#include <dirent.h>
+#include <errno.h>
+
+static struct fatimage_params fatparams = {
+	.input_dir = NULL,
+	.extra_space = 512,
+	.fat_type = 0,
+	.volume_id = "BOOT",
+	.mkfs_opts = "-S 512",
+};
+
+/* Cached image size to avoid recalculation between vrec_header and set_header */
+static int cached_image_size_kb = -1;
+
+/**
+ * get_directory_size_kb() - Return the total disk usage of a directory in KB
+ * @path: Path to the directory
+ *
+ * Runs 'du -sk' to measure the on-disk size of all files under @path.
+ *
+ * Return: size in KB on success, -1 on error
+ */
+static int get_directory_size_kb(const char *path)
+{
+	char cmd[1024];
+	FILE *fp;
+	int size_kb = 0;
+
+	snprintf(cmd, sizeof(cmd), "du -sk \"%s\" 2>/dev/null | cut -f1", path);
+
+	fp = popen(cmd, "r");
+	if (!fp) {
+		fprintf(stderr, "Error: Failed to execute du command\n");
+		return -1;
+	}
+
+	if (fscanf(fp, "%d", &size_kb) != 1) {
+		fprintf(stderr, "Error: Failed to read directory size\n");
+		pclose(fp);
+		return -1;
+	}
+
+	pclose(fp);
+	return size_kb;
+}
+
+/**
+ * count_entries() - Recursively count files and subdirectories under a path
+ * @path: Directory to scan
+ * @files: Incremented for each regular file found
+ * @dirs: Incremented for each subdirectory found
+ *
+ * Used to estimate FAT directory entry overhead when sizing the image.
+ *
+ * Return: 0 on success, -1 if the directory cannot be opened
+ */
+static int count_entries(const char *path, int *files, int *dirs)
+{
+	DIR *dir;
+	struct dirent *entry;
+	struct stat st;
+	char full_path[1024];
+
+	dir = opendir(path);
+	if (!dir) {
+		fprintf(stderr, "Error: Cannot open directory %s: %s\n",
+			path, strerror(errno));
+		return -1;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strcmp(entry->d_name, ".") == 0 ||
+		    strcmp(entry->d_name, "..") == 0)
+			continue;
+
+		snprintf(full_path, sizeof(full_path), "%s/%s", path, entry->d_name);
+
+		if (stat(full_path, &st) < 0) {
+			fprintf(stderr, "Warning: Cannot stat %s: %s\n",
+				full_path, strerror(errno));
+			continue;
+		}
+
+		if (S_ISDIR(st.st_mode)) {
+			(*dirs)++;
+			count_entries(full_path, files, dirs);
+		} else {
+			(*files)++;
+		}
+	}
+
+	closedir(dir);
+	return 0;
+}
+
+/**
+ * calculate_image_size() - Compute the required FAT image size in KB
+ * @input_dir: Directory whose contents will be packed into the image
+ * @extra_space: Additional padding in KB to add beyond the data size
+ * @fat_type: Requested FAT type (0=auto, 12, 16, 32)
+ *
+ * Calculates the minimum image size needed to hold all files in @input_dir
+ * plus FAT metadata overhead (directory entries, two FAT copies) and
+ * @extra_space KB of padding. The result is cached in cached_image_size_kb
+ * so that vrec_header and set_header agree on the same value.
+ *
+ * Return: image size in KB on success, -1 on error
+ */
+static int calculate_image_size(const char *input_dir, int extra_space,
+				 int fat_type)
+{
+	int data_kb;
+	int sectors;
+	int files = 0, dirs = 0;
+	int dir_bytes, fat_bytes;
+	int dir_sectors, fat_sectors;
+	int fat_entry_size;
+	int total_sectors;
+	int blocks;
+
+	if (cached_image_size_kb > 0)
+		return cached_image_size_kb;
+
+	data_kb = get_directory_size_kb(input_dir);
+	if (data_kb < 0)
+		return -1;
+
+	sectors = data_kb * 2;
+
+	if (count_entries(input_dir, &files, &dirs) < 0)
+		return -1;
+
+	dir_bytes = (files + dirs) * DIR_ENTRY_SIZE;
+	dir_bytes += dirs * DIR_ENTRY_SIZE;
+
+	if (fat_type == 32) {
+		fat_entry_size = FAT_ENTRY_SIZE_FAT32;
+		if ((sectors / 2 + extra_space) < 32 * 1024) {
+			fprintf(stderr, "Warning: Image size %d KB may be too small for FAT32\n",
+				(sectors / 2 + extra_space));
+			fprintf(stderr, "         FAT32 works best with images >= 32 MB\n");
+			fprintf(stderr, "         Consider using auto-detect or FAT16 instead\n");
+		}
+	} else if (fat_type == 0) {
+		if ((sectors / 2 + extra_space) > 512 * 1024)
+			fat_entry_size = FAT_ENTRY_SIZE_FAT32;
+		else
+			fat_entry_size = FAT_ENTRY_SIZE_FAT16;
+	} else if (fat_type == 16) {
+		fat_entry_size = FAT_ENTRY_SIZE_FAT16;
+	} else if (fat_type == 12) {
+		fat_entry_size = FAT_ENTRY_SIZE_FAT12;
+	} else {
+		fat_entry_size = FAT_ENTRY_SIZE_FAT16;
+	}
+
+	fat_bytes = sectors * fat_entry_size;
+	fat_bytes += dirs * fat_entry_size;
+
+	dir_sectors = (dir_bytes + SECTOR_SIZE - 1) / SECTOR_SIZE;
+	fat_sectors = ((fat_bytes + SECTOR_SIZE - 1) / SECTOR_SIZE) * 2;
+
+	total_sectors = sectors + dir_sectors + fat_sectors;
+	blocks = (total_sectors / 2) + extra_space;
+
+	printf("FAT image size calculation:\n");
+	printf("  Data size: %d KB (%d sectors)\n", data_kb, sectors);
+	printf("  Files: %d, Directories: %d\n", files, dirs);
+	printf("  Directory overhead: %d sectors\n", dir_sectors);
+	printf("  FAT overhead: %d sectors (2 FATs)\n", fat_sectors);
+	printf("  Extra padding: %d KB\n", extra_space);
+	printf("  Total image size: %d KB\n", blocks);
+
+	cached_image_size_kb = blocks;
+
+	return blocks;
+}
+
+/**
+ * create_fat_image() - Format a FAT image file and populate it with files
+ * @input_dir: Source directory; all contents are copied into the image
+ * @output_file: Path of the FAT image file to create
+ * @blocks: Image size in KB (passed to mkfs.vfat as the block count)
+ * @fat_type: FAT type to use (0=auto, 12, 16, 32)
+ * @volume_id: FAT volume label string
+ * @mkfs_opts: Additional options forwarded to mkfs.vfat
+ *
+ * Calls mkfs.vfat to format @output_file as a FAT filesystem, then uses
+ * mcopy to copy all files from @input_dir into the image root.
+ *
+ * Return: 0 on success, -1 on error
+ */
+static int create_fat_image(const char *input_dir, const char *output_file,
+			    int blocks, int fat_type, const char *volume_id,
+			    const char *mkfs_opts)
+{
+	char cmd[2048];
+	int ret;
+
+	unlink(output_file);
+
+	if (fat_type > 0) {
+		snprintf(cmd, sizeof(cmd),
+			 "mkfs.vfat -F %d %s -n \"%s\" -C \"%s\" %d",
+			 fat_type, mkfs_opts ? mkfs_opts : "",
+			 volume_id, output_file, blocks);
+	} else {
+		if (blocks > 512 * 1024) {
+			snprintf(cmd, sizeof(cmd),
+				 "mkfs.vfat -F 32 %s -n \"%s\" -C \"%s\" %d",
+				 mkfs_opts ? mkfs_opts : "",
+				 volume_id, output_file, blocks);
+		} else {
+			snprintf(cmd, sizeof(cmd),
+				 "mkfs.vfat %s -n \"%s\" -C \"%s\" %d",
+				 mkfs_opts ? mkfs_opts : "",
+				 volume_id, output_file, blocks);
+		}
+	}
+
+	printf("Creating FAT filesystem: %s\n", cmd);
+	ret = system(cmd);
+	if (ret != 0) {
+		fprintf(stderr, "Error: mkfs.vfat failed with code %d\n", ret);
+		fprintf(stderr, "Make sure mkfs.vfat (dosfstools) is installed\n");
+		return -1;
+	}
+
+	snprintf(cmd, sizeof(cmd),
+		 "MTOOLS_SKIP_CHECK=1 mcopy -i \"%s\" -s \"%s\"/* ::/",
+		 output_file, input_dir);
+
+	printf("Copying files: %s\n", cmd);
+	ret = system(cmd);
+	if (ret != 0) {
+		fprintf(stderr, "Error: mcopy failed with code %d\n", ret);
+		fprintf(stderr, "Make sure mcopy (mtools) is installed\n");
+		return -1;
+	}
+
+	printf("FAT image created successfully: %s\n", output_file);
+	return 0;
+}
+
+/**
+ * fatimage_check_params() - Validate mkimage parameters for the fatfs type
+ * @params: mkimage tool parameters (unused; input dir is in fatparams)
+ *
+ * Verifies that an input directory has been specified via fatimage_set_dir()
+ * and that it exists and is a directory.
+ *
+ * Return: 0 if parameters are valid, -1 on error
+ */
+static int fatimage_check_params(struct image_tool_params *params)
+{
+	if (!fatparams.input_dir) {
+		fprintf(stderr, "Error: Input directory not specified\n");
+		fprintf(stderr, "Use -d <directory> to specify input directory\n");
+		return -1;
+	}
+
+	struct stat st;
+	if (stat(fatparams.input_dir, &st) < 0) {
+		fprintf(stderr, "Error: Input directory '%s' does not exist: %s\n",
+			fatparams.input_dir, strerror(errno));
+		return -1;
+	}
+
+	if (!S_ISDIR(st.st_mode)) {
+		fprintf(stderr, "Error: '%s' is not a directory\n",
+			fatparams.input_dir);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * fatimage_check_image_type() - Report whether this handler owns a given type
+ * @type: IH_TYPE_* value to check
+ *
+ * Return: EXIT_SUCCESS if @type == IH_TYPE_FATFS, EXIT_FAILURE otherwise
+ */
+static int fatimage_check_image_type(uint8_t type)
+{
+	if (type == IH_TYPE_FATFS)
+		return EXIT_SUCCESS;
+	return EXIT_FAILURE;
+}
+
+/**
+ * fatimage_verify_header() - Verify that a buffer contains a valid FAT image
+ * @ptr: Pointer to the start of the image data
+ * @image_size: Total size of the image in bytes
+ * @params: mkimage tool parameters (unused)
+ *
+ * Checks for the FAT boot sector signature (0x55AA) at bytes 510-511.
+ *
+ * Return: 0 if the signature is present, -1 otherwise
+ */
+static int fatimage_verify_header(unsigned char *ptr, int image_size,
+				  struct image_tool_params *params)
+{
+	if (image_size < 512)
+		return -1;
+
+	if (ptr[510] != 0x55 || ptr[511] != 0xAA) {
+		fprintf(stderr, "Error: Not a valid FAT filesystem image\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * fatimage_print_header() - Print human-readable FAT image information
+ * @ptr: Pointer to the start of the image data
+ * @params: mkimage tool parameters (unused)
+ *
+ * Prints the boot signature, detected FAT type (FAT32 vs FAT12/16),
+ * and volume label read from the BPB.
+ */
+static void fatimage_print_header(const void *ptr,
+				  struct image_tool_params *params)
+{
+	const unsigned char *buf = ptr;
+
+	printf("FAT Filesystem Image\n");
+	printf("  Boot signature: 0x%02X%02X\n", buf[511], buf[510]);
+
+	if (buf[82] == 'F' && buf[83] == 'A' && buf[84] == 'T' &&
+	    buf[85] == '3' && buf[86] == '2') {
+		printf("  Filesystem: FAT32\n");
+		printf("  Volume label: %.11s\n", &buf[71]);
+	} else {
+		printf("  Filesystem: FAT12/FAT16\n");
+		printf("  Volume label: %.11s\n", &buf[43]);
+	}
+}
+
+/**
+ * fatimage_vrec_header() - Allocate the output buffer for the FAT image
+ * @params: mkimage tool parameters
+ * @tparams: image type parameters; hdr and header_size are set on success
+ *
+ * Called before set_header to pre-allocate a buffer large enough for the
+ * complete FAT image. The size is calculated from the input directory and
+ * cached for reuse by fatimage_set_header().
+ *
+ * Return: 0 on success, -1 on error
+ */
+static int fatimage_vrec_header(struct image_tool_params *params,
+				struct image_type_params *tparams)
+{
+	int blocks;
+	int image_size_bytes;
+
+	blocks = calculate_image_size(fatparams.input_dir,
+				      fatparams.extra_space,
+				      fatparams.fat_type);
+	if (blocks < 0) {
+		fprintf(stderr, "Error: Failed to calculate image size\n");
+		return -1;
+	}
+
+	image_size_bytes = blocks * 1024;
+
+	tparams->hdr = malloc(image_size_bytes);
+	if (!tparams->hdr) {
+		fprintf(stderr, "Error: Failed to allocate %d bytes for FAT image\n",
+			image_size_bytes);
+		return -1;
+	}
+
+	tparams->header_size = image_size_bytes;
+
+	return 0;
+}
+
+/**
+ * fatimage_set_header() - Create the FAT image and load it into the buffer
+ * @ptr: Output buffer (allocated by fatimage_vrec_header)
+ * @sbuf: stat of the output file (unused)
+ * @ifd: file descriptor of the output file (unused)
+ * @params: mkimage tool parameters; imagefile is used for the temp file name
+ *
+ * Creates the FAT image in a temporary file using mkfs.vfat and mcopy,
+ * reads the result into @ptr, then removes the temporary file.
+ *
+ * Return: 0 on success, -1 on error
+ */
+static int fatimage_set_header(void *ptr, struct stat *sbuf, int ifd,
+			       struct image_tool_params *params)
+{
+	int blocks;
+	int ret;
+	char temp_file[256];
+	FILE *fp;
+	size_t bytes_read;
+
+	snprintf(temp_file, sizeof(temp_file), "%s.tmp", params->imagefile);
+
+	blocks = calculate_image_size(fatparams.input_dir,
+				      fatparams.extra_space,
+				      fatparams.fat_type);
+	if (blocks < 0) {
+		fprintf(stderr, "Error: Failed to calculate image size\n");
+		return -1;
+	}
+
+	ret = create_fat_image(fatparams.input_dir, temp_file,
+			       blocks, fatparams.fat_type,
+			       fatparams.volume_id, fatparams.mkfs_opts);
+	if (ret < 0) {
+		fprintf(stderr, "Error: Failed to create FAT image\n");
+		return -1;
+	}
+
+	fp = fopen(temp_file, "rb");
+	if (!fp) {
+		fprintf(stderr, "Error: Failed to open temporary file %s: %s\n",
+			temp_file, strerror(errno));
+		unlink(temp_file);
+		return -1;
+	}
+
+	bytes_read = fread(ptr, 1, blocks * 1024, fp);
+	fclose(fp);
+	unlink(temp_file);
+
+	if (bytes_read != (size_t)(blocks * 1024)) {
+		fprintf(stderr, "Error: Failed to read FAT image (read %zu, expected %d)\n",
+			bytes_read, blocks * 1024);
+		return -1;
+	}
+
+	printf("FAT image created successfully in buffer\n");
+	return 0;
+}
+
+U_BOOT_IMAGE_TYPE(
+	fatfsimage,
+	"FAT Filesystem Image",
+	0,
+	NULL,
+	fatimage_check_params,
+	fatimage_verify_header,
+	fatimage_print_header,
+	fatimage_set_header,
+	NULL,
+	fatimage_check_image_type,
+	NULL,
+	fatimage_vrec_header
+);
+
+void fatimage_set_dir(const char *dir)
+{
+	fatparams.input_dir = strdup(dir);
+}
+
+void fatimage_set_extra_space(int space_kb)
+{
+	fatparams.extra_space = space_kb;
+}
+
+void fatimage_set_fat_type(int type)
+{
+	fatparams.fat_type = type;
+}
+
+void fatimage_set_volume_id(const char *volid)
+{
+	fatparams.volume_id = strdup(volid);
+}
+
+void fatimage_set_mkfs_opts(const char *opts)
+{
+	fatparams.mkfs_opts = strdup(opts);
+}
diff --git a/tools/fatimage.h b/tools/fatimage.h
new file mode 100644
index 00000000000..8822724925c
--- /dev/null
+++ b/tools/fatimage.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * FAT Filesystem Image support for mkimage
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#ifndef _FATIMAGE_H_
+#define _FATIMAGE_H_
+
+#define SECTOR_SIZE 512
+#define DIR_ENTRY_SIZE 32
+#define FAT_ENTRY_SIZE_FAT32 4
+#define FAT_ENTRY_SIZE_FAT16 2
+#define FAT_ENTRY_SIZE_FAT12 2  /* Rounded up from 1.5 bytes */
+
+struct fatimage_params {
+	char *input_dir;
+	int extra_space;      /* Extra padding space in KB (default: 512) */
+	int fat_type;         /* FAT type: 0=auto, 12/16/32 */
+	char *volume_id;      /* Volume label (default: "BOOT") */
+	char *mkfs_opts;      /* Extra mkfs.vfat options (default: "-S 512") */
+};
+
+#endif /* _FATIMAGE_H_ */
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 3c43962807d..9fbc9b52957 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -204,6 +204,10 @@ static const struct option longopts[] = {
 	{ "tfa-bl31-addr", no_argument, NULL, 'Y' },
 	{ "tee-file", no_argument, NULL, 'z' },
 	{ "tee-addr", no_argument, NULL, 'Z' },
+{ "fat-extra-space", required_argument, NULL, OPT_FAT_EXTRA },
+	{ "fat-type", required_argument, NULL, OPT_FAT_TYPE },
+	{ "fat-volume-id", required_argument, NULL, OPT_FAT_VOLID },
+	{ "fat-mkfs-opts", required_argument, NULL, OPT_FAT_MKFS },
 	{ /* sentinel */ },
 };
 
@@ -397,6 +401,18 @@ static void process_args(int argc, char **argv)
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case OPT_FAT_EXTRA:
+			fatimage_set_extra_space(atoi(optarg));
+			break;
+		case OPT_FAT_TYPE:
+			fatimage_set_fat_type(atoi(optarg));
+			break;
+		case OPT_FAT_VOLID:
+			fatimage_set_volume_id(optarg);
+			break;
+		case OPT_FAT_MKFS:
+			fatimage_set_mkfs_opts(optarg);
+			break;
 		default:
 			usage("Invalid option");
 		}
@@ -433,6 +449,11 @@ static void process_args(int argc, char **argv)
 		params.type = type;
 	}
 
+	if (params.type == IH_TYPE_FATFS && params.datafile) {
+		fatimage_set_dir(params.datafile);
+		params.skipcpy = 1;
+	}
+
 	if (!params.imagefile)
 		usage("Missing output filename");
 }
diff --git a/tools/mkimage.h b/tools/mkimage.h
index 5d6bcc9301a..599f92e617f 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -53,4 +53,19 @@ static inline ulong map_to_sysmem(const void *ptr)
 #define MKIMAGE_DEFAULT_DTC_OPTIONS	"-I dts -O dtb -p 500"
 #define MKIMAGE_MAX_DTC_CMDLINE_LEN	2 * MKIMAGE_MAX_TMPFILE_LEN + 35
 
+/* Long option values for mkimage */
+enum {
+	OPT_FAT_EXTRA = 512,
+	OPT_FAT_TYPE,
+	OPT_FAT_VOLID,
+	OPT_FAT_MKFS,
+};
+
+/* FAT image functions */
+void fatimage_set_dir(const char *dir);
+void fatimage_set_extra_space(int space_kb);
+void fatimage_set_fat_type(int type);
+void fatimage_set_volume_id(const char *volid);
+void fatimage_set_mkfs_opts(const char *opts);
+
 #endif /* _MKIIMAGE_H_ */
-- 
2.34.1

