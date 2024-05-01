Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79282C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DAD88BF8;
	Wed,  1 May 2024 04:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qUCM346q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9288588C1B; Wed,  1 May 2024 04:45:13 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3A288BFA
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a05f376effso49634506d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531510; x=1715136310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwBLlqDeDrC4WeauezfwOFQxdSDzsbR8s710ysRRDV0=;
 b=qUCM346qTpK7+6R2CgzhmmVNJEt2cPkbM7BQ77mlfNeNmjSRa/yG7yLGZgYz5Dhuvf
 lwHmNBsXJHGODrRiSuPdSX5rqgGqltlgmaztkLYIkdi/hBALvNa3Mcvn27S23UHXH6/+
 UCJGQITmB1J/4JG5HaSIEKMWI+ejbSgp8yhbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531510; x=1715136310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwBLlqDeDrC4WeauezfwOFQxdSDzsbR8s710ysRRDV0=;
 b=fZ8mIv9Tm2wWSO0ci1OEzRURKXGwqzm4/kcfIrZI6di/kiH0b321SqI9oYOtk6Af36
 QEHzFZCmFW1tRRy72CR2LFg7KA8v5OKOqtMfY08OD7EDpy4dcqG961qeX4XtyzK9vSNM
 G/nzbrq6Oe50N8MB76ba4mtMc2krK+hk5AGdgbPUYILBBDOkJufOziQahkNYweC2qlhZ
 thFdjcs6HOjfQZ5AqxD3TnV5NRDBzMkqoLqsbqwjhogS1Z8/kLeWuOWNTEnBVLp2pxI3
 C2/3LigzbvqZR2mCKIi8a7SR3M8NstFTsAwFxj3sr6n5YrHpCzvvaQR7nGSYL1I0PkvH
 a+8g==
X-Gm-Message-State: AOJu0Yz9H16DPv/d/nG87EDQrccFZI66aiUSv+L+UNkJnSZ8qXRThF2M
 9vf6Uw3riu5pT+X1knyEVQn0DGYwQP5zexs6/SS5V62Wfn1RxKe+q16nE8hU4JAyoxdmZWZUbxt
 QnihmpbBG
X-Google-Smtp-Source: AGHT+IFl1iEFQR6evZ7UEy5uKNPfIdMsJDvrQ7dSfgOZnCE85gL2AwqCWspDrIPFHUHjYHlaLUZZpw==
X-Received: by 2002:a05:6214:260f:b0:6a0:c339:1ede with SMTP id
 gu15-20020a056214260f00b006a0c3391edemr1356341qvb.40.1714531510306; 
 Tue, 30 Apr 2024 19:45:10 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 097/149] board: novtech: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:24 -0600
Message-Id: <20240501024316.1767971-97-trini@konsulko.com>
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
Cc: Shawn Guo <shawnguo@kernel.org>
---
 board/novtech/meerkat96/meerkat96.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/novtech/meerkat96/meerkat96.c b/board/novtech/meerkat96/meerkat96.c
index 1edebe5db9be..ca3b0698f5a8 100644
--- a/board/novtech/meerkat96/meerkat96.c
+++ b/board/novtech/meerkat96/meerkat96.c
@@ -12,7 +12,6 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
-#include <common.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.34.1

