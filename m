Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A9CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153B687A8B;
	Mon,  8 Jan 2024 18:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="qRcI5CKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D1687A7E; Mon,  8 Jan 2024 18:20:56 +0100 (CET)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8818082A
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.orlov@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pn6ClSdipMY6nE+HhmTgklfhXFS8MZ5AnTS5OKBfDNE=; b=qRcI5CKRy+QiOXajE80foWc6AM
 xtlZ4V2TlPl/l6Dq1uiquHtW1jAXOVux+jnKHX21hYmWsdB36groIA6rPf/+H+M5jqNMBrXTHCTCI
 0qGaTTDVB5PXZwYrRmhOG1GuuRIhUS5o715+Yz8oQHxEGDiZmDcsIqICyDFIBfcdKKo50dB0lB+96
 BSgoCB940kuSsdByVglmUF4tl99kcJxN/G3XYnuoMKKAF0w042pyky8LMPnd2+zmqL+Y+7mzdlHiM
 es9cn5VxC39M1iglIiiXro7RWhFGTnedxBGjvbaq/jbzMK6Ik4Wxsa2iHpGZ7FLiHVtiK8sHTvFIw
 RAN8yWQg==;
Received: from [167.98.27.226] (helo=ct-lt-2504.guest.codethink.co.uk)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1rMtIt-0033Nl-9d; Mon, 08 Jan 2024 17:20:47 +0000
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
To: sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 troykiskyboundary@gmail.com, rasmus.villemoes@prevas.dk
Cc: Ivan Orlov <ivan.orlov@codethink.co.uk>,
	u-boot@lists.denx.de
Subject: [PATCH] cmd: nvedit: Fix typo in 'illegal character' error
Date: Mon,  8 Jan 2024 17:20:45 +0000
Message-Id: <20240108172045.1474962-1-ivan.orlov@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jan 2024 18:29:50 +0100
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

Fix a typo: add a space after the single quote in 'illegal character'
error message in 'env set' command

Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
---
 cmd/nvedit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index daf1ad37f9..7db78848bb 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -233,7 +233,7 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
 	name = argv[1];
 
 	if (strchr(name, '=')) {
-		printf("## Error: illegal character '='"
+		printf("## Error: illegal character '=' "
 		       "in variable name \"%s\"\n", name);
 		return 1;
 	}
-- 
2.34.1

