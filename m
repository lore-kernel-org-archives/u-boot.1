Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EDBFD374D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 12:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAF882A9E;
	Wed, 25 Feb 2026 13:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pxHkk9nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A9E83642; Wed, 25 Feb 2026 13:13:11 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6182C8003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 13:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B3CD3F365
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772021589;
 bh=Rm+YT1vrSTLhchcSOVh06zjsgnRFTRHpGMafpJMFWoc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pxHkk9ntNE+Ni6cvHzSmpK7KfYqXxm/v8ju8jv7nKBb9A4cj7zhHKaiZXf+2+McP7
 I7RzW0Wxxzj+oblXAw/Fzy+zsbloq9fehnnyhXTPjpm34dSo5EEaP77/gx7rSNDZjz
 lQrwCCVmrgYRG9YLOAHi+pCWdvCxcH+3Sq7L1ytAcAn6OO+UNNATRbmD96I02nSoKT
 1nzZf2d8DaBaaK/XNyyIxm3QgGi7rzjeqCpCtzisrpltB4lEjXnOXpEp7EvNLrg+Sn
 QyCLeHtrVUsEbr3I+QZ3JRUac2XpoJhwa9RRi+uR2atheNoD8BDiq88S9so057j6CO
 s5pnDTIGmCLtDRwwtJk2t79uOALcAJO+Q/2QYefAmTQzSR0rmZZkXUVJHmBFBTryta
 vqhcE/Em20+qmm1hGryJL9DJymMYGyvO0u9KMlmezIklwvcpBJtveEPXn+1i8RHdz5
 26G7rUBXqSIKYm8tbeF7ck3wqvBwd30+DR4eQ3Wn3hIsjRnicPpV4I0jmJbsos/go3
 Tb9UW16M3SDJtsFFBfvzrg1qcAjAPSM223mjjiiSX9RbyPTaLh6RUurIfDL4Ubz12l
 JzF7sH59AEYwMa1kcMb4384cYYwty2UnyyKGy3G/paqy2Q+1Fu37OgfgIJhaaTP0od
 ZvD1+zdDKSf4aZoazVtCP9K0=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so11234255e9.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772021588; x=1772626388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm+YT1vrSTLhchcSOVh06zjsgnRFTRHpGMafpJMFWoc=;
 b=mYiC/U+s8xjMvUe/AwbYNQc9mOuqV1jwq5fBWKOeVx6qV7x59up4SCr2eKCGeGaMjp
 fjq0+oAauEo2UeYRCPF+0XiqQV6i8l5C9baq8aSboECVW1kmi6+ZCXdxYzmycUfsfFdS
 WdW/CrHaCc4MC6T7zO1H3q8tcTOIR19pIVOF7H28EzpQGweXS9bROPANLKtu1XBiCo+N
 dfBmn/WJlWzZE98Up1yCcsv2VXamY7eJ10c+jhTp3meRDFhxf32WbuK5WtQ2g7U8H40X
 RF8vso2mAid8pByGtnZAdYc4roYlq/kwjHUoLOk//yBCImlIiHNniZJsNUFTZ29FIWIp
 L0Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrWkqdwWTjS+9CyOsyMmFeF6am1UAQ6hFudoj3OuWXRA0kEiTNRsuxtBoKk13R25s9ow7spSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzmD15XHXgtWLjXxxCU/7zVVb7gpfRWKvu0ISS9IefkPfeYCQsk
 33lW0HGGEW4dgLh9k9I3c3xVyejcoEsbtO3pp8gE792prb0VXDs6U0hBT0eHRrZEuPBaKCmVRdb
 utiEZfDHedPWZPHTF+KbaLmrLdUoUulhzG9WzvIROLKibGkRyGweCcI/qRc81zpJm5D+VCGc=
X-Gm-Gg: ATEYQzyll4gaiHOtBe2tjqv/uwTIU4xP8njC+eUukgB7/TRDCnnbCU3FtWpMZEi5s8c
 dNc5ky+fTdwBrp87uNd2fzpO6Us3j5ZiTBbdCSR8hPGcfMfzuyDJaowD8EeeJ+tzzTrnG1xLIZr
 t1E6NPdc5mFu7kd3RS8+YuNWrMoGmwVFf/rkseY5Kxr6LB1gbdHLmk36o7dnP0x1Rxfq2LpPLj4
 jon683I/Xh3AMbVh+t50xBM8FGwiHwQ6LAo7YeWcAofbi+w3iFsL9uIyAOXw/OQiS9U8kmi3EsB
 FD76B1MB1mvZ7BTjOJZMFWEBCe7JfyKJSvCDgo+n/WVs3hBgAOoYbYt805bFFZFtCaGlNYiOiYU
 X8hRTO8uKyu94baV7fS/LT2vBOAPLvjYMkG3V30JxEkpCqYumyiZB/YGMUsBLphgG+AsXhGXV2q
 JEp2hQic3MauU/tVohqNWftDhd7G5SNsYETYeqPPiDoM1M
X-Received: by 2002:a05:600c:3495:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-483bd72542dmr63416515e9.1.1772021588634; 
 Wed, 25 Feb 2026 04:13:08 -0800 (PST)
X-Received: by 2002:a05:600c:3495:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-483bd72542dmr63415925e9.1.1772021588205; 
 Wed, 25 Feb 2026 04:13:08 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm66881565e9.1.2026.02.25.04.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 04:13:07 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tianrui Wei <tianrui-wei@outlook.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] openpiton: imply CONFIG_SPL_CPU
Date: Wed, 25 Feb 2026 13:13:02 +0100
Message-ID: <20260225121302.56052-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

There is no symbol CONFIG_SPL_CPU_SUPPORT.
The intended symbol is called CONFIG_SPL_CPU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/openpiton/riscv64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/openpiton/riscv64/Kconfig b/board/openpiton/riscv64/Kconfig
index e4bd8903aab..b646aa8cbb2 100644
--- a/board/openpiton/riscv64/Kconfig
+++ b/board/openpiton/riscv64/Kconfig
@@ -31,7 +31,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply RISCV_TIMER
 	imply SPL_RISCV_ACLINT
 	imply CMD_CPU
-	imply SPL_CPU_SUPPORT
+	imply SPL_CPU
 	imply SPL_SMP
 	imply SPL_MMC
 	imply SMP
-- 
2.51.0

