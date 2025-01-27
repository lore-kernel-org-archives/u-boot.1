Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEEBC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BA980725;
	Mon, 27 Jan 2025 13:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWaR9t8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC0B2811E1; Mon, 27 Jan 2025 13:34:56 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB7A805DA
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso69745325ad.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737981293; x=1738586093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLTVnvXKn3d19xJJuXZCBVLy73ohjQ2hgAm1tUuMVI4=;
 b=PWaR9t8X/odFT5dBxY9MC6dbM2DRVCZjsIwle53V9kYwxQ1qSAoqI4MUhz6p7IoQ9c
 xQb2UhLrVB6e6S5qEWuJyNB3iIQy24PmdDXwsgVvraL0nhW1O1IpNXVy1pS0f1DL9lXi
 tRBZTgEAfmuNL8XJgGw1PbVZcbkCyFLDcNgQbhhY7g6aN+JaLYAxPr6YYGxz3baBYB/p
 ME6yJVfg8OeCu3CA6li7ulvtisQ0uQ70I7EeLjHAzHe1Z0UW7bxHEIN1WR3I1UpeAyaY
 8eKO2y7CQfQWoO1ynXfKg+UPlzxxvza28P3ktUEWOMJTOEop2OXQhF6e0ZXeUF+YOFUY
 D7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737981293; x=1738586093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLTVnvXKn3d19xJJuXZCBVLy73ohjQ2hgAm1tUuMVI4=;
 b=N2M9F+PL8eP0I4aDORhE2LJr6qikaRi8soWPp2CAafIzO8/28E6Wr3dPuE1UJYFtvu
 PEElOr0n9OMglfaMtVQnTSFJZonXnsojghP6W8w1jniwJwncbai1HyelsDsuvbSmJkFM
 RFnjRMsswdx8S3QrkYYKdkK7W1jErIUvydw4sIzp1NHMhmB25K+17seSeufz6OasrHDs
 T0mQXL8KSwXFXbDgQNxY15u/hYE7YlrHM4q/BmHyOZyCfGibpnaJyUfh9W6VIk153rqM
 e3AQU+7mF5hMghQfCSQ5SldtZm1hD/knYQODSiFX2byKdXpW0t3G/8qs76/v/bR8co94
 Kq7g==
X-Gm-Message-State: AOJu0YxWF+TlBYOz6OvGOuc+S/uh/mslt6QM0WNPZy2UR17hUFeLKa2P
 9aFqc5S/3zLIqgVKEF4n/OCMAi3Bgr7SGKGV6Lvhl0C+flw0faW9AbNmY7+G
X-Gm-Gg: ASbGncsrbvMLmUkdrl9C6XS0sdYYxNimWpvVACFZSPJUBI6st8yeC+n6z4s0bhuwDvS
 qtbECfIyx8kbR1YLu5KuPGc/HCgXbnzv8hzsXSabyLUwxqEX/rkhhqmMfp6MtPABM4ID0AkAlr1
 bYu9XNOrREjs8tMEZzZSXJSBky3tWRzqpBQFzvaqBNzrEuYx5jLoSfcxX2UHPZ67oIBV5PhYcFH
 5ql4vdoXMnML98OHz1zXLOqs5SFpmwEqj5cSiG+6ej9vplH7ycw61fj3O/l2f5ea22kVqjpk3Ch
 F35QUScNm/JItwumWXAqlQo=
X-Google-Smtp-Source: AGHT+IG9a5KYKoLHCHIKlvE2j0ym4dUzY7ItKkRAM7ZwcmWTYBbDbYI+VdWutX/ZNFDt0vNZfRGEYg==
X-Received: by 2002:a05:6a20:4312:b0:1e1:becc:1c9c with SMTP id
 adf61e73a8af0-1eb215a0501mr66998968637.28.1737981292840; 
 Mon, 27 Jan 2025 04:34:52 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b51e7sm7222630b3a.69.2025.01.27.04.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 04:34:52 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
Date: Mon, 27 Jan 2025 09:34:45 -0300
Message-ID: <20250127123445.1040480-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127123445.1040480-1-adriano.cordova@canonical.com>
References: <20250127123445.1040480-1-adriano.cordova@canonical.com>
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

This commit fixes an use after free introduced in Commit e55a4acb54
(" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
from wget"). The logic in efi_net_set_dp is reworked so that when the
function is invoked it not only changes the value of the static variable
net_dp (this is how the function was implemented in e55a4acb54) but also
updates the protocol interface of the device path protocol in case efi
has started.

Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path to HTTP when loaded from wget")
Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
Changes in v3: initialize ret variable in efi_net_set_dp
Changes in v2: use reinstall_protocol_interface() and new_net_dp in the body of efi_net_set_dp()

 lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 67593ef50c0..f696a47060c 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -925,12 +925,15 @@ efi_status_t efi_net_register(void)
 			     &netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
-	if (!net_dp)
-		efi_net_set_dp("Net", NULL);
-	r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
-			     net_dp);
+
+	if (net_dp)
+		r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+			       net_dp);
+	else
+		r = efi_net_set_dp("Net", NULL);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
+
 	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
 			     &netobj->pxe);
 	if (r != EFI_SUCCESS)
@@ -1055,18 +1058,58 @@ out_of_resources:
  */
 efi_status_t efi_net_set_dp(const char *dev, const char *server)
 {
-	efi_free_pool(net_dp);
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_handler *phandler;
+	struct efi_device_path *old_net_dp, *new_net_dp;
 
-	net_dp = NULL;
+	old_net_dp = net_dp;
+	new_net_dp = NULL;
 	if (!strcmp(dev, "Net"))
-		net_dp = efi_dp_from_eth();
+		new_net_dp = efi_dp_from_eth();
 	else if (!strcmp(dev, "Http"))
-		net_dp = efi_dp_from_http(server);
+		new_net_dp = efi_dp_from_http(server);
 
-	if (!net_dp)
+	if (!new_net_dp) {
 		return EFI_OUT_OF_RESOURCES;
+	}
+
+	// If netobj is not started yet, end here.
+	if (!netobj) {
+		goto exit;
+	}
+
+	phandler = NULL;
+	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+
+	// If the device path protocol is not yet installed, install it
+	if (!phandler)
+		goto add;
+
+	// If it is already installed, try to update it
+	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
+					       old_net_dp, new_net_dp);
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	net_dp = new_net_dp;
+	efi_free_pool(old_net_dp);
 
 	return EFI_SUCCESS;
+add:
+	ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+			       new_net_dp);
+	if (ret != EFI_SUCCESS)
+		goto error;
+exit:
+	net_dp = new_net_dp;
+	efi_free_pool(old_net_dp);
+
+	return ret;
+error:
+	// Failed, restore
+	efi_free_pool(new_net_dp);
+	
+	return ret;
 }
 
 /**
-- 
2.43.0

