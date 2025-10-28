Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D250ACCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F36283948;
	Tue, 28 Oct 2025 17:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E1283957; Tue, 28 Oct 2025 17:57:50 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923A8838C8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwxQ40t9vzGnr;
 Tue, 28 Oct 2025 17:57:48 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwxQ304tZznmL; Tue, 28 Oct 2025 17:57:46 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/4] rockchip: use rockchip_stimer_init from spl_common.c
 on PX30/RK3036 + "cosmetic" fix
Date: Tue, 28 Oct 2025 17:57:33 +0100
Message-Id: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP31AGkC/x3MQQqEMAxA0atI1gZiqqJeRVwMGmeC2pZWpCDef
 YrLt/j/hihBJcJQ3BDk0qjOZlRlAfPvY7+CumQDEzcVcYc+GcKwGUMtzu44nMXT79hR3xpeqeG
 lhhz7IKumdzxOz/MHFs5peGgAAAA=
X-Change-ID: 20251028-px30-rk3306-common-tpl-809632f052d4
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

This adds PX30 and RK3036 to the list of SoCs using the same
implementation for its timer init via the weak function in spl_common.
It seems there is a mix of version IP in RK35 series as RK3506, RK3562
and RK3566/RK3568 are using something similar to the "old" SoCs but
RK3528, RK3576 and RK3588 use a different one. RK3399 also has slightly
different implem compared to the old IP where we write zeroes to two
more registers (and the control register is at a different address).

Also fix the improper value of free running mode for the timer on
function to use for the old IP + RK3399. Luckily, the mistake doesn't
actually change the value written to the register before and after the
fix so no intended change.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      rockchip: px30: use rockchip_stimer_init from spl_common.o for TPL
      rockchip: rk3036: use rockchip_stimer_init from spl_common.o
      rockchip: rk3399: fix TIMER_FMODE constant
      rockchip: spl_common: fix TIMER_FMODE constant

 arch/arm/mach-rockchip/Makefile           |  4 ++--
 arch/arm/mach-rockchip/px30-board-tpl.c   | 28 +++-------------------------
 arch/arm/mach-rockchip/rk3036-board-spl.c | 21 +--------------------
 arch/arm/mach-rockchip/rk3399/rk3399.c    |  4 ++--
 arch/arm/mach-rockchip/spl_common.c       |  4 ++--
 5 files changed, 10 insertions(+), 51 deletions(-)
---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251028-px30-rk3306-common-tpl-809632f052d4

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

