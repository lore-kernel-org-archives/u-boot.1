Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8975E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 15:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62E186CB8;
	Sun,  8 Oct 2023 17:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X92t/FXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99AA586B89; Sun,  8 Oct 2023 17:46:03 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F098662F
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 17:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so672022466b.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696779960; x=1697384760;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIGSMWG9wB8nSXXdhajx7VgE3zyfpt07huxXjyhDX0I=;
 b=X92t/FXBuL2AFsiiP/jOLoT0OFk55ehjrCIDAOtCO/iC12RR7OV/4g5LIfOeeDPSkb
 cEx9aoI47XGSqHtFoM5Y64yqT9AdboXxyTGkD/AdbCOGwxoh22jYvlm0nAmDvc7Uhmc8
 RBkPDSQB43j7DGN7xWvqqomb5fA3IJ3PR+FPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696779960; x=1697384760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIGSMWG9wB8nSXXdhajx7VgE3zyfpt07huxXjyhDX0I=;
 b=IvE1MVaCvFbkVyVCVHEoW23zkX1/fYnEMcvJA8i2qhPm5TfCY0gjw3L3/m+FM3tH1W
 hakEAHpDeSJdbZ+5ZWgBbKgux6sOXtQUnjP0qYKf08HDAk3yYZUd+9EPT0BggtBCSTbT
 5HS/f6yMmIqFPDgs9zOXcxaZZyM3SfCHTR4GTRDor4egBuGiB4D3jfPg7YP7swzZ4xv/
 I0sMaRUdOeD0zCWYKeRKloMP2KzzHexdV3AWdBXZdW4Q9xp4+zO9DKdLSObm87X+Mp0E
 j76hgvs8qHawNqNNFl6ARybTgT3lr+9gQrk5ERM2NfW46eSzMtCbboBDm/IBg+ejSiHZ
 jRzQ==
X-Gm-Message-State: AOJu0YxHP4Qz9PH4K+8vnlQ35NzRtRk6zwJUooaDXEkbs7zbJ3qotDcJ
 L8Yw1eWNSs9uj+Ee0360hCEhTHlcpq281mNqc1w=
X-Google-Smtp-Source: AGHT+IHUr6AHuKTWWjdKW+oU12w5z0UGUUjHSuXBq9J71VYBMuS59ZQ0TlQD/kgv8xg3ZLTeAyxNmw==
X-Received: by 2002:a17:907:774e:b0:9a5:d972:af43 with SMTP id
 kx14-20020a170907774e00b009a5d972af43mr11896479ejc.65.1696779959775; 
 Sun, 08 Oct 2023 08:45:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-50-102-159.retail.telecomitalia.it. [79.50.102.159])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170906f90b00b009b9aa8fffdasm5623981ejb.131.2023.10.08.08.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 08:45:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v2 2/5] ARM: dts: stm32: make the LTDC clock usable by the
 clock driver
Date: Sun,  8 Oct 2023 17:44:54 +0200
Message-ID: <20231008154538.1622772-3-dario.binacchi@amarulasolutions.com>
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
of the LTDC clock.

[1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

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
2.42.0

