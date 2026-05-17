Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353F5CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C62846A5;
	Sun, 17 May 2026 21:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="X1OCh2s6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D7A83EF9; Sun, 17 May 2026 21:24:59 +0200 (CEST)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [178.154.239.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB23D845E3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id F145CC0009;
 Sun, 17 May 2026 22:24:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-pqAMmCI2; 
 Sun, 17 May 2026 22:24:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045896; bh=eqwalwiYND/MvfmLxAEjUlEshfv60kbwi0MgiW6RNZg=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=X1OCh2s6Mp0JzoHYVn9/MerPLip1wtyytakuQrA9x3OqAF4VY1IX4oQMgCMeLLclU
 Gdxzrj4R4TRGtvwOtGnwRzolESZOzaiyU9YLAbEPZL3H93Hz4Xp+HX1jZIpM0LLydx
 FqHil2QNzdDYGeP6JyqTdKDxPpl5sfwAMJIoUxNk=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:30 +0300
Subject: [PATCH RFC 04/18] rockchip: rk3568: syscon: Add MSCH, SGRF and
 DDRGRF support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-4-a24e16302a13@ya.ru>
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

Add support for the MSCH, SGRF and DDRGRF register regions in syscon,
which are necessary for RK3568's DRAM controller initialization.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 arch/arm/include/asm/arch-rockchip/clock.h    |  1 +
 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 95b08bfd046..a6b399da4ff 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -39,6 +39,7 @@ enum {
 	ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
 	ROCKCHIP_SYSCON_VOP_GRF,
 	ROCKCHIP_SYSCON_VO_GRF,
+	ROCKCHIP_SYSCON_DDRGRF,
 };
 
 /* Standard Rockchip clock numbers */
diff --git a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
index b9d59a4721e..7f6caf9ca67 100644
--- a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
@@ -8,8 +8,11 @@
 #include <asm/arch-rockchip/clock.h>
 
 static const struct udevice_id rk3568_syscon_ids[] = {
-	{ .compatible = "rockchip,rk3568-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ .compatible = "rockchip,rk3568-grf",    .data = ROCKCHIP_SYSCON_GRF    },
 	{ .compatible = "rockchip,rk3568-pmugrf", .data = ROCKCHIP_SYSCON_PMUGRF },
+	{ .compatible = "rockchip,rk3568-msch",   .data = ROCKCHIP_SYSCON_MSCH   },
+	{ .compatible = "rockchip,rk3568-sgrf",   .data = ROCKCHIP_SYSCON_SGRF   },
+	{ .compatible = "rockchip,rk3568-ddrgrf", .data = ROCKCHIP_SYSCON_DDRGRF },
 	{ }
 };
 
@@ -37,4 +40,25 @@ U_BOOT_DRIVER(rockchip_rk3568_pmugrf) = {
 	.of_match = rk3568_syscon_ids + 1,
 	.bind = rk3568_syscon_bind_of_plat,
 };
+
+U_BOOT_DRIVER(rockchip_rk3568_msch) = {
+	.name = "rockchip_rk3568_msch",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3568_syscon_ids + 2,
+	.bind = rk3568_syscon_bind_of_plat,
+};
+
+U_BOOT_DRIVER(rockchip_rk3568_sgrf) = {
+	.name = "rockchip_rk3568_sgrf",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3568_syscon_ids + 3,
+	.bind = rk3568_syscon_bind_of_plat,
+};
+
+U_BOOT_DRIVER(rockchip_rk3568_ddrgrf) = {
+	.name = "rockchip_rk3568_ddrgrf",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3568_syscon_ids + 4,
+	.bind = rk3568_syscon_bind_of_plat,
+};
 #endif

-- 
2.25.1

