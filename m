Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8248AE92FC9
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 23:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0640886B18;
	Fri,  6 Oct 2023 01:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aX2OoT7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CA386AB3; Fri,  6 Oct 2023 01:08:50 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C107C86C2F
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 01:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3529eafb3a9so6270115ab.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696547324; x=1697152124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aB2O72bA4FINfbHMTGYiyRM5U044fF9JN3/NC490yG4=;
 b=aX2OoT7cNJItMqI6FE9mRud11dIg/w30CdH781AeC6UEWDukeBu0Q5HpqUpWsdjFEN
 jCFF9j/xuvtv0XYKQAqnbz/Ft6gQrfoyoN7R9O7ndf2+Jvl642J8UU2veO4YtBsFnb+T
 ihQanFZAHeRGKBSJAR0ZKhYKkBvRro9ZVQnnXE4aAq42pEEIN0cwgzfoPOtc4YVTLLKv
 rGrph2Mke74BBlJtu+7IWqJxsJN1Te8N+0swo4nMATMgDlMhAqmMTiNfuiFm2PGTOK24
 LXnaRWdlP35QrgXiHE7MePup5rMa+Oy4lBx9q7LSh0uG9aHEuiuqCccygbKdWnmBvif1
 Ej3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696547324; x=1697152124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aB2O72bA4FINfbHMTGYiyRM5U044fF9JN3/NC490yG4=;
 b=veOWRBBMSW/HbY+u33Jk7NtzMX+4iWbGu4K9fH2+PWn9I1YWH+HViVP58KdmJ1snfs
 hMlzd5Eod1iHejzZWh3VBMMo+k6nI8Yjv9LH5zIAt25flmogFE5gmgpTGOG+DIdyh4Yq
 4GuhnuqOR9MIylSq1/IdJwj4JUcVDwapaeOo/WWVN0MbL/x7JzEej2Od2uF6kICn0m5/
 w/rsmP+GK8C6LwAE+V2EHOQ0/X7rVrBoDnAIwEk7A9iPBbV8u8ysXnLOGg65OK1YkW1v
 HztYmDNffLnE8hhdQfx+5UEHTFhpCTjSHWi2tIVNo2XzrfLeaPThmLKSjPmyWy+2d6vp
 v0dw==
X-Gm-Message-State: AOJu0YzYjmSJMeCp/luN4/7hbwmWc0tLWG5Marex33Aa2yvfpqPY5GZ4
 I9bc0l+JYIVDciSlTnjkoE54GdKzOe70ew==
X-Google-Smtp-Source: AGHT+IHeqx6BxOwFOblOralPjhFpKAte6AYyM08J+kKaQ8m2wLLLeD/nghWBJkuxmEIeTM9U3TzY2g==
X-Received: by 2002:a05:6e02:1061:b0:34f:d9db:66c4 with SMTP id
 q1-20020a056e02106100b0034fd9db66c4mr5983857ilj.30.1696547324061; 
 Thu, 05 Oct 2023 16:08:44 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9b88:f219:40c8:60fc])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a922811000000b003513b7613f3sm709974ilf.3.2023.10.05.16.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 16:08:43 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Schocher <hs@denx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [RFC PATCH v2 4/4] HACK: enable access to `ubi 0:volname` block
 devices
Date: Thu,  5 Oct 2023 17:08:31 -0600
Message-ID: <20231005230831.4032070-5-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005230831.4032070-1-CFSworks@gmail.com>
References: <20231005230831.4032070-1-CFSworks@gmail.com>
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

---
 disk/part.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index a4b6d265da..7c995f583c 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -14,6 +14,9 @@
 #include <malloc.h>
 #include <part.h>
 #include <ubifs_uboot.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
 
 #undef	PART_DEBUG
 
@@ -524,6 +527,58 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	}
 #endif
 
+#if IS_ENABLED(CONFIG_CMD_UBI) && !IS_ENABLED(CONFIG_SPL_BUILD)
+	/*
+	 * Also special-case UBI, which may use names to find the specific
+	 * volumes, so this deviates a bit from the typical devnum:partnum
+	 * syntax.
+	 */
+	if (!strcmp(ifname, "ubi")) {
+		dev = dectoul(dev_part_str, &ep);
+		if (*ep == ':') {
+			struct udevice *ubi_dev = NULL;
+			struct udevice *vol_dev = NULL;
+			part_str = &ep[1];
+
+			ret = uclass_find_device(UCLASS_UBI, dev, &ubi_dev);
+			if (!ubi_dev || ret) {
+				printf("** Cannot find UBI %x\n", dev);
+				return -EINVAL;
+			}
+
+			part = dectoul(part_str, &ep);
+			if (!*ep) {
+				struct udevice *tmp_dev;
+				device_foreach_child(tmp_dev, ubi_dev) {
+					struct blk_desc *desc = dev_get_uclass_plat(tmp_dev);
+					if (desc->devnum == part) {
+						vol_dev = tmp_dev;
+						break;
+					}
+				}
+			} else {
+				ret = device_find_child_by_name(ubi_dev, part_str, &vol_dev);
+			}
+
+			if (!vol_dev || ret) {
+				printf("** UBI volume %s not found\n", part_str);
+				return -EINVAL;
+			}
+
+			ret = device_probe(vol_dev);
+			if (ret)
+				return ret;
+
+			*desc = dev_get_uclass_plat(vol_dev);
+			part_get_info_whole_disk(*desc, info);
+			return 0;
+		}
+
+		printf("UBIFS not mounted, use ubifsmount to mount volume first!\n");
+		return -EINVAL;
+	}
+#endif
+
 	/* If no dev_part_str, use bootdevice environment variable */
 	if (CONFIG_IS_ENABLED(ENV_SUPPORT)) {
 		if (!dev_part_str || !strlen(dev_part_str) ||
-- 
2.41.0

