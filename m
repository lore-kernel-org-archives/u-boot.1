Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E14FE7D267
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B678B86D3A;
	Tue, 26 Sep 2023 10:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B7F86D3B; Tue, 26 Sep 2023 10:46:08 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB6B86BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp88t1695717958t282959x
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:45:56 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: rZJGTgY0+YMu0ZB8Wv9DW+AZO92Lw/n2swwivL7MANpHmhVT4qcfgmR7WsTPd
 NUds8pj+DRgUljeA3gv40HQtFJneipc4J1i5+t+pA1RA0p4RU70xTowdKCY4Ugh9mgGBW40
 eovpcPhL+iZpTWWB4S1OJquIrwV/gOIr29/GjIFejemSXxSOHDBmBoLvvYqgPNeKEeEPDd/
 mZfQ4GYqTzAnjcudY3d/MJ6drYaVKjQgt4d+rM+MBQyoOmuVc6WDMf0TCYt25O+5g8cR8F5
 Fz7h+iKzgb2mwOFp3x4D/7/O3CwNV/8vQ772rIr41Tb2SqvhLXo/7cIh58g1IWE5UR8J8O/
 dA3BBYp05lfQGo4fgRE2SIH6l1KHo03kcW8zsOg
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12166942720030736096
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH 02/15] cmd: host: Mandate the filename parameter in the 'bind'
 command
Date: Tue, 26 Sep 2023 16:43:32 +0800
Message-Id: <20230926084346.2237483-3-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

At present the host bind command does not require filename to be
provided. When it is not given NULL is passed to the host device
driver, which ends up failure afterwards.

Change to mandate the filename so that it is useful.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/host.c b/cmd/host.c
index fb1cb1fdd1..b924940ffb 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -59,10 +59,10 @@ static int do_host_bind(struct cmd_tbl *cmdtp, int flag, int argc,
 		argv++;
 	}
 
-	if (argc > 2)
+	if (argc != 2)
 		return CMD_RET_USAGE;
 	label = argv[0];
-	file = argc > 1 ? argv[1] : NULL;
+	file = argv[1];
 
 	ret = host_create_attach_file(label, file, removable, &dev);
 	if (ret) {
@@ -253,7 +253,7 @@ U_BOOT_CMD(
 	"host save hostfs - <addr> <filename> <bytes> [<offset>] - "
 		"save a file to host\n"
 	"host size hostfs - <filename> - determine size of file on host\n"
-	"host bind [-r] <label> [<filename>] - bind \"host\" device to file\n"
+	"host bind [-r] <label> <filename> - bind \"host\" device to file\n"
 	"     -r = mark as removable\n"
 	"host unbind <label>     - unbind file from \"host\" device\n"
 	"host info [<label>]     - show device binding & info\n"
-- 
2.25.1

