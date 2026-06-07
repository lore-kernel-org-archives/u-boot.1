Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCB1CD8C90
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC2284841;
	Mon,  8 Jun 2026 01:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YF9ez3UG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13DD83314; Mon,  8 Jun 2026 01:05:39 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F4B847C6
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43bf95c3f6fso3719362fac.0
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780873536; x=1781478336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPPQt/k1agJnQ+HdUUAxvyQvNJmzdWpPzSunYS/A2yM=;
 b=YF9ez3UGEPdaEadtFYMHdPShUS2yo5OE3Ny/DsA1v+4B8cWeGYNddeQ5HQb0arfgcm
 DLU68oBkpWB5wpdenn9d4Ecs9AfHisyzK4cr1iTcpADc8l388QSAmuTo6dp3VmYIh8ME
 TIz/2ulyjZaqGFyHua+suADcfpbVE6d3xb5Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780873536; x=1781478336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FPPQt/k1agJnQ+HdUUAxvyQvNJmzdWpPzSunYS/A2yM=;
 b=ikPMmIsSG8nKQkALVzOE67wdahoJunoeXiE3wR/qJZwXgQ2fTWA73neoVBjZ9/A02Q
 oNPMBs8vpXfHVFwAYDBNSCHS4SJwvRTXcxt/y/oTo2aIHyNSy+qpJJzYQ5tzMIJemQ5R
 E6CLqeNWGZWwz5tezl4czBmkpAhBf9DerZUYRQo0jVsOLp1U5MXESUynHlnYZm9WQYDN
 BdmvnWZtTa5lC83xppL1sXeN7MKb6hi+2zIGonLWKYkjvTF+0Q1LmMby3d6GO3+N/iF6
 WY8c0tfNI60KWRKgTaK3mUt0cmzXymJsOZaft1LU5rLjeUQ9Kj9lCLUd6ONGWg/77+jj
 kBCQ==
X-Gm-Message-State: AOJu0YwKy8T2tfrW1yf0yzMnoC3APuxU2k1aJgz1vJFY9VoSm2+5zT95
 9jnAnyiT2B6sn0f0a98BKCjdBtWApaBS3L4wpfjZRtKET7TdB3/JDkZMR/nc9VwmzGFcNQERv7O
 ZEQQGdQ==
X-Gm-Gg: Acq92OFeXBhWRtTDtdvFPf3Cxoo7j6rqAvSBY46CItLChOvynUwaBSs/GgF2+Hs9Q5J
 OCHwaiRmMVgOj7A0TRXBUmN3uV/5N+l2TkJt05mZrUDZJ/13DCn6S3DAHSieYe/6eawKbQ5Toen
 sfTiT8htZtG6/82kBjRKLE3WHB6R9yH7B7qdMkhUyFyMo+SqgIk5Hw7ZbRleetLC2MrmdTgfQlm
 HMIqxW6SN96v9JvI9ivUxx32AC0aiw6ntxBSj8DGsaaHAQACF+qRWc+QmFzGiJrug016pxSFdWc
 okAtXF8ypzbjk0QHqZ/2d8A8fJLhfyjldR5R6zAFVrMyR3awtln1YlHgjQ9OTBX7p9WGAB3Iuhw
 VS7r5fTBj5Rm3F3pCxbRbBap6fLSoKC8kfhXNOgPkqFlGX5oCpAzbZOV1ajVJkW/PW8aB/At2xG
 lde62ltKqTAQhIp5acynbxJrEaO7pO
X-Received: by 2002:a05:6870:414f:b0:43b:516f:5f0e with SMTP id
 586e51a60fabf-44145c2a18cmr4409620fac.9.1780873536327; 
 Sun, 07 Jun 2026 16:05:36 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm13916389fac.8.2026.06.07.16.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:05:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
Date: Sun,  7 Jun 2026 17:05:12 -0600
Message-ID: <20260607230519.3022520-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607230519.3022520-1-sjg@chromium.org>
References: <20260607230519.3022520-1-sjg@chromium.org>
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
was arranged by board/intel/edison/config.mk, which prepended 4096 zero
bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
recipe moved its output back over u-boot.bin.

Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
that rule from running, so u-boot.bin no longer gains the 4KB prefix.
The mask ROM then jumps 4KB into U-Boot's code and the board never
starts, sitting in BootROM download mode (DnX) and cycling.

Since the Edison image is assembled by binman, provide the gap there
instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
Drop the now-redundant alignment hack from the board config.mk.

Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/dts/edison.dts      | 11 ++++++++++-
 board/intel/edison/config.mk | 10 ----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/dts/edison.dts b/arch/x86/dts/edison.dts
index 9c7630161e9..05391d49d02 100644
--- a/arch/x86/dts/edison.dts
+++ b/arch/x86/dts/edison.dts
@@ -175,8 +175,17 @@
 		intel-osip {
 		};
 
+		/*
+		 * The OSII loads the image to 0x01100000 but enters it at
+		 * 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded
+		 * data. Pad with zeroes ahead of U-Boot to provide that gap.
+		 */
+		fill {
+			size = <0x1000>;
+			fill-byte = [00];
+		};
+
 		u-boot {
-			offset = <0x200>;
 		};
 
 		u-boot-env {
diff --git a/board/intel/edison/config.mk b/board/intel/edison/config.mk
index 3afebf0f0b1..da7c9acf1a2 100644
--- a/board/intel/edison/config.mk
+++ b/board/intel/edison/config.mk
@@ -4,14 +4,4 @@
 # Copyright (c) 2017 Intel Corporation
 #
 
-# Add 4096 bytes of zeroes to u-boot.bin
-quiet_cmd_mkalign_eds = EDSALGN $@
-cmd_mkalign_eds =							\
-	dd if=$^ of=$@ bs=4k seek=1 2>/dev/null &&			\
-	mv $@ $^
-
-INPUTS-y += u-boot-align.bin
-u-boot-align.bin: u-boot.bin FORCE
-	$(call if_changed,mkalign_eds)
-
 HOSTCFLAGS_include/autoconf.mk.dep = -Wno-variadic-macros
-- 
2.43.0

