Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E09CCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54D183927;
	Fri, 24 Oct 2025 17:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB84836D1; Fri, 24 Oct 2025 17:12:34 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3A1836B4
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 054327288;
 Fri, 24 Oct 2025 17:12:30 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122848-28980 ;
 Fri, 24 Oct 2025 17:12:28 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417123080-18301 ;
 Fri, 24 Oct 2025 17:12:30 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "E Shattow" <e@freeshell.de>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 8/9] doc: Fix whitespace in devicetree example in
 overlay-fdt-boot.rst
Date: Fri, 24 Oct 2025 17:12:04 +0200
Message-ID: <20251024151219.100970-9-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:30 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:30 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:28 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:28 PM,
 Serialize complete at 10/24/2025 05:12:28 PM
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

Fix the whitespace and add a missing quotation mark
(default =3D "foo-reva.dtb") in overlay-fdt-boot.rst.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 doc/usage/fit/overlay-fdt-boot.rst | 142 ++++++++++++++---------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt=
-boot.rst
index f5af6d9df05..0f012d6988a 100644
--- a/doc/usage/fit/overlay-fdt-boot.rst
+++ b/doc/usage/fit/overlay-fdt-boot.rst
@@ -24,77 +24,77 @@ add-on board, while only the revb board can use a baz a=
dd-on board.
=20
 Without using overlays the configuration would be as follows for every cas=
e::
=20
-	/dts-v1/;
-	/ {
-	    images {
-	    kernel {
-		data =3D /incbin/("./zImage");
-		type =3D "kernel";
-		arch =3D "arm";
-		os =3D "linux";
-		load =3D <0x82000000>;
-		entry =3D <0x82000000>;
-	    };
-	    fdt-1 {
-		data =3D /incbin/("./foo-reva.dtb");
-		type =3D "flat=5Fdt";
-		arch =3D "arm";
-	    };
-	    fdt-2 {
-		data =3D /incbin/("./foo-revb.dtb");
-		type =3D "flat=5Fdt";
-		arch =3D "arm";
-	    };
-	    fdt-3 {
-		data =3D /incbin/("./foo-reva-bar.dtb");
-		type =3D "flat=5Fdt";
-		arch =3D "arm";
-	    };
-	    fdt-4 {
-		data =3D /incbin/("./foo-revb-bar.dtb");
-		type =3D "flat=5Fdt";
-		arch =3D "arm";
-	    };
-	    fdt-5 {
-		data =3D /incbin/("./foo-revb-baz.dtb");
-		type =3D "flat=5Fdt";
-		arch =3D "arm";
-	    };
-	    fdt-6 {
-		data =3D /incbin/("./foo-revb-bar-baz.dtb");
-		type =3D "flat=5Fdt";
-		arch =3D "arm";
-	    };
-	    };
-
-	    configurations {
-	    default =3D "foo-reva.dtb;
-	    foo-reva.dtb {
-		kernel =3D "kernel";
-		fdt =3D "fdt-1";
-	    };
-	    foo-revb.dtb {
-		kernel =3D "kernel";
-		fdt =3D "fdt-2";
-	    };
-	    foo-reva-bar.dtb {
-		kernel =3D "kernel";
-		fdt =3D "fdt-3";
-	    };
-	    foo-revb-bar.dtb {
-		kernel =3D "kernel";
-		fdt =3D "fdt-4";
-	    };
-	    foo-revb-baz.dtb {
-		kernel =3D "kernel";
-		fdt =3D "fdt-5";
-	    };
-	    foo-revb-bar-baz.dtb {
-		kernel =3D "kernel";
-		fdt =3D "fdt-6";
-	    };
-	    };
-	};
+    /dts-v1/;
+    / {
+        images {
+            kernel {
+                data =3D /incbin/("./zImage");
+                type =3D "kernel";
+                arch =3D "arm";
+                os =3D "linux";
+                load =3D <0x82000000>;
+                entry =3D <0x82000000>;
+            };
+            fdt-1 {
+                data =3D /incbin/("./foo-reva.dtb");
+                type =3D "flat=5Fdt";
+                arch =3D "arm";
+            };
+            fdt-2 {
+                data =3D /incbin/("./foo-revb.dtb");
+                type =3D "flat=5Fdt";
+                arch =3D "arm";
+            };
+            fdt-3 {
+                data =3D /incbin/("./foo-reva-bar.dtb");
+                type =3D "flat=5Fdt";
+                arch =3D "arm";
+            };
+            fdt-4 {
+                data =3D /incbin/("./foo-revb-bar.dtb");
+                type =3D "flat=5Fdt";
+                arch =3D "arm";
+            };
+            fdt-5 {
+                data =3D /incbin/("./foo-revb-baz.dtb");
+                type =3D "flat=5Fdt";
+                arch =3D "arm";
+            };
+            fdt-6 {
+                data =3D /incbin/("./foo-revb-bar-baz.dtb");
+                type =3D "flat=5Fdt";
+                arch =3D "arm";
+            };
+        };
+
+        configurations {
+            default =3D "foo-reva.dtb";
+            foo-reva.dtb {
+                kernel =3D "kernel";
+                fdt =3D "fdt-1";
+            };
+            foo-revb.dtb {
+                kernel =3D "kernel";
+                fdt =3D "fdt-2";
+            };
+            foo-reva-bar.dtb {
+                kernel =3D "kernel";
+                fdt =3D "fdt-3";
+            };
+            foo-revb-bar.dtb {
+                kernel =3D "kernel";
+                fdt =3D "fdt-4";
+            };
+            foo-revb-baz.dtb {
+                kernel =3D "kernel";
+                fdt =3D "fdt-5";
+            };
+            foo-revb-bar-baz.dtb {
+                kernel =3D "kernel";
+                fdt =3D "fdt-6";
+            };
+        };
+    };
=20
 Note the blob needs to be compiled for each case and the combinatorial exp=
losion of
 configurations. A typical device tree blob is in the low hundreds of kbyte=
s so a
--=20
2.51.1

