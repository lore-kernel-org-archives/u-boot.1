Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7E9C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77A988AF3;
	Wed,  1 May 2024 04:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KlUimjgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C1088B11; Wed,  1 May 2024 04:44:04 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF27D88ADE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7f15256cb89so593288241.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531441; x=1715136241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNrzvIUDD08Iz0LN1g+Rcx2ki4OmhCCy6YJyFTwa870=;
 b=KlUimjgra0Scn6N6FAI8hCLrGuVA3WO97v69IPT9+LXdllN9lf0bWT2w+9rUkIQsB1
 6oVbehrcNsDcnT0qS5m/l+IPaKAwkyQ8ET9Xubu20tn4skI+GCi8NupyH+DHegcYyJkE
 YGbVZ1zMzkPJoh4dxpxifCbEAJ/7YVvd+2a9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531441; x=1715136241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNrzvIUDD08Iz0LN1g+Rcx2ki4OmhCCy6YJyFTwa870=;
 b=E4ysPUENfWDv+piToYPqBkcRXkg3SDaZfgOvR/PgaLHVnsC2XZxZl8tIzcyhdmseb/
 DYTcr+GPqmO5E3roe10/uL+BoGLo/ZLEvc95hWvdsm68V6LUvLnW4Vr42sfiEef8BTf/
 NQRtaMd6zGCE5POB+9XAEDEtPFCyCo9MKz/82tKWea+jsUvoT0A7EP5BvfBXGoQlGt22
 8VNWw0jUkXw8q2ZcSEsvaUbCt5WfTDV9a+0vbyC0oT6tF6Ou7Te1qHEADf7R16zfL3UP
 wMVRlfyD/ceDarZCiduMEVtmUbxMBc7OT5VczH7v5umGbxIeS8tgKr0KdsCjguHNcbxJ
 FV5A==
X-Gm-Message-State: AOJu0YzlGcPQAHiFfI3ggoUKP1g5xd+viA0nFeacSOJbHjNcOs35Tqux
 eLFnQw97RdQjdr/nqly4EaAVUYi5VXOBz5zb2NFRPKxcIccpM6xGZPpTS9fNd7cRtuU/yLRFV7g
 1PfuA3Q==
X-Google-Smtp-Source: AGHT+IEIXDS4Qf7e7kn2YK75jTzHzQ1uhCr4SyJEvOp2gPscSZWfai0zicZ0JPzd8Oze2DmQsVV1RA==
X-Received: by 2002:a05:6102:87:b0:47b:c864:fd78 with SMTP id
 t7-20020a056102008700b0047bc864fd78mr1366352vsp.34.1714531441481; 
 Tue, 30 Apr 2024 19:44:01 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lin Huang <hl@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 037/149] board: chipspark: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:24 -0600
Message-Id: <20240501024316.1767971-37-trini@konsulko.com>
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
Cc: Lin Huang <hl@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 board/chipspark/popmetal_rk3288/popmetal-rk3288.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/chipspark/popmetal_rk3288/popmetal-rk3288.c b/board/chipspark/popmetal_rk3288/popmetal-rk3288.c
index e6909b3b1c53..dd7551170d25 100644
--- a/board/chipspark/popmetal_rk3288/popmetal-rk3288.c
+++ b/board/chipspark/popmetal_rk3288/popmetal-rk3288.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/gpio.h>
 
-- 
2.34.1

