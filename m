Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07BBC6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 19:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6353A882B4;
	Fri, 29 Mar 2024 20:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0gOtHauK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA7E8828C; Fri, 29 Mar 2024 20:03:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4FB8882B8
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 20:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711739014; bh=2HqMC1XhJhH0z1RUTTrW5ykBMyBH0Vk75i5/PG+ogTk=;
 b=0gOtHauK4Z/EgWFE9vqzYQ2QunYK8LfPqwufdiAIFbsni0N32Dm/RLziKawg+66B0mT6tUAf3
 iKlxy6pStV+HWYyoXLV7Mm6dHW8Mxd6xFAElgsWkqN9KfzH1KU1vEOuh1bTSRTthEO5Bvhz1bhp
 iEBjXlVOxAdXK1w94kQPkB+O6mYEdoHQnifLjQBeBng8k/iwsqjX8A1p1w0A7wAJ379uX2aAjUO
 qCLjnVncsQkXbFliukwOXTilzOB5NR1ZDOkuLKlbYZc5n257ZkXWAJHrHRfexyORXymkGuueBf5
 rqvoUYKK4pL3rJpTPXWcPOrK9rXgszUAvHEV5KYgThtg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 14/19] rockchip: rk3588-coolpi: Add boards to documentation
Date: Fri, 29 Mar 2024 19:01:55 +0000
Message-ID: <20240329190224.3613471-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240329190224.3613471-1-jonas@kwiboo.se>
References: <20240329190224.3613471-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66071084c77850cc7d0ca16c
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

Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the documentation.
Also fix .dtb-file entries in Makefile.

Fixes: 3e15dee38d45 ("board: rockchip: Add support for rk3588 based Cool Pi CM5 EVB")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile           | 4 ++--
 doc/board/rockchip/rockchip.rst | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b359259ab0fb..f49b7e5d251f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -194,8 +194,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
 	rk3568-rock-3a.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RK3588) += \
-	rk3588s-coolpi-4b.dts \
-	rk3588-coolpi-cm5-evb.dts \
+	rk3588s-coolpi-4b.dtb \
+	rk3588-coolpi-cm5-evb.dtb \
 	rk3588-edgeble-neu6a-io.dtb \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5dd5ea7f1e29..9a726e9cde63 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -131,6 +131,8 @@ List of mainline supported Rockchip boards:
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
+     - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
+     - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
 
 * rv1108
      - Rockchip Evb-rv1108 (evb-rv1108)
-- 
2.43.2

