Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A81CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE66D87C82;
	Sun, 31 Mar 2024 22:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xAZS7DAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67E8882AA; Sun, 31 Mar 2024 22:30:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA6087FE8
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711916996; bh=ATeHjUqXV3ohVg342WOwm6RDm5mbspGBteGAUpxgdZc=;
 b=xAZS7DAx+r6sYolK72rmcgqdWnXHT5SN5haYVvsKqsIVRjz3k8zHOO/+DTAUX71DUtIqKwjC7
 URVFTcn3spC6ztzcDiVpkhBc05yfPaAfBw/d3G78Xu0/NZFcs4xpGoRgGH2yk9emraUrjrH1yEM
 xMug442Tl4M1GemChwuarY0/bJSqLWmtc6IzIxNPetKD29bzwkjjTcfgNAquH8/6Yzs/vBPurhy
 j3yfM69eYbDTlueas0pdB2129u90lomXwjWrOom/TTXOYrxosL5DfRd28SurlM3pWRpbh7BcFNo
 HCeeq20Qmf2HfVNfxI+8cduk+whezUQE0Xb/VOWGyxlg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/31] rockchip: rk3399: Imply support for GbE PHY
Date: Sun, 31 Mar 2024 20:28:12 +0000
Message-ID: <20240331202921.262323-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7c28fc6b45ed44f72b8
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

Imply support for GbE PHY status parsing and configuration when support
for onboard ethernet is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index e18d7f373f77..a07ad38f2efc 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -270,6 +270,7 @@ config ROCKCHIP_RK3399
 	imply MISC_INIT_R
 	imply OF_LIVE
 	imply PARTITION_TYPE_GUID
+	imply PHY_GIGE if GMAC_ROCKCHIP
 	imply PRE_CONSOLE_BUFFER
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
-- 
2.43.2

