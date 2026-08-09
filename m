Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A69C5AD4E
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 18:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24BDF404C9;
	Sun,  9 Aug 2026 18:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOoNkvC5VNmB; Sun,  9 Aug 2026 18:53:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 568C140483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786301636;
	bh=7kBH1Yg6FsXX38g6Iuu/pWNZFE8QESwJOD48jjfcgnw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=0NoB8/aYOB8AHTxkTP8sukuDzSWY5Sa0qmnZpqlVg876cyzfoSDJEFfheNhQ6A3IV
	 a63ohmk9kn007lAXlq8To3c7Owp/esh0zZrbISh6kMCAfOxiNsuNGuycqJrLaPXTmp
	 rKHbXyFZ/jbxNY3h5aEno3ATilL6zdjuQXlk9UkaVxX26LK8wUNeLScFDNJQAAogB3
	 T4K+NiGo7CIgXoHt8/tSamVY+mdqwJmbkkGnPMz7frSO98jm3enh18mbkkJHvhin4A
	 rVPaPfZ07urW+WufdqmSkDRv3kTq33xwLsQ3q7cLbt9EuVo/zAQ/rrxILOWBAUA263
	 f9WoYvYZ1Pbgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 568C140483;
	Sun,  9 Aug 2026 18:53:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 17D2010E
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 18:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09471404C1
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 18:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8p7D4Tsih3Zt for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 18:53:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+usb@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D5DA940483
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5DA940483
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5DA940483
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 18:53:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hJ6VP3g0vzKnRn;
 Sun, 09 Aug 2026 20:53:49 +0200 (CEST)
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Carlo Caione <ccaione@baylibre.com>
Subject: [PULL] u-boot-usb/main
Date: Sun,  9 Aug 2026 20:52:50 +0200
Message-ID: <20260809185338.841953-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8c245c9719b7c806036
X-MBO-RS-META: arm69fb1c4of4bqub5szihcwaob9suis
X-Rspamd-Queue-Id: 4hJ6VP3g0vzKnRn
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786301629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7kBH1Yg6FsXX38g6Iuu/pWNZFE8QESwJOD48jjfcgnw=;
 b=DHPgxp3Hz9jeaHUmDb2keKHs8QSR64O/iZK/Rp8IuYBoB0GC8bMMsVX62et4yVdslH/TY1
 sUKNKbz5uL19XvcRhLJQatAOik5Pzc3T4qtic8NxBW1qyyAxtIK8gWw4p7qBf4md1k/kTZ
 gzB3NiAohsa0FT97Avs2tQh4afZWyv5eb5VPO7g6B/vPKnzXLj4+XyQ+ridCfPqAnWykeH
 EQjBYFKWvhhLbzonD3Ny/DXyDIiKKBVRX1QkQ55H6TiYpNevXvzNMOS5cxPh+x4gATLDh/
 xfrh4fBgQBtnDV8f6ClXQsKzVuCtTxvr2zRy1p33vftqHoEPTTdqmJWV60bhaw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786301627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7kBH1Yg6FsXX38g6Iuu/pWNZFE8QESwJOD48jjfcgnw=;
 b=byneVcslXoBO2IAANOcve335nqd4GvXRa+KgaA9vg1RjW/SrQveFwYb9jDQBGr+DKfAd1M
 gMPU7/IXLdLsUisdcldBoUJakmdxCrmxprRWvlin9iBV4/sI/2NLnqgJrKo2jrXKz6c0ew
 tiQJeEjB6WIHjDe3ExuFJBOHl3LuMwbcqYY7cCvQFOETZeQCLIXm3YJ+VQdRgxex1IGPwO
 drHpMWX1fQfB16AKdhhT2n6AvPUabwS4FRYSYcPhRx2dpCM1iJTlFrVEb0vWqBLupI0Rkk
 PyK0QXZ3zxbyuCAhvVsb+J51OvS5LK7yhlFhvGPWeSKQLfnZY//t+d4rirkNQw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=DHPgxp3H; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=byneVcsl
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=byneVcsl;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+usb@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

MTU3 DT bindings alignment with Linux DT bindings.

The following changes since commit d0615e4a67c8958fad4a8c39262074958f04c179:

  Merge tag 'u-boot-imx-main-20260807' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-08-07 10:21:33 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to 08b77aac333cb437df57a7f746fa712042ccde61:

  usb: mtu3: add SPL support (2026-08-09 13:26:42 +0200)

----------------------------------------------------------------
Carlo Caione (3):
      doc: usb: remove obsolete MediaTek MTU3 bindings
      usb: mtu3: support the upstream devicetree binding
      usb: mtu3: add SPL support

 arch/arm/dts/mt8183-pumpkin.dts                    |   4 -
 arch/arm/dts/mt8183.dtsi                           |  17 +-
 arch/arm/dts/mt8512-bm1-emmc.dts                   |   6 +-
 arch/arm/dts/mt8512.dtsi                           |  19 +-
 doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt |  46 -----
 doc/device-tree-bindings/usb/mediatek,mtu3.txt     |  79 -------
 drivers/Makefile                                   |   3 +-
 drivers/usb/mtu3/Kconfig                           |  39 ++++
 drivers/usb/mtu3/Makefile                          |  10 +-
 drivers/usb/mtu3/mtu3.h                            |  12 +-
 drivers/usb/mtu3/mtu3_core.c                       |   4 +-
 drivers/usb/mtu3/mtu3_dr.h                         |   4 +-
 drivers/usb/mtu3/mtu3_host.c                       |  11 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  11 +-
 drivers/usb/mtu3/mtu3_plat.c                       | 227 +++++++++++++++------
 15 files changed, 240 insertions(+), 252 deletions(-)
 delete mode 100644 doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt
 delete mode 100644 doc/device-tree-bindings/usb/mediatek,mtu3.txt
