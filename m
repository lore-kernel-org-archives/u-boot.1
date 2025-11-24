Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A26ACFD340
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 18:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF6A83EAE;
	Mon, 24 Nov 2025 19:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cyberdimension.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cyberdimension.org header.i=@cyberdimension.org header.b="iGH+x5L/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFC283EB3; Mon, 24 Nov 2025 19:16:23 +0100 (CET)
Received: from rockpro64.cyberdimension.org (cyberdimension.org
 [IPv6:2001:678:938:3ff::36])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0A183E9F
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 19:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=cyberdimension.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=GNUtoo@cyberdimension.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=dkim; bh=a1ob/l/oo+mCbbR
 GacQ9Ei+SqZx5MAyciDzdHSkZows=; h=date:subject:cc:to:from;
 d=cyberdimension.org; b=iGH+x5L/fJJjxXVM2wDwwn0VsSaVDYFbWvFyzweGxavWSK
 adWuqgP7fSPceFoX2gXcTrUKaWtjVYzV1PClDTbuZWGXkbf1PGL4fDjco9+CKmYuFCqkBr
 1vjEGvO0Yxc+LnW44NPfHEt+drnGtH9c87x7QQEvymQvysJcLZ1v3w5P2P1GaGAvkZFcYK
 G0Okt/obiYU6KBnrCfy2ySrLOCMEbR8uHBR7letEUvFbpuGap+M4e0B+JTi9yBq8012brS
 ESFONLPd7K/iNq4f1XGa4/p3YevkxVI30Q2Mrm8ATxIrg+G1LSnqrqAv5ItnGvdvueky2q
 DyDg8mlgYDxF7aKA==
Received: from primarylaptop.localdomain (localhost [127.0.0.1])
 by rockpro64.cyberdimension.org (OpenSMTPD) with ESMTP id a13154d5;
 Mon, 24 Nov 2025 18:16:20 +0000 (UTC)
From: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Leah Rowe <leah@libreboot.org>,
 Sean Anderson <seanga2@gmail.com>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: [PATCH v1] test: correct strlcat license information
Date: Mon, 24 Nov 2025 19:16:11 +0100
Message-ID: <20251124181611.8150-1-GNUtoo@cyberdimension.org>
X-Mailer: git-send-email 2.51.0
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

The GPL-2.1 isn't a valid license.

The copyright header says that "These tests adapted from glibc's
string/test-strncat.c" and test-strncat.c is under the LGPL-2.1+.

This was reported to us by Leah Rowe.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
---
 test/lib/strlcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
index d1a0293271b..70982d5cd68 100644
--- a/test/lib/strlcat.c
+++ b/test/lib/strlcat.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.1+
+// SPDX-License-Identifier: LGPL-2.1+
 /*
  * Copyright (C) 2021 Sean Anderson <seanga2@gmail.com>
  * Copyright (C) 2011-2021 Free Software Foundation, Inc.

base-commit: 4a4871e3dc38f3f771d2713b805e79e6191b4297
-- 
2.34.1

