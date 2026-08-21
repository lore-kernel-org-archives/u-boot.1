Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8219C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 11:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FDA64098C;
	Fri, 21 Aug 2026 11:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xn_y9Fb-ObO; Fri, 21 Aug 2026 11:55:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787313313;
	bh=DzFQwdtyUznHYks4+9hDMfoRZIpRf+WQbOMuJ1mMNCA=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kqo9EAQzsy7GlM+LQt//nRXTtemAA0PrbN1xFGfjRxVpdoIdWE2Fhwag5si6MM+Mi
	 i7zEjyJnBqgW8VvkcTw1dG9DNnIoiOzkOPjR5ADcQQ0832ak0tQyOF7bRpDUI+nR/Q
	 S4qIv7KK8lA5Z9uhgizuMSXdCxTwsb+o62esUHrSOUKTLEABezgXUd46xdxZisSAit
	 PqH8d2AvpDSOgYg8q7CdSLxSdMbXERU3/zPV+060h9tL80E9FYHj/Tfr+1algccvPd
	 1mg5IJiSu4R/duh7Fyy5s2FZkKHooVBlHQXVuss6yZb1ZMrMFyEW7dQYtqYJnjLX+D
	 EyhTUF1zOxhAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DFB140985;
	Fri, 21 Aug 2026 11:55:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 410054B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 277B740986
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4hsjjKTVdFf for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:55:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.28;
 helo=mail-10628.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=v4z25w46qzelhjphyvao4ii4iq.protonmail header.b=crOS0ECL
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 315E540984
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=v4z25w46qzelhjphyvao4ii4iq.protonmail; t=1787313305; x=1787572505;
 bh=DzFQwdtyUznHYks4+9hDMfoRZIpRf+WQbOMuJ1mMNCA=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=crOS0ECLNVyfubfzXCmv3TfXisNSbKq1DPbMmOXnhNL7AMrUD1RpJypsoSPT54cPU
 ckXNU15LdxcWC7h7GGBoSaA7s+80PIM2eNwgkkgkllB9u4s9Kpa85558NECbgL2Uu/
 7a9vfb5it633OPzDw2ZpXe3u9x3cho5JseyWjtyxjtxXMJ/Ypid3/CeF8hRVR5EQJ1
 15S4uV4Lw+nxFrkD9ImA6VtfJr+lOSW6lgaGkCNtLwVO/cBsqyUI/2Djsdd0gPHXzD
 nnvwV4y2vlVRZMLV6THSgFSd8bxHraTFPvzalYNUpR/06VrlfVwlbztiUyniQ0jvZN
 1SKGEVkwDkDsw==
Date: Fri, 21 Aug 2026 11:54:58 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 0/2] spi: support devices with no wire in one direction
Message-ID: <cover.1787309754.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 3c709aebbe711aeb474953ee09c9c2e055978e05
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
from them so the unused FIFO stays out of the transfer. Background is
in the v2 cover letter:

https://lore.kernel.org/all/cover.1787238071.git.Munzzyy1@proton.me/

Changes in v4, both from the comment discussion with Quentin:
- toread comment cut down to the one factual sentence
- the comment above rkspi_wait_till_not_busy() now says why the wait
  matters: the TX FIFO can still hold unsent data and disabling the
  controller clears the FIFOs
- patch 1 unchanged, carries the Acked-by

Cole Munz (2):
  spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
  spi: rockchip: skip the unused FIFO direction on a one-wire device

 drivers/spi/rk_spi.c     | 33 ++++++++++++++++++++++++++-------
 drivers/spi/spi-uclass.c | 16 ++++++++++++++++
 include/spi.h            |  2 ++
 test/dm/spi.c            | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 7 deletions(-)


base-commit: 527115ef6783cec49e5610c523c124b399011361
--=20
2.55.0


