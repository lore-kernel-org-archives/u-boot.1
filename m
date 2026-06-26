Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A811CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 03:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5D984974;
	Fri, 26 Jun 2026 05:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UAY7tIV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105198497A; Fri, 26 Jun 2026 05:45:49 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31298496E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-37de8008910so252606a91.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782445545; x=1783050345; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IPujUm2t6qYm9Y+NbCS7Wx3BvBwMT78r/FaXoAucW1Y=;
 b=UAY7tIV6xZTZd/ANX98M+Bm0wYYOP4oYlCPiuyMaHsLFW4j4E1wwQmpHPwKTbA0D1y
 FfaxLq3Jhw6V3GSvSPSVh44nu0Es3d+Dh897pp3tP0X70zKGnGi0anVz1kB5RslpRWRo
 9s9hzO1KCHy15eCQ1uDKrRmAKM9Q1jsl4KraSQi6YqQ2fr85dZvkMHPTJA2ZW+b15D/h
 hRr2F5Huqubw5jfu+dqoEiXUPIp3KBRB1ZHlHiRehKSRQUFKee3Ik0RcMGFHqfXthGa5
 RBMB1vixRI5/2ws0O9aYYiyMt6ROCHPDz1YH2IKcgrsIt8vlvwvBWmnhPaRJce7VmBjv
 4mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782445545; x=1783050345;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPujUm2t6qYm9Y+NbCS7Wx3BvBwMT78r/FaXoAucW1Y=;
 b=Ux1LJ+4IxsAa2PrkIIdWFIaxJwRGCp5N81I76o0lAYKAXcFY7pm1NGy/Z6qt7eb1T8
 UM8ArX45DRdNA/EY/VfmPLtuxfVqQuTOKXgLCye5teK9biFYmLH8jcr5snb1vscFrBqg
 pIYoXowvDXmqDRMgQYJVm7qhuW0E2SfSDwBtfuQ0LPOd5bJKg1zqOg3H52wgb8r0fcw6
 v6Tlsy2EGJld7BqNaaydEP+VARKdJi/Whd8o0F6cb5f/pOWcCoxQZbWonxTLqVKSEQMJ
 MLhVOS/uNUwgTputyW2sxajMCTw1tQC3hJRpPxDpsux7DvyN47S+FeYdUEuiZolhENai
 e0UQ==
X-Gm-Message-State: AOJu0YygAqx5atfW38RIhZuLY+z40weEi5Eiro28zpvZYAkyAyd4L95B
 Zop5eQMD8VI0ExuBoD7TqAojJjlU+9ov68BOh/99K3gAMr2y+Ty9HI6yvoGsUjVw
X-Gm-Gg: AfdE7ck3aIwIsbeidzUgMAmOmzw6PqDDxwXPLlTHjVPR3MJ/73D0rx6T2DXib9xgxKR
 4uEBr/fHTtQmh3ed3L2DV+0JeL9baFXJp/eozJZw1lBwlVBIfOU3dwXWtjRZDWPatTvytFKzxFA
 HcdMyjlN7LNpsH4ueKZcBFBk4Yw0Dmus8dH/s0A+SS5NuJWbmkmeymCUQiKydU7bKvQml0J8l2Y
 ui1LQMkB570RxwOJqMhEIUxCn/WLPQw+3RPxYNg13pXLjOQM7ykaI/R8byt1kiOLzjDZnppP4Bx
 0c9T5hGDRAwPUI9g6wnAOXqwaAgPh4TOyxF6FzCbbe024WcPFHDxtvrrY3jUpRGUK5ijakKoEkQ
 qKjs5MJjFvURjDUrjEakSpejOfSo/KmNUNIwN631s1Znyl5AjinFQTx2xmmjrCTlKcvGiMoOohi
 vSGXtdcgRACvJM4A==
X-Received: by 2002:a17:903:19e7:b0:2bf:23c3:34ba with SMTP id
 d9443c01a7336-2c7fc7948aemr53388455ad.28.1782445545202; 
 Thu, 25 Jun 2026 20:45:45 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f63b24a2sm31516775ad.50.2026.06.25.20.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:45:44 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:15:42 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com, john@harmon.hk
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: clone: report destination block number on dest write
 error
Message-ID: <mpptnmlat2m7k64ny3sxdv3uw7rjysmn6bh5e4f24rut4g4maz@w2jsuzudjwev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The error path of the destination blk_dwrite() prints srcblk, which
refers to the source device's block counter and is unrelated to the
write that just failed. This produces misleading diagnostics that
point at the wrong block on the wrong device when a clone aborts on
a write error.

Print destblk so the message identifies the block that actually
failed, mirroring the existing "Src read error @blk %ld" message
above which correctly uses srcblk.

Fixes: 4a4830cf915 ("cmd: add clone command")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/clone.c b/cmd/clone.c
index 1f3cff1836d..371f06d917a 100644
--- a/cmd/clone.c
+++ b/cmd/clone.c
@@ -97,7 +97,7 @@ read:
 write:
 		ret = blk_dwrite(destdesc, destblk, towrite, buf + offset);
 		if (ret < 0) {
-			printf("Dest write error @blk %ld\n", srcblk);
+			printf("Dest write error @blk %ld\n", destblk);
 			goto exit;
 		}
 		wrcnt += ret * destbz;
-- 
2.43.0

