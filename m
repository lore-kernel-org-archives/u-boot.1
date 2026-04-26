Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170FDFF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A78C84312;
	Sun, 26 Apr 2026 17:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nUpT2vxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB79C84312; Sun, 26 Apr 2026 17:41:10 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B35780087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891f625344so82338665e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218068; x=1777822868;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GSYQhGo2SyIVxnn6Fpy6y7erjo+T2Ff+eqsbRqEQV0=;
 b=nUpT2vxHLV7tCZ+uxkx/z1bK8TGwlVWi1++pRTMuJyITVUxklB038knW6FW4vF3hZ8
 reesy2IZj6W+xM2K+eonR5lNVLi6pc0DwhphS1iMDyydng9/G/6SDMwwfve4EhCCrIPL
 Ym3OCHbAfLKcFXcmKomzuFLOzLO95jAZLPK5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218068; x=1777822868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GSYQhGo2SyIVxnn6Fpy6y7erjo+T2Ff+eqsbRqEQV0=;
 b=TGDTgQzDktE5tMBr438YyFMxURm3lKcqaFm3qXxmksi+1hA8FUyNMQ3Q55tFVDuBGx
 p9oAanYDQJva2YX8mA2ZdolpbCuxk3E3zvzfCgt68s+eK6czgctcZypGcua8154XVeFi
 cmXfXLmboIEJtfZ+oygMhdjezxADKmZruaNBhOa8BcSvNxuFL9NsmkajOxJAs9OSY9ps
 taUORf+Lo21aKWqYy/tS8NnHN6glDwnejazO5M9gQS1GKFPJIB50ENRMaXjJwHz6Jb8u
 nH0K6gvVSUn7rM0b8l2qwPai3uNh5OPlgRu140urIeuRw2UNwuGmIIwA19cliYbp3GEv
 by7A==
X-Gm-Message-State: AOJu0YysPPOn75OCepaFb8aMSB02sk8PiMbEEHrAqKREXMR5GjtDt5WU
 mVYpvALY/NRvgtwV1VY/B+n0zYP2m+jIPOE0AwdaH/ne/eN1SAm77pjtgsT6xBPSrjlxsl8XAir
 X4s04
X-Gm-Gg: AeBDieu/eDrj4H+KgsK3HeOaQjBMvz+RQ8Jgx16uYRlSBBN7HUALjbGh13mjqZplSPD
 Yl+Yy893mgu5/qNkp7+WOitDDYM3pHLfQ26ZFJA3syqeBnl/DPjgJBxpzewB1RJa6w1WJTv8dBW
 26dMI1V9Abvb4mY4oNppzUirJXvXfLGVYO/gwEh5kd2xdx3CP/viOnAg9nsERggC9R3laf3L/v4
 9PHajJN/er6dwfrZeFRZ2IWFmJs7sNSsrooZezTNdTqk/YimDk+McjpBw4pwgKmFLyPtFSD2wf0
 vmwGtzY9MhXPUt0S1qco6VpEJuHjQD4nY/hguFfVhJhfn4YKwoHY0iCWFn5nrogZhcnHtP0zDF2
 D+wHdm6qMpjpwbMicoMp8K3/TOfrbbEmGBnGPUyZHJBwxC/gemVFQRydD4YpUASW1xv9Yx1fVrc
 oIdtdJkr+Exr2784cdyTN3Ouwqvg7DMPTSy7zpoezEo6UiGM/9Lo1mDqjMVyYPrTI64P2cXincq
 kv7o32ZQG0dWwFXUaRUrRB/EZ06IRidLfYnsEbaOv8G+ZhGajHZernknCm0RvwtsuMJfY3dI2oV
 p2WwxEgQpbJ9Wk+9uqdbBrg5vI37xQ==
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-4891baf8d2cmr401873875e9.11.1777218067634; 
 Sun, 26 Apr 2026 08:41:07 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:41:07 -0700 (PDT)
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
Subject: [PATCH v6 6/8] fwu: add helper to get image GUID by type and bank
 index
Date: Sun, 26 Apr 2026 17:40:38 +0200
Message-ID: <20260426154054.2040932-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
References: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
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

