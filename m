Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D07DCF64A0
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC1788ED0;
	Mon, 30 Sep 2024 14:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rt54HqjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163BB88E39; Mon, 30 Sep 2024 14:44:45 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AAE088ED2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so35008575e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700281; x=1728305081; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfwAM8eYFpIw8iKfFTzwL5BidwOo+6kSHQGUrzEEd5I=;
 b=rt54HqjBpqTXUsIQvHdkf/L2wutQxVarEls+A2ZRe1yjqBs5tXPp81V6wkBGYrfAeH
 xAafjNtvVrxNoAI7GCgqIjK8K7J1vwxpBP+RuXVCnUomghcOjHh7e737m9daBspOalRk
 RTbkFgTU0GizNYAfydRnbt7YP/p5dGnCXmbI2Ss8009SWSqbzBuXpBlMMneGZWjIa0as
 HiB5xU06+1s1SlVZAEIhn7OlZGZgyJOzY178LjEYWpHZVTI+M2yrAZJ5X65j5Di5tHEZ
 aHrcGEuMS4Y4ZYoefLCCBqxWwsPGIo0rlJCLYQs/T++gvK0NQ4Pxlr/QqMNKqQ2rtBRV
 zLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700281; x=1728305081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfwAM8eYFpIw8iKfFTzwL5BidwOo+6kSHQGUrzEEd5I=;
 b=UarGe6GIHzOZx6swx7EDtjdNp7a1A7uf8NLT9IOqs3ye1KGvggHrmHv9qy7G9OkR0f
 D4WAuIfETHvHEVKoWQFwhAwy093/sX05DMExcmsEj0AvCkyyfWq6XjlpFRbsf2jNuEwe
 jnI3EUDV3kn7X4EUdNILQbrI0ZPrOjQcQPNw3FAt4M5EKsQZbuGQMPjiMIPJNNsGurHI
 zjcsrWATYPXgEizKAG6UmiGvzYSo3di4vv82xwkPlRHPlNl0jmVPQj8suC0yHjHrhRta
 aKYVCnpDIDM9Id1rVbhpw3FgJc3xLip6nEkTNzgH1Dhe4cdSHkSLm5f9HtaoeISOD+ZW
 ohXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGILGWnxRBswqb5ro8RM37mc1moiglD5QHWldfI5BIeLgUYYR0KVG/3PMQIEmgjqDEkEt1LY8=@lists.denx.de
X-Gm-Message-State: AOJu0YxODk5P3d0SxhMHseqlkVTr0fzBUhZ2S8tMfS/M7U3wkAit4PDz
 GTI5u6i0AcnfvqHHwcOgpHLfyehITaohY8bweIXfS6y1rJQDRUrVKjLr09+etJI=
X-Google-Smtp-Source: AGHT+IFs6x/3pmXU5ztFL6p9UWKyHmLBNvnHu5DnBC57LQVS/dbb0NWYNlMYXa6ny6Vw9v14AvqAkg==
X-Received: by 2002:a05:600c:3588:b0:42c:a72a:e8f4 with SMTP id
 5b1f17b1804b1-42f58434d37mr92980515e9.14.1727700281358; 
 Mon, 30 Sep 2024 05:44:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:40 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:31 +0200
Subject: [PATCH v3 09/13] ufs: Sync possible UFS Quirks with Linux UFS driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-9-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7573;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=q8fsmqgenbbQnBeevkHGjjRLOCaFmquIV/UAgOUc4GY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0rX+Gr+II5YcGNkhqwervTHmK1IEAtK1qlS55g
 rdCT/kiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKwAKCRB33NvayMhJ0d9PD/
 9FFKLpewFsm5rq7p/yphUpNRebqWkgpoLKQ05TlJYcXAd5lAcQnS/pTn8kOLTRLlmdEoLP0FlCKrRK
 y2nNTOdTl6nbdgRtGzKYMppA84EQwgCAk0cCyXQw5S90jPSwk3xhr+ZSy0cqhbq8tNC93IvdedEtaW
 r2N28ZiZiVQ2eXnNCdRjj8Okl++tVCQ+NIBEBdJsoUjsrjGBNeaw+SLoKH2IqrXhaM1HpiQFVQjJDo
 AKNvfIu+6LQvsg0kEbQVK2WyMSqky/zm7fi9FHj1iJ+xgMksqJuwys+M/XCIL4seluGYS9KqQATzI2
 9zbyrWpj2h0rrFz76MCoeGbfrpLgMpm3EeqMRgvLNneHrfqPBu62If7TAJ74aMJp1iaXomY2aSozVi
 k9LSNW9+JO5o4xs9R98qyJTK9/cga0oQ6Y5rpz5sO+CLSWE2yXA10W0zhd1nYncItvQiQZi4wf5PJL
 SFylCg2FSjvZVDq1Zcx61uJjFLWQChmtTltLlay43jKvYW3g4WwXJ5rS23Ohkzew2DU4tMUOXZKxy0
 jyYC+VXpnB+0fB+F19fbXxI0PrpXb+V/hmGcmYIgfhSxfgBjeRnTERzM/PIeolIKaG9MmU3YNFKRbF
 2mcmWY55+zJ6jDyTw9oahrB25WU2bfsxVG9qPLhPOtV17RZ4zY3UDN7AYlWw==
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
 drivers/ufs/ufs.h | 197 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 164 insertions(+), 33 deletions(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 555f8a6857d..c1c6d15db4a 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -703,6 +703,169 @@ struct ufs_hba_ops {
 	int (*phy_initialization)(struct ufs_hba *hba);
 };
 
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
+
 struct ufs_hba {
 	struct			udevice *dev;
 	void __iomem		*mmio_base;
@@ -711,39 +874,7 @@ struct ufs_hba {
 	u32			capabilities;
 	u32			version;
 	u32			intr_mask;
-	u32			quirks;
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
-
-/*
- * This quirk needs to be enabled if the host controller has
- * auto-hibernate capability but it's FASTAUTO only.
- */
-#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
+	enum ufshcd_quirks	quirks;
 
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;

-- 
2.34.1

