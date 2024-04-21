Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042BAC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6328830B;
	Sun, 21 Apr 2024 22:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OU0FFixZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987D487EDC; Sun, 21 Apr 2024 22:12:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4711B8830B
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1713730357;
 bh=hp94nca7BOgm08UyUik8usty2ligzUN6i2S7+3TBhDw=;
 b=OU0FFixZVPrbhv/U1mVfJYshaDqhe0r4EWMIVTq4Ec5LlFBilSTUUikV5lGQMHx/0qtTQ4rA6
 OjPrSfWBfQQppYww8Dcpo/ABik+/5zHBwU7PpqINIFyhIKiM4N5dtRMia6Mf9XFFXOaRTSSCYjI
 R1do2r60+JtO+CY6sKq2a6kH2rkNYYSlBq9j+qKQrEEnVm5MHQCLzyzu1Ho4/sJDkVDGv/O7rgz
 7LO93YFlhe7fLzafUS+MZrM55OYF4n45SM4UQp5YAb85CtUw3Lga7CH4cDP3sHfOlaVTsP9yGyH
 oVd7IgXBMqYCkCR0OAJNP4vMcfYVNRElMOsReGAh/96Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] rockchip: rk3328: Fix bootph prop for vop node
Date: Sun, 21 Apr 2024 20:12:29 +0000
Message-ID: <20240421201231.520328-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66257334d283e311fc8ea963
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

The vop node should not be included in TPL/SPL control FDT, it should
only be included at U-Boot proper pre-reloc phase.

Change to use bootph-some-ram prop to fix this.

Fixes: 6794063d5065 ("ARM: dts: rk3328: Enable VOP for bootph-all")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3328-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index 7c5067cf002e..d3608bd0e2b2 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -131,7 +131,7 @@
 };
 
 &vop {
-	bootph-all;
+	bootph-some-ram;
 };
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-- 
2.43.2

