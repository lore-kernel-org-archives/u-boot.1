Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F76E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1AE805FB;
	Mon,  6 Jan 2025 15:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpIDzB/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 391A2805EA; Mon,  6 Jan 2025 15:40:43 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C176F801E8
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f796586so149478735e9.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736174440; x=1736779240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jkAoidKM6UwRmpj1AeNEJ/9ggx9xy85rNcDgr7W3Tm4=;
 b=GpIDzB/fwaytgXAD/Wduvrca4OFSiMPL9nFMDy1E5Weyuzdz5ejp9VUl9A2BZ6XnXD
 /HctIvM8H6G6YxaETWMtqMFmJrbBBi4wLTLKVv0FI7QgUgJGmC5/YSVxwz9/VwZQDITi
 zeBLxVAz1DDS1SnWX4/Dm6Zo+5PKmLFGfbrvP5AkeVAliP2Q4Htrh6v5zEeItBNX+6jt
 lAm9xLZIspiJ6rPhxLIbnJzfFcE33u7JPts3AD86WsCZKy6x1JESHbceewz0Qajk7qLD
 lKuvyqlHR5Sfwt4huPMaaDZQ/wutnMrxEuQfKWYmdnqRKVY5glbfhVNE1O9pR03rrMSB
 agFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174440; x=1736779240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jkAoidKM6UwRmpj1AeNEJ/9ggx9xy85rNcDgr7W3Tm4=;
 b=G2lzX3ohPiqdPpp46ApClvtqt0Cw/o6puYAVVeXrih2lE0fwhAF4rvy7bXJ9rF3PQQ
 J9NxDT4w4SuX+6DF4P2Bk9/An4xspCOKnlD56Q2RXuHC32edHY2nPXVB2FfW740b/Fl/
 R6VtT/IHNy9WyZB6Lk35z2VwU+lCoFv06nTwtMQ695rAnDn8MKhYzWcRn0W5hBipQK9l
 Ap+TCzSd/522p79GX7do8uzbyh5LKhqFlQ1tEe1RhzO/ZU3OE9iVEDbOlEknhFeCWpXv
 ja7Rd57fKgTOCear/Inl4HgK6vsjpwtA7hHqKHODn5BDFSEMFG3f10gBMVhvMo7fPHhL
 /TPw==
X-Gm-Message-State: AOJu0YwmZOW0UpQD9/q2Rb58GHbWkIwavBFkeBzImxHtxFAdl53rkhHy
 HruSKcEkoS7qNZ1/je2TeF7zpsvw/J689vBvnnoI9NygFNj7X2w8ko6HnztHu/vLq7TFUX3XOMt
 vlKY=
X-Gm-Gg: ASbGncvk6uZ3uJjklekCsigeoWip/ywOOndN3ck3zCyWPUM/zomkeWAmSs7t0+ax/Aw
 DB1mHYHz16Ix8ItuBCyASOxIAN+3o4gLTr6pPlAYkgooJ+WiVy+iwFOQhsfw+57DiWojj7SEsSG
 InK9tNI87HSzj+uspSSQoWmpoLUyDpGyG1KJkyESLf3aEsGCqwKxQHr9fH+44q4qaO3AR7ZKcbj
 XsGmEiNok5DlepbSfVzYQxLo/YC4vkrc+/YZL0kRz2YbfGcR/h+ytiDwHv1GG+yTg==
X-Google-Smtp-Source: AGHT+IHUeK8nJKEXr9AsJ01aN5DBPGrD05W5xIntgYdGVsmZzbY8VA4cv+MFmTXvVz1RHGcKqtiguw==
X-Received: by 2002:a05:600c:1c95:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-4366835c1b0mr538849285e9.3.1736174439965; 
 Mon, 06 Jan 2025 06:40:39 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436724169afsm519332585e9.25.2025.01.06.06.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:40:39 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 0/2] Static initcalls
Date: Mon,  6 Jan 2025 15:40:12 +0100
Message-ID: <cover.1736174204.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

This series replaces the dynamic initcalls (with function pointers) with
static calls, and gets rid of initcall_run_list(), init_sequence_f,
init_sequence_f_r and init_sequence_r. This makes the code simpler and the
binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).

Execution time doesn't seem to change noticeably. There is no impact on
the SPL.

Changes in v4:
- Fold all changes to board_init_*() into a single patch
- Use '#if CONFIG_IS_ENABLED(FOO) INITCALL(init_foo) #endif' instead of
'CONFIG_IS_ENABLED(FOO, (INITCALL(init_foo);));' (Caleb C., Simon G.).
As a consequence, drop Michal's patch ("common: board: Simplify array
with function pointers with CONFIG_IS_ENABLED").
- Rebase on next

Changes in v3:
- Use printf() rather than debug() to report initcall failures
(Quentin S.)
- initcall_run_f(): replace one erroneous call to WATCHDOG_INIT() with
WATCHDOG_RESET() (Ilias A.)
- Fix relocate_code() in arch/sh/lib/board.c to address CI failures with
r2dplus (https://lists.denx.de/pipermail/u-boot/2025-January/576213.html)
(Tom R.)
- Add comments to initcall_run_f() and initcall_run_r() (Simon G.)

Changes in v2:
- INTICALL() and INITCALL_EVT() now call hang() immediately on error 
- Fixed typo: s/intcall_run_f_r/initcall_run_f_r/


*** BLURB HERE ***

Jerome Forissier (2):
  common: board: make static calls
  initcall: remove initcall_run_list()

 common/board_f.c   | 218 ++++++++++++++++++++-------------------
 common/board_r.c   | 251 +++++++++++++++++++++++----------------------
 include/initcall.h |  45 ++++----
 lib/Makefile       |   1 -
 lib/initcall.c     | 102 ------------------
 5 files changed, 263 insertions(+), 354 deletions(-)
 delete mode 100644 lib/initcall.c

-- 
2.43.0

