Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B4FCA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 285E960845;
	Wed, 30 Sep 2026 13:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_TdN_VQyIpj; Wed, 30 Sep 2026 13:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 501B2608A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775806;
	b=QatIh5dreJWWk+tpNPjDVXSyBSORIj/ABN0uC3WWBZe7w1EJh4TPSxL4rAgyNY6IRKgB
	 aY3fwQRpMcsbTMZ25n1fDSr9D+nda5sNQMAmJNrCLOqdz/XjUCVqlhEw/YLg5v39SI24R
	 qGFR+6cChcppURWB1Ofrczf6jC3XuLdxLcqRr9UYhVeO6rzYaz6Fi2zCqT+l+D9BJzmbF
	 /6j/Mk9pSOAl3fYuldFsuqcqo34rk8phw7lJf3u+hOuxqudLpKLwz4+2xaMCyh9tuvhQK
	 0aaJuAcrElxenVwOUTzHSwwkPAEPcmR6lAlatpDiX2Miyrb89FKQHig+adeaJn+V5LQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
	b=W2D8kZZlk3P+1kpZkepH2euyx/61qRbdROPgy19mqwXdq+UqbENU1D9CYpV8S9bUhLzt
	 GQjA84yYIZlfudFysaooaErf5j+etuNudHyt1sSjO7hRPhYnlL+lzJJ/aBtiplGEPutmM
	 cXRsEmb4wSvzM5/gx9tKzkxFPcFltqcsmd3zwNC1JVb4yGagSq9SOoW2dlAJ0y6Bh0Gnn
	 EFbYlC13A9ntCuomn8ao/P9UuZ8Q8XwhRikDra/dnSnp8Bfx6fNU1sB6fQgvL9Zcyx9S/
	 CsBlLmDV7inRYT+WGrwHDjwuaz1krNl9RiQqKv8nRg7lRL8/JU6+iDsb6mumgLQd4KQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775806;
	bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ffc+QOIT41nqpntqe+rwQlgziGKwThxUzbYRad3M6r8rrAaEsETeHJcmO6/VYxKty
	 nD+n8XzhrCRD5h2zfxnfDwKgEdzCwcI1EL0nwnwwAXW0DrJC6T9bz4JO2WAybGy9R1
	 5qSJ55a3ZcJ/6lwft7f4HZf4lqEZF+YLsTmkKV0SraxUd1wLBaAu8aWkKmVU1hK0MD
	 L5jnJAsrmfRjIwYSSLinrLwfkEMXkxLjh6E4GXB45/3iBdqZlMEDyFDSrwieqT4KG1
	 RiYxtC+5vRFdcnZvvoyrEgXxPo5PA8j1BQdYTfmGjSF9LLvEJ0GAMvdNzzb3e3fQ/V
	 ttLRgscyy8cAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 501B2608A8;
	Wed, 30 Sep 2026 13:43:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 466634C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38ED44009F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wbcEfOJwcSpx for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8B9B6400AE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775802;
 b=aN6tZPEi66+8cbO0wZShcCCzBirXuuheDcmwdWrqNLpPO+xPq+coebT2/crYsNrBrYdB
 M1rFUkSbiXxqkDfaEUipuy7RjypXhTqulE4Kk6a6o/jN0/dJq0s4ZxxFnzBrsOeOz4B8i
 2NZ9MjhxX9eVFg8uEvvrkxE5Xe6vUvcmn+Ob9K3AARp/DapJxlyj3T+1HMcCF/nJCFzGB
 MhmwtER/qAKzHIjkuDp3kkIoXEmb4i4sTq1aKXDFQrbOiDhzF7YrVt8yte3EoYtLcifE2
 4ZxMYeYP+SYpE8VczGaorttHieUnWqV7ALhFw50TaPDgdvmV0CfSMBdBwBCQfLB/PQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775802;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
 b=HPKiAVDBIO99zDIHKsGqXvdWZW/J6txR/Axb6+/JDNdsYOeePsvC+iVYlFEsKF13mdNf
 Ah8PyK/c71RZXV8MR42iYBaT1o/ClV7hX6HZTWe4VVGsnndmZ507N9wOj9wnOTbc4LmP1
 RHkKSO1FkioLKamCzjXL1pyhuLYoj7kjXknVJxyhO9urIFTjDmHu6Y2PUW3eneN8Va1Vt
 DiF7upQ9K7qZ9jY4ZDq+/VMe1TKqHDBJQv3HN1Lzjods/bkdOPvhAmrHd4W3KNqEeHJGB
 9eF5U8jRD2hsuHcdqu8t+tEBKjeqyYmrnuD30RMmxfJiNNxukxe/PnLcxRaBod/EYZw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gJrSYQ1L; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gJrSYQ1L
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B9B6400AE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3D2544E410D4;
 Wed, 30 Sep 2026 13:43:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 081FE60749;
 Wed, 30 Sep 2026 13:43:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B369610328E6D; 
 Wed, 30 Sep 2026 15:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hDOzg7TayypKLmacIemnVASbQssZF064XWWJSmelFgg=;
 b=gJrSYQ1LsT58UYlqZzEYHZ2Z5YGcxrUqJxI1am8SGUKlPN7hTfqswyB7nvKBR1zh4RnRZ6
 eHWEgL+E29wkjKfwEw1wM41Yw24WUi2HepZMz79zs3GfhOdCMY5kPDdZubtKrvJe8nhiBw
 8mE6BRRwpUyPkoxHt3g3AKxPTukPJfXInU+6eSBcde4ptJH0mkTN8a9g6PsSsjKTgrK+1T
 aV7ZLJs5+lh5w9WD0EQhqaTd08/j9bTYu+ceRNcCPVs5SqVWhY/pDwuCeF+QZn9yGmoDP+
 g4HfWrwVm+dH0mCJNd6glPw4IJFSl7iNgDc5eaa0HFA7KRbfRXLKifnXo90heg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:36 +0200
Subject: [PATCH v4 3/9] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-3-f968a1b14dc5@bootlin.com>
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=ToHY/lcSpuqeajOv8URgUYHIAZA2lpBFwEO3LAeoo6o=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZ46k6XiVzb7cvqqG9sgbluUkLdfypxpqwU
 rmX7D6IuW2JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 A6C7D/0ZyAajg4XEBxz8Zx3foMUHqi5cS/0PIDxYG1Fvaxen2Gh4EnPBlFjIq2KeT/57V2VNcwy
 mEMTj29r+g0duVw7j7TAPxQg7El6ZWOA5sFXCrvFJr+9M/VBZuZ+SLpDCoPSrHt/U3gRE+G4r3T
 RpGP4uSL5Hj9xerS/4FR3qzi9tRR9SIDJKh7sIn50bZrkKQTv3pOb+9pvk3wwlCTuH3HkQqKJYg
 uqFzwYEljRu6uE+NFwL63sDGe2hk6piD4JAT8nNgsfMkGotfqmWOHGbbCojSVDXsKWWubfvrTmA
 fdAJcJUZwzuJpKRKrg1EH89zz1u1rsnMTeQAPv2ADIQ/1DzPjF9r3wjrC8Gm1l3/AuD+pwhPxik
 abqSV9d4gM5re6h9S4XnV6Ey9B/gB5cnxGizB/RDeFyFUmqLWsl3f1N7HZchSNWHasiPAH14V9/
 lRK8uNH63tF2160Bfsj3pYBqn34yU1zs2jdUZM39JR//a5XZ5q0pyCXYKP1tzsIsYu9AdxHKToh
 3uJsynTnZl/9F4Uy3r52WzEFP+Qev6CQVbKttN+KCsO+M+4EJoFE+lGqCyEyEOYxQ8f8hyHY0AY
 54yt4qsr/LF8e6fLpfHjC3wLJbmJ7HsJ8BusIpZaSr1JtQ8rDPE7mdRGNP8bHADcODcqTawJW0x
 xLPkRSCXp5FWAcA==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
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

Add a binman etype which allows signing the SPL and U-Boot proper
sections of the i.MX93 flash.bin using CST and AHAB. The implementation
reuses the shared functionality from the nxp_imxcst base etype.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 .gitignore                         |   2 +
 tools/binman/etype/nxp_imx93cst.py | 112 +++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/.gitignore b/.gitignore
index 0e09715cc60..5cb135fc58c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,8 @@ fit-dtb.blob*
 /keep-syms-lto.*
 /*imx8mimage*
 /*imx8mcst*
+/*imx9image*
+/*imx93cst*
 /*rcar4-sa0*
 /drivers/video/u_boot_logo.bmp.S
 /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
diff --git a/tools/binman/etype/nxp_imx93cst.py b/tools/binman/etype/nxp_imx93cst.py
new file mode 100644
index 00000000000..41326728c5d
--- /dev/null
+++ b/tools/binman/etype/nxp_imx93cst.py
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 (C) Bootlin
+# Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+#
+# Derived from nxp_imx8mcst.py
+# Copyright 2023-2024 Marek Vasut <marex@denx.de>
+
+# Entry-type module for generating the i.MX93 code signing tool
+# input configuration file and invocation of cst on generated
+# input configuration file and input data to be signed.
+#
+
+import os
+import struct
+
+from binman.etype.nxp_imxcst import Entry_nxp_imxcst
+from dtoc import fdt_util
+
+CONTAINER_HDR_TAG = 0x87
+SPL_CONTAINER_OFFSET = 1024  # 0x400
+CONTAINER_HDR_SIZE = 16
+AHAB_IMAGE_ENTRY_FLAGS_OFFSET = 24
+ELE_IMAGE_CORE_AND_TYPE = 0x66
+
+KEY_NAME = 'sha384_secp384r1_v3_usr_crt'
+
+CSF_CONFIG_TEMPLATE = f'''
+[Header]
+  Target = AHAB
+  Version = 1.0
+
+[Install SRK]
+  File = "SRK_1_2_3_4_table.bin"
+  Source = "SRK1_{KEY_NAME}.pem"
+  Source index = 0
+  Source set = OEM
+  Revocations = 0x0
+
+[Authenticate Data]
+  File = "data.bin"
+  Offsets = 0x0 0x0
+
+'''
+
+
+class Entry_nxp_imx93cst(Entry_nxp_imxcst):
+    """NXP i.MX93 CST .cfg file generator and cst invoker
+
+    Properties / Entry arguments:
+        - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+        - nxp,srk-crt - full path to the SRK Key SRK1_sha384_secp384r1_v3_usr_crt.pem
+
+    The nxp,srk-table and nxp,srk-crt properties can be overridden with
+    the SRK_TABLE and SRK_KEY environment variables, respectively.
+    """
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.srk_crt = os.getenv(
+            'SRK_KEY',
+            fdt_util.GetString(self._node, 'nxp,srk-crt', f'SRK1_{KEY_NAME}.pem'),
+        )
+        self.ReadEntries()
+
+    def BuildSectionData(self, required):
+        data, _, uniq = self.collect_contents_to_file(self._entries.values(), 'input')
+
+        flags_offset = CONTAINER_HDR_SIZE + AHAB_IMAGE_ENTRY_FLAGS_OFFSET
+
+        # Give up early if the input is too short to contain the container
+        # header fields read below
+        if len(data) < flags_offset + 4:
+            return data
+
+        if data[3] != CONTAINER_HDR_TAG:
+            # Unknown section type, pass input data through.
+            return data
+
+        hdr_addr = 0
+
+        # The SPL AHAB image can optionally contain and start with the ELE FW,
+        # which is already signed by NXP.
+        # In this case, the SPL container header address is not 0x0.
+
+        image_flags = struct.unpack('<I', data[flags_offset : flags_offset + 4])[0]
+        # Detect the ELE FW from the core/type fields of its image entries
+        if (image_flags & 0xFF) == ELE_IMAGE_CORE_AND_TYPE:
+            hdr_addr = SPL_CONTAINER_OFFSET
+
+        # Extract the signing offset from the i.MX container
+        signoffset = struct.unpack('<H', data[hdr_addr + 12 : hdr_addr + 14])[0]
+
+        # The signing offset is relative to the container header address,
+        # so compute the absolute signing offset address
+        signoffset = signoffset + hdr_addr
+
+        # Write out customized data to be signed
+        output_dname = self.write_input_data(data, uniq)
+
+        # Generate CST configuration file used to sign payload
+        config = self.get_config(CSF_CONFIG_TEMPLATE)
+        config['Install SRK']['File'] = f'"{self.srk_table}"'
+        config['Install SRK']['Source'] = f'"{self.srk_crt}"'
+        config['Authenticate Data']['File'] = f'"{output_dname}"'
+        config['Authenticate Data']['Offsets'] = f'{hdr_addr:#x} {signoffset:#x}'
+
+        cfg_fname = self.write_config(config, uniq)
+
+        outdata = self.run_cst(cfg_fname, uniq)
+        if outdata is not None:
+            return outdata
+        return data

-- 
2.55.0

