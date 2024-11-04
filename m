Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6FCD1BDED
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 20:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9881488E1C;
	Mon,  4 Nov 2024 21:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UAkIpX8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DD488E50; Mon,  4 Nov 2024 21:26:03 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A102988DE6
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 21:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72d1=SA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730751950;
 bh=RhPJLVmVWi/TPZwatdHH87g5WV1aJanEVXd3KanGwPQ=;
 b=UAkIpX8BI6xYpb+clLbT0zjjWlu2A6l4NUWnOHOBq5ZLV5mzWf4qD5zIM428d0Yd7vlgOflck
 eT9k2VjAgyuXn1nfveEQLdT6TRHKLcgr7fEXA89sZIiDNcBxq0V7g5JXpPo4CptjlTM/MOpY3s5
 KyHbwGdw6/VE2t5X93Ybpn6fufd/70G9lc+QN3nlQmjJehb38Ae8dt+swyzxOGLqp4eqNEpjYGe
 bkB3gXaHi/QcXQI4/3aqzv6G5xeqh9UPg6wrqCqL/08zYVILNCWVA+AQHGOcH8+79jAFRI8FxvP
 JUCRAgoOMyZpT3vBI6rmulzqgqdJ20PBKMVWyZTEKeRA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3288: Fix bootph prop for vop nodes
Date: Mon,  4 Nov 2024 20:25:40 +0000
Message-ID: <20241104202543.977008-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67292dce69a511a84def4d08
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

The vop nodes does not need to be included in xPL control FDT, they only
need to be included at U-Boot proper pre-reloc phase.

Change to use bootph-some-ram prop to fix this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
index a43d320ade7b..c51bfca65604 100644
--- a/arch/arm/dts/rk3288-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-u-boot.dtsi
@@ -128,11 +128,11 @@
 };
 
 &vopb {
-	bootph-all;
+	bootph-some-ram;
 };
 
 &vopl {
-	bootph-all;
+	bootph-some-ram;
 };
 
 &xin24m {
-- 
2.46.2

