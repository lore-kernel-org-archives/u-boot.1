Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFCDC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 10:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FA982006;
	Mon, 14 Apr 2025 12:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D63B820B7; Mon, 14 Apr 2025 12:51:03 +0200 (CEST)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8928129F
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 12:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zbkbm4SXBzmWr;
 Mon, 14 Apr 2025 12:51:00 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Zbkbl71mnzlF9; Mon, 14 Apr 2025 12:50:59 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] binman: properly error out if path provided to
 key-name-hint in signature nodes
Date: Mon, 14 Apr 2025 12:50:43 +0200
Message-Id: <20250414-binman-pubkey-dir-v1-0-0784d54ac621@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPo/GcC/x3MQQ5AMBBA0avIrE2iUpSriEXLYCKGtCFE3F1j+
 Rb/PxDIMwVokgc8nRx4kwiVJtDPViZCHqIhz/Ii00qhY1mt4H64hW4c2KM2zpjSqaqoa4jd7mn
 k63+23ft+6nvpjWMAAAA=
X-Change-ID: 20250411-binman-pubkey-dir-48b886b17599
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

I misunderstood the documentation and put the signing key in a keys/
directory while setting key-name-hint property in the signature node and
u-boot-spl-pubkey-dtb to a path.

mkimage doesn't fail if it cannot find the public key when signing a
FIT but returns something on stderr to notify the user it couldn't find
the key. The issue is that bintool currently discards stderr if the
command successfully returns, so the FIT is not signed AND the user
isn't made aware of it unless the image is manually inspected.

mkimage does fail when trying to insert a public key in a DTB if it
isn't found but we can have a better error message.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      tools: binman: etype: fit: raise ValueError if key-name-hint is a path
      binman: etype: u_boot_spl_pubkey_dtb: provide more explicit error for key-name-hint with path

 tools/binman/etype/fit.py                   | 3 +++
 tools/binman/etype/u_boot_spl_pubkey_dtb.py | 2 ++
 2 files changed, 5 insertions(+)
---
base-commit: cb7555e93075114fe4af0adb806877ac4d4ef80d
change-id: 20250411-binman-pubkey-dir-48b886b17599

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

