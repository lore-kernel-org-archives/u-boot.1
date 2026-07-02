Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEAEC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5493184A78;
	Thu,  2 Jul 2026 16:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="HnbkbeqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA47846F8; Thu,  2 Jul 2026 16:44:38 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C3284A86
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 22AB1B005A9;
 Thu,  2 Jul 2026 16:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783003475;
 bh=40xAjtoCYbmqtfWDC1vnwl63DoGNTq/2RC0+D/PdC7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HnbkbeqLnSHJFwLymnTy/UP+r75vMTfj7pb3yZ3ycOYFsJ3+/pemKyB1VhuZRV6NI
 Bq2oPZYz75x0NQWOtcy2WGIBnXwCMsfgzO8XqF0IfOTEdjm+mUOWuPNifmtQBCl1dj
 dnpt4AupHAAcDmFx/o8ZSHvoUfQsIda3sW6CzjM1qD/khnSOINr0+rGDefPG5ExSQu
 Pa7AolGI577cBRDR/3r1AOc7BGAE7W7e9Tfbni+ZhNzY9rJQTxJs7w1r2n/W0lvg0V
 bI+/y7x2jTrsq+ZiVtsftVLNJpEv8jPUP4XY8mnoKWplpDBUVEBNmRN62I6ac0KTWk
 7mRbYHTPi02hw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/3] doc: usage: cmd: load: null-block-device
Date: Thu,  2 Jul 2026 16:42:13 +0200
Message-ID: <20260702144359.1583239-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702144359.1583239-1-vjardin@free.fr>
References: <"<20260601131311.1163914-1-vjardin@free.fr>">
 <20260702144359.1583239-1-vjardin@free.fr>
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

Document the dispatch path added by the former commit

    fs: dispatch null_dev_desc_ok filesystems before lookup

Add a null-block-device interfaces section that:

  * lists the three fstypes that can benefit of it (semihosting, ubifs,
    sandbox) and the CONFIG option that builds each
  * explains the '-' convention for the unused <dev[:part]> field

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/usage/cmd/load.rst | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
index bfa45c6f36c..bf2fffbed21 100644
--- a/doc/usage/cmd/load.rst
+++ b/doc/usage/cmd/load.rst
@@ -63,6 +63,39 @@ Example
     16 bytes read in 1 ms (15.6 KiB/s)
     =>
 
+Null-block-device interfaces
+----------------------------
+
+A few ``<interface>`` values have no underlying block device. Their
+filesystem implementations directly call a back-end (JTAG
+debugger, UBI volume, host running U-Boot under sandbox, ...) and
+ignore the ``<dev[:part]>`` field, which may be given as ``-``. So
+``load <iface> - <addr> <filename>`` works.
+
+semihosting
+    Read files from the host filesystem of an attached JTAG debugger
+    using the ARM semihosting protocol. Useful with OpenOCD.
+    Built when ``CONFIG_SEMIHOSTING=y``.
+
+ubifs
+    Read files from a UBIFS volume that has already been attached
+    and mounted with the ``ubi part`` + ``ubifsmount`` commands.
+    Built when ``CONFIG_CMD_UBIFS=y``.
+
+sandbox
+    Read files from the host filesystem the sandbox binary is
+    running under. Available on sandbox builds.
+
+The ``<dev[:part]>`` argument is conventionally written as ``-`` for
+these interfaces, to make it visible at the call site that the field
+is unused. The filesystem layer never looks at it.
+
+Example::
+
+    => load semihosting - ${kernel_addr_r} kernel.itb
+    9437184 bytes read in 412 ms (21.8 MiB/s)
+    =>
+
 Configuration
 -------------
 
-- 
2.43.0

