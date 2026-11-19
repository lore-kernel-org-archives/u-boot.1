Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087D606A332
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xCRHWsf8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D5F1812AB;
	Thu, 19 Nov 2026 09:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-nmUKog9Y4i; Thu, 19 Nov 2026 09:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 581C480F4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795079949;
	b=JU8rralXBxttZG+VxLMfArJXVNZQTqDMwnHOJ2ciBqhV17SJXH3uHj0v/UXaoIjUaTKG
	 bL8qp4Y3bwuISf4RZo1cby7vY3/m6LYPqW9R4NUDBAgmXo+uJCCc87ydiHsnlxDlpR3Rq
	 In16LJjpWG+eJrRbqREO9UDvTtJMtsX9s2XMTZGjARhuYJRchIGJ9M/Vb8HlsPBT2w6TT
	 J3Lezia00+rDZmOJEBddRcAEAZ4TKmIH06RQhiV8mCgZ6TwqeYtcKqqRo5mi3a+PA05T9
	 h9enOis6Q+9qQpmExXrDeUMBKnbLtKQwfVvO7E7yhIYWfr0V1yRAib8+NrN5KrLSyjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795079949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6dXhtoj56pigw3/dVeu2Piy+/ryd8QC4lcM7qxxPHEk=;
	b=ZnXhla3jDiIAsNMDov8z8WkX1Q8ZAAQE4Wb8gSMLRsnN6BTAR2TLYTdoaslI/uNz7pKl
	 6vl9dHk2W746vIvfj9lheQU2HX/PevISMVR3KUQ6enxSlJS6i1o29WUkElhJXLsiLuqpR
	 XzBAuvaEYsq/u0pZeRPZLxivD9lfnAayPNoj/Bs+aq3XDYXfh3Erbuh7kfMxx8UwveWj2
	 eaNhCCTmA5tOERkl/lS3eiFoar+YOhisZC5v8su+chUuQyJoJ2QcKw0P8E1pz1gAtQ27p
	 5xCqoMn89nIck43izHZc7VjREm9fJFkqGcHcWPy6Kc/Q74DolbZNDpkoLVDk/QWpMVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=rustsbi.com;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795079949;
	bh=6dXhtoj56pigw3/dVeu2Piy+/ryd8QC4lcM7qxxPHEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xCRHWsf8njVu7ODjQ+KUKEToRV+H1GNY5pqdcIhl4x7IL0ms9cJZaNVN2jrK+1iyv
	 oAj6Iw9H9uA0Wwpk9uwqxFNTDWy/w6rX3r4fn3SdNgyh9R6EpKqJdrrQTJETPKyF5a
	 VoWJ5hwmtHPXWGtztgK4aaGGtinPxp0osLA1PrjucmtICJ7a7+Ctb/2oFMRCM8//zt
	 puhUncGpOTtZ5MxbiNtGfyTA8gPh4hZIeXB58iqXEDiJonnoCAmhFWuiEEXkMknYVF
	 DBu3JFWITjDANBdBetRogjqAmxsPpXsyCWlHYJ6p+NxiYlI3HobD4tPPaZLGphEKia
	 oxAUWm5riLdwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 581C480F4D;
	Thu, 19 Nov 2026 09:19:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA9EB70B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A082380F4D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5FE7dfHiq85 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E11C380DCC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E11C380DCC
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:04 +0000 (UTC)
X-QQ-mid: zesmtpsz3t1795079892tb564f860
X-QQ-Originating-IP: qXJTqw87ZR38z8E1CT+Fka0tyNZz30V9FRTbct7Z7dQ=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 17:18:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6740102583277304573
EX-QQ-RecipientCnt: 11
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>
Subject: [PATCH v2 3/3] riscv: Document SBI firmware support in SPL
Date: Thu, 19 Nov 2026 17:18:42 +0800
Message-ID: <356792A791E175F1+20261119091842.3062208-4-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119091842.3062208-1-luojia@rustsbi.com>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MIAHdi1iQo+zl+lvtrdYx1aziclTsnuu9fUxtjfh75PSXuTwXzvnXenb
 Jf2zQhPiEIKjv2NCOrPn0+jQrx7kIlQ2NlHFeno8b8th3ENKE8PEVdy4K+tA7KRNxBitCPZ
 6ag1IKIvaju0Rgr1wsFz98KN8wtdz5qokilhL/GVvpLpzr9B8008esfkCK1O4h8SEYCdNb9
 1tqsQMKXDmuwyATusv970d1JN59ZmiYDiH+nFNuGxHn8AowdFE8kOmT8cEgDga8exT1WAy/
 uta+Q+Q0cuVfS7GzsTThblR869Cf0Cg1DeXcGC0qCROyvYJoc+9Zl9aSqfoftYxvzaOjard
 wLFl+B2T2ixnCbIfIHnqMgfGmmcJWMAXWpu3eCRD6ZIY/09Wx/+/J5QEO/nKLXXyoo6E0EO
 NjifmNKWRtHv8TGJcRomGPsGA9miTRmx076PhR6Q2i9Ccijh9qswhPGrey29qW30zKwEhhP
 MJytnewENAm9cBiO5Lu6vn1LDbNKNGQO6CGCgNu6a7uFNx1DmkJm+Eylnc8FSUqRL1kZFs/
 RrKA/x9QjgAkiCKcm5tGajVZvU3AY1nA0kcN3WuOfhTCP3Rlt1OrnSqsBMqmnrukW2AcbMw
 WhvBkf3NjXKpRF2HF2EsQeJxK8kCQi5NlEj3XQsTJ8NHzIdLXcIDF68xoDLXSvuRK6b2Ya6
 RvACjHtTkhDw68FmckmfWy1ym9igslB5A7kgEded5E2f1gLDq/S4noSdlFWed0caINhuF5m
 jwmWW/e55WQ7u5vDpHu0yE6dqmK5v6jdC9f5H7KlnkDavCcEmv3C0rfxVRN6wujTjflqFjQ
 dxnrE4cpDWSKcQzbDTHdPd7sOVvqNtB+m31hIVzsodGTrYaqGJeEFaYGOBULXKutVJ3FF3k
 DNo4QnGIk9xtcUp3D9dCiMc9oZvtd6TqNqbvPnBz3eWPf6my73hUg+NWMyN8E2UMjuRKs6b
 DF9gcqkqARCXW/oxNh85Nlc8vO+O70C+TYSXR8rWLNd1nTc8ik/BkZm12b2/lJ1K78n7YVG
 kbhe/fSqdEXe4kH+CQuXyGB1Qqe6oYKbWGVqUeG76UXR9/u/PxzQ4F/MN0ERpbmGnjdkpTU
 Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document how to supply OpenSBI and RustSBI Prototyper dynamic
firmware to the existing SPL handoff. Explain the firmware load
address, the FIT OS label, and how each implementation handles
SPL_OPENSBI_SCRATCH_OPTIONS.

Mention RustSBI compatibility in the SPL Kconfig help so users can
find it when configuring U-Boot.

Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
---
Changes in v2:
- Document the shared handoff in the RISC-V architecture guide.
- Explain scratch options in the architecture guide and SPL help.

 common/spl/Kconfig |  8 +++++++-
 doc/arch/riscv.rst | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..07548094e38 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1744,7 +1744,10 @@ config SPL_OPENSBI
 	  Interface (SBI) specification. U-Boot supports the OpenSBI FW_DYNAMIC
 	  firmware. It is loaded and started by U-Boot SPL.
 
-	  More details are available at https://github.com/riscv/opensbi and
+	  RustSBI Prototyper dynamic firmware also supports this handoff.
+
+	  More details are available at https://github.com/riscv/opensbi,
+	  https://github.com/rustsbi/rustsbi and
 	  https://github.com/riscv/riscv-sbi-doc
 
 config SPL_OPENSBI_LOAD_ADDR
@@ -1763,6 +1766,9 @@ config SPL_OPENSBI_SCRATCH_OPTIONS
 	  - SBI_SCRATCH_NO_BOOT_PRINTS = 0x1 (Disable prints during boot)
 	  - SBI_SCRATCH_DEBUG_PRINTS   = 0x2 (Enable runtime debug prints)
 
+	  RustSBI Prototyper currently does not use these options. See the
+	  RISC-V architecture documentation for details.
+
 config SPL_TARGET
 	string "Addtional build targets for 'make'"
 	default "spl/u-boot-spl.srec" if RCAR_GEN2
diff --git a/doc/arch/riscv.rst b/doc/arch/riscv.rst
index af0c48b8982..dc4cc853baa 100644
--- a/doc/arch/riscv.rst
+++ b/doc/arch/riscv.rst
@@ -72,6 +72,23 @@ To examine the boot process with the QEMU virt machine, you can follow the
 steps in the "Running U-Boot SPL" section of the following document:
 :doc:`../board/emulation/qemu-riscv`.
 
+SBI firmware for SPL
+--------------------
+
+With ``CONFIG_SPL_OPENSBI``, SPL passes FW_DYNAMIC handoff information to
+the firmware loaded from the FIT image. Supported implementations include:
+
+* `OpenSBI FW_DYNAMIC <https://github.com/riscv-software-src/opensbi>`_.
+* `RustSBI Prototyper dynamic firmware <https://github.com/rustsbi/rustsbi/tree/main/firmware>`_.
+
+Provide the firmware using either ``OPENSBI=/path/to/firmware.bin`` or
+``RUSTSBI=/path/to/firmware.bin``. Its link address must match
+``CONFIG_SPL_OPENSBI_LOAD_ADDR``. Both use the ``opensbi`` FIT OS label.
+
+``CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS`` passes options to the firmware. OpenSBI
+uses ``0x1`` to disable boot prints and ``0x2`` for runtime debug prints;
+RustSBI Prototyper currently ignores these options.
+
 Toolchain
 ---------
 
-- 
2.53.0.windows.2
