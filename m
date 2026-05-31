Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131E9CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 14:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F0D838D7;
	Sun, 31 May 2026 16:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMcYM0Vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242818405A; Sun, 31 May 2026 12:03:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453F8838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 12:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raziebe@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45efb698ef2so385116f8f.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 03:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780221827; cv=none;
 d=google.com; s=arc-20240605;
 b=L1KrnN4AI6/VpykZLiua3vDeQZ8cpqHEijlmn2QlIoVg6QCJn4FKNrB+9IVByjVbJz
 LTILCr67n0Ngv0mGVsOj53oJgSPUzqfoe60CGKTdryx4Otqd17xNhOAle++ggNiypBqK
 BZItFcf/MtbpIG2qJpaeMCn3wy/njRbGDlXdztfySUSa+acvz5SN1UoyUXNMnuc52HRH
 xG3+tWC2IjjuVDiyIxJ5iKev06dJ7jpxyAz3u5nFBUsMM3HBfrfeIY3xaLpteoVMGX+k
 SMBSTVg98zq0TijCPMkbMTIFaM6ucWZDByeej+vK8QuyQ+2EnOUyrIwrDDWzqloRqiZ0
 gZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=0O70UxqRmkuxgKX6IW8nqBMx4ZHUA35AfehRBVp/Q4w=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=ByRpW2xrvh5+2aHx8ZXfbBhrQZnAw5oxIg7x6j5USu7cB0DGbUIrQai1jse3d1ow9Z
 VqEJ7kvise+R3guohQl9UkzarX9kUfGq7/b/IuUvSYNHDS/vQ+6SKHkhMo1cMYtqIPx7
 upUHhovrLkLz2VH1BWU8vMEBH6UPJJw8+J7YOtkhMq33VaglEX6oMOZ28gTcN4lo2XnV
 s+TgNNYmieNDf97hY8VdLMdbDyqCVwraz1rhp35ERqhJP6jZY3I/WKOpT/p8PzBDx3Tc
 2AsPVl0iezWAHQLUiWu5C/SHDmCpvyt2ELUGz6HRicZbNdKQu9tCatEKzmbxVLUiRiD/
 6vCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780221827; x=1780826627; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0O70UxqRmkuxgKX6IW8nqBMx4ZHUA35AfehRBVp/Q4w=;
 b=gMcYM0Vy+ppMJ9MgTwZ4TCOdnGiDn1dVUWSq5IvZqrCcVEg+JsHPcX/urj4Ma6iL2w
 Gq0/Y+JyjgkKhiqv3pQbnpcb0nADsS63QrhtTYpo9Ph4ARJKcrYZ3gy83xp3mOea/iHZ
 p6oAw6kZXCUmCsh0pHll3hOlfmSqy5xFJn1k5dQigY7lQjPz1wb6uXSMKtaUSXWjINkp
 U1q/GNtPUIA6cmHq6fk5HSgyQAlNFvv9EptjacbqxS1VJFOpwZQEkXDLoR62/MzRMSJZ
 VB4U7kG0g7jLGYk9pe/h+0iOVavKMlkySjhlxlxwdnHsk93z5jhXhSd64rWM+P3AmauO
 0OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780221827; x=1780826627;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0O70UxqRmkuxgKX6IW8nqBMx4ZHUA35AfehRBVp/Q4w=;
 b=kkL62UzOKEYOc1MckTuO2YWISVtMyeczQVz/81c4gr3aagqDiaYKpztXIAG/CljDry
 UqPmmvjXnnm1zhQmNIP13NqkmfEvzObtpYQDmWFmbfQfIvGuQ2fwfzvXB69MkmQikTZ/
 Qhp9GsjzKJxphsGkbvn63xKP7oWolMYxxSRrpmUGN7kBuAYHOpDLpiAf1QOXdPaJP0QX
 JszZTH7jB6S8OXU+CkRjg2HTeMyrT/hZVwFDc8H2HJlhggxEt3eQjGBNJTPpLLeIrTwi
 ohnPpTM6dyYlov7cauILkQiRhSKBHakxCXnHDGVLt6l/DlT2I4Ij9amPxk4Lb3pkUHjJ
 FvXA==
X-Gm-Message-State: AOJu0Yzyl57U3wXvNiHFJKyagSA/XtMfKyzdptpFzMmncwUCFuaKsyb3
 tIkOAWTZeejkh5v0gjWXMIoX5PEax4b0dYjL/cq+JLofGi5iuzsSPuqsKbPlAt5nDAtiRi3tLwU
 Y87fhHp1IgK/VB++GVFVNI3BU5M2FFViknR6V
X-Gm-Gg: Acq92OHFQ3k/aZnyf6bJgsO84yn1XCFfEiBBhngj4nKdo4oy8GTLIBzTzc4v9d3otWz
 nwnItUNCKJcZjzrQV9LtmKnBsaW+6RRX2csrFOzQER6SOcd7RpjyvFp8AHJjKkoRez9jcQ3nv8C
 tngugpTEEYwKWsZG/mexrWftEc+w9rme2TZU4WsshxrrEDrNtXRUfJAidSXHNOBisiQIsSxmhuj
 vQM1TXLhoHWoyxBIKx6nA+NgU6B0+GrSIlSdjyTQkkM8dvJZRo7+ou/P1gvttjobreglLv6mRSM
 Q05mSg/SUSj5ciAh9jCqHbgwyrxLJ5Ytobp068W94oSRNfTI/w==
X-Received: by 2002:a5d:5cd1:0:b0:454:35b9:803 with SMTP id
 ffacd0b85a97d-45ef6b78b50mr9482706f8f.30.1780221826264; Sun, 31 May 2026
 03:03:46 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Sun, 31 May 2026 13:03:33 +0300
X-Gm-Features: AVHnY4I2tlaLCLg_urqqLMXwMcuAADKqZaKnsw8xZ8VgPjFWSmktWoIhWnDhwAg
Message-ID: <CAPB=Z-qWFYrO6VQuS5LmitEMEf5xWe7aQ8ADR4yZsg1gymwaaQ@mail.gmail.com>
Subject: UFS-TOOL. PATCH [1/4]
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000939bdf06531a31da"
X-Mailman-Approved-At: Sun, 31 May 2026 16:30:00 +0200
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

--000000000000939bdf06531a31da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From b6034d44a848450691e6d9aecb15638fe5a4890c Mon Sep 17 00:00:00 2001
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Date: Thu, 28 May 2026 15:06:56 +0300
Subject: [PATCH 1/4] ufs: add UFS descriptor/configuration utility support

Add a UFS tool implementation for querying, printing, and updating
UFS descriptors and configuration parameters.

Features include:

* Query and print device, geometry, unit, config, and power descriptors
* Display LUN configuration and calculated capacities
* Support updating LUN, config, and device descriptor fields
* Add WriteBooster-related configuration handling
* Add flag query support for common UFS runtime flags
* Add commit and clear-all configuration helpers
* Improve descriptor decoding and formatted debug output

The tool is intended for U-Boot/UFS debugging, provisioning,
and configuration workflows.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs_tool.c | 1251 ++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs_tool.h |  394 +++++++++++++
 2 files changed, 1645 insertions(+)
 create mode 100644 drivers/ufs/ufs_tool.c
 create mode 100644 drivers/ufs/ufs_tool.h

diff --git a/drivers/ufs/ufs_tool.c b/drivers/ufs/ufs_tool.c
new file mode 100644
index 00000000000..1f5ce85beed
--- /dev/null
+++ b/drivers/ufs/ufs_tool.c
@@ -0,0 +1,1251 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <dm/devres.h>
+#include <errno.h>
+#include <limits.h>
+#include <linux/bitops.h>
+#include <linux/byteorder/little_endian.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <malloc.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+
+#include "ufs.h"
+#include "ufs_tool.h"
+#include <ufs.h>
+
+#define UFS_DESC_SIZE (unsigned char)0xff
+
+static int ufshcd_query_desc_idn_geometry(struct ufs_hba *,
+   struct ufs_geometry_descriptor *decs);
+static int ufshcd_query_desc_idn_config(struct ufs_hba *hba,
+ struct ufs_config_descriptor *cfg);
+static int ufshcd_query_desc_idn_device(struct ufs_hba *hba,
+ struct ufs_device_descriptor *desc);
+static int ufshcd_query_desc_idn_unit(struct ufs_hba *hba, int lun,
+       struct unit_descriptor *desc);
+
+static void
+ufshcd_print_idn_geometry_desc(struct ufs_geometry_descriptor *desc);
+static void ufshcd_print_device_descriptor(struct ufs_device_descriptor *d=
esc);
+static void ufshcd_print_unit_descriptor(struct unit_descriptor *desc);
+static void
+ufshcd_print_idn_desc_config(struct ufs_config_descriptor *user_cfg,
+      struct ufs_geometry_descriptor *geometry,
+      u32 b_ud0_base_offset, u32 b_u_dconfig_p_length);
+
+static int
+ufshcd_query_desc_idn_power(struct ufs_hba *hba, int lun,
+     struct ufs_power_parameters_descriptor *desc);
+
+static void
+print_ufs_power_parameters(struct ufs_power_parameters_descriptor *desc);
+
+static int ufshcd_query_user_flag(struct ufs_hba *hba, const char *flag_na=
me);
+static int ufshcd_write_desc_param(struct ufs_hba *hba, enum desc_idn desc=
_id,
+    int desc_index, unsigned char param_offset,
+    unsigned char *param_write_buf,
+    unsigned char param_size);
+
+static struct ufs_config_descriptor g_cfg_desc;
+
+struct ufs_hba *ufstool_probe_dev(int index)
+{
+ struct udevice *dev;
+ struct ufs_hba *hba =3D NULL;
+
+ if (!uclass_get_device(UCLASS_UFS, index, &dev))
+ hba =3D dev_get_uclass_priv(dev);
+ return hba;
+}
+
+int ufshcd_query_desc_idn_device(struct ufs_hba *hba,
+ struct ufs_device_descriptor *desc)
+{
+ int ret;
+ int param_offset =3D 0;
+ int desc_index =3D 0; /* LUNS 0-7 controlled by index 0 */
+
+ memset(desc, 0x00, sizeof(*desc));
+ ret =3D ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, desc_index,
+      param_offset, (void *)desc,
+      UFS_DESC_SIZE);
+ return ret;
+}
+
+void ufshcd_print_device_descriptor(struct ufs_device_descriptor *descript=
or)
+{
+ u32 val =3D descriptor->num_shared_write_booster_buffer_allocunits;
+
+ printf("--- UFS Device Descriptor (IDN: 00h %ld) ---\n",
+        sizeof(struct ufs_device_descriptor));
+
+ printf(" Name | Value | Description\n");
+ printf("-----------------------------------------------------------\n");
+ /* Descriptor Header (Offset 00h =E2=80=93 01h) */
+ printf("Length | 0x%x\n", descriptor->length);
+ printf("DescriptorIdn | 0x%x\n", descriptor->descriptor_idn);
+
+ /* Device Identification & Core configuration (Offset 02h =E2=80=93 0Dh) =
*/
+ printf("Device | 0x%x\n", descriptor->device);
+ printf("DeviceClass | 0x%x\n", descriptor->device_class);
+ printf("DeviceSubClass | 0x%x\n", descriptor->device_sub_class);
+ printf("protocol | 0x%x\n", descriptor->protocol);
+ printf("NumberLu | %d\n", descriptor->number_lu);
+ printf("NumberWLu | %d\n", descriptor->number_wlu);
+ printf("BootEnable | 0x%x\n", descriptor->boot_enable);
+ printf("DescrAccessEn | 0x%x\n", descriptor->descr_access_en);
+ printf("InitPowerMode | 0x%x\n", descriptor->init_power_mode);
+ printf("highPriorityLun | 0x%x\n",
+        descriptor->high_priority_lun);
+ printf("SecureRemovalType | 0x%x\n",
+        descriptor->secure_removal_type);
+ printf("SecurityLu | 0x%x\n", descriptor->security_lu);
+
+ /* power Management, Version & Pointers (Offset 0Eh =E2=80=93 2Ah) */
+ printf("b_background_ops_term_lat | 0x%x\n",
+        descriptor->background_ops_term_lat);
+ printf("b_init_active_icc_level | 0x%x\n",
+        descriptor->init_active_icc_level);
+ printf("SpecVersion | 0x%x\n",
+        __builtin_bswap16(descriptor->spec_version));
+ printf("ManufactureDate | 0x%x\n", descriptor->manufacture_date);
+ printf("ManufacturerName | 0x%x\n", descriptor->manufacturer_name);
+ printf("ProductName | 0x%x\n", descriptor->product_name);
+ printf("SerialNumber | 0x%x\n", descriptor->serial_number);
+ printf("OEMId | 0x%x\n", descriptor->oem_id);
+ printf("ManufacturerId | 0x%x\n", descriptor->manufacturer_id);
+ printf("Ud0BaseOffset | %d\n", descriptor->ud0_base_offset);
+ printf("DConfigLength | %d\n",
+        descriptor->config_length);
+ printf("DeviceRttCap | 0x%x\n", descriptor->device_rtt_cap);
+ printf("PeriodicRtcUpdate | 0x%x\n",
+        descriptor->periodic_rtc_update);
+ printf("UfsFeaturesSupport | 0x%x\n",
+        descriptor->ufs_features_support);
+ printf("FfuTimeout | %d\n", descriptor->ffu_timeout);
+ printf("QueueDepth | %d\n", descriptor->queue_depth);
+ printf("DeviceVersion | 0x%x\n", descriptor->device_version);
+ printf("NumSecureWpArea | 0x%x\n",
+        descriptor->num_secure_wp_area);
+ printf("PsaMaxDataSize | 0x%x\n",
+        descriptor->psa_max_data_size);
+ printf("PsaStateTimeout | 0x%x\n",
+        descriptor->psa_state_timeout);
+ printf("ProductRevisionLevel | 0x%x\n",
+        descriptor->product_revision_level);
+
+ /* Extended Features (Offset 4Fh =E2=80=93 58h) */
+ printf("ExtendedUfsFeaturesSupport ");
+ printf("| 0x%x |(includes  WriteBooster/Throttling)\n",
+        be32_to_cpu(descriptor->extended_ufs_features_support));
+
+ printf("WriteBoosterBufferPreserveUserSpaceEn");
+ printf("| 0x%x | Preserve User Space mode for WriteBooster Buffer\n",
+        descriptor->write_booster_buffer_preserve_user_space_en);
+
+ printf("write booster buffer type");
+ printf("| 0x%x | WriteBooster Buffer Type",
+        descriptor->write_booster_buffer_type);
+ puts("(00h: LU dedicated, 01h: shared)\n");
+
+ printf("NumSharedWriteBooster_buffer_allocunits |");
+ printf("%d | Shared WriteBooster Buf size (in Allocation units)\n",
+        be32_to_cpu(val));
+}
+
+int ufshcd_query_desc_idn_geometry(struct ufs_hba *hba,
+    struct ufs_geometry_descriptor *desc)
+{
+ int param_offset =3D 0;
+ int desc_index =3D 0;
+
+ memset(desc, 0xc, sizeof(*desc));
+ return ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, desc_index,
+       param_offset, (void *)desc,
+       QUERY_DESC_GEOMETRY_DEF_SIZE);
+}
+
+void ufshcd_print_idn_geometry_desc(struct ufs_geometry_descriptor *desc)
+{
+ u64 cap =3D be64_to_cpu(desc->total_raw_device_capacity);
+
+ cap =3D ((cap << 9) >> 30);
+
+ printf("--- UFS geometry Descriptor (IDN: 07h) ---\n");
+ printf(" Name   | Value              | Description\n");
+ printf("-------------------------------------------------------\n");
+
+ /* Header and Core Capacity (Offset 00h - 0Ch) */
+ printf("Length | 0x%x  | Size of descriptor\n", desc->length);
+ printf("DescriptorIdn   | 0x%x | geometry Descriptor ID\n",
+        desc->descriptor_idn);
+ printf("MediaTechnology | 0x%x | Reserved (00h)\n",
+        desc->media_technology);
+
+ printf("TotalRawDeviceCapacity | %lld GB\n", cap);
+
+ printf("MaxNumberLu | %d | Max LUs (00h: 8, 01h: 32)\n",
+        desc->max_number_lu);
+
+ /* Segment and Allocation unit constraints (Offset 0Dh - 12h) */
+ printf("SegmentSize | %d | Segment size (512B units)\n",
+        be32_to_cpu(desc->segment_size));
+
+ printf("AllocationunitSize | %d | Alloc unit size (in segments)\n",
+        desc->allocationunit_size);
+
+ printf("MinAddrBlockSize | %d | Min addressable block size\n",
+        desc->min_addr_block_size);
+
+ /* Performance and Buffer parameters (Offset 13h - 17h) */
+ printf("OptimalReadBlockSize");
+ printf("| %d | Optimal read size (512B units)\n",
+        desc->optimal_read_block_size);
+
+ printf("OptimalWriteBlockSize ");
+ printf("| 0x%x | Optimal write size (512B units)\n",
+        desc->optimal_write_block_size);
+
+ printf("MaxInBufferSize | 0x%x | Max Data-In buffer (512B units)\n",
+        desc->max_in_buffer_size);
+
+ printf("MaxOutBufSize | 0x%x | Max Data-Out buffer (512B)\n",
+        desc->max_out_buffer_size);
+
+ printf("bRPMBReadWriteSize | 0x%x | Max RPMB frames per command\n",
+        desc->rpmb_read_write_size);
+
+ /* Feature Support Bitmaps (Offset 18h - 1Fh) */
+ printf("DynamicCapacityResourcePolicy| 0x%x |",
+        desc->dynamic_capacity_resource_policy);
+
+ printf("00h: per LU, 01h: per Memory Type\n");
+ printf("DataOrdering | 0x%x | 01h: Out-of-order supported\n",
+        desc->data_ordering);
+ printf("MaxContexIdNumber | 0x%x | Max supported contexts (min 5)\n",
+        desc->max_contex_id_number);
+
+ printf("SysDataTagUnitSize | 0x%x | System data tag granularity\n",
+        desc->sys_data_tagunit_size);
+
+ printf("SysDataTagResSize  | 0x%x | Max area for tagged system data\n",
+        desc->sys_data_tag_res_size);
+
+ printf("SupportedSecRTypes | 0x%x | Supported secure removal types\n",
+        desc->supported_sec_r_types);
+
+ printf("SupportedMemoryTypes | 0x%x | Bitmap of memory types\n",
+        be16_to_cpu(desc->supported_memory_types));
+ /*
+ * Memory Type Specific Capacities and Adjustment Factors
+ */
+ printf("SystemCodeMaxNAlloc | 0x%x | Max Alloc units\n",
+        desc->system_code_max_n_alloc_u);
+
+ printf("SystemCodeCapAdjFac | 0x%x | cap_adj_factor: System Code\n",
+        desc->system_code_cap_adj_fac);
+
+ printf("NonPersistMaxNAlloc | 0x%x | Max Alloc units: Non-Persist\n",
+        desc->non_persist_max_n_alloc_u);
+
+ printf("NonPersistCapAdjFac   | 0x%x | cap_adj_factor: Non-Persist\n",
+        desc->non_persist_cap_adj_fac);
+
+ printf("Enhanced1MaxNAlloc | %d | Max Alloc units: Enhanced 1\n",
+        be32_to_cpu(desc->enhanced1_max_n_alloc_u));
+
+ printf("Enhanced1CapAdjFac | %d | cap_adj_factor: Enhanced 1\n",
+        be16_to_cpu(desc->enhanced1_cap_adj_fac));
+
+ printf("Enhanced2MaxNAlloc_u | %d | Max Alloc units: Enhanced 2\n",
+        be32_to_cpu(desc->enhanced2_max_n_alloc_u));
+
+ printf("Enhanced2CapAdjFac | %d | cap_adj_factor: Enhanced 2\n",
+        be16_to_cpu(desc->enhanced2_cap_adj_fac));
+ printf("Enhanced3MaxNAlloc | %d | Max Alloc units: Enhanced 3\n",
+        be32_to_cpu(desc->enhanced3_max_n_alloc_u));
+
+ printf("Enhanced3CapAdjFac | %d | cap_adj_factor: Enhanced 3\n",
+        be32_to_cpu(desc->enhanced3_cap_adj_fac));
+
+ printf("Enhanced4MaxNAlloc | %d | Max Alloc units: Enhanced 4\n",
+        be32_to_cpu(desc->enhanced4_max_n_alloc_u));
+
+ printf("Enhanced4CapAdjFac | %d | cap_adj_factor: Enhanced 4\n",
+        be16_to_cpu(desc->enhanced4_cap_adj_fac));
+
+ /* Performance and WriteBooster (Offset 44h - 56h) */
+ printf("OptimalLogicalBlockSize | %d | Optimal Blk Size per type\n",
+        be32_to_cpu(desc->optimal_logical_block_size));
+
+ printf("WriteBoosterBufferMaxNAllocunits");
+ printf("| %d | Max tot WB buf size\n",
+        be32_to_cpu(desc->write_booster_buffer_max_alloc_units));
+
+ printf("DeviceMaxWriteBoosterLus ");
+ printf("| %d | Max LUs supporting WB (MDV:1)\n",
+        desc->device_max_write_booster_lus);
+
+ printf("WriteBoosterBufferCapAdjFac");
+ printf("| %d | WB Capacity Adjustment Factor\n",
+        desc->write_booster_buffer_capadjfac);
+
+ printf("SupportedwbBufferUserSpaceReductionType");
+ printf(" | 0x%x | Reduction/Preserve mode support\n",
+        desc->supported_write_booster_buffer_userspace_reduction_types);
+
+ printf("SupportedWriteBoosterBufferTypes");
+ printf("| 0x%x | 00h: LU based, 01h: Shared\n",
+        desc->supported_write_booster_buffer_types);
+}
+
+void ufshcd_print_config_descriptor(const struct config_descriptor *cd)
+{
+ if (!cd)
+ return;
+
+ printf("Config Descriptor:\n");
+
+ printf("Length                          : 0x0%x\n", cd->length);
+ printf("DescriptorIdn                   : 0x0%x\n",
+        cd->descriptor_idn);
+ printf("ConfDescContinue                : 0x0%x\n",
+        cd->conf_desc_continue);
+
+ printf("BootEnable                      : 0x0%x\n",
+        cd->boot_enable);
+ printf("DescrAccess_en                   : 0x0%x\n",
+        cd->descr_access_en);
+ printf("InitPowerMode                   : 0x0%x\n",
+        cd->initpower_mode);
+ printf("HighPriorityLun                 : 0x0%x\n",
+        cd->high_priority_lun);
+ printf("SecureRemovalType               : 0x0%x\n",
+        cd->secure_removal_type);
+ printf("InitActiveIccLevel              : 0x0%x\n",
+        cd->init_active_icc_level);
+ printf("PeriodicRtcUpdate               : 0x0%x\n",
+        cd->periodic_rtc_update);
+ printf("Reserved_HPB                    : 0x0%x\n",
+        cd->reserved_HPB);
+
+ printf("RpmbRegionEnable                : 0x0%x\n",
+        cd->rpmb_region_enable);
+ printf("RpmbRegion1Size                 : 0x0%x\n",
+        cd->rpmb_region1_size);
+ printf("RpmbRegion2Size                 : 0x0%x\n",
+        cd->rpmb_region2_size);
+ printf("RpmbRegion3Size                 : 0x0%x\n",
+        cd->rpmb_region3_size);
+
+ printf("WriteBoosterBufferPreserveUserSpaceEN : 0x0%x\n",
+        cd->write_booster_buffer_preserve_user_space_en);
+ printf("WriteBoosterBufferType           : 0x0%x\n",
+        cd->write_booster_buffer_type);
+ printf("NumSharedWriteBoosterBufferAllocUnits : 0x0%x\n",
+        cd->num_shared_write_booster_buffer_allocunits);
+}
+
+int ufshcd_query_desc_idn_config(struct ufs_hba *hba,
+ struct ufs_config_descriptor *user_cfg)
+{
+ int ret;
+ int param_offset =3D 0;
+ int desc_index =3D 0;
+
+ ret =3D
+     ufshcd_read_desc_param(hba, QUERY_DESC_IDN_CONFIGURATION,
+    desc_index, param_offset, (void *)user_cfg,
+    QUERY_DESC_CONFIGURATION_DEF_SIZE);
+ if (ret)
+ printf("Failed to read config\n");
+ return ret;
+}
+
+void ufshcd_print_unit_param_descriptor(struct ufs_unit_configurable_param=
eters
+ *unit)
+{
+ /* Header segment (Offset 00h - 03h) */
+ printf("LuEnable  | 0x%x  | Enabled, 00h: Disabled\n",
+        unit->lu_enable);
+ printf("BootLunId | 0x%x  | Boot LU A, 02h: Boot LU B\n",
+        unit->boot_lun_id);
+ printf("LuWriteProtect | 0x%x | power-on, 02h: Permanent\n",
+        unit->lu_write_protect);
+ printf("MemoryType| 0x%x | Normal, 01h: System Code\n",
+        unit->memory_type);
+ /* Allocation and Sizing (Offset 04h - 0Ah) */
+ printf("NumAllocunits | %d | Number of Allocation units for LU\n",
+        be32_to_cpu(unit->num_allocunits));
+ printf("DataReliability | 0x%x | power failure protection\n",
+        unit->data_reliability);
+ printf("LogicalBlockSize | 0x%x | Block size exponent (Min: 0Ch)\n",
+        unit->logical_block_size);
+ printf("ProvisioningType | 0x%x | Full, 02h/03h: Thin\n",
+        unit->provisioning_type);
+
+ /* Context and HPB (Offset 0Bh - 15h) */
+ puts("ContextCapabilities");
+ printf(" | 0x%x | LU Context support/multipliers\n",
+        unit->context_capabilities);
+ /* printf("Reserved  | --   | Reserved\n"); */
+ /* printf("Reserved (HPB) | -- | Reserved for HPB Extension\n"); */
+ /* WriteBooster (Offset 16h) */
+ printf("LuNumWriteBoosterBufferAllocunits");
+ printf("| 0x%x | WB Buffer size (LUs 0-7 only)\n",
+        unit->lu_num_write_booster_buffer_allocunits);
+}
+
+void ufshcd_clearall_luns(struct ufs_config_descriptor *user_cfg,
+   u32 base_offset, u32 config_length)
+
+{
+ int i;
+ int off;
+ u8 *config =3D (u8 *)user_cfg;
+ struct ufs_unit_configurable_parameters *unit;
+
+ for (i =3D 0; i < 8; i++) {
+ off =3D base_offset + (i * config_length);
+
+ unit =3D (struct ufs_unit_configurable_parameters *)&config[off];
+
+ unit->num_allocunits =3D cpu_to_be32(0);
+ unit->memory_type =3D 0;
+ unit->lu_enable =3D 0;
+ unit->boot_lun_id =3D 0;
+ unit->logical_block_size =3D 0xC;
+ unit->data_reliability =3D 0;
+ unit->provisioning_type =3D 0;
+ unit->context_capabilities =3D cpu_to_be16(0);
+ unit->lu_num_write_booster_buffer_allocunits =3D cpu_to_be32(0);
+ }
+}
+
+static float calc_lun_capacity(struct ufs_unit_configurable_parameters *un=
it,
+        struct ufs_geometry_descriptor *geometry)
+{
+ u16 cap_adj_fac =3D 1;
+ float cap_adj_facfl =3D 1;
+ u64 lun_capacity;
+
+ switch (unit->memory_type) {
+ case 0: /* Normal */
+ cap_adj_fac =3D 1;
+ break;
+ case 1:
+ cap_adj_fac =3D
+     be16_to_cpu(geometry->system_code_cap_adj_fac);
+ break;
+ case 2:
+ cap_adj_fac =3D
+     be16_to_cpu(geometry->non_persist_cap_adj_fac);
+ break;
+ case 3:
+ cap_adj_fac =3D
+     be16_to_cpu(geometry->enhanced1_cap_adj_fac);
+ break;
+ case 4:
+ cap_adj_fac =3D
+     be16_to_cpu(geometry->enhanced2_cap_adj_fac);
+ break;
+ case 5:
+ cap_adj_fac =3D
+     be16_to_cpu(geometry->enhanced3_cap_adj_fac);
+ break;
+ case 6:
+ cap_adj_fac =3D
+     be16_to_cpu(geometry->enhanced4_cap_adj_fac);
+ break;
+ default:
+ printf("ilegal memory type\n");
+ }
+
+ if (unit->memory_type) {
+ /* See geometry Descriptor/cap_adj_fac in Jedec. */
+ cap_adj_facfl =3D (float)(cap_adj_fac / 256.00);
+ }
+
+ lun_capacity =3D 512 * (u64)be32_to_cpu(unit->num_allocunits) *
+     geometry->allocationunit_size *
+     (u64)be32_to_cpu(geometry->segment_size);
+
+ lun_capacity /=3D cap_adj_facfl;
+ u32 mb =3D (u32)(lun_capacity >> 20);
+ return mb;
+}
+
+void ufs_tool_print_luns(void)
+{
+ struct ufs_geometry_descriptor geometry;
+ struct ufs_config_descriptor config_desc;
+ struct ufs_device_descriptor device_desc;
+ struct ufs_hba *hba;
+ int i;
+
+ hba =3D ufstool_probe_dev(0);
+ if (!hba) {
+ printf("ufs_tool: failed to get hba\n");
+ return;
+ }
+ if (ufshcd_query_desc_idn_config(hba, &config_desc)) {
+ printf("Failed to read configuration\n");
+ return;
+ }
+
+ if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
+ printf("Failed to read 0h\n");
+ return;
+ }
+
+ if (ufshcd_query_desc_idn_geometry(hba, &geometry)) {
+ printf("Failed to read geometry\n");
+ return;
+ }
+
+ u8 *config =3D (u8 *)&config_desc;
+ /* Header */
+ for (i =3D 0; i < 8; i++) {
+ const int COL_WIDTH  =3D 14;
+ int off;
+ char buf[32];
+ struct ufs_unit_configurable_parameters *unit;
+
+ off =3D device_desc.ud0_base_offset +
+       (i * device_desc.config_length);
+
+ unit =3D (struct ufs_unit_configurable_parameters *)&config[off];
+
+ if (unit->lu_enable !=3D 1)
+ continue;
+
+ snprintf(buf, sizeof(buf), "LUN %d", i);
+ printf("| %-*s", COL_WIDTH - 2, buf);
+ }
+ printf("|\n");
+ /* Sizes */
+ for (i =3D 0; i < 8; i++) {
+ int off;
+ s64 mb;
+ char size_str[32];
+ const int COL_WIDTH =3D 14;
+ struct ufs_unit_configurable_parameters *unit;
+
+ off =3D device_desc.ud0_base_offset +
+       (i * device_desc.config_length);
+
+ unit =3D (struct ufs_unit_configurable_parameters *)&config[off];
+
+ if (unit->lu_enable !=3D 1)
+ continue;
+
+ mb =3D calc_lun_capacity(unit, &geometry);
+
+ snprintf(size_str, sizeof(size_str), "%lld MB", mb);
+
+ printf("| %-*s", COL_WIDTH - 2, size_str);
+ }
+ printf("|\n");
+}
+
+static void ufshcd_print_idn_desc_config(struct ufs_config_descriptor
*user_cfg,
+ struct ufs_geometry_descriptor *geometry,
+ u32 base_offset, u32 config_ength)
+{
+ int i;
+ int off;
+ struct ufs_unit_configurable_parameters *unit;
+ u8 *config =3D (u8 *)user_cfg;
+ u32 mb;
+
+ ufshcd_print_config_descriptor(&user_cfg->cfg_desc);
+ for (i =3D 0; i < 8; i++) {
+ off =3D base_offset + (i * config_ength);
+
+ unit =3D (struct ufs_unit_configurable_parameters *)&config[off];
+ mb =3D calc_lun_capacity(unit, geometry);
+ printf("-------------------------------------------------\n");
+ printf("LUN %d Capacity %d MB\n", i, mb);
+ printf("Name  | Value      | Description\n");
+ printf("-------------------------------------------------\n");
+ ufshcd_print_unit_param_descriptor(unit);
+ }
+}
+
+/**
+ * Decodes and prints a single 16-bit power Parameter Element.
+ * Format based on Table 7.13.
+ */
+void print_power_element(struct ufs_power_parameter_element desc)
+{
+ static const char * const units[] =3D { "n_a", "u_a", "m_a", "A" };
+ u16 element =3D desc.upower_value;
+
+ /* Bits [15:14] define the unit */
+ u8 unit_code =3D (element >> 14) & 0x03;
+
+ /* Bits [9:0] define the maximum current value */
+ u16 value =3D element & 0x03FF;
+
+ printf("%d %s", value, units[unit_code]);
+}
+
+/**
+ * Print function for UFS power Parameters Descriptor (IDN: 08h).
+ * References: Table 14.16, Table 7.12, and Table 7.13.
+ */
+void print_ufs_power_parameters(struct ufs_power_parameters_descriptor *de=
sc)
+{
+ printf("--- UFS power Parameters Descriptor (IDN: 08h) ---\n");
+ printf("Descriptor Length: 0x%x (%u bytes)\n", desc->length, desc->length=
);
+ printf("Descriptor IDN:    0x%x\n\n", desc->descriptor_idn);
+
+ printf("Level | VCC Current | VCCQ Current | VCCQ2 Current\n");
+ printf("--------------------------------------------------\n");
+
+ for (int i =3D 0; i < 5; i++) {
+ printf(" %x  | ", i);
+ /* Accessing the  levels for each supply (VCC, VCCQ, VCCQ2) */
+ /* Values represent worst-case maximum peak current */
+ print_power_element(desc->active_icc_levels_vcc[i]);
+ printf("      | ");
+ print_power_element(desc->active_icc_levels_vccq[i]);
+ printf("       | ");
+ print_power_element(desc->active_icc_levels_vccq2[i]);
+ printf("\n");
+ }
+}
+
+int ufshcd_query_desc_idn_power(struct ufs_hba *hba, int lun,
+ struct ufs_power_parameters_descriptor
+ *out_desc)
+{
+ int ret;
+ unsigned char Space[QUERY_DESC_POWER_DEF_SIZE];
+
+ memset(out_desc, 0xFF, sizeof(*out_desc));
+
+ ret =3D ufshcd_read_desc_param(hba, QUERY_DESC_IDN_POWER, lun, 0, Space,
+      QUERY_DESC_POWER_DEF_SIZE);
+
+ if (ret) {
+ puts("Err:--- UFS power Descriptor");
+ return ret;
+ }
+ memcpy(out_desc, Space, sizeof(*out_desc));
+ return ret;
+}
+
+int ufshcd_query_desc_idn_unit(struct ufs_hba *hba, int lun,
+        struct unit_descriptor *out_desc)
+{
+ int ret;
+ unsigned char unit_space[QUERY_DESC_UNIT_DEF_SIZE];
+ struct unit_descriptor *desc =3D (struct unit_descriptor *)&unit_space;
+
+ memset(desc, 0xFF, sizeof(*desc));
+ ret =3D ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, lun, 0,
+      (void *)desc, QUERY_DESC_UNIT_DEF_SIZE);
+ if (ret) {
+ puts("Err:--- UFS unit Descriptor");
+ return ret;
+ }
+ memcpy(out_desc, desc, sizeof(*out_desc));
+ return ret;
+}
+
+void ufshcd_print_unit_descriptor(struct unit_descriptor *desc)
+{
+ printf("--- UFS unit Descriptor (IDN: 02h) ---\n");
+ printf(" Name   | Value              | Description\n");
+ printf("---------------------------------------------\n");
+
+ /* Descriptor Header */
+ printf("Length | %d    | Size of descriptor\n", desc->length);
+ printf("DescriptorIdn | 0x%x | unit Descriptor ID\n",
+        desc->descriptor_idn);
+ printf("BunitIndex     | 0x%x | Logical unit Index\n",
+        desc->bunit_index);
+
+ /* configuration Parameters */
+ printf("luEnable | 0x%x | LU Enabled (01h) or Disabled (00h)\n",
+        desc->lu_enable);
+ printf("BootLunId | 0x%x| Boot LU ID (01h: A, 02h: B\n",
+        desc->boot_lun_id);
+ printf("luWriteProtect | 0x%x | WP (01h: power-on, 02h: Perm)\n",
+        desc->lu_write_protect);
+ printf("luQueueDepth   | 0x%x | Queue depth (0 if shared)\n",
+        desc->lu_queue_depth);
+ printf("psaSensitive | 0x%x  | Soldering sensitivity indicator\n",
+        desc->psa_sensitive);
+ printf("MemoryType | 0x%x  | Memory type (00h: Normal\n",
+        desc->memory_type);
+ printf("DataReliability | 0x%x | power failure protection enabled\n",
+        desc->data_reliability);
+ printf("LogicalBlockSize| 0x%x | Block size exponent (2^n)\n",
+        desc->logical_block_size);
+ /* Capacity and geometry */
+ printf("LogicalBlockCount | %d %d | Total addressable blocks\n",
+        be32_to_cpu(upper_32_bits(desc->logical_block_count)),
+        be32_to_cpu(lower_32_bits(desc->logical_block_count)));
+ printf("EraseBlockSize | 0x%x | Optimal erase granularity\n",
+        desc->erase_block_size);
+ printf("ProvisioningType | 0x%x | 00h: Full, 02h/03h: Thin\n",
+        desc->provisioning_type);
+ printf("phyMemResourceCount| %d %d  Available physical resources\n",
+        lower_32_bits(desc->phy_mem_resource_count),
+        upper_32_bits(desc->phy_mem_resource_count));
+ /* Performance and Extended Features */
+ printf("ContextCapabilities | 0x%x | Context ID & LU Multiplier\n",
+        desc->context_capabilities);
+ printf("bLargeunitGranularity_M1|");
+ printf("0x%x | Large unit granularity minus one",
+        desc->largeunit_granularity_M1);
+ puts("Reserved | Reserved for extension standards");
+ puts("luNumWriteBoosterBufferAllocunits");
+ printf(" | 0x%x | WB Buffer size in Alloc units\n",
+        desc->lu_num_write_booster_buffer_allocunits);
+}
+
+#define str_eq !strcmp
+
+int set_param_field(struct ufs_unit_configurable_parameters *ud,
+     const char *name, u32 value)
+{
+ if (str_eq(name, "boot_lun_id"))
+ ud->boot_lun_id =3D (u8)value;
+ else if (str_eq(name, "lu_enable"))
+ ud->lu_enable =3D (u8)value;
+ else if (str_eq(name, "lu_write_protect"))
+ ud->lu_write_protect =3D (u8)value;
+ else if (str_eq(name, "memory_type"))
+ ud->memory_type =3D (u8)value;
+ else if (str_eq(name, "data_reliability"))
+ ud->data_reliability =3D (u8)value;
+ else if (str_eq(name, "num_allocunits"))
+ ud->num_allocunits =3D cpu_to_be32(value);
+ else if (str_eq(name, "provisioning_type"))
+ ud->provisioning_type =3D (u8)value;
+ else if (str_eq(name, "context_capabilities"))
+ ud->context_capabilities =3D (u16)value;
+ else if (str_eq(name, "lu_num_write_booster_buffer_allocunits"))
+ ud->lu_num_write_booster_buffer_allocunits =3D (u32)value;
+ else
+ return -1;
+ return 0;
+}
+
+int ufshcd_update_lun(struct ufs_hba *hba, int lun,
+       const char *field, u32 val)
+{
+ int off;
+ int ret;
+ u8 *config;
+ struct ufs_unit_configurable_parameters *unit;
+ struct ufs_device_descriptor dev_desc;
+
+ // Populate descriptor
+ if (g_cfg_desc.cfg_desc.length =3D=3D 0 &&
+     ufshcd_query_desc_idn_config(hba, &g_cfg_desc))
+ return -EINVAL;
+
+ if (ufshcd_query_desc_idn_device(hba, &dev_desc)) {
+ printf("Failed to read IDN 0h\n");
+ return -EINVAL;
+ }
+
+ config =3D (__u8 *)&g_cfg_desc;
+ off =3D dev_desc.ud0_base_offset + (lun * dev_desc.config_length);
+
+ unit =3D (struct ufs_unit_configurable_parameters *)&config[off];
+
+ unit->logical_block_size =3D 0xC;
+ // Always enable the Lun
+ unit->lu_enable =3D 1;
+ // Enable Lun configuration
+ //g_cfg_desc.cfg_desc.write_booster_buffer_type =3D 0;
+
+ // Now change the required value
+ if (set_param_field(unit, field, val)) {
+ printf("ilegal value to set %s\n", field);
+ return -EINVAL;
+ }
+ ufshcd_print_unit_param_descriptor(unit);
+ return ret;
+}
+
+static int ufshcd_write_desc_param(struct ufs_hba *hba, enum desc_idn desc=
_id,
+    int desc_index, unsigned char param_offset,
+    unsigned char *param_write_buf,
+    unsigned char param_size)
+{
+ int ret;
+ int buff_len;
+ int selector =3D 0;
+
+ if (desc_id >=3D QUERY_DESC_IDN_MAX || !param_size)
+ return -EINVAL;
+
+ buff_len =3D param_size;
+ ret =3D ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
+     desc_id, desc_index, selector,
+     param_write_buf, &buff_len);
+ if (!ret)
+ return 0;
+ printf("Err: desc_id %d desc_index %d, param_offset %d,buflen %d,ret=3D%d=
\n",
+        (unsigned int)desc_id, desc_index,
+        (unsigned int)param_offset, buff_len, ret);
+ return ret;
+}
+
+enum flag_idn ufshcd_get_flag(const char *name)
+{
+ if (str_eq(name, "deviceinit"))
+ return QUERY_FLAG_IDN_FDEVICEINIT;
+
+ if (str_eq(name, "permanent_wpe"))
+ return QUERY_FLAG_IDN_PERMANENT_WPE;
+
+ if (str_eq(name, "pwr_on_wpe"))
+ return QUERY_FLAG_IDN_PWR_ON_WPE;
+
+ if (str_eq(name, "bkops_en"))
+ return QUERY_FLAG_IDN_BKOPS_EN;
+
+ if (str_eq(name, "life_span_mode"))
+ return QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE;
+
+ if (str_eq(name, "purge_enable"))
+ return QUERY_FLAG_IDN_PURGE_ENABLE;
+
+ if (str_eq(name, "fphy_resource_removal"))
+ return QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL;
+
+ if (str_eq(name, "busy_rtc"))
+ return QUERY_FLAG_IDN_BUSY_RTC;
+
+ if (str_eq(name, "permanently_disable_fw_update"))
+ return QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE;
+
+ if (str_eq(name, "write_booster_en"))
+ return QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN;
+
+ if (str_eq(name, "wb_buf_flush_en"))
+ return QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN;
+
+ if (str_eq(name, "wb_buf_flush_h8"))
+ return QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8;
+ return -1;
+}
+
+int ufshcd_query_user_flag(struct ufs_hba *hba, const char *flag_name)
+{
+ enum flag_idn idn;
+ bool flag_res;
+ int ret;
+
+ if (!hba) {
+ printf("invalid hba\n");
+ return -EINVAL;
+ }
+
+ idn =3D ufshcd_get_flag(flag_name);
+ if ((int)idn < 0) {
+ printf("%s invalid\n", __func__);
+ return -EINVAL;
+ }
+ ret =3D
+     ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG, idn, &flag_res);
+ if (!ret) {
+ printf("%s =3D %x\n", flag_name, flag_res);
+ return 0;
+ }
+ printf("%s idn query failed\n", flag_name);
+ return ret;
+}
+
+#define CMD_HELP \
+ "query:\n" \
+ "\tDevice desc (0h)\n" \
+ "\tGeometry desc(7h)\n" \
+ "\tPower desc (8h)\n" \
+ "\tUnit desc(2h)\n" \
+ "\tConfig desc(1h)\n" \
+ "****************************\n" \
+ "\n\tset_lun [LUN] (parm)\n" \
+ "\t\tlu_enable\n" \
+ "\t\tboot_lun_id\n" \
+ "\t\tlu_write_protect\n" \
+ "\t\tmemory_type\n" \
+ "\t\tdata_reliability\n" \
+ "\t\tnum_allocunits\n" \
+ "\t\tlogical_block_size\n" \
+ "\t\tprovisioning_type\n" \
+ "\t\tcontext_capabilities\n" \
+ "\t\tlu_num_write_booster_buffer_allocunits\n\n" \
+ "****************************\n" \
+ "\n\tset_dev_desc [parm] [value]\n" \
+ "\t\tdescriptor_idn\n" \
+ "\t\tdevice\n" \
+ "\t\tdevice_class\n" \
+ "\t\tdevice_sub_class\n" \
+ "\t\tnumber_lu\n" \
+ "\t\tboot_enable\n" \
+ "\t\tdescr_access_en\n" \
+ "\t\tinit_power_mode\n" \
+ "\t\thigh_priority_lun\n" \
+ "\t\tsecure_removal_type\n" \
+ "\t\tinitactive_icc_level\n" \
+ "\t\tqueue_depth\n" \
+ "\t\twrite_booster_buffer_preserve_user_space_en\n" \
+ "\t\twrite_booster_buffer_type\n" \
+ "\t\tspec_version\n" \
+ "\t\tmanufacturer_id\n" \
+ "\t\tperiodic_rtc_update\n" \
+ "\t\tdevice_version\n" \
+ "\t\tpsa_max_data_size\n" \
+ "\t\textended_ufs_features_support\n" \
+ "\t\tnum_shared_write_booster_buffer_allocunits\n" \
+ "\t\twrite_booster_buffer_preserve_user_space_en\n" \
+ "****************************\n" \
+ "\n\tset_cfg_desc [parm] [value]\n" \
+ "\t\tlength\n" \
+ "\t\tdescriptor_idn\n" \
+ "\t\tconf_desc_continue\n" \
+ "\t\tboot_enable\n" \
+ "\t\tdescr_access_en\n" \
+ "\t\tinitpower_mode\n" \
+ "\t\thigh_priority_lun\n" \
+ "\t\tsecure_removal_type\n" \
+ "\t\tinit_active_icc_level\n" \
+ "\t\tperiodic_rtc_update\n" \
+ "\t\treserved_HPB\n" \
+ "\t\trpmb_region_enable\n" \
+ "\t\trpmb_region1_size\n" \
+ "\t\trpmb_region2_size\n" \
+ "\t\trpmb_region3_size\n" \
+ "\t\twrite_booster_buffer_preserve_user_space_en\n" \
+ "\t\twrite_booster_buffer_type\n" \
+ "\t\tnum_shared_write_booster_buffer_allocunits\n" \
+ "****************************\n" \
+ "\n\tflag [flag name]\n" \
+ "\t\tdeviceinit\n" \
+ "\t\tpermanent_wpe\n" \
+ "\t\tpwr_on_wpe\n" \
+ "\t\tbkops_en\n" \
+ "\t\tlife_span_mode\n" \
+ "\t\tpurge_enable\n" \
+ "\t\tfphy_resource_removal\n" \
+ "\t\tbusy_rtc\n" \
+ "\t\tpermanently_disable_fw_update\n" \
+ "\t\twrite_booster_en\n" \
+ "\t\twb_buf_flush_en\n" \
+ "\t\twb_buf_flush_h8\n" \
+ "****************************\n" \
+ "\texamples :\n" \
+ "\n\nto write lun please\n" \
+ "\tufs query 0 1\n" \
+ "\tfix the luns, disable lu_enable\n" \
+ "\tuse ufs set [LUN] num_allocunits=3Dxxx to set size\n" \
+ "\tufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000\n" =
\
+ "\tufs set_cfg_desc write_booster_buffer_type 1\n" \
+ "\tufs commit\n"
+
+void ufs_tool_help(void)
+{
+ puts(CMD_HELP);
+}
+
+void idn_read(struct ufs_hba *hba, int idn, int lun)
+{
+ struct ufs_device_descriptor device_desc;
+ struct unit_descriptor unit_desc;
+ struct ufs_geometry_descriptor geometry;
+ struct ufs_power_parameters_descriptor power_desc;
+
+ switch (idn) {
+ case QUERY_DESC_IDN_DEVICE: /* 0x0 */
+ if (!ufshcd_query_desc_idn_device(hba, &device_desc))
+ ufshcd_print_device_descriptor(&device_desc);
+ break;
+
+ case QUERY_DESC_IDN_GEOMETRY: /* 0x7 */
+ if (!ufshcd_query_desc_idn_geometry(hba, &geometry)) {
+ ufshcd_print_idn_geometry_desc(&geometry);
+ return;
+ }
+ printf("Failed to read geometry\n");
+ break;
+
+ case QUERY_DESC_IDN_UNIT: /* 0x2 */
+ unit_desc.bunit_index =3D lun;
+ if (!ufshcd_query_desc_idn_unit(hba, lun, &unit_desc))
+ ufshcd_print_unit_descriptor(&unit_desc);
+ break;
+
+ case QUERY_DESC_IDN_POWER:
+ if (!ufshcd_query_desc_idn_power(hba, lun, &power_desc))
+ print_ufs_power_parameters(&power_desc);
+ break;
+
+ case QUERY_DESC_IDN_CONFIGURATION: /* 0x1 */
+ if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
+ printf("Failed to read IDN 0h\n");
+ return;
+ }
+
+ if (ufshcd_query_desc_idn_geometry(hba, &geometry)) {
+ printf("Failed to read geometry\n");
+ return;
+ }
+
+ ufshcd_query_desc_idn_config(hba, &g_cfg_desc);
+ ufshcd_print_idn_desc_config(&g_cfg_desc, &geometry,
+      device_desc.ud0_base_offset,
+      device_desc.config_length);
+ break;
+
+ default:
+ printf("Ilegal IDN %d\n", idn);
+ ufs_tool_help();
+ }
+}
+
+static int set_config_desc_field(struct config_descriptor *desc,
+ const char *fieldname, u32 value)
+{
+ /* --- Descriptor Header & Flow Control --- */
+ if (!strcmp(fieldname, "length"))
+ desc->length =3D (u8)value;
+ else if (!strcmp(fieldname, "descriptor_idn"))
+ desc->descriptor_idn =3D (u8)value;
+ else if (!strcmp(fieldname, "conf_desc_continue"))
+ desc->conf_desc_continue =3D (u8)value;
+ /* --- Device Descriptor Configurable Parameters --- */
+ else if (!strcmp(fieldname, "boot_enable"))
+ desc->boot_enable =3D (u8)value;
+ else if (!strcmp(fieldname, "descr_access_en"))
+ desc->descr_access_en =3D (u8)value;
+ else if (!strcmp(fieldname, "initpower_mode"))
+ desc->initpower_mode =3D (u8)value;
+ else if (!strcmp(fieldname, "high_priority_lun"))
+ desc->high_priority_lun =3D (u8)value;
+ else if (!strcmp(fieldname, "secure_removal_type"))
+ desc->secure_removal_type =3D (u8)value;
+ else if (!strcmp(fieldname, "init_active_icc_level"))
+ desc->init_active_icc_level =3D (u8)value;
+ else if (!strcmp(fieldname, "periodic_rtc_update"))
+ desc->periodic_rtc_update =3D (u16)value;
+ else if (!strcmp(fieldname, "reserved_HPB"))
+ desc->reserved_HPB =3D (u8)value;
+ /* --- RPMB Configuration Parameters --- */
+ else if (!strcmp(fieldname, "rpmb_region_enable"))
+ desc->rpmb_region_enable =3D (u8)value;
+ else if (!strcmp(fieldname, "rpmb_region1_size"))
+ desc->rpmb_region1_size =3D (u8)value;
+ else if (!strcmp(fieldname, "rpmb_region2_size"))
+ desc->rpmb_region2_size =3D (u8)value;
+ else if (!strcmp(fieldname, "rpmb_region3_size"))
+ desc->rpmb_region3_size =3D (u8)value;
+ else if (!strcmp(fieldname,
+ "write_booster_buffer_preserve_user_space_en"))
+ desc->write_booster_buffer_preserve_user_space_en =3D (u8)value;
+ else if (!strcmp(fieldname, "write_booster_buffer_type"))
+ desc->write_booster_buffer_type =3D (u8)value;
+ else if (!strcmp(fieldname,
+ "num_shared_write_booster_buffer_allocunits"))
+ desc->num_shared_write_booster_buffer_allocunits =3D
+ cpu_to_be32(value);
+ else
+ return -1;
+ return 0;
+}
+
+static int set_device_desc_field(struct ufs_device_descriptor *dev_desc,
+ const char *name, u32 value)
+{
+ if (!strcmp(name, "descriptor_idn"))
+ dev_desc->descriptor_idn =3D (u8)value;
+ else if (!strcmp(name, "device"))
+ dev_desc->device =3D (u8)value;
+ else if (!strcmp(name, "device_class"))
+ dev_desc->device_class =3D (u8)value;
+ else if (!strcmp(name, "device_sub_class"))
+ dev_desc->device_sub_class =3D (u8)value;
+ else if (!strcmp(name, "number_lu"))
+ dev_desc->number_lu =3D (u8)value;
+ else if (!strcmp(name, "boot_enable"))
+ dev_desc->boot_enable =3D (u8)value;
+ else if (!strcmp(name, "descr_access_en"))
+ dev_desc->descr_access_en =3D (u8)value;
+ else if (!strcmp(name, "bInitPowerMode"))
+ dev_desc->init_power_mode =3D (u8)value;
+ else if (!strcmp(name, "high_priority_lun"))
+ dev_desc->high_priority_lun =3D (u8)value;
+ else if (!strcmp(name, "secure_removal_type"))
+ dev_desc->secure_removal_type =3D (u8)value;
+ else if (!strcmp(name, "initactive_icc_level"))
+ dev_desc->init_active_icc_level =3D (u8)value;
+ else if (!strcmp(name, "queue_depth"))
+ dev_desc->queue_depth =3D (u8)value;
+ else if (!strcmp(name, "write_booster_buffer_preserve_user_space_en"))
+ dev_desc->write_booster_buffer_preserve_user_space_en =3D (u8)value;
+ else if (!strcmp(name, "write_booster_buffer_type"))
+ dev_desc->write_booster_buffer_type =3D (u8)value;
+ else if (!strcmp(name, "spec_version"))
+ dev_desc->spec_version =3D cpu_to_be16(value);
+ else if (!strcmp(name, "manufacturer_id"))
+ dev_desc->manufacturer_id =3D cpu_to_be16(value);
+ else if (!strcmp(name, "periodic_rtc_update"))
+ dev_desc->periodic_rtc_update =3D cpu_to_be16(value);
+ else if (!strcmp(name, "device_version"))
+ dev_desc->device_version =3D cpu_to_be16(value);
+ else if (!strcmp(name, "psa_max_data_size"))
+ dev_desc->psa_max_data_size =3D cpu_to_be32(value);
+ else if (!strcmp(name, "extended_ufs_features_support"))
+ dev_desc->extended_ufs_features_support =3D cpu_to_be32(value);
+ else if (!strcmp(name, "num_shared_write_booster_buffer_allocunits"))
+ dev_desc->num_shared_write_booster_buffer_allocunits =3D be32_to_cpu(valu=
e);
+ else
+ return -1;
+ return 0;
+}
+
+int ufs_tool_set_config_desc(const char *name, u32 value)
+{
+ struct ufs_hba *hba =3D ufstool_probe_dev(0);
+
+ if (g_cfg_desc.cfg_desc.length =3D=3D 0) {
+ if (ufshcd_query_desc_idn_config(hba, &g_cfg_desc)) {
+ printf("Failed to read device descriptor\n");
+ return -EINVAL;
+ }
+ }
+
+ if (set_config_desc_field(&g_cfg_desc.cfg_desc, name, value)) {
+ printf("Failed to set parameters %s descriptor\n", name);
+ return -EINVAL;
+ }
+ ufshcd_print_config_descriptor(&g_cfg_desc.cfg_desc);
+ return 0;
+}
+
+int ufs_tool_set_device_desc(const char *name, u32 value)
+{
+ struct ufs_device_descriptor device_desc;
+ struct ufs_hba *hba =3D ufstool_probe_dev(0);
+ int ret;
+
+ if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
+ printf("Failed to read device descriptor\n");
+ return -EINVAL;
+ }
+
+ if (set_device_desc_field(&device_desc, name, value)) {
+ printf("Failed to set parameters %s descriptor\n", name);
+ return -EINVAL;
+ }
+
+ ret =3D ufshcd_write_desc_param(hba, QUERY_DESC_IDN_DEVICE,
+       0, 0, (void *)&device_desc,
+       UFS_DESC_SIZE);
+ if (ret) {
+ printf("Failed to write %s\n", name);
+ return -EINVAL;
+ }
+ return ret;
+}
+
+int ufs_tool_commit(void)
+{
+ int ret;
+ u8 *config;
+ struct ufs_hba *hba =3D ufstool_probe_dev(0);
+
+ config =3D (__u8 *)&g_cfg_desc;
+ ufshcd_cache_flush(config, QUERY_DESC_UNIT_DEF_SIZE);
+ ret =3D ufshcd_write_desc_param(hba,
+       QUERY_DESC_IDN_CONFIGURATION,
+       0, 0, config,
+       g_cfg_desc.cfg_desc.length);
+
+ if (ret)
+ printf("Failed to write Configuration\n");
+ return ret;
+}
+
+int ufs_tool_clearall(void)
+{
+ int ret;
+ u8 *config;
+ struct ufs_device_descriptor device_desc;
+ struct ufs_hba *hba =3D ufstool_probe_dev(0);
+
+ // Populate descriptor
+ if (g_cfg_desc.cfg_desc.length =3D=3D 0 &&
+     ufshcd_query_desc_idn_config(hba, &g_cfg_desc)) {
+ return -EINVAL;
+ }
+ config =3D (__u8 *)&g_cfg_desc;
+
+ ufshcd_cache_flush(config, QUERY_DESC_UNIT_DEF_SIZE);
+ if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
+ printf("Failed to read IDN 0h\n");
+ return -1;
+ }
+
+ ufshcd_clearall_luns(&g_cfg_desc,
+      device_desc.ud0_base_offset,
+      device_desc.config_length);
+
+ ret =3D ufshcd_write_desc_param(hba,
+       QUERY_DESC_IDN_CONFIGURATION,
+       0, 0, config,
+       g_cfg_desc.cfg_desc.length);
+
+ if (ret)
+ printf("Failed to Clear Configuration\n");
+ return ret;
+}
+
+int ufs_tool_set_lun(int lun, const char *parm, u32 val)
+{
+ struct ufs_hba *hba =3D ufstool_probe_dev(0);
+
+ return ufshcd_update_lun(hba, lun, parm, val);
+}
+
+int ufs_tool_query_flag(const char *flag)
+{
+ struct ufs_hba *hba =3D ufstool_probe_dev(0);
+
+ return ufshcd_query_user_flag(hba, flag);
+}
+
+int ufs_tool_query(int lun, int idn)
+{
+ struct ufs_hba *hba;
+
+ hba =3D ufstool_probe_dev(0);
+ if (!hba) {
+ printf("ufs_tool: failed to get hba\n");
+ return -1;
+ }
+
+ if (lun >=3D 0 && idn >=3D 0) {
+ idn_read(hba, idn, lun);
+ return 0;
+ }
+
+ ufs_tool_help();
+ return -1;
+}
diff --git a/drivers/ufs/ufs_tool.h b/drivers/ufs/ufs_tool.h
new file mode 100644
index 00000000000..7ba852ceed0
--- /dev/null
+++ b/drivers/ufs/ufs_tool.h
@@ -0,0 +1,394 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __UFS2_H
+#define __UFS2_H
+#include <linux/types.h>
+
+/*
+ * In a QUERY REQUEST UPIU, the Device Descriptor
+ * is addressed setting: DESCRIPTOR IDN =3D 00h
+ */
+struct ufs_device_descriptor {
+ u8 length; /* Size of this descriptor */
+ u8 descriptor_idn; /* Descriptor Type Identifier (00h) */
+ u8 device; /* Device type (00h: Device) */
+ u8 device_class;
+ /* UFS Device Class (00h: Mass Storage) */
+ u8 device_sub_class;
+ /* UFS Mass Storage Subclass (e.g., 00h: Embedded Bootable) */
+ u8 protocol;
+ /* Protocol supported by UFS Device (00h: SCSI) */
+ u8 number_lu;
+ /* Number of Logical units (non-well known)  */
+ u8 number_wlu;
+ /* Number of Well known Logical units (MDV =3D 04h) */
+ u8 boot_enable; /* Boot Enable (01h: enabled) */
+ u8 descr_access_en;
+ /* Descriptor Access Enable during partial boot initialization */
+
+ /* --- power Management & Priority (Offset 0x0A) --- */
+ u8 init_power_mode;
+ /* Initial power Mode after device initi (00h: UFS-Sleep, 01h: */
+ /*   Active) [4, 5] */
+ u8 high_priority_lun;
+ /* High Priority Logical unit (7Fh if all LUs have same priority) */
+ u8 secure_removal_type;
+ /* Secure Removal Type (00h: erase, 01h: overwrite/erase, etc.) */
+ u8 security_lu;
+ /* Support for security LU (01h: RPMB) */
+ u8 background_ops_term_lat;
+ /* Background Operations Termination Latency (in units of 10 ms) */
+ u8 init_active_icc_level;
+ /* Initial Active ICC Level after power on/reset (00h to 0Fh) */
+
+ /* --- Version, Naming, & configuration Pointers (Offset 0x10) --- */
+ u16 spec_version;
+ /* Specification version in BCD format (e.g., 3.1 =3D 0310h) */
+ u16 manufacture_date; /* Manufacturing Date in BCD format */
+ u8 manufacturer_name;
+ /* Index to the Manufacturer Name string descriptor */
+ u8 product_name;
+ /* Index to the Product Name string descriptor */
+ u8 serial_number;
+ /* Index to the Serial Number string descriptor */
+ u8 oem_id;
+ /* Index to the OEM ID string descriptor */
+ u16 manufacturer_id;
+ /* Manufacturer ID code and Bank Index (JEP106 definition) */
+ u8 ud0_base_offset;
+ /* Offset of unit Descriptor 0 configurable parameters within the */
+ /* configuration Descriptor */
+ u8 config_length;
+ /* Total size of the configurable unit Descriptor parameters */
+ u8 device_rtt_cap;
+ /* Maximum number of outstanding Ready To Transfer (RTT) UPIUs */
+ /* supported  (min 2) */
+ u16 periodic_rtc_update;
+ /* Frequency and method of Real-Time Clock update */
+
+ /* --- Feature Support & Device Status (Offset 0x1F) --- */
+ u8 ufs_features_support;
+ /* Bitmap indicating supported UFS features (FFU, PSA, etc.) */
+ u8 ffu_timeout;
+ /* Field Firmware Update Timeout (in seconds) */
+ u8 queue_depth;
+ /* Queue Depth (0: per-LU queueing; 1-255: shared queue depth) */
+ u16 device_version; /* Device Version */
+ u8 num_secure_wp_area;
+ /* Total number of Secure Write Protect */
+ /* Areas supported (max 32) */
+ u32 psa_max_data_size;
+ /* PSA Maximum Data Size (in units of 4 Kbyte) */
+ u8 psa_state_timeout;
+ /* PSA State Timeout (max command timeout for b_psa_state change) */
+ u8 product_revision_level;
+ /* Index to the Product Revision Level string descriptor */
+ u8 reserved_2bh[18]; /* reserved */
+ u8 reserved_30h[19];
+ /* Reserved for Unified Memory Extension standard */
+ u8 reserved_40h[20];
+ /* Reserved for Host Performance Booster (HPB) Extension Standard */
+ u8 reserved_43h[21]; /* Reserved */
+
+ /* --- Extended Feature Support (Offset 0x4F) --- */
+ u32 extended_ufs_features_support;
+ /* Extended UFS Features Support (including WriteBooster, */
+ /* offset 53h Performance Throttling) */
+ u8 write_booster_buffer_preserve_user_space_en;
+ /* offset 54h Preserve User Space mode for WriteBooster Buffer */
+ u8 write_booster_buffer_type;
+ /*  offset 55h WriteBooster Buffer Type
+ *  (0h:dedicated buffer,01h: shared buffer)
+ */
+ u32 num_shared_write_booster_buffer_allocunits;
+ /* WriteBooster Buffer size for shared configuration */
+ /* (in Allocation units) */
+} __packed;
+
+struct unit_descriptor {
+ u8 length; /* Size of this descriptor (Default: 2Dh) */
+ u8 descriptor_idn; /* unit Descriptor Type Identifier (02h) */
+ u8 bunit_index; /* The index of the Logical unit */
+
+ /* --- configuration Parameters --- */
+ u8 lu_enable; /* 01h: LU enabled, 00h: LU disabled */
+ u8 boot_lun_id;
+ /* 01h: Boot LU A, 02h: Boot LU B, 00h: Not bootable */
+ u8 lu_write_protect;
+ /* 01h: power-on WP, 02h: Permanent WP, 00h: None */
+ u8 lu_queue_depth;
+ /* LU-specific queue depth (0 if shared queuing is used) */
+ u8 psa_sensitive;
+ /* 01h: Sensitive to soldering, 00h: Not sensitive */
+ u8 memory_type;
+ /* Memory type (e.g., 00h: Normal, 01h: System Code) */
+ u8 data_reliability;
+ /* 01h: Data protected against power failure */
+ u8 logical_block_size;
+ /* Logical Block Size exponent (e.g., 0Ch =3D 4 Kbyte) */
+
+ /* --- Capacity and geometry --- */
+ u64 logical_block_count;
+ /* Total number of addressable logical blocks in the LU */
+ u32 erase_block_size;
+ /* Optimal granularity for erase/discard operations */
+ u8 provisioning_type;
+ /* 00h: Full, 02h: Thin (TPRZ=3D0), 03h: Thin (TPRZ=3D1) */
+ u64 phy_mem_resource_count;
+ /* Total physical memory resources available to the LU */
+
+ /* --- Performance and Extended Features --- */
+ u16 context_capabilities;
+ /* Bits [3:0]: MaxContextID; Bits [6:4]: Large unit Multiplier */
+ u8 largeunit_granularity_M1;
+ /* Large unit Granularity =3D 1MB * (value + 1) */
+ u8 reserved[11]; /* Reserved for HPB Extension Standard */
+ u32 lu_num_write_booster_buffer_allocunits;
+ /* WriteBooster Buffer size in Allocation units */
+} __packed;
+
+/*
+ *
+ * UFS Geometry Descriptor (IDN 07h)
+ * Total Size: 87 bytes (0x57)
+ */
+struct ufs_geometry_descriptor {
+ /* --- Descriptor Header (Offset 0x00) --- */
+ u8 length; /* Size of this descriptor (57h) */
+ u8 descriptor_idn; /* geometry Descriptor ID (07h) */
+ u8 media_technology; /* Reserved (00h) */
+ u8 reserved_03h; /* Reserved (00h) */
+
+ /* --- Capacity and Device geometry (Offset 0x04) --- */
+ u64 total_raw_device_capacity; /* Total memory available (units of 512B) =
*/
+ u8 max_number_lu; /* Max LUs: 00h (8 LUs) or 01h (32 LUs) */
+ u32 segment_size; /* Segment size (units of 512B) */
+ u8 allocationunit_size; /* Allocation unit Size (number of segments) */
+ u8 min_addr_block_size;
+ /* Min addressable block size (units of 512B, min 08h) */
+ u8 optimal_read_block_size; /* Optimal read granularity (units of 512B) *=
/
+ u8 optimal_write_block_size; /* Optimal write granularity (units of 512B)=
 */
+ u8 max_in_buffer_size; /* Max data-in buffer size (units of 512B) */
+ u8 max_out_buffer_size; /* Max data-out buffer size (units of 512B) */
+ u8 rpmb_read_write_size; /* Max RPMB frames (256B) per command */
+ u8 dynamic_capacity_resource_policy; /* 00h: per LU, 01h: per memory type=
 */
+ u8 data_ordering; /* 01h: Out-of-order data transfer supported */
+ u8 max_contex_id_number; /* Maximum supported contexts (min 5) */
+ u8 sys_data_tagunit_size; /* Granularity for System Data Tagging */
+ u8 sys_data_tag_res_size; /* Max storage area for system data tagging */
+ u8 supported_sec_r_types; /* Bitmap of supported Secure Removal Types */
+ u16 supported_memory_types;
+ /* Bitmap of supported memory types (Normal, Enhanced, etc.) */
+
+ /* --- Memory Type Capacity and Factors (Offset 0x20) --- */
+ u32 system_code_max_n_alloc_u;
+ /* Max Allocation units for System Code memory */
+ u16 system_code_cap_adj_fac;
+ /* Capacity Adjustment Factor for System Code */
+ u32 non_persist_max_n_alloc_u;
+ /* Max Allocation units for Non-Persistent memory */
+ u16 non_persist_cap_adj_fac;
+ /* Capacity Adjustment Factor for Non-Persistent */
+ u32 enhanced1_max_n_alloc_u;
+ /* Max Allocation units for Enhanced memory */
+ /* Capacity Adjustment Factor for Enhanced */
+ u16 enhanced1_cap_adj_fac;
+ u32 enhanced2_max_n_alloc_u;
+ /* Max Allocation units for Enhanced memory */
+ /* Capacity Adjustment Factor for Enhanced */
+ u16 enhanced2_cap_adj_fac;
+ u32 enhanced3_max_n_alloc_u;
+ /* Max Allocation units for Enhanced memory */
+ /* Capacity Adjustment Factor for Enhanced */
+ u16 enhanced3_cap_adj_fac;
+ u32 enhanced4_max_n_alloc_u;
+ /* Max Allocation units for Enhanced memory */
+ /* Capacity Adjustment Factor for Enhanced */
+ u16 enhanced4_cap_adj_fac;
+ /* --- Performance Optimization (Offset 0x44) --- */
+ /* Optimal Logical Block Size per memory type */
+ u32 optimal_logical_block_size;
+ u8  reserved_hpb[4]; // 48h: Reserved for HPB Extension
+ u16 reserved2;   // 4Dh: Reserved
+ /* WriteBooster Parameters */
+ /* 4Fh: Max total WriteBooster Buffer size */
+ u32 write_booster_buffer_max_alloc_units;
+ /* 53h: Max LUs supporting WriteBooster (Valid: 1) */
+ u8  device_max_write_booster_lus;
+ /* 54h: LBA space reduction factor (e.g., 3 for TLC) */
+ u8  write_booster_buffer_capadjfac;
+ /* 55h: User space vs Preserve types */
+ u8  supported_write_booster_buffer_userspace_reduction_types;
+ /* 56h: LU based vs Shared buffer type */
+ u8  supported_write_booster_buffer_types;
+} __packed;
+
+/**
+ * UFS configuration Descriptor - Header and Device configurable Parameter=
s
+ * Based on Table 14.10 (INDEX =3D 00h)
+ */
+struct config_descriptor {
+ /* --- Descriptor Header --- */
+ u8 length;
+ /* 00h: Size of this descriptor (MDV: E6h) */
+ u8 descriptor_idn;
+ /* 01h: configuration Descriptor Type ID (01h) */
+
+ /* --- configuration Flow Control --- */
+ u8 conf_desc_continue;
+ /* 02h: 00h =3D Last descriptor (apply config); */
+ /* 01h =3D More descriptors follow */
+
+ /* --- Device Descriptor configurable Parameters --- */
+ u8 boot_enable;
+ /* 03h: Enables boot feature (01h: enabled) */
+ u8 descr_access_en;
+ /* 04h: Enables Device Descriptor access after partial init */
+ u8 initpower_mode;
+ /* 05h: Initial power Mode after reset (01h: Active) */
+ u8 high_priority_lun;
+ /* 06h: LUN of the high priority logical unit */
+ u8 secure_removal_type;
+ /* 07h: configures secure removal (e.g., 00h: erase) */
+ u8 init_active_icc_level;
+ /* 08h: Initial ICC level after reset (00h-0Fh) */
+ u16 periodic_rtc_update;
+ /* 09h: Frequency/method of Real-Time Clock update */
+ u8 reserved_HPB;
+ /* 0Bh: Reserved for Host Performance Booster */
+
+ /* --- RPMB configuration Parameters --- */
+ u8 rpmb_region_enable;
+ /* 0Ch: Bitmask to enable RPMB regions 1-3 */
+ u8 rpmb_region1_size;
+ /* 0Dh: Size of RPMB region 1 in 128KB units */
+ u8 rpmb_region2_size;
+ /* 0Eh: Size of RPMB region 2 in 128KB units */
+ u8 rpmb_region3_size;
+ /* 0Fh: Size of RPMB region 3 in 128KB units */
+
+ /* --- WriteBooster configuration Parameters --- */
+ u8 write_booster_buffer_preserve_user_space_en;
+ /* 10h: 01h =3D Preserve user space */
+ u8 write_booster_buffer_type;
+ /* 11h: 00h =3D Dedicated LU; 01h =3D Shared */
+ u32 num_shared_write_booster_buffer_allocunits;
+ /* 12h: Shared buffer size in Alloc units */
+} __packed;
+
+/**
+ * UFS unit Descriptor configurable Parameters
+ * Found within the configuration Descriptor (IDN: 01h)
+ * Based on Table 14.12
+ */
+struct ufs_unit_configurable_parameters {
+ u8 lu_enable; /* 01h: Enabled, 00h: Disabled */
+
+ u8 boot_lun_id; /* 0 Not Bootable,1-A or 2-B */
+
+ /* 01h: Boot LU A, 02h: Boot LU B, 00h: Not bootable */
+ u8 lu_write_protect;
+ /* 00h: None, 01h: power-on WP, 02h: Permanent WP */
+ u8 memory_type;
+ /* Memory type (00h: Normal, 01h: System Code) */
+
+ /* Number of allocation units assigned to the LU. */
+ u32 num_allocunits;
+
+ u8 data_reliability; /* 01h: Protected against power failure */
+
+ /* Block size exponent (e.g., 0Ch =3D 4 KB) */
+ u8 logical_block_size;
+
+ /* 00h: Full, 02h: Thin (TPRZ=3D0), 03h: Thin (TPRZ=3D1) */
+ u8 provisioning_type;
+
+ u16 context_capabilities; /* LU Context support and multipliers */
+
+ u8 reserved_0dh[6]; /* Reserved */
+
+ u8 reserved_hpb[7];
+ /* Reserved for Host Performance Booster Extension */
+
+ u32 lu_num_write_booster_buffer_allocunits;
+ /* WriteBooster Buffer size in Allocation units. */
+} __packed;
+
+struct ufs_config_descriptor {
+ struct config_descriptor cfg_desc;
+ /*
+ * NOTE: For INDEX =3D 00h, configurable parameters
+ * for unit Descriptors 0 to 7
+ */
+ /* follow this header at the offset defined
+ * by b_ud0_base_offset
+ */
+ unsigned char space[QUERY_DESC_CONFIGURATION_DEF_SIZE -
+     sizeof(struct config_descriptor)];
+} __packed;
+
+/**
+ * UFS power Parameter Element Format
+ * Based on Table 7.13
+ */
+struct ufs_power_parameter_element {
+ /* Bits [15:14]: unit (00b:n_a, 01b:u_a, 10b:m_a, 11b:A) */
+ /* Bits [13:10]: Reserved (0000b) */
+ /* Bits [9:0]:   Value (Maximum current expected) */
+ u16 upower_value;
+};
+
+/**
+ * UFS power Parameters Descriptor (IDN: 08h)
+ * Based on Table 14.16
+ */
+struct ufs_power_parameters_descriptor {
+ /* Offset 00h */
+ u8 length; /* Size of descriptor (62h) */
+ u8 descriptor_idn; /* Descriptor Type ID (08h) */
+
+ /* Offset 02h: Maximum current for VCC (16 levels) */
+ struct ufs_power_parameter_element active_icc_levels_vcc[5];
+ /* Offset 22h: Maximum current for VCCQ (16 levels) */
+ struct ufs_power_parameter_element active_icc_levels_vccq[5];
+ /* Offset 42h: Maximum current for VCCQ2 (16 levels) */
+ struct ufs_power_parameter_element active_icc_levels_vccq2[5];
+} __packed;
+
+/**
+ * UFS Temperature-related Attributes
+ * These are device-level attributes (Type 'D') retrieved via Query Reques=
ts.
+ * All temperature values follow the formula: Temperature (=C2=BAC) =3D Va=
lue =E2=80=93 80.
+ */
+struct  ufs_temp_parameters_descriptor {
+ /**
+ * IDN 18h: bDeviceCaseRoughTemperature [1]
+ * Represents the rough package case surface temperature.
+ * 0: Unknown Temperature.
+ * 1 ~ 250: Calculated as (Value - 80) in Celsius (-79=C2=BAC ~ 170=C2=BAC=
).
+ */
+ u8 device_case_rough_temperature;
+ /**
+ * IDN 19h: bDeviceTooHighTempBoundary
+ * High temperature boundary that triggers
+ * the TOO_HIGH_TEMP exception event.
+ * 100 ~ 250: Calculated as (Value - 80) in Celsius (20=C2=BAC ~ 170=C2=BA=
C).
+ */
+ u8 device_too_high_temp_boundary;
+ /*
+ * IDN 1Ah: bDeviceTooLowTempBoundary
+ * Low temperature boundary that triggers the TOO_LOW_TEMP
+ * exception event.
+ * 1 ~ 80: Calculated as (Value - 80) in Celsius (-79=C2=BAC ~ 0=C2=BAC).
+ */
+ u8 device_too_low_temp_boundary;
+ /**
+ * IDN 1Bh: bThrottlingStatus
+ * Indicates if the device is limiting performance due
+ * to specific conditions.
+ * bit 0: Set to 1 if performance is throttled due to Temperature.
+ * bits [7:1]: Reserved.
+ */
+ u8 throttling_status;
+} __packed__;
+
+#endif
--=20
2.43.0

--000000000000939bdf06531a31da
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-ufs-add-UFS-descriptor-configuration-utility-support.patch"
Content-Disposition: attachment; 
	filename="0001-ufs-add-UFS-descriptor-configuration-utility-support.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mptm25oc0>
X-Attachment-Id: f_mptm25oc0

RnJvbSBiNjAzNGQ0NGE4NDg0NTA2OTFlNmQ5YWVjYjE1NjM4ZmU1YTQ4OTBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXogQmVuIFllaHVkYSA8cmF6LmJlbnllaHVkYUBtb2JpbGV5
ZS5jb20+CkRhdGU6IFRodSwgMjggTWF5IDIwMjYgMTU6MDY6NTYgKzAzMDAKU3ViamVjdDogW1BB
VENIIDEvNF0gdWZzOiBhZGQgVUZTIGRlc2NyaXB0b3IvY29uZmlndXJhdGlvbiB1dGlsaXR5IHN1
cHBvcnQKCkFkZCBhIFVGUyB0b29sIGltcGxlbWVudGF0aW9uIGZvciBxdWVyeWluZywgcHJpbnRp
bmcsIGFuZCB1cGRhdGluZwpVRlMgZGVzY3JpcHRvcnMgYW5kIGNvbmZpZ3VyYXRpb24gcGFyYW1l
dGVycy4KCkZlYXR1cmVzIGluY2x1ZGU6CgoqIFF1ZXJ5IGFuZCBwcmludCBkZXZpY2UsIGdlb21l
dHJ5LCB1bml0LCBjb25maWcsIGFuZCBwb3dlciBkZXNjcmlwdG9ycwoqIERpc3BsYXkgTFVOIGNv
bmZpZ3VyYXRpb24gYW5kIGNhbGN1bGF0ZWQgY2FwYWNpdGllcwoqIFN1cHBvcnQgdXBkYXRpbmcg
TFVOLCBjb25maWcsIGFuZCBkZXZpY2UgZGVzY3JpcHRvciBmaWVsZHMKKiBBZGQgV3JpdGVCb29z
dGVyLXJlbGF0ZWQgY29uZmlndXJhdGlvbiBoYW5kbGluZwoqIEFkZCBmbGFnIHF1ZXJ5IHN1cHBv
cnQgZm9yIGNvbW1vbiBVRlMgcnVudGltZSBmbGFncwoqIEFkZCBjb21taXQgYW5kIGNsZWFyLWFs
bCBjb25maWd1cmF0aW9uIGhlbHBlcnMKKiBJbXByb3ZlIGRlc2NyaXB0b3IgZGVjb2RpbmcgYW5k
IGZvcm1hdHRlZCBkZWJ1ZyBvdXRwdXQKClRoZSB0b29sIGlzIGludGVuZGVkIGZvciBVLUJvb3Qv
VUZTIGRlYnVnZ2luZywgcHJvdmlzaW9uaW5nLAphbmQgY29uZmlndXJhdGlvbiB3b3JrZmxvd3Mu
CgpTaWduZWQtb2ZmLWJ5OiBSYXogQmVuIFllaHVkYSA8cmF6LmJlbnllaHVkYUBtb2JpbGV5ZS5j
b20+Ci0tLQogZHJpdmVycy91ZnMvdWZzX3Rvb2wuYyB8IDEyNTEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy91ZnMvdWZzX3Rvb2wuaCB8ICAzOTQgKysr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNjQ1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3Vmcy91ZnNfdG9vbC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy91ZnMvdWZzX3Rvb2wuaAoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL3Vmc190b29sLmMg
Yi9kcml2ZXJzL3Vmcy91ZnNfdG9vbC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwLi4xZjVjZTg1YmVlZAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvdWZzL3Vmc190
b29sLmMKQEAgLTAsMCArMSwxMjUxIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMCsKKyNpbmNsdWRlIDxhc20vaW8uaD4KKyNpbmNsdWRlIDxkbS9kZXZyZXMuaD4KKyNpbmNs
dWRlIDxlcnJuby5oPgorI2luY2x1ZGUgPGxpbWl0cy5oPgorI2luY2x1ZGUgPGxpbnV4L2JpdG9w
cy5oPgorI2luY2x1ZGUgPGxpbnV4L2J5dGVvcmRlci9saXR0bGVfZW5kaWFuLmg+CisjaW5jbHVk
ZSA8bGludXgvY29tcGlsZXIuaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUg
PGxpbnV4L2RtYS1tYXBwaW5nLmg+CisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVk
ZSA8bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlIDxtYWxsb2MuaD4KKyNpbmNsdWRlIDxzdGRpby5o
PgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPHN0cmluZy5oPgorI2luY2x1ZGUgPHRp
bWUuaD4KKyNpbmNsdWRlIDxkbS91Y2xhc3MuaD4KKyNpbmNsdWRlIDxkbS9kZXZpY2UuaD4KKwor
I2luY2x1ZGUgInVmcy5oIgorI2luY2x1ZGUgInVmc190b29sLmgiCisjaW5jbHVkZSA8dWZzLmg+
CisKKyNkZWZpbmUgVUZTX0RFU0NfU0laRSAodW5zaWduZWQgY2hhcikweGZmCisKK3N0YXRpYyBp
bnQgdWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2dlb21ldHJ5KHN0cnVjdCB1ZnNfaGJhICosCisJCQkJ
CSAgc3RydWN0IHVmc19nZW9tZXRyeV9kZXNjcmlwdG9yICpkZWNzKTsKK3N0YXRpYyBpbnQgdWZz
aGNkX3F1ZXJ5X2Rlc2NfaWRuX2NvbmZpZyhzdHJ1Y3QgdWZzX2hiYSAqaGJhLAorCQkJCQlzdHJ1
Y3QgdWZzX2NvbmZpZ19kZXNjcmlwdG9yICpjZmcpOworc3RhdGljIGludCB1ZnNoY2RfcXVlcnlf
ZGVzY19pZG5fZGV2aWNlKHN0cnVjdCB1ZnNfaGJhICpoYmEsCisJCQkJCXN0cnVjdCB1ZnNfZGV2
aWNlX2Rlc2NyaXB0b3IgKmRlc2MpOworc3RhdGljIGludCB1ZnNoY2RfcXVlcnlfZGVzY19pZG5f
dW5pdChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBpbnQgbHVuLAorCQkJCSAgICAgIHN0cnVjdCB1bml0
X2Rlc2NyaXB0b3IgKmRlc2MpOworCitzdGF0aWMgdm9pZAordWZzaGNkX3ByaW50X2lkbl9nZW9t
ZXRyeV9kZXNjKHN0cnVjdCB1ZnNfZ2VvbWV0cnlfZGVzY3JpcHRvciAqZGVzYyk7CitzdGF0aWMg
dm9pZCB1ZnNoY2RfcHJpbnRfZGV2aWNlX2Rlc2NyaXB0b3Ioc3RydWN0IHVmc19kZXZpY2VfZGVz
Y3JpcHRvciAqZGVzYyk7CitzdGF0aWMgdm9pZCB1ZnNoY2RfcHJpbnRfdW5pdF9kZXNjcmlwdG9y
KHN0cnVjdCB1bml0X2Rlc2NyaXB0b3IgKmRlc2MpOworc3RhdGljIHZvaWQKK3Vmc2hjZF9wcmlu
dF9pZG5fZGVzY19jb25maWcoc3RydWN0IHVmc19jb25maWdfZGVzY3JpcHRvciAqdXNlcl9jZmcs
CisJCQkgICAgIHN0cnVjdCB1ZnNfZ2VvbWV0cnlfZGVzY3JpcHRvciAqZ2VvbWV0cnksCisJCQkg
ICAgIHUzMiBiX3VkMF9iYXNlX29mZnNldCwgdTMyIGJfdV9kY29uZmlnX3BfbGVuZ3RoKTsKKwor
c3RhdGljIGludAordWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX3Bvd2VyKHN0cnVjdCB1ZnNfaGJhICpo
YmEsIGludCBsdW4sCisJCQkgICAgc3RydWN0IHVmc19wb3dlcl9wYXJhbWV0ZXJzX2Rlc2NyaXB0
b3IgKmRlc2MpOworCitzdGF0aWMgdm9pZAorcHJpbnRfdWZzX3Bvd2VyX3BhcmFtZXRlcnMoc3Ry
dWN0IHVmc19wb3dlcl9wYXJhbWV0ZXJzX2Rlc2NyaXB0b3IgKmRlc2MpOworCitzdGF0aWMgaW50
IHVmc2hjZF9xdWVyeV91c2VyX2ZsYWcoc3RydWN0IHVmc19oYmEgKmhiYSwgY29uc3QgY2hhciAq
ZmxhZ19uYW1lKTsKK3N0YXRpYyBpbnQgdWZzaGNkX3dyaXRlX2Rlc2NfcGFyYW0oc3RydWN0IHVm
c19oYmEgKmhiYSwgZW51bSBkZXNjX2lkbiBkZXNjX2lkLAorCQkJCSAgIGludCBkZXNjX2luZGV4
LCB1bnNpZ25lZCBjaGFyIHBhcmFtX29mZnNldCwKKwkJCQkgICB1bnNpZ25lZCBjaGFyICpwYXJh
bV93cml0ZV9idWYsCisJCQkJICAgdW5zaWduZWQgY2hhciBwYXJhbV9zaXplKTsKKworc3RhdGlj
IHN0cnVjdCB1ZnNfY29uZmlnX2Rlc2NyaXB0b3IgZ19jZmdfZGVzYzsKKworc3RydWN0IHVmc19o
YmEgKnVmc3Rvb2xfcHJvYmVfZGV2KGludCBpbmRleCkKK3sKKwlzdHJ1Y3QgdWRldmljZSAqZGV2
OworCXN0cnVjdCB1ZnNfaGJhICpoYmEgPSBOVUxMOworCisJaWYgKCF1Y2xhc3NfZ2V0X2Rldmlj
ZShVQ0xBU1NfVUZTLCBpbmRleCwgJmRldikpCisJCWhiYSA9IGRldl9nZXRfdWNsYXNzX3ByaXYo
ZGV2KTsKKwlyZXR1cm4gaGJhOworfQorCitpbnQgdWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2Rldmlj
ZShzdHJ1Y3QgdWZzX2hiYSAqaGJhLAorCQkJCSBzdHJ1Y3QgdWZzX2RldmljZV9kZXNjcmlwdG9y
ICpkZXNjKQoreworCWludCByZXQ7CisJaW50IHBhcmFtX29mZnNldCA9IDA7CisJaW50IGRlc2Nf
aW5kZXggPSAwOwkvKiBMVU5TIDAtNyBjb250cm9sbGVkIGJ5IGluZGV4IDAgKi8KKworCW1lbXNl
dChkZXNjLCAweDAwLCBzaXplb2YoKmRlc2MpKTsKKwlyZXQgPSB1ZnNoY2RfcmVhZF9kZXNjX3Bh
cmFtKGhiYSwgUVVFUllfREVTQ19JRE5fREVWSUNFLCBkZXNjX2luZGV4LAorCQkJCSAgICAgcGFy
YW1fb2Zmc2V0LCAodm9pZCAqKWRlc2MsCisJCQkJICAgICBVRlNfREVTQ19TSVpFKTsKKwlyZXR1
cm4gcmV0OworfQorCit2b2lkIHVmc2hjZF9wcmludF9kZXZpY2VfZGVzY3JpcHRvcihzdHJ1Y3Qg
dWZzX2RldmljZV9kZXNjcmlwdG9yICpkZXNjcmlwdG9yKQoreworCXUzMiB2YWwgPSBkZXNjcmlw
dG9yLT5udW1fc2hhcmVkX3dyaXRlX2Jvb3N0ZXJfYnVmZmVyX2FsbG9jdW5pdHM7CisKKwlwcmlu
dGYoIi0tLSBVRlMgRGV2aWNlIERlc2NyaXB0b3IgKElETjogMDBoICVsZCkgLS0tXG4iLAorCSAg
ICAgICBzaXplb2Yoc3RydWN0IHVmc19kZXZpY2VfZGVzY3JpcHRvcikpOworCisJcHJpbnRmKCIg
TmFtZSB8IFZhbHVlIHwgRGVzY3JpcHRpb25cbiIpOworCXByaW50ZigiLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cbiIpOworCS8qIERl
c2NyaXB0b3IgSGVhZGVyIChPZmZzZXQgMDBoIOKAkyAwMWgpICovCisJcHJpbnRmKCJMZW5ndGgg
fCAweCV4XG4iLCBkZXNjcmlwdG9yLT5sZW5ndGgpOworCXByaW50ZigiRGVzY3JpcHRvcklkbiB8
IDB4JXhcbiIsIGRlc2NyaXB0b3ItPmRlc2NyaXB0b3JfaWRuKTsKKworCS8qIERldmljZSBJZGVu
dGlmaWNhdGlvbiAmIENvcmUgY29uZmlndXJhdGlvbiAoT2Zmc2V0IDAyaCDigJMgMERoKSAqLwor
CXByaW50ZigiRGV2aWNlIHwgMHgleFxuIiwgZGVzY3JpcHRvci0+ZGV2aWNlKTsKKwlwcmludGYo
IkRldmljZUNsYXNzIHwgMHgleFxuIiwgZGVzY3JpcHRvci0+ZGV2aWNlX2NsYXNzKTsKKwlwcmlu
dGYoIkRldmljZVN1YkNsYXNzIHwgMHgleFxuIiwgZGVzY3JpcHRvci0+ZGV2aWNlX3N1Yl9jbGFz
cyk7CisJcHJpbnRmKCJwcm90b2NvbCB8IDB4JXhcbiIsIGRlc2NyaXB0b3ItPnByb3RvY29sKTsK
KwlwcmludGYoIk51bWJlckx1IHwgJWRcbiIsIGRlc2NyaXB0b3ItPm51bWJlcl9sdSk7CisJcHJp
bnRmKCJOdW1iZXJXTHUgfCAlZFxuIiwgZGVzY3JpcHRvci0+bnVtYmVyX3dsdSk7CisJcHJpbnRm
KCJCb290RW5hYmxlIHwgMHgleFxuIiwgZGVzY3JpcHRvci0+Ym9vdF9lbmFibGUpOworCXByaW50
ZigiRGVzY3JBY2Nlc3NFbiB8IDB4JXhcbiIsIGRlc2NyaXB0b3ItPmRlc2NyX2FjY2Vzc19lbik7
CisJcHJpbnRmKCJJbml0UG93ZXJNb2RlIHwgMHgleFxuIiwgZGVzY3JpcHRvci0+aW5pdF9wb3dl
cl9tb2RlKTsKKwlwcmludGYoImhpZ2hQcmlvcml0eUx1biB8IDB4JXhcbiIsCisJICAgICAgIGRl
c2NyaXB0b3ItPmhpZ2hfcHJpb3JpdHlfbHVuKTsKKwlwcmludGYoIlNlY3VyZVJlbW92YWxUeXBl
IHwgMHgleFxuIiwKKwkgICAgICAgZGVzY3JpcHRvci0+c2VjdXJlX3JlbW92YWxfdHlwZSk7CisJ
cHJpbnRmKCJTZWN1cml0eUx1IHwgMHgleFxuIiwgZGVzY3JpcHRvci0+c2VjdXJpdHlfbHUpOwor
CisJLyogcG93ZXIgTWFuYWdlbWVudCwgVmVyc2lvbiAmIFBvaW50ZXJzIChPZmZzZXQgMEVoIOKA
kyAyQWgpICovCisJcHJpbnRmKCJiX2JhY2tncm91bmRfb3BzX3Rlcm1fbGF0IHwgMHgleFxuIiwK
KwkgICAgICAgZGVzY3JpcHRvci0+YmFja2dyb3VuZF9vcHNfdGVybV9sYXQpOworCXByaW50Zigi
Yl9pbml0X2FjdGl2ZV9pY2NfbGV2ZWwgfCAweCV4XG4iLAorCSAgICAgICBkZXNjcmlwdG9yLT5p
bml0X2FjdGl2ZV9pY2NfbGV2ZWwpOworCXByaW50ZigiU3BlY1ZlcnNpb24gfCAweCV4XG4iLAor
CSAgICAgICBfX2J1aWx0aW5fYnN3YXAxNihkZXNjcmlwdG9yLT5zcGVjX3ZlcnNpb24pKTsKKwlw
cmludGYoIk1hbnVmYWN0dXJlRGF0ZSB8IDB4JXhcbiIsIGRlc2NyaXB0b3ItPm1hbnVmYWN0dXJl
X2RhdGUpOworCXByaW50ZigiTWFudWZhY3R1cmVyTmFtZSB8IDB4JXhcbiIsIGRlc2NyaXB0b3It
Pm1hbnVmYWN0dXJlcl9uYW1lKTsKKwlwcmludGYoIlByb2R1Y3ROYW1lIHwgMHgleFxuIiwgZGVz
Y3JpcHRvci0+cHJvZHVjdF9uYW1lKTsKKwlwcmludGYoIlNlcmlhbE51bWJlciB8IDB4JXhcbiIs
IGRlc2NyaXB0b3ItPnNlcmlhbF9udW1iZXIpOworCXByaW50ZigiT0VNSWQgfCAweCV4XG4iLCBk
ZXNjcmlwdG9yLT5vZW1faWQpOworCXByaW50ZigiTWFudWZhY3R1cmVySWQgfCAweCV4XG4iLCBk
ZXNjcmlwdG9yLT5tYW51ZmFjdHVyZXJfaWQpOworCXByaW50ZigiVWQwQmFzZU9mZnNldCB8ICVk
XG4iLCBkZXNjcmlwdG9yLT51ZDBfYmFzZV9vZmZzZXQpOworCXByaW50ZigiRENvbmZpZ0xlbmd0
aCB8ICVkXG4iLAorCSAgICAgICBkZXNjcmlwdG9yLT5jb25maWdfbGVuZ3RoKTsKKwlwcmludGYo
IkRldmljZVJ0dENhcCB8IDB4JXhcbiIsIGRlc2NyaXB0b3ItPmRldmljZV9ydHRfY2FwKTsKKwlw
cmludGYoIlBlcmlvZGljUnRjVXBkYXRlIHwgMHgleFxuIiwKKwkgICAgICAgZGVzY3JpcHRvci0+
cGVyaW9kaWNfcnRjX3VwZGF0ZSk7CisJcHJpbnRmKCJVZnNGZWF0dXJlc1N1cHBvcnQgfCAweCV4
XG4iLAorCSAgICAgICBkZXNjcmlwdG9yLT51ZnNfZmVhdHVyZXNfc3VwcG9ydCk7CisJcHJpbnRm
KCJGZnVUaW1lb3V0IHwgJWRcbiIsIGRlc2NyaXB0b3ItPmZmdV90aW1lb3V0KTsKKwlwcmludGYo
IlF1ZXVlRGVwdGggfCAlZFxuIiwgZGVzY3JpcHRvci0+cXVldWVfZGVwdGgpOworCXByaW50Zigi
RGV2aWNlVmVyc2lvbiB8IDB4JXhcbiIsIGRlc2NyaXB0b3ItPmRldmljZV92ZXJzaW9uKTsKKwlw
cmludGYoIk51bVNlY3VyZVdwQXJlYSB8IDB4JXhcbiIsCisJICAgICAgIGRlc2NyaXB0b3ItPm51
bV9zZWN1cmVfd3BfYXJlYSk7CisJcHJpbnRmKCJQc2FNYXhEYXRhU2l6ZSB8IDB4JXhcbiIsCisJ
ICAgICAgIGRlc2NyaXB0b3ItPnBzYV9tYXhfZGF0YV9zaXplKTsKKwlwcmludGYoIlBzYVN0YXRl
VGltZW91dCB8IDB4JXhcbiIsCisJICAgICAgIGRlc2NyaXB0b3ItPnBzYV9zdGF0ZV90aW1lb3V0
KTsKKwlwcmludGYoIlByb2R1Y3RSZXZpc2lvbkxldmVsIHwgMHgleFxuIiwKKwkgICAgICAgZGVz
Y3JpcHRvci0+cHJvZHVjdF9yZXZpc2lvbl9sZXZlbCk7CisKKwkvKiBFeHRlbmRlZCBGZWF0dXJl
cyAoT2Zmc2V0IDRGaCDigJMgNThoKSAqLworCXByaW50ZigiRXh0ZW5kZWRVZnNGZWF0dXJlc1N1
cHBvcnQgIik7CisJcHJpbnRmKCJ8IDB4JXggfChpbmNsdWRlcyAgV3JpdGVCb29zdGVyL1Rocm90
dGxpbmcpXG4iLAorCSAgICAgICBiZTMyX3RvX2NwdShkZXNjcmlwdG9yLT5leHRlbmRlZF91ZnNf
ZmVhdHVyZXNfc3VwcG9ydCkpOworCisJcHJpbnRmKCJXcml0ZUJvb3N0ZXJCdWZmZXJQcmVzZXJ2
ZVVzZXJTcGFjZUVuIik7CisJcHJpbnRmKCJ8IDB4JXggfCBQcmVzZXJ2ZSBVc2VyIFNwYWNlIG1v
ZGUgZm9yIFdyaXRlQm9vc3RlciBCdWZmZXJcbiIsCisJICAgICAgIGRlc2NyaXB0b3ItPndyaXRl
X2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZlX3VzZXJfc3BhY2VfZW4pOworCisJcHJpbnRmKCJ3cml0
ZSBib29zdGVyIGJ1ZmZlciB0eXBlIik7CisJcHJpbnRmKCJ8IDB4JXggfCBXcml0ZUJvb3N0ZXIg
QnVmZmVyIFR5cGUiLAorCSAgICAgICBkZXNjcmlwdG9yLT53cml0ZV9ib29zdGVyX2J1ZmZlcl90
eXBlKTsKKwlwdXRzKCIoMDBoOiBMVSBkZWRpY2F0ZWQsIDAxaDogc2hhcmVkKVxuIik7CisKKwlw
cmludGYoIk51bVNoYXJlZFdyaXRlQm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0cyB8Iik7CisJcHJp
bnRmKCIlZCB8IFNoYXJlZCBXcml0ZUJvb3N0ZXIgQnVmIHNpemUgKGluIEFsbG9jYXRpb24gdW5p
dHMpXG4iLAorCSAgICAgICBiZTMyX3RvX2NwdSh2YWwpKTsKK30KKworaW50IHVmc2hjZF9xdWVy
eV9kZXNjX2lkbl9nZW9tZXRyeShzdHJ1Y3QgdWZzX2hiYSAqaGJhLAorCQkJCSAgIHN0cnVjdCB1
ZnNfZ2VvbWV0cnlfZGVzY3JpcHRvciAqZGVzYykKK3sKKwlpbnQgcGFyYW1fb2Zmc2V0ID0gMDsK
KwlpbnQgZGVzY19pbmRleCA9IDA7CisKKwltZW1zZXQoZGVzYywgMHhjLCBzaXplb2YoKmRlc2Mp
KTsKKwlyZXR1cm4gdWZzaGNkX3JlYWRfZGVzY19wYXJhbShoYmEsIFFVRVJZX0RFU0NfSUROX0dF
T01FVFJZLCBkZXNjX2luZGV4LAorCQkJCSAgICAgIHBhcmFtX29mZnNldCwgKHZvaWQgKilkZXNj
LAorCQkJCSAgICAgIFFVRVJZX0RFU0NfR0VPTUVUUllfREVGX1NJWkUpOworfQorCit2b2lkIHVm
c2hjZF9wcmludF9pZG5fZ2VvbWV0cnlfZGVzYyhzdHJ1Y3QgdWZzX2dlb21ldHJ5X2Rlc2NyaXB0
b3IgKmRlc2MpCit7CisJdTY0IGNhcCA9IGJlNjRfdG9fY3B1KGRlc2MtPnRvdGFsX3Jhd19kZXZp
Y2VfY2FwYWNpdHkpOworCisJY2FwID0gKChjYXAgPDwgOSkgPj4gMzApOworCisJcHJpbnRmKCIt
LS0gVUZTIGdlb21ldHJ5IERlc2NyaXB0b3IgKElETjogMDdoKSAtLS1cbiIpOworCXByaW50Zigi
IE5hbWUgICB8IFZhbHVlICAgICAgICAgICAgICB8IERlc2NyaXB0aW9uXG4iKTsKKwlwcmludGYo
Ii0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1c
biIpOworCisJLyogSGVhZGVyIGFuZCBDb3JlIENhcGFjaXR5IChPZmZzZXQgMDBoIC0gMENoKSAq
LworCXByaW50ZigiTGVuZ3RoIHwgMHgleCAgfCBTaXplIG9mIGRlc2NyaXB0b3JcbiIsIGRlc2Mt
Pmxlbmd0aCk7CisJcHJpbnRmKCJEZXNjcmlwdG9ySWRuICAgfCAweCV4IHwgZ2VvbWV0cnkgRGVz
Y3JpcHRvciBJRFxuIiwKKwkgICAgICAgZGVzYy0+ZGVzY3JpcHRvcl9pZG4pOworCXByaW50Zigi
TWVkaWFUZWNobm9sb2d5IHwgMHgleCB8IFJlc2VydmVkICgwMGgpXG4iLAorCSAgICAgICBkZXNj
LT5tZWRpYV90ZWNobm9sb2d5KTsKKworCXByaW50ZigiVG90YWxSYXdEZXZpY2VDYXBhY2l0eSB8
ICVsbGQgR0JcbiIsIGNhcCk7CisKKwlwcmludGYoIk1heE51bWJlckx1IHwgJWQgfCBNYXggTFVz
ICgwMGg6IDgsIDAxaDogMzIpXG4iLAorCSAgICAgICBkZXNjLT5tYXhfbnVtYmVyX2x1KTsKKwor
CS8qIFNlZ21lbnQgYW5kIEFsbG9jYXRpb24gdW5pdCBjb25zdHJhaW50cyAoT2Zmc2V0IDBEaCAt
IDEyaCkgKi8KKwlwcmludGYoIlNlZ21lbnRTaXplIHwgJWQgfCBTZWdtZW50IHNpemUgKDUxMkIg
dW5pdHMpXG4iLAorCSAgICAgICBiZTMyX3RvX2NwdShkZXNjLT5zZWdtZW50X3NpemUpKTsKKwor
CXByaW50ZigiQWxsb2NhdGlvbnVuaXRTaXplIHwgJWQgfCBBbGxvYyB1bml0IHNpemUgKGluIHNl
Z21lbnRzKVxuIiwKKwkgICAgICAgZGVzYy0+YWxsb2NhdGlvbnVuaXRfc2l6ZSk7CisKKwlwcmlu
dGYoIk1pbkFkZHJCbG9ja1NpemUgfCAlZCB8IE1pbiBhZGRyZXNzYWJsZSBibG9jayBzaXplXG4i
LAorCSAgICAgICBkZXNjLT5taW5fYWRkcl9ibG9ja19zaXplKTsKKworCS8qIFBlcmZvcm1hbmNl
IGFuZCBCdWZmZXIgcGFyYW1ldGVycyAoT2Zmc2V0IDEzaCAtIDE3aCkgKi8KKwlwcmludGYoIk9w
dGltYWxSZWFkQmxvY2tTaXplIik7CisJcHJpbnRmKCJ8ICVkIHwgT3B0aW1hbCByZWFkIHNpemUg
KDUxMkIgdW5pdHMpXG4iLAorCSAgICAgICBkZXNjLT5vcHRpbWFsX3JlYWRfYmxvY2tfc2l6ZSk7
CisKKwlwcmludGYoIk9wdGltYWxXcml0ZUJsb2NrU2l6ZSAiKTsKKwlwcmludGYoInwgMHgleCB8
IE9wdGltYWwgd3JpdGUgc2l6ZSAoNTEyQiB1bml0cylcbiIsCisJICAgICAgIGRlc2MtPm9wdGlt
YWxfd3JpdGVfYmxvY2tfc2l6ZSk7CisKKwlwcmludGYoIk1heEluQnVmZmVyU2l6ZSB8IDB4JXgg
fCBNYXggRGF0YS1JbiBidWZmZXIgKDUxMkIgdW5pdHMpXG4iLAorCSAgICAgICBkZXNjLT5tYXhf
aW5fYnVmZmVyX3NpemUpOworCisJcHJpbnRmKCJNYXhPdXRCdWZTaXplIHwgMHgleCB8IE1heCBE
YXRhLU91dCBidWZmZXIgKDUxMkIpXG4iLAorCSAgICAgICBkZXNjLT5tYXhfb3V0X2J1ZmZlcl9z
aXplKTsKKworCXByaW50ZigiYlJQTUJSZWFkV3JpdGVTaXplIHwgMHgleCB8IE1heCBSUE1CIGZy
YW1lcyBwZXIgY29tbWFuZFxuIiwKKwkgICAgICAgZGVzYy0+cnBtYl9yZWFkX3dyaXRlX3NpemUp
OworCisJLyogRmVhdHVyZSBTdXBwb3J0IEJpdG1hcHMgKE9mZnNldCAxOGggLSAxRmgpICovCisJ
cHJpbnRmKCJEeW5hbWljQ2FwYWNpdHlSZXNvdXJjZVBvbGljeXwgMHgleCB8IiwKKwkgICAgICAg
ZGVzYy0+ZHluYW1pY19jYXBhY2l0eV9yZXNvdXJjZV9wb2xpY3kpOworCisJcHJpbnRmKCIwMGg6
IHBlciBMVSwgMDFoOiBwZXIgTWVtb3J5IFR5cGVcbiIpOworCXByaW50ZigiRGF0YU9yZGVyaW5n
IHwgMHgleCB8IDAxaDogT3V0LW9mLW9yZGVyIHN1cHBvcnRlZFxuIiwKKwkgICAgICAgZGVzYy0+
ZGF0YV9vcmRlcmluZyk7CisJcHJpbnRmKCJNYXhDb250ZXhJZE51bWJlciB8IDB4JXggfCBNYXgg
c3VwcG9ydGVkIGNvbnRleHRzIChtaW4gNSlcbiIsCisJICAgICAgIGRlc2MtPm1heF9jb250ZXhf
aWRfbnVtYmVyKTsKKworCXByaW50ZigiU3lzRGF0YVRhZ1VuaXRTaXplIHwgMHgleCB8IFN5c3Rl
bSBkYXRhIHRhZyBncmFudWxhcml0eVxuIiwKKwkgICAgICAgZGVzYy0+c3lzX2RhdGFfdGFndW5p
dF9zaXplKTsKKworCXByaW50ZigiU3lzRGF0YVRhZ1Jlc1NpemUgIHwgMHgleCB8IE1heCBhcmVh
IGZvciB0YWdnZWQgc3lzdGVtIGRhdGFcbiIsCisJICAgICAgIGRlc2MtPnN5c19kYXRhX3RhZ19y
ZXNfc2l6ZSk7CisKKwlwcmludGYoIlN1cHBvcnRlZFNlY1JUeXBlcyB8IDB4JXggfCBTdXBwb3J0
ZWQgc2VjdXJlIHJlbW92YWwgdHlwZXNcbiIsCisJICAgICAgIGRlc2MtPnN1cHBvcnRlZF9zZWNf
cl90eXBlcyk7CisKKwlwcmludGYoIlN1cHBvcnRlZE1lbW9yeVR5cGVzIHwgMHgleCB8IEJpdG1h
cCBvZiBtZW1vcnkgdHlwZXNcbiIsCisJICAgICAgIGJlMTZfdG9fY3B1KGRlc2MtPnN1cHBvcnRl
ZF9tZW1vcnlfdHlwZXMpKTsKKwkvKgorCSAqIE1lbW9yeSBUeXBlIFNwZWNpZmljIENhcGFjaXRp
ZXMgYW5kIEFkanVzdG1lbnQgRmFjdG9ycworCSAqLworCXByaW50ZigiU3lzdGVtQ29kZU1heE5B
bGxvYyB8IDB4JXggfCBNYXggQWxsb2MgdW5pdHNcbiIsCisJICAgICAgIGRlc2MtPnN5c3RlbV9j
b2RlX21heF9uX2FsbG9jX3UpOworCisJcHJpbnRmKCJTeXN0ZW1Db2RlQ2FwQWRqRmFjIHwgMHgl
eCB8IGNhcF9hZGpfZmFjdG9yOiBTeXN0ZW0gQ29kZVxuIiwKKwkgICAgICAgZGVzYy0+c3lzdGVt
X2NvZGVfY2FwX2Fkal9mYWMpOworCisJcHJpbnRmKCJOb25QZXJzaXN0TWF4TkFsbG9jIHwgMHgl
eCB8IE1heCBBbGxvYyB1bml0czogTm9uLVBlcnNpc3RcbiIsCisJICAgICAgIGRlc2MtPm5vbl9w
ZXJzaXN0X21heF9uX2FsbG9jX3UpOworCisJcHJpbnRmKCJOb25QZXJzaXN0Q2FwQWRqRmFjICAg
fCAweCV4IHwgY2FwX2Fkal9mYWN0b3I6IE5vbi1QZXJzaXN0XG4iLAorCSAgICAgICBkZXNjLT5u
b25fcGVyc2lzdF9jYXBfYWRqX2ZhYyk7CisKKwlwcmludGYoIkVuaGFuY2VkMU1heE5BbGxvYyB8
ICVkIHwgTWF4IEFsbG9jIHVuaXRzOiBFbmhhbmNlZCAxXG4iLAorCSAgICAgICBiZTMyX3RvX2Nw
dShkZXNjLT5lbmhhbmNlZDFfbWF4X25fYWxsb2NfdSkpOworCisJcHJpbnRmKCJFbmhhbmNlZDFD
YXBBZGpGYWMgfCAlZCB8IGNhcF9hZGpfZmFjdG9yOiBFbmhhbmNlZCAxXG4iLAorCSAgICAgICBi
ZTE2X3RvX2NwdShkZXNjLT5lbmhhbmNlZDFfY2FwX2Fkal9mYWMpKTsKKworCXByaW50ZigiRW5o
YW5jZWQyTWF4TkFsbG9jX3UgfCAlZCB8IE1heCBBbGxvYyB1bml0czogRW5oYW5jZWQgMlxuIiwK
KwkgICAgICAgYmUzMl90b19jcHUoZGVzYy0+ZW5oYW5jZWQyX21heF9uX2FsbG9jX3UpKTsKKwor
CXByaW50ZigiRW5oYW5jZWQyQ2FwQWRqRmFjIHwgJWQgfCBjYXBfYWRqX2ZhY3RvcjogRW5oYW5j
ZWQgMlxuIiwKKwkgICAgICAgYmUxNl90b19jcHUoZGVzYy0+ZW5oYW5jZWQyX2NhcF9hZGpfZmFj
KSk7CisJcHJpbnRmKCJFbmhhbmNlZDNNYXhOQWxsb2MgfCAlZCB8IE1heCBBbGxvYyB1bml0czog
RW5oYW5jZWQgM1xuIiwKKwkgICAgICAgYmUzMl90b19jcHUoZGVzYy0+ZW5oYW5jZWQzX21heF9u
X2FsbG9jX3UpKTsKKworCXByaW50ZigiRW5oYW5jZWQzQ2FwQWRqRmFjIHwgJWQgfCBjYXBfYWRq
X2ZhY3RvcjogRW5oYW5jZWQgM1xuIiwKKwkgICAgICAgYmUzMl90b19jcHUoZGVzYy0+ZW5oYW5j
ZWQzX2NhcF9hZGpfZmFjKSk7CisKKwlwcmludGYoIkVuaGFuY2VkNE1heE5BbGxvYyB8ICVkIHwg
TWF4IEFsbG9jIHVuaXRzOiBFbmhhbmNlZCA0XG4iLAorCSAgICAgICBiZTMyX3RvX2NwdShkZXNj
LT5lbmhhbmNlZDRfbWF4X25fYWxsb2NfdSkpOworCisJcHJpbnRmKCJFbmhhbmNlZDRDYXBBZGpG
YWMgfCAlZCB8IGNhcF9hZGpfZmFjdG9yOiBFbmhhbmNlZCA0XG4iLAorCSAgICAgICBiZTE2X3Rv
X2NwdShkZXNjLT5lbmhhbmNlZDRfY2FwX2Fkal9mYWMpKTsKKworCS8qIFBlcmZvcm1hbmNlIGFu
ZCBXcml0ZUJvb3N0ZXIgKE9mZnNldCA0NGggLSA1NmgpICovCisJcHJpbnRmKCJPcHRpbWFsTG9n
aWNhbEJsb2NrU2l6ZSB8ICVkIHwgT3B0aW1hbCBCbGsgU2l6ZSBwZXIgdHlwZVxuIiwKKwkgICAg
ICAgYmUzMl90b19jcHUoZGVzYy0+b3B0aW1hbF9sb2dpY2FsX2Jsb2NrX3NpemUpKTsKKworCXBy
aW50ZigiV3JpdGVCb29zdGVyQnVmZmVyTWF4TkFsbG9jdW5pdHMiKTsKKwlwcmludGYoInwgJWQg
fCBNYXggdG90IFdCIGJ1ZiBzaXplXG4iLAorCSAgICAgICBiZTMyX3RvX2NwdShkZXNjLT53cml0
ZV9ib29zdGVyX2J1ZmZlcl9tYXhfYWxsb2NfdW5pdHMpKTsKKworCXByaW50ZigiRGV2aWNlTWF4
V3JpdGVCb29zdGVyTHVzICIpOworCXByaW50ZigifCAlZCB8IE1heCBMVXMgc3VwcG9ydGluZyBX
QiAoTURWOjEpXG4iLAorCSAgICAgICBkZXNjLT5kZXZpY2VfbWF4X3dyaXRlX2Jvb3N0ZXJfbHVz
KTsKKworCXByaW50ZigiV3JpdGVCb29zdGVyQnVmZmVyQ2FwQWRqRmFjIik7CisJcHJpbnRmKCJ8
ICVkIHwgV0IgQ2FwYWNpdHkgQWRqdXN0bWVudCBGYWN0b3JcbiIsCisJICAgICAgIGRlc2MtPndy
aXRlX2Jvb3N0ZXJfYnVmZmVyX2NhcGFkamZhYyk7CisKKwlwcmludGYoIlN1cHBvcnRlZHdiQnVm
ZmVyVXNlclNwYWNlUmVkdWN0aW9uVHlwZSIpOworCXByaW50ZigiIHwgMHgleCB8IFJlZHVjdGlv
bi9QcmVzZXJ2ZSBtb2RlIHN1cHBvcnRcbiIsCisJICAgICAgIGRlc2MtPnN1cHBvcnRlZF93cml0
ZV9ib29zdGVyX2J1ZmZlcl91c2Vyc3BhY2VfcmVkdWN0aW9uX3R5cGVzKTsKKworCXByaW50Zigi
U3VwcG9ydGVkV3JpdGVCb29zdGVyQnVmZmVyVHlwZXMiKTsKKwlwcmludGYoInwgMHgleCB8IDAw
aDogTFUgYmFzZWQsIDAxaDogU2hhcmVkXG4iLAorCSAgICAgICBkZXNjLT5zdXBwb3J0ZWRfd3Jp
dGVfYm9vc3Rlcl9idWZmZXJfdHlwZXMpOworfQorCit2b2lkIHVmc2hjZF9wcmludF9jb25maWdf
ZGVzY3JpcHRvcihjb25zdCBzdHJ1Y3QgY29uZmlnX2Rlc2NyaXB0b3IgKmNkKQoreworCWlmICgh
Y2QpCisJCXJldHVybjsKKworCXByaW50ZigiQ29uZmlnIERlc2NyaXB0b3I6XG4iKTsKKworCXBy
aW50ZigiTGVuZ3RoICAgICAgICAgICAgICAgICAgICAgICAgICA6IDB4MCV4XG4iLCBjZC0+bGVu
Z3RoKTsKKwlwcmludGYoIkRlc2NyaXB0b3JJZG4gICAgICAgICAgICAgICAgICAgOiAweDAleFxu
IiwKKwkgICAgICAgY2QtPmRlc2NyaXB0b3JfaWRuKTsKKwlwcmludGYoIkNvbmZEZXNjQ29udGlu
dWUgICAgICAgICAgICAgICAgOiAweDAleFxuIiwKKwkgICAgICAgY2QtPmNvbmZfZGVzY19jb250
aW51ZSk7CisKKwlwcmludGYoIkJvb3RFbmFibGUgICAgICAgICAgICAgICAgICAgICAgOiAweDAl
eFxuIiwKKwkgICAgICAgY2QtPmJvb3RfZW5hYmxlKTsKKwlwcmludGYoIkRlc2NyQWNjZXNzX2Vu
ICAgICAgICAgICAgICAgICAgIDogMHgwJXhcbiIsCisJICAgICAgIGNkLT5kZXNjcl9hY2Nlc3Nf
ZW4pOworCXByaW50ZigiSW5pdFBvd2VyTW9kZSAgICAgICAgICAgICAgICAgICA6IDB4MCV4XG4i
LAorCSAgICAgICBjZC0+aW5pdHBvd2VyX21vZGUpOworCXByaW50ZigiSGlnaFByaW9yaXR5THVu
ICAgICAgICAgICAgICAgICA6IDB4MCV4XG4iLAorCSAgICAgICBjZC0+aGlnaF9wcmlvcml0eV9s
dW4pOworCXByaW50ZigiU2VjdXJlUmVtb3ZhbFR5cGUgICAgICAgICAgICAgICA6IDB4MCV4XG4i
LAorCSAgICAgICBjZC0+c2VjdXJlX3JlbW92YWxfdHlwZSk7CisJcHJpbnRmKCJJbml0QWN0aXZl
SWNjTGV2ZWwgICAgICAgICAgICAgIDogMHgwJXhcbiIsCisJICAgICAgIGNkLT5pbml0X2FjdGl2
ZV9pY2NfbGV2ZWwpOworCXByaW50ZigiUGVyaW9kaWNSdGNVcGRhdGUgICAgICAgICAgICAgICA6
IDB4MCV4XG4iLAorCSAgICAgICBjZC0+cGVyaW9kaWNfcnRjX3VwZGF0ZSk7CisJcHJpbnRmKCJS
ZXNlcnZlZF9IUEIgICAgICAgICAgICAgICAgICAgIDogMHgwJXhcbiIsCisJICAgICAgIGNkLT5y
ZXNlcnZlZF9IUEIpOworCisJcHJpbnRmKCJScG1iUmVnaW9uRW5hYmxlICAgICAgICAgICAgICAg
IDogMHgwJXhcbiIsCisJICAgICAgIGNkLT5ycG1iX3JlZ2lvbl9lbmFibGUpOworCXByaW50Zigi
UnBtYlJlZ2lvbjFTaXplICAgICAgICAgICAgICAgICA6IDB4MCV4XG4iLAorCSAgICAgICBjZC0+
cnBtYl9yZWdpb24xX3NpemUpOworCXByaW50ZigiUnBtYlJlZ2lvbjJTaXplICAgICAgICAgICAg
ICAgICA6IDB4MCV4XG4iLAorCSAgICAgICBjZC0+cnBtYl9yZWdpb24yX3NpemUpOworCXByaW50
ZigiUnBtYlJlZ2lvbjNTaXplICAgICAgICAgICAgICAgICA6IDB4MCV4XG4iLAorCSAgICAgICBj
ZC0+cnBtYl9yZWdpb24zX3NpemUpOworCisJcHJpbnRmKCJXcml0ZUJvb3N0ZXJCdWZmZXJQcmVz
ZXJ2ZVVzZXJTcGFjZUVOIDogMHgwJXhcbiIsCisJICAgICAgIGNkLT53cml0ZV9ib29zdGVyX2J1
ZmZlcl9wcmVzZXJ2ZV91c2VyX3NwYWNlX2VuKTsKKwlwcmludGYoIldyaXRlQm9vc3RlckJ1ZmZl
clR5cGUgICAgICAgICAgIDogMHgwJXhcbiIsCisJICAgICAgIGNkLT53cml0ZV9ib29zdGVyX2J1
ZmZlcl90eXBlKTsKKwlwcmludGYoIk51bVNoYXJlZFdyaXRlQm9vc3RlckJ1ZmZlckFsbG9jVW5p
dHMgOiAweDAleFxuIiwKKwkgICAgICAgY2QtPm51bV9zaGFyZWRfd3JpdGVfYm9vc3Rlcl9idWZm
ZXJfYWxsb2N1bml0cyk7Cit9CisKK2ludCB1ZnNoY2RfcXVlcnlfZGVzY19pZG5fY29uZmlnKHN0
cnVjdCB1ZnNfaGJhICpoYmEsCisJCQkJIHN0cnVjdCB1ZnNfY29uZmlnX2Rlc2NyaXB0b3IgKnVz
ZXJfY2ZnKQoreworCWludCByZXQ7CisJaW50IHBhcmFtX29mZnNldCA9IDA7CisJaW50IGRlc2Nf
aW5kZXggPSAwOworCisJcmV0ID0KKwkgICAgdWZzaGNkX3JlYWRfZGVzY19wYXJhbShoYmEsIFFV
RVJZX0RFU0NfSUROX0NPTkZJR1VSQVRJT04sCisJCQkJICAgZGVzY19pbmRleCwgcGFyYW1fb2Zm
c2V0LCAodm9pZCAqKXVzZXJfY2ZnLAorCQkJCSAgIFFVRVJZX0RFU0NfQ09ORklHVVJBVElPTl9E
RUZfU0laRSk7CisJaWYgKHJldCkKKwkJcHJpbnRmKCJGYWlsZWQgdG8gcmVhZCBjb25maWdcbiIp
OworCXJldHVybiByZXQ7Cit9CisKK3ZvaWQgdWZzaGNkX3ByaW50X3VuaXRfcGFyYW1fZGVzY3Jp
cHRvcihzdHJ1Y3QgdWZzX3VuaXRfY29uZmlndXJhYmxlX3BhcmFtZXRlcnMKKwkJCQkJKnVuaXQp
Cit7CisJLyogSGVhZGVyIHNlZ21lbnQgKE9mZnNldCAwMGggLSAwM2gpICovCisJcHJpbnRmKCJM
dUVuYWJsZSAgfCAweCV4ICB8IEVuYWJsZWQsIDAwaDogRGlzYWJsZWRcbiIsCisJICAgICAgIHVu
aXQtPmx1X2VuYWJsZSk7CisJcHJpbnRmKCJCb290THVuSWQgfCAweCV4ICB8IEJvb3QgTFUgQSwg
MDJoOiBCb290IExVIEJcbiIsCisJICAgICAgIHVuaXQtPmJvb3RfbHVuX2lkKTsKKwlwcmludGYo
Ikx1V3JpdGVQcm90ZWN0IHwgMHgleCB8IHBvd2VyLW9uLCAwMmg6IFBlcm1hbmVudFxuIiwKKwkg
ICAgICAgdW5pdC0+bHVfd3JpdGVfcHJvdGVjdCk7CisJcHJpbnRmKCJNZW1vcnlUeXBlfCAweCV4
IHwgTm9ybWFsLCAwMWg6IFN5c3RlbSBDb2RlXG4iLAorCSAgICAgICB1bml0LT5tZW1vcnlfdHlw
ZSk7CisJLyogQWxsb2NhdGlvbiBhbmQgU2l6aW5nIChPZmZzZXQgMDRoIC0gMEFoKSAqLworCXBy
aW50ZigiTnVtQWxsb2N1bml0cyB8ICVkIHwgTnVtYmVyIG9mIEFsbG9jYXRpb24gdW5pdHMgZm9y
IExVXG4iLAorCSAgICAgICBiZTMyX3RvX2NwdSh1bml0LT5udW1fYWxsb2N1bml0cykpOworCXBy
aW50ZigiRGF0YVJlbGlhYmlsaXR5IHwgMHgleCB8IHBvd2VyIGZhaWx1cmUgcHJvdGVjdGlvblxu
IiwKKwkgICAgICAgdW5pdC0+ZGF0YV9yZWxpYWJpbGl0eSk7CisJcHJpbnRmKCJMb2dpY2FsQmxv
Y2tTaXplIHwgMHgleCB8IEJsb2NrIHNpemUgZXhwb25lbnQgKE1pbjogMENoKVxuIiwKKwkgICAg
ICAgdW5pdC0+bG9naWNhbF9ibG9ja19zaXplKTsKKwlwcmludGYoIlByb3Zpc2lvbmluZ1R5cGUg
fCAweCV4IHwgRnVsbCwgMDJoLzAzaDogVGhpblxuIiwKKwkgICAgICAgdW5pdC0+cHJvdmlzaW9u
aW5nX3R5cGUpOworCisJLyogQ29udGV4dCBhbmQgSFBCIChPZmZzZXQgMEJoIC0gMTVoKSAqLwor
CXB1dHMoIkNvbnRleHRDYXBhYmlsaXRpZXMiKTsKKwlwcmludGYoIgl8IDB4JXggfCBMVSBDb250
ZXh0IHN1cHBvcnQvbXVsdGlwbGllcnNcbiIsCisJICAgICAgIHVuaXQtPmNvbnRleHRfY2FwYWJp
bGl0aWVzKTsKKwkvKiBwcmludGYoIlJlc2VydmVkICB8IC0tICAgfCBSZXNlcnZlZFxuIik7ICov
CisJLyogcHJpbnRmKCJSZXNlcnZlZCAoSFBCKSB8IC0tIHwgUmVzZXJ2ZWQgZm9yIEhQQiBFeHRl
bnNpb25cbiIpOyAqLworCS8qIFdyaXRlQm9vc3RlciAoT2Zmc2V0IDE2aCkgKi8KKwlwcmludGYo
Ikx1TnVtV3JpdGVCb29zdGVyQnVmZmVyQWxsb2N1bml0cyIpOworCXByaW50ZigifCAweCV4IHwg
V0IgQnVmZmVyIHNpemUgKExVcyAwLTcgb25seSlcbiIsCisJICAgICAgIHVuaXQtPmx1X251bV93
cml0ZV9ib29zdGVyX2J1ZmZlcl9hbGxvY3VuaXRzKTsKK30KKwordm9pZCB1ZnNoY2RfY2xlYXJh
bGxfbHVucyhzdHJ1Y3QgdWZzX2NvbmZpZ19kZXNjcmlwdG9yICp1c2VyX2NmZywKKwkJCSAgdTMy
IGJhc2Vfb2Zmc2V0LCB1MzIgY29uZmlnX2xlbmd0aCkKKworeworCWludCBpOworCWludCBvZmY7
CisJdTggKmNvbmZpZyA9ICh1OCAqKXVzZXJfY2ZnOworCXN0cnVjdCB1ZnNfdW5pdF9jb25maWd1
cmFibGVfcGFyYW1ldGVycyAqdW5pdDsKKworCWZvciAoaSA9IDA7IGkgPCA4OyBpKyspIHsKKwkJ
b2ZmID0gYmFzZV9vZmZzZXQgKyAoaSAqIGNvbmZpZ19sZW5ndGgpOworCisJCXVuaXQgPSAoc3Ry
dWN0IHVmc191bml0X2NvbmZpZ3VyYWJsZV9wYXJhbWV0ZXJzICopJmNvbmZpZ1tvZmZdOworCisJ
CXVuaXQtPm51bV9hbGxvY3VuaXRzID0gY3B1X3RvX2JlMzIoMCk7CisJCXVuaXQtPm1lbW9yeV90
eXBlID0gMDsKKwkJdW5pdC0+bHVfZW5hYmxlID0gMDsKKwkJdW5pdC0+Ym9vdF9sdW5faWQgPSAw
OworCQl1bml0LT5sb2dpY2FsX2Jsb2NrX3NpemUgPSAweEM7CisJCXVuaXQtPmRhdGFfcmVsaWFi
aWxpdHkgPSAwOworCQl1bml0LT5wcm92aXNpb25pbmdfdHlwZSA9IDA7CisJCXVuaXQtPmNvbnRl
eHRfY2FwYWJpbGl0aWVzID0gY3B1X3RvX2JlMTYoMCk7CisJCXVuaXQtPmx1X251bV93cml0ZV9i
b29zdGVyX2J1ZmZlcl9hbGxvY3VuaXRzID0gY3B1X3RvX2JlMzIoMCk7CisJfQorfQorCitzdGF0
aWMgZmxvYXQgY2FsY19sdW5fY2FwYWNpdHkoc3RydWN0IHVmc191bml0X2NvbmZpZ3VyYWJsZV9w
YXJhbWV0ZXJzICp1bml0LAorCQkJICAgICAgIHN0cnVjdCB1ZnNfZ2VvbWV0cnlfZGVzY3JpcHRv
ciAqZ2VvbWV0cnkpCit7CisJdTE2IGNhcF9hZGpfZmFjID0gMTsKKwlmbG9hdCBjYXBfYWRqX2Zh
Y2ZsID0gMTsKKwl1NjQgbHVuX2NhcGFjaXR5OworCisJc3dpdGNoICh1bml0LT5tZW1vcnlfdHlw
ZSkgeworCWNhc2UgMDoJLyogTm9ybWFsICovCisJCWNhcF9hZGpfZmFjID0gMTsKKwkJYnJlYWs7
CisJY2FzZSAxOgorCQljYXBfYWRqX2ZhYyA9CisJCSAgICBiZTE2X3RvX2NwdShnZW9tZXRyeS0+
c3lzdGVtX2NvZGVfY2FwX2Fkal9mYWMpOworCQlicmVhazsKKwljYXNlIDI6CisJCWNhcF9hZGpf
ZmFjID0KKwkJICAgIGJlMTZfdG9fY3B1KGdlb21ldHJ5LT5ub25fcGVyc2lzdF9jYXBfYWRqX2Zh
Yyk7CisJCWJyZWFrOworCWNhc2UgMzoKKwkJY2FwX2Fkal9mYWMgPQorCQkgICAgYmUxNl90b19j
cHUoZ2VvbWV0cnktPmVuaGFuY2VkMV9jYXBfYWRqX2ZhYyk7CisJCWJyZWFrOworCWNhc2UgNDoK
KwkJY2FwX2Fkal9mYWMgPQorCQkgICAgYmUxNl90b19jcHUoZ2VvbWV0cnktPmVuaGFuY2VkMl9j
YXBfYWRqX2ZhYyk7CisJCWJyZWFrOworCWNhc2UgNToKKwkJY2FwX2Fkal9mYWMgPQorCQkgICAg
YmUxNl90b19jcHUoZ2VvbWV0cnktPmVuaGFuY2VkM19jYXBfYWRqX2ZhYyk7CisJCWJyZWFrOwor
CWNhc2UgNjoKKwkJY2FwX2Fkal9mYWMgPQorCQkgICAgYmUxNl90b19jcHUoZ2VvbWV0cnktPmVu
aGFuY2VkNF9jYXBfYWRqX2ZhYyk7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXByaW50ZigiaWxl
Z2FsIG1lbW9yeSB0eXBlXG4iKTsKKwl9CisKKwlpZiAodW5pdC0+bWVtb3J5X3R5cGUpIHsKKwkJ
LyogU2VlIGdlb21ldHJ5IERlc2NyaXB0b3IvY2FwX2Fkal9mYWMgaW4gSmVkZWMuICovCisJCWNh
cF9hZGpfZmFjZmwgPSAoZmxvYXQpKGNhcF9hZGpfZmFjIC8gMjU2LjAwKTsKKwl9CisKKwlsdW5f
Y2FwYWNpdHkgPSA1MTIgKiAodTY0KWJlMzJfdG9fY3B1KHVuaXQtPm51bV9hbGxvY3VuaXRzKSAq
CisJCSAgICBnZW9tZXRyeS0+YWxsb2NhdGlvbnVuaXRfc2l6ZSAqCisJCSAgICAodTY0KWJlMzJf
dG9fY3B1KGdlb21ldHJ5LT5zZWdtZW50X3NpemUpOworCisJbHVuX2NhcGFjaXR5IC89IGNhcF9h
ZGpfZmFjZmw7CisJdTMyIG1iID0gKHUzMikobHVuX2NhcGFjaXR5ID4+IDIwKTsKKwlyZXR1cm4g
bWI7Cit9CisKK3ZvaWQgdWZzX3Rvb2xfcHJpbnRfbHVucyh2b2lkKQoreworCXN0cnVjdCB1ZnNf
Z2VvbWV0cnlfZGVzY3JpcHRvciBnZW9tZXRyeTsKKwlzdHJ1Y3QgdWZzX2NvbmZpZ19kZXNjcmlw
dG9yIGNvbmZpZ19kZXNjOworCXN0cnVjdCB1ZnNfZGV2aWNlX2Rlc2NyaXB0b3IgZGV2aWNlX2Rl
c2M7CisJc3RydWN0IHVmc19oYmEgKmhiYTsKKwlpbnQgaTsKKworCWhiYSA9IHVmc3Rvb2xfcHJv
YmVfZGV2KDApOworCWlmICghaGJhKSB7CisJCXByaW50ZigidWZzX3Rvb2w6IGZhaWxlZCB0byBn
ZXQgaGJhXG4iKTsKKwkJcmV0dXJuOworCX0KKwlpZiAodWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2Nv
bmZpZyhoYmEsICZjb25maWdfZGVzYykpIHsKKwkJcHJpbnRmKCJGYWlsZWQgdG8gcmVhZCBjb25m
aWd1cmF0aW9uXG4iKTsKKwkJcmV0dXJuOworCX0KKworCWlmICh1ZnNoY2RfcXVlcnlfZGVzY19p
ZG5fZGV2aWNlKGhiYSwgJmRldmljZV9kZXNjKSkgeworCQlwcmludGYoIkZhaWxlZCB0byByZWFk
IDBoXG4iKTsKKwkJcmV0dXJuOworCX0KKworCWlmICh1ZnNoY2RfcXVlcnlfZGVzY19pZG5fZ2Vv
bWV0cnkoaGJhLCAmZ2VvbWV0cnkpKSB7CisJCXByaW50ZigiRmFpbGVkIHRvIHJlYWQgZ2VvbWV0
cnlcbiIpOworCQlyZXR1cm47CisJfQorCisJdTggKmNvbmZpZyA9ICh1OCAqKSZjb25maWdfZGVz
YzsKKwkvKiBIZWFkZXIgKi8KKwlmb3IgKGkgPSAwOyBpIDwgODsgaSsrKSB7CisJCWNvbnN0IGlu
dCBDT0xfV0lEVEggID0gMTQ7CisJCWludCBvZmY7CisJCWNoYXIgYnVmWzMyXTsKKwkJc3RydWN0
IHVmc191bml0X2NvbmZpZ3VyYWJsZV9wYXJhbWV0ZXJzICp1bml0OworCisJCW9mZiA9IGRldmlj
ZV9kZXNjLnVkMF9iYXNlX29mZnNldCArCisJCSAgICAgIChpICogZGV2aWNlX2Rlc2MuY29uZmln
X2xlbmd0aCk7CisKKwkJdW5pdCA9IChzdHJ1Y3QgdWZzX3VuaXRfY29uZmlndXJhYmxlX3BhcmFt
ZXRlcnMgKikmY29uZmlnW29mZl07CisKKwkJaWYgKHVuaXQtPmx1X2VuYWJsZSAhPSAxKQorCQkJ
Y29udGludWU7CisKKwkJc25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgIkxVTiAlZCIsIGkpOwor
CQlwcmludGYoInwgJS0qcyIsIENPTF9XSURUSCAtIDIsIGJ1Zik7CisJfQorCXByaW50ZigifFxu
Iik7CisJLyogU2l6ZXMgKi8KKwlmb3IgKGkgPSAwOyBpIDwgODsgaSsrKSB7CisJCWludCBvZmY7
CisJCXM2NCBtYjsKKwkJY2hhciBzaXplX3N0clszMl07CisJCWNvbnN0IGludCBDT0xfV0lEVEgg
PSAxNDsKKwkJc3RydWN0IHVmc191bml0X2NvbmZpZ3VyYWJsZV9wYXJhbWV0ZXJzICp1bml0Owor
CisJCW9mZiA9IGRldmljZV9kZXNjLnVkMF9iYXNlX29mZnNldCArCisJCSAgICAgIChpICogZGV2
aWNlX2Rlc2MuY29uZmlnX2xlbmd0aCk7CisKKwkJdW5pdCA9IChzdHJ1Y3QgdWZzX3VuaXRfY29u
ZmlndXJhYmxlX3BhcmFtZXRlcnMgKikmY29uZmlnW29mZl07CisKKwkJaWYgKHVuaXQtPmx1X2Vu
YWJsZSAhPSAxKQorCQkJY29udGludWU7CisKKwkJbWIgPSBjYWxjX2x1bl9jYXBhY2l0eSh1bml0
LCAmZ2VvbWV0cnkpOworCisJCXNucHJpbnRmKHNpemVfc3RyLCBzaXplb2Yoc2l6ZV9zdHIpLCAi
JWxsZCBNQiIsIG1iKTsKKworCQlwcmludGYoInwgJS0qcyIsIENPTF9XSURUSCAtIDIsIHNpemVf
c3RyKTsKKwl9CisJcHJpbnRmKCJ8XG4iKTsKK30KKworc3RhdGljIHZvaWQgdWZzaGNkX3ByaW50
X2lkbl9kZXNjX2NvbmZpZyhzdHJ1Y3QgdWZzX2NvbmZpZ19kZXNjcmlwdG9yICp1c2VyX2NmZywK
KwkJCQkJIHN0cnVjdCB1ZnNfZ2VvbWV0cnlfZGVzY3JpcHRvciAqZ2VvbWV0cnksCisJCQkJCSB1
MzIgYmFzZV9vZmZzZXQsIHUzMiBjb25maWdfZW5ndGgpCit7CisJaW50IGk7CisJaW50IG9mZjsK
KwlzdHJ1Y3QgdWZzX3VuaXRfY29uZmlndXJhYmxlX3BhcmFtZXRlcnMgKnVuaXQ7CisJdTggKmNv
bmZpZyA9ICh1OCAqKXVzZXJfY2ZnOworCXUzMiBtYjsKKworCXVmc2hjZF9wcmludF9jb25maWdf
ZGVzY3JpcHRvcigmdXNlcl9jZmctPmNmZ19kZXNjKTsKKwlmb3IgKGkgPSAwOyBpIDwgODsgaSsr
KSB7CisJCW9mZiA9IGJhc2Vfb2Zmc2V0ICsgKGkgKiBjb25maWdfZW5ndGgpOworCisJCXVuaXQg
PSAoc3RydWN0IHVmc191bml0X2NvbmZpZ3VyYWJsZV9wYXJhbWV0ZXJzICopJmNvbmZpZ1tvZmZd
OworCQltYiA9IGNhbGNfbHVuX2NhcGFjaXR5KHVuaXQsIGdlb21ldHJ5KTsKKwkJcHJpbnRmKCIt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG4iKTsKKwkJ
cHJpbnRmKCJMVU4gJWQgQ2FwYWNpdHkgJWQgTUJcbiIsIGksIG1iKTsKKwkJcHJpbnRmKCJOYW1l
ICB8IFZhbHVlICAgICAgfCBEZXNjcmlwdGlvblxuIik7CisJCXByaW50ZigiLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxuIik7CisJCXVmc2hjZF9wcmlu
dF91bml0X3BhcmFtX2Rlc2NyaXB0b3IodW5pdCk7CisJfQorfQorCisvKioKKyAqIERlY29kZXMg
YW5kIHByaW50cyBhIHNpbmdsZSAxNi1iaXQgcG93ZXIgUGFyYW1ldGVyIEVsZW1lbnQuCisgKiBG
b3JtYXQgYmFzZWQgb24gVGFibGUgNy4xMy4KKyAqLwordm9pZCBwcmludF9wb3dlcl9lbGVtZW50
KHN0cnVjdCB1ZnNfcG93ZXJfcGFyYW1ldGVyX2VsZW1lbnQgZGVzYykKK3sKKwlzdGF0aWMgY29u
c3QgY2hhciAqIGNvbnN0IHVuaXRzW10gPSB7ICJuX2EiLCAidV9hIiwgIm1fYSIsICJBIiB9Owor
CXUxNiBlbGVtZW50ID0gZGVzYy51cG93ZXJfdmFsdWU7CisKKwkvKiBCaXRzIFsxNToxNF0gZGVm
aW5lIHRoZSB1bml0ICovCisJdTggdW5pdF9jb2RlID0gKGVsZW1lbnQgPj4gMTQpICYgMHgwMzsK
KworCS8qIEJpdHMgWzk6MF0gZGVmaW5lIHRoZSBtYXhpbXVtIGN1cnJlbnQgdmFsdWUgKi8KKwl1
MTYgdmFsdWUgPSBlbGVtZW50ICYgMHgwM0ZGOworCisJcHJpbnRmKCIlZCAlcyIsIHZhbHVlLCB1
bml0c1t1bml0X2NvZGVdKTsKK30KKworLyoqCisgKiBQcmludCBmdW5jdGlvbiBmb3IgVUZTIHBv
d2VyIFBhcmFtZXRlcnMgRGVzY3JpcHRvciAoSUROOiAwOGgpLgorICogUmVmZXJlbmNlczogVGFi
bGUgMTQuMTYsIFRhYmxlIDcuMTIsIGFuZCBUYWJsZSA3LjEzLgorICovCit2b2lkIHByaW50X3Vm
c19wb3dlcl9wYXJhbWV0ZXJzKHN0cnVjdCB1ZnNfcG93ZXJfcGFyYW1ldGVyc19kZXNjcmlwdG9y
ICpkZXNjKQoreworCXByaW50ZigiLS0tIFVGUyBwb3dlciBQYXJhbWV0ZXJzIERlc2NyaXB0b3Ig
KElETjogMDhoKSAtLS1cbiIpOworCXByaW50ZigiRGVzY3JpcHRvciBMZW5ndGg6IDB4JXggKCV1
IGJ5dGVzKVxuIiwgZGVzYy0+bGVuZ3RoLCBkZXNjLT5sZW5ndGgpOworCXByaW50ZigiRGVzY3Jp
cHRvciBJRE46ICAgIDB4JXhcblxuIiwgZGVzYy0+ZGVzY3JpcHRvcl9pZG4pOworCisJcHJpbnRm
KCJMZXZlbCB8IFZDQyBDdXJyZW50IHwgVkNDUSBDdXJyZW50IHwgVkNDUTIgQ3VycmVudFxuIik7
CisJcHJpbnRmKCItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLVxuIik7CisKKwlmb3IgKGludCBpID0gMDsgaSA8IDU7IGkrKykgeworCQlwcmludGYoIiAl
eCAgfCAiLCBpKTsKKwkJLyogQWNjZXNzaW5nIHRoZSAgbGV2ZWxzIGZvciBlYWNoIHN1cHBseSAo
VkNDLCBWQ0NRLCBWQ0NRMikgKi8KKwkJLyogVmFsdWVzIHJlcHJlc2VudCB3b3JzdC1jYXNlIG1h
eGltdW0gcGVhayBjdXJyZW50ICovCisJCXByaW50X3Bvd2VyX2VsZW1lbnQoZGVzYy0+YWN0aXZl
X2ljY19sZXZlbHNfdmNjW2ldKTsKKwkJcHJpbnRmKCIgICAgICB8ICIpOworCQlwcmludF9wb3dl
cl9lbGVtZW50KGRlc2MtPmFjdGl2ZV9pY2NfbGV2ZWxzX3ZjY3FbaV0pOworCQlwcmludGYoIiAg
ICAgICB8ICIpOworCQlwcmludF9wb3dlcl9lbGVtZW50KGRlc2MtPmFjdGl2ZV9pY2NfbGV2ZWxz
X3ZjY3EyW2ldKTsKKwkJcHJpbnRmKCJcbiIpOworCX0KK30KKworaW50IHVmc2hjZF9xdWVyeV9k
ZXNjX2lkbl9wb3dlcihzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBpbnQgbHVuLAorCQkJCXN0cnVjdCB1
ZnNfcG93ZXJfcGFyYW1ldGVyc19kZXNjcmlwdG9yCisJCQkJKm91dF9kZXNjKQoreworCWludCBy
ZXQ7CisJdW5zaWduZWQgY2hhciBTcGFjZVtRVUVSWV9ERVNDX1BPV0VSX0RFRl9TSVpFXTsKKwor
CW1lbXNldChvdXRfZGVzYywgMHhGRiwgc2l6ZW9mKCpvdXRfZGVzYykpOworCisJcmV0ID0gdWZz
aGNkX3JlYWRfZGVzY19wYXJhbShoYmEsIFFVRVJZX0RFU0NfSUROX1BPV0VSLCBsdW4sIDAsIFNw
YWNlLAorCQkJCSAgICAgUVVFUllfREVTQ19QT1dFUl9ERUZfU0laRSk7CisKKwlpZiAocmV0KSB7
CisJCXB1dHMoIkVycjotLS0gVUZTIHBvd2VyIERlc2NyaXB0b3IiKTsKKwkJcmV0dXJuIHJldDsK
Kwl9CisJbWVtY3B5KG91dF9kZXNjLCBTcGFjZSwgc2l6ZW9mKCpvdXRfZGVzYykpOworCXJldHVy
biByZXQ7Cit9CisKK2ludCB1ZnNoY2RfcXVlcnlfZGVzY19pZG5fdW5pdChzdHJ1Y3QgdWZzX2hi
YSAqaGJhLCBpbnQgbHVuLAorCQkJICAgICAgIHN0cnVjdCB1bml0X2Rlc2NyaXB0b3IgKm91dF9k
ZXNjKQoreworCWludCByZXQ7CisJdW5zaWduZWQgY2hhciB1bml0X3NwYWNlW1FVRVJZX0RFU0Nf
VU5JVF9ERUZfU0laRV07CisJc3RydWN0IHVuaXRfZGVzY3JpcHRvciAqZGVzYyA9IChzdHJ1Y3Qg
dW5pdF9kZXNjcmlwdG9yICopJnVuaXRfc3BhY2U7CisKKwltZW1zZXQoZGVzYywgMHhGRiwgc2l6
ZW9mKCpkZXNjKSk7CisJcmV0ID0gdWZzaGNkX3JlYWRfZGVzY19wYXJhbShoYmEsIFFVRVJZX0RF
U0NfSUROX1VOSVQsIGx1biwgMCwKKwkJCQkgICAgICh2b2lkICopZGVzYywgUVVFUllfREVTQ19V
TklUX0RFRl9TSVpFKTsKKwlpZiAocmV0KSB7CisJCXB1dHMoIkVycjotLS0gVUZTIHVuaXQgRGVz
Y3JpcHRvciIpOworCQlyZXR1cm4gcmV0OworCX0KKwltZW1jcHkob3V0X2Rlc2MsIGRlc2MsIHNp
emVvZigqb3V0X2Rlc2MpKTsKKwlyZXR1cm4gcmV0OworfQorCit2b2lkIHVmc2hjZF9wcmludF91
bml0X2Rlc2NyaXB0b3Ioc3RydWN0IHVuaXRfZGVzY3JpcHRvciAqZGVzYykKK3sKKwlwcmludGYo
Ii0tLSBVRlMgdW5pdCBEZXNjcmlwdG9yIChJRE46IDAyaCkgLS0tXG4iKTsKKwlwcmludGYoIiBO
YW1lICAgfCBWYWx1ZSAgICAgICAgICAgICAgfCBEZXNjcmlwdGlvblxuIik7CisJcHJpbnRmKCIt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cbiIpOworCisJLyog
RGVzY3JpcHRvciBIZWFkZXIgKi8KKwlwcmludGYoIkxlbmd0aCB8ICVkICAgIHwgU2l6ZSBvZiBk
ZXNjcmlwdG9yXG4iLCBkZXNjLT5sZW5ndGgpOworCXByaW50ZigiRGVzY3JpcHRvcklkbiB8IDB4
JXggfCB1bml0IERlc2NyaXB0b3IgSURcbiIsCisJICAgICAgIGRlc2MtPmRlc2NyaXB0b3JfaWRu
KTsKKwlwcmludGYoIkJ1bml0SW5kZXggICAgIHwgMHgleCB8IExvZ2ljYWwgdW5pdCBJbmRleFxu
IiwKKwkgICAgICAgZGVzYy0+YnVuaXRfaW5kZXgpOworCisJLyogY29uZmlndXJhdGlvbiBQYXJh
bWV0ZXJzICovCisJcHJpbnRmKCJsdUVuYWJsZSB8IDB4JXggfCBMVSBFbmFibGVkICgwMWgpIG9y
IERpc2FibGVkICgwMGgpXG4iLAorCSAgICAgICBkZXNjLT5sdV9lbmFibGUpOworCXByaW50Zigi
Qm9vdEx1bklkIHwgMHgleHwgQm9vdCBMVSBJRCAoMDFoOiBBLCAwMmg6IEJcbiIsCisJICAgICAg
IGRlc2MtPmJvb3RfbHVuX2lkKTsKKwlwcmludGYoImx1V3JpdGVQcm90ZWN0IHwgMHgleCB8IFdQ
ICgwMWg6IHBvd2VyLW9uLCAwMmg6IFBlcm0pXG4iLAorCSAgICAgICBkZXNjLT5sdV93cml0ZV9w
cm90ZWN0KTsKKwlwcmludGYoImx1UXVldWVEZXB0aCAgIHwgMHgleCB8IFF1ZXVlIGRlcHRoICgw
IGlmIHNoYXJlZClcbiIsCisJICAgICAgIGRlc2MtPmx1X3F1ZXVlX2RlcHRoKTsKKwlwcmludGYo
InBzYVNlbnNpdGl2ZSB8IDB4JXggIHwgU29sZGVyaW5nIHNlbnNpdGl2aXR5IGluZGljYXRvclxu
IiwKKwkgICAgICAgZGVzYy0+cHNhX3NlbnNpdGl2ZSk7CisJcHJpbnRmKCJNZW1vcnlUeXBlIHwg
MHgleCAgfCBNZW1vcnkgdHlwZSAoMDBoOiBOb3JtYWxcbiIsCisJICAgICAgIGRlc2MtPm1lbW9y
eV90eXBlKTsKKwlwcmludGYoIkRhdGFSZWxpYWJpbGl0eSB8IDB4JXggfCBwb3dlciBmYWlsdXJl
IHByb3RlY3Rpb24gZW5hYmxlZFxuIiwKKwkgICAgICAgZGVzYy0+ZGF0YV9yZWxpYWJpbGl0eSk7
CisJcHJpbnRmKCJMb2dpY2FsQmxvY2tTaXplfCAweCV4IHwgQmxvY2sgc2l6ZSBleHBvbmVudCAo
Ml5uKVxuIiwKKwkgICAgICAgZGVzYy0+bG9naWNhbF9ibG9ja19zaXplKTsKKwkvKiBDYXBhY2l0
eSBhbmQgZ2VvbWV0cnkgKi8KKwlwcmludGYoIkxvZ2ljYWxCbG9ja0NvdW50IHwgJWQgJWQgfCBU
b3RhbCBhZGRyZXNzYWJsZSBibG9ja3NcbiIsCisJICAgICAgIGJlMzJfdG9fY3B1KHVwcGVyXzMy
X2JpdHMoZGVzYy0+bG9naWNhbF9ibG9ja19jb3VudCkpLAorCSAgICAgICBiZTMyX3RvX2NwdShs
b3dlcl8zMl9iaXRzKGRlc2MtPmxvZ2ljYWxfYmxvY2tfY291bnQpKSk7CisJcHJpbnRmKCJFcmFz
ZUJsb2NrU2l6ZSB8IDB4JXggfCBPcHRpbWFsIGVyYXNlIGdyYW51bGFyaXR5XG4iLAorCSAgICAg
ICBkZXNjLT5lcmFzZV9ibG9ja19zaXplKTsKKwlwcmludGYoIlByb3Zpc2lvbmluZ1R5cGUgfCAw
eCV4IHwgMDBoOiBGdWxsLCAwMmgvMDNoOiBUaGluXG4iLAorCSAgICAgICBkZXNjLT5wcm92aXNp
b25pbmdfdHlwZSk7CisJcHJpbnRmKCJwaHlNZW1SZXNvdXJjZUNvdW50fCAlZCAlZCAgQXZhaWxh
YmxlIHBoeXNpY2FsIHJlc291cmNlc1xuIiwKKwkgICAgICAgbG93ZXJfMzJfYml0cyhkZXNjLT5w
aHlfbWVtX3Jlc291cmNlX2NvdW50KSwKKwkgICAgICAgdXBwZXJfMzJfYml0cyhkZXNjLT5waHlf
bWVtX3Jlc291cmNlX2NvdW50KSk7CisJLyogUGVyZm9ybWFuY2UgYW5kIEV4dGVuZGVkIEZlYXR1
cmVzICovCisJcHJpbnRmKCJDb250ZXh0Q2FwYWJpbGl0aWVzIHwgMHgleCB8IENvbnRleHQgSUQg
JiBMVSBNdWx0aXBsaWVyXG4iLAorCSAgICAgICBkZXNjLT5jb250ZXh0X2NhcGFiaWxpdGllcyk7
CisJcHJpbnRmKCJiTGFyZ2V1bml0R3JhbnVsYXJpdHlfTTF8Iik7CisJcHJpbnRmKCIweCV4IHwg
TGFyZ2UgdW5pdCBncmFudWxhcml0eSBtaW51cyBvbmUiLAorCSAgICAgICBkZXNjLT5sYXJnZXVu
aXRfZ3JhbnVsYXJpdHlfTTEpOworCXB1dHMoIlJlc2VydmVkIHwgUmVzZXJ2ZWQgZm9yIGV4dGVu
c2lvbiBzdGFuZGFyZHMiKTsKKwlwdXRzKCJsdU51bVdyaXRlQm9vc3RlckJ1ZmZlckFsbG9jdW5p
dHMiKTsKKwlwcmludGYoIiB8IDB4JXggfCBXQiBCdWZmZXIgc2l6ZSBpbiBBbGxvYyB1bml0c1xu
IiwKKwkgICAgICAgZGVzYy0+bHVfbnVtX3dyaXRlX2Jvb3N0ZXJfYnVmZmVyX2FsbG9jdW5pdHMp
OworfQorCisjZGVmaW5lIHN0cl9lcSAhc3RyY21wCisKK2ludCBzZXRfcGFyYW1fZmllbGQoc3Ry
dWN0IHVmc191bml0X2NvbmZpZ3VyYWJsZV9wYXJhbWV0ZXJzICp1ZCwKKwkJICAgIGNvbnN0IGNo
YXIgKm5hbWUsIHUzMiB2YWx1ZSkKK3sKKwlpZiAoc3RyX2VxKG5hbWUsICJib290X2x1bl9pZCIp
KQorCQl1ZC0+Ym9vdF9sdW5faWQgPSAodTgpdmFsdWU7CisJZWxzZSBpZiAoc3RyX2VxKG5hbWUs
ICJsdV9lbmFibGUiKSkKKwkJdWQtPmx1X2VuYWJsZSA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmIChz
dHJfZXEobmFtZSwgImx1X3dyaXRlX3Byb3RlY3QiKSkKKwkJdWQtPmx1X3dyaXRlX3Byb3RlY3Qg
PSAodTgpdmFsdWU7CisJZWxzZSBpZiAoc3RyX2VxKG5hbWUsICJtZW1vcnlfdHlwZSIpKQorCQl1
ZC0+bWVtb3J5X3R5cGUgPSAodTgpdmFsdWU7CisJZWxzZSBpZiAoc3RyX2VxKG5hbWUsICJkYXRh
X3JlbGlhYmlsaXR5IikpCisJCXVkLT5kYXRhX3JlbGlhYmlsaXR5ID0gKHU4KXZhbHVlOworCWVs
c2UgaWYgKHN0cl9lcShuYW1lLCAibnVtX2FsbG9jdW5pdHMiKSkKKwkJdWQtPm51bV9hbGxvY3Vu
aXRzID0gY3B1X3RvX2JlMzIodmFsdWUpOworCWVsc2UgaWYgKHN0cl9lcShuYW1lLCAicHJvdmlz
aW9uaW5nX3R5cGUiKSkKKwkJdWQtPnByb3Zpc2lvbmluZ190eXBlID0gKHU4KXZhbHVlOworCWVs
c2UgaWYgKHN0cl9lcShuYW1lLCAiY29udGV4dF9jYXBhYmlsaXRpZXMiKSkKKwkJdWQtPmNvbnRl
eHRfY2FwYWJpbGl0aWVzID0gKHUxNil2YWx1ZTsKKwllbHNlIGlmIChzdHJfZXEobmFtZSwgImx1
X251bV93cml0ZV9ib29zdGVyX2J1ZmZlcl9hbGxvY3VuaXRzIikpCisJCXVkLT5sdV9udW1fd3Jp
dGVfYm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0cyA9ICh1MzIpdmFsdWU7CisJZWxzZQorCQlyZXR1
cm4gLTE7CisJcmV0dXJuIDA7Cit9CisKK2ludCB1ZnNoY2RfdXBkYXRlX2x1bihzdHJ1Y3QgdWZz
X2hiYSAqaGJhLCBpbnQgbHVuLAorCQkgICAgICBjb25zdCBjaGFyICpmaWVsZCwgdTMyIHZhbCkK
K3sKKwlpbnQgb2ZmOworCWludCByZXQ7CisJdTggKmNvbmZpZzsKKwlzdHJ1Y3QgdWZzX3VuaXRf
Y29uZmlndXJhYmxlX3BhcmFtZXRlcnMgKnVuaXQ7CisJc3RydWN0IHVmc19kZXZpY2VfZGVzY3Jp
cHRvciBkZXZfZGVzYzsKKworCS8vIFBvcHVsYXRlIGRlc2NyaXB0b3IKKwlpZiAoZ19jZmdfZGVz
Yy5jZmdfZGVzYy5sZW5ndGggPT0gMCAmJgorCSAgICB1ZnNoY2RfcXVlcnlfZGVzY19pZG5fY29u
ZmlnKGhiYSwgJmdfY2ZnX2Rlc2MpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWlmICh1ZnNoY2Rf
cXVlcnlfZGVzY19pZG5fZGV2aWNlKGhiYSwgJmRldl9kZXNjKSkgeworCQlwcmludGYoIkZhaWxl
ZCB0byByZWFkIElETiAwaFxuIik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWNvbmZpZyA9
IChfX3U4ICopJmdfY2ZnX2Rlc2M7CisJb2ZmID0gZGV2X2Rlc2MudWQwX2Jhc2Vfb2Zmc2V0ICsg
KGx1biAqIGRldl9kZXNjLmNvbmZpZ19sZW5ndGgpOworCisJdW5pdCA9IChzdHJ1Y3QgdWZzX3Vu
aXRfY29uZmlndXJhYmxlX3BhcmFtZXRlcnMgKikmY29uZmlnW29mZl07CisKKwl1bml0LT5sb2dp
Y2FsX2Jsb2NrX3NpemUgPSAweEM7CisJLy8gQWx3YXlzIGVuYWJsZSB0aGUgTHVuCisJdW5pdC0+
bHVfZW5hYmxlID0gMTsKKwkvLyBFbmFibGUgTHVuIGNvbmZpZ3VyYXRpb24KKwkvL2dfY2ZnX2Rl
c2MuY2ZnX2Rlc2Mud3JpdGVfYm9vc3Rlcl9idWZmZXJfdHlwZSA9IDA7CisKKwkvLyBOb3cgY2hh
bmdlIHRoZSByZXF1aXJlZCB2YWx1ZQorCWlmIChzZXRfcGFyYW1fZmllbGQodW5pdCwgZmllbGQs
IHZhbCkpIHsKKwkJcHJpbnRmKCJpbGVnYWwgdmFsdWUgdG8gc2V0ICVzXG4iLCBmaWVsZCk7CisJ
CXJldHVybiAtRUlOVkFMOworCX0KKwl1ZnNoY2RfcHJpbnRfdW5pdF9wYXJhbV9kZXNjcmlwdG9y
KHVuaXQpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgdWZzaGNkX3dyaXRlX2Rlc2Nf
cGFyYW0oc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSBkZXNjX2lkbiBkZXNjX2lkLAorCQkJCSAg
IGludCBkZXNjX2luZGV4LCB1bnNpZ25lZCBjaGFyIHBhcmFtX29mZnNldCwKKwkJCQkgICB1bnNp
Z25lZCBjaGFyICpwYXJhbV93cml0ZV9idWYsCisJCQkJICAgdW5zaWduZWQgY2hhciBwYXJhbV9z
aXplKQoreworCWludCByZXQ7CisJaW50IGJ1ZmZfbGVuOworCWludCBzZWxlY3RvciA9IDA7CisK
KwlpZiAoZGVzY19pZCA+PSBRVUVSWV9ERVNDX0lETl9NQVggfHwgIXBhcmFtX3NpemUpCisJCXJl
dHVybiAtRUlOVkFMOworCisJYnVmZl9sZW4gPSBwYXJhbV9zaXplOworCXJldCA9IHVmc2hjZF9x
dWVyeV9kZXNjcmlwdG9yX3JldHJ5KGhiYSwgVVBJVV9RVUVSWV9PUENPREVfV1JJVEVfREVTQywK
KwkJCQkJICAgIGRlc2NfaWQsIGRlc2NfaW5kZXgsIHNlbGVjdG9yLAorCQkJCQkgICAgcGFyYW1f
d3JpdGVfYnVmLCAmYnVmZl9sZW4pOworCWlmICghcmV0KQorCQlyZXR1cm4gMDsKKwlwcmludGYo
IkVycjogZGVzY19pZCAlZCBkZXNjX2luZGV4ICVkLCBwYXJhbV9vZmZzZXQgJWQsYnVmbGVuICVk
LHJldD0lZFxuIiwKKwkgICAgICAgKHVuc2lnbmVkIGludClkZXNjX2lkLCBkZXNjX2luZGV4LAor
CSAgICAgICAodW5zaWduZWQgaW50KXBhcmFtX29mZnNldCwgYnVmZl9sZW4sIHJldCk7CisJcmV0
dXJuIHJldDsKK30KKworZW51bSBmbGFnX2lkbiB1ZnNoY2RfZ2V0X2ZsYWcoY29uc3QgY2hhciAq
bmFtZSkKK3sKKwlpZiAoc3RyX2VxKG5hbWUsICJkZXZpY2Vpbml0IikpCisJCXJldHVybiBRVUVS
WV9GTEFHX0lETl9GREVWSUNFSU5JVDsKKworCWlmIChzdHJfZXEobmFtZSwgInBlcm1hbmVudF93
cGUiKSkKKwkJcmV0dXJuIFFVRVJZX0ZMQUdfSUROX1BFUk1BTkVOVF9XUEU7CisKKwlpZiAoc3Ry
X2VxKG5hbWUsICJwd3Jfb25fd3BlIikpCisJCXJldHVybiBRVUVSWV9GTEFHX0lETl9QV1JfT05f
V1BFOworCisJaWYgKHN0cl9lcShuYW1lLCAiYmtvcHNfZW4iKSkKKwkJcmV0dXJuIFFVRVJZX0ZM
QUdfSUROX0JLT1BTX0VOOworCisJaWYgKHN0cl9lcShuYW1lLCAibGlmZV9zcGFuX21vZGUiKSkK
KwkJcmV0dXJuIFFVRVJZX0ZMQUdfSUROX0xJRkVfU1BBTl9NT0RFX0VOQUJMRTsKKworCWlmIChz
dHJfZXEobmFtZSwgInB1cmdlX2VuYWJsZSIpKQorCQlyZXR1cm4gUVVFUllfRkxBR19JRE5fUFVS
R0VfRU5BQkxFOworCisJaWYgKHN0cl9lcShuYW1lLCAiZnBoeV9yZXNvdXJjZV9yZW1vdmFsIikp
CisJCXJldHVybiBRVUVSWV9GTEFHX0lETl9GUEhZUkVTT1VSQ0VSRU1PVkFMOworCisJaWYgKHN0
cl9lcShuYW1lLCAiYnVzeV9ydGMiKSkKKwkJcmV0dXJuIFFVRVJZX0ZMQUdfSUROX0JVU1lfUlRD
OworCisJaWYgKHN0cl9lcShuYW1lLCAicGVybWFuZW50bHlfZGlzYWJsZV9md191cGRhdGUiKSkK
KwkJcmV0dXJuIFFVRVJZX0ZMQUdfSUROX1BFUk1BTkVOVExZX0RJU0FCTEVfRldfVVBEQVRFOwor
CisJaWYgKHN0cl9lcShuYW1lLCAid3JpdGVfYm9vc3Rlcl9lbiIpKQorCQlyZXR1cm4gUVVFUllf
RkxBR19JRE5fRl9XUklURV9CT09TVEVSX0VOOworCisJaWYgKHN0cl9lcShuYW1lLCAid2JfYnVm
X2ZsdXNoX2VuIikpCisJCXJldHVybiBRVUVSWV9GTEFHX0lETl9GX1dCX0JVRl9GTFVTSF9FTjsK
KworCWlmIChzdHJfZXEobmFtZSwgIndiX2J1Zl9mbHVzaF9oOCIpKQorCQlyZXR1cm4gUVVFUllf
RkxBR19JRE5fRl9XQl9CVUZfRkxVU0hfSElCRVJOODsKKwlyZXR1cm4gLTE7Cit9CisKK2ludCB1
ZnNoY2RfcXVlcnlfdXNlcl9mbGFnKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGNvbnN0IGNoYXIgKmZs
YWdfbmFtZSkKK3sKKwllbnVtIGZsYWdfaWRuIGlkbjsKKwlib29sIGZsYWdfcmVzOworCWludCBy
ZXQ7CisKKwlpZiAoIWhiYSkgeworCQlwcmludGYoImludmFsaWQgaGJhXG4iKTsKKwkJcmV0dXJu
IC1FSU5WQUw7CisJfQorCisJaWRuID0gdWZzaGNkX2dldF9mbGFnKGZsYWdfbmFtZSk7CisJaWYg
KChpbnQpaWRuIDwgMCkgeworCQlwcmludGYoIiVzIGludmFsaWRcbiIsIF9fZnVuY19fKTsKKwkJ
cmV0dXJuIC1FSU5WQUw7CisJfQorCXJldCA9CisJICAgIHVmc2hjZF9xdWVyeV9mbGFnKGhiYSwg
VVBJVV9RVUVSWV9PUENPREVfUkVBRF9GTEFHLCBpZG4sICZmbGFnX3Jlcyk7CisJaWYgKCFyZXQp
IHsKKwkJcHJpbnRmKCIlcyA9ICV4XG4iLCBmbGFnX25hbWUsIGZsYWdfcmVzKTsKKwkJcmV0dXJu
IDA7CisJfQorCXByaW50ZigiJXMgaWRuIHF1ZXJ5IGZhaWxlZFxuIiwgZmxhZ19uYW1lKTsKKwly
ZXR1cm4gcmV0OworfQorCisjZGVmaW5lIENNRF9IRUxQIFwKKwkJInF1ZXJ5OlxuIiBcCisJCSJc
dERldmljZSBkZXNjICgwaClcbiIgXAorCQkiXHRHZW9tZXRyeSBkZXNjKDdoKVxuIiBcCisJCSJc
dFBvd2VyIGRlc2MgKDhoKVxuIiBcCisJCSJcdFVuaXQgZGVzYygyaClcbiIgXAorCQkiXHRDb25m
aWcgZGVzYygxaClcbiIgXAorCQkiKioqKioqKioqKioqKioqKioqKioqKioqKioqKlxuIiBcCisJ
CSJcblx0c2V0X2x1biBbTFVOXSAocGFybSlcbiIgXAorCQkiXHRcdGx1X2VuYWJsZVxuIiBcCisJ
CSJcdFx0Ym9vdF9sdW5faWRcbiIgXAorCQkiXHRcdGx1X3dyaXRlX3Byb3RlY3RcbiIgXAorCQki
XHRcdG1lbW9yeV90eXBlXG4iIFwKKwkJIlx0XHRkYXRhX3JlbGlhYmlsaXR5XG4iIFwKKwkJIlx0
XHRudW1fYWxsb2N1bml0c1xuIiBcCisJCSJcdFx0bG9naWNhbF9ibG9ja19zaXplXG4iIFwKKwkJ
Ilx0XHRwcm92aXNpb25pbmdfdHlwZVxuIiBcCisJCSJcdFx0Y29udGV4dF9jYXBhYmlsaXRpZXNc
biIgXAorCQkiXHRcdGx1X251bV93cml0ZV9ib29zdGVyX2J1ZmZlcl9hbGxvY3VuaXRzXG5cbiIg
XAorCQkiKioqKioqKioqKioqKioqKioqKioqKioqKioqKlxuIiBcCisJCSJcblx0c2V0X2Rldl9k
ZXNjIFtwYXJtXSBbdmFsdWVdXG4iIFwKKwkJIlx0XHRkZXNjcmlwdG9yX2lkblxuIiBcCisJCSJc
dFx0ZGV2aWNlXG4iIFwKKwkJIlx0XHRkZXZpY2VfY2xhc3NcbiIgXAorCQkiXHRcdGRldmljZV9z
dWJfY2xhc3NcbiIgXAorCQkiXHRcdG51bWJlcl9sdVxuIiBcCisJCSJcdFx0Ym9vdF9lbmFibGVc
biIgXAorCQkiXHRcdGRlc2NyX2FjY2Vzc19lblxuIiBcCisJCSJcdFx0aW5pdF9wb3dlcl9tb2Rl
XG4iIFwKKwkJIlx0XHRoaWdoX3ByaW9yaXR5X2x1blxuIiBcCisJCSJcdFx0c2VjdXJlX3JlbW92
YWxfdHlwZVxuIiBcCisJCSJcdFx0aW5pdGFjdGl2ZV9pY2NfbGV2ZWxcbiIgXAorCQkiXHRcdHF1
ZXVlX2RlcHRoXG4iIFwKKwkJIlx0XHR3cml0ZV9ib29zdGVyX2J1ZmZlcl9wcmVzZXJ2ZV91c2Vy
X3NwYWNlX2VuXG4iIFwKKwkJIlx0XHR3cml0ZV9ib29zdGVyX2J1ZmZlcl90eXBlXG4iIFwKKwkJ
Ilx0XHRzcGVjX3ZlcnNpb25cbiIgXAorCQkiXHRcdG1hbnVmYWN0dXJlcl9pZFxuIiBcCisJCSJc
dFx0cGVyaW9kaWNfcnRjX3VwZGF0ZVxuIiBcCisJCSJcdFx0ZGV2aWNlX3ZlcnNpb25cbiIgXAor
CQkiXHRcdHBzYV9tYXhfZGF0YV9zaXplXG4iIFwKKwkJIlx0XHRleHRlbmRlZF91ZnNfZmVhdHVy
ZXNfc3VwcG9ydFxuIiBcCisJCSJcdFx0bnVtX3NoYXJlZF93cml0ZV9ib29zdGVyX2J1ZmZlcl9h
bGxvY3VuaXRzXG4iIFwKKwkJIlx0XHR3cml0ZV9ib29zdGVyX2J1ZmZlcl9wcmVzZXJ2ZV91c2Vy
X3NwYWNlX2VuXG4iIFwKKwkJIioqKioqKioqKioqKioqKioqKioqKioqKioqKipcbiIgXAorCQki
XG5cdHNldF9jZmdfZGVzYyBbcGFybV0gW3ZhbHVlXVxuIiBcCisJCSJcdFx0bGVuZ3RoXG4iIFwK
KwkJIlx0XHRkZXNjcmlwdG9yX2lkblxuIiBcCisJCSJcdFx0Y29uZl9kZXNjX2NvbnRpbnVlXG4i
IFwKKwkJIlx0XHRib290X2VuYWJsZVxuIiBcCisJCSJcdFx0ZGVzY3JfYWNjZXNzX2VuXG4iIFwK
KwkJIlx0XHRpbml0cG93ZXJfbW9kZVxuIiBcCisJCSJcdFx0aGlnaF9wcmlvcml0eV9sdW5cbiIg
XAorCQkiXHRcdHNlY3VyZV9yZW1vdmFsX3R5cGVcbiIgXAorCQkiXHRcdGluaXRfYWN0aXZlX2lj
Y19sZXZlbFxuIiBcCisJCSJcdFx0cGVyaW9kaWNfcnRjX3VwZGF0ZVxuIiBcCisJCSJcdFx0cmVz
ZXJ2ZWRfSFBCXG4iIFwKKwkJIlx0XHRycG1iX3JlZ2lvbl9lbmFibGVcbiIgXAorCQkiXHRcdHJw
bWJfcmVnaW9uMV9zaXplXG4iIFwKKwkJIlx0XHRycG1iX3JlZ2lvbjJfc2l6ZVxuIiBcCisJCSJc
dFx0cnBtYl9yZWdpb24zX3NpemVcbiIgXAorCQkiXHRcdHdyaXRlX2Jvb3N0ZXJfYnVmZmVyX3By
ZXNlcnZlX3VzZXJfc3BhY2VfZW5cbiIgXAorCQkiXHRcdHdyaXRlX2Jvb3N0ZXJfYnVmZmVyX3R5
cGVcbiIgXAorCQkiXHRcdG51bV9zaGFyZWRfd3JpdGVfYm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0
c1xuIiBcCisJCSIqKioqKioqKioqKioqKioqKioqKioqKioqKioqXG4iIFwKKwkJIlxuXHRmbGFn
IFtmbGFnIG5hbWVdXG4iIFwKKwkJIlx0XHRkZXZpY2Vpbml0XG4iIFwKKwkJIlx0XHRwZXJtYW5l
bnRfd3BlXG4iIFwKKwkJIlx0XHRwd3Jfb25fd3BlXG4iIFwKKwkJIlx0XHRia29wc19lblxuIiBc
CisJCSJcdFx0bGlmZV9zcGFuX21vZGVcbiIgXAorCQkiXHRcdHB1cmdlX2VuYWJsZVxuIiBcCisJ
CSJcdFx0ZnBoeV9yZXNvdXJjZV9yZW1vdmFsXG4iIFwKKwkJIlx0XHRidXN5X3J0Y1xuIiBcCisJ
CSJcdFx0cGVybWFuZW50bHlfZGlzYWJsZV9md191cGRhdGVcbiIgXAorCQkiXHRcdHdyaXRlX2Jv
b3N0ZXJfZW5cbiIgXAorCQkiXHRcdHdiX2J1Zl9mbHVzaF9lblxuIiBcCisJCSJcdFx0d2JfYnVm
X2ZsdXNoX2g4XG4iIFwKKwkJIioqKioqKioqKioqKioqKioqKioqKioqKioqKipcbiIgXAorCQki
XHRleGFtcGxlcyA6XG4iIFwKKwkJIlxuXG50byB3cml0ZSBsdW4gcGxlYXNlXG4iIFwKKwkJIlx0
dWZzIHF1ZXJ5IDAgMVxuIiBcCisJCSJcdGZpeCB0aGUgbHVucywgZGlzYWJsZSBsdV9lbmFibGVc
biIgXAorCQkiXHR1c2UgdWZzIHNldCBbTFVOXSBudW1fYWxsb2N1bml0cz14eHggdG8gc2V0IHNp
emVcbiIgXAorCQkiXHR1ZnMgc2V0X2NmZ19kZXNjIG51bV9zaGFyZWRfd3JpdGVfYm9vc3Rlcl9i
dWZmZXJfYWxsb2N1bml0cyAxMDAwMDBcbiIgXAorCQkiXHR1ZnMgc2V0X2NmZ19kZXNjIHdyaXRl
X2Jvb3N0ZXJfYnVmZmVyX3R5cGUgMVxuIiBcCisJCSJcdHVmcyBjb21taXRcbiIKKwordm9pZCB1
ZnNfdG9vbF9oZWxwKHZvaWQpCit7CisJcHV0cyhDTURfSEVMUCk7Cit9CisKK3ZvaWQgaWRuX3Jl
YWQoc3RydWN0IHVmc19oYmEgKmhiYSwgaW50IGlkbiwgaW50IGx1bikKK3sKKwlzdHJ1Y3QgdWZz
X2RldmljZV9kZXNjcmlwdG9yIGRldmljZV9kZXNjOworCXN0cnVjdCB1bml0X2Rlc2NyaXB0b3Ig
dW5pdF9kZXNjOworCXN0cnVjdCB1ZnNfZ2VvbWV0cnlfZGVzY3JpcHRvciBnZW9tZXRyeTsKKwlz
dHJ1Y3QgdWZzX3Bvd2VyX3BhcmFtZXRlcnNfZGVzY3JpcHRvciBwb3dlcl9kZXNjOworCisJc3dp
dGNoIChpZG4pIHsKKwljYXNlIFFVRVJZX0RFU0NfSUROX0RFVklDRToJLyogMHgwICovCisJCWlm
ICghdWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2RldmljZShoYmEsICZkZXZpY2VfZGVzYykpCisJCQl1
ZnNoY2RfcHJpbnRfZGV2aWNlX2Rlc2NyaXB0b3IoJmRldmljZV9kZXNjKTsKKwkJYnJlYWs7CisK
KwljYXNlIFFVRVJZX0RFU0NfSUROX0dFT01FVFJZOgkvKiAweDcgKi8KKwkJaWYgKCF1ZnNoY2Rf
cXVlcnlfZGVzY19pZG5fZ2VvbWV0cnkoaGJhLCAmZ2VvbWV0cnkpKSB7CisJCQl1ZnNoY2RfcHJp
bnRfaWRuX2dlb21ldHJ5X2Rlc2MoJmdlb21ldHJ5KTsKKwkJCXJldHVybjsKKwkJfQorCQlwcmlu
dGYoIkZhaWxlZCB0byByZWFkIGdlb21ldHJ5XG4iKTsKKwkJYnJlYWs7CisKKwljYXNlIFFVRVJZ
X0RFU0NfSUROX1VOSVQ6CS8qIDB4MiAqLworCQl1bml0X2Rlc2MuYnVuaXRfaW5kZXggPSBsdW47
CisJCWlmICghdWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX3VuaXQoaGJhLCBsdW4sICZ1bml0X2Rlc2Mp
KQorCQkJdWZzaGNkX3ByaW50X3VuaXRfZGVzY3JpcHRvcigmdW5pdF9kZXNjKTsKKwkJYnJlYWs7
CisKKwljYXNlIFFVRVJZX0RFU0NfSUROX1BPV0VSOgorCQlpZiAoIXVmc2hjZF9xdWVyeV9kZXNj
X2lkbl9wb3dlcihoYmEsIGx1biwgJnBvd2VyX2Rlc2MpKQorCQkJcHJpbnRfdWZzX3Bvd2VyX3Bh
cmFtZXRlcnMoJnBvd2VyX2Rlc2MpOworCQlicmVhazsKKworCWNhc2UgUVVFUllfREVTQ19JRE5f
Q09ORklHVVJBVElPTjoJLyogMHgxICovCisJCWlmICh1ZnNoY2RfcXVlcnlfZGVzY19pZG5fZGV2
aWNlKGhiYSwgJmRldmljZV9kZXNjKSkgeworCQkJcHJpbnRmKCJGYWlsZWQgdG8gcmVhZCBJRE4g
MGhcbiIpOworCQkJcmV0dXJuOworCQl9CisKKwkJaWYgKHVmc2hjZF9xdWVyeV9kZXNjX2lkbl9n
ZW9tZXRyeShoYmEsICZnZW9tZXRyeSkpIHsKKwkJCXByaW50ZigiRmFpbGVkIHRvIHJlYWQgZ2Vv
bWV0cnlcbiIpOworCQkJcmV0dXJuOworCQl9CisKKwkJdWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2Nv
bmZpZyhoYmEsICZnX2NmZ19kZXNjKTsKKwkJdWZzaGNkX3ByaW50X2lkbl9kZXNjX2NvbmZpZygm
Z19jZmdfZGVzYywgJmdlb21ldHJ5LAorCQkJCQkgICAgIGRldmljZV9kZXNjLnVkMF9iYXNlX29m
ZnNldCwKKwkJCQkJICAgICBkZXZpY2VfZGVzYy5jb25maWdfbGVuZ3RoKTsKKwkJYnJlYWs7CisK
KwlkZWZhdWx0OgorCQlwcmludGYoIklsZWdhbCBJRE4gJWRcbiIsIGlkbik7CisJCXVmc190b29s
X2hlbHAoKTsKKwl9Cit9CisKK3N0YXRpYyBpbnQgc2V0X2NvbmZpZ19kZXNjX2ZpZWxkKHN0cnVj
dCBjb25maWdfZGVzY3JpcHRvciAqZGVzYywKKwkJCQkgY29uc3QgY2hhciAqZmllbGRuYW1lLCB1
MzIgdmFsdWUpCit7CisJLyogLS0tIERlc2NyaXB0b3IgSGVhZGVyICYgRmxvdyBDb250cm9sIC0t
LSAqLworCWlmICghc3RyY21wKGZpZWxkbmFtZSwgImxlbmd0aCIpKQorCQlkZXNjLT5sZW5ndGgg
PSAodTgpdmFsdWU7CisJZWxzZSBpZiAoIXN0cmNtcChmaWVsZG5hbWUsICJkZXNjcmlwdG9yX2lk
biIpKQorCQlkZXNjLT5kZXNjcmlwdG9yX2lkbiA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3Ry
Y21wKGZpZWxkbmFtZSwgImNvbmZfZGVzY19jb250aW51ZSIpKQorCQlkZXNjLT5jb25mX2Rlc2Nf
Y29udGludWUgPSAodTgpdmFsdWU7CisJLyogLS0tIERldmljZSBEZXNjcmlwdG9yIENvbmZpZ3Vy
YWJsZSBQYXJhbWV0ZXJzIC0tLSAqLworCWVsc2UgaWYgKCFzdHJjbXAoZmllbGRuYW1lLCAiYm9v
dF9lbmFibGUiKSkKKwkJZGVzYy0+Ym9vdF9lbmFibGUgPSAodTgpdmFsdWU7CisJZWxzZSBpZiAo
IXN0cmNtcChmaWVsZG5hbWUsICJkZXNjcl9hY2Nlc3NfZW4iKSkKKwkJZGVzYy0+ZGVzY3JfYWNj
ZXNzX2VuID0gKHU4KXZhbHVlOworCWVsc2UgaWYgKCFzdHJjbXAoZmllbGRuYW1lLCAiaW5pdHBv
d2VyX21vZGUiKSkKKwkJZGVzYy0+aW5pdHBvd2VyX21vZGUgPSAodTgpdmFsdWU7CisJZWxzZSBp
ZiAoIXN0cmNtcChmaWVsZG5hbWUsICJoaWdoX3ByaW9yaXR5X2x1biIpKQorCQlkZXNjLT5oaWdo
X3ByaW9yaXR5X2x1biA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKGZpZWxkbmFtZSwg
InNlY3VyZV9yZW1vdmFsX3R5cGUiKSkKKwkJZGVzYy0+c2VjdXJlX3JlbW92YWxfdHlwZSA9ICh1
OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKGZpZWxkbmFtZSwgImluaXRfYWN0aXZlX2ljY19s
ZXZlbCIpKQorCQlkZXNjLT5pbml0X2FjdGl2ZV9pY2NfbGV2ZWwgPSAodTgpdmFsdWU7CisJZWxz
ZSBpZiAoIXN0cmNtcChmaWVsZG5hbWUsICJwZXJpb2RpY19ydGNfdXBkYXRlIikpCisJCWRlc2Mt
PnBlcmlvZGljX3J0Y191cGRhdGUgPSAodTE2KXZhbHVlOworCWVsc2UgaWYgKCFzdHJjbXAoZmll
bGRuYW1lLCAicmVzZXJ2ZWRfSFBCIikpCisJCWRlc2MtPnJlc2VydmVkX0hQQiA9ICh1OCl2YWx1
ZTsKKwkvKiAtLS0gUlBNQiBDb25maWd1cmF0aW9uIFBhcmFtZXRlcnMgLS0tICovCisJZWxzZSBp
ZiAoIXN0cmNtcChmaWVsZG5hbWUsICJycG1iX3JlZ2lvbl9lbmFibGUiKSkKKwkJZGVzYy0+cnBt
Yl9yZWdpb25fZW5hYmxlID0gKHU4KXZhbHVlOworCWVsc2UgaWYgKCFzdHJjbXAoZmllbGRuYW1l
LCAicnBtYl9yZWdpb24xX3NpemUiKSkKKwkJZGVzYy0+cnBtYl9yZWdpb24xX3NpemUgPSAodTgp
dmFsdWU7CisJZWxzZSBpZiAoIXN0cmNtcChmaWVsZG5hbWUsICJycG1iX3JlZ2lvbjJfc2l6ZSIp
KQorCQlkZXNjLT5ycG1iX3JlZ2lvbjJfc2l6ZSA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3Ry
Y21wKGZpZWxkbmFtZSwgInJwbWJfcmVnaW9uM19zaXplIikpCisJCWRlc2MtPnJwbWJfcmVnaW9u
M19zaXplID0gKHU4KXZhbHVlOworCWVsc2UgaWYgKCFzdHJjbXAoZmllbGRuYW1lLAorCQkJICJ3
cml0ZV9ib29zdGVyX2J1ZmZlcl9wcmVzZXJ2ZV91c2VyX3NwYWNlX2VuIikpCisJCWRlc2MtPndy
aXRlX2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZlX3VzZXJfc3BhY2VfZW4gPSAodTgpdmFsdWU7CisJ
ZWxzZSBpZiAoIXN0cmNtcChmaWVsZG5hbWUsICJ3cml0ZV9ib29zdGVyX2J1ZmZlcl90eXBlIikp
CisJCWRlc2MtPndyaXRlX2Jvb3N0ZXJfYnVmZmVyX3R5cGUgPSAodTgpdmFsdWU7CisJZWxzZSBp
ZiAoIXN0cmNtcChmaWVsZG5hbWUsCisJCQkgIm51bV9zaGFyZWRfd3JpdGVfYm9vc3Rlcl9idWZm
ZXJfYWxsb2N1bml0cyIpKQorCQlkZXNjLT5udW1fc2hhcmVkX3dyaXRlX2Jvb3N0ZXJfYnVmZmVy
X2FsbG9jdW5pdHMgPQorCQljcHVfdG9fYmUzMih2YWx1ZSk7CisJZWxzZQorCQlyZXR1cm4gLTE7
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgc2V0X2RldmljZV9kZXNjX2ZpZWxkKHN0cnVj
dCB1ZnNfZGV2aWNlX2Rlc2NyaXB0b3IgKmRldl9kZXNjLAorCQkJCSBjb25zdCBjaGFyICpuYW1l
LCB1MzIgdmFsdWUpCit7CisJaWYgKCFzdHJjbXAobmFtZSwgImRlc2NyaXB0b3JfaWRuIikpCisJ
CWRldl9kZXNjLT5kZXNjcmlwdG9yX2lkbiA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21w
KG5hbWUsICJkZXZpY2UiKSkKKwkJZGV2X2Rlc2MtPmRldmljZSA9ICh1OCl2YWx1ZTsKKwllbHNl
IGlmICghc3RyY21wKG5hbWUsICJkZXZpY2VfY2xhc3MiKSkKKwkJZGV2X2Rlc2MtPmRldmljZV9j
bGFzcyA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKG5hbWUsICJkZXZpY2Vfc3ViX2Ns
YXNzIikpCisJCWRldl9kZXNjLT5kZXZpY2Vfc3ViX2NsYXNzID0gKHU4KXZhbHVlOworCWVsc2Ug
aWYgKCFzdHJjbXAobmFtZSwgIm51bWJlcl9sdSIpKQorCQlkZXZfZGVzYy0+bnVtYmVyX2x1ID0g
KHU4KXZhbHVlOworCWVsc2UgaWYgKCFzdHJjbXAobmFtZSwgImJvb3RfZW5hYmxlIikpCisJCWRl
dl9kZXNjLT5ib290X2VuYWJsZSA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKG5hbWUs
ICJkZXNjcl9hY2Nlc3NfZW4iKSkKKwkJZGV2X2Rlc2MtPmRlc2NyX2FjY2Vzc19lbiA9ICh1OCl2
YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKG5hbWUsICJiSW5pdFBvd2VyTW9kZSIpKQorCQlkZXZf
ZGVzYy0+aW5pdF9wb3dlcl9tb2RlID0gKHU4KXZhbHVlOworCWVsc2UgaWYgKCFzdHJjbXAobmFt
ZSwgImhpZ2hfcHJpb3JpdHlfbHVuIikpCisJCWRldl9kZXNjLT5oaWdoX3ByaW9yaXR5X2x1biA9
ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKG5hbWUsICJzZWN1cmVfcmVtb3ZhbF90eXBl
IikpCisJCWRldl9kZXNjLT5zZWN1cmVfcmVtb3ZhbF90eXBlID0gKHU4KXZhbHVlOworCWVsc2Ug
aWYgKCFzdHJjbXAobmFtZSwgImluaXRhY3RpdmVfaWNjX2xldmVsIikpCisJCWRldl9kZXNjLT5p
bml0X2FjdGl2ZV9pY2NfbGV2ZWwgPSAodTgpdmFsdWU7CisJZWxzZSBpZiAoIXN0cmNtcChuYW1l
LCAicXVldWVfZGVwdGgiKSkKKwkJZGV2X2Rlc2MtPnF1ZXVlX2RlcHRoID0gKHU4KXZhbHVlOwor
CWVsc2UgaWYgKCFzdHJjbXAobmFtZSwgIndyaXRlX2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZlX3Vz
ZXJfc3BhY2VfZW4iKSkKKwkJZGV2X2Rlc2MtPndyaXRlX2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZl
X3VzZXJfc3BhY2VfZW4gPSAodTgpdmFsdWU7CisJZWxzZSBpZiAoIXN0cmNtcChuYW1lLCAid3Jp
dGVfYm9vc3Rlcl9idWZmZXJfdHlwZSIpKQorCQlkZXZfZGVzYy0+d3JpdGVfYm9vc3Rlcl9idWZm
ZXJfdHlwZSA9ICh1OCl2YWx1ZTsKKwllbHNlIGlmICghc3RyY21wKG5hbWUsICJzcGVjX3ZlcnNp
b24iKSkKKwkJZGV2X2Rlc2MtPnNwZWNfdmVyc2lvbiA9IGNwdV90b19iZTE2KHZhbHVlKTsKKwll
bHNlIGlmICghc3RyY21wKG5hbWUsICJtYW51ZmFjdHVyZXJfaWQiKSkKKwkJZGV2X2Rlc2MtPm1h
bnVmYWN0dXJlcl9pZCA9IGNwdV90b19iZTE2KHZhbHVlKTsKKwllbHNlIGlmICghc3RyY21wKG5h
bWUsICJwZXJpb2RpY19ydGNfdXBkYXRlIikpCisJCWRldl9kZXNjLT5wZXJpb2RpY19ydGNfdXBk
YXRlID0gY3B1X3RvX2JlMTYodmFsdWUpOworCWVsc2UgaWYgKCFzdHJjbXAobmFtZSwgImRldmlj
ZV92ZXJzaW9uIikpCisJCWRldl9kZXNjLT5kZXZpY2VfdmVyc2lvbiA9IGNwdV90b19iZTE2KHZh
bHVlKTsKKwllbHNlIGlmICghc3RyY21wKG5hbWUsICJwc2FfbWF4X2RhdGFfc2l6ZSIpKQorCQlk
ZXZfZGVzYy0+cHNhX21heF9kYXRhX3NpemUgPSBjcHVfdG9fYmUzMih2YWx1ZSk7CisJZWxzZSBp
ZiAoIXN0cmNtcChuYW1lLCAiZXh0ZW5kZWRfdWZzX2ZlYXR1cmVzX3N1cHBvcnQiKSkKKwkJZGV2
X2Rlc2MtPmV4dGVuZGVkX3Vmc19mZWF0dXJlc19zdXBwb3J0ID0gY3B1X3RvX2JlMzIodmFsdWUp
OworCWVsc2UgaWYgKCFzdHJjbXAobmFtZSwgIm51bV9zaGFyZWRfd3JpdGVfYm9vc3Rlcl9idWZm
ZXJfYWxsb2N1bml0cyIpKQorCQlkZXZfZGVzYy0+bnVtX3NoYXJlZF93cml0ZV9ib29zdGVyX2J1
ZmZlcl9hbGxvY3VuaXRzID0gYmUzMl90b19jcHUodmFsdWUpOworCWVsc2UKKwkJcmV0dXJuIC0x
OworCXJldHVybiAwOworfQorCitpbnQgdWZzX3Rvb2xfc2V0X2NvbmZpZ19kZXNjKGNvbnN0IGNo
YXIgKm5hbWUsIHUzMiB2YWx1ZSkKK3sKKwlzdHJ1Y3QgdWZzX2hiYSAqaGJhID0gdWZzdG9vbF9w
cm9iZV9kZXYoMCk7CisKKwlpZiAoZ19jZmdfZGVzYy5jZmdfZGVzYy5sZW5ndGggPT0gMCkgewor
CQlpZiAodWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2NvbmZpZyhoYmEsICZnX2NmZ19kZXNjKSkgewor
CQkJcHJpbnRmKCJGYWlsZWQgdG8gcmVhZCBkZXZpY2UgZGVzY3JpcHRvclxuIik7CisJCQlyZXR1
cm4gLUVJTlZBTDsKKwkJfQorCX0KKworCWlmIChzZXRfY29uZmlnX2Rlc2NfZmllbGQoJmdfY2Zn
X2Rlc2MuY2ZnX2Rlc2MsIG5hbWUsIHZhbHVlKSkgeworCQlwcmludGYoIkZhaWxlZCB0byBzZXQg
cGFyYW1ldGVycyAlcyBkZXNjcmlwdG9yXG4iLCBuYW1lKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJ
fQorCXVmc2hjZF9wcmludF9jb25maWdfZGVzY3JpcHRvcigmZ19jZmdfZGVzYy5jZmdfZGVzYyk7
CisJcmV0dXJuIDA7Cit9CisKK2ludCB1ZnNfdG9vbF9zZXRfZGV2aWNlX2Rlc2MoY29uc3QgY2hh
ciAqbmFtZSwgdTMyIHZhbHVlKQoreworCXN0cnVjdCB1ZnNfZGV2aWNlX2Rlc2NyaXB0b3IgZGV2
aWNlX2Rlc2M7CisJc3RydWN0IHVmc19oYmEgKmhiYSA9IHVmc3Rvb2xfcHJvYmVfZGV2KDApOwor
CWludCByZXQ7CisKKwlpZiAodWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2RldmljZShoYmEsICZkZXZp
Y2VfZGVzYykpIHsKKwkJcHJpbnRmKCJGYWlsZWQgdG8gcmVhZCBkZXZpY2UgZGVzY3JpcHRvclxu
Iik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWlmIChzZXRfZGV2aWNlX2Rlc2NfZmllbGQo
JmRldmljZV9kZXNjLCBuYW1lLCB2YWx1ZSkpIHsKKwkJcHJpbnRmKCJGYWlsZWQgdG8gc2V0IHBh
cmFtZXRlcnMgJXMgZGVzY3JpcHRvclxuIiwgbmFtZSk7CisJCXJldHVybiAtRUlOVkFMOworCX0K
KworCXJldCA9IHVmc2hjZF93cml0ZV9kZXNjX3BhcmFtKGhiYSwgUVVFUllfREVTQ19JRE5fREVW
SUNFLAorCQkJCSAgICAgIDAsIDAsICh2b2lkICopJmRldmljZV9kZXNjLAorCQkJCSAgICAgIFVG
U19ERVNDX1NJWkUpOworCWlmIChyZXQpIHsKKwkJcHJpbnRmKCJGYWlsZWQgdG8gd3JpdGUgJXNc
biIsIG5hbWUpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisJcmV0dXJuIHJldDsKK30KKworaW50
IHVmc190b29sX2NvbW1pdCh2b2lkKQoreworCWludCByZXQ7CisJdTggKmNvbmZpZzsKKwlzdHJ1
Y3QgdWZzX2hiYSAqaGJhID0gdWZzdG9vbF9wcm9iZV9kZXYoMCk7CisKKwljb25maWcgPSAoX191
OCAqKSZnX2NmZ19kZXNjOworCXVmc2hjZF9jYWNoZV9mbHVzaChjb25maWcsIFFVRVJZX0RFU0Nf
VU5JVF9ERUZfU0laRSk7CisJcmV0ID0gdWZzaGNkX3dyaXRlX2Rlc2NfcGFyYW0oaGJhLAorCQkJ
CSAgICAgIFFVRVJZX0RFU0NfSUROX0NPTkZJR1VSQVRJT04sCisJCQkJICAgICAgMCwgMCwgY29u
ZmlnLAorCQkJCSAgICAgIGdfY2ZnX2Rlc2MuY2ZnX2Rlc2MubGVuZ3RoKTsKKworCWlmIChyZXQp
CisJCXByaW50ZigiRmFpbGVkIHRvIHdyaXRlIENvbmZpZ3VyYXRpb25cbiIpOworCXJldHVybiBy
ZXQ7Cit9CisKK2ludCB1ZnNfdG9vbF9jbGVhcmFsbCh2b2lkKQoreworCWludCByZXQ7CisJdTgg
KmNvbmZpZzsKKwlzdHJ1Y3QgdWZzX2RldmljZV9kZXNjcmlwdG9yIGRldmljZV9kZXNjOworCXN0
cnVjdCB1ZnNfaGJhICpoYmEgPSB1ZnN0b29sX3Byb2JlX2RldigwKTsKKworCS8vIFBvcHVsYXRl
IGRlc2NyaXB0b3IKKwlpZiAoZ19jZmdfZGVzYy5jZmdfZGVzYy5sZW5ndGggPT0gMCAmJgorCSAg
ICB1ZnNoY2RfcXVlcnlfZGVzY19pZG5fY29uZmlnKGhiYSwgJmdfY2ZnX2Rlc2MpKSB7CisJCXJl
dHVybiAtRUlOVkFMOworCX0KKwljb25maWcgPSAoX191OCAqKSZnX2NmZ19kZXNjOworCisJdWZz
aGNkX2NhY2hlX2ZsdXNoKGNvbmZpZywgUVVFUllfREVTQ19VTklUX0RFRl9TSVpFKTsKKwlpZiAo
dWZzaGNkX3F1ZXJ5X2Rlc2NfaWRuX2RldmljZShoYmEsICZkZXZpY2VfZGVzYykpIHsKKwkJcHJp
bnRmKCJGYWlsZWQgdG8gcmVhZCBJRE4gMGhcbiIpOworCQlyZXR1cm4gLTE7CisJfQorCisJdWZz
aGNkX2NsZWFyYWxsX2x1bnMoJmdfY2ZnX2Rlc2MsCisJCQkgICAgIGRldmljZV9kZXNjLnVkMF9i
YXNlX29mZnNldCwKKwkJCSAgICAgZGV2aWNlX2Rlc2MuY29uZmlnX2xlbmd0aCk7CisKKwlyZXQg
PSB1ZnNoY2Rfd3JpdGVfZGVzY19wYXJhbShoYmEsCisJCQkJICAgICAgUVVFUllfREVTQ19JRE5f
Q09ORklHVVJBVElPTiwKKwkJCQkgICAgICAwLCAwLCBjb25maWcsCisJCQkJICAgICAgZ19jZmdf
ZGVzYy5jZmdfZGVzYy5sZW5ndGgpOworCisJaWYgKHJldCkKKwkJcHJpbnRmKCJGYWlsZWQgdG8g
Q2xlYXIgQ29uZmlndXJhdGlvblxuIik7CisJcmV0dXJuIHJldDsKK30KKworaW50IHVmc190b29s
X3NldF9sdW4oaW50IGx1biwgY29uc3QgY2hhciAqcGFybSwgdTMyIHZhbCkKK3sKKwlzdHJ1Y3Qg
dWZzX2hiYSAqaGJhID0gdWZzdG9vbF9wcm9iZV9kZXYoMCk7CisKKwlyZXR1cm4gdWZzaGNkX3Vw
ZGF0ZV9sdW4oaGJhLCBsdW4sIHBhcm0sIHZhbCk7Cit9CisKK2ludCB1ZnNfdG9vbF9xdWVyeV9m
bGFnKGNvbnN0IGNoYXIgKmZsYWcpCit7CisJc3RydWN0IHVmc19oYmEgKmhiYSA9IHVmc3Rvb2xf
cHJvYmVfZGV2KDApOworCisJcmV0dXJuIHVmc2hjZF9xdWVyeV91c2VyX2ZsYWcoaGJhLCBmbGFn
KTsKK30KKworaW50IHVmc190b29sX3F1ZXJ5KGludCBsdW4sIGludCBpZG4pCit7CisJc3RydWN0
IHVmc19oYmEgKmhiYTsKKworCWhiYSA9IHVmc3Rvb2xfcHJvYmVfZGV2KDApOworCWlmICghaGJh
KSB7CisJCXByaW50ZigidWZzX3Rvb2w6IGZhaWxlZCB0byBnZXQgaGJhXG4iKTsKKwkJcmV0dXJu
IC0xOworCX0KKworCWlmIChsdW4gPj0gMCAmJiBpZG4gPj0gMCkgeworCQlpZG5fcmVhZChoYmEs
IGlkbiwgbHVuKTsKKwkJcmV0dXJuIDA7CisJfQorCisJdWZzX3Rvb2xfaGVscCgpOworCXJldHVy
biAtMTsKK30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL3Vmc190b29sLmggYi9kcml2ZXJzL3Vm
cy91ZnNfdG9vbC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi43YmE4
NTJjZWVkMAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvdWZzL3Vmc190b29sLmgKQEAgLTAs
MCArMSwzOTQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAqLworI2lm
bmRlZiBfX1VGUzJfSAorI2RlZmluZSBfX1VGUzJfSAorI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
CisKKy8qCisgKiBJbiBhIFFVRVJZIFJFUVVFU1QgVVBJVSwgdGhlIERldmljZSBEZXNjcmlwdG9y
CisgKiBpcyBhZGRyZXNzZWQgc2V0dGluZzogREVTQ1JJUFRPUiBJRE4gPSAwMGgKKyAqLworc3Ry
dWN0IHVmc19kZXZpY2VfZGVzY3JpcHRvciB7CisJdTggbGVuZ3RoOwkJLyogU2l6ZSBvZiB0aGlz
IGRlc2NyaXB0b3IgKi8KKwl1OCBkZXNjcmlwdG9yX2lkbjsJLyogRGVzY3JpcHRvciBUeXBlIElk
ZW50aWZpZXIgKDAwaCkgKi8KKwl1OCBkZXZpY2U7CQkvKiBEZXZpY2UgdHlwZSAoMDBoOiBEZXZp
Y2UpICovCisJdTggZGV2aWNlX2NsYXNzOworCS8qIFVGUyBEZXZpY2UgQ2xhc3MgKDAwaDogTWFz
cyBTdG9yYWdlKSAqLworCXU4IGRldmljZV9zdWJfY2xhc3M7CisJLyogVUZTIE1hc3MgU3RvcmFn
ZSBTdWJjbGFzcyAoZS5nLiwgMDBoOiBFbWJlZGRlZCBCb290YWJsZSkgKi8KKwl1OCBwcm90b2Nv
bDsKKwkvKiBQcm90b2NvbCBzdXBwb3J0ZWQgYnkgVUZTIERldmljZSAoMDBoOiBTQ1NJKSAqLwor
CXU4IG51bWJlcl9sdTsKKwkvKiBOdW1iZXIgb2YgTG9naWNhbCB1bml0cyAobm9uLXdlbGwga25v
d24pICAqLworCXU4IG51bWJlcl93bHU7CisJLyogTnVtYmVyIG9mIFdlbGwga25vd24gTG9naWNh
bCB1bml0cyAoTURWID0gMDRoKSAqLworCXU4IGJvb3RfZW5hYmxlOwkvKiBCb290IEVuYWJsZSAo
MDFoOiBlbmFibGVkKSAqLworCXU4IGRlc2NyX2FjY2Vzc19lbjsKKwkvKiBEZXNjcmlwdG9yIEFj
Y2VzcyBFbmFibGUgZHVyaW5nIHBhcnRpYWwgYm9vdCBpbml0aWFsaXphdGlvbiAqLworCisJLyog
LS0tIHBvd2VyIE1hbmFnZW1lbnQgJiBQcmlvcml0eSAoT2Zmc2V0IDB4MEEpIC0tLSAqLworCXU4
IGluaXRfcG93ZXJfbW9kZTsKKwkvKiBJbml0aWFsIHBvd2VyIE1vZGUgYWZ0ZXIgZGV2aWNlIGlu
aXRpICgwMGg6IFVGUy1TbGVlcCwgMDFoOiAqLworCS8qICAgQWN0aXZlKSBbNCwgNV0gKi8KKwl1
OCBoaWdoX3ByaW9yaXR5X2x1bjsKKwkvKiBIaWdoIFByaW9yaXR5IExvZ2ljYWwgdW5pdCAoN0Zo
IGlmIGFsbCBMVXMgaGF2ZSBzYW1lIHByaW9yaXR5KSAqLworCXU4IHNlY3VyZV9yZW1vdmFsX3R5
cGU7CisJLyogU2VjdXJlIFJlbW92YWwgVHlwZSAoMDBoOiBlcmFzZSwgMDFoOiBvdmVyd3JpdGUv
ZXJhc2UsIGV0Yy4pICovCisJdTggc2VjdXJpdHlfbHU7CisJLyogU3VwcG9ydCBmb3Igc2VjdXJp
dHkgTFUgKDAxaDogUlBNQikgKi8KKwl1OCBiYWNrZ3JvdW5kX29wc190ZXJtX2xhdDsKKwkvKiBC
YWNrZ3JvdW5kIE9wZXJhdGlvbnMgVGVybWluYXRpb24gTGF0ZW5jeSAoaW4gdW5pdHMgb2YgMTAg
bXMpICovCisJdTggaW5pdF9hY3RpdmVfaWNjX2xldmVsOworCS8qIEluaXRpYWwgQWN0aXZlIElD
QyBMZXZlbCBhZnRlciBwb3dlciBvbi9yZXNldCAoMDBoIHRvIDBGaCkgKi8KKworCS8qIC0tLSBW
ZXJzaW9uLCBOYW1pbmcsICYgY29uZmlndXJhdGlvbiBQb2ludGVycyAoT2Zmc2V0IDB4MTApIC0t
LSAqLworCXUxNiBzcGVjX3ZlcnNpb247CisJLyogU3BlY2lmaWNhdGlvbiB2ZXJzaW9uIGluIEJD
RCBmb3JtYXQgKGUuZy4sIDMuMSA9IDAzMTBoKSAqLworCXUxNiBtYW51ZmFjdHVyZV9kYXRlOwkv
KiBNYW51ZmFjdHVyaW5nIERhdGUgaW4gQkNEIGZvcm1hdCAqLworCXU4IG1hbnVmYWN0dXJlcl9u
YW1lOworCS8qIEluZGV4IHRvIHRoZSBNYW51ZmFjdHVyZXIgTmFtZSBzdHJpbmcgZGVzY3JpcHRv
ciAqLworCXU4IHByb2R1Y3RfbmFtZTsKKwkvKiBJbmRleCB0byB0aGUgUHJvZHVjdCBOYW1lIHN0
cmluZyBkZXNjcmlwdG9yICovCisJdTggc2VyaWFsX251bWJlcjsKKwkvKiBJbmRleCB0byB0aGUg
U2VyaWFsIE51bWJlciBzdHJpbmcgZGVzY3JpcHRvciAqLworCXU4IG9lbV9pZDsKKwkvKiBJbmRl
eCB0byB0aGUgT0VNIElEIHN0cmluZyBkZXNjcmlwdG9yICovCisJdTE2IG1hbnVmYWN0dXJlcl9p
ZDsKKwkvKiBNYW51ZmFjdHVyZXIgSUQgY29kZSBhbmQgQmFuayBJbmRleCAoSkVQMTA2IGRlZmlu
aXRpb24pICovCisJdTggdWQwX2Jhc2Vfb2Zmc2V0OworCS8qIE9mZnNldCBvZiB1bml0IERlc2Ny
aXB0b3IgMCBjb25maWd1cmFibGUgcGFyYW1ldGVycyB3aXRoaW4gdGhlICovCisJLyogY29uZmln
dXJhdGlvbiBEZXNjcmlwdG9yICovCisJdTggY29uZmlnX2xlbmd0aDsKKwkvKiBUb3RhbCBzaXpl
IG9mIHRoZSBjb25maWd1cmFibGUgdW5pdCBEZXNjcmlwdG9yIHBhcmFtZXRlcnMgKi8KKwl1OCBk
ZXZpY2VfcnR0X2NhcDsKKwkvKiBNYXhpbXVtIG51bWJlciBvZiBvdXRzdGFuZGluZyBSZWFkeSBU
byBUcmFuc2ZlciAoUlRUKSBVUElVcyAqLworCS8qIHN1cHBvcnRlZCAgKG1pbiAyKSAqLworCXUx
NiBwZXJpb2RpY19ydGNfdXBkYXRlOworCS8qIEZyZXF1ZW5jeSBhbmQgbWV0aG9kIG9mIFJlYWwt
VGltZSBDbG9jayB1cGRhdGUgKi8KKworCS8qIC0tLSBGZWF0dXJlIFN1cHBvcnQgJiBEZXZpY2Ug
U3RhdHVzIChPZmZzZXQgMHgxRikgLS0tICovCisJdTggdWZzX2ZlYXR1cmVzX3N1cHBvcnQ7CisJ
LyogQml0bWFwIGluZGljYXRpbmcgc3VwcG9ydGVkIFVGUyBmZWF0dXJlcyAoRkZVLCBQU0EsIGV0
Yy4pICovCisJdTggZmZ1X3RpbWVvdXQ7CisJLyogRmllbGQgRmlybXdhcmUgVXBkYXRlIFRpbWVv
dXQgKGluIHNlY29uZHMpICovCisJdTggcXVldWVfZGVwdGg7CisJLyogUXVldWUgRGVwdGggKDA6
IHBlci1MVSBxdWV1ZWluZzsgMS0yNTU6IHNoYXJlZCBxdWV1ZSBkZXB0aCkgKi8KKwl1MTYgZGV2
aWNlX3ZlcnNpb247CS8qIERldmljZSBWZXJzaW9uICovCisJdTggbnVtX3NlY3VyZV93cF9hcmVh
OworCS8qIFRvdGFsIG51bWJlciBvZiBTZWN1cmUgV3JpdGUgUHJvdGVjdCAqLworCS8qIEFyZWFz
IHN1cHBvcnRlZCAobWF4IDMyKSAqLworCXUzMiBwc2FfbWF4X2RhdGFfc2l6ZTsKKwkvKiBQU0Eg
TWF4aW11bSBEYXRhIFNpemUgKGluIHVuaXRzIG9mIDQgS2J5dGUpICovCisJdTggcHNhX3N0YXRl
X3RpbWVvdXQ7CisJLyogUFNBIFN0YXRlIFRpbWVvdXQgKG1heCBjb21tYW5kIHRpbWVvdXQgZm9y
IGJfcHNhX3N0YXRlIGNoYW5nZSkgKi8KKwl1OCBwcm9kdWN0X3JldmlzaW9uX2xldmVsOworCS8q
IEluZGV4IHRvIHRoZSBQcm9kdWN0IFJldmlzaW9uIExldmVsIHN0cmluZyBkZXNjcmlwdG9yICov
CisJdTggcmVzZXJ2ZWRfMmJoWzE4XTsJLyogcmVzZXJ2ZWQgKi8KKwl1OCByZXNlcnZlZF8zMGhb
MTldOworCS8qIFJlc2VydmVkIGZvciBVbmlmaWVkIE1lbW9yeSBFeHRlbnNpb24gc3RhbmRhcmQg
Ki8KKwl1OCByZXNlcnZlZF80MGhbMjBdOworCS8qIFJlc2VydmVkIGZvciBIb3N0IFBlcmZvcm1h
bmNlIEJvb3N0ZXIgKEhQQikgRXh0ZW5zaW9uIFN0YW5kYXJkICovCisJdTggcmVzZXJ2ZWRfNDNo
WzIxXTsJLyogUmVzZXJ2ZWQgKi8KKworCS8qIC0tLSBFeHRlbmRlZCBGZWF0dXJlIFN1cHBvcnQg
KE9mZnNldCAweDRGKSAtLS0gKi8KKwl1MzIgZXh0ZW5kZWRfdWZzX2ZlYXR1cmVzX3N1cHBvcnQ7
CisJLyogRXh0ZW5kZWQgVUZTIEZlYXR1cmVzIFN1cHBvcnQgKGluY2x1ZGluZyBXcml0ZUJvb3N0
ZXIsICovCisJLyogb2Zmc2V0IDUzaCBQZXJmb3JtYW5jZSBUaHJvdHRsaW5nKSAqLworCXU4IHdy
aXRlX2Jvb3N0ZXJfYnVmZmVyX3ByZXNlcnZlX3VzZXJfc3BhY2VfZW47CisJLyogb2Zmc2V0IDU0
aCBQcmVzZXJ2ZSBVc2VyIFNwYWNlIG1vZGUgZm9yIFdyaXRlQm9vc3RlciBCdWZmZXIgKi8KKwl1
OCB3cml0ZV9ib29zdGVyX2J1ZmZlcl90eXBlOworCS8qICBvZmZzZXQgNTVoIFdyaXRlQm9vc3Rl
ciBCdWZmZXIgVHlwZQorCSAqICAoMGg6ZGVkaWNhdGVkIGJ1ZmZlciwwMWg6IHNoYXJlZCBidWZm
ZXIpCisJICovCisJdTMyIG51bV9zaGFyZWRfd3JpdGVfYm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0
czsKKwkvKiBXcml0ZUJvb3N0ZXIgQnVmZmVyIHNpemUgZm9yIHNoYXJlZCBjb25maWd1cmF0aW9u
ICovCisJLyogKGluIEFsbG9jYXRpb24gdW5pdHMpICovCit9IF9fcGFja2VkOworCitzdHJ1Y3Qg
dW5pdF9kZXNjcmlwdG9yIHsKKwl1OCBsZW5ndGg7CQkvKiBTaXplIG9mIHRoaXMgZGVzY3JpcHRv
ciAoRGVmYXVsdDogMkRoKSAqLworCXU4IGRlc2NyaXB0b3JfaWRuOwkvKiB1bml0IERlc2NyaXB0
b3IgVHlwZSBJZGVudGlmaWVyICgwMmgpICovCisJdTggYnVuaXRfaW5kZXg7CQkvKiBUaGUgaW5k
ZXggb2YgdGhlIExvZ2ljYWwgdW5pdCAqLworCisJLyogLS0tIGNvbmZpZ3VyYXRpb24gUGFyYW1l
dGVycyAtLS0gKi8KKwl1OCBsdV9lbmFibGU7CQkvKiAwMWg6IExVIGVuYWJsZWQsIDAwaDogTFUg
ZGlzYWJsZWQgKi8KKwl1OCBib290X2x1bl9pZDsKKwkvKiAwMWg6IEJvb3QgTFUgQSwgMDJoOiBC
b290IExVIEIsIDAwaDogTm90IGJvb3RhYmxlICovCisJdTggbHVfd3JpdGVfcHJvdGVjdDsKKwkv
KiAwMWg6IHBvd2VyLW9uIFdQLCAwMmg6IFBlcm1hbmVudCBXUCwgMDBoOiBOb25lICovCisJdTgg
bHVfcXVldWVfZGVwdGg7CisJLyogTFUtc3BlY2lmaWMgcXVldWUgZGVwdGggKDAgaWYgc2hhcmVk
IHF1ZXVpbmcgaXMgdXNlZCkgKi8KKwl1OCBwc2Ffc2Vuc2l0aXZlOworCS8qIDAxaDogU2Vuc2l0
aXZlIHRvIHNvbGRlcmluZywgMDBoOiBOb3Qgc2Vuc2l0aXZlICovCisJdTggbWVtb3J5X3R5cGU7
CisJLyogTWVtb3J5IHR5cGUgKGUuZy4sIDAwaDogTm9ybWFsLCAwMWg6IFN5c3RlbSBDb2RlKSAq
LworCXU4IGRhdGFfcmVsaWFiaWxpdHk7CisJLyogMDFoOiBEYXRhIHByb3RlY3RlZCBhZ2FpbnN0
IHBvd2VyIGZhaWx1cmUgKi8KKwl1OCBsb2dpY2FsX2Jsb2NrX3NpemU7CisJLyogTG9naWNhbCBC
bG9jayBTaXplIGV4cG9uZW50IChlLmcuLCAwQ2ggPSA0IEtieXRlKSAqLworCisJLyogLS0tIENh
cGFjaXR5IGFuZCBnZW9tZXRyeSAtLS0gKi8KKwl1NjQgbG9naWNhbF9ibG9ja19jb3VudDsKKwkv
KiBUb3RhbCBudW1iZXIgb2YgYWRkcmVzc2FibGUgbG9naWNhbCBibG9ja3MgaW4gdGhlIExVICov
CisJdTMyIGVyYXNlX2Jsb2NrX3NpemU7CisJLyogT3B0aW1hbCBncmFudWxhcml0eSBmb3IgZXJh
c2UvZGlzY2FyZCBvcGVyYXRpb25zICovCisJdTggcHJvdmlzaW9uaW5nX3R5cGU7CisJLyogMDBo
OiBGdWxsLCAwMmg6IFRoaW4gKFRQUlo9MCksIDAzaDogVGhpbiAoVFBSWj0xKSAqLworCXU2NCBw
aHlfbWVtX3Jlc291cmNlX2NvdW50OworCS8qIFRvdGFsIHBoeXNpY2FsIG1lbW9yeSByZXNvdXJj
ZXMgYXZhaWxhYmxlIHRvIHRoZSBMVSAqLworCisJLyogLS0tIFBlcmZvcm1hbmNlIGFuZCBFeHRl
bmRlZCBGZWF0dXJlcyAtLS0gKi8KKwl1MTYgY29udGV4dF9jYXBhYmlsaXRpZXM7CisJLyogQml0
cyBbMzowXTogTWF4Q29udGV4dElEOyBCaXRzIFs2OjRdOiBMYXJnZSB1bml0IE11bHRpcGxpZXIg
Ki8KKwl1OCBsYXJnZXVuaXRfZ3JhbnVsYXJpdHlfTTE7CisJLyogTGFyZ2UgdW5pdCBHcmFudWxh
cml0eSA9IDFNQiAqICh2YWx1ZSArIDEpICovCisJdTggcmVzZXJ2ZWRbMTFdOwkvKiBSZXNlcnZl
ZCBmb3IgSFBCIEV4dGVuc2lvbiBTdGFuZGFyZCAqLworCXUzMiBsdV9udW1fd3JpdGVfYm9vc3Rl
cl9idWZmZXJfYWxsb2N1bml0czsKKwkvKiBXcml0ZUJvb3N0ZXIgQnVmZmVyIHNpemUgaW4gQWxs
b2NhdGlvbiB1bml0cyAqLworfSBfX3BhY2tlZDsKKworLyoKKyAqCisgKiBVRlMgR2VvbWV0cnkg
RGVzY3JpcHRvciAoSUROIDA3aCkKKyAqIFRvdGFsIFNpemU6IDg3IGJ5dGVzICgweDU3KQorICov
CitzdHJ1Y3QgdWZzX2dlb21ldHJ5X2Rlc2NyaXB0b3IgeworCS8qIC0tLSBEZXNjcmlwdG9yIEhl
YWRlciAoT2Zmc2V0IDB4MDApIC0tLSAqLworCXU4IGxlbmd0aDsJCS8qIFNpemUgb2YgdGhpcyBk
ZXNjcmlwdG9yICg1N2gpICovCisJdTggZGVzY3JpcHRvcl9pZG47CS8qIGdlb21ldHJ5IERlc2Ny
aXB0b3IgSUQgKDA3aCkgKi8KKwl1OCBtZWRpYV90ZWNobm9sb2d5OwkvKiBSZXNlcnZlZCAoMDBo
KSAqLworCXU4IHJlc2VydmVkXzAzaDsJLyogUmVzZXJ2ZWQgKDAwaCkgKi8KKworCS8qIC0tLSBD
YXBhY2l0eSBhbmQgRGV2aWNlIGdlb21ldHJ5IChPZmZzZXQgMHgwNCkgLS0tICovCisJdTY0IHRv
dGFsX3Jhd19kZXZpY2VfY2FwYWNpdHk7IC8qIFRvdGFsIG1lbW9yeSBhdmFpbGFibGUgKHVuaXRz
IG9mIDUxMkIpICovCisJdTggbWF4X251bWJlcl9sdTsJLyogTWF4IExVczogMDBoICg4IExVcykg
b3IgMDFoICgzMiBMVXMpICovCisJdTMyIHNlZ21lbnRfc2l6ZTsJLyogU2VnbWVudCBzaXplICh1
bml0cyBvZiA1MTJCKSAqLworCXU4IGFsbG9jYXRpb251bml0X3NpemU7CS8qIEFsbG9jYXRpb24g
dW5pdCBTaXplIChudW1iZXIgb2Ygc2VnbWVudHMpICovCisJdTggbWluX2FkZHJfYmxvY2tfc2l6
ZTsKKwkvKiBNaW4gYWRkcmVzc2FibGUgYmxvY2sgc2l6ZSAodW5pdHMgb2YgNTEyQiwgbWluIDA4
aCkgKi8KKwl1OCBvcHRpbWFsX3JlYWRfYmxvY2tfc2l6ZTsJLyogT3B0aW1hbCByZWFkIGdyYW51
bGFyaXR5ICh1bml0cyBvZiA1MTJCKSAqLworCXU4IG9wdGltYWxfd3JpdGVfYmxvY2tfc2l6ZTsJ
LyogT3B0aW1hbCB3cml0ZSBncmFudWxhcml0eSAodW5pdHMgb2YgNTEyQikgKi8KKwl1OCBtYXhf
aW5fYnVmZmVyX3NpemU7CS8qIE1heCBkYXRhLWluIGJ1ZmZlciBzaXplICh1bml0cyBvZiA1MTJC
KSAqLworCXU4IG1heF9vdXRfYnVmZmVyX3NpemU7CS8qIE1heCBkYXRhLW91dCBidWZmZXIgc2l6
ZSAodW5pdHMgb2YgNTEyQikgKi8KKwl1OCBycG1iX3JlYWRfd3JpdGVfc2l6ZTsJLyogTWF4IFJQ
TUIgZnJhbWVzICgyNTZCKSBwZXIgY29tbWFuZCAqLworCXU4IGR5bmFtaWNfY2FwYWNpdHlfcmVz
b3VyY2VfcG9saWN5OwkvKiAwMGg6IHBlciBMVSwgMDFoOiBwZXIgbWVtb3J5IHR5cGUgKi8KKwl1
OCBkYXRhX29yZGVyaW5nOwkvKiAwMWg6IE91dC1vZi1vcmRlciBkYXRhIHRyYW5zZmVyIHN1cHBv
cnRlZCAqLworCXU4IG1heF9jb250ZXhfaWRfbnVtYmVyOwkvKiBNYXhpbXVtIHN1cHBvcnRlZCBj
b250ZXh0cyAobWluIDUpICovCisJdTggc3lzX2RhdGFfdGFndW5pdF9zaXplOwkvKiBHcmFudWxh
cml0eSBmb3IgU3lzdGVtIERhdGEgVGFnZ2luZyAqLworCXU4IHN5c19kYXRhX3RhZ19yZXNfc2l6
ZTsJLyogTWF4IHN0b3JhZ2UgYXJlYSBmb3Igc3lzdGVtIGRhdGEgdGFnZ2luZyAqLworCXU4IHN1
cHBvcnRlZF9zZWNfcl90eXBlczsJLyogQml0bWFwIG9mIHN1cHBvcnRlZCBTZWN1cmUgUmVtb3Zh
bCBUeXBlcyAqLworCXUxNiBzdXBwb3J0ZWRfbWVtb3J5X3R5cGVzOworCS8qIEJpdG1hcCBvZiBz
dXBwb3J0ZWQgbWVtb3J5IHR5cGVzIChOb3JtYWwsIEVuaGFuY2VkLCBldGMuKSAqLworCisJLyog
LS0tIE1lbW9yeSBUeXBlIENhcGFjaXR5IGFuZCBGYWN0b3JzIChPZmZzZXQgMHgyMCkgLS0tICov
CisJdTMyIHN5c3RlbV9jb2RlX21heF9uX2FsbG9jX3U7CisJLyogTWF4IEFsbG9jYXRpb24gdW5p
dHMgZm9yIFN5c3RlbSBDb2RlIG1lbW9yeSAqLworCXUxNiBzeXN0ZW1fY29kZV9jYXBfYWRqX2Zh
YzsKKwkvKiBDYXBhY2l0eSBBZGp1c3RtZW50IEZhY3RvciBmb3IgU3lzdGVtIENvZGUgKi8KKwl1
MzIgbm9uX3BlcnNpc3RfbWF4X25fYWxsb2NfdTsKKwkvKiBNYXggQWxsb2NhdGlvbiB1bml0cyBm
b3IgTm9uLVBlcnNpc3RlbnQgbWVtb3J5ICovCisJdTE2IG5vbl9wZXJzaXN0X2NhcF9hZGpfZmFj
OworCS8qIENhcGFjaXR5IEFkanVzdG1lbnQgRmFjdG9yIGZvciBOb24tUGVyc2lzdGVudCAqLwor
CXUzMiBlbmhhbmNlZDFfbWF4X25fYWxsb2NfdTsKKwkvKiBNYXggQWxsb2NhdGlvbiB1bml0cyBm
b3IgRW5oYW5jZWQgbWVtb3J5ICovCisJLyogQ2FwYWNpdHkgQWRqdXN0bWVudCBGYWN0b3IgZm9y
IEVuaGFuY2VkICovCisJdTE2IGVuaGFuY2VkMV9jYXBfYWRqX2ZhYzsKKwl1MzIgZW5oYW5jZWQy
X21heF9uX2FsbG9jX3U7CisJLyogTWF4IEFsbG9jYXRpb24gdW5pdHMgZm9yIEVuaGFuY2VkIG1l
bW9yeSAqLworCS8qIENhcGFjaXR5IEFkanVzdG1lbnQgRmFjdG9yIGZvciBFbmhhbmNlZCAqLwor
CXUxNiBlbmhhbmNlZDJfY2FwX2Fkal9mYWM7CisJdTMyIGVuaGFuY2VkM19tYXhfbl9hbGxvY191
OworCS8qIE1heCBBbGxvY2F0aW9uIHVuaXRzIGZvciBFbmhhbmNlZCBtZW1vcnkgKi8KKwkvKiBD
YXBhY2l0eSBBZGp1c3RtZW50IEZhY3RvciBmb3IgRW5oYW5jZWQgKi8KKwl1MTYgZW5oYW5jZWQz
X2NhcF9hZGpfZmFjOworCXUzMiBlbmhhbmNlZDRfbWF4X25fYWxsb2NfdTsKKwkvKiBNYXggQWxs
b2NhdGlvbiB1bml0cyBmb3IgRW5oYW5jZWQgbWVtb3J5ICovCisJLyogQ2FwYWNpdHkgQWRqdXN0
bWVudCBGYWN0b3IgZm9yIEVuaGFuY2VkICovCisJdTE2IGVuaGFuY2VkNF9jYXBfYWRqX2ZhYzsK
KwkvKiAtLS0gUGVyZm9ybWFuY2UgT3B0aW1pemF0aW9uIChPZmZzZXQgMHg0NCkgLS0tICovCisJ
LyogT3B0aW1hbCBMb2dpY2FsIEJsb2NrIFNpemUgcGVyIG1lbW9yeSB0eXBlICovCisJdTMyIG9w
dGltYWxfbG9naWNhbF9ibG9ja19zaXplOworCXU4ICByZXNlcnZlZF9ocGJbNF07IC8vIDQ4aDog
UmVzZXJ2ZWQgZm9yIEhQQiBFeHRlbnNpb24KKwl1MTYgcmVzZXJ2ZWQyOyAgIC8vIDREaDogUmVz
ZXJ2ZWQKKwkvKiBXcml0ZUJvb3N0ZXIgUGFyYW1ldGVycyAqLworCS8qIDRGaDogTWF4IHRvdGFs
IFdyaXRlQm9vc3RlciBCdWZmZXIgc2l6ZSAqLworCXUzMiB3cml0ZV9ib29zdGVyX2J1ZmZlcl9t
YXhfYWxsb2NfdW5pdHM7CisJLyogNTNoOiBNYXggTFVzIHN1cHBvcnRpbmcgV3JpdGVCb29zdGVy
IChWYWxpZDogMSkgKi8KKwl1OCAgZGV2aWNlX21heF93cml0ZV9ib29zdGVyX2x1czsKKwkvKiA1
NGg6IExCQSBzcGFjZSByZWR1Y3Rpb24gZmFjdG9yIChlLmcuLCAzIGZvciBUTEMpICovCisJdTgg
IHdyaXRlX2Jvb3N0ZXJfYnVmZmVyX2NhcGFkamZhYzsKKwkvKiA1NWg6IFVzZXIgc3BhY2UgdnMg
UHJlc2VydmUgdHlwZXMgKi8KKwl1OCAgc3VwcG9ydGVkX3dyaXRlX2Jvb3N0ZXJfYnVmZmVyX3Vz
ZXJzcGFjZV9yZWR1Y3Rpb25fdHlwZXM7CisJLyogNTZoOiBMVSBiYXNlZCB2cyBTaGFyZWQgYnVm
ZmVyIHR5cGUgKi8KKwl1OCAgc3VwcG9ydGVkX3dyaXRlX2Jvb3N0ZXJfYnVmZmVyX3R5cGVzOwor
fSBfX3BhY2tlZDsKKworLyoqCisgKiBVRlMgY29uZmlndXJhdGlvbiBEZXNjcmlwdG9yIC0gSGVh
ZGVyIGFuZCBEZXZpY2UgY29uZmlndXJhYmxlIFBhcmFtZXRlcnMKKyAqIEJhc2VkIG9uIFRhYmxl
IDE0LjEwIChJTkRFWCA9IDAwaCkKKyAqLworc3RydWN0IGNvbmZpZ19kZXNjcmlwdG9yIHsKKwkv
KiAtLS0gRGVzY3JpcHRvciBIZWFkZXIgLS0tICovCisJdTggbGVuZ3RoOworCS8qIDAwaDogU2l6
ZSBvZiB0aGlzIGRlc2NyaXB0b3IgKE1EVjogRTZoKSAqLworCXU4IGRlc2NyaXB0b3JfaWRuOwor
CS8qIDAxaDogY29uZmlndXJhdGlvbiBEZXNjcmlwdG9yIFR5cGUgSUQgKDAxaCkgKi8KKworCS8q
IC0tLSBjb25maWd1cmF0aW9uIEZsb3cgQ29udHJvbCAtLS0gKi8KKwl1OCBjb25mX2Rlc2NfY29u
dGludWU7CisJLyogMDJoOiAwMGggPSBMYXN0IGRlc2NyaXB0b3IgKGFwcGx5IGNvbmZpZyk7ICov
CisJLyogMDFoID0gTW9yZSBkZXNjcmlwdG9ycyBmb2xsb3cgKi8KKworCS8qIC0tLSBEZXZpY2Ug
RGVzY3JpcHRvciBjb25maWd1cmFibGUgUGFyYW1ldGVycyAtLS0gKi8KKwl1OCBib290X2VuYWJs
ZTsKKwkvKiAwM2g6IEVuYWJsZXMgYm9vdCBmZWF0dXJlICgwMWg6IGVuYWJsZWQpICovCisJdTgg
ZGVzY3JfYWNjZXNzX2VuOworCS8qIDA0aDogRW5hYmxlcyBEZXZpY2UgRGVzY3JpcHRvciBhY2Nl
c3MgYWZ0ZXIgcGFydGlhbCBpbml0ICovCisJdTggaW5pdHBvd2VyX21vZGU7CisJLyogMDVoOiBJ
bml0aWFsIHBvd2VyIE1vZGUgYWZ0ZXIgcmVzZXQgKDAxaDogQWN0aXZlKSAqLworCXU4IGhpZ2hf
cHJpb3JpdHlfbHVuOworCS8qIDA2aDogTFVOIG9mIHRoZSBoaWdoIHByaW9yaXR5IGxvZ2ljYWwg
dW5pdCAqLworCXU4IHNlY3VyZV9yZW1vdmFsX3R5cGU7CisJLyogMDdoOiBjb25maWd1cmVzIHNl
Y3VyZSByZW1vdmFsIChlLmcuLCAwMGg6IGVyYXNlKSAqLworCXU4IGluaXRfYWN0aXZlX2ljY19s
ZXZlbDsKKwkvKiAwOGg6IEluaXRpYWwgSUNDIGxldmVsIGFmdGVyIHJlc2V0ICgwMGgtMEZoKSAq
LworCXUxNiBwZXJpb2RpY19ydGNfdXBkYXRlOworCS8qIDA5aDogRnJlcXVlbmN5L21ldGhvZCBv
ZiBSZWFsLVRpbWUgQ2xvY2sgdXBkYXRlICovCisJdTggcmVzZXJ2ZWRfSFBCOworCS8qIDBCaDog
UmVzZXJ2ZWQgZm9yIEhvc3QgUGVyZm9ybWFuY2UgQm9vc3RlciAqLworCisJLyogLS0tIFJQTUIg
Y29uZmlndXJhdGlvbiBQYXJhbWV0ZXJzIC0tLSAqLworCXU4IHJwbWJfcmVnaW9uX2VuYWJsZTsK
KwkvKiAwQ2g6IEJpdG1hc2sgdG8gZW5hYmxlIFJQTUIgcmVnaW9ucyAxLTMgKi8KKwl1OCBycG1i
X3JlZ2lvbjFfc2l6ZTsKKwkvKiAwRGg6IFNpemUgb2YgUlBNQiByZWdpb24gMSBpbiAxMjhLQiB1
bml0cyAqLworCXU4IHJwbWJfcmVnaW9uMl9zaXplOworCS8qIDBFaDogU2l6ZSBvZiBSUE1CIHJl
Z2lvbiAyIGluIDEyOEtCIHVuaXRzICovCisJdTggcnBtYl9yZWdpb24zX3NpemU7CisJLyogMEZo
OiBTaXplIG9mIFJQTUIgcmVnaW9uIDMgaW4gMTI4S0IgdW5pdHMgKi8KKworCS8qIC0tLSBXcml0
ZUJvb3N0ZXIgY29uZmlndXJhdGlvbiBQYXJhbWV0ZXJzIC0tLSAqLworCXU4IHdyaXRlX2Jvb3N0
ZXJfYnVmZmVyX3ByZXNlcnZlX3VzZXJfc3BhY2VfZW47CisJLyogMTBoOiAwMWggPSBQcmVzZXJ2
ZSB1c2VyIHNwYWNlICovCisJdTggd3JpdGVfYm9vc3Rlcl9idWZmZXJfdHlwZTsKKwkvKiAxMWg6
IDAwaCA9IERlZGljYXRlZCBMVTsgMDFoID0gU2hhcmVkICovCisJdTMyIG51bV9zaGFyZWRfd3Jp
dGVfYm9vc3Rlcl9idWZmZXJfYWxsb2N1bml0czsKKwkvKiAxMmg6IFNoYXJlZCBidWZmZXIgc2l6
ZSBpbiBBbGxvYyB1bml0cyAqLworfSBfX3BhY2tlZDsKKworLyoqCisgKiBVRlMgdW5pdCBEZXNj
cmlwdG9yIGNvbmZpZ3VyYWJsZSBQYXJhbWV0ZXJzCisgKiBGb3VuZCB3aXRoaW4gdGhlIGNvbmZp
Z3VyYXRpb24gRGVzY3JpcHRvciAoSUROOiAwMWgpCisgKiBCYXNlZCBvbiBUYWJsZSAxNC4xMgor
ICovCitzdHJ1Y3QgdWZzX3VuaXRfY29uZmlndXJhYmxlX3BhcmFtZXRlcnMgeworCXU4IGx1X2Vu
YWJsZTsJCS8qIDAxaDogRW5hYmxlZCwgMDBoOiBEaXNhYmxlZCAqLworCisJdTggYm9vdF9sdW5f
aWQ7CQkvKiAwIE5vdCBCb290YWJsZSwxLUEgb3IgMi1CICovCisKKwkvKiAwMWg6IEJvb3QgTFUg
QSwgMDJoOiBCb290IExVIEIsIDAwaDogTm90IGJvb3RhYmxlICovCisJdTggbHVfd3JpdGVfcHJv
dGVjdDsKKwkvKiAwMGg6IE5vbmUsIDAxaDogcG93ZXItb24gV1AsIDAyaDogUGVybWFuZW50IFdQ
ICovCisJdTggbWVtb3J5X3R5cGU7CisJLyogTWVtb3J5IHR5cGUgKDAwaDogTm9ybWFsLCAwMWg6
IFN5c3RlbSBDb2RlKSAqLworCisJLyogTnVtYmVyIG9mIGFsbG9jYXRpb24gdW5pdHMgYXNzaWdu
ZWQgdG8gdGhlIExVLiAqLworCXUzMiBudW1fYWxsb2N1bml0czsKKworCXU4IGRhdGFfcmVsaWFi
aWxpdHk7IC8qIDAxaDogUHJvdGVjdGVkIGFnYWluc3QgcG93ZXIgZmFpbHVyZSAqLworCisJLyog
QmxvY2sgc2l6ZSBleHBvbmVudCAoZS5nLiwgMENoID0gNCBLQikgKi8KKwl1OCBsb2dpY2FsX2Js
b2NrX3NpemU7CisKKwkvKiAwMGg6IEZ1bGwsIDAyaDogVGhpbiAoVFBSWj0wKSwgMDNoOiBUaGlu
IChUUFJaPTEpICovCisJdTggcHJvdmlzaW9uaW5nX3R5cGU7CisKKwl1MTYgY29udGV4dF9jYXBh
YmlsaXRpZXM7IC8qIExVIENvbnRleHQgc3VwcG9ydCBhbmQgbXVsdGlwbGllcnMgKi8KKworCXU4
IHJlc2VydmVkXzBkaFs2XTsJLyogUmVzZXJ2ZWQgKi8KKworCXU4IHJlc2VydmVkX2hwYls3XTsK
KwkvKiBSZXNlcnZlZCBmb3IgSG9zdCBQZXJmb3JtYW5jZSBCb29zdGVyIEV4dGVuc2lvbiAqLwor
CisJdTMyIGx1X251bV93cml0ZV9ib29zdGVyX2J1ZmZlcl9hbGxvY3VuaXRzOworCS8qIFdyaXRl
Qm9vc3RlciBCdWZmZXIgc2l6ZSBpbiBBbGxvY2F0aW9uIHVuaXRzLiAqLworfSBfX3BhY2tlZDsK
Kworc3RydWN0IHVmc19jb25maWdfZGVzY3JpcHRvciB7CisJc3RydWN0IGNvbmZpZ19kZXNjcmlw
dG9yIGNmZ19kZXNjOworCS8qCisJICogTk9URTogRm9yIElOREVYID0gMDBoLCBjb25maWd1cmFi
bGUgcGFyYW1ldGVycworCSAqIGZvciB1bml0IERlc2NyaXB0b3JzIDAgdG8gNworCSAqLworCS8q
IGZvbGxvdyB0aGlzIGhlYWRlciBhdCB0aGUgb2Zmc2V0IGRlZmluZWQKKwkgKiBieSBiX3VkMF9i
YXNlX29mZnNldAorCSAqLworCXVuc2lnbmVkIGNoYXIgc3BhY2VbUVVFUllfREVTQ19DT05GSUdV
UkFUSU9OX0RFRl9TSVpFIC0KKwkJCSAgICBzaXplb2Yoc3RydWN0IGNvbmZpZ19kZXNjcmlwdG9y
KV07Cit9IF9fcGFja2VkOworCisvKioKKyAqIFVGUyBwb3dlciBQYXJhbWV0ZXIgRWxlbWVudCBG
b3JtYXQKKyAqIEJhc2VkIG9uIFRhYmxlIDcuMTMKKyAqLworc3RydWN0IHVmc19wb3dlcl9wYXJh
bWV0ZXJfZWxlbWVudCB7CisJLyogQml0cyBbMTU6MTRdOiB1bml0ICgwMGI6bl9hLCAwMWI6dV9h
LCAxMGI6bV9hLCAxMWI6QSkgKi8KKwkvKiBCaXRzIFsxMzoxMF06IFJlc2VydmVkICgwMDAwYikg
Ki8KKwkvKiBCaXRzIFs5OjBdOiAgIFZhbHVlIChNYXhpbXVtIGN1cnJlbnQgZXhwZWN0ZWQpICov
CisJdTE2IHVwb3dlcl92YWx1ZTsKK307CisKKy8qKgorICogVUZTIHBvd2VyIFBhcmFtZXRlcnMg
RGVzY3JpcHRvciAoSUROOiAwOGgpCisgKiBCYXNlZCBvbiBUYWJsZSAxNC4xNgorICovCitzdHJ1
Y3QgdWZzX3Bvd2VyX3BhcmFtZXRlcnNfZGVzY3JpcHRvciB7CisJLyogT2Zmc2V0IDAwaCAqLwor
CXU4IGxlbmd0aDsJCS8qIFNpemUgb2YgZGVzY3JpcHRvciAoNjJoKSAqLworCXU4IGRlc2NyaXB0
b3JfaWRuOwkvKiBEZXNjcmlwdG9yIFR5cGUgSUQgKDA4aCkgKi8KKworCS8qIE9mZnNldCAwMmg6
IE1heGltdW0gY3VycmVudCBmb3IgVkNDICgxNiBsZXZlbHMpICovCisJc3RydWN0IHVmc19wb3dl
cl9wYXJhbWV0ZXJfZWxlbWVudCBhY3RpdmVfaWNjX2xldmVsc192Y2NbNV07CisJLyogT2Zmc2V0
IDIyaDogTWF4aW11bSBjdXJyZW50IGZvciBWQ0NRICgxNiBsZXZlbHMpICovCisJc3RydWN0IHVm
c19wb3dlcl9wYXJhbWV0ZXJfZWxlbWVudCBhY3RpdmVfaWNjX2xldmVsc192Y2NxWzVdOworCS8q
IE9mZnNldCA0Mmg6IE1heGltdW0gY3VycmVudCBmb3IgVkNDUTIgKDE2IGxldmVscykgKi8KKwlz
dHJ1Y3QgdWZzX3Bvd2VyX3BhcmFtZXRlcl9lbGVtZW50IGFjdGl2ZV9pY2NfbGV2ZWxzX3ZjY3Ey
WzVdOworfSBfX3BhY2tlZDsKKworLyoqCisgKiBVRlMgVGVtcGVyYXR1cmUtcmVsYXRlZCBBdHRy
aWJ1dGVzCisgKiBUaGVzZSBhcmUgZGV2aWNlLWxldmVsIGF0dHJpYnV0ZXMgKFR5cGUgJ0QnKSBy
ZXRyaWV2ZWQgdmlhIFF1ZXJ5IFJlcXVlc3RzLgorICogQWxsIHRlbXBlcmF0dXJlIHZhbHVlcyBm
b2xsb3cgdGhlIGZvcm11bGE6IFRlbXBlcmF0dXJlICjCukMpID0gVmFsdWUg4oCTIDgwLgorICov
CitzdHJ1Y3QgIHVmc190ZW1wX3BhcmFtZXRlcnNfZGVzY3JpcHRvciB7CisJLyoqCisJICogSURO
IDE4aDogYkRldmljZUNhc2VSb3VnaFRlbXBlcmF0dXJlIFsxXQorCSAqIFJlcHJlc2VudHMgdGhl
IHJvdWdoIHBhY2thZ2UgY2FzZSBzdXJmYWNlIHRlbXBlcmF0dXJlLgorCSAqIDA6IFVua25vd24g
VGVtcGVyYXR1cmUuCisJICogMSB+IDI1MDogQ2FsY3VsYXRlZCBhcyAoVmFsdWUgLSA4MCkgaW4g
Q2Vsc2l1cyAoLTc5wrpDIH4gMTcwwrpDKS4KKwkgKi8KKwl1OCBkZXZpY2VfY2FzZV9yb3VnaF90
ZW1wZXJhdHVyZTsKKwkvKioKKwkgKiBJRE4gMTloOiBiRGV2aWNlVG9vSGlnaFRlbXBCb3VuZGFy
eQorCSAqIEhpZ2ggdGVtcGVyYXR1cmUgYm91bmRhcnkgdGhhdCB0cmlnZ2VycworCSAqIHRoZSBU
T09fSElHSF9URU1QIGV4Y2VwdGlvbiBldmVudC4KKwkgKiAxMDAgfiAyNTA6IENhbGN1bGF0ZWQg
YXMgKFZhbHVlIC0gODApIGluIENlbHNpdXMgKDIwwrpDIH4gMTcwwrpDKS4KKwkgKi8KKwl1OCBk
ZXZpY2VfdG9vX2hpZ2hfdGVtcF9ib3VuZGFyeTsKKwkvKgorCSAqIElETiAxQWg6IGJEZXZpY2VU
b29Mb3dUZW1wQm91bmRhcnkKKwkgKiBMb3cgdGVtcGVyYXR1cmUgYm91bmRhcnkgdGhhdCB0cmln
Z2VycyB0aGUgVE9PX0xPV19URU1QCisJICogZXhjZXB0aW9uIGV2ZW50LgorCSAqIDEgfiA4MDog
Q2FsY3VsYXRlZCBhcyAoVmFsdWUgLSA4MCkgaW4gQ2Vsc2l1cyAoLTc5wrpDIH4gMMK6QykuCisJ
ICovCisJdTggZGV2aWNlX3Rvb19sb3dfdGVtcF9ib3VuZGFyeTsKKwkvKioKKwkgKiBJRE4gMUJo
OiBiVGhyb3R0bGluZ1N0YXR1cworCSAqIEluZGljYXRlcyBpZiB0aGUgZGV2aWNlIGlzIGxpbWl0
aW5nIHBlcmZvcm1hbmNlIGR1ZQorCSAqIHRvIHNwZWNpZmljIGNvbmRpdGlvbnMuCisJICogYml0
IDA6IFNldCB0byAxIGlmIHBlcmZvcm1hbmNlIGlzIHRocm90dGxlZCBkdWUgdG8gVGVtcGVyYXR1
cmUuCisJICogYml0cyBbNzoxXTogUmVzZXJ2ZWQuCisJICovCisJdTggdGhyb3R0bGluZ19zdGF0
dXM7Cit9IF9fcGFja2VkX187CisKKyNlbmRpZgotLSAKMi40My4wCgo=
--000000000000939bdf06531a31da--
