Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26ACE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8D280383;
	Thu, 19 Dec 2024 22:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="qE5SM1/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35BBA8032B; Thu, 19 Dec 2024 22:42:17 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD1F80196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 42941120013;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 42941120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734644529;
 bh=kQ3KL2Tuk1TzC/Qb94nK3XAeHPJ3kfuyGu5qKys7Fy4=;
 h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
 b=qE5SM1/g3u0IunaVLm44nbQ/ov1/LrIj3GeE9GNWHh5/Ci33DeXAs0MfjQSoJk4Xh
 bURQlsRdRcPQ8QKHnsDY7iBJUTlDjMQgQlcOaAHWsL68Nqvy9jMs/grQ08pY6p7kmQ
 dIGFq8RvyXreGKY11TMnQfXAQuTBlxcpIFW/l37nWS9w3Efj68CfrhNbPE3f4qgVxw
 pR0CaRHKRpAPtkkkRLxw3AWtH/BzZjFVzmN8fOIuN6hpRpR9yoT2TfnKBpxWueea5v
 NqG8qRqFkqs4KPmWpJzTGGT5ergbdBCzcXHK+6YDB8Uu4yJskXgLffE/T1t2H7CCet
 PtNuQzAskr4og==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH 0/3] fdt_support: improve board_fdt_chosen_bootargs() for
 flexibility
Date: Fri, 20 Dec 2024 00:42:07 +0300
Message-ID: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+TZGcC/x2NQQqEMAwAvyI5W9gWUdyvLFJaGzUHG0mKCOLfL
 Xucw8zcoCiECt/mBsGTlDhXsG0D8xbyioZSZXAf11lnRxM5SPJLKn7eWDH7yFyCrOppP4RP3DE
 XNUPf9bFKYwwD1NghuND1H/2m53kBkFrpB3gAAAA=
X-Change-ID: 20241219-board_fdt_chosen_bootargs_improvements-7646b2029ba7
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Tim Harvey
 <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Sam Protsenko
 <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734644528; l=2087;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=emBG4z/BJodznm7vA58VX9+IG0jG5PXBvwVS9hJ3R8c=;
 b=a5NeGxuL1qB80sgbWAu2RwZjGY0QBKGu3mVoviV8zaOt8zJ4a9c4B5ffnjkAkmm3WdKCT9ww7
 +LbiDuqn2dYDQACnTkAmwU/uSyVGdvkQXnCuyurpNHIsbp0gl3VqmFe
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.162.51]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189961 [Dec 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; github.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/19 20:37:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/19 20:37:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/19 19:16:00 #26891781
X-KSMG-AntiVirus-Status: Clean, skipped
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

This series consists of three patches.

The first patch modifies the function documentation style in the
include/fdt_support.h file to comply with kernel-doc requirements.

The second patch modifies the board_fdt_chosen_bootargs() function to
return a const char* type. This change clarifies to the caller that the
returned string should neither be freed nor modified. It aligns with the
existing fdt_setprop() function, which already utilizes a const char*
parameter. This promotes consistency within the codebase and enhances
code safety by preventing unintended modifications to the returned
string.

The third patch addresses the need for flexibility in providing kernel
command line arguments (bootargs) for different kernel images within the
same U-Boot environment. It introduces a read-only (RO) fdt_property
argument to the board_fdt_chosen_bootargs() function, allowing access to
the original chosen/bootargs data. This is crucial for scenarios where
different kernel versions require distinct console setups (e.g., ttyS0
for vendor kernels and ttyAML0 for upstream kernels). By enabling board
developers to either merge or replace the original bootargs, this
patch enhances the configurability of U-Boot for various kernel
images without relying on outdated configurations like CMDLINE_EXTEND.

CI/CD results: https://github.com/u-boot/u-boot/pull/716/checks

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
Dmitry Rokosov (3):
      include/fdt_support: fix docstyle to comply with kernel-doc requirements
      fdt_support: board_fdt_chosen_bootargs() should return const char*
      common: fdt: hand over original fdt bootargs into board chosen handler

 boot/fdt_support.c    |   7 +-
 include/fdt_support.h | 173 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 107 insertions(+), 73 deletions(-)
---
base-commit: 69bd83568c57813cd23bc2d100c066a17e7e349d
change-id: 20241219-board_fdt_chosen_bootargs_improvements-7646b2029ba7

Best regards,
-- 
Dmitry Rokosov <ddrokosov@salutedevices.com>

