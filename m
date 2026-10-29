Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zEmv2tJT;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AOGKRGZX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1970E80FA7;
	Thu, 29 Oct 2026 17:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0W6z9jSnLRkX; Thu, 29 Oct 2026 17:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3381D8104C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295362;
	b=ny+iMljUhdsVQn9I2aE5/bQzanJqhuRT/IR9jSqf4AJUVSHnr2VXlcgYMIKnllkfBrLX
	 yOPUwY31pDpfEcOzKvFRt7/bJYT2BX/9i3VTIFNtVX/F3loVH5JmQ/VuTn9hUA6uYEyi1
	 U3RX+iEzHmtcQdHY3N9/njW9r6TotdMjYVzLxdE7ZXGONWW9bZ1MyCqXVHLr7BzEuTSsg
	 u06DaITSonWOeRL5jX1+bxtLjSXHIw1DzbjQuBssX6W7dADwY9AajDidFO/OvhqDnpTON
	 Cw5ydIfove5QVcB6wCrQY1K1G4dTgegw/2uSAaw74DX2gICLFzxu4gfH51IL9OFaoiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZwGk2aYiA/yovwpWe6+IEwRWIZ4A1qzeV0YqKSUgnP8=;
	b=Vi728POjfs3IXqw1Dc6U6eUICpyx+KUmE08p1dOnhyiEBVr2YqJ0kveXhkrhUIebdkSC
	 x/Jj4GYQ+3WiJEGy4iNHdpktsUvZWO1BWC8Ex7S9girPB0+tMKJcEQa1k+PXFt7bc2pZz
	 4HPzSg9SetdiylHn3/HN9jw3Apf06v4PBnfKRj3fc3pCLFkBK0FpAKtsYlmijxgYUCYx7
	 BTS7/wIoL23wwJWi+ojl/8M9d1AmvRJby27kik5XltHCIDR8xpUkVostMFZmcxan3XUJm
	 it9BOp2t7nGgrFS80bTf4+QPxtmzirR87VGen5cr/6SQxgqopgeqV9q5xzQBJ/BRXXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295362;
	bh=ZwGk2aYiA/yovwpWe6+IEwRWIZ4A1qzeV0YqKSUgnP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zEmv2tJTawOrCW2wBXIst0A8RXJ21dRnpForUlV8kVNn4RBHssZOMbxc8v6YXf3S/
	 7GKdBHlUaJ6xionlO6BasqeyLoFnk8CBrwz+fN2+5wCM06yO5nxezCdszPfp3nRF9q
	 IbAAP6QLen/qy3cS/pCLrygn/b9/PoLbNMpFVgIf+Oga4QwTUR5XlkDy6ECp/g4Wyn
	 Vr4OuP69CyRFX/jDb5KxQyDToy3+XNOL7Zg9fj1Rsay1gsA4/41jEIi7XTZq06eIHM
	 4bKVOC3z+kFm0meAeFezbZ/Ch+9vZMjG6SonM3KQsz+rqUzGNTmwZ/QwgJHcGq8Nit
	 cGTvxJYMZHKwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3381D8104C;
	Thu, 29 Oct 2026 17:36:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F9C13A7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 521A160A6F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wOidM3fPvMBD for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D47DC60710
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295357;
 b=LNhmnLYF61KC9o3hJyHc3eY5dfHD/z/4sRPn/vUlBeRjEH+NqJcz6eRK5R5HQPYFqL/Q
 fMwDf7+suOuQWSpgjQHAQVIppkA5zo8Rk8DUQtCpKWnNSOriDB9JDKEZi1NQQgmCZFMZS
 pDHOA18G/ooRcGYMM4QHzOdeiFrHiZQr9EAOxjBFdt6oARIyYqkBxLi7GKWorkryrOatN
 OnQwcbCPdDaJ3V5WshjSPUI8AU3rcjiDXn1TEMeGsiTnjCUWuTSeAiJgMwASdYkZBGSYu
 FIh2cVCjZJCdkoz6HkN7ea4tSfUZlMIFNMF7GqhmnF8Rk0UyYKOB/BR1JPwZjfTC/3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295357;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=ZwGk2aYiA/yovwpWe6+IEwRWIZ4A1qzeV0YqKSUgnP8=;
 b=rcdsKQq1NYbwac4jC7bVZ3sG8TJDE8C20nNoEQ3dknBXil3k4yqBq+/3ez18gfIQuMPP
 Yzj1ZvgSmrrEISl1FV6S13zRGYbYAvpY53w74fbH+kqAJqP2C8UrgTODPDuGAOcUrPTuM
 BJdvVUmF5ka1LcqFyCyMwsxtSqNDgiERKlHKSUtTl+GIQsU8w8f53BwyBGIz/+hyvr7Ze
 654lRGghzrp9TFtQb+MYgoFQfITYt57HMYr/ETPKKj9DcYOg7TO5dFkZzQXaF39buSSTE
 SNqGtM+mzI7KegfskiZsCL1j3ebyQyg6LlZw25nLsUK1F6YWZP7YzqcPKsh8DSa9N5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AOGKRGZX; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AOGKRGZX
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D47DC60710
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0FC364E4139E;
 Thu, 29 Oct 2026 17:35:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CF7E76076A;
 Thu, 29 Oct 2026 17:35:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B92110328F94; Thu, 29 Oct 2026 18:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZwGk2aYiA/yovwpWe6+IEwRWIZ4A1qzeV0YqKSUgnP8=;
 b=AOGKRGZX1zWW//uzrBkdzIFAMot3GrIv3kdKDl9PONGHmTF82v9ypWp9kQm0SV7VnNc99K
 KrmQtceF6BwjzxW+lV1nqkAVE5c6EqbZCqOpSBP+zcYWEC6Vf2dMRS2nXfh5MZ49LX3Ixa
 89vyWLpYcuBt9VWeOA0b1HpAqKKrFsnJrI6Bf1Q+7OotRkifJyEQLt1HqIv91hw1mh6Hil
 bVq9AgWwvYjk6FBKR9L2cMk5OSHTPHf26jOjv9/ATHzGUNfVltal/qzOo/XAzduC8u/hnW
 Z+cCefH4kLYPVxMeEL/NrWjVIaWVeohsE6x6Vh0d3kRbBmwEmP/4zz1OuP+zzg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:24 +0100
Subject: [PATCH v6 1/9] binman: add nxp_imxcst base etype for i.MX CST signing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-1-27b9c987e25f@bootlin.com>
References: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
In-Reply-To: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5024;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=XwFllsQrZOT0Dt8CRvbGYDUApheLC5hhSSQC+zuTYwE=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44PsDJtI37gijCZX1Siwinzd3XwC3er8/m+0C
 deqKRTmsteJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7AAKCRArAF6gG1qP
 A4c2EAC5KLS51B6vt/yGO/74BRyMCQ1O4LFDO6FLRSIPPcOKo59rPl9oyA/r7xEcu+hFx9pWUKW
 UzrQKUPyKzij4ql3UBZ//pp0vYNMwVtQAXJ/snuBj6oQO/vRgpz+3/X4VnKc5Djjq55WA5tAX/W
 Wtb/Q8j/ZC3fKOwmEoBIRwoZ4Qg9XaNXKDUuFsRZbx4MLo/PSplRSkF7Ysbp79T3bgjf4C3785C
 fzlBj37uOPiCgqFsnG5AczAMHKgki9VRx9rAisGVWGb3luCArfaoUFu74FoRlrEcim8T3zHkJGg
 vbp8EU0oM5W8Z4Wc+mSgKxrEb8iSfDkuiazIt3ozrMPCq3lly7qSuitkfvzupTKhBtrJXwe16O5
 vHAMTtG1v+iiFIGNltJ0UynyJr4XHVAl0CN2Zueve7G+b3U7McdSTkdEWQQIOhqAOfHN8q8gMqy
 tl60FrZNOeEQM4ssSV0v1ODO1eWTa+2eo3oeK9z1L/BueJzEp7pANfcwjBFQH47uRtDg+dMSaNi
 KXC/BC6w+nYb90/1ny/1joGdSwMqupHHqJi8rk+hAxdYoqoY3m9jNO6PmLg8QnrKWQWNC9XpOXk
 cXQSjVF27BMPSFiH1JyO+vm6H6YiUFAHXrc5XmP1a/Hjqpm8OxEOKwahfNKEY0EjLwfbRglmOZ6
 8tWQVnt/464xP4Q==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a common etype which provides the shared functionality for signing
i.MX images with the NXP Code Signing Tool (CST). This includes the SRK
table property handling, the CST bintool registration, and helpers for
writing the input data and configuration files and for running cst.

The nxp_imx8mcst etype and the upcoming nxp_imx93cst etype will be
converted to use this common base in the following commits.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/etype/nxp_imxcst.py | 120 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tools/binman/etype/nxp_imxcst.py b/tools/binman/etype/nxp_imxcst.py
new file mode 100644
index 00000000000..718537fda40
--- /dev/null
+++ b/tools/binman/etype/nxp_imxcst.py
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 (C) Bootlin
+# Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+#
+# Derived from nxp_imx8mcst.py
+# Copyright 2023-2024 Marek Vasut <marex@denx.de>
+
+# Entry-type module for NXP i.MX Code Signing Tool (CST) base class
+#
+
+import configparser
+import os
+
+from binman.etype.mkimage import Entry_mkimage
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+
+class Entry_nxp_imxcst(Entry_mkimage):
+    """NXP i.MX CST .cfg file generator and cst invoker base class
+
+    Properties / Entry arguments:
+        - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.cst = None
+        self.srk_table = None
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.srk_table = os.getenv(
+            'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
+                                            'SRK_1_2_3_4_table.bin'))
+
+    def SetImagePos(self, image_pos):
+        # Customized SoC specific SetImagePos which skips the mkimage etype
+        # implementation and removes the 0x48 offset introduced there. That
+        # offset is only used for uImage/fitImage, which is not the case in
+        # here.
+        upto = 0x00
+        for entry in super().GetEntries().values():
+            entry.SetOffsetSize(upto, None)
+
+            # Give up if any entries lack a size
+            if entry.size is None:
+                return
+            upto += entry.size
+
+        Entry_section.SetImagePos(self, image_pos)
+
+    def AddBintools(self, btools):
+        super().AddBintools(btools)
+        self.cst = self.AddBintool(btools, 'cst')
+
+    def write_input_data(self, data, uniq):
+        """Write input data to a temporary file for CST
+
+        Args:
+            data: Data to write
+            uniq: Unique string for naming output files
+
+        Returns:
+            str: Path to the written file
+        """
+        output_dname = tools.get_output_filename(f'nxp.cst-input-data.{uniq}')
+        tools.write_file(output_dname, data)
+        return output_dname
+
+    def get_config(self, template):
+        """Get a ConfigParser loaded with the given template
+
+        Args:
+            template: Configuration template string
+
+        Returns:
+            ConfigParser instance
+        """
+        config = configparser.ConfigParser()
+        # Do not make key names lowercase
+        config.optionxform = str
+        config.read_string(template)
+        return config
+
+    def write_config(self, config, uniq):
+        """Write ConfigParser object to a temporary file for CST
+
+        Args:
+            config: ConfigParser instance
+            uniq: Unique string for naming output files
+
+        Returns:
+            str: Path to the written configuration file
+        """
+        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
+        with open(cfg_fname, 'w') as cfgf:
+            config.write(cfgf)
+        return cfg_fname
+
+    def run_cst(self, cfg_fname, uniq, backend=None):
+        """Run CST tool with given configuration file
+
+        Args:
+            cfg_fname: Filename of the CST configuration file
+            uniq: Unique string for naming output files
+            backend: Optional backend (e.g. 'ssl' or 'pkcs11')
+
+        Returns:
+            bytes: Output data from CST, or None if bintool is missing
+        """
+        output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
+        args = ['-i', cfg_fname, '-o', output_fname]
+        if backend:
+            args.extend(['-b', backend])
+        if self.cst.run_cmd(*args) is not None:
+            return tools.read_file(output_fname)
+        self.record_missing_bintool(self.cst)
+        return None

-- 
2.56.0

