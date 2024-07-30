Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14D2C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3D8888C6;
	Tue, 30 Jul 2024 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tM2o7CJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6480B888BE; Tue, 30 Jul 2024 16:52:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81274887B9
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722351145; bh=iOwbA8xGvBi6/FC1Xa5TxiTw6pd1HiNlMP2eCX3D86Q=;
 b=tM2o7CJwxSrw3kpSoeAeZvF60aL2B+lZAA1cE+KXP5mzfrQGYa9gm4ISfDzMltQ/Kpb/H8sgb
 xaluazbPFLCuJqNcM4OaW4dPlO91br+8OJiKUpzaEjXYFbU91T00CeCFYoU9HCHhCe70wOa+l+V
 PSyf+66kd2gj/e6LFyDpoSYgev1XCQq+pMBSpCyW4Y4MeH57XLLfSZKh1izuD4cwoAGEF+RbTE8
 0t1NsyLnzEOhuBwCkKDgmk3v+XZiwuNf1oo1cClKyuM1ZIlxSodittAeBYWH9qjPVLek6CE/8VY
 tw3lsGeLyLmJIaj27JDOAwxXJYmggi/I3gpxDC1etPNA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 8/8] rockchip: rk3308-rock-pi-s: Enable LED and IO Domain
 driver
Date: Tue, 30 Jul 2024 14:51:48 +0000
Message-ID: <20240730145148.849245-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730145148.849245-1-jonas@kwiboo.se>
References: <20240730145148.849245-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a8fe2588a51d097cb15640
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

Add LED=y and LED_GPIO=y to support the onboard leds.

Add ROCKCHIP_IODOMAIN=y to configure correct io voltage domains.

Add DM_MDIO=y now that the DT contain a Ethernet phy node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/rock-pi-s-rk3308_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index e450a0618020..54f7744c9895 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -38,10 +38,14 @@ CONFIG_CLK=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
-- 
2.45.2

