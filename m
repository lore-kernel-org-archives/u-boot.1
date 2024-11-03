Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D606E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9742890D5;
	Sun,  3 Nov 2024 01:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SHngQsYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF01890D5; Sun,  3 Nov 2024 01:29:50 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB93088AAC
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cbca51687so29184175ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593786; x=1731198586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OK6BVB/zrKgFQRIoVG4HZsXvxHAkWPaelfh4X4dXF0A=;
 b=SHngQsYo8CA/ODx4w+z2bA3FILlpAwxHg3lLr0UCqL9/1tPL6X4SeXfPrxHbJYzGOO
 LGwhpBPif5I9MW0BvQOOFEOfeqT7oy/VTOASD94jUjose5gfN1m1/86spIWvTzILvmY0
 kSRNNNqKUlOosOFNr+xKafbsp6UMLYs5MoM8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593786; x=1731198586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OK6BVB/zrKgFQRIoVG4HZsXvxHAkWPaelfh4X4dXF0A=;
 b=eDL5awnZz7s37H9ybuILj5HVHf/U5I7rW2P3YyS1dg70QhWISbTV19MRb3379OcZZv
 W/h56OY04i8pcNXBT5wscm4qMIyb3HQF2+GmDFhSS6W4awAp+ZtaEC64tneZSIvnnlt0
 Xf7lE/ktwAH09KoTNa5XNA2ve9ZCF54PrdmdTL8BOJpu3SgzL6lhWYGXvCTkYwJv5P8B
 Js0KZU4hDBmIOUtFB3iWlVENUuEZhzarXqK48lnJ/ym64PMZdUySCK2D7rfV6X52/DNR
 XOk8TgkDHbgi0TSgK8seDL4IzFaZ+TJs3SorwGLeypQSl/hCZ5uU+7UY7LTJfS1+kQBb
 EO7A==
X-Gm-Message-State: AOJu0YzaQhKWXdoA+3Zve0F0y/JxxRHaHa+imdtF9pk0RWjSCvbM3VIf
 fr+Ae+h/Fgms8I1XkI/GvaSixjOBDPMfPsTj3TUAM/qjv9z2QQSKpdFLj3AqvizQijOM2lgn9O3
 DAQ==
X-Google-Smtp-Source: AGHT+IG8nk0fkn4lGv1lfUqDUE7Hl0XYLUq/vp0evoVg8aDVyD+nWQDaIEmTzp7qHTVm42TlZ5/xxw==
X-Received: by 2002:a17:902:e847:b0:20c:a498:1e4d with SMTP id
 d9443c01a7336-2111afa9461mr105590365ad.60.1730593785744; 
 Sat, 02 Nov 2024 17:29:45 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc65sm39133335ad.10.2024.11.02.17.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:29:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 2/9] board_f: Correct stack reservation
Date: Sat,  2 Nov 2024 18:28:19 -0600
Message-ID: <20241103002828.624931-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103002828.624931-1-sjg@chromium.org>
References: <20241103002828.624931-1-sjg@chromium.org>
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

The reserve_stack_aligned() function already ensures that the resulting
address is aligned to a 16-byte boundary. The comment seems to suggest
that 16 is passed reserve_stack_aligned() to make it aligned.

Change the value to 0, since the stack can start at the current address,
if it is suitably aligned already.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d..677e37d93c0 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
 static int reserve_stacks(void)
 {
 	/* make stack pointer 16-byte aligned */
-	gd->start_addr_sp = reserve_stack_aligned(16);
+	gd->start_addr_sp = reserve_stack_aligned(0);
 
 	/*
 	 * let the architecture-specific code tailor gd->start_addr_sp and
-- 
2.43.0

