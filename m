Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208A1C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 20:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442528142D;
	Thu, 27 Feb 2025 21:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PWLo+OEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B59C3814B6; Thu, 27 Feb 2025 21:50:54 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5F081429
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 21:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22128b7d587so28580905ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740689451; x=1741294251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gLN60ztQKX9OIHbIj5vJi9fUZsiNx0edOJVvxaCLLGQ=;
 b=PWLo+OEjXFK1vEsiZbkyXWmSNxqr0Mif2mq8ERQCwDN5AGxum38GKbuHM7j2oYmTz9
 +sZ7HqY4WJoW/VkE3WK4bYx75s96QhufcUMaabmzV8CxtseBqPv0iylI3fOJGCvn5tUT
 JqvS9uK64WwSLoMkokkQNL/YuOIE9ANOrP+2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740689451; x=1741294251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLN60ztQKX9OIHbIj5vJi9fUZsiNx0edOJVvxaCLLGQ=;
 b=Sl6SmsRpblx2zU4lBDEpW7rw4T+gTAt1KCeMl40jZsW/G+N6Cz1baiEdmZqrBLa3AI
 z0Y6EwGRa9wgtIVTk6D1uGUOvKuILiKv5D5HY/h43+Bgwqu2WGb0X8v1BrWtwcBNH9E0
 0gt+sd+trxBneyxRyYKUlT1/gVOXwkiqHqECl1bD0aqZOuT9cKua276VjW1pMTo1cIsG
 1+nJlkZL5OP7eIJQ0LwBeM7OdrWS22/+Ehn2iYuoRZv7kBtb2mpKeIgOpvA5n5kM3oOj
 jOu6xDR/8cIsG83YQe1Yc5yRFoSEd4XH40yXmO8Vi0cd5JjW/EgApp58yoAid+K/9CFm
 cq6Q==
X-Gm-Message-State: AOJu0YwCAlLFaNEv4mCxFpkHTaHJcY/5U9cEojiGLew0ZIf3u4PMJbdA
 Ug5UNQpIWOfck+/lxnYUhWWgIs4mX9P1mZgTQq7sr9hZBPQzCX/qQdYSgCCsMP0x1i5NiYCyWhN
 AUqU=
X-Gm-Gg: ASbGncsKGcVXKN1mK7p391s6DBlGy9NBQmf1eBmkl6gsYLCNzDCtfVBW7Umwmw1pygv
 lQ9ooGYV96gN4utfidA40otqLWJzhr/QpGrFg2pWKJ7XoQ4KPQvjGimmTO4edsss2/dhZ8ZnkR4
 O6wpeEDdm4RhTygXcgSDyv0H1lVopuya/2lJZedkzU/t/BEB8KYfptFnwimDC4gnaH24a0DQ0iC
 nCGmed7bePYdF6V8Pk3Has1p3kiBDv68TvvsDOtzSqCagKL7z1NMmUj/NxEsoSjk3SYoh9di/kt
 F3urWQojSRJP7MzF1X5Z/1IG7/U=
X-Google-Smtp-Source: AGHT+IGbT/nC8Nak41ScmPXpTuyiAs2v2teFyHo9nLYkowavTrGerQb2SCPypzUYrjL/n/ONXajlBw==
X-Received: by 2002:a05:6a21:998b:b0:1ee:c74c:2436 with SMTP id
 adf61e73a8af0-1f2f4dfc2ebmr960104637.34.1740689450984; 
 Thu, 27 Feb 2025 12:50:50 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024c81sm2140363b3a.118.2025.02.27.12.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 12:50:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] cmd: Drop last reference to CMD_REISERFS
Date: Thu, 27 Feb 2025 14:50:48 -0600
Message-ID: <20250227205048.4127552-1-trini@konsulko.com>
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

While the code was removed in commit 3766a249a3c0 ("fs: drop reiserfs")
this reference in the Makefile was missed. Remove it now.

Fixes: 3766a249a3c0 ("fs: drop reiserfs")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peter Robinson <pbrobinson@gmail.com>
---
 cmd/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb0..c1275d466c81 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -155,7 +155,6 @@ obj-$(CONFIG_CMD_QFW) += qfw.o
 obj-$(CONFIG_CMD_READ) += read.o
 obj-$(CONFIG_CMD_WRITE) += read.o
 obj-$(CONFIG_CMD_REGINFO) += reginfo.o
-obj-$(CONFIG_CMD_REISER) += reiser.o
 obj-$(CONFIG_CMD_REMOTEPROC) += remoteproc.o
 obj-$(CONFIG_CMD_RNG) += rng.o
 obj-$(CONFIG_CMD_KASLRSEED) += kaslrseed.o
-- 
2.43.0

