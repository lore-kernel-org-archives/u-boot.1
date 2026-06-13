Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C9CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5810584878;
	Sat, 13 Jun 2026 15:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfKhDW9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E59984874; Sat, 13 Jun 2026 15:06:28 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B838485F
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 15:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69e1eba21a6so1577911eaf.3
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781355985; x=1781960785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IggMT19qMBfMWrvMBOcCCL5Bk3C+cEFmxCoxtVrKiE=;
 b=hfKhDW9Qrl+Kd2XFp2rZhbUM20d3T+gII4b8FU5CRYuKEzT6GtNutcOTVGaZJUmhXP
 pRW23BHQMBQXGrn1zNLenmrdcqsLoPeiKICieSjgkdsWnyCrDs5fNgseup/3V4qKViDn
 YhKBHNrIRXRsPy4o14IG6SNSv4pL9w9+Ty8ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781355985; x=1781960785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3IggMT19qMBfMWrvMBOcCCL5Bk3C+cEFmxCoxtVrKiE=;
 b=FNWLPlT3KMLpQ/X1WPfCJO6BLHOjIHfj68VRn4INy2nNo4f6FSmEw37jCc+bz9KFJ7
 bigrE39AmYS2DZWEazNMstqkL34fVr5ZjZkA4FIgBliAh35EDqd+NpcS6bRoClLCjkbK
 5oJASLt7d+F5GPA6OI6nk/7Ixogn6fZangk7CbNDRDQekWV2GZILS3jFvgLwVEEXJoHu
 abJZ1GfBfnJu7o0osxDUf+52S8UY70/V1cvkOGr0Ypsxq23ERsyJrg8GwV+I4/eWnFbQ
 YdFaIO5tsjyT6GyqXIoQdMBe4J4n+si8xqayVJSJCzWyEC2YHKdTOsu4xE1+VazeujEL
 1BPg==
X-Gm-Message-State: AOJu0Yw7m7d26GaaNnQGzCgxT7m1DX3tA1NPUAs0+DXxBtl2vYoZAb0i
 fvE0661NDTN0VQB3BwTHOmBgaom5ou4wnbvzeN6704V+EuxO7UtqoHw7CSBVjZgjQKtqDKBc9ji
 QyGz7kw==
X-Gm-Gg: Acq92OFx3qfiAfjr0Nox/hjQs6W9A8IuMYkW+M9NQfF6z7+fQwtL5/V78hwC76BXvlG
 rC+upp6/VWMRm7W5Im2ckYvQD4fPDPvp7S8jOwh1WMzxXXSb2vLsvzQkrbiUGF5etmjDgc8bF8e
 Q7KwhVbVwTkyXBMEX+EJNTFeAtMNO1Yk3GQ1htUZ+WBmHqNtxbULIvaQqviaz7zw6aI8cThtymS
 U9H60jBmNVESgM4YhOfSXtbgFlGAiJo0Y6ILvzesJjdyiAsQMulXBabEZ6jWkMdhym/KbayPukv
 nqswoSM7NKB/4VyxQFZ4JNtGJLCiPSuDQwJ3L0wuyH7wFpWEWRBByoXovlhUZ1fTGC18nvCcv3S
 X9bq5f9YI3aO5wYtv0G/ZL2HO3ELu29GPxFi5gQgXP20b1egnX2/HvD8XV8xMH2rbIvpsKq6A//
 knsbG4FK4NzA0plz0HLQ==
X-Received: by 2002:a05:6820:2014:b0:696:1e45:9011 with SMTP id
 006d021491bc7-69edc6f3f3dmr4085947eaf.28.1781355984728; 
 Sat, 13 Jun 2026 06:06:24 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426b32624csm4459564fac.16.2026.06.13.06.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 06:06:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] x86: edison: Avoid passing FORCE to the align command
Date: Sat, 13 Jun 2026 07:05:12 -0600
Message-ID: <20260613130519.1516808-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130519.1516808-1-sjg@chromium.org>
References: <20260613130519.1516808-1-sjg@chromium.org>
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

Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") adds FORCE
as a prerequisite to the u-boot-align.bin rule, but cmd_mkalign_eds
expands $^, so FORCE leaks in as a stray operand. The dd then fails
(silently, since its stderr is discarded) and the following mv never
runs, so u-boot.bin never gains its 4096-byte zero prefix. The mask ROM
enters U-Boot 0x1000 (4KB) into the image and the board never starts,
sitting in BootROM download mode (DnX).

Use $< instead of $^, which excludes FORCE and restores the prefix.

Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/intel/edison/config.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/intel/edison/config.mk b/board/intel/edison/config.mk
index 3afebf0f0b1..fff187caa15 100644
--- a/board/intel/edison/config.mk
+++ b/board/intel/edison/config.mk
@@ -7,8 +7,8 @@
 # Add 4096 bytes of zeroes to u-boot.bin
 quiet_cmd_mkalign_eds = EDSALGN $@
 cmd_mkalign_eds =							\
-	dd if=$^ of=$@ bs=4k seek=1 2>/dev/null &&			\
-	mv $@ $^
+	dd if=$< of=$@ bs=4k seek=1 2>/dev/null &&			\
+	mv $@ $<
 
 INPUTS-y += u-boot-align.bin
 u-boot-align.bin: u-boot.bin FORCE
-- 
2.43.0

