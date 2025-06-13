Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1113C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0F082F46;
	Fri, 13 Jun 2025 15:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V8yKEDXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519EB82C30; Fri, 13 Jun 2025 15:22:20 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E5482CE7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so345240066b.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820938; x=1750425738;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c4ovgK4LJKQkGUqJK57pxqaZXGD7781Dcq+CDSilOYM=;
 b=V8yKEDXj8LVXpNrAp3JAmjyoI9Xu6Gkk9ZcVOz1FnpIxqI5/+k4STSyPTZn454ny6A
 9hh2Ul/ZQZy212O5FSbgSKNAEiRnTrLgAiBcu8KICBIdYaMAzRAIGb4TMYOzbou/8RTX
 YK8vSY+V9US0IHzqA0pOwEDZpZnkhjZ4/sXGfGyQmBeukC0Xs7pxkq1lBJWWuLDnK9Im
 DayKq78q007KgePgMaZeM7e2Yd9F1QVKdcawc5c5VY5TeRmXbEWIC6DRwUByOpQSbc6M
 cNjA/OpWUfOaH6jYV+7REBOBSdBLKHY9qUHEGgAb97frw7vQKCfIsPfshP6zzNgvy2VE
 l5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820938; x=1750425738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4ovgK4LJKQkGUqJK57pxqaZXGD7781Dcq+CDSilOYM=;
 b=pKP34gOxbFqMQDsdTj3qOhcBgUsuhTjjyNAbKVKblyGQak3wcm7/YJCK9dZedxGorV
 KdUyZBtarUTeAp8umpUyNy5zCl1mZxGdSsde2BsQEsJf+y2P21ZfF7zE/8NCSMrNhGAr
 XY7q5izP40JP946QJj3dLeRO7CvGXKkRDiSULc00TzVwAeJGBnAbn2NZJRknPmI2Pemc
 qDvpanqChDeYeI6qWQ1o/tkvhi32VROZ6OKhDxF7nlDq8bK1L0eJKrDkyHRrk1J+7gsK
 5dqJN/x/dbCbkeRtWRC7REtN1x7SubZik1K9pVRLPOw9ad0uiMVSXRgOVgmpzQfuTzza
 +Rqw==
X-Gm-Message-State: AOJu0Yz5ptaQcJ5CFlKrAGcXF29rAYnvor6k9qwjX4GqORlp5KdImf7Z
 rtDMslOk58SwblZg66geGGXzN8v5s+oSAtSpJWdcz73hripvrwESyLq35PXG/M0TJ6M9PBsrpb1
 oosvE
X-Gm-Gg: ASbGncvID06e70tVRdXcBFS8OYjC8JLiKtk1PcVADW+n+MidTcrsKyu5+znGbx4X9Be
 4Wj8pbwQ5KE/KIZOex05SKVJFPQDSBeJUGXIlGqvXzT26GpPLaVBxos0k+IcLmGKl4f8Vhetb+O
 WPGXr4bMPegPMgdANv9DKgGO3bctRLPArJwJr0lmzDElDjRldZp+m8owkjXi3f0I4MgAZ1i+zQx
 2HYSvDt/ODaXvxL0cOAyl7K7dXXEivPPkWGGhr6A/VjNX258VcUTojUvhgUBSRZWBfKXqJofFJe
 RHZZ8AJyArFjxRRNNwtVJe+nR28QJNcEb8NR7oKWdQIJ5f/SB78g5g3vXOo=
X-Google-Smtp-Source: AGHT+IGBBb5lyfhNGgKNWCJ5ym2uSTg6R/nhzRKmj6JXACPxzoYleRgRWqB9S6eXNXER5e2ysNm0Sg==
X-Received: by 2002:a17:906:7312:b0:ade:3413:8778 with SMTP id
 a640c23a62f3a-adec5caf42amr298359566b.30.1749820937816; 
 Fri, 13 Jun 2025 06:22:17 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec81c5be2sm128943866b.64.2025.06.13.06.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:17 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:42 +0200
Subject: [PATCH v2 22/22] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-22-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4ON03dX6HJoJByhLGmCG5Fy58aFAKYFm+72Jk57rLb4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1dezN1Q+OlGnWq6WkXD+wzKB20d0t4Yt32h02HlSw
 USnX2/mdJSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEZhYz/LMzeTbnXv63lGLd
 qp0+IhMsJ61ctGHGt476CQ6SucG9HwwZ/il+Vdxzkzco16c1aKpweuHqSrFVM98Wq2ZG++8w3MJ
 3gBkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index f2e1f31ef0f5c1d30706ba676f9608943dcc929f..266883f523e701d18df3acaf51427ebfa37e3108 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -122,3 +122,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.49.0

