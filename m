Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBB3EA7190
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58CE8842D2;
	Sun, 19 Apr 2026 16:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nNVCSNZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C010E842E7; Sun, 19 Apr 2026 16:33:08 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C820483B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so14596085e9.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609186; x=1777213986;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35oH3mslwLGRRway1ir7K30i9wTZHNIramSRlzIVcYQ=;
 b=nNVCSNZR1VlzcJRz33qjUOSYXAIRPl/IlhSyeyneYPL12WPEgUR8pnz6AQjMqNxv19
 p5re5ZtaMjaxq5BFOcIwoOG/s90QOrKWMrm9ZS7EJusgMirqmZDQOT1igKOHMyNl9Mmq
 TKmbOrSFcvpYegEXS5PWj22NOo+TRH5HtbMUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609186; x=1777213986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=35oH3mslwLGRRway1ir7K30i9wTZHNIramSRlzIVcYQ=;
 b=YzLJAC5FhNRw7o04ZrG/5eNNafT2RnJEM87mCqGysnowtUdDbBoOTCxbu2PhV99Kfj
 9ARWcAkerAzTHSoxY51puvAbrdOqj/alkpF5U/11z+OgId+SgHx2PFMKUipEGmcEmifh
 +dmTskYgdftBmq9E3rqjd2dP/rajcQyf8X45bSoFrU92onaXCnw9fh6cV7MDOwBD56PL
 pHvpy7mzBnzzjp2xiAHAUSvy/Ap4M5T85kb35XiIYsc6kUDTzMqxmug0N6K/mZACaJvS
 55ciUm5RYqsA5lKAi0lu0alvO5iXi26Pjs7CBB4IQeoJoargD7eyE+toiYB6OgZbrNHk
 fdCg==
X-Gm-Message-State: AOJu0YyRw6r3e2+1mcYMk0ebSoia5x7rSqBqC2BpFu5cknhpJckQcL0x
 WgOUvcxyHJHPwRdHjjn6cA3eFujNGjgnLJ/1tpHKLT0mehUkg3R92dZh7V4ZNLp6JI4cN6HcgWH
 ZFB/g
X-Gm-Gg: AeBDietazyWsV1k41hEKEj7JRERi9CEBnDyFos95VuXX6suXJHZGye4hkFTAbq4/BgS
 rCxJqQ64v/7hpwz45hf+qGYjTjxhQesEqWSo0jr7bPnrhDR/nTCC9lrMtaSE+IwWoAZNxyruizH
 7nnuAdguabjrRG5OirBTIYSgaICNpSueSZOk6u4p4tDV0XUxq2lwHemLkUCL+SLaj+Tl3B8fF/A
 zn263nPdMyjnugNimgif4UD7GAOo50/Rbu39VAvza1mz/m3SVux1OumnvLmAppjp/DMN65fZBUq
 yEGRc4j5FCA/dUWHYrrC86bFfHnOu4sf2WX/ARjqMavwa/iv591PFN8wb17q98/AuRugKGN12w9
 YneoOGfLbTwpddsPy411LqHcfOUH/w+5ijTK4JFJ7w3qzGCeVUzOiEXgmQLL1zeUfq6q2oc6+qe
 SZxY4V7YUS34EvXqsqayJDOAVFX9I2bZDAvhb0a1yooTDdXQudcLw6rtw38JXWrfDuunesZTXg7
 BQU1MHI9txxHhmmC0thN1x5VCUNXljCzkUCRbdzU+CNf2a3Rwf9hCDNMaVLkKjTwhdvf92F729p
 jRCLUlhNlXBUHb6sV0cvnDWH8GeFinmu
X-Received: by 2002:a05:600c:4e16:b0:488:d6eb:e63a with SMTP id
 5b1f17b1804b1-488fb76fe73mr140754565e9.14.1776609185929; 
 Sun, 19 Apr 2026 07:33:05 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:33:05 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 6/8] fwu: add helper to get image GUID by type and bank
 index
Date: Sun, 19 Apr 2026 16:31:46 +0200
Message-ID: <20260419143247.437733-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
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

Introduce fwu_mdata_get_image_guid() to retrieve a specific image GUID
from the FWU metadata based on the bank index and image type GUID.

This allows identifying the correct partition in multi-bank (A/B)
scenarios, ensuring the correct image is targeted depending on the
current bank.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v4:
- Add Reviewed-by of Simon Glass

Changes in v3:
- Add kerneldoc comment for fwu_mdata_get_image_guid() above its
  declaration in fwu.h.

Changes in v2:
- Add kerneldoc comment for fwu_mdata_get_image_guid().
- Pass efi_guid_t by pointer for consistency.

 include/fwu.h         | 11 +++++++++++
 lib/fwu_updates/fwu.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 9cee8fb085cb..68a51fb4296b 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -396,6 +396,17 @@ void fwu_populate_mdata_image_info(struct fwu_data *data);
  */
 int fwu_get_mdata_size(uint32_t *mdata_size);
 
+/**
+ * fwu_mdata_get_image_guid() - Get image GUID for a type and bank
+ * @image_guid: Pointer to be filled with the found image GUID
+ * @image_type_guid: Pointer to the image type GUID to search for
+ * @bank_index: Index of the bank
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
+			     const efi_guid_t *image_type_guid, u32 bank_index);
+
 /**
  * fwu_state_machine_updates() - Update FWU state of the platform
  * @state: FWU bank state
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index e82600a29a40..2b11e5da061d 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -243,6 +243,39 @@ int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 	return 0;
 }
 
+/**
+ * fwu_mdata_get_image_guid() - Get image GUID for a type and bank
+ * @image_guid: Pointer to be filled with the found image GUID
+ * @image_type_guid: Pointer to the image type GUID to search for
+ * @bank_index: Index of the bank
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
+			     const efi_guid_t *image_type_guid, u32 bank_index)
+{
+	struct fwu_data *data = &g_fwu_data;
+	struct fwu_image_entry *image;
+	int i;
+
+	if (bank_index >= data->num_banks)
+		return -EINVAL;
+
+	for (i = 0; i < data->num_images; i++) {
+		image = &data->fwu_images[i];
+
+		if (!guidcmp(image_type_guid, &image->image_type_guid)) {
+			struct fwu_image_bank_info *bank;
+
+			bank = &image->img_bank_info[bank_index];
+			guidcpy(image_guid, &bank->image_guid);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /**
  * fwu_mdata_copies_allocate() - Allocate memory for metadata
  * @mdata_size: Size of the metadata structure
-- 
2.43.0

