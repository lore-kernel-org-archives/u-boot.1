Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F11CC982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4353B60BC3;
	Thu, 17 Sep 2026 17:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FA_j18McSKXY; Thu, 17 Sep 2026 17:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2AB4D60BAE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665590;
	b=gvrmq6DWALBcNWQGIdccP6SdchrmsBpsUtJN4yH5wiI/zjInluxNDuiuqL7XHCLuXuwS
	 sNQdgQIbamcWicfTnAPrthIaOe1NC/VNhXwiePXZjN9xWElzpOxErH4Nab3PU+tnuTq0r
	 6fLkwCC59xwmye6LhhMXthmQzVxA7MiybTYlsldxFti4i5xwQiOrG9c+8HlwZsbwR/CQX
	 QW4d0MkbQcu/MZjTnLMsMMEt1h+HurGc3Rl9g5AsSSqlyWq4Ps65hx1WoDVVz+Xn25D7F
	 4QHP31rycHHKv1gxWOrOujz0j66V4Z0AlNl9+u1A7FFZXhaaEmFJ5JO03XvuSfROJUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gmZgp7Gkk4Ix/FNskMu8B9hyZhyHNlIuHpsCYIAUqZY=;
	b=qoA/jiNYYMrrn2oM7swhkb2dKEHk5knjEBms4+P7PyFXt8wgZjwegynLpjHEOdramBqF
	 g2C/Zmhf/vZ4hiM0dhXMlNGrwRFMUOdE/WNSAmC8VHluNYtQRTccJvE+J/BN6ZpeUCGkV
	 ndfcdtE2sdCupwg4OVDseLeG6QpywghzSY4RufcC0XVpLQAOlhGFXFUjbKkNdgQl2p2SL
	 CqvPceCbW1jkNU/lBGpcjBWxUtmk1/j9JWuh1q7x2m6zR6OXi45JcgpfvWeuFK3gJSuAs
	 529oZEoFXL/mxpjHg+GdHFyVvsS3BqsBowQGGlXgS5Pku9/TJnL5nSnjds/BxSDkhCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kjbZWHJV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665590;
	bh=gmZgp7Gkk4Ix/FNskMu8B9hyZhyHNlIuHpsCYIAUqZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w13iTu5LmYhl8RN2jaWOwVTRRE7dgalVSZPH6QD1lQax2B8Eh0f+y4QhNjDbWNg0q
	 BeDkQoQM09fhqKgshxma1v+M9N5hkM5/DzYIoUTbNGpdURPMBPvIEiIgm6vYrLLCRN
	 RJEVTEqiKwEAJq4wY1hyg2V5mQ2CSWzpz8vVIkWCPNX5TtqeILukT+e4oCOOL6pR7b
	 PuFkGSZGzSEv0kUD/mvmShuXx101bITyVwV7BmWZrSTVvuNogjfXH/fi1Fd1DadKej
	 cOt1EtbQhkH+z8a/YEOzlDYpaOCKIzZ1/yLX8RYahHudIG/GQm0VSSMizfimo4Z+0I
	 JdySKi6lzZsdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AB4D60BAE;
	Thu, 17 Sep 2026 17:19:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 240B037A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A31660B6A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g5JXCbMrdnzT for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 102F26084D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665534;
 b=jYlAKEW3J8///3GEqItopoSFqr/WYprkTkn0BXgWGTKh8CF39ooNRfJCHDvvVUG5Wc4e
 xfB2JkQT/yv3ly+BPh4muu9eFq9C082LvdQ1LY4+0mDU2+iSC+MKQL3piVhVAZ9ESWnKv
 ZDQQOOjpy19x8u9jF2klY9gKRLoJwWYPsgKeXKIRVZQY/CDPDql+60r/QsqmNnL0PewBm
 yHexxI3218ulCcQBzyX5A1aXacuGe7VNpxzf4ragKSYWvWV2b5db7HSlM27HcqRDc8ZH4
 Y82YUtQAribBZ9XfOdtZ1Glz0wmHjej5iPAdfyfE7zsxYB9ZDfTbU7K5bkucXH1FEsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665534;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=gmZgp7Gkk4Ix/FNskMu8B9hyZhyHNlIuHpsCYIAUqZY=;
 b=UtlumI84prETn1AWdTuSG50wAdf/oWxgEWltpba/6QpENi0edH7LnRWWYiBPl4tN7Los
 jFGAONtBnyW72INAukqAr2aUF/L4hAi1c4tGQi6Z1fZOGUjAYD6K8lXh7GuuDn9HWuJim
 4cgCdcbZelQgwG+aVrdMq/AtQIYQM0rAy60GAfsrFj8ZaiMUfy0f01el846UlWeA/n16N
 d/hqiYZObJF4D+GaI3Alhp4o5xaMknCg1Gf8VIjaQtDPjg9MFH0DvADmFwWriZUPjdMIO
 5Uq0pF+LbnuCxvlORbH0fUEQ7ds6/I++FGjAjjUMHlwq0yVs7jorLIcthlk9H8ACD9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=kjbZWHJV; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=kjbZWHJV
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 102F26084D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B045C1596;
 Thu, 17 Sep 2026 10:18:49 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F0A03F7B4;
 Thu, 17 Sep 2026 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665533; bh=06z87kkElLp+GKYMx/06CzKg4MLLXrJqx76sJIl4fZ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kjbZWHJVCfEiaPlM9WAIwa8Gtw+iqdqikuty3KSLnQVJxjGnZUqn48LFOSf54jIdl
 Dk5brK4Bt2aFpSgGQPArd5gsmL8VWhLZp/QhUg1r7AyDmXSvi+4PZ5+cUxIoSueDt9
 UYzxSGkO8XftlOTnKFqWn0VSWRO3QNCTsScuu+9o=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 10/24] fwu_arm_psa: Read the FWU directory through
 get_image_info()
Date: Thu, 17 Sep 2026 18:17:56 +0100
Message-ID: <20260917171810.4122899-11-harsimransingh.tungal@arm.com>
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

Implement efi_fill_image_desc_array()

Arm PSA implementation of efi_fill_image_desc_array() reads
the images information from the cached directory in Secure
world then populates the images descriptors.

The FWU Arm PSA setup ABIs have been implemented to allow
reading the directory data.

The ABIs are specified by the Platform Security Firmware Update for
the A-profile Arm Architecture specification [1].

For more details about PSA please see [2].

The implemented ABIs are as follows:

FWU_DISCOVER
FWU_OPEN
FWU_READ_STREAM
FWU_COMMIT

[1]: DEN0118, 1.0 A:
    https://developer.arm.com/documentation/den0118/latest/
[2]: https://www.psacertified.org/

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: David Hu <david.hu2@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 include/fwu_arm_psa.h        | 194 +++++++++++
 lib/efi_loader/Kconfig       |   7 +
 lib/efi_loader/fwu_arm_psa.c | 635 ++++++++++++++++++++++++++++++++++-
 3 files changed, 835 insertions(+), 1 deletion(-)

diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index a5881a0d400..5a22de84d25 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -6,14 +6,22 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  *   Davidson kumaresan <davidson.kumaresan@arm.com>
  *   Alex Chapman <alex.chapman@arm.com>
+ *   David Hu <david.hu2@arm.com>
  */
 
 #ifndef __FWU_ARM_PSA_H
 #define __FWU_ARM_PSA_H
 
+#include <efi_loader.h>
 #include <linux/bitfield.h>
 #include <u-boot/uuid.h>
 
+#define DEFAULT_HW_INSTANCE		(1)
+
+/* Default values of the ESRT fields which are not supported at this stage */
+#define PACKAGE_VERSION_NOT_SUP		(0xffffffff)
+#define LAST_ATTEMPT_NOT_SUP		(0)
+
 /* 4 MB buffer shared with secure world */
 #define FWU_BUFFER_SIZE			(CONFIG_FWU_BUFFER_PAGES * EFI_PAGE_SIZE)
 
@@ -25,6 +33,19 @@
 #define TS_FWU_SERVICE_UUID		"38a82368-061b-0e47-7497-fd53fb8bce0c"
 /* In little-endian equivalent to:  6823a838-1b06-470e-9774-0cce8bfb53fd */
 
+/* TS FWU directory UUID string (in big-endian format) */
+#define FWU_DIRECTORY_CANONICAL_GUID	EFI_GUID(0xd958eede, 0x4751, 0xd34a, 0xa2, 0x90, 0x77, 0x66, 0x6e, 0x23, 0x41, 0xa5)
+/* In big-endian equivalent to:  d958eede-4751-d34a-90a2-a541236e6677 */
+
+/* The entries correspond to the payloads in the storage device and the fake ESRT image */
+#define FWU_DIRECTORY_IMAGE_ENTRIES_COUNT (CONFIG_FWU_NUM_IMAGES_PER_BANK + 1)
+
+/* Image directory excluding all entries */
+#define FWU_IMAGE_DIRECTORY_HDR_SIZE offsetof(struct fwu_image_directory, entries)
+
+/* One image directory entry */
+#define FWU_IMAGE_DIRECTORY_INFO_SIZE sizeof(struct fwu_image_info_entry)
+
 #define TS_RPC_MEM_RETRIEVE		(0xff0001)
 #define TS_RPC_SERVICE_INFO_GET		(0xff0003)
 #define RPC_SUCCESS			(0)
@@ -33,6 +54,11 @@
 #define GET_SVC_IFACE_ID(x)		\
 			 ((u8)(FIELD_GET(SVC_IFACE_ID_GET_MASK, (x))))
 
+#define SVC_ID_MASK			GENMASK(15, 0)
+#define SVC_IFACE_ID_SET_MASK		GENMASK(23, 16)
+#define PACK_SVC_IFACE_ID(svc, iface)	(FIELD_PREP(SVC_ID_MASK, (svc)) | \
+					FIELD_PREP(SVC_IFACE_ID_SET_MASK, (iface)))
+
 #define HANDLE_MSW_MASK			GENMASK(63, 32)
 #define HANDLE_LSW_MASK			GENMASK(31, 0)
 #define GET_FWU_BUF_MSW(x)		\
@@ -40,6 +66,174 @@
 #define GET_FWU_BUF_LSW(x)		\
 				((u32)(FIELD_GET(HANDLE_LSW_MASK, (x))))
 
+enum fwu_abis {
+	FWU_DISCOVER = 0,
+	FWU_OPEN = 19,
+	FWU_READ_STREAM = 21,
+	FWU_COMMIT = 22,
+	/* To be updated when adding new FWU IDs */
+	FWU_FIRST_ID = FWU_DISCOVER, /* Lowest number ID */
+	FWU_LAST_ID = FWU_COMMIT, /* Highest number ID */
+};
+
+enum fwu_abi_errcode {
+	FWU_UNKNOWN = 1,
+	FWU_BUSY,
+	FWU_OUT_OF_BOUNDS,
+	FWU_AUTH_FAIL,
+	FWU_NO_PERMISSION,
+	FWU_DENIED,
+	FWU_RESUME,
+	FWU_NOT_AVAILABLE,
+	MAX_NUMBER_FWU_ERR
+};
+
+/* Container structure and helper macros to map between an FF-A error and relevant error log */
+struct fwu_abi_errmap {
+	char *err_str[MAX_NUMBER_FWU_ERR];
+};
+
+#define FWU_ERRMAP_COUNT (FWU_LAST_ID - FWU_FIRST_ID + 1)
+#define FWU_ID_TO_ERRMAP_ID(fwu_id) ((fwu_id) - FWU_FIRST_ID)
+
+/**
+ * struct fwu_open_args - fwu_open ABI arguments
+ * @function_id: fwu_open service ID
+ * @image_type_guid: GUID of the image to be opened
+ * @op_type: The operation that the Client will perform on the image
+ */
+struct fwu_open_args {
+	u32 function_id;
+	efi_guid_t image_type_guid;
+#define FWU_OP_TYPE_READ 0
+#define FWU_OP_TYPE_WRITE 1
+	u8  op_type;
+} __packed;
+
+/**
+ * struct fwu_open_resp - fwu_open ABI returns
+ * @status: The ABI return status
+ * @handle: Staging context identifier
+ */
+struct fwu_open_resp {
+	int status;
+	u32  handle;
+} __packed;
+
+/**
+ * struct fwu_discover_args - fwu_discover ABI arguments
+ * @function_id: fwu_discover service ID
+ */
+struct fwu_discover_args {
+	u32 function_id;
+} __packed;
+
+/**
+ * struct fwu_discover_resp - fwu_discover ABI returns
+ * @status: The ABI return status
+ * @service_status: the status of the service provider
+ * @version_major: the ABI major version
+ * @version_minor: the ABI minor version
+ * @off_function_presence: the offset (in bytes) of the function_presence array
+ *                         relative to the start of this data structure
+ * @num_func: the number of entries in the function_presence array
+ * @max_payload_size: the maximum number of bytes that a payload can contain
+ * @flags: flags listing the update capabilities
+ * @vendor_specific_flags: Vendor specific update capabilities flags
+ * @function_presence: array of bytes indicating functions that are implemented
+ */
+struct fwu_discover_resp {
+	int status;
+	u16 service_status;
+	u8 version_major;
+	u8 version_minor;
+	u16 off_function_presence;
+	u16 num_func;
+	u64 max_payload_size;
+	u32 flags;
+	u32 vendor_specific_flags;
+	void *function_presence;
+} __packed;
+
+/**
+ * struct fwu_read_stream_args - fwu_read_stream ABI arguments
+ * @function_id: fwu_read_stream service ID
+ * @handle: The handle of the context being read from
+ */
+struct fwu_read_stream_args {
+	u32 function_id;
+	u32  handle;
+} __packed;
+
+/**
+ * struct fwu_read_stream_resp - fwu_read_stream ABI returns
+ * @status: The ABI return status
+ * @read_bytes: Number of bytes read by the current ABI call
+ * @total_bytes: Total number of bytes that can be read
+ * @payload: The read data by the current ABI call
+ */
+struct fwu_read_stream_resp {
+	int status;
+	u32  read_bytes;
+	u32  total_bytes;
+	u8  payload[];
+} __packed;
+
+/**
+ * struct fwu_commit_args - fwu_commit ABI arguments
+ * @function_id: fwu_commit service ID
+ * @handle: The handle of the context being closed
+ * @acceptance_req: If positive, the Client requests the image to be marked as
+ *                  unaccepted
+ * @max_atomic_len: Hint, maximum time (in ns) that the Update Agent can execute
+ *                  continuously without yielding back to the Client state
+ */
+struct fwu_commit_args {
+	u32 function_id;
+	u32 handle;
+#define FWU_IMG_ACCEPTED 0
+#define FWU_IMG_NOT_ACCEPTED 1
+	u32 acceptance_req;
+	u32 max_atomic_len;
+} __packed;
+
+/**
+ * struct fwu_commit_resp - fwu_commit ABI returns
+ * @status: The ABI return status
+ * @progress: Units of work already completed by the Update Agent
+ * @total_work: Units of work the Update Agent must perform until fwu_commit
+ *              returns successfully
+ */
+struct fwu_commit_resp {
+	int status;
+	u32 progress;
+	u32 total_work;
+} __packed;
+
+/*
+ * FWU directory information structures
+ */
+
+struct __packed fwu_image_info_entry {
+	efi_guid_t img_type_guid;
+	u32 client_permissions;
+	u32 img_max_size;
+	u32 lowest_acceptable_version;
+	u32 img_version;
+	u32 accepted;
+	u32 reserved;
+};
+
+struct __packed fwu_image_directory {
+	u32 directory_version;
+	u32 img_info_offset;
+	u32 num_images;
+	u32 correct_boot;
+	u32 img_info_size;
+	u32 reserved;
+	struct fwu_image_info_entry entries[];
+};
+
 /**
  * fwu_agent_init() - Setup the FWU agent
  * Perform the initializations required to communicate
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 998f2fb547e..483d2c6dc18 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -380,6 +380,13 @@ config FWU_ARM_PSA
 	  driver that supports the Arm PSA firmware update specification as
 	  mentioned in https://developer.arm.com/documentation/den0118/a/
 
+config FWU_NUM_IMAGES_PER_BANK
+	int "Number of firmware images per bank"
+	depends on FWU_ARM_PSA
+	help
+	  Define the number of firmware images per bank. This value
+	  should be the same for all the banks.
+
 config FWU_BUFFER_PAGES
 	int "Number of 4KB pages in the FWU shared buffer"
 	depends on FWU_ARM_PSA
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index 9355101a3a8..96511668328 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -6,11 +6,11 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  *   Davidson kumaresan <davidson.kumaresan@arm.com>
  *   Alex Chapman <alex.chapman@arm.com>
+ *   David Hu <david.hu2@arm.com>
  */
 #include <arm_ffa.h>
 #include <dm.h>
 #include <fwu_arm_psa.h>
-#include <efi_loader.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -21,7 +21,526 @@ static u64 g_fwu_buf_handle;
 static u16 g_fwu_sp_id;
 static struct udevice *g_dev;
 static u16 g_svc_interface_id;
+static u64 g_max_payload_size;
+static u8 g_fwu_version_major;
+static u8 g_fwu_version_minor;
 static bool g_fwu_initialized;
+static struct fwu_image_directory *g_fwu_cached_directory;
+
+/* Error mapping declarations */
+
+int fwu_to_std_errmap[MAX_NUMBER_FWU_ERR] = {
+	[FWU_UNKNOWN] = -EOPNOTSUPP,
+	[FWU_OUT_OF_BOUNDS] = -ERANGE,
+	[FWU_AUTH_FAIL] = -EFAULT,
+	[FWU_BUSY] = -EBUSY,
+	[FWU_NO_PERMISSION] = -EPERM,
+	[FWU_DENIED] = -EACCES,
+	[FWU_RESUME] = -EAGAIN,
+	[FWU_NOT_AVAILABLE] = -ENAVAIL,
+};
+
+static struct fwu_abi_errmap err_msg_map[FWU_ERRMAP_COUNT] = {
+	[FWU_ID_TO_ERRMAP_ID(FWU_OPEN)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: Image type with GUID=image_type_guid does not exist",
+			[FWU_DENIED] =
+			"FWU_DENIED: An image cannot be opened for writing outside of this Staging state",
+			[FWU_NOT_AVAILABLE] =
+			"FWU_NOT_AVAILABLE: The Update Agent does not support the op_type for this image",
+		},
+	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_READ_STREAM)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: Handle is not recognized",
+			[FWU_DENIED] =
+			"FWU_DENIED: The image cannot be temporarily read from",
+			[FWU_NO_PERMISSION] =
+			"FWU_NO_PERMISSION: The image cannot be read from",
+		},
+	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_COMMIT)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: Handle is not recognized",
+			[FWU_DENIED] =
+			"FWU_DENIED: The image can only be accepted after activation",
+			[FWU_AUTH_FAIL] =
+			"FWU_AUTH_FAIL: Image closed, authentication failed",
+			[FWU_RESUME] =
+			"FWU_RESUME: The Update Agent yielded",
+		},
+	},
+};
+
+/**
+ * fwu_to_std_errno() - convert FWU error code to standard error code
+ * @fwu_errno:	Error code returned by the FWU ABI
+ *
+ * Description: Map the given FWU error code as specified
+ * by the spec to a U-Boot standard error code.
+ *
+ * Return: The corresponding standard error code, or -EINVAL if @fwu_errno is
+ * invalid.
+ */
+static int fwu_to_std_errno(int fwu_errno)
+{
+	int err_idx = -fwu_errno;
+
+	/* Map the FWU error code to the standard u-boot error code */
+	if (err_idx > 0 && err_idx < MAX_NUMBER_FWU_ERR)
+		return fwu_to_std_errmap[err_idx];
+	return -EINVAL;
+}
+
+/**
+ * fwu_print_error_log() - print the error log of the selected FWU ABI
+ * @fwu_id:	FWU ABI ID
+ * @fwu_errno:	Error code returned by the FWU ABI
+ *
+ * Description: Map the FWU error code to the error log relevant to the
+ * selected FWU ABI. Then the error log is printed.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_print_error_log(u32 fwu_id, int fwu_errno)
+{
+	int err_idx = -fwu_errno, abi_idx = 0;
+
+	/* Map the FWU error code to the corresponding error log */
+
+	if (err_idx <= 0 || err_idx >= MAX_NUMBER_FWU_ERR)
+		return -EINVAL;
+
+	if (fwu_id < FWU_FIRST_ID || fwu_id > FWU_LAST_ID)
+		return -EINVAL;
+
+	abi_idx = FWU_ID_TO_ERRMAP_ID(fwu_id);
+
+	if (!err_msg_map[abi_idx].err_str[err_idx])
+		return -EINVAL;
+
+	log_err("%s\n", err_msg_map[abi_idx].err_str[err_idx]);
+
+	return 0;
+}
+
+/**
+ * fwu_invoke_svc() - FWU service call request
+ * @svc_id: FWU ABI function ID
+ * @svc_name: FWU ABI function name
+ * @req_args_sz: Size in bytes of the arguments of the FWU ABI function
+ * @expect_resp_sz: Size in bytes of the response of the FWU ABI function
+ * @extra_resp_bytes: Size in bytes of the extra response data
+ *
+ * Description: Invoke a FWU ABI by issuing a TS service call request.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_invoke_svc(u32 svc_id, const char *svc_name,
+			  u32 req_args_sz, u32 expect_resp_sz,
+			  u32 *extra_resp_bytes)
+{
+	struct ffa_send_direct_data msg;
+	int ret;
+	int *svc_status_in_buf = g_fwu_buf, svc_status_in_reg;
+	u32 expect_total_resp_sz;
+
+	log_debug("FWU: Invoking %s\n", svc_name);
+
+	if (!expect_resp_sz || !svc_name || !req_args_sz) {
+		log_err("%s: Invalid invoke arguments\n", svc_name);
+		return -EINVAL;
+	}
+
+	msg.data0 = PACK_SVC_IFACE_ID(svc_id, g_svc_interface_id);
+	msg.data1 = GET_FWU_BUF_LSW(g_fwu_buf_handle);
+	msg.data2 = GET_FWU_BUF_MSW(g_fwu_buf_handle);
+	msg.data3 = req_args_sz;
+	msg.data4 = 0;
+
+	ret = ffa_sync_send_receive(g_dev, g_fwu_sp_id, &msg, 0);
+	if (ret) {
+		log_err("%s: FF-A error %d\n", svc_name, ret);
+		return ret;
+	}
+
+	if (msg.data0 != PACK_SVC_IFACE_ID(svc_id, g_svc_interface_id)) {
+		log_err("%s: Unexpected service/interface ID 0x%lx\n",
+			svc_name, msg.data0);
+		return -EINVAL;
+	}
+
+	if (msg.data1 != RPC_SUCCESS) {
+		log_err("%s: TS RPC error 0x%lx\n", svc_name, msg.data1);
+		return -ECOMM;
+	}
+
+	svc_status_in_reg = (int)msg.data2;
+	if (*svc_status_in_buf != svc_status_in_reg) {
+		log_err("%s: Status mismatch (reg %d , buf %d)\n",
+			svc_name, svc_status_in_reg, *svc_status_in_buf);
+		return -EINVAL;
+	}
+
+	if (svc_status_in_reg < 0) {
+		fwu_print_error_log(svc_id, svc_status_in_reg);
+		if (svc_status_in_reg != -FWU_RESUME)
+			return fwu_to_std_errno(svc_status_in_reg);
+	}
+
+	if (!extra_resp_bytes)
+		expect_total_resp_sz = expect_resp_sz;
+	else
+		expect_total_resp_sz = expect_resp_sz + *extra_resp_bytes;
+
+	if (msg.data3 != expect_total_resp_sz) {
+		log_err("%s: Unexpected response size (%ld , %d)\n",
+			svc_name, msg.data3, expect_total_resp_sz);
+		return -EINVAL;
+	}
+
+	if (svc_status_in_reg == -FWU_RESUME)
+		return fwu_to_std_errno(svc_status_in_reg);
+
+	return 0;
+}
+
+/**
+ * fwu_discover() -  fwu_discover ABI
+ *
+ * Description: This call indicates the version of the ABI alongside a list of
+ * the implemented functions (aka services).
+ * Only max_payload_size is saved for future use.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_discover(void)
+{
+	int ret;
+	struct fwu_discover_args *args = g_fwu_buf;
+	struct fwu_discover_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_DISCOVER";
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_DISCOVER;
+
+	/* Executing the FWU ABI through the FF-A bus */
+	ret = fwu_invoke_svc(args->function_id, svc_name, sizeof(*args),
+			     sizeof(int), NULL);
+	if (ret) {
+		log_debug("FWU_DISCOVER: error %d\n", ret);
+		return ret;
+	}
+
+	g_max_payload_size = resp->max_payload_size;
+	g_fwu_version_major = resp->version_major;
+	g_fwu_version_minor = resp->version_minor;
+
+	log_debug("FWU: max_payload_size %llu\n", g_max_payload_size);
+	log_info("FWU: ABI version %d.%d detected\n", g_fwu_version_major,
+		 g_fwu_version_minor);
+
+	return 0;
+}
+
+/**
+ * fwu_open() -  fwu_open ABI
+ * @guid: GUID of the image to be opened
+ * @op_type: The operation that the Client will perform on the image
+ * @handle: Staging context identifier
+ *
+ * Description: Returns a handle to the image with a given GUID.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_open(const efi_guid_t *guid, u8  op_type,
+		    u32 *handle)
+{
+	int ret;
+	struct fwu_open_args *args = g_fwu_buf;
+	struct fwu_open_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_OPEN";
+
+	if (!guid || !handle)
+		return -EINVAL;
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_OPEN;
+
+	guidcpy(&args->image_type_guid, guid);
+	args->op_type = op_type;
+
+	/* Executing the FWU ABI through the FF-A bus */
+	ret = fwu_invoke_svc(args->function_id, svc_name,
+			     sizeof(*args), sizeof(*resp), NULL);
+	if (ret)
+		return ret;
+
+	*handle = resp->handle;
+
+	return 0;
+}
+
+/**
+ * fwu_read_stream() - Read a stream into an allocated buffer
+ * @handle: The handle of the context being read from
+ * @buffer: The destination buffer allocated to hold the stream contents
+ * @buffer_size: The size of the allocated destination buffer
+ *
+ * Description: Read the complete Update Agent context stream pointed to by
+ * handle. The destination buffer is allocated from the stream's reported total
+ * size and must be empty on entry. The caller owns the returned buffer.
+ *
+ * Note: Either buffer and buffer_size should point to NULL and 0 respectively
+ * or non-NULL and non-0.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_read_stream(u32 handle, void **buffer, u32 *buffer_size)
+{
+	int ret;
+	u32 curr_read_offset = 0, new_read_offset, fwu_buf_bytes_left;
+	struct fwu_read_stream_args *args = g_fwu_buf;
+	struct fwu_read_stream_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_READ_STREAM";
+	bool allocated = false;
+
+	if ((*buffer == NULL && *buffer_size != 0) ||
+		(*buffer != NULL && *buffer_size == 0)) {
+		return -EINVAL;
+	}
+
+	do {
+		/* Filling the arguments in the shared buffer */
+		args->function_id = FWU_READ_STREAM;
+		args->handle = handle;
+
+		/* Executing the FWU ABI through the FF-A bus */
+		ret = fwu_invoke_svc(args->function_id, svc_name, sizeof(*args),
+				     sizeof(*resp), &resp->read_bytes);
+		if (ret)
+			goto fail;
+
+		if (!*buffer_size) {
+			if (!resp->total_bytes)
+				return -EINVAL;
+
+			*buffer = calloc(1, resp->total_bytes);
+			if (!*buffer)
+				return -ENOMEM;
+
+			*buffer_size = resp->total_bytes;
+			allocated = true;
+		}
+
+		if (resp->read_bytes > g_max_payload_size) {
+			log_err("%s: Bytes read > max_payload_size (%d , %llu)\n",
+				svc_name, resp->read_bytes,
+				g_max_payload_size);
+			goto invalid;
+		}
+
+		fwu_buf_bytes_left = FWU_BUFFER_SIZE - sizeof(*resp);
+
+		if (resp->read_bytes > fwu_buf_bytes_left) {
+			log_err("%s: Bytes read > shared buffer (%d , %d)\n",
+				svc_name, resp->read_bytes, fwu_buf_bytes_left);
+			goto invalid;
+		}
+
+		if (resp->total_bytes > *buffer_size) {
+			log_err("%s: Total bytes > dest buffer (%d , %d)\n",
+				svc_name, resp->total_bytes, *buffer_size);
+			goto invalid;
+		}
+
+		new_read_offset = resp->read_bytes + curr_read_offset;
+
+		if (new_read_offset > *buffer_size) {
+			log_err("%s: Bytes read > dest buffer (%d , %d)\n",
+				svc_name, new_read_offset, *buffer_size);
+			goto invalid;
+		}
+
+		memcpy((u8 *)*buffer + curr_read_offset, resp->payload,
+		       resp->read_bytes);
+
+		curr_read_offset = new_read_offset;
+
+		if (curr_read_offset > resp->total_bytes) {
+			log_err("%s: Offset bypassed total bytes (%d , %d)\n",
+				svc_name, curr_read_offset, resp->total_bytes);
+			goto invalid;
+		}
+
+	} while (curr_read_offset != resp->total_bytes);
+
+	return 0;
+
+invalid:
+	ret = -EINVAL;
+fail:
+	if (allocated) {
+		free(*buffer);
+		*buffer = NULL;
+		*buffer_size = 0;
+	}
+
+	return ret;
+}
+
+/**
+ * fwu_commit() -  fwu_commit ABI
+ * @handle: The handle of the context being closed
+ * @acceptance_req: Acceptance status set by the Client
+ * @max_atomic_len: Hint, maximum time (in ns) that the Update Agent can execute
+ *                  continuously without yielding back to the Client state
+ *
+ * Description: The call closes the image pointed to by handle. The image can be
+ * any entity opened with fwu_open().
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_commit(u32 handle, u32 acceptance_req, u32 max_atomic_len)
+{
+	struct fwu_commit_args *args = g_fwu_buf;
+	struct fwu_commit_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_COMMIT";
+	int ret;
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_COMMIT;
+	args->handle = handle;
+	args->acceptance_req = acceptance_req;
+	args->max_atomic_len = max_atomic_len;
+
+	/* Executing the FWU ABI through the FF-A bus */
+	ret = fwu_invoke_svc(args->function_id, svc_name,
+			     sizeof(*args), sizeof(*resp), NULL);
+
+	while (resp->status == -FWU_RESUME)
+		ret = fwu_invoke_svc(args->function_id, svc_name, sizeof(*args),
+				     sizeof(*resp), NULL);
+
+	if (ret)
+		return ret;
+
+	log_debug("%s:  Progress %d/%d\n", svc_name, resp->progress,
+		  resp->total_work);
+
+	return 0;
+}
+
+/**
+ * fwu_read_directory() - Read FWU directory information
+ *
+ * Description: Read FWU directory information.
+ * For more details see fwu_image_directory structure.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_read_directory(void)
+{
+	int ret, close_ret;
+	static u32 read_directory_size;
+	u32 expected_directory_size;
+
+	u32 handle = 0;
+	efi_guid_t dir_guid = FWU_DIRECTORY_CANONICAL_GUID;
+
+	ret = fwu_open(&dir_guid, FWU_OP_TYPE_READ, &handle);
+	if (ret) {
+		log_err("FWU: Open image directory failed (err: %d)\n",
+			ret);
+		return ret;
+	}
+
+	log_debug("FWU: Image directory handle (0x%x)\n", handle);
+
+	ret = fwu_read_stream(handle,
+			      (void **)&g_fwu_cached_directory,
+			      &read_directory_size);
+
+	if (ret) {
+		log_err("FWU: Read image directory failed (err: %d)\n",
+			ret);
+		goto close_handle;
+	}
+
+	if (read_directory_size < FWU_IMAGE_DIRECTORY_HDR_SIZE) {
+		log_err("FWU: No image entry data received (%u , %lu)\n",
+			read_directory_size,
+			FWU_IMAGE_DIRECTORY_HDR_SIZE);
+		ret = -EINVAL;
+		goto close_handle;
+	}
+
+	if (g_fwu_cached_directory->img_info_offset !=
+	    FWU_IMAGE_DIRECTORY_HDR_SIZE) {
+		log_err("FWU: Invalid image info offset (%u , %lu)\n",
+			g_fwu_cached_directory->img_info_offset,
+			FWU_IMAGE_DIRECTORY_HDR_SIZE);
+		ret = -EINVAL;
+		goto close_handle;
+	}
+
+	if (g_fwu_cached_directory->img_info_size !=
+	    FWU_IMAGE_DIRECTORY_INFO_SIZE) {
+		log_err("FWU: Invalid image info size (%u , %lu)\n",
+			g_fwu_cached_directory->img_info_size,
+			FWU_IMAGE_DIRECTORY_INFO_SIZE);
+		ret = -EINVAL;
+		goto close_handle;
+	}
+
+	expected_directory_size = g_fwu_cached_directory->img_info_offset +
+		g_fwu_cached_directory->num_images * g_fwu_cached_directory->img_info_size;
+	if (read_directory_size != expected_directory_size) {
+		log_err("FWU: Directory size is not as expected (%d , %d)\n",
+			read_directory_size,
+			expected_directory_size);
+		ret = -EINVAL;
+		goto close_handle;
+	}
+
+	log_debug("FWU: directory_version (%d)\n",
+		  g_fwu_cached_directory->directory_version);
+
+	/*
+	 * Note: The expected images in the directory are:
+	 * - The images to be updated
+	 * - The ESRT image (an image containing ESRT data)
+	 * The ESRT image is not involved in the FWU.
+	 * It should be removed from the count.
+	 */
+	g_fwu_cached_directory->num_images -= 1;
+
+	if (g_fwu_cached_directory->num_images !=
+	    CONFIG_FWU_NUM_IMAGES_PER_BANK) {
+		log_err("FWU: Unexpected image count (%d , %d)\n",
+			g_fwu_cached_directory->num_images,
+			CONFIG_FWU_NUM_IMAGES_PER_BANK);
+		ret = -EINVAL;
+		goto close_handle;
+	}
+
+	log_debug("FWU: images to be updated (%d)\n",
+		  g_fwu_cached_directory->num_images);
+	log_debug("FWU: img_info_size (%d)\n",
+		  g_fwu_cached_directory->img_info_size);
+
+close_handle:
+	/* The Update Agent can execute for an unbounded time */
+	close_ret = fwu_commit(handle, FWU_IMG_NOT_ACCEPTED, 0);
+	if (close_ret)
+		log_err("FWU: Close image directory handle failed (err: %d)\n",
+			close_ret);
+
+	return ret;
+}
 
 /**
  * fwu_discover_ts_sp_id() - Query the FWU partition ID
@@ -237,7 +756,121 @@ int fwu_agent_init(void)
 	if (ret)
 		return ret;
 
+	ret = fwu_discover();
+	if (ret)
+		goto failure;
+
+	ret = fwu_read_directory();
+	if (ret)
+		goto failure;
+
 	g_fwu_initialized = true;
 
 	return 0;
+
+failure:
+	fwu_shared_buf_reclaim();
+	return ret;
+}
+
+/**
+ * efi_fill_image_desc_array - PSA implementation for populating image descriptors
+ * @image_info_size:		Size of @image_info
+ * @image_info:			Image information
+ * @descriptor_version:		Pointer to version number
+ * @descriptor_count:		Image count
+ * @descriptor_size:		Pointer to descriptor size
+ * @package_version:		Package version
+ * @package_version_name:	Package version's name
+ *
+ * Initialize the update agent in secure world if not initialized.
+ * Then, read the FWU directory information including the current
+ * images information. For more details refer to fwu_image_directory structure.
+ *
+ * Return information about the current firmware image in @image_info.
+ * @image_info will consist of a number of descriptors.
+ * Each descriptor will be created based on efi_fw_image array.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure
+ */
+efi_status_t efi_fill_image_desc_array(efi_uintn_t *image_info_size,
+				       struct efi_firmware_image_descriptor *image_info,
+				       u32 *descriptor_version,
+				       u8 *descriptor_count,
+				       efi_uintn_t *descriptor_size,
+				       u32 *package_version,
+				       u16 **package_version_name)
+{
+	int ret;
+	int required_image_info_size;
+	size_t image_info_desc_size = sizeof(*image_info);
+
+	if (!g_fwu_initialized) {
+		ret = fwu_agent_init();
+		if (ret) {
+			log_err("FWU: Update agent init failed, ret = %d\n",
+				ret);
+			return EFI_EXIT(EFI_DEVICE_ERROR);
+		}
+	}
+
+	required_image_info_size = g_fwu_cached_directory->num_images *
+		image_info_desc_size;
+
+	if (*image_info_size < required_image_info_size) {
+		*image_info_size = required_image_info_size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	*descriptor_version = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
+	*descriptor_count = g_fwu_cached_directory->num_images;
+	*descriptor_size = image_info_desc_size;
+	*package_version = PACKAGE_VERSION_NOT_SUP; /* Not supported */
+	*package_version_name = NULL; /* Not supported */
+
+	for (int i = 0; i < g_fwu_cached_directory->num_images; i++) {
+		/* Only image indexes starting from 1 are supported */
+		image_info[i].image_index = i + 1;
+
+		/* Corresponding ESRT field: FwClass */
+		guidcpy(&image_info[i].image_type_id,
+			&g_fwu_cached_directory->entries[i].img_type_guid);
+
+		image_info[i].image_id = image_info[i].image_index;
+		image_info[i].image_id_name = NULL; /* Not supported */
+
+		/* Corresponding ESRT field: FwVersion */
+		image_info[i].version =
+			g_fwu_cached_directory->entries[i].img_version;
+
+		image_info[i].version_name = NULL; /* Not supported */
+		image_info[i].size =
+			g_fwu_cached_directory->entries[i].img_max_size;
+
+		image_info[i].attributes_supported =
+			IMAGE_ATTRIBUTE_IMAGE_UPDATABLE |
+			IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED;
+		image_info[i].attributes_setting =
+				IMAGE_ATTRIBUTE_IMAGE_UPDATABLE;
+
+		/* Check if the capsule authentication is enabled */
+		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
+			image_info[i].attributes_setting |=
+				IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED;
+
+		/* Corresponding ESRT field: LowestSupportedFwVersion */
+		image_info[i].lowest_supported_image_version =
+			g_fwu_cached_directory->entries[i].lowest_acceptable_version;
+
+		/* Corresponding ESRT field: LastAttemptVersion (not supported) */
+		image_info[i].last_attempt_version = LAST_ATTEMPT_NOT_SUP;
+
+		/* Corresponding ESRT field: LastAttemptStatus (not supported) */
+		image_info[i].last_attempt_status = LAST_ATTEMPT_NOT_SUP;
+
+		image_info[i].hardware_instance = DEFAULT_HW_INSTANCE;
+		image_info[i].dependencies = NULL; /* Not supported */
+	}
+
+	return EFI_SUCCESS;
 }
-- 
2.43.0

