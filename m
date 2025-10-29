Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D6DCCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 10:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8CF8004F;
	Wed, 29 Oct 2025 11:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P5BCr+xy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947F68006D; Wed, 29 Oct 2025 11:49:15 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EFC8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 11:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b5b823b4f3dso982257066b.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761734953; x=1762339753;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hvWM6TAHXK9kUbfcKWEd4PJ6l1RIOWyC+LQcP4dtWHs=;
 b=P5BCr+xy+3cWmv1m2Hb5m5+saFRNIzbdapm+vpMZHizzwSKpXpFwNbMoVa9DcAe89W
 oss7PcLT+XyWbwWId/ZYAx3PnOecdSyMqy+IUJzI2CLhb3N6xvzoODcnYCnmtb37P2V4
 +iKh5qw0qaHMWdFbC84doFs2bH68ekxfjHWXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761734953; x=1762339753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hvWM6TAHXK9kUbfcKWEd4PJ6l1RIOWyC+LQcP4dtWHs=;
 b=ijA2F9qshLvO2ZWdXnfDqRueGS9ThHmokChcakgzheDHlLIive3kjgKcuLgn8G5Syd
 VG0dQdYyLg99hGoOI6NE2dYAHrs/EqvfZ5u/8QY9cPFsMHxIW+tAviZf+XvJ37HgZoAD
 Hu+V4DbVPrYy+GZSpOYlg8pVNVPMcAw1/ubTqX8M7d0B0BTdeki0jRWYZ0zMaiNX2HDo
 wYshRHBDTvZGz+HOHnTAzf4IVVfwcVKyiYYZhN8h4lNatvbgaDsFlJu+WZ09ho5XF3at
 dKcLkNSQbkQ8/UKOjZhhbdYWtKmKf//XF0Kha71g9VBkb+c43nDNewhnnxfl8OQ2+2yP
 DyIQ==
X-Gm-Message-State: AOJu0Ywn/PiFRDhzzJAgq1AE2UR1z5TwyoV34lwcuDCdkjzP3cHnRYRW
 KVhvski8rmvUCSxwSMK4rdZ+zKN2RBc/a3HMufMLkBHOU/qCUzWDuJbVoKhnPo2PEtdOXMd6dMA
 WniX71qI=
X-Gm-Gg: ASbGncuxjjyfnSvLM0ZBtls2XTKL5szq6JYrDXrA2LS9rCyWpiBLhqugfRuE1Smm/L0
 py1zz+7Fe023eNbHXn+iDG1hMDS0z/TRQB76y59SSBnb2MX9GXhYP+ARx7DXPG1VM0k590z/ZTo
 5JgCqNckLTeu1ct2z7OJJ2hqmaZv2FMUVkMusCIwnx4l58UbyWVKZJ6rCsEemLUyly7XyebiuCA
 jlvkRtooUfYsXJ2NpwpXmDht8CA/Ev7kvb+0wBR92c7Fo9/UiTNg1fjEKRCZRkPuaLKLBAU2FSK
 B4ZT59o/S59Fq98NHBO6cdE3z7uKt/v93hOMQtaIGLPwuzcyUtDUiAwo7qLM9IwKUwKmYHC8Sqp
 dnd7HOIHGbvNbKWRqfh7akfPyQEBn7JffVWOVqbdqN5YXog0H2In9fT3tCwKA8fPHagqJBMzAyk
 r/3RUpbVZjYVb0a4b1tUU8Egq7i3VJ0PwF544q5ujF9tTBzKwCgxSRf1L7FLkm4VxhBXcDcyn1l
 IUjxBnT/GyniaehmA==
X-Google-Smtp-Source: AGHT+IEkTWS/sT374IalTaVXd44Mp2z5NnGxANLfSbUn8rxrxjyEEmP29UBDi6G4Pl16bRUBgwigjQ==
X-Received: by 2002:a17:907:1c0a:b0:b3d:9c3c:9ab6 with SMTP id
 a640c23a62f3a-b703d3831a1mr234998666b.29.1761734952873; 
 Wed, 29 Oct 2025 03:49:12 -0700 (PDT)
Received: from andrea-amarula.amarulasolutions.com
 (98-215-98-95.ftth.glasoperator.nl. [95.98.215.98])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8530905dsm1385924166b.6.2025.10.29.03.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 03:49:12 -0700 (PDT)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com, festevam@gmail.com
Cc: andrea.calabrese@amarulasolutions.com
Subject: [PATCH 1/3] bsh: update readme with instructions to build M2B
Date: Wed, 29 Oct 2025 11:48:59 +0100
Message-ID: <20251029104901.3810649-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Oct 2025 11:50:14 +0100
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

readme was missing instructions to build M2B. Now added.

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

diff --git a/board/bsh/imx6ulz_smm_m2/README b/board/bsh/imx6ulz_smm_m2/README
index 03d01325a97..3007180cc47 100644
--- a/board/bsh/imx6ulz_smm_m2/README
+++ b/board/bsh/imx6ulz_smm_m2/README
@@ -1,4 +1,4 @@
-How to Update U-Boot on imx6ulz_smm_m2 board
+How to Update U-Boot on imx6ulz_smm_m2 and imx6ulz_smm_m2b boards
 --------------------------------------------
 
 Required software on the host PC:
@@ -11,6 +11,11 @@ $ make mrproper
 $ make imx6ulz_smm_m2_defconfig
 $ make
 
+Build U-Boot for m2b:
+$ make mrproper
+$ make imx6ulz_smm_m2b_defconfig
+$ make
+
 This generates the SPL and u-boot-dtb.img binaries.
 
 1. Loading U-Boot via USB Serial Download Protocol
-- 
2.48.1

