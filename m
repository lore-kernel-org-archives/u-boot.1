Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8B7CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3A183FCF;
	Fri, 10 Oct 2025 15:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S7vwxR/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F8784051; Fri, 10 Oct 2025 15:43:36 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6C883FCE
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f494764a2so1137839b6e.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760103813; x=1760708613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5srZpzrJlM9kPRkrGcwsHFr4QmGjKOgF2Qfh1oqHLA=;
 b=S7vwxR/LR+RjAnU0TK8pHV/9ll1ESJpQ8dNvfdo/DyE+Q5V+yJsuHkh1vY5SIfe/yU
 G8nE8p2Dh+Y7keYJNi8oBKVn6ra2BmXZRiG3qhjLKtJB986yWf3RRMxB53RJ7W5w4Jgh
 GC92XUQTRWpDMYGSnq0ERHpfUtVGAS68iLkY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103813; x=1760708613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n5srZpzrJlM9kPRkrGcwsHFr4QmGjKOgF2Qfh1oqHLA=;
 b=l+Tudf8Go/9/PJu8lt6mq8NGgwkH9hQl2txREkmIN5k4xKNK/Rku3cz0h0t/yAl5r8
 +UqUqVZF9taS3dJ5MrKxVRMjBTiPnEzvitZBdUYD8PBjHchxZE/wadM5nBSlvTkLXIzm
 VRF0VYRIUv2D5II9gjPBlVk9Sta94vVlbzY98XyFAkiHZHmd/IVfONwPnaipKdmU24Tc
 Yd7j0scTnBfmPppo+EWIA6iZ2jmXKT76i42r66YKyMr2SyOgerLIZ7Q0OQfWLj5pNiAu
 ATxDFbjEp8r9ckJChGBVR+4LsqFlUaSO+dSu9wHfrXjqiYwmsGfEeg1g8IbqY7K7xq4p
 c49Q==
X-Gm-Message-State: AOJu0YwnRfCed6rLXo1q1/WAf82JtvqI8Dkd/LqVkLzPLCgq8P/lVezM
 sg8p5jd5J/OrOaSCoN9JLMt9Dvb/noxEbDhJQSbWeBCi+JHbc12dcqkpW9y7ixAuxiFvnhkrrhj
 cAKMjd8w=
X-Gm-Gg: ASbGncs9TPc9U/jUfjRedhaqLWg+E+eAVLGI3qjTfPv3r1Wv8rOSOMo+VF/eVCaq11+
 LJEmcFy6+8FBkwr5iR6YZOwf4wh2O1+pQkBSoO7q4loUndUGMsVfiLS5FkOnbVBcVi6khxSTvAy
 gCZV4/uUM7HlKYtYUuP7NeAgdlHgAruIlUMvHnyMi74+I/NU7AQwQ1ym8nI4VtgeWObuARQ/kmp
 vbf1NFxZKzFtGRHFEuqsH/1eiur/ICvu7dab9E5xeQb3n5L1sSTAwBSA9blO4fG1g5BS3nrJZjf
 eMlsMptjmrv40Z6IOUAdn/JUEzA791IYdKE80lFtDzme8obJtFTso+Z/S5nL9LOyt2ZyFsBnbmz
 J0WDl9OT0+/xBCobi/Y3XB+xdE3tAV+G8zZ8rtN+eBRCFjQ7f0HtnC1rTWYXlYXhAnWUqgEIpOM
 irfwd5CJ4=
X-Google-Smtp-Source: AGHT+IE7Zgq0cZTz9I9MTI7eu9Td6BaJaQDBWXJPc6W1N7A0rIgDaiWHGg47w7kSfFP3ok/Np5hMUw==
X-Received: by 2002:a05:6808:198d:b0:43f:4b40:6a3b with SMTP id
 5614622812f47-4417b316e39mr5645339b6e.21.1760103812661; 
 Fri, 10 Oct 2025 06:43:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419893b2d3sm635223b6e.18.2025.10.10.06.43.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:43:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py: Update to a newer pytest release
Date: Fri, 10 Oct 2025 07:43:30 -0600
Message-ID: <20251010134330.1094378-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Our pytest package was pinned to a release from 2021.  The minimum
compatible with labgrid v25.0.x is pytest 7.0.0. Update to the final
release of the 7.x series to start with.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 804a427b3514..672a58ae3584 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,5 +1,5 @@
 filelock==3.0.12
 pycryptodomex==3.21.0
-pytest==6.2.5
+pytest==7.4.4
 pytest-xdist==2.5.0
 FATtools==1.0.42
-- 
2.43.0

