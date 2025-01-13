Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B54E77188
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 00:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768BB805C5;
	Mon, 13 Jan 2025 01:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kYIq3uow";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wgxPKyNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DBD805C5; Mon, 13 Jan 2025 01:19:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14F680027
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 01:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YWXtl31xJz9sPq;
 Mon, 13 Jan 2025 01:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736727551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A3zoogKQbhHI8EF/xdmT3LY/fiffniDBd8FBucQGRDQ=;
 b=kYIq3uowmrvmYY4dvv40iL83v9X2C6MN4g5020m+vRQj+Xej2vmao2Vibv2M49QfWTkcx4
 14p5kqT/5Bv7QFcXxFrS9QdRPrE0WGvsqVEaq2E9I5ugUdRRW5S4Aj7Nj8rjirVw9QYcIG
 OZE419ylVPsvEFusZ11LJ14XkBwH/BgA2XtunROEiXrRqnwG1KHGpGPnQ81OeseajM5zFL
 3xTQuCuaRVOiYs2Suk+7XEIg4PbHhwXebEI6KJ8SMTPpLeaKRumYPgTDp1DjH28FrD7ETQ
 wtScmzIlXcl3ZLc1p9vxaZ+JGEcPXGbdgBa9wiSg0PECFfcumXpswxv/UEiCmQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736727549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A3zoogKQbhHI8EF/xdmT3LY/fiffniDBd8FBucQGRDQ=;
 b=wgxPKyNWj8HNrBqXlxglqVv17wpXXSr7JzHzPTQ6gw3KvMAwOGhIO2evZFk3d0Bw/s/ky7
 CKRhHtPWCDZll3ArfBxdEGOT+KfoZJGzbSB6wwLeZr0oLh9F5fumTJA/6Y5A7BJW6K4niU
 8usqm9OzhivrI7YE+t3MYKv65fY5HC0r1ieYxDJACoFMIaZDZv7EVys5tP1+mhvRhExS00
 SUswzRFa/X0+GKEbiX3IYU8Ls9UzQsqI4ZrbMlPI2+PdetupbS9ZLYLK38GR6suxvZoqHS
 zQDBmXgKoiG9cPUTeGnl2dGpG8vmsHTCfm+x/N4QyCFqEwvSb6wfgSpIOrfnDQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Mon, 13 Jan 2025 01:17:30 +0100
Message-ID: <20250113001853.296787-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fa8581fbc213abd7dd7
X-MBO-RS-META: kpqdqk8bjotdw797q6ef58msujf49ynz
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

The following changes since commit bc157bb6667ed97e33be8ce8436c28baa275b295:

  Merge tag 'u-boot-rockchip-20250110' of https://source.denx.de/u-boot/custodians/u-boot-rockchip (2025-01-10 18:56:22 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 46a7999160da3167497e08a444417aea26171197:

  arm64: renesas: Convert boards over to is_cortex_a() functions (2025-01-12 23:49:58 +0100)

----------------------------------------------------------------
Marek Vasut (3):
      arm64: Convert core type check macros into inline functions
      arm64: Add MIDR entries for Cortex-A57 and Cortex-A76
      arm64: renesas: Convert boards over to is_cortex_a() functions

 arch/arm/include/asm/armv8/cpu.h        | 32 +++++++++++++++++++++-----------
 board/hoperun/hihope-rzg2/hihope-rzg2.c |  8 ++------
 board/renesas/rcar-common/gen3-common.c | 10 +++-------
 3 files changed, 26 insertions(+), 24 deletions(-)
