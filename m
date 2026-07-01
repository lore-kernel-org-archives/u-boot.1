Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB93FC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D04184C19;
	Wed,  1 Jul 2026 19:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GVOu7Ek4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58A784C23; Wed,  1 Jul 2026 19:18:34 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B405984BE0
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44caeb973b3so398978fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782926311; x=1783531111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k6KkE3bGV4bCS7iYn6ClZF+XZu7l/fRkz+KgFJc3coA=;
 b=GVOu7Ek4lES7KlooeGMwEDVg6YXat+uacSB9Hbfzhm8ZHZ7mm1h8f3ZMPlm/8r0D8i
 l7GSePzCmJlcT/h1TgtAthVSkUXwc+cgsBLHlW2un+T9RynQ5SN6G+l8AmNEOk8s60Uh
 QkpJVVtIqf+DubkGjHVoEcrolCGiTafHYSi30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926311; x=1783531111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6KkE3bGV4bCS7iYn6ClZF+XZu7l/fRkz+KgFJc3coA=;
 b=LvmAuYH/+aaw0MIU5VHWTLI2QktPgO11lQU/2KC3UnPufvKeIhCcG9ZMJWtJKHFPir
 UA80MZ0hNKHsenLU+P0HRHf+RzmEjoGeWb+8vrKXWiLPaF2ch7Lb7ISPPn0HoKZbpTEV
 8ljQzAW5ANIXwaVKFknP9y7ewfSvDbdGMxBuqGF576MGKT/9LPVk1e//7U5x85TOl/yD
 SICjHsn4k3RjrWgrsOL3rdNbdemlibSirAKCuRz8E3FkuCxw6Mw/ppnqWiPheXojxmAN
 JkpF10bDZS/rqjdZD76gP1ffCUgiO0ybPEoQp81oGoGEOqm+M1s+7xT1Ib67KT3LGkAp
 66dA==
X-Gm-Message-State: AOJu0YxBmj41zWLPsH8JMbvRe6p8UDRqG/x/TbFf47U/sYCSfkKjt5EZ
 C/qz4nGH+68PRzmkBet6TnGzknemkDEy3eUQtOcqPdEnjZQQqLCuzA0snQEg40b8sXyb8qiw9r9
 6BPkGMHdybg==
X-Gm-Gg: AfdE7ckXLRG8dAYCKIrqeo6wifxQ4cTVWmQ2qlqL8Q/vEPKlQqsmlrMBpDq3BVBXXTW
 PMlUwVytJpOKM7jmt3SxCYolcEv1C14VXhYvv8HzxjQGHHfI/D3utJUucKxJCJEzRpMxqHdZ9hf
 oWr6ZkOHFbbBLn4vDuyOvrDEkX6ZBgYXDrz0QlJt80/gdxHNnV6kXqhlS19p5iE1CEqpjrzJ/Td
 lL2H+kNXRznotZIZQcVeFvFyb/9ZgZZrtL/iYVbO1Di5VrtJJmvciGOynJnGTXyUIvoAJv1kWgs
 hna0a/KBb96s6hTMkLw5GusHxxcts/6j53gPsBPzDuDL+wiQPto9cm2Ue5GU7NtpvWT4A3cInb0
 tr3HOPvNIzqDwT2tj66qmhhrxqP+772Bz0b3ZLyouehGmAvab/cay6jBoGRcXxgvB9V5F6Xn4j4
 +5Qvjdze3bCj8xljEe2R3J/0uF+2MKKSW4v0NxFOpWcIFVDVtrRR/9liwpK8vyyf8yvpnhfv2i0
 Oiiasx9J/N0lFKxPurHr31ej8AViYjzjpVwsOUkR6Xwu8NMJqz+1oVioR2lUw==
X-Received: by 2002:a05:6871:6c0d:b0:44b:3fef:5c77 with SMTP id
 586e51a60fabf-44cab55b411mr1484036fac.9.1782926311360; 
 Wed, 01 Jul 2026 10:18:31 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe841750sm330161fac.3.2026.07.01.10.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:18:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH] MAINTAINERS: Remove merge garbage
Date: Wed,  1 Jul 2026 11:18:29 -0600
Message-ID: <20260701171829.2576414-1-trini@konsulko.com>
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

When I merged the changes in commit 0d8e33717d7e ("Merge patch series
"arm: aspeed: add initial AST2700 SoC support"") I didn't fully remove
the before/after changes. Finish this merge now.

Reported-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9abc4bcbfd9b..f4eb2c13a43f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -232,15 +232,6 @@ F:	arch/arm/mach-axiado/
 F:	board/axiado/scm3005/
 F:	configs/ax3005_scm3005_defconfig
 F:	include/configs/ax3005-scm3005.h
-=======
-F:	drivers/pinctrl/aspeed/
-F:	drivers/pwm/pwm-aspeed.c
-F:	drivers/ram/aspeed/
-F:	drivers/reset/reset-ast*.c
-F:	drivers/watchdog/ast_wdt.c
-N:	aspeed
-N:	ast2700
->>>>>>> 4a72fd9fb09109857303ca64fd259009e1d4b554
 
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
-- 
2.43.0

