Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E28FFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918A8840ED;
	Sun, 26 Apr 2026 17:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QsuPKd3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D5784348; Sun, 26 Apr 2026 17:47:40 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445AB83FDB
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so7840625f8f.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218457; x=1777823257;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GSYQhGo2SyIVxnn6Fpy6y7erjo+T2Ff+eqsbRqEQV0=;
 b=QsuPKd3gCkgkW6ll3BIKJL8ZZXGfe0CPX+QkRfEJXvd+UJcziHIwZfJn+nPcANpOst
 AMQhZkrhzoIHGJe2fszoqTsVo9Z5RzyNLPADLJdtRV99XlXluSaw6r+6FnhBohW+mW+b
 1W96VMavm/RW+W6YjdxU8REQifRLA0ZnHrRfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218457; x=1777823257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GSYQhGo2SyIVxnn6Fpy6y7erjo+T2Ff+eqsbRqEQV0=;
 b=XA4UU5/rrQCOWTmLDluM9Ybdxe/hzzH6VgvYLmHJR79LPG5st3FjrLcs0fD2DQrUG2
 iw+Sw+OD3tTI0dotfXqoKiYYJegs+UA5ipAs8Ix8eW83wDtCBM/ht4eG5OHZ4D0WiEmz
 xlFM7k/rHBLBvrdCpH8WIq+Lq8dxNgq/dQ74imnWzhbS/QBIEJCPOCXE8QpZxoS2gPQ+
 6hFujSH7AxEZUZVcbmsRae52VTPVBQ2RuT44A5Ke3rGCiliawjb0vGcmtV5SqbFBHwl7
 EhdP41GfYX9dYuXCG9jfC99rQmEmAi9RXVIqqqbeQoqpZamG0qVaj8nf6l4bffNIr8B/
 4TzA==
X-Gm-Message-State: AOJu0Ywd7AyYaOho0Ki2K9W/VjGOcRAcplcAWYYwgWbEI3oFytJm0kxd
 B7rHh+VnLPYfhc/nkREjtiTf1NO8a8fvMQqGUODm/mdvw3Sl0YUw2IhJf5BbfUElKziCc1PZZSx
 bK1Yj
X-Gm-Gg: AeBDieuxMG976WzsUq08s/GtH4J3S7qp2/EkLABh7OoWEcmrB67qkPGgl5J3sd5+Obd
 2Dit6rp8IA4Txp7kcmQ17fJo5qknOWrifLCJi0fM+KPafePCyBQHsU8o+E/taGb0DjOqkGqHxtx
 g8ibV0p1bLlQe9YN8LRdkGd6IIiBEk27fuOiz5bGKJ/CeGV2HPh75BqR8qUXHqRp8AtuvWGEieJ
 kSIp0JTcpVpEAb4MW7da1e4bLoCdomY5Kzs+fH3ExuR0yuX58sAGocHlchuI9N/HZNt4TqdvfUg
 fP2IJZZJYiPy9trOugewE2jYg450xaA17FpCjeVLZrkNeuuzB+WdP+YJJFEWfZlaJQT7Fs3BPdP
 4PKnRIzsOFRTBDv6loWpQGpkoQ5sUWo8kc3Sm0D0ZxGm3mf8zLKdVCw9TggRRBR9BF+A4SfuimN
 YjEsi6jdZtMdnjtTpdp4ET0ZY5+xJbWMb2xO82gQlBRzgs01hi+tquRdbnpUt7YlfkJ6J3FVGDW
 d4fitHhHZ3pJTXUAXaTpZNpsol0VUzUitruXJCW8hAtO0fFsz2CcZrXP57Nxj7GRgIAD407XSP5
 CM2dmKBD4UdO74enNgYG4TtgSDtrCA==
X-Received: by 2002:a05:6000:4283:b0:43d:73ff:fd59 with SMTP id
 ffacd0b85a97d-43fe3db9bc9mr60196646f8f.10.1777218457451; 
 Sun, 26 Apr 2026 08:47:37 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:37 -0700 (PDT)
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
Subject: [PATCH v7 6/8] fwu: add helper to get image GUID by type and bank
 index
Date: Sun, 26 Apr 2026 17:46:59 +0200
Message-ID: <20260426154724.2042569-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

(no changes since v5)

Changes in v5:
- Add Acked-by of Ilias Apalodimas (added to v3)

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

