Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0FBE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19F98971E;
	Fri,  6 Dec 2024 18:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VJaN8f4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F1A89373; Fri,  6 Dec 2024 18:19:00 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9D589736
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21577f65bdeso19733105ad.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733505536; x=1734110336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIOPoE/Vrg7UJNzD1lAnsdaAGdI60hCrSeNBj/hliHo=;
 b=VJaN8f4ddNDDs9H+aPyEQ+jzpsrRqGZV2klevUGS//LzNcFNyEVcmLIU6WUQKZWnM9
 C1bPPMRPERmrLCNTwr17una9fU5z40K4I85mWU1eFO115Fol3frLzq2FCJJpBB2SwZiM
 SAV7D31Bp7w909MlCFkwl7yxB6dhPGL/th71sp2KFZIAzto1hUI6DzUl1w7rQee1Y37L
 PzISeFKEIWhZ0qgUjonIcifOq/50CSGkyjnbIjlncO7A24vfKXKQFFXEwgID3G89x/N7
 XSuwCrPv46xUGJ6PQErPIMwou5a3qfyjVg0W5CQBjHf2nvCfo2sKLZzZZwkTzPxY7Rmi
 BHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733505536; x=1734110336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIOPoE/Vrg7UJNzD1lAnsdaAGdI60hCrSeNBj/hliHo=;
 b=C40b239hV6IeFdNG9Xt9NSAjVTkRenlWMPDZLZFduhNxPazp/qNoGSTTUAFbo/6PKa
 R7zxYg/hsG5HhOEOCcCCFPObybVLW7OUDg6PSUJVion4tnRt+YWV0JjtIEey96ethIqo
 5Jc3A+ztqO7dwVba4lALW20zt2aQU/ir4icRcRXvmhRcI68mv2aiVsaaH5BzkOQhdoCC
 VDnZuK6jNsIFzVaQradlkLCX8DnWeOqxRDq10YRb97hcVbJF3dGKpeZfGn5OF6WBmTkW
 80NZApKMsEiIWPs1HLB1AL8SZig9PC8BkFXbknrqpQdGaUFyTNmx3NxfTVS9qe4S9rw7
 AXxg==
X-Gm-Message-State: AOJu0Yza0ywNzaQ8Gm3qhY9k+vKHWjRlPDoJpy3lTA9sDgh0c4q5VzUE
 PkUKe5agfLFvJ1ovsaJ4STFDOavckQT9OgyfXNnDXbmndlp4PCdV3QD4lfaheGA=
X-Gm-Gg: ASbGncsnQ59dVEMoDX+KB+I9aRXTLCkfAJtoo9DWUaF3kVdqSsTSZ1VHmEqgr8uW5C2
 eujNP0HeDYRRivw8eY0AbF54oeEmDtEqi9TakXu4ZNA/cnlsKcIGaBtE0WSSsqFQPYtJQmtXA8j
 13OnPwHYhUHXZt0wVZzd6mbrAMispY81XMxs/qiRq/kbLua5+vZbSSfIAAZMxoBGygXbJ3KHeSI
 W7KFroIDLb9NYdY3kzes3/XBdy0u3tr5Z7QlgUgUvA+dPZB2T+e6lIRLg==
X-Google-Smtp-Source: AGHT+IHaldVPEFeWpnAO+3f1Ho9lWwKfHdDT8mHBK7+fuB4hYNa3bdmIEC4mv3CEf/woJ+FAU/NtZg==
X-Received: by 2002:a17:903:2309:b0:215:beb2:1039 with SMTP id
 d9443c01a7336-215f3c56b8cmr131325145ad.4.1733505535695; 
 Fri, 06 Dec 2024 09:18:55 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f263b9sm30970025ad.226.2024.12.06.09.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:18:55 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
Date: Fri,  6 Dec 2024 14:18:35 -0300
Message-ID: <20241206171835.2403418-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206171835.2403418-1-adriano.cordova@canonical.com>
References: <20241206171835.2403418-1-adriano.cordova@canonical.com>
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
Changes in v2: use reinstall_protocol_interface() and new_net_dp in the body of efi_net_set_dp()

 lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 67593ef50c..ac8e54639b 100644
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
+	efi_status_t ret;
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

