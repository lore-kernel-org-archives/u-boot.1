Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94C8C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18CB48171B;
	Wed,  2 Apr 2025 00:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecAfTaMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D5F82045; Wed,  2 Apr 2025 00:52:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7698A8209C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso44360595e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547967; x=1744152767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wV0Md3YNik26+zOgG2dX/kL4pu5J0Pp6WJbfijQZQSw=;
 b=ecAfTaMJzG3AnzNjJgLvz1Dm86uD5Nl+GDzqY/CIsLQG3WoomwNPFreHmamPJUjo7o
 pASSoQUbkKLf8D9aShdxje+z7MS4bi8rfKJdu9j1BmfUFPqIdc9BpICX/JLSJ0H+QvWl
 U61etooWhHr6uPiJgR0kdkrD932fqxhK3CsclupdyS1QBeP5Soa9t9HSgmMu/Xl9XxP3
 bwyyH6pcd4oKcSsUqu/TDI24pRvGJYMVp1unQqcm3FrRdGetXqyLIHZT+3Iok0Mw+olw
 BTBVW9Z+PfZRpX2tTnnXRaJIU4oRCUVuhiWR3ZxHlKSrivcoqI53fMi3JltXoy3tDBox
 nZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547967; x=1744152767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wV0Md3YNik26+zOgG2dX/kL4pu5J0Pp6WJbfijQZQSw=;
 b=WBld8yhhwg14OjfZktPkB9ad5uPywrkhoyo9YFiwFv6wUp22yTg18iS0MxtD66XKBf
 iFORAaPcyphGpVmYxnhqR8qky4Qa2JDxJbK0MOl1LXlkN1U7CPB5q30IPe/hKqkAiFfQ
 6NTEqb2J/BHwGryoP9mn+Ey5PU/YUt66WiWKW21WEZt/wy3Z0wk9P1wQah2FYboqI4pF
 Q12q29Mh71FX4lEv/fg1ZF0hEc+xPuf3f7KUR8k1CJ+iQb/cBaMrrhoXHdFloG8BPA2i
 mW1uzqjexFJqasukRgcJiQAmnfM57QqdnwOHk43aZJgFa8YIuXWjH2z4MTIJCL10Afs3
 ibjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTPYOlvNrNqjo3JZHAJ39xvis9Dmi4oX9JgB38TXQuPfs1dO/OnpdiJbvHwMOiJj8K4wzR/hA=@lists.denx.de
X-Gm-Message-State: AOJu0YzxIFzB6eXiNzJivKLNjz2SascVhoXjieEq+27cprFysrxibwa5
 WsMiMSpN3ooHrhg8QKobX9RYRjzUbJdH2NABEQtXbg00c8aYFyN/
X-Gm-Gg: ASbGncssME7iqTABr+0mny/d9Hw6T7rhyq2+ecVwdKeMq/jcfXQH5fV3Z7Nfrv+F4xu
 yqAGxdOJ/J2g6ftS71UYSfNDTnaE8RJ9qJ+OJ/BB29l1Wl6756K8r7LJXVL/vQYoMbHeBPM8BLa
 YBG5OxVzNCjRcSHiXnTv3nXToDTxawIxAQOcW2qKk1nJyLNkGB7XluDlbfITYwNU8GevcGRaYF6
 iVyEvHhhP4oz5mX8NPHQcc1zxa6HMTPNKKM4Zjaw5JUC2raFHApoEKHN7WowflcAippNOH9vu+C
 dc9CjlIKjn2bmidHKJ/bid++J6bBzKMZ5fTt6IppcntS3+DFk/nTGIIA6S0Fuek14reLSpzc/9U
 mRnn1SVKXY8Etrp9RKbxcb34Z
X-Google-Smtp-Source: AGHT+IHIlAg3vc1Qa0yfge/YUC+COYUDH12x/i3c1QV5XHoVlNeivbp+snnVJGBxvy9QrJJIlR2CMA==
X-Received: by 2002:a05:600c:8119:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-43e7a5426dbmr118845815e9.13.1743547966914; 
 Tue, 01 Apr 2025 15:52:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 09/14] spi: drop unneeded spi.h header include from spinand.h
Date: Wed,  2 Apr 2025 00:51:41 +0200
Message-ID: <20250401225156.25790-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Drop unneeded spi.h header include from spinand.h, nothing included by
spi.h is actually used in this header and .c should correctly included
spi.h if actually needed.

Replace spi.h with linux/bitops.h as this is what is actually required
for spinand.h

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/mtd/spinand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 13b5a52f8b9..6fe6fd520a4 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -17,7 +17,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #else
-#include <spi.h>
+#include <linux/bitops.h>
 #include <spi-mem.h>
 #include <linux/mtd/nand.h>
 #endif
-- 
2.48.1

