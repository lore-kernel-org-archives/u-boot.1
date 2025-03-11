Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF81C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8B081335;
	Tue, 11 Mar 2025 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrmgZZ6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427E68168B; Tue, 11 Mar 2025 17:47:59 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04823811C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c322so11253595a91.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711675; x=1742316475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJqhvM4yLks9CdujhKlTf9jdOzMrqAeXvFf4l9r51NA=;
 b=nrmgZZ6saOpPF5sc6IKty/5Updr/7JUn4ytqc5+wzsZw6R/64ey1PFkudlEMyTWGXw
 vDZNxk/yexp+BCbmNcYrqHHsx1YQbDMsd//1rOIn0cRM96+I0YD+DIuP02Nx5feccxRn
 o3ab0ZXRsXwRNb05srI1s0F72Wv3Ha56JkBH/CHoAVWgPc0zwqNZwkcOsDDLFzTsA+6z
 zlKl1XK5zI0GpjsIK57O96CtuhD9qneP5c5xQDmYks2KuLo7l/u7Du+yd1Eyv7QTkDme
 03jAhklP4bWTlxgsjleagEfGVI1XEK5smRvmnJpZDFMAts3ccddd0T5iQzH9y7iUGC9w
 acMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711675; x=1742316475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJqhvM4yLks9CdujhKlTf9jdOzMrqAeXvFf4l9r51NA=;
 b=uJXxQU+ZLg0XfcB0CTrkGVeUqAzTumluzpZM4lBg5krKPm+1lgsbRqRHGxpIXE/8+v
 Dep8Pt9Fv2QyOzkLEqtJDIZYkV6LvWrg3W2Byvz/38CE+9xkxu96v1N6Iz4yLOWsGJ6y
 eJsjUAM8S4qRo+ve4kYRDyAEFq+Qy2yjCyAygDV4vYefi+vWCYrqygGbPj9WLbRA113S
 wVoGgMoEA/tXD+wbiwYiq1UlbtBnH+hfLje6kDTZi8G7iZFkTFLIFg+TEMwpo4W4eaIi
 1BJOeO8fOfy4HcbleLnS3Liv0otLqH3LQIbcDJmSBNQvuPRywJ3DvVoYDr3dOefJv8UJ
 acLA==
X-Gm-Message-State: AOJu0YyISJ8oPcVMbHdzUdIdVAfYxnoPOEIo+sWMB4qULRtQR9YeG9Nj
 zWE2WbpbcbsYCgVclD2lq7mglZzFk92iia/+KCPj+draBfksd2QF1ekoDmohRPU=
X-Gm-Gg: ASbGncs96Q5KHvdK0m+xi9D2sNX52CFBNcvtMOd34wpEWwwESzlQsxxgHlhwrFvXs0X
 ljXWWzaTnMohp8eKRct/iuxEMeUrzvYuXQiwhx30XKcm34yoIQJuwhbywlw0Zu4dfa1QCHMisvK
 GNwkIrHl0KIlF2gwrGAGUP3jopNif6OE7ewgW/3pPr7TYhQjCf0TM4yONZY4feTwKO8e0QuthXM
 XngBlwuxjitjupTcf167myBjTU6BYFJSKFZhrn7RM2rdVto0ZgNX5Rai+8OChgBoPRYonAcwsUp
 T4Bf78NYIwPNDhIC+LlhSKo5wM70LYGpZE8dkmBpZ/5ujkSLpni4zZs=
X-Google-Smtp-Source: AGHT+IH6E7j2bc5dYws+XJiHZiAR3wceAnSycZhjjes1aRVd8pZG5l4f4FEW0PYm0w/weUO81dF7Ug==
X-Received: by 2002:a05:6a20:7f93:b0:1f0:e84c:866f with SMTP id
 adf61e73a8af0-1f544b16311mr30262515637.21.1741711675419; 
 Tue, 11 Mar 2025 09:47:55 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:47:55 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 02/16] efi_loader: efi_net: check efi_search_protocol return
 value
Date: Tue, 11 Mar 2025 13:47:44 -0300
Message-ID: <20250311164758.421900-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 0334eedaf5c..8c0a3f5243c 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1020,7 +1020,9 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
 		return EFI_OUT_OF_RESOURCES;
 
 	phandler = NULL;
-	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	ret = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
+		return ret;
 
 	// If the device path protocol is not yet installed, install it
 	if (!phandler)
@@ -1051,12 +1053,15 @@ add:
 static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 {
 	struct efi_handler *phandler;
+	efi_status_t r;
 
 	if (!efi_netobj_is_active(netobj))
 		return NULL;
 
 	phandler = NULL;
-	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	r = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+	if (r != EFI_SUCCESS && r != EFI_NOT_FOUND)
+		return NULL;
 
 	if (phandler && phandler->protocol_interface)
 		return efi_dp_dup(phandler->protocol_interface);
@@ -1444,7 +1449,9 @@ int efi_net_unregister(void *ctx, struct event *event)
 			return -1;
 
 		phandler = NULL;
-		efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+		ret = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+		if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
+			return -1;
 		if (phandler && phandler->protocol_interface)
 			interface = phandler->protocol_interface;
 
-- 
2.48.1

