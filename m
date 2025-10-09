Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12481CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D0B84319;
	Thu,  9 Oct 2025 14:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zirpel.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=zirpel.de header.i=@zirpel.de header.b="VGVk738P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A191844D8; Thu,  9 Oct 2025 12:20:22 +0200 (CEST)
Received: from mail.luflosi.de (mail.luflosi.de [202.61.205.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58734844EC
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zirpel.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukas@zirpel.de
From: Lukas Zirpel <lukas@zirpel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zirpel.de; s=mail;
 t=1760005216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2C/ID/dbKzukpN1zIKyII/qymW6FkN5JR6Ad5Gqw26k=;
 b=VGVk738PNkDj0+mAlNIlOCUzaBHUd5miqbhpafP/2LyLckKOmWzeU5Jg0dOij3nd8xSpkE
 Qhwb3g12/3C0X/7R1PeOuiriP4MItk1IblTxnzmiq7pWFDowWL0EOjZW1BwAT0dDJaW16o
 PPKK7x2Pn8X9o9eD608mXtdAyP2/4bs=
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukas Zirpel <lukas@zirpel.de>
Subject: [PATCH] doc: sandbox: fix typos
Date: Thu,  9 Oct 2025 12:18:02 +0200
Message-ID: <20251009101802.160467-1-lukas@zirpel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Oct 2025 14:58:33 +0200
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

Fix two typos in the sandbox docs.

Signed-off-by: Lukas Zirpel <lukas@zirpel.de>

Cc: Simon Glass <sjg@chromium.org>
---
 doc/arch/sandbox/sandbox.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 7e641306da2..0aad7a57b5e 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -72,7 +72,7 @@ console::
    Err:   lcd
    =>
 
-You can issue commands as your would normally. If the command you want is
+You can issue commands as you would normally. If the command you want is
 not supported you can add it to include/configs/sandbox.h.
 
 To exit, type 'poweroff' or press Ctrl-C.
@@ -634,7 +634,7 @@ There are at least four possible ways to address this:
 * Use the host malloc and free instead of U-Boot's custom allocator. This will
   eliminate the need to annotate dlmalloc. However, using a different allocator
   for sandbox will mean that bugs in dlmalloc will only be tested when running
-  on read (or emulated) hardware.
+  on real (or emulated) hardware.
 
 Until one of the above options are implemented, it will remain difficult
 to sift through the massive amount of spurious warnings.
-- 
2.51.0

