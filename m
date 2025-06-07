Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BAFC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F61382B44;
	Sat,  7 Jun 2025 11:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="heVtdKuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE69A82A7B; Sat,  7 Jun 2025 11:37:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A06182AF6
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so2571108a12.3
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289058; x=1749893858;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EYlXTukM9iQeWq7o7TCfUj4K5UOPJ1hdlXX00ZZ8vA=;
 b=heVtdKuhAr1GBzPk5r+Rf3OdiqPhH54cjcBb4J//iSag/n6Ug200qRfetrDNOlRO+/
 9ic5xHYJ6x5m+hOPm5r7qGh9sj98jHaS23rtCXazs4ESyGQ8XJao/5s+B6x+Zk3NtSL0
 VAXH+MaamJ+wIHoYbqL57Hkxe/4ZTtKuLz+qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289058; x=1749893858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EYlXTukM9iQeWq7o7TCfUj4K5UOPJ1hdlXX00ZZ8vA=;
 b=w/suoctPBzZPuenYsbgossjoPEWfkpBm1S0gCx4YvK+q6iQ7tdtkJcDV2d06/r5zxy
 /X15vliyxAvCR6KeGnBn7wJ/kuBOECikApafNt1adRiho0zQYmL/d4fpxcfjq0lMwadr
 +/fGDoVnfIpVTLKkejNA/ry9ElkfGcljZeFexr6XWctRRF0dZurYd2JQCGQHQNxUtsK1
 alelhqJrHJN9Q+avscPWzyRiSGkOSaeuxihXfPPfQiUjTzj6QXbgANhInG0ecFnUpOAY
 WIlByAefifhs7UTutw+GH9uZUXZ14aH3Pr3rFKjmDcVh2RA8dtKescargiDovVGg0qWJ
 5gDA==
X-Gm-Message-State: AOJu0YwBd3MpIrjPLd5dPTkoVs0JgO8TYgLEGRxCewmxY9tOaNGoJZyt
 yGX9i9KC2SlYXzr9Niq0sKAHASIssmxeLB89LKque/yBN9I+Qsu69h2WcVl/8/mpOmf2b6YhvoJ
 B74xk
X-Gm-Gg: ASbGncu62zBHcKFOV6vuAIeJol7EVX0VJaKlKWSUW3wYKBq83uD5e1lncSzGQvFi2DK
 eO6rCY5uvpmFixW1qdp0PIfkVMIOr3AJgfkyFXuR+fTHa0ebeMrSYBTFP1KEx6OT0/RdgS7Y4ky
 bdDh0OtAE8Jt2K9vIUCzKz56tPvrHAnBCVkY3jgRQ9P9/VP9XVi65JBx8pmtMAzl9uCL8pjX7IS
 OGfb/lo87uT1GkwJ7HLcjWLotM9OwLI6bmSdOh8jFd5U46F5bAKy6N40YE84b3rJBBJ8SHFJp9s
 g3+LYjyF81NsS2zQdGsQHGncagNiPwZogw8S941VZcmcFXjJJBm19NFe+SVtBv2bP0TchceGPEb
 3rRrzwJ4z3pzjqcKnCP0GXSdsSHaqAZWh6Z7Et5jCDClNC8ZDCLKDYRg2FjuSu7+YnZ8z03vJVO
 vtpjaD1lqUUxwnTVO5jHXjLlQ=
X-Google-Smtp-Source: AGHT+IHBkrZFq8Z8CSmDTiG1wug9eS7FjYIuIGhMsLFN1qp3MnnUthlWFGGwra3brbDS0dZrY9jh5Q==
X-Received: by 2002:a17:907:97d6:b0:ad5:c463:8d42 with SMTP id
 a640c23a62f3a-ade1a9164acmr631631366b.12.1749289057793; 
 Sat, 07 Jun 2025 02:37:37 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:37 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/9] dt-bindings: clock: stm32h7: rename USART{7,
 8}_CK to UART{7, 8}_CK
Date: Sat,  7 Jun 2025 11:37:11 +0200
Message-ID: <20250607093730.2249536-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
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

As stated in the reference manual RM0433, the STM32H743 MCU has
USART1/2/3/6, UART4/5/7/8, and LPUART1. The patches make all the clock
macros for the serial ports consistent with the documentation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250427074404.3278732-5-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: ecab3c40fa49a2073c4c916ebff9496a6b5db7bd ]

---

 dts/upstream/include/dt-bindings/clock/stm32h7-clks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h b/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h
index 6637272b3242..330b39c2c303 100644
--- a/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h
+++ b/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h
@@ -126,8 +126,8 @@
 #define ADC3_CK 128
 #define DSI_CK 129
 #define LTDC_CK 130
-#define USART8_CK 131
-#define USART7_CK 132
+#define UART8_CK 131
+#define UART7_CK 132
 #define HDMICEC_CK 133
 #define I2C3_CK 134
 #define I2C2_CK 135
-- 
2.43.0

