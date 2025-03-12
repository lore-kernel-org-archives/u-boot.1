Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ED6C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 07:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5760F805D7;
	Wed, 12 Mar 2025 08:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fP/tgRU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361D180756; Wed, 12 Mar 2025 08:37:59 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F3CA801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 08:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4795AA46D8D;
 Wed, 12 Mar 2025 07:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BEAC4CEE3;
 Wed, 12 Mar 2025 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741765075;
 bh=D08SQcuoLr3w8D0XIJYb9tvAMuv+fGG7lj0p4rhaka4=;
 h=From:To:Cc:Subject:Date:From;
 b=fP/tgRU7mgYJ6R12q+wYxY2h7XPtgjRnmKuA65uQUdlt0MSusXxE1XjYaGPikZP0z
 Y1TwZt56Z6GwpnnqmhSk3eH1DpwDZOuh6cINKqah1BEvADEdMVlNRzRr7NiI9NYQpq
 lTIcg2grW7QzacwEn9a0h7NRQNPWL3Rj+e2QH9yCiLhWVlglj6EASWmfqOY5HtcDOw
 7BMyLmo1yovSB5hIwc00I4nyqlbZ8RV/Ji/4qtSi7vdef3d+Ve7mMM5Va09VpROzO1
 lF2Zn4CZJVOrCpfYYnLtWcLLIuW2dNpZdK0+NuF6hfY6C8g2D/nSINa9IoxvILhyui
 r+kwNrrNPeDxQ==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/3] net: lwip: remove superfluous newline at tftp help text
Date: Wed, 12 Mar 2025 08:37:50 +0100
Message-Id: <20250312073750.2281630-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
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

The help text has a newline at the end which will lead to an empty
line after the tftpboot when printing the help overview. Remove it.

Fixes: 4d4d7838127e ("net: lwip: add TFTP support and tftpboot command")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 cmd/net-lwip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 0fd446ecb20..249556243d6 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -17,7 +17,7 @@ U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
 
 #if defined(CONFIG_CMD_TFTPBOOT)
 U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
-	   "boot image via network using TFTP protocol\n",
+	   "boot image via network using TFTP protocol",
 	   "[loadAddress] [[hostIPaddr:]bootfilename]");
 #endif
 
-- 
2.39.5

