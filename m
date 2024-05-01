Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24B6C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4508788B15;
	Wed,  1 May 2024 04:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OxkVQqBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E81D88AFA; Wed,  1 May 2024 04:44:12 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D0788AFA
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a04c581ee3so24585826d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531448; x=1715136248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjMiChLhPS6XGEHGzIbeAuy/w15STMzC3ZQvSaDepWI=;
 b=OxkVQqBz48JsXiW20Vt4fbnykfoY/Ghi1WxkbJ828QVa1DQ6AC36J1KtuhwhTu7Jpp
 mtaLhSg/2tqmYAXEwzUuJfTi7xxY1lPmHZmjURBp4ntKv7bpKGdRKZvIJvpVSWstt2Vt
 r/7/jmb0gYareMRtu+Qn3czq1WbdBFkemNxMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531448; x=1715136248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjMiChLhPS6XGEHGzIbeAuy/w15STMzC3ZQvSaDepWI=;
 b=lRb21DKd+gLpacUsMTodQ5ttmyhXcSZunEgcKYAdQIBmRlf71YXC66PUCIVkfAmPSe
 8PbvM84jUW26epnbD0AfPwo28Q4eWOmnyiQ3q+BarY8WVCQGgSXI00U7LE2v/qjjfwU7
 aoRuJ+b2ObURQWkSGblKTtU70nA6OvTZZFtRa/f5WCIjd0FrvKrGGT2jr89O+EUWaDA/
 TM+v17flB614b4w6bIXvDsAu8UiX8G0SwaHsdCklJfjofovOFe7CevTnCCbqtHo1njfZ
 YM2UJDMYsXDfnQVqb8GelO5KZX8+qIfmO4PaFuSQCoUDtxN4xvCYASlGyb0DwZvjgimn
 /+NA==
X-Gm-Message-State: AOJu0Yy/7S1ZjcChL8c0nf6XQMs+G3CsaAB8tei8+I3tkv3F41KiixD/
 8N2r7jNdBxg/53/ObF/12bninFERAcoOzpciOYjcWCgaoPm721C7Q9VH6jgzNREiErEQnFmMohQ
 alN2nRw==
X-Google-Smtp-Source: AGHT+IHOTIGICRa2iIPuroS+/rEcZN8bf7+g/cbi9axD1tXmgg5Emg5mY0zgCSC1TEZmWE0zgvAS5A==
X-Received: by 2002:a05:6214:c68:b0:6a0:cefc:a86 with SMTP id
 t8-20020a0562140c6800b006a0cefc0a86mr1068261qvj.62.1714531447674; 
 Tue, 30 Apr 2024 19:44:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jakub Klama <jakub@conclusive.pl>,
	Artur Rojek <artur@conclusive.pl>
Subject: [PATCH 042/149] board: conclusive: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:29 -0600
Message-Id: <20240501024316.1767971-42-trini@konsulko.com>
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
Cc: Jakub Klama <jakub@conclusive.pl>
Cc: Artur Rojek <artur@conclusive.pl>
---
 board/conclusive/kstr-sama5d27/kstr-sama5d27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
index 1b765b113743..64282ae9dc77 100644
--- a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
+++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2021-2023 Conclusive Engineering Sp. z o. o.
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <env.h>
-- 
2.34.1

