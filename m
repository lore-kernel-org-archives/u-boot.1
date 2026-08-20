Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75327C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FDBF80DC7;
	Thu, 20 Aug 2026 15:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1b1u7PnmDdpc; Thu, 20 Aug 2026 15:26:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787239583;
	bh=tjToLbJp14+++gRIa/NrOJQ/0VBxdTKE7EUvqiHW8Vo=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XVQuvV8N1WR2VZIXcJ7BG6BEVp5LsLRpVJepqYH79gvaZUW2FsfbMHZhkc0Wllrqc
	 P7p3AypiaZZlvAUUH5Fn+IL7+C2O5VS/BYsF0C4ujWr0uCi/9cIw54bFYkc768DPU7
	 Fq8v3ulw12+WYd9JW+5qKkFwaooqp37rzcBkA14Cq6Yvde9UIYrs50SfUtJTkVv1r0
	 mm6lO6bDjZU2lgbTaOYyVqGngOgtl0KURbJDRkBLUK4qho04Bufw/x4sy8si6kzCks
	 DbkqRs5S8wUxDp1pZOn874vRamUchNU1avGzwpKziQzuFO38hXYIgoC/RxYJXnhTat
	 4dwBFEXkS8sfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10F8F80DA8;
	Thu, 20 Aug 2026 15:26:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3423323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D96566065F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EoN3A-m7pZYi for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:26:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.102;
 helo=mail-43102.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=mkK1s0sG
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F960605DA
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787239574; x=1787498774;
 bh=tjToLbJp14+++gRIa/NrOJQ/0VBxdTKE7EUvqiHW8Vo=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mkK1s0sGII0T+7dmC3D5Cyn+aY7lmmfI4TrPInGNE7yTaYloqmXLYGaN2tBz3gjOy
 y0PGHImMqF4ZBceUsN+HuHN1jD5v31QIgzl/LiMMJ9fL699xwOCLGtwBg3QOHQf8lP
 2DGD8ldHWH8Ytf8PNc5/9E8YzFeDfXJrky86S9Z/IGyKZclpDpeKEfZYOjvreauE5M
 2Wtui1ZJAD/wd+rIYdog8gRyd9p7G62b8f53iSlrOCTL5jQzwGhbXlbWVx3ThZ+3wC
 5dbLGKHwTxJg4Af2Uo+OcRAfYbTxIugoBEpKjZHwsgp2hslexiOgi9Z6NboapHd2dM
 gvq+9M3hvfzFw==
Date: Thu, 20 Aug 2026 15:26:09 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/2] spi: support devices with no wire in one direction
Message-ID: <cover.1787238071.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 63dbcd7f73934245693dd359ad7b12b7037af33a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Flipper One display bus has no MISO wire. That pin is the
end-of-frame GPIO. The device tree says so with spi-rx-bus-width =3D <0>,
but the uclass dropped the value and the Rockchip driver clocked the
receive FIFO anyway, discarding every byte. Reported at
https://github.com/flipperdevices/u-boot/issues/33 from the boot log
there; Alexey has since confirmed the fix on the hardware.

Patch 1 maps bus width 0 to SPI_NO_TX/SPI_NO_RX, validates transfers
against the bits in dm_spi_xfer() and adds a sandbox test. Patch 2 has
the Rockchip driver pick its transfer mode from those bits, so the
unused FIFO stays out of the transfer.

Both went out on their own before:

https://lore.kernel.org/all/10e92a74c8a22cc2cd54f5dcccc31594016d4263.178701=
5208.git.Munzzyy1@proton.me/
https://lore.kernel.org/all/69c35eba7ee1a353107459b8f8032e92506a3fb1.178704=
5568.git.Munzzyy1@proton.me/

Rolled into one series now, since patch 1 has no user by itself. The
rk_spi mail had also gone out as a reply into the uclass thread, which
is what made b4 read it as a v2 of the prerequisite. Clean thread this
time. Sorry for the noise.

Changes in v2:
- validate NO_RX/NO_TX centrally in dm_spi_xfer() and return -EINVAL,
  matching Linux __spi_validate(), with a sandbox test for both
  rejections (suggested by Quentin)
- reworded the transfer mode comment in rk_spi.c claim_bus (Quentin)
- collected Alexey's Tested-by on patch 2 (Flipper One, warning gone,
  transmit-only display still works)
- added the maintainers get_maintainer.pl lists for the touched files
- one series with a cover letter instead of two stray patches

Cole Munz (2):
  spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
  spi: rockchip: skip the unused FIFO direction on a one-wire device

 drivers/spi/rk_spi.c     | 27 ++++++++++++++++++++++----
 drivers/spi/spi-uclass.c | 16 ++++++++++++++++
 include/spi.h            |  2 ++
 test/dm/spi.c            | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 4 deletions(-)


base-commit: 527115ef6783cec49e5610c523c124b399011361
--=20
2.55.0


