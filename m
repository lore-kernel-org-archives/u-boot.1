Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B9C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 11:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2001B8657C;
	Thu, 24 Aug 2023 13:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WrmccGLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807F5865A6; Thu, 24 Aug 2023 13:55:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D69864B7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 13:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fef3c3277bso35243575e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692878110; x=1693482910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+4nZBQREroHNf1yQ61IgQrl73fmHFFgSo3+NiWRMbew=;
 b=WrmccGLLlRND1BdGKOkDmb+R8otsnjiL6jp10dUFlpHW3RJ1nRC6BWuwxartSQyT9y
 DpzKv7aTziwwUjvGLFZ8BxuXY/YPnitqAA1wuqtM2E1KkballxqXSbUTLvaWHcxacGCE
 NcUrEWJrPWXde9RZEEGgVorxJQt4f5d2PddlbEOsWZ350zO1n62+XQ1Kg7NIt3Jhv7eI
 qNjH5CLBBmcjIh47930djHXDzJHJZeJxFL5/jvnv+WpOxixhKKUtoAFdG1LEvUsdwjF8
 rlP+qmbeAE9k1cK7D5KuzNqoq6kMUFoSLWyXBxZljrkmu5PO17+3hfxySgSYoYEFKYqO
 ipag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692878110; x=1693482910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4nZBQREroHNf1yQ61IgQrl73fmHFFgSo3+NiWRMbew=;
 b=h49nFgtX/MHIbEx9yl+2VADrK/f10HMWMvobY3xq7i64DvKGUEwz7d9yFoJiMeccZU
 RMlAWjIC9s60uHSZNLAjiFI6+Fd3eh0bkSiTjRAKE4CYlthp8GF7TvWS5OGY7m9RUM6y
 v1MSuF+rx4RO6oh2IEq8T0s/2FC90xXS5EVkLqMGDfy9+sGBGdQqcXuieZ7llIrLMgYm
 0tVf7eGpVGfllYPC+NS7NoIGQVtkkttMUEEDb8zOa92YJds2HNYnC2I5TdMzBD/ktTPk
 Cob9gURQ7+ZDSgibSb2tdSWtGL5wZd5UACeO7Mj13P6B9ELAEBVcBTMV4HUqqUQo3EIC
 B00A==
X-Gm-Message-State: AOJu0YynMHybfBqHRhW0H1PrUIBD6N0zwFsXtwVqa2okkdpdUDCu7kdq
 buR+DJn5BqvyxuZXMQ1Qwszowt7b3JKPQRtFuQb++A==
X-Google-Smtp-Source: AGHT+IEOy5+C/UTF4QyD/pSNPe3+6/KSPQZ+3ePi5wbawhTCUkxrb1GfFGf8Lpw0GpNXNwdaejkjOg==
X-Received: by 2002:a7b:cbcd:0:b0:3fb:fa9f:5292 with SMTP id
 n13-20020a7bcbcd000000b003fbfa9f5292mr11500243wmi.25.1692878110226; 
 Thu, 24 Aug 2023 04:55:10 -0700 (PDT)
Received: from hades.. ([2a02:85f:fcb3:de74:3efd:feff:fe6b:c5ca])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c0b5900b003feea62440bsm2389901wmr.43.2023.08.24.04.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 04:55:09 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: delete handle from events when a protocol is
 uninstalled
Date: Thu, 24 Aug 2023 14:55:00 +0300
Message-Id: <20230824115500.2388636-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

When a notification event is registered for a protocol the handle of the
protocol is added in our event notification list.  When all the protocols
of the handle are uninstalled we delete the handle but we do not remove
it from the event notification list.

Clean up the protocol removal functions and add a wrapper which
- Removes the to-be deleted handle from any lists it participates
- Remove the handle if no more protocols are present

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_boottime.c | 80 ++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0e89c8505b11..96950790ba2a 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -61,7 +61,7 @@ static volatile gd_t *efi_gd, *app_gd;
 
 static efi_status_t efi_uninstall_protocol
 			(efi_handle_t handle, const efi_guid_t *protocol,
-			 void *protocol_interface);
+			 void *protocol_interface, bool preserve);
 
 /* 1 if inside U-Boot code, 0 if inside EFI payload code */
 static int entry_count = 1;
@@ -207,6 +207,36 @@ static bool efi_event_is_queued(struct efi_event *event)
 	return !!event->queue_link.next;
 }
 
+/**
+ * efi_purge_handle() - Clean the deleted handle from the various lists
+ * @handle: handle to remove
+ *
+ * Return: status code
+ */
+static efi_status_t efi_purge_handle(efi_handle_t handle)
+{
+	struct efi_register_notify_event *item, *next;
+
+	if (!list_empty(&handle->protocols))
+		return EFI_ACCESS_DENIED;
+	/* The handle is about to be freed. Remove it from events */
+	list_for_each_entry_safe(item, next, &efi_register_notify_events, link) {
+		struct efi_protocol_notification *hitem, *hnext;
+
+		list_for_each_entry_safe(hitem, hnext, &item->handles, link) {
+			if (handle == hitem->handle) {
+				list_del(&hitem->link);
+				free(hitem);
+			}
+		}
+	}
+	/* The last protocol has been removed, delete the handle. */
+	list_del(&handle->link);
+	free(handle);
+
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_process_event_queue() - process event queue
  */
@@ -615,7 +645,7 @@ static efi_status_t efi_remove_all_protocols(const efi_handle_t handle)
 		efi_status_t ret;
 
 		ret = efi_uninstall_protocol(handle, &protocol->guid,
-					     protocol->protocol_interface);
+					     protocol->protocol_interface, true);
 		if (ret != EFI_SUCCESS)
 			return ret;
 	}
@@ -639,10 +669,7 @@ efi_status_t efi_delete_handle(efi_handle_t handle)
 		return ret;
 	}
 
-	list_del(&handle->link);
-	free(handle);
-
-	return ret;
+	return efi_purge_handle(handle);
 }
 
 /**
@@ -1356,6 +1383,8 @@ reconnect:
  * @handle:             handle from which the protocol shall be removed
  * @protocol:           GUID of the protocol to be removed
  * @protocol_interface: interface to be removed
+ * @preserve:		preserve or delete the handle and remove it from any
+ *			list it participates if no protocols remain
  *
  * This function DOES NOT delete a handle without installed protocol.
  *
@@ -1363,7 +1392,7 @@ reconnect:
  */
 static efi_status_t efi_uninstall_protocol
 			(efi_handle_t handle, const efi_guid_t *protocol,
-			 void *protocol_interface)
+			 void *protocol_interface, bool preserve)
 {
 	struct efi_handler *handler;
 	struct efi_open_protocol_info_item *item;
@@ -1397,6 +1426,14 @@ static efi_status_t efi_uninstall_protocol
 		goto out;
 	}
 	r = efi_remove_protocol(handle, protocol, protocol_interface);
+	if (r != EFI_SUCCESS)
+		return r;
+	/*
+	 * We don't care about the return value here since the
+	 * handle might have more protocols installed
+	 */
+	if (!preserve)
+		efi_purge_handle(handle);
 out:
 	return r;
 }
@@ -1422,15 +1459,10 @@ static efi_status_t EFIAPI efi_uninstall_protocol_interface
 
 	EFI_ENTRY("%p, %pUs, %p", handle, protocol, protocol_interface);
 
-	ret = efi_uninstall_protocol(handle, protocol, protocol_interface);
+	ret = efi_uninstall_protocol(handle, protocol, protocol_interface, false);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	/* If the last protocol has been removed, delete the handle. */
-	if (list_empty(&handle->protocols)) {
-		list_del(&handle->link);
-		free(handle);
-	}
 out:
 	return EFI_EXIT(ret);
 }
@@ -2785,7 +2817,7 @@ static efi_status_t EFIAPI
 efi_uninstall_multiple_protocol_interfaces_int(efi_handle_t handle,
 					       efi_va_list argptr)
 {
-	const efi_guid_t *protocol;
+	const efi_guid_t *protocol, *next_protocol;
 	void *protocol_interface;
 	efi_status_t ret = EFI_SUCCESS;
 	size_t i = 0;
@@ -2795,25 +2827,25 @@ efi_uninstall_multiple_protocol_interfaces_int(efi_handle_t handle,
 		return EFI_INVALID_PARAMETER;
 
 	efi_va_copy(argptr_copy, argptr);
+	protocol = efi_va_arg(argptr, efi_guid_t*);
 	for (;;) {
-		protocol = efi_va_arg(argptr, efi_guid_t*);
+		bool preserve = true;
+
 		if (!protocol)
 			break;
 		protocol_interface = efi_va_arg(argptr, void*);
+		next_protocol = efi_va_arg(argptr, efi_guid_t*);
+		if (!next_protocol)
+			preserve = false;
 		ret = efi_uninstall_protocol(handle, protocol,
-					     protocol_interface);
+					     protocol_interface, preserve);
 		if (ret != EFI_SUCCESS)
 			break;
 		i++;
+		protocol = next_protocol;
 	}
-	if (ret == EFI_SUCCESS) {
-		/* If the last protocol has been removed, delete the handle. */
-		if (list_empty(&handle->protocols)) {
-			list_del(&handle->link);
-			free(handle);
-		}
+	if (ret == EFI_SUCCESS)
 		goto out;
-	}
 
 	/* If an error occurred undo all changes. */
 	for (; i; --i) {
@@ -3712,7 +3744,7 @@ static efi_status_t EFIAPI efi_reinstall_protocol_interface(
 		  new_interface);
 
 	/* Uninstall protocol but do not delete handle */
-	ret = efi_uninstall_protocol(handle, protocol, old_interface);
+	ret = efi_uninstall_protocol(handle, protocol, old_interface, true);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-- 
2.37.2

