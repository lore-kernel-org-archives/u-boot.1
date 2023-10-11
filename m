Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078B1CD6E48
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F51986C6E;
	Wed, 11 Oct 2023 10:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMsovsLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBFC86CC1; Wed, 11 Oct 2023 10:48:41 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BCD382BBF
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so594254b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697014107; x=1697618907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lIuC0LlaQk3Zov8/qB7awXdM6wdmjV8nZ/ai4ky46A=;
 b=lMsovsLD/50WPns6n2L7sqdnYs2aoUz/0WSiOHt3VDQcxykLiJOXp6Wftbn2/P5JCy
 Zy/+lmXRxCjDIh2LGqKs1lQfMxJ+MOR5kIl18ZNK1q1BU/SZAEw5xX2vul9r0Ncc0vRS
 NfCgCMFi5ZVIhqACDcZZaQnxiDN0JGGU5xTabpYJ+/MXQFsIK8DXA4O0gH+fMd6SJjag
 dXs7eMLjdGYRLrEFG+9yeL0D8Jzh6827yeRtToSA4V94Lv5ETIXCB+/8bZ1qkzmS0gHA
 CWiurWc71ki0GQ9evWe0MhorWGLh5irh0v3AK14etha/scfVg/F8GQj/bp0K2PdhNwis
 zobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697014107; x=1697618907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lIuC0LlaQk3Zov8/qB7awXdM6wdmjV8nZ/ai4ky46A=;
 b=YArgK7nfNw1U3KKYQbjlzkNSVzmDbIh/oiqrRjSkNf9aaXeRf4I81EASN9iqKVWpyw
 0BCPaTfEpal163j5uDmMfpDQX+p3SX1xtguNrg+Bd6Yd0gGLdI3NZ+SX9y7fvwPOcjj0
 auuw4/b4rgOSLGh4uCPd+nagC10eQXILDjLyeIS7xixuYrUpq5l1CyqK65Jy5fYfBH76
 Db0E1qkowhyAvvldKUqvGaPWNJ/z8KmN8JPjE/3Suz5A4RoXOdAkiWakvbve5ghSDdtu
 gfgokJfimDiENd2NtQlN1/lXrVua1HWFQ+IrQb6SrzEK3I2I+OGYenA0vE5+EKLYpYgA
 Fb1w==
X-Gm-Message-State: AOJu0YyeJ2vD1IfwNPjPFx/fg0Gf7Af20srfI0gsynadLI1gU8ioIiSy
 zmw8/anochJfuGC6tjEMF28=
X-Google-Smtp-Source: AGHT+IHNZb4sgqrhnkSH3BbFKcq8SrlU+luQBKo0tfqRiYW5y1DgEtGf/iF3Ik8Z205f4P6YaQOZQw==
X-Received: by 2002:a05:6a21:1a5:b0:15d:8366:65b8 with SMTP id
 le37-20020a056a2101a500b0015d836665b8mr24678693pzb.13.1697014107378; 
 Wed, 11 Oct 2023 01:48:27 -0700 (PDT)
Received: from localhost.localdomain ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a638c1c000000b0059c8fa8f917sm2307940pgd.12.2023.10.11.01.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:48:27 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/5] arm: dts: npcm8xx: add watchdog node
Date: Wed, 11 Oct 2023 16:45:32 +0800
Message-Id: <20231011084533.2325296-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
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

add npcm8xx watchdog node

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index fabe5925b7..fb544e5f1a 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -154,6 +154,30 @@
 				clock-names = "refclk";
 			};
 
+			watchdog0: watchdog@801c {
+				compatible = "nuvoton,npcm750-wdt";
+				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				reg = <0x801c 0x4>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			watchdog1: watchdog@901c {
+				compatible = "nuvoton,npcm750-wdt";
+				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				reg = <0x901c 0x4>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			watchdog2: watchdog@a01c {
+				compatible = "nuvoton,npcm750-wdt";
+				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				reg = <0xa01c 0x4>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			serial0: serial@0 {
 				compatible = "nuvoton,npcm845-uart", "nuvoton,npcm750-uart";
 				reg = <0x0 0x1000>;
-- 
2.34.1

