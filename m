Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FEAC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1189A87E12;
	Tue, 30 Jan 2024 15:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VsoUrRoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B954787E15; Tue, 30 Jan 2024 15:05:17 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC51687DEE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50eabbc3dccso4956267e87.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623513; x=1707228313; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=92881TofNR6K+dQepNioVBdkWkKE9A8U9U6CYokVWeg=;
 b=VsoUrRoJOaWFMhMIaJEQYbKnu+9SnOSOo9cE0oWw8lOAKDEUocpi3ff/1zHQBL1mNW
 u4lzlJYOEzxUvnwSEl61nCYS3c6FzccLrzpYLrAUaYdcxcTIH30duBmwvlxw4Jrju6f+
 dOs6ejkMYHx3gVbC5gL6K5raR1R/juc1PrWYkimjvbS3mLEcxhqgv0t1F0nbEKZkNbJM
 sDsj5bIjEwDkCMxaLsVFuLuhDoNCf9f13uhR+/I97pEgUipW/ycYNua+Tnhd6hJBsQyk
 zHp19Qz/GleMfITVSPhJOuevpyfregSwQmpHtSWvuIzGKql7QgCndpA6kDyQ/Asbka3M
 1nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623513; x=1707228313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92881TofNR6K+dQepNioVBdkWkKE9A8U9U6CYokVWeg=;
 b=vlGpOrzldiBSZGKHxYjy7NHfZiUkWV++uP7r5tv1rqemLHQqbwXKnBzXm0aJ5mjVeY
 VRzeMaPdanpFJ6ZYUzFheeFXhKU10EbTllDr38CRsDrCA8evUU+56v9RNzcmP5Ji/5Oh
 xRjjlmt7tq2bTs2GWNexHw+4A/ECZGkIsRSDhd//zdH/NiP8FOKZA5uWKlssV/y/5NXs
 eAQUhz4Q0FfP2gS8lX4M63kmx9anQ0XcQtqXY3CuCozUVtQQUP/hJIO2clGBZ8Rq8qSJ
 EQFRVnAR03yCcFPxILgp/D3LgV9+fBUgpY2/Uxg2Pc0yhnAJWGDCBFL0Lql7B7yItuuU
 mmIw==
X-Gm-Message-State: AOJu0YxF2TBXDJuz3knfTKlBe2+t5naZaKRNnPNQN3eLH+Mf7I0pidA6
 DbNOwiTSoHsN7/cDVM/IcNeKWp8bDNQoGtVeWDvn/kIuRWH3/TdHn57LlStheYU=
X-Google-Smtp-Source: AGHT+IHcdaigkBwB62ScU393X1vVqbRG6uYPhIXp/XfFK5F5n3D5VysecUZY4jX4HTvbYLtdfiuFKA==
X-Received: by 2002:a05:6512:282c:b0:511:1fb0:1f71 with SMTP id
 cf44-20020a056512282c00b005111fb01f71mr998680lfb.51.1706623512974; 
 Tue, 30 Jan 2024 06:05:12 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:12 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:52 +0000
Subject: [PATCH v3 04/36] dt-bindings: drop msm_sdhci binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-4-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Gh4RzFvKOFQkDw3JGGTrFm+w8pP/OI4qHLKtc+YrTv8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTPypU19NDf21Qi9C/9OUXeXOBwVctSUuCb4J8jIuP
 V3baL+yo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExk3zNGhsY3YVEc24Tb3jKV
 nTi5OEvm9sOISyfEgl+qqlb/sROOs2f4p+x8rJhv+xen7Gz1X/aO4ieMX+0q3Jhx5EvOO4fa/xl
 flwIA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The upstream DT is supported here, so drop the U-Boot specific binding
docs.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/device-tree-bindings/mmc/msm_sdhci.txt | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/doc/device-tree-bindings/mmc/msm_sdhci.txt b/doc/device-tree-bindings/mmc/msm_sdhci.txt
deleted file mode 100644
index 08a290c66931..000000000000
--- a/doc/device-tree-bindings/mmc/msm_sdhci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Qualcomm Snapdragon SDHCI controller
-
-Required properties:
-- compatible : "qcom,sdhci-msm-v4"
-- reg: Base address and length of registers:
-	- Host controller registers (SDHCI)
-	- SD Core registers
-- clock: interface clock (must accept SD bus clock as a frequency)
-
-Optional properties:
-- index: If there is more than one controller - controller index (required
-	by generic SDHCI code).
-- bus_width: Width of SD/eMMC bus (default 4)
-- clock-frequency: Frequency of SD/eMMC bus (default 400 kHz)
-
-Example:
-
-sdhci@07864000 {
-	compatible = "qcom,sdhci-msm-v4";
-	reg = <0x7864900 0x11c 0x7864000 0x800>;
-	index = <0x1>;
-	bus-width = <0x4>;
-	clock = <&clkc 1>;
-	clock-frequency = <200000000>;
-};

-- 
2.43.0

