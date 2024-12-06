Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B532E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 12:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092CC89608;
	Fri,  6 Dec 2024 13:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYm+ib90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FD889481; Fri,  6 Dec 2024 13:27:40 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED6289623
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 13:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724fc1aaa91so2107824b3a.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 04:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488055; x=1734092855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBf9ivNTa2LW7BDXPrj5gCloinlzYxI6rAGWAOYD4M4=;
 b=GYm+ib90jVSTdIbQmS7riK2hEJSlterqsl+c9uIf6DnuXaTD1zNWZJsm0mFKrZwOYg
 yXqAQPTTEojJ3NnpFdzZaBaUv0uDFCs3k8X9/f19vhgdarDDIeW0VJpMDkttLEE/dFPO
 3hOdGfKS99icRSwzu+K/we2WkaOjLw0lJ9BnNjI8TyD+eKmywh0zAdv21Ow4Ja3+R7St
 BEoyKEVxoenDocSOeAeLEINQoyUYJGYc3ImDmLc2CCWRQxWnpqAVbSLIDeSfDL3CQOm1
 db95SjZn5fipzsKzEf0idE6OjqUyLRZtkaeNw2dlJD5wMsbvhfGB3pRAtfvxs14ygzPE
 QBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488055; x=1734092855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBf9ivNTa2LW7BDXPrj5gCloinlzYxI6rAGWAOYD4M4=;
 b=rQRlJ/U4Iwv7No85+nTIUOdOlESTwpeSYUYTAozPC0N6ab28FEf1YbZep+2ZyPPUrf
 lk09jNVrIZY8Zw8nM1KLCby/ac8tyS57s4CmM3zqomlJTsKMoLYRIvA1rJCzNJn7cCG4
 c+6f8ChCnSioJB0dzl5eI+1x6p8UuhmlhhKEqi4Un35D9Fr0uQk/yKxdA0IJ5wIFrqBt
 rSsf0PWAmkKKXq0v7IBtnQd6Jv5fE/jSHd/d41692ddldZAkydYkafwtO99VvAbpQzK6
 i/H6paUYXVb+DckgDmi59l/dFBPTk5orcAdiz7mJMJ85KY5mxaAAw/5/6zm2hgtdmTg4
 cmOQ==
X-Gm-Message-State: AOJu0YzmBtqHUBPjA05enFs94jLhqM0B4F0B6inhEOFANf8FLkSEnHyn
 87fBIclbavsw42TY7HkjAUk7Yrtm+vc51w+W4NHsQJ3pdOGZsW1VBSC5e0rfupU=
X-Gm-Gg: ASbGncsnUkYQ1L3hAftX+0s2GhWwDU2+BZ3GScOI7/luD8BWDiIMDgobwY01+EojdK3
 uleqdNXQJ+SemxooOaQBfuvDwQ0NcYEqpnxu0YNdfvc/O22i4MI1CRUUov/m0SWK8Arc/aYGLkL
 ZFbYX/EAG4D5euCmCBEOhjMVi8s80HTVLjBSe4xlzRRcZTLvrlebO2urIqFBQuWtYF+SNBU7OFz
 aSJRLszjxZXkx2WYVbFpJnEvd7MNNHkrGcltGudPcdAvThR3a+hytaggw==
X-Google-Smtp-Source: AGHT+IFQjvjCOYwivsziHuVA9APKxHGh1dX4lMW7K18E4P96WMnomVdRCMhC3bslTptlau7ZZw9w5w==
X-Received: by 2002:a05:6a00:238b:b0:71e:55e2:2c43 with SMTP id
 d2e1a72fcca58-725b8158cfemr5228531b3a.14.1733488055245; 
 Fri, 06 Dec 2024 04:27:35 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6725sm2821011b3a.151.2024.12.06.04.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:27:34 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/2] efi_loader: efi_net: let efi_net_set_dp properly update
 the device path
Date: Fri,  6 Dec 2024 09:27:14 -0300
Message-ID: <20241206122714.2365114-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206122714.2365114-1-adriano.cordova@canonical.com>
References: <20241206122714.2365114-1-adriano.cordova@canonical.com>
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
 lib/efi_loader/efi_net.c | 53 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 67593ef50c..1e87cd7be6 100644
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
@@ -1055,18 +1058,56 @@ out_of_resources:
  */
 efi_status_t efi_net_set_dp(const char *dev, const char *server)
 {
-	efi_free_pool(net_dp);
+	efi_status_t ret;
+	struct efi_handler *phandler;
+	struct efi_device_path *old_net_dp;
 
+	old_net_dp = net_dp;
 	net_dp = NULL;
 	if (!strcmp(dev, "Net"))
 		net_dp = efi_dp_from_eth();
 	else if (!strcmp(dev, "Http"))
 		net_dp = efi_dp_from_http(server);
 
-	if (!net_dp)
+	if (!net_dp) {
+		net_dp = old_net_dp;
 		return EFI_OUT_OF_RESOURCES;
+	}
+
+	if (!netobj)
+		return EFI_SUCCESS;
+
+	phandler = NULL;
+	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
+
+	if (!phandler)
+		goto add;
+
+	if (phandler->protocol_interface != old_net_dp) {
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
+					       old_net_dp, net_dp);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	efi_free_pool(old_net_dp);
 
 	return EFI_SUCCESS;
+add:
+	ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
+			       net_dp);
+	if (ret == EFI_SUCCESS) {
+		efi_free_pool(old_net_dp);
+		return ret;
+	}
+error:
+	// Failed, restore
+	efi_free_pool(net_dp);
+	net_dp = old_net_dp;
+	return ret;
 }
 
 /**
-- 
2.43.0

