Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E5FC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 15:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357FD87E93;
	Mon, 26 Feb 2024 16:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="oei0YEBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0D587F1E; Mon, 26 Feb 2024 16:46:48 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758A987E93
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 16:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1708962405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=4f2xmsyxS1GXV2QEd+pNOuApRky5JM5/soMqtXXSFJA=;
 b=oei0YEBns3qEqvDzbalLNq6fABoTokSZUsZRTSR3qci85ZEmDEk+twpSJ8rk3Crd4y5At2
 2994TTpejh/7I33AxvYZYl7xd6rHkCJyshM7KtnUatmjKgHDn7j2mnuxmLsI41nAIvMSGg
 o/9jSm5XNmGpn/yecyTYMpbQ1SDpkuUagOkZxDOLD/yCtK4Ce0JkbNnS96HqMk9TOdAD8B
 25FAXgVMvLfyw9Ny1SiR0o49Pkk9uLraNGTQf2PfgpAz5nSSiKTPYpArn+NLogAWJ5aVHB
 ZQVHZGUCkLXH2sAbezCOM1T75jHWOq2moX+yswA1foTjbqWrrs2NmfDUEyOPyA==
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: develop: commands: Fix function prototype
Date: Mon, 26 Feb 2024 16:46:43 +0100
Message-Id: <20240226154643.218732-1-ada@thorsis.com>
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

When using the previous prototype you got a compiler warning like this:

    warning: initialization of 'int (*)(struct cmd_tbl *, int,  int,  char * const*)' from incompatible pointer type 'int (*)(struct cmd_tbl *, int,  int,  const char **)' [-Wincompatible-pointer-types]

Fixes: 3d9640f55cb2 ("doc: expand README.commands")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 doc/develop/commands.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/commands.rst b/doc/develop/commands.rst
index ede880d248c..5ad4e59c838 100644
--- a/doc/develop/commands.rst
+++ b/doc/develop/commands.rst
@@ -88,7 +88,7 @@ The command function pointer has to be of type
 
 .. code-block:: c
 
-    int (*cmd)(struct cmd_tbl *cmdtp, int flag, int argc, const char *argv[]);
+    int (*cmd)(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 cmdtp
     Table entry describing the command (see above).

base-commit: 1a66a7768af7e8106c2cd93a19f4013877fb85ae
-- 
2.39.2

