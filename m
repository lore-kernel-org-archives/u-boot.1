Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E68C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98EBF88A4F;
	Tue, 30 Apr 2024 15:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p2TQ20Jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0027E88A35; Tue, 30 Apr 2024 15:36:21 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A84D88A36
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-23d175cea45so297343fac.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484178; x=1715088978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vb/ZjiUpySf6Ym5xTOjkBStKbTQ98pxT9uGx4TB31jE=;
 b=p2TQ20JdaXoCDxPh00qBJapRZlleRkYtiFAhKCE4otyGHOMTMPH+d9qAoTvQBLlUUl
 Y+Q0PQj8BgHH0wJNQI5psgakObKPLHguDzoWVSr02qYwlXzTdl+qrI+hKZU9qDh+cX5+
 DB2S/cV7q6ZsMAISkUcghQtifC+fQdVATRSnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484178; x=1715088978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vb/ZjiUpySf6Ym5xTOjkBStKbTQ98pxT9uGx4TB31jE=;
 b=AFxE/3Cb4ZQzWfpIzsfXkxTA2FM7bnIp6cWfRU4zN8Cq0LiFu5Yb+FdQw/lxA0j14q
 v6XYV1KJIDt4NuZbNiTQ0i3dOlvlBSliSkCY3BJp8DlS/m0qmW+QC1CCDYj1dvecPoyU
 n7bJ6y06WYZlZqvZlySui8WqinpnJC4GDSWS1E1qbnbtgcF4l3N4Z+3JhPI3yNC0dcNQ
 b/nk0YYYtIbFxvhMTMNQLf58AYcRHGgaIzoCjiLFsGMAHFA7aG7GaTWzABv6Y+HbaIdM
 g5wAbFYEHel1lB6Whx+CGhtcWsMdCTzf4MJ4R762iSFnzdI6+fj2/PIjCAgMCBmjtj2o
 zNUQ==
X-Gm-Message-State: AOJu0Yw3UbZ/vW3xD3FBhU7wTRYf0LihN/bkjmJmU8aMxLr772GzheaB
 OXQXOhJ4QS8noyDqNveNY9HBMpTmaycXiWFKgnfE3wZXHS0Qb9Hc64+7CkQv6VHL33ZUuwFTAyb
 g8P5oqw==
X-Google-Smtp-Source: AGHT+IHBkOUWM6HKATf5+l5NdufUxyLsKqMPtbH8etzuNccn3lIQBOPZPL1kKKXI9Ner1Xbv58qkBQ==
X-Received: by 2002:a05:6870:d8c7:b0:23c:a69b:645b with SMTP id
 of7-20020a056870d8c700b0023ca69b645bmr6088574oac.14.1714484177994; 
 Tue, 30 Apr 2024 06:36:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 14/33] arm: octeontx2: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 07:35:40 -0600
Message-Id: <20240430133559.1836389-14-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-octeontx2 files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-octeontx2/clock.c | 1 -
 arch/arm/mach-octeontx2/cpu.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-octeontx2/clock.c b/arch/arm/mach-octeontx2/clock.c
index 9da21077ecdc..ffdee8799fb6 100644
--- a/arch/arm/mach-octeontx2/clock.c
+++ b/arch/arm/mach-octeontx2/clock.c
@@ -5,7 +5,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/board.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-octeontx2/cpu.c b/arch/arm/mach-octeontx2/cpu.c
index 723deef719b6..0a44af71a40d 100644
--- a/arch/arm/mach-octeontx2/cpu.c
+++ b/arch/arm/mach-octeontx2/cpu.c
@@ -5,7 +5,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-- 
2.34.1

