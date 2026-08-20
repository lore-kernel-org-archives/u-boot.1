Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5142FC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 17:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDF4780ED7;
	Thu, 20 Aug 2026 17:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5wZ3I1-v7as; Thu, 20 Aug 2026 17:53:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787248427;
	bh=iEAexsmFjG65BJl2Lv3eevUxqQEDoY9JrgXk9WtZGT4=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h9zkZeyeiYl+I7K1nWg954fq1iY+MqsmkUXFgZ2h6z1OhSWFzmiV4fUgGje82/EyB
	 U9IRzmVZKWqjZcGoJ5GGbpnxNiMbaZwJD+0YvIkeZ3WmixZbX6KP78ueWKLbRvKTsT
	 puQqpnZpXsRQMw7AjZ+/paK9IcA+Qj5g/708JmG1skQkHLKYMy0CTcejgWapj4nR6n
	 kY+24BEO3cFT7/DHLurR0GWLCMiu4zuf+qkLSYqaG7iWfvdcjCQcSu25Adwa8wqne8
	 ULT8L4+hiLUThBNLGEeSOePz/WXQjI58Sd0YmxTG+eo5dRJJajv/WFf3h4++j7Zo2L
	 XuU0Tq9Hu62fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E6FE80ECB;
	Thu, 20 Aug 2026 17:53:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90C701B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 729E9606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oq8Vki6SnGIv for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 17:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.28;
 helo=mail-10628.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=C2vZH8rL
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C54D760602
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787248421; x=1787507621;
 bh=iEAexsmFjG65BJl2Lv3eevUxqQEDoY9JrgXk9WtZGT4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=C2vZH8rLtbJODTxZ6+HTs0UYzC0mDkgCsZgjRNIBKoiHO0nNyKJ1FvinYnZzGySBk
 jP1ULWPkZynN3UTyNledCln8QxIfnJXwk3FooZz8srq8ThGJ8mWp569srCd6ZSBogT
 BKeSPgDONQYMH53B6c8pNxkiO2c88k6QrhBqkB+S0m0IcQ/Ga47eQgKzgStVB4+VAK
 TwWI+uX/Jo5S8D4hJflDwGR0DpvcMDm+frYAIIJWekvY8mTAoGFnSgsv46zyoUFOA1
 v6HVWHS5c12P9BcZyL6wp6IIqyUNrJumgocp6mHeaSkFfWlSvDaDFz2p8yrm9S++TV
 ObPiz4xjUZm+Q==
Date: Thu, 20 Aug 2026 17:53:37 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 0/2] spi: support devices with no wire in one direction
Message-ID: <cover.1787245113.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 74bb41d655bf5112ddf2d69afda35c3e9a0183fb
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

The Flipper One display bus has no MISO wire; the pin is the
end-of-frame GPIO. Patch 1 maps spi-{tx,rx}-bus-width =3D <0> to
SPI_NO_TX/SPI_NO_RX and validates transfers against the bits in
dm_spi_xfer(). Patch 2 has the Rockchip driver pick its transfer mode
from them so the unused FIFO stays out of the transfer. Background and
history are in the v2 cover letter:

https://lore.kernel.org/all/cover.1787238071.git.Munzzyy1@proton.me/

Changes in v3:
- dropped the happy path assertion from the new sandbox test, it is
  already covered by dm_test_spi_xfer (Quentin)
- collected Quentin's Acked-by on patch 1
- reworded the toread comment in rk_spi.c to say what the RX drain was
  actually doing for the transmit path (Quentin)

Cole Munz (2):
  spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
  spi: rockchip: skip the unused FIFO direction on a one-wire device

 drivers/spi/rk_spi.c     | 29 +++++++++++++++++++++++++----
 drivers/spi/spi-uclass.c | 16 ++++++++++++++++
 include/spi.h            |  2 ++
 test/dm/spi.c            | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 4 deletions(-)


base-commit: 527115ef6783cec49e5610c523c124b399011361
--=20
2.55.0


