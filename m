Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8862EC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638B884AC8;
	Sun, 19 Jul 2026 20:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="RZhbuVOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A03D84A5D; Sun, 19 Jul 2026 20:04:16 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122BF8494B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664b05d408bso5068318d50.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484253; x=1785089053; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5jS28xxpTquQxiwMOs64s0zNF47bl4pH+0npvEUF6VQ=;
 b=RZhbuVOaGDW85OqmQ9pvm/vjoZsJ8kLG7nTJ+8xIMppe5BiyytQMm6tP3YRIw1+inz
 OzQa3rhcujZiMLOU+mieZrbgTqS2ntyvFuWDoNaPQTwosMnxso2GtGEWg0kpJLC7dUSS
 vt4xm0isRWOKyzjQSpEocONQeqvoq4Ahsx7lIkd6LSJueeLYsCbc6MS22552WRKIY6UT
 +3O1R7nF40yl86EJsN8bfIQconcuVw77VT/fc+rBjxp60zD0o0PSFQnZ7CQuOxmgR5Li
 hBqO3JOS3ICBNvjD6daEneijh3mPPTz0r2C9m3mU2ZQYWcjDjkQJ0RGay/dAwlG+BXEf
 sZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484253; x=1785089053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5jS28xxpTquQxiwMOs64s0zNF47bl4pH+0npvEUF6VQ=;
 b=Yl4/o88RbpLRSx+65s7bTzpQ7risyW/bvi804f+QvX9swmiyQ8zJ0LLPWUqJ0uyjG4
 6HIqiF6yvgi1DklkTPG8E850SgHSZmHxLkQgAzT3aOgaIBo8gP3y/PP/0ZP44P7y+xW0
 BT4PjX/1kYMfEGccn3LTy4zRA02H4g0CY3d3btUNAVrTiJSONDGizFWbmKZnl9M9UlKq
 Z+gZRrNmeC56DhQq/SYkUAysJG65tDdzv0n9qRQga5Hh2Xj0j8OG2uFiStGdr/rzTnWL
 tFaJ06f0tCkQagZTQldZta6ZQoD1bR5LSbVl8mUvyAjLzQqNWyWRqOZrrNE0ibHUCL5D
 FZhw==
X-Gm-Message-State: AOJu0YxxKfl5bbqFXieQz8KC1an6lth4/SuXgV6uVEdIJMPzqS9kCdkz
 KoVg/2Cme0XXI5igN0Pmq6j1oSq4F2KIXHZBxlzOBjoDroNE+GuP79PkzWu1p47zfsk=
X-Gm-Gg: AfdE7cma1jFD1UQuSYllg6H5Orjj9FgJ9SGR/hu0hi0qWWpjTHci3ssd5zuWdociOpn
 0yYfbfULv3cXFrRTbjNUSZrCPsexry0kMa8K/zskHrEYzZLKAGp9JvyCsIyVzmJ1Dz/yS3+1j1d
 cs7FOj6gnLHKiKeCyt8moWnZV5Y0FI7fUXAFgVFYprB3ZZG7T/Xjl64gMSgnpSitdBL3QN6qdoj
 X8DgOxOR7U/DOQol4z1UKBStWmhXR3ygeumShaf5slTDdUNWR2kzDfxHBTk55aKZMUnfAEfsRxd
 9Q+8m2Qba6Kh1MI/5N3hHybLKKJOQ6UHimYGj3b/rf+B69MiwYMij32z7xuYSBzSkfMkCSmtwrP
 V7F76v10+jZOLt3lYi/n8qFvT3no/SjeBJd8JKLQYogjZp5eUjd5I0WVQQuamgAfq351WjgmYp/
 O41Id7+ZX7Y7UF/8zxtILdTVAtGEY2Oz/VZoJTwJqrIX/a5vADhEFUupOlq801mivO
X-Received: by 2002:a53:accb:0:20b0:668:110f:8c10 with SMTP id
 956f58d0204a3-6683bde88e3mr2440485d50.83.1784484252744; 
 Sun, 19 Jul 2026 11:04:12 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:12 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:36 -0500
Subject: [PATCH 5/8] bios_emulator: extend VGA I/O ports to include ports
 0x3B4-0x3DA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-5-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

The IS_VGA_PORT macro currently doesn't cover the 0x3B4, 0x3B5 and 0x3BA
I/O ports. Reads/writes to this currently fall through to LOG_inpb/outb
which are unimplemented on non x86 architectures (which don't support
I/O ports).

Add these ports to the IS_VGA_PORT macro, and implement reads/writes to
these ports. 0x3B4 and 0x3B5 are mirrors of 0x3D4 and 0x3D5 that are
used in monochrome mode (bit 0 of 0x3C2 is not set). Implement these
with the same logic and env state as 0x3D4/0x3D5, but with the bit check
condition for 0x3C2 flipped. 0x3BA is a mirror of 0x3DA, so the
implementation for this falls back to the same logic as 0x3DA.

The Aspeed AST2600's VBIOS uses these I/O ports, and these changes are
needed for it's VBIOS to run.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 1b0c29794e6..7365e86a9e7 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -249,7 +249,7 @@ void X86API BE_wrl(u32 addr, u32 val)
 #define IS_TIMER_PORT(port) (0x40 <= port && port <= 0x43)
 #define IS_CMOS_PORT(port)  (0x70 <= port && port <= 0x71)
 /*#define IS_VGA_PORT(port)   (_BE_env.emulateVGA && 0x3C0 <= port && port <= 0x3DA)*/
-#define IS_VGA_PORT(port)   (0x3C0 <= port && port <= 0x3DA)
+#define IS_VGA_PORT(port)   (0x3B4 <= port && port <= 0x3DA)
 #define IS_PCI_PORT(port)   (0xCF8 <= port && port <= 0xCFF)
 #define IS_SPKR_PORT(port)  (port == 0x61)
 
@@ -270,6 +270,18 @@ static u8 VGA_inpb (const int port)
 
 	debug_io("vga_inb.%04X -> ", (u16) port);
 	switch (port) {
+	/*
+	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
+	 * monochrome mode (i.e bit 0 of 3C2 is not set)
+	 */
+	case 0x3B4:
+		if (!(_BE_env.emu3C2 & 0x1))
+			return _BE_env.emu3D4;
+		break;
+	case 0x3B5:
+		if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
+			return _BE_env.emu3D5[_BE_env.emu3D4];
+		break;
 	case 0x3C0:
 		/* 3C0 has funky characteristics because it can act as either
 		   a data register or index register depending on the state
@@ -321,6 +333,10 @@ static u8 VGA_inpb (const int port)
 		if ((_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
 			return _BE_env.emu3D5[_BE_env.emu3D4];
 		break;
+	/*
+	 * 3BA is a mirror of 3DA
+	 */
+	case 0x3BA:
 	case 0x3DA:
 		_BE_env.flipFlop3C0 = 0;
 		val = _BE_env.emu3DA;
@@ -343,6 +359,18 @@ to use.
 static void VGA_outpb (int port, u8 val)
 {
 	switch (port) {
+	/*
+	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
+	 * monochrome mode (i.e bit 0 of 3C2 is not set)
+	 */
+	case 0x3B4:
+		if (!(_BE_env.emu3C2 & 0x1))
+			_BE_env.emu3D4 = val;
+		break;
+	case 0x3B5:
+		if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
+			_BE_env.emu3D5[_BE_env.emu3D4] = val;
+		break;
 	case 0x3C0:
 		/* 3C0 has funky characteristics because it can act as either
 		   a data register or index register depending on the state

-- 
2.43.0

