Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC235D44171
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01768965F;
	Wed, 20 Nov 2024 10:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ohJEV1kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECF989685; Wed, 20 Nov 2024 10:22:54 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5DF89672
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3823eb7ba72so1351962f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094571; x=1732699371; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U7s68va0Bu9tGYMzRH/MkeTzC1pkF/rec6OH+95Dc6I=;
 b=ohJEV1kPCyodBC0UV7DFFe93FRAcq4ahC72EvGgJXUKoYh5mSFl0TK067pMqlDbk1D
 XVMCKFbXvZDJ/qkRJm45Kh1/d71xkrrS7Naasj3wWJnlfdWME8+hoS05pYBB9vNCfAKN
 We5AkJIhroTsYhTHXxjJsJ7Qo7tkyS0Lz3xsIeP76WjmUbeP6x1UEx7YMDbW3fUGP7bA
 dh9RSyUv1nyrjHm2qdhi3/o8V4PEJzymra80f3bpe2/nEwoQHhFQSjmDVMYdzuwlJl8m
 5qQai1cLo3S37zk1q6EsMgxAfSYo+efqIC1yUkk8jIw1KxUyYSbADogznGThCkTrhKKZ
 r5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094571; x=1732699371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7s68va0Bu9tGYMzRH/MkeTzC1pkF/rec6OH+95Dc6I=;
 b=r3KsoQEbxn2EXROaAco7zUNjqMh1gejTIkWHT1leOLx2ub6r52wImJ9HsXdtJK2f+H
 IQDlbr/bfiJhdqulpRE+fStTDqmxhYMjb2kYyeeeguARB93snIS/bpj5TLFKhFmhEYHm
 i0nrW48MH0wE1WXanKfs5y+bHC9rHVdxCvxW5ED+Z11VSfjlGymSp7+0QFnlGT6gXc0/
 mz+2xWd982HcJG5+yZWtMf+toF3QsDL0eCxySlj3r8BkKw0oDjYxTd4nmt260DSeMqET
 We/k69Ps/bdctVKqU9bSFzIfyzV2CHIqSkqXi8j9r5/zxkVYigHBXGzolHmRze4QuHDy
 FTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1c2MsRdi5W3p1QYnKDb/dfS2y00pRjK9jI4LfdT3F7pzCzhPOiiz8zEfZfl5y8BTHiHSBVug=@lists.denx.de
X-Gm-Message-State: AOJu0YwvXbmJFzzA1JGW8QfnRS8hNYNTbxOx9Zm0V1A1H9/K+N2t7Hd2
 J2YMOLd7zRY6yjQsedbKB1hLtFLpdKWIHXDyK8OOthB6k8UlHbbVFyRI4GOi24I=
X-Gm-Gg: ASbGncusePsI56fRBBsHBN34BcshPpx7EaMmJ+FtSDDYtwEYNvGJ+jhSoKj1fv3Qigl
 3/5ucyiNlKwsZG0VvA7U2gQXbW1cmPZ31Xx1RvHIE3M/EOjwaJeolFRMt4P8LUng98i5fVZQOzK
 ZfzJwsABJIwnQ58nmFS/NcKCwNSzDJsNekovE/l3OIB0QnwVrkcqlbuXMiroJFJV5w7onJYovfz
 KqKKdeyYXMpxSesHMJ/xHsLKTsg9C7EyBCHRYHFnXPmpQoaBaHP813/3TiVOfnY4+esYlc=
X-Google-Smtp-Source: AGHT+IEy8IbWRq6Le1azqzHEPSa+P4Un8DKy9C++6xOvlIB4neh24dQx/qu/u+JLG8njq6mDLAfzrA==
X-Received: by 2002:a5d:6d82:0:b0:382:4a8e:b81c with SMTP id
 ffacd0b85a97d-38254afac4dmr1474397f8f.33.1732094570811; 
 Wed, 20 Nov 2024 01:22:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:50 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Nov 2024 10:22:45 +0100
Subject: [PATCH 4/6] ufs: core: move ufshci defines in a separate header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-topic-ufs-cleanup-v1-4-a5cef54b1cdc@linaro.org>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22225;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yEkEui0wwKCyZ6tAIVReVGvf5LAnQHUqaKNUMsS5u5k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapl9umVUX6b21F9gkVTy/frqINF2t20lLuPFALn
 SKWNazaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qZQAKCRB33NvayMhJ0VgCD/
 4tQlPxA8J7v6A9y9oiM0QEo9UGFzR4D72qqFcM8rP4PvoDc53WIklUOAwYrMQKZni/EjOrg4yV2hp2
 HLt0JNqOwoSAIxF1c0dO5O7LCsQpY0GwcUz9AO254JZZOEa8LAVPBKtwXUaZ/rRiqrj7Hy2QwAX6xj
 QlyepaJzi+3Nkuwtj/WbNe9RvKmIROm3xeC5H9uQLoPZgg9lZMDMyLrx2DSApniZ+JZrBsZ/oFCy47
 N92+6Fz35tU1b5FCNBClhCpWua1GkxypamUBR3DMCSb/f0nHr58fHWzWpx3o/MBPGe35m3wO4YHMee
 YqTaJlUKS/rq62OJjRHBCzq3IF2y3oxTH2IMpfIBKYHDZUx1QPVd5UqczaQdClfLWYB+miQoGSAH51
 g50dfk5gCMVX+4MyQyaJTiRfv/NnQPIgfWTQuFvhuhEYPqpXWDqpxUDv7ZEO2llCNbu0/Qcl7wTQyR
 J/0vr3bSfW+cMqrBQD5/aEUnQojlOZ63V4gUYtOxS/tdBCqzIvoD0RdkUWVUSDuD+aJi2Uet1ZJ0iY
 qYOrMPs3D/lkmwlOS6HsATO3kEWIlD2jZyTl3fqgrpChG+xxxlYOXlvnrB5I/t7mBpuUnxQL/TEDg1
 e9GQn38pXuTjQFw/PvT4b5lIs8gQEJpdvkmv9HBJ5XmtGhpMg2tf9Dtmq2Jg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Splitting the header will help synchronizing the defines
again with Linux.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.h    | 329 +-------------------------------------------------
 drivers/ufs/ufshci.h | 334 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 335 insertions(+), 328 deletions(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index f4f042005e7fc2638ea6b33f26839c668d22bc9e..53137fae3a81ce87d744dd56c49db2a8ffba1d3d 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <asm/io.h>
+#include "ufshci.h"
 #include "unipro.h"
 
 struct udevice;
@@ -14,11 +15,6 @@ struct udevice;
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
 #define UFS_MAX_LUNS		0x7F
 
-enum {
-	TASK_REQ_UPIU_SIZE_DWORDS	= 8,
-	TASK_RSP_UPIU_SIZE_DWORDS	= 8,
-	ALIGNED_UPIU_SIZE		= 512,
-};
 
 /* UFS device power modes */
 enum ufs_dev_pwr_mode {
@@ -84,44 +80,6 @@ enum {
 /* Offset of the response code in the UPIU header */
 #define UPIU_RSP_CODE_OFFSET		8
 
-/* To accommodate UFS2.0 required Command type */
-enum {
-	UTP_CMD_TYPE_UFS_STORAGE	= 0x1,
-};
-
-enum {
-	UTP_SCSI_COMMAND		= 0x00000000,
-	UTP_NATIVE_UFS_COMMAND		= 0x10000000,
-	UTP_DEVICE_MANAGEMENT_FUNCTION	= 0x20000000,
-	UTP_REQ_DESC_INT_CMD		= 0x01000000,
-};
-
-/* UTP Transfer Request Data Direction (DD) */
-enum {
-	UTP_NO_DATA_TRANSFER	= 0x00000000,
-	UTP_HOST_TO_DEVICE	= 0x02000000,
-	UTP_DEVICE_TO_HOST	= 0x04000000,
-};
-
-/* Overall command status values */
-enum {
-	OCS_SUCCESS			= 0x0,
-	OCS_INVALID_CMD_TABLE_ATTR	= 0x1,
-	OCS_INVALID_PRDT_ATTR		= 0x2,
-	OCS_MISMATCH_DATA_BUF_SIZE	= 0x3,
-	OCS_MISMATCH_RESP_UPIU_SIZE	= 0x4,
-	OCS_PEER_COMM_FAILURE		= 0x5,
-	OCS_ABORTED			= 0x6,
-	OCS_FATAL_ERROR			= 0x7,
-	OCS_INVALID_COMMAND_STATUS	= 0x0F,
-	MASK_OCS			= 0x0F,
-};
-
-/* The maximum length of the data byte count field in the PRDT is 256KB */
-#define PRDT_DATA_BYTE_COUNT_MAX	(256 * 1024)
-/* The granularity of the data byte count field in the PRDT is 32-bit */
-#define PRDT_DATA_BYTE_COUNT_PAD	4
-
 #define GENERAL_UPIU_REQUEST_SIZE (sizeof(struct utp_upiu_req))
 #define QUERY_DESC_MAX_SIZE       255
 #define QUERY_DESC_MIN_SIZE       2
@@ -297,79 +255,6 @@ enum desc_header_offset {
 	QUERY_DESC_DESC_TYPE_OFFSET	= 0x01,
 };
 
-struct ufshcd_sg_entry {
-	__le32    base_addr;
-	__le32    upper_addr;
-	__le32    reserved;
-	__le32    size;
-};
-
-#define MAX_BUFF	128
-/**
- * struct utp_transfer_cmd_desc - UFS Command Descriptor structure
- * @command_upiu: Command UPIU Frame address
- * @response_upiu: Response UPIU Frame address
- * @prd_table: Physical Region Descriptor
- */
-struct utp_transfer_cmd_desc {
-	u8 command_upiu[ALIGNED_UPIU_SIZE];
-	u8 response_upiu[ALIGNED_UPIU_SIZE];
-	struct ufshcd_sg_entry    prd_table[MAX_BUFF];
-};
-
-/**
- * struct request_desc_header - Descriptor Header common to both UTRD and UTMRD
- * @dword0: Descriptor Header DW0
- * @dword1: Descriptor Header DW1
- * @dword2: Descriptor Header DW2
- * @dword3: Descriptor Header DW3
- */
-struct request_desc_header {
-	__le32 dword_0;
-	__le32 dword_1;
-	__le32 dword_2;
-	__le32 dword_3;
-};
-
-/**
- * struct utp_transfer_req_desc - UTRD structure
- * @header: UTRD header DW-0 to DW-3
- * @command_desc_base_addr_lo: UCD base address low DW-4
- * @command_desc_base_addr_hi: UCD base address high DW-5
- * @response_upiu_length: response UPIU length DW-6
- * @response_upiu_offset: response UPIU offset DW-6
- * @prd_table_length: Physical region descriptor length DW-7
- * @prd_table_offset: Physical region descriptor offset DW-7
- */
-struct utp_transfer_req_desc {
-	/* DW 0-3 */
-	struct request_desc_header header;
-
-	/* DW 4-5*/
-	__le32  command_desc_base_addr_lo;
-	__le32  command_desc_base_addr_hi;
-
-	/* DW 6 */
-	__le16  response_upiu_length;
-	__le16  response_upiu_offset;
-
-	/* DW 7 */
-	__le16  prd_table_length;
-	__le16  prd_table_offset;
-};
-
-/**
- * struct utp_upiu_header - UPIU header structure
- * @dword_0: UPIU header DW-0
- * @dword_1: UPIU header DW-1
- * @dword_2: UPIU header DW-2
- */
-struct utp_upiu_header {
-	__be32 dword_0;
-	__be32 dword_1;
-	__be32 dword_2;
-};
-
 /**
  * struct utp_upiu_query - upiu request buffer structure for
  * query request.
@@ -403,27 +288,6 @@ struct utp_upiu_cmd {
 	u8 cdb[UFS_CDB_SIZE];
 };
 
-/*
- * UTMRD structure.
- */
-struct utp_task_req_desc {
-	/* DW 0-3 */
-	struct request_desc_header header;
-
-	/* DW 4-11 - Task request UPIU structure */
-	struct utp_upiu_header	req_header;
-	__be32			input_param1;
-	__be32			input_param2;
-	__be32			input_param3;
-	__be32			__reserved1[2];
-
-	/* DW 12-19 - Task Management Response UPIU structure */
-	struct utp_upiu_header	rsp_header;
-	__be32			output_param1;
-	__be32			output_param2;
-	__be32			__reserved2[3];
-};
-
 /**
  * struct utp_upiu_req - general upiu request structure
  * @header:UPIU header structure DW-0 to DW-2
@@ -551,63 +415,6 @@ struct uic_command {
 	int result;
 };
 
-/* GenSelectorIndex calculation macros for M-PHY attributes */
-#define UIC_ARG_MPHY_TX_GEN_SEL_INDEX(lane) (lane)
-#define UIC_ARG_MPHY_RX_GEN_SEL_INDEX(lane) (PA_MAXDATALANES + (lane))
-
-#define UIC_ARG_MIB_SEL(attr, sel)	((((attr) & 0xFFFF) << 16) |\
-					 ((sel) & 0xFFFF))
-#define UIC_ARG_MIB(attr)		UIC_ARG_MIB_SEL(attr, 0)
-#define UIC_ARG_ATTR_TYPE(t)		(((t) & 0xFF) << 16)
-#define UIC_GET_ATTR_ID(v)		(((v) >> 16) & 0xFFFF)
-
-/* Link Status*/
-enum link_status {
-	UFSHCD_LINK_IS_DOWN	= 1,
-	UFSHCD_LINK_IS_UP	= 2,
-};
-
-#define UIC_ARG_MIB_SEL(attr, sel)	((((attr) & 0xFFFF) << 16) |\
-					 ((sel) & 0xFFFF))
-#define UIC_ARG_MIB(attr)		UIC_ARG_MIB_SEL(attr, 0)
-#define UIC_ARG_ATTR_TYPE(t)		(((t) & 0xFF) << 16)
-#define UIC_GET_ATTR_ID(v)		(((v) >> 16) & 0xFFFF)
-
-/* UIC Commands */
-enum uic_cmd_dme {
-	UIC_CMD_DME_GET			= 0x01,
-	UIC_CMD_DME_SET			= 0x02,
-	UIC_CMD_DME_PEER_GET		= 0x03,
-	UIC_CMD_DME_PEER_SET		= 0x04,
-	UIC_CMD_DME_POWERON		= 0x10,
-	UIC_CMD_DME_POWEROFF		= 0x11,
-	UIC_CMD_DME_ENABLE		= 0x12,
-	UIC_CMD_DME_RESET		= 0x14,
-	UIC_CMD_DME_END_PT_RST		= 0x15,
-	UIC_CMD_DME_LINK_STARTUP	= 0x16,
-	UIC_CMD_DME_HIBER_ENTER		= 0x17,
-	UIC_CMD_DME_HIBER_EXIT		= 0x18,
-	UIC_CMD_DME_TEST_MODE		= 0x1A,
-};
-
-/* UIC Config result code / Generic error code */
-enum {
-	UIC_CMD_RESULT_SUCCESS			= 0x00,
-	UIC_CMD_RESULT_INVALID_ATTR		= 0x01,
-	UIC_CMD_RESULT_FAILURE			= 0x01,
-	UIC_CMD_RESULT_INVALID_ATTR_VALUE	= 0x02,
-	UIC_CMD_RESULT_READ_ONLY_ATTR		= 0x03,
-	UIC_CMD_RESULT_WRITE_ONLY_ATTR		= 0x04,
-	UIC_CMD_RESULT_BAD_INDEX		= 0x05,
-	UIC_CMD_RESULT_LOCKED_ATTR		= 0x06,
-	UIC_CMD_RESULT_BAD_TEST_FEATURE_INDEX	= 0x07,
-	UIC_CMD_RESULT_PEER_COMM_FAILURE	= 0x08,
-	UIC_CMD_RESULT_BUSY			= 0x09,
-	UIC_CMD_RESULT_DME_FAILURE		= 0x0A,
-};
-
-#define MASK_UIC_COMMAND_RESULT			0xFF
-
 /* Host <-> Device UniPro Link state */
 enum uic_link_state {
 	UIC_LINK_OFF_STATE	= 0, /* Link powered down or disabled */
@@ -940,17 +747,6 @@ static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
 	return 0;
 }
 
-/* Controller UFSHCI version */
-enum {
-	UFSHCI_VERSION_10 = 0x00010000, /* 1.0 */
-	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
-	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
-	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
-	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
-	UFSHCI_VERSION_31 = 0x00000310, /* 3.1 */
-	UFSHCI_VERSION_40 = 0x00000400, /* 4.0 */
-};
-
 /* Interrupt disable masks */
 enum {
 	/* Interrupt disable mask for UFSHCI v1.0 */
@@ -964,123 +760,6 @@ enum {
 	INTERRUPT_MASK_ALL_VER_21	= 0x71FFF,
 };
 
-/* UFSHCI Registers */
-enum {
-	REG_CONTROLLER_CAPABILITIES		= 0x00,
-	REG_UFS_VERSION				= 0x08,
-	REG_CONTROLLER_DEV_ID			= 0x10,
-	REG_CONTROLLER_PROD_ID			= 0x14,
-	REG_AUTO_HIBERNATE_IDLE_TIMER		= 0x18,
-	REG_INTERRUPT_STATUS			= 0x20,
-	REG_INTERRUPT_ENABLE			= 0x24,
-	REG_CONTROLLER_STATUS			= 0x30,
-	REG_CONTROLLER_ENABLE			= 0x34,
-	REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER	= 0x38,
-	REG_UIC_ERROR_CODE_DATA_LINK_LAYER	= 0x3C,
-	REG_UIC_ERROR_CODE_NETWORK_LAYER	= 0x40,
-	REG_UIC_ERROR_CODE_TRANSPORT_LAYER	= 0x44,
-	REG_UIC_ERROR_CODE_DME			= 0x48,
-	REG_UTP_TRANSFER_REQ_INT_AGG_CONTROL	= 0x4C,
-	REG_UTP_TRANSFER_REQ_LIST_BASE_L	= 0x50,
-	REG_UTP_TRANSFER_REQ_LIST_BASE_H	= 0x54,
-	REG_UTP_TRANSFER_REQ_DOOR_BELL		= 0x58,
-	REG_UTP_TRANSFER_REQ_LIST_CLEAR		= 0x5C,
-	REG_UTP_TRANSFER_REQ_LIST_RUN_STOP	= 0x60,
-	REG_UTP_TASK_REQ_LIST_BASE_L		= 0x70,
-	REG_UTP_TASK_REQ_LIST_BASE_H		= 0x74,
-	REG_UTP_TASK_REQ_DOOR_BELL		= 0x78,
-	REG_UTP_TASK_REQ_LIST_CLEAR		= 0x7C,
-	REG_UTP_TASK_REQ_LIST_RUN_STOP		= 0x80,
-	REG_UIC_COMMAND				= 0x90,
-	REG_UIC_COMMAND_ARG_1			= 0x94,
-	REG_UIC_COMMAND_ARG_2			= 0x98,
-	REG_UIC_COMMAND_ARG_3			= 0x9C,
-
-	UFSHCI_REG_SPACE_SIZE			= 0xA0,
-
-	REG_UFS_CCAP				= 0x100,
-	REG_UFS_CRYPTOCAP			= 0x104,
-
-	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
-};
-
-/* Controller capability masks */
-enum {
-	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
-	MASK_TASK_MANAGEMENT_REQUEST_SLOTS	= 0x00070000,
-	MASK_AUTO_HIBERN8_SUPPORT		= 0x00800000,
-	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
-	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
-	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
-};
-
-/* Interrupt Status 20h */
-#define UTP_TRANSFER_REQ_COMPL			0x1
-#define UIC_DME_END_PT_RESET			0x2
-#define UIC_ERROR				0x4
-#define UIC_TEST_MODE				0x8
-#define UIC_POWER_MODE				0x10
-#define UIC_HIBERNATE_EXIT			0x20
-#define UIC_HIBERNATE_ENTER			0x40
-#define UIC_LINK_LOST				0x80
-#define UIC_LINK_STARTUP			0x100
-#define UTP_TASK_REQ_COMPL			0x200
-#define UIC_COMMAND_COMPL			0x400
-#define DEVICE_FATAL_ERROR			0x800
-#define CONTROLLER_FATAL_ERROR			0x10000
-#define SYSTEM_BUS_FATAL_ERROR			0x20000
-
-#define UFSHCD_UIC_PWR_MASK	(UIC_HIBERNATE_ENTER |\
-				UIC_HIBERNATE_EXIT |\
-				UIC_POWER_MODE)
-
-#define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UIC_POWER_MODE)
-
-#define UFSHCD_ERROR_MASK	(UIC_ERROR |\
-				DEVICE_FATAL_ERROR |\
-				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR)
-
-#define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
-				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR)
-
-/* Host Controller Enable 0x34h */
-#define CONTROLLER_ENABLE	0x1
-#define CONTROLLER_DISABLE	0x0
-/* HCS - Host Controller Status 30h */
-#define DEVICE_PRESENT				0x1
-#define UTP_TRANSFER_REQ_LIST_READY		0x2
-#define UTP_TASK_REQ_LIST_READY			0x4
-#define UIC_COMMAND_READY			0x8
-#define HOST_ERROR_INDICATOR			0x10
-#define DEVICE_ERROR_INDICATOR			0x20
-#define UIC_POWER_MODE_CHANGE_REQ_STATUS_MASK	UFS_MASK(0x7, 8)
-
-#define UFSHCD_STATUS_READY	(UTP_TRANSFER_REQ_LIST_READY |\
-				UTP_TASK_REQ_LIST_READY |\
-				UIC_COMMAND_READY)
-
-enum {
-	PWR_OK		= 0x0,
-	PWR_LOCAL	= 0x01,
-	PWR_REMOTE	= 0x02,
-	PWR_BUSY	= 0x03,
-	PWR_ERROR_CAP	= 0x04,
-	PWR_FATAL_ERROR	= 0x05,
-};
-
-/* UICCMD - UIC Command */
-#define COMMAND_OPCODE_MASK		0xFF
-#define GEN_SELECTOR_INDEX_MASK		0xFFFF
-
-#define MIB_ATTRIBUTE_MASK		UFS_MASK(0xFFFF, 16)
-#define RESET_LEVEL			0xFF
-
-#define ATTR_SET_TYPE_MASK		UFS_MASK(0xFF, 16)
-#define CFG_RESULT_CODE_MASK		0xFF
-#define GENERIC_ERROR_CODE_MASK		0xFF
-
 #define ufshcd_writel(hba, val, reg)   \
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg) \
@@ -1103,12 +782,6 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 	ufshcd_writel(hba, tmp, reg);
 }
 
-/* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
-#define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
-
-/* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
-#define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
-
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
 #endif
diff --git a/drivers/ufs/ufshci.h b/drivers/ufs/ufshci.h
new file mode 100644
index 0000000000000000000000000000000000000000..db30812b176f9e36529452e260b847241f97fdab
--- /dev/null
+++ b/drivers/ufs/ufshci.h
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __UFSHCI_H
+#define __UFSHCI_H
+
+enum {
+	TASK_REQ_UPIU_SIZE_DWORDS	= 8,
+	TASK_RSP_UPIU_SIZE_DWORDS	= 8,
+	ALIGNED_UPIU_SIZE		= 512,
+};
+
+/* To accommodate UFS2.0 required Command type */
+enum {
+	UTP_CMD_TYPE_UFS_STORAGE	= 0x1,
+};
+
+enum {
+	UTP_SCSI_COMMAND		= 0x00000000,
+	UTP_NATIVE_UFS_COMMAND		= 0x10000000,
+	UTP_DEVICE_MANAGEMENT_FUNCTION	= 0x20000000,
+	UTP_REQ_DESC_INT_CMD		= 0x01000000,
+};
+
+/* UTP Transfer Request Data Direction (DD) */
+enum {
+	UTP_NO_DATA_TRANSFER	= 0x00000000,
+	UTP_HOST_TO_DEVICE	= 0x02000000,
+	UTP_DEVICE_TO_HOST	= 0x04000000,
+};
+
+/* Overall command status values */
+enum {
+	OCS_SUCCESS			= 0x0,
+	OCS_INVALID_CMD_TABLE_ATTR	= 0x1,
+	OCS_INVALID_PRDT_ATTR		= 0x2,
+	OCS_MISMATCH_DATA_BUF_SIZE	= 0x3,
+	OCS_MISMATCH_RESP_UPIU_SIZE	= 0x4,
+	OCS_PEER_COMM_FAILURE		= 0x5,
+	OCS_ABORTED			= 0x6,
+	OCS_FATAL_ERROR			= 0x7,
+	OCS_INVALID_COMMAND_STATUS	= 0x0F,
+	MASK_OCS			= 0x0F,
+};
+
+/* The maximum length of the data byte count field in the PRDT is 256KB */
+#define PRDT_DATA_BYTE_COUNT_MAX	(256 * 1024)
+/* The granularity of the data byte count field in the PRDT is 32-bit */
+#define PRDT_DATA_BYTE_COUNT_PAD	4
+
+/* Controller UFSHCI version */
+enum {
+	UFSHCI_VERSION_10 = 0x00010000, /* 1.0 */
+	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
+	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
+	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
+	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
+	UFSHCI_VERSION_31 = 0x00000310, /* 3.1 */
+	UFSHCI_VERSION_40 = 0x00000400, /* 4.0 */
+};
+
+/* UFSHCI Registers */
+enum {
+	REG_CONTROLLER_CAPABILITIES		= 0x00,
+	REG_UFS_VERSION				= 0x08,
+	REG_CONTROLLER_DEV_ID			= 0x10,
+	REG_CONTROLLER_PROD_ID			= 0x14,
+	REG_AUTO_HIBERNATE_IDLE_TIMER		= 0x18,
+	REG_INTERRUPT_STATUS			= 0x20,
+	REG_INTERRUPT_ENABLE			= 0x24,
+	REG_CONTROLLER_STATUS			= 0x30,
+	REG_CONTROLLER_ENABLE			= 0x34,
+	REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER	= 0x38,
+	REG_UIC_ERROR_CODE_DATA_LINK_LAYER	= 0x3C,
+	REG_UIC_ERROR_CODE_NETWORK_LAYER	= 0x40,
+	REG_UIC_ERROR_CODE_TRANSPORT_LAYER	= 0x44,
+	REG_UIC_ERROR_CODE_DME			= 0x48,
+	REG_UTP_TRANSFER_REQ_INT_AGG_CONTROL	= 0x4C,
+	REG_UTP_TRANSFER_REQ_LIST_BASE_L	= 0x50,
+	REG_UTP_TRANSFER_REQ_LIST_BASE_H	= 0x54,
+	REG_UTP_TRANSFER_REQ_DOOR_BELL		= 0x58,
+	REG_UTP_TRANSFER_REQ_LIST_CLEAR		= 0x5C,
+	REG_UTP_TRANSFER_REQ_LIST_RUN_STOP	= 0x60,
+	REG_UTP_TASK_REQ_LIST_BASE_L		= 0x70,
+	REG_UTP_TASK_REQ_LIST_BASE_H		= 0x74,
+	REG_UTP_TASK_REQ_DOOR_BELL		= 0x78,
+	REG_UTP_TASK_REQ_LIST_CLEAR		= 0x7C,
+	REG_UTP_TASK_REQ_LIST_RUN_STOP		= 0x80,
+	REG_UIC_COMMAND				= 0x90,
+	REG_UIC_COMMAND_ARG_1			= 0x94,
+	REG_UIC_COMMAND_ARG_2			= 0x98,
+	REG_UIC_COMMAND_ARG_3			= 0x9C,
+
+	UFSHCI_REG_SPACE_SIZE			= 0xA0,
+
+	REG_UFS_CCAP				= 0x100,
+	REG_UFS_CRYPTOCAP			= 0x104,
+
+	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
+};
+
+/* Controller capability masks */
+enum {
+	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
+	MASK_TASK_MANAGEMENT_REQUEST_SLOTS	= 0x00070000,
+	MASK_AUTO_HIBERN8_SUPPORT		= 0x00800000,
+	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
+	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
+	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
+};
+
+/* Interrupt Status 20h */
+#define UTP_TRANSFER_REQ_COMPL			0x1
+#define UIC_DME_END_PT_RESET			0x2
+#define UIC_ERROR				0x4
+#define UIC_TEST_MODE				0x8
+#define UIC_POWER_MODE				0x10
+#define UIC_HIBERNATE_EXIT			0x20
+#define UIC_HIBERNATE_ENTER			0x40
+#define UIC_LINK_LOST				0x80
+#define UIC_LINK_STARTUP			0x100
+#define UTP_TASK_REQ_COMPL			0x200
+#define UIC_COMMAND_COMPL			0x400
+#define DEVICE_FATAL_ERROR			0x800
+#define CONTROLLER_FATAL_ERROR			0x10000
+#define SYSTEM_BUS_FATAL_ERROR			0x20000
+
+#define UFSHCD_UIC_PWR_MASK	(UIC_HIBERNATE_ENTER |\
+				UIC_HIBERNATE_EXIT |\
+				UIC_POWER_MODE)
+
+#define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UIC_POWER_MODE)
+
+#define UFSHCD_ERROR_MASK	(UIC_ERROR |\
+				DEVICE_FATAL_ERROR |\
+				CONTROLLER_FATAL_ERROR |\
+				SYSTEM_BUS_FATAL_ERROR)
+
+#define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
+				CONTROLLER_FATAL_ERROR |\
+				SYSTEM_BUS_FATAL_ERROR)
+
+/* Host Controller Enable 0x34h */
+#define CONTROLLER_ENABLE	0x1
+#define CONTROLLER_DISABLE	0x0
+/* HCS - Host Controller Status 30h */
+#define DEVICE_PRESENT				0x1
+#define UTP_TRANSFER_REQ_LIST_READY		0x2
+#define UTP_TASK_REQ_LIST_READY			0x4
+#define UIC_COMMAND_READY			0x8
+#define HOST_ERROR_INDICATOR			0x10
+#define DEVICE_ERROR_INDICATOR			0x20
+#define UIC_POWER_MODE_CHANGE_REQ_STATUS_MASK	UFS_MASK(0x7, 8)
+
+#define UFSHCD_STATUS_READY	(UTP_TRANSFER_REQ_LIST_READY |\
+				UTP_TASK_REQ_LIST_READY |\
+				UIC_COMMAND_READY)
+
+enum {
+	PWR_OK		= 0x0,
+	PWR_LOCAL	= 0x01,
+	PWR_REMOTE	= 0x02,
+	PWR_BUSY	= 0x03,
+	PWR_ERROR_CAP	= 0x04,
+	PWR_FATAL_ERROR	= 0x05,
+};
+
+/* UICCMD - UIC Command */
+#define COMMAND_OPCODE_MASK		0xFF
+#define GEN_SELECTOR_INDEX_MASK		0xFFFF
+
+#define MIB_ATTRIBUTE_MASK		UFS_MASK(0xFFFF, 16)
+#define RESET_LEVEL			0xFF
+
+#define ATTR_SET_TYPE_MASK		UFS_MASK(0xFF, 16)
+#define CFG_RESULT_CODE_MASK		0xFF
+#define GENERIC_ERROR_CODE_MASK		0xFF
+
+/* GenSelectorIndex calculation macros for M-PHY attributes */
+#define UIC_ARG_MPHY_TX_GEN_SEL_INDEX(lane) (lane)
+#define UIC_ARG_MPHY_RX_GEN_SEL_INDEX(lane) (PA_MAXDATALANES + (lane))
+
+#define UIC_ARG_MIB_SEL(attr, sel)	((((attr) & 0xFFFF) << 16) |\
+					 ((sel) & 0xFFFF))
+#define UIC_ARG_MIB(attr)		UIC_ARG_MIB_SEL(attr, 0)
+#define UIC_ARG_ATTR_TYPE(t)		(((t) & 0xFF) << 16)
+#define UIC_GET_ATTR_ID(v)		(((v) >> 16) & 0xFFFF)
+
+/* Link Status*/
+enum link_status {
+	UFSHCD_LINK_IS_DOWN	= 1,
+	UFSHCD_LINK_IS_UP	= 2,
+};
+
+#define UIC_ARG_MIB_SEL(attr, sel)	((((attr) & 0xFFFF) << 16) |\
+					 ((sel) & 0xFFFF))
+#define UIC_ARG_MIB(attr)		UIC_ARG_MIB_SEL(attr, 0)
+#define UIC_ARG_ATTR_TYPE(t)		(((t) & 0xFF) << 16)
+#define UIC_GET_ATTR_ID(v)		(((v) >> 16) & 0xFFFF)
+
+/* UIC Commands */
+enum uic_cmd_dme {
+	UIC_CMD_DME_GET			= 0x01,
+	UIC_CMD_DME_SET			= 0x02,
+	UIC_CMD_DME_PEER_GET		= 0x03,
+	UIC_CMD_DME_PEER_SET		= 0x04,
+	UIC_CMD_DME_POWERON		= 0x10,
+	UIC_CMD_DME_POWEROFF		= 0x11,
+	UIC_CMD_DME_ENABLE		= 0x12,
+	UIC_CMD_DME_RESET		= 0x14,
+	UIC_CMD_DME_END_PT_RST		= 0x15,
+	UIC_CMD_DME_LINK_STARTUP	= 0x16,
+	UIC_CMD_DME_HIBER_ENTER		= 0x17,
+	UIC_CMD_DME_HIBER_EXIT		= 0x18,
+	UIC_CMD_DME_TEST_MODE		= 0x1A,
+};
+
+/* UIC Config result code / Generic error code */
+enum {
+	UIC_CMD_RESULT_SUCCESS			= 0x00,
+	UIC_CMD_RESULT_INVALID_ATTR		= 0x01,
+	UIC_CMD_RESULT_FAILURE			= 0x01,
+	UIC_CMD_RESULT_INVALID_ATTR_VALUE	= 0x02,
+	UIC_CMD_RESULT_READ_ONLY_ATTR		= 0x03,
+	UIC_CMD_RESULT_WRITE_ONLY_ATTR		= 0x04,
+	UIC_CMD_RESULT_BAD_INDEX		= 0x05,
+	UIC_CMD_RESULT_LOCKED_ATTR		= 0x06,
+	UIC_CMD_RESULT_BAD_TEST_FEATURE_INDEX	= 0x07,
+	UIC_CMD_RESULT_PEER_COMM_FAILURE	= 0x08,
+	UIC_CMD_RESULT_BUSY			= 0x09,
+	UIC_CMD_RESULT_DME_FAILURE		= 0x0A,
+};
+
+#define MASK_UIC_COMMAND_RESULT			0xFF
+
+/* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
+#define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
+
+/* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
+#define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
+
+struct ufshcd_sg_entry {
+	__le32    base_addr;
+	__le32    upper_addr;
+	__le32    reserved;
+	__le32    size;
+};
+
+#define MAX_BUFF	128
+/**
+ * struct utp_transfer_cmd_desc - UFS Command Descriptor structure
+ * @command_upiu: Command UPIU Frame address
+ * @response_upiu: Response UPIU Frame address
+ * @prd_table: Physical Region Descriptor
+ */
+struct utp_transfer_cmd_desc {
+	u8 command_upiu[ALIGNED_UPIU_SIZE];
+	u8 response_upiu[ALIGNED_UPIU_SIZE];
+	struct ufshcd_sg_entry    prd_table[MAX_BUFF];
+};
+
+/**
+ * struct request_desc_header - Descriptor Header common to both UTRD and UTMRD
+ * @dword0: Descriptor Header DW0
+ * @dword1: Descriptor Header DW1
+ * @dword2: Descriptor Header DW2
+ * @dword3: Descriptor Header DW3
+ */
+struct request_desc_header {
+	__le32 dword_0;
+	__le32 dword_1;
+	__le32 dword_2;
+	__le32 dword_3;
+};
+
+/**
+ * struct utp_transfer_req_desc - UTRD structure
+ * @header: UTRD header DW-0 to DW-3
+ * @command_desc_base_addr_lo: UCD base address low DW-4
+ * @command_desc_base_addr_hi: UCD base address high DW-5
+ * @response_upiu_length: response UPIU length DW-6
+ * @response_upiu_offset: response UPIU offset DW-6
+ * @prd_table_length: Physical region descriptor length DW-7
+ * @prd_table_offset: Physical region descriptor offset DW-7
+ */
+struct utp_transfer_req_desc {
+	/* DW 0-3 */
+	struct request_desc_header header;
+
+	/* DW 4-5*/
+	__le32  command_desc_base_addr_lo;
+	__le32  command_desc_base_addr_hi;
+
+	/* DW 6 */
+	__le16  response_upiu_length;
+	__le16  response_upiu_offset;
+
+	/* DW 7 */
+	__le16  prd_table_length;
+	__le16  prd_table_offset;
+};
+
+/**
+ * struct utp_upiu_header - UPIU header structure
+ * @dword_0: UPIU header DW-0
+ * @dword_1: UPIU header DW-1
+ * @dword_2: UPIU header DW-2
+ */
+struct utp_upiu_header {
+	__be32 dword_0;
+	__be32 dword_1;
+	__be32 dword_2;
+};
+
+/*
+ * UTMRD structure.
+ */
+struct utp_task_req_desc {
+	/* DW 0-3 */
+	struct request_desc_header header;
+
+	/* DW 4-11 - Task request UPIU structure */
+	struct utp_upiu_header	req_header;
+	__be32			input_param1;
+	__be32			input_param2;
+	__be32			input_param3;
+	__be32			__reserved1[2];
+
+	/* DW 12-19 - Task Management Response UPIU structure */
+	struct utp_upiu_header	rsp_header;
+	__be32			output_param1;
+	__be32			output_param2;
+	__be32			__reserved2[3];
+};
+
+#endif

-- 
2.34.1

