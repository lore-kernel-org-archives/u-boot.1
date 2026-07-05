Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28156C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 10:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F5784987;
	Sun,  5 Jul 2026 12:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b47gR+KT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DC784881; Sun,  5 Jul 2026 12:42:56 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3B4846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso798694a34.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783248172; x=1783852972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5lBqtE8Tsapd+GXpEuBUuw35eFm22gpPuspJfWOQ1Ds=;
 b=b47gR+KT6zhg/LFcp7IREM2rQhYJtEi4qxCGTst7/pFM5ZkkDuPydnzFeqahOZIICQ
 ni81luD4dnetUIvLUzk5SJDyix/0Xyc1qhhiV1dhlpMskwCPXCNUDC7Ub6iWMaYOH4Hf
 xMB0FM/ShJlla/lsiVQvOu9X+U9tQCEjWhGD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783248172; x=1783852972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5lBqtE8Tsapd+GXpEuBUuw35eFm22gpPuspJfWOQ1Ds=;
 b=GT7wFIALhzf2aD7xKmGXtdxN3qrXjTdOvoYEoz7tP56/KKC+H+IiyerXk0uaWLqCiQ
 2DE3D8Y5wNhvm1EzMIvFBXLzY9gjRs1VX7/i9hA09B+ymqzESIldr6otSwFEii7OJf9X
 3m9VO3aA5TJXRqvl9QYxIGmhEOgifrYOg/4Mb8LNl3IChzuz/XWzXOiwNpZNEla2BGFs
 O65N9p/iSjUmzPUomldeN3iTWOirBiwh5IFZvzfiz2uAOtbxTTMGnecEoWARHkPx765H
 O1s9IFxJ+f7exvuyZIRopVRITbyIZ0zLxbcB5b6magpD7vDIZ8TXv7JPQSXiTk0nFaBr
 s4tw==
X-Gm-Message-State: AOJu0Yz53kTs3CBjeiMjOhpvJdEl3iCwifcSinsIvHWrYg+FVIMko6xA
 sCK7ECrDZ8ExWTXAJqmWWj33Dp7F1tUIc/tI7LOrzwbuT33CtvO38r+JPWmIOWWV9GY5+RvcO7Q
 fZfL1iQ==
X-Gm-Gg: AfdE7cmk5iGeGomPBEat4qlZSjykoNwCfNqiRD23nAIhHlyPQhNcoNaGCU2i2GHfn1F
 v1TspOV1nn/0Nyf4g4TmL1hRVUHivvZVOxuuZ4QEDZXTyEGPA30hxkR3y2DFg92VVn9eaPldT8O
 LsFL99dteXs3Qx0HHQozQ/mLIckAjvFE7e4d1GsjZmCGy6OBK5hnU1wYTGQ3r0BSMopgR1X7vPO
 oWUtn6qcwp8Khgz9fg06bqUOIDacCFC1opTeaplX87b0olOBN7AA9bqHyYOdFysasnrFXERN6+S
 vvQl8XMaYQisHbUisSUlxAUZvD9W8dti+iF7kmHz8gqhacvUNGYph3QTna98bE33pHvUcfg5YTj
 jK5yuC3bHsf4iAn2SKlPYCc5/JEwe+q5Dwm46w0ha/8CtWQ3BATr5s1hw5N6R/Z5ctTvMZez99q
 7uIv2M4o7I5nYxI+6rKw==
X-Received: by 2002:a05:6830:6685:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7eb7feeb735mr4502389a34.16.1783248172078; 
 Sun, 05 Jul 2026 03:42:52 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm9136961a34.3.2026.07.05.03.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 03:42:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/5] x86: edison: Move U-Boot alignment into binman
Date: Sun,  5 Jul 2026 04:42:14 -0600
Message-ID: <20260705104231.3846672-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705104231.3846672-1-sjg@chromium.org>
References: <20260705104231.3846672-1-sjg@chromium.org>
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

The mask ROM loads the OS image to 0x01100000 but enters it at
0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
is arranged by board/intel/edison/config.mk, which prepends 4096 zero
bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
recipe moves its output back over u-boot.bin.

Since the Edison image is assembled by binman, provide the gap there
instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
Wrap the fill and U-Boot in a section that is also written out as
u-boot-edison-dfu.bin, the [gap + U-Boot] payload to flash into the
u-boot0 partition over DFU, so that no longer needs a manual prepend.
Drop the now-redundant alignment hack from the board config.mk.

The stock v2014.04 DFU also needs the whole payload to be a multiple of
4KB, so round U-Boot's size up to a full block. With the 4KB gap ahead
of it, that makes u-boot-edison-dfu.bin 4KB-aligned as a whole. The tail
is padded with zeroes, matching what the old 'truncate -s %4096' step
produced.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Round U-Boot's size up to a 4KB boundary

Changes in v2:
- Reframe as a binman conversion (the boot fix is now a precursor) and
  drop the duplicate 'Fixes' tag
- Wrap the gap and U-Boot in a section emitted as u-boot-edison-dfu.bin,
  the ready-to-flash DFU payload

 arch/x86/dts/edison.dts      | 28 ++++++++++++++++++++++++++--
 board/intel/edison/config.mk | 10 ----------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/x86/dts/edison.dts b/arch/x86/dts/edison.dts
index 8fdacfb0fd8..c8c8426b0ae 100644
--- a/arch/x86/dts/edison.dts
+++ b/arch/x86/dts/edison.dts
@@ -177,8 +177,32 @@
 			intel,load-address = <(CONFIG_TEXT_BASE - 0x1000)>;
 		};
 
-		u-boot {
-			offset = <0x200>;
+		/*
+		 * The OSII loads the image to (CONFIG_TEXT_BASE - 0x1000) but
+		 * enters it at CONFIG_TEXT_BASE, so U-Boot must sit 0x1000
+		 * (4KB) into the loaded data. Pad with zeroes ahead of U-Boot
+		 * to provide that gap, and emit the [gap + U-Boot] payload as
+		 * its own file (u-boot-edison-dfu.bin) for flashing into the
+		 * u-boot0 partition over DFU.
+		 */
+		u-boot-dfu {
+			type = "section";
+			filename = "u-boot-edison-dfu.bin";
+
+			fill {
+				size = <0x1000>;
+				fill-byte = [00];
+			};
+
+			/*
+			 * The stock v2014.04 DFU needs the whole payload to be
+			 * a multiple of 4KB. With the 4KB gap above, rounding
+			 * U-Boot's size up to a full block (the tail is padded
+			 * with zeroes) makes the emitted file 4KB-aligned too.
+			 */
+			u-boot {
+				align-size = <0x1000>;
+			};
 		};
 
 		u-boot-env {
diff --git a/board/intel/edison/config.mk b/board/intel/edison/config.mk
index fff187caa15..da7c9acf1a2 100644
--- a/board/intel/edison/config.mk
+++ b/board/intel/edison/config.mk
@@ -4,14 +4,4 @@
 # Copyright (c) 2017 Intel Corporation
 #
 
-# Add 4096 bytes of zeroes to u-boot.bin
-quiet_cmd_mkalign_eds = EDSALGN $@
-cmd_mkalign_eds =							\
-	dd if=$< of=$@ bs=4k seek=1 2>/dev/null &&			\
-	mv $@ $<
-
-INPUTS-y += u-boot-align.bin
-u-boot-align.bin: u-boot.bin FORCE
-	$(call if_changed,mkalign_eds)
-
 HOSTCFLAGS_include/autoconf.mk.dep = -Wno-variadic-macros
-- 
2.43.0

