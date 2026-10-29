Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B7606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SrVS4kW4;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E/nkIVPr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B71518107C;
	Thu, 29 Oct 2026 17:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id az3zbFa1CqIT; Thu, 29 Oct 2026 17:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC23C8101C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295411;
	b=jipr5SowSB5Tr9DOgag+WTHhWumiWV7FnNEYx/BTJNY/KZpoLdQ3sGXC4OlWNpsnBDk6
	 P80aMjm35Uttc96YlKOvc+CTbCqtakX0hxiDAOTtBxpzc5zI7srmCcDwDbayoqc0eJ9z1
	 i7r+TC9Hbn6nUeBnIaOlXVQM+M3CuAvl3gnH5WpTfgkuJlljHpPVQl6SHB0Htd2mwtTo2
	 ETJBUpwoDZ/tj8V4ym0XqkdKiyTL/MH9wiilV6AoLBnjJXzpR0Lj511A7JXWq+ifOQHnY
	 vqHoohavvBT+xNZcuyJevvVU9/wcqluLrVeVfs+cpz7Rc+tvE1UVGaDm8KUq0uKKdXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HrbQsFCCypgk9ccf7L8i+6faRFvHeIEgMS7wuGqgQdo=;
	b=nvjX2qFNLzD4luuxzjYrEkB1Mhcdeuj9pT3b1KD5ZgnDae+mSWuvwecS8R6jcE9NDemx
	 Uk/2Ml1tyDNQTkN/GPhnIbqxcTvEDwBLvfuXncyrymCaGEZAKFJIYMoFvyVoMAIHd0LFR
	 qN1T9LoYjVyUJyG5vIVhj5QxZ9Up/8tGZtX33qa2Bug6NDLjgm26C+7p439mYHFzV1wWX
	 mBvfjT12kFpMP4xDgX7lGiHBj27+3DLbPWzxOF202oWe+T+TOKtgxWrCwcrv2k/cbV61x
	 4o7O0Mbh24+bApXAvKBV21ltJPDiZIg1VDNRx47bOSeIMXO2fzdFOBUo9MdZgvNUbBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295410;
	bh=HrbQsFCCypgk9ccf7L8i+6faRFvHeIEgMS7wuGqgQdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SrVS4kW4wf3qyu3AAKGU/Lp8R7yBYSkSWDhcrX34N33aaBRWI4bXlYpoNWOy2p5fi
	 mzRctvklI5NS2Igk9Oj0Ml+FhKQeWnaWRGSb30V5u1lwsUA0kRFdToMk4OtCtWzACq
	 r04lhezgKbHolOuzv1jKjj58RnESBTAxOSkBgMPGa2XF7Zkk7o/ilwQHzDpNWcRMFo
	 t4bjWG+JU+HeIMkdVQRKM1dr1sEOvKKlYnV2PDVuLjR1BHChq6/R3CXZr9ZVxm4K3h
	 7nHyyP9+SYi3PEGA4II7oSBB/yc3ulnSPvXNX8kihFmuhzditlJ+UIUQfREdSETpbC
	 mhWezFOtuaTiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC23C8101C;
	Thu, 29 Oct 2026 17:36:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F5A6120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51176400C7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_HoAbpfxUie for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2888D40048
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295408;
 b=PHrp8p/HMh6xEs8BAwKuQj/hjPn1yWNfaOI3GseoPiFlAQNmBKwo7tBSRvv9yFAzRFnh
 JZ0A3BNJINPViXaB3i31zvRUEsmTz5TQir51kh7nH/fI0k+b1+nMTr8jH7ygZFAf7VwnI
 yVpmwq7p09Rzm4mS4EUpD16S/VXHVKs3tVGgyfxAug5OXuB08l6SpS25y8JZQLS90IeYq
 rPRs9th+Ras1fjMPIouMMhO9rb+mhj1ebs80Fd/3U+yfCIAJK4gzu5XHrJxvI6/O1o6qq
 LzHzcUXlAcK7begyLNXfQAL3pPN9irsz9BDFGWWOdQ4mTbNevv/Cq7fJE8SinFsrpEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295408;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=HrbQsFCCypgk9ccf7L8i+6faRFvHeIEgMS7wuGqgQdo=;
 b=FIl1fL8lMhdP9oSCFFmRPHjP0aW0f2nIfGc0HlC96jVTWQbZL8vk25gDJ7HKbNuFBRuq
 XPOImFiW6KjDvoefjkyu784j7WVmjaWFupx8lqqnHFpjT6GM1iJUVG0XOcCYVx0vh8Kxm
 gWv9fNegg9UsD/dokSsJQ6DtBBPGDsdUxvLo2UKJWRc8j/qA64OwR8pOyiM3AJb5PzvMR
 p0ZrmYX9NlDwuNybBdJUnndEJwz5n+F2SftFQEql1HzEa7hcb4IJKuZXLddapAgEne9Uu
 HfgVwiejF9+pNLIdh2NM/ZnePwi8N8toUOj8ApaexaImpWIgxKanWvUsXDbOCIk2l8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="E/nkIVPr"; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=E/nkIVPr
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2888D40048
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BCC144E413A0;
 Thu, 29 Oct 2026 17:36:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 824F06076A;
 Thu, 29 Oct 2026 17:36:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9724110329115; Thu, 29 Oct 2026 18:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HrbQsFCCypgk9ccf7L8i+6faRFvHeIEgMS7wuGqgQdo=;
 b=E/nkIVPr/BEY7IcyN6RQvKN1qgyjQM806QJvICr3pj8luFUxZCJSlUKeK3U8+HwPja/9Jz
 pObDMOE6GC7NwfgdENWBj2w78e0v8GYqYFMy0NrxtKtbC2vtPxNlekPbjfCpWbpQsMGi3y
 fXoaIyd7sO+VdBsOFB3l6LTGGtzHW1dDzjRxievqGJMPEEad6yDLpMRM80AGN5CITtB6zb
 FttMPt4tGOvTaaeWwsTz6hH+bJKGsRuZ+qIab/7WFYOd6yKcXQfh69M0TVA1NJ/UMoNXPV
 yuMncQVsKoIgiza9VTj3/Ld7P2zsHnawvxu1GiiIsEaIP8aYPi5i4vF5hdLY1w==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:32 +0100
Subject: [PATCH v6 9/9] binman: test: add code coverage for nxp_imx93cst etype
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-9-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=RRdzzrVOLpcHkX0gK3EQqUa5pUzhPCPVKPwtrcILikk=;
 b=kA0DAAoBKwBeoBtajwMByyZiAGrjg+2jJDF3g5q2Pen6ANjWrgyRjRZhoKmwsaXudfcEykW6n
 okCMwQAAQoAHRYhBPsUrZCG27hCkEgECSsAXqAbWo8DBQJq44PtAAoJECsAXqAbWo8DP1gP/3yE
 B4EVH3jalTym91w8e0hvSoSU6U4enEkIPHpEE0fT2vHE9qkgq0SU6UxhMvbupUgh+2dlAXc6Rd1
 j6ADWzZEYlbJXBRiR5iVaGHrM4edP0/7rf2xxwyuIb37iewTqcoz5LruYb+/Z/udn6foxPVnOyh
 BDrQDBZtL0BIVUUMCSImHqb2ZQymMcH3pfoMadKC4At+HnCFs7MNLe/6sOUbvzDjf4qaNRqXlcw
 Gh1YQVayqFt6XoSOev1D/OuI0vVExSTgh3/8asuu/bKI4kXl8NaM6L1quP8OkLsSh9VNPuqGtOO
 gJAR04/Y+D6CxCTk4DD72uwOJ8suHBgZv2Y24w4omigkvOmE3RuiNCMy2dY+UgctOekGJXiSWOT
 70ESMDBONE00YupyF3pbTlB6zQq3EDrBIvUPISjDx5dY5YEi65f94t5+r9LfH81U9T6tlkeQ1SN
 p+8QELmtOb4fwDA5Y8ZV+joefzThWQxFHcWXtuNCkMatjoXblTYh01C5swWqJl3eTIFwJn+v56m
 g/9gGiPVzl5GHNrMxiPOhakXKj6BAFnuYMWMB/5zGTxsHg6f4uHpHQ9UYSD2p8qk17PLLz5Jb81
 MvvuKZPIYv3LpnxlVrfK6frwdl/x8VniONRkE/n0AUNbObtDWhbl6hIFbxjTi9jeiVAzhnC5iSi
 7C6Yj
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

Add test methods to cover all code paths of the nxp_imx93cst etype,
reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
Glass.

This brings nxp_imx93cst to 100% coverage.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/ftest.py                      | 97 ++++++++++++++++++++++++++++++
 tools/binman/test/vendor/nxp_imx93_csf.dts | 18 ++++++
 2 files changed, 115 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 783836045cb..822ad5c6f07 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -35,6 +35,7 @@ from dtoc import fdt
 from dtoc import fdt_util
 from binman.etype import fdtmap
 from binman.etype import image_header
+from binman.etype import nxp_imx93cst
 from binman.image import Image
 from u_boot_pylib import command
 from u_boot_pylib import terminal
@@ -8158,6 +8159,102 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             result = cst.fetch(bintool.FETCH_BUILD)
             self.assertEqual(('cst', None), result)
 
+    def _MakeImx93SplContainer(self, offset=0):
+        """Create a fake AHAB image containing an SPL container
+
+        The SPL container header tag is placed at the given offset, and the
+        returned buffer is large enough to also cover the signature block
+        referenced by that header. The image-entry flags hold the A55
+        core/type (0x23) as their low byte.
+
+        Args:
+            offset: Offset of the SPL container header. Use
+                nxp_imx93cst.SPL_CONTAINER_OFFSET to build an image which
+                starts with the ELE FW instead.
+
+        Returns:
+            bytes: Fake AHAB image data
+        """
+        data = bytearray(offset + 0x100)
+        data[offset + 3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        data[offset + 12:offset + 14] = struct.pack('<H', 0x90)
+        data[offset + 40:offset + 44] = struct.pack('<I', 0x123)
+        return bytes(data)
+
+    def testNxpImx93cstNormal(self):
+        """Test CST signing with an i.MX93 SPL container (no ELE FW)"""
+        self._MakeInputFile('imx93-container.bin',
+                            self._MakeImx93SplContainer())
+
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+        cfg = tools.read_file(tools.get_output_filename(
+            'nxp.csf-config-txt.nxp-imx93cst'), binary=False)
+        self.assertIn('Offsets = 0x0 0x90', cfg)
+
+    def testNxpImx93cstELE(self):
+        """Test CST signing where the SPL container starts with the ELE FW"""
+        # Create a fake AHAB image starting with the NXP-signed ELE
+        # container. The low byte of the first image entry flags (0x66) is
+        # the ELE core/type, so the SPL container header starts at
+        # SPL_CONTAINER_OFFSET and the signature block is covered too.
+        ele_data = bytearray(self._MakeImx93SplContainer(
+            nxp_imx93cst.SPL_CONTAINER_OFFSET))
+        ele_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        ele_data[40:44] = struct.pack('<I', 0x866)
+        self._MakeInputFile('imx93-container.bin', bytes(ele_data))
+
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+        cfg = tools.read_file(tools.get_output_filename(
+            'nxp.csf-config-txt.nxp-imx93cst'), binary=False)
+        self.assertIn('Offsets = 0x400 0x490', cfg)
+
+    def testNxpImx93cstUnknownTag(self):
+        """Test CST with unknown input tag passes data through"""
+        # Trigger the pass-through path using an input without the AHAB
+        # container tag
+        data = b'\x00' * 64
+        self._MakeInputFile('imx93-container.bin', data)
+        self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                         force_missing_bintools='cst')
+
+        # The pass-through branch returns the input data unchanged, so the
+        # produced image must be exactly the 64 zero bytes
+        out = tools.read_file(tools.get_output_filename('image.bin'))
+        self.assertEqual(out, b'\x00' * 64)
+
+    def testNxpImx93cstSigned(self):
+        """Test CST-signing-success path with mocked cst invocation"""
+        self._MakeInputFile('imx93-container.bin',
+                            self._MakeImx93SplContainer())
+
+        with self._MockCstRunCmd():
+            data = self._DoReadFile('vendor/nxp_imx93_csf.dts')
+
+        # The output must be the fake 32-byte CST blob produced by cst
+        self.assertEqual(data, b'\x00' * 32)
+
+    def testNxpImx93cstShortInput(self):
+        """Test BuildSectionData() passes a too-short input through"""
+        # The input is too short to hold the container header fields read by
+        # BuildSectionData(), so it must be passed through unchanged
+        data = b'\x00' * 32
+        self._MakeInputFile('imx93-container.bin', data)
+        self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                         force_missing_bintools='cst')
+
+        out = tools.read_file(tools.get_output_filename('image.bin'))
+        self.assertEqual(out, data)
+
     def testNxpImx8MFSPI(self):
         """Test that binman can produce an iMX8m FSPI image"""
         self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
diff --git a/tools/binman/test/vendor/nxp_imx93_csf.dts b/tools/binman/test/vendor/nxp_imx93_csf.dts
new file mode 100644
index 00000000000..bbe8eda4b70
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx93_csf.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx93cst {
+			args;
+
+			blob {
+				filename = "imx93-container.bin";
+			};
+		};
+	};
+};

-- 
2.56.0

