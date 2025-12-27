Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FCEE92716
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 20:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF37D83CEE;
	Sat, 27 Dec 2025 21:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAA183CB1; Sat, 27 Dec 2025 19:19:02 +0100 (CET)
Received: from luna.linkmauve.fr (unknown
 [IPv6:2a01:e0a:1040:9780:e2d5:5eff:fe2d:8e8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6654383C6C
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 19:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=linkmauve@linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id 5EBAAF437C3; Sat, 27 Dec 2025 19:18:59 +0100 (CET)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: u-boot@lists.denx.de
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH] =?UTF-8?q?Add=20missing=20=E2=80=9Cnet=E2=80=9D=20prefix?=
 =?UTF-8?q?=20in=20help=20net?=
Date: Sat, 27 Dec 2025 19:18:48 +0100
Message-ID: <20251227181852.4404-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 21:13:02 +0100
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

From: Link Mauve <linkmauve@linkmauve.fr>

The usage of the net sub-system was missing the complete command for “net
stats”.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 cmd/net-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/net-common.c b/cmd/net-common.c
index 1c6f11cd435..6f33d15d695 100644
--- a/cmd/net-common.c
+++ b/cmd/net-common.c
@@ -103,4 +103,4 @@ static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 U_BOOT_CMD(net, 3, 1, do_net, "NET sub-system",
 	   "list - list available devices\n"
-	   "stats <device> - dump statistics for specified device\n");
+	   "net stats <device> - dump statistics for specified device\n");
-- 
2.52.0

