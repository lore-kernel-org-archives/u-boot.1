Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F020C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04DF481128;
	Thu, 24 Sep 2026 12:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lT7_fYUpWQoa; Thu, 24 Sep 2026 12:37:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 90AEE80A82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253451;
	b=m0oJHwQcmfjsdwzr4QAlIWUIvhdBcxUETKyMrEO/aYLCVZT+oJXjWsCKTLR6e8l2RT6r
	 bOlK/HiLm8adqwQR96qXZh1KaHde3BK8QSR1mmEDAqTtcdvVxBPG2UsP8x0LcpYXrvq8y
	 JfE/yGMV+VIEc37/zZZOvHWNR6ojRM4aH/haxKhv1igRmFb3kc1p8BmJCbhgN5K6Usldr
	 R3sKAh61/f5J1y15AVbiFgGiIppRemHMZL/aE2NES43M0zgd22LaV9fEi3svFPnNGuOVU
	 NC/X4H5tBs9P/hGHS5RZfkyKpHUXi+XJ3pD7RpomLfVVcKwOklwDIZnA+Yvk8gr0SFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VaSWcvr4a9gPrD8rDRhXdldSenX+1mKzY+06JLHiqpk=;
	b=MvrxY1t2L1qPnr6wEuYOQ8aTAidYaOGrVvzNHSu6GcuGZ7LdqUzsp86xpdkZXLbWPHTD
	 u/Ct7ivm/dtuwaJY9GAPmOcsOzuRwjmL+8cYgbxtmI4lAn6lw0Wii0rRgx53YnSZ42cSl
	 bqmtTWW06gVKEnDjmPQT2dRq3GZYFyeLg5gBNioONCvuVZIDcm4leJ3qVF8KxjK34gt9/
	 bH8LBCOvCO7HpZRL6C3N+1Sa/5baaoP0gHhsi+maO7F5mAkhUA+Oa/IPtx4V3eSbewOAy
	 R9A3i2hVkeJd3DcYDaCxw5sowGRKK1Fl23EAgtc6uQb+dxnUlLcPfM7ZiWEd3VhjBGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gpJbu1VI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253451;
	bh=VaSWcvr4a9gPrD8rDRhXdldSenX+1mKzY+06JLHiqpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K2IfPmoa83FfQDWbPg6TqFsJaYbutGBgAP4jfdpTElUNKj7ePXxam1/0aa/na1Hss
	 V1STwUBCTNYern6NQGyS+HOmn8qJFKondJRPDbStTA+tGAELQYScxWiYO3L6U76Z4W
	 MeOOc9Jh7NVQfE/RDM3jopvomrpR/adZSRcbi06DYV8L35HP4RuYseWKcfWKZuDq8f
	 ivIlo+h5g39TMbwugDHDSJdAIA0DnyrDA8hGQ9G7+uTOSI1FATG1GTs6gKnKYPdYgg
	 o+RWlcqZwVGhwzjG81igYvhe3WyCsj9/Fwc68ta3jxfa73274E1NAf6pf9gD/jDbA2
	 8MNb6/51wQBzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90AEE80A82;
	Thu, 24 Sep 2026 12:37:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B187194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C9A781D21
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bs1sfTsTgCEJ for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 384DB81916
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253446;
 b=kQFB3cdNAo/gfPYIW1RTKEB8/3b6ixGpW/+UXNJRcD8atn9K7q8RaO5HStRQREiN4u7+
 vnItUZl7IoXEJRDiO9CQc/u/ozbklRD9e1x1IonsD3We5G2iNCSekdnoFjbr1ZQ3AaQ6m
 k0UXvkihtJ+LrlWNu7yqCtiVVkYpAByd1Y1x7snsOIh1/bnWeTRNtLvGEV16DTjfV0NfH
 Ay0Pqhx9g+rCJHGTe4rAr3M4/6jX9d1hhzLS+eCqW5EkYuFdvrevJ1tMWfVJ/nHjpK8eM
 8GnU1tRHVy4DclNfx/RmGo1DhrmcwO7TWFpV0mgW07BdQQzm/tt2O6tFpqpPC1SMVWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253446;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=VaSWcvr4a9gPrD8rDRhXdldSenX+1mKzY+06JLHiqpk=;
 b=O6UZNSL17WRZtJfcsLK2ksgkGDOa88xrbJmhxQBJTubFkCpbrDjFNrw3pXgG/LWXM99x
 pt+DeC8DkMnN4oSyHB4mbuDjXqqHQVPV32/a3ZA9IFA+uVQp3+y0qxVRvzIirQpfgfwkN
 QOUEOcgpv8R9nKzfL1l5haNSqX+mZ4J62XFIbzSaeUWn2ePtMnuV4HEmYsgAlslp4dhm2
 vx01AY/On3z3h1vPJX82os7A/xgn07F/NTT6bU5MwILqLlWtdyaeg1v5vgeU1cf2Stm5L
 omNrgsxYv3rbFn5EGTbxNYwp4PZk6fEsuGEqrbX7Z32yTkKyspTeVcpkv2XYoJ+Fsmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gpJbu1VI; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=gpJbu1VI
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 384DB81916
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4C49D1A1001;
 Thu, 24 Sep 2026 12:37:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1FA9A60341;
 Thu, 24 Sep 2026 12:37:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 27FAD10329471; 
 Thu, 24 Sep 2026 14:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253443; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=VaSWcvr4a9gPrD8rDRhXdldSenX+1mKzY+06JLHiqpk=;
 b=gpJbu1VIwo3rxXYzD55BwwJpI2z8t5MeuEHibjgFzN7Y/gdU/P4MouuOXPKzXPY1c6OK5T
 nAK+TYixjD2QG7O0lFGNAX/2hR6NOKnvZESqUHvY09fz/9UYNrhN6w6aJLqTPSTvX/qH8j
 JVlTGuW1NvRAcyObghRqnrmkkhfvkZuD8KHp0GFuda0T2cjqYHe3SMLFVw+UIjSlyrOMs4
 hrXi/W7i2KnSFFyirOkTFXu+ZxMZHLjuBkktKPqL8qut8vIu/J2YcIfOUi500nUjE5fO3E
 Yf6YnkalPyY1t+pEi9lsaQRRyofbxe1FhhC05SgHKCu0jWlKLcIPyR4NwyTaVw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 22/22] doc: board: ti: Add Jacinto resume flow
Date: Thu, 24 Sep 2026 14:35:33 +0200
Message-ID: <20260924123533.2599438-23-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Update Jacinto documentation with the resume flow.

Add a new diagram for the resume flow and modify the boot flow by
adding:
- Extract context address from device tree
- Power on rproc cluster PD
- Auth ATF/OP-TEE/DM certs and apply firewalls
- Send context address
- Firewall context address area

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 doc/board/ti/img/boot_diagram_k3_current.svg |  444 ++++-
 doc/board/ti/img/resume_diagram_k3.svg       | 1638 ++++++++++++++++++
 doc/board/ti/j7200_evm.rst                   |   14 +
 doc/board/ti/j721s2_evm.rst                  |   14 +
 doc/board/ti/j722s_evm.rst                   |   14 +
 doc/board/ti/j784s4_evm.rst                  |   14 +
 6 files changed, 2048 insertions(+), 90 deletions(-)
 create mode 100644 doc/board/ti/img/resume_diagram_k3.svg

diff --git a/doc/board/ti/img/boot_diagram_k3_current.svg b/doc/board/ti/img/boot_diagram_k3_current.svg
index e38a42a8960e..d482ac1f111d 100644
--- a/doc/board/ti/img/boot_diagram_k3_current.svg
+++ b/doc/board/ti/img/boot_diagram_k3_current.svg
@@ -6,8 +6,8 @@
 <svg
    version="1.1"
    width="706px"
-   height="951px"
-   viewBox="-0.5 -0.5 706 951"
+   height="1191px"
+   viewBox="-0.5 -0.5 706 1191"
    id="svg408"
    sodipodi:docname="boot_diagram_j7200_am62x.svg"
    inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
@@ -51,7 +51,7 @@
        pointer-events="all"
        id="rect4" />
     <path
-       d="M 304.25 90 L 304.25 940"
+       d="M 304.25 90 L 304.25 1180"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -142,7 +142,7 @@
        x="299.75"
        y="305"
        width="10"
-       height="205"
+       height="445"
        fill="rgb(255, 255, 255)"
        stroke="rgb(0, 0, 0)"
        pointer-events="all"
@@ -272,9 +272,51 @@ config data</xhtml:div>
            id="text44">Load system...</text>
       </switch>
     </g>
-    <rect
+        <rect
        x="310"
        y="336"
+       width="150"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect400" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g401">
+      <switch
+         id="switch402">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 148px; height: 1px; padding-top: 356px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Set LPM core bus path<xhtml:br />and compatible</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="385"
+           y="360"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text403">Set LPM core bus path</text>
+      </switch>
+    </g>
+<rect
+       x="310"
+       y="376"
        width="90"
        height="32"
        rx="4.8"
@@ -295,7 +337,7 @@ config data</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 352px; margin-left: 311px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 392px; margin-left: 311px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -306,17 +348,239 @@ config data</xhtml:div>
         </foreignObject>
         <text
            x="355"
-           y="356"
+           y="396"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
            text-anchor="middle"
            id="text52">DDR Config</text>
       </switch>
+    </g>    <rect
+       x="310"
+       y="408"
+       width="140"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect410" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g411">
+      <switch
+         id="switch412">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 138px; height: 1px; padding-top: 428px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Extract context address<xhtml:br />from device tree</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="380"
+           y="432"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text413">Extract context address</text>
+      </switch>
     </g>
+    <path
+       d="M 297 478 L 141 478"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path411" />
+    <path
+       d="M 134 478 L 141 474.5 L 139.25 478 L 141 481.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path412" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g413">
+      <switch
+         id="switch414">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 462px; margin-left: 215px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Power on rproc cluster PD</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="215"
+           y="465"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text415">Power on rproc cluster PD</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 522 L 141 522"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path421" />
+    <path
+       d="M 134 522 L 141 518.5 L 139.25 522 L 141 525.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path422" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g423">
+      <switch
+         id="switch424">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 150px; height: 1px; padding-top: 499px; margin-left: 144px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Auth ATF/OP-TEE/DM certs<xhtml:br />and apply firewalls</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="219"
+           y="502"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text425">Auth ATF/OP-TEE/DM certs</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 552 L 141 552"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path431" />
+    <path
+       d="M 134 552 L 141 548.5 L 139.25 552 L 141 555.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path432" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g433">
+      <switch
+         id="switch434">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 536px; margin-left: 215px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Send context address</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="215"
+           y="539"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text435">Send context address</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 582 L 141 582"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path441" />
+    <path
+       d="M 134 582 L 141 578.5 L 139.25 582 L 141 585.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path442" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g443">
+      <switch
+         id="switch444">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 566px; margin-left: 218px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Firewall context address area</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="218"
+           y="569"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text445">Firewall context address area</text>
+      </switch>
+    </g>
+
     <rect
        x="310"
-       y="368"
+       y="608"
        width="90"
        height="32"
        rx="4.8"
@@ -337,7 +601,7 @@ config data</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 384px; margin-left: 311px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 624px; margin-left: 311px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -348,7 +612,7 @@ config data</xhtml:div>
         </foreignObject>
         <text
            x="355"
-           y="388"
+           y="628"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -358,7 +622,7 @@ config data</xhtml:div>
     </g>
     <rect
        x="310"
-       y="440"
+       y="680"
        width="90"
        height="32"
        rx="4.8"
@@ -379,7 +643,7 @@ config data</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 456px; margin-left: 311px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 696px; margin-left: 311px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -390,7 +654,7 @@ config data</xhtml:div>
         </foreignObject>
         <text
            x="355"
-           y="460"
+           y="700"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -400,7 +664,7 @@ config data</xhtml:div>
     </g>
     <rect
        x="310"
-       y="472"
+       y="712"
        width="90"
        height="32"
        rx="4.8"
@@ -421,7 +685,7 @@ config data</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 488px; margin-left: 311px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 728px; margin-left: 311px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -432,7 +696,7 @@ config data</xhtml:div>
         </foreignObject>
         <text
            x="355"
-           y="492"
+           y="732"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -442,7 +706,7 @@ config data</xhtml:div>
     </g>
     <rect
        x="300"
-       y="530"
+       y="770"
        width="10"
        height="410"
        fill="rgb(255, 255, 255)"
@@ -451,7 +715,7 @@ config data</xhtml:div>
        id="rect82" />
     <rect
        x="302"
-       y="535"
+       y="775"
        width="71.5"
        height="30"
        fill="#e1d5e7"
@@ -470,7 +734,7 @@ config data</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 550px; margin-left: 303px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 790px; margin-left: 303px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -481,7 +745,7 @@ config data</xhtml:div>
         </foreignObject>
         <text
            x="338"
-           y="554"
+           y="794"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -490,14 +754,14 @@ config data</xhtml:div>
       </switch>
     </g>
     <path
-       d="M 299 456 L 139.37 456"
+       d="M 299 696 L 139.37 696"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path92" />
     <path
-       d="M 134.12 456 L 141.12 452.5 L 139.37 456 L 141.12 459.5 Z"
+       d="M 134.12 696 L 141.12 692.5 L 139.37 696 L 141.12 699.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -515,7 +779,7 @@ config data</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 440px; margin-left: 257px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 680px; margin-left: 257px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
@@ -526,7 +790,7 @@ config data</xhtml:div>
         </foreignObject>
         <text
            x="257"
-           y="443"
+           y="683"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="11px"
@@ -535,98 +799,98 @@ config data</xhtml:div>
       </switch>
     </g>
     <path
-       d="M 481 601 L 139.37 601"
+       d="M 481 841 L 139.37 841"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path102" />
     <path
-       d="M 134.12 601 L 141.12 597.5 L 139.37 601 L 141.12 604.5 Z"
+       d="M 134.12 841 L 141.12 837.5 L 139.37 841 L 141.12 844.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="all"
        id="path104" />
     <path
-       d="M 481 711 L 139.37 711"
+       d="M 481 951 L 139.37 951"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path106" />
     <path
-       d="M 134.12 711 L 141.12 707.5 L 139.37 711 L 141.12 714.5 Z"
+       d="M 134.12 951 L 141.12 947.5 L 139.37 951 L 141.12 954.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="all"
        id="path108" />
     <path
-       d="M 482 692 L 317.37 691.04"
+       d="M 482 932 L 317.37 931.04"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path110" />
     <path
-       d="M 312.12 691.01 L 319.14 687.55 L 317.37 691.04 L 319.1 694.55 Z"
+       d="M 312.12 931.01 L 319.14 927.55 L 317.37 931.04 L 319.1 934.55 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="all"
        id="path112" />
     <path
-       d="M 482 799 L 317.37 798.04"
+       d="M 482 1039 L 317.37 1038.04"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path114" />
     <path
-       d="M 312.12 798.01 L 319.14 794.55 L 317.37 798.04 L 319.1 801.55 Z"
+       d="M 312.12 1038.01 L 319.14 1034.55 L 317.37 1038.04 L 319.1 1041.55 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="all"
        id="path116" />
     <path
-       d="M 481 791 L 139.37 791"
+       d="M 481 1031 L 139.37 1031"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path118" />
     <path
-       d="M 134.12 791 L 141.12 787.5 L 139.37 791 L 141.12 794.5 Z"
+       d="M 134.12 1031 L 141.12 1027.5 L 139.37 1031 L 141.12 1034.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="all"
        id="path120" />
     <path
-       d="M 481 890 L 315.37 890.96"
+       d="M 481 1130 L 315.37 1130.96"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path122" />
     <path
-       d="M 310.12 890.99 L 317.1 887.45 L 315.37 890.96 L 317.14 894.45 Z"
+       d="M 310.12 1130.99 L 317.1 1127.45 L 315.37 1130.96 L 317.14 1134.45 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="all"
        id="path124" />
     <path
-       d="M 481 879 L 139.37 881.95"
+       d="M 481 1119 L 139.37 1121.95"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path126" />
     <path
-       d="M 134.12 881.99 L 141.09 878.43 L 139.37 881.95 L 141.15 885.43 Z"
+       d="M 134.12 1121.99 L 141.09 1118.43 L 139.37 1121.95 L 141.15 1125.43 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -644,7 +908,7 @@ config data</xhtml:div>
        pointer-events="all"
        id="rect130" />
     <path
-       d="M 487 90 L 487 820"
+       d="M 487 90 L 487 1060"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -684,7 +948,7 @@ config data</xhtml:div>
     </g>
     <rect
        x="482"
-       y="510"
+       y="750"
        width="10"
        height="70"
        fill="rgb(255, 255, 255)"
@@ -692,14 +956,14 @@ config data</xhtml:div>
        pointer-events="all"
        id="rect140" />
     <path
-       d="M 482 565 L 139.37 565"
+       d="M 482 805 L 139.37 805"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path142" />
     <path
-       d="M 134.12 565 L 141.12 561.5 L 139.37 565 L 141.12 568.5 Z"
+       d="M 134.12 805 L 141.12 801.5 L 139.37 805 L 141.12 808.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -717,7 +981,7 @@ config data</xhtml:div>
        pointer-events="all"
        id="rect146" />
     <path
-       d="M 635.25 90 L 635.25 950"
+       d="M 635.25 90 L 635.25 1190"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -758,7 +1022,7 @@ C6x/C7x</xhtml:div>
     </g>
     <rect
        x="631"
-       y="910"
+       y="1150"
        width="10"
        height="38"
        fill="rgb(255, 255, 255)"
@@ -767,7 +1031,7 @@ C6x/C7x</xhtml:div>
        id="rect156" />
     <rect
        x="633"
-       y="912"
+       y="1152"
        width="71.5"
        height="30"
        fill="#e1d5e7"
@@ -786,7 +1050,7 @@ C6x/C7x</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 927px; margin-left: 634px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 1167px; margin-left: 634px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -797,7 +1061,7 @@ C6x/C7x</xhtml:div>
         </foreignObject>
         <text
            x="669"
-           y="931"
+           y="1171"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -817,7 +1081,7 @@ C6x/C7x</xhtml:div>
        pointer-events="all"
        id="rect166" />
     <path
-       d="M 127 90 L 127 940"
+       d="M 127 90 L 127 1180"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -908,7 +1172,7 @@ C6x/C7x</xhtml:div>
        x="122"
        y="253"
        width="10"
-       height="687"
+       height="927"
        fill="rgb(255, 255, 255)"
        stroke="rgb(0, 0, 0)"
        pointer-events="all"
@@ -1404,7 +1668,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="310"
-       y="400"
+       y="640"
        width="90"
        height="32"
        rx="4.8"
@@ -1425,7 +1689,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 416px; margin-left: 311px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 656px; margin-left: 311px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1436,7 +1700,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="355"
-           y="420"
+           y="660"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1445,14 +1709,14 @@ Processor</xhtml:div>
       </switch>
     </g>
     <path
-       d="M 303 510 L 333 510 L 333 530 L 309.12 530"
+       d="M 303 750 L 333 750 L 333 770 L 309.12 770"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path302" />
     <path
-       d="M 302.12 530 L 309.12 526.5 L 309.12 533.5 Z"
+       d="M 302.12 770 L 309.12 766.5 L 309.12 773.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -1470,7 +1734,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-start; width: 1px; height: 1px; padding-top: 521px; margin-left: 337px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-start; width: 1px; height: 1px; padding-top: 761px; margin-left: 337px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: left;"
                data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
@@ -1481,7 +1745,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="337"
-           y="524"
+           y="764"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="11px"
@@ -1489,14 +1753,14 @@ Processor</xhtml:div>
       </switch>
     </g>
     <path
-       d="M 133 511 L 137 511 L 476.63 511"
+       d="M 133 751 L 137 751 L 476.63 751"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path312" />
     <path
-       d="M 481.88 511 L 474.88 514.5 L 476.63 511 L 474.88 507.5 Z"
+       d="M 481.88 751 L 474.88 754.5 L 476.63 751 L 474.88 747.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -1514,7 +1778,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 500px; margin-left: 177px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 740px; margin-left: 177px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
@@ -1525,7 +1789,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="177"
-           y="503"
+           y="743"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="11px"
@@ -1535,7 +1799,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="484"
-       y="513"
+       y="753"
        width="71.5"
        height="30"
        fill="#d5e8d4"
@@ -1554,7 +1818,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 528px; margin-left: 485px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 768px; margin-left: 485px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1565,7 +1829,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="520"
-           y="532"
+           y="772"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1575,7 +1839,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="482"
-       y="581"
+       y="821"
        width="10"
        height="70"
        fill="rgb(255, 255, 255)"
@@ -1584,7 +1848,7 @@ Processor</xhtml:div>
        id="rect330" />
     <rect
        x="484"
-       y="584"
+       y="824"
        width="71.5"
        height="30"
        fill="#d5e8d4"
@@ -1603,7 +1867,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 599px; margin-left: 485px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 839px; margin-left: 485px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1614,7 +1878,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="520"
-           y="603"
+           y="843"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1624,7 +1888,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="482"
-       y="662"
+       y="902"
        width="10"
        height="78"
        fill="rgb(255, 255, 255)"
@@ -1633,7 +1897,7 @@ Processor</xhtml:div>
        id="rect340" />
     <rect
        x="484"
-       y="665"
+       y="905"
        width="83"
        height="30"
        fill="#d5e8d4"
@@ -1652,7 +1916,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 81px; height: 1px; padding-top: 680px; margin-left: 485px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 81px; height: 1px; padding-top: 920px; margin-left: 485px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1663,7 +1927,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="526"
-           y="684"
+           y="924"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1673,7 +1937,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="482"
-       y="748"
+       y="988"
        width="10"
        height="192"
        fill="rgb(255, 255, 255)"
@@ -1682,7 +1946,7 @@ Processor</xhtml:div>
        id="rect350" />
     <rect
        x="484"
-       y="751"
+       y="991"
        width="83"
        height="30"
        fill="#d5e8d4"
@@ -1701,7 +1965,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 81px; height: 1px; padding-top: 766px; margin-left: 485px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 81px; height: 1px; padding-top: 1006px; margin-left: 485px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1712,7 +1976,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="526"
-           y="770"
+           y="1010"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1722,7 +1986,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="492"
-       y="700"
+       y="940"
        width="103"
        height="32"
        rx="4.8"
@@ -1743,7 +2007,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 716px; margin-left: 493px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 956px; margin-left: 493px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1754,7 +2018,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="544"
-           y="720"
+           y="960"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1764,7 +2028,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="492"
-       y="820"
+       y="1060"
        width="103"
        height="32"
        rx="4.8"
@@ -1785,7 +2049,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 836px; margin-left: 493px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 1076px; margin-left: 493px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1797,7 +2061,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="544"
-           y="840"
+           y="1080"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1807,7 +2071,7 @@ Processor</xhtml:div>
     </g>
     <rect
        x="492"
-       y="860"
+       y="1100"
        width="103"
        height="32"
        rx="4.8"
@@ -1828,7 +2092,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 876px; margin-left: 493px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 1116px; margin-left: 493px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); ">
@@ -1840,7 +2104,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="544"
-           y="880"
+           y="1120"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="12px"
@@ -1849,14 +2113,14 @@ Processor</xhtml:div>
       </switch>
     </g>
     <path
-       d="M 311 909 L 628.38 909"
+       d="M 311 1149 L 628.38 1149"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path384" />
     <path
-       d="M 633.63 909 L 626.63 912.5 L 628.38 909 L 626.63 905.5 Z"
+       d="M 633.63 1149 L 626.63 1152.5 L 628.38 1149 L 626.63 1145.5 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
@@ -1874,7 +2138,7 @@ Processor</xhtml:div>
            height="100%"
            requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
           <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 900px; margin-left: 357px;">
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 1140px; margin-left: 357px;">
             <xhtml:div
                style="box-sizing: border-box; font-size: 0px; text-align: center;"
                data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
@@ -1885,7 +2149,7 @@ Processor</xhtml:div>
         </foreignObject>
         <text
            x="357"
-           y="903"
+           y="1143"
            fill="rgb(0, 0, 0)"
            font-family="Helvetica"
            font-size="11px"
@@ -1894,14 +2158,14 @@ Processor</xhtml:div>
       </switch>
     </g>
     <path
-       d="M 482 632.91 L 315.37 632.91"
+       d="M 482 872.91 L 315.37 872.91"
        fill="none"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
        pointer-events="stroke"
        id="path394" />
     <path
-       d="M 310.12 632.91 L 317.12 629.41 L 315.37 632.91 L 317.12 636.41 Z"
+       d="M 310.12 872.91 L 317.12 869.41 L 315.37 872.91 L 317.12 876.41 Z"
        fill="rgb(0, 0, 0)"
        stroke="rgb(0, 0, 0)"
        stroke-miterlimit="10"
diff --git a/doc/board/ti/img/resume_diagram_k3.svg b/doc/board/ti/img/resume_diagram_k3.svg
new file mode 100644
index 000000000000..cc25e003ef5c
--- /dev/null
+++ b/doc/board/ti/img/resume_diagram_k3.svg
@@ -0,0 +1,1638 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!--SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause-->
+
+<!--Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/-->
+
+<svg
+   version="1.1"
+   width="556px"
+   height="926px"
+   viewBox="-0.5 -0.5 556 926"
+   id="svg1"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <defs
+     id="defs1" />
+  <g
+     id="g1">
+    <path
+       d="M 62 0 L 178 0 L 192 14 L 192 35 L 62 35 L 62 0 Z"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path1" />
+    <path
+       d="M 178 0 L 178 14 L 192 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path2" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g3">
+      <switch
+         id="switch4">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 128px; height: 1px; padding-top: 1px; margin-left: 63px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal; ">Security Enclave<xhtml:br />Boot Processor</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="127.0"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text5"><tspan
+             x="127.0"
+             dy="0">Security Enclave</tspan><tspan
+             x="127.0"
+             dy="14.4">Boot Processor</tspan></text>
+      </switch>
+    </g>
+    <path
+       d="M 241 0 L 361 0 L 375 14 L 375 35 L 241 35 L 241 0 Z"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path6" />
+    <path
+       d="M 361 0 L 361 14 L 375 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path7" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g8">
+      <switch
+         id="switch9">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 132px; height: 1px; padding-top: 1px; margin-left: 242px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal; ">Boot Loader<xhtml:br />Processor</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="308.0"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text10"><tspan
+             x="308.0"
+             dy="0">Boot Loader</tspan><tspan
+             x="308.0"
+             dy="14.4">Processor</tspan></text>
+      </switch>
+    </g>
+    <path
+       d="M 416.25 0 L 532.25 0 L 546.25 14 L 546.25 35 L 416.25 35 L 416.25 0 Z"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path16" />
+    <path
+       d="M 532.25 0 L 532.25 14 L 546.25 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path17" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g18">
+      <switch
+         id="switch19">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 128px; height: 1px; padding-top: 1px; margin-left: 417.25px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal; ">Main CPU</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="481.25"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text20"><tspan
+             x="481.25"
+             dy="0">Main CPU</tspan></text>
+      </switch>
+    </g>
+    <rect
+       x="77"
+       y="50"
+       width="100"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect21" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g22">
+      <switch
+         id="switch23">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 70.0px; margin-left: 78px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS/DMSC</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="127.0"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text24">TIFS/DMSC</text>
+      </switch>
+    </g>
+    <rect
+       x="235.5"
+       y="50"
+       width="137.5"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect25" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g26">
+      <switch
+         id="switch27">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 135.5px; height: 1px; padding-top: 70.0px; margin-left: 236.5px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-R</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="304.25"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text28">Cortex-R</text>
+      </switch>
+    </g>
+    <rect
+       x="423.25"
+       y="50"
+       width="116.5"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect33" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g34">
+      <switch
+         id="switch35">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 114.5px; height: 1px; padding-top: 70.0px; margin-left: 424.25px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="481.5"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text36">Cortex-A</text>
+      </switch>
+    </g>
+    <path
+       d="M 127 90 L 127 916"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path37" />
+    <path
+       d="M 304.25 90 L 304.25 916"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path38" />
+    <path
+       d="M 481.5 90 L 481.5 916"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path40" />
+    <rect
+       x="122"
+       y="130"
+       width="10"
+       height="110"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect41" />
+    <rect
+       x="298.75"
+       y="160"
+       width="10"
+       height="130"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect42" />
+<rect
+        x="122"
+        y="253"
+        width="10"
+        height="659"
+        fill="rgb(255, 255, 255)"
+        stroke="rgb(0, 0, 0)"
+        pointer-events="all"
+        id="rect43" />
+    <rect
+       x="298.75"
+       y="305"
+       width="10"
+       height="551"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect44" />
+    <rect
+       x="476.5"
+       y="786"
+       width="10"
+       height="36"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect46" />
+    <rect
+       x="476.5"
+       y="830"
+       width="10"
+       height="82"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect47" />
+    <rect
+       x="298.75"
+       y="876"
+       width="10"
+       height="36"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect48" />
+    <rect
+       x="79"
+       y="132"
+       width="50"
+       height="30"
+       fill="#ffe6cc"
+       stroke="#d79b00"
+       pointer-events="all"
+       id="rect49" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g50">
+      <switch
+         id="switch51">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 48px; height: 1px; padding-top: 147.0px; margin-left: 80px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ROM</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="104.0"
+           y="151"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text52">ROM</text>
+      </switch>
+    </g>
+    <rect
+       x="302"
+       y="161"
+       width="71.5"
+       height="30"
+       fill="#ffe6cc"
+       stroke="#d79b00"
+       pointer-events="all"
+       id="rect53" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g54">
+      <switch
+         id="switch55">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 69.5px; height: 1px; padding-top: 176.0px; margin-left: 303px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ROM</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="337.75"
+           y="180"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text56">ROM</text>
+      </switch>
+    </g>
+    <rect
+       x="302"
+       y="306"
+       width="105.5"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect57" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g58">
+      <switch
+         id="switch59">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 103.5px; height: 1px; padding-top: 321.0px; margin-left: 303px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-R SPL</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="354.75"
+           y="325"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text60">Cortex-R SPL</text>
+      </switch>
+    </g>
+    <rect
+       x="80"
+       y="255"
+       width="50"
+       height="30"
+       fill="#f8cecc"
+       stroke="#b85450"
+       pointer-events="all"
+       id="rect61" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g62">
+      <switch
+         id="switch63">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 48px; height: 1px; padding-top: 270.0px; margin-left: 81px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="105.0"
+           y="274"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text64">TIFS</text>
+      </switch>
+    </g>
+    <rect
+       x="446.5"
+       y="788"
+       width="70"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect65" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g66">
+      <switch
+         id="switch67">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 68px; height: 1px; padding-top: 803.0px; margin-left: 447.5px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TF-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="481.5"
+           y="807"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text68">TF-A</text>
+      </switch>
+    </g>
+    <rect
+       x="446.5"
+       y="832"
+       width="70"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect69" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g70">
+      <switch
+         id="switch71">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 68px; height: 1px; padding-top: 847.0px; margin-left: 447.5px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Kernel</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="481.5"
+           y="851"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text72">Kernel</text>
+      </switch>
+    </g>
+    <rect
+       x="302"
+       y="878"
+       width="105.5"
+       height="30"
+       fill="#e1d5e7"
+       stroke="#9673a6"
+       pointer-events="all"
+       id="rect73" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g74">
+      <switch
+         id="switch75">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 103.5px; height: 1px; padding-top: 893.0px; margin-left: 303px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Device Mgr</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="354.75"
+           y="897"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text76">Device Mgr</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="190"
+       width="90"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect77" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g78">
+      <switch
+         id="switch79">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 210.0px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load and auth<xhtml:br />tiboot3.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="214"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text80">Load and auth</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="230"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect81" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g82">
+      <switch
+         id="switch83">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 246.0px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Start TIFS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="250"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text84">Start TIFS</text>
+      </switch>
+    </g>
+    <rect
+       x="309"
+       y="262"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect85" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g86">
+      <switch
+         id="switch87">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 278.0px; margin-left: 310px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load system<xhtml:br />config data</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="354.0"
+           y="282"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text88">Load system</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="344"
+       width="150"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect89" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g90">
+      <switch
+         id="switch91">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 148px; height: 1px; padding-top: 364.0px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Set LPM core bus path<xhtml:br />and compatible</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="383.75"
+           y="368"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text92">Set LPM core bus path</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="528"
+       width="140"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect93" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g94">
+      <switch
+         id="switch95">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 138px; height: 1px; padding-top: 548.0px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Extract context address<xhtml:br />from devicetree</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="378.75"
+           y="552"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text96">Extract context address</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="820"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect97" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g98">
+      <switch
+         id="switch99">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 836.0px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Jump to DM<xhtml:br />firmware</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="840"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text100">Jump to DM</text>
+      </switch>
+    </g>
+            <rect
+       x="308.75"
+       y="396"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect200" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g201">
+      <switch
+         id="switch202">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 412px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Exit DDR from<xhtml:br />retention</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="416"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text203">Exit DDR from</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="428"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect210" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g211">
+      <switch
+         id="switch212">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 444px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">De-assert<xhtml:br />retention</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="448"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text213">De-assert</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="460"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect220" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g221">
+      <switch
+         id="switch222">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 476px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Restore DDR<xhtml:br />max frequency</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="480"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text223">Restore DDR</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="492"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect230" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g231">
+      <switch
+         id="switch232">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 508px; margin-left: 309.75px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Exit DDR from<xhtml:br />low power</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="353.75"
+           y="512"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text233">Exit DDR from</text>
+      </switch>
+    </g>
+<path
+       d="M 298 200 L 141 200"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path121" />
+    <path
+       d="M 134 200 L 141 196.5 L 139.25 200 L 141 203.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path122" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g123">
+      <switch
+         id="switch124">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 184px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Auth tiboot3.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="187"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text125">Auth tiboot3.bin</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 238 L 141 238"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path126" />
+    <path
+       d="M 134 238 L 141 234.5 L 139.25 238 L 141 241.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path127" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g128">
+      <switch
+         id="switch129">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 222px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Start TIFS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="225"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text130">Start TIFS</text>
+      </switch>
+    </g>
+    <path
+       d="M 299 281 L 141 281"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path131" />
+    <path
+       d="M 134 281 L 141 277.5 L 139.25 281 L 141 284.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path132" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g133">
+      <switch
+         id="switch134">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 265px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Load system config data</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="268"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text135">Load system config data</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 594 L 141 594"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path136" />
+    <path
+       d="M 134 594 L 141 590.5 L 139.25 594 L 141 597.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path137" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g138">
+      <switch
+         id="switch139">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 578px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Power on rproc cluster PD</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="581"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text140">Power on rproc cluster PD</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 638 L 141 638"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path141" />
+    <path
+       d="M 134 638 L 141 634.5 L 139.25 638 L 141 641.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path142" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g143">
+      <switch
+         id="switch144">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 154px; height: 1px; padding-top: 615.4px; margin-left: 139px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Auth ATF/OP-TEE/DM certs<xhtml:br />and apply firewalls</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="618"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text145">Auth ATF/OP-TEE/DM certs</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 668 L 141 668"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path146" />
+    <path
+       d="M 134 668 L 141 664.5 L 139.25 668 L 141 671.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path147" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g148">
+      <switch
+         id="switch149">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 652px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Send context address</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="655"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text150">Send context address</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 698 L 141 698"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path151" />
+    <path
+       d="M 134 698 L 141 694.5 L 139.25 698 L 141 701.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path152" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g153">
+      <switch
+         id="switch154">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 682px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Firewall context address area</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="685"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text155">Firewall context address area</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 728 L 141 728"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path156" />
+    <path
+       d="M 134 728 L 141 724.5 L 139.25 728 L 141 731.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path157" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g158">
+      <switch
+         id="switch159">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 712px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Decrypt and restore TF-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="715"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text160">Decrypt and restore TF-A</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 758 L 141 758"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path161" />
+    <path
+       d="M 134 758 L 141 754.5 L 139.25 758 L 141 761.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path162" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g163">
+      <switch
+         id="switch164">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 742px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Resume TF-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="745"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text165">Resume TF-A</text>
+      </switch>
+    </g>
+    <path
+       d="M 134 788 L 469.5 788"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path166" />
+    <path
+       d="M 476.5 788 L 469.5 784.5 L 471.25 788 L 469.5 791.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path167" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g168">
+      <switch
+         id="switch169">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 772px; margin-left: 250px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Release Reset</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="382"
+           y="775"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text170">Release Reset</text>
+      </switch>
+    </g>
+    <path
+       d="M 297 816 L 141 816"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path171" />
+    <path
+       d="M 134 816 L 141 812.5 L 139.25 816 L 141 819.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path172" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g173">
+      <switch
+         id="switch174">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 800px; margin-left: 216px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;  background-color: rgb(255, 255, 255);">Power on rproc PD</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="216"
+           y="803"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text175">Power on rproc PD</text>
+      </switch>
+    </g>
+    <path
+       d="M 303 856 L 333 856 L 333 876 L 309.12 876"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path176" />
+    <path
+       d="M 302.12 876 L 309.12 872.5 L 309.12 879.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path177" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g178">
+      <switch
+         id="switch179">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe flex-start; width: 1px; height: 1px; padding-top: 867px; margin-left: 337px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: left;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">branch</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="337"
+           y="870"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           id="text180">branch</text>
+      </switch>
+    </g>
+  </g>
+  <switch
+     id="switch900">
+    <g
+       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+       id="g901" />
+    <a
+       transform="translate(0,-5)"
+       xlink:href="https://www.drawio.com/doc/faq/svg-export-text-problems"
+       target="_blank"
+       id="a900">
+      <text
+         text-anchor="middle"
+         font-size="10px"
+         x="50%"
+         y="100%"
+         id="text900">Text is not SVG - cannot display</text>
+    </a>
+  </switch>
+</svg>
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff83547..2036570bb809 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -40,6 +40,20 @@ Below is the pictorial representation of boot flow:
 - Here DMSC acts as master and provides all the critical services. R5/A72
   requests DMSC to get these services done as shown in the above diagram.
 
+Resume Flow:
+------------
+Below is the pictorial representation of resume flow:
+
+.. image:: img/resume_diagram_k3.svg
+  :alt: Resume flow diagram
+
+**Disclaimer:**
+
+*There's a potential attack vector in this sequence, because OPTEE could
+be modified before being reloaded.*
+*Also, if the certificate replay is skipped, then TFA can be read from
+MSMC.*
+
 Sources:
 --------
 
diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index 21683b90b1a8..4390648a28e1 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -53,6 +53,20 @@ Below is the pictorial representation of boot flow:
   the C7x (Aux core) software components request TIFS/DM to handle
   security or device management services.
 
+Resume Flow:
+------------
+Below is the pictorial representation of resume flow:
+
+.. image:: img/resume_diagram_k3.svg
+  :alt: Resume flow diagram
+
+**Disclaimer:**
+
+*There's a potential attack vector in this sequence, because OPTEE could
+be modified before being reloaded.*
+*Also, if the certificate replay is skipped, then TFA can be read from
+MSMC.*
+
 Sources:
 --------
 
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 4b5cf0275940..531c9b3e7cf0 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -38,6 +38,20 @@ family. Below is the pictorial representation:
 - Here TIFS acts as master and provides all the critical services. R5/A53
   requests TIFS to get these services done as shown in the above diagram.
 
+Resume Flow:
+------------
+Below is the pictorial representation of resume flow:
+
+.. image:: img/resume_diagram_k3.svg
+  :alt: Resume flow diagram
+
+**Disclaimer:**
+
+*There's a potential attack vector in this sequence, because OPTEE could
+be modified before being reloaded.*
+*Also, if the certificate replay is skipped, then TFA can be read from
+MSMC.*
+
 Sources:
 --------
 
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab908..131d0d10374a 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -58,6 +58,20 @@ Below is the pictorial representation of boot flow:
   the C7x (Aux core) software components request TIFS/DM to handle
   security or device management services.
 
+Resume Flow:
+------------
+Below is the pictorial representation of resume flow:
+
+.. image:: img/resume_diagram_k3.svg
+  :alt: Resume flow diagram
+
+**Disclaimer:**
+
+*There's a potential attack vector in this sequence, because OPTEE could
+be modified before being reloaded.*
+*Also, if the certificate replay is skipped, then TFA can be read from
+MSMC.*
+
 Sources
 -------
 
-- 
2.55.0

