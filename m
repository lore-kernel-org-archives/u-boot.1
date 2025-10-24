Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A8CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F25F2838D7;
	Fri, 24 Oct 2025 17:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FC383677; Fri, 24 Oct 2025 17:12:33 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB151836C8
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 18D1D7282;
 Fri, 24 Oct 2025 17:12:29 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122652-28975 ;
 Fri, 24 Oct 2025 17:12:26 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417122888-18296 ;
 Fri, 24 Oct 2025 17:12:28 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Alex Shumsky" <alexthreed@gmail.com>, "E Shattow" <e@freeshell.de>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Jerome Forissier" <jerome.forissier@linaro.org>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Mark Jonas" <mark.jonas@de.bosch.com>,
 "Mattia Narducci" <mattianarducci1@gmail.com>,
 "Ricardo Simoes" <ricardo.simoes@pt.bosch.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Yegor Yefremov" <yegorslists@googlemail.com>,
 "mason1920" <mason1920@use.startmail.com>
Subject: [PATCH 3/9] doc: Fix typos
Date: Fri, 24 Oct 2025 17:11:59 +0200
Message-ID: <20251024151219.100970-4-wolfgang.wallner@br-automation.com>
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
 2025) at 10/24/2025 05:12:27 PM,
 Serialize complete at 10/24/2025 05:12:27 PM
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

Fix typos/wording in various files in doc/.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 doc/develop/devicetree/control.rst     |  2 +-
 doc/develop/driver-model/fdt-fixup.rst |  2 +-
 doc/develop/testing.rst                |  4 ++--
 doc/develop/trace.rst                  |  2 +-
 doc/mkimage.1                          |  4 ++--
 doc/usage/environment.rst              |  2 +-
 doc/usage/fit/beaglebone=5Fvboot.rst     |  2 +-
 doc/usage/fit/overlay-fdt-boot.rst     | 14 +++++++-------
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/co=
ntrol.rst
index c25b98683f8..634114af59a 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -288,7 +288,7 @@ The full devicetree is available to U-Boot proper, but =
normally only a subset
 Using several DTBs in the SPL (SPL=5FMULTI=5FDTB=5FFIT Kconfig option)
 ----------------------------------------------------------------
 In some rare cases it is desirable to let SPL be able to select one DTB am=
ong
-many. This usually not very useful as the DTB for the SPL is small and usu=
ally
+many. This is usually not very useful as the DTB for the SPL is small and =
usually
 fits several platforms. However the DTB sometimes include information that=
 do
 work on several platforms (like IO tuning parameters).
 In this case it is possible to use SPL=5FMULTI=5FDTB=5FFIT Kconfig option.=
 This option
diff --git a/doc/develop/driver-model/fdt-fixup.rst b/doc/develop/driver-mo=
del/fdt-fixup.rst
index 974c09031ed..b547daf79ff 100644
--- a/doc/develop/driver-model/fdt-fixup.rst
+++ b/doc/develop/driver-model/fdt-fixup.rst
@@ -45,7 +45,7 @@ An additional problem with the device tree in U-Boot is t=
hat it is read-only,
 and the current mechanisms don't allow easy manipulation of the device tree
 after the driver model has been initialized. While migrating to a live dev=
ice
 tree (at least after the relocation) would greatly simplify the solution of
-this problem, it is a non-negligible task to implement it, an a interim
+this problem, it is a non-negligible task to implement it, an ad interim
 solution is needed to address the problem at least in the medium-term.
=20
 Hence, we propose a solution to this problem by offering a board-specific
diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index aa7786c99fd..3a2b496fa00 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -28,7 +28,7 @@ run. Type this::
=20
     make tcheck
=20
-You can also run a selection tests in parallel with::
+You can also run a selection of tests in parallel with::
=20
     make pcheck
=20
@@ -39,7 +39,7 @@ are run. See :doc:`pytest/usage` for more information.
 Sandbox
 -------
 U-Boot can be built as a user-space application (e.g. for Linux). This
-allows test to be executed without needing target hardware. The 'sandbox'
+allows tests to be executed without needing target hardware. The 'sandbox'
 target provides this feature and it is widely used in tests.
=20
 See :doc:`tests=5Fsandbox` for more information.
diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
index d3c8628d124..16635d6d238 100644
--- a/doc/develop/trace.rst
+++ b/doc/develop/trace.rst
@@ -354,7 +354,7 @@ Writing Out Trace Data
 ----------------------
=20
 Once the trace data is in an output buffer in memory there are various ways
-to transmit it to the host. Notably you can use tftput to send the data
+to transmit it to the host. Notably you can use tftpput to send the data
 over a network link::
=20
     fakegocmd=3Dtrace pause; usb start; set autoload n; bootp;
diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 75b6b48a0cf..c705218d345 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -208,7 +208,7 @@ option and the format of their configuration are listed=
 in
 .TQ
 .BI \-\-secondary\-config " secondary-configuration"
 Some image types support a second set of configuration data. The image typ=
es
-which support secondary configuration and the formap of their configuratio=
n are
+which support secondary configuration and the format of their configuratio=
n are
 listed in
 .BR CONFIGURATION .
 .
@@ -396,7 +396,7 @@ when used together with -K and/or -k options.
 .BI \-\-key\-dest " key-destination"
 Specifies a compiled device tree binary file (typically .dtb) to write
 public key information into. When a private key is used to sign an image,
-the corresponding public key is written into this file for for run-time
+the corresponding public key is written into this file for run-time
 verification. Typically the file here is the device tree binary used by
 CONFIG=5FOF=5FCONTROL in U-Boot.
 .
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 5553a629e42..0143f81f2c0 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -213,7 +213,7 @@ updatefile
=20
 autoload
     if set to "no" (any string beginning with 'n'),
-    "bootp" and "dhcp" will just load perform a lookup of the
+    "bootp" and "dhcp" will just perform a lookup of the
     configuration from the BOOTP server, but not try to
     load any image.
=20
diff --git a/doc/usage/fit/beaglebone=5Fvboot.rst b/doc/usage/fit/beaglebon=
e=5Fvboot.rst
index 1298ba1ae08..b15399441ee 100644
--- a/doc/usage/fit/beaglebone=5Fvboot.rst
+++ b/doc/usage/fit/beaglebone=5Fvboot.rst
@@ -473,7 +473,7 @@ you sign::
 Here we are overriding the normal device tree file with our one, which
 contains the public key.
=20
-Now you have a special U-Boot image with the public key. It can verify can
+Now you have a special U-Boot image with the public key. It can verify any
 kernel that you sign with the private key as in step 5.
=20
 If you like you can take a look at the public key information that mkimage
diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt=
-boot.rst
index d687e98ea2a..f5af6d9df05 100644
--- a/doc/usage/fit/overlay-fdt-boot.rst
+++ b/doc/usage/fit/overlay-fdt-boot.rst
@@ -19,7 +19,7 @@ Configuration without overlays
 ------------------------------
=20
 Take a hypothetical board named 'foo' where there are different supported
-revisions, reva and revb. Assume that both board revisions can use add a b=
ar
+revisions, reva and revb. Assume that both board revisions can add a bar
 add-on board, while only the revb board can use a baz add-on board.
=20
 Without using overlays the configuration would be as follows for every cas=
e::
@@ -97,7 +97,7 @@ Without using overlays the configuration would be as foll=
ows for every case::
 	};
=20
 Note the blob needs to be compiled for each case and the combinatorial exp=
losion of
-configurations. A typical device tree blob is in the low hunderds of kbyte=
s so a
+configurations. A typical device tree blob is in the low hundreds of kbyte=
s so a
 multitude of configuration grows the image quite a bit.
=20
 Booting this image is done by using::
@@ -117,7 +117,7 @@ Configuration using overlays
 ----------------------------
=20
 Device tree overlays can be applied to a base DT and result in the same bl=
ob
-being passed to the booting kernel. This saves on space and avoid the comb=
inatorial
+being passed to the booting kernel. This saves on space and avoids the com=
binatorial
 explosion problem::
=20
     /dts-v1/;
@@ -164,7 +164,7 @@ explosion problem::
         };
=20
         configurations {
-            default =3D "foo-reva.dtb;
+            default =3D "foo-reva.dtb";
             foo-reva.dtb {
                 kernel =3D "kernel";
                 fdt =3D "fdt-1", "fdt-2";
@@ -209,9 +209,9 @@ to be writeable.
 Configuration using overlays and feature selection
 --------------------------------------------------
=20
-Although the configuration in the previous section works is a bit inflexib=
le
-since it requires all possible configuration options to be laid out before
-hand in the FIT image. For the add-on boards the extra config selection me=
thod
+Although the configuration in the previous section works, it is a bit infl=
exible
+since it requires all possible configuration options to be laid out before=
hand
+in the FIT image. For the add-on boards the extra config selection method
 might make sense.
=20
 Note the two bar & baz configuration nodes. To boot a reva board with
--=20
2.51.1

