Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB8D10775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F368352B;
	Wed, 18 Mar 2026 17:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sTbP+b4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9724A83B03; Wed, 18 Mar 2026 17:45:25 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000ED836D3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b3f91a7abso9628f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852322; x=1774457122;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lrbSIBpctXkGISb/yjYw+2OsKTOpBgX6bsKq33kMLfQ=;
 b=sTbP+b4epGBSOlvC8W47phs4ClRct/fdiNWIlNFlF4lqoN8Htj0iZJxeVoKIF3kNTu
 AP1+o2YMQsRczgDl5eay9wZqE4WzMIz/bMH4hV/kly3MhesPVacB9JZepgocY5pDZTPl
 gV/OIS9Evpdjb90O6tW/72YuxWD5hECTnHUs8DWpCvnOdgcp3kCqj/+hCbMiJ2VFbp+K
 7bwhfxAmJQolGrOh1mssHUB9LHBtAQi+DANhfpO1E5oHyJ6gwjzeK+DIJwHtNKx46XQY
 BfZatDMxyVusu2le1v93ZUwtvGs4OljWRf95Zn+YoIFkrMC3wPIo0k6uxk23WqtPd4XV
 C0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852322; x=1774457122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lrbSIBpctXkGISb/yjYw+2OsKTOpBgX6bsKq33kMLfQ=;
 b=EnxebNCFnM8zqQztNjSmb6xDgOWx1dzpNUrkN01OlqiD4hB2nTYBcdt3HAr6kWshO2
 hJGvRI+sWJQb8ynEPNmVphVPbxg/ifHhQPjrjZo5FKg7jZy6PtX6QlZmvfjr3XA64RRq
 /4mjmOQALQ8so4K2vz9MKCv92U/j5mWDXYH28I+h5JHX9UZfPRsmYLrwAuPwWiFMHhwq
 ceRqK9N0n7KgW0MzWjGslGgZTm8DtsnRRyxpyKJjBFwQxlORxEbKJ64A4SeMmNJ8mRx1
 ArPDT6mbIu2x/wD2nhAF5QmhoaYCcHtYnVbN3bVIXc88aLrJFRoG78Z3lus1mtP5ca1v
 DstQ==
X-Gm-Message-State: AOJu0YwrQUvmqyLIe8RSVp7zgnRXeevyOs6yE/G3ci+K59XLsvVdskqZ
 4X8/DR8Ivc7L3Qh0zwy/DCaBNM3vMmNzBn0RwQSmBW8Y3UZUaQvz4sUxYDU0vcbcjG8=
X-Gm-Gg: ATEYQzyivL5o3vaAcRxLhLxRe4eQmDxjAS14tCy+1gaux4sWGAdzEupxIRk9LQESuj2
 HCx1ouVZCE+hbKJm6FPZ+ISQMxoB8BWjXjC4LjTFRK6AB39cXkwTtFaypS74CeAnNXPCHKC82KZ
 FxmqXNCj03X6arPp2uI3oMW+F0aS9ecrRi6+fKRVTIIX98uUD52vvxph7q235RVGf2APMx8yA+l
 QwZZNl00JRljsHU3vnMMwRwKpv+h+YwIsa4PjIcqENvA8qh8qy6iPqtYsgRRg5L9VCifhzr7O3d
 pwHx15+c9P3IbPNv578wrqJiMJyTsByfAV4Rf/XE0wF0oqTkyYcUmSpcMXt7HQv7irOQLfkr+I5
 i9u+8c3bHM6VVm+7p+ruzAaPrF+yZAelfhloaL6EyTPahfAJ4OWT9P4O0j9IMHz6qaZnuo3g+qj
 PME3b6KmmB403TW/8cpWAX2/GQ5Ws5H0cu1ou1aT9m7EtcDGbBo07zikkv7MHSZgWwk36LIqqZ+
 9UxRf0ouloVe6GssBvZoFCiV/z8tRqof/zbULSJ4/AbwPwEtXRTLTf+zNiXHQu0W2zRPFvrmhfx
 33IvMDAnuweM3uFv+A==
X-Received: by 2002:a5d:588a:0:b0:43a:4e5:73b0 with SMTP id
 ffacd0b85a97d-43b527a925emr7261952f8f.17.1773852322323; 
 Wed, 18 Mar 2026 09:45:22 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:45:24 +0100
Subject: [PATCH v2 2/6] configs: mt8395_evk: rename to
 mt8395_genio_1200_evk_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v2-2-1f77580d72f3@baylibre.com>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Rename mt8395_evk to match the name of the device tree which is
mt8395-genio-1200-evk.dts

Also update CONFIG_IDENT_STRING to be consistent.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS                                        | 4 ++--
 configs/{mt8395_evk_defconfig => mt8395_genio_1200_evk_defconfig} | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 446a9e8e53c..5ae23b1628c 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -14,7 +14,7 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
 F:	configs/mt8390_evk_defconfig
 
-MT8395 EVK
+MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
-F:	configs/mt8395_evk_defconfig
+F:	configs/mt8395_genio_1200_evk_defconfig
diff --git a/configs/mt8395_evk_defconfig b/configs/mt8395_genio_1200_evk_defconfig
similarity index 92%
rename from configs/mt8395_evk_defconfig
rename to configs/mt8395_genio_1200_evk_defconfig
index 2edf3cb3e35..2d73af353f7 100644
--- a/configs/mt8395_evk_defconfig
+++ b/configs/mt8395_genio_1200_evk_defconfig
@@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
 CONFIG_TARGET_MT8195=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
-CONFIG_IDENT_STRING=" mt8395-evk"
+CONFIG_IDENT_STRING="mt8395-genio-1200-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y

-- 
2.52.0

