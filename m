Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC65C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DDA82F28;
	Mon, 26 May 2025 16:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="icltiNf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1641C82D4A; Mon, 26 May 2025 16:24:49 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D60582E17
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-603fdd728ccso3125430a12.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1748269486; x=1748874286;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4eybnPAuz41GVo0y6ufQUF7KNsVi8svit+LKnXGggfM=;
 b=icltiNf0RhkgDxCqCmbCdMWsVWOzlWkLsIwbyH2qnzS5/CHPRMVAiQrwjyLlZtiZS1
 4liuKa5tWUfTtRkuYRNtCqiF0lbb4x4+R/0OBrfpEw1SMqKwA8BAkYZWkqnkAtZqQGNG
 iAUDuayQnls5p8XuKbfs7GRA5IKiHchIIsoaU0FDdAvS8uq1ozdQu4sw5hcWLdmhSFua
 9HJrhckmFxM9qsR35EJR7ak1EYCfXhUCQl4/VIy/AW4qsYfmiC81/A0LWG1CY0zU6bIu
 /NF8s2vV1r7fOPmVji1xGOWEwOnfCRqOsPwq7fz4Xq6EeZCUmv3/KHA9R71K8Uy4tTQT
 ffZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269486; x=1748874286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eybnPAuz41GVo0y6ufQUF7KNsVi8svit+LKnXGggfM=;
 b=lDK0RMf1rMdEDIVlchwYSLkhAuPk7MGbg0u5pypsR3UGIudkPbtDPbjrLJPm/8J0Zt
 AMChATtsO+5odUddRdYK0Y2p143DhvTe6CReu9ex8gmAhREMNxUsYmfZHngjXLGBtf1n
 /L1b0ax8cKn5dS+gKbnFrFcpYp3BJu+y7ptuz2yaT9mqmfhBapV+8osVzkHDr20MoU8E
 uoDAc3BrMswFo7BVxR2Rd3AAIDWkjgoslujmkktiyEWaca+iROroAX7UKdhVYIo/zgGT
 ss4klh6iW6we5CFpl4WA6VtMKdOI9qGNvsIxpMpET5T6tmpZKGoynl6Y7V61jPco9jDN
 9xxw==
X-Gm-Message-State: AOJu0YwKbmk9AK/81BhoLulT3tobAeyovCZKwio63RZVq33T/cTAaiaI
 9eh86z6D7igrskVFjIyv1yJ3eGWd6kHRaf4UzvgC8tQffXk7dZC1hby+nNn8BENDcWbg+6Eg8eI
 DI3A6LX4=
X-Gm-Gg: ASbGncsJIAF3w9er3c1EkGlzfWzslqktoqQONsXKWa8JWh3ztTO5AhOI/86AT9rNM7G
 PIiEs9uOcbnEPvqq1z5XM978LquvzWpqZrrCL5HHcGlN/pQtsqGuNde2ZHGRBJHlFTjxlkEz5IS
 YMS4iMfzOmlk4UaHD3LpWD1J6q7f0e8wrfVWaU34qYFnaYQPlQ7RIyVD63O8tvF5gUQh72XhZp+
 pPYWUf9kciy81SE0ycncmohpA10vGz4zM1t7RYj5I1eMJjpTJsaAZCM6vqX+T573+p4NTtvE2mE
 RHA72d6beMuCCxO7MVPSCf6AW40OpBnZ9QMIn6vQYf7xVlV3al7v3Sc2ywRcakTm
X-Google-Smtp-Source: AGHT+IGjnVIBSOXlqQW8CuktjoiLvdza1X93yYmh8Mbyn7Gh8GBTjms3W5/i8kJ9Sp/s2MnwfFF+zQ==
X-Received: by 2002:a05:6402:3582:b0:601:f92e:71e with SMTP id
 4fb4d7f45d1cf-602da304191mr7379434a12.25.1748269486295; 
 Mon, 26 May 2025 07:24:46 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6045c6d25dcsm2926950a12.8.2025.05.26.07.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:45 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Mon, 26 May 2025 16:24:20 +0200
Subject: [PATCH v2 1/5] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-usb_onboard_hub_cypress_hx3-v2-1-f382415da84f@thaumatec.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Currently the check in usb_onboard_hub_bind is relying on specific
compatible string for the Michrochip USB5744. Replace this with
more generic approach that will allow to add new types of devices
to the of_match table. Because the driver only needs to bind one
"half" of the hub, the peer-hub node is used to find out if it
was already done. In case peer-hub was bound, -ENODEV is returned.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7fe62b043e6a..3dfeb0cb5a59 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/uclass-internal.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
@@ -179,8 +180,8 @@ err:
 static int usb_onboard_hub_bind(struct udevice *dev)
 {
 	struct ofnode_phandle_args phandle;
-	const void *fdt = gd->fdt_blob;
-	int ret, off;
+	struct udevice *peerdev;
+	int ret;
 
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
 	if (ret == -ENOENT) {
@@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 		return ret;
 	}
 
-	off = ofnode_to_offset(phandle.node);
-	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
-	if (!ret)
+	ret = uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node, &peerdev);
+	if (ret) {
+		dev_dbg(dev, "binding before peer-hub %s\n",
+			ofnode_get_name(phandle.node));
 		return 0;
+	}
+
+	dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
 
 	return -ENODEV;
 }

-- 
2.43.0

