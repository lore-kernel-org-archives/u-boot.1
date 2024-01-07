Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F79FC47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 08:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958B687A08;
	Sun,  7 Jan 2024 09:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FMlUN+3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB98187A12; Sun,  7 Jan 2024 09:56:14 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E46AD86F87
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 09:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C0E774288E; 
 Sun,  7 Jan 2024 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704617770;
 bh=YGhnc49Q8axR+g/DP86BpyTPUmRL2Ohlv+1YAG9cSGk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FMlUN+3CofmHwaIz2fg0odLvSfQyMnLqXDmC3hH/qlLvZNinTC+dC7UReZQrlgnMA
 zjLV48GGvH1B/4KjpwJtp7xPswMSeHITn9LeaX9JlgxowPJDSybx3EHLbDDJSf4CpO
 DCkaXF+L0pMbS2MDMm11UtIQUCSDvYAq5m8ERs41m0g2TGUPWYN74apvFwu6qq6nzt
 7evUN+ZPXeR1RpDdasHflmU4b6ypax864lVp+GptuUppSrC6mK6hePRA1JSwCtPi8F
 HjnEKyXW3BmJxRQMWlWvKUcMCG+QDMED7CL8tQoOPMiXblKekAPwgdCRnx2q5Ycdge
 XdObwo+1D/wKQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: boot_flow_iter_set() called with uninitialized
 methods_flag
Date: Sun,  7 Jan 2024 09:56:07 +0100
Message-ID: <20240107085607.63103-1-heinrich.schuchardt@canonical.com>
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

Some code paths do not initialize methods_flag before using it.
Initialize it to 0 in the definition line.

Addresses-Coverity-ID: ("467057 Uninitialized scalar variable")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootflow.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 05484fd5b1..4b32d74fe1 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -241,7 +241,7 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
 		ret = -ENOENT;
 	} else {
-		int method_flags;
+		int method_flags = 0;
 
 		ret = 0;
 		dev = iter->dev;
@@ -260,7 +260,6 @@ static int iter_incr(struct bootflow_iter *iter)
 		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
 			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
 			log_debug("next in single\n");
-			method_flags = 0;
 			do {
 				/*
 				 * Move to the next bootdev child of this media
@@ -302,7 +301,6 @@ static int iter_incr(struct bootflow_iter *iter)
 				}
 			} else {
 				ret = bootdev_next_prio(iter, &dev);
-				method_flags = 0;
 			}
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,
-- 
2.43.0

