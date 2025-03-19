Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F25C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 23:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34C2809D4;
	Thu, 20 Mar 2025 00:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FQG0RCab";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mJtKgttj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E12480FF0; Thu, 20 Mar 2025 00:49:49 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B818083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 00:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZJ56L27pkz9skp;
 Thu, 20 Mar 2025 00:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742428186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sSE6VMDnvP1kcTxHhET8IH3VlBCSfvhBQ7pa7/4BcuI=;
 b=FQG0RCabLJzQ1DTnHeB4nc/AVoI5tfby4zX1orgu/QDDugGq1CXRf/VBgvzU0yUE17H0Zf
 9+PvSjxwsH6itrS8fKrKVLRfB80I5nZzkPl2xgjtwPuA0FVmTDma3rnS9shR7kdKHQpyci
 eo8UL6cC6pigKk/bsl8Zpll2h1iQT9RdHbMFaS6InN2zwHWJcvB7pkfZMeEiTYDwqGbV7r
 O1Qs2E+8Vn2bCcy9SVMVLJ0lxmgGQRrjjAIdTf38n14XfsmdJBDF8TZnrv4dxFLH8aABVI
 5iCvvKOGDOb4UD/TPxtUxhDq176WryOkdKPY4avxVksjBmc+LG+7DR4HG+5UuQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742428184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sSE6VMDnvP1kcTxHhET8IH3VlBCSfvhBQ7pa7/4BcuI=;
 b=mJtKgttj72konEaaMdpubAinXq6qWfwTrRce5k25fxEP6ccrZV1iEXyLVrV6Kmn7x2i0Se
 fmmjJkt5CoBeAXnzTsidtKxDQGc3MZOXHyAud4wbldYvWj5Jd5xm1Hw2psNqlAG7MNg348
 KW6t4arnmLMfCVkj1c0pg1Rc3BMgLCf6xOUG89E3UyGWxfL4XFWAtYQAN6oJMFhFAyqGDV
 v1XWfjt2sQ4Z263xrnGlKjHpWpPsxggDzOsTu1QXFj7/dWV1+W1Loka7Qs9NLiFW9Vn1Tp
 IYCZ3V3BUKY5v32ySSaAa2xixI77X7tbzFEUXyI1bjuaX4CSR7BszV/5x6mwUg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/next
Date: Thu, 20 Mar 2025 00:48:00 +0100
Message-ID: <20250319234923.264256-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b012193ec1b6d24a547
X-MBO-RS-META: 1m117e4f8i7jh9r1ojpm61k11wdco3c8
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

Renesas RZ/G2L USB support, remaining RAVB ethernet fix and
KSZ9031 LED errata fix for next.

The following changes since commit 8bc3542384e3a1219e5ffb62b79d16dddc1b1fb9:

  Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE" (2025-03-18 13:12:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to 95d10669c0bd7c7211d7fcdffc5993b16898124b:

  net: phy: ksz90x1: Simplify ksz9131_config_rgmii_delay (2025-03-19 03:38:51 +0100)

----------------------------------------------------------------
Paul Barker (10):
      reset: rzg2l-usbphy-ctrl: Add new driver
      regulator: rzg2l-usbphy: Add new driver
      reset: rzg2l-usbphy-ctrl: Connect up vbus regulator
      phy: rcar: Support RZ/G2L USB PHY
      renesas_rzg2l_smarc_defconfig: Enable USB support
      net: ravb: Fix error handling in ravb_probe
      net: phy: Port set/clear bits from Linux
      net: phy: ksz90x1: Handle ksz9131 LED errata
      net: phy: ksz90x1: Load skew values from device tree
      net: phy: ksz90x1: Simplify ksz9131_config_rgmii_delay

 configs/renesas_rzg2l_smarc_defconfig            |   8 ++
 drivers/net/phy/micrel_ksz90x1.c                 | 169 ++++++++++++++++++++---
 drivers/net/ravb.c                               |  14 +-
 drivers/phy/Kconfig                              |   4 +-
 drivers/phy/phy-rcar-gen3.c                      |  79 +++++++++--
 drivers/power/regulator/Kconfig                  |   8 ++
 drivers/power/regulator/Makefile                 |   1 +
 drivers/power/regulator/rzg2l-usbphy-regulator.c |  42 ++++++
 drivers/reset/Kconfig                            |  10 ++
 drivers/reset/Makefile                           |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c          | 142 +++++++++++++++++++
 include/phy.h                                    |  24 ++++
 include/renesas/rzg2l-usbphy.h                   |  17 +++
 13 files changed, 481 insertions(+), 38 deletions(-)
 create mode 100644 drivers/power/regulator/rzg2l-usbphy-regulator.c
 create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c
 create mode 100644 include/renesas/rzg2l-usbphy.h
