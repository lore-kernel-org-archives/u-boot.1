Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E07C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06EC832EB;
	Thu, 31 Jul 2025 01:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AqCcpRtp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51158323A; Thu, 31 Jul 2025 01:54:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2849A83278
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919641; bh=ozwahjtLMx5akIS4ugHLvCcF9oIjaHq5npvs1p7cABM=;
 b=AqCcpRtpd84/mwHGyBkf/UFGW1UHB5i/iIBYZNJl4QgOKIk2JgysniICQrx201u4NnHQMWwDt
 naMMfLVUcCHlj6YjVia1/k5OS1L3h/o/nEEC4HEclBSDEG9r2GGnhwwfq9W3kcpleUDJbcdC8Kx
 tt4NHV+dwhDRW1DjI/bFyJ0T4AJzvqHbzMR//3fFc2HKk+Q/+QbOi/Oq1lyDDtQc8Y8zd/yY4B/
 hBCaNnaiEw1ASr0TibIV7boWg8ZwThvq9E23kn4M/6hXaQ1JHe+c35xVMiucH5J4lmijHfKodjB
 71DW46boh24FVPQ+zR/07hH0xUmpNeaWGp6CY80ham2Q==
X-Forward-Email-ID: 688ab0781851584377f62151
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 6/8] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3528
Date: Wed, 30 Jul 2025 23:52:47 +0000
Message-ID: <20250730235301.1774089-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Like Rockchip RK3328, RK3568 and RK3588, the RK3528 also have a single
node to represent the glue and ctrl for USB 3.0.

Use rk_ops as driver data to select correct ctrl node for RK3528 DWC3.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 3cda2b74b7e3..6b2016c0cd37 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -698,6 +698,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "ti,am654-dwc3" },
 	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3399-dwc3" },
+	{ .compatible = "rockchip,rk3528-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
-- 
2.50.1

