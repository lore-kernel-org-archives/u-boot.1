Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C8C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CAA388B51;
	Wed,  1 May 2024 18:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AF57F1Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C52A88B4C; Wed,  1 May 2024 18:23:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C4D88B07
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714580601; bh=V+PcrZLPjR73Gk8MyiymIPaUk0pr0sGRjV0U9VTKfe8=;
 b=AF57F1WfC37jdImbwyoWWSKigicdB2aaF/cvi4yd+5FLezVzZL6rJCNMKBhVdkrGxIUirlQ3n
 ob5zY998k5n6aS5bh08nDU341tO/PnObCLKL8j7Btvpp0B+Vn0yIHKbbMqyDy4COV1brrfHauhz
 hvR80jKDXEU5mRu97auXRK0hDuT9PCmZC6zKjy0aZRGxQKNcgoeCNEzZxrQKPh1I8Z00tONrNs+
 tc7qZPL++sH9uAjcO5pug9a5bLyfrK960pLuoSZDostDPjSKGDyCg34ZWKbJKhitQQ7JoM+FBen
 zpdNBS2JGK94W0/CGAuaPd++kf5dC0gH7/InEpnf6/xg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 02/22] clk: rockchip: rk3399: Add dummy support for
 ACLK_VDU clock
Date: Wed,  1 May 2024 16:22:19 +0000
Message-ID: <20240501162308.875193-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501162308.875193-1-jonas@kwiboo.se>
References: <20240501162308.875193-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66326c793e72fadc559db9ad
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

rk3399.dtsi from linux v5.19 and newer try to set VDU clock rate to
400 MHz using an assigned-clock-rates prop of the CRU node.

U-Boot does not use or need this clock so add dummy support for getting
and setting ACLK_VDU clock rate to allow CRU driver to be loaded with an
updated rk3399.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3399.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index f0ce54067f8c..5934771b4096 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -971,6 +971,7 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 	case ACLK_HDCP:
 	case ACLK_GIC_PRE:
 	case PCLK_DDR:
+	case ACLK_VDU:
 		break;
 	case PCLK_ALIVE:
 	case PCLK_WDT:
@@ -1061,6 +1062,7 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
 	case ACLK_HDCP:
 	case ACLK_GIC_PRE:
 	case PCLK_DDR:
+	case ACLK_VDU:
 		return 0;
 	default:
 		log_debug("Unknown clock %lu\n", clk->id);
-- 
2.43.2

