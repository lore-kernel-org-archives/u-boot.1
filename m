Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EF8FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D0BE84119;
	Sun, 26 Apr 2026 17:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MELeNFhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6AF80087; Sun, 26 Apr 2026 17:36:33 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A2884150
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488d2079582so110393065e9.2
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217790; x=1777822590;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06sczhgbtWdNK8ERusWYcOlhVyUuYZr9/KPOpcPmhKw=;
 b=MELeNFhCW0p+J8QtH4E4cR3kIw/kPmqRy1Ly52nD6luKqC2VHNd5YGJWOWagLzcZEV
 TpVxIpfZJZYsuul096gzCYTu/gKM1p6nqtAqT42g8laoDRKsqUXKHkqoB5zOpspysJkH
 7BWTxpeCrBOKH426sd7UOspeCef9M38Pdbf/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217790; x=1777822590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06sczhgbtWdNK8ERusWYcOlhVyUuYZr9/KPOpcPmhKw=;
 b=O7ZbzV1oGuIBCgoY4jxotUoDV/J9cDOD+V5/uxeN1hlBs64mB99TMGa8V21BlDQYOC
 roUKHWWHvXX1RAmvH0wpksu22O1Il6/YPnPJUTlVf5xWmFMOUNvGndwcSmpwVxdJTe4X
 K/bpoo69hpmHDTlu8BcqpdhxVtBEibBJkU3i9JHmJhBLOsWaapi7scs19rBeHTjpsK7l
 ohNjHYpCsICLEx3LIWCFrr0Et0E+Of4MdMKuRNWieo+89Dt9CejydRyAdpwFPuhTRhVt
 T6NtSrw8yVtRyZpHY1OW9gk//AAEuKDEhJWo38IEB+xXi1KcATvLHU6872p05nzjA6sb
 SRhA==
X-Gm-Message-State: AOJu0Yz4SH8lg96PBJXVWII3rqUWZXWnNDWBAhEYFJrYzaTip0T3+Srq
 R2oaPRyUNssmharRnf16W5MoGoVBAtSd5i0C/ZblBMkH0reO61D+qKmrUa+Ci14e0bbIBaVHx+j
 MLsHA
X-Gm-Gg: AeBDieuDBmRKXalgO9C/TvwkAyB+vL97hDF0iZgvPqFrZwlRjWhqauK24QViwGnTgW4
 O131ppKxHn7otT4zCIXsdEFt/Yjil2kMIFqUn/BVlXXVH5fPgK4i97D4JmvKRIJU+HmsDCOl1Wq
 /DQYOSX5yDfpfE2f6yCwnnoSOjIPLhIjK/uqbWnQRUT+422mvojb30eHsFZ1D0f0SLJfhHCrs/z
 Ev0Yyhj8gzR1Kxv27mV4cEqcvkUiFsNBr6edUFqhO9l4knFl6lYHDe1bHEV0ckXhjpgH0M3SZdN
 ogIpteFpo74H4Jivwogei08lyJK8NJaGiBOI+sdloS2piBovSJiGI4hHWwmok7gDIJvwUCR8HHX
 I20Gall2McKq2d0w8yWloiOJaCYb/bs4vsb3QxTosB+/gMnDUQm2XHzMQg5sOfoS9+vn03FiJCX
 Eg93lN69bPs38ObbE0FTXAW1kl8ix7diQ0afjWkEEy1FFvBJvAauDDdgno10wO5CR6B3xh5HJ59
 dXYTnWjmVAt5zFdnYfEw7uUxaAiAB0N7Lf1JfU/VzlaFP8o8Cyxk7JvIjN2Z9SXnzzukAjt2rA7
 5Tz9wWPzxICP7ABw4T9Q0bQeQDh/yQ==
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-488fb73aa3bmr573546275e9.3.1777217790527; 
 Sun, 26 Apr 2026 08:36:30 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:29 -0700 (PDT)
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
Subject: [PATCH v5 6/8] fwu: add helper to get image GUID by type and bank
 index
Date: Sun, 26 Apr 2026 17:35:31 +0200
Message-ID: <20260426153617.2039651-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
References: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
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

