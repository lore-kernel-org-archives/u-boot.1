Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E543C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 06:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B30187703;
	Thu,  2 Nov 2023 07:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aqYgzIES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C0D876F5; Thu,  2 Nov 2023 07:46:42 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620918037B
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 07:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso5273955ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698907596; x=1699512396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cib8KL/yfgl91t4t3wFdlqpTDFoTGfWf+CPOfiYxJw8=;
 b=aqYgzIESv8IBj4XSuzsz03fWelB4hb09QTVWCfBs0l+ttb12ngPUJZQf295/xOnGf2
 mhUwzNidKhuUkPr0AOlGtatD0XF6tYNlCuc0VQ7cCHXILs63IEDZdlbgaxVqRu3WIvvh
 1XtaTL4Tx0dLQ5M+ce6CS6ac4c8/Jr0/P1b68HUyD/T4jA3fvrv2BU+MX83pZ1oaBGBp
 cCMvEax6eEMPchSwJoiR4jEfJVKs/DUBm6+UvNA+wjSN/WNbwDmlEGXnrmStXhGIj1Ec
 Xlc8Ku4X2E7n90mFTxqW2EBBR7QQBIlHPKjLPX3iCM9AOT0VAEYa/mQqJlVyFWcqkejX
 mfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698907596; x=1699512396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cib8KL/yfgl91t4t3wFdlqpTDFoTGfWf+CPOfiYxJw8=;
 b=QU0CQ7zpKbZg0I6cAwk9+BCFlPfppV6aIHxwkUePHfiOiu1te/VgTxB/XvF0AT7jiR
 unEoOx1MflNmC5Axsr402JuR8LxL08W4ZHn8sHVWtDzGC7TbgHMIFRsU4UZlTP34XXT9
 GuBBWnA4S2GwtF0Ygu3PiPm2Lxuj5HZZ5i2SrLbKBO79A0i+DCVR5+kk6sgrLsymawHb
 M+7RHPy/+6Ye7gNfL2Tz1HhbOPheb3XsyBQI2pXPj0Ka3fcbbxCI4jxRFImJPm1QMZ3M
 Y1CX5+Lc8PU/sfGiV2S3i/EqjLVzeL5JfZTBA3pE85DjwvnReddeVu/WRd35MaEidMJN
 SX0Q==
X-Gm-Message-State: AOJu0YzWfx0WKzGJoEPNix8LRiRiLsM0NpovF63uBknOh8pNjpcyXRor
 +Z8gXXsbbS/fE4+QMBKKyPfukLlwUH6XN6fgQZs=
X-Google-Smtp-Source: AGHT+IESZCxMLARuT8zYTLewn2ta1DpIHxOf5Y4DOO7hRhOJd8zPtBLoFHYhNSTVFkS8GR7DeaF99A==
X-Received: by 2002:a17:902:c948:b0:1cc:33e7:95f5 with SMTP id
 i8-20020a170902c94800b001cc33e795f5mr6620210pla.33.1698907596394; 
 Wed, 01 Nov 2023 23:46:36 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ij6-20020a170902ab4600b001cc307bcdbdsm2389819plb.211.2023.11.01.23.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 23:46:35 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v9 6/9] efi_loader: add return to efibootmgr event group
Date: Thu,  2 Nov 2023 15:44:56 +0900
Message-Id: <20231102064459.3466953-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
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

