Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B68FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780048657C;
	Thu, 24 Aug 2023 16:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dt0k1UBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C43865A5; Thu, 24 Aug 2023 16:21:16 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A56B864B4
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c5327e5e8so623391f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692886873; x=1693491673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AtNAXrjIFSN3Prae/ffgA6FSsIQCixT3FM/ikCyK4Po=;
 b=Dt0k1UBrg7n2QNkFqrGsJdd2s8p/4vXaisgFyjrkj28Ehg6XyT8vYIMkJfg5Qrf53i
 pqQeS5Vh+nwqZXt/Plr+i6L4vql4wU+UmtHUacMRb5k1h9QIXzjEP5zbjV1CgUprDBmd
 fi/xak/JjaFhLFdPXL5N0UhqY5CwQd4jUY1gAY3H3fxRmoI2d2kajH75dlvLFNipGeIa
 9C9sy0u+0DAC/F62/3Gzh0gzOEKtEGYBPRb/XUJM0FNvioa7OxXS0tElmYYNaFz8dvjj
 NbKV0ZP7twqxxy5c+ilvfRhWs0dnB0qtT9QHyHxonPqM/GsH5y73pzW7KDZ39frXYuoI
 8BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692886873; x=1693491673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtNAXrjIFSN3Prae/ffgA6FSsIQCixT3FM/ikCyK4Po=;
 b=XaWA+UfXbJ9kZoPMX31sa+cWgMVqV+aaYQ6tWG12oPYrTPTQsqGF+dYj1mg6T6a9Nq
 zqmb7+ghEQ39Ijcuojm8ggM8QHU7G06e7CC6G26voQva4PBGMHjxJN0ef+Hoh273eQ1o
 PY9h/NoY3Rx7Tet6JSFBSJqjHo7IpFpAtbw8KdBl2trci9pjLDvMIQpAp8bxKmeI/HTd
 fh3xoLOGS75+owizjbllOSSw4p3IX37HRVNXbOrCDu/Wvj6Y/HdRqemciCwA+n/x4r5v
 ZQNMrnm2+K0FVelJN8l8E5HRcfaN1AlZ2++KEprNXH+EICrcj4MD+15HBMo0Z8RecvLe
 Y6Mw==
X-Gm-Message-State: AOJu0YycG+3QSu58QmzykF4JgHj8fd3v2hSsntGwWOfHNq6paH8S7zBa
 ClcE60G6lJhjcsR8Vyq0BL1xTRbWsc6BfzeF3SU=
X-Google-Smtp-Source: AGHT+IFSqoRD82EyMZuilZje32w2L39veJgcY4MDy/My5RuS/xMKXuvo90zg6/R5vkrJW6QCYqD5Cg==
X-Received: by 2002:a5d:4ac2:0:b0:319:70c8:6e90 with SMTP id
 y2-20020a5d4ac2000000b0031970c86e90mr11757131wrs.24.1692886872701; 
 Thu, 24 Aug 2023 07:21:12 -0700 (PDT)
Received: from hades.. ([2a02:85f:fcb3:de74:3efd:feff:fe6b:c5ca])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a5d6304000000b0031431fb40fasm22363758wru.89.2023.08.24.07.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:21:12 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] efi_loader: delete handle from events when a protocol is
 uninstalled
Date: Thu, 24 Aug 2023 17:21:09 +0300
Message-Id: <20230824142109.2401528-1-ilias.apalodimas@linaro.org>
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
Changes since v1:
- use the non safe list traversing macros on efi_register_notify_events since
  we don't delete anythig from that list
- Add a comment explaining the code that preserves the handle in case of a
  removal failure

 lib/efi_loader/efi_boottime.c | 89 +++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0e89c8505b11..0b7579cb5af1 100644
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
+	struct efi_register_notify_event *item;
+
+	if (!list_empty(&handle->protocols))
+		return EFI_ACCESS_DENIED;
+	/* The handle is about to be freed. Remove it from events */
+	list_for_each_entry(item, &efi_register_notify_events, link) {
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
@@ -2795,25 +2827,34 @@ efi_uninstall_multiple_protocol_interfaces_int(efi_handle_t handle,
 		return EFI_INVALID_PARAMETER;

 	efi_va_copy(argptr_copy, argptr);
+	protocol = efi_va_arg(argptr, efi_guid_t*);
 	for (;;) {
-		protocol = efi_va_arg(argptr, efi_guid_t*);
+		/*
+		 * If efi_uninstall_protocol() fails we need to be able to
+		 * reinstall the previously uninstalled protocols on the same
+		 * handle.
+		 * Instead of calling efi_uninstall_protocol(...,..., false)
+		 * and potentially removing the handle, only allow the handle
+		 * removal on the last protocol that we requested to uninstall.
+		 * That way we can preserve  the handle in case the latter fails
+		 */
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
@@ -3712,7 +3753,7 @@ static efi_status_t EFIAPI efi_reinstall_protocol_interface(
 		  new_interface);

 	/* Uninstall protocol but do not delete handle */
-	ret = efi_uninstall_protocol(handle, protocol, old_interface);
+	ret = efi_uninstall_protocol(handle, protocol, old_interface, true);
 	if (ret != EFI_SUCCESS)
 		goto out;

--
2.37.2

