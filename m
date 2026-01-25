Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31125E63CA5
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 13:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7343583C39;
	Sun, 25 Jan 2026 14:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="sDPA+isI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18E183A36; Sun, 25 Jan 2026 14:13:02 +0100 (CET)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE46183C72
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 14:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout4.routing.net (Postfix) with ESMTP id 77C5710032F;
 Sun, 25 Jan 2026 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769346779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h87HzOjC33bbJH3RgzhKR/UA9+xsrerrLXO3s7wQPvk=;
 b=sDPA+isIR7Q0LqILBaBFe+1i4wX4g9/99FELwCVjUbG+ymK+IikXSrCq25cFLNqjQpgaJ4
 WFJ9E/mp2HhwxtF6tWtZm0x6ZXIxO25duh2ClY90RQtBpkBRHgwowm3S+g8NUEPOdqLrLB
 38Ws6CJG38tgMymGEXxe7kkIkO9uel8=
Received: from frank-u24.. (fttx-pool-194.15.85.69.bambit.de [194.15.85.69])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 602E41226CC;
 Sun, 25 Jan 2026 13:12:59 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v6 3/3] doc: cmd: add usage doc for memsize
Date: Sun, 25 Jan 2026 14:12:53 +0100
Message-ID: <20260125131254.23210-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125131254.23210-1-linux@fw-web.de>
References: <20260125131254.23210-1-linux@fw-web.de>
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

From: Frank Wunderlich <frank-w@public-files.de>

Add documentation for memsize command.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 doc/usage/cmd/memsize.rst | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 doc/usage/cmd/memsize.rst

diff --git a/doc/usage/cmd/memsize.rst b/doc/usage/cmd/memsize.rst
new file mode 100644
index 000000000000..4571795c7b41
--- /dev/null
+++ b/doc/usage/cmd/memsize.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: memsize (command)
+
+memsize command
+===============
+
+Synopsis
+--------
+
+::
+
+    memsize [name]
+
+Description
+-----------
+
+The memsize command shows the amount of memory in MiB.
+Optionally value can be assigned to an environment variable.
+
+Examples
+--------
+
+This first example shows printing of ram size:
+
+::
+
+  => memsize
+  8192 MiB
+
+This second example shows assign ram size to environment variable:
+
+::
+
+  => memsize memsz
+  => printenv memsz
+  memsz=8192
+
+Return value
+------------
+
+The return value is always 0 except error happens on setting environment variable.
-- 
2.43.0

