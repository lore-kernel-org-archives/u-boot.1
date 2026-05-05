Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99308FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 09:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B013846B1;
	Tue,  5 May 2026 11:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="PmssVbuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D723E84877; Tue,  5 May 2026 11:14:42 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7AD846B1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8tBS1yy7z7Tt;
 Tue,  5 May 2026 11:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777972480;
 bh=84hrh3g9PJB/sCxZY9FG14DMpptDObciSi+ZiHCh5xQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PmssVbuFkOpeu1VFI1jvloiOsw7bdiRIdu0mYrs0WkhFu329kejeXzmB6RaEWp63B
 s9W85FD4lm4Lm7bQptYbVqMUC92QoXmINk+bQR5v8v07HffdbqSH6F60pJyBXxiJ9x
 OLkPEomfJZMXJxZWZoDSegOD4cSxTWhp2Hmp5aQG2nuKd4qSoeynBqOtSBepmqNO5X
 UM8/OyGEBXvmQeCSnfhplMxkGT0ykO1cssDEaqKS/9uNvP90O4pGZ0iE1Gy4qqTLP+
 p2s+3NrhBYyExsBZKBzvjY6x41vrz3T95mFy6UdLpIVIJJUp/CInf+VIHAPsuwkCbK
 p5VFeLvMFkhYA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8tBR4L97z519; Tue,  5 May 2026 11:14:39 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 05 May 2026 11:14:31 +0200
Subject: [PATCH v3 1/2] cmd: ufetch: show net feature when NET_LWIP is selected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ufetch-net-v3-1-eee5eb9ca5ce@cherry.de>
References: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
In-Reply-To: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

We've had a new lwIP networking stack for a couple of years already, so
let's show there is a "net" feature if it's selected. Since NET_LEGACY
|| NET_LWIP is the same as NET, let's check on NET.

Reported-by: Simon Glass <sjg@chromium.org>
Closes: https://lore.kernel.org/u-boot/CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com/
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index f8dc904bdd0..bc5db08eee1 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -159,7 +159,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		case FEATURES:
 			printf("Features:" RESET " ");
-			if (IS_ENABLED(CONFIG_NET_LEGACY))
+			if (IS_ENABLED(CONFIG_NET))
 				printf("Net");
 			if (IS_ENABLED(CONFIG_EFI_LOADER))
 				printf(", EFI");

-- 
2.54.0

