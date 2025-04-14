Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21E5C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15DD82757;
	Mon, 14 Apr 2025 22:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="BimIk3WV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBFD8214B; Mon, 14 Apr 2025 22:01:56 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C527F8219C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DdjkaNv2bm+MOH5qNHlSCnn684/XTAGlhPB9iACSV0g=; b=BimIk3WVXWJ96GdzLORzkhqpfp
 FBiOfaRwnWZnbaXyDkwW1x48GolMspipGtEXTrKrOOOuy7tUFuPRnLtiIDXRJnK/lTV3ePDCAyY/S
 NA+B39MJ/8xhbZ/nkp7+I+jzp5lG6fChgG/bIjNRrQiZd760sv8Z4VZ2SNZplGSflk78FtdciXqcw
 2N8dsQow5Zk2u/9Wcok5zlu8ZJeAa5LII3OQkta6fshzBkHWnQ+6y7XM6YhAuJh0GPyrlVvvCwpo7
 Eow3exI8iVsejM4uykzOJ39P9HVuf6X9/XsEC4hCd1QoZFb32OBVKxy2IMyZEcTe1QXHVAVJ7eQTW
 2MZJvYIw==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzx-0001rf-1N; Mon, 14 Apr 2025 22:01:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v2 09/16] rockchip: otp: Add support for RK3576
Date: Mon, 14 Apr 2025 22:01:04 +0200
Message-ID: <20250414200111.1357867-10-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
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

Add support for RK3576 compatible.
The RK3576 OTP uses the same read mechanism as the RK3588, just
with different values for offset and size.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/misc/rockchip-otp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
index b5597de39ac..46820425a84 100644
--- a/drivers/misc/rockchip-otp.c
+++ b/drivers/misc/rockchip-otp.c
@@ -361,6 +361,13 @@ static const struct rockchip_otp_data rk3568_data = {
 	.block_size = 2,
 };
 
+static const struct rockchip_otp_data rk3576_data = {
+	.read = rockchip_rk3588_otp_read,
+	.offset = 0x700,
+	.size = 0x100,
+	.block_size = 4,
+};
+
 static const struct rockchip_otp_data rk3588_data = {
 	.read = rockchip_rk3588_otp_read,
 	.offset = 0xC00,
@@ -391,6 +398,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
 		.compatible = "rockchip,rk3568-otp",
 		.data = (ulong)&rk3568_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-otp",
+		.data = (ulong)&rk3576_data,
+	},
 	{
 		.compatible = "rockchip,rk3588-otp",
 		.data = (ulong)&rk3588_data,
-- 
2.47.2

