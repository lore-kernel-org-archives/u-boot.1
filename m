Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29C606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e8cmjzpe;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aE25vKXe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2745860892;
	Wed, 21 Oct 2026 12:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-x7CSBR2x2B; Wed, 21 Oct 2026 12:55:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E75DA60837
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587303;
	b=OVrbJIZMY22Bg5P42xNmjP7xj2sUSYBb/fSnwEzgChTVhgSTIOb+TJvEPN3DsrgAkpiO
	 673atL9CLAqrS9GosX6Bnq6F83qNNNhHKoOJffqn/304hKTE5WGe9gdhN0kL3Z/GF7SmO
	 AHQVLNAuwBOiIlT0MqRrBxD9QumbY4cVFaL1ZmlcZApriY0Fc4pwsqJnYv1CkTlx7MdE8
	 Wt/Lm8LBk7pF+QOkOPg1cks0Wfly7PennPbrtuf0r9WTMGeCoixGHJP61dwUh5z2qZJ4F
	 6C7lxLobsNrcYuRHO9Gxw0fzv/CY/UJgR20k901xSOdoBMLxPlX7wbSlGsB5fLbU9qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587303;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8Jqi8DbMfHsnXg/2UClEZyOyd/e1Ty0Z278a0Y1CXMI=;
	b=L9fphNJvBla3D4j2TBPvPW7Ds+xcaYSCAF0g+Am16CoV1riJc5eX0EEgVWTiNNJQOZLf
	 QvC6YxKVmNcmXfi8zA8d7VZckvPMTKTeQifOe4d3bBE2xDCt+oqcytGcoi4aIXD2xLRB0
	 FoEis1tngYoTCA7lNqzNoz+HUQZXt8JzsBIPHmVBUitcu0iSlR8AFppB2kOKUvYh8e51k
	 LYr1gQxPcFsXIlOZk+2S291sP4YgLrRVt80JlXseVEE4dM5EWNr3fLmWKewv8r/A9k436
	 56RI9zizGSMynjeU3rpOyKxwEri/9REL40N6TzV/Sn4ntoFw2DL7bMOOCP1OI0ok0gw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aE25vKXe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587303;
	bh=8Jqi8DbMfHsnXg/2UClEZyOyd/e1Ty0Z278a0Y1CXMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e8cmjzpe+FfSFpAaiFadS0QaguSpQ2wiphPbE+2OajJ84/fqLyLfPWjrTpmef10it
	 +rOTvtn7DcfVUiqjw0MygpgJjvEvoVHtvbgebncwtqbQ5TStIoGbyPTK3cDuzCc74e
	 UaG3zx3h6nexUzs954tKyUPNY1N7IbKsx+Xosc7U0YhvzvWekvMeUfPqwbt8KTBnK1
	 iP/+sgt8Gq0eZR6QtkQrGC0Ru4pP4fEQ5JvlDPU+c5cj1w47jS4HC5O89uZkiTIDNo
	 xPqsbyyIsX3gvsyzqj3jjeID1feEY37nds6pc+Ors/77xdtBIV5kO+F9h2UDimWtBF
	 t+LEUfYWFlolw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E75DA60837;
	Wed, 21 Oct 2026 12:55:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6630F23A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BA0060834
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qVfoMktNlUKG for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BCCB60818
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587298;
 b=nm6ZMbIo+JWv+eAYVrKh5RpOl11cbu6uNHClJzsP9KkMTRdCKiouQXuBZslxeKJmL/BL
 mOWwcn5pMu0jIbLujB6xDXGJ2pn70xstcICkIKhJ2V9ReRVWQaSBcu4Fovur2bxJXIiep
 zkbk4ozFdt9Gdt6XDTRFb9GNK/DNSTR2yPhY0DRLUJcWIx3rP+LTjbf2uAr3SpVL1EeeE
 vf/0tntNvaPu615CRPK0lTmdnytWQdk0A7iWj/0pcC8FlaJk7rRn3fjFxWJvVBsTEP3aI
 8nc6QKCriEGccSAGQ0R5RnY7DooAZfmJI6N7Jll7wMd5sDQlHEDtjLO5KZcI/yOmm5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587298;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=8Jqi8DbMfHsnXg/2UClEZyOyd/e1Ty0Z278a0Y1CXMI=;
 b=oDqpY/cCz5h2yPK/gePvmztoB3fawCFEDv7Xg21J8/moGB4CHiMh3X/+heuwRz8kg7Hg
 DGynuy3jc3LHWtWF1BtYndxD8iQUxr9auqsfzvuc8fh7Bhj3NNUVh9c/f9SalX6q0x4XA
 qGB/NY8PSdYMWSQyoSaVfCXMe36OedZ+RGdSYnMLXbaL+jRLEARG10mK89wcsULVTK0O0
 Ygel6LVrspyl+fE96Mi1aG6KmpEQpai1LKSGgNRaPCbJmzIimJosp2pgu2xhHtDp47VZ+
 NMQSf4PC+hc1pAExp3kMaddil2Vh+rbyDBB41GIVgTleeqSyLRl/shIg+D91sNesN7w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aE25vKXe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aE25vKXe
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BCCB60818
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:56 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5ea97b74acaso101466e0c.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587295; x=1793192095;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Jqi8DbMfHsnXg/2UClEZyOyd/e1Ty0Z278a0Y1CXMI=;
 b=aE25vKXerTh3bzgbq76s5SXO3uto3rd98mkD3aRurbMwNfFFUc1SXmZkOGwqHj79HI
 PaMVjjz9+yhY1l+UKZg0jH7xJdxr6VpMYnoVUFTsjeIe1CI4osYrDmPZZTwBIe6eOUdm
 //5k3QCufK4yB6MKRwB9nQcKuJOaNqFJFOJMk/jdSqSun6eVFrjCG1uwECaoU8qe/JZ1
 vqOIxCl1jiXFwbY42fFZiQ+2GojDYoAPDBdHx6kky/pTxqsU0yPkhTDhPh0rox1YGNck
 DIPqr/phqAxYJfcuVIzj+CA5c7g1cNtBsdlC+lBZZ0g4Hh4xS2fHEjFe5JpZzs+iid0z
 c9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587295; x=1793192095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Jqi8DbMfHsnXg/2UClEZyOyd/e1Ty0Z278a0Y1CXMI=;
 b=y2VQuEfCUThxRhL6R8XTn4olOJh3LLcekehFx+BWtSGQxaY8OAMpLN11ssBInMUTRQ
 imko+v6SOnzV96iAdvzjnoaF3LhAgsguUkYxGiJ04MFEy0OkqQeKNfEWAAouOHmeD7xF
 pqbCDrOAxpKzFgAZOaqMW1Yv5d5XCCBoII4RniEKvjk5jbKuMf9eauIyM0M0pTdHXkPa
 hOEm4QZBqsHH5of49NcDH5kFYP1/alxOz6v+2sz1H38a7HLt0LEN27iAOHShSr3yHCvo
 IvA08g7zzb8UgctpUQHOv0zXqzVzny6/arVs16jkMsv+42ybhqUNNUqxjB6yXGUVCeRZ
 7sKg==
X-Gm-Message-State: AFq9FYJ3PkjwpigEvWi08Gyiahnsk0UMg0PndQmxYXpQucvMkuriOq6g
 NFAers/aYmRlOeSApkPczuZ3vSupey1jNIkCfF+f/IFaO87DhMpvIIabir/Am5MIopA=
X-Gm-Gg: AYBFou0yjrpEOT39bRU4sEtV79BeW2K+bk4Ws2WqHWt7hKdS/MZcd1O1QoYT+A5HFXb
 f5v1bBK9IpmUxT2nDgKh4hBoVGvecWTQDG7tL4dS0Me453Df3+PycK41AoznGb6KiC5NoUrE8C6
 dAJ8HQO40hZu86n+4QIrr7+Pu57DQLCCXvskIY84Q8uJCdq8zl+1LMIMwhnFCYl0wY/Qtw5NLEX
 yo8u0/NvFyMJ0pZaww82wi6jfmQTkXRYu2net9B/VPY9ZTgeIlDIB/vBNmZIXndOWZYqm1vFxmz
 DjVHzkWpkm5JSr7yeRYYzy98nKM4wrBO6XVCRlRW9kW7EFQBFKLPnqVEvUgA0dVIUOlYxCHZQWX
 VJZiihV6Y5LhnkYhvKsPqxT6bPT0Y82fDgxipQXLMrB6+QGoANTnS/R1OEGJkbZiMduc9wymTYo
 kiZfvLpzNtWfE1MmrXg8MaP2i/kB6ijOvjQYHeM81vwKhT1z6rWKj9EVZZ2zfKtRagMvIm2m+tg
 iUeFwV3XP5u60Qwl3qlUMI0AswHpx8oQB7bPf7TXcoiy/ST64GlHVmmpC5nJfD45cGZwDa+WTZ+
 FX9oVMO0wCfd/7thmCI=
X-Received: by 2002:a05:6102:915:b0:7cb:bc5e:7dab with SMTP id
 ada2fe7eead31-7cc926978c5mr587404137.24.1792587295636; 
 Wed, 21 Oct 2026 05:54:55 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:54:55 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:17 -0300
Subject: [PATCH 1/8] binman: add Sophgo CV18xx FIP entry type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-1-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16.0
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

Add a binman entry type that builds the FIP image loaded by the
BootROM of the Sophgo CV180x/CV181x SoCs named fip.bin.

The image reuses the layout produced by the vendor fiptool: a 4KiB
param1 header with size and CRC-16/XMODEM checksums, followed by a
32-byte BL2 header (first instruction jumps over it). Unlike the
vendor tool, only the entry's subnodes (typically u-boot-spl) are
packed as BL2, since the BootROM does not use the BLCP, param2,
monitor or second stage loader it also supports.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 tools/binman/etype/sophgo_cv18xx_fip.py            | 89 ++++++++++++++++++++++
 tools/binman/ftest.py                              | 54 +++++++++++++
 tools/binman/test/vendor/sophgo_cv18xx_fip.dts     | 18 +++++
 .../test/vendor/sophgo_cv18xx_fip_bad_offset.dts   | 16 ++++
 .../test/vendor/sophgo_cv18xx_fip_collection.dts   | 19 +++++
 5 files changed, 196 insertions(+)

diff --git a/tools/binman/etype/sophgo_cv18xx_fip.py b/tools/binman/etype/sophgo_cv18xx_fip.py
new file mode 100644
index 00000000000..6fb189d2616
--- /dev/null
+++ b/tools/binman/etype/sophgo_cv18xx_fip.py
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+#
+# Entry-type module for the Sophgo CV18xx BootROM FIP image
+#
+
+import binascii
+import struct
+
+from binman.etype.section import Entry_section
+from u_boot_pylib import tools
+
+FIP_ALIGN = 0x200
+PARAM1_SIZE = 0x1000
+
+# jal zero, +32: jump over the BL2 header expected by the BootROM
+BL2_HEADER = struct.pack('<I', 0x0200006f) + tools.get_bytes(0, 28)
+
+# The subnodes follow param1 and the BL2 header
+SPL_OFFSET = PARAM1_SIZE + len(BL2_HEADER)
+
+# Empty register list, only the "scan start" terminator
+CHIP_CONF = struct.pack('<II', 0xffffffa0, 0xffffffff)
+
+
+def fip_cksum(data):
+    """CRC-16/XMODEM followed by the 0xcafe marker"""
+    return struct.pack('<HH', binascii.crc_hqx(data, 0), 0xcafe)
+
+
+class Entry_sophgo_cv18xx_fip(Entry_section):
+    """Sophgo CV18xx FIP image
+
+    This creates the FIP image loaded by the BootROM of the Sophgo CV180x and
+    CV181x SoCs, named fip.bin. The subnodes, typically just u-boot-spl, form
+    the BL2 image, which the BootROM loads into SRAM and runs::
+
+        sophgo-cv18xx-fip {
+            u-boot-spl {
+            };
+        };
+
+    The image contains:
+
+    - param1: 4KiB header with the BL2 size and checksums, read by the BootROM
+    - BL2: a 32-byte header whose first instruction jumps over it, followed by
+      the subnodes, aligned to 512 bytes
+
+    Unlike the vendor fiptool, no BLCP, param2, monitor or second stage loader
+    is packed, as the BootROM does not use them: SPL loads the next stages
+    itself, e.g. from a FIT placed after this entry.
+    """
+
+    def _PackEntries(self):
+        """Pack the subnodes after param1 and the BL2 header"""
+        offset = SPL_OFFSET
+        for entry in self.GetEntries().values():
+            offset = entry.Pack(offset)
+        return offset
+
+    def BuildSectionData(self, required):
+        data = super().BuildSectionData(required)
+        if data is None:
+            return None
+
+        # Once packed, the subnodes are preceded by the space reserved for
+        # param1 and the BL2 header, which is filled in below
+        entries = self.GetEntries().values()
+        if all(entry.offset is not None for entry in entries):
+            if any(entry.offset < SPL_OFFSET for entry in entries):
+                self.Raise('Subnodes must be placed at %#x or later' %
+                           SPL_OFFSET)
+            data = data[SPL_OFFSET:]
+
+        bl2 = BL2_HEADER + data
+        bl2 += tools.get_bytes(0, tools.align(len(bl2), FIP_ALIGN) - len(bl2))
+
+        param1 = bytearray(PARAM1_SIZE)
+        param1[0x00:0x08] = b'CVBL01\n\0'
+        param1[0x90:0xb4] = tools.get_bytes(0xff, 36)           # NOR_INFO
+        struct.pack_into('<I', param1, 0xbc, len(CHIP_CONF))    # CHIP_CONF_SIZE
+        param1[0xc0:0xc4] = fip_cksum(b'')                      # BLCP_IMG_CKSUM
+        param1[0xd4:0xd8] = fip_cksum(bl2)                      # BL2_IMG_CKSUM
+        struct.pack_into('<I', param1, 0xd8, len(bl2))          # BL2_IMG_SIZE
+        param1[0xe8:0xe8 + len(CHIP_CONF)] = CHIP_CONF
+        # PARAM_CKSUM covers NAND_INFO up to the signatures
+        param1[0x0c:0x10] = fip_cksum(param1[0x10:0x800])
+
+        return bytes(param1) + bl2
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a0e8bde7901..413850cf13d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6,6 +6,7 @@
 #
 #    python -m unittest func_test.TestFunctional.testHelp
 
+import binascii
 import collections
 import configparser
 import glob
@@ -5598,6 +5599,59 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Node '/binman/renesas-rcar4-sa0': SRAM data longer than 966656 Bytes",
                       str(exc.exception))
 
+    def testSophgoCv18xxFip(self):
+        """Test that binman can produce a Sophgo CV18xx FIP image"""
+        def cksum(buf):
+            return struct.pack('<HH', binascii.crc_hqx(buf, 0), 0xcafe)
+
+        self._SetupSplElf()
+        data = self._DoReadFileRealDtb('vendor/sophgo_cv18xx_fip.dts')
+
+        # param1
+        self.assertEqual(b'CVBL01\n\0', data[:8])
+        self.assertEqual(cksum(data[0x10:0x800]), data[0xc:0x10])
+        self.assertEqual(tools.get_bytes(0xff, 36), data[0x90:0xb4])
+        self.assertEqual(struct.pack('<I', 8), data[0xbc:0xc0])
+        self.assertEqual(cksum(b''), data[0xc0:0xc4])
+        bl2 = data[0x1000:0x1200]
+        self.assertEqual(cksum(bl2), data[0xd4:0xd8])
+        self.assertEqual(struct.pack('<I', len(bl2)), data[0xd8:0xdc])
+        self.assertEqual(struct.pack('<II', 0xffffffa0, 0xffffffff),
+                         data[0xe8:0xf0])
+
+        # BL2: header, SPL and padding to 512 bytes
+        spl_end = 0x20 + len(U_BOOT_SPL_DATA)
+        self.assertEqual(struct.pack('<I', 0x0200006f) +
+                         tools.get_bytes(0, 28), bl2[:0x20])
+        self.assertEqual(U_BOOT_SPL_DATA, bl2[0x20:spl_end])
+        self.assertEqual(tools.get_bytes(0, 0x200 - spl_end), bl2[spl_end:])
+
+        fip = control.images['image'].GetEntries()['sophgo-cv18xx-fip']
+        self.assertEqual(0x1200, fip.size)
+        spl = fip.GetEntries()['u-boot-spl']
+        self.assertEqual(0x1020, spl.offset)
+        self.assertEqual(0x1020, spl.image_pos)
+
+        image_fname = tools.get_output_filename('image.bin')
+        self.assertEqual(U_BOOT_SPL_DATA,
+                         control.ReadEntry(image_fname,
+                                           'sophgo-cv18xx-fip/u-boot-spl'))
+
+    def testSophgoCv18xxFipCollection(self):
+        """Test using a Sophgo CV18xx FIP image in a collection"""
+        self._SetupSplElf()
+        data = self._DoReadFile('vendor/sophgo_cv18xx_fip_collection.dts')
+        self.assertEqual(data[:0x1200], data[0x1200:])
+
+    def testSophgoCv18xxFipBadOffset(self):
+        """Test a Sophgo CV18xx FIP subnode overlapping the headers"""
+        self._SetupSplElf()
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('vendor/sophgo_cv18xx_fip_bad_offset.dts')
+        self.assertIn(
+            "Node '/binman/sophgo-cv18xx-fip': Subnodes must be placed at 0x1020 or later",
+            str(exc.exception))
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/vendor/sophgo_cv18xx_fip.dts b/tools/binman/test/vendor/sophgo_cv18xx_fip.dts
new file mode 100644
index 00000000000..7bec144e2b7
--- /dev/null
+++ b/tools/binman/test/vendor/sophgo_cv18xx_fip.dts
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
+		sophgo-cv18xx-fip {
+			u-boot-spl {
+			};
+		};
+
+		fdtmap {
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/sophgo_cv18xx_fip_bad_offset.dts b/tools/binman/test/vendor/sophgo_cv18xx_fip_bad_offset.dts
new file mode 100644
index 00000000000..8c0b68008e2
--- /dev/null
+++ b/tools/binman/test/vendor/sophgo_cv18xx_fip_bad_offset.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		sophgo-cv18xx-fip {
+			u-boot-spl {
+				offset = <0>;
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/sophgo_cv18xx_fip_collection.dts b/tools/binman/test/vendor/sophgo_cv18xx_fip_collection.dts
new file mode 100644
index 00000000000..a13cb7b7ba6
--- /dev/null
+++ b/tools/binman/test/vendor/sophgo_cv18xx_fip_collection.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		collection {
+			content = <&fip>;
+		};
+
+		fip: sophgo-cv18xx-fip {
+			u-boot-spl {
+			};
+		};
+	};
+};

-- 
2.53.0

