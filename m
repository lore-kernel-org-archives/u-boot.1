Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764A0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258D887442;
	Sun, 29 Oct 2023 08:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="R/Q+BBuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA71F8723E; Sun, 29 Oct 2023 08:09:18 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80D3871E8
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id DFF124265F;
 Sun, 29 Oct 2023 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698563354; bh=Iwu3rI3ZJ3sVIfoju2RrDVttz8JqA55b6HTohOu/b1o=;
 h=From:Subject:Date:To:Cc;
 b=R/Q+BBuKRsvBujhWJ6p/8CfSowZ1UMadxqZCiu0kHRGEkhER/CyXCrLC97eYx+FHK
 dHMpsaVVE5oofLfnxH8f4uuWnEgmhDvgO/Ae+AURubgG00qQXaRPvWW+DevjJl/uIu
 vqXxLLTgDJkLoibiNymroYmzmYHORbXRSFUrjZUeba5i/kVe2wCDDF4NjHq5DBVvgA
 6Xx0J3GyAcOYLkSnOutbzkhiIUxWoSIFm8/BR2lFnPuk11q6uVMPqmGvcwMwqFKn49
 eXONXUu4jIDqVtewRiMtaOJEnFRzDwDku2g0NXh7tGPol+JgwLrbWxDwolGZT6wiIl
 quNypxxR/RnbQ==
From: Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/2] USB fixes: Add missing timeout, ignore YubiKeys
Date: Sun, 29 Oct 2023 16:09:07 +0900
Message-Id: <20231029-usb-fixes-2-v1-0-9f793aa20fe4@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMFPmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNL3dLiJN20zIrUYl0jXUtzMxMLsxRDMwPjZCWgjoKiVLAUUEN0bG0
 tAAjleV9dAAAA
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=705; i=marcan@marcan.st;
 h=from:subject:message-id; bh=Iwu3rI3ZJ3sVIfoju2RrDVttz8JqA55b6HTohOu/b1o=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ7VnG+IsmFLXKySy/d9e0/J9m35ahjwbTjfo99pjvbs
 x3SX3Wuo5SFQYyDQVZMkaXxRO+pbs/p59RVU6bDzGFlAhnCwMUpABPp+MLIcP7P4ZPs65V0g5Ua
 uqa8lOWclqecVzvxmi1ffNukivLjpQz/EzdMVDuw2mny1v16frmRrxM9GhXnzryWtbZdQo7D+GA
 pCwA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

This mini series fixes one bug, but in the process makes YubiKeys work,
which then regresses people who have one *and* a USB keyboard, since we
only support a single keyboard device.

Therefore patch #1 makes U-Boot ignore YubiKeys, so #2 does not
regress things.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
Hector Martin (2):
      usb: kbd: Ignore Yubikeys
      usb: hub: Add missing reset recovery delay

 common/usb_hub.c |  7 +++++++
 common/usb_kbd.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)
---
base-commit: 8ad1c9c26f7740806a162818b790d4a72f515b7e
change-id: 20231029-usb-fixes-2-976486d1603c

Best regards,
-- 
Hector Martin <marcan@marcan.st>

