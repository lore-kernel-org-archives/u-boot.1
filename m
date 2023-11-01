Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B73C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 14:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B5D87D1A;
	Wed,  1 Nov 2023 15:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="MuNZSJXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664F187CF6; Wed,  1 Nov 2023 15:05:20 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5DB87D06
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 15:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 34659120035;
 Wed,  1 Nov 2023 17:05:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 34659120035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1698847514;
 bh=X8N+NLz4a+p7W8gWxruFdL14oYTRzWa6jt9J7lTlCZI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=MuNZSJXe1ryAE10wIDe+tbzYQhtM82BHkkGZalbezNm1RbpdVmSAUybjJtHxbs1lv
 Ah6R6B68ZRYXT7GI1VkTVqkn3zK28DZMn4GFUfZG6xe6U5HtXAqC9uNh5QjSmoab/9
 11Z4y+XOFueRnuSIGSZhCm6QD+giPSKIneMvTul7CX5f1Scy1ju0lQ4U4LNDoOIwZp
 txD02C72XkbaPFgBOOEPj3BOKlopCeKpQLdgUK//ElNPtxf1U/ZqToiqlluZCBC1Br
 iYNJZN3pua/f2HJ0xG3wdaFr9qwxN8GAAIlvbbZyvWGMMWTnxr0DOFiCXkLASerIrE
 iNF/9GVFmgPqg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  1 Nov 2023 17:05:14 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 17:05:13 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 1/2] clk: a1: add new clocks for USB stack
Date: Wed, 1 Nov 2023 17:04:56 +0300
Message-ID: <20231101140500.9025-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101140500.9025-1-avromanov@salutedevices.com>
References: <20231101140500.9025-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181052 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/01 13:00:00 #22378131
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 01 Nov 2023 15:11:11 +0100
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

Since we sync device tree with Linux, we have to add this
clock definition for USB stack.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/clk/meson/a1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 1075ba7333..d0f5bb3753 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -241,6 +241,12 @@ static const struct meson_clk_info *meson_clocks[] = {
 	[CLKID_USB_PHY_IN] = CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
 		EXTERNAL_XTAL
 	),
+	[CLKID_USB_CTRL_IN] = CLK_GATE("usb_ctrl_in", A1_SYS_OSCIN_CTRL, 3,
+		EXTERNAL_XTAL
+	),
+	[CLKID_USB_CTRL] = CLK_GATE("usb_ctrl", A1_SYS_CLK_EN0, 28,
+		CLKID_SYS
+	),
 	[CLKID_USB_PHY] = CLK_GATE("usb_phy", A1_SYS_CLK_EN0, 27,
 		CLKID_SYS
 	),
-- 
2.25.1

