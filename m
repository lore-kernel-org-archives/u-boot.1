Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F3FE6BF2F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F49844C0;
	Fri, 30 Jan 2026 19:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="pn5+D/ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283EF84529; Fri, 30 Jan 2026 19:04:33 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD8B84523
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769796264; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gvMP1Qn4u8HMv11Yen2OupaCHrNylpGgKdpjKrObBsn2esjvQiuBA3ndpPjn+qGojI5kB4P00bGtGafAv5R8W/qrMJQ7zuom/C3z9ZRr+3HJzvhS+nSF11c3XMZTUwD2n1kgd7zwz+Lc5Mw9MAjRNffOT9IwHyf4rkfCoD7v8ms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769796264;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QT4GoK1fqDA6iaJFNxQTd9qjPNrUxKyGIcTIr+yr70k=; 
 b=Nn5P1wCjELZhh6skPdEpLQ7O2QnLpr89Z9zyBwzF4uM1iXf4+cet3GV28Yr44vj3IlBw9KA3NQps9wc72srh433KrCN2g0OaDz8xHlyo377v100jb4NnXh8zJvkHVqgK3BA368KbDLxJ1cb6/QafmRWzlavyKhY/IEJY6YFh29w=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769796264; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=QT4GoK1fqDA6iaJFNxQTd9qjPNrUxKyGIcTIr+yr70k=;
 b=pn5+D/ewZ4ZhuXl0lbCyfvjkTSrCvJJ6jXFSu6/mqsRzvcof6+nNLlR8kJSENZBe
 iDC+oBy/kCam+7HdXDJU1G3zuYcKiyaUEh9PnYzmQALXeJ6JhpKRxar6YyLYIuuUULt
 49TnQvZxXK0p2XIbdoLiniv5Kgb6wTCnZBugW4hg=
Received: by mx.zohomail.com with SMTPS id 1769796262192409.2203974474485;
 Fri, 30 Jan 2026 10:04:22 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 2/3] cmd: mmc: Check whether arguments are valid numbers in
 dev subcommand
Date: Fri, 30 Jan 2026 18:03:52 +0000
Message-ID: <20260130180353.42205-3-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130180353.42205-1-me@ziyao.cc>
References: <20260130180353.42205-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Currently when any of speed_mode, part, or dev fails to be parse as a
number, no error is reported. In this case __init_mmc_device() is called
with weird arguments, probably zeroes if there's no digit prefixing the
argument, which is especially confusing when the invocation occasionally
succeeds.

Let's check whether arguments are valid numbers without trailing
characters. This is quite helpful for speed_mode: it requires an index
instead of a mode name, one may easily pass in a string, which will be
parsed as zero (MMC_LEGACY), without carefully reading the
documentation, then finds the MMC device is under an unexpected mode.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 cmd/mmc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index f2a59af087cb..512bd482ae82 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -559,15 +559,25 @@ static int do_mmc_dev(struct cmd_tbl *cmdtp, int flag,
 {
 	enum bus_mode speed_mode = MMC_MODES_END;
 	int dev = curr_device, part = 0, ret;
+	char *endp;
 	struct mmc *mmc;
 
 	switch (argc) {
 	case 4:
-		speed_mode = (int)dectoul(argv[3], NULL);
+		speed_mode = (int)dectoul(argv[3], &endp);
+		if (*endp) {
+			printf("Invalid speed mode index '%s', "
+			       "did you specify a mode name?\n", argv[3]);
+			return CMD_RET_USAGE;
+		}
+
 		fallthrough;
 	case 3:
-		part = (int)dectoul(argv[2], NULL);
-		if (part > PART_ACCESS_MASK) {
+		part = (int)dectoul(argv[2], &endp);
+		if (*endp) {
+			printf("Invalid part number '%s'\n", argv[2]);
+			return CMD_RET_USAGE;
+		} else if (part > PART_ACCESS_MASK) {
 			printf("#part_num shouldn't be larger than %d\n",
 			       PART_ACCESS_MASK);
 			return CMD_RET_FAILURE;
@@ -575,7 +585,12 @@ static int do_mmc_dev(struct cmd_tbl *cmdtp, int flag,
 
 		fallthrough;
 	case 2:
-		dev = (int)dectoul(argv[1], NULL);
+		dev = (int)dectoul(argv[1], &endp);
+		if (*endp) {
+			printf("Invalid device number '%s'\n", argv[1]);
+			return CMD_RET_USAGE;
+		}
+
 		fallthrough;
 	case 1:
 		mmc = __init_mmc_device(dev, true, speed_mode);
-- 
2.52.0

