Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C573CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 16:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 228A780422;
	Wed, 22 Oct 2025 18:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sNVliTSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E048781E13; Wed, 22 Oct 2025 18:13:09 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C966E8003E
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 18:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6746A4E4127D;
 Wed, 22 Oct 2025 16:13:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 31B09606DC;
 Wed, 22 Oct 2025 16:13:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E95BA102F2448; 
 Wed, 22 Oct 2025 18:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761149586; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=FffklfEvHTo2M6zgNp8e3YbntoRggqviI1ItggmsTLk=;
 b=sNVliTSkRpDQ+lwTcW2ticG7I8qohLvFh60pn6U/GXtC9LyKD4gsyNOofBKrsRAgNDQF0i
 pYtATQbuvyL3FLCI0udxUgEoW2X/yCIL0jcNsc6btOVE2dMXwHUsFnbhnnbIJC9739CEpy
 iXLaKfBAoR9tTuSM1aqBe5rHy+kr70foo0SiUiRc+6EevVwetFCArcVV8xdzAnyBVdfRKT
 KwWXnYjMayHRPGHOiswHVhCd0Y3eS4A6uoIMkgBINu8sp2XFVfVjQKBIkwp0TCZbVJUGU8
 NzFFRIElVbPXA4Ty+8tpl3OKuECLyR1ikmbqy2peN3OiyoF6C6t99iTTbHZshA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH] test: py: Add pyelftools dependency for test_event_dump
Date: Wed, 22 Oct 2025 18:13:00 +0200
Message-ID: <20251022161301.893395-1-kory.maincent@bootlin.com>
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

The test_event_dump test requires pyelftools to run.
Add this missing dependency to requirements.txt to ensure the test can run
successfully.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 test/py/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 804a427b351..6d7909cb919 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -3,3 +3,4 @@ pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
 FATtools==1.0.42
+pyelftools==0.32
-- 
2.43.0

