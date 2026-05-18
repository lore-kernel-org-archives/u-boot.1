Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F7CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD248469D;
	Mon, 18 May 2026 07:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OgRWW355";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C92184150; Mon, 18 May 2026 07:57:55 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B85F803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6ECDD41788; 
 Mon, 18 May 2026 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083873;
 bh=zNBjCkgLCNLd0TFoW/ql0+BkXC0NGAZ4SSZHFlT3nig=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=OgRWW355WJt5ZYTrTRqb4bnphVSb1B5oOywDh3sBvee6VWEK8AF6c2Zwu/p0DcWZy
 33+Nz1AZ6S7ku2a5hKVald15y03N4SgtbDQaCBQHYh5Ld+auzQXaKpRFtzUdOVqI1g
 Mg2t8j57ZKHXkd0T9ade/jBmufXd7Lts5lUtpyrrjLvyEcsQQTVj9RpigbcSOBic15
 aL3QXRbjRKO/xIHJ85lsktwOeqUtqS664hoanA1winSkMm2htsHRSvYMMNlbK7ZxG+
 yHmEN24xKXFAmnhvHDmToholUQy6FZYav25vbueSouzLk40U8OOZwwNzioFbiXLaBf
 1aUcHBC4EY0J1gkJmLRzCmVg9tMswC3U+9ePsYw5JaQnFzEcRcYNvROYOJNue+X3b0
 EUv2FAyG6ew0dWoimGX4qmAfBAm3VLuSeml8Bvt43E+eiXtQWWbXKbv9na3R0WmM2U
 4my5ew3ghzH94V6WEIs+Udow8dXiXUBXOOCV1VvaeJK2gnaZpPfc6q47U1PRReXnJX
 bPrdWuQ9I8HjzpFB0Y5BTp1vv86yT0NldNd5er9YJ4qhf9J+lI2s/sQ0SfMoQxPzgn
 BuhqErZ2wZH1kJOTy689mgiVsm3RIfcAtdHcT+hq3TRcNRvnqWC6x5oPnEqIGrwIDs
 G9DH8hDLoa7FyTogHG+HG9C8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/9] fs: ext4: print change date in directory listing
Date: Mon, 18 May 2026 07:57:22 +0200
Message-ID: <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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

Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
displays the modification date alongside the file size:

 4096 2024-03-15 09:30 filename.txt

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index f8e4794c10e..482a5523712 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_EXT,
 		.name = "ext4",
 		.null_dev_desc_ok = false,
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+		.caps = FS_CAP_DATE,
+#endif
 		.probe = ext4fs_probe,
 		.close = ext4fs_close,
 		.ls = fs_ls_generic,
-- 
2.53.0

