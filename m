Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34000E784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD71871B0;
	Mon,  2 Oct 2023 17:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g0HOkj8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8952487195; Mon,  2 Oct 2023 17:22:00 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0C5871A8
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id AA1706607313;
 Mon,  2 Oct 2023 16:21:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260118;
 bh=4mtG7Xvp6AoGG6oGrW0oJMg6BUPOq0XV5RzEHqakux0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g0HOkj8cg4TOq4p0oiVDkZ7TFmSxjGoJ1FdO7HsMUsDTh+xNXUDcrqDzHR3cezqvq
 Ca9XP6wPVZeEx8dMgQHvbTY+qNHfz8Otg9qTrxLMmnUAl/cckMdtaAadyKSliLKfkF
 CRM+4DlVeRwZamzSvwDUkGpyRco4A/aoXL2hNEDmc2GhXawA4UIK8KSA3QJjRwR0VM
 0wWtqoE7P/4Efw3jI4Xg2F+5zEyEx/H5dpfcZinNY5aS/s0wsN1a/+Hkruea6skbzW
 sDCea+rOntqYnGDjITXT+Fti3Rpe5X2J8CQHOKsV3EefJR63tyIMIdDfj+YMpNxui6
 ABUeS9dXcQ40w==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 4/6] sysinfo: Add documentation
Date: Mon,  2 Oct 2023 11:20:08 -0400
Message-ID: <20231002152142.76516-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002152142.76516-1-detlev.casanova@collabora.com>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
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

Add documentation for the sysinfo command with examples.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 doc/usage/cmd/sysinfo.rst | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 doc/usage/cmd/sysinfo.rst

diff --git a/doc/usage/cmd/sysinfo.rst b/doc/usage/cmd/sysinfo.rst
new file mode 100644
index 00000000000..1660b2aa1a6
--- /dev/null
+++ b/doc/usage/cmd/sysinfo.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+sysinfo command
+===============
+
+Synopis
+-------
+
+::
+
+    sysinfo id <varname>
+    sysinfo model <varname>
+    sysinfo revision <varname>
+
+Description
+-----------
+
+The `sysinfo` command is used to show information about the running system
+
+The `sysinfo id` command prints or sets an environment variable to the board id
+as an hex value.
+
+    varname
+        an optional environment variable to store the board id into.
+
+The `sysinfo model` command prints or sets an environment variable to the board
+model name as a string value.
+
+    varname
+        an optional environment variable to store the board model name into.
+
+The `sysinfo revision` command prints or sets an environment variable to the
+board revision in the <MAJOR>.<MINOR> format, where MINOR and MINOR are int
+values.
+
+    varname
+        an optional environment variable to store the board revision into.
+
+Examples
+--------
+
+::
+
+    => sysinfo id
+    0x0b
+    => sysinfo model
+    Renesas Starter Kit Premier board rev 2.1
+    => sysinfo revision varname
+    => env print varname
+    2.1
+
+Return value
+------------
+
+The return value $? is set to 0 (true) if the command succeeded. If an
+error occurs, the return value $? is set to 1 (false).
-- 
2.41.0

