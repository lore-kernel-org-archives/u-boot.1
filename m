Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F12CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BCD83971;
	Tue, 28 Oct 2025 17:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E0883965; Tue, 28 Oct 2025 17:57:52 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8879838C8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwxQ63wTrzFXY;
 Tue, 28 Oct 2025 17:57:50 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwxQ569yDznDv; Tue, 28 Oct 2025 17:57:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Oct 2025 17:57:37 +0100
Subject: [PATCH 4/4] rockchip: spl_common: fix TIMER_FMODE constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-px30-rk3306-common-tpl-v1-4-251aba72de7c@cherry.de>
References: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
In-Reply-To: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The free running mode is 0 at bit offset 1. User mode is 1 at bit offset
1. Currently, free running mode is 1 at offset 0, which is already the
case thanks to TIME_EN.

So, this essentially does not change the actual value written to the
register as it is TIME_EN | TIMER_FMODE which currently is 0x1 | BIT(0)
= 0b1, and will become 0x1 | (0 << 1) = 0b1.

I checked PX30, RK3128, RK3188, RK3228, RK3288, RK3308, RK3328, RK3368
RK3506, RK3562 and RK3568 TRMs.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/spl_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl_common.c b/arch/arm/mach-rockchip/spl_common.c
index b29f33448ab..208cd22fcad 100644
--- a/arch/arm/mach-rockchip/spl_common.c
+++ b/arch/arm/mach-rockchip/spl_common.c
@@ -10,8 +10,8 @@
 #define TIMER_LOAD_COUNT_H	0x04
 #define TIMER_CONTROL_REG	0x10
 #define TIMER_EN	0x1
-#define	TIMER_FMODE	BIT(0)
-#define	TIMER_RMODE	BIT(1)
+#define	TIMER_FMODE	(0 << 1)
+#define	TIMER_RMODE	(1 << 1)
 
 __weak void rockchip_stimer_init(void)
 {

-- 
2.51.0

