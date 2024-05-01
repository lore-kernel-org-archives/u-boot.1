Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9438DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D55488CDB;
	Wed,  1 May 2024 04:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="no+/THQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA4C88CC5; Wed,  1 May 2024 04:46:03 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A6F88CE0
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-79100a90868so189434085a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531560; x=1715136360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=em6vvJq9c69ZmOoqXMI7QN1siDnm3EFtH2IP0CjoVDk=;
 b=no+/THQJ54J2pza3wmq9ybOrqJmzin8J/MvYyCmPT7yvU9Ok0WARCoYJ8ABJ3qQAdr
 Ah7uAbTtkv7C0C04shNvRygETlE0LEB9S8WkQAiHpMjdbl7AFC7hAOl59szil9D+bkD2
 4JI2FRoB/Z4nFUyUObJbnyr3GFNcZXmcXsLGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531560; x=1715136360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=em6vvJq9c69ZmOoqXMI7QN1siDnm3EFtH2IP0CjoVDk=;
 b=KnXK/d1JGOj1iaRjrCBGWwVFQtN8ZGVpdPsVVSyx5+EI3nlh7C3RcIGwv3l/FLJWyc
 bbOKZ/Cm4GsFmZfsz7P1ihqT00iEFD0Nn/PeXWyOKKTi6nyeI2QHYCPHj+vvzpkUTzH6
 9xTiA8hGQHxyqQ6x0xdQX0t/PnB+1pIoEKEVVEKmzUQtA6jgJPlY5hfQ4E+leVO45LRs
 c+fLB110zpm6A1AAsVZf8zcczycDMcIRfhnBL98LNxmAABoa0eOB2cV9rVADd9o2myr4
 96DAKuKZ1ngG3ljQFzxVoEGz4OlyRxcLnv9e6A2hFAPMpYB6DAghOZ1wL7k01jUU6ffu
 0yYA==
X-Gm-Message-State: AOJu0Yxvq1BJB2mjmeX3zTBfqqCRBQBe25mhZeQ3Vppx8LTldLEgKiTn
 dspa2pVVgi40QNRoqD2Bvi73Tn6UZuhMOvOu/kEsgDjn79ImtODXKLliXBNNEBL1IaLShEnxfIm
 +8/C+Z6ut
X-Google-Smtp-Source: AGHT+IEDlFGy9AHwZ53mu1rcLJnDMprT41e8OCba4p5ItR6SRKrTLideHSAqF8Qs0i1sGecCEjGduQ==
X-Received: by 2002:ad4:5aa1:0:b0:6a0:7de0:a28c with SMTP id
 u1-20020ad45aa1000000b006a07de0a28cmr1141510qvg.65.1714531560215; 
 Tue, 30 Apr 2024 19:46:00 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 143/149] board: vscom: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:10 -0600
Message-Id: <20240501024316.1767971-143-trini@konsulko.com>
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
Cc: Yegor Yefremov <yegorslists@googlemail.com>
---
 board/vscom/baltos/board.c | 2 +-
 board/vscom/baltos/mux.c   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index bc7dc5888f2d..2c91e9fac43d 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/vscom/baltos/mux.c b/board/vscom/baltos/mux.c
index 7b99cf0e182f..77b142f08f0a 100644
--- a/board/vscom/baltos/mux.c
+++ b/board/vscom/baltos/mux.c
@@ -13,7 +13,6 @@
  * GNU General Public License for more details.
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-- 
2.34.1

