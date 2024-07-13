Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8FEC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31BE888BF;
	Sat, 13 Jul 2024 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MOaGsKLu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="km5Y50RY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC16A888CB; Sat, 13 Jul 2024 15:21:39 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE365888B7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyT5DbLz9sTd;
 Sat, 13 Jul 2024 15:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuQeHeVQZqrJLG8ON9zAcMexkRwxWCgfOa18Jo6Nl9c=;
 b=MOaGsKLuJws/1LU3F/xiRtcBMdm8gDtHNvpzm4WEgWPAKlDibrueOFiVFZ9gXa7wp0R58B
 TLeXvAs3extr3TA/eb4GHN0zTW1gjEyG6bNZ/WG1pfETY1BsdFr945ehYBt7Q4lJrC/7cO
 YjKh0sP/SkA/Q+Y/jXbGtmdxgVo2yNFU8Ag9/Qo8jTsM6K02fux9ul/3JWLjfNLvpiPCMn
 jyKjtK5vVT744lNX59ogjnU8BSjXhW2lxXrqhKj0MkbIj92esUryA2ZBZJYIDnvYV2yDWc
 qJtaQ2NMieI1e+fwKjiP03tmkIXDXCHHjWAtQw7lb4IHhV3kpkDhP4HLfE78pA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuQeHeVQZqrJLG8ON9zAcMexkRwxWCgfOa18Jo6Nl9c=;
 b=km5Y50RYlAdUWqnzJ2iALCLjzR/cgWGtWpjOFkfKmW4jRQkpF0PJvuppp+7RlFwMIiIYUa
 epL8XgmfFJd4pHhGhf5u2+HZnWhHz4k1oGFlh2bJFmfLCdsX/KSKwy8EpFQbBZNVYGE6Oe
 5r5nri/6GvTHMlXSawPQ7cqNE6orwRcQu1bK58Ql4slN2whYstVWcAOcRiwJYvygZGOxiZ
 iqvgye386fH1av2ua75APbzcuWBakDk3QSf+dRdnlTVoHd2HTEtINwLgKpll18JGhJyATC
 1Dg3c7g7GR4ftIKXYxpd3suRGvxg8Tj/IFwdalAtxa/0iQf4CChqtNWQCjyirQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 29/45] examples: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:20 +0200
Message-ID: <20240713132021.57650-29-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5f01d3976b08760c2c1
X-MBO-RS-META: icec8iuquegx6eackp7mk3f8dkp5ps3i
X-Rspamd-Queue-Id: 4WLpyT5DbLz9sTd
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 examples/api/glue.c         | 1 -
 examples/standalone/sched.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/examples/api/glue.c b/examples/api/glue.c
index 08c21a8cb9c..0aaa82bccb2 100644
--- a/examples/api/glue.c
+++ b/examples/api/glue.c
@@ -153,7 +153,6 @@ unsigned long ub_get_timer(unsigned long base)
 	return cur;
 }
 
-
 /****************************************************************************
  *
  * devices
diff --git a/examples/standalone/sched.c b/examples/standalone/sched.c
index d507163f6f3..57ae67e1a5b 100644
--- a/examples/standalone/sched.c
+++ b/examples/standalone/sched.c
@@ -21,7 +21,6 @@
  * timer interrupts.
  */
 
-
 #define MAX_THREADS 8
 
 #define CTX_SIZE 512
@@ -55,7 +54,6 @@ struct lthread {
 static volatile struct lthread lthreads[MAX_THREADS];
 static volatile int current_tid = MASTER_THREAD;
 
-
 static uchar dbg = 0;
 
 #define PDEBUG(fmt, args...)	 {					\
@@ -162,7 +160,6 @@ static int testthread (void *name)
 	return *(int *) name + 1;
 }
 
-
 static void sched_init (void)
 {
 	int i;
-- 
2.43.0

