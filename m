Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE044F31E3D
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD85F84105;
	Thu,  9 Apr 2026 17:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCcePmoN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aslZFf5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEDF84099; Thu,  9 Apr 2026 16:44:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F6783CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 16:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639ACesl1727413
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BKJ5oFYiXc+M8jgsNod0+ZBiakITyVze44e4H2WEVSc=; b=KCcePmoNUl7JGCzS
 joqt+D8BpfJrkVKb6T6zmCxjXRCJ9bhdBu9vZ/7zyvu0oIuusKI+BhhU9ygdMOf0
 JieXR1PP56MKp+FRCnf9/zGrBy7eu98Qg2fIbXPOhJ67PS3hHl8K9ugi/3J8UpN3
 9DPggQGrjUaTfcax0ZmYf+bSw10fVR1WLyJ2Lpz0bVhcVvJPzSEDisoi944SaCos
 E20L09dGzEoS4XGN6BNf0fpkmyVaZYcBjdapyZk6DCQf0o1VGboFI4IQ73ZmS6iH
 5x0WGoTIrTMnkxAL2zDxow5OUGW8lhHhUudUZ/enhwn1qjopeJfy6a/KO4Hejq24
 Es7DtA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddwcrutds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 14:43:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24e45271cso12938135ad.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775745834; x=1776350634; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BKJ5oFYiXc+M8jgsNod0+ZBiakITyVze44e4H2WEVSc=;
 b=aslZFf5S4jDvvyZGIpZ1CrJKTgZY3mB1eno6nARLGyUDK1ntQ8Sa8V3Mbht51c3cY5
 Bd6urZtsu75wDeQWEZxdfWytReXMyj/IpNG7RL+Yy24xm0KXololffn2JJz1BWfJrrAL
 Sci/7ks9NE/3YeKFZAAw9BF7kiB0Hv3cuRLLJ2WcA0CXhpH5e3qJixJCUxb2XB2G/Ctc
 EGM5nT0KXH53TT4KLNi998t0jFbGpuDHHtieIWmamjeWir8MZbBaPZFdXO7mGOA/Clzz
 XuwP6eCB9qdwrxmC8ljuW+E9277y9yz5QJgdsK7QDBZcba9YS/Sknag3k1KCjn6Mm16a
 wYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775745834; x=1776350634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BKJ5oFYiXc+M8jgsNod0+ZBiakITyVze44e4H2WEVSc=;
 b=V/Tf/IuX0sdejum3mLUugJBWy1qFT+vQaukLkqq4WzlFFTIbxUMXTB5dTDC6ING61/
 OMpV+k/cAVU0Dh/I6YsX4Bw1v7d8eeAoRpP89sagnA3E9BqIAPn7qhoiTxvfWTC1/Z8V
 IJNZXJZT++HIDAb2J8ePWRYBqX4QMEhtbXZoK5jDTDrtXtY6SL07LNNXkLpwaGtN4Qqo
 M8ThEn9mPqaCQA8X4N4UK5f12s8X528KxM+ernx6ik/9+4W3KDekjLSEW6/gfQuBAwcb
 8qYzFSVVOBf45tuVHup+hYmiCxUz3mZKb9pCJ6+N6KKp/6zfmcpMm0l/l7aoJX2zxyq1
 3XPQ==
X-Gm-Message-State: AOJu0YwdV8fc7peFKx70dEbZJAW8GZ6OOAhE+nNQdKR0I1O6SoZ4RjGF
 pt5k7reAu3IFGoN+WKjvHxXYs4vmlFjzbG6/eSpZEj7aCoiDeG1qReQyVs3vyuP8755rlaH32OI
 Vih86CGFPVKBcdvcqAuFhu17Ey83Lr5MI4r8pF93iRhecDnkWy1MXVQEq
X-Gm-Gg: AeBDieuDDmzEDxorOyx+y4WFThom5JEWWWlZkIn+gLIP/uUScbHhoia5nGxqQwBAwHR
 LwPFwpQjj1/pu+qArgn42YCIxP+5h1r9iYJXFWQNwaXsHeLNABM0qKy/JPwtCUgqZ1WDVynUHn0
 wwA7BeWQ8LTZzz9EQGcxV/u5CCF+3qiq3fXpj4D+rTWvwdljRMFBKdRu6JWsuGHswn6YYto+2Fs
 /Phs4jYUYicx5nRZA9kvY3DcwX99EMEgHA06/eWRQoG70l1EotZ0cIAvoZ84gK9C1kz1PORn29H
 6lkFYrtjPO5w0MCMJhENkki4mYvhyj7dyWBHnv5BIqcmk4suXVVYVeJqb56luBxmrR4VCSyLB1o
 v8Ma0A/G51bkwCyw/Q6g6EZL6yT6D9pkrbMvi5kMunQ5qA/I1ae31qZ0h47xSb4hHO4eVySLX/a
 eSpq4Q0d7tI9oBt8sOtn6lfX4Bk20qAJezeQqRn8HmuizfpSElbQ==
X-Received: by 2002:a17:903:22c6:b0:2ae:3b9b:db34 with SMTP id
 d9443c01a7336-2b28188da6amr268315345ad.42.1775745834300; 
 Thu, 09 Apr 2026 07:43:54 -0700 (PDT)
X-Received: by 2002:a17:903:22c6:b0:2ae:3b9b:db34 with SMTP id
 d9443c01a7336-2b28188da6amr268314535ad.42.1775745833454; 
 Thu, 09 Apr 2026 07:43:53 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd85sm235083535ad.74.2026.04.09.07.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:43:52 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 20:13:31 +0530
Subject: [PATCH 1/4] spl: ufs: Add partition support and flexible loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-spl_ufs_only-v1-1-f7e0e243d805@oss.qualcomm.com>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
In-Reply-To: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775745813; l=10124;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=vzonfL9BkiOIqHJiTsEKEDkpVU9zuuCD325/L9I8XRw=;
 b=JG5e44/zjzUTPP5+iamvXosYTD8mP6MAoY148BXWZRAap4cy7kWM/w/tzOSe7q4SByMiMV+X0
 vN1xPzfeYU2Cqx8YSPbLNwZ8YUA+hvOJjHPWb5TSV1JBbQK5NabAGPS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNCBTYWx0ZWRfX8CuTdt6EvK5+
 4BZLlA2jjotjGl6lXV6f6ECV2zSLT+89NVFxd8Aa2WXkLK04G2yphPxqvQ9SjDmu+UkIme3rsZa
 ZYjOc3mBWNxr8c3aqxmNNgJY1QdqYwy+ACTrkMOZ4NudTe0pUkUGMlB0jROOlbpoLjmBJA8RAKW
 3C30A0/e9yDbWZ5LBFHDUoI0cSupfV4qML2Z+pHWvmfHRqf4is9KX0PWOmLsoqFmk24enaknAxy
 NC1DqrNIu120yQlTkVIgWJI/EryySaTfx0fd66QnYZM90QYw+khun3cencUDeJjHm9LPkkm1WiB
 qEMkWRgAcSnSHcXR0DZ6OvJTHDJCBgwpmMMYhkkeHTYckm7OLPtGOPpKKVkRaWtVU/n8PRj3Y3B
 5z/XdumUYOp2uW9w9NVQkQHW58hjoEpJmu8E9eDovcZc+GGQTnHc+vh7lQ3ITqni637NcHSfs/H
 fuPqlD3EM7u8SvdBn0g==
X-Authority-Analysis: v=2.4 cv=SsWgLvO0 c=1 sm=1 tr=0 ts=69d7bb2b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KMwvg-qJkY4bAsvMzlMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: zTFR7xWQQKDkIfVnUfpJNEZeW2wZy6KJ
X-Proofpoint-ORIG-GUID: zTFR7xWQQKDkIfVnUfpJNEZeW2wZy6KJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090134
X-Mailman-Approved-At: Thu, 09 Apr 2026 17:38:43 +0200
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

Add partition-based loading support to SPL UFS, similar to the
existing implementation in spl_mmc.c. This allows loading from
named partitions or partition numbers instead of hardcoded sector
offsets.

The loading strategy tries methods in order: absolute sector if
configured, partition by name, partition by number, then filesystem
mode (placeholder for future implementation).

This brings UFS boot flexibility on par with MMC/SD boot.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 common/spl/Kconfig   |  40 ++++++++++-
 common/spl/spl_ufs.c | 188 +++++++++++++++++++++++++++++++++++++++++++++------
 include/part.h       |   3 +-
 include/spl.h        |   4 ++
 4 files changed, 214 insertions(+), 21 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index a21b71ad5d1..b3c7a1d8aa3 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1637,9 +1637,47 @@ config SPL_UFS_RAW_U_BOOT_SECTOR
 	depends on SPL_UFS_SUPPORT
 	default 0x800 if ARCH_ROCKCHIP
 	help
-	  Address on the block device to load U-Boot from.
+	  Absolute sector offset on the UFS LUN to load U-Boot from.
+	  This is tried first before partition-based loading.
+	  Set to 0x0 to skip absolute sector loading and use partition mode.
 	  Units: UFS sectors (1 sector = 4096 bytes).
 
+config SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	bool "Enable UFS partition support for raw mode"
+	depends on SPL_UFS_SUPPORT
+	select SPL_LIBDISK_SUPPORT
+	help
+	  Enable support for loading from a specific partition on UFS
+	  in raw mode. When enabled, you can specify either a partition
+	  name or partition number to load from.
+
+config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+	string "Partition name to load U-Boot from"
+	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	help
+	  Name of the partition to load U-Boot from in UFS raw mode.
+	  This is tried before partition number lookup.
+	  Leave empty to skip name-based lookup.
+	  Example: "boot", "uefi", "dtb_a"
+
+config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
+	int "Partition number to load U-Boot from"
+	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
+	help
+	  Partition number to load U-Boot from when using UFS raw mode
+	  with partition support. This is used if partition name is not
+	  specified or not found.
+
+config SPL_UFS_FS
+	bool "Enable UFS filesystem boot mode"
+	depends on SPL_UFS_SUPPORT
+	help
+	  Enable filesystem-based boot from UFS. This allows loading
+	  U-Boot from FAT or EXT4 filesystems on UFS partitions.
+	  This is tried as a fallback if raw mode loading fails.
+
+	  Note: Filesystem support is not yet fully implemented.
+
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"
 	imply SPL_WDT if !HW_WATCHDOG
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f..c4e793bf701 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -3,15 +3,19 @@
  * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
  */
 
+#include <dm.h>
+#include <log.h>
 #include <spl.h>
 #include <spl_load.h>
 #include <scsi.h>
-#include <errno.h>
-#include <image.h>
+#include <part.h>
+#include <blk.h>
 #include <linux/compiler.h>
-#include <log.h>
+#include <errno.h>
 
-static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
+/* Block read callback for spl_load framework */
+static ulong h_spl_ufs_load_read(struct spl_load_info *load, ulong off,
+				 ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;
 	lbaint_t sector = off >> bd->log2blksz;
@@ -20,30 +24,176 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
 	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
-static int spl_ufs_load_image(struct spl_image_info *spl_image,
-			      struct spl_boot_device *bootdev)
+/* Load image from raw sector */
+static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
+				     struct spl_boot_device *bootdev,
+				     struct blk_desc *bd,
+				     unsigned long sector)
 {
-	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
-	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct spl_load_info load;
+	int ret;
+
+	debug("spl: ufs loading from sector 0x%lx\n", sector);
+
+	spl_load_init(&load, h_spl_ufs_load_read, bd, bd->blksz);
+	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
+
+	if (ret) {
+		debug("spl: ufs load failed: %d\n", ret);
+		return ret;
+	}
+
+	debug("spl: ufs load successful\n");
+	return 0;
+}
+
+u32 __weak spl_ufs_boot_mode(const u32 boot_device)
+{
+	return UFS_MODE_RAW;
+}
+
+int spl_ufs_load(struct spl_image_info *spl_image,
+		 struct spl_boot_device *bootdev,
+		 const char *filename)
+{
+	u32 boot_mode;
+	int ret = 0;
+	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct blk_desc *bd;
-	int err;
+	unsigned long sector = 0;
+
+	log_debug("spl: ufs devnum=%d\n", devnum);
+
+	ret = scsi_scan(false);
+	if (ret) {
+		printf("spl: scsi scan failed: %d\n", ret);
+		return ret;
+	}
 
-	/* try to recognize storage devices immediately */
-	scsi_scan(false);
 	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
-	if (!bd)
+	if (!bd) {
+		printf("spl: could not get UFS device %d\n", devnum);
 		return -ENODEV;
+	}
 
-	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
-	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
-	if (err) {
-		puts("spl_ufs_load_image: ufs block read error\n");
-		log_debug("(error=%d)\n", err);
-		return err;
+	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
+
+	switch (boot_mode) {
+	case UFS_MODE_RAW:
+		debug("spl: ufs raw mode\n");
+
+		/* Step 1: Try absolute sector (if configured and non-zero) */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR
+		if (CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR != 0) {
+			debug("spl: trying absolute sector 0x%x\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
+
+			ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
+							CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
+
+			if (!ret) {
+				debug("spl: loaded from absolute sector\n");
+				return 0;
+			}
+			debug("spl: absolute sector failed: %d\n", ret);
+		}
+#endif
+
+		/* Step 2-4: Try partition-based loading */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION
+		{
+			struct disk_partition part_info;
+			int part_found = 0;
+
+			/* Step 2: Try partition name (if configured) */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+			if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
+				debug("spl: trying partition name '%s'\n",
+				      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
+
+				ret = part_get_info_by_name(bd,
+							    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+					&part_info);
+
+				if (ret >= 0) {
+					debug("spl: found partition '%s' at 0x%lx\n",
+					      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+					      (ulong)part_info.start);
+					sector = part_info.start;
+					part_found = 1;
+				} else {
+					debug("spl: partition name not found: %d\n", ret);
+				}
+			}
+#endif
+
+			/* Step 3: Try partition number (if name not found) */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM
+			if (!part_found) {
+				debug("spl: trying partition number %d\n",
+				      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
+
+				ret = part_get_info(bd,
+						    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+						    &part_info);
+
+				if (ret >= 0) {
+					debug("spl: found partition %d at 0x%lx\n",
+					      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+					      (ulong)part_info.start);
+					sector = part_info.start;
+					part_found = 1;
+				} else {
+					debug("spl: partition number not found: %d\n", ret);
+				}
+			}
+#endif
+
+			/* Load from partition if found */
+			if (part_found) {
+				ret = ufs_load_image_raw_sector(spl_image, bootdev, bd, sector);
+
+				if (!ret) {
+					debug("spl: loaded from partition\n");
+					return 0;
+				}
+				debug("spl: partition load failed: %d\n", ret);
+			}
+		}
+#endif /* CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION */
+
+		/* Step 4: Fall through to FS mode if enabled */
+		debug("spl: raw mode failed, trying fs\n");
+		fallthrough;
+
+#ifdef CONFIG_SPL_UFS_FS
+	case UFS_MODE_FS:
+		debug("spl: ufs fs mode\n");
+
+		/* TODO: Implement filesystem support */
+		printf("spl: ufs filesystem boot not implemented\n");
+		ret = -ENOSYS;
+		break;
+#endif
+
+	default:
+		puts("spl: ufs: invalid boot mode\n");
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
+}
+
+/* SPL load image entry point */
+static int spl_ufs_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	return spl_ufs_load(spl_image, bootdev,
+#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
+#else
+			    NULL);
+#endif
 }
 
 SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);
diff --git a/include/part.h b/include/part.h
index 15daacd7faa..47b91e2043c 100644
--- a/include/part.h
+++ b/include/part.h
@@ -463,7 +463,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SPL_FS_SQUASHFS) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
+	defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL
diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..a617bc26c04 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -29,6 +29,10 @@ struct legacy_img_hdr;
 #define MMCSD_MODE_FS		2
 #define MMCSD_MODE_EMMCBOOT	3
 
+/* UFS boot modes */
+#define UFS_MODE_RAW		1
+#define UFS_MODE_FS		2
+
 struct blk_desc;
 struct legacy_img_hdr;
 struct spl_boot_device;

-- 
2.34.1

