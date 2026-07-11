Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B11C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 13:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B17846F8;
	Sat, 11 Jul 2026 15:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ddwoehad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D7E847AF; Sat, 11 Jul 2026 15:39:10 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C1BC841F2
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 15:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 74A741196B4; Sat, 11 Jul 2026 15:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783777147; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=ZDqvNVvwwGXUqlBEdM3Cru0Hl82oX7fHvAipOmuoq1Q=;
 b=ddwoehadUH4FruYkkmaW4M/OZ44gB+wqUNW2SpnA9WQgFmU8QNcm5y72g3r+/l8e3tFddC
 w7NY+hEOfOBF4h5Nuk/Ujtj3//WrO9KmQVmkP0rNdpSgaq0wrU+E2Nnv97Jc5N/zK9hmLo
 Onx49vDSwOmEW9+Da5bmYXvQkQuw1MHhJ6JaEZQzN9MPVGsML6kWTd9/0erEFJNCX+lwk9
 X7vw6yGQWge9BSwhxylUUCgfTBt7retwCWE6eeUVB30+WljpfVECnYBUX3FOsWmE0cE4Il
 6F6VKSLjUuN1B5T2YRYtjJuCfwio48xD8qh9GzEDAa/9c6zn6R5pdm9XDJC0WA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH] cmd: date: Handle -ENOSYS return from dm_rtc_reset()
Date: Sat, 11 Jul 2026 15:38:37 +0200
Message-ID: <20260711133903.106411-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In case dm_rtc_reset() returns -ENOSYS, it means the .reset callback
in RTC driver is not implemented, likely because the callback is not
needed. Handle the -ENOSYS return code as success and proceed, else
the 'date reset' invocation incorrectly prints a bogus warning:
"## Failed to set date after RTC reset".

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
---
 cmd/date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/date.c b/cmd/date.c
index 67cfaed0d48..8d15018253b 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -44,7 +44,7 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 		if (strcmp(argv[1],"reset") == 0) {
 			puts ("Reset RTC...\n");
 			rcode = dm_rtc_reset(dev);
-			if (!rcode)
+			if (!rcode || rcode == -ENOSYS)
 				rcode = dm_rtc_set(dev, &default_tm);
 			if (rcode)
 				puts("## Failed to set date after RTC reset\n");
-- 
2.53.0

