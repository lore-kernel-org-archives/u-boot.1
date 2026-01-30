Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0426FE6BF31
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C301C8452E;
	Fri, 30 Jan 2026 19:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="QQwDcpeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452868452B; Fri, 30 Jan 2026 19:04:34 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2ABB844AE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769796260; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m+WJYoPn7en/6/2AupdVo8ObPVp8bYzkxcuG8fBHAA1w7YC38z0OQJfSjNsfXJFClckkleDhYXMSV0+asNzqctfUlYI8kUN6HqZzRYYMUaRpTD4OlQiijTdpxz/9aTDBAdkapO8p4Wh6rWNZh2d8ID6+2KETh34OTkJL4Eev9Eg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769796260;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=c9LT5ttRwUvFqewdsHnwaopsrP/wcnSfbSg2o4XhBCA=; 
 b=iFb3zj9Ozvqjwm+dyaKk1I26ROyWc3Jfve0onwP3a5WTWljMxz+YkvbnsLcFYpO8Ax+xZOOJ+CIgZnYCkupzd2rpdr996rHrN+dmYE6Im0w59WKUXKweMUhP3GBigm4ENLtuLkvKYt6w8HoSb9iib4nhBGJABPPZF8lEVga27EY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769796260; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=c9LT5ttRwUvFqewdsHnwaopsrP/wcnSfbSg2o4XhBCA=;
 b=QQwDcpeOoVf779ajLDzqk1Pd9biKgt4+qjq5fhPn6XczsAe1Um2kq8pO1xCa+5a8
 Cv5ow7E68GnbxeQZtwlW4PQPkDEMoAcOaIPGb7y7GQYp9ffSPfiuSvtd7KUu/1mo++e
 1D1Rmn40/weXrebepxVcZfy27p5ERqlsO91wUgPg=
Received: by mx.zohomail.com with SMTPS id 1769796259834123.49802991494084;
 Fri, 30 Jan 2026 10:04:19 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 1/3] cmd: mmc: Simplify dev subcommand handling
Date: Fri, 30 Jan 2026 18:03:51 +0000
Message-ID: <20260130180353.42205-2-me@ziyao.cc>
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

Replace the big if-else block in do_mmc_dev() with switch-case and use
fallthrough to remove the duplicated code for parsing dev and part.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 cmd/mmc.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 5340a58be8ee..f2a59af087cb 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -16,6 +16,7 @@
 #include <sparse_format.h>
 #include <image-sparse.h>
 #include <vsprintf.h>
+#include <linux/compiler_attributes.h>
 #include <linux/ctype.h>
 
 static int curr_device = -1;
@@ -556,37 +557,30 @@ static int do_mmc_part(struct cmd_tbl *cmdtp, int flag,
 static int do_mmc_dev(struct cmd_tbl *cmdtp, int flag,
 		      int argc, char *const argv[])
 {
-	int dev, part = 0, ret;
+	enum bus_mode speed_mode = MMC_MODES_END;
+	int dev = curr_device, part = 0, ret;
 	struct mmc *mmc;
 
-	if (argc == 1) {
-		dev = curr_device;
-		mmc = init_mmc_device(dev, true);
-	} else if (argc == 2) {
-		dev = (int)dectoul(argv[1], NULL);
-		mmc = init_mmc_device(dev, true);
-	} else if (argc == 3) {
-		dev = (int)dectoul(argv[1], NULL);
+	switch (argc) {
+	case 4:
+		speed_mode = (int)dectoul(argv[3], NULL);
+		fallthrough;
+	case 3:
 		part = (int)dectoul(argv[2], NULL);
 		if (part > PART_ACCESS_MASK) {
 			printf("#part_num shouldn't be larger than %d\n",
 			       PART_ACCESS_MASK);
 			return CMD_RET_FAILURE;
 		}
-		mmc = init_mmc_device(dev, true);
-	} else if (argc == 4) {
-		enum bus_mode speed_mode;
 
+		fallthrough;
+	case 2:
 		dev = (int)dectoul(argv[1], NULL);
-		part = (int)dectoul(argv[2], NULL);
-		if (part > PART_ACCESS_MASK) {
-			printf("#part_num shouldn't be larger than %d\n",
-			       PART_ACCESS_MASK);
-			return CMD_RET_FAILURE;
-		}
-		speed_mode = (int)dectoul(argv[3], NULL);
+		fallthrough;
+	case 1:
 		mmc = __init_mmc_device(dev, true, speed_mode);
-	} else {
+		break;
+	default:
 		return CMD_RET_USAGE;
 	}
 
-- 
2.52.0

