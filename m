Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41356C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0E7876C0;
	Thu, 30 Nov 2023 15:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CF5vdHny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF3D8768A; Thu, 30 Nov 2023 15:40:45 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5BAF87646
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50bc22c836bso1542454e87.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701355243; x=1701960043;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kyXGBY2KLW4rJ8Eqx6QRH4TAKJ0k23of0ltCNtobbA=;
 b=CF5vdHnyQnmYdyialTWIgLUHGVz28qepex1FsoZKjg8Y34v9iymRB/4lwLUbXyNxh7
 BY+/uFST4j3VPf4wpdav8aIkwplcLA9lYGd3dkTtEwIlukJ/Zqn38lPfmozaIrAaoeoD
 UMzasAymbKV3w4BodtxuATOFUHvyFZxEJvGls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701355243; x=1701960043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kyXGBY2KLW4rJ8Eqx6QRH4TAKJ0k23of0ltCNtobbA=;
 b=ilGzFOxQaU/6Airpeqr3W9gzciOGR7hy8u0OPS9KgjyEQsGnyL/odR/AkJYklXUZDa
 fLu0a9q6IcooUyYhIJLr/znSeOWKS8GvB2+fOjMb279NpgON12NCfl/ZZOwureM1efbk
 52kJHzFBm1Sgiqv+/kMYcB+tuTMaEVYIfmqRu4IFTVjgHzVI3IqG4FqIIR2JILvPNzLo
 cqyaOrXu8KQ0yPtgOIfn08tLJdFIr1chlEHxOTg3OLCqYs9ef4qKbPQgTQA/22XDX/Hz
 9rTsknvvL+Q0evK1DQWM9ZLxAdOS3wfRhRnPnpU/IHjWEqnb0xyzQWpLeSVr1w0FRc32
 JyQQ==
X-Gm-Message-State: AOJu0YxsHpy0Q7TCQK++oBU7vjCgKorFlvWV4LOsit9hLzATHvCSmZ8X
 LJ7NK1tKGuql0somRfrLSDXUqlmuwRFCi/a1AwxXYQ==
X-Google-Smtp-Source: AGHT+IHhbWIpPKb9YSkM/5UYy2HkiuJdxxVzu4jJ+0QMLX/7uHXceuYpiJJqIC8FKbs+lmKR5H/s2w==
X-Received: by 2002:ac2:51b2:0:b0:50b:cb84:8ccc with SMTP id
 f18-20020ac251b2000000b0050bcb848cccmr1525885lfk.54.1701355242842; 
 Thu, 30 Nov 2023 06:40:42 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a1709064a9500b00a18399ff790sm733470eju.215.2023.11.30.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 06:40:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RESEND RFC PATCH v2 3/5] ARM: dts: stm32: make the DSI clock usable
 by the clock driver
Date: Thu, 30 Nov 2023 15:40:04 +0100
Message-ID: <20231130144033.1850298-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
References: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
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
2.43.0

