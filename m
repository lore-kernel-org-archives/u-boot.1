Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431A9C3ABB9
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 22:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A29D8007D;
	Tue,  6 May 2025 00:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ydt4icyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A595A820E1; Tue,  6 May 2025 00:09:33 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9EA8004F
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 00:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-605fda00c30so2507506eaf.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746482970; x=1747087770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DZAVUWA85QnM0OIfByp2gAwd9uGRf37rMTvE4gFGY2E=;
 b=Ydt4icyEXil3Hh3/QCOvPScQIM1iH3O06S9heOalQeckV56gTfO4JT/rAIQRYH7f+G
 QOUlTWxwW3+l/Vp0TKj2hZDVDXUeC2BlojgX0CHrOhLUMaDK2wkpbrJPan7vuvoThk8J
 R1qp5JaodntXFywBixjdFRK1u3MSBQA+JdgpBASaFkgf/fN2mlmBvyP08n3DqgYrqfAK
 zULgIyOkZ4uboCAKfS/NrDuJMWGCOcatMsBbG2cAXSHWpqf6Vct7k3yT+Rk24wB+P6UM
 gSk97WS+tYlyaXNt4AQjr1abDtPiUF915KKbO46BzvfvqFFZH3FO15s9EJJxhU46M+LJ
 ifwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746482970; x=1747087770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZAVUWA85QnM0OIfByp2gAwd9uGRf37rMTvE4gFGY2E=;
 b=B5XIdIS0L6/v+aHNGc7FRByBHVmjoaAq/AfkKFV7JIumVLCoYqbAiNjCHqauHkYch5
 V0vRWWf4wIDfoT/8Ba7pQvQ/P7M8kkAvhvcB4KDaW2T++YYVyewmBvhn5bN+pKgZ8I+j
 D7X8OdzjWh0nMBhfIs84Q9F3R541R82w9xNbc7LJ9TQqJoFqiWeTxdLxq+b6wAbAQyzx
 SngzXx4ByDol4qyGzIlmsJItl2BpbRX81Vlkc/w532qA7XKSP/GYNdGBge+FEPv9ZQSW
 lhuojpzhUKTmPrbfZzGwZO9hM4xWgnYRVQsjXuHVXkI8huUG+8yyJYdFbIEJg6fg4X8q
 Xdww==
X-Gm-Message-State: AOJu0YxUvH0xUEQNS52+PEXqFtHPxd4TIEJrQ3QGdnvCCb4iaLhazN3i
 qKqn/nOH4h5NjYyxNwDcQRN2VhNrhqyqxDoH/9Q0Z44/l9geU4CyBmiSNw==
X-Gm-Gg: ASbGncv+5U+/3UrXgwuUCkqd7xuVYjW2fL0/EiupZpml3P8LtbjsBDc8GA+7xanae7+
 pj/S2kWp7Z+7XKGFAppYK9Guswa4yahOP/o/nR3ozqXUTwnb5DyRPR+Tigdb294PEej5o4pIjhS
 D2yVcxG1Kjn+o3aL5piAM1hIvKid0kQE18JAJ+575W42YzlRWsTeEtT0J9vfizrc3BFVR5iLEDw
 HA+NjS0rNYl0mjMNZGY2a09CoIXday1gMts35Sb3lcSJdAaCqhiZe/TW529nUhIdeyRDV/wyzIV
 2jIcv66G+2K7rbEDvjDUbBHC0bFILK06m5GkjrZGuPEjpze91SYWWrdZliRtyxaWOPwNFHM0eYa
 XQp0ixBVhsGUtXnE9kjdhzfhCT89b
X-Google-Smtp-Source: AGHT+IH40dPExuzmvximK9tCW9OPzvegEGFh0JMTpWmTfbivKRZ5WwxdwptBWLAyeNwfMvaO/Txz8Q==
X-Received: by 2002:a05:6820:2789:b0:607:e57d:fe70 with SMTP id
 006d021491bc7-6081e6ecc3fmr406406eaf.6.1746482969700; 
 Mon, 05 May 2025 15:09:29 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe8e8dsm1897006eaf.38.2025.05.05.15.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 15:09:28 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: kirkwood: Convert to DM_SERIAL for Kirkwood boards
Date: Mon,  5 May 2025 15:08:52 -0700
Message-Id: <20250505220853.23679-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Enable DM_SERIAL for Marvell Kirkwood boards that have not been converted.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 arch/arm/mach-kirkwood/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 6761a9cb393..26fcd3732d1 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -55,6 +55,7 @@ config TARGET_GURUPLUG
 	bool "GuruPlug Board"
 	select KW88F6281
 	select SHEEVA_88SV131
+	select KIRKWOOD_COMMON
 
 config TARGET_SHEEVAPLUG
 	bool "SheevaPlug Board"
@@ -86,6 +87,7 @@ config TARGET_DNS325
 	bool "dns325 Board"
 	select FEROCEON_88FR131
 	select KW88F6281
+	select KIRKWOOD_COMMON
 
 config TARGET_ICONNECT
 	bool "iconnect Board"
@@ -103,15 +105,18 @@ config TARGET_NET2BIG_V2
 	bool "LaCie 2Big Network v2 NAS Board"
 	select FEROCEON_88FR131
 	select KW88F6281
+	select KIRKWOOD_COMMON
 
 config TARGET_NETSPACE_V2
 	bool "LaCie netspace_v2 Board"
 	select FEROCEON_88FR131
+	select KIRKWOOD_COMMON
 
 config TARGET_IB62X0
 	bool "ib62x0 Board"
 	select FEROCEON_88FR131
 	select KW88F6281
+	select KIRKWOOD_COMMON
 
 config TARGET_DOCKSTAR
 	bool "Dockstar Board"
@@ -129,6 +134,7 @@ config TARGET_NAS220
 	bool "BlackArmor NAS220"
 	select FEROCEON_88FR131
 	select KW88F6192
+	select KIRKWOOD_COMMON
 
 config TARGET_NSA310S
 	bool "Zyxel NSA310S"
@@ -146,11 +152,13 @@ config TARGET_SBx81LIFKW
 	bool "Allied Telesis SBx81GS24/SBx81GT40/SBx81XS6/SBx81XS16"
 	select FEROCEON_88FR131
 	select KW88F6281
+	select KIRKWOOD_COMMON
 
 config TARGET_SBx81LIFXCAT
 	bool "Allied Telesis SBx81GP24/SBx81GT24"
 	select FEROCEON_88FR131
 	select KW88F6281
+	select KIRKWOOD_COMMON
 
 endchoice
 
-- 
2.39.5

base-commit: 9cf090e8874f958d637d779bd872cbc41ab30544
branch: master
