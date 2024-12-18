Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CECE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F758022B;
	Wed, 18 Dec 2024 20:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j7gSVoxY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DqdEpelg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645DA80291; Wed, 18 Dec 2024 20:42:04 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA038021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YD3wT6CbJz9t2v;
 Wed, 18 Dec 2024 20:42:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734550921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/u2Ri5r6yVEcAvpOt88NzK3bRIKxx3C6XfE7hx2pLk=;
 b=j7gSVoxYukoyiL34d+4oAYFufOnbD84EO+ydc0YCTBXvae1wFUQ/eVx/Urcmy83ZfZ95RO
 WW7JORdqB6PF6e4Sb1wSnsEzYTcXm9eVgpxiTVudf8Pmml1cb7mES0pgHAeGSd3N7p2YAw
 HnNqlc8+NOmf4K6TZAAreLS4vVn2nLW8bdbBPp50VX+b79rxPM8oneboH5yQUs3Vgeciee
 mPLWeRqfshwS+94ZoOpH0AtKMNyLogLCda0hKKIYPJyIM0qhl0TFKXFIe4/y0C0jzojB/+
 NcVO2hOu9/pOYbHiDEoM9fwZdV8wHgcY18Z3aLTAfatJvI2haz8/PXfAiGviCw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734550920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/u2Ri5r6yVEcAvpOt88NzK3bRIKxx3C6XfE7hx2pLk=;
 b=DqdEpelg3BxFKiCQAZuItEBrwfODEvfwe8YWxR4TIWr38Up62ktbkAf9yOvlYQ5FN6QpXp
 Iax0hgxt6N2Rn1vzSjj2p6iJpmT74JalfNisJ9PC8XbYo2G3V0CzkrmSkj8HbU8gprJB6d
 5+YTzz87iooUxELZhsQckCodNl/aULIsVa8R3CBOxop/I1Cu2V/pnrBadsxCd0mEN2+Tzv
 80ns1ZFUCNqMi7qSpg317S22bAyPjGe+SGjCoppjc6H1Pi+eDVsbmz5ZeTc8xVsa7U6/sV
 g0Qx4zi44NCS0oqipr2FyjSonhPg3T/bk6TpwXzDzXu8SxM+H2EoZe7TC+wPug==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: renesas: Enable TFTP_TSIZE on all Renesas hardware
Date: Wed, 18 Dec 2024 20:41:28 +0100
Message-ID: <20241218194143.79136-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iwrn5d4roe54y6p4mjptpze3zsb3sk4o
X-MBO-RS-ID: cd7554e139f8846919a
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

TFTP transfer size can be used to re-size the TFTP progress bar on
single line based on the server reported file size. Enable it by
default for Renesas hardware to avoid long scrolling walls of '#'
character during long TFTP transfers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: I wonder, shall we simply enable this by default ?
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index b4bb68dd613..24508026200 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -90,7 +90,7 @@ config TFTP_WINDOWSIZE
 config TFTP_TSIZE
 	bool "Track TFTP transfers based on file size option"
 	depends on CMD_TFTPBOOT
-	default y if (ARCH_OMAP2PLUS || ARCH_K3)
+	default y if (ARCH_OMAP2PLUS || ARCH_K3 || ARCH_RENESAS)
 	help
 	  By default, TFTP progress bar is increased for each received UDP
 	  frame, which can lead into long time being spent for sending
-- 
2.45.2

