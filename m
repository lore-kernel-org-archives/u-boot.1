Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE70E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA488973E;
	Fri,  6 Dec 2024 18:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JTTZXveV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDE8894F2; Fri,  6 Dec 2024 18:31:06 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833708972B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fbd9be84bdso2272274a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733506263; x=1734111063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H18JXNNTx4XzQB/xLxxL85RwNLxMkMGA/JFirpV2Hes=;
 b=JTTZXveVKncrh+c5u3xjg1lWAV3rASeBJKdL3ydr4lPw4soCnrhf1rzodnkefMY65E
 RIQYVndjbEQzsRS6fd4Uw2RNkJ0fbXsZO7YpcJun3b8kDFa4R0DVYt35LmOvscjFgiq/
 R6FSPGeay0LDw577HX/NM7VpknAeX1/yPgrk/G+nRccve64jUyv82G1uasLznmDowVTX
 XaPd+8/jfP5Ap+WaW1dB+Q3mA+pI3q3z6bKMrLTc8u8UJMjaYdAew4qVWI2ts+QATI11
 1WcNUK/jfQGnD0JKwyHvbE08Q2dIMXUMU2rO2z9hGdpiImbdvm0fTC+YnjdahB/15lZb
 x/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733506263; x=1734111063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H18JXNNTx4XzQB/xLxxL85RwNLxMkMGA/JFirpV2Hes=;
 b=fyN4U4GxzHASF8j4sO3oKRcciBdRxJNrP+jh3fJj5rMDDglD6PSzOzJ35U96xg4c7m
 JoQPPI81OBnWjGQLdwSTYDvdntosLvpxnr52Od+6jCw++VXL5aGznLGtu4a3ps1EtcBX
 gaZzUmQg1u0zNHUEl1AYUaSSJCtzDsmgGlwIoV2YNqfPVt4+l7nbiUQdOwy9HIpPotlQ
 5PalgKL1T0pmvgO/OoEO4wIA0+ZWSbaw+4jRqKfZ30pHwWHOePH3yCPJep4LAtOC7zC0
 eOHLI1Kovmmx6UBe7nxcnMbnaLP9253IFlPgKA9Mzj5ZsCbr7C2CCWCtOU+waGYTTGoM
 A7Mw==
X-Gm-Message-State: AOJu0YwbXu1UYriSx8gn795dsk/jJcdfK5Yg2ukJB9ViaZ8ZcCOKmkSO
 JcoOemBZPT+qDwoT8pmFqxjFjv1UVMuyZq+niq+ZQ43qv+XkZSMUKsV8YDr/1K0=
X-Gm-Gg: ASbGncuEHo+oyda4Lu7WoiRM+CrpGo+NFrPmbsKqL90eUQoPyumX3QUWRv84meY7/mt
 JNVlHUoQ7uvqBXzwjFMvTod+hYLBFe58TebZg3ROk7Lbd/HS+ApUWgWv4SHlbN3zJQB5Y3Ahvc/
 m/xBT/sed8cMH/dcElhPj9OYqvng1n/cdtsOPkhm2OEIyA+LUvZuKfo39KD+VOuumuERu1GAVbg
 L4vZtvl7AbJHRrCCnzTCMdvlhpHkqlKMWKKSLeEyKI2igBagGCe63dAJw==
X-Google-Smtp-Source: AGHT+IGEsCvizZjHeUnJt5rRMig7twjYYf6PX6FnXtzsV/nnoVv+6aZlTjwYBX9/8x0vuuUcUzGhCg==
X-Received: by 2002:a17:90b:4fcd:b0:2ea:3d2e:a0d7 with SMTP id
 98e67ed59e1d1-2ef69e154e1mr6826403a91.15.1733506262773; 
 Fri, 06 Dec 2024 09:31:02 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef31715ba8sm4810162a91.13.2024.12.06.09.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:31:02 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/2] efi_loader: efi_net: Add efi_net_start() to efi_net.c
Date: Fri,  6 Dec 2024 14:30:33 -0300
Message-ID: <20241206173033.2403998-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206173033.2403998-1-adriano.cordova@canonical.com>
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
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
 include/efi_loader.h       |  1 +
 lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c |  3 +++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 0d858c1e12..85ca0ecee1 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -626,6 +626,7 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
 efi_status_t efi_net_register(void);
+efi_status_t efi_net_do_start(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index ac8e54639b..acb71ef12a 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -876,6 +876,30 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
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
@@ -1020,13 +1044,6 @@ efi_status_t efi_net_register(void)
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
index 164586742a..eeed82c073 100644
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
2.43.0

