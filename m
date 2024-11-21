Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95C6D7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF588977E;
	Thu, 21 Nov 2024 15:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="MM4lFBIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94EE89784; Thu, 21 Nov 2024 15:28:18 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B548977F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CiCogM493Lvm5rAHuc/GkT3iYIZBHFjcpbgMvlr2vfo=; b=MM4lFBIMkKuubnixV++cpdspRm
 wToQadv/SlW5oENDCXXZf8IaHOoZm8626KQzLTfbs3m03U7l2J/vbzNLsWNtJkfuGW+PD5a6D8oHW
 o6HwxZUIS+IGEmbPgyfTm9+yaZaelM3Ll0li6qoJQfG/scO640vcEvIYK+WNqnJ8En17aNQXpnOwE
 Z7Rah+CIlKibSZmQyl+OaR66TmmyXIUrvsss2oUHRfZytsBAJvO5GgcvdfmthFTV6lH2jrc6GuqRH
 uhgj7E+7hmInEMsUElAQ0ktB4f7h4nlsuF4TOPcq45E7PVBm5P2JP4hf1w+t21PeRaMGls4lZFgyy
 +JoXwCTg==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A3-0007f9-AU; Thu, 21 Nov 2024 15:27:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Xuhui Lin <xuhui.lin@rock-chips.com>
Subject: [PATCH 09/20] rockchip: mkimage: Add rk3576 support
Date: Thu, 21 Nov 2024 15:27:20 +0100
Message-ID: <20241121142731.1202209-10-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

From: Xuhui Lin <xuhui.lin@rock-chips.com>

Add support for rk3576 package header in mkimage tool.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 3e52236b15a..d89c7d3afea 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -135,6 +135,7 @@ static struct spl_info spl_infos[] = {
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
+	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
 };
 
-- 
2.45.2

