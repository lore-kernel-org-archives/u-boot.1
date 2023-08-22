Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFE9EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 10:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC408642D;
	Tue, 22 Aug 2023 12:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dkStUVnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29A486434; Tue, 22 Aug 2023 12:21:23 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E878642B
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 12:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-062-143-244-162.um16.pools.vodafone-ip.de [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 302813F1F8; 
 Tue, 22 Aug 2023 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692699680;
 bh=AB7oEgpQS4fgfjuwecxbn4DirfNEKkAYYgrnL/GP724=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=dkStUVnO04laTo/cdSM8FSpXNfCFrZefab6kjMKuIWTxakVh4JAAmHJfqAXB7IROl
 jPJXs0pVgE6Kn+cG95Vatl8XGTo82w08xrhOfJC3xYmXCdGcjfQNYAnftJIeQRmUlK
 CjKB6wACMJCWe2TSnXN5ZY5QksDACVrUsHYn4Cq3e1jY5N8zTZ3a+CQfYaAIQYwnl7
 Lncpdl6HH/VK6EtFxUBjzBmGhXGEmqzLk+kxKW9j6UkhUV2NtD2hSIqzBCK560oahA
 4LkjcLv7SQRuno37Fl/MXUFTihtIz2TbAKtnXNQuz1d7ul7E0aQpcW6GXunqj/+VZ1
 h5oRmn6NcBeug==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Roland Gaudig <roland.gaudig@weidmueller.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: setexpr: fix printf_str()
Date: Tue, 22 Aug 2023 12:21:13 +0200
Message-Id: <20230822102113.129996-1-heinrich.schuchardt@canonical.com>
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

If vsnprintf() returns a negative number, (i >= remaining) will
possibly be true:

'i' is of type signed int and 'remaining' is of the unsigned type size_t.
The C language will convert i to an unsigned type before the comparison.

This can result in the wrong error type being indicated.

Checking for negative i should be done first.

Fixes: f4f8d8bb1abc ("cmd: setexpr: add format string handling")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/printf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/printf.c b/cmd/printf.c
index e024676743..9d30678188 100644
--- a/cmd/printf.c
+++ b/cmd/printf.c
@@ -144,10 +144,10 @@ static void printf_str(struct print_inf *inf, char *format, ...)
 	i = vsnprintf(inf->str + inf->offset, remaining, format, args);
 	va_end(args);
 
-	if (i >= remaining)
-		inf->error |= PRINT_TRUNCATED_ERROR;
-	else if (i < 0)
+	if (i < 0)
 		inf->error |= PRINT_CONVERSION_ERROR;
+	else if ((unsigned int)i >= remaining)
+		inf->error |= PRINT_TRUNCATED_ERROR;
 	else
 		inf->offset += i;
 }
-- 
2.40.1

