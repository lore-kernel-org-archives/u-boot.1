Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72508D73094
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE93484132;
	Sat,  4 Apr 2026 17:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T3P1QbP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B4C84178; Sat,  4 Apr 2026 17:27:05 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0F984129
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887eca00c4so18314545e9.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316423; x=1775921223;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBbe/3O88q4H84p8+vNuWLUC8LxONfOyv9MT1gkDBL4=;
 b=T3P1QbP/giMfbrtuMPSZnKB3tUXmnToa6Fpoe9QYy/hmwNltVwOKQlv9E+fWjK+xaA
 4z0FC/kbD9bGJhMDftIKAW9iDYjiQgtN2LhlR7W2DuAe+URh545O+wVk+ymwaqU8DQ44
 dcXV5mWWkcnOf6FV3t3YxIgdALkfDAjBhxSwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316423; x=1775921223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oBbe/3O88q4H84p8+vNuWLUC8LxONfOyv9MT1gkDBL4=;
 b=Qtk6xDHUEhibqroOH4df13jhLxC+AzeMKSeVCVZukJMhNzIU/DQsTUtl65ibGd9tOt
 aMG9hUeEj8OyGz+PT6jVtTk7pq+YdhWfRk5Yn/ron2hcWD+VH7JnASoizsApos2Fr+bv
 ga/sXwY/LuqQrMthkxWJfNKwqZnLuO/MkRFGPKyajjMXgqZQrlmEYY0WQ0SE+epcTwVC
 Ur/Sd7QD8nW1JO28jK5zAi9VGtLPLScsPL+egG36EiEPwL2ofrTdte1njNytBwcO60dG
 r7H2nupL4l5Ob+WP6tmbWBfawi54hQo1iH7p2L0qKpbf/13m05P6VIZXf8+OLDIf00Fc
 KW8Q==
X-Gm-Message-State: AOJu0YwCys9CLABdfu5Y5ljvNp/6yi/Mt04AxYD3ybIFhXZ+oHSMgW1x
 KyxAWoTZPT2P1nZ5BxGg/3C6fsf72I7e2MEr8zezYPEj3RWHICMmL+yu42Mpk/mXxN52fih0Xaz
 JVg07
X-Gm-Gg: AeBDievmN7/Sjn/EvMN6rj7/p+l0OXn7iM0AbjRxLwpXaq65JgtjXyz6i1yVw8MxhN5
 O1+FwUY2Nraaog326KJ8sAy1M/hv7AL7SdeqG5rS/ljrpcgknWDPF37nn5QT6agJFoIj89eD0ou
 RID7/rU3o3hF50nGpIgh5UbPi9yzF0ZZ8Y9jacMO/I6Oe6YmaFXZgDkgCai4iK6ypSWOBeKVaKq
 GUeuGxempSk/uQM0n/0ELrAcA9Ie2SKpNV+lZk1/vZaaOPrhgJQOfQnotTTwfJoYZtb9lNAXVtU
 qcMuuSqvhOYGEp8EsNlMN8DjZ6BS88fm/ITJpSWCRSTcJevUIQp8c2oDBY11QN77d50iQ4No9vv
 dP0oeCaSbyZAD7IhL55a8ZbuI+jZDarNjoybk4MrWtaLM1nY0Bos0PmKgD5sNJVPdEYxbvm3PWC
 +amLbvRZf5SoCX/2f+4iqKGN5qtLpJZFTl+Dokal/LZ8NcMvoO4YwrPRjNIKHF5TEpQmUfM8YM0
 xf6bXQbn6ixdY5+PeSZaSGoXLh/dInd3b7T617HUV7Acmad/hokucsQjxynFoRGjJLtE+OhukpF
 dSVldZEWGAPWzSNZnV1JJdGS
X-Received: by 2002:a05:600c:4593:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-488997dda87mr108407655e9.20.1775316423025; 
 Sat, 04 Apr 2026 08:27:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:27:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/7] fwu: add helper to get image GUID by type and bank
 index
Date: Sat,  4 Apr 2026 17:23:33 +0200
Message-ID: <20260404152640.3297713-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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

---

Changes in v2:
- Add kerneldoc comment for fwu_mdata_get_image_guid().
- Pass efi_guid_t by pointer for consistency.

 include/fwu.h         |  3 +++
 lib/fwu_updates/fwu.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index e7bd1d492af1..40b12810d5fc 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -394,6 +394,9 @@ void fwu_populate_mdata_image_info(struct fwu_data *data);
  */
 int fwu_get_mdata_size(uint32_t *mdata_size);
 
+int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
+			     const efi_guid_t *image_type_guid, u32 bank_index);
+
 /**
  * fwu_state_machine_updates() - Update FWU state of the platform
  * @trial_state: Is platform transitioning into Trial State
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 0f5ef2ba5153..b26b244cf855 100644
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

