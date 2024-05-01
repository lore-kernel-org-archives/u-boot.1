Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B952C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B1B88C13;
	Wed,  1 May 2024 04:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="njSToXT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE05788C09; Wed,  1 May 2024 04:45:11 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A686F88BF9
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a0406438b5so26618596d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531508; x=1715136308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6ZmeDc9I0gsMBZgPZvI9fGgwvipY8SHxLZfEhNd2yU=;
 b=njSToXT9dEaT8I3GEi7+4MVkOc0jDDx61XKuoHzl/j+bgXFyt6dbQ9AjT373rEZbus
 +CbTnnzF9XCtQ2sTrJd1EKRsiEu7vmUptR9WQqIuNFGvu2YWZ94iQj57hBi3xL/Ux3wD
 aCeqoyyjQjRLFY6gKozX3PFeQGxKBVYvxD2f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531508; x=1715136308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6ZmeDc9I0gsMBZgPZvI9fGgwvipY8SHxLZfEhNd2yU=;
 b=VROrfH8Tu9sv1/yI9fhBiyEqTNwV+tPZOx0rOBCSY4ZMl+OxM2wRfsHEuNdDQPePoL
 UVWgUqivSAV4brSMlaB4lGNu/od/he1r6qVgRxsrf9VfswuEVl7TY0tBnfK5/CFgLkgD
 XvG+A3XRfgVut+HgPEcaZwulua1qhA1q6De30VXJdjUmZOsJ6MipBl00CLVU6B86x0Hq
 QT1+ikA9e94ZdD6TN8QthuhQnjwRtREomXeVE8odzuRWqP3hYPQNlgRM/dMjHBtDKqtZ
 NrqnVhqZckyH11if1tZTC5yEkpg5CHWsIFdGZygCBp5nbi70MZr4aS/oHRRSgoayBNwy
 kPsg==
X-Gm-Message-State: AOJu0YwLfHHhBVfQ24o7UUGjL9JpoQ6iomO4UCs++nnRGGGl4Q5yY66g
 l5R9vCI1vt+xc0dE7KZNvFLOYKWfEUx9+hRoT0XD/Ga6Q66xoQv72uAxSUiGVW5IGdf/Z59Prpj
 2Pi1UpUf4
X-Google-Smtp-Source: AGHT+IEJRlEYCJlTV61OKNTvKDrIm9/BoaGKzKPK+RoWgEZGyrvztv24CAJaJKi4n3S+wDgoQ2K06A==
X-Received: by 2002:a05:6214:21ea:b0:6a0:b4fd:c7af with SMTP id
 p10-20020a05621421ea00b006a0b4fdc7afmr1182359qvj.32.1714531508165; 
 Tue, 30 Apr 2024 19:45:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH 095/149] board: myir: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:22 -0600
Message-Id: <20240501024316.1767971-95-trini@konsulko.com>
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
Cc: Parthiban Nallathambi <parthiban@linumiz.com>
---
 board/myir/mys_6ulx/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/myir/mys_6ulx/spl.c b/board/myir/mys_6ulx/spl.c
index 3cf14e2bc660..4414487eff24 100644
--- a/board/myir/mys_6ulx/spl.c
+++ b/board/myir/mys_6ulx/spl.c
@@ -4,7 +4,7 @@
  * Author: Parthiban Nallathambi <parthiban@linumiz.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

