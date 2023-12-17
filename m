Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDE6C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 11:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE6C587705;
	Sun, 17 Dec 2023 12:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QRkwgjM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E05487719; Sun, 17 Dec 2023 12:45:07 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9385B87702
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 12:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 96F013F94A; 
 Sun, 17 Dec 2023 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702813504;
 bh=tPENiPZJVLoXSuMWn7gSjpYswWWAJtGMXR+Z6knp92M=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=QRkwgjM4NE2chSngc+DMr+pIo7P/LXJbwt9RC0LG2+SG2zPSiR0GfLTwK0nkr8pgP
 F1zZCirj0so/AEloO6/9N6G8aBK/513wbYC8/9Bn9KvsLbVEQ3J7n8jNgHfiQ9iUeO
 S5vFTSZCf/AizB262FfNbYoFPyp+ouySwmi0rirRnvoLHnzXLzISaM8WLW0Ntx59JC
 DdEHkRN4lDZFJuhWtn88l6YZ2jBdI1b3k2Fzn2+Y5pQvP7bL2M01vSrhZu8nCXYr45
 ZsAmwtGH6+HCEMsgG5WM1ob4jok4BYUCjrSPKKxBIFNXxUinNzlAw5QQdzWvS9Abut
 jnfdgM8+7f2ZA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: CONFIG_CMD_BOOTEFI_HELLO_COMPILE dependencies
Date: Sun, 17 Dec 2023 12:44:57 +0100
Message-Id: <20231217114457.70128-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

CONFIG_EFI_LOADER cannot be chosen for ARM v7m. Remove the superfluous
dependency on CONFIG_CPU_V7M=n.

Fixes: b20bb09b2108 ("efi_loader: restrict EFI_LOADER to armv7 and armv8 on ARM")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 748b959961..0ae5bcd981 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -373,7 +373,7 @@ config CMD_BOOTEFI_BOOTMGR
 
 config CMD_BOOTEFI_HELLO_COMPILE
 	bool "Compile a standard EFI hello world binary for testing"
-	depends on CMD_BOOTEFI && !CPU_V7M
+	depends on CMD_BOOTEFI
 	default y
 	help
 	  This compiles a standard EFI hello world application with U-Boot so
-- 
2.40.1

