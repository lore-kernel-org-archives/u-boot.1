Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA40CF58E8
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 20:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045E883F1F;
	Wed, 19 Nov 2025 21:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="F18py/uO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nMdf9ryR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAD083F26; Wed, 19 Nov 2025 21:37:22 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7659983EF9
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 21:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dBYFC0kSjz9stn;
 Wed, 19 Nov 2025 21:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763584639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=karPhRZDiYPSu7laO+WAt2EQBivUwsEOvWuKADVJ4sU=;
 b=F18py/uOeTwCmDdjKN0/n1NCTUGk/A9XxLqnbTj1pTgi4QhNPryj+v7UTGgN8weqj+Rejr
 xQsfq//6N9yz5AeLNTebziviIlmE2SYjiT7INSCS72VltIO8/HSrOd/Bmfj31/P8aZac51
 IZxAVtWaAu3okyA9LCtz0zqYE+P+FCIV6J/1c8KK4lCkfxyqmV91AokHEmqAcUoJt9zMfS
 8AJ9A9hP4pc9OAcoc1KXUqcKQTySJUq68XJ0qHvXHzqeBvA2bnkIiDI5ewVsHKLUPi5EN/
 BHIczUQYAK0brYNV/VyTkiST6nqime4LrH2Z90pNEJVq/lpeK1jhEuPVLIrLYg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763584637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=karPhRZDiYPSu7laO+WAt2EQBivUwsEOvWuKADVJ4sU=;
 b=nMdf9ryRAkiFnferS4sv0BDVl61bUCwWDGxpv9AY8fqupLuW+X6lI70UedTj63MH2uRVfw
 uXWJ6B+NQux71j/Xm8sgZCMSxV8UFgUTQzWvesV3wdnABcykEM6byoReGnz22fxPoCICyI
 QQj0TX89oMZZmOa1nyoN4SPgLlIGTfiDGsjcZ4/hMaFbuHJiQLMqhY2CNJ6ZNfoQyKVi7h
 tombOaxKzDhvBUZAADCuzN7KePXQKHZNGKhPn0beFw8z7fHekyzQtfpWDId8hof2dMEgq0
 SajjLfhP1ICqhNTQmAyQp4FQskdyjZO2x76cp10WxkvQax9OzKrecmzZJD51Gw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: r8a779g3: Use redundant env on Retronix R-Car
 V4H Sparrow Hawk board
Date: Wed, 19 Nov 2025 21:36:59 +0100
Message-ID: <20251119203714.182403-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ihyoj1wx4asgux1n7uxo8441s8rb6q8x
X-MBO-RS-ID: 22c307fc120922c2035
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

The redundant environment offset is already set in board configuration,
but the redundant environment itself is not explicitly enabled. Make
sure the redundant environment is enabled, as we most certainly do want
to have two copies of the environment.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g3_sparrowhawk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index 2d1abf6f26d..ee8f2711985 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -6,6 +6,7 @@ CONFIG_RCAR_GEN4=y
 CONFIG_ARM_SMCCC=y
 CONFIG_ARMV8_PSCI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_OFFSET=0x3f80000
 CONFIG_ENV_OFFSET_REDUND=0x3fc0000
 CONFIG_ENV_SECT_SIZE=0x40000
-- 
2.51.0

