Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9455BC61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 12:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3B3A6060E;
	Sat, 29 Aug 2026 12:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 27YjyrN0ynhR; Sat, 29 Aug 2026 12:12:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788005532;
	bh=pEAsE3lFOfq+vQfZc6GCLu2w9fmI1/pjezyc6M+ovn0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NkIu5hnZWjhRJqZQHd3+wGmKA802tb9jQaOm1npMr9GKyaO6cU6C99hJVmDUjplWy
	 tNALCunr5UBA4TbmyXl2QH7gW4hA0XfW6x5RzHPNeXlR3gT4c4KzqhN6vb0GaY1eJs
	 1Jt1Vf/t/0T3RMKzEzEuhn4pKAKTeYuxk/lPzLBCrq7+oiuE1uKWuJwIxhmBm/eEQc
	 uQFLW9dDOwIsp8dCGCvFBTSq3r0TJm87bAnqSpO8dPeMc5+9WDFjZmcrEFr24lNYIA
	 sumOe9iOtq+LBS9p3mb6EGpVak4PoRZbnI/sWvI/HMgeUtzhw9oY2CX+yI16pb3/ZJ
	 A3/BZbAUH06eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D098D605CF;
	Sat, 29 Aug 2026 12:12:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E7E123E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A00960609
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_bWkjV_RZkz for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 12:12:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.173;
 helo=smtp-42ad.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=cKfFpl4A
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1652460607
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:12:08 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hXDdg07gzz15Nk;
 Sat, 29 Aug 2026 14:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1788005526;
 bh=pEAsE3lFOfq+vQfZc6GCLu2w9fmI1/pjezyc6M+ovn0=;
 h=From:To:Cc:Subject:Date:From;
 b=cKfFpl4AVA97GMy4MX3fUHl+vUKbHNVTTBJcugm989ndLLGrIj0YB5mEAbRBzNg4P
 AK9Xm964QbztavJ2nqS8PGZXmlFV9l9zXRwbVdgiorZROo2TnH1ZWAm6dJlcSQdJot
 ZDrlzu4WH0PnSUXZRKMI1X/Xac2FR0IhQ8wnDEbXAg3qniu4RJUKZhp/BabaM4L39G
 q2gQqv6UJE0DaIgT5/dMPmcM8jv7IPIlwlcFceSzUJpBB9Kn9uUB5Gl2B5h/ZTx+8u
 E4fw/7Y4dN7TvQEzjNZ8SNr72Zl8JWmF4Tmi6QgDd9JGWpgQpxuGmFxHClJC/cF/sB
 gjiwiVvfsCewg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hXDdf3RHYzT8N; Sat, 29 Aug 2026 14:12:06 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2027.01-20260828 into next
Date: Sat, 29 Aug 2026 14:11:05 +0200
Message-ID: <20260829121154.831957-1-u-boot@0leil.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1115

The following changes since commit 41541f47a3af93d76d63c2d6d1f1c859fa3dd61a:

  global_data: Only include driver model fields when DM is enabled (2026-08-17 18:46:29 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2027.01-20260828

for you to fetch changes up to ed58bafd0b24e15b734c624bdaf00b876e5d32e6:

  spi: rockchip: skip the unused FIFO direction on a one-wire device (2026-08-24 10:53:00 +0200)

----------------------------------------------------------------
- Fixed possible SPI hangs when only PICO is routed (TX-only),
- Added support for ROC-RK3399-PC-PLUS (via roc-pc-rk3399_defconfig)

----------------------------------------------------------------
Cole Munz (2):
      spi: Handle spi-{tx, rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
      spi: rockchip: skip the unused FIFO direction on a one-wire device

Fabio Estevam (4):
      mtd: spi-nor-ids: Add XMC XM25QH128C
      rockchip: rk3399: Remove ROC-PC regulator overrides
      rockchip: rk3399: Add ROC-PC-PLUS board detection
      rockchip: roc-pc-rk3399: Enable redundant environment

 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      | 28 +++++--------------
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 42 +++++++++++++++++++++++++++++
 configs/roc-pc-rk3399_defconfig             |  5 ++++
 doc/board/rockchip/rockchip.rst             |  2 +-
 drivers/mtd/spi/spi-nor-ids.c               |  1 +
 drivers/spi/rk_spi.c                        | 33 ++++++++++++++++++-----
 drivers/spi/spi-uclass.c                    | 16 +++++++++++
 include/spi.h                               |  2 ++
 test/dm/spi.c                               | 39 +++++++++++++++++++++++++++
 9 files changed, 138 insertions(+), 30 deletions(-)
