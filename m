Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF8CC19F53
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A9E88B40;
	Wed,  1 May 2024 04:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ct4hPera";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C8188B39; Wed,  1 May 2024 04:44:15 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 831E188AFA
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7f169d3ef53so588698241.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531452; x=1715136252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJpoW6gLLcYN2mVpGkr6uum3vkdVcbFJk5lEK9Onqso=;
 b=Ct4hPeraUCaQKmcFeG9E5zG2YAUSM9EexTcvoL/xg5OOEbe+WeTGGF9dLqPjgDSyYh
 zkqku8u74ITd1cpQYuWPSoAEbOSxCRVa6SF71KjD4pYtSv6llQsgkMcOVkkf8c1QeIC9
 Zyd5Ng4mry9jWMsU+bCc2RAAIVUnQwuB/gjNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531452; x=1715136252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJpoW6gLLcYN2mVpGkr6uum3vkdVcbFJk5lEK9Onqso=;
 b=OeUxIICJzp4OIz9QUbPAdj5o88sVnpIpuTWcwf0bN16f1ciN2n8/ssCL+bEUUaxZr6
 PucSa9f02kaGs/9dwnBxiHQ8aOGTchUtdp2m+mKHkw+seUP4Y4wNlW3rVgpHsWa39Toa
 4SVAtiHyAhMBun9ghz6qW28H9H36JC9Nskh5TckBOT31vlBuv9OFnfs2i1LhkMXglxu9
 HMv6vQxc+uoQDHNF3YhzBfk2T+hoLcvvnweaemMRlJcrS/BQoDhhf21ddfr8NZa9BAcN
 jsi8HrfTRGwzDOdZfryDzr9VQjskc/x9XHA0kfIATpPkeK/z+Awdvuk1v/WZzAdXqtPL
 qEFA==
X-Gm-Message-State: AOJu0YyM8QT+Xw22aazdw5GxWhSN1/rlZulaABrj7M5QVi79Ia/8Qe3Z
 tDAW9nEym9SWAdNEYRj55Vrugx3BoS9uKxwlD8rnu7t1u4CvEwiTMnXwyo5AOGptVr/gDHkKhUQ
 +lhe7pw==
X-Google-Smtp-Source: AGHT+IH40x4hroBDcz2dXmBwB0n8NcT0lohnr7DTD9PriAS344+JLq4I/QX4noplXLvuWyxgc6zwEA==
X-Received: by 2002:a67:c50b:0:b0:47b:bfbd:1577 with SMTP id
 e11-20020a67c50b000000b0047bbfbd1577mr1889397vsk.5.1714531452085; 
 Tue, 30 Apr 2024 19:44:12 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>
Subject: [PATCH 046/149] board: d-link: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:33 -0600
Message-Id: <20240501024316.1767971-46-trini@konsulko.com>
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
Cc: Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>
---
 board/d-link/dns325/dns325.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/d-link/dns325/dns325.c b/board/d-link/dns325/dns325.c
index 8ebfe4c60189..3bbde9808d20 100644
--- a/board/d-link/dns325/dns325.c
+++ b/board/d-link/dns325/dns325.c
@@ -9,7 +9,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <miiphy.h>
-- 
2.34.1

