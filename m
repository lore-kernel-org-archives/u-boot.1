Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839B7CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3B5882AD;
	Sun, 31 Mar 2024 22:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h0goQ/UA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD9A87FC0; Sun, 31 Mar 2024 22:30:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC214882BF
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917032; bh=Dkqk7AZ+bxFWYT2hMfWgoKz/3R/hK76XYZmSgoLzgnM=;
 b=h0goQ/UAEnL124RwKvx2/Szs6OL/ZQFpr71KrKiQQ4/GwTbfo2kPbtycKcAZjMNzP0m7KpJOZ
 JOMAbmkBmNoB1zCwdbzuZ5WoV746ayI4yqntSPpNl2MAGQOEZyWXDFgHi9UiL7WfUxPucZJbBPh
 mzSw85zIHR2xlGAb5sAGl1Xze/0XvOZOJDkW8hXWiHj7PRISPQkmDYmyqG9/a2x1tAyHrdFhIZG
 +23cuF7knhInQBJj02DvEQBksLjTNmxWXaTsicYZR9tgZrv+ygbOl9kaEsir67xbzndXN2LjWnC
 6C0ah+RfLhyJWnRRIKcTPdb8zl9guj5OvRMqQE7IYxhQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 13/31] clk: rockchip: rk3399: Add dummy support for
 SCLK_PCIEPHY_REF clock
Date: Sun, 31 Mar 2024 20:28:19 +0000
Message-ID: <20240331202921.262323-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7e68fc6b45ed44f734c
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

rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
SCLK_PCIEPHY_REF clock.

The existing enable/disable ops for SCLK_PCIEPHY_REF already handles
setting correct parent once the clock gets enabled. And 100 MHz is the
default rate used for this clock.

Add dummy support for setting parent, getting and setting clock rate of
the SCLK_PCIEPHY_REF clock to allow use of PCIe on affected boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3399.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 5934771b4096..29b01abeca06 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -972,6 +972,7 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 	case ACLK_GIC_PRE:
 	case PCLK_DDR:
 	case ACLK_VDU:
+	case SCLK_PCIEPHY_REF:
 		break;
 	case PCLK_ALIVE:
 	case PCLK_WDT:
@@ -1063,6 +1064,7 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
 	case ACLK_GIC_PRE:
 	case PCLK_DDR:
 	case ACLK_VDU:
+	case SCLK_PCIEPHY_REF:
 		return 0;
 	default:
 		log_debug("Unknown clock %lu\n", clk->id);
@@ -1114,6 +1116,8 @@ static int __maybe_unused rk3399_clk_set_parent(struct clk *clk,
 	switch (clk->id) {
 	case SCLK_RMII_SRC:
 		return rk3399_gmac_set_parent(clk, parent);
+	case SCLK_PCIEPHY_REF:
+		return 0;
 	}
 
 	debug("%s: unsupported clk %ld\n", __func__, clk->id);
-- 
2.43.2

