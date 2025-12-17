Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA72FD65C7D
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D49983BB1;
	Wed, 17 Dec 2025 17:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25BF83B99; Wed, 17 Dec 2025 17:24:07 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B7A83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dWfJ44PhtzVkD;
 Wed, 17 Dec 2025 17:24:04 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dWfJ36sC0zKjs; Wed, 17 Dec 2025 17:24:03 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] cmd: bdinfo: further document
Date: Wed, 17 Dec 2025 17:23:55 +0100
Message-Id: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MQQ5AMBCF4avIrE2iE1JxFbGgHcympUUk4u4aL
 L+XvP+CyEE4QpNdEPiQKN4lqDwDM/duYhSbDFRQpUhpHEocrLjRo/UG60Irzb0hqwnSZwk8yvn
 22u5z4HVP2e0f7/sBbI1d13QAAAA=
X-Change-ID: 20251217-b4-bdinfo-doc-80717eac2d72
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

bdinfo is missing a long help text for the additional -a, -e and -m
options so let's add them.

While at it, update the sphinx docs to add missing requirement for the
devicetree field to appear in the output.

Finally, update the sphinx docs to provide an example of bdinfo -a, -e
and -m as well as make their Kconfig dependencies explicit.

This depends on v1 (but will apply without!!!!):
- https://lore.kernel.org/u-boot/20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de/

Do not apply if another version than v1 for the dependency is merged as
the symbols may have changed and then the docs are wrong.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      cmd: bdinfo: provide long help with all options
      doc: cmd: bdinfo: specify required dependency for some info
      doc: cmd: bdinfo: document options

 cmd/bdinfo.c             | 16 ++++++++++++-
 doc/usage/cmd/bdinfo.rst | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)
---
base-commit: 05661fb9b7bd1ab8192e82fb562b9fd501703b6b
change-id: 20251217-b4-bdinfo-doc-80717eac2d72

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

