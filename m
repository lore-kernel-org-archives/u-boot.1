Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A160E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 23:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F828950E;
	Mon,  9 Dec 2024 00:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n0TPxbU9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W3UmAnTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 289D989500; Mon,  9 Dec 2024 00:54:01 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E64D3893AE
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y61zn3r13z9sTD;
 Mon,  9 Dec 2024 00:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733702037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=780f9+MVaAh91P0w8QpJDvlsPVGM7ZRpIPtWsE2ejYY=;
 b=n0TPxbU9bOnLc6d/SCpGG4nb3rMD0wDoadNZtTUDYJiq2a4Sry04VAJ1yE2q2ZeFjSUHNO
 NEb3h6uBhTibYv5Ps4XgI2vZqTtGbLi4PY66EZUAcjQbrIJqO+/rX8WMFNu3S4NCJIsKLT
 2pDv60d1pYFCaMvNEZZWyEuTv14JYlCHtHRk8KxfzhgU2JhS8uQcwbaHBKc/PXboGmxigo
 gto4S43vu0fELPZq21qCAT/Bis7ZqDOV5kWevKXA6vt/bRySKyEYLcxnGts2Dn9W0BW1Dm
 ey6I1d7gfSb31kWlsbP62rRJ0DghLGrv+EK1KYg88PEIu6wr2LGmw19ye1cmNw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733702035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=780f9+MVaAh91P0w8QpJDvlsPVGM7ZRpIPtWsE2ejYY=;
 b=W3UmAnTPP53ItCSbQTuF3CPVpmMdI/33RfvxngRj0jB2T8LjTjAh3e1DIByIiSTuS1VdG2
 aw5c6o1CwYSHJMnS1cqR0ZaGr78QwJgeT6slHTJShNRbWT/TutPlA3MmyG5ppK4IuNOaCG
 c0irLVrt9Guh7yEebqC3W9WbIt+kN8/A2r3qyGvVNsOfwkwu2jLvPq1xq/aOC35q8l3ao3
 U8TjD5bcrXk8MuB5OMAH6LqmiGnNxltp8GAK4o0v2dkxut6SC8c/V4q2d3IlWUItT90+Ad
 EBRpAUpCUtpPgBmAChjBLc4sMpvGdp9DOanzfzhNBeb1+4HhVQT4kCgIR6Y3Ow==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Mon,  9 Dec 2024 00:53:02 +0100
Message-ID: <20241208235334.208595-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dyhdknn1m7gs7diwq84c3tq8nifstffu
X-MBO-RS-ID: 0d2b6b9b18192100510
X-Rspamd-Queue-Id: 4Y61zn3r13z9sTD
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

The following changes since commit 45f05f681224d88d1b170063001b59edc8fc24cf:

  mbedtls: remove MBEDTLS_HAVE_TIME (2024-12-06 17:47:23 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 455e66bc598935c01621e77709866eb54a6fbd5f:

  arm64: renesas: Disable AVB1 and AVB2 on R8A779G0 V4H White Hawk board (2024-12-08 23:07:34 +0100)

----------------------------------------------------------------
Marek Vasut (1):
      arm64: renesas: Disable AVB1 and AVB2 on R8A779G0 V4H White Hawk board

Paul Barker (5):
      clk: rzg2l: Ignore enable for core clocks
      net: ravb: Simplify max-speed handling in ravb_of_to_plat
      pinctrl: rzg2l: Support 2.5V PVDD for Ethernet interfaces
      pinctrl: rzg2l: Support Ethernet TXC output enable
      pinctrl: rzg2l: Drop unnecessary scope

 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi |  8 +++
 drivers/clk/renesas/rzg2l-cpg.c              |  8 +++
 drivers/net/ravb.c                           |  6 +-
 drivers/pinctrl/renesas/rzg2l-pfc.c          | 83 ++++++++++++++++++++++------
 include/renesas/rzg2l-pfc.h                  |  4 ++
 5 files changed, 86 insertions(+), 23 deletions(-)
