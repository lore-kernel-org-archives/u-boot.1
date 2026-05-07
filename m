Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9352CCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 18:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C8D8490D;
	Thu,  7 May 2026 20:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZRt1VYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CFE84BFB; Thu,  7 May 2026 20:38:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD1B84099
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bc2a06f3978so16253866b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778179128; x=1778783928; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KxmEJJv1+MuAWvLW8Fb/WslsY4GFOvbFquNvpUoHadU=;
 b=AZRt1VYzItuMrnTkhE8XW4sTo6FHg/QJbgh8tKh2kq4vWSaC3rhyc1KoH3Js5HVR50
 +efzEJPJs81UVfvqf1jcSw2UQgswkl8bCQ8JoV7mSBZ/UOrgi3xhWP3J9T3/RYGVGSuw
 kU+xSCxH2EmmE/F3BVz10Sd9YYcTRC13CtYYIhaL5YdbNSAkLcaOa6wzL1ippivFmZQb
 //4BXStAwgROBHhKnJ2MDhmpNZArpTN6tLsLmmPqcGekrEYGc26zBT6wD7sRYgCMCOhe
 NJYoaA6HRoLG2hGW4U8sRFqUDYsjhpIsCK5YxFsc0GHMD9FaHGe2yY7ytLWU1Dnpz0Xp
 Pbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778179128; x=1778783928;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KxmEJJv1+MuAWvLW8Fb/WslsY4GFOvbFquNvpUoHadU=;
 b=K9YVj+o68MFxP/lBhNx01hjwqs7brevAjFAoIKT3Np8MX4sfoaiTiSQrzb0p7KhLhV
 oBdF8qoevw4EAkXpgn1TZfy44CSwaL3N49rnfLMHvaOcsLsFJficqQCENlucyx7X0kJV
 ZSBjzXYDlsaE5Q65C+d59IuhX8wDjTzHnwaIRUhKVK6h0vw8doOhf4kkzG8HMfqtOSwS
 jYcKMymixC3o7oklNVWrTj3YuoB644m1girmakRDBrLWYMeTaXmHLNZ5qzUzcD1OocdL
 jjiMe6ikqeQ6LU+tmHvnVjRCCz8QC6q3PRmHtlhtGtE7QjsM+GtV6G12SkTZif1fW0jK
 cizg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JtO/wEDbUbNceFcUMhpVXIdtnaYjn0HwruMOvetLLtyUgz7cS1loxY4E4/zgXngJ8ggQKpiU=@lists.denx.de
X-Gm-Message-State: AOJu0YwT4jUnmJDVMR6juEACmCxDr2AUzlQIhpaelEecFxCvfqs3wGc5
 ThUJC9w6Qsitlv2WZYnqsPmxTjbPvKDDyWU5G19aX2Gvf5Uoedh/2599NO3o6w==
X-Gm-Gg: AeBDiev7DEnmFSCqeECZW+9g+8MOkGRHs/5jdLmDl3+XMt6asFmS6vhDKIaX9ERonjF
 WuKFSHgUdOqWVYG6UCW5nNwS2yPTS5VYtOkZ3pKk5BLADSm2G1wB0As6ZM1CS/EMCw988dqsKm2
 ZRBPV3t0Poz/2a7OUzqXoX02JS7/b3l2lYLm9fun0KWwLztfm7+27FAgJ+hlTUspJdTtUgg+1le
 GOg2GCejfJ9+1VQ28RouYBt4SILmNe8fsEpKPx9q3YMaPpfhaRMm3i68rc+NdIImrXrMdH+Cm28
 +/aSD4+3KMY2RwpZqUEeN4S/3LC68vAUz2PxrI8jBCd5f4GtpigJQkrIO/MYa4oF6D+AeT6IWLH
 ssyZbDCxmB/8KVHwjOU+Bwtw+JfPxUDWTlxlvYKBotxS7MpZZMONCvVOhDzPBgRrJSQ/EnoBL86
 I11+EEp7MRh0ak2pFfCOB+wx5Ia9fOPGfrG5mUchQrlRloqF6HDELPYMiFMVIACUYJ/8jBJ7Vb
X-Received: by 2002:a17:907:60ce:b0:ba2:a0a2:6f8c with SMTP id
 a640c23a62f3a-bc5673518afmr221602866b.0.1778179127737; 
 Thu, 07 May 2026 11:38:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bca57eae8dbsm16902666b.47.2026.05.07.11.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 11:38:47 -0700 (PDT)
Message-ID: <a2401657-650f-45a8-96be-0e16660ac3cf@gmail.com>
Date: Thu, 7 May 2026 20:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 5/5] rockchip: pinctrl: use include from dts/upstream
To: kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, andy.yan@rock-chips.com, u-boot@lists.denx.de,
 quentin.schulz@cherry.de
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Use Rockchip pinctrl include from dts/upstream and remove what
is now redundant.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/pinctrl/rockchip.h | 60 --------------------------
 1 file changed, 60 deletions(-)
 delete mode 100644 include/dt-bindings/pinctrl/rockchip.h

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
deleted file mode 100644
index 1c28d6cb1fad..000000000000
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Header providing constants for Rockchip pinctrl bindings.
- *
- * Copyright (c) 2013 MundoReader S.L.
- * Author: Heiko Stuebner <heiko@sntech.de>
- */
-
-#ifndef __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
-#define __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
-
-#define RK_GPIO0	0
-#define RK_GPIO1	1
-#define RK_GPIO2	2
-#define RK_GPIO3	3
-#define RK_GPIO4	4
-#define RK_GPIO6	6
-
-#define RK_PA0		0
-#define RK_PA1		1
-#define RK_PA2		2
-#define RK_PA3		3
-#define RK_PA4		4
-#define RK_PA5		5
-#define RK_PA6		6
-#define RK_PA7		7
-#define RK_PB0		8
-#define RK_PB1		9
-#define RK_PB2		10
-#define RK_PB3		11
-#define RK_PB4		12
-#define RK_PB5		13
-#define RK_PB6		14
-#define RK_PB7		15
-#define RK_PC0		16
-#define RK_PC1		17
-#define RK_PC2		18
-#define RK_PC3		19
-#define RK_PC4		20
-#define RK_PC5		21
-#define RK_PC6		22
-#define RK_PC7		23
-#define RK_PD0		24
-#define RK_PD1		25
-#define RK_PD2		26
-#define RK_PD3		27
-#define RK_PD4		28
-#define RK_PD5		29
-#define RK_PD6		30
-#define RK_PD7		31
-
-#define RK_FUNC_GPIO	0
-#define RK_FUNC_1	1
-#define RK_FUNC_2	2
-#define RK_FUNC_3	3
-#define RK_FUNC_4	4
-#define RK_FUNC_5	5
-#define RK_FUNC_6	6
-
-#endif
--
2.39.5

