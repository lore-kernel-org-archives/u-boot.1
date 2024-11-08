Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F967D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E318900E;
	Fri,  8 Nov 2024 14:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q094Yp55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A6188DB6; Fri,  8 Nov 2024 04:45:51 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D369E88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so1358391b3a.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037547; x=1731642347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09jWy177y7hTkp2xx4O2ONRoCNza26sq4tjIsGo1zos=;
 b=Q094Yp55KS7dg5uWPhiJkhpE3HD+1SVtyTM2AK1iM0JgFkai/hKUrbBeSUaSPB3Tyr
 WcZjxCgrK+bkJA57tsVBKUZPRT8KRiibp9p/0Y2qX4CULWG3irq1E9YrhdaiUTQoz12H
 QqT5Cq+yB3gXV/lENAR9MZFVHgl0e/r/9DTXWt5OIcqVV/e2thxinEBfl9h14h+NkK00
 E+3LpUX8jqLabzom4b++09d4hvb/uM08cKC+ZcG4WQdouh9XE0VwNUmdWsip4lEeq0LZ
 DPJ2rVfobcN1oDIn6hiHTZWWt1LAGJHqTrehoEcn9T8ErZe2Q6d+r7ypxkyuZKS4ZNKC
 H+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037547; x=1731642347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09jWy177y7hTkp2xx4O2ONRoCNza26sq4tjIsGo1zos=;
 b=wvIFMel5LnRsd3aKRoBQkm3NSv9p8SuyevLyR9nVIfkdRBD5aVrVysB17NF+9IHd0k
 Jq9H42dRuda4tZj9TgI5m78HzjrMLQIDRSZmAS3BlloSBDGfeP1VpEMxh/kO45o2exRG
 mV4jw+l5vwVKmab6hKF412WZLQIXUt9zfTUDEFByEG8XOr2OFkl6pStp9bMJLVwXxZS3
 kAx5jHwER9ieMR22DzUMrN2UIVWxQo4ppPeeaOEmjW5lEYaWjo6Sisn8gS9Igm8dlppS
 GjwT4fvCu9mtgozr3cRlqFuvcyziyKTg2O743CISnt+q8fjx1JF3QKGlyKaK4JtWHJWP
 Myxw==
X-Gm-Message-State: AOJu0YzvnI9EPfYDbQU2j4g2So01FznsdLOvxKmuXf850q8Rbuk7/0wx
 p8jxX/9K7ED5PGTQQ2CtMyfrhF5bUrmDxsLUurL5NZvr8CBnsEVol/XWv3XA9Nw=
X-Google-Smtp-Source: AGHT+IGVBlSo5B7Zk+0tLp0sLCGHc3odfIqV2/MWLivqaljwAUs9XHtU6vJbj9Y6eEIhPU9LKOjzYg==
X-Received: by 2002:a05:6a20:394b:b0:1db:d83e:df34 with SMTP id
 adf61e73a8af0-1dc228bf0edmr2026440637.8.1731037547256; 
 Thu, 07 Nov 2024 19:45:47 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a5719dsm2619745b3a.183.2024.11.07.19.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:45:46 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 05/15] efi_loader: add IPv4() to device path to text protocol
Date: Fri,  8 Nov 2024 00:45:41 -0300
Message-ID: <20241108034541.346293-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

