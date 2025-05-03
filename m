Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CD8C369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 10:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9339F820E2;
	Sat,  3 May 2025 12:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t8B82Sc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CC68210D; Sat,  3 May 2025 12:12:44 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9331881F7B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 12:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-064.46.114.pool.telefonica.de
 [46.114.111.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A660E3FF63; 
 Sat,  3 May 2025 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746267161;
 bh=FwLfRHV2Vknjj2oluUJ+GbNcmFTJrNcT+Pu3lPnQKdk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=t8B82Sc1yd1grNTq+JgLke1CihgdY7qlxKlT3KfQ0yHZPaU3iTbsJMUN99Sp1DAFq
 orHh4Yrz3zzL+uCXD5cKQ4I+Ij588RVkonYQV2eUxjSpOuX6BAY6JrZrrpvXbUqjT5
 HFUOSClJCPxvKyOXQFU++MLW1rgjZvp5iN81R1oP/+SS/HVfyHMtaFmgI7/C0eKTWF
 /cX0tOuCOObuycw0kkdn3PZ7RRrNDPXA7qHmnt5frBD/mEO1mG4Z6DO6ZSrLbehhop
 e9Upuntn09Uyxf8Y9ieAcRrETB8c66LrPCjxOcjGKr/tBbTe31MpqM7dNgFPaOkb9M
 fV6qfaxMdC8EA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: u-boot-test-reset: mention power cycling
Date: Sat,  3 May 2025 12:12:37 +0200
Message-ID: <20250503101237.48135-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Using power cycling is a valid option to implement u-boot-test-reset.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/py_testing.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 824e3c0d9a7..33103bbd650 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -377,7 +377,8 @@ this script again to restore U-Boot to an operational state before running the
 next test function.
 
 This script will likely be implemented by communicating with some form of
-relay or electronic switch attached to the board's reset signal.
+relay or electronic switch attached to the board's reset signal. Power cycling
+is another option.
 
 The semantics of this script require that when it is executed, U-Boot will
 start running from scratch. If the U-Boot binary to be tested has been written
-- 
2.48.1

