Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FF8CF58E9
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0A689432;
	Fri, 20 Sep 2024 10:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z3miCRhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA97D8942B; Fri, 20 Sep 2024 10:00:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C449A893D7
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so14730335e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819241; x=1727424041; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R4cGKPJpzNJCSwjAbMhpal1e0iHKKUKG+dEV+7xk5Cs=;
 b=z3miCRhVfDxQrsBqmSdvEWbPUWb25WyMVoh05GWpBB8+9mXeny9ZSKaCY11g5W1N+f
 diquKoPJ+Yhv0jClQQTNHBQrjKNy0CKjP5rgRzdjLQwyjtDhrcWt/0URuBl0cUo/idpc
 93vg/e1XnKlFrf8am94LuUQakubhEi4xtkSWxHrCwaa2C7vT64XwkG2W7lhXiLD8inBe
 3Dx31z7OBLhBUoUMB7wcMPM9QXZIbgPGKhIES0s0bgYdjf567p55WCkLEEdw5F1DD4/j
 TyuQZpljxxACSfIitgvIjWczwhGo/To2ggInXP2GdXNRTaqZAhDWk5feymayRcAphv+f
 eczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819241; x=1727424041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4cGKPJpzNJCSwjAbMhpal1e0iHKKUKG+dEV+7xk5Cs=;
 b=U3dBMTtoHoePo1otnWJHkRN/eHzuvvxQbQxIM8bkdDPhUMHv6M8IAW3L7bi5/vPY8P
 +DMj6GS4taeSSwby8rIgGbq7oudwbP0i80G12P4W+XXEreqmb2f53vy7MATbU5DH+1PO
 q3qR+AuDM+rIkvvxEOxgNKl5kcqyYlmDtJEGhH/8uJHRMhMGcILcIQdPBzuwx9BlxQ3C
 WRTkwh2YjebnO1bbm557DDOiJo9zwBoYTi0dynPcB+1tpcwNBAWrgMEog04vRXMD/eQy
 2kWvWHwwknMgl0DJJRkb4RYuHcQExJ6FAEftZEMbb0tNrflnbkM58lzdcOMskNiRbLon
 W7Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUylHorXWKN4TeVa6zokhKHA5aDWSAStrtrKIrutLffke5LS0SE/g219idmCTHtwxsoVEpKZLo=@lists.denx.de
X-Gm-Message-State: AOJu0YyD994J0nujGvryFXeEequklF9uSp9FbDdWAbkC6KYVxFVeSLxo
 +71+w/dlrNV2T6vsHa+B748dqvxmeRC1d9pa9gLH1zovJtkpp/FOH1MaGUy4/tQ=
X-Google-Smtp-Source: AGHT+IFshgioWtm5tvhyvNfUl2DBOKbcQx7xnjJqKpOxz9tGMNuMfFEsWdKJmqcKTXN5XyyzzDBSCg==
X-Received: by 2002:a5d:6d0b:0:b0:378:c2f3:defd with SMTP id
 ffacd0b85a97d-37a4226bbd5mr1202927f8f.13.1726819241104; 
 Fri, 20 Sep 2024 01:00:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:40 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:30 +0200
Subject: [PATCH v2 09/13] ufs: Sync possible UFS Quirks with Linux UFS driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-9-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7342;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cOAONTj6Y9STDTWMTerHgVAvbi0arJFt6Ki9NcHsPPk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7Sucu2vsdBlwUT0eW8BUa9o8BeFMMGt98KUVGY40
 40ytzwGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rnAAKCRB33NvayMhJ0YIFEA
 CCNLmPzVSCcCn7taZQ5jhK+qnO4LVQwacp7qOe8xssmz6QlF4C54ZdXoOVNOLnNRSlp53p5u4rtVva
 kK79+Zp2ubAMG5ragNIF0HOtVZAQfMuA/VT5CY/HkG2LN6dO9j6axfiNRWn0TSa9CNUhT9y4dMUooR
 a+cuZ+BO0r73YQ6ObskdvIi8qXOp9Krz8oz424RCAsQ4iGehcBxSefaygo6cDKHX7EMqLc3th6sCpe
 eRx9rbxRLu5lYGZUjPmhedi8PM3M6LTKXW8EYARiC8wRI6aeAcfOPKGPKkIOgmSeCoVOeYWd60SvNz
 obm/djo7TUnF+Y3YCUd9A7v7516U0zUCKtjtHWD68PO8uuS4ZSX1Vkju/oym04AyCIi21m+YTZERD0
 37SLOrP7BsZ+2z1+1J/Fs9V42HSI6+MHTxMVaRjYYk1IwwuHUPXWf/pESP7VZw8eTHu3Wts1CXyjbh
 VSKiTguIVwlS/pSsRgzKobBCfPEVEv+Y6Vykh5O0PoEl6qc/m0O4aiaSva0jZmza9EqluglhAdsz/h
 sLdO7+5kUGTrm+XZG6Xn/SvRGnjVoeuLq7OTPC/oacccZYAWfF3265sTj0OlmaPfIFnU9R4XmFGxA/
 AvOIHKZo/eVcUxbuNLk9Huw8IiyyxfZjgUxKVTaais9/IIjCRfbVkVTKeX9A==
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

Synced with include/ufs/ufshcd.h from Linux v6.11 release

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h | 193 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 162 insertions(+), 31 deletions(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 555f8a6857d..a1006b80e88 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -712,38 +712,169 @@ struct ufs_hba {
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
-
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
 
-/*
- * This quirk needs to be enabled if the host controller has
- * auto-hibernate capability but it's FASTAUTO only.
- */
-#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
+enum ufshcd_quirks {
+	/* Interrupt aggregation support is broken */
+	UFSHCD_QUIRK_BROKEN_INTR_AGGR			= 1 << 0,
+
+	/*
+	 * delay before each dme command is required as the unipro
+	 * layer has shown instabilities
+	 */
+	UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS		= 1 << 1,
+
+	/*
+	 * If UFS host controller is having issue in processing LCC (Line
+	 * Control Command) coming from device then enable this quirk.
+	 * When this quirk is enabled, host controller driver should disable
+	 * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
+	 * attribute of device to 0).
+	 */
+	UFSHCD_QUIRK_BROKEN_LCC				= 1 << 2,
+
+	/*
+	 * The attribute PA_RXHSUNTERMCAP specifies whether or not the
+	 * inbound Link supports unterminated line in HS mode. Setting this
+	 * attribute to 1 fixes moving to HS gear.
+	 */
+	UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP		= 1 << 3,
+
+	/*
+	 * This quirk needs to be enabled if the host controller only allows
+	 * accessing the peer dme attributes in AUTO mode (FAST AUTO or
+	 * SLOW AUTO).
+	 */
+	UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE		= 1 << 4,
+
+	/*
+	 * This quirk needs to be enabled if the host controller doesn't
+	 * advertise the correct version in UFS_VER register. If this quirk
+	 * is enabled, standard UFS host driver will call the vendor specific
+	 * ops (get_ufs_hci_version) to get the correct version.
+	 */
+	UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION		= 1 << 5,
+
+	/*
+	 * Clear handling for transfer/task request list is just opposite.
+	 */
+	UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR		= 1 << 6,
+
+	/*
+	 * This quirk needs to be enabled if host controller doesn't allow
+	 * that the interrupt aggregation timer and counter are reset by s/w.
+	 */
+	UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR		= 1 << 7,
+
+	/*
+	 * This quirks needs to be enabled if host controller cannot be
+	 * enabled via HCE register.
+	 */
+	UFSHCI_QUIRK_BROKEN_HCE				= 1 << 8,
+
+	/*
+	 * This quirk needs to be enabled if the host controller regards
+	 * resolution of the values of PRDTO and PRDTL in UTRD as byte.
+	 */
+	UFSHCD_QUIRK_PRDT_BYTE_GRAN			= 1 << 9,
+
+	/*
+	 * This quirk needs to be enabled if the host controller reports
+	 * OCS FATAL ERROR with device error through sense data
+	 */
+	UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR		= 1 << 10,
+
+	/*
+	 * This quirk needs to be enabled if the host controller has
+	 * auto-hibernate capability but it doesn't work.
+	 */
+	UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8		= 1 << 11,
+
+	/*
+	 * This quirk needs to disable manual flush for write booster
+	 */
+	UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL		= 1 << 12,
+
+	/*
+	 * This quirk needs to disable unipro timeout values
+	 * before power mode change
+	 */
+	UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING = 1 << 13,
+
+	/*
+	 * This quirk needs to be enabled if the host controller does not
+	 * support UIC command
+	 */
+	UFSHCD_QUIRK_BROKEN_UIC_CMD			= 1 << 15,
+
+	/*
+	 * This quirk needs to be enabled if the host controller cannot
+	 * support physical host configuration.
+	 */
+	UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		= 1 << 16,
+
+	/*
+	 * This quirk needs to be enabled if the host controller has
+	 * 64-bit addressing supported capability but it doesn't work.
+	 */
+	UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		= 1 << 17,
+
+	/*
+	 * This quirk needs to be enabled if the host controller has
+	 * auto-hibernate capability but it's FASTAUTO only.
+	 */
+	UFSHCD_QUIRK_HIBERN_FASTAUTO			= 1 << 18,
+
+	/*
+	 * This quirk needs to be enabled if the host controller needs
+	 * to reinit the device after switching to maximum gear.
+	 */
+	UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH       = 1 << 19,
+
+	/*
+	 * Some host raises interrupt (per queue) in addition to
+	 * CQES (traditional) when ESI is disabled.
+	 * Enable this quirk will disable CQES and use per queue interrupt.
+	 */
+	UFSHCD_QUIRK_MCQ_BROKEN_INTR			= 1 << 20,
+
+	/*
+	 * Some host does not implement SQ Run Time Command (SQRTC) register
+	 * thus need this quirk to skip related flow.
+	 */
+	UFSHCD_QUIRK_MCQ_BROKEN_RTC			= 1 << 21,
+
+	/*
+	 * This quirk needs to be enabled if the host controller supports inline
+	 * encryption but it needs to initialize the crypto capabilities in a
+	 * nonstandard way and/or needs to override blk_crypto_ll_ops.  If
+	 * enabled, the standard code won't initialize the blk_crypto_profile;
+	 * ufs_hba_variant_ops::init() must do it instead.
+	 */
+	UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE		= 1 << 22,
+
+	/*
+	 * This quirk needs to be enabled if the host controller supports inline
+	 * encryption but does not support the CRYPTO_GENERAL_ENABLE bit, i.e.
+	 * host controller initialization fails if that bit is set.
+	 */
+	UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE		= 1 << 23,
+
+	/*
+	 * This quirk needs to be enabled if the host controller driver copies
+	 * cryptographic keys into the PRDT in order to send them to hardware,
+	 * and therefore the PRDT should be zeroized after each request (as per
+	 * the standard best practice for managing keys).
+	 */
+	UFSHCD_QUIRK_KEYS_IN_PRDT			= 1 << 24,
+
+	/*
+	 * This quirk indicates that the controller reports the value 1 (not
+	 * supported) in the Legacy Single DoorBell Support (LSDBS) bit of the
+	 * Controller Capabilities register although it supports the legacy
+	 * single doorbell mode.
+	 */
+	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
+};
 
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;

-- 
2.34.1

