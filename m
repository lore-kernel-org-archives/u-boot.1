Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F139EC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55EC48818B;
	Fri, 22 Mar 2024 08:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AJLMB/4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8606C8812B; Fri, 22 Mar 2024 08:57:41 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E0E880F8
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 175173F3AE; 
 Fri, 22 Mar 2024 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711094258;
 bh=pYpfpw0Zevv9x9UldYYNkz2LLQSu7mDYCpVRZeUQGiQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AJLMB/4+7K/LLkJnLEdEj7sx3IC7g/kWDo8PlxPMLAEy4Sqo5owV+Bu8UsxBG62D9
 YOr6EOc+Qo08rlzNXmqLPzRxHdtYKaG7iMfrG8JE2bMpjyP9rhP7C0IGlLz4hudpZy
 YP6VGHZ3xGvt2IbH+ZEe0HaT/0X2HjauikN/+NVlha8UUEjFEVd24qfv+Ghxr8x0fT
 o2C8eDDXVE3xw701i8Ayip/vvOJyg6k2+SvDJF71SoybTLxpsMsQh1wh2KR1l8Wb7G
 C6DsnEeUbsrXLh50qAcYE2clTfVwHe+v15jPwzbzAryb3ff7NZQdSXaSPD9KdDphR2
 zlUg82JsLIjJA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] doc: man-page for itest
Date: Fri, 22 Mar 2024 08:57:30 +0100
Message-ID: <20240322075731.33390-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Provide a man-page for the itest command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/itest.rst | 113 ++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |   1 +
 2 files changed, 114 insertions(+)
 create mode 100644 doc/usage/cmd/itest.rst

diff --git a/doc/usage/cmd/itest.rst b/doc/usage/cmd/itest.rst
new file mode 100644
index 00000000000..66b466d965c
--- /dev/null
+++ b/doc/usage/cmd/itest.rst
@@ -0,0 +1,113 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: itest (command)
+
+itest command
+=============
+
+Synopsis
+--------
+
+::
+
+    itest[.b | .w | .l | .q | .s] [*]<value1> <op> [*]<value2>
+
+Description
+-----------
+
+The itest command is used to compare two values. The return value $? is set
+accordingly.
+
+By default it is assumed that the values are 4 byte integers. By appending a
+postfix (.b, .w, .l, .q, .s) the size can be specified:
+
+======= ======================================================
+postfix meaning
+======= ======================================================
+.b      1 byte integer
+.w      2 byte integer
+.l      4 byte integer
+.q      8 byte integer (only available if CONFIG_PHYS_64BIT=y)
+.s      string
+======= ======================================================
+
+value1, value2
+    values to compare. Numeric values are hexadecimal. If '*' is prefixed a
+    hexadecimal address is passed, which points to the value to be compared.
+
+op
+    operator, see table
+
+    ======== ======================
+    operator meaning
+    ======== ======================
+    -lt      less than
+    <        less than
+    -le      less or equal
+    <=       less or equal
+    -eq      equal
+    ==       equal
+    -ne      not equal
+    !=       not equal
+    <>       not equal
+    -ge      greater or equal
+    >=       greater or equal
+    -gt      greater than
+    >        greater than
+    ======== ======================
+
+Examples
+========
+
+The itest command sets the result variable $? to true (0) or false (1):
+
+::
+
+    => itest 3 < 4; echo $?
+    0
+    => itest 3 == 4; echo $?
+    1
+
+This value can be used in the :doc:`if <if>` command:
+
+::
+
+    => if itest 0x3002 < 0x4001; then echo true; else echo false; fi
+    true
+
+Numbers will be truncated according to the postfix before comparing:
+
+::
+
+    => if itest.b 0x3002 < 0x4001; then echo true; else echo false; fi
+    false
+
+Postfix .s causes a string compare. The string '0xa1234' is alphabetically
+smaller than '0xb'.
+
+    => if itest.s 0xa1234 < 0xb; then echo true; else echo false; fi
+    true
+
+A value prefixed by '*' is a pointer to the value in memory.
+
+::
+
+    => mm 0x4000
+    00004000: 00000004 ?
+    00004004: 00000003 ? =>
+    => if itest *0x4000 == 4; then echo true; else echo false; fi
+    true
+    => if itest *0x4004 == 3; then echo true; else echo false; fi
+    true
+
+Configuration
+-------------
+
+The command is only available if CONFIG_CMD_ITEST=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) if the condition is true and 1 (false)
+otherwise.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 66d73e70cc4..2f211f748ab 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -72,6 +72,7 @@ Shell commands
    cmd/history
    cmd/host
    cmd/if
+   cmd/itest
    cmd/imxtract
    cmd/load
    cmd/loadb
--
2.43.0

