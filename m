Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA92CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B31784694;
	Thu, 14 May 2026 19:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hssf/bKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6497B846B4; Thu, 14 May 2026 19:55:09 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6EE8467C
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-47c941f6bdcso5307803b6e.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781304; x=1779386104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLA0FvnyNLUAk3hjfoxfdg3NIkR+6JYfK08jQgr2Tu0=;
 b=hssf/bKYQVYwZZj0tMEKcizlDpxIYZU2zYr/Ow0uqQ1zvEZFIXp0p1phtWjSdVQu0W
 ZGXu1zHRWJYLiGoDASMSrB+zQksmMaDqDuI/OTjzFFkxUfd/OnSULvuFSom3oM2587dI
 JAovFdFYnDereCcODOL2ZjvqBghqaextgdEE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781304; x=1779386104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oLA0FvnyNLUAk3hjfoxfdg3NIkR+6JYfK08jQgr2Tu0=;
 b=b/WRf18j3bZqMpyRt+9vWf5KskFU9+9yW8Cnc5C4yclNf7ky74hfaIOGTXaeZ7t4mu
 1mPdt5ishZK0REYp/zBiBi+yYlMMF5wLXbZ/AWPpekOlZjL2mpbYzqwIM7tp8WMOvXW0
 CYW1jodn0GGQIKDfujaVZJzwZBypN1Iu5mM3RO2Mv3vllBQxEi7BgKetxCqTLgAimRjO
 +Q0m3Xi9wInfk2bHPi18kBGG6BJYgYECzMKMhTZIylb9G9pSKb40KVMbpBfjpM3GSgOw
 8jRvwDv7nt+V3OcmdvZV1acP5YueoqnNmUq4FNzbSh6Rs7mfPhiYO2jdkBZiyKB2CgdI
 zXRg==
X-Gm-Message-State: AOJu0YzIQ0mkN+zCV/7lNQL4ZSUJvGLpJeu5ejchj43gsXAWoKCBhE7o
 tUoicjXzjlbZwAa7XtUUWqDFWFKfUn6n4Aj6qj9pRG/LLCM8Mt4hdH+mt3fA6go4fzLNkD8rW5X
 VELNLsiCDz1pT
X-Gm-Gg: Acq92OEtGgXJJb8Hp//IV4uv/KxLgMMmkiowR/Ewtlg3MEnZW4tY9LEDoZNSw1hQjqT
 EJ4baXsuvFXqnpPctZaasctlG6JSBDDPWPsXZWYs0268ca7Iax/xqJ+kpDofCVAc4ym6R/HhgUp
 1Yw4Z5IxuHwd7r7PJV4enlilZaYKe3ZL68xHF1Uqkr4umHQC85OJqGzsKuJh7RRJOaam+moBO/+
 VdV5iAeQceVlYOAyGzfwcjQn7oEKwUf8vorvVWJa2KD4Yb1Ed3skFdPwuh4fpRQkeY8MAdZH8gs
 Aa+Rb5f3Up9hCaHnwLg1TbHNreNyjA5TBI875dRqDHLmkcieRcJZ4NuOVE3koXKCBzKsvuhR//B
 Usep0EOPeZqc+jskIdZ1/cxo+84dNyPIfECe60bkpWRTqetLO3nuBaAu1Rsrj0V5DipJp1QgK+1
 xLcTDjadeAWiyrcmUYZCOqLNvsFxGl/xUsw14/29rZ1yuVEUhhXOYQaRWLujsqvblp0oY+IJeAd
 II3el2Z5vpHpXb6G/gODVFquroHfzrV4NzBn45ArYS06hrqSkixvelT1b4u2e28UGTHQOYkw6E=
X-Received: by 2002:a05:6808:5390:b0:482:c65c:4586 with SMTP id
 5614622812f47-482e576fca9mr326894b6e.37.1778781304206; 
 Thu, 14 May 2026 10:55:04 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-482d379f062sm1758710b6e.6.2026.05.14.10.55.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] bloblist: Demote not finding a bloblist to a debug
Date: Thu, 14 May 2026 11:42:28 -0600
Message-ID: <20260514175457.4047707-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514175457.4047707-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
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

The message about not finding a bloblist will quite often be seen at
least once, and is non-fatal. Demote this to a log_debug message from a
log_warning message.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/bloblist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index d084be899588..09afdd1f96b4 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -613,8 +613,8 @@ int bloblist_init(void)
 			ret = bloblist_check(addr, size);
 
 		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
-				    addr, ret);
+			log_debug("Bloblist at %lx not found (err=%d)\n",
+				  addr, ret);
 		else
 			/* Get the real size */
 			size = gd->bloblist->total_size;
-- 
2.43.0

