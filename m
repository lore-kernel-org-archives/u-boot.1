Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FF6D711C8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA111800AB;
	Thu, 18 Dec 2025 23:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JB+JdqK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C4B80433; Thu, 18 Dec 2025 23:59:54 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA8B98003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 23:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c24f4dfb7so926048a91.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766098790; x=1766703590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/OzeZRZE1Nm4m0gJMSIV5HwGFHIzGtqdTLz0UhRTYE=;
 b=JB+JdqK5iOCb6kfI1A4cZ226xOsRaT77Uzbtx7jNtSvTOk8DkwPTt1lok1C8bPxdHg
 T9pizxvBLegqzt0VQmzVo49LGF5pH215jRNll8Il47jwt1/lP+Zo5C+O4R0eZjxsCbTs
 kN6GAC06vRTci6TVeOU2MZxrUbmIrCzL/hm4TM4Yvio4Ojk3whv0+/CslqVS0QtcO/2e
 mtFP7t6sAU4JmF1uuEoLIlvj35R+xn+vFilsjbcdpf8xV6RxYDj4TjHXKRQSywW+9kBT
 cz1ZABORCRJnfT/OKQKThEmKNWlYh2jag7FBHQLKU0cppLo2SzPUVtm9ViCA1fLkQGtK
 d5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766098790; x=1766703590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/OzeZRZE1Nm4m0gJMSIV5HwGFHIzGtqdTLz0UhRTYE=;
 b=WlL1MJ3uenLZZl2MBPvy1W8qMwH/hlcrzr6hqquzavXEfjGOBuJp0loNNsmzqjv+qN
 jk7a3XO18e3u/w+iXg4KORcWRBSnsy2PUtnOiRr77LCkecfi3cwBYh3M1hDCVhfuxyYs
 ZJ061yDLys0hkNSDrPYeSEGSajFrehEBeL/QL2VRCBeyP8eSPnLZo1Au0h4RZxVkojl0
 CtDEmhCTFzUN4Hk2wFKRZwUs8uYk4JgNWl030scDOVdiF4Bx6OyqdTvAA4yeuswM+45e
 Qk3cBatHCvuy1RYQxXHLSHfAsjhjrjo5NbbdGukFNeWgBGYJR5a5CBrIsqaLq6gVp8F4
 Leaw==
X-Gm-Message-State: AOJu0YxmnYlfSR8lNTJGp99jptrNeuK0IjcxNVDz93SUHRbWF1V0HPAl
 KqU/3hIktd0jEv24uGRRxOYfclkatCeXhmpLL5Q/+ySAYrLDnI08G1Xi
X-Gm-Gg: AY/fxX7hO1DP8zqrgHKoXS5/FSiaBeNsM4x0bpValqOeMuGrAcbyZtPrCjrhodaYh6O
 5qwk59HQcv7SiNUrtBOjXsdJjevJtsCDBfsZpfIwcHxSq3d5wNC4KM9uFxqvNF6zeyzFENQ7AJL
 uT6GD17al0IBWZr/V7Un7rzwjoDtOa98thYW7e1ccbeSHuURo0VbMVk5cI44KwoMwDomAPrUb+5
 FP6rGIG/8ECZSNwAa9WgLH0/coItUVf0Rl6nbyv6lqVD77HUkXxtwqDqByNwstC7gi/Fgy+P8aF
 ZKC42ZK/BwqFEUXw3QjpjL0kpaxQARt3D9xztI/EyML+5uuCrt4ELBRILusSxt/lKJsoBkg0eJQ
 vRR0kWc+klTQOKc8oXIq5L/gWg5AycfB9Kftj+aWnuONg/WrCgzlhj3L/DcEzMpZdtkoOK1GqGn
 u7IxVGIl0mI/WFmoi0/wZvrs86
X-Google-Smtp-Source: AGHT+IFNk3qtmO0mHfN+/vVIaMXBEqp6h37hNH9OS+xIClzH8qdYUP+/rpzibNmUa1NTiwQ7TKBODw==
X-Received: by 2002:a17:90b:1d83:b0:32a:34d8:33d3 with SMTP id
 98e67ed59e1d1-34e91f749d8mr730395a91.0.1766098790410; 
 Thu, 18 Dec 2025 14:59:50 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d6565esm3431356a91.6.2025.12.18.14.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 14:59:49 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH v3 2/3] arm: mvebu: db-xc3-24g4xg: Remove marvell,
 nand-keep-config
Date: Fri, 19 Dec 2025 11:59:35 +1300
Message-ID: <20251218225936.2016920-3-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218225936.2016920-1-judge.packham@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
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

nand-keep-config is used to retain the NAND controller configuration
from an earlier boot stage. In U-Boot's case there isn't an earlier boot
stage so reconfiguring the NAND controller is required.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

Notes:
    Changes in v2:
    - None

 arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
index dc20643bfa37..ad64813e7704 100644
--- a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
+++ b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
@@ -5,7 +5,6 @@
 	status = "okay";
 	label = "pxa3xx_nand-0";
 	nand-rb = <0>;
-	marvell,nand-keep-config;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
-- 
2.52.0

