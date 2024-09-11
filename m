Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D9EE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14D78925F;
	Wed, 11 Sep 2024 11:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ypzULrHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828998924B; Wed, 11 Sep 2024 11:58:55 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932CD8923C
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3787f30d892so4018963f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048733; x=1726653533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ly69i+XeCnYQgS8pZW1S63YOkSlgFrIkxkE3L1wYgI=;
 b=ypzULrHVCRl1S5fA2I998PxFYLH/FAAPAQHTGh+wGri/tqKcAuAJERnz5UPRLxi7in
 5t8ukjBZcNXXnz2y5Ggd3SaU3qlQNCJKjKMjZjJYTt1nZp7yePRHEvGAG1SpZhFEZBZ8
 lf+oGIyuORyIQPGKBJ7KcgQ1/48EJzwfSk/lgPDa9z41BjKjbYQblzvUAUWJQwZ3CLay
 obheZ4PaaqD7ZcjYqiv4t2wUxVAfll5AvvyrQLBrm3uHAOC5uZtbi2QmdoahXARxWoac
 P2UmaMzePT5OjBJ9mHWiY9N9hZbU6mPJdexVsCKDBQYCrfR3ikakeF9NyS3rwgPPSdYl
 RWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048733; x=1726653533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ly69i+XeCnYQgS8pZW1S63YOkSlgFrIkxkE3L1wYgI=;
 b=O8b2T0okef16fT+7mThV104xoiXdoxHe317doO5lYpBGt8/huvHNOZdMEgr0YjzdqE
 ftJRDGVeGdnnseNRvD0gRXXbQ9SVV2Q4/37CF5FHQGghim8okw4kKvRKDI0SDjTZe8EH
 231iAflHmldzl0I+ZsRz/nW4KHC7LEjmc0lNst+jnX/bvPOqHsNjD8Ny+rSWqSWLr8OJ
 rcP6vRRUD9ZNYo3C/YTRndcj4K8TrYaZqHV9NonOWFyCMTMGJkAeTELc7ZY55GFHjY82
 s/RLDz/0jaTCer2krg6jTYVFQSoF3mvRFSrGanyC3aKF3FaT+9CSHJ5vjhXcOCr2mAJT
 8PQg==
X-Gm-Message-State: AOJu0Yy+6iqjJGsiKmIEORO9QEZjRsRU2CsyoDCk0JyuVwDZc8ITWagC
 FULvNXtzzcgsYoT4toza3t7Bk2zKo1CgusQ60yMLudNQM5tAkt2ItgTjFrdAxd6XF28y1C8lu9A
 mf4g5zw==
X-Google-Smtp-Source: AGHT+IH/9Dp8Z1Sac2Yr9p4a+jsm9/N6dl9JPs8QUyX3ifdkcrtnyR/gryngCegtC/cNSVMnfLSNAg==
X-Received: by 2002:adf:e242:0:b0:371:8c19:f5e6 with SMTP id
 ffacd0b85a97d-378896a3e97mr11308085f8f.40.1726048732758; 
 Wed, 11 Sep 2024 02:58:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/15] net: fm: call dtsec_init_phy() only when it is
 defined
Date: Wed, 11 Sep 2024 11:58:18 +0200
Message-Id: <b7c378d570e12b0d619e291953deb2b333b16966.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

dtsec_init_phy() is defined only with MII so add the proper conditional
in the caller code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/fm/eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef07..63fe4b2d33c 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -26,7 +26,8 @@
 
 #include "fm.h"
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
+#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
+     !defined(CONFIG_BITBANGMII))
 
 #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
 			 TBIANA_FULL_DUPLEX)
@@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
+#if (CONFIG_IS_ENABLED(MII) || CONFIG_IS_ENABLED(CMD_MII)) && \
+	!CONFIG_IS_ENABLED(BITBANGMII)
 	if (fm_eth->type == FM_ETH_1G_E)
 		dtsec_init_phy(fm_eth);
+#endif
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO
-- 
2.40.1

