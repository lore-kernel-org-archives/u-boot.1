Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDA1CD4935
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8E086C48;
	Thu, 21 Sep 2023 00:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nBsxh+Wj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vp3mWDA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D4186C2A; Thu, 21 Sep 2023 00:58:40 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CA586C24
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RrYqL0X3kz9t8H;
 Thu, 21 Sep 2023 00:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOX5v8gFxb4lCMp9z5mmC4d+0KKZlvYnzdsX2W7x3ME=;
 b=nBsxh+WjcoPzgCnkgDDmwfcejSOGtmHCJdZm9rdWNg5dsR0LtE0jk2HAgHXLysKi+k+rPY
 /FtjMHJ1HjaviTIPrvZBAD64hbWBxxfGsz9e/VW0pBZqHCxVYPnqNvEaHJIXhBxIv+YWko
 pTyKxX9dwm4Y9D5IWuj93jCj4z3d+9yUEfcauMa3DqbgsbGxicheaJOBYc2W2YECDpnDeu
 6pqJMrdRWQzwq+je7sxA+JEoeh+MSKf6FyPZlnQsWKXd9/ZPYQPCq6tDmNccus4WtFwzk3
 2mUlEIdgTlxgf7Psg2BGo8ppg/F/WH0791dhDz1NBAzM7+4ry6EelWdE89Op1Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOX5v8gFxb4lCMp9z5mmC4d+0KKZlvYnzdsX2W7x3ME=;
 b=Vp3mWDA4txRtf/f+3pSRbyVAOkvNbeta3/INyB6k+TIVP0QBVgYGxAf5VvciJSyazceU74
 diDNTcLrSt+hxTOc6jnZQ8BgPD6NCxqTZmaZ/GY0kCBePsbcNAkgBULykvy2cR8B3sqyoX
 Vu+GU+fU4fcfCDaQBEXuvO1gQj+K7/MAQzZUtpiSqvQG4PuU2CSqnEdoczYFoiYsb+X00w
 Aw9cS3p2QOdrXkL38L9vfrcV73/oor86VBEcEXDHwyrws0U5yDpeiqd6wais31FNzeqLH/
 PIuO/UmUBkpVyzL2mgM7sqelLAZqwzE4wI3VxhGWL/KhoNznrV82UTrRVsfEbg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/9] cmd: bdinfo: Implement support for printing memory layout
 via bdinfo -m
Date: Thu, 21 Sep 2023 00:58:04 +0200
Message-Id: <20230920225811.153474-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 75ku459gcu7ww9wmcjsbkt79bey1fw5g
X-MBO-RS-ID: 50cffb71fbde3231039
X-Rspamd-Queue-Id: 4RrYqL0X3kz9t8H
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

Add support for printing memory layout only via 'bdinfo -m' .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 cmd/bdinfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 2c0d5e9c01b..c720ee6f9b6 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -193,10 +193,13 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return bdinfo_print_all(bd);
 
 	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "a")) > 0) {
+	while ((opt = getopt(&gs, argc, argv, "am")) > 0) {
 		switch (opt) {
 		case 'a':
 			return bdinfo_print_all(bd);
+		case 'm':
+			print_bi_dram(bd);
+			return CMD_RET_SUCCESS;
 		default:
 			return CMD_RET_USAGE;
 		}
-- 
2.40.1

