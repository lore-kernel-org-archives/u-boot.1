Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA5BC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC454864E7;
	Mon, 28 Aug 2023 23:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fSDppsix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4A2864E0; Mon, 28 Aug 2023 23:56:39 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8464B80569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a812843f0fso2165087b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259794; x=1693864594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvpopYli34W3PM5VVflK1gfd7z3xxfwnGa9MP1bjtTI=;
 b=fSDppsixtozijuwf0SI1E5bX8LH5x9FkHx6e46gUxtuKSGdCiLDxTKdF1Nw0rOGLLp
 lKMkTI8zTPICShSoclV98lqNWFSeTQ5hA+Fl8PZ4TyFmGmyfWExj+5nWTVmSOapAXHMs
 28/n1fiacbbfZJSSrfVynmjwM4yz4G2bSA7yIg8UeJ1kUo8h4JtQaw+kU+CatqA1lDzn
 Unx3fQSXJMLaR7UuJnB5fU5/sg9182ceRlQwp5u7vQNTMC2/e0TuVWl0gEoPam8f3Mzt
 V/kjKgweEm7gx93n1l3ILPXdkoLkx0ocalR2i+wnx3zc8QuSshBcyWsAuVVgKK/fdXb6
 MBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259794; x=1693864594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvpopYli34W3PM5VVflK1gfd7z3xxfwnGa9MP1bjtTI=;
 b=X84us+yIpusMJRa9cjQNlCAYYcPR9ou9fysdXWKCkcE3fvBImkxxfm2LpIXBerF2kW
 dfdK8x7qW5UpQG1DzsVftms5ekxHmedXf2C01lCeQI4BehPsUUK49/5DCHVLSu2KRkO4
 eEJGfqrMGxCgC3s74cR2QmPAUOXdpLJQteyFPzbNZ1WCoeRtiTxeIMbGtPD6yztuwsBs
 pYVWsFiPFFNADiPTPnphmo73Nr77tF0xtAPs+iUC1s8O1HIM6eoeNao3vhTJmiDw87lH
 HClsU5+fzDDK7h0hljB/3/0Y1AIQAT8aIujZESoRwWLJdqhuSQafhdjKCtqJas4vBZxN
 76YQ==
X-Gm-Message-State: AOJu0YymZmjEywlEH4OhcoTUKykEjWtO8iB8oB6+1EyZNpFpU2JN3FPh
 VJSLiKYpkmlgqoBpHf7g+ufSKcYld5Y=
X-Google-Smtp-Source: AGHT+IHKAns0IkQOap8NGaILm3MDqSM1BZRoZCAoHOus82MqxceHp9CybPyuPnFYgvSgJFu2wZ5QVQ==
X-Received: by 2002:a05:6808:1785:b0:3a9:6400:62cb with SMTP id
 bg5-20020a056808178500b003a9640062cbmr12110558oib.57.1693259794384; 
 Mon, 28 Aug 2023 14:56:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:33 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 1/8] cmd: gpt: Remove confusing help text
Date: Mon, 28 Aug 2023 15:56:08 -0600
Message-Id: <20230828215623.3727536-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230828215623.3727536-1-JPEWhacker@gmail.com>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
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

This help text appears to be a fragment of the text shown when
CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 964056bd28..fe9e06681c 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -1060,8 +1060,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	"      gpt_partition_name, gpt_partition_entry\n"
 	" gpt enumerate mmc 0\n"
 	"    - store list of partitions to gpt_partition_list environment variable\n"
-	" read <interface> <dev>\n"
-	"    - read GPT into a data structure for manipulation\n"
 	" gpt guid <interface> <dev>\n"
 	"    - print disk GUID\n"
 	" gpt guid <interface> <dev> <varname>\n"
-- 
2.33.0

