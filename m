Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3013C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 21:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55EE809A4;
	Sat, 15 Feb 2025 22:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kd1Ww0ZJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R0F3B/6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB3080C77; Sat, 15 Feb 2025 22:24:11 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FD080141
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 22:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YwMP44XGJz9tYs;
 Sat, 15 Feb 2025 22:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739654648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ISuZkbW1DLvSBxYV8b3QZsZ0nA/8Tt0+2JUTj5okNM8=;
 b=kd1Ww0ZJzG/REXFpipdU41ev5IXx2gY/zrB4U1fZN8YLaI7tRrWf/oMQkiSRajHInuvIgq
 bwOHDKvhilIDkQ2O6PzOYa29HN92JPth+2gcaXtbHIwCoj8oXPRIY93KDErJQPoLngdm+N
 tDET1vYHzkkD22/IZmSE2u3HUtGuUZYtFg5S3EwnwYrET2bxqDocOzXCIRyNlDFuj8WBkC
 RoYNkKxTXXhurhNtq80wRb4Xlpwh/QMHEnAEPB3FWRy9EDY7ja46MKBrLGylDqzgUIF6vB
 DW4TKlZPk7jiJnq34xD8BmwI6WPBqjE33VTYsj4IPFCBqQ+zgnB5SgpHEcNZdw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739654646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ISuZkbW1DLvSBxYV8b3QZsZ0nA/8Tt0+2JUTj5okNM8=;
 b=R0F3B/6RtUAxfDOdOYM/HmL1kBLMNrSmipBVSBnT+k6Oo9GLITWHbrb8zj4OuWFRfIeckY
 4pSjVowFGZ8wzFdvBLfWl/vyRz6+osVOBBXulBJsTVKaq0qoRia87cR1PuAWHcpxEPXCd5
 bMwTd9bJ30sm//ahWlyzZB/E43VGR/Gs509pZDEpa75EUvGoXNdHr6c5wYnLTqwB5NKQ2V
 1uOAMvizVS+20esBtxesjpkxUn+UmAx/FJAQ7AdhLSBgKq0z0kbRek7LUho1/s4OMOY7c4
 seljwxCwFX7uGQK75IsZ9GDpVUxwzudOCyVODR32MeNvvz3Rp9zvUIN/qCfYew==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sat, 15 Feb 2025 22:18:51 +0100
Message-ID: <20250215212352.101971-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c9459aa7bd2ea53a316
X-MBO-RS-META: ebuiihkcuok8h3ayof4s83ojkz3ctiz5
X-Rspamd-Queue-Id: 4YwMP44XGJz9tYs
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

Add empty weak assembler function armv8_switch_to_el2_prep() which is
jumped to just before U-Boot determines which EL it is running in and
decides which path to take to boot the Linux kernel. Add IH_TYPE_TFA_BL31
into supported images type, to allow implementation of board specific
U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TFA_BL31, ...) TFA BL31 loadable
handler for fitImages.

This PR contains common hooks which are noop, R-Car Gen4 board specific
implementation using these hooks is coming in next PR.

The following changes since commit 89d33336d2645128dd217ac05410cfbfa2f74233:

  Merge branch 'misc' of https://source.denx.de/u-boot/custodians/u-boot-tegra (2025-02-13 12:37:26 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 854a5a00cadd6ea4adcc9e4a923124887989f5f8:

  image: Add support for starting TFA BL31 as fitImage loadables (2025-02-15 14:44:43 +0100)

----------------------------------------------------------------
Marek Vasut (2):
      arm64: Add late jump to kernel board hook
      image: Add support for starting TFA BL31 as fitImage loadables

 arch/arm/cpu/armv8/transition.S |  8 ++++++++
 arch/arm/include/asm/system.h   | 16 ++++++++++++++++
 boot/image-fit.c                |  1 +
 boot/image.c                    |  1 +
 include/image.h                 |  1 +
 5 files changed, 27 insertions(+)
