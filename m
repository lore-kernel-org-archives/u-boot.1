Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19493C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 232B18752D;
	Wed,  8 Nov 2023 12:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DrEisMOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7038770F; Wed,  8 Nov 2023 12:08:13 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F338087546
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b5714439b3so3220820b6e.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441687; x=1700046487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKRfTkXsyxHbAbfC2fDvqXQoTddGeOCmf5imGSOro/k=;
 b=DrEisMOYOWvsScqWdt4R8OprOTzlUu0TPmL37e3s53SYXwbdyCU0Uw6mK3PMe16VZh
 tgufPjITlYFJ9isWNBk0Ze999SfUTAdA25rwEb4IrS/5j6HYkql7gtG0gRpzuTvXDX+r
 +C9HTcXBqX13Xp3lC1f/MJP4KbYXALsdwK3j5/ciclnW6kN9xsMGXWRKTQC3UZRdLgLN
 f1JVMNsrYMIxGcwQu4QUj/qAv1sn1yeICEWa9WzGLW4wkEfeotH/kBdMOUEkEYpfge5a
 LQ1CHiSXM3UTzvZx3H3zaBsBjb3V1v2gewyp02psjxLE1ruEAP7QqvuABSXyZpXJQXti
 DTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441687; x=1700046487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKRfTkXsyxHbAbfC2fDvqXQoTddGeOCmf5imGSOro/k=;
 b=W8lDT9npXEZBIhFtO35Dd3wDfEfAdPG7TDCOvTcv0dAsgH17pqm0RmI/9y/kkha4jN
 fInwt8UG5cH3asE9Cnb6kGYiB0p2gBTATYlR5pqxf/g6iu9z0wH0Z8Qv4kpypvhXRQg8
 B0OjLXLaGcRxzVpHU6VXUnxc65YKt8pz/aWZAYjzSRn+Mel56tcxZKIHPJ6qXx2AS75j
 oHjFxNIm3IpeBa0ct45PNpbhrb4kK1Q2j4pwLf2rrMBDKeY8H7JkkAi1xHqgn9PL5PAE
 nQDVbB3OjUEBOVYgh1ZeiWmzNkQl2NI+72U42dXtkHn2X6tacBPlR2cz+69Dc/ykWZGj
 2hfQ==
X-Gm-Message-State: AOJu0YxpDE4wmYWaS/Q4A/XFJCJNiOEmBMfIw/SSVfhdjaQFefP3aUUe
 UGPM3+jhrHqVS91qHZzcATRxsXPBuSXdQ35NsTE=
X-Google-Smtp-Source: AGHT+IEJaChGAj1aQvexDBrF91C6lFdb1ACfml0diOfFbOUVLGCYuHuchDQaBp+QxaNLhMVOdYvUvA==
X-Received: by 2002:a05:6808:13d1:b0:3a9:e8e2:57a7 with SMTP id
 d17-20020a05680813d100b003a9e8e257a7mr1992907oiw.53.1699441686898; 
 Wed, 08 Nov 2023 03:08:06 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 s1-20020aa78281000000b006b4a5569694sm8700646pfm.83.2023.11.08.03.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:08:06 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v11 6/9] efi_loader: add return to efibootmgr event group
Date: Wed,  8 Nov 2023 20:06:33 +0900
Message-Id: <20231108110637.3691441-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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

When the image loaded by efibootmgr returns, efibootmgr
needs to clean the resources. Adding the event of returning
to efibootmgr is useful to simplify the implementation.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/bootefi.c                 | 12 ++++++++++++
 include/efi_api.h             |  3 +++
 include/efi_loader.h          |  2 ++
 lib/efi_loader/efi_boottime.c |  3 +++
 4 files changed, 20 insertions(+)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33..4d74969ad6 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -356,6 +356,7 @@ static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
 	efi_status_t ret;
 	efi_uintn_t exit_data_size = 0;
 	u16 *exit_data = NULL;
+	struct efi_event *evt;
 
 	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
 	switch_to_non_secure_mode();
@@ -394,6 +395,17 @@ out:
 			log_err("Failed to remove loadfile2 for initrd\n");
 	}
 
+	/* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
+	list_for_each_entry(evt, &efi_events, link) {
+		if (evt->group &&
+		    !guidcmp(evt->group,
+			     &efi_guid_event_group_return_to_efibootmgr)) {
+			efi_signal_event(evt);
+			EFI_CALL(systab.boottime->close_event(evt));
+			break;
+		}
+	}
+
 	/* Control is returned to U-Boot, disable EFI watchdog */
 	efi_set_watchdog(0);
 
diff --git a/include/efi_api.h b/include/efi_api.h
index c2d6964467..0e92cb8a7f 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -404,6 +404,9 @@ struct efi_runtime_services {
 #define EFI_EVENT_GROUP_RESET_SYSTEM \
 	EFI_GUID(0x62da6a56, 0x13fb, 0x485a, 0xa8, 0xda, \
 		 0xa3, 0xdd, 0x79, 0x12, 0xcb, 0x6b)
+#define EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR \
+	EFI_GUID(0xb4a40fe6, 0x9149, 0x4f29, 0x94, 0x47, \
+		 0x49, 0x38, 0x7a, 0x7f, 0xab, 0x87)
 
 /* EFI Configuration Table and GUID definitions */
 #define NULL_GUID \
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e164e6067d..31954e84c3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -290,6 +290,8 @@ extern const efi_guid_t efi_guid_event_group_memory_map_change;
 extern const efi_guid_t efi_guid_event_group_ready_to_boot;
 /* event group ResetSystem() invoked (before ExitBootServices) */
 extern const efi_guid_t efi_guid_event_group_reset_system;
+/* event group return to efibootmgr */
+extern const efi_guid_t efi_guid_event_group_return_to_efibootmgr;
 /* GUID of the device tree table */
 extern const efi_guid_t efi_guid_fdt;
 extern const efi_guid_t efi_guid_loaded_image;
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index f9b10a9763..3767fa2db4 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -90,6 +90,9 @@ const efi_guid_t efi_guid_event_group_ready_to_boot =
 /* event group ResetSystem() invoked (before ExitBootServices) */
 const efi_guid_t efi_guid_event_group_reset_system =
 			EFI_EVENT_GROUP_RESET_SYSTEM;
+/* event group return to efibootmgr */
+const efi_guid_t efi_guid_event_group_return_to_efibootmgr =
+			EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR;
 /* GUIDs of the Load File and Load File2 protocols */
 const efi_guid_t efi_guid_load_file_protocol = EFI_LOAD_FILE_PROTOCOL_GUID;
 const efi_guid_t efi_guid_load_file2_protocol = EFI_LOAD_FILE2_PROTOCOL_GUID;
-- 
2.34.1

