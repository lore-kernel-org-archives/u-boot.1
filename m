Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FD5FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1243684083;
	Tue, 17 Mar 2026 02:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cxzyygh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781248407F; Tue, 17 Mar 2026 02:24:28 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF7B8405A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so1997029fac.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710663; x=1774315463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2RbfsA5E6hBJ/TeC/Lu9nrZcsQDQy6nmB0A4+P40RgM=;
 b=cxzyygh1D04hOQ9VVviN79EaLxbNNON3JCfN6haT6V9UrQs5I+6W1EcLr4jx0fQlzC
 zATXp8fy5I60hiNyUYxJDYUibHayKl+jRRs3cNbabdu12i6Gx6z1J8Wg4qJSOrhJ8IIo
 YuJjd/76+y03r1hGtta+LD0uUOqQRH0SCqR1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710663; x=1774315463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2RbfsA5E6hBJ/TeC/Lu9nrZcsQDQy6nmB0A4+P40RgM=;
 b=cOzKWX5Vwfk1qL4Ia68Jgmn7ryLu66y+Tj2EPk+GLD0wLRDNOLWj4kMFb+F2V5BniK
 oc095+21ZVBXFUNLpPzjVC+1Ic4d5LjXDtes4wvt6qtts2m+Ryc/twIv2MFv3VG/Pkeh
 BIOxNqkQNuModjngR9d6qhIPHPjxyZ3lQosHYchAVXa958wJRXz0WlvUNzY7cbk7moJm
 dQbD4yJMiq2IByT3fxdexzFHvn7sqLttmPrHcmKs0ceHaZ8VRZPpkQFOlMTkomn8iTNK
 LfhsMxl9Zbyp8GZsk519c55bd1GfeuuDsF6+im8l5eT1cwhSNVpTIzdP9o1VQ8SaJXkK
 4a3Q==
X-Gm-Message-State: AOJu0YybeyCBi4jhfHOaF+NWMPB30cRjNoRGfxgZI9mBtnf2EcI81UzH
 qWN7IR0HhUYBeriuTTRXwdSeJP34c+A7n/cHGsy/5RtlEb8N/aSYdBagPSF0xDiibdat9pVMBtg
 yeJRyPVE=
X-Gm-Gg: ATEYQzwArkHvW5ai88KJ3XU+777bGEQw1zH3YP5s96lCYbzoxTERI/gQANGeULIkjFt
 pLStXdHJgeqkU7I45R2xXXohFU83QPDwz8EB/0iMvBkQ2L2f9zxNjYHLWMwOM8hSFINqtjiirBM
 JSiE8hXg2dVokNsRf3nKwK5BSziD5xGeApFfNCM0ii2tuydJXMRN+Sv68OeS2BXC5uG3Jt8mQoy
 m/xMmy1dZoA5w4S0k5wsgrh0+RymxG/L7eSEQZYwB06OT/whbdcRFV+JvEKw/8371ttdUK99hk5
 ICemlYa8WY7YtiV+ScuM99lz3DqyyCicjuOVHj+bXEF2xI7Sz3lEyz4aWq0XRW6gFpoePh/3DDK
 LEHCQoj6Bfyr3PWBnKw2lvzG5u8F6xuq0U+z771z3I06SNDaZVHVNDnRVtFcwuZJ4WUINeOss7h
 blHBwCu1EjyfCPwBjG6/whRjn72JaXcOkx3uMxCYtzvBFqu+kczkCHXP2OdSrHGTITUhR6rEsjg
 PtoUElB3w0ep1/FglwJapfmDWV9iMp4ChP9PSAT5jgcEjqB4pk=
X-Received: by 2002:a05:6870:2184:b0:417:4f81:638e with SMTP id
 586e51a60fabf-417b9060a56mr7601625fac.6.1773710663034; 
 Mon, 16 Mar 2026 18:24:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e1fb6efsm19557968fac.3.2026.03.16.18.24.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] xPL FIT: Rework SPL_FIT dependencies
Date: Mon, 16 Mar 2026 19:24:21 -0600
Message-ID: <20260317012421.4162392-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have xPL_FIT select'ing
xPL_OF_CONTROL, and that in turn requires xPL_LIBGENERIC_SUPPORT. The
most reasonable solution here is to have xPL_FIT select
xPL_LIBGENERIC_SUPPORT.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index d81e56e8528c..7849928fc37d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -183,6 +183,7 @@ config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
 	depends on SPL
 	select SPL_HASH
+	select SPL_LIBGENERIC_SUPPORT
 	select SPL_OF_LIBFDT
 
 config SPL_FIT_PRINT
@@ -315,6 +316,7 @@ config TPL_FIT
 	bool "Support Flattened Image Tree within TPL"
 	depends on TPL
 	select TPL_HASH
+	select TPL_LIBGENERIC_SUPPORT
 	select TPL_OF_LIBFDT
 
 config TPL_LOAD_FIT
-- 
2.43.0

