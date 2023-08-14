Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB3EC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8DF869BB;
	Mon, 14 Aug 2023 23:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y1MvJ9Ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F43B869C1; Mon, 14 Aug 2023 23:55:52 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6804A869B5
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso30766845ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050148; x=1692654948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzTUFPnPmljz7xdYpOWKhhsvjZVAZ50PZfyxzv1JcHQ=;
 b=y1MvJ9RyqnB1M1BF/6Du6u8iha62z98LYSl1GOri2N70R32Ci7+ZvP1H9CRTpvYQH/
 ao+7uWXrlB6FDKkFb4ElDI/+Z+ljfE9wpbBq7oYnDW/w3TI7XZ2kTMdmpX+KFB3+hmE+
 U+kmFzDVE93pEE1owcylSR96dTEMKDpMIOAWkHV9DkGzxXHAWCidmLaLWyFVXo/TJ2ab
 p2y7ZcrhcsNyA4Mb4y0ELwSNSGuWuto4f16Zf9gZI/kBy29PbfUysi+V9zbvQEiAm3O3
 rMACAGGUnBGLZaT7i7k2HKXUb11FqsXi2ROElQHnFvongFSUvXwP7HyXjxny28ujpbkM
 uqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050148; x=1692654948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzTUFPnPmljz7xdYpOWKhhsvjZVAZ50PZfyxzv1JcHQ=;
 b=cFlDfU/a0OiAZbNX2SUr9aV04dB4bYi+tCs52Tnr/WvlxVIiMePBrcYkDpVUKvI5p0
 F0wYKyo3do2DTPnaB5wyOzKLNGIXOep4HkAmRfyOVC12PZX6y28GQwC5o+qgj9CfUdMr
 rTRW7+6+V9HeElE90Jh04ubcz5AjbfK0prEOsOWV41/KjecE2NQPqWqEawgFD+ZvsGL8
 rxD03v4Ebge0ZgIbB90kiLLCYtl37UZItcp8u2wr9RhOfT8GIdiYvQBGOpGjyYg+cHm2
 RTd+f8vaAT34oCr47pY78qt/Byo+XRzh3Sq51AtdS/HWCLXnpAtVEzKk47y3vV3C7fOU
 HCNg==
X-Gm-Message-State: AOJu0YxkQwpRqIH3jeAsG0MrMrNF5zBYZA9w76X09g2qoQPuh1d9IAc2
 MaKPtHvWOPSa5BiCQKRYQeltoy8/G3z079pERF0=
X-Google-Smtp-Source: AGHT+IFnq5ofJhLhx+m6g+ayHa+7icOLIHI8Ve0KmENcMGOaiRXEkALmfB3ZKyhDHC3lIEwEzHwAHA==
X-Received: by 2002:a17:902:e809:b0:1bc:8fca:9d59 with SMTP id
 u9-20020a170902e80900b001bc8fca9d59mr11948527plg.29.1692050148450; 
 Mon, 14 Aug 2023 14:55:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:48 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 09/17] ufs: Sync possible UFS Quirks with Linux UFS driver
Date: Tue, 15 Aug 2023 03:24:49 +0530
Message-Id: <20230814215457.4075025-10-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync u-boot UFS driver to add all possible UFS Quirks
as supported by Linux UFS driver as well.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.h | 129 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index b3d2bd0368..cdc88919b4 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -712,14 +712,127 @@ struct ufs_hba {
 	u32			version;
 	u32			intr_mask;
 	u32			quirks;
-/*
- * If UFS host controller is having issue in processing LCC (Line
- * Control Command) coming from device then enable this quirk.
- * When this quirk is enabled, host controller driver should disable
- * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
- * attribute of device to 0).
- */
-#define UFSHCD_QUIRK_BROKEN_LCC				0x1
+
+	/* Interrupt aggregation support is broken */
+#define UFSHCD_QUIRK_BROKEN_INTR_AGGR		(1 << 0)
+
+	/*
+	 * delay before each dme command is required as the unipro
+	 * layer has shown instabilities
+	 */
+#define UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS	(1 << 1)
+
+	/*
+	 * If UFS host controller is having issue in processing LCC (Line
+	 * Control Command) coming from device then enable this quirk.
+	 * When this quirk is enabled, host controller driver should disable
+	 * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
+	 * attribute of device to 0).
+	 */
+#define UFSHCD_QUIRK_BROKEN_LCC			(1 << 2)
+
+	/*
+	 * The attribute PA_RXHSUNTERMCAP specifies whether or not the
+	 * inbound Link supports unterminated line in HS mode. Setting this
+	 * attribute to 1 fixes moving to HS gear.
+	 */
+#define UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP	(1 << 3)
+
+	/*
+	 * This quirk needs to be enabled if the host controller only allows
+	 * accessing the peer dme attributes in AUTO mode (FAST AUTO or
+	 * SLOW AUTO).
+	 */
+#define UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE	(1 << 4)
+
+	/*
+	 * This quirk needs to be enabled if the host controller doesn't
+	 * advertise the correct version in UFS_VER register. If this quirk
+	 * is enabled, standard UFS host driver will call the vendor specific
+	 * ops (get_ufs_hci_version) to get the correct version.
+	 */
+#define UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION	(1 << 5)
+
+	/*
+	 * Clear handling for transfer/task request list is just opposite.
+	 */
+#define UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR	(1 << 6)
+
+	/*
+	 * This quirk needs to be enabled if host controller doesn't allow
+	 * that the interrupt aggregation timer and counter are reset by s/w.
+	 */
+#define UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR	(1 << 7)
+
+	/*
+	 * This quirks needs to be enabled if host controller cannot be
+	 * enabled via HCE register.
+	 */
+#define UFSHCI_QUIRK_BROKEN_HCE			(1 << 8)
+
+	/*
+	 * This quirk needs to be enabled if the host controller regards
+	 * resolution of the values of PRDTO and PRDTL in UTRD as byte.
+	 */
+#define UFSHCD_QUIRK_PRDT_BYTE_GRAN		(1 << 9)
+
+	/*
+	 * This quirk needs to be enabled if the host controller reports
+	 * OCS FATAL ERROR with device error through sense data
+	 */
+#define UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR	(1 << 10)
+
+	/*
+	 * This quirk needs to be enabled if the host controller has
+	 * auto-hibernate capability but it doesn't work.
+	 */
+#define UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8	(1 << 11)
+
+	/*
+	 * This quirk needs to disable manual flush for write booster
+	 */
+#define UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL	(1 << 12)
+
+	/*
+	 * This quirk needs to disable unipro timeout values
+	 * before power mode change
+	 */
+#define UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING	(1 << 13)
+
+	/*
+	 * Align DMA SG entries on a 4 KiB boundary.
+	 */
+#define UFSHCD_QUIRK_4KB_DMA_ALIGNMENT			(1 << 14)
+
+	/*
+	 * This quirk needs to be enabled if the host controller does not
+	 * support UIC command
+	 */
+#define UFSHCD_QUIRK_BROKEN_UIC_CMD			(1 << 15)
+
+	/*
+	 * This quirk needs to be enabled if the host controller cannot
+	 * support physical host configuration.
+	 */
+#define UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		(1 << 16)
+
+	/*
+	 * This quirk needs to be enabled if the host controller has
+	 * 64-bit addressing supported capability but it doesn't work.
+	 */
+#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		(1 << 17)
+
+	/*
+	 * This quirk needs to be enabled if the host controller has
+	 * auto-hibernate capability but it's FASTAUTO only.
+	 */
+#define UFSHCD_QUIRK_HIBERN_FASTAUTO			(1 << 18)
+
+	/*
+	 * This quirk needs to be enabled if the host controller needs
+	 * to reinit the device after switching to maximum gear.
+	 */
+#define UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH	(1 << 19)
 
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
-- 
2.38.1

