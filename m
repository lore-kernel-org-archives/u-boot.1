Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0189DC88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8B44606C5;
	Fri, 11 Sep 2026 16:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSIkTEVfun-Y; Fri, 11 Sep 2026 16:36:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C3F4960642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144588;
	b=pNZyjyU/Kf6uMBYam1S7PnAmmtwfK7nqXgxgkZWKcybKV++1f2w8qSUDO0LYyyNIP2C5
	 MQxDBU5XbR4jsFE8FDLkRcr539JGAo7SInT/Yhrw+E2Thz17UyYZWxo4AFkA+s2jkUMrZ
	 rz+dDqOB1j85cZr2sS4r1qh1hzieJ9QkDeKmb7Miob15s0YE4w7yxAAt1zFmJQiULmzah
	 GInu95+SDtVf9zZDUBefrdCetaPcTJ8VYMyKhf3wkF+0s1vBbdna5IBIIiyQ5DEZirK68
	 GzzkSPKRfpLSm1Lko85CZ35wBmLkAiNg4PRcQ1mmOoSRcW1jfTMx/4taMlW6PTcRjQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789144588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s+vosXfZX09Oom75wGdCDVEHN7P/bhWEvtlqIUofX2M=;
	b=jGpI5xC1tfVcMGc5N9qECCsp05MnQGrqgk55GtiEwLxSsuF/gch9LGjic0M7ebI/mfW0
	 8IkNEwm8qW7FlFyQSxsQbBKyFcbYlvlHFN27G1kJ4HbUaWuwXORP5NJxAMHMua0PIF+g9
	 L+vKvaQ5ULw+rRyYAu8amF8QMmybj8kD37PNv6s207M7ZdarEvCNBDtwch7VBtvBImy+A
	 iQjhSq4NtJx6S25XOCVcWOyR6ODCyKBbJdr6Rcq6B6KpNvQt6SC/+7YXt5ovydlFIfGa/
	 DPvr6ETsQdjFKMwJVJvpc5VpypayyAY5RtpW+3Pt6LimsTcWkOz+NRwsxkCznpRUpVA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789144587;
	bh=s+vosXfZX09Oom75wGdCDVEHN7P/bhWEvtlqIUofX2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yHR20Cz9w3qLqkhcqy6e1rVtkUqhIshf11ERmhCKD6N7HtsehixlazBcWyXuQbcnt
	 ESuoIzrYPi0S8sYgZJs1R0SPs8SaEVzG1hC308SjhssjWoUBJ8Qr/upaBB+/8UJ4nQ
	 dn552h4XCJ1SdsyQKQNVTKKetVkoRnoGL5nDvQIwbZwdbewqrT5YeTareFfk1SB5yU
	 4DhnbHNUHp4B0jYb6HiVa3qjiXkyBa9yBrPa3VcOH+c1C/9nyV8mxzjyoKflGS0cT4
	 N+VE9+LttE+uRYtNOz9ImnGTTnjr6WiZr97iv6MLRbErx8lInEoIUOQGeoHSS3aIeJ
	 UXzXFQgCCn7eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3F4960642;
	Fri, 11 Sep 2026 16:36:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 415B014C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3302E80EF2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JclfvQBQEa44 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 58CD180EA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789144585;
 b=FMOku6hH6NPgGdZwOK0PyTcsRxf3KTIgAY+q2R4PcBvD8Tx2izKbUDRTX5DqElry3SI6
 Twg8VYFUwA3SyharnBfibATqhBswTkK4fTrTsZGBut/C5uJaKmcTPeWuJ0dT/XkWZi+hH
 HLIRozAtfKmJehK9CESZ9Hisui4Ad7EEGkVjpFfKoVBfms2NuseM1nmAphY+GHuoJYOZ9
 JVTAZBrYSfiY3NglKyAqneoSqvImXkuYQPL2NhNiFjm1/1zXrpSjGCfdCwycEP+GOzhXT
 aF9HsF/vJ0c0aSoF5RELPLSoxfS//77mNBr2nFuBzTNOV76mnOt7e2UWzdpHRid/njw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789144585;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=s+vosXfZX09Oom75wGdCDVEHN7P/bhWEvtlqIUofX2M=;
 b=aubGLQMqE7DjCetWO7c8pT/KSNqCmGH1x9xFgvfDoC18CLCBj4pTpQVrrAnP5A+5uZp6
 XqOEbvM413Cx4i0l3bdLbYrkIwxltskXGTb6xtzu3jj5ufBXrzWbOldoO7U+lhwtAgaR4
 h8NlstlYWisT6jY8/0xGHYqHVpRD2CDzLyk2b2AHgHhIj1zVnDOPEgI/pyMkfTyqVIh22
 Z2uSBpbDZnCulf8lSKisL5DF2eiZrefoOu4oZ77UxB43Esq6Z4cOrxQtvfdEQLU2+05cX
 6Wgg5D9VeSK+JH423+IPT1H3BRTDXdfkYLZCfe3+dJBxYBMtp4A1J6EVfZs+rqYtSsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="pB0H4j/N"; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=pB0H4j/N
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58CD180EA8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 027551A00D5;
 Fri, 11 Sep 2026 16:36:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CB8D9601A3;
 Fri, 11 Sep 2026 16:36:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A60F911C7AFB3; 
 Fri, 11 Sep 2026 18:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144577; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=s+vosXfZX09Oom75wGdCDVEHN7P/bhWEvtlqIUofX2M=;
 b=pB0H4j/Nw2Wt7HK2mXRnij2ReufDPQyjyuEJiHM/bgus4khKEyrn2qF/US2tTybLPqzhf8
 NeG6uKu3A974PtDKqn66MBJm8ofohraK4SOUzRAZcVmue4rBdBUhPWbV0+lrz9vnL/U4o8
 IqYvH9ymGnd8oNR1JU2RIkCijM6KHkbc8J0BttyFkKBg5DTWQYnTRGuuDEz9PaQdvJaTVl
 BoDWcxSHxH9kvInjJYgw3OF5zhK2YAw0BEa4XVkS1XwVYzEQ15K/X/zZXzruaEXAQxJanX
 KXKldPKZXU9+0yWM5KxL/KxB7/jzsppA+shnhTlt342Z3iva07SRFXhXG7jnsQ==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:06 +0200
Subject: [PATCH v3 3/7] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-3-542a99793af0@bootlin.com>
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4868;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=N8qvNPa18KBg1qdkKVtxeeyM9eXAdu3T+okoo4fHV24=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3pL4fZ/O7VPOGZZKYuADdf9o9ZAue7T6EkV
 pOlohv3L42JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6QAKCRArAF6gG1qP
 A3uZEACHPgUFh1jlkLk6zIUh23WKKkqykH4VycO64ex6jPACjG2Y+nZT2+VCIw04IGTy2qUcgnm
 RqMs5XphgKvgFduilFjoJ3alGqDr+XEdPXhRKEaQfJDfqEL0jkQnaVN9FtBABUCOYkWTy28CPtJ
 9MbjAqnRugeoDIidMQWpUFYCQZXW9S8RlGwHktgHQjG/OdYB/W7nqLssiLUyZ4o27VKZkH2GlYv
 31wopL6o+v86DJtfF/f4wlM6rPxxPbDusA5IuGept9ZJBeJls0W+qsa2zx/i0bqVR4HvkeTI+iT
 KTJKkm/rnQqTaXFG7MExsQ0nCwN67BNeZ6luqEGxet+EoJXzRXTu9JpI4xuSYVXF0Z9XlhCNC0k
 iFkDol9HoDuFruVgh0s5kZhRGBlpEhvx+VTpVSYwh2mp1/lMZQPf2LH7dZD10Fp6QaOAwtLknp2
 URNsQ8jnq1IrTxR9t/30pHS+SYneepGESexf4vZ3b/hvMP3aob90A+FC+3xX/Shk5fn5yqTlFz5
 QCFueH9Tbv4UiPjzwedTvU97Msz/T3ZM718XouPE+HaN8iSbhM74JN52DMYJYk0MfVBWflqWGQD
 T0S43idLYk9qe9LyPF5ZpaqFPE3GfWxVwjhfN5cL/CeEFWPNCXAG+HGe2T252beE4fSq1ShJMeL
 KiAfisHKxQngHuA==
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

