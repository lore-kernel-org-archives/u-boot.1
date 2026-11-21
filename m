Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91009606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xw6+9BGf;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MzO/ynMB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C54D180C70;
	Sat, 21 Nov 2026 19:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAZPpdDA3vXX; Sat, 21 Nov 2026 19:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEC3780F2C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795291121;
	b=Ko8mHm5WMnz4rGHY8byYtOl9yiVPu6iC0l28TMk5E+VuHEtcuJ6p6FwHkuQZmxRicu8n
	 gxoKLGjVAeCA88X+ZvNITKQU3fV/Y0AOqp1aZ0OhQF9bGS46O1vhb4p+MPQAR48dfxPpC
	 WwnqHW/KIGV8aUyym5OWtPTP94QTh7w2VKM1Fv0LsNGR7ANxkPLrxtrLSyTPop422sSQr
	 t+RVxXtJdfH0TxJt2LDSIFEyOBAOHuDqxrhPoSw2ARfYZNphmeuiIteSCvt/akH0T09UH
	 rVFbYr7z8Ubqvwt8GPfPMTQEN9lbqSpBD5ZGlmFMRRZPBStbDubulIIQszHUD+2KVLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795291121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z7fr8fGnHTvPzuYMrhZoonH4kiDOFkbOroKRn2ZX87Y=;
	b=LinJRjX/U2gV1rqemHIVcHBtX5VIgJfvND28LZiZnMyr5itY8vLbl9MR61gKo4mi3Gdj
	 q/BGBzUrGj9O7V4VnikTGDYcPrK71f5dmxia1ukVKvODJyGHTuQW1QeOuli5rWZo8szwa
	 0IA3J2gsAtjgsTIG0qjxuFND5Tn0l7nJiyq4y0ww+syNeC7NmabR828jRLWl2r+LcqeZb
	 eO52Sv1OUtH7W2VVytg7yqhDRh1ni1Wn5h7MolqRuiMmtdo0dnlMXiRCjsb2eo5GhHdX9
	 QTmF4Wy7MK2yq8qksBYSmbTTJ8i/hLnTy1gQzhhheyT4H0EB04JFWZyJ7zFi5rpvWfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MzO/ynMB";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795291121;
	bh=z7fr8fGnHTvPzuYMrhZoonH4kiDOFkbOroKRn2ZX87Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xw6+9BGf3t5kZDiJqXtNmJWOmMZcPGu5YLw/ekPiRVz11ceMpalXJjtCQ0VVHV3NF
	 pUGrDQ9rD2OfiaIY59Q0sLjHtG5TCLcat0E7B+aMTlB62DoOESvN3WtWEKR+HrQyhl
	 a85xamYd1itT00hcIlDuS4x25LMA1+5J+/57DX6Iz/3z+UA2R1Ze/ivaRALgggLPxI
	 bicT5M+ATL+OfWWuspHw1nI4LICF14YCcQowtPzTpaKrOaxQlqMuTrK3RKX2VJTsVG
	 6+wLCLVxXmQ8iiOYelaHuVk6jieZq0hQhOQn2pYLvY9yLX4V5KJwOCZlqLcLM39hVb
	 WdeKQ5+QnK6bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEC3780F2C;
	Sat, 21 Nov 2026 19:58:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA9ED465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90B16808AD
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIZpIfpnwVTp for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 18:58:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5B5A807F9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=thallescampagnani@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=MzO/ynMB
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5B5A807F9
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:16 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-33fb4680717so5394291eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795287495; x=1795892295;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z7fr8fGnHTvPzuYMrhZoonH4kiDOFkbOroKRn2ZX87Y=;
 b=MzO/ynMBn4tWlNDFhfMKkV4I8yAGPi8SOg4iwj127DOv/Y7e3JWUPMVaU8Z8Jju+nS
 3Ib3oiQJktLPVDTr7NJ8+VpGHFPHTkmJP5GJFP0qHtaa2zl5HHLE/lbhS2OluJwn26pC
 bfGXIYAFU6nEkDZ77DhklfNE9RrpUYeIOQRLET0btsLbulXJ6L/V+kBY7amIApdKxmLz
 upKGTA06HHNoY0qEoz+2OORRriW9IZmJk/J5Cx9Xu1FY8lhtRC+l6JbEypwTD2PD5pLS
 TULx6ILLqN3wdjE3RgdkCIjqUfzcwaoMGMqOo8lD0vydhWsYzZnhxyps7H6qT9eH9WkE
 KIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795287495; x=1795892295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z7fr8fGnHTvPzuYMrhZoonH4kiDOFkbOroKRn2ZX87Y=;
 b=m473AyKwAerZkRJq1HR+mPCp/qA540ih5cD7MP0pFShGOnbYqbCTjQ2zbOLm9PllJx
 xBcF9G9HeeMJmNhzeFuN8YyYkiwY2nYTQlWieDJCVa6YhYLg4aeselbAuqr5D2YrjPlJ
 sp8pelSJ0PNAn5c+H+0gFcKv2l6aIbwE3mpRM0TMFW8UbYahYezriE3/OhXniGZ9+4ZV
 P/dUk5xQ+mknse02Dm6BBkmZ1eOe6LIY8nEfvTDwoYOqYXT5PwNhA6IdqAL9iG+UQZmg
 LWrh65CGE9oHU1lfYRKdPH9iNFw1am9lPEcvyIt9gd8XeG+g0O04qAeCgLTsj8f/BF08
 rv3g==
X-Gm-Message-State: APuU4Z/AtzsGfzhWImGadFBJjBwxB++sxSr8ilCP4OSkBh86F/iNGnPY
 g46vcMvVD3ZOpogtSFMgrHINIi4e9rxhzn9NlRU6llghWOqGrXePH9ltSy2UVH4F
X-Gm-Gg: AZFdTZfEh3TV1Sz3Riw5VJXSg+L0u16mab9xq8654jfHsljTkIHvXZ1Jwq06hyCQAWz
 1OSBTionhquz57K4VWaMIWDOUb8+ui2caOfKoXbemJj1gL9EU7gIJPfN87QM3P9Or3S/NF8CTqs
 jJ/09pufwtZaC49lhs6CFGN7Hy9QqkDckjnbkxst29PPUuLO5ySFeJ72hNhYDKMiyX8WKRXqg8y
 OPGpbhlqvPZDZTdMn0HxYIQukq1fNS86/qveQ/Nnma4Ww7l0PUkgKYJWeEFWDj2UKVfYP3YlN8I
 hAL+XMhqxL439pz89KOK3cx+OklYyxa/WJBde5oQ8lU5skjdq8zJyBj3krQ0fYwvGTsl0nEYdPy
 +UaoE0XY3fHDH8N6J00bUhOt+E9EXHvo4G3ImUUyVKcyj7OliH1nq0zb8pbAK3k0EUmTw7fH84b
 8IhpEEfUQYjd8nkcSv/EqGW0fTXtTXKcAMNr7x3mduCafTPSZ2New16+q7IHUrAGGD1pNIR3UzX
 EobyUHRMmtmONPu9DYqkhp0Oqyg8bQ9nvTn5VeaRrXCjdWDZFcogxbz2nyRoxOkl61NtZCkh0Ch
 OQf6DWlnRqw5zocs+oz8g0aycSDqq3We
X-Received: by 2002:a05:693c:20c4:20b0:36f:550f:bb0d with SMTP id
 5a478bee46e88-3856c2c3ff8mr7273700eec.5.1795287495233; 
 Sat, 21 Nov 2026 10:58:15 -0800 (PST)
Received: from qqlt ([2804:14c:5b81:8b94:5fa9:2af4:7818:7c81])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm20383004eec.12.2026.11.21.10.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 10:58:14 -0800 (PST)
From: Thalles Campagnani <thallescampagnani@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Thalles Campagnani <thallescampagnani@gmail.com>
Subject: [RFC PATCH 3/3] doc: spacemit: update K1 build instructions for
 native DDR init
Date: Sat, 21 Nov 2026 15:57:38 -0300
Message-ID: <20261121185739.531651-4-thallescampagnani@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121185739.531651-1-thallescampagnani@gmail.com>
References: <20261121185739.531651-1-thallescampagnani@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 19:58:34 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update doc/board/spacemit/k1-spl.rst to reflect that SpacemiT K1 SPL
builds now use the native open-source DDR driver
(CONFIG_SPL_SPACEMIT_K1_DDR=y) by default without requiring an external
ddr_fw.bin blob or DDR_FW_FILE. Keep a short note for opting back into
the legacy external blob and update the expected serial output and
DEBUG logging instructions.

Signed-off-by: Thalles Campagnani <thallescampagnani@gmail.com>
---
 doc/board/spacemit/k1-spl.rst | 49 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/doc/board/spacemit/k1-spl.rst b/doc/board/spacemit/k1-spl.rst
index 187eed56e8e..d65f34cd1e6 100644
--- a/doc/board/spacemit/k1-spl.rst
+++ b/doc/board/spacemit/k1-spl.rst
@@ -60,18 +60,18 @@ Default baudrate: 115200.
 Building U-Boot SPL
 ~~~~~~~~~~~~~~~~~~~~
 
-**1. Obtain the DDR training firmware**
+**1. DDR initialization driver**
 
-The DDR training firmware is a proprietary binary provided by SpacemiT. It is
-not included in U-Boot and must be downloaded separately from:
+By default (``CONFIG_SPL_SPACEMIT_K1_DDR=y``), U-Boot SPL uses the native
+open-source LPDDR4/4X DDR driver in ``drivers/ram/spacemit/``. No external
+``ddr_fw.bin`` binary or ``DDR_FW_FILE`` environment variable is required.
 
-https://github.com/spacemit-com/spacemit-firmware/tree/master/k1/v0.2
-
-Download ``ddr_fw.bin`` from that directory.
+.. note::
 
-This binary is integrated into the SPL image at build time via the binman
-framework. When the SPL image is loaded to SRAM (e.g., via USB fastboot),
-the SPL executes the DDR firmware from SRAM to perform DDR initialization.
+   If you need to fall back to the legacy proprietary ``ddr_fw.bin`` blob
+   (from https://github.com/spacemit-com/spacemit-firmware/tree/master/k1/v0.2),
+   disable ``CONFIG_SPL_SPACEMIT_K1_DDR`` and export
+   ``DDR_FW_FILE=/path/to/ddr_fw.bin`` before building.
 
 **2. Obtain OpenSBI fw_dynamic.bin**
 
@@ -89,18 +89,13 @@ but U-Boot's binman still packages ``fw_dynamic.bin`` into
 
    $ export CROSS_COMPILE=riscv64-linux-gnu-
    $ export ARCH=riscv
-   $ export DDR_FW_FILE=$(pwd)/ddr_fw.bin
    $ export OPENSBI=/path/to/fw_dynamic.bin
    $ make spacemit_k1_defconfig
    $ make
 
-Output: ``u-boot-spl-ddr.bin`` in the build directory. This image contains the
-SPL code and the DDR firmware blob packaged together via binman.
-
-.. note::
-
-   If ``DDR_FW_FILE`` is not set, the build completes with an empty
-   placeholder. The resulting SPL will boot but cannot initialize DDR.
+Output: ``u-boot-spl-ddr.bin`` in the build directory. With
+``CONFIG_SPL_SPACEMIT_K1_DDR=y``, the native DDR driver is linked directly
+into SPL and no external DDR blob is appended.
 
 **4. Generate signed FSBL image**
 
@@ -212,7 +207,7 @@ shows output like::
     vdd_core, value:900000
     vdd_1v8, value:1800000
     vdd_1v8_mmc, value:1800000
-    DDR firmware: [0xc0815840]:0xf0227179, size:0x8d98
+    k1-ddr: LPDDR4X 8192 MB (2 CS) at 2400 MT/s (fp2)
     DDR is ready
     SPL: Unsupported Boot Device!
     SPL: failed to boot from all boot devices
@@ -220,21 +215,21 @@ shows output like::
 
 To walk through the key lines:
 
-- ``DDR firmware: [...], size:0x8d98`` - DDR firmware loaded successfully
-- ``DDR is ready`` - DDR initialization completed
+- ``k1-ddr: LPDDR4X 8192 MB (2 CS) at 2400 MT/s (fp2)`` - native DDR driver
+  initialized and trained DRAM
+- ``DDR is ready`` - DDR read/write sanity check passed
 - ``SPL: failed to boot from all boot devices`` - expected at this stage,
   confirms that SPL with DDR init is working correctly
 
-If SPL hangs before printing DDR messages, verify that ``DDR_FW_FILE`` was set
-during build and that ``ddr_fw.bin`` is not empty.
+If ``CONFIG_SPL_SPACEMIT_K1_DDR`` is disabled and SPL hangs before printing
+DDR messages, verify that ``DDR_FW_FILE`` was set during build and that
+``ddr_fw.bin`` is not empty.
 
 .. tip::
 
-   To see verbose DDR training output from the DDR firmware (per-phase
-   training pass/fail logs), add ``#define DEBUG`` at the top of
-   ``board/spacemit/k1/spl.c`` and rebuild. SPL then passes ``puts`` as
-   the firmware's log callback; otherwise the callback is ``NULL`` and
-   the firmware runs silently.
+   To see verbose DDR training output (per-pass PI and independent-eye logs),
+   add ``#define DEBUG`` at the top of ``drivers/ram/spacemit/k1_ddr_spl.c``
+   (or ``board/spacemit/k1/spl.c`` when using the legacy blob) and rebuild.
 
 References
 ~~~~~~~~~~~
-- 
2.56.1

