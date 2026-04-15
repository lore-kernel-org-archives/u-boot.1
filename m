Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8C7F428C0
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39890841F2;
	Wed, 15 Apr 2026 20:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XDSxH6Cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DAD8422D; Wed, 15 Apr 2026 20:33:15 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1746841D7
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso74889555e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277993; x=1776882793;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCAR4bHfuzLtCYDWhI3svjkqvfHud+Ornn0vBeRVnY0=;
 b=XDSxH6Cz3sGEb64oypSUTU0+cnljuQDFUuBSZ2LNVYLpf4YMFakfDHUxRCOgNvjiQD
 WkrqhwF4itobV0P1ZWBShdM7NTsq8hrlYw9XE6hXAKGDzjPoMpZ41J5kBvBY7c0iEd5I
 CEHh9MWhRFMEjwW38FF6+nOKOrO4CRx4rsmMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277993; x=1776882793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uCAR4bHfuzLtCYDWhI3svjkqvfHud+Ornn0vBeRVnY0=;
 b=LSmNJ8fx0BVX4WRoi0e37YxsfM5pvCR0YyOGwkfTvi/expzTc4H3uc4iWBKObe0YH8
 PPXVh7Sxd5c+7Y7MgFnzxsECRbxb2ol1nCXsJ30mCk7iqjPCiVaYjHR0AOTUpTaJffGm
 zHCxPjgc21cn3U1HovJ0vVAeAainblqHkP0UFHUMJtWR48Nbs/LYy9y66nhlyChoVx5z
 bzE05wOxx9nRe8AR3ciAcnBJtSZ1YkK++OjQvrYQ6OZ5aXw8D+A7T07OI1RiSzJBgLie
 hqQ4zDv5nmdOu1uW2DduYgNEpZ6uZEjsromDiOfSbifh/p5eV0XjjsaEechinAtOygNf
 LlEQ==
X-Gm-Message-State: AOJu0YycoMGvkvdugOFvU5DdfdpDnZV1LtX7Jrw3eEKCm1S+ZyHfCB3g
 NEGUyGUilMb6Jq0cSzv2PYR0QSJMqiPJGGyo6k+dRV8khX0vj4lSA+DzfyN+wpHf5YUAwxTjUfW
 GeV9O
X-Gm-Gg: AeBDiesHXVOJkKbE5AqVL7ZGATQRBJT8xx0U5SLmF0OQUwBi2o8qQmre6JKed3MPWR9
 jDkzKaJfn2/pNfSun0R2O+1gi/IZByMZ8/yg1mys0URkvcdPkEsQmWLyNPeWPLpyw37syxPVGm6
 69dRLQKKXt+OJMXPFZWwHs86xOgq68omB37/cN6euFv0qBoF9y8uiZpzWjjxqelxfvejoEdQ95A
 11R9LktSbU6WKYCr65LXP3sKLQVUYyN1RVxoBF0p/UIr9eGqeS59LNYjXdpdX7FG1/Cmjw68hhw
 oYR/sgS1+jkK2VhwBdL2N8xBxAys14qfP/1Y4pwF5Ky8Gr0049nbeOKXB5aKUBgcoxr33FNGft1
 SDWl+e4FQPYVBlGGv9gpTY9rZuGuo1rgKqE0PTRVVuj93nvkgbIbKHB9nfg8fYWs6zWsh3Vxnxk
 qrkF1+Q7P9PIOuaIv9kKeZPpm5rhioPPmutoQHrwRQRFp71mPJTBp7F/tbGj3lWdg0vlyhImsD+
 kUELBHJzsrkG6DBlXuNKmM8S+uaMsW9TE8pk0h7e7JlnGeAQd4EHEa5Yg==
X-Received: by 2002:a05:600c:8b2f:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-488d688d46cmr293152095e9.26.1776277993020; 
 Wed, 15 Apr 2026 11:33:13 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 6/7] fwu: add helper to get image GUID by type and bank
 index
Date: Wed, 15 Apr 2026 20:31:33 +0200
Message-ID: <20260415183250.3031030-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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
index 37c613014d18..e5e4907a2d43 100644
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

