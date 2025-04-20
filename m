Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038A0C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 08:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C25A82076;
	Sun, 20 Apr 2025 10:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gOzOLHU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5B9820B7; Sun, 20 Apr 2025 10:59:55 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00EE782027
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 10:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-177.46.114.pool.telefonica.de
 [46.114.111.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A09153FF07; 
 Sun, 20 Apr 2025 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745139591;
 bh=kTg8Q7C8J4meu/TOQHZcZ3TDkcHoE9x5c7BNDxWlM/Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gOzOLHU7EzLzjk/SIfW9J9QDeDSORM2Vj8t1rPdfBz1ngBgq+Gv5Lk+BhsFaVcCSH
 QO5O/l9JfGsvNs+6Ukd5Z32cLudzv29jBEjQKnJSyx+e1XrO7DpmzAjD30frYfUMf4
 IdbOFZ1c02hROXcBjRQc4cRkZsKL/Qzi7IcAzU5+UV+LHQtvbZyPNnIKiqNkr4HPhY
 6gVJnM+OOe+dCewfLO5YIbyrAEZ6L+90JsZVxsK1lxDj6aQ46vi5azEjG+hCGZ3r5X
 6K2qWxOkjuKyHeA130D4+pnuwNMnzNWEL5LPaUe87sgK2ppBU2O0zztrpsbmeBo1hR
 P1idHIPwf5M8Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] configs: ACPI enabled QEMU defconfigs
Date: Sun, 20 Apr 2025 10:59:25 +0200
Message-ID: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

For QEMU we have developed supporting passsing through ACPI tables.
This functionality has been broken multipled times due to missing CI
builds.

* Two new defconfigs qemu_arm64_acpi and qemu-riscv64_smode_acpi.
* Assign the defconfigs to the respective maintainers.

Heinrich Schuchardt (4):
  configs: add qemu_arm64_acpi_defconfig
  MAINTAINERS: add all qemu_arm64* defconfigs to VIRT
  configs: add qemu-riscv64_smode_acpi_defconfig
  MAINTAINERS: add qemu-riscv* defconfigs to QEMU RISC-V 'VIRT' BOARD

 board/emulation/qemu-arm/MAINTAINERS      | 3 +--
 board/emulation/qemu-riscv/MAINTAINERS    | 7 +------
 configs/qemu-riscv64_smode_acpi_defconfig | 2 ++
 configs/qemu_arm64_acpi_defconfig         | 2 ++
 4 files changed, 6 insertions(+), 8 deletions(-)
 create mode 100644 configs/qemu-riscv64_smode_acpi_defconfig
 create mode 100644 configs/qemu_arm64_acpi_defconfig

-- 
2.48.1

