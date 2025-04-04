Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B99EC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 12:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0F582948;
	Fri,  4 Apr 2025 14:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADFB82958; Fri,  4 Apr 2025 14:54:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6A5A6828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 14:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080231515;
 Fri,  4 Apr 2025 05:54:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.14.224])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 859FA3F59E;
 Fri,  4 Apr 2025 05:54:02 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] cmd: optee: fix hello subcommand argument check
Date: Fri,  4 Apr 2025 14:53:58 +0200
Message-ID: <20250404125358.538120-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When the `optee hello' subcommand is called, the do_optee_hello_world_ta()
function passes a NULL pointer to the strcmp() function while verifying its
input argument, which results in the following crash:

  => optee hello
  "Synchronous Abort" handler, esr 0x96000010, far 0x0

Fix this by verifying the number of input arguments instead.

Fixes: e3cf80fbe02d ("cmd: Add support for optee commands")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/optee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/optee.c b/cmd/optee.c
index d0d37293986..e3aae5e9f9b 100644
--- a/cmd/optee.c
+++ b/cmd/optee.c
@@ -53,7 +53,7 @@ static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int ret, value = 0;
 
-	if (strcmp(argv[1], NULL))
+	if (argc > 1)
 		value = hextoul(argv[1], NULL);
 
 	ret = hello_world_ta(value);
-- 
2.47.2

