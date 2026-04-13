Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0998CEBFD01
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 06:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F24839D5;
	Mon, 13 Apr 2026 08:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jcRJdVWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53DB83F75; Mon, 13 Apr 2026 08:24:48 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95FF8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6113E3F69B; 
 Mon, 13 Apr 2026 06:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776061486;
 bh=twUXIeYefj7YftVyMfLFtR5D+crZO8jBhcbrWMElv0o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jcRJdVWE8FxjdtT2d6N1+iVHTc/FFqd19m1l5+78FRW6ZlTOgbbi0OlPwBWrDGUt1
 ju+53jKTHXxmku2KS0HcyFk71xZFRm1d37rfI4TB6em1LLq4cRwVcp0VgZuz7W0Lkn
 eb5+vITlIyT8OOVecw2sk6X4SPBExGW5YrEpxMfG/Mi7WegfaJvNSaZIeruZ6Z0dOF
 VROMo3aKQ4cIlMEvFYZ2jhZPP6THnvncoCDQCcEG3kMFPq8PSHNEQBjdm+NOiOFstr
 vj5ikeKoCIoeJi/G2/xaAHQ/0II/60XDHqnoK1daap2oujGL+mBMakrQOrIS64BhJC
 uBpzPaP7+Mj0Ff3WDldjZcMTsKRADbCYvhbMrzENO4Ti2B3vZ6r4N4dcdjyBDqXSpR
 FU8ELqgVRk9OE+MzpeXa5lLv9gGQsop6W3QMb+LCFCqbVNWwwXEr93kL+GtybSkOrv
 VrLMKpMuyB/a/B1ZKs398+ZVSk9JR2LiTC13ofBUDQ09VzOmdCZF32+IE6FkT/4KeN
 aPEADjfIorzoFIFNBDuBcTmB09CEgOEB0qtXDxEj7FsEPYi9EKLGMrPi9BszHXTTql
 iDqcPELPzz0FYdegthWUeDN+OP/ikRq7zWFJ7UFb1PU0zgPLg6swlflLpE9gsl4918
 yZUBG2zuK1CS3c5tepeCSIIs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: correct title of CONTRIBUTE.rst
Date: Mon, 13 Apr 2026 08:24:39 +0200
Message-ID: <20260413062439.56470-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The title should be 'Contributing' as this is not the 'Overview' of the
U-Boot project.

The top title should be H1, the other titles H2.

Fixes: 0290cec364f6 ("Add an initial CONTRIBUTE.rst")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/CONTRIBUTE.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index 8ccb3a193da..a47dfdca221 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
 
-Overview
---------
+Contributing
+============
 
 This document is a high level contributors overview setting overall expectations,
 so people can get started quickly, the rest of the documentation goes into the
-- 
2.53.0

