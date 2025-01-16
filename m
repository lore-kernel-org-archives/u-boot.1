Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7B2C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6637880702;
	Thu, 16 Jan 2025 02:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3viR6SB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D29807B1; Thu, 16 Jan 2025 02:28:24 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0530380214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3ce7935d38cso1339645ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990900; x=1737595700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/TRfYl5YLvTn/Od68z+/ZTttxDsYoliaaofZhE2PaY=;
 b=f3viR6SBT1zOZNb0HjEkMAzeCKWHp0OkdXEi2kTsi68YUnPEi/hWz8vJnKY/rYDBLq
 /Iw2mNnPvW4k3tQYDxPyyVb9CFlo9YNzO9XprEV3OkgZlj/R8e9aFlX0nQSHteIo/wIK
 DOvtgkwER2cfS5J55ERCMuBqDatPV1nGk29oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990900; x=1737595700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/TRfYl5YLvTn/Od68z+/ZTttxDsYoliaaofZhE2PaY=;
 b=vfHi6z8JmW0Z3PIUpHTThIllNZe9+fMttA9PcmQNPUFnwhPCg7PO7j0EbKY5AQXldt
 fcErMkyxAnnvbpOlpAQKlmA2eoTGpX2xWqrzLeWrdEx5qHCn8aG/xYIbSlV008T5v+xP
 SczwF1R7gOOTaciiebm3ZUkhts37eTXTMllTZuMFTU55s7bmqyDUTW3quDzNuSuU973B
 stcxp7oN4m80ChRA0EBuwYksZRkhJbJt7EbBbVGEJz+z/X49+ltk3Jee6sEfupFZOEfV
 nEMVewUO9Q4F1C+gNc3PYCH72cjFUHBAvgpNlT2P+//IngAlK97ZrMbT9jSUroLeB7jK
 Ct6Q==
X-Gm-Message-State: AOJu0Yw3W0GzOebWMMELahzdZ6Znn00Jyui8wrzajHFcoGhctaOKdC6h
 srHBLBdYfpaU+031OedmzLQGC92oPybesWNx85AuLTKoxKycJc8j7BF/GA0dWoXOXoDAryK6bp4
 =
X-Gm-Gg: ASbGncsUgaa7gNYRNLJnYfyUYCHIUm3wJyGrZJWL2cb1Gq0ODaor7wza1N+gsLiJ5Rp
 bXKG/boUzj1H0HwE5D0I0RCPl33DL53q8vnrOTwSHxMxPWkasHeQw+gwGqRp28pm+T9ovrbxphY
 IYtf9ylLl7VxlF+mgX1pD14qeknJ/LP03IqjSYrpiyRx8ymB87vdS6IRzvSLriZ9y6RP5LF6mEr
 2Upz1LZ0oGZf9hX7e7vveYklnGVQ62Dw4hsAaSWW0GmeOMBu84CK/X0O4mcpaZuC2g0cO6w8nLt
 MCkiheOdUMoN5WjKig==
X-Google-Smtp-Source: AGHT+IGgUejNAwXshmtw0G58NZbFfC4SdwOEePBauSV+gZKFFJq1LALRoFBaa1T30krFFuZU2k6D8w==
X-Received: by 2002:a05:6e02:198e:b0:3a7:8d8e:e730 with SMTP id
 e9e14a558f8ab-3ce3a8ec729mr239028435ab.22.1736990900208; 
 Wed, 15 Jan 2025 17:28:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 16/22] spl: Add fields for VBE
Date: Wed, 15 Jan 2025 18:27:17 -0700
Message-Id: <20250116012723.2820301-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

Add some fields to track the VBE state in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/spl.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/spl.h b/include/spl.h
index 43b344dbc55..781e5a2d638 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/spl.h>
 #include <handoff.h>
+#include <image.h>
 #include <mmc.h>
 
 struct blk_desc;
@@ -265,6 +266,11 @@ enum spl_sandbox_flags {
 	SPL_SANDBOXF_ARG_IS_BUF,
 };
 
+/**
+ * struct spl_image_info - Information about the SPL image being loaded
+ *
+ * @fdt_size: Size of the FDT for the image (0 if none)
+ */
 struct spl_image_info {
 	const char *name;
 	u8 os;
@@ -276,6 +282,7 @@ struct spl_image_info {
 	u32 boot_device;
 	u32 offset;
 	u32 size;
+	ulong fdt_size;
 	u32 flags;
 	void *arg;
 #ifdef CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK
@@ -316,12 +323,18 @@ typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
  * @read: Function to call to read from the device
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
+ * @phase: Image phase to load
+ * @fit_loaded: true if the FIT has been loaded, except for external data
  */
 struct spl_load_info {
 	spl_load_reader read;
 	void *priv;
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
-	int bl_len;
+	u16 bl_len;
+#endif
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	u8 phase;
+	u8 fit_loaded;
 #endif
 };
 
@@ -344,6 +357,32 @@ static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 #endif
 }
 
+static inline void xpl_set_phase(struct spl_load_info *info,
+				 enum image_phase_t phase)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	info->phase = phase;
+#endif
+}
+
+static inline enum image_phase_t xpl_get_phase(struct spl_load_info *info)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	return info->phase;
+#else
+	return IH_PHASE_NONE;
+#endif
+}
+
+static inline bool xpl_get_fit_loaded(struct spl_load_info *info)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	return info->fit_loaded;
+#else
+	return false;
+#endif
+}
+
 /**
  * spl_load_init() - Set up a new spl_load_info structure
  */
-- 
2.34.1

