Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71800E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 11:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1C38031D;
	Wed,  1 Jan 2025 12:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="c7RWyEzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C13980379; Wed,  1 Jan 2025 12:19:32 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E20D8021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 12:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6C92D3F942; 
 Wed,  1 Jan 2025 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735730368;
 bh=ZWvKZ7ypdVX+iMzvkksPPW0ZxvrkkB+duF8594/V9Mk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=c7RWyEzoiqDxG73AFOTxnxJQg2hsqCbI+NIQTqMnelCNU1JYpWe25r1UPuQKVhei0
 EHtOXSLgi+wS/1/adV3xqyq21Ws2UHHlqRWKPXq0SByRgramBXsJV688BIgUum5ZNr
 W3T1hknqtaeQ6Uw6dCs5DSiAu5t2Ye4v2iZosIZfVReRPXyohmwaSHaY8ghe5D24th
 BPlvrC1g/00Tyxgn/UkzVC9nwEyVsvWBX1c3/xxdBcUdMLcXlFkX2LVTq9L8fafzG2
 sri2zRqFUpDqabD6WIOrJw25C3r2OOamFJNf8vS4mEoPhSBsAnKF3OfahS5Cmx1Gdj
 MsHvBBeoP2tbw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: move licenses to doc/
Date: Wed,  1 Jan 2025 12:19:20 +0100
Message-ID: <20250101111920.18535-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

* Move all license texts to doc/
* Convert README to restructured text and rename to index.rst
* Replace '+' suffix by '-or-later' suffix
* The eCos-2.0 license is OSI approved.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/sending_patches.rst             |   6 +-
 doc/index.rst                               |   1 +
 {Licenses => doc/licenses}/Exceptions       |   0
 {Licenses => doc/licenses}/OFL.txt          |   0
 {Licenses => doc/licenses}/bsd-2-clause.txt |   0
 {Licenses => doc/licenses}/bsd-3-clause.txt |   0
 {Licenses => doc/licenses}/bzip2-1.0.6.txt  |   0
 {Licenses => doc/licenses}/eCos-2.0.txt     |   0
 {Licenses => doc/licenses}/gpl-2.0.txt      |   0
 {Licenses => doc/licenses}/ibm-pibs.txt     |   0
 Licenses/README => doc/licenses/index.rst   | 198 ++++++++++++++------
 {Licenses => doc/licenses}/isc.txt          |   0
 {Licenses => doc/licenses}/lgpl-2.0.txt     |   0
 {Licenses => doc/licenses}/lgpl-2.1.txt     |   0
 {Licenses => doc/licenses}/mit.txt          |   0
 {Licenses => doc/licenses}/r8a779x_usb3.txt |   0
 {Licenses => doc/licenses}/x11.txt          |   0
 17 files changed, 142 insertions(+), 63 deletions(-)
 rename {Licenses => doc/licenses}/Exceptions (100%)
 rename {Licenses => doc/licenses}/OFL.txt (100%)
 rename {Licenses => doc/licenses}/bsd-2-clause.txt (100%)
 rename {Licenses => doc/licenses}/bsd-3-clause.txt (100%)
 rename {Licenses => doc/licenses}/bzip2-1.0.6.txt (100%)
 rename {Licenses => doc/licenses}/eCos-2.0.txt (100%)
 rename {Licenses => doc/licenses}/gpl-2.0.txt (100%)
 rename {Licenses => doc/licenses}/ibm-pibs.txt (100%)
 rename Licenses/README => doc/licenses/index.rst (45%)
 rename {Licenses => doc/licenses}/isc.txt (100%)
 rename {Licenses => doc/licenses}/lgpl-2.0.txt (100%)
 rename {Licenses => doc/licenses}/lgpl-2.1.txt (100%)
 rename {Licenses => doc/licenses}/mit.txt (100%)
 rename {Licenses => doc/licenses}/r8a779x_usb3.txt (100%)
 rename {Licenses => doc/licenses}/x11.txt (100%)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index ee6e34089b5..390d466dadc 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -305,10 +305,10 @@ Notes
 1. U-Boot is Free Software that can redistributed and/or modified under the
    terms of the `GNU General Public License
    <http://www.fsf.org/licensing/licenses/gpl.html>`_ (GPL). Currently (August
-   2022) version 2 of the GPL applies. Please see :download:`Licensing
-   <../../Licenses/README>` for details. To allow that later versions of U-Boot
+   2022) version 2 of the GPL applies. Please see :doc:`Licensing
+   <../licenses/index>` for details. To allow that later versions of U-Boot
    may be released under a later version of the GPL, all new code that gets
-   added to U-Boot shall use a "GPL-2.0+" SPDX-License-Identifier.
+   added to U-Boot shall use a "GPL-2.0-or-later" SPDX-License-Identifier.
 
 2. All code must follow the :doc:`codingstyle` requirements.
 
diff --git a/doc/index.rst b/doc/index.rst
index 43398627d89..ffb1d1c97ff 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -38,6 +38,7 @@ want to contribute to U-Boot.
    :maxdepth: 2
 
    develop/index
+   licenses/index
 
 
 U-Boot API documentation
diff --git a/Licenses/Exceptions b/doc/licenses/Exceptions
similarity index 100%
rename from Licenses/Exceptions
rename to doc/licenses/Exceptions
diff --git a/Licenses/OFL.txt b/doc/licenses/OFL.txt
similarity index 100%
rename from Licenses/OFL.txt
rename to doc/licenses/OFL.txt
diff --git a/Licenses/bsd-2-clause.txt b/doc/licenses/bsd-2-clause.txt
similarity index 100%
rename from Licenses/bsd-2-clause.txt
rename to doc/licenses/bsd-2-clause.txt
diff --git a/Licenses/bsd-3-clause.txt b/doc/licenses/bsd-3-clause.txt
similarity index 100%
rename from Licenses/bsd-3-clause.txt
rename to doc/licenses/bsd-3-clause.txt
diff --git a/Licenses/bzip2-1.0.6.txt b/doc/licenses/bzip2-1.0.6.txt
similarity index 100%
rename from Licenses/bzip2-1.0.6.txt
rename to doc/licenses/bzip2-1.0.6.txt
diff --git a/Licenses/eCos-2.0.txt b/doc/licenses/eCos-2.0.txt
similarity index 100%
rename from Licenses/eCos-2.0.txt
rename to doc/licenses/eCos-2.0.txt
diff --git a/Licenses/gpl-2.0.txt b/doc/licenses/gpl-2.0.txt
similarity index 100%
rename from Licenses/gpl-2.0.txt
rename to doc/licenses/gpl-2.0.txt
diff --git a/Licenses/ibm-pibs.txt b/doc/licenses/ibm-pibs.txt
similarity index 100%
rename from Licenses/ibm-pibs.txt
rename to doc/licenses/ibm-pibs.txt
diff --git a/Licenses/README b/doc/licenses/index.rst
similarity index 45%
rename from Licenses/README
rename to doc/licenses/index.rst
index d09f0fe2cb8..fabf4a82bdb 100644
--- a/Licenses/README
+++ b/doc/licenses/index.rst
@@ -1,6 +1,9 @@
-SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0
 
-  U-Boot is Free Software.  It is copyrighted by Wolfgang Denk and
+Licenses
+========
+
+U-Boot is Free Software.  It is copyrighted by Wolfgang Denk and
 many others who contributed code (see the actual source code and the
 git commit messages for details).  You can redistribute U-Boot and/or
 modify it under the terms of version 2 of the GNU General Public
@@ -8,21 +11,21 @@ License as published by the Free Software Foundation.  Most of it can
 also be distributed, at your option, under any later version of the
 GNU General Public License -- see individual files for exceptions.
 
-  NOTE! This license does *not* cover the so-called "standalone"
-applications that use U-Boot services by means of the jump table
-provided by U-Boot exactly for this purpose - this is merely
-considered normal use of U-Boot, and does *not* fall under the
-heading of "derived work" -- see file  Licenses/Exceptions  for
-details.
+.. note::
 
-  Also note that the GPL and the other licenses are copyrighted by
-the Free Software Foundation and other organizations, but the
-instance of code that they refer to (the U-Boot source code) is
-copyrighted by me and others who actually wrote it.
--- Wolfgang Denk
+  This license does **not** cover the so-called "standalone"
+  applications that use U-Boot services by means of the jump table
+  provided by U-Boot exactly for this purpose - this is merely
+  considered normal use of U-Boot, and does **not** fall under the
+  heading of "derived work" -- see file  Licenses/Exceptions  for
+  details.
 
+  Also note that the GPL and the other licenses are copyrighted by
+  the Free Software Foundation and other organizations, but the
+  instance of code that they refer to (the U-Boot source code) is
+  copyrighted by the authors who actually wrote it.
 
-Like many other projects, U-Boot has a tradition of including big
+Like many other projects, U-Boot had a tradition of including big
 blocks of License headers in all files.  This not only blows up the
 source code with mostly redundant information, but also makes it very
 difficult to generate License Clearing Reports.  An additional problem
@@ -31,20 +34,22 @@ slightly varying text blocks (full, abbreviated, different
 indentation, line wrapping and/or white space, with obsolete address
 information, ...) which makes automatic processing a nightmare.
 
-To make this easier, such license headers in the source files will be
+To make this easier, such license headers in the source files are
 replaced with a single line reference to Unique License Identifiers
-as defined by the Linux Foundation's SPDX project [1].
+as defined by the Linux Foundation's `SPDX project <http://spdx.org/>`_.
 
 If a "SPDX-License-Identifier:" line references more than one Unique
 License Identifier, then this means that the respective file can be
 used under the terms of either of these licenses, i. e. with
 
-	SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. code-block:: text
+
+	SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 
-you can choose between GPL-2.0+ and BSD-3-Clause licensing.
+you can choose between GPL-2.0-or-later and BSD-3-Clause licensing.
 
-We use the SPDX Unique License Identifiers here; these are available
-at [2].
+We use the SPDX Unique License Identifiers here. These are available
+at `<http://spdx.org/licenses/>`_.
 
 License identifier syntax
 -------------------------
@@ -57,19 +62,40 @@ License identifier syntax
    '#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
    identifier goes into the second line.
 
-|
-
 2. Style:
 
    The SPDX license identifier is added in form of a comment.  The comment
-   style depends on the file type::
+   style depends on the file type:
+
+   .. list-table::
+      :header-rows: 1
+
+      * - File type
+        - Comment line
+      * - C source (\*.c)
+        - ::
 
-      C source:	// SPDX-License-Identifier: <SPDX License Expression>
-      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */
-      ASM:	/* SPDX-License-Identifier: <SPDX License Expression> */
-      scripts:	# SPDX-License-Identifier: <SPDX License Expression>
-      .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
-      .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>
+              // SPDX-License-Identifier: <SPDX License Expression>
+      * - C header (\*.h)
+        - ::
+
+              /* SPDX-License-Identifier: <SPDX License Expression> */
+      * - Assembler (\*.S)
+        - ::
+
+              /* SPDX-License-Identifier: <SPDX License Expression> */
+      * - Scripts (\*.py, \*.sh)
+        - ::
+
+              # SPDX-License-Identifier: <SPDX License Expression>
+      * - Restructured text (\*.rst)
+        - ::
+
+              .. SPDX-License-Identifier: <SPDX License Expression>
+      * - Device-tree source (\*.dts, \*.dtsi)
+        - ::
+
+              // SPDX-License-Identifier: <SPDX License Expression>
 
    If a specific tool cannot handle the standard comment style, then the
    appropriate comment mechanism which the tool accepts shall be used. This
@@ -79,8 +105,6 @@ License identifier syntax
    there are still older assembler tools which cannot handle C++ style
    comments.
 
-|
-
 3. Syntax:
 
    A <SPDX License Expression> is either an SPDX short form license
@@ -91,21 +115,21 @@ License identifier syntax
    "(", ")" .
 
    License identifiers for licenses like [L]GPL with the 'or later' option
-   are constructed by using a "+" for indicating the 'or later' option.::
+   are constructed by appending "-or-later"::
 
-      // SPDX-License-Identifier: GPL-2.0+
-      // SPDX-License-Identifier: LGPL-2.1+
+      // SPDX-License-Identifier: GPL-2.0-or-later
+      // SPDX-License-Identifier: LGPL-2.1-or-later
 
    WITH should be used when there is a modifier to a license needed.
-   For example, the linux kernel UAPI files use the expression::
+   For example, the Linux kernel UAPI files use the expression::
 
       // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-      // SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note
+      // SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note
 
-   Other examples using WITH exceptions found in the linux kernel are::
+   Other examples using WITH exceptions found in the Linux kernel are::
 
       // SPDX-License-Identifier: GPL-2.0 WITH mif-exception
-      // SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+      // SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0
 
    Exceptions can only be used with particular License identifiers. The
    valid License identifiers are listed in the tags of the exception text
@@ -120,7 +144,7 @@ License identifier syntax
    Examples from U-Boot for license expressions in dual licensed files::
 
       // SPDX-License-Identifier: GPL-2.0 OR MIT
-      // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+      // SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 
    AND should be used if the file has multiple licenses whose terms all
    apply to use the file. For example, if code is inherited from another
@@ -132,24 +156,78 @@ License identifier syntax
    Another other example where both sets of license terms need to be
    adhered to is::
 
-      // SPDX-License-Identifier: GPL-1.0+ AND LGPL-2.1+
-
-[1] http://spdx.org/
-[2] http://spdx.org/licenses/
-
-Full name					SPDX Identifier	OSI Approved	File name		URI
-=======================================================================================================================================
-bzip2 and libbzip2 License v1.0.6		bzip2-1.0.6			bzip2-1.0.6.txt		https://spdx.org/licenses/bzip2-1.0.6.html
-GNU General Public License v2.0 only		GPL-2.0		Y		gpl-2.0.txt		http://www.gnu.org/licenses/gpl-2.0.txt
-GNU General Public License v2.0 or later	GPL-2.0+	Y		gpl-2.0.txt		http://www.gnu.org/licenses/gpl-2.0.txt
-GNU Library General Public License v2 or later	LGPL-2.0+	Y		lgpl-2.0.txt		http://www.gnu.org/licenses/old-licenses/lgpl-2.0.txt
-GNU Lesser General Public License v2.1 or later	LGPL-2.1+	Y		lgpl-2.1.txt		http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt
-eCos license version 2.0			eCos-2.0			eCos-2.0.txt		http://www.gnu.org/licenses/ecos-license.html
-BSD 2-Clause License				BSD-2-Clause	Y		bsd-2-clause.txt	http://spdx.org/licenses/BSD-2-Clause
-BSD 3-clause "New" or "Revised" License		BSD-3-Clause	Y		bsd-3-clause.txt	http://spdx.org/licenses/BSD-3-Clause#licenseText
-IBM PIBS (PowerPC Initialization and		IBM-pibs			ibm-pibs.txt
-	Boot Software) license
-ISC License					ISC		Y		isc.txt			https://spdx.org/licenses/ISC
-MIT License					MIT		Y		mit.txt			https://spdx.org/licenses/MIT.html
-SIL OPEN FONT LICENSE (OFL-1.1)			OFL-1.1		Y		OFL.txt			https://spdx.org/licenses/OFL-1.1.html
-X11 License					X11				x11.txt			https://spdx.org/licenses/X11.html
+      // SPDX-License-Identifier: GPL-1.0-or-later AND LGPL-2.1-or-later
+
+.. list-table::
+   :header-rows: 1
+
+   * - Full name
+     - SPDX Identifier
+     - OSI Approved
+     - File name
+     - URI
+   * - bzip2 and libbzip2 License v1.0.6
+     - bzip2-1.0.6
+     -
+     - :download:`bzip2-1.0.6.txt`
+     - https://spdx.org/licenses/bzip2-1.0.6.html
+   * - GNU General Public License v2.0 only
+     - GPL-2.0-only
+     - yes
+     - :download:`gpl-2.0.txt`
+     - http://www.gnu.org/licenses/gpl-2.0.txt
+   * - GNU General Public License v2.0 or later
+     - GPL-2.0-or-later
+     - yes
+     - :download:`gpl-2.0.txt`
+     - http://www.gnu.org/licenses/gpl-2.0.txt
+   * - GNU Library General Public License v2 or later
+     - LGPL-2.0-or-later
+     - yes
+     - :download:`lgpl-2.0.txt`
+     - http://www.gnu.org/licenses/old-licenses/lgpl-2.0.txt
+   * - GNU Lesser General Public License v2.1 or later
+     - LGPL-2.1-or-later
+     - yes
+     - :download:`lgpl-2.1.txt`
+     - http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt
+   * - eCos license version 2.0
+     - eCos-2.0
+     - yes (non-reusable)
+     - eCos-2.0.txt`
+     - http://www.gnu.org/licenses/ecos-license.html
+   * - BSD 2-Clause License
+     - BSD-2-Clause
+     - yes
+     - :download:`bsd-2-clause.txt`
+     - http://spdx.org/licenses/BSD-2-Clause
+   * - BSD 3-clause "New" or "Revised" License
+     - BSD-3-Clause
+     - yes
+     - :download:`bsd-3-clause.txt`
+     - http://spdx.org/licenses/BSD-3-Clause#licenseText
+   * - IBM PIBS (PowerPC Initialization and Boot Software) license
+     - IBM-pibs
+     -
+     - :download:`ibm-pibs.txt`
+     -
+   * - ISC License
+     - ISC
+     - yes
+     - :download:`isc.txt`
+     - https://spdx.org/licenses/ISC
+   * - MIT License
+     - MIT
+     - yes
+     - :download:`mit.txt`
+     - https://spdx.org/licenses/MIT.html
+   * - SIL Open Font License (OFL) version 1.1
+     - OFL-1.1
+     - yes
+     - :download:`OFL.txt`
+     - https://spdx.org/licenses/OFL-1.1.html
+   * - X11 License
+     - X11
+     -
+     - :download:`x11.txt`
+     - https://spdx.org/licenses/X11.html
diff --git a/Licenses/isc.txt b/doc/licenses/isc.txt
similarity index 100%
rename from Licenses/isc.txt
rename to doc/licenses/isc.txt
diff --git a/Licenses/lgpl-2.0.txt b/doc/licenses/lgpl-2.0.txt
similarity index 100%
rename from Licenses/lgpl-2.0.txt
rename to doc/licenses/lgpl-2.0.txt
diff --git a/Licenses/lgpl-2.1.txt b/doc/licenses/lgpl-2.1.txt
similarity index 100%
rename from Licenses/lgpl-2.1.txt
rename to doc/licenses/lgpl-2.1.txt
diff --git a/Licenses/mit.txt b/doc/licenses/mit.txt
similarity index 100%
rename from Licenses/mit.txt
rename to doc/licenses/mit.txt
diff --git a/Licenses/r8a779x_usb3.txt b/doc/licenses/r8a779x_usb3.txt
similarity index 100%
rename from Licenses/r8a779x_usb3.txt
rename to doc/licenses/r8a779x_usb3.txt
diff --git a/Licenses/x11.txt b/doc/licenses/x11.txt
similarity index 100%
rename from Licenses/x11.txt
rename to doc/licenses/x11.txt
-- 
2.47.1

