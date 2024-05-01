Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476DDC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2244188CBC;
	Wed,  1 May 2024 04:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XJAcxiAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A4088C9F; Wed,  1 May 2024 04:45:47 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28DD88CA0
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-47c1cf8a7d7so1764909137.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531544; x=1715136344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lW+CEufsZIaJ/tjQr/kPIgEGSlwWFPSstSySxvVumGw=;
 b=XJAcxiAKio4RI6fjDApxFGcqJygXN5KAFyuYqDIueP4UVTP8JSshf6phXKxf7xF9xM
 EQWVyKgXNwvYXe/ZjSJBcZ6pUHabEgBa3gEX+SkQW7807GqqcP+lKtEKEiBmtQ7a/UFK
 9HaqnN30qAD6K50TMBfx6Rfng5tFx3474+1Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531544; x=1715136344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lW+CEufsZIaJ/tjQr/kPIgEGSlwWFPSstSySxvVumGw=;
 b=CgG5sRq7pTrTWcjfIfaAO58ZueLBUMGBctPpqa3PrxjJFA0YzanTFsWRLcys9ghmbU
 YYpGFM+An+3Azyb+h2MkFzxS3uM3JsNNik0i33DZpHqzG29KmbS1pidZKTvVpwsfvGZb
 1/UqeGcbAp2iIhsK+/ATw7p6lsZ4F0afAIsnMNnjgVJ4Yl7QF+0H72CqOYBkeMTihWYD
 N5CUX7U6Eg3hbVBZ27d3lTycmnRkFn/VaUCDllPUd+iRU45ftq6CLFcyOXgOcigLOBum
 fIr4EGRdoCy9VPRWLYX5Kpik91j8IVeDsWGNv3mn5tNXrntQTnx35nWG3nsBcIGy/VYC
 9L+g==
X-Gm-Message-State: AOJu0YwailBACjQySlFTRfVmHuHF0ZKGsYuuNRyOBpViKFwrlOUrf1Ni
 vHukbSS7pH9dtlZmbUFEUbLhoc8UEeqz0Y7j0cga1xC5ocr0QR9kf/EVWl9ytdrKExCBCcgE/w+
 YXNutRoli
X-Google-Smtp-Source: AGHT+IGrYlf5NahIFS/SLUjWh89ebHuQmDNliSSuaTA5HtTfgzpUNMtqf+hH6NPEL1ykKaSRCvWWaQ==
X-Received: by 2002:a05:6102:c89:b0:47c:2a80:ac61 with SMTP id
 f9-20020a0561020c8900b0047c2a80ac61mr2012636vst.27.1714531544616; 
 Tue, 30 Apr 2024 19:45:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
	Eduard Strehlau <eduard@lionizers.com>
Subject: [PATCH 128/149] board: storopack: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:55 -0600
Message-Id: <20240501024316.1767971-128-trini@konsulko.com>
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
Cc: Fabio Estevam <festevam@denx.de>
Cc: Eduard Strehlau <eduard@lionizers.com>
---
 board/storopack/smegw01/smegw01.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/storopack/smegw01/smegw01.c b/board/storopack/smegw01/smegw01.c
index 345191b31c29..910feeda31f5 100644
--- a/board/storopack/smegw01/smegw01.c
+++ b/board/storopack/smegw01/smegw01.c
@@ -12,7 +12,6 @@
 #include <asm/mach-imx/hab.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
-#include <common.h>
 #include <env.h>
 #include <env_internal.h>
 #include <asm/arch/crm_regs.h>
-- 
2.34.1

