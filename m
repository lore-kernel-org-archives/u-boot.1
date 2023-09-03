Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF20CC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7201A86813;
	Sun,  3 Sep 2023 22:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pbJjFJ31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A346868BB; Sun,  3 Sep 2023 22:49:04 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A8486828
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso365025366b.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774137; x=1694378937;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tFSdaOfLgjvu5lT2Mze0e90IV6aw9wvzp074I8xHsk=;
 b=pbJjFJ31ZgCx1y4IbaaRqdm4nZGtQA2pJQdLpDuBjRuRHDZEgLymzwInl+p2IaLacq
 rMn42bZFenby3VSrkLrNxffETSFYU3F4bKhSfNUK3M+3jayQ7KGWlvnBDv2/8ctvMzt1
 Cv/2vpWznKnKMa5oiwgM/8pMp5kiauBLHzteI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774137; x=1694378937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tFSdaOfLgjvu5lT2Mze0e90IV6aw9wvzp074I8xHsk=;
 b=bkKJ02ESShc7tRSdEJfmVgGpSfbNDT/qofC3XAPMfFhV22cchd/djwpI9CZi2za2rM
 lQojnhhEHovzF+j5zVwFBOvggTmmj8Od6WBV2v1zqRGmFMz2DjI5hV/c5bAVR5x7gusp
 9kqwctrdTd9xXqKxCz+SVr136U1vpdFPEvyNCvj6j9QmLpfCYNO9mDx0Bj/cZJIlamKv
 F6MmKdzLzAj/veVb5GxtYI8HppV6mp2fzmFBdsu4jf0SSwaLJZHckcHNQHtzzO6T+fo4
 s6p3e841/6J9h9ud4wnnkZp0UDQvViByl5v1wI+FXdPL1IcKVzCQw4GVnsDMUr20/C/q
 00Yw==
X-Gm-Message-State: AOJu0Yw9yxsORXQczSmpgNsbVFibtm4fNruT0p3KW7qm5PDqkwAebnwI
 SNCHRi0g4/ofrsccZ4uYSe8sLbTkN7q1TdLDLxAgwA==
X-Google-Smtp-Source: AGHT+IHohTEO5zEvbbTV4Uc5AoidRRR95vDt995kYR8twHTCoCq3KWUHb/hScez+nzBjwmiPcD72RA==
X-Received: by 2002:a17:907:3e1f:b0:9a5:9b93:d60d with SMTP id
 hp31-20020a1709073e1f00b009a59b93d60dmr11300128ejc.36.1693774137676; 
 Sun, 03 Sep 2023 13:48:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/10] ARM: dts: stm32: use RCC macro for CRC node on stm32f746
Date: Sun,  3 Sep 2023 22:48:43 +0200
Message-Id: <20230903204849.660722-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

commit 7a5f349e592c254f3c1ac34665b6c3905576efc2 Linux upstream.

The patch replaces the number 12 with the appropriate numerical constant
already defined in the file stm32f7-rcc.h.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
---

 arch/arm/dts/stm32f746.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32f746.dtsi b/arch/arm/dts/stm32f746.dtsi
index dc5c257fb5fb..7b4bd805c998 100644
--- a/arch/arm/dts/stm32f746.dtsi
+++ b/arch/arm/dts/stm32f746.dtsi
@@ -526,7 +526,7 @@
 		crc: crc@40023000 {
 			compatible = "st,stm32f7-crc";
 			reg = <0x40023000 0x400>;
-			clocks = <&rcc 0 12>;
+			clocks = <&rcc 0 STM32F7_AHB1_CLOCK(CRC)>;
 			status = "disabled";
 		};
 
-- 
2.34.1

