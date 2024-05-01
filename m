Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23984C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8493788B0D;
	Wed,  1 May 2024 04:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OWujEI4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819A588ADB; Wed,  1 May 2024 04:44:01 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7966688AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so69342266d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531438; x=1715136238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsCZpKYYMccZKP99Bi5Ziy7HBdPa+4qcdZti1Ht/tdA=;
 b=OWujEI4BaOzdp9elVM14vaQU01rJxLAzGb8C7KAsr3E3+Vdh5O7Do6TkVuVqQT/Fd4
 8dhrbi6Yj4nhnHzQQeR7lzqSwrBdkaj/GgBN2PYhqKDMOufx2k2jYFt7RDQib2pFzxA5
 eseUdDIMLB9RH13RV4ELhxX+g4aXBuTAWn3hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531438; x=1715136238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsCZpKYYMccZKP99Bi5Ziy7HBdPa+4qcdZti1Ht/tdA=;
 b=jta/jc3zRSFVMFnQIpZfkiig6Pf+SCe5DO2eCm9rlufutmM54vinpgDBkgN7Hbh/dv
 w79WSUUdP9gpK6r6922vJ2aGRIHCDAwvPOCNaNqWp+DlYIpQSAbp3TqeZuPDGKiZR7zg
 jNYcL3ALvivE33Dxbh22tLCSeg8HbWyVJGi32+o6eJQa5RLvE/Aqa6CpDak41GzWDiVZ
 GeXliFrH81cYUxDA6LhTEnuc4wgdytAZ1tmZo85Quy8lo4pJd45mw47ka9ybYhUPqma6
 /fCbxq8UcygMV7wLSGFXi5lXqBLEwcf65ipCLgxJ46ii/vh36kpE28077sHt/XZjhXlG
 G8WQ==
X-Gm-Message-State: AOJu0Ywh8H8otwc0xP7eHbMlBa6z8T/zYGTTcuUbcJvqBexIM1deNsJE
 VKrPNQyyyj+axqC97LGcoXeRgCuPYuTsGxmCBaw09SZ8c5YwahecLuL2Wr3LSJe9WdPZdHYhyIW
 6tq+fIQ==
X-Google-Smtp-Source: AGHT+IHkykCAsi854y6+Z2F9m9p4w+kr5dV1lPEerdRuRffa1HiJ6xfRDWPr7fMmMQcnHWpXiV2irQ==
X-Received: by 2002:a05:6214:f06:b0:699:49d3:fe3a with SMTP id
 gw6-20020a0562140f0600b0069949d3fe3amr1191487qvb.44.1714531438222; 
 Tue, 30 Apr 2024 19:43:58 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
Subject: [PATCH 034/149] board: calao: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:21 -0600
Message-Id: <20240501024316.1767971-34-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
---
 board/calao/usb_a9263/usb_a9263.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/calao/usb_a9263/usb_a9263.c b/board/calao/usb_a9263/usb_a9263.c
index 3d31776d4841..8e39a157ea31 100644
--- a/board/calao/usb_a9263/usb_a9263.c
+++ b/board/calao/usb_a9263/usb_a9263.c
@@ -7,7 +7,7 @@
  * Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/arch/at91sam9_smc.h>
 #include <asm/arch/at91_common.h>
-- 
2.34.1

