Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE44C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 22:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D59877D4;
	Mon, 11 Dec 2023 23:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A2lnxoV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA13877C8; Mon, 11 Dec 2023 23:06:56 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B950877C5
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 23:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1f8510883aso327173666b.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702332413; x=1702937213;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuFLBuUt6rSAkdj6yel2bAXH3CEy4Y9k9K7PWe/PI08=;
 b=A2lnxoV1Z1oIGZ0d3Bd9Fd5+GLD1FFLGVlGdTd/Pa+OGPdetUA7al9cJWOscqtBqmj
 /bnZHiTI4isgDSjxprs2ClxGgWBTZMv1OG4nxiWr2Om5WLQe/2ai4b8HysZCDDJra7Sr
 z2RZY8btUqQbA41YShPl61lejywP0pJ2gvLQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332413; x=1702937213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zuFLBuUt6rSAkdj6yel2bAXH3CEy4Y9k9K7PWe/PI08=;
 b=ZkvdEci30wApwtTKQ33e6TBDvlZCI7QB2dnd4UwaCFVpO2J1xzdMv3QZ1lh7Fa6Pi+
 eNe7TEswxbewNfvE2kM93x35FaALgdL1s+/QqQA+T6uYUdugJkt0igX8NVbFmU9xJYkB
 Z8xL4D1tbase3cApvwsjc3fV3TokUQm9e55p/BJ9+MjH3huDitcfFExM9uHWxIXfo+hZ
 L/6xrWIQvjmXA8l6C2zKIgWFv7dpInvr3YXxpYmjOupNkHf0HM+8WVEHF83n2mveFYDt
 HxYdZbVamS3v59OpPdJA62ag9Y7tem109qHUjj8TFspbZe9UCU+93Q7CubkXKVFlTSAl
 lUfw==
X-Gm-Message-State: AOJu0YwJWaBaPObAmiEIWdrdUEPKAbNDQLkJVaUjZZ1MZWzp6TxcQ0Lh
 JA8yMBxfwLoHsaDZhhnw8u7IoWuI56vdwpSR10uAVQ==
X-Google-Smtp-Source: AGHT+IHaq2m4Nxwx1ntmSKZUv5UsntnBZB1BDqLTvxi/+Y/TmCH84Q/6kEaxRWfcY36eDOa6naFm8g==
X-Received: by 2002:a17:907:cbc8:b0:a19:d40a:d1e3 with SMTP id
 vk8-20020a170907cbc800b00a19d40ad1e3mr1762406ejc.175.1702332413313; 
 Mon, 11 Dec 2023 14:06:53 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a170907a38d00b00a1f78048f08sm4568276ejc.146.2023.12.11.14.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 14:06:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 2/6] ARM: dts: stm32: make the LTDC clock usable by the
 clock driver
Date: Mon, 11 Dec 2023 23:05:52 +0100
Message-ID: <20231211220643.1073606-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
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
of the LTDC clock.

[1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

(no changes since v2)

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag.

 arch/arm/dts/stm32f469-disco-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index c07e2022e4a8..dcc70369cd0d 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -134,6 +134,10 @@
 	bootph-all;
 };
 
+&ltdc {
+	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
+};
+
 &pinctrl {
 	bootph-all;
 
-- 
2.43.0

