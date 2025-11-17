Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787F9CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC1283B7E;
	Mon, 17 Nov 2025 11:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WkiNwdSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B63A83A79; Mon, 17 Nov 2025 11:33:29 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B9583A79
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A81343CC2;
 Mon, 17 Nov 2025 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB9C4AF09;
 Mon, 17 Nov 2025 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763375605;
 bh=6/zeNwQUOMUcDK3zwF9sFzNG2StYi5MDRS6VvOoAOpo=;
 h=From:To:Cc:Subject:Date:From;
 b=WkiNwdSX9kRTTY8jsm1YoqMHb6Hmxi7qdEXn3tIvirzrCLfiDgTZl6EsHbYFxzSEJ
 mcUwOCr/Jm+oGc8IDjVmhTeipiSg7amUyI0jLPaBrrFXnubDDwyaEwVgDo23sO8WlY
 v9vW34pj7qixo6AQ/PvyxhiwidGfNziQ4yJctWypg/lgMaHBhpb43nX9qbP+ICWA/6
 vRsZAFZof1MEWUasN8lUCQUEzQRCZzXhilv3znHbMaBnrjQkDQ1sgaiQkwmSf0HkUN
 Nv3l5hrMZ+bSJ70YRxCCGK1onxGmo3WSrbH0q9nPrw7Ecw5Xpv/U8pm2h4NnyuSXB7
 yEhPHrrk2XJOw==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 0/2] Add support for two RTCs
Date: Mon, 17 Nov 2025 11:32:49 +0100
Message-ID: <20251117103315.2212686-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I'll soon post support for the Kontron SMARC-sAM67 u-boot support.
I'm still waiting for the linux device trees to be merged (in -next
right now) and then to be synced to the u-boot tree. That board
features two different RTCs and this will already support for these.

You can find the device tree at [1]. RTC nodes are in the overlays,
though there is none for the RV3032 at the moment.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts

v2:
 - new patch to convert existing tristate to bool
 - use bool instead of tristate in the pcf85063 patch

Michael Walle (3):
  drivers: rtc: convert tristate to bool
  drivers: rtc: add PCF85063 support
  drivers: rtc: add RV3032 support

 drivers/rtc/Kconfig    |  17 +++++-
 drivers/rtc/Makefile   |   2 +
 drivers/rtc/pcf85063.c | 107 ++++++++++++++++++++++++++++++++++++
 drivers/rtc/rv3032.c   | 121 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 drivers/rtc/pcf85063.c
 create mode 100644 drivers/rtc/rv3032.c

-- 
2.47.3

