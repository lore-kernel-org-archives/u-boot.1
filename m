Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419A7C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94ABF88B02;
	Wed,  1 May 2024 04:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XY+zir/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3E888AF5; Wed,  1 May 2024 04:43:54 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF1588AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-790f699eb2cso258577385a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531431; x=1715136231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wP4p/DXepSSzNAtOcZakYemle/fX4H8rIcnRQ1Tw7uw=;
 b=XY+zir/EuQBFXgEm8HhONCkE8Uz14eQYRpYpfoC9/MiayNbEf/QoSlDFJ6orOXi5/U
 E9RS/iz7w+5NYxglfe1diuXKEFESI2sO00bBE2U1IBqUBNRO3uNDSAPvLb7OYBpbSFME
 PyCXFsX2f3M8X1EVtjiphoZFFPQlLAFdYpWhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531431; x=1715136231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wP4p/DXepSSzNAtOcZakYemle/fX4H8rIcnRQ1Tw7uw=;
 b=jY+qmUqL9+nr6xXptrwgBk4utJAriRfJ2olJ8aGfgYnozzC5L6OEqpub+gxhHc4nMI
 Gtl7PIginKJjVTvRm4TjUBymINOINbnTKGk5ce0Z5zLYMXjzhdbB9br1wA/djtxPZlly
 nCzH9ph3vWRG/LdePSNyPMaAk0uJn0W3oMmuAg2yp/yZjdfoI9lY7W3cvaNv7caTZ+vz
 NrtrrYBgmIMRp4bPLBYXCz/0gMHoreSdCjBQMFwOj8WrRn2EpFqU2ZKiBPwoNI5lCn+p
 1lo0qm9/1audHmbmnrk80UmXrIe3ObBaeGO2ZEssxnIAvTMTe6Fb0TbPLbmRzVuUoA1X
 P0NQ==
X-Gm-Message-State: AOJu0YxDR+GZQXHiaPpqV9FcHvNd9daP+gyM5JIkz0KA89aScUjP7WTh
 ErFKXLOlec9PQ1fa7gjIlnbbslV90Pn7QgEblXerAwnp/aosZarqeq1OutrHHDjOJZb+aQvao3h
 FTKT6OA==
X-Google-Smtp-Source: AGHT+IHZ8MM2LaAjJQzK//3vTnU84baQT3fC4ZRcMxhjBudlLbaDLr1dDI4060/RZJy5zHJp+EcaoQ==
X-Received: by 2002:ad4:5ca5:0:b0:6a0:cd65:599e with SMTP id
 q5-20020ad45ca5000000b006a0cd65599emr1088174qvh.22.1714531431149; 
 Tue, 30 Apr 2024 19:43:51 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 028/149] board: boundary: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:15 -0600
Message-Id: <20240501024316.1767971-28-trini@konsulko.com>
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
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
---
 board/boundary/nitrogen6x/nitrogen6x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/boundary/nitrogen6x/nitrogen6x.c b/board/boundary/nitrogen6x/nitrogen6x.c
index 382c01ddf4e0..2b0cb2361c40 100644
--- a/board/boundary/nitrogen6x/nitrogen6x.c
+++ b/board/boundary/nitrogen6x/nitrogen6x.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2013, Boundary Devices <info@boundarydevices.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <init.h>
-- 
2.34.1

