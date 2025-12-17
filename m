Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69033D66B9A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 19:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB0D83B49;
	Wed, 17 Dec 2025 20:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XHFFS+f4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qPVx6ZT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B35883B55; Wed, 17 Dec 2025 20:58:18 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2264D83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 20:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dWl3C6SZbz9tV3;
 Wed, 17 Dec 2025 20:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766001495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zd6/Adv40fgBTbJws0hMXNIRWblS6jI/5dwmc8AWMRw=;
 b=XHFFS+f4SgFksmNtouok178ygwA8bt6S2GJPc1/E+NR33Ji6s+87KSt1zGijRvMv4b2SSb
 NbCNtvNKMjpRc7S1NjBE+Wfiy1PLHnFToXSxnXBCn2tR0WTQRAkq/KLTC4ftXZ3L6RqJsz
 QDgZZIIaAfKTNlcVoVTrbo+ssXA4tdDfH2sJuvGTq1/iyCw0foHqLH0z+84KTQnxQ/tCin
 JH88N1i7em6vK2nCUNI9rgfAzkiQxh+GpCW+KnzNMqwqrfo8i2qow72k1qss6p0OPv2gpl
 4eSJf3OxbkXDQsBU+Z3caTOikJL/Iv8iild/O89owMQii27supXe52UMzPglMg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766001494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zd6/Adv40fgBTbJws0hMXNIRWblS6jI/5dwmc8AWMRw=;
 b=qPVx6ZT28y9OBsrD09P6E6cmKgTM9q0FK1gkc7QSX8HDQNUKS++FLFSU4QLM74LzqtagJo
 RC8RNiwp94Y51iooSZQNE0DSxgTnfLWmB0LaYn2I9qXgf5LcW4oMXxOndrCHsr38pICJcP
 cRIU1IbOzH2tz0V4ScorXeYBm6bVlDrL64DNriR+Ep8uSw/SSwfZ5IDZhJE0uythdrJtNu
 xJdZsv3UDebLbW2mGZTcgNkQdp+SJkra0ZLdjbfxhLY1/Oo8dAWpfXTdgzYoNMkJHNGM/c
 Ilvj20SbDhUezOQ5QAcT8INEr9W0ZPtfqhWIJBlrtW22iVu53rfXeaS1efnGGg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@st.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH] cmd: nvedit: Validate argument count before use
Date: Wed, 17 Dec 2025 20:57:38 +0100
Message-ID: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 48394255015e2ee1ebb
X-MBO-RS-META: jfjb63e7g8wmnwjpbwmmzocex4py53gz
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

Avoid NULL pointer dereference in case 'env select' is invoked
without parameters, check the arg count and make sure it is at
least 2, otherwise print usage.

The crash is easy to trigger e.g. in sandbox:
$ ./u-boot -Tc "env select"

Fixes: a97d22ebba23 ("cmd: env: add env select command")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Delaunay <patrick.delaunay@st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vincent Stehlé <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de
---
 cmd/nvedit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 11c3cea882b..636bddee1be 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -499,6 +499,9 @@ static int do_env_load(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
 	return env_select(argv[1]) ? 1 : 0;
 }
 #endif
-- 
2.51.0

