Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB98C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 13:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D5F86579;
	Tue,  5 Sep 2023 15:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gmGjzcD/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d52t3ZAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72C68698E; Tue,  5 Sep 2023 15:48:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1159686575
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 15:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Rg6KK5Kbhz9shG;
 Tue,  5 Sep 2023 15:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693921701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dfxgFTQeC+LpRRZ1TWB+jEnBPkzQFN58zE07V7NcLJg=;
 b=gmGjzcD/EaXPJylKHtIkcgs5GojzmLq34SPb1pAejdiTEYMSO05pIS866lkgoneT3XyQ9Q
 wew4VbPZJPHKn5hUHomDKtzwq1pHe8iPCyISKmOYkHbN0K6Mv0WvOEpcZPhpSiWz2mzMcG
 ebcmqM7FxL05OCSe75O2S5SjidsSRI7JBRU8+HmkBmj5fCuCBU1GBt3qThWbkQjcUIOFjb
 GE3758QLg8LENy15pDB/EKXNw/FEWinqJCdLDy6s0bML4eGSoLgnN+o/ZCJuAccSJk1yb0
 Tw8NkdflorVCpi5NW1wc6nU8Wilr6mAqy1IyQyN4xwfE4yaF228ssTrImleVMQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693921699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dfxgFTQeC+LpRRZ1TWB+jEnBPkzQFN58zE07V7NcLJg=;
 b=d52t3ZAZfhHqIBMm7kUCBPQlNDSIrZspMnJ9PcxabCGKyBwfp1kFt6x4swJ6b4TA+FIQgx
 LksjFZ7no0u0k1B/PDwkcauuW/Iw6mLpWUvmqk8AavE2cUa+A4BUqaMiDd7j/2SW9c8eBl
 CrUnnDUU9P6KC+vVwsZMCgSy8SEzle+QXgeKRMONwLpUqT5hAuaadQheJmcFp2hVCVfm4a
 1yQXgk4ORaq8rM38pMwvidSuUmsoGvz9OoWFEoX83ic1c5BvJq5wugnvQ+5cbwWWCHVl+e
 4tgPlnYOuLLSaBzOgIMK38BdDsYr1Z8YDjH0ljriVBjgE7ZzTj/2PyldX+w3+g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chanho Park <chanho61.park@samsung.com>, Leo <ycliang@andestech.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 1/2] riscv: cpu: Rename EVENT_SPY to EVENT_SPY_SIMPLE
Date: Tue,  5 Sep 2023 15:48:07 +0200
Message-Id: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3a90d65146817c49131
X-MBO-RS-META: sfejreqo8gufyg3ibccjybt6rqa3pkr4
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

Fix up cpu.c and align it with commit
6c4cad7438 ("event: Rename EVENT_SPY to EVENT_SPY_FULL")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Leo <ycliang@andestech.com>
Cc: Nikita Shubin <n.shubin@yadro.com>
Cc: Padmarao Begari <padmarao.begari@microchip.com>
Cc: Rick Chen <rick@andestech.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>
---
 arch/riscv/cpu/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index d64aa330f20..15beec29875 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
 #endif /* CONFIG_CPU */
 }
 
-static int riscv_cpu_probe(void *ctx, struct event *event)
+static int riscv_cpu_probe(void)
 {
 #ifdef CONFIG_CPU
 	int ret;
@@ -79,7 +79,7 @@ static int riscv_cpu_probe(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, riscv_cpu_probe);
 
 /*
  * This is called on secondary harts just after the IPI is init'd. Currently
@@ -96,7 +96,7 @@ int riscv_cpu_setup(void)
 {
 	int ret;
 
-	ret = riscv_cpu_probe(ctx, event);
+	ret = riscv_cpu_probe();
 	if (ret)
 		return ret;
 
-- 
2.40.1

