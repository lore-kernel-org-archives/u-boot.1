Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24D910F3DEC
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 17:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A850683CD3;
	Sat, 28 Mar 2026 18:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jrZoSSC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B3E80077; Sat, 28 Mar 2026 18:17:08 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6153C83CD3
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 18:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483487335c2so32888125e9.2
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774718226; x=1775323026;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ANRuDcH5uj8PwGl9AVCV/OxTcpSsUjtUcNfGEbS7lw=;
 b=jrZoSSC6myVS3YilBXJQGyYn6C3L0WrAC9+vuNZbEVBL2L6bMinqMFq7b3lMUcEy9u
 1UdjPVNbNbPTdF2Ozfx2Sun482Z5JfxCT7UmfQR7OOTHckCp2bQKzGrEOUD1m9Cydj1F
 4s64HmludU0qlHW5hFoZE1XwWPcE9K1iid+n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774718226; x=1775323026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ANRuDcH5uj8PwGl9AVCV/OxTcpSsUjtUcNfGEbS7lw=;
 b=WGizJMB3LVBqq24gkdcj0w3wc1zEp6dLzZSFyXoS+zC7Hhkku9E/0gKHd1CrgVUS5M
 Ie8lIS5NotsdAJo05GDz5P1wybUHYwkeAvnxYPFD1xN6meRfJhHGWG2wmT27bUeQN4Bp
 ferm6v2fPv4l/ZrVp9DWP/mGFAnKxC+kdwsGfkTT5Ef1IGO7K3FHCeO5fX5URQ0xQr5s
 yU9P1g8qZgjPCYsf28B3lh3rsVTXtcnYkZvo8IWZTd21weNEPWhQ8JoITdEQg5i/HLN6
 TJaU6YmDPY1FJu6trsPl2MBIqT0oIMxPkO7sG69zYCgosLHb+x2iFkP9gqCsNH13mudc
 idcQ==
X-Gm-Message-State: AOJu0YxuzlfgdIO0vrRctaR9PwjFO7Kz04Xg+nypy30jLiqxNrFYwcYm
 yueg3MXrCwSAicrcn0p22qMldIUCELfQF93A3rNfdrt/2kL7scSH3x4YWY2QWCUF+ZP70uQ24ym
 rQZZz
X-Gm-Gg: ATEYQzw4nGJlyCQgdCF0Vu0J8vDH1pHafsp/lfkv3V6L8TQ2Efxygwbc4EYa4kPQiYM
 gO68sD12FW9Yrj520vBn2U3K/gYGw6kYoVPEQBpopDyI2A9/++bpv8DxRfVFxNZvC2cBVhUDSdq
 G7yLAeJWgyRfYbKyiftNcVqmJqYkvvlcX1suCO0GYM3hAvuHn5nHuaB4BfUhrST/4SZD299BSFD
 qkQVwRyEk5v+6883q7vsckyXdidIh/P8+NXe11wY/qA/Ck6Rz3Prc8UqXjgntZ3zKvghRG4LRNH
 ordAbKhulvO/1+niHyajkgw7/nLTpUY18bl2FOf+ukvBm13KBOW0ZrSlxw3B/dbMcFAOMCHDdt2
 opSeZ2GmZ3Q65qMae5vBel7RT/YrY9x/pUXkHXaiSm37tL/ZDBD2/Qb8M2sqHUuqfy9IeuxF9B4
 8WTZaKVA+JLAb75/8YeEL2KTpBHmOStPAd1HrM8XBMFrj9idZGYzBOtv5qV4cUGUmfMZlNhAGfY
 8t/AXPxO/MY6006x+i4lS0ovrFL03sOplaAkG3kjlJSkv5mgVTtwplljhJKPtLuxiMAAsNt5MWH
 7eYxbuF2WzUneZkAcs/sLyn2
X-Received: by 2002:a05:600c:6287:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-48727ef1782mr113553035e9.3.1774718225558; 
 Sat, 28 Mar 2026 10:17:05 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b105sm332432465e9.1.2026.03.28.10.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:17:05 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] fwu: add helper to get image GUID by type and bank index
Date: Sat, 28 Mar 2026 18:15:16 +0100
Message-ID: <20260328171624.2377527-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
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

 include/fwu.h         |  3 +++
 lib/fwu_updates/fwu.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index e7bd1d492af1..47242629e404 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -394,6 +394,9 @@ void fwu_populate_mdata_image_info(struct fwu_data *data);
  */
 int fwu_get_mdata_size(uint32_t *mdata_size);
 
+int fwu_mdata_get_image_guid(efi_guid_t *image_guid, efi_guid_t image_type_guid,
+			     u32 bank_index);
+
 /**
  * fwu_state_machine_updates() - Update FWU state of the platform
  * @trial_state: Is platform transitioning into Trial State
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 0f5ef2ba5153..a2857d369b92 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -243,6 +243,30 @@ int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
 	return 0;
 }
 
+int fwu_mdata_get_image_guid(efi_guid_t *image_guid, efi_guid_t image_type_guid,
+			     u32 bank_index)
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
+		if (!guidcmp(&image_type_guid, &image->image_type_guid)) {
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
 /**
  * fwu_mdata_copies_allocate() - Allocate memory for metadata
  * @mdata_size: Size of the metadata structure
-- 
2.43.0

