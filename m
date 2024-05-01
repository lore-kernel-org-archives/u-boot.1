Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05FCC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FC788C51;
	Wed,  1 May 2024 04:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ikAgUkS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7F188C4A; Wed,  1 May 2024 04:45:22 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CADE88C21
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso39512591cf.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531519; x=1715136319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfnORaXgDHXvqVEle6C1W4abqjFzQZiGeSFfhSegJBE=;
 b=ikAgUkS5sepuIPPJ4fbVZNtaIiZRD0eOcHSH/o1OEPXWpv3dhdGZhENG3oONao9GSu
 Ku/X6gk3qoD+t6xYuFpOuqULzPTFNXJyiKqCsIQK+C4HapkLnqD+7gCI2cYRzMd1wU+z
 lhRrtrSqiK0NQgGIlD8P69P6ZcufEhI/VH1hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531519; x=1715136319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfnORaXgDHXvqVEle6C1W4abqjFzQZiGeSFfhSegJBE=;
 b=ADAW4+e2JRD/AvGB09BfubO1bQmRw/zZfjOP1NXlSTPzo+AH7g8OtSbJ+afAtYdbf+
 8Sq8P7dGjX4huK4JiP2s5XCXDp7lGryfj1SAQ/wjhBVvIguqSPECVYXak4Yugc2jekvt
 lORyLLYuDKOoZrPmvqUhcwxMlzIHUjRxpq5NKRo7jGVru1MzekSH+oMXaMJAorpgaBPk
 PQ5b8hkgTeFu8F322YJhyQhoRECnXv4LOeglTNnMwQZSBbL8TaNlnGV2RTzKtHhjmYyc
 ZAlVRuST1Gs/vCOFzLtXlP0FWtgUX3+73IY4KXpS0Vgfj3Y9XdRb8LLi0lACLMMUMzcB
 g2Gw==
X-Gm-Message-State: AOJu0YxZN7pdXhuIOtb/7Ney9P6ILPyGpQIgE4oMdDjudRYFwn+FzHlP
 fHv/BomlewO0EqOoxJw70Ye7GITdhjglu2nmJhI/3YJ9ySSZUlkG7vf+k1ECuHt8XF1X/EH3SlM
 9CLGx5o3C
X-Google-Smtp-Source: AGHT+IE747IgWKDVzmQKr3DbEGGTx2hsj7G7PzP266dsoyUEjScwCdW3K+xWFPTTM7fXN4Q2Hpxq1w==
X-Received: by 2002:a05:6214:1d29:b0:6a0:d21b:c914 with SMTP id
 f9-20020a0562141d2900b006a0d21bc914mr1183403qvd.51.1714531518905; 
 Tue, 30 Apr 2024 19:45:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Gilles Talis <gilles.talis@gmail.com>
Subject: [PATCH 105/149] board: polyhex: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:32 -0600
Message-Id: <20240501024316.1767971-105-trini@konsulko.com>
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
Cc: Gilles Talis <gilles.talis@gmail.com>
---
 board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c | 1 -
 board/polyhex/imx8mp_debix_model_a/spl.c                  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
index 14b94c9e33ce..112770ba4931 100644
--- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
+++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
@@ -11,7 +11,6 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/polyhex/imx8mp_debix_model_a/spl.c b/board/polyhex/imx8mp_debix_model_a/spl.c
index eb904e116b11..6cbd1815cad5 100644
--- a/board/polyhex/imx8mp_debix_model_a/spl.c
+++ b/board/polyhex/imx8mp_debix_model_a/spl.c
@@ -11,7 +11,6 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
-#include <common.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <hang.h>
-- 
2.34.1

