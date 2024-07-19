Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EACAC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D5088B9E;
	Fri, 19 Jul 2024 12:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eRn1RMyE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nwy3skP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4B788B87; Fri, 19 Jul 2024 12:30:29 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C906788B8A
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WQQtC47gWz9sjL;
 Fri, 19 Jul 2024 12:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RbhfCNPBfBWGO8rRKE4cNM9wLT6ZrMxv/WSDcUXajA=;
 b=eRn1RMyEgfkFeqkY9Y8hZktqRTvMmIE+o8S/znB1TtgqhZmEK2Vh3O1z+5Vi9MBy22wQwR
 rLMNSe5sgM1k5ei9BFyVhFV5ZA3/qjWQUDc+cmK0m+wOHl2Rw3rt1KzMgonA2u31Ew6486
 UevMYz13DqE3VOraRpnTlQAIl6YmHXQ+1K2IdGTj9R+u+3skM4UqhrkAAyLaNH7kPp2hA0
 pcLfI+wu4bLQgGF9pBDFTLidyFYsI+V01UtkW0cjtPeANSk8CGypAkH1/7Vf4ybth0cD3g
 rZjwofvC6qINJCNe9zldHbCKGaVnjO5+PBGYZwDopUFU/wTk0oJg3lyA/g2PgQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RbhfCNPBfBWGO8rRKE4cNM9wLT6ZrMxv/WSDcUXajA=;
 b=Nwy3skP6jQCQWsnv6W4MbaNBR/s6tqiBhlAcVzExULYDXO/SFhAQBTQclLXM2BfyJ2Bn9B
 KVr8foWCiv45jAI1H4Uwat8OKNUnr/I5hz6gKMLxdI6Mun/esE7i4i2aPdy5SU1oMeV/rp
 J1mg9n46YTpd3JzGc55ct9u3Rs89EfgUSDLualKDT14F3jtrCBmtRHQSkTkbUBws8B8PJG
 EfgTBWav2KsZEEbA3TA35DZmfTaAjKislwGczNXdfDM1rlH58oFIJ7OFYtvxLTnNS+e6GT
 ImivU9O9i3AmrSmKQU+zP2vv+8Mt+oCp0StHYommggNgSeDOoOEL37U0ces9vw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/37] board: engicam: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:08 +0200
Message-ID: <20240719102934.322997-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jgwrjm4trn45xiakxrd1j44prrysooxq
X-MBO-RS-ID: e4a60702088b02250fc
X-Rspamd-Queue-Id: 4WQQtC47gWz9sjL
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/engicam/imx6q/imx6q.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/engicam/imx6q/imx6q.c b/board/engicam/imx6q/imx6q.c
index d799fe6526a..a8d54128476 100644
--- a/board/engicam/imx6q/imx6q.c
+++ b/board/engicam/imx6q/imx6q.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <linux/sizes.h>
-- 
2.43.0

