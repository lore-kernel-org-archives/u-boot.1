Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DCCC83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76773869A4;
	Sun,  3 Sep 2023 22:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SgfDDmmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0236186993; Sun,  3 Sep 2023 22:57:13 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BEBB86898
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4ff9b389677so1268015e87.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774629; x=1694379429;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbSzTvc7TKxmIY7ZC52gEHS3qqkfD7Pv8oCtaBas99Y=;
 b=SgfDDmmC50miSkASyUwg2hnWWJR/ZdXn2JmfYyLB8yRDCuc7EN2BTnM1BTQTkwlgJ3
 z6F3ostMjVVUOJ6N2+tvpRCmWtdMYvAvrqyjzd5cbkYWr3McdQNvaAwFYNNZLpimUR0F
 iUURNq/aSw44AhpfBHpMwsJVv+DtscYtsf/7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774629; x=1694379429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbSzTvc7TKxmIY7ZC52gEHS3qqkfD7Pv8oCtaBas99Y=;
 b=LV8iLe5kEs1pvi7qXvpq/R/Gg76yyvw8mzq6ONUVE/rVNykTWDD+94de1zdUWxu57C
 owQ/2ddqjPe8XTiRkHodqM6VoS0OmV7H2E/9neWdFVVjF8ZBl7+Wo4Z+y6NQZZ9FcJa/
 bY1HmAW0rYmoA+UYeGaj/HqzjRi+uFE6z9FAiKp/evVINCq7vyG+kmm3e7pexXcwkuCf
 vSdEQlr59JXWCtwUgJzBSR0tzkS/JzJHIPNAZZMd2vaejA1/Ihn5Zke2wDkGUau6vQBN
 mPZWxehNlbASn8sYBHN8yo9hz7C46658bYVNgM0fOw57KeW9hGyHxAAQQy/UHNmyvW1r
 n8lQ==
X-Gm-Message-State: AOJu0YzuSJy/AhfFf+NO5q5FDvStwBaW2Wu9mJ4DWgHy2wCn5JRxAcem
 QCECgLaC5ePqj2TP42x83AVG+3nmAZI4HydJY5RqZA==
X-Google-Smtp-Source: AGHT+IFwKNDyMxP8u3ndTJIAFmYBEq38UzTOxjF5lxxWpg/0iDXHqF9MTEx2SGKgjOf6ctHzBivp1Q==
X-Received: by 2002:a05:6512:1054:b0:500:c709:5845 with SMTP id
 c20-20020a056512105400b00500c7095845mr6421859lfb.4.1693774629463; 
 Sun, 03 Sep 2023 13:57:09 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d9d6000000b0052568bf9411sm4850232eds.68.2023.09.03.13.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:57:09 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 3/5] ARM: dts: stm32: make the DSI clock usable by the
 clock driver
Date: Sun,  3 Sep 2023 22:57:01 +0200
Message-Id: <20230903205703.662080-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
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

As described in [1], the "clocks" property contains "a phandle to the
clock device node, an index selecting between gated clocks (0) and other
clocks (1), and an index specifying the clock to use." The current version
of the clock driver, unlike the kernel, is currently able to properly
handle nodes with "clocks" properties with an index set to 0.

This patch is preparatory for future developments that require the use
of the DSI clock.

[1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32f469-disco-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index dcc70369cd0d..8e781c5a7b23 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -90,6 +90,11 @@
 	bootph-all;
 };
 
+&dsi {
+	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
+		 <&clk_hse>;
+};
+
 &gpioa {
 	bootph-all;
 };
-- 
2.34.1

