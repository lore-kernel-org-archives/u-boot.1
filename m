Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA858C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C5A87ABA;
	Wed, 17 Jan 2024 08:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f0ZWJq5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B379587A98; Wed, 17 Jan 2024 08:53:22 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2640687AB0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d5f388407bso7362395ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477991; x=1706082791;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VDLOTRjl3lCujyS2QEZD7Uk511tI4DdzAii2iAhmyo=;
 b=f0ZWJq5ZLXybYsn1MLJTtR5aBJh4RregsoDZIXygb/xOY/PtastFiP1Pht3zCeXDWF
 jM57A1+y4vuqol893FXK3c3ywgI+Aa4zdzDrEQ0180KzjuHbJU2SgA/oUCP6Vm/2Oxke
 TwqxpPkZRoshgxdtVrWBMUwyzVpSe41Nwf9nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477991; x=1706082791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VDLOTRjl3lCujyS2QEZD7Uk511tI4DdzAii2iAhmyo=;
 b=vM1GroiazTbvn3EfE1ITNuIRKOl8JPs6OIXEqeatqcmwqT3bZZ9x7eRevoMKz9S5e4
 HsLAxNSK6sCol54CX0aDD2jZooL78JmU1YjYUNzjnse1rVCNXn+Z2Wkf66jKx1H2z6ry
 Xh2iQWBgy8Ldexa43hOREVS8ePb6/zPM0uabCkvJ0pkirPhyvIHHq7+ngt5qwjv3OiJ4
 o/gPb9k3WSF7CVsKYfP5xJ5tW7FvDokiMa7YgYnxgTaqfmgvQhygYL9pP0cInBvB4m5T
 H2OewSoeBUuk/7NEUUi0QlOiFEvUJh0sTQiqM3i5kUpZeh1iiusXtKmPkR2qzco57dlf
 gk8w==
X-Gm-Message-State: AOJu0Yy2Yd6t5uBHayDTIqNpqkuIfkOEOLz4ketjqfCqSXiWnKF4wlyS
 0suLk9AV7LNd0IWXZxh52Y6+kWc9ZnYfLw==
X-Google-Smtp-Source: AGHT+IGDJMCJQmrjABqcwRa0v8mZkrkeNh7g0tAVNsySdjdlPc2OppBBOMFwvzppiEQTgbL2ft925A==
X-Received: by 2002:a17:902:d892:b0:1d5:e998:8db6 with SMTP id
 b18-20020a170902d89200b001d5e9988db6mr1555547plz.99.1705477991617; 
 Tue, 16 Jan 2024 23:53:11 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:53:11 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 14/17] ARM: dts: rk3328: Enable VOP for bootph-all
Date: Wed, 17 Jan 2024 13:21:51 +0530
Message-Id: <20240117075154.58747-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

Model: Firefly roc-rk3328-cc
DRAM: 1 GiB (effective 1022 MiB)
Video device 'vop@ff370000' cannot allocate frame buffer memory -ensure the device is set up before relocation
Error binding driver 'rockchip_rk3328_vop': -28
Some drivers failed to bind
initcall sequence 000000003ffcd5e8 failed at call 000000000021a5c4 (err=-28)
 ### ERROR ### Please RESET the board ###

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index a9f2536de2..5258fec566 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -68,3 +68,7 @@
 &spi0 {
 	bootph-all;
 };
+
+&vop {
+	bootph-all;
+};
-- 
2.25.1

