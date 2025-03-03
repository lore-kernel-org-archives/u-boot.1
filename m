Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE77DC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BDF81280;
	Mon,  3 Mar 2025 15:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XgQAs101";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADCA81280; Mon,  3 Mar 2025 15:13:32 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C59C81280
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2235c5818a3so45942055ad.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741011208; x=1741616008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olOBOn3swvsKBkEioj0P2XqwJJxb6tYpiV9cL8ltrrg=;
 b=XgQAs101INZhKmRQB9PMQ/laGnxOzkgsOHBo6ha3+8KtVix+Gxa3j3yX8RnCRAx22r
 45iN8/xdiga9yeaMVNOLcpB9PNNc1502/nr1T5MsvChsGFhOslYQ6OaQGrqYJa3EW1n6
 yY6rBj8gnsQ6Gpk7ln3J9o3erBDiwxoNFPYOKHjl7kbznh5nyYp7EF9F2iERi49Hj91q
 pO25kZL1eJul0XHbhUcM6z8JwFdn6Cjr9OiefyHNp8JQ6GaQruKCinK0D3RQOoHcpiPI
 fy9JXrxALZ1F0tGJZMCqMPVMxFxOI8u0kASEiLKUxM23sSPwnoXH+CZMcu8+Cfo4UrR7
 /tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011208; x=1741616008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olOBOn3swvsKBkEioj0P2XqwJJxb6tYpiV9cL8ltrrg=;
 b=KVPq3+tRAhIc6jBpevS6buKeOcPQNdaQ+luelXp4N2eiFW8XcGu//buNnDO4RsX56f
 opxPiZUPO2yJ148fI3OzUel9uQ2xU0hCjtDj3BU3UCQNhtNpWS50LjQGOaXibpZGY5By
 OjCFqzoi7LaWDQ8EHGF9VVivkHtWOKveXukIKvfbC3mnuriDQtXTZPuQS/By3HmZUS0h
 QlYq/rzrSIxKSjMTM3sJHyRXu1ssh5MJDVolO7fzPTZ/LVZFwjs/+sNv7IRG4egQH0DL
 fHEUshbpX0keC02xHFwQUv2i3RTKCbxhJhchXJfrSeb/Ndu+DJ56DZ2DRu0AQxpWPy0s
 NFdA==
X-Gm-Message-State: AOJu0YxxAhUJqlRE7Qt4grxsMqtRO4ShsbJx6d4sbU5RA+qNTz7mPk5q
 0m0AHaMURZWYbq9pbeFY42cEHLYd3+NoA6TPGBdzmTf4H8v25syt/fCcw/bZdCA=
X-Gm-Gg: ASbGncsqVb9rtwTL5IUSr7ricuoRj+4C2yLK2KWTY7UhXRGmtBHIgBmozFK0fu4c+lH
 NfvuvYSxSFat9hif8GZvQwIvmsU2fFBfsRrUf2Stu6g8FLN7FZYuBGTDcnatGSLAwYOVaOUpOKi
 3k71h63VYpyMQs1FI0LhxSOAQA1ItcEX6Lmn+na4DBDceZAGHp6bAupHl1ilKM5X3PoSiHdY+BK
 JdG6y60QfjvZsCU72hOlWxczhYQ1icOVBWpNpWiLWMZyuJwiQ1VAWea+fNn+qK8oTEcAEpr03ic
 1ZMV/BkQzQHNtqFAawgI7HsMoAwSaNyj9txT0S7iUoFl5fDTkc7dAic=
X-Google-Smtp-Source: AGHT+IE46zeqzuoewpkabuZsvzBxFBH3QWP7rfAcHhpCt08iddUlH4h6CHTn/k6/VoS6UTDzPABatQ==
X-Received: by 2002:a17:902:ec91:b0:223:5ada:2484 with SMTP id
 d9443c01a7336-2236926e8bemr247105455ad.44.1741011208474; 
 Mon, 03 Mar 2025 06:13:28 -0800 (PST)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501faa33sm77875265ad.66.2025.03.03.06.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:13:28 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 4/8] efi_loader: efi_net: Add efi_net_do_start() to
 efi_net.c
Date: Mon,  3 Mar 2025 11:13:13 -0300
Message-ID: <20250303141317.265098-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303141317.265098-1-adriano.cordova@canonical.com>
References: <20250303141317.265098-1-adriano.cordova@canonical.com>
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

This gets called each time a payload is to get executed by bootefi.
For now this only updates the PXE IP address.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 include/efi_loader.h       |  1 +
 lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c |  3 +++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 6a17a41dbad..c2fb3e66eb9 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -650,6 +650,7 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
 efi_status_t efi_net_register(void);
+efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index a48402d49d4..68051852dd8 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -878,6 +878,30 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
 	return EFI_UNSUPPORTED;
 }
 
+/**
+ * efi_net_do_start() - start the efi network stack
+ *
+ * This gets called from do_bootefi_exec() each time a payload gets executed.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_net_do_start(void)
+{
+	efi_status_t r = EFI_SUCCESS;
+
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	/*
+	 * No harm on doing the following. If the PXE handle is present, the client could
+	 * find it and try to get its IP address from it. In here the PXE handle is present
+	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
+	 */
+	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
+#endif
+
+	return r;
+}
+
 /**
  * efi_net_register() - register the simple network protocol
  *
@@ -1019,13 +1043,6 @@ efi_status_t efi_net_register(void)
 	r = efi_http_register(&netobj->header, &netobj->http_service_binding);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
-	/*
-	 * No harm on doing the following. If the PXE handle is present, the client could
-	 * find it and try to get its IP address from it. In here the PXE handle is present
-	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
-	 */
-	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
 #endif
 
 	return EFI_SUCCESS;
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 164586742ae..eeed82c0736 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -218,6 +218,9 @@ static efi_status_t efi_start_obj_list(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
+	if (IS_ENABLED(CONFIG_NETDEVICES))
+		ret = efi_net_do_start();
+
 	return ret;
 }
 
-- 
2.47.1

