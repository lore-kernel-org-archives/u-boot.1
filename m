Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC136C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0840188890;
	Wed, 24 Jul 2024 08:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uSHd3Vna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCEC88886; Wed, 24 Jul 2024 08:56:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AB7888A2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=SRS0=3f2b=OY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1721804151;
 bh=43A7FbcmuoZ3M/HdlTpZfZIDiC2DfBXI3yJLqLlk4Zk=;
 b=uSHd3Vna6dTqaCUt9yz2u4LvHIALLNskrNnjYhpkx2wmh0rVkLYagflmXOwuG3gyIMH3gjJOX
 dntGagNETcusXGoUzAnHG/Z/s62MAk1DPOzRTN0ZYFBi76tbum68yaHXtACFRHj1JGTsTENc0vl
 X2bf2RhpFx9onXyEKkZ+rxWU+qEyDAGFl1qWvSPnYXqf+N/KrS87joIweoUAZqBMj5yV8GhYKxD
 mmDpYBbzT854K80wDmmkR+1Ve1nQmyM7oY+oPVmN6aM4XhuFEGLhWJf3OWRYu0Cfy8gZ533TCx3
 x5fc30rNdopJBJS80k7VOkFsY51iwj04dB8EWUdAi5JQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] mmc: rockchip_dw_mmc: Allow 4-bit mode when 8-bit mode is
 supported
Date: Wed, 24 Jul 2024 06:55:36 +0000
Message-ID: <20240724065538.2735237-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a0a572964f016be2adfbcc
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

Hosts capable of 8-bit can also do 4 bits, fix use of 4-bit mode when
8-bit mode is supported.

This fixes use of 1-bit mode with SD NAND on ROCK Pi S using the DT in
v6.11-rc1 that chage to use 8-bit bus to also support eMMC. With this
4-bit mode is used with SD NAND and 8-bit mode with eMMC, same as in
Linux kernel.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mmc/rockchip_dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 1a10b7057a47..549fb80f1988 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -159,6 +159,10 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 	host->mmc->dev = dev;
 	upriv->mmc = host->mmc;
 
+	/* Hosts capable of 8-bit can also do 4 bits */
+	if (host->buswidth == 8)
+		plat->cfg.host_caps |= MMC_MODE_4BIT;
+
 	return dwmci_probe(dev);
 }
 
-- 
2.45.2

