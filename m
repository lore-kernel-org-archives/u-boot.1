Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9865DE77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250B1805ED;
	Mon, 30 Dec 2024 11:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uJtazJer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843118066C; Mon, 30 Dec 2024 11:31:15 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BDD806A7
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso65627555e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554672; x=1736159472; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtYSlc1uBzgE8dzeDkKxs9KOoTwtF+rm0XNgd+OsfSY=;
 b=uJtazJerkJlVthE31BtpvfO+cAZYBZfor9Wwq1zbfvmtC/8vkNe0d158mZP/TgPF23
 u/WvYDx5pvT4WOGDDjB2n3/cInff8DUfyUUKIsKDI50B3PfioxP0OtftJA0IJtMfCBYU
 VwLgLIWjJAvhknPXECjT80UfkFstMwfb5qzaDPEOJX9/EcP5RalngBCJGAP6ySoFPlZ2
 Vp+6Tt4XXlbpD3r0JZjfzi0DHdOhYBL0GwVlOYm69bpkA08WK0BzxIqpXxmCB9cEU8rj
 vwoYT/JuR7+OWyhGO25mUzhNAAgumBQeFNs+wATf4agFLOdX+0PvzEhG8bsOVrcWh+BL
 3sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554672; x=1736159472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtYSlc1uBzgE8dzeDkKxs9KOoTwtF+rm0XNgd+OsfSY=;
 b=k3567I7GuKH/+3bSeNGRaz4DgOdI5MFPAGPM1EFbskPDPO0kRVhPnXZSfKrpbRCEhy
 Wpc2rjMvZSiifY08906in5nL3xb+WuQfZR2Jf2dFgPzQuH7pdkdiGswf4kwJq+I08Hbm
 lKkmQNBglXri8Z+LuQouGSkxb10j9iOYz1d1A9tjhcWNH4HVUbeWDr/w2R4u9SweKyzT
 /DoagtwARsI77DsnsPhQBE3ZhEJiZoNfsu7NGPu0lhRgLWjJJqCmxhLZytKgZz90prqo
 mNDnupcgG9ekaifKlG+5Us4JAdx0LwH3o56ZhuBp21H5xvwf03mn558YOG+AFBczo245
 /fLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+tLA8S5SqbygCP+feSBlywNmVUURjbTdgzR9C3HpwQmhiQqcKWfBN6Zv4hLt5XvL8GH40x4o=@lists.denx.de
X-Gm-Message-State: AOJu0YyxwYjRhVGt0t3GdX3gHcStsPjRjx8BVjAsOCIHgdFrFPCmBci+
 eZBPqePyALUNFR+PUvQmygFDlL6Y946Dv5g1CFFZbMhhG3M6vhFQx+ZMcuGYo6o=
X-Gm-Gg: ASbGncvDkIJH4ftls3a8e1/+K0eJhUF5a2n6zryKTjZOTA5TWh9l9Oy7L8xX7J1Xi8E
 H3T2FIcLdaLeND65nWx51bhFTVunnkpojgFUw+wJD98tSrEWfwYFIIl5CKTKqiioR9eRf0W9pK2
 qDkG6uCXD1r39HNXolRgzzrkyQA1i85XB6RR104GNkXg8wTfDgFCazbXm1ZFPtPE8vVqXQ9kuDy
 lcjgwWPt4yluUVg1J5vfOSQWI0mWAXCG2KtLFlZqB6l4l1PAhaZDgSXEtrw6vajgOy9CCJcyh5I
 qw==
X-Google-Smtp-Source: AGHT+IHPhyLpR6+xGKAeY7UK/MhvRFi8zm4v4x/gjea/UrJTl4NQvH0JKDkoD5eLEfFdFey7Pc552A==
X-Received: by 2002:a5d:6da2:0:b0:385:d7a7:ad60 with SMTP id
 ffacd0b85a97d-38a221f11b2mr31763525f8f.3.1735554667638; 
 Mon, 30 Dec 2024 02:31:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm30201550f8f.77.2024.12.30.02.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 02:31:07 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Dec 2024 11:31:00 +0100
Subject: [PATCH v2 6/6] ufs: core: sync ufshci.h with Linux v6.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-topic-ufs-cleanup-v2-6-4c6d7994a45d@linaro.org>
References: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
In-Reply-To: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, Love Kumar <love.kumar@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mw3KCZaPbgM9eDz7r3959ekqf9kLxMyERVVfuDZ2p5w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBncnZkB4z+eMrmD9bgiTPzFKbcjaTSsugR9/scLM9c
 NGMv4laJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ3J2ZAAKCRB33NvayMhJ0S8SEA
 DQN9qvk2aDzLK9jGIO5Y1xmnVNU1IWvpMfYtB2gXkcjjW8tZP6McOCVVS4g3GL1+8XtpXNtjM6O+oj
 um+4nKzQ5CyrepJa5Rt/5poE8zX/iztuZ5v156gVhW+lydOFw5cA7hL2hSag2YGUP8trZ4iul6RWVt
 y0B8vnEafizjqlbplauQJNJA1e5h/ZjpFBJD/s9CGuDrtPEBgQbaAXsTxujIgD3KFbY4725eS4S1Gl
 yRcLRMsBBoiX6NmnRuEJ1SXEpDyv5h9fqiF3v5vJtEG1bKw1IKfT2wrPDdrAc2Md3yVCvxEcS+9E54
 7rInwM+21gY1aJtA2EE0PtFtyFyst6vJNIyygaee3Q4vi1zlytLYdIFEy8Bb+CN4KBGywsDSgaqOoM
 CGwpu58At9rBlgeq3glUdIp6jPFJHoIiNQX9awKo9dt0hXN+72xI0fBjSXiWIfOiR1IY+eDo9Nux6P
 krf/JngEEkqZyKLbtFKo33pMiCP4z/NpxWI8TfcmDoBKjl70LwIGnGLnVV60ZhaUqbw7QO+E4sGjoj
 fVFNxfUs3QhDD0ZNjwlOTKiloiAZuNBmH9FkZHzFYi16WtrznfLDqrC6C8P1Qo71YMdVwr9lOOUEw4
 ZCMHGCB/9eMiRKv7TfLtwN626fBt8KHEwqafEJ6NpE9vykMu9s0CDPQMUAEQ==
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

Acked-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Love Kumar <love.kumar@amd.com>
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

