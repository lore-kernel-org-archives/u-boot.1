Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D90FC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 00:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B5008467B;
	Sun, 12 Jul 2026 02:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D6A849D2; Sun, 12 Jul 2026 02:33:28 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F84844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 02:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wii84-000000006YK-3zlP; Sun, 12 Jul 2026 00:33:09 +0000
Date: Sun, 12 Jul 2026 01:33:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: [PATCH 0/3] boot: fit: authenticate the dm-verity roothash
Message-ID: <cover.1783816074.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

A signed FIT configuration can delegate the integrity of a (potentially
large) root filesystem image to the kernel's dm-verity instead of having
U-Boot hash the whole payload at boot: the FIT carries a "dm-verity"
subnode with the roothash, salt and block parameters, U-Boot passes the
roothash to Linux through the dm-mod.create bootargs, and dm-verity then
validates the filesystem block by block against it.

For that to be safe the roothash has to be trusted, and in a signed
configuration the only thing that establishes trust is the configuration
signature. The roothash was not covered by it. fit_config_add_hash()
collected the image node, its hash subnodes and its cipher subnode into
the signed region, but not the dm-verity subnode, so the roothash, the
sole integrity anchor for the filesystem, was left unsigned.

The result is a verified-boot bypass for the root filesystem: an
attacker who can rewrite the boot medium can replace the filesystem,
recompute a matching dm-verity tree, write the new roothash into the
unsigned dm-verity subnode, and the configuration signature still
verifies. dm-verity then faithfully validates the malicious filesystem
against the attacker's roothash.

This series closes the gap.

Daniel Golle (3):
  boot: fit: factor out node-path collection in fit_config_add_hash()
  boot: fit: cover the dm-verity roothash with the config signature
  test: fit: verify dm-verity roothash is covered by the config
    signature

 boot/image-fit-sig.c                  | 119 ++++++++++------
 include/image.h                       |  25 ++++
 test/boot/fit_verity.c                | 194 ++++++++++++++++++++++++++
 test/py/tests/test_fit_verity_sign.py | 162 +++++++++++++++++++++
 tools/image-host.c                    |  22 +++
 5 files changed, 483 insertions(+), 39 deletions(-)
 create mode 100644 test/py/tests/test_fit_verity_sign.py


base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
-- 
2.55.0
