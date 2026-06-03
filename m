Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC20CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A9D84715;
	Thu,  4 Jun 2026 01:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FY2eB3l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0488467E; Thu,  4 Jun 2026 01:51:10 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCFDA83EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec85f03e14so2162466b.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530667; x=1781135467; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5jqcK45pGDnWwmR6dGCWbb2ruhRPcYZiU5hB99UX0y0=;
 b=FY2eB3l5MhG+AmGDFHI9L1lfdSXXLzuDJ/QEMKiZa+1cfiK3OGMP9lIH2tk2YBmFyZ
 y1QkVCGgoqh9VIpldTg/gUJyaIcYAektrE2KtJ9LGMTUtqDjUWyXB4QZMhAYs3qwZ8kj
 6GnkWkfrewqko7y49PXPMY9Jb4bOPUyattYOdk2aJbcuRlG4DXZUKE7UTWE6dy6a9E97
 HqhJDDndZXZgvKmrlWG4YuWuvU5bmcoYg6z0/5BFR+BhCoRBZA7pc9KPN49BxL1mBSDC
 8O9Znw2XFbqjZKEyxHWZSaxIIGoSWPQ+f58GKrpY95vpWY8HXq9ONRUzHIWZkomoAu9T
 U5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530667; x=1781135467;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jqcK45pGDnWwmR6dGCWbb2ruhRPcYZiU5hB99UX0y0=;
 b=qzDgYIDrY1otTynjlm3KBxSRp4IUZ2NbS0A8mfg9OmVqGaIG0VaBda+SdZGBq5Esg5
 0SLeaLJEEGPLsWYYGnsTpaI70n/ji5FmOwwbmUIKapYoAG7JOFBvB+hWvdT2QhvFlOB1
 SkFzdQKcsjGqHeC+701lHBrneai98iohVNjNmWHtx9klWRVcbWVOQllde6qg+fw31tj1
 8XaroAar8LBvZqzrBWxBaZs+Cwn9C//UD9i4W7jYj+IcDdivG6Wu3+Mr6DzQW7TeW8/Y
 m42creGS5QTu2dJVc+P2v8QV7sF/JXTJH2vvR66PNxu3nt9OPeh3w8RUYq+1H6bmtV3l
 KSFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8opJclYRHAFkeTnx/tBBQdfDa2LrN8iVmth9S4T4kM0wSrEMo1awiLNlAH1KfI21BDHJioHec=@lists.denx.de
X-Gm-Message-State: AOJu0YwE1jrLdVgBLGduJBmX57B1P95CYsjcIDLCfmm26MELY15Gv2hr
 KGZYjxg+xdrrC/q0jVo0Q3h/+p+QYqVOfJvbE+q3aNLxaMft3ja/0KbJ
X-Gm-Gg: Acq92OEsIziSPmwVoQ0mcjoWNRmt2Z9nv1e7UfHUJC4fz3wGsC7zOVOsilm7vpiTs5x
 /dM2tPvyrH8iLy+kOqVi/LEYb4Til8nhWQMyc/rMIao6EjvqfeE3rlAajSceNDUdevzuIaoDulS
 Feto/kwLmrDy/Xouw0OnTs4rRc+Ke3kZmXR5B7g4Ratjt6DFgIYhriAd9K1UgZHsuajszHI3dHO
 cfg1n5lGqyPjeWwMdHdJjhpq61WmxgpCP2emfXE2hoNcM4/79Mu5ifCvTwHJIZrd2lgyB91R8oh
 qZLB+3XoqKdvxI1hnnrBDHSInRaKOGwZILptuBs0h4Q+4EgnOB4YfpSz/iw/uWftm8g9GoAnwaU
 e7n51cbq8eGG+QUvtdxorMh1ly1yfs83SbhvN01UgA+/dUNe3m3s5pvFaTVckv50/po6MQjzH8K
 02lDGWPLDPe2uf0DKZfHcONzDPWkmSYlCR8xbHIuOvOMVCGVYZ07U3UA8S/uDaL1wRUjloESKz
X-Received: by 2002:a17:906:c14f:b0:beb:3449:5fff with SMTP id
 a640c23a62f3a-bf063d3dd8emr162981866b.0.1780530666833; 
 Wed, 03 Jun 2026 16:51:06 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051b8c7efsm220553966b.14.2026.06.03.16.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:51:05 -0700 (PDT)
Message-ID: <4751708b-3b1c-41b9-a539-8191be081ad6@gmail.com>
Date: Thu, 4 Jun 2026 01:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 08/10] rockchip: spl-boot-order: add usb boot option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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

Add usb boot option to spl-boot-order.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
(Jonas)
use uclass_find_device_by_of_offset
---
 arch/arm/mach-rockchip/spl-boot-order.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 6572dde29f65..410c799493db 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;

+	if (!uclass_find_device_by_of_offset(UCLASS_USB, node, &parent))
+		return BOOT_DEVICE_USB;
+
 	return -1;
 }

--
2.39.5

