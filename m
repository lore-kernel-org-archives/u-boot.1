Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D668ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F36C88FA5;
	Tue, 10 Sep 2024 11:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NzimKahz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA0C88F9C; Tue, 10 Sep 2024 11:20:41 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E001788F71
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso4679055e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960036; x=1726564836; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HV8ewGL5ts1akQ5UvRod54uQuskpBFgWIEw8bl8J2hQ=;
 b=NzimKahzQZAQCLG4KsM/Y2DTHitxAQBS3ywD/tRD1z+5x5YOXGelNT5wuF0QCouj2i
 k97E/XZbOMkOV9Oz/Hk5QlrFztznCmpC1kRkYDCI3dRYrhejE6r3CwFlL6ejQyWXff82
 cACr9kWTXRM85MSwoHGT1PCDO6jT83zTxYe6plrhtvauAbi+Q9ystekZttlpkeMj83bG
 Elt4ADmwB8jkfvuQQgaC/ujw3Ho6PIaBls/MABffzv2+keWQndMe+TkP3Qj3pGMky+Pj
 NCCA6NkyfYtZAxZn0Ol/alnbdKoj0MqG4SdMOHALLs1GyHPW/LvtTVvrz/tt5uOASMvj
 bY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960036; x=1726564836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV8ewGL5ts1akQ5UvRod54uQuskpBFgWIEw8bl8J2hQ=;
 b=uGaLTUNqGJ5gOXhpmHcEh3nHH0tQTxeR7xnS4rWSD4zVr6IqWjLuiaDOXy3ZJXmx5D
 22rWe51BAxReGPb9bZdLmRUIUuhjORF9kIykC7v/W3+7RwGWIaL0LBSuRoGbW63TwAF7
 bxVaUrVogxiZJMef9DpeNmQKxLjYRxHlOtIS+ylCBU9q1a2XbN815eRH+R3hms9srK5K
 leNWwwMt/IWvroWZT/zchCFpL+Ty5LWtecYNc+gN+xbZ1nTvtCHgeYDb8YQGPrE2XQ9j
 WfEtO1hmUibvBH1j6ClBBEnOwMVDwMLItMsF2CmzQink2akL5wSE+ZmSTBe26K3/gd3K
 yZ7A==
X-Gm-Message-State: AOJu0YyWY5XfWANDDq56cmVuWPH6TAeYC0msqqwQ0RKl3LuUz2N2eOLM
 EVzAZlQYUIbdE7OIKesEj719tFt1UKdiMCG3jHcZf4KBoWZOBRySRrNZanzWbBU=
X-Google-Smtp-Source: AGHT+IGB30H9TwNlNWhg72qCcdlP1SGwOCCYa0fq1z6ke2fPT+3H4NR8O26PIaeMWaxexp8uTR3KhA==
X-Received: by 2002:a05:600c:1d03:b0:42c:b950:680a with SMTP id
 5b1f17b1804b1-42cb9506955mr35635715e9.20.1725960035579; 
 Tue, 10 Sep 2024 02:20:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:35 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:26 +0200
Subject: [PATCH 09/13] ufs: Sync possible UFS Quirks with Linux UFS driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-9-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5647;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5A1oQNU/wPrcd8KX7K18Fe1TPVAS2m1OHwrC9jqiadc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9ZY2Z1lOgpzcaZo0voAgqmM/dOU4/XQnA3u9Cs
 n8KTNeGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWQAKCRB33NvayMhJ0eyqEA
 CjjveOPo4eqFoLmTaPW24+T4TTl6BPfRe1XjgWx7EjLfx29AcauH/ml/cAQ0frkcWQ0K6QF04iOkBc
 J5UgOZiY0d/Gqav6ON8hDO0YQFZYQ2H1Hu4TqqP45geUfO8a4bJUpCwSxksmR5dCHoSOIvkYGK2iEE
 YCsk77FVTBjMbrssYmSv9kIw3Fzh1tlXXw+8zcj394bAQ3jRDSvoZOI9xs/7+Yv7p96BAvGXB71RHB
 I0LkYdPtp4jaL5mLOGX5z5IAS7VauAlvNCgb6S60pfCfykonFODbWf6KL2mJkTbehVmzj1gfknfQnA
 1CZpuILYKNHVrnQjGH7hcDYaZ5Yo5y9+XgkTgK/lBlJp+Q1JNdpxmJYZkSgnZTQUM0yA3GWhLbPU+n
 Q0XUerkJ5GR4hlr6lSxSiB6HunLZK05/4T+BrerOb/l9fHYyaGu3EpsJbF7Uv5WSfS2cmDpXx62WQy
 mrFTvAaPkwAy2gGHjKBpkr30hSHj+Sh9Mf1M4TV4er6HhHaS2fepZbQ7uqZKPkHFfHdzbSTHMvAQ9E
 pbqsatvkM80MjIAT7rkht2P1f/avsPXZghdaESmRcIi8DB8IQFJltJlHtd4fVNhOdzNKFbL7hzmgbP
 R5eLu5oNoZ4KFa8lrF4Pgn3YEutEfze6p//mjSbyg3aVoyb7LvZ7I5SwcvzQ==
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Sync u-boot UFS driver to add all possible UFS Quirks
as supported by Linux UFS driver as well.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.h | 151 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 120 insertions(+), 31 deletions(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 555f8a6857d..e8a14411560 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -712,38 +712,127 @@ struct ufs_hba {
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
-#define UFSHCD_QUIRK_BROKEN_LCC				BIT(0)
 
-/*
- * This quirk needs to be enabled if the host controller has
- * 64-bit addressing supported capability but it doesn't work.
- */
-#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		BIT(1)
-
-/*
- * This quirk needs to be enabled if the host controller has
- * auto-hibernate capability but it's FASTAUTO only.
- */
-#define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
-
-/*
- * This quirk needs to be enabled if the host controller has
- * 64-bit addressing supported capability but it doesn't work.
- */
-#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
-
-/*
- * This quirk needs to be enabled if the host controller has
- * auto-hibernate capability but it's FASTAUTO only.
- */
-#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
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
2.34.1

