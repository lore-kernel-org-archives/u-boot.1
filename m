Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28743C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E4A780FFA;
	Thu, 30 Jul 2026 14:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsTHlOOJYbhh; Thu, 30 Jul 2026 14:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D52C80D47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420803;
	bh=LNBDIaIO5zs5GKlboYQYuqpEAaw18HqfY7TzmQWyPoI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r0LF8zv76CizlQF82gTIVOdj9Cbjs1+AznN6jpaDcqKpo3xTh4BAKz3FuAwMADZK7
	 xJC7tvq98ota2yD7txXjAnWlta7n/KrQvZ+Y3n/pAvCtvU2rpzg8LbT1DkcGTn5l14
	 hfOPzPUVwnJzMFJOb21BD01VjYrf7stQARwhUpp7pR6gv5+E3Em/azl4hcmlFvKzv/
	 kl2zNEl8UXZZyw2AvkOhdGOqHjS1XYKVEseA5YHIKdFj97Lj9ehCBnn6gUc9u4as38
	 DGdEiZKU/MuEfwWNBM/LShYOaPVsHtD0pgUgLk/XirwDk0mFLJoSk9bYCKy3DDQevC
	 UNa7O0BO613nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D52C80D47;
	Thu, 30 Jul 2026 14:13:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2BC569
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98CB680FDD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lP4tL513mjOg for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BCCF380CBD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCCF380CBD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCCF380CBD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:18 +0000 (UTC)
X-Forward-Email-ID: 6a6b5bfba254ae338c091652
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/15] rockchip: Miscellaneous RK35xx clock fixes
Date: Thu, 30 Jul 2026 14:12:49 +0000
Message-ID: <20260730141308.1218014-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785420798;
 bh=LNBDIaIO5zs5GKlboYQYuqpEAaw18HqfY7TzmQWyPoI=;
 b=IPgatAT+ZoAyWo7YEEGqU9AYGM+N2Oy4xNF8CAwgHPGo+ztjeNIDcLSrceJPY1y9J2IxClaAW
 04W2YDqAsdl2B2By+efetZBiWGXNK1ea6e63QsS9XMXnmRAm+6CuAQOKpEqAyGj4WJkVV//bohH
 z8xOzLvFoh8lqqraIFUAS8vnpP9QbbIiWty6vmZznxj44huoYQyJhkU4qxt0uAaIfcGPcb6KLUF
 0ekI30v/K96wAoG0GfW9INumSIwITzZltOeY7JRYYUqCTnKu5YSgVS7AW/IxmihfIbEgP+tstFF
 rcUSEC0rfQVpyu4av8R0gBeqG5hKKI8ndfnSarEkor1g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=IPgatAT+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series fixes a few trivial copy-paste mistakes and other misc clock
issues for RK35xx SoCs.

Patch 1-3 fixes minor and very unlikely issues for plls
Patch 4 fixes PPLL mode handling on RK3588/RK3576
Patch 5 disable 'special pll handling' for RK3576 plls
Patch 6-7,11-13 fixes trivial clock configuration errors
Patch 8-9 fixes less trivial clock configuration errors
Patch 14-15 remove unused GRF syscon lookups

Some of these fixes has only been compile tested as it involves clocks
or rates that is rarely used in U-Boot.

The 'special pll handling' should ideally be moved into clk_rk3588
driver, something that can be done in a future follow-up series.

Jonas Karlman (15):
  clk: rockchip: pll: Fix double use of postdiv1
  clk: rockchip: pll: Always write the dsmpd flag
  clk: rockchip: pll: Always write the k param
  clk: rockchip: pll: Use PLL_FIXED_MODE flag on rk3588/rk3576 plls
  clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
  clk: rockchip: rk3568: Fix trivial clock configuration errors
  clk: rockchip: rk3588: Fix trivial clock configuration errors
  clk: rockchip: rk3588: Fix possible divide by zero
  clk: rockchip: rk3588: Fix ACLK_BUS_ROOT rate set during probe
  clk: rockchip: rk3588: Use SPLL_HZ constant
  clk: rockchip: rk3576: Fix trivial clock configuration errors
  clk: rockchip: rk3528: Fix trivial clock configuration errors
  clk: rockchip: rk3506: Fix trivial clock configuration errors
  clk: rockchip: rk3568: Drop unused GRF syscon lookup
  clk: rockchip: rk3588: Drop unused GRF syscon lookup

 .../include/asm/arch-rockchip/cru_rk3568.h    |  1 -
 .../include/asm/arch-rockchip/cru_rk3576.h    |  5 +-
 .../include/asm/arch-rockchip/cru_rk3588.h    |  6 +-
 drivers/clk/rockchip/clk_pll.c                | 56 ++++++++++---------
 drivers/clk/rockchip/clk_rk3506.c             |  2 +
 drivers/clk/rockchip/clk_rk3528.c             |  7 ++-
 drivers/clk/rockchip/clk_rk3568.c             | 12 ++--
 drivers/clk/rockchip/clk_rk3576.c             | 26 ++++-----
 drivers/clk/rockchip/clk_rk3588.c             | 39 ++++++-------
 9 files changed, 72 insertions(+), 82 deletions(-)

-- 
2.54.0

