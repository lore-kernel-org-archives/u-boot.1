Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA0E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448CE801ED;
	Fri, 13 Dec 2024 00:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZGpbOKut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADE280141; Fri, 13 Dec 2024 00:57:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74495801A0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047870; bh=65vJyzfUZpZFIpU5ZNZTdT1wyNyGrMIJr4QYZtDFQvs=;
 b=ZGpbOKut+Uez7+wtuNbh0NVnr9XEkSbB5iOcR1/06E47bQ9whPM6PYqxUDTarwkPY68t1niEn
 tLJ8355USktS+p8xGdNv6x0GGhEL8dvpEkigme/WO6VaOmGCYfXhVYjQt0ENxGAUoXiNl8YSNCa
 vgFPuVq305kWua0vDQ9yg0pIbSBzdl86yo+/7x7nsgwfTbq+x+J8DxYFoW+t8d0idd7Jw+QiZ/X
 QLQy3HOimGeLBJuaJig+v2r/rFXLjqUcPLwYYMf/gpQn4OGPSri3gIcr3yVEP1OwZPs0uD9MV7t
 SiHJXPS7AH1dn6vBAIrePJzU5OlHpvpgEx9CICF1lhdg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/12] rockchip: rk3399: Fix TPL build of bob and kevin
Date: Thu, 12 Dec 2024 23:57:08 +0000
Message-ID: <20241212235735.164272-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b787aa511ed8f0b3fe25e
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

Building chromebook_bob/kevin with TPL=y ends with a linking error:

  arch/arm/mach-rockchip/rk3399/rk3399.o: in function `board_debug_uart_init':
  arch/arm/mach-rockchip/rk3399/rk3399.c:148:(.text.board_debug_uart_init+0x34):
    undefined reference to `spl_gpio_output'
  arch/arm/mach-rockchip/rk3399/rk3399.c:148:(.text.board_debug_uart_init+0x34):
    relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `spl_gpio_output'

  make[2]: *** [scripts/Makefile.xpl:542: tpl/u-boot-tpl] Error 1
  make[1]: *** [Makefile:2134: tpl/u-boot-tpl] Error 2
  make: *** [Makefile:568: __build_one_by_one] Error 2

Change to only use spl_gpio functions in SPL to fix this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 0c28241c603e..ba89079b1e73 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -136,7 +136,7 @@ void board_debug_uart_init(void)
 	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
 	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
 
-	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
 	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
 	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
 		rk_setreg(&grf->io_vsel, 1 << 0);
-- 
2.47.1

