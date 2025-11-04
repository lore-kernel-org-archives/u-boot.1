Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B7CCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770EF8390D;
	Tue,  4 Nov 2025 11:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="G5GVZzfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C4E83984; Tue,  4 Nov 2025 11:06:51 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7761883968
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 121EE1A186A;
 Tue,  4 Nov 2025 10:06:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D55AA606EF;
 Tue,  4 Nov 2025 10:06:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1A51A10B50AE9; Tue,  4 Nov 2025 11:06:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762250808; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=heGstLNgoO3v5b9X+baWgC7MAiwaVlsdVeZ2O74Dh2I=;
 b=G5GVZzfrS08QSnqnUFLNrSZ9IaX/DEn8a+pBwoihLLgg/eW92RsZdTaZrqBxyTxZV5LrR9
 z34DlhT++cZC/0U37I4wtYSVGwgNj3OrM5BTxPU/iCgHm7+zJv5/TQOYKR8kzPve+T5tut
 l9IT/XRHQ8v4SPBQuxZDGG6FTPb9xewakZRcDbW+obGRpT6pu7ateiRJUQmWCw+tBsrLHR
 oCfI4+bOLL1Hn8VR9sbtpnwFUK1vB/bLUHsce0ehST3wS8EKys8rw0Dozl6kgJy26fg1J0
 ZprM/WKqWh1AurklVXCdwBTAtdMfYq7E7C+qMe9WJWCNwkF+MC6Y00t1duh+wg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH] doc: bootstd: Remove extension support from TODO list
Date: Tue,  4 Nov 2025 11:06:38 +0100
Message-ID: <20251104100639.1031962-1-kory.maincent@bootlin.com>
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

Now that extension support has been added to extlinux and efi bootmeths
we can remove this line from the TODO list.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 doc/develop/bootstd/overview.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 0a237359575..6cf3b48efca 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -836,7 +836,6 @@ To do
 
 Some things that need to be done to completely replace the distro-boot scripts:
 
-- implement extensions (devicetree overlays with add-on boards)
 - implement legacy (boot image v2) android boot flow
 
 Other ideas:
-- 
2.43.0

