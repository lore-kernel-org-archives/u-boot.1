Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21098C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B13886F3;
	Tue, 11 Jun 2024 16:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="J8gAyXr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2A9886F7; Tue, 11 Jun 2024 16:40:39 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F24886DF
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0ACD71484FF2; Tue, 11 Jun 2024 16:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1718116836; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=TTqANAtwYRgjPnRo957YDCKN22iGVMTMq3o/kApRx1U=;
 b=J8gAyXr81cu0whh+khCe2wMBh8WcSTLMMXhsCRF/J0VJzKIZ1gIabudIRI8aCvqZ44zOXP
 4O1RNA5uKinPbki2akV8HPv8ur05DWUV4zUdSD52AZvoqdnaIejFRdWB5KAQaJ5BS2VWFk
 +g0gMwAa1uP3Yg052velKsgHLkbiiePBkvI6NpL13a5osikHQLzEzNZV0ylqWPFzlPkisL
 ln9QrZed8xHjHhCRICGMUWXuQ1+MKx9kJjKL3a4TkpPRrNmOmrnBY3N15/0VxQmrURKb4u
 Zu12dTy1RyCyNTLPS817mja6dAqYjsUWSdq4GiKuCXPKcV50Xxa4aPu5lAOrwA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: Fix link reference to general verified boot docs
Date: Tue, 11 Jun 2024 16:40:31 +0200
Message-Id: <20240611144031.1311008-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
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

Fixes: ad29e08b79fd ("doc: Bring in FIT signature files")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 doc/usage/fit/signature.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index 03a71b5192d..b868dcbf9fd 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -15,7 +15,7 @@ that it can be verified using a public key later. Provided that the private
 key is kept secret and the public key is stored in a non-volatile place,
 any image can be verified in this way.
 
-See verified-boot.txt for more general information on verified boot.
+See :doc:`verified-boot` for more general information on verified boot.
 
 
 Concepts

base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
-- 
2.39.2

