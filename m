Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB6C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 12:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4EBD40764;
	Sat, 29 Aug 2026 12:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2lqdwwv92qas; Sat, 29 Aug 2026 12:10:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788005434;
	bh=IwGcT++cqEYAW6HUoMsZit3dNgDsOb3XjIBl+XCwmqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIetvBRWNNslbGBTj51HzCamgGBfGNVxRm1U8+iStx2Stl0FUy/AYCxV4CethXS0d
	 MOdUpM85P6CrFh1zOIIQmPDaq0dEzcD7lc60qLQXpHxZfaF/ib8DztnlAMXKiG8RlY
	 WD9iJSFFR+luInw5VUUaiWA2d4z1R1BrQv28wMM57JDbQnnYJZMut5tbGEhHhcVgop
	 a5on80Fq4Lq/6uPxDfwQEVCwQxd47qtjJarBKDfrAzNAvBL8tho+2OPdPgfV9jj4aY
	 l6F3ro3g3PlL0s1xojv7qNa2uQifKPMEZUvTj7xtSnwA2ZcNOp/2fnsSsUlq8AmFHl
	 VtdaGCLME3S8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4AF440730;
	Sat, 29 Aug 2026 12:10:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EF85336
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38B7B80E85
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-fFHa__XVvE for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 12:10:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=HvbezWPu
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01A0980E84
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:10:30 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hXDbm58BYz14Pd;
 Sat, 29 Aug 2026 14:10:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1788005428;
 bh=IwGcT++cqEYAW6HUoMsZit3dNgDsOb3XjIBl+XCwmqI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HvbezWPuxlBLhaeSyt/opxf7Q+WiJ7kFoDNifsXHYRpFpJTe0ZZAvYhz68wrP4s5X
 mK+A/4+MEv7PctsV8EJ0q7h5Y7ZYgvpyIdcYwNAtXJX0rJrncYw1JszMXhhrMb6Rrh
 cK+RcbkdUAGlmdQk6HzVrAS46ujKNEakp74c1D0d8cLgy3DmLENIusF3pVkxhO5E6I
 e3XHVXwyoS3iGnVwRX0fejUPmk7vBsdapyiJIjga88sMGbQH3jqEgegdWH8VVsKoeR
 eARj9n1D7rnA7azB2mrwmS8ozJFTLwvlveOgD1RlzJV+c+StstZfjSHAKzl+vbDFzh
 MuMb1CJc4T8Pg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hXDbl5PG2zQfD; Sat, 29 Aug 2026 14:10:27 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.u-boot-project.org, Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Alexey Charkov <alchark@flipper.net>
In-Reply-To: <cover.1787309754.git.Munzzyy1@proton.me>
References: <cover.1787309754.git.Munzzyy1@proton.me>
Subject: Re: [PATCH v4 0/2] spi: support devices with no wire in one direction
Message-Id: <178800542772.831438.11770710522380733212.b4-ty@b4>
Date: Sat, 29 Aug 2026 14:10:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

On Fri, 21 Aug 2026 11:54:58 +0000, Cole Munz wrote:
> The Flipper One display bus has no MISO wire; the pin is the
> end-of-frame GPIO. Patch 1 maps spi-{tx,rx}-bus-width = <0> to
> SPI_NO_TX/SPI_NO_RX and validates transfers against the bits in
> dm_spi_xfer(). Patch 2 has the Rockchip driver pick its transfer mode
> from them so the unused FIFO stays out of the transfer. Background is
> in the v2 cover letter:
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/2] spi: Handle spi-{tx, rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/300cdfa08c53e89ff277b16a719e2796e9ffa4ad
[2/2] spi: rockchip: skip the unused FIFO direction on a one-wire device
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/ed58bafd0b24e15b734c624bdaf00b876e5d32e6

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

