Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF15FCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21F5848D8;
	Mon,  1 Jun 2026 15:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="PLeXOV+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F7F848D2; Mon,  1 Jun 2026 15:14:04 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01D4848BF
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 07CC8B005B2;
 Mon,  1 Jun 2026 15:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1780319641;
 bh=N/QxShSTiLHwEKOOFNYXe+2ZydFE4lFvBmOfc7O91Ck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PLeXOV+ads61ebC75C47brD8K2jXUTL2jkX1YN4qcEpOra6GSPMD0s4H73cMfpeqO
 TZxPevfpaNPgmBk2J/dZ4GHDooQ3ccAvIPKa1vj31tEbclgd5hbnkWxQek1ytt3FFE
 2qHdoo+tWeApxFdZIwUXYv7i7elxynAxHLVYHs+1e+Yd+q+BkxAt4p9x+pFbztzcFz
 dwlFPuFKdHdleKXHGrVHR2NVqylPIW1zQsKOQ9fsWERtpJo7A5QM2989dBDKRtazTu
 X88fd3tp840WcjfOMCag4STFEtMxYyOjHGzCJYJsau7/Y3LZthLMwrNI3UpO7UrbOF
 9mgK6AJl6EAWQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] doc: usage: cmd: load: null-block-device
Date: Mon,  1 Jun 2026 15:12:03 +0200
Message-ID: <20260601131311.1163914-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601131311.1163914-1-vjardin@free.fr>
References: <"<20260511115340.675883-1-vjardin@free.fr>">
 <20260601131311.1163914-1-vjardin@free.fr>
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
---

(no changes since v1)

 doc/usage/cmd/load.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
index bfa45c6f36c..5d7abdd30f3 100644
--- a/doc/usage/cmd/load.rst
+++ b/doc/usage/cmd/load.rst
@@ -63,6 +63,43 @@ Example
     16 bytes read in 1 ms (15.6 KiB/s)
     =>
 
+Null-block-device interfaces
+----------------------------
+
+A few ``<interface>`` values do not name their block device. Their
+filesystem implementations call directly a back-end (JTAG
+debugger, UBI volume, host running U-Boot under sandbox, ...)
+and ignore the ``<dev[:part]>`` argument. The fstype info table marks
+these with the internal ``null_dev_desc_ok`` flag; the dispatcher in
+``fs_set_blk_dev()`` routes them by name before any block-device
+lookup is attempted, so ``load <iface> - <addr> <filename>`` works.
+
+semihosting
+    Read files from the host filesystem of an attached JTAG debugger
+    via using the ARM semihosting protocol. Useful with OpenOCD.
+    Built when ``CONFIG_SEMIHOSTING=y``.
+
+ubifs
+    Read files from a UBIFS volume that has already been attached
+    and mounted with the ``ubi part`` + ``ubifsmount`` commands.
+    Built when ``CONFIG_CMD_UBIFS=y``.
+
+sandbox
+    Read files from the host filesystem the sandbox binary is
+    running under. Built on a sandbox build (the sandbox fstype
+    is registered with name ``sandbox`` and ``null_dev_desc_ok =
+    true``).
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

