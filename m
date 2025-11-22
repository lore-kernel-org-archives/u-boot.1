Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F9CCFD30D
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 22:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6320C83B4F;
	Sat, 22 Nov 2025 23:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dR5KZ0xa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D0083B6C; Sat, 22 Nov 2025 23:18:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F96583B4E
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 23:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763849875; x=1764454675; i=xypron.glpk@gmx.de;
 bh=TKwG+i7Xd2Ch34g2AZlIRaWecEpPZD3qiga56bGsfdw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dR5KZ0xa34piBOrHewCBjXeYYlzzLD/T6P4sAyjEBiCmOnSvAgpaLhm2TnjsZYZP
 vXj/5BvfA+vH4HKAbrlfX16s7bb5EBEEaf/zZPl8Hv694Xv7/CoeKAOPpAOXZCmw7
 acg0QdkXiivRWNoV/FVy9nTOOUBFeKg3iKhwVY+E/kFK60li74zlpo+PINq6vgwuV
 yXLvVD592nNSLADP50yL/bVE4hfV+04/TAdzN+DEGqB/tlPmzbsGA7Ckx6L3LtJO5
 Ks1CRP0YvwSsQnTlf9/lrYRPurC9R1QMOFm9i6kLHz4qzEvS7ySAk5HyMp2mjyF81
 h6PqyZSobnWQBIiwmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from LT03 ([46.114.110.111]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1viz3514wy-00OY2g; Sat, 22
 Nov 2025 23:17:55 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/2] tools/logos: Add U-Boot logo with text 'U-Boot'
Date: Sat, 22 Nov 2025 23:17:37 +0100
Message-ID: <20251122221738.238704-2-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251122221738.238704-1-xypron.glpk@gmx.de>
References: <20251122221738.238704-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mudKt3x3pJStmny215uxj/CV7IL5/El9MzfGpMog3aLH0a2tT8g
 +muadqfTTdVceOCPK8/ZPWlhgCwM+mIxhBn31UvEIF/mTvCEj/ltRvt+9Sn1s8SFfNvSiKY
 kQAMqzlS5eBC7v7H/f5Mawg3hMPb60VXtGmZ5Yr7/nqYpolb5IpkIIJkRKFNC37wugcIz3+
 TYx9GaWiu91mZjTIvBXWQ==
UI-OutboundReport: notjunk:1;M01:P0:Zd1jt6DDTGw=;ny5y5xoG2RNwFOVGpFB0SILvu2o
 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
 ABJ3+NsPSGsbmOn3A/Vz7Ej2OSNJTvT8A==
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

The logo with the text 'U-Boot' has been used in multiple presentations.
Up to now it was only available from my upload to wikimedia.org.
Make it available in our repository.

Link: https://upload.wikimedia.org/wikipedia/commons/9/9e/U-Boot_Logo.svg
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 tools/logos/u-boot_logo_with_text.svg | 280 ++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)
 create mode 100644 tools/logos/u-boot_logo_with_text.svg

diff --git a/tools/logos/u-boot_logo_with_text.svg b/tools/logos/u-boot_lo=
go_with_text.svg
new file mode 100644
index 00000000000..1527e79a3a9
=2D-- /dev/null
+++ b/tools/logos/u-boot_logo_with_text.svg
@@ -0,0 +1,280 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
+<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
+
+<!-- Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> -->
+
+<svg
+   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
+   xmlns:cc=3D"http://creativecommons.org/ns#"
+   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:svg=3D"http://www.w3.org/2000/svg"
+   xmlns=3D"http://www.w3.org/2000/svg"
+   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
+   width=3D"186"
+   height=3D"244"
+   viewBox=3D"0 0 186 244"
+   id=3D"svg2"
+   version=3D"1.1"
+   inkscape:version=3D"0.92.4 (5da689c313, 2019-01-14)"
+   sodipodi:docname=3D"u-boot_logo.svg"
+   inkscape:export-filename=3D"tools/logos/u-boot_logo.png"
+   inkscape:export-xdpi=3D"41.290001"
+   inkscape:export-ydpi=3D"41.290001">
+  <title
+     id=3D"title30">U-Boot Logo</title>
+  <metadata
+     id=3D"metadata31">
+    <rdf:RDF>
+      <cc:Work
+         rdf:about=3D"">
+        <dc:format>image/svg+xml</dc:format>
+        <dc:type
+           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
+        <dc:title>U-Boot Logo</dc:title>
+        <cc:license
+           rdf:resource=3D"http://creativecommons.org/licenses/by-sa/4.0/=
" />
+        <dc:creator>
+          <cc:Agent>
+            <dc:title>Heinrich Schuchardt &lt;xypron.glpk@gmx.de&gt;</dc:=
title>
+          </cc:Agent>
+        </dc:creator>
+        <dc:date>May 21st, 2018</dc:date>
+      </cc:Work>
+      <cc:License
+         rdf:about=3D"http://creativecommons.org/licenses/by-sa/4.0/">
+        <cc:permits
+           rdf:resource=3D"http://creativecommons.org/ns#Reproduction" />
+        <cc:permits
+           rdf:resource=3D"http://creativecommons.org/ns#Distribution" />
+        <cc:requires
+           rdf:resource=3D"http://creativecommons.org/ns#Notice" />
+        <cc:requires
+           rdf:resource=3D"http://creativecommons.org/ns#Attribution" />
+        <cc:permits
+           rdf:resource=3D"http://creativecommons.org/ns#DerivativeWorks"=
 />
+        <cc:requires
+           rdf:resource=3D"http://creativecommons.org/ns#ShareAlike" />
+      </cc:License>
+    </rdf:RDF>
+  </metadata>
+  <defs
+     id=3D"defs29" />
+  <sodipodi:namedview
+     pagecolor=3D"#ffffff"
+     bordercolor=3D"#666666"
+     borderopacity=3D"1"
+     objecttolerance=3D"10"
+     gridtolerance=3D"10"
+     guidetolerance=3D"10"
+     inkscape:pageopacity=3D"0"
+     inkscape:pageshadow=3D"2"
+     inkscape:window-width=3D"1920"
+     inkscape:window-height=3D"1051"
+     id=3D"namedview27"
+     showgrid=3D"false"
+     inkscape:zoom=3D"2.1213203"
+     inkscape:cx=3D"40"
+     inkscape:cy=3D"66.333333"
+     inkscape:window-x=3D"0"
+     inkscape:window-y=3D"0"
+     inkscape:window-maximized=3D"1"
+     inkscape:current-layer=3D"flowRoot840" />
+  <g
+     inkscape:label=3D"Layer 1"
+     inkscape:groupmode=3D"layer"
+     id=3D"layer1"
+     transform=3D"translate(0,58)">
+    <circle
+       style=3D"fill:#004466;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path835"
+       cx=3D"93"
+       cy=3D"35"
+       r=3D"93" />
+    <path
+       inkscape:connector-curvature=3D"0"
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:none;stroke-width:0"
+       d=3D"M 116,18 A 20,20 0 0 1 96,-2 20,20 0 0 1 116,-22 v 11 a 9,9 0=
 0 0 -9,9 9,9 0 0 0 9,9 z"
+       id=3D"path4136-6-6-1-6-3-5" />
+    <path
+       inkscape:connector-curvature=3D"0"
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:none;stroke-width:0"
+       d=3D"m 116,8 a 10,10 0 0 1 -10,-10 10,10 0 0 1 10,-10 v 1 a 9,9 0 =
0 0 -9,9 9,9 0 0 0 9,9 z"
+       id=3D"path4136-6-6-1-6-3-5-1-9" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4136-6-6-1-6-3-5-1-2"
+       cx=3D"116"
+       cy=3D"-16.5"
+       rx=3D"4"
+       ry=3D"5.5" />
+    <circle
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4352"
+       cx=3D"86"
+       cy=3D"8"
+       r=3D"10" />
+    <circle
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4352-1"
+       cx=3D"126"
+       cy=3D"8"
+       r=3D"10" />
+    <rect
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"rect4399"
+       width=3D"39"
+       height=3D"20"
+       x=3D"86.5"
+       y=3D"-2" />
+    <rect
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"rect4660"
+       width=3D"60"
+       height=3D"9.5"
+       x=3D"76"
+       y=3D"8.5" />
+    <circle
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4549-5"
+       cx=3D"36"
+       cy=3D"23"
+       r=3D"15" />
+    <circle
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4549-5-5"
+       cx=3D"36"
+       cy=3D"63"
+       r=3D"15" />
+    <ellipse
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:#000000;stroke-width:0=
"
+       id=3D"path4136-6-6"
+       cx=3D"15"
+       cy=3D"33"
+       rx=3D"4"
+       ry=3D"10" />
+    <ellipse
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:#000000;stroke-width:0=
"
+       id=3D"path4136-6-6-1"
+       cx=3D"15"
+       cy=3D"53"
+       rx=3D"4"
+       ry=3D"10" />
+    <rect
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:#000000;stroke-width:0=
"
+       id=3D"rect4213"
+       width=3D"65"
+       height=3D"4"
+       x=3D"11"
+       y=3D"41" />
+    <ellipse
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:#000000;stroke-width:0=
"
+       id=3D"path4136"
+       cx=3D"100.5"
+       cy=3D"42.5"
+       rx=3D"74.5"
+       ry=3D"34.5" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416"
+       cx=3D"70"
+       cy=3D"37.5"
+       rx=3D"15"
+       ry=3D"12.5" />
+    <ellipse
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-9"
+       cx=3D"70"
+       cy=3D"37.5"
+       rx=3D"14"
+       ry=3D"11.5" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-0"
+       cx=3D"70"
+       cy=3D"37.5"
+       rx=3D"11"
+       ry=3D"8.5" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-94"
+       cx=3D"110"
+       cy=3D"37.5"
+       rx=3D"15"
+       ry=3D"12.5" />
+    <ellipse
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-9-1"
+       cx=3D"110"
+       cy=3D"37.5"
+       rx=3D"14"
+       ry=3D"11.5" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-0-1"
+       cx=3D"110"
+       cy=3D"37.5"
+       rx=3D"11"
+       ry=3D"8.5" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-94-2"
+       cx=3D"150"
+       cy=3D"37.5"
+       rx=3D"15"
+       ry=3D"12.5" />
+    <ellipse
+       style=3D"fill:#ffcc88;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-9-1-2"
+       cx=3D"150"
+       cy=3D"37.5"
+       rx=3D"14"
+       ry=3D"11.5" />
+    <ellipse
+       style=3D"fill:#dd9955;fill-opacity:1;stroke:none;stroke-width:0"
+       id=3D"path4416-0-1-9"
+       cx=3D"150"
+       cy=3D"37.5"
+       rx=3D"11"
+       ry=3D"8.5" />
+    <g
+       aria-label=3D"U-Boot"
+       transform=3D"matrix(1.4316296,0,0,1.4316493,154.42725,-33.934324)"
+       style=3D"font-style:normal;font-weight:normal;font-size:40px;line-=
height:1.25;font-family:sans-serif;text-align:center;letter-spacing:0px;wo=
rd-spacing:0px;text-anchor:middle;fill:#004466;fill-opacity:1;stroke:none"
+       id=3D"flowRoot840">
+      <g
+         id=3D"g3123">
+        <path
+           style=3D"stroke-width:0.99455768"
+           id=3D"path1717"
+           d=3D"m -107.86816,123.89647 h 3.9218 v 17.71485 q 0,4.6875 1.6=
8078,6.75781 1.68077,2.05078 5.44802,2.05078 3.747933,0 5.428707,-2.05078 =
1.680773,-2.07031 1.680773,-6.75781 v -17.71485 h 3.921806 v 18.20313 q 0,=
5.70312 -2.80129,8.61328 -2.78197,2.91016 -8.229996,2.91016 -5.46734,0 -8.=
26863,-2.91016 -2.78197,-2.91016 -2.78197,-8.61328 z"
+           inkscape:connector-curvature=3D"0" />
+        <path
+           id=3D"path1719"
+           style=3D"fill:#dd9955;fill-opacity:1;stroke-width:0.99455768"
+           d=3D"m -80.415526,140.49804 h 10.413069 v 3.20312 h -10.413069=
 z"
+           inkscape:connector-curvature=3D"0" />
+        <path
+           style=3D"stroke-width:0.99455768"
+           id=3D"path1721"
+           d=3D"m -60.28488,139.13085 v 10.68359 h 6.259433 q 3.149036,0 =
4.655936,-1.30859 1.526221,-1.32813 1.526221,-4.04297 0,-2.73437 -1.526221=
,-4.02344 -1.5069,-1.30859 -4.655936,-1.30859 z m 0,-11.99219 v 8.78906 h =
5.776453 q 2.859247,0 4.250232,-1.07421 1.410304,-1.09375 1.410304,-3.3203=
2 0,-2.20703 -1.410304,-3.30078 -1.390985,-1.09375 -4.250232,-1.09375 z m =
-3.902486,-3.24219 h 9.968727 q 4.462744,0 6.877649,1.875 2.414905,1.875 2=
.414905,5.33204 0,2.67578 -1.236432,4.25781 -1.236431,1.58203 -3.632016,1.=
97265 2.878566,0.625 4.462744,2.61719 1.603496,1.97266 1.603496,4.94141 0,=
3.90625 -2.627416,6.03515 -2.627417,2.12891 -7.476545,2.12891 h -10.355112=
 z"
+           inkscape:connector-curvature=3D"0" />
+        <path
+           style=3D"stroke-width:0.99455768"
+           id=3D"path1723"
+           d=3D"m -28.813841,133.70116 q -2.859247,0 -4.520701,2.26563 -1=
.661455,2.24609 -1.661455,6.17187 0,3.92578 1.642136,6.19141 1.661454,2.24=
609 4.54002,2.24609 2.839928,0 4.501383,-2.26562 1.661454,-2.26563 1.66145=
4,-6.17188 0,-3.88672 -1.661454,-6.15234 -1.661455,-2.28516 -4.501383,-2.2=
8516 z m 0,-3.04687 q 4.636617,0 7.283354,3.04687 2.646735,3.04688 2.64673=
5,8.4375 0,5.3711 -2.646735,8.4375 -2.646737,3.04688 -7.283354,3.04688 -4.=
655936,0 -7.302672,-3.04688 -2.627416,-3.0664 -2.627416,-8.4375 0,-5.39062=
 2.627416,-8.4375 2.646736,-3.04687 7.302672,-3.04687 z"
+           inkscape:connector-curvature=3D"0" />
+        <path
+           style=3D"stroke-width:0.99455768"
+           id=3D"path1725"
+           d=3D"m -4.6068351,133.70116 q -2.8592473,0 -4.5207018,2.26563 =
-1.6614541,2.24609 -1.6614541,6.17187 0,3.92578 1.6421348,6.19141 1.661454=
5,2.24609 4.5400211,2.24609 2.839928,0 4.50138246,-2.26562 1.66145444,-2.2=
6563 1.66145444,-6.17188 0,-3.88672 -1.66145444,-6.15234 -1.66145446,-2.28=
516 -4.50138246,-2.28516 z m 0,-3.04687 q 4.63661713,0 7.2833528,3.04687 2=
.6467357,3.04688 2.6467357,8.4375 0,5.3711 -2.6467357,8.4375 -2.64673567,3=
.04688 -7.2833528,3.04688 -4.6559365,0 -7.3026719,-3.04688 -2.627417,-3.06=
64 -2.627417,-8.4375 0,-5.39062 2.627417,-8.4375 2.6467354,-3.04687 7.3026=
719,-3.04687 z"
+           inkscape:connector-curvature=3D"0" />
+        <path
+           style=3D"stroke-width:0.99455768"
+           id=3D"path1727"
+           d=3D"m 14.731723,124.97069 v 6.21094 h 7.321991 v 2.79297 h -7=
.321991 v 11.875 q 0,2.67578 0.714811,3.4375 0.734132,0.76172 2.955843,0.7=
6172 h 3.651337 v 3.00781 h -3.651337 q -4.114997,0 -5.679855,-1.54297 -1.=
564858,-1.5625 -1.564858,-5.66406 v -11.875 H 8.5495661 v -2.79297 h 2.608=
0979 v -6.21094 z"
+           inkscape:connector-curvature=3D"0" />
+      </g>
+    </g>
+  </g>
+</svg>
=2D-=20
2.51.0

