Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA5DCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB123838AE;
	Fri, 24 Oct 2025 17:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314F783881; Fri, 24 Oct 2025 17:12:31 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41486836B2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id B89607280;
 Fri, 24 Oct 2025 17:12:28 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122618-28974 ;
 Fri, 24 Oct 2025 17:12:26 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417122849-18295 ;
 Fri, 24 Oct 2025 17:12:28 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
 "Bryan Brattlof" <bb@ti.com>, "Lothar Rubusch" <l.rubusch@gmail.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Yannic Moog" <y.moog@phytec.de>
Subject: [PATCH 2/9] doc: develop: Change formatting to make binman doc more
 readable
Date: Fri, 24 Oct 2025 17:11:58 +0200
Message-ID: <20251024151219.100970-3-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:28 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:28 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:26 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:26 PM,
 Serialize complete at 10/24/2025 05:12:26 PM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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

Change the formatting of binman.rst so that the compiled HTML output
becomes more readable. Changes include enumerations and the escaping of
arguments starting with a double dash (e.g. --debug).

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 tools/binman/binman.rst | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 2d81f0115c0..3f725868c8b 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1338,12 +1338,17 @@ file with the new devicetree.
 This is handled by the --update-fdt-in-elf option. It takes four arguments,
 separated by comma:
=20
-   infile     - filename of input ELF file, e.g. 'u-boot's
-   outfile    - filename of output ELF file, e.g. 'u-boot.out'
-   begin=5Fsym - symbol at the start of the embedded devicetree, e.g.
-   '=5F=5Fdtb=5Fdt=5Fbegin'
-   end=5Fsym   - symbol at the start of the embedded devicetree, e.g.
-   '=5F=5Fdtb=5Fdt=5Fend'
+infile:
+    filename of input ELF file, e.g. 'u-boot's
+
+outfile:
+    filename of output ELF file, e.g. 'u-boot.out'
+
+begin=5Fsym:
+    symbol at the start of the embedded devicetree, e.g. '=5F=5Fdtb=5Fdt=
=5Fbegin'
+
+end=5Fsym:
+    symbol at the start of the embedded devicetree, e.g. '=5F=5Fdtb=5Fdt=
=5Fend'
=20
 When this flag is used, U-Boot does all the normal packaging, but as an
 additional step, it creates a new ELF file with the new devicetree embedde=
d in
@@ -1546,19 +1551,19 @@ Logging
 -------
=20
 Binman normally operates silently unless there is an error, in which case =
it
-just displays the error. The -D/--debug option can be used to create a full
+just displays the error. The ``-D/--debug`` option can be used to create a=
 full
 backtrace when errors occur. You can use BINMAN=5FDEBUG=3D1 when building =
to select
 this.
=20
 Internally binman logs some output while it is running. This can be displa=
yed
-by increasing the -v/--verbosity from the default of 1:
+by increasing the ``-v/--verbosity`` from the default of 1:
=20
-   0: silent
-   1: warnings only
-   2: notices (important messages)
-   3: info about major operations
-   4: detailed information about each operation
-   5: debug (all output)
+   - 0: silent
+   - 1: warnings only
+   - 2: notices (important messages)
+   - 3: info about major operations
+   - 4: detailed information about each operation
+   - 5: debug (all output)
=20
 You can use BINMAN=5FVERBOSE=3D5 (for example) when building to select thi=
s.
=20
@@ -1616,19 +1621,19 @@ To fetch tools which are missing, use::
=20
     binman tool --fetch missing
=20
-You can also use `--fetch all` to fetch all tools or `--fetch <tool>` to f=
etch
+You can also use ``--fetch all`` to fetch all tools or ``--fetch <tool>`` =
to fetch
 a particular tool. Some tools are built from source code, in which case yo=
u will
 need to have at least the `build-essential` and `git` packages installed.
=20
 Tools are fetched into the `~/.binman-tools` directory. This directory is
-automatically added to the toolpath so there is no need to use `--toolpath=
` to
+automatically added to the toolpath so there is no need to use ``--toolpat=
h`` to
 specify it. If you want to use these tools outside binman, you may want to
 add this directory to your `PATH`. For example, if you use bash, add this =
to
 the end of `.bashrc`::
=20
    PATH=3D"$HOME/.binman-tools:$PATH"
=20
-To select a custom directory, use the `--tooldir` option.
+To select a custom directory, use the ``--tooldir`` option.
=20
 Bintool Documentation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.51.1

