Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6A6E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 15:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 544B986D65;
	Sun,  8 Oct 2023 17:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fz9k6ZV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90668662F; Sun,  8 Oct 2023 17:46:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F3386C32
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 17:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so638927466b.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696779961; x=1697384761;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTx7xiY1gVrYaN4UWiDJPmdtqAhZcB13UK7nV6rDAms=;
 b=Fz9k6ZV09+QEs9gU6qghWp/KbtId62MKpcAPiBcdWfuzpVdlFRCBcfnQjgGfyp2dZF
 F4aADFVu3KGwHUEs9XTdh+L7NpQTxLb6kY5BJvsLJntA1OOaCOAww/o8msC596v5sRt7
 Jq+yUUsovlfqCVa+yajlt/pgwLdrIHWsstGs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696779961; x=1697384761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTx7xiY1gVrYaN4UWiDJPmdtqAhZcB13UK7nV6rDAms=;
 b=eDedyHpyEn0CgngtLdjL1aN4EbCXHd+s1yI8wtK1Fejbf4swcXDrr3BZYEpcwVNwFy
 dZ3xffgea4WJzfDwxJTk3wrrUYlAk55r5KY3M0SA8hsn5oG47WJebv9hb0BaS50szFBn
 ha1ZLh2qahBfC5PaHW3dqY3J3W8hxJWcBeekQT/v819i6Bho22WC+cunkA4XnETSOD/0
 5KzS2ceqCYbt6OT7sUQVNn73dzQJS1AiI0E67dgfYT9+fJjM1AOpKgfSbMz2DETCcrR+
 jSGwdBGTh9FzZKOx5tbi6NZ1qjBBrCi8V6qN2KMzUclGy+ExP8nxQUZ8FkZNQBs6UJOz
 f4IQ==
X-Gm-Message-State: AOJu0Yx3wKAk7/NUFQ2FFDmHvicwQMO/5AXtX0S1uVFrW5mOjFB0PekC
 baY5qzAT8A3SMH4HZHhexv9ZSESedR6SbgjRDws=
X-Google-Smtp-Source: AGHT+IF/Va05jr10Og4exGS3OYwpKdaRUHqEKmD0iV40UumPiPXyBQg+aFF2064T4091RMuwVOGo3Q==
X-Received: by 2002:a17:906:2932:b0:994:522f:3f4a with SMTP id
 v18-20020a170906293200b00994522f3f4amr10705904ejd.29.1696779961136; 
 Sun, 08 Oct 2023 08:46:01 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-50-102-159.retail.telecomitalia.it. [79.50.102.159])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170906f90b00b009b9aa8fffdasm5623981ejb.131.2023.10.08.08.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 08:46:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v2 3/5] ARM: dts: stm32: make the DSI clock usable by the
 clock driver
Date: Sun,  8 Oct 2023 17:44:55 +0200
Message-ID: <20231008154538.1622772-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
References: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag.

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
2.42.0

