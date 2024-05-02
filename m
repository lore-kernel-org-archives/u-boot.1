Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FA0C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0075488BFE;
	Thu,  2 May 2024 03:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k8rbcC3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871A288C05; Thu,  2 May 2024 03:31:55 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F61A88BFB
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4349685c845so52775091cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613511; x=1715218311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Av2/bEDNnXRYDTOtUQUoB4DfpEzt6nUv5xTWwGvioYk=;
 b=k8rbcC3Hps4mKj+su4PPL8YveeoSFLHJcH++S+eWhtN7iK4p1KV/qGAMCOzAerd+7X
 fKBC9joQtS37tTBabznjMr0NcVZhreIhxmib6mNpW3WOGOhwZ6lFiGkM+ojaHL0rFca5
 bNwh7vFtaCIfdXcZ1p5Xomo3YUf6lyIztg9Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613511; x=1715218311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Av2/bEDNnXRYDTOtUQUoB4DfpEzt6nUv5xTWwGvioYk=;
 b=hj8PNWTlWzqjhT4YjSEhgrM/qI9Xl1v+hvNhjqbyvoSTDjyKrjZ4e54SYpsJWTht7F
 B+hFVEQ4ZkMQ6q4a5SChbahYvBcxnmxJULlVIzHaBQpoyqxQwFErRCMeoN2pS8ahoztw
 y54Of9Oyq9zCBT4pm3W0Ww/L8CPTqEEenvAsC9Tj1XuJ+7gqWCybR4FanRNkVMZCzQEH
 4zK81pH9lEqsrf9xfuZ7PI2ixejhvKnXqzMFM/qH3xaBkDvlVOZBodzujs5mi94dytmm
 4m2EHInn8+m36OX0Lr6Nblj2giCpct1Gd34hGC0Fn15LQwK4lX7gMy53iVXSAg9i/pu/
 2U5A==
X-Gm-Message-State: AOJu0Yyorlda8rDPbZLYtXiCj1VMw1bPzZ8jCOetAcEunGyEz3wQD0Ft
 jMy0SrQNy1ewZ7Ey/Y0GAyiKhileAakW0ae2V1D7eRL3KmVWqedeeGAic8D+ue1iaW54y4/E2b7
 OXfchIlTn
X-Google-Smtp-Source: AGHT+IHPvHZM13oF4WC8u2jszdJEee3P0qu+mhl6Sj79yEPQS+wopv8jfTVGmk8iZl3gLFc9M1iJJw==
X-Received: by 2002:ac8:5807:0:b0:43a:f7fb:9698 with SMTP id
 g7-20020ac85807000000b0043af7fb9698mr555252qtg.41.1714613510993; 
 Wed, 01 May 2024 18:31:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 09/81] include/linux/compat.h: Add <time.h>
Date: Wed,  1 May 2024 19:30:26 -0600
Message-Id: <20240502013138.2383421-9-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

As this file has macros which use get_timer() it must include <time.h>
to resolve this.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/linux/compat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f8e3570d1ad2..623814516175 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -5,6 +5,7 @@
 #include <cyclic.h>
 #include <log.h>
 #include <malloc.h>
+#include <time.h>
 
 #include <asm/processor.h>
 
-- 
2.34.1

