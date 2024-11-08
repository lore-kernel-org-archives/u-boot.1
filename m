Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2561D5C0F4
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B158925A;
	Fri,  8 Nov 2024 16:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OC5xh0UL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E35388D47; Fri,  8 Nov 2024 14:40:04 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377AB88DF5
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so22107265ad.3
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073201; x=1731678001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09jWy177y7hTkp2xx4O2ONRoCNza26sq4tjIsGo1zos=;
 b=OC5xh0ULH3NLYZ7P0t+XR75TA2fi41zBG+LrgtZ+kPSqH4Gfz6bA1R6GVXEC5WKopg
 rW2ioda6TgDb+mdLKwMiUxVeFf+LgKRfg03jKctdj9rnncOFEhbtY9+xuGycxaMsmJFs
 SzuqPf+anY7nSLsyNAuQf3cF85ytxFB4JK80rGzDJ5AyQDJ4AvoSl/DWlLri83ndUi7g
 WMSV4vNilV/NBzDvMjp6PQd2plrDnXI3o1sVtgX+0GGPDp5t5GJxxgGW5tXu/s51WG65
 esVq+Y1xr5+PZ4GHHF3IlY/95LeWWS/rp/zFdmkIyheTgxoNnXqRcY1+K1Ws1ec7TV9c
 /ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073201; x=1731678001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09jWy177y7hTkp2xx4O2ONRoCNza26sq4tjIsGo1zos=;
 b=PDB3Slxazh3eoEtcNLV3vv7tvm9Gs2HalrziERlCiohdBgRlHiI/08ijUxC6lPhHBF
 ccFClAzQRF/5nPck0Jbicy2ZXp7ZsyFVwsw2Mhg/RmDsDK71uBfZ4XV8aHEY8YOwK7c0
 Ly3UC3TkqJJmcSF4DdW6qGgx0kBSaTi8Pkya8cOwPoyA1u5YU4sDJ5YaivjLMjGlLkhN
 YpCz9nxy/EuIN6rCC9BsAqtts4UMhQ1UEyE/TqHnlBqKBD1bvInP7N3tLsagRTOX731I
 ht7sqRg2/YkHU9AHck/KSW2QDix0sAJ6nIzqksGVDpliEGbRMrNrHBmv5oT4vfvWK2yJ
 +Zmg==
X-Gm-Message-State: AOJu0YzsNAVGARKOR4goXgcMoeg0q18qmKRs9Jpv9cgZPyGVLGlmuXBQ
 ErDmOgmxGQ9H/NNxt0VZ2elLgRBjxNpNew/2FVl6fDcUWwBDNZ8NCWBGwR+xf0I=
X-Google-Smtp-Source: AGHT+IENXVud6SOpkzU4rvDt2T2A8MzX80E4Z330lgrcQhI+8fuJTJO18ebTnMS2qJ+tNPeOMZDumg==
X-Received: by 2002:a17:902:d48a:b0:20c:e5b5:608a with SMTP id
 d9443c01a7336-211834dfb92mr39563525ad.5.1731073200596; 
 Fri, 08 Nov 2024 05:40:00 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:40:00 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 05/15] efi_loader: add IPv4() to device path to text
 protocol
Date: Fri,  8 Nov 2024 10:38:40 -0300
Message-ID: <20241108133850.431075-6-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Implement Ipv4() node support in the device path to text protocol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/efi_device_path_to_text.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 0c7b30a26e..481a9712d9 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <efi_loader.h>
 #include <malloc.h>
+#include <net.h>
 
 #define MAC_OUTPUT_LEN 22
 #define UNKNOWN_OUTPUT_LEN 23
@@ -170,6 +171,28 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 
 		break;
 	}
+	case DEVICE_PATH_SUB_TYPE_MSG_IPV4: {
+		struct efi_device_path_ipv4 *idp =
+			(struct efi_device_path_ipv4 *)dp;
+
+		s += sprintf(s, "IPv4(%pI4,", &idp->remote_ip_address);
+		switch (idp->protocol) {
+		case IPPROTO_TCP:
+			s += sprintf(s, "TCP,");
+		case IPPROTO_UDP:
+			s += sprintf(s, "UDP,");
+		default:
+			s += sprintf(s, "0x%x,", idp->protocol);
+		}
+		s += sprintf(s, idp->static_ip_address ? "Static" : "DHCP");
+		s += sprintf(s, ",%pI4", &idp->local_ip_address);
+		if (idp->dp.length == sizeof(struct efi_device_path_ipv4))
+			s += sprintf(s, ",%pI4,%pI4", &idp->gateway_ip_address,
+				     &idp->subnet_mask);
+		s += sprintf(s, ")");
+
+		break;
+	}
 	case DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS: {
 		struct efi_device_path_usb_class *ucdp =
 			(struct efi_device_path_usb_class *)dp;
-- 
2.43.0

