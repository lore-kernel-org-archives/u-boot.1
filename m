Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B868C47BF2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB1D83F86;
	Tue,  6 Jan 2026 15:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="hszHe7/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DA183FAA; Tue,  6 Jan 2026 15:14:26 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3B183F6A
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68071103277; Tue,  6 Jan 2026 15:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767708858; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=IIYdxFnHCzVmlRhTzp1joGT1GB8WSHSbaym9NpLa1T0=;
 b=hszHe7/M0VYBI+UWHo0/LUgmy7IVVv7weAkeYd17DEN+0dCsaEB8GsRHwzP9ZvnvDfbcz8
 KQqL+7UsrF9/1BPihYyT9/nrxA+Lez1LJ8vEc7RFDwkCx8IZ4KD1m+QMdsEGshsO/tSy9Z
 fr50QdI+pZeNO8VGOeywlwhgbVfkPGBh9SOzIBPmPKzlvi4fe65CndpMrj/f09g+6L52z+
 O1XWAWYP9MhfBSiH4a6kSF6l+NuJWumkWb7sZeEjALOlRB+18dt4bTc9dnsTB/CbI+2kaN
 b6IQnHKq66cLrPCyvr+tBpxI6dw3PxHkBnJCmPEpAzIgfOKuTCnabTdvlEXNMA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v1 2/2] doc_ cmd: add documentation for sm3sum
Date: Tue,  6 Jan 2026 15:14:05 +0100
Message-Id: <20260106141405.82637-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260106141405.82637-1-hs@nabladev.com>
References: <20260106141405.82637-1-hs@nabladev.com>
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

 doc/usage/cmd/sm3sum.rst | 117 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 doc/usage/cmd/sm3sum.rst

diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
new file mode 100644
index 00000000000..3b157779a0e
--- /dev/null
+++ b/doc/usage/cmd/sm3sum.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+   Copyright 2025 Nabladev
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
+The sm3sum command calculates the SM3_256 Hash from a
+address with length of count bytes. If the -v option is
+passed to the command, it compares the calculated hash
+with the hash found at address sum.
+
+The SM3 secure hash, is calculated as specified by OSCCA GM/T
+0004-2012 SM3 and described at
+
+https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
+
+Parameters
+----------
+
+address
+    address from where the sm3 hash is calculated
+
+count
+    length in bytes of memory area for which the sm3 hash is calculated
+
+sum
+    address of hash to which the calculated hash gets stored
+
+    or if "-v" option is passed:
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
+    u-boot=> mw 0x0000000100000000 0x426f6f46 1
+    u-boot=> md.b 0x0000000100000000 4
+    00000000: 46 6f 6f 42                                      FooB
+
+and calculate the sm3sum from address and store it in environment
+variable hashval
+
+::
+
+    u-boot=> sm3sum 0x0000000100000000 4 hashval
+    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
+    u-boot=> print hashval
+    hashval=cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
+    u-boot=>
+
+or calculate sm3sum from address and store it at address sum
+
+::
+
+    u-boot=> sm3sum 0x0000000100000000 4 *0x0000000110000000
+    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
+
+and now check if this hash is a valid sm3sum with "-v" option
+
+::
+
+    u-boot=> sm3sum -v 0x0000000100000000 4 *0x0000000110000000
+    u-boot=> echo $?
+    0
+
+example with wrong hash
+
+::
+
+    u-boot=> sm3sum -v 0x0000000100000000 4 *0x0000000110000004
+    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7 != e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7ffffffff ** ERROR **
+    u-boot=>
+
+
+Configuration
+-------------
+
+Enable the sm3sum command via Kconfig option CONFIG_CMD_SM3SUM.
+The "-v" option is separate enabled through Kconfig option
+CONFIG_SM3SUM_VERIFY.
+
+
+Return value
+------------
+
+The return value $? is true (0) if the hash is calculated or if
+the created hash is the same as the hash stored in memory at
+address sum.
+
+The return value is false (1) if there is a problem with
+calculating the hash, or if the hash is not the same as
+the hash stored ar address sum.
-- 
2.20.1

