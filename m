Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B79FC982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F331460BCD;
	Thu, 17 Sep 2026 17:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWM0_g9otgjQ; Thu, 17 Sep 2026 17:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DF9B860BB2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665592;
	b=GsHycf19yKrfFZ2uvall3wjaUVUBuWG1McxpZFpZbRJcbH8r+2oI6GfVEeMggsyGybQC
	 yFjTehHuFUIm8YrLMxXOJtQ9/rkhlfl7yf5rAkANdlBTLNhAa9TaKdB6ZDHvGuuXyXeCq
	 r+x7EPnCRy9M9HBGCtkCcQqDeSW7328VYLMw321q71OJlCczZV0cMrQ3emMVvM1SaMT+n
	 6GO9m/ze/6TwJG6IU6l6vSvWnloi9s6gpeqR6ni22mMebOFLc2LyzbvBS3edG62OrQTV6
	 kEu/EypKiIIeal2K6NwfN8cStoS7mHGIZQx6nbWWmPks/8lVmtznZFEkdN0QrV4UJ9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qgLT3xyNLXibmFJKB6UXlipRu9ygmQF/USiGiUyvL0I=;
	b=ta1cW/bcI7wNc5KDDVbW6F5VGE9Rqh/HWf7RAE6AKOPlPHBzH5DpcFyVx5oQoSkSF1qn
	 vW9ozZ6bxqBgRyywl5NNr3xW9H0y2A5VODnXB/ZSzSN85ciDr2iBnf0EpJPXfQ0Bt1brY
	 UiBBhWXpIfKphi0vm4MB+KZk8uBRHYCZ65YaJkPO3H+w56XXZ8q4vmlrRjxkppTXmC2xl
	 FQHeD6Vx12fvcga8143UJgopXxczmRI83ryf4HlVEsP1rvYV2S3R+gWhScDvtSeZ9P7sW
	 BP1Cue30IvqF4RgTRA3lWb4285cNaIPgngHgjoTbflnKyoI9kbP2wlf/6jwflCSfZdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665592;
	bh=qgLT3xyNLXibmFJKB6UXlipRu9ygmQF/USiGiUyvL0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ukno3d57mvoqoDleZ3WEtAvF2lrK+NkADkojBV4djCCwc3RsyF0pAvvHjFfFuE6EG
	 DQbt0rFuVBux+Y0zml8jYTpapxjSWcF6kI/xqCy+woKY6wcFiMND6Esc9Xxwv08JDE
	 B3fH5P0a0ScX0O43mjSzE9uLtjDR+/K7gJK/nkMi9f0ATSW8zFh7d4Vbt/V9pMQ9Xt
	 flbSeQzcl7VaAQSuxTHaXLjQVMurA5mJbmAE3n7ygdAOVx//mygGCI7ykvlNZ6mZFi
	 ZWTfHAB78A/kfNXlrjKJ7TLqSTPdEIZgolbZ9Q1WgQfDX+JTwiEP/m5MEdzFJ7q1fe
	 zaPJk/PlT8A4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF9B860BB2;
	Thu, 17 Sep 2026 17:19:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31D4C422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23860407D2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jBUaSgE8v6y for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 22B5E407C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665536;
 b=n25bmjh08DgmEXGNlnX58des15kIgWom7QKjqOCWC6+gm2tq62/8rL9YtLwQCv8N+ggb
 QBR9QJyHe0RqUU5zmPWETznkqnZRchY+us/2sCGYSBAN5b/gE2Yf5G8y4ncX0s3YNHy7a
 AE5rZOs2kAciAekeWqZhAT2V0Ocj7xk0cLfumDYT46bIY7RtEfZhWjGRs5RQgcJNKi6aP
 OUbssNrU9dt8x0XgDDfBjRvks/uRb2v1Nv2TXUR2+FVi8UTBczWgfE9Hq7eOIAXbygqt8
 WUH9CCcCnxyzk9PPieAVpJlEgTFr6sfFLNXpkpJ6FuUxbppv9YJcETRfyTebV9YZArw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665536;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qgLT3xyNLXibmFJKB6UXlipRu9ygmQF/USiGiUyvL0I=;
 b=bPkY7xHTkIIrPY0yDhrCKz8kj/63cZc0Ej6kh6icn+HhbKHbjvlducChXvtKndiNQCXF
 D1EfnGVihNJ6MWGKcWyHQL55wHzx4qzv+RzbF6KMmnt3rBTcs24CmnO8HhD0e8eHMPHU3
 epycBSSZKPFgvtv2bRZ/GnWhjSeUnzCjJSEXDutFzL0qDUnx3x+A9eB5KR7VpfHhhLU27
 9jH/VDg+ds9Z/psQg9RuywTGqclHSXKAL0GWDRg5FU1EYUfe9BcN3JpNR7msPa6MDIlil
 W+EdVr/b0DOEUUeTobNv+JLwcdWAfkpbldJGN0nEhjxuQuNRfmb6oIjQ7+leUNXFg8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=bT9PE5yN; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=bT9PE5yN
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22B5E407C8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE94F1F02;
 Thu, 17 Sep 2026 10:18:51 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993DA3F7B4;
 Thu, 17 Sep 2026 10:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665535; bh=R+XmUIuW5fd72tcEkHdecwtzb6PIVk6iY0MhR24CNYs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bT9PE5yNeVJR/oIZim0ejpuDNW/Cowa9DVS+zsevFu9Al73XwK0yG5rw6pWI0mIe9
 GdDJmN9notMTI4vtzUsNlA62tlrP5drFnMxFw6cF91qq9R9w16J4vgcetMTeAVVcGq
 Aq5m3fmhEf45974KmL66nEOnPpvKeUbS+fKRUgHc=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>
Subject: [PATCH v6 11/24] fwu_arm_psa: Add staging ABIs
Date: Thu, 17 Sep 2026 18:17:57 +0100
Message-ID: <20260917171810.4122899-12-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Implement the ABIs and logic for updating images

The staging process defined by the Platform Security Firmware
Update for the A-profile Arm Architecture specification [1] is
executed through the staging ABIs.

The capsule should contain at least 3 payloads (2 dummy payloads
to indicate the start and the end of the staging process.
In addition, one or multiple payloads to write in the storage device).

The implemented ABIs are as follows:

FWU_BEGIN_STAGING
FWU_END_STAGING
FWU_CANCEL_STAGING
FWU_WRITE_STREAM

[1]: DEN0118, 1.0 A:
    https://developer.arm.com/documentation/den0118/latest/

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: David Hu <david.hu2@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
---
 include/efi_api.h            |   3 +
 include/efi_loader.h         |   3 +
 include/fwu_arm_psa.h        | 128 +++++++++++++
 lib/efi_loader/efi_capsule.c |  18 +-
 lib/efi_loader/fwu_arm_psa.c | 350 +++++++++++++++++++++++++++++++++++
 5 files changed, 500 insertions(+), 2 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index d4fdd50c49e..450bc69a847 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -25,6 +25,9 @@
  */
 #define EFI_SPECIFICATION_VERSION (2 << 16 | 110)
 
+#define EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER_VERSION 0x00000001
+#define EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER_VERSION 0x00000003
+
 /* Types and defines for EFI CreateEvent */
 enum efi_timer_delay {
 	EFI_TIMER_STOP = 0,
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..96c84dfb1d0 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -398,6 +398,9 @@ extern const efi_guid_t smbios3_guid;
 extern const efi_guid_t efi_guid_text_input_protocol;
 extern const efi_guid_t efi_guid_text_output_protocol;
 
+/*The current processed capsule */
+extern struct efi_capsule_header *g_capsule_data;
+
 /**
  * struct efi_open_protocol_info_item - open protocol info item
  *
diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index 5a22de84d25..5b82a7b0fb2 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -46,6 +46,21 @@
 /* One image directory entry */
 #define FWU_IMAGE_DIRECTORY_INFO_SIZE sizeof(struct fwu_image_info_entry)
 
+/*
+ * GUIDs for dummy payloads
+ *
+ * The GUIDs are generated with the UUIDv5 format.
+ * Namespace: 7b5c472e-5671-4fb7-a824-36a8e86f05c1
+ * Names: DUMMY_START, DUMMY_END
+ */
+#define FWU_DUMMY_START_IMAGE_GUID \
+	EFI_GUID(0x6f784cbf, 0x7938, 0x5c23, 0x8d, 0x6e, \
+		0x24, 0xd2, 0xf1, 0x41, 0x0f, 0xa9)
+
+#define FWU_DUMMY_END_IMAGE_GUID \
+	EFI_GUID(0xb57e432b, 0xa250, 0x5c73, 0x93, 0xe3, \
+		0x90, 0x20, 0x5e, 0x64, 0xba, 0xba)
+
 #define TS_RPC_MEM_RETRIEVE		(0xff0001)
 #define TS_RPC_SERVICE_INFO_GET		(0xff0003)
 #define RPC_SUCCESS			(0)
@@ -68,7 +83,11 @@
 
 enum fwu_abis {
 	FWU_DISCOVER = 0,
+	FWU_BEGIN_STAGING = 16,
+	FWU_END_STAGING = 17,
+	FWU_CANCEL_STAGING = 18,
 	FWU_OPEN = 19,
+	FWU_WRITE_STREAM = 20,
 	FWU_READ_STREAM = 21,
 	FWU_COMMIT = 22,
 	/* To be updated when adding new FWU IDs */
@@ -88,6 +107,14 @@ enum fwu_abi_errcode {
 	MAX_NUMBER_FWU_ERR
 };
 
+/* Enum to classify the possible type of payloads */
+enum fwu_payload_type {
+	FWU_PAYLOAD_TYPE_REAL = 1, /* Real payload */
+	FWU_PAYLOAD_TYPE_DUMMY_START, /* The start dummy payload */
+	FWU_PAYLOAD_TYPE_DUMMY_END, /* The end dummy payload */
+	FWU_PAYLOAD_TYPE_INVALID, /* Invalid image_index */
+};
+
 /* Container structure and helper macros to map between an FF-A error and relevant error log */
 struct fwu_abi_errmap {
 	char *err_str[MAX_NUMBER_FWU_ERR];
@@ -179,6 +206,63 @@ struct fwu_read_stream_resp {
 	u8  payload[];
 } __packed;
 
+/**
+ * struct fwu_begin_staging_args - fwu_begin_staging ABI arguments
+ * @function_id: fwu_begin_staging service ID
+ * @reserved: Reserved, must be zero
+ * @vendor_flags: Vendor specific staging flags
+ * @partial_update_count: The number of elements in the update_guid
+ * @update_guid: An array of image type GUIDs that the update Client will update
+ *               during the Staging state
+ */
+struct fwu_begin_staging_args {
+	u32 function_id;
+	u32 reserved;
+	u32 vendor_flags;
+	u32 partial_update_count;
+	efi_guid_t update_guid[];
+} __packed;
+
+/**
+ * struct fwu_begin_staging_resp - fwu_begin_staging ABI returns
+ * @status: The ABI return status
+ */
+struct fwu_begin_staging_resp {
+	int status;
+} __packed;
+
+/**
+ * struct fwu_end_staging_args - fwu_end_staging ABI arguments
+ * @function_id: fwu_end_staging service ID state
+ */
+struct fwu_end_staging_args {
+	u32 function_id;
+} __packed;
+
+/**
+ * struct fwu_end_staging_resp - fwu_end_staging ABI returns
+ * @status: The ABI return status
+ */
+struct fwu_end_staging_resp {
+	int status;
+} __packed;
+
+/**
+ * struct fwu_cancel_staging_args - fwu_cancel_staging ABI arguments
+ * @function_id: fwu_cancel_staging service ID state
+ */
+struct fwu_cancel_staging_args {
+	u32 function_id;
+} __packed;
+
+/**
+ * struct fwu_cancel_staging_resp - fwu_cancel_staging ABI returns
+ * @status: The ABI return status
+ */
+struct fwu_cancel_staging_resp {
+	int status;
+} __packed;
+
 /**
  * struct fwu_commit_args - fwu_commit ABI arguments
  * @function_id: fwu_commit service ID
@@ -210,6 +294,28 @@ struct fwu_commit_resp {
 	u32 total_work;
 } __packed;
 
+/**
+ * struct fwu_write_stream_args - fwu_write_stream ABI arguments
+ * @function_id: fwu_write_stream service ID
+ * @handle: The handle of the context being written to
+ * @data_len: Size of the data present in the payload
+ * @payload: The data to be transferred
+ */
+struct fwu_write_stream_args {
+	u32 function_id;
+	u32  handle;
+	u32 data_len;
+	u8 payload[];
+} __packed;
+
+/**
+ * struct fwu_write_stream_resp - fwu_write_stream ABI returns
+ * @status: The ABI return status
+ */
+struct fwu_write_stream_resp {
+	int status;
+} __packed;
+
 /*
  * FWU directory information structures
  */
@@ -245,4 +351,26 @@ struct __packed fwu_image_directory {
  */
 int fwu_agent_init(void);
 
+/**
+ * fwu_update_image() - Update an image
+ * @image: Pointer to the payload
+ * @image_index: Payload index
+ * @image_size: Payload size in bytes
+ *
+ * Perform staging with multiple payloads support.
+ *
+ * Return: 0 on success
+ */
+int fwu_update_image(const void *image, u8 image_index, u32 image_size);
+
+/**
+ * fwu_get_payload_type() - Identifies the payload type
+ * @image_index:	The payload index
+ *
+ * Identifies the FWU payload type based on the image index.
+ *
+ * Return: See @fwu_payload_type for details
+ */
+enum fwu_payload_type fwu_get_payload_type(u32 image_index);
+
 #endif
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 52887f7c274..ef2cb7fabe1 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -16,6 +16,7 @@
 #include <fdtdec.h>
 #include <fs.h>
 #include <fwu.h>
+#include <fwu_arm_psa.h>
 #include <hang.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -38,6 +39,8 @@ const efi_guid_t fwu_guid_os_request_fw_revert =
 const efi_guid_t fwu_guid_os_request_fw_accept =
 		FWU_OS_REQUEST_FW_ACCEPT_GUID;
 
+struct efi_capsule_header *g_capsule_data;
+
 #define FW_ACCEPT_OS	(u32)0x8000
 
 #ifdef CONFIG_EFI_CAPSULE_ON_DISK
@@ -194,6 +197,12 @@ efi_fmp_find(efi_guid_t *image_type, u8 image_index, u64 instance,
 			continue;
 		fmp = fmp_handler->protocol_interface;
 
+		if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+			if (fwu_get_payload_type(image_index) !=
+				FWU_PAYLOAD_TYPE_REAL)
+				return fmp;
+		}
+
 		/* get device's image info */
 		info_size = 0;
 		image_info = NULL;
@@ -585,7 +594,7 @@ static efi_status_t efi_capsule_update_firmware(
 	capsule_size = capsule_data->capsule_image_size
 			- capsule_data->header_size;
 
-	if (capsule->version != 0x00000001)
+	if (capsule->version != EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER_VERSION)
 		return EFI_UNSUPPORTED;
 
 	handles = NULL;
@@ -596,6 +605,10 @@ static efi_status_t efi_capsule_update_firmware(
 	if (ret != EFI_SUCCESS)
 		return EFI_UNSUPPORTED;
 
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+		g_capsule_data = capsule_data;
+	}
+
 	/* Payload */
 	for (item = capsule->embedded_driver_count;
 	     item < capsule->embedded_driver_count
@@ -610,7 +623,8 @@ static efi_status_t efi_capsule_update_firmware(
 
 		image = (void *)capsule + capsule->item_offset_list[item];
 
-		if (image->version != 0x00000003) {
+		if (image->version !=
+			EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER_VERSION) {
 			ret = EFI_UNSUPPORTED;
 			goto out;
 		}
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index 96511668328..91ad6ce5b21 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -26,6 +26,7 @@ static u8 g_fwu_version_major;
 static u8 g_fwu_version_minor;
 static bool g_fwu_initialized;
 static struct fwu_image_directory *g_fwu_cached_directory;
+efi_guid_t g_update_guid[CONFIG_FWU_NUM_IMAGES_PER_BANK];
 
 /* Error mapping declarations */
 
@@ -61,6 +62,18 @@ static struct fwu_abi_errmap err_msg_map[FWU_ERRMAP_COUNT] = {
 			"FWU_NO_PERMISSION: The image cannot be read from",
 		},
 	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_WRITE_STREAM)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: Unrecognized handle",
+			[FWU_DENIED] =
+			"FWU_DENIED: The system is not in a Staging state",
+			[FWU_NO_PERMISSION] =
+			"FWU_NO_PERMISSION: The image cannot be written to",
+			[FWU_OUT_OF_BOUNDS] =
+			"FWU_OUT_OF_BOUNDS: less than data_len bytes available in the image",
+		},
+	},
 	[FWU_ID_TO_ERRMAP_ID(FWU_COMMIT)] = {
 		{
 			[FWU_UNKNOWN] =
@@ -73,6 +86,34 @@ static struct fwu_abi_errmap err_msg_map[FWU_ERRMAP_COUNT] = {
 			"FWU_RESUME: The Update Agent yielded",
 		},
 	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_BEGIN_STAGING)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: One of more GUIDs in the update_guid field are unknown to the Update Agent",
+			[FWU_DENIED] =
+			"FWU_DENIED: The Firmware Store is in the Trial state or the platform did not boot correctly",
+			[FWU_BUSY] =
+			"FWU_BUSY: The Client is temporarily prevented from entering the Staging state",
+		},
+	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_END_STAGING)] = {
+		{
+			[FWU_BUSY] =
+			"FWU_BUSY: There are open image handles",
+			[FWU_DENIED] =
+			"FWU_DENIED: The system is not in a Staging state",
+			[FWU_AUTH_FAIL] =
+			"FWU_AUTH_FAIL: At least one of the updated images fails to authenticate",
+			[FWU_NOT_AVAILABLE] =
+			"FWU_NOT_AVAILABLE: The Update Agent does not support partial updates",
+		},
+	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_CANCEL_STAGING)] = {
+		{
+			[FWU_DENIED] =
+			"FWU_DENIED: The system is not in a Staging state",
+		},
+	},
 };
 
 /**
@@ -127,6 +168,104 @@ static int fwu_print_error_log(u32 fwu_id, int fwu_errno)
 	return 0;
 }
 
+/**
+ * fwu_get_payload_type() - Identifies the payload type
+ * @image_index:	The payload index
+ *
+ * Description: Identifies the FWU payload type based on the image index.
+ *
+ * Return: See @fwu_payload_type for details
+ */
+enum fwu_payload_type fwu_get_payload_type(u32 image_index)
+{
+	efi_guid_t *image_guid = NULL;
+	int i;
+	struct efi_fw_image *fw_array;
+
+	fw_array = update_info.images;
+	for (i = 0; i < update_info.num_images; i++) {
+		if (fw_array[i].image_index == image_index) {
+			image_guid = &fw_array[i].image_type_id;
+			break;
+		}
+	}
+
+	if (!image_guid)
+		return FWU_PAYLOAD_TYPE_INVALID;
+
+	if (!guidcmp(image_guid,
+		     &((efi_guid_t)FWU_DUMMY_START_IMAGE_GUID)))
+		return FWU_PAYLOAD_TYPE_DUMMY_START;
+
+	if (!guidcmp(image_guid,
+		     &((efi_guid_t)FWU_DUMMY_END_IMAGE_GUID)))
+		return FWU_PAYLOAD_TYPE_DUMMY_END;
+
+	return FWU_PAYLOAD_TYPE_REAL;
+}
+
+/**
+ * fwu_get_capsule_guids() - Get payload GUIDs from the capsule
+ *
+ * @partial_update_count:	A pointer to the number of payloads to update
+ * @saved_guids:	A pointer to an array for storing the payload GUIDs
+ *
+ * Description: Parse the current capsule and detect its payload GUIDs.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure.
+ */
+static efi_status_t fwu_get_capsule_guids(u32 *partial_update_count,
+					  efi_guid_t saved_guids[])
+{
+	struct efi_firmware_management_capsule_header *capsule;
+	struct efi_firmware_management_capsule_image_header *image;
+	int item;
+	size_t capsule_size;
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (!saved_guids || !partial_update_count)
+		return EFI_INVALID_PARAMETER;
+
+	*partial_update_count = 0;
+	capsule = (void *)g_capsule_data + g_capsule_data->header_size;
+	capsule_size = g_capsule_data->capsule_image_size
+		- g_capsule_data->header_size;
+
+	/* Payload */
+	for (item = capsule->embedded_driver_count;
+	     item < capsule->embedded_driver_count
+		     + capsule->payload_item_count; item++) {
+		/* sanity check */
+		if ((capsule->item_offset_list[item] + sizeof(*image)
+				>= capsule_size)) {
+			ret = EFI_INVALID_PARAMETER;
+			log_err("FWU: Insufficient data, err (0x%lx)\n", ret);
+			break;
+		}
+
+		image = (void *)capsule + capsule->item_offset_list[item];
+
+		if (image->version !=
+			EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER_VERSION) {
+			ret = EFI_UNSUPPORTED;
+			log_err("FWU: Version check failed, err (0x%lx)\n",
+				ret);
+			break;
+		}
+
+		if (fwu_get_payload_type(image->update_image_index) !=
+					 FWU_PAYLOAD_TYPE_REAL)
+			continue;
+
+		guidcpy(&saved_guids[*partial_update_count],
+			&image->update_image_type_id);
+
+		(*partial_update_count)++;
+	}
+
+	return ret;
+}
+
 /**
  * fwu_invoke_svc() - FWU service call request
  * @svc_id: FWU ABI function ID
@@ -392,6 +531,86 @@ fail:
 	return ret;
 }
 
+/**
+ * fwu_begin_staging() -  fwu_begin_staging ABI
+ *
+ * Description: This call indicates to the Update Agent that a new staging
+ *  process will commence.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_begin_staging(void)
+{
+	struct fwu_begin_staging_args *args = g_fwu_buf;
+	struct fwu_begin_staging_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_BEGIN_STAGING";
+	efi_status_t ret;
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_BEGIN_STAGING;
+
+	args->reserved = 0;
+	args->vendor_flags = 0;
+
+	ret = fwu_get_capsule_guids(&args->partial_update_count,
+				    args->update_guid);
+	if (ret) {
+		log_err("FWU: Failure to get the payload GUIDs\n");
+		return -ENODATA;
+	}
+
+	log_info("FWU: Updating %d payload(s)\n", args->partial_update_count);
+
+	/* Executing the FWU ABI through the FF-A bus */
+	return fwu_invoke_svc(args->function_id, svc_name,
+			      sizeof(*args), sizeof(*resp), NULL);
+}
+
+/**
+ * fwu_end_staging() -  fwu_end_staging ABI
+ *
+ * Description: The Client informs the Update Agent that all the images, meant
+ * to be updated, have been transferred to the Update Agent and that the staging
+ * has terminated.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_end_staging(void)
+{
+	struct fwu_end_staging_args *args = g_fwu_buf;
+	struct fwu_end_staging_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_END_STAGING";
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_END_STAGING;
+
+	/* Executing the FWU ABI through the FF-A bus */
+	return fwu_invoke_svc(args->function_id, svc_name,
+			      sizeof(*args), sizeof(*resp), NULL);
+}
+
+/**
+ * fwu_cancel_staging() -  fwu_cancel_staging ABI
+ *
+ * Description: The Client cancels the staging procedure and the system
+ * transitions back to the Regular state.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_cancel_staging(void)
+{
+	struct fwu_cancel_staging_args *args = g_fwu_buf;
+	struct fwu_cancel_staging_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_CANCEL_STAGING";
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_CANCEL_STAGING;
+
+	/* Executing the FWU ABI through the FF-A bus */
+	return fwu_invoke_svc(args->function_id, svc_name,
+			      sizeof(*args), sizeof(*resp), NULL);
+}
+
 /**
  * fwu_commit() -  fwu_commit ABI
  * @handle: The handle of the context being closed
@@ -434,6 +653,137 @@ static int fwu_commit(u32 handle, u32 acceptance_req, u32 max_atomic_len)
 	return 0;
 }
 
+/**
+ * fwu_write_stream() -  fwu_write_stream ABI
+ * @handle: The handle of the context being written to
+ * @payload: The data to be transferred
+ * @payload_size: Size of the data present in the payload
+ *
+ *  Description: The call writes at most max_payload_size bytes to the Update
+ *  Agent context pointed to by handle.
+ *
+ * Return: 0 on success. Otherwise, failure
+ */
+static int fwu_write_stream(u32 handle, const u8 *payload, u32 payload_size)
+{
+	int ret;
+	u32 write_size, max_write_size, curr_write_offset = 0;
+	u32 payload_bytes_left = payload_size, fwu_buf_bytes_left;
+	struct fwu_write_stream_args *args = g_fwu_buf;
+	struct fwu_write_stream_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_WRITE_STREAM";
+
+	if (!payload || !payload_size)
+		return -EINVAL;
+
+	fwu_buf_bytes_left = FWU_BUFFER_SIZE - sizeof(*args);
+
+	if (g_max_payload_size <= fwu_buf_bytes_left)
+		max_write_size = g_max_payload_size;
+	else
+		max_write_size = fwu_buf_bytes_left;
+
+	while (curr_write_offset < payload_size) {
+		if (payload_bytes_left <= max_write_size)
+			write_size = payload_bytes_left;
+		else
+			write_size = max_write_size;
+
+		/* Filling the arguments in the shared buffer */
+		args->function_id = FWU_WRITE_STREAM;
+		args->handle = handle;
+		args->data_len = write_size;
+		memcpy(args->payload, payload + curr_write_offset, write_size);
+
+		/* Executing the FWU ABI through the FF-A bus */
+		ret = fwu_invoke_svc(args->function_id, svc_name, sizeof(*args),
+				     sizeof(*resp), NULL);
+		if (ret)
+			return ret;
+
+		curr_write_offset += write_size;
+		payload_bytes_left -= write_size;
+
+		log_debug("%s:  %d bytes written, remaining %d bytes\n",
+			  svc_name, write_size, payload_bytes_left);
+	}
+
+	return ret;
+}
+
+/**
+ * fwu_update_image() - Update an image
+ *
+ * @image: Pointer to the payload to write
+ * @image_index: The payload index
+ * @image_size: The payload size
+ *
+ * Description: Perform staging with multiple payloads support.
+ * The capsule is expected to:
+ *     - Start with a dummy payload to mark the start of the payloads sequence
+ *     - One or more payloads to be written to the storage device
+ *     - End with a dummy payload to mark the end of the payloads sequence
+ *
+ * The possible payloads in the capsule are described in the board file
+ * through struct efi_fw_image. This includes the dummy payloads.
+ * The dummy payloads image indexes must be >= CONFIG_FWU_NUM_IMAGES_PER_BANK
+ * The dummy payloads are not sent to the Secure world and are not written to
+ * the storage device.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+int fwu_update_image(const void *image, u8 image_index, u32 image_size)
+{
+	int ret;
+	u32 handle;
+
+	if (!image)
+		return -EINVAL;
+
+	/* Only image indexes starting from 1 are supported */
+	if (!image_index || image_index > update_info.num_images)
+		return -EINVAL;
+
+	if (fwu_get_payload_type(image_index) ==
+		FWU_PAYLOAD_TYPE_DUMMY_START) {
+		return fwu_begin_staging();
+	}
+
+	if (fwu_get_payload_type(image_index) ==
+		FWU_PAYLOAD_TYPE_DUMMY_END) {
+		ret = fwu_end_staging();
+		if (ret)
+			goto cancel_staging;
+		return 0;
+	}
+
+	ret = fwu_open(&g_fwu_cached_directory->entries[image_index - 1].img_type_guid,
+		       FWU_OP_TYPE_WRITE, &handle);
+	if (ret)
+		goto cancel_staging;
+
+	ret = fwu_write_stream(handle, image, image_size);
+	if (ret)
+		goto cancel_staging;
+
+	/*
+	 * The Update Agent can execute for an unbounded time.
+	 * The image should be tried before being accepted.
+	 * So, we put the acceptance request as 'not accepted'.
+	 */
+	ret = fwu_commit(handle, FWU_IMG_NOT_ACCEPTED, 0);
+	if (ret)
+		goto cancel_staging;
+
+	log_debug("FWU: Image at index %d updated\n", image_index);
+
+	return 0;
+
+cancel_staging:
+
+	return fwu_cancel_staging();
+}
+
 /**
  * fwu_read_directory() - Read FWU directory information
  *
-- 
2.43.0

