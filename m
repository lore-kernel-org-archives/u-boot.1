Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A231C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1763382B3D;
	Sat,  7 Jun 2025 11:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MAGgAVZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEB582AFC; Sat,  7 Jun 2025 11:37:41 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924EA82B00
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso5079128a12.3
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289059; x=1749893859;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttmUHLY08fh/FuLq2G6mP6MFdpRwEDRrcgYPXrhNizk=;
 b=MAGgAVZ8cW00pHgetYzXZzBxXAx3AdwdFVbIHiEfJA85wg6qgJVFfyofnjOlbXD7XN
 qN6e/jaJ9rlnvA/3O7RnM2NFyoVpJeFc8kgerv5G8HlklUSyHiunJFde6kizqwkM4tp8
 iSf6JPfukywMj213cKx7qkGjXRWoIeVtwpT3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289059; x=1749893859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttmUHLY08fh/FuLq2G6mP6MFdpRwEDRrcgYPXrhNizk=;
 b=Zx8BWc72YzGrjGux2rEdU6nD46lYKCSlUqM7geVUZwjyh6TH8hwxQ1dgmJG/GbW0cL
 tMDnbbyZkOIam3I4uDrAic8l0EZ8kycLp2j8XN26BlB+D8tjq3om/Q99hdmzM/wGeEun
 xoNRb04QljzIABk9C5492SECSZSOSQ5H1QaCiawqzyz+gKEYCNS7D+ig1V/uDQr6qr/s
 KhwolGVemkCXJzv6F6tnRtXWqdLD3k1h29yTr9d09gULbBP1mtn4v2Y8sljszjofO/IQ
 s/Z6Ey1bc5qUHjh8BrFU2XPNxVhy/r4RKkL8d+KmCH4Z5F89qYcyRu4VhW8Q/kIDYtlh
 bHyw==
X-Gm-Message-State: AOJu0YyVi1yo6Xl8NJiGYOMkKtZKBppM4W2/FDxWV2AXo3AwVskjiHWV
 48nZCq++G4TVJ0RaJ05HbGChlvOfC4Igo7M6I1ijH4RIt/qpPHLhHNHXvlPvcN1WZd4ECQKmYs4
 649MX
X-Gm-Gg: ASbGnctAoEwWeYacu0N7gthtjDiqW4Uu7ToD90/IRlcKqvACccsk2q41zBFf4QXB5uf
 7MeLNMxIRpjVkHIEM2cYZOHmFxKqvVgEtbwoKDEliJIlvpqz/TtUPnuoxr/fMyW23m1k0ruKs18
 7AFzj62jQQiVwjVzzBCtklruYKaAZJVt6iqgqoN+oWSq6bdmindY0bKgK3r5GP4LlzTXLMY6IDG
 iEX2mz2E/ThS1suSPajJV+Yjp1oPD7sfrxcYmW3lFoFzNpxusxaenYo89/BzGq+Mhf1FMJzWbjq
 jxG4WWRxDFvi7qbQhjO/MjRrGVMvN2flLSqomMlTZ5tse+R/ZxxfcC5/gwLHaJyEZ2xWUvMDqIQ
 FJHf9ZFiKaIP0HQesJdCLURYaHWqwOxv0WOAdYhCttgnXGEtwif9Ryg6zDCPrCVTqel59KOjgdS
 S0Q55+W3vdinXe
X-Google-Smtp-Source: AGHT+IGGJA2vZQ+atvf90Rrht2amcxYEugiItPRofnasHL712epb6JRjIOyADmJAEGQ9pzJjAjtX2Q==
X-Received: by 2002:a17:907:94cc:b0:adb:3345:7594 with SMTP id
 a640c23a62f3a-ade1a9e22camr495051466b.9.1749289058886; 
 Sat, 07 Jun 2025 02:37:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 4/9] ARM: dts: stm32: add uart8 node for stm32h743 MCU
Date: Sat,  7 Jun 2025 11:37:12 +0200
Message-ID: <20250607093730.2249536-5-dario.binacchi@amarulasolutions.com>
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

Add support for UART8 by applying the settings specified in the
reference manual RM0433.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20250427074404.3278732-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 07aa43adae2363c3734055aeba0789536fa0f8f2 ]

---

 dts/upstream/src/arm/st/stm32h743.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm/st/stm32h743.dtsi b/dts/upstream/src/arm/st/stm32h743.dtsi
index b8d4c44c8a82..2f19cfbc57ad 100644
--- a/dts/upstream/src/arm/st/stm32h743.dtsi
+++ b/dts/upstream/src/arm/st/stm32h743.dtsi
@@ -211,6 +211,14 @@
 			};
 		};
 
+		uart8: serial@40007c00 {
+			compatible = "st,stm32h7-uart";
+			reg = <0x40007c00 0x400>;
+			interrupts = <83>;
+			status = "disabled";
+			clocks = <&rcc UART8_CK>;
+		};
+
 		usart1: serial@40011000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
-- 
2.43.0

