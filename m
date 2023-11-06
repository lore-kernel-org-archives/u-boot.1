Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B16C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6244887026;
	Mon,  6 Nov 2023 12:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wcu2jIAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65FC8653E; Mon,  6 Nov 2023 12:41:15 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AAB87049
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso4691255b3a.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270849; x=1699875649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKRfTkXsyxHbAbfC2fDvqXQoTddGeOCmf5imGSOro/k=;
 b=wcu2jIAo6rwE+z/OHSYaViKp3+9gsAIXFMqzqIwvjylTtamp799QA0q0vrjZJM0Mke
 ucUM1fjsQo5Jzs89JYx/BwdX5UK4B5rHDiGT1mAUpKPjcEURaCqfSds+Ju/3IkYivuUS
 +nRJb6YTRcxiJqFJqh/3UvEHtZC5Xj/sQXIjtgncdlQWBc7chaHGMUTfBLh4E6o+nMoD
 hw/lPWKkOLga3hJ2bAc/FgsMt3YYbM6TkLRl2nCJHpA24egaLRrDE1Gu4rKmYNknMXcV
 qiJo/7r98NoUiYybDrb7x59qgMyJJINxv/sLFKilJQBb1EqtJSdaQiu3cTfct5onPCy6
 /9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270849; x=1699875649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKRfTkXsyxHbAbfC2fDvqXQoTddGeOCmf5imGSOro/k=;
 b=euLCokc52HUh66L07n4p5Lth4kOrUvytej1cJi5+Jiz8xmz6aA6JvhiUiMJvc2zaJq
 E/PI6fQz1B5iqTjGf4cZUn1II2iqCxrVBgBJec7QiSOmIeOdno6JT6VWmQxtZk3lv1oo
 S9NyYk8uBrAgTSGxYa3EO7d4zFGDwEWHWijnQ46l67dLS8baFtsXv8mEpQHOMw/oy2UR
 Qodpc0RZ/uwYuws50PvaHuDEoD5rgX++DQ0bvki9nMOf3vT9uk/h81HqOk+tdWuqsWeW
 fXUyYdZ1C/BwjgpO1QZU8i2rwSToYWi7rU6Gj73Y2Q0y4SM1UQxi7uysb/I3U5wh5uqT
 3wlw==
X-Gm-Message-State: AOJu0YzvSxWAurik4roGR5okprxcePEfAcCu3fLnbZW2YpaFAUQqOH0p
 FG9s1TqmO1SleVwqy+Yqz3JVunyxnBxmn1Izq/k=
X-Google-Smtp-Source: AGHT+IHYzZxxvdA8GGe1M5106gdQuBMJQodzEH/fI7sWb4kkFfR7UR0Ptm5OZLGPfzgtjFpTT4RoEg==
X-Received: by 2002:a05:6a20:c1aa:b0:17b:7505:8ab7 with SMTP id
 bg42-20020a056a20c1aa00b0017b75058ab7mr38922034pzb.46.1699270849227; 
 Mon, 06 Nov 2023 03:40:49 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 iy10-20020a170903130a00b001cc3a8af18dsm5740147plb.60.2023.11.06.03.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:48 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v10 6/9] efi_loader: add return to efibootmgr event
 group
Date: Mon,  6 Nov 2023 20:39:17 +0900
Message-Id: <20231106113920.3631591-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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

