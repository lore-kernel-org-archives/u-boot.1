Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63197C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83741877AF;
	Fri, 10 Nov 2023 05:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VlRtaEbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50C387783; Fri, 10 Nov 2023 05:27:42 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C281D8778F
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1274909a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590448; x=1700195248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKRfTkXsyxHbAbfC2fDvqXQoTddGeOCmf5imGSOro/k=;
 b=VlRtaEbjjIMyWYGunCddfof98AxuBZ5OgC6GNagr1/bbuJGknHhIGYP5NGghWLUGmu
 2M4dsP0sGxM9IKDF0vxO4Enj7jjVV4hsbYVzWpICUfMjbqeTBhcS0FbKbm0kgIJ2vg+Y
 qbhCkF48/vbjhj0QfyEjtbrMgvDTg8RV4MR4Y2TgPm3MOpqt7xe2AWQu0E9Ii/42hfxu
 wM/OURiFz2AaAi64u7bI9t3qYfrWBiB4cRo/v4m55urCvBIMpkAJOwc6PtL5eh6Y4E9s
 i3yM2xZ/DQF5+E5EP97TU8saRxb9PUjNIu4BkIrahq2S6Li1TCozKltO1J7Vlnl6GBXi
 seeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590448; x=1700195248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKRfTkXsyxHbAbfC2fDvqXQoTddGeOCmf5imGSOro/k=;
 b=sj5hbrFNyWnSmzvvwTup0ajQ5u+52fJ7yKWWAnMaQqZG4/a/qUV1g+mMEAPUzeYIhv
 Bd9xJVriaTlPShfxaocl8LS1uKhEPzd8v2d9k9xV9V0Dix1JbUyCWuxI23Fb5IZx5JvU
 HqRp1rvmqVp1mhrU8JvYQGAWxyiYfbVrH6rkfR39JjgEWtPnQNAKKsIEWeMi/nBN1yp0
 qp6LPXPy3axI1XkNKu9CwArgBSPG07E8yZ4rKNhHTXKvUuX1hqeO7VvTUP3beiBpV3Yv
 3IjYHgkhB/WHXE/u0GNmuFUX+Gh5u/tDSdlkuIsCU7sAodwbdpD8H2dyBtC9u2+/oDHk
 R9Hw==
X-Gm-Message-State: AOJu0Yw3UkNLhr7tVW+6DY8fm+gGbs22hTEg0InFyvQc/2/BcmlzJXPO
 LCWevnL1f9q6r6zCOPdh2NlgoTG3w5rLpwe4FCc=
X-Google-Smtp-Source: AGHT+IE4DSAIsJ6z+9R/F/wPntHSMwsWH8k+IlrTwG9US+8SOKnHE4UOeUtWoB91DTb5tz0PrbsjrQ==
X-Received: by 2002:a05:6a21:3603:b0:185:c32e:cfd8 with SMTP id
 yg3-20020a056a21360300b00185c32ecfd8mr160317pzb.6.1699590448586; 
 Thu, 09 Nov 2023 20:27:28 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ij27-20020a170902ab5b00b001c3a8b135ebsm4406508plb.282.2023.11.09.20.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:27 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v12 6/9] efi_loader: add return to efibootmgr event group
Date: Fri, 10 Nov 2023 13:25:39 +0900
Message-Id: <20231110042542.3797301-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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

