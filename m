Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798D6CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F1B83C64;
	Wed, 12 Nov 2025 14:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Z+Zii8rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B982F83C8C; Wed, 12 Nov 2025 14:16:04 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D0483C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 14:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 97C9C1A1A2C;
 Wed, 12 Nov 2025 13:16:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5D4C06070B;
 Wed, 12 Nov 2025 13:16:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD641102F16E2; Wed, 12 Nov 2025 14:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762953360; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=L9kTIp8Dj0D+NzvPscMGuW+YlVkSCpTiPDyzZnd/n8w=;
 b=Z+Zii8rLYjXs8El4Os2FFfxTljyp/Fjyzfhimfg1P1OR54o34b4SWr83Imizu1pbCbqEp/
 XleKscLqfzrv5G4+F+g7SjNeElf/ghNwSfmhkjyCLdDlknM53KDhIo9zT++lAPasekUU6q
 x584uWTZcCDAIhNvL119Td2hxVbmjmk2yigk5s+GiFg/CYOWWRpwPzj5vhphjKwJ7vyOGR
 KwLEqKtp64j49nhunm3vmWMrS4ZpyEHUqkYxCFgNW2XYArYevMh34yAed5tG2PxTwlJIRW
 ZbMTRNAM9AhL24DQivyy2q+oK0L8MFd+/UruUAzwYsMjaNteutwIZXjSUg0oZw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] cmd: extension: Fix possible null pointer dereference
Date: Wed, 12 Nov 2025 14:07:41 +0100
Message-ID: <20251112130742.97473-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

Add a null check for extension_list before calling alist_get_ptr() to
prevent a potential null pointer dereference. If extension_get_list()
returns NULL, alist_get_ptr() would attempt to dereference it, leading
to undefined behavior.

The fix ensures both extension_list and its first element are checked
before proceeding with the list operation.

Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
Fixes: 2d12958ee71b ("boot: Remove legacy extension board support")
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 cmd/extension_board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 86e4795ba8a..1b92be82611 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -99,7 +99,7 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 	int i = 0;
 
 	extension_list = extension_get_list();
-	if (!alist_get_ptr(extension_list, 0)) {
+	if (!extension_list || !alist_get_ptr(extension_list, 0)) {
 		printf("No extension registered - Please run \"extension scan\"\n");
 		return CMD_RET_SUCCESS;
 	}
-- 
2.43.0

