Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5E1D60D14
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BB989686;
	Wed, 20 Nov 2024 10:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MMh8z0tL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2862889694; Wed, 20 Nov 2024 10:22:55 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA1F89555
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso1687331f8f.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094572; x=1732699372; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d58mVy2Lu59odAq8AOPRX9+9zrlFd+bWsCiQz/tyzZQ=;
 b=MMh8z0tLz8WonCOjCyu/0cZb+s7KuNPe0Lfe+ecY2EP6fvxViFavFIDwsSCr0+/02L
 R5N9+UOJtQkcar2ClWBo7uftoDOABtSHbDoT4L930GQSiFCEaVre2ex1xem81fv2ebEc
 ES2XneK37t1gEdmTn+KuYdTZ26gawnMGOxcdcr34pdZpSINc/jISGmCIfiwE6oBbq4MB
 OedZDuF0KhFHswmWQVkOURJMW+HwnpTBUFGlgi2EqFUTWTSqogccZGT/4XyDYVqmpA3H
 eMNs0v+XPFH8/CnJbMQaOO2xRuVQpPPE9V/8KQI/pHcLOyuh/VF/jMsUuz5k+o7hikBL
 Gd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094572; x=1732699372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d58mVy2Lu59odAq8AOPRX9+9zrlFd+bWsCiQz/tyzZQ=;
 b=cb/iWvYuzJv4dXkA8XOVc6WPYEgKpwBJTJhHgu/ZBMNhvjC4g920fdTbZNEb0YasGe
 emrG8ILVg6L7MHSwZq/T6GDtRr1j9M62UyEdft5EIQN/zQ+oOSbTqthGxjERiMvVLdJW
 YDHaOjxbqa+FO3KIAh8PE1rlTHL52NG+LhxXc7SoqIGEntHxBtC287KXovv7LFL9VZyU
 TZHfyP3lyA9QgP2YiakZmi69uMzI6ti00B3W5BGkIfV6aZ9yvhD1FGX+V5qaKWy98zpz
 tALXpUWvaCPDs+fcx5peToILl6cZ2haBQQYSseK1j8e/DzARojV7MgnCoFbeXYLMZyxq
 6Lzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0KppoUUkdP2AV/8hYJ7hfGIseTwNp16DRovE6kNTWcAi+M6IqZkFvVrhqaqqq/jfqT8LFyvc=@lists.denx.de
X-Gm-Message-State: AOJu0YxCwo9NfAio9UHpFC9jO6y2JSnvOVwTuE/nbR7uAFS/UKcqqLUg
 jj3LYIf36hQSxFQhTt5VoG6Xgp7XU0/9IZf3jgCa2X9JmWcezGSoSKD9YCwcYAY=
X-Google-Smtp-Source: AGHT+IGa2QDhQEa063wB/iQ7qkOryR0l67qZvOD6srRfEqfG4HL35W3o9cscQ1cv+DHb9kS3eH4hBg==
X-Received: by 2002:a05:6000:2b0e:b0:382:4b6f:24ea with SMTP id
 ffacd0b85a97d-38254ade0a9mr1155106f8f.11.1732094572354; 
 Wed, 20 Nov 2024 01:22:52 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:52 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Nov 2024 10:22:47 +0100
Subject: [PATCH 6/6] ufs: core: sync ufshci.h with Linux v6.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-topic-ufs-cleanup-v1-6-a5cef54b1cdc@linaro.org>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11426;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zFn6k6/WI4KU8Yu77BTn4eHMlAiEMz3F8WxSSUI4Mso=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapmVZ98dcHeaz0AwLtmkvd8E9xralWB5WML7jQY
 rzO3gUyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qZgAKCRB33NvayMhJ0VXOEA
 Cup6cpa1UDTUONyYglpJj9Ulb+MbMKn1UsGS64HoSnUHjbai0SHgZeJQqOXgqfKhZ1SErJcJ+Cz4mh
 9SI8lbMCoc3dJtb3n2T1un9hQJGR2LHdah3hKhySF7Ii/ogqgGFpu5cRI8MHrzbZHovwZIfwyX0oZI
 rn1hatlZc5d7zi15VxVEyNEIlGllzakwDqmzPh8RF5fAEX0Mnl1jopUTlb8k/xAECd6pAfPUBBVd6q
 gkf6+Dtpuhq5bdOj6uszTAVhjtY5XXMg8W8qHGzG3elfMXWi2haJk9z9ef0yoDZxexGvM9VhyxIpap
 cPYKTXwRM8f4jDlBIfHyCD4Mzjplwu4pQXdjfC7cR9fGTG8UtdK+jazWW/Mab8eawEnjbB34miXJBW
 TdlC4EKrm/eCijpzA7zJFpEjpf3lanBmXefZshVFszue74HKIOfjItaHMdlN8o8ljC3QC2qAnhy2Gf
 4gVl5cdpi2zzunWqZRxWlneBRBgntXpqCSlc/0Lj4LeGFI/I9Nm6HVEmS9ooZBujzpBWeOqjNdhbzM
 IJ1lTrpYaYuUcgZHjXiycQSAHOYX1COBBCFC3285w5ooDT+nq1sQz/ee3euERWHjU5RhsUxn0so46V
 kIUm2w+49btgLRJYoq5is/A+mULd+w+2CkVWePHHJnGi1ykTiB4TFOFleFZA==
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

Sync ufshci.h with the version found in the Linux v6.12
version commit adc218676eef ("Linux 6.12").

It adds new defines, and moves defines to the same place
as the Linux header.

No functional changes intended.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufshci.h | 285 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 210 insertions(+), 75 deletions(-)

diff --git a/drivers/ufs/ufshci.h b/drivers/ufs/ufshci.h
index db30812b176f9e36529452e260b847241f97fdab..08af517b1028804e64602767f7a51bbfb083c59b 100644
--- a/drivers/ufs/ufshci.h
+++ b/drivers/ufs/ufshci.h
@@ -8,61 +8,14 @@ enum {
 	ALIGNED_UPIU_SIZE		= 512,
 };
 
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
 /* UFSHCI Registers */
 enum {
 	REG_CONTROLLER_CAPABILITIES		= 0x00,
+	REG_MCQCAP				= 0x04,
 	REG_UFS_VERSION				= 0x08,
-	REG_CONTROLLER_DEV_ID			= 0x10,
-	REG_CONTROLLER_PROD_ID			= 0x14,
+	REG_EXT_CONTROLLER_CAPABILITIES		= 0x0C,
+	REG_CONTROLLER_PID			= 0x10,
+	REG_CONTROLLER_MID			= 0x14,
 	REG_AUTO_HIBERNATE_IDLE_TIMER		= 0x18,
 	REG_INTERRUPT_STATUS			= 0x20,
 	REG_INTERRUPT_ENABLE			= 0x24,
@@ -94,20 +47,98 @@ enum {
 	REG_UFS_CCAP				= 0x100,
 	REG_UFS_CRYPTOCAP			= 0x104,
 
+	REG_UFS_MEM_CFG				= 0x300,
+	REG_UFS_MCQ_CFG				= 0x380,
+	REG_UFS_ESILBA				= 0x384,
+	REG_UFS_ESIUBA				= 0x388,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
 
 /* Controller capability masks */
 enum {
-	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
+	MASK_TRANSFER_REQUESTS_SLOTS_SDB	= 0x0000001F,
+	MASK_TRANSFER_REQUESTS_SLOTS_MCQ	= 0x000000FF,
+	MASK_NUMBER_OUTSTANDING_RTT		= 0x0000FF00,
 	MASK_TASK_MANAGEMENT_REQUEST_SLOTS	= 0x00070000,
+	MASK_EHSLUTRD_SUPPORTED			= 0x00400000,
 	MASK_AUTO_HIBERN8_SUPPORT		= 0x00800000,
 	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
 	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
+	MASK_CRYPTO_SUPPORT			= 0x10000000,
+	MASK_LSDB_SUPPORT			= 0x20000000,
+	MASK_MCQ_SUPPORT			= 0x40000000,
+};
+
+/* MCQ capability mask */
+enum {
+	MASK_EXT_IID_SUPPORT = 0x00000400,
+};
+
+enum {
+	REG_SQATTR		= 0x0,
+	REG_SQLBA		= 0x4,
+	REG_SQUBA		= 0x8,
+	REG_SQDAO		= 0xC,
+	REG_SQISAO		= 0x10,
+
+	REG_CQATTR		= 0x20,
+	REG_CQLBA		= 0x24,
+	REG_CQUBA		= 0x28,
+	REG_CQDAO		= 0x2C,
+	REG_CQISAO		= 0x30,
+};
+
+enum {
+	REG_SQHP		= 0x0,
+	REG_SQTP		= 0x4,
+	REG_SQRTC		= 0x8,
+	REG_SQCTI		= 0xC,
+	REG_SQRTS		= 0x10,
+};
+
+enum {
+	REG_CQHP		= 0x0,
+	REG_CQTP		= 0x4,
+};
+
+enum {
+	REG_CQIS		= 0x0,
+	REG_CQIE		= 0x4,
+};
+
+enum {
+	SQ_START		= 0x0,
+	SQ_STOP			= 0x1,
+	SQ_ICU			= 0x2,
+};
+
+enum {
+	SQ_STS			= 0x1,
+	SQ_CUS			= 0x2,
+};
+
+#define SQ_ICU_ERR_CODE_MASK		GENMASK(7, 4)
+#define UFS_MASK(mask, offset)		((mask) << (offset))
+
+/* UFS Version 08h */
+#define MINOR_VERSION_NUM_MASK		UFS_MASK(0xFFFF, 0)
+#define MAJOR_VERSION_NUM_MASK		UFS_MASK(0xFFFF, 16)
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
 };
 
-/* Interrupt Status 20h */
+/*
+ * IS - Interrupt Status - 20h
+ */
 #define UTP_TRANSFER_REQ_COMPL			0x1
 #define UIC_DME_END_PT_RESET			0x2
 #define UIC_ERROR				0x4
@@ -122,25 +153,25 @@ enum {
 #define DEVICE_FATAL_ERROR			0x800
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
+#define CRYPTO_ENGINE_FATAL_ERROR		0x40000
+#define MCQ_CQ_EVENT_STATUS			0x100000
 
-#define UFSHCD_UIC_PWR_MASK	(UIC_HIBERNATE_ENTER |\
-				UIC_HIBERNATE_EXIT |\
+#define UFSHCD_UIC_HIBERN8_MASK	(UIC_HIBERNATE_ENTER |\
+				UIC_HIBERNATE_EXIT)
+
+#define UFSHCD_UIC_PWR_MASK	(UFSHCD_UIC_HIBERN8_MASK |\
 				UIC_POWER_MODE)
 
-#define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UIC_POWER_MODE)
+#define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UFSHCD_UIC_PWR_MASK)
 
-#define UFSHCD_ERROR_MASK	(UIC_ERROR |\
-				DEVICE_FATAL_ERROR |\
-				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR)
+#define UFSHCD_ERROR_MASK	(UIC_ERROR | INT_FATAL_ERRORS)
 
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR)
+				SYSTEM_BUS_FATAL_ERROR |\
+				CRYPTO_ENGINE_FATAL_ERROR |\
+				UIC_LINK_LOST)
 
-/* Host Controller Enable 0x34h */
-#define CONTROLLER_ENABLE	0x1
-#define CONTROLLER_DISABLE	0x0
 /* HCS - Host Controller Status 30h */
 #define DEVICE_PRESENT				0x1
 #define UTP_TRANSFER_REQ_LIST_READY		0x2
@@ -163,6 +194,70 @@ enum {
 	PWR_FATAL_ERROR	= 0x05,
 };
 
+/* HCE - Host Controller Enable 34h */
+#define CONTROLLER_ENABLE	0x1
+#define CONTROLLER_DISABLE	0x0
+#define CRYPTO_GENERAL_ENABLE	0x2
+
+/* UECPA - Host UIC Error Code PHY Adapter Layer 38h */
+#define UIC_PHY_ADAPTER_LAYER_ERROR			0x80000000
+#define UIC_PHY_ADAPTER_LAYER_ERROR_CODE_MASK		0x1F
+#define UIC_PHY_ADAPTER_LAYER_LANE_ERR_MASK		0xF
+#define UIC_PHY_ADAPTER_LAYER_GENERIC_ERROR		0x10
+
+/* UECDL - Host UIC Error Code Data Link Layer 3Ch */
+#define UIC_DATA_LINK_LAYER_ERROR		0x80000000
+#define UIC_DATA_LINK_LAYER_ERROR_CODE_MASK	0xFFFF
+#define UIC_DATA_LINK_LAYER_ERROR_TCX_REP_TIMER_EXP	0x2
+#define UIC_DATA_LINK_LAYER_ERROR_AFCX_REQ_TIMER_EXP	0x4
+#define UIC_DATA_LINK_LAYER_ERROR_FCX_PRO_TIMER_EXP	0x8
+#define UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF	0x20
+#define UIC_DATA_LINK_LAYER_ERROR_PA_INIT	0x2000
+#define UIC_DATA_LINK_LAYER_ERROR_NAC_RECEIVED	0x0001
+#define UIC_DATA_LINK_LAYER_ERROR_TCx_REPLAY_TIMEOUT 0x0002
+
+/* UECN - Host UIC Error Code Network Layer 40h */
+#define UIC_NETWORK_LAYER_ERROR			0x80000000
+#define UIC_NETWORK_LAYER_ERROR_CODE_MASK	0x7
+#define UIC_NETWORK_UNSUPPORTED_HEADER_TYPE	0x1
+#define UIC_NETWORK_BAD_DEVICEID_ENC		0x2
+#define UIC_NETWORK_LHDR_TRAP_PACKET_DROPPING	0x4
+
+/* UECT - Host UIC Error Code Transport Layer 44h */
+#define UIC_TRANSPORT_LAYER_ERROR		0x80000000
+#define UIC_TRANSPORT_LAYER_ERROR_CODE_MASK	0x7F
+#define UIC_TRANSPORT_UNSUPPORTED_HEADER_TYPE	0x1
+#define UIC_TRANSPORT_UNKNOWN_CPORTID		0x2
+#define UIC_TRANSPORT_NO_CONNECTION_RX		0x4
+#define UIC_TRANSPORT_CONTROLLED_SEGMENT_DROPPING	0x8
+#define UIC_TRANSPORT_BAD_TC			0x10
+#define UIC_TRANSPORT_E2E_CREDIT_OVERFOW	0x20
+#define UIC_TRANSPORT_SAFETY_VALUE_DROPPING	0x40
+
+/* UECDME - Host UIC Error Code DME 48h */
+#define UIC_DME_ERROR			0x80000000
+#define UIC_DME_ERROR_CODE_MASK		0x1
+
+/* UTRIACR - Interrupt Aggregation control register - 0x4Ch */
+#define INT_AGGR_TIMEOUT_VAL_MASK		0xFF
+#define INT_AGGR_COUNTER_THRESHOLD_MASK		UFS_MASK(0x1F, 8)
+#define INT_AGGR_COUNTER_AND_TIMER_RESET	0x10000
+#define INT_AGGR_STATUS_BIT			0x100000
+#define INT_AGGR_PARAM_WRITE			0x1000000
+#define INT_AGGR_ENABLE				0x80000000
+
+/* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
+#define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
+
+/* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
+#define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
+
+/* REG_UFS_MEM_CFG - Global Config Registers 300h */
+#define MCQ_MODE_SELECT	BIT(0)
+
+/* CQISy - CQ y Interrupt Status Register  */
+#define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
+
 /* UICCMD - UIC Command */
 #define COMMAND_OPCODE_MASK		0xFF
 #define GEN_SELECTOR_INDEX_MASK		0xFFFF
@@ -171,7 +266,7 @@ enum {
 #define RESET_LEVEL			0xFF
 
 #define ATTR_SET_TYPE_MASK		UFS_MASK(0xFF, 16)
-#define CFG_RESULT_CODE_MASK		0xFF
+#define CONFIG_RESULT_CODE_MASK		0xFF
 #define GENERIC_ERROR_CODE_MASK		0xFF
 
 /* GenSelectorIndex calculation macros for M-PHY attributes */
@@ -190,12 +285,6 @@ enum link_status {
 	UFSHCD_LINK_IS_UP	= 2,
 };
 
-#define UIC_ARG_MIB_SEL(attr, sel)	((((attr) & 0xFFFF) << 16) |\
-					 ((sel) & 0xFFFF))
-#define UIC_ARG_MIB(attr)		UIC_ARG_MIB_SEL(attr, 0)
-#define UIC_ARG_ATTR_TYPE(t)		(((t) & 0xFF) << 16)
-#define UIC_GET_ATTR_ID(v)		(((v) >> 16) & 0xFFFF)
-
 /* UIC Commands */
 enum uic_cmd_dme {
 	UIC_CMD_DME_GET			= 0x01,
@@ -231,11 +320,57 @@ enum {
 
 #define MASK_UIC_COMMAND_RESULT			0xFF
 
-/* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
-#define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
+#define INT_AGGR_COUNTER_THLD_VAL(c)	(((c) & 0x1F) << 8)
+#define INT_AGGR_TIMEOUT_VAL(t)		(((t) & 0xFF) << 0)
+
+/*
+ * Request Descriptor Definitions
+ */
+
+/* To accommodate UFS2.0 required Command type */
+enum {
+	UTP_CMD_TYPE_UFS_STORAGE	= 0x1,
+};
+
+enum {
+	UTP_SCSI_COMMAND		= 0x00000000,
+	UTP_REQ_DESC_INT_CMD            = 0x01000000,
+	UTP_NATIVE_UFS_COMMAND		= 0x10000000,
+	UTP_DEVICE_MANAGEMENT_FUNCTION	= 0x20000000,
+};
+
+/* UTP Transfer Request Data Direction (DD) */
+enum utp_data_direction {
+	UTP_NO_DATA_TRANSFER	= 0,
+	UTP_HOST_TO_DEVICE	= 1,
+	UTP_DEVICE_TO_HOST	= 2,
+};
+
+/* Overall command status values */
+enum utp_ocs {
+	OCS_SUCCESS			= 0x0,
+	OCS_INVALID_CMD_TABLE_ATTR	= 0x1,
+	OCS_INVALID_PRDT_ATTR		= 0x2,
+	OCS_MISMATCH_DATA_BUF_SIZE	= 0x3,
+	OCS_MISMATCH_RESP_UPIU_SIZE	= 0x4,
+	OCS_PEER_COMM_FAILURE		= 0x5,
+	OCS_ABORTED			= 0x6,
+	OCS_FATAL_ERROR			= 0x7,
+	OCS_DEVICE_FATAL_ERROR		= 0x8,
+	OCS_INVALID_CRYPTO_CONFIG	= 0x9,
+	OCS_GENERAL_CRYPTO_ERROR	= 0xA,
+	OCS_INVALID_COMMAND_STATUS	= 0x0F,
+};
+
+enum {
+	MASK_OCS			= 0x0F,
+};
+
+/* The maximum length of the data byte count field in the PRDT is 256KB */
+#define PRDT_DATA_BYTE_COUNT_MAX	SZ_256K
+/* The granularity of the data byte count field in the PRDT is 32-bit */
+#define PRDT_DATA_BYTE_COUNT_PAD	4
 
-/* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
-#define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
 struct ufshcd_sg_entry {
 	__le32    base_addr;

-- 
2.34.1

