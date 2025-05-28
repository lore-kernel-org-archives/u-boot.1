Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DCBC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 00:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0076D838C8;
	Wed, 28 May 2025 02:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LQkjNx/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E208D838D2; Wed, 28 May 2025 02:03:07 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C538318E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6065251725bso2436162eaf.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748390584; x=1748995384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bppW7KJ5xK7ecl/weaZPB8PoQ8/nn63EJ6XAnfs7p/Y=;
 b=LQkjNx/TBGDYo1RVel5MBDYIIzQFIcKbjH8dbiN4M1Q2+TrytUOoCs9tjZm2ViH2k9
 DDsyZenw1R+ZNDw2rH66U+gxFuQdugHYECIbO6RHzrKnXXIi3oPeAzrsDXJBZVPzPuJv
 1C9fmU9f5n+pjNJvkciopAXIXxGOn3Hw3VKgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748390584; x=1748995384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bppW7KJ5xK7ecl/weaZPB8PoQ8/nn63EJ6XAnfs7p/Y=;
 b=vaoWOhUYqt/K21G3k5zCi0GT8PfSmyVWDGOdG4kem36kDqogzKaPk3+IX8IqVITdiG
 6RawnnodnKJ7R1vLN45ZXHwnV5YprNlX+r5pR71vAqg/xixLRa68/rstiXHs8s/HFiEH
 X24UF9b3IrdG9AB58NRsPuGotTaFhLRqgfhtVOJPli8JSF87xGa0dMMQLCEgcGuHJ+ZX
 OW2AMDefr52X5obX44mVjwApkZFL1OzjXqMiBaLi7gVcpRIvsjZVMdKGPwR4OM8aYyxg
 HntxoS3zz8ekn5OrrUl7pVmV5I4FvGBjUA+ytmN1pijQU+dH4pj0suboV7QB+bothyuX
 ba3w==
X-Gm-Message-State: AOJu0YwXe2dsZFqov4TLJUmAlA6rsfvvZo/TC2/i8rIKM2uc+LVlLmii
 Uou8cd83B35Zhm6LqM5lAu3vRJ5u0aRTcmyu77VIsFu5lLxwfT5sFmpFh1jEZ9cKCLn1row4GL1
 5f3ghRcU=
X-Gm-Gg: ASbGncsjlvrX2s/ugqLpcSjPBusLzQsi0212jYbDG4Zkglq1TaKLXFfi5N5o9qO396U
 9vY87uJsfuHZp3likAx+Vs+w5CIHmEi7GAsLvZNjBaRwzYKHuSx2dVEVhlG+KtDjoXIpbZ8O4pG
 EmD276jP00uRRWMs5OIH/wn08ez8Jx/UZ9vKvZWK5dHIwmtzwzv/o1ipRtIRPLBJ05YpRihPOxP
 K6MzlANWrxBtXLu1/4xDAyajJddt/FXZfvrnP5olNJB42yMXu6Ns2Zld/xTdiBJTAr+HzeFtGKu
 VoRDX5BiqGVFCWMc/F5swqO3Wiyd3QjLEP2YqfvB0VICr75bDPObQmUMBoyY2wU31KaRH+G5Bt4
 qaKgwL71Rj0XTggE=
X-Google-Smtp-Source: AGHT+IE0WwYg/RLUpVsQLmuvPzgy54iufXy12p+oyZsSO0NN9oIUYZuK8s35Vv5Wq+oufo3WgO773A==
X-Received: by 2002:a4a:d856:0:b0:60b:a7d2:f993 with SMTP id
 006d021491bc7-60ba7d30363mr5899654eaf.7.1748390584120; 
 Tue, 27 May 2025 17:03:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd9c2fce7sm17504eaf.19.2025.05.27.17.03.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 17:03:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] include/dt-bindings/reset: Remove local version of
 bcm6318-reset.h
Date: Tue, 27 May 2025 18:03:01 -0600
Message-ID: <20250528000302.3003129-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Aside from SPDX tags, the only difference between our version of this
header and upstream is that BCM6318_RST_HOSTMIPS was defined to 11 (the
same as BCM6318_RST_PHYMIPS) and is now defined to 12.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/dt-bindings/reset/bcm6318-reset.h | 25 -----------------------
 1 file changed, 25 deletions(-)
 delete mode 100644 include/dt-bindings/reset/bcm6318-reset.h

diff --git a/include/dt-bindings/reset/bcm6318-reset.h b/include/dt-bindings/reset/bcm6318-reset.h
deleted file mode 100644
index 1422500f8f52..000000000000
--- a/include/dt-bindings/reset/bcm6318-reset.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6318_H
-#define __DT_BINDINGS_RESET_BCM6318_H
-
-#define BCM6318_RST_SPI		0
-#define BCM6318_RST_EPHY	1
-#define BCM6318_RST_SAR		2
-#define BCM6318_RST_ENETSW	3
-#define BCM6318_RST_USBD	4
-#define BCM6318_RST_USBH	5
-#define BCM6318_RST_PCIE_CORE	6
-#define BCM6318_RST_PCIE	7
-#define BCM6318_RST_PCIE_EXT	8
-#define BCM6318_RST_PCIE_HARD	9
-#define BCM6318_RST_ADSL	10
-#define BCM6318_RST_PHYMIPS	11
-#define BCM6318_RST_HOSTMIPS	11
-
-#endif /* __DT_BINDINGS_RESET_BCM6318_H */
-- 
2.43.0

