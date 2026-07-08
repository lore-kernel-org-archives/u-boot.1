Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD57C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 14:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2768849BA;
	Wed,  8 Jul 2026 16:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qtM4L2PZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299A1849BA; Wed,  8 Jul 2026 16:33:43 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108CF84994
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 16:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-51c05dcdf49so6783011cf.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783521221; x=1784126021; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n2+BP98IZPdvV8O2sY1ThMxTi7VbW/U5mJMRUBA4UhE=;
 b=qtM4L2PZeWhN3+I4/kz40jqdhIFBM35a+ybFYdx722pWDlO3qf1o0ysAE8XxNQmZ9G
 g/lrbeU+DhVjq0jWTD0s1RnHjSlUNx4aZnMu9X+7Hb7+yvn3rMXzOzHPQ4jOuOG1vgMc
 LjHNsQ2ZM02kH2c0RxVaKpKB+c+586EsKSAT+JJOsp2w3ou7Sl+GW9+sxfDzxrOGl2Eb
 8EIdYb67SynALyk1AicA92GLc1dNUhnBnYyYHHbe7N7qqKMCYaBzNqaj39R0kK3py9Gc
 VSxzLLnZ1jhqS0+JMLC+Y/nTqa+Yf1HXsL79MEqeOiJxXr84hWPPe3BQ97n03tRaaC13
 Y2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521221; x=1784126021;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n2+BP98IZPdvV8O2sY1ThMxTi7VbW/U5mJMRUBA4UhE=;
 b=A6LEwEGlTwahX4sthN8n78fBPCYJeNWDoxa5e35nL3WjaP6QkLMlOeG0BNCZqoLevT
 HZLKSF9z6z1DMIVVbiuccY9N0tOxJRTIJX+Z6d2QocVCQS5lvnyZ1TftEwf2WCBl/pi6
 wRGPVEt5Jog8eTz5kN9DRJ6ffWbaWsfWSrkoya5UkAGkkZSdi0nQ4ctG0J5UXJhQ2mFF
 B8gwitCX0WfYBcFouIn0l34gjlVRZJLhq/hCOITlAsU4ObXBJFEZGrURJKIJzYSVuK18
 mHM59zLa5oZDa3DOwIcPDuik4MQwxhLy23riRMsgtGtpXIpN5RVezJmzuYTe0EFmspvw
 uccg==
X-Gm-Message-State: AOJu0Yx9vfX1sKjcYYsc4Sasm6b9GneZskeXJ+uA1/jp0dKb00Xd4ltX
 AXcEI/qAD1lMs6jbw8/haF4Mc47wEA67eF2NUF7JsWYb6tJZ9GEirzRl
X-Gm-Gg: AfdE7cnarZJwg93NBjvzaVcK4CSPXeSl2adh0JA6gytjqXP12SkKL5TICfOYRG6O0Ci
 95Xn8rlP06LRgPDLtqljDu0BDZXoZPGQGjp0xzC56etFU+zzkiHKXR/dHQxVgupafSt27FB0xLg
 JMWknNzSOZpl7qzX6JD99VSGv8d0zX4cbQn3EuT1vwZi0bbEqwHn5/1kcwDcUUZZmAGvYzv7/7s
 lUcy3bx86B9jC7Nf4JYIj4JiICcVi2yyCRSOv1McexUgsJKQ1Q5jdrHpcovZEr1j7kYhIdOLbzM
 e4Q5vEgU4wyCjZKIW1MoGPQBfnJ8AV/B6WkqKIUU6YH3zRBIhWHdhAghuYcrv825nEjQd3z/ZVd
 kBC80Y2ytQJ7h94FKCG0DrMnVh78ZYsPPejeCq/GQDp4REcahf4U3CUHsUjRs2g3s8qaTqA4RfP
 aponwC/RxgIw==
X-Received: by 2002:a05:622a:1a8c:b0:51a:1651:b796 with SMTP id
 d75a77b69052e-51c8b2e41ccmr29653551cf.29.1783521220719; 
 Wed, 08 Jul 2026 07:33:40 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41b55495sm144176601cf.11.2026.07.08.07.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:33:40 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:03:37 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: setexpr: reject division and modulo by zero
Message-ID: <g7sabrrsecusu7p35zh7rjgksvxqtghrqnks2tshw4h3ft2cuk@x3fqhhdmwm2r>
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

The '/' and '%' arms of the operator switch in do_setexpr() perform
a / b and a % b directly on the user-supplied ulongs with no check
that b is non-zero. The consequences are architecture-dependent:

  - On x86 and sandbox, integer divide-by-zero raises an exception
    (#DE / SIGFPE) which aborts the shell.
  - On arm64, arm, and RISC-V, the UDIV/SDIV instructions are defined
    to return 0 on a zero divisor and do not trap, so 'setexpr x 10
    / 0' silently succeeds and stores 0 into the environment
    variable, which is a plausible-looking but garbage result.

Neither behaviour is acceptable for a scripting primitive. Check b
before dividing and print a clear error, returning failure so
scripts can detect it.

++++++ Before Fix ++++++++
=> setexpr x 0xa / 0
=> printenv x
x=0

++++++ After Fix +++++++++
=> setexpr x 0xa / 0
Error: division by zero
=> setexpr x 0xa % 0
Error: modulo by zero
=>
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/setexpr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index c45fa85c887..38a7fbeb86c 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -517,9 +517,17 @@ static int do_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
 			value = a * b;
 			break;
 		case '/':
+			if (b == 0) {
+				printf("Error: division by zero\n");
+				return 1;
+			}
 			value = a / b;
 			break;
 		case '%':
+			if (b == 0) {
+				printf("Error: modulo by zero\n");
+				return 1;
+			}
 			value = a % b;
 			break;
 		default:
-- 
2.43.0

