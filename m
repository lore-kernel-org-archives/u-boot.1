Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161BC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 269AD405CC;
	Tue, 25 Aug 2026 15:59:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QskEI1XPM1tP; Tue, 25 Aug 2026 15:59:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673548;
	bh=8zS0V79jsyu53Siad2RZFPd1oNSmaTmxaFfmO6NzYzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYOzqJZfNkhDxbdZ6TT7Tn3Gtas83OBPAuzYjwUXnVu9//17ErkS5NA/ePe2m2snH
	 VRKNQH+B0CARjtd7vpBcCmfSJ9KSHEMPSfnJ1YHdNiG8DSfbfEoa7TK3ONfEd6PNdp
	 nvKZx2/xEQWZ1BucIR3ieFsjCUdlov/hQA/fCn8rHWPzMmEWiEhcLydRXJI8hoiGP+
	 8NQS10h2HmKSYNMQDWJR+Ug8VmhV5ldzAMbhCLrfzsFvL1gdzJKEazgjo3gPTLu1UO
	 dxd87tb0FtJWHOfol8mnrssGSQtNLHlvh/qx7mYuQgjhwhVt6s0E4BQkenqrFsypEf
	 6agC6QvJIKcAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6555640497;
	Tue, 25 Aug 2026 15:59:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E67FD3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E440140497
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UclkgYDc9a88 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:59:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5E2B4037B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:05 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytYF-000000003uC-2rVE; Tue, 25 Aug 2026 15:59:03 +0000
Date: Tue, 25 Aug 2026 16:59:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 05/11] mtd: ubi: block: build only with CONFIG_CMD_UBI
Message-ID: <72719d1e913f6863a1f06992c4ae8deb000df0dd.1787673209.git.daniel@makrotopia.org>
References: <cover.1787673209.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787673209.git.daniel@makrotopia.org>
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

The UBI block driver calls ubi_volume_read() and ubi_volume_write(),
which are defined in cmd/ubi.c and thus only built with CONFIG_CMD_UBI.
Selecting UBI_BLOCK without CMD_UBI, for example in a CONFIG_CMDLINE=n
build, fails to link:

  drivers/mtd/ubi/block.c: undefined reference to `ubi_volume_read'
  drivers/mtd/ubi/block.c: undefined reference to `ubi_volume_write'

Make the dependency explicit so UBI_BLOCK is only offered when CMD_UBI is
enabled. The only in-tree user, topic_miami_defconfig, already enables
CMD_UBI, so no board is affected.

Fixes: 9daad11ad17 ("drivers: introduce UBI block abstraction")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index e523a4c4707..bde8664fe80 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -116,6 +116,7 @@ config MTD_UBI_FM_DEBUG
 
 config UBI_BLOCK
 	bool "Enable UBI block device support"
+	depends on CMD_UBI
 	select BLK
 	help
 	  Enable UBI block device support using blk_ops abstraction.
-- 
2.55.0
