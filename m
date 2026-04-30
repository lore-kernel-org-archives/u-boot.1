Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4703FFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFD984659;
	Thu, 30 Apr 2026 10:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kzBThG8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C9E08467A; Thu, 30 Apr 2026 10:06:50 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E4C84198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so357861f8f.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536407; x=1778141207;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GSYQhGo2SyIVxnn6Fpy6y7erjo+T2Ff+eqsbRqEQV0=;
 b=kzBThG8N5s3+w+78IMDR93/gl9WyZtk4kLCj3kDjjBd+QIIXNg0yntKYeCAit+2YpG
 YbM8Vvipg39D3SbO4tQBE2zvNCsl/aVVIg8lxP6ZkkTNDoJ5bfLR8yooF/VXqHU/pIdC
 Ek+VaQjKIL/X3fBVrULxoMoX5Di5IbaiWwVqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536407; x=1778141207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GSYQhGo2SyIVxnn6Fpy6y7erjo+T2Ff+eqsbRqEQV0=;
 b=mfsTBRU19r6/YwG/VqIoeXZdQCVrQPwvbviurety7RkfswSgNb7svJ6aW+is3+41gk
 Tno2xWxSidkoLpQOB3P5FGVQjRc33s5GcEsdG6faCP8rybOi5ihdxAQc9Umhc0NazWUV
 scVjlivUXzHes8mgufGowaYU3CCntIHLuTvUPHZ6bA6War3QrFs/kEfGpemC0s778n/d
 OdffwGNCgHPf6vmD3GHHsJGDjRNhX/0CXAmwRN0tDAR2SDnGyizrjrF42IoFzbDttHsE
 jl08c6qcAyPdO04pEKQcq2/nO9F3UV9XyA7LoXZveO2rH6jniu5jtVAYVeUcw8XWlB+H
 iAYw==
X-Gm-Message-State: AOJu0Yx0x5Vr+MrF0KL4aRQgv2IoRuWThUSm6njB/GJmKJmcgFqbZbTQ
 Yn5sIRrqcgV5YF12niRejwORo8TUXN0MurYO3wFZp8zb8+WV5tzki6CgiWUhS10XpI3HgoiguZi
 gMdXa
X-Gm-Gg: AeBDietQ3nTmK828fqZ4cBNAHX7WXUjtCFjAwO31ep+5PMiY9mAVAywxxmW5HyJIPiV
 d9u9SyHwM7hGmq17sXE9ILe73x4o/4EKlCBJz/4pJL4fTI0XMMv2TzhZl89g4fIbIUdS5JOsbvM
 bWUldavlH702neGUc/DAyvYBuJx/LMVR1OC0BD6vjYhHQMPUhGD23gBNXkszEF2KH8FcrRApzJF
 2NHEJCutzAdJAaBVrTZgVCsvkN34nGDgrgg/8iPPMwhq/pTmNdmpGNj+rmH8RTQy/v1UwSwyTmS
 3LAawA9sTxpvP1OavdA2fa6W96OnYKJNUasF1BWG0pr46dVk625KZZsUKVNvLZ5iYRwQBTEiygt
 wCVW0/lgbEan6uJarFOLNVXoDto4K3Nw4pcqNXRIfeMMu909v/8AgBkkJSEZ+Qb4V6nEUspRQwQ
 JHEwwclHFI0v7xEJYN5nvZ+TOFqoLbT+aS+RjCwQxAOs7Afo0ybPW2Jrkh6vK+lsOmyps5tqtsH
 q65SFh50WQzUZk7X8GkpG7PojSTonMW/ULXhB+4ELwqYpVRsjGzCqqUuWcJSJTiBkieRELGVrod
 2BCOsrKUIkkx+2kOFwgGU1depo3KAeO6f4yevva963I7Ng==
X-Received: by 2002:a05:6000:40e0:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-4493cc3fdadmr2932222f8f.11.1777536407032; 
 Thu, 30 Apr 2026 01:06:47 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:46 -0700 (PDT)
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
Subject: [PATCH v8 6/8] fwu: add helper to get image GUID by type and bank
 index
Date: Thu, 30 Apr 2026 10:06:07 +0200
Message-ID: <20260430080627.849636-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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

