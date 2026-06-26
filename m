Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A99CDE00B
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 01:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7E284974;
	Fri, 26 Jun 2026 03:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dgt7CGkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548468498B; Fri, 26 Jun 2026 03:09:35 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1188496E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4877a7b451dso358428b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436172; x=1783040972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E0nVkJmhP+/HuVwWlf+FpaH6RCmHeXxm6m0JNGqCLi8=;
 b=dgt7CGkbuMarDMBzJCvIGt1zJBZuu+ZYg+Cf+N9PNV8HC2EW76t+Z769nTSzYfVGQT
 GkCqeiLRJbeeRYE4TFtf7SSYbD1Q1JP0/eQluse9i9NfL4ReNt7zUgkAa4loZGSfAY31
 ktNm/yOQTrsZIhjL70RMcxB+Z3al7gLnes7XLseHwepleBqEJMG0zRio1dS05m6tDLgn
 x5HwHhYeDu/DU/l7HvAvEEW/Q3Fo5NgmRJO/+VlrUrCKN0/CdaoWBp3Q96dpwWb+QiOU
 25mMnakJRMo9XE5l+OaNqR5Nnuhrp33NrLJxP/LzSsMXRfjxT9MSksGURFxAOMPOusQi
 tHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436172; x=1783040972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0nVkJmhP+/HuVwWlf+FpaH6RCmHeXxm6m0JNGqCLi8=;
 b=sAljDQVniwEensywQa4qieYVgr2b1RRPib/lCIWQ+v5990ZAK9R7t58PGvgDAEfXnd
 b4yicnu9TKzkCi9CTjfFMFB63AO6rxFSEI0196lunfX8F2sxvSuj2lNvBNnqmyskVg+b
 PDh/I144UJNvzTLz2pe8Sh+91/YLwFcujK8wJkvysXgw0+EBZbvUbIPMbuBhaTATQUc3
 MmxoyqtxvEjiAlZtS6mn1zKJNGnkv16uiMhDYSrfRmBOejB6ReHg0u2pqdNyrkFsaxXC
 k3zizJVdljhFTQIYoIJcHzJ3/PNMt1Hse2LcDtYPBSbZP8lcJBYc++CV/7b+qkDcUeQB
 UcRw==
X-Gm-Message-State: AOJu0YyhotY/8p6EMzFNfsnN1YUTCJhPfqwmTZckUpJBq6/36akOmWny
 6h/zdQNTrQXpQ0Y5HsiBNL+q3RZWKzS8rrN7w5081BPhi2Yau2+e557qciySLFrrBV4=
X-Gm-Gg: AfdE7cnOyeAkw1jFjdVcgPnCzhCsZ4R6r/P7FCihsKdce+vCVyh/CWb4rxRS07Ktz6C
 AtEQQ7v22POYzd3P0slv0PjIfodSHCG86Oum3r3wgyQ0qsceOjpdkkfbo7/AwKBOv8+jb2iYBcP
 PXy6kUPqJR8onBaJOdO5Jm7ZnN5RvfFs/1LDLm/6sv5ruYYjhUcB6uI916sOYIqx2/bm64/9vAQ
 ER61liN1kzcW3u73FT9L1VE4tMEDXvpD8iDVK4fmrixbPwYdIiDC/2EAtDj0XMVDdxbMrbNzQrm
 HN0JSRYcAARn6L4+MyAf0ACY61+v8hSsEKIQ80OJ6XipUsRI65vEB+7oRbRGsYq0/qTqBvReCkt
 b8aZz5Fd5hwheNAhEOumwpVApanM0mbsBshg1STT0dbe1XkJk2PxariUrenpKJJkJbC9X4/aT+t
 5S6PchyHuZ+LqQuHUyrA8tjey9R7Q/jHPM0l7w8klAGF7/y+ORVpBJqTSSH/vAZeokna8LdgYZ7
 pah54OScz7sBnYUlO0IhFmVzDPR0T1EKKIVCNg7Efp770+ZxBqRGqd/6sow0ay5hyubZS5fuLII
 UxAy65Wr+5ctTSk=
X-Received: by 2002:a05:6809:210:20b0:492:3ad9:326d with SMTP id
 5614622812f47-4923ad93c97mr2808023b6e.22.1782436171871; 
 Thu, 25 Jun 2026 18:09:31 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ec6065esm14310532fac.4.2026.06.25.18.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 18:09:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH] sunxi: spl: call spl_early_init() from board_init_f()
Date: Thu, 25 Jun 2026 19:09:23 -0600
Message-ID: <20260626010925.1812691-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sunxi calls spl_init() from board_init_f(), before the optional SPL
stack relocation has happened. This is too early for the full SPL init
path when SPL_STACK_R and SPL_SYS_MALLOC_SIMPLE are enabled, since
spl_init() assumes the relocated malloc area is already available in that
case.

Use spl_early_init() instead, matching the SPL helper intended for
board_init_f(). The SPL core still calls spl_init() later from
board_init_r() if full SPL init has not already completed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm/mach-sunxi/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 378d4706c82..9522fd3e43f 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -500,7 +500,7 @@ void board_init_f(ulong dummy)
 	clock_init();
 	gpio_init();
 
-	spl_init();
+	spl_early_init();
 	preloader_console_init();
 
 #if CONFIG_IS_ENABLED(I2C) && CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-- 
2.53.0

