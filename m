Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB118C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00AA88CD9;
	Wed,  1 May 2024 04:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RQq/aYTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2184488CF4; Wed,  1 May 2024 04:46:07 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139FA88CC5
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b44071a07so60782826d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531564; x=1715136364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zk3rmbTwYo6+DVAz2teYiEDRrKT1TmSJ1Kz04TryhoE=;
 b=RQq/aYTV0DY3jV20x+BQVcmrD0Eu5VkbJB4g270or5k+5BMPn2/N4bUmImXfem4oyI
 gPKw6e8FkrLTA6Mze4AZ77DX5JruB8CSjbFsVFxrHlI+YWp+9eT1c8RshQ67OWBRNnme
 JulVlkdxHK5tC6E64vxSRPY7KhD94SIKAqerY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531564; x=1715136364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zk3rmbTwYo6+DVAz2teYiEDRrKT1TmSJ1Kz04TryhoE=;
 b=mCaVvpRdoyNHzbdXd8PKs+nEaQqPbKLjcjuZBPa1b9QK5ttITVIjJETkb28qo5eL/q
 h3qHIkZr9Ow+8WEZh30wTQnMq0upGijihgMtVZbxsmT8HX1MybhXOxSWZTleRWk2iPUy
 YAvBr/17Vqc5CvllOJ616c77b/lBUh3mhKr4PFNo93Nmtw4zlUsCXdB7FJ04llHvJlJE
 uB17VwYvVMwy5UyWSzaMa6Gz4Nu9zlPpqpJpRR3szqhT3cx8KccZkMCh+3C+I5fu4cFI
 8oivp5aEH7iNmMfXtndWqJZIODknkbvhmQLqHorOItAV+/3Psfhx6BowBhINjxHNWqFF
 hKoQ==
X-Gm-Message-State: AOJu0Yyp7z5bjRoiOH8CSNCebHlHGty/LpmveAFMUX8KuVLHEhKbZKzj
 pJpzV99NOWTriUgi9Iiiqhtzn30AFMiIIDxLzgC0DmpY6AWebSnBXHgpI0Pd9V/gr2p0fHhcp+v
 rULf1cTj+
X-Google-Smtp-Source: AGHT+IEdzfP2a1fusJ68eookFlK5SB/Gvk+GvqXuq4h57glbUXzXZ178fZHiOQIYvajsf1l16Mm/5w==
X-Received: by 2002:a05:6214:2584:b0:6a0:c990:26d5 with SMTP id
 fq4-20020a056214258400b006a0c99026d5mr1208831qvb.44.1714531563828; 
 Tue, 30 Apr 2024 19:46:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:46:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 147/149] board: xen: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:43:14 -0600
Message-Id: <20240501024316.1767971-147-trini@konsulko.com>
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
Cc: Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 board/xen/xenguest_arm64/xenguest_arm64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/xen/xenguest_arm64/xenguest_arm64.c b/board/xen/xenguest_arm64/xenguest_arm64.c
index 1d2946f4fde8..4c3b9c9e2780 100644
--- a/board/xen/xenguest_arm64/xenguest_arm64.c
+++ b/board/xen/xenguest_arm64/xenguest_arm64.c
@@ -7,7 +7,6 @@
  * (C) 2020 EPAM Systems Inc
  */
 
-#include <common.h>
 #include <log.h>
 #include <cpu_func.h>
 #include <dm.h>
-- 
2.34.1

