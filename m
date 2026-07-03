Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B4AC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D85784A7A;
	Fri,  3 Jul 2026 15:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JdBtkCFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F8284A5D; Fri,  3 Jul 2026 15:29:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30A884A75
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3382D43970;
 Fri,  3 Jul 2026 13:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813061F00A3A;
 Fri,  3 Jul 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085391;
 bh=RylhuXI7qa1XXzPqQwV4641r/vN/ZB2M/ttOWN6yNsA=;
 h=From:Subject:Date:To:Cc;
 b=JdBtkCFK9UD+u/uOBwGWfy+n4cqaBJdPUlTsu5KtsuW30xRHwP3Wh9qQgTJib3FhQ
 SkZ+9PaE07Gzx90EQqPuD6oUq8piOQl3J91hqdVyuFw7NcbwxwRizIXJiTMtu3J2QS
 PO+AtB/Wnu48uGQLlqIVW9ecKdbXQY7s1CRx/4j2+HsF4UMLFqOcvajJGpp9ouerjq
 FPpRk2Wmv0kAeJoLH5T9l5rFWx4hS876DU1QjGpWmLniQ/cDPUpFZXkNi0YcSzJZtt
 U2nPolTYxBzw3zugDz7tmnz+QncxhuKYA6VniiGrSG/cGt7ppcvs2++ePafAaIjflL
 f0NGo0c3mehAg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 0/2] usb: gadget: dwc2: Prepare for UDC core migration
Date: Fri, 03 Jul 2026 15:29:35 +0200
Message-Id: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw6DMAxF0a0gj7EUCAXUrSAGJDHgDlIU8xVi7
 6RlePT07glCgUngnZwQaGXhr4/I0gTs2PmBkF005CovVaU0LmJwCjSh26xGObzF/lUWda3JuKy
 AeIxzz/s/2rSPZTEfsvOvBNd1Azy7pNh2AAAA
X-Change-ID: 20260703-usb-prep-dwc3-sync-f564883ebd14
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=xWXGoau/NMOHg7A9pqBEQZ1hDbUj/An1cBx+amhB1Wc=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ5b7Tm8Tr8CfnDEnV9us07swf81mPsWQdQIpD3M3v/L1d
 Hq+xkW6k9GYhYGRi0FWTJFF76XT8m3yWfuChdcywAxiZQKZwsDFKQATOXuA/X+89323tae/cksc
 KZ4xY6JrpNXCkKW5gRoOx50jjR6Ihn3YLdlizVv6trjf7BYjV+XU456HTpZ91bvSfm4314Pm5re
 Js5J/hppukL5YFh5aUqL9w1wh0FYxIlhxW19WcdCn9HiFfTn2dr0PZF4wrTjRvuCOKP/Zdb2pB2
 3NNKulOW/rhs7/9H0F2x5DYb6efcp8iz/XV9S3bks0yBFKnejl+MHXKtz55OeLbU02i7S2tAhlL
 bS9XqTPrere8XPVXfeJnNff+e++XBTzx4k5NcItz2S5d/BdycDI7ZOnsO6YUdOwp1LkV8L18+HT
 LyvuOsEv5Xu56GOFiQy73pvHu+bmGE0ymFYUpJ6Uld4FAA==
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

Jens Wiklander started to migrate the DWC3 driver to a more recent
version of linux (v6.16) [1].

This migration also updates the UDC core and most notably how drivers
perform their endpoint matching.

While testing Jens' series on a Khadas VIM3 board, I reported [2] that
I can no longer bind the fastboot gadget to the dwc2 otg driver.

This series aims to fix the problems I've reported.
They can be applied to master/next (as they should not break
anything with the current UDC core). They can also be applied after we
merge Jens' work.

It has been tested on khadas-vim3_android_defconfig with the next branch
using base commit e800cc67f5b6 ("mtd: spi-nor: Add gd55lb02gf chips")

"""
U-Boot 2026.07-rc5-g89106934d3fb (Jul 03 2026 - 15:16:29 +0200) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (total 3.8 GiB)
Core:  408 devices, 37 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
MMC Device -1 not foundm MMC...
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot: 0
=> fastboot usb 0
crq->brequest:0x0
"""

[1] https://lore.kernel.org/u-boot/20260629084507.3254232-1-jens.wiklander@linaro.org/
[2] https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
Mattijs Korpershoek (2):
      usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit() for fifo sizes
      usb: gadget: dwc2: Set endpoint capabilities via .caps field

 drivers/usb/gadget/dwc2_udc_otg.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260703-usb-prep-dwc3-sync-f564883ebd14

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

