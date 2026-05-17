Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEA5CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080D084690;
	Sun, 17 May 2026 21:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="Fk9JSu1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6236F845E3; Sun, 17 May 2026 21:24:57 +0200 (CEST)
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBFB8465A
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward101b.mail.yandex.net (Yandex) with ESMTPS id B7E4DC0083;
 Sun, 17 May 2026 22:24:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-SWorc5ZE; 
 Sun, 17 May 2026 22:24:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045893; bh=PmYaJAN5dQ5tYAgjCVsL7oGGJOyRitwdCGtZvKD6AsE=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Fk9JSu1bPAlQIqRTJc5SGG7vq3oWk5wbZPNkhV/NEn3rr2nEtK8Phy7J5reVFQc2c
 olNx25jrxST16GY7R2FYG68dX4G5qPruHGnnrgm+ZnFR/iJKbfWgYc9Gzlb2c/lWSI
 8W5GiMiwqCUN02Mb+yWlOoam0gYwRHN712OEE/qQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:28 +0300
Subject: [PATCH RFC 02/18] clk: rockchip: rk3568: Fix probe with
 OF_PLATDATA enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

Properly initialize cru address space reference when CONFIG_OF_PLATDATA
is enabled.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 drivers/clk/rockchip/clk_rk3568.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 67bc04b81c0..199bb51fa6f 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <dt-structs.h>
 #include <errno.h>
+#include <mapmem.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/cru_rk3568.h>
 #include <asm/arch-rockchip/clock.h>
@@ -2906,8 +2907,14 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 static int rk3568_clk_probe(struct udevice *dev)
 {
 	struct rk3568_clk_priv *priv = dev_get_priv(dev);
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+	struct rk3568_clk_plat *plat = dev_get_plat(dev);
+#endif
 	int ret;
 
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
+#endif
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR(priv->grf))
 		return PTR_ERR(priv->grf);
@@ -2926,9 +2933,11 @@ static int rk3568_clk_probe(struct udevice *dev)
 
 static int rk3568_clk_ofdata_to_platdata(struct udevice *dev)
 {
-	struct rk3568_clk_priv *priv = dev_get_priv(dev);
+	if (CONFIG_IS_ENABLED(OF_REAL)) {
+		struct rk3568_clk_priv *priv = dev_get_priv(dev);
 
-	priv->cru = dev_read_addr_ptr(dev);
+		priv->cru = dev_read_addr_ptr(dev);
+	}
 
 	return 0;
 }

-- 
2.25.1

