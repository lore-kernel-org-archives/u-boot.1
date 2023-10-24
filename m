Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA33C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5138487966;
	Tue, 24 Oct 2023 17:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="Abc+3yh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F8C8797B; Tue, 24 Oct 2023 17:44:15 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDED87967
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFZ9po032237; Tue, 24 Oct 2023 15:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/8oIoGV38A1IPKX00PeULeXK8IUQOsGu1Mll12KiUSc=;
 b=Abc+3yh/RGruZve2e6K9/4uGdz3EeXxCVreBMKrLyPQdnp0ghRyn0Fplo3edVSgGhN82
 rUVGff8AA3FYxpB8rBwdyM8hmQvD0siWKCI+EvfYfldRtRBdYwqP5LBoH2fX0sParGOr
 eyUShKn52+EOMO6YXoPwih4rl6ojwh32egKEuC/caAa4qP8E3lXHnb0iqW2nPB9a7/g1
 1oNH4YWTH/UZdt5gKCWaCqf95ZJ9/BFpMpWGRLN7lwnlmFRDSXwBn6/gHSoZbHRyFU9D
 XjGbADIwLgOO+AO6Q8gPD7Uz1BLntUjPsHQePz5OK3Zi6ApGMGiQQxd4aWBqRZeqA/QU vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgpr8ged-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:00 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFa23Y004372;
 Tue, 24 Oct 2023 15:43:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgpr8ga2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ODKKvd010315; Tue, 24 Oct 2023 15:43:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbygkqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhupU52167218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F359D58059;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C555158055;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 4/8] bootm: Support boot measurement
Date: Tue, 24 Oct 2023 10:43:50 -0500
Message-Id: <20231024154354.197524-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ti9Eu9zeUtrcr58tOi6IrpDGEz4Svdwd
X-Proofpoint-ORIG-GUID: vg5ORKjEh3sQx_VTfhd8gRfxOighhMVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240135
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

Add a configuration option to measure the boot through the bootm
function. Add the measurement state to the booti and bootz paths
as well.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v8:
 - Added a configuration option to select to ignore any existing
   event log. This would only be selected for systems that know
   that U-Boot is the first stage bootloader. This is necessary
   because the reserved memory region may persist through resets
   and so U-Boot attempts to append to the previous boot's log.

Changes since v6:
 - Added comment for bootm_measure
 - Fixed line length in bootm_measure

 boot/Kconfig    | 32 +++++++++++++++++++++
 boot/bootm.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/booti.c     |  1 +
 cmd/bootm.c     |  2 ++
 cmd/bootz.c     |  1 +
 include/bootm.h | 11 ++++++++
 include/image.h |  1 +
 7 files changed, 122 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index a01e6cb8aa..abbc72f4cf 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -685,6 +685,38 @@ config LEGACY_IMAGE_FORMAT
 	  loaded. If a board needs the legacy image format support in this
 	  case, enable it here.
 
+config MEASURED_BOOT
+	bool "Measure boot images and configuration to TPM and event log"
+	depends on HASH && TPM_V2
+	help
+	  This option enables measurement of the boot process. Measurement
+	  involves creating cryptographic hashes of the binary images that
+	  are booting and storing them in the TPM. In addition, a log of
+	  these hashes is stored in memory for the OS to verify the booted
+	  images and configuration. Enable this if the OS has configured
+	  some memory area for the event log and you intend to use some
+	  attestation tools on your system.
+
+if MEASURED_BOOT
+	config MEASURE_DEVICETREE
+	bool "Measure the devicetree image"
+	default y if MEASURED_BOOT
+	help
+	  On some platforms, the devicetree is not static as it may contain
+	  random MAC addresses or other such data that changes each boot.
+	  Therefore, it should not be measured into the TPM. In that case,
+	  disable the measurement here.
+
+	config MEASURE_IGNORE_LOG
+	bool "Ignore the existing event log"
+	default n
+	help
+	  On platforms that use an event log memory region that persists
+	  through system resets and are the first stage bootloader, then
+	  this option should be enabled to ignore any existing data in the
+	  event log memory region.
+endif # MEASURED_BOOT
+
 config SUPPORT_RAW_INITRD
 	bool "Enable raw initrd images"
 	help
diff --git a/boot/bootm.c b/boot/bootm.c
index 8f96a80d42..cb61485c22 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -23,6 +23,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/sizes.h>
+#include <tpm-v2.h>
 #if defined(CONFIG_CMD_USB)
 #include <usb.h>
 #endif
@@ -673,6 +674,75 @@ int bootm_process_cmdline_env(int flags)
 	return 0;
 }
 
+int bootm_measure(struct bootm_headers *images)
+{
+	int ret = 0;
+
+	/* Skip measurement if EFI is going to do it */
+	if (images->os.os == IH_OS_EFI &&
+	    IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL) &&
+	    IS_ENABLED(CONFIG_BOOTM_EFI))
+		return ret;
+
+	if (IS_ENABLED(CONFIG_MEASURED_BOOT)) {
+		struct tcg2_event_log elog;
+		struct udevice *dev;
+		void *initrd_buf;
+		void *image_buf;
+		const char *s;
+		u32 rd_len;
+		bool ign;
+
+		elog.log_size = 0;
+		ign = IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG);
+		ret = tcg2_measurement_init(&dev, &elog, ign);
+		if (ret)
+			return ret;
+
+		image_buf = map_sysmem(images->os.image_start,
+				       images->os.image_len);
+		ret = tcg2_measure_data(dev, &elog, 8, images->os.image_len,
+					image_buf, EV_COMPACT_HASH,
+					strlen("linux") + 1, (u8 *)"linux");
+		if (ret)
+			goto unmap_image;
+
+		rd_len = images->rd_end - images->rd_start;
+		initrd_buf = map_sysmem(images->rd_start, rd_len);
+		ret = tcg2_measure_data(dev, &elog, 9, rd_len, initrd_buf,
+					EV_COMPACT_HASH, strlen("initrd") + 1,
+					(u8 *)"initrd");
+		if (ret)
+			goto unmap_initrd;
+
+		if (IS_ENABLED(CONFIG_MEASURE_DEVICETREE)) {
+			ret = tcg2_measure_data(dev, &elog, 0, images->ft_len,
+						(u8 *)images->ft_addr,
+						EV_TABLE_OF_DEVICES,
+						strlen("dts") + 1,
+						(u8 *)"dts");
+			if (ret)
+				goto unmap_initrd;
+		}
+
+		s = env_get("bootargs");
+		if (!s)
+			s = "";
+		ret = tcg2_measure_data(dev, &elog, 1, strlen(s) + 1, (u8 *)s,
+					EV_PLATFORM_CONFIG_FLAGS,
+					strlen(s) + 1, (u8 *)s);
+
+unmap_initrd:
+		unmap_sysmem(initrd_buf);
+
+unmap_image:
+		unmap_sysmem(image_buf);
+		tcg2_measurement_term(dev, &elog, ret != 0);
+	}
+
+	return ret;
+}
+
 /**
  * Execute selected states of the bootm command.
  *
@@ -724,6 +794,10 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_FINDOTHER))
 		ret = bootm_find_other(cmdtp, flag, argc, argv);
 
+	if (IS_ENABLED(CONFIG_MEASURED_BOOT) && !ret &&
+	    (states & BOOTM_STATE_MEASURE))
+		bootm_measure(images);
+
 	/* Load the OS */
 	if (!ret && (states & BOOTM_STATE_LOADOS)) {
 		iflag = bootm_disable_interrupts();
diff --git a/cmd/booti.c b/cmd/booti.c
index 1d531bdd06..a6c7db272c 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -127,6 +127,7 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
 			      BOOTM_STATE_RAMDISK |
 #endif
+			      BOOTM_STATE_MEASURE |
 			      BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
 			      BOOTM_STATE_OS_GO,
 			      &images, 1);
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 3e504ccfe8..6ded091dd5 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -147,6 +147,8 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		BOOTM_STATE_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
 		states |= BOOTM_STATE_RAMDISK;
+	if (IS_ENABLED(CONFIG_MEASURED_BOOT))
+		states |= BOOTM_STATE_MEASURE;
 	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
 		states |= BOOTM_STATE_OS_CMDLINE;
 	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 742889f21d..dd6fe4904b 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -81,6 +81,7 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
 			      BOOTM_STATE_RAMDISK |
 #endif
+			      BOOTM_STATE_MEASURE |
 			      BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
 			      BOOTM_STATE_OS_GO,
 			      &images, 1);
diff --git a/include/bootm.h b/include/bootm.h
index c3c7336207..10a1bd65a7 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -56,6 +56,17 @@ ulong bootm_disable_interrupts(void);
 int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		      ulong size);
 
+/*
+ * Measure the boot images. Measurement is the process of hashing some binary
+ * data and storing it into secure memory, i.e. TPM PCRs. In addition, each
+ * measurement is logged into the platform event log such that the operating
+ * system can access it and perform attestation of the boot.
+ *
+ * @images:	The structure containing the various images to boot (linux,
+ *		initrd, dts, etc.)
+ */
+int bootm_measure(struct bootm_headers *images);
+
 int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[], int states, struct bootm_headers *images,
 		    int boot_progress);
diff --git a/include/image.h b/include/image.h
index 5f85bf84a2..2e3cf839ee 100644
--- a/include/image.h
+++ b/include/image.h
@@ -409,6 +409,7 @@ struct bootm_headers {
 #define BOOTM_STATE_OS_FAKE_GO	0x00000200	/* 'Almost' run the OS */
 #define BOOTM_STATE_OS_GO	0x00000400
 #define BOOTM_STATE_PRE_LOAD	0x00000800
+#define BOOTM_STATE_MEASURE	0x00001000
 	int		state;
 
 #if defined(CONFIG_LMB) && !defined(USE_HOSTCC)
-- 
2.39.3

