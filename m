Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19F1C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E38836C8;
	Mon, 26 May 2025 12:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F15XY+OE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54616836C8; Mon, 26 May 2025 12:16:15 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B897836A7
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3da82c6c5d4so18494645ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254571; x=1748859371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p09O7IPm/+ewfd0wsG5El1kb6UrNQ+AJimfZThD00rc=;
 b=F15XY+OEC8u6ojukKZWoY9GJX+sBRq7EqZN6/Q2+awFOvoyvSLR8IEIS3SOtgt22ZU
 PnYvi2OhdZDz6VbBYdXTwuuHKQ/3R2tleES6QR2Pkr1mPrZOQ00sRAgG3bxHviX/JCPF
 Y1Y3/ia+6mrhMeLVzMacDiGOUHr/pPLOsxfKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254571; x=1748859371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p09O7IPm/+ewfd0wsG5El1kb6UrNQ+AJimfZThD00rc=;
 b=ZaqNComIgeSlfGspxi3gxJhbHyxJf7ERMBbFzkyeF9Jyel2IoA9jEMLpSh0neBiGQp
 YlHz6GviCWXXRbQ3DEL9CnnIuY4r2EpffG1tCF8Jme3hGNxElJ/cqIsHL+fsw+dggoTA
 q4UbVEjQhwiXDeiTCEggUsEt3mxFXd1fVf15zV4uJAgHhE+gxb29XqvG1qBE4tE1hGSD
 R+PzMxMnleRVZ3eIuc5MG1nmmMtWdnPZyXymOi7wpERBUW+OwJqrXj0SflQ92mcUdDqb
 PnrnA+P/xGwJeYpmw+MWjbhAaP15D1WARPukjQ2iqP7fnhA4lHFEUjYMizmMNwkycvPF
 prSQ==
X-Gm-Message-State: AOJu0YwYkklgjsPkZzmod09v0MZdJeqmt7+qdo5aNN6C80nCMaKHGYiP
 v+zyS8MEI4kHF8pk+kaeY0dhbHJ+nuzy/PgDaJ9ccSg9lzlK6F46mPOJLOss6mtbgokWll3vCml
 icR6HmpgB
X-Gm-Gg: ASbGnctcjk7g0PQhoUEunkCu0rJubj1HzjrfXTzhT97JVOTlwQh+Ac3TiXTVbPC7gEv
 pNck0Hle0OB6fMJ5mCAQssMb99/vrDq8Ksvf3h42TQjVwerbXTQot18XHe63i/CbLJwrToMwdPG
 4hHHXSVAlW4qT3lfNg7ecmc3JF9YgXQtGEyxmnXjt64gSISkHfHs6ln0yi9cWsFes27nSUKaPjN
 uafeHxBcyGs4K8UcNIXu2BOvj0DuCbvb4bv8Qvb2czPCEWku8Sc7GtF3mn5SIq8rE+JsEEN5mFx
 r9DjPyUEIGOWXDXDI48ch3n2yUQkxt9vrBdUyFt+X2L8PHGibACppc8PrFbMFK4u3c32Rpt7bEP
 v7znsw82klpif
X-Google-Smtp-Source: AGHT+IHGe0miRgtfB3rgphDEQqbdTI9cNWayLOOPdLC29BS0FOA5wsAuANsiTFbFTLZTU5kJAHabtw==
X-Received: by 2002:a05:6e02:32c6:b0:3dc:8bb8:28bf with SMTP id
 e9e14a558f8ab-3dc9b6aa189mr76185945ab.5.1748254571515; 
 Mon, 26 May 2025 03:16:11 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 05/25] rockchip: dts: Add an fdtmap
Date: Mon, 26 May 2025 04:14:51 -0600
Message-ID: <20250526101541.3254628-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Add an fdtmap so it is possible to look at the image with 'binman ls'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes in v5:
- Drop stray #endif

Changes in v3:
- Add blank lines before the node

 arch/arm/dts/rockchip-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index cc2feed6464..b8a3d6b6273 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -192,6 +192,9 @@
 #endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
+
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -224,6 +227,9 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
-- 
2.43.0

