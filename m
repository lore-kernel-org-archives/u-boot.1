Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F939C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 22:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E77A877C6;
	Mon, 11 Dec 2023 23:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jcBODO43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEB6877D0; Mon, 11 Dec 2023 23:07:02 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE51E877D9
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 23:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2c5a8150so46500505e9.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702332419; x=1702937219;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+DeLLzvFUt8bF9r3f6NRU00M1E5EfRpOIcrIGfseE0=;
 b=jcBODO43A/neykySc/3tP+cKLvaORVGsDLuNUx5JxRFi5CFSUQcnLAMvyBy1Nv2MYx
 FXXIlPzLJg48mvkG4xndve+ZBzP0Q5KtpbghslVe1SziKGEWO99IGxS1JD1hRq+bjUO/
 owzVotdacnUKAAEsfHsGS7dzF3Efi6HeTp7yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332419; x=1702937219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+DeLLzvFUt8bF9r3f6NRU00M1E5EfRpOIcrIGfseE0=;
 b=QyekZh0/WtTFXu+QBGhNWYlF00s0Nhb1JE5JhNuq6IXo48ugl2n16wnKUqsoVmy6mS
 uIaZ0/4nNdiVyvLeZoA3vsAu1Yea41rwSodd0pnSLHVF8FOfdRFm7pGf8teynNZ+s77I
 n+QKF2Z3FvHRTzYRbx1NQ/suI6cN7SxH55EmNL17THcT1+XEZ23136agVYch/PWTiiwC
 wqffQHVQSRJVOvfB3fhqhVUshR2kdlFdyzY1d1ADapuS74mzH23VoFYi3Ji8hl0PDrak
 pfMr6hGsDm+EqIJvsB3ZAhGNc4XGts20jQLkuWbSsPXdxRr9tC/TByHLm6khsF71Zgjk
 5obg==
X-Gm-Message-State: AOJu0Yyk24vgOxua5BzoXshi8qOA8Qd5OYZlX9rDPGgkO9rs8e1aXC6S
 ahDZWwqQQxB4YOGUJtWo8puM8Zkl/vrwqJiXqobqNQ==
X-Google-Smtp-Source: AGHT+IFzlChAzMT/mG36n57XD0mq/fmyCuYmJaZaX/g+ONZIW283Y8w8dWl0hD1eH+lHxlK2qJADqA==
X-Received: by 2002:a1c:4b0b:0:b0:40b:5e21:ec37 with SMTP id
 y11-20020a1c4b0b000000b0040b5e21ec37mr2300235wma.105.1702332418877; 
 Mon, 11 Dec 2023 14:06:58 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a170907a38d00b00a1f78048f08sm4568276ejc.146.2023.12.11.14.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 14:06:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 4/6] ARM: dts: stm32: support MIPI DSI on stm32f469-disco
 board
Date: Mon, 11 Dec 2023 23:05:54 +0100
Message-ID: <20231211220643.1073606-5-dario.binacchi@amarulasolutions.com>
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

Unlike Linux, the DSI driver requires the LTDC clock to be properly
probed. Hence, the changes made to the DSI node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/dts/stm32f469-disco-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index 8e781c5a7b23..47ba9fa4a783 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -92,7 +92,9 @@
 
 &dsi {
 	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
+		 <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>,
 		 <&clk_hse>;
+	clock-names = "pclk", "px_clk", "ref";
 };
 
 &gpioa {
@@ -140,6 +142,8 @@
 };
 
 &ltdc {
+	bootph-all;
+
 	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
 };
 
-- 
2.43.0

