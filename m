Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3734E677F8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D945788F6B;
	Sat,  2 Nov 2024 11:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ohGEHT+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C5788FC4; Sat,  2 Nov 2024 11:08:49 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D76588C10
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2D45B408EC; 
 Sat,  2 Nov 2024 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730542122;
 bh=h2KItQMTekjKk7kxOtk6saqZzUTSMzvjAaPS0iANAPU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ohGEHT+7ppFXAdqBU1UrIoXRn5Sp02KkK6NkaZIdQqM9sLPLuh4IzzcBU36T41v9v
 hfW8z+YQJp3OSCIqqTwye54xxR89s2gkLSHk3WMLQON5jva2tHbncdvhA3O8f10nVw
 n+JLJBwJs+WCqtcR5uFEx6fqZB/KexHTNQWSL2ufQQWJ34p7xq7l5Km4mPb9SX+jTt
 Kdy1/7zxVvYUlBM2fv4JqzoL8FeJKUdIGIEqtfwnfoaHvSTmdtsF0Q3g11lg9mAMHi
 1YMTRlrRsBUfBIWWcnjhzapDGqsxKs3JcXZCcxi0xpcJnRtqHAXU83MKNr804Z5fQ6
 KADfVL6szDc8A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] cmd: hash: correct parameter count check
Date: Sat,  2 Nov 2024 11:08:35 +0100
Message-ID: <20241102100836.103005-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
References: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
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

Since commit 348ea878508d ("cmd: hash: fix param count check") the hash
command cannot be used without the optional variable name parameter if
CONFIG_HASH_VERIFY=y. 'hash sha1 $loadaddr $filesize' returns
CMD_RET_USAGE.

The minimum number of arguments is four no matter if verification is
enabled or not.

Fixes: 348ea878508d ("cmd: hash: fix param count check")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/hash.c b/cmd/hash.c
index 60d482b7f87..5b40982b098 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -25,7 +25,7 @@ static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *s;
 	int flags = HASH_FLAG_ENV;
 
-	if (argc < (HARGS - 1))
+	if (argc < 4)
 		return CMD_RET_USAGE;
 
 #if IS_ENABLED(CONFIG_HASH_VERIFY)
-- 
2.45.2

