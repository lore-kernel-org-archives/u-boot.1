Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC33ECCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF00583857;
	Fri, 24 Oct 2025 17:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E336C83837; Fri, 24 Oct 2025 17:12:30 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E403283677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 654EF7283;
 Fri, 24 Oct 2025 17:12:28 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122576-28973 ;
 Fri, 24 Oct 2025 17:12:25 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417122811-18294 ;
 Fri, 24 Oct 2025 17:12:28 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
 "Bryan Brattlof" <bb@ti.com>, "Lothar Rubusch" <l.rubusch@gmail.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Yannic Moog" <y.moog@phytec.de>
Subject: [PATCH 1/9] doc: develop: Fix typos in binman/binman.rst
Date: Fri, 24 Oct 2025 17:11:57 +0200
Message-ID: <20251024151219.100970-2-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:28 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:28 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:25 PM,
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

Fix some typos in binman.rst.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>

---

 tools/binman/binman.rst | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 392e507d449..2d81f0115c0 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -272,7 +272,7 @@ Then, in practice binman is often used twice:
 - Once within the U-Boot build system, for development and testing
 - Again, outside U-Boot to assembly and final production images
=20
-While the same input binaries are used in each case, you will of course yo=
u will
+While the same input binaries are used in each case, you will of course
 need to create your own binman command line, like that in `cmd=5Fbinman` in
 the Makefile. You may find the -I and --toolpath options useful. The
 devicetree file is provided to binman in binary form, so there is no need =
to
@@ -1184,7 +1184,7 @@ size is written to the node in an 'uncomp-size' prope=
rty, if -u is used.
=20
 Compression is also supported for sections. In that case the entire sectio=
n is
 compressed in one block, including all its contents. This means that acces=
sing
-an entry from the section required decompressing the entire section. Also,=
 the
+an entry from the section requires decompressing the entire section. Also,=
 the
 size of a section indicates the space that it consumes in its parent secti=
on
 (and typically the image). With compression, the section may contain more =
data,
 and the uncomp-size property indicates that, as above. The contents of the
@@ -1224,8 +1224,8 @@ If you are having trouble figuring out what is going =
on, you can use
 Templates
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Sometimes multiple images need to be created which have all have a common
-part. For example, a board may generate SPI and eMMC images which both inc=
lude
+Sometimes multiple images need to be created which all have a common part.
+For example, a board may generate SPI and eMMC images which both include
 a FIT. Since the FIT includes many entries, it is tedious to repeat them t=
wice
 in the image description.
=20
@@ -1250,7 +1250,7 @@ Templates provide a simple way to handle this::
=20
             /* things specific to SPI follow */
             footer {
-            ];
+            };
=20
             text {
                 text =3D "SPI image";
@@ -1263,7 +1263,7 @@ Templates provide a simple way to handle this::
=20
             /* things specific to MMC follow */
             footer {
-            ];
+            };
=20
             text {
                 text =3D "MMC image";
@@ -1330,9 +1330,9 @@ Updating an ELF file
=20
 For the EFI app, where U-Boot is loaded from UEFI and runs as an app, ther=
e is
 no way to update the devicetree after U-Boot is built. Normally this works=
 by
-creating a new u-boot.dtb.out with he updated devicetree, which is automat=
ically
+creating a new u-boot.dtb.out with the updated devicetree, which is automa=
tically
 built into the output image. With ELF this is not possible since the ELF is
-not part of an image, just a stand-along file. We must create an updated E=
LF
+not part of an image, just a stand-alone file. We must create an updated E=
LF
 file with the new devicetree.
=20
 This is handled by the --update-fdt-in-elf option. It takes four arguments,
@@ -1450,7 +1450,7 @@ or just a selection::
     $ binman extract -i image.bin "*u-boot*" -O outdir
=20
 Some entry types have alternative formats, for example fdtmap which allows
-extracted just the devicetree binary without the fdtmap header::
+extracting just the devicetree binary without the fdtmap header::
=20
     $ binman extract -i /tmp/b/odroid-c4/image.bin -f out.dtb -F fdt fdtmap
     $ fdtdump out.dtb
@@ -1488,7 +1488,7 @@ that there is an 'fdtmap' entry in the image. For exa=
mple::
     $ binman replace -i image.bin section/cbfs/u-boot
=20
 which will write the contents of the file 'u-boot' from the current direct=
ory
-to the that entry, compressing if necessary. If the entry size changes, yo=
u must
+to that entry, compressing if necessary. If the entry size changes, you mu=
st
 add the 'allow-repack' property to the original image before generating it=
 (see
 above), otherwise you will get an error.
=20
@@ -1517,27 +1517,27 @@ original offset and size properties of each entry, =
if any were specified, in
 the 'orig-offset' and 'orig-size' properties. This allows Binman to distin=
guish
 between an entry which ended up being packed at an offset (or assigned a s=
ize)
 and an entry which had a particular offset / size requested in the Binman
-configuration. Where are particular offset / size was requested, this is t=
reated
+configuration. Where a particular offset / size was requested, this is tre=
ated
 as set in stone, so Binman will ensure it doesn't change. Without this fea=
ture,
 repacking an entry might cause it to disobey the original constraints prov=
ided
 when it was created.
=20
=20
-Signing FIT container with private key in an image
---------------------------------------------------
+Signing a FIT container with private key in an image
+----------------------------------------------------
=20
-You can sign FIT container with private key in your image.
+You can sign a FIT container with private key in your image.
 For example::
=20
     $ binman sign -i image.bin -k privatekey -a sha256,rsa4096 fit
=20
-binman will extract FIT container, sign and replace it immediately.
+binman will extract the FIT container, sign and replace it immediately.
=20
-If you want to sign and replace FIT container in place::
+If you want to sign and replace a FIT container in place::
=20
     $ binman sign -i image.bin -k privatekey -a sha256,rsa4096 -f fit.fit =
fit
=20
-which will sign FIT container with private key and replace it immediately
+which will sign the FIT container with a private key and replace it immedi=
ately
 inside your image.
=20
 .. =5F`BinmanLogging`:
--=20
2.51.1

