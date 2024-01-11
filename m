Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4856DC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A578786C;
	Thu, 11 Jan 2024 09:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l8KHy2LM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916EE878A5; Thu, 11 Jan 2024 09:14:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB0A8718A
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 214154025B; 
 Thu, 11 Jan 2024 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704960881;
 bh=oDu5UWWebWp2NsqL0Jq3piTdJh47xlEr3on5MEpNBTM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l8KHy2LMV1zG1a0VzMXNl5fEOhaEVxflc8rTvxiIxrJADeav0bg4lwP6Efj/KDZBp
 k7vgLUfrf+wQ9L/HsydMU17/sPK/O6Ioo4I4KpxYFSX93IqgvBGFq6RM+8ccRwL6P+
 N4R2Zj5qKABteD0+feSkO4feDvHONGUawHRcrOh/hXOUj54+19l8278DT/OVSwDEWR
 BXHJPmnNjOEO37fXn+eH3wuq2wGAY1HqPvgdBtGbD8wTm+k0ZvIFe2XunPijP0BYzI
 ktzYXoQLR/6bu8LhUSao1LbGGBkqD9yf3WIUfxRKkQTroFHw0BGPkv96N9j1maaI/M
 5coomIPWDdGrQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: bootflow: remove dead code in do_bootflow_cmdline()
Date: Thu, 11 Jan 2024 09:14:33 +0100
Message-ID: <20240111081433.178860-1-heinrich.schuchardt@canonical.com>
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

Checking argc < 3 twice is redundant.

Addresses-Coverity-ID: 477198 Logically dead code
Fixes: 921f63e57238 ("bootflow: Allow setting a cmdline arg with no value")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootflow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index cc6dfae166..be5d7d8e74 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -543,8 +543,6 @@ static int do_bootflow_cmdline(struct cmd_tbl *cmdtp, int flag, int argc,
 	op = argv[1];
 	arg = argv[2];
 	if (*op == 's') {
-		if (argc < 3)
-			return CMD_RET_USAGE;
 		val = argv[3] ?: (const char *)BOOTFLOWCL_EMPTY;
 	}
 
-- 
2.43.0

