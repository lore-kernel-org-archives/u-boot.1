Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B1C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE24880A55;
	Mon, 10 Feb 2025 12:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LUcgeIo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8A780A55; Mon, 10 Feb 2025 12:18:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFA0801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 40EFE40069
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739186327;
 bh=T/D3Hqig29AwEZ5QWuNaIbZboXaPUrQ7v2Z1hXYUT0g=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LUcgeIo4QGVbLYiY5IrzZqJGPqcmeUS93f9hJ7f9RxxYLcZyKI4xE2cIxL/GZ3TQ7
 QGXa6uliwdvz9Lzni5JWM3Q+my5tz/l6myOIoyPKoybi1v2/VIVJy5purP1fz2yj9A
 rBB0fjWXz0hi54hVeqYfI+yNHJlDoaULL9cxfS8CjEo9ocD3yhpeaZbvtjU852LTRo
 VGk/4Vm+DyFRxPxjpocSyZymo4obsQPHxJjBJwZ4IgoCeDksiFsPm/mB+DSO10GRJA
 NQ6crCOc3K/RdqeRkt8X0tgaAPHb99YReHkvruzjOK51rBErazLTfRAxxxmy3I3mKL
 c+bS6AOGKw7Nw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so31971035e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739186325; x=1739791125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/D3Hqig29AwEZ5QWuNaIbZboXaPUrQ7v2Z1hXYUT0g=;
 b=b7PNGpAzB2pP+wDct+wfRbI9FjOoSDvdiNxs/+zMt4qbL/Pkyg5HuCBzCWxdUUg9lZ
 e0XAH9LjXnNCKnO6gTXrX8Aowqxs9ZVnJ/ng3DhjuFMyeKO2+oIkJRuLPGiNXQQm0qYJ
 3g8sVnhvdt9ePZ6B2QnLYS+EJS47Stpze3GoQDIIJ1NNU20SGsP/uJzNP/zSI4hm/jYr
 fNpe8tiujOsLn6wO9P739Vvxurqkvi3aytXKEft/O9xuUvDs1cAsnf8P4lqPPIVWl1tQ
 cA6uN6hWzWwsTNHEUY+0A/dq0cuATE7AXRTUFlRg66RhAlPJl6xahIsR1C+GrmyB9Yzx
 0/Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0Wl96offv66C4mFlFEs/0jUCaycomkpTIOxP2Ki9yT/NWkFR+l3PP4AFIWgGt+9g+dFUKKUQ=@lists.denx.de
X-Gm-Message-State: AOJu0YybBrw4p0EDDISaNFqaZdZBpqHq9FWp+eMfYgoOgSwM6CA9ep3Y
 DEOWd3enaX9fdP2+vRc6vBVi0QgXHECyF5vp304eZzedMJiqIjPj5xuCCERYOjxZcRxfWA5VTcB
 rapYfRg6qmDppt3IlWMstpaEtX0JJ2pci//8sSnWwQLxNM4afNcvzdw5S96G+1pxcJZ4=
X-Gm-Gg: ASbGncsRmOK77SbMmyBOki59CCWV+a7ZEj+TYKKIqI46TCpxHM4D7pLZai8uCUCC/vN
 LO22bwE6VQKqPaUnaUCTf++uTH2sQl4vBBtFRenfGJZaR4uzFVHYHKEmgk9/+VYranucQdm6FyP
 IPUioRDU8zWn9uGSLWyxG+RMmnpsmKGaTAirJDwbAZvOnYO6q9wOD16plUqcj2B/3+v9o6cO1YA
 c3k5bmPly4oNOaBS+qxybv0Zc2uwAzYxWPinko1RCdtSIIsxVhFeBPTF8y41zI108DkTsYDxdxJ
 juW4YuIXEjc2w0N0CFovtmPmVw9jNeS5WJVUGLWKLmdNs0t06XBdvGglQV4tNIUVDbfD2jjh4ic
 ictI81HY=
X-Received: by 2002:a05:600c:3c9b:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-439249c6e17mr117681965e9.29.1739186325382; 
 Mon, 10 Feb 2025 03:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqcOOkKYkizv7KbcZbQoFNFa4iRX0mYrKLysFjIVhdzAncXduYvkSGMbcYpP9aIDxg7QlSnA==
X-Received: by 2002:a05:600c:3c9b:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-439249c6e17mr117681705e9.29.1739186325063; 
 Mon, 10 Feb 2025 03:18:45 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dda26c6f5sm4194243f8f.68.2025.02.10.03.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 03:18:44 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] riscv: dts: starfive: don't use a default configuration
Date: Mon, 10 Feb 2025 12:18:30 +0100
Message-ID: <20250210111830.72055-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
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

Booting JH7110 systems with a VisionFive 2 device-tree used to kind of
work without causing harm to the hardware. But there is no guarantee
that this will hold true in future. So we should not rely on it.

Before the current patch series booting failed on unsupported boards due
to the lack of a device-tree in the binman generated default configuration
when reaching main U-Boot.

By setting the default configuration to non-matching value booting will
now fail on unsupported boards already in SPL. This allows SPL to
continue with the next boot source for a possible recovery.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 arch/riscv/dts/starfive-visionfive2-binman.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
index 05787bdb92d..dd0faca6824 100644
--- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -13,6 +13,19 @@
 };
 
 &binman {
+	itb {
+		fit {
+			configurations {
+				/*
+				 * Do not boot if there is no matching
+				 * configuration. We can't remove the default
+				 * here. So use a non-matching value.
+				 */
+				default = "none";
+			};
+		};
+	};
+
 	spl-img {
 		filename = "spl/u-boot-spl.bin.normal.out";
 
-- 
2.47.1

