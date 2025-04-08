Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78431C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D12D833F6;
	Tue,  8 Apr 2025 11:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N818rgAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFFF833AD; Tue,  8 Apr 2025 11:13:51 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210CE833D0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso38200025e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744103626; x=1744708426; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TUt/PdLS+D/EZ0oATS8bLOXTFUuI6RbIUSJ16QFezuw=;
 b=N818rgAR/qF9hRWnHH+v8Uo1nOTvavzAbkKDvoADskTIocEMfHZHOIOVYDwrMgrjpP
 inP3+t2JCxEOQBFXuEW1DFIUL+MD5aU0aAjvxOJdmukeJaE9Z7p2DS16vutKj22JPsGl
 068mx/xH2lS6m77gfGfXAX+IprO8uhl5w2RNo5ecRgrx/5sXv7jazP71DpuZ0hiTZQHl
 m3px+ecGhfkjoSGr+9FtJSpeWudAgZ2U8wCAwoutu0bJy9cWiJ/vQGQ6nLzmTPZiMXO+
 uE8IGZN4tFOMVLjBiH3Q94O+hIsIsuqQVpNhopxh4bOfZoGr/tLE5/x98YM+yD8+fBH3
 lPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744103626; x=1744708426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUt/PdLS+D/EZ0oATS8bLOXTFUuI6RbIUSJ16QFezuw=;
 b=RgYNTBEJKw3p2eOqrWC7Rr+YP5Jo5V132aAj+N8OsoQ0Z/OpGSJBhaBYib21kyKACu
 WoRiKkRg6sG2bGKDGZQauFvx4x1JNpzszoY+zdSlhgiQ/Od1FpcaoKdWFa4olbUxPVeP
 n/1FJ+SWkfM/+ekxCZqwz3WBtEdnFJeArYaQz0hBSkN+ZBza+BntdXHg9CywWdJ7WtRN
 DXxtc6F84JhCK1scP28RZ5l6cziL3+xbLwn9I/ypXnKdCnrQXiXLuR6Mv1sFiUEnoF+Y
 LZJDt8gZU49bPd6dnP85UjRNwLmlkpvuuxkiH2ZqhKgKbBYtxatupQH1tUuXn/tkb8KA
 FBuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxUHUV2UD/q7oO9IcJb2GwUwrg0ExnxRtHZx0CO1DMI1uX309r4vYrKqtmUgILyY9mgk/l2m0=@lists.denx.de
X-Gm-Message-State: AOJu0YyjatslrHxZpK/aXVP0+OJ40S6GuCWSyv0oHhVsM5xWc2ogaWCP
 KtkcMZuWrQ7G8sAtMhswsBheKIqJJDqOXP+rtVmQoYpTv4NCQBZtTX062tpPpEnjnfvvlqPrq7G
 2
X-Gm-Gg: ASbGncv3KjgIfs7JMqvymMWow+wtBwVGn9UhacX08VbVYufe9M7iAtDU5JbOKwf4ZwZ
 zpc221IuLVsigZbaZsloA2ZBZVonX26+mQ4ZsTJL4mROBj2P+YASI9Y9/o8kuJmj2S9aFWlawBk
 WKZe2eNCEhoPvRr5BFgp5Qw2x3dpcJ36UN0Wj2VaOvy+wOtn3hXXOzdQbNX8ve5NPDGKJgvWj4P
 tB3VNMqSMQaEScKBpd/Ic/+7yZmypvRG1be/scXax/SEkk0BwRd+hbiMmz7yVm4EfyNblSZ9l2Y
 b21rA0TitkCKYgj7DMelcAKowh6B/yEW7cIGN62GKEKGBZ7LZkkU+SSco34Y31ENRA==
X-Google-Smtp-Source: AGHT+IFBmUVftpf4IAjp8gIK8VtFjrLHa1RugYyH1DF4WsrXJ5x6oywL4ixqGgks1SurCMpL8PlfNA==
X-Received: by 2002:a05:600c:1f0c:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-43ecf85f4bamr137064695e9.9.1744103626628; 
 Tue, 08 Apr 2025 02:13:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366aa29sm155056555e9.39.2025.04.08.02.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 02:13:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Apr 2025 11:13:42 +0200
Subject: [PATCH v2 3/3] block: use part_get_info_cached() API when scanning
 partitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-topic-gpt-cache-v2-3-de76e47debb7@linaro.org>
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
In-Reply-To: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3VUUXUHHK36WmdgHTTZknhh/dGAKueo+uN8b6XY61Es=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9OjHHDceFOj6O2wKRIV6K8UNThk+LkTnkFjdlWTV
 aNhYlZaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ToxwAKCRB33NvayMhJ0W64EA
 CWJbzZNNmCm5/166/40et5aGKK8So68OmFM1oshzu2fplgogH5UFsgCWYBnj7ehCUm+34mbMnIYWzk
 PTXc2xx8rware8FpDh6HWoYCzh6E1+ABdLXCdws8olduLpVx7qHPZDRIlQlys0ZGBc/+VKKlzh4S7Z
 ydzrsTjngeRg2TnaJNJn983F5RDSlPxFyLMEQot+LKZGRjVQTzxyze0iGk37bSldJOctb0GfO42enw
 9cdxLJhol5vy/s98PoVrMHq6WuP4XYf4VusKE9TeAirFTbV5DSpzKWUeyTHfjfSPeuK9bOje9KfgKY
 fnhVcSKsxs726VNQvejFZomgNQYsircGWcsS37pVecQdMGzMRPLrwh4YxOy/xDymZrZm8TAe9984Xf
 Ngw7HcEJs7s4Y5BUexCkQ7wLImydpLXCKh5/lL/CUGr53hmKVcfShUGKQtOaZP4i1MOJK93wag9SjZ
 meIwzaK+Zgms0cwFhdILZ/ryd1k02GzL2ZOpED3tQxsCgqrO3Ecq7WC5mPng+VVh/0cRsbQh1rNLGv
 w4H6CLjVC1MgcUkZCO8OKb+WtbkNZ1nGuHXgRQb9/atWNxbWpRzOf8GuOrTW5O1NVoYMgsbevsnXr4
 ciydtukKn8HXFHwsuwRiGcSjVicNog5KZVE4DJeTURuyGUoSaQzUeqjUwMHg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Let's make use of the newly introduced part_get_info_cached() API
and the part_get_info_cached_free() when scanning all partitions
of a disk. With this, a lot of unnecessary computation is saved,
leading to a faster boot time when partitions are scanned, especially
with storage medias with potentially multiple large hardware
partitions like UFS, NVMe or eMMC.

Since the default part scan code will always scan up to
128 partitions for a block, and devices with an UFS chip
with up to 8 LUNs are very common in the field, this means
a complete GPT parsing and validation will be done
up to 1024 times instead of 8 on such devices.

On the SM8650 QRD platform with a KIOXIA THGJFJT1E45BATPC
configured with 8 LUNs, the scsi scan takes 0.2s with both
CPU caches enabled, but when disabling both CPU caches it
goes up to 4s to do the full scan of all 8 LUN partitions.

With this change the scan takes only 0.18s with both CPU
caches enabled running 1.1x times faster, and with both CPU
caches disabled the full scan takes only 1.27s running
3x faster.

While 20ms could look negligeable, it's still a 20ms gain
in the boot flow and a non negligeable reduction in
calculation and memory allocation since for each scan
it would allocate and free the gpt_pte table up to
1024 times, now it would only do 8 allocations, reducing
memory fragmentation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/block/blk-uclass.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index f3ac8db9464311acbc96f3358e0ef143471ca59d..313fbe6a480e5bced5230c6ea03a3815cf4087b9 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -820,15 +820,17 @@ static int part_create_block_devices(struct udevice *blk_dev)
 
 	/* Add devices for each partition */
 	for (count = 0, part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
-		if (part_get_info(desc, part, &info))
+		if (part_get_info_cached(desc, part, &info))
 			continue;
 		snprintf(devname, sizeof(devname), "%s:%d", blk_dev->name,
 			 part);
 
 		ret = device_bind_driver(blk_dev, "blk_partition",
 					 strdup(devname), &dev);
-		if (ret)
+		if (ret) {
+			part_get_info_cached_free(desc);
 			return ret;
+		}
 
 		part_data = dev_get_uclass_plat(dev);
 		part_data->partnum = part;
@@ -847,6 +849,7 @@ static int part_create_block_devices(struct udevice *blk_dev)
 	debug("%s: %d partitions found in %s\n", __func__, count,
 	      blk_dev->name);
 
+	part_get_info_cached_free(desc);
 	return 0;
 }
 

-- 
2.34.1

