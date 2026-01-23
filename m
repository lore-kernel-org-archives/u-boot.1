Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2436D6CFAE
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 02:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AAB983B63;
	Fri, 23 Jan 2026 03:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="g2khJMYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3218E838FA; Fri, 23 Jan 2026 03:26:21 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A17839DF
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 03:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E9C5510F127; Fri, 23 Jan 2026 03:26:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769135162; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=hz8Hm0q/MJJahGHtOycAo70QaYMr9W71Aaq26nv7HvU=;
 b=g2khJMYSWECH1X3eaaXoHoZR/V4Wme8lW1joZdKXCbQj6EIy7tpztISw56k9urr2cg7/En
 GVeV48P/2SV582ky2AlVkAHph/p465zVIHI5v0hXy7gbTnM181Qo91e5PMYBl5cuQUk7Fe
 ZXMhnfOADdE5vjbPmmTXT/AlVy8REzIWH1DVl/pg/lCWf+7cF/kTrn7nal7d79Zk4kO13b
 +1PVe/uICDluvTIq64pfIMeXsrL2rosjS0BiKIBuRhhVB3t4iKs1Lm2b+yNr68rOa2XiF4
 2Gk27MhzZ3l9ypByDtPZaJbbM8Xe3AhjHfa24g4u+OdUOlnh5jzj0bbvg/BewQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 2/2] doc: cmd: add documentation for sm3sum
Date: Fri, 23 Jan 2026 03:25:52 +0100
Message-Id: <20260123022552.100884-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260123022552.100884-1-hs@nabladev.com>
References: <20260123022552.100884-1-hs@nabladev.com>
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

add documentation for sm3sum command.

Signed-off-by: Heiko Schocher <hs@nabladev.com>

---

Changes in v2:
Added comments from Quentin
- fixed typo in commit subject
- fixed a lot of style and spelling issues
- added in parameters section the format of the input values
- removed section "Return value"

 doc/usage/cmd/sm3sum.rst | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 doc/usage/cmd/sm3sum.rst

diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
new file mode 100644
index 00000000000..2a3ee456395
--- /dev/null
+++ b/doc/usage/cmd/sm3sum.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright Nabla Software Engineering GmbH
+   Written by Heiko Schocher <hs@nabladev.com>
+
+.. index::
+   single: sm3sum (command)
+
+sm3sum command
+==============
+
+Synopsis
+--------
+
+::
+
+    sm3sum - compute SM3 message digest
+
+    Usage:
+    sm3sum address count [[*]sum]
+      - compute SM3 message digest [save to sum]
+    sm3sum -v address count [*]sum
+      - verify sm3sum of memory area
+
+
+Description
+-----------
+
+The sm3sum command calculates the SM3 hash of data of ``count`` bytes
+at address ``address``. If the ``-v`` option is passed to the command,
+it compares the calculated hash with the hash found at address ``sum``.
+
+The SM3 secure hash is calculated as specified by OSCCA GM/T
+0004-2012 SM3 and described at
+
+https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
+
+Parameters
+----------
+
+address
+    address from where the sm3 hash is calculated.
+    Hexadecimal string, 0x prefix optional.
+
+count
+    length in bytes of memory area for which the sm3 hash is calculated
+    Hexadecimal string, 0x prefix optional.
+
+sum
+    if it starts with ``*`` the string is interpreted as an address
+    in hexadecimal format to which the calculated hash gets stored.
+
+    else the string is interpreted as a name for an environment variable
+    in which the calculated hash is stored as string.
+
+    or if ``-v`` option is passed:
+
+    address of hash with which the calculated hash gets compared.
+
+Example
+-------
+
+create some data
+
+::
+
+    u-boot=> mw 0x100000000 0x426f6f46 1
+    u-boot=> md.b 0x100000000 4
+    00000000: 46 6f 6f 42                                      FooB
+
+and calculate the sm3sum of 4 bytes starting from address ``0x100000000``
+and store it in environment variable ``hashval``
+
+::
+
+    u-boot=> sm3sum 0x100000000 4 hashval
+    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
+    u-boot=> print hashval
+    hashval=cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
+    u-boot=>
+
+or calculate sm3sum of 4 bytes starting from address ``0x100000000`` and
+store it at address ``0x110000000``
+
+::
+
+    u-boot=> sm3sum 0x100000000 4 *0x110000000
+    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
+
+and now check if this hash is the expected sm3sum hash value with ``-v``
+option
+
+::
+
+    u-boot=> sm3sum -v 0x100000000 4 *0x110000000
+    u-boot=> echo $?
+    0
+
+example with wrong hash
+
+::
+
+    u-boot=> sm3sum -v 0x100000000 4 *0x110000004
+    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7 != e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7ffffffff ** ERROR **
+    u-boot=>
+
+
+Configuration
+-------------
+
+Enable the sm3sum command via Kconfig option ``CONFIG_CMD_SM3SUM``.
+The ``-v`` option is separate enabled through Kconfig option
+``CONFIG_SM3SUM_VERIFY``.
-- 
2.20.1

