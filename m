Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E404CCA472
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81658835FE;
	Mon,  6 Oct 2025 00:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dUIo4t7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD4F809A5; Mon,  6 Oct 2025 00:13:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4073835FE
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so32956135e9.1
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702377; x=1760307177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lBKnaWLcww54SJZBCMiHdOmu/0ByJroc9WjFUkDWveo=;
 b=dUIo4t7SMk6cS2xpYtP8CXpn4gu0B9mvcHz3FC+fwiAXxjZ1enQ3jtDDF3NUL9TCFv
 j4kWxD/DwfskxommiU+aXLq07uJ3PPjIwKAO20Itrjoy5XTLeWx8Lg/lPKS/q9hjzIHp
 Ie+23Z1+jHsO6kiLGd3dxqDKCrq7L/McvaQL2aLrmacVu2qsK6v8lB/If6NeOmWlnDWd
 CnkSvr3u6+2jc39EfibwyhMC/HhL9p+39gtxy+RmAWfxN+dzhluQOEI5QS18T7CVnhnY
 2ZbO4H3u2ruIyu8efY38vCLqwjPn3of/M1FkTfxdnN26PpU0QrHx+djUHWK/9QX1xj4e
 MyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702377; x=1760307177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBKnaWLcww54SJZBCMiHdOmu/0ByJroc9WjFUkDWveo=;
 b=cFYngwNi55NKgp/GLeEWaE6/B61LCcu3j+prLCKdHSJDzh+9V5AJzOKcYVcvj6GSVE
 zhsEszhMEEu9UR8/Ftx8VXFE0bMkGd+jSoSGsNGCNvuYSps4UIrwKLGFel0lQA+lhGen
 MlKwZyLMlV6lIrksKTOhz/nNGaXojR/3ySblaQBOQGTsmTDwzkD5THeX7S/RsBqB0Opf
 exDy/hMRGgFpNDUCi7TMYTBRu5yhAlQzUMPe4e2ZZ1V1SPs2AoNz9CN0kIwpUUVQu2qN
 ecS+hvzIGsvdMLHfpDGztQ7TG072AmGs2DydIYkk5Iaw18kqPdolhonHJFG+a2qccL9Q
 DRdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7bGwzNGGjzxhYXnNBAf6sWRS0Pn+VkIJCWsPWTr9pnSYIuEL0SVDS0Kh5EJk91AmFTqf6ulU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1gGEPfk/mtdqGsMqbfKlYPKACSezvMWVXLKOHM9P36i/hZXhe
 98pU1dCW1cMTIfCS494/kNWcVwG4hkzLN+Kc0dmsrHwiRPky7yPZPT4B
X-Gm-Gg: ASbGncul0nWr2DAW3b2yIHJz/35EDp2FbQe93B8EGKDLYcusoC9bezpA15PO7Uox2UC
 EqfIE1M7XQjpas8oLR7m3XcM2rTebY2tRvDTgGBqC64xHKon8svhTjvZWpDrE41VHv0YxCTA/vj
 fhYum8Yv7KCs68Q323fReL3Z5uzImUd0dcH9j7blVypqNjoDzCkqYI0jocc4yQYXPqIyRdHoLDB
 D36PsB7dJBmA//XUEJszF4+4y5pubCq2aHpu3jiJ/BeUcMtzLJa573gG4BYTBT/ubucppgbV3SH
 QpdPtlaQLzlwOYqh+nSaPCie38TNz0ueaMkIb1ywXutAW2j6nxv4c6mD4YA/uCoOd7zzy0tO0IE
 IUq1S1k+SKKEA9QuxPi0Jm5Ic6Q4OJy9Jds7/IgvT/bQav8CHWv9ur5n6y9WHLo0R
X-Google-Smtp-Source: AGHT+IHvgH2XbojwCNQYOLJZAwPWrb5yT35XWUSfy4Yhlql+dJToRsC9Dfo44AlV9FFO5twzpQmGCw==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id
 5b1f17b1804b1-46e71109f78mr59959975e9.13.1759702376895; 
 Sun, 05 Oct 2025 15:12:56 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:12:56 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vitor Soares <vitor.soares@toradex.com>, Wadim Egorov <w.egorov@phytec.de>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 5/7] doc: make pdfdocs: Update kfigure sphinx extension to
 support inkscape as well
Date: Sun,  5 Oct 2025 23:10:12 +0100
Message-ID: <20251005221057.255029-6-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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

As it is right now, kfigure relies on ImageMagick's convert. It,
however, fails to convert some SVG files (see below). With this change,
inkscape support is added. If present, inkscape is preferred over
ImageMagick's convert.

With this change kfigure.py is an exact copy of the Linux kernel's at
v6.17. I reviewed all the changes and, it seems to me that, only one
change may cause trouble: logging uses a slightly different approach
(logger v. kernellog).

inkscape is also added as a dependency. Dockerfile updated as well.

Without this change, this is what I get with
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

[...]
convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCompliance/1057.
convert: non-conforming drawing primitive definition `stroke' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/develop/pics/spl_before_reloc.svg /home/uboot/u-boot/doc/output/latex/spl_before_reloc.pdf
convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCompliance/1057.
convert: non-conforming drawing primitive definition `stroke' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/develop/pics/spl_after_reloc.svg /home/uboot/u-boot/doc/output/latex/spl_after_reloc.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/ospi_sysfw2.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw2.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/ospi_sysfw-am64.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw-am64.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/emmc_am65x_evm_boot0.svg /home/uboot/u-boot/doc/output/latex/emmc_am65x_evm_boot0.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/ospi_sysfw.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/emmc_j7200_evm_boot01.svg /home/uboot/u-boot/doc/output/latex/emmc_j7200_evm_boot01.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/emmc_j7200_evm_udafs.svg /home/uboot/u-boot/doc/output/latex/emmc_j7200_evm_udafs.pdf
convert: non-conforming drawing primitive definition `Liberation' @ error/draw.c/RenderMVGContent/4414.
WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/board/ti/img/ospi_sysfw3.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw3.pdf
[...]
build finished with problems, 9 warnings (with warnings treated as errors).
make[1]: *** [doc/Makefile:84: latexdocs] Error 1
make: *** [Makefile:2687: pdfdocs] Error 2

To get the above the following line in /etc/ImageMagick-6/policy.xml
needs to be deleted or commented out:

<policy domain="coder" rights="none" pattern="PDF" />

Otherwise, we'll get:

convert: attempt to perform an operation not allowed by the security policy `PDF' @ error/constitute.c/IsCoderAuthorized/426.

inkscape has the added advantage of this not being necessary.

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst |   2 +
 doc/sphinx/kfigure.py       | 212 ++++++++++++++++++++++++++----------
 tools/docker/Dockerfile     |   1 +
 3 files changed, 158 insertions(+), 57 deletions(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 483bdc42227..1342c71addd 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -18,6 +18,8 @@ the following dependencies are needed to build the documentation:
 
 * texlive-xetex (if building the `PDF documentation`_ through the *pdfdocs* target)
 
+* inkscape (if building the `PDF documentation`_ through the *pdfdocs* target)
+
 When submitting patches for documentation always build with KDOC_WERROR=1 to
 treat warnings as errors.
 
diff --git a/doc/sphinx/kfigure.py b/doc/sphinx/kfigure.py
index dea7f91ef5a..ad495c0da27 100644
--- a/doc/sphinx/kfigure.py
+++ b/doc/sphinx/kfigure.py
@@ -1,6 +1,7 @@
 # -*- coding: utf-8; mode: python -*-
+# SPDX-License-Identifier: GPL-2.0
 # pylint: disable=C0103, R0903, R0912, R0915
-u"""
+"""
     scalable figure and image handling
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -31,10 +32,13 @@ u"""
 
     * ``dot(1)``: Graphviz (https://www.graphviz.org). If Graphviz is not
       available, the DOT language is inserted as literal-block.
+      For conversion to PDF, ``rsvg-convert(1)`` of librsvg
+      (https://gitlab.gnome.org/GNOME/librsvg) is used when available.
 
     * SVG to PDF: To generate PDF, you need at least one of this tools:
 
       - ``convert(1)``: ImageMagick (https://www.imagemagick.org)
+      - ``inkscape(1)``: Inkscape (https://inkscape.org/)
 
     List of customizations:
 
@@ -49,36 +53,21 @@ import os
 from os import path
 import subprocess
 from hashlib import sha1
-import sys
-
+import re
 from docutils import nodes
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives import images
 import sphinx
-
 from sphinx.util.nodes import clean_astext
-from six import iteritems
-
-import kernellog
-
-PY3 = sys.version_info[0] == 3
+from sphinx.util import logging
 
-if PY3:
-    _unicode = str
-else:
-    _unicode = unicode
-
-# Get Sphinx version
-major, minor, patch = sphinx.version_info[:3]
-if major == 1 and minor > 3:
-    # patches.Figure only landed in Sphinx 1.4
-    from sphinx.directives.patches import Figure  # pylint: disable=C0413
-else:
-    Figure = images.Figure
+Figure = images.Figure
 
 __version__  = '1.0.0'
 
+logger = logging.getLogger('kfigure')
+
 # simple helper
 # -------------
 
@@ -121,10 +110,20 @@ def pass_handle(self, node):           # pylint: disable=W0613
 
 # Graphviz's dot(1) support
 dot_cmd = None
+# dot(1) -Tpdf should be used
+dot_Tpdf = False
 
 # ImageMagick' convert(1) support
 convert_cmd = None
 
+# librsvg's rsvg-convert(1) support
+rsvg_convert_cmd = None
+
+# Inkscape's inkscape(1) support
+inkscape_cmd = None
+# Inkscape prior to 1.0 uses different command options
+inkscape_ver_one = False
+
 
 def setup(app):
     # check toolchain first
@@ -167,28 +166,69 @@ def setup(app):
 
 
 def setupTools(app):
-    u"""
+    """
     Check available build tools and log some *verbose* messages.
 
     This function is called once, when the builder is initiated.
     """
-    global dot_cmd, convert_cmd   # pylint: disable=W0603
-    kernellog.verbose(app, "kfigure: check installed tools ...")
+    global dot_cmd, dot_Tpdf, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
+    global inkscape_cmd, inkscape_ver_one  # pylint: disable=W0603
+    logger.verbose("kfigure: check installed tools ...")
 
     dot_cmd = which('dot')
     convert_cmd = which('convert')
+    rsvg_convert_cmd = which('rsvg-convert')
+    inkscape_cmd = which('inkscape')
 
     if dot_cmd:
-        kernellog.verbose(app, "use dot(1) from: " + dot_cmd)
+        logger.verbose("use dot(1) from: " + dot_cmd)
+
+        try:
+            dot_Thelp_list = subprocess.check_output([dot_cmd, '-Thelp'],
+                                    stderr=subprocess.STDOUT)
+        except subprocess.CalledProcessError as err:
+            dot_Thelp_list = err.output
+            pass
+
+        dot_Tpdf_ptn = b'pdf'
+        dot_Tpdf = re.search(dot_Tpdf_ptn, dot_Thelp_list)
     else:
-        kernellog.warn(app, "dot(1) not found, for better output quality install "
-                       "graphviz from https://www.graphviz.org")
-    if convert_cmd:
-        kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
+        logger.warning(
+            "dot(1) not found, for better output quality install graphviz from https://www.graphviz.org"
+        )
+    if inkscape_cmd:
+        logger.verbose("use inkscape(1) from: " + inkscape_cmd)
+        inkscape_ver = subprocess.check_output([inkscape_cmd, '--version'],
+                                               stderr=subprocess.DEVNULL)
+        ver_one_ptn = b'Inkscape 1'
+        inkscape_ver_one = re.search(ver_one_ptn, inkscape_ver)
+        convert_cmd = None
+        rsvg_convert_cmd = None
+        dot_Tpdf = False
+
     else:
-        kernellog.warn(app,
-            "convert(1) not found, for SVG to PDF conversion install "
-            "ImageMagick (https://www.imagemagick.org)")
+        if convert_cmd:
+            logger.verbose("use convert(1) from: " + convert_cmd)
+        else:
+            logger.verbose(
+                "Neither inkscape(1) nor convert(1) found.\n"
+                "For SVG to PDF conversion, install either Inkscape (https://inkscape.org/) (preferred) or\n"
+                "ImageMagick (https://www.imagemagick.org)"
+            )
+
+        if rsvg_convert_cmd:
+            logger.verbose("use rsvg-convert(1) from: " + rsvg_convert_cmd)
+            logger.verbose("use 'dot -Tsvg' and rsvg-convert(1) for DOT -> PDF conversion")
+            dot_Tpdf = False
+        else:
+            logger.verbose(
+                "rsvg-convert(1) not found.\n"
+                "  SVG rendering of convert(1) is done by ImageMagick-native renderer."
+            )
+            if dot_Tpdf:
+                logger.verbose("use 'dot -Tpdf' for DOT -> PDF conversion")
+            else:
+                logger.verbose("use 'dot -Tsvg' and convert(1) for DOT -> PDF conversion")
 
 
 # integrate conversion tools
@@ -222,13 +262,12 @@ def convert_image(img_node, translator, src_fname=None):
 
     # in kernel builds, use 'make SPHINXOPTS=-v' to see verbose messages
 
-    kernellog.verbose(app, 'assert best format for: ' + img_node['uri'])
+    logger.verbose('assert best format for: ' + img_node['uri'])
 
     if in_ext == '.dot':
 
         if not dot_cmd:
-            kernellog.verbose(app,
-                              "dot from graphviz not available / include DOT raw.")
+            logger.verbose("dot from graphviz not available / include DOT raw.")
             img_node.replace_self(file2literal(src_fname))
 
         elif translator.builder.format == 'latex':
@@ -254,9 +293,12 @@ def convert_image(img_node, translator, src_fname=None):
     elif in_ext == '.svg':
 
         if translator.builder.format == 'latex':
-            if convert_cmd is None:
-                kernellog.verbose(app,
-                                  "no SVG to PDF conversion available / include SVG raw.")
+            if not inkscape_cmd and convert_cmd is None:
+                logger.warning(
+                    "no SVG to PDF conversion available / include SVG raw.\n"
+                    "Including large raw SVGs can cause xelatex error.\n"
+                    "Install Inkscape (preferred) or ImageMagick."
+                )
                 img_node.replace_self(file2literal(src_fname))
             else:
                 dst_fname = path.join(translator.builder.outdir, fname + '.pdf')
@@ -269,19 +311,25 @@ def convert_image(img_node, translator, src_fname=None):
         _name = dst_fname[len(str(translator.builder.outdir)) + 1:]
 
         if isNewer(dst_fname, src_fname):
-            kernellog.verbose(app,
-                              "convert: {out}/%s already exists and is newer" % _name)
+            logger.verbose("convert: {out}/%s already exists and is newer" % _name)
 
         else:
             ok = False
             mkdir(path.dirname(dst_fname))
 
             if in_ext == '.dot':
-                kernellog.verbose(app, 'convert DOT to: {out}/' + _name)
-                ok = dot2format(app, src_fname, dst_fname)
+                logger.verbose('convert DOT to: {out}/' + _name)
+                if translator.builder.format == 'latex' and not dot_Tpdf:
+                    svg_fname = path.join(translator.builder.outdir, fname + '.svg')
+                    ok1 = dot2format(app, src_fname, svg_fname)
+                    ok2 = svg2pdf_by_rsvg(app, svg_fname, dst_fname)
+                    ok = ok1 and ok2
+
+                else:
+                    ok = dot2format(app, src_fname, dst_fname)
 
             elif in_ext == '.svg':
-                kernellog.verbose(app, 'convert SVG to: {out}/' + _name)
+                logger.verbose('convert SVG to: {out}/' + _name)
                 ok = svg2pdf(app, src_fname, dst_fname)
 
             if not ok:
@@ -310,27 +358,77 @@ def dot2format(app, dot_fname, out_fname):
     with open(out_fname, "w") as out:
         exit_code = subprocess.call(cmd, stdout = out)
         if exit_code != 0:
-            kernellog.warn(app,
+            logger.warning(
                           "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
     return bool(exit_code == 0)
 
 def svg2pdf(app, svg_fname, pdf_fname):
-    """Converts SVG to PDF with ``convert(1)`` command.
+    """Converts SVG to PDF with ``inkscape(1)`` or ``convert(1)`` command.
 
-    Uses ``convert(1)`` from ImageMagick (https://www.imagemagick.org) for
-    conversion.  Returns ``True`` on success and ``False`` if an error occurred.
+    Uses ``inkscape(1)`` from Inkscape (https://inkscape.org/) or ``convert(1)``
+    from ImageMagick (https://www.imagemagick.org) for conversion.
+    Returns ``True`` on success and ``False`` if an error occurred.
 
     * ``svg_fname`` pathname of the input SVG file with extension (``.svg``)
     * ``pdf_name``  pathname of the output PDF file with extension (``.pdf``)
 
     """
     cmd = [convert_cmd, svg_fname, pdf_fname]
-    # use stdout and stderr from parent
-    exit_code = subprocess.call(cmd)
+    cmd_name = 'convert(1)'
+
+    if inkscape_cmd:
+        cmd_name = 'inkscape(1)'
+        if inkscape_ver_one:
+            cmd = [inkscape_cmd, '-o', pdf_fname, svg_fname]
+        else:
+            cmd = [inkscape_cmd, '-z', '--export-pdf=%s' % pdf_fname, svg_fname]
+
+    try:
+        warning_msg = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
+        exit_code = 0
+    except subprocess.CalledProcessError as err:
+        warning_msg = err.output
+        exit_code = err.returncode
+        pass
+
     if exit_code != 0:
-        kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
+        logger.warning("Error #%d when calling: %s" %
+                            (exit_code, " ".join(cmd)))
+        if warning_msg:
+            logger.warning( "Warning msg from %s: %s" %
+                                (cmd_name, str(warning_msg, 'utf-8')))
+    elif warning_msg:
+        logger.verbose("Warning msg from %s (likely harmless):\n%s" %
+                            (cmd_name, str(warning_msg, 'utf-8')))
+
     return bool(exit_code == 0)
 
+def svg2pdf_by_rsvg(app, svg_fname, pdf_fname):
+    """Convert SVG to PDF with ``rsvg-convert(1)`` command.
+
+    * ``svg_fname`` pathname of input SVG file, including extension ``.svg``
+    * ``pdf_fname`` pathname of output PDF file, including extension ``.pdf``
+
+    Input SVG file should be the one generated by ``dot2format()``.
+    SVG -> PDF conversion is done by ``rsvg-convert(1)``.
+
+    If ``rsvg-convert(1)`` is unavailable, fall back to ``svg2pdf()``.
+
+    """
+
+    if rsvg_convert_cmd is None:
+        ok = svg2pdf(app, svg_fname, pdf_fname)
+    else:
+        cmd = [rsvg_convert_cmd, '--format=pdf', '-o', pdf_fname, svg_fname]
+        # use stdout and stderr from parent
+        exit_code = subprocess.call(cmd)
+        if exit_code != 0:
+            logger.warning("Error #%d when calling: %s" %
+                                (exit_code, " ".join(cmd)))
+        ok = bool(exit_code == 0)
+
+    return ok
+
 
 # image handling
 # ---------------------
@@ -348,7 +446,7 @@ class kernel_image(nodes.image):
     pass
 
 class KernelImage(images.Image):
-    u"""KernelImage directive
+    """KernelImage directive
 
     Earns everything from ``.. image::`` directive, except *remote URI* and
     *glob* pattern. The KernelImage wraps a image node into a
@@ -384,7 +482,7 @@ class kernel_figure(nodes.figure):
     """Node for ``kernel-figure`` directive."""
 
 class KernelFigure(Figure):
-    u"""KernelImage directive
+    """KernelImage directive
 
     Earns everything from ``.. figure::`` directive, except *remote URI* and
     *glob* pattern.  The KernelFigure wraps a figure node into a kernel_figure
@@ -421,15 +519,15 @@ def visit_kernel_render(self, node):
     app = self.builder.app
     srclang = node.get('srclang')
 
-    kernellog.verbose(app, 'visit kernel-render node lang: "%s"' % (srclang))
+    logger.verbose('visit kernel-render node lang: "%s"' % srclang)
 
     tmp_ext = RENDER_MARKUP_EXT.get(srclang, None)
     if tmp_ext is None:
-        kernellog.warn(app, 'kernel-render: "%s" unknown / include raw.' % (srclang))
+        logger.warning( 'kernel-render: "%s" unknown / include raw.' % srclang)
         return
 
     if not dot_cmd and tmp_ext == '.dot':
-        kernellog.verbose(app, "dot from graphviz not available / include raw.")
+        logger.verbose("dot from graphviz not available / include raw.")
         return
 
     literal_block = node[0]
@@ -460,7 +558,7 @@ class kernel_render(nodes.General, nodes.Inline, nodes.Element):
     pass
 
 class KernelRender(Figure):
-    u"""KernelRender directive
+    """KernelRender directive
 
     Render content by external tool.  Has all the options known from the
     *figure*  directive, plus option ``caption``.  If ``caption`` has a
@@ -540,7 +638,7 @@ def add_kernel_figure_to_std_domain(app, doctree):
     docname = app.env.docname
     labels = std.data["labels"]
 
-    for name, explicit in iteritems(doctree.nametypes):
+    for name, explicit in doctree.nametypes.items():
         if not explicit:
             continue
         labelid = doctree.nameids[name]
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 8e166eda4bc..50d71f5bf90 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -90,6 +90,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	help2man \
 	iasl \
 	imagemagick \
+	inkscape \
 	inetutils-telnet \
 	iputils-ping \
 	libconfuse-dev \
-- 
2.34.1

