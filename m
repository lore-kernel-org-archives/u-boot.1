Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25DDCFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D3983C7B;
	Sun, 23 Nov 2025 23:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cGUypDwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2F383C98; Sun, 23 Nov 2025 23:58:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CA483B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 46D4444977; 
 Sun, 23 Nov 2025 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938687;
 bh=dv0r7fJiryduOhgOkPZ5qDKwThGSvNEvfyGmr+x59gs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cGUypDwfE08ECyskrU1vU/c9K9Q70b+BnnMB22h7bloYrQA7dATf27mJZrIuPHcuo
 YN7B/YiIXY/B7BIHPDvDZ5WpHXhEsDxpDfJq0HaJLLNMQOjvPu6sJsyeVgVv9lUjUV
 ZuKDqB9eUp02g0KvHGiKhNobmEx+JiY5hWY1XdWDLChNnx7emJ2jIp+3kD/JLUYQc7
 UQtIrZeDT5f0mYFHtSYSZslSSO/9uIO38HYfJjKlrfScNgTN+T02D2mxiGiNGbb6e6
 CeF2iR7/iOonQ5f+GggyCUDiTfJ9W+MzhgZPsoP76LrtV5Aqvs6FsMLbr5qgqZKF3A
 56OiaBq4cTViNyWOK4iifyASI++zJrYarNUn3DW6RGFodC8T7vwLsZt9i8DsPVZfP6
 pQbGPCxgRLh0fzjKy3DYFyRVJx/35jpIFtbXybomxtKBkt4afqz4nnJEi+A0dhuiYM
 RbRxbW32Ht4TpJjU6EyjPUJoV2JTfq06LzmRhrjD9WLJ8eDp71GD05GvjnKCjKlvTk
 snyByMwK9Fzj1WJVZA5BPLyzY78DKfvzYq+ydaPxJ3rBiHrJmLgmMDpWKGpy6h5C93
 MAU1HAeDeP8PgdYQHdtSnPpCJTbSS9GzNk0DA8cFht1hKACReef6c/po1qiKY3AMoC
 bocHk8LAbLh6GiFad7kKMTbg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 12/19] test: fix bdinfo_test_all boot_params expectation
Date: Sun, 23 Nov 2025 23:57:04 +0100
Message-ID: <20251123225711.227016-13-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

The value of boot_params is device specific and non-zero on many boards.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/bdinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 2f3a65996e7..ba8a3392237 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -156,7 +156,9 @@ static int bdinfo_check_mem(struct unit_test_state *uts)
 
 static int bdinfo_test_all(struct unit_test_state *uts)
 {
-	ut_assertok(test_num_l(uts, "boot_params", 0));
+	struct bd_info *bd = gd->bd;
+
+	ut_assertok(test_num_l(uts, "boot_params", bd->bi_boot_params));
 
 	ut_assertok(bdinfo_check_mem(uts));
 
-- 
2.51.0

