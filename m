Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43A0C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3544F87876;
	Thu, 25 Jul 2024 11:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="J9iLvOrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00561876EA; Thu, 25 Jul 2024 11:46:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7D086E35
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fa7d=OZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1721900778;
 bh=OByK4hGp+aWKwNXxXa9LUEjCntiDT5hnQbPT9ObN2LM=;
 b=J9iLvOrvvQ7Hb7RKp/bd4NS5+2C6kPpVwrh8leJxl6rYsKsSyGaB/1D4jKRC+lzp9uzmxXnJn
 7k4pIHyoOTfvtBDpGYA2kBIU+v0AgQkSCuT3OPLN9mgAumKuJNeP5iqcVmVZg8W/Kv0PeL+rTqS
 31bZe0RcYqrR/zU3BudNajewKoo/mnAxIVRCwTINAKhOByTwG5lRWE7NhyapTz+gW1hNJGyrq+k
 8YtwCwGCPaR8fiv+jHVyyo9NauiGzmesoSn0nV+xW6H9MhIopyxU4Wb+M689/VboMsZ5/2FW/jY
 eFb/NMJrA+Twq68JE4SEPLgMF6tJEbbWAykS1kmlEkcg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Remove files that can be included from
 dts/upstream
Date: Thu, 25 Jul 2024 09:46:02 +0000
Message-ID: <20240725094609.3113632-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a21ee6fa07ff5ac5ecd3ca
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

Most Rockchip aarch64 targets have now migrated to use OF_UPSTREAM,
however a few of the old dtsi and dt-bindings files still remain.

This series remove remaining dtsi and header files that can be included
directly from dts/upstream.

No changes is expected with this series.

Jonas Karlman (2):
  rockchip: px30/rk3326: Use soc dtsi files from dts/upstream
  rockchip: Use files from dts/upstream

 arch/arm/dts/px30-firefly.dts                |    4 +
 arch/arm/dts/px30-u-boot.dtsi                |    4 +
 arch/arm/dts/px30.dtsi                       | 2415 ------------------
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi   |    4 +
 arch/arm/dts/rk3326.dtsi                     |   15 -
 arch/arm/dts/rockchip-pinconf.dtsi           |  344 ---
 include/dt-bindings/clock/px30-cru.h         |  389 ---
 include/dt-bindings/clock/rockchip,rk808.h   |   11 -
 include/dt-bindings/power/px30-power.h       |   27 -
 include/dt-bindings/soc/rockchip,boot-mode.h |   16 -
 include/dt-bindings/soc/rockchip,vop2.h      |   18 -
 11 files changed, 12 insertions(+), 3235 deletions(-)
 delete mode 100644 arch/arm/dts/px30.dtsi
 delete mode 100644 arch/arm/dts/rk3326.dtsi
 delete mode 100644 arch/arm/dts/rockchip-pinconf.dtsi
 delete mode 100644 include/dt-bindings/clock/px30-cru.h
 delete mode 100644 include/dt-bindings/clock/rockchip,rk808.h
 delete mode 100644 include/dt-bindings/power/px30-power.h
 delete mode 100644 include/dt-bindings/soc/rockchip,boot-mode.h
 delete mode 100644 include/dt-bindings/soc/rockchip,vop2.h

-- 
2.45.2

