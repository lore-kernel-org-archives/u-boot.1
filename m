Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA03C10F1A
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E93E882F1;
	Sun, 12 May 2024 14:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lrHrv+3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E481988087; Sun, 12 May 2024 14:17:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0163587F33
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516220; bh=keYWR38fj3EEpIwrInWyv5TAoCyeIC83ZbYcVyCPYBM=;
 b=lrHrv+3lVHV9hwCfu7os2mlrA5pysVpwQdGZ08Zk/8oaCf6OEGC2nzmTOy2JAMJlGUXDK7K4G
 qZ0nF3snoopAkuVAshrZ4K7ZWohxrBpeCW3GHowb3XvOeM8yNEcXKj1VbYsUsF7T/IvMvJnUgK0
 DbnGpmDMcM/whlf2r6Z9OTsAn/3GWnDbsLBj/iQ+OflD3FF15VHwlmYDWyJiRIGytLRuN78c2sh
 i5wg4dTz0+YHCXe3DJzKAv3de233eVzsl28e+Br4iD34xNB5VZvx17wj7Z6n3uExNeQtiAXMcgM
 fAUz1XIb1Lq1fo+s5qtvCfr6eD2oDyRnk38DNQrVULNA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 1/9] pinctrl: rockchip: rk3188: Fix support for
 IOMUX_GPIO_ONLY flag
Date: Sun, 12 May 2024 12:16:14 +0000
Message-ID: <20240512121633.1632597-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240512121633.1632597-1-jonas@kwiboo.se>
References: <20240512121633.1632597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6640b32c1cfb9f69e9a4efe8
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

GPIO0_A0-A7 on RK3188 is IOMUX_GPIO_ONLY, however, trying to set gpio
mux return an -ENOTSUPP error code. Fix this by validating using the mux
function type and not the iomux flag.

Based on Linux commit c4a532dee6b6 ("pinctrl: rockchip: handle first
half of rk3188-bank0 correctly").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Based on the old Linux commit and TRM it looks like GPIO0_B0-B7 should
also be flagged as IOMUX_GPIO_ONLY.
---
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index a423abcafb23..b6e2ab474d0f 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -189,7 +189,7 @@ static int rockchip_verify_mux(struct rockchip_pin_bank *bank,
 	}
 
 	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY) {
-		if (mux != IOMUX_GPIO_ONLY) {
+		if (mux != RK_FUNC_GPIO) {
 			debug("pin %d only supports a gpio mux\n", pin);
 			return -ENOTSUPP;
 		}
-- 
2.43.2

