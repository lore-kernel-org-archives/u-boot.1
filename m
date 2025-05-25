Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21100C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C148382CED;
	Sun, 25 May 2025 12:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ssxyudln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E2D82CCE; Sun, 25 May 2025 12:48:23 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777E082CF8
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a367ec7840so992273f8f.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170100; x=1748774900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Do+4Rru6M2N5GxCTknC09nx6aiBbH+QMXvMjneX8ReU=;
 b=SsxyudlnaQFWFNJ9nKHTl93bmLOtfYQqMvpT4clI90qwi2+0cRRhscjGpyk/tRr/bu
 e1fRck1nI/+T1DyDyzAcUMo7mXrJAKpMkMDzdXwNI611OBeo794Hbfx2EPl5vW61mJ6E
 +YM6i+0JFEa2ChiVvrXxTwIPR5uCR9ACDwpoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170100; x=1748774900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Do+4Rru6M2N5GxCTknC09nx6aiBbH+QMXvMjneX8ReU=;
 b=tlB0PDfMRsHQghdqcppmbbQdgq3c7UQNJvCCsjgM+daPRGavIYwHjqUVOmy2PUuwf4
 HtEHB3xlS7O9gXQcJFlcZnkq6u15U94U7QZ97ywl1cNXZtHhOSuIYiS3kW7Xf3mmmxj0
 uk0iIuxoLn3vnpjYrLutyhkSE8z2iU/vVSArtGKtiNtMFKFe5f4Bc8cw7u0JGQ/fQa6E
 oqsFYm7ADlGwVXmzxO/1P+Grmt5IBLthWvVbs46g3u0Xn1F4wS0OWU5G4yTElRS4q4/5
 pf7fXf5roFT9c2GfkH4CAMN5PaLxzOIix9uyTrdgw2ki9Su91Mgs/Y2Lvtin5sfHUHfI
 u+vA==
X-Gm-Message-State: AOJu0Yz4/mvwT+K0Q2GFmuKEJ3Neor0byqfIq7cv5iQcnbc03r8MJz3O
 V5cSbsG1SKgg4NnD/y4lqoPCcxZiPO3/tzhqEjiAnE4glqogoz473WtyPRmgx+mvavZRubZIWp8
 EPFr38rTV
X-Gm-Gg: ASbGncvOetvWodzcozKUbJg+zdUYZ/C4JGOxFaB2si9hPdxN6nJBw1rfUJJj0eKo3xx
 Qf0PNkSdWLVqFhRGdENg3xpW60VdUYBeaW3YZPaut4K71HBmvhHKsaccyIsbDOZ0a9jjYJq29aR
 YGKHwsDEzxu35/5lH1D2QfwaQVRVIzimZHGmB0dgOsPeaL7kfCTFeHYPnDhLKJtMlp+yACHITvr
 lTkj8A8M3kmFYBuI0YTciaoKYZB1GbVq59b/Fu2ZaGdpzX0i1UMFDTMizIcW56TeTMLoVpXFJin
 B2X7Iz5bwaMrOMZycz7pu7JFGNO/ujf0Ss6ULsEzlQ7EWZM6FZomq/LzZU2/iV/DrX2/aLI=
X-Google-Smtp-Source: AGHT+IFLEowcCsD8B8Kuo1efMBUh4yo02nrTwwkOXnd51KJWhDSxbJrASX3/4ubRCJ42gz8vVN3fVA==
X-Received: by 2002:a05:6000:2485:b0:3a3:7031:59da with SMTP id
 ffacd0b85a97d-3a4cb4c6d15mr4030983f8f.59.1748170100455; 
 Sun, 25 May 2025 03:48:20 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 08/25] rockchip: Add SPL into the main FIT
Date: Sun, 25 May 2025 11:47:44 +0100
Message-Id: <20250525104801.1440260-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

VBE may want to load the SPL image from the same FIT as contains U-Boot,
if there is enough memory, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Use FIT_ARCH instead of ARCH

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 475dbc53796..dc1664d7b2d 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -38,3 +38,32 @@
 		};
 	};
 };
+
+&binman {
+	template-1 {
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				phase = "spl";
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+		};
+		configurations {
+			@config-SEQ {
+				fit,firmware = "atf-1", "u-boot", "spl";
+			};
+		};
+	};
+};
-- 
2.34.1

