Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2B2C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DBE88808;
	Wed, 12 Jun 2024 16:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9859488808; Wed, 12 Jun 2024 16:58:59 +0200 (CEST)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8faa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A678B885D0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vzpb51BG2zpPy;
 Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vzpb45MS7zCm6; Wed, 12 Jun 2024 16:58:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/4] boot: fix crash in bootflow menu with EFI BOOTMGR
 support + typos
Date: Wed, 12 Jun 2024 16:58:45 +0200
Message-Id: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKa3aWYC/x2MQQqAIBAAvyJ7bqHMhPpKdDBbayEyNCoQ/550H
 IaZBJECU4RBJAh0c2R/FGgqAXYzx0rIS2GQtVS1biTO3l9u9w+SY7TBxA1tJ5XqyWnVEpTwDMW
 9/3Sccv4Apt9bv2QAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

bootflow menu currently crashes U-Boot with a NULL pointer dereference
because bootflow->dev is NULL for global bootmeths (such as EFI BOOTMGR).
Therefore, let's check if the bootflow is associated with a global
bootmeth before trying to make it part of the menu.

While this makes U-Boot not crash anymore, bootflow menu doesn't work
for me (I have never had a happy path with it, but I haven't actually
tried it before today :) ) and this was basically just implemented
following Simon's suggestion sent over IRC. No clue if this is enough or
just a quick band-aid patch.

This also fixes typos in multiple places.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      cmd: fix typo in CMD_BOOTMETH help text
      boot: fix typos in help text of Kconfig configs
      doc: bootstd: fix typos
      boot: bootflow_menu: fix crash for EFI BOOTMGR global bootmeth

 boot/Kconfig            | 22 +++++++++++-----------
 boot/bootflow_menu.c    |  7 +++++++
 cmd/Kconfig             |  2 +-
 doc/develop/bootstd.rst | 50 ++++++++++++++++++++++++-------------------------
 include/bootflow.h      |  3 ++-
 5 files changed, 46 insertions(+), 38 deletions(-)
---
base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
change-id: 20240612-bootflow-efi-crash-c52449ef643e

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

