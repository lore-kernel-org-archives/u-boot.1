Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C340D5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 21:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC478929F;
	Sat,  9 Nov 2024 22:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VWMOdSZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57C88929F; Sat,  9 Nov 2024 22:04:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24B189304
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 22:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ff=SF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1731186283; bh=PRzpyvogan/zQ7l7qVuO3kClpSJ+PcakDk1gIq6aA3c=;
 b=VWMOdSZnIg+5ge9RPuV5cB57uAM/pW8MGZxJdmMD8pxVRJ8spzA+UshemqR1Hmyy0xqwLTnuD
 9h4uK2W1IPFF4XlKlPiUO4VNxxzDkkPJJnu9bCDSZ7idBZEuQ0IjOpge6TQro7uch2stUpSNQ3W
 +veIWVs7Ay76BCTCEmxojNjFdF25N165OTBfBue5HnVLEhUWgoCFtWNX7WXuo/y+UHkp1qjxks9
 ltuHcHWj3A98Q9dMbMYtpFx1sUaf95dZ7xzL4436FtaYq7jOdDPkkmPri3szUogBJH869eCNA8O
 6W1D18CbCUI6XSCsZGGih6LZ7+PZr8UciNOcaj/eG6CQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/4] rockchip: rk3288: Use rk3288-power.h from dts/upstream
Date: Sat,  9 Nov 2024 21:04:09 +0000
Message-ID: <20241109210427.884888-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241109210427.884888-1-jonas@kwiboo.se>
References: <20241109210427.884888-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672fce6aebcd1468e2815bd0
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

power/rk3288-power.h in include/dt-bindings is identical to the version
in dts/upstream, remove the copy from include/dt-bindings to only use
the version from dts/upstream.

No functional change to board DTs is intended with this removal.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
---
 include/dt-bindings/power/rk3288-power.h | 32 ------------------------
 1 file changed, 32 deletions(-)
 delete mode 100644 include/dt-bindings/power/rk3288-power.h

diff --git a/include/dt-bindings/power/rk3288-power.h b/include/dt-bindings/power/rk3288-power.h
deleted file mode 100644
index f710b56ccd81..000000000000
--- a/include/dt-bindings/power/rk3288-power.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_BINDINGS_POWER_RK3288_POWER_H__
-#define __DT_BINDINGS_POWER_RK3288_POWER_H__
-
-/**
- * RK3288 Power Domain and Voltage Domain Summary.
- */
-
-/* VD_CORE */
-#define RK3288_PD_A17_0		0
-#define RK3288_PD_A17_1		1
-#define RK3288_PD_A17_2		2
-#define RK3288_PD_A17_3		3
-#define RK3288_PD_SCU		4
-#define RK3288_PD_DEBUG		5
-#define RK3288_PD_MEM		6
-
-/* VD_LOGIC */
-#define RK3288_PD_BUS		7
-#define RK3288_PD_PERI		8
-#define RK3288_PD_VIO		9
-#define RK3288_PD_ALIVE		10
-#define RK3288_PD_HEVC		11
-#define RK3288_PD_VIDEO		12
-
-/* VD_GPU */
-#define RK3288_PD_GPU		13
-
-/* VD_PMU */
-#define RK3288_PD_PMU		14
-
-#endif
-- 
2.46.2

