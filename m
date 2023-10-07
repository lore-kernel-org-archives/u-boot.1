Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57197E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED4686D3F;
	Sat,  7 Oct 2023 23:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d34L0LDW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BXZmzidf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F19E86D83; Sat,  7 Oct 2023 23:41:30 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC9786936
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S2zJH1kKTz9sW5;
 Sat,  7 Oct 2023 23:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AF4hnBSfVvCHePCZ0696Etzu1qJc5i2ORpYIc0MXAzg=;
 b=d34L0LDW/BDBLNABr35Ay3w5Hi8b0tobLmXfxHFxZE+OELe0c6pfCqj53McA8bzdrTYPdJ
 W4ypdzCgL77vXL3+Id0YnOZ3DkrFQqsrsshLBP6bKEVeEOeo63THBUhSjdt8o/1ZHeVMAk
 w64MYcTeQkV5pKZ73dopTMPzZsSRlvgwmEblvKdJAi4kdEePzmYdn0djvpqPKNN5R+oFtI
 Z239GSk0wkX3z1BZZekVhTHWsO9wFu/5znJyd0D6bicJLOueUg53zR+t6w8XmS73EuxER2
 IqS6tL5iYczr3eOLvbu0xPfLwLw0JKQ+yyNqbQ4yX97DV4v0hc8KlPzHU1kdjg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AF4hnBSfVvCHePCZ0696Etzu1qJc5i2ORpYIc0MXAzg=;
 b=BXZmzidfShhTiQ8D2M0SVPFYPlHG364KJak2OFh0QzED3TWg/ph9KBymkwxUgGDPPJ5GQb
 mfYwl7aLQGIWfFWgk4an224Hrh3GaMYgNmY9azGeCaJs76iX9dwsM+hFSOYBQhPjhHHFTY
 JVMYGmpIefvUjmhdBbsz7YHPp1XJlWRgWtOGw7bt0bPNvorvU5PUk6IHKgIufIbS/SG7R6
 SZRTNudQV8qcm5iaQVtIQ0xsD7IEsghreOHQhL+66ALNSmjd7Q3zvXGG1YrSe4ihtZgtNV
 b3f9lbqlFcgEM4SKpM5R1+ha+HZg2PkZbS/Qrg2xR8YHzAjOLMUSC9xdpKdQFQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 2/9] cmd: bdinfo: Implement support for printing memory
 layout via bdinfo -m
Date: Sat,  7 Oct 2023 23:40:59 +0200
Message-Id: <20231007214106.15744-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6f996c1f64f55ac2a70
X-MBO-RS-META: p3bhwukwos58mphxfc1jcw19whjfuw7s
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Add RB from Simon
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

