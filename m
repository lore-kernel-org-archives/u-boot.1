Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FDBC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 19:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AC880FB9;
	Wed, 26 Feb 2025 20:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uW7Yw6iS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BsI0TceZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1911180FDE; Wed, 26 Feb 2025 20:35:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADFD80FB6
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 20:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z34Sh28Lmz9scM;
 Wed, 26 Feb 2025 20:35:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740598532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SSc3U37hKIpOCIZYm+rW5I2CinTzITnoE5nzU5sd1Tc=;
 b=uW7Yw6iSyxwDyuQQlJCmB5xjAIHYqW2xfaFarunQPDq/oRly8rV5dNdKPs6J1ZpKtlkL1e
 pRnj9aOEI6y16Kcp0SOBoKtZa9R5/R6PR32IH9yIQ2p9bLPlLBXsGINZFaxwcLbuKXUCVa
 MSA8cnFeSRAhv6hKkLghWAdX6y5nWRVb5VF0IHELx1iH68Bv/zNoCK1sKkrk9f640DvjKp
 f5m0UzBgPDLKvEiRPUPcV0TaC5xLPZv7Bp0Vfn8fMCgjAqShpn+Ki1SC7l26+n5j0fOmpS
 GsvJ83BFKYaDe5IGCaRjuTgoaEMHjbPbGhU+4Vwb2XT3rDGgZEMRxoJ43gw5yQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740598530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SSc3U37hKIpOCIZYm+rW5I2CinTzITnoE5nzU5sd1Tc=;
 b=BsI0TceZyyo5cX9fbDE5yCc5I060SBIj4U0JkMP+tH2fg81aY4KuGSIkuSIL8ISw1OTR6+
 Qb7mLdFbE0uTUaZlN1mw6dIINjKlTR2zhn6/8nBVxhajVyk3bouDgY0vzDupl6lwh2nl7r
 mgGS287b8xUsYOMwfEiBBewN+MsgrYPTuDs0493c8JQrQ1Tzz6e+8pVBMzWUEle1++64zx
 rqTSTnz8qn2X54KFVtK3W0s8wK1ru6EiYsQifLBSh4Q4kMfE1i/WgRTd/tvLm9ZVZK8Yvc
 E3o6nydJx5oup4SZiYIllMeaDGXFNxXEuOyHWiNr2tLxhLT7JGgwS3EeawzHoA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next
Date: Wed, 26 Feb 2025 20:33:58 +0100
Message-ID: <20250226193518.65593-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ezstz3xj7xmjmzwiyp84fziiz6c64kgp
X-MBO-RS-ID: 85e2974831b1f115f5a
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

bbmiiphy clean up and DM alignment, finally gets rid of the static bbmiiphy
variables and plugs bbmiiphy into MDIO framework.

The following changes since commit 8dd7186ca7821446c6f46b6cccefab502912f2e0:

  Merge patch series "Remove "saveenv" functionality from am57xx evms" (2025-02-25 11:11:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to 4e6fed49becc7e8d9639966fd34695583192a3ee:

  net: miiphybb: Drop bb_miiphy_buses and bb_miiphy_buses_num (2025-02-26 18:26:57 +0100)

----------------------------------------------------------------
Marek Vasut (23):
      net: ravb: Drop empty init callback
      net: sh_eth: Drop empty init callback
      net: designware: Drop NULL priv assignment
      net: ravb: Reorder bb_miiphy functions
      net: sh_eth: Reorder bb_miiphy functions
      arm: mvebu: a38x: Reorder bb_miiphy functions
      net: designware: Reorder bb_miiphy functions
      arm: mvebu: a38x: Call bb_miiphy init directly in driver probe
      net: miiphybb: Drop bb_miiphy_init() and .init callback
      net: designware: Drop bus index
      net: designware: Extract bbmiiphy initialization into dedicated function
      net: miiphy: Introduce mdio_init()
      net: miiphybb: Introduce bb_miiphy_alloc()/bb_miiphy_free() wrappers
      arm: mvebu: a38x: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
      net: ravb: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
      net: sh_eth: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
      net: designware: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
      net: miiphybb: Use container_of() in bb_miiphy_getbus()
      net: miiphybb: Drop name field from struct bb_miiphy_bus
      arm: mvebu: a38x: Drop use of miiphy_get_dev_by_name()
      net: ravb: Drop use of miiphy_get_dev_by_name()
      net: sh_eth: Drop use of miiphy_get_dev_by_name()
      net: miiphybb: Drop bb_miiphy_buses and bb_miiphy_buses_num

 board/gdsys/a38x/ihs_phys.c | 237 ++++++++++++++++++---------------------
 common/board_r.c            |   3 -
 common/miiphyutil.c         |  13 ++-
 drivers/net/designware.c    | 263 ++++++++++++++++++++++++--------------------
 drivers/net/phy/miiphybb.c  |  36 +++---
 drivers/net/ravb.c          | 159 +++++++++++++-------------
 drivers/net/sh_eth.c        | 179 ++++++++++++++----------------
 include/miiphy.h            |  17 +--
 8 files changed, 438 insertions(+), 469 deletions(-)
