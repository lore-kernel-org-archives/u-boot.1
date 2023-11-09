Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D3EC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D768729D;
	Thu,  9 Nov 2023 11:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sberdevices.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sberdevices.ru header.i=@sberdevices.ru header.b="ow3JGN3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F1F87450; Thu,  9 Nov 2023 11:55:37 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0AB787250
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sberdevices.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7AB90120040;
 Thu,  9 Nov 2023 13:55:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7AB90120040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
 s=mail; t=1699527335;
 bh=J7SZxu/xyp9ytMfVs9epm1TQ96SN7qBo1wcwdrpgXRc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ow3JGN3YnXu8Dl0a5k3UX5ZqYRpq0GnmyGBRHhLR9aK8crGcE430WLZvasVh46rKy
 vh+puCGf52n+recZAye/B96DIM0BgJne7HOUCYYKSLDwpunTDV4rcuWVlKusgPZHAa
 qzSFdtE9sTLws8fox759HxDzaOW6DdCuTRcBGxwIbTXT1io471GksfEFNheVoouadG
 0aq9Eov8/XI/vBEwAXE+cx0bczytWK9a6rcINg3ckBpJxW1dfn5CjQGYoztZhU8Q7x
 lAOw1ji7s1HrjZvvbQoZBvXWvwVFw4TiaOs7pVVNt0WUMp3AzrX7dYksnMmKh1d7NO
 IViChJVj2ICnQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  9 Nov 2023 13:55:35 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 13:55:35 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot-amlogic@groups.io>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v7 4/8] clk: amlogic: Move driver and ops structs
Date: Thu, 9 Nov 2023 13:55:12 +0300
Message-ID: <20231109105516.24892-5-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109105516.24892-1-ivprusov@sberdevices.ru>
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181238 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from},
 {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n,
 {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch},
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/09 07:10:00 #22435383
X-KSMG-AntiVirus-Status: Clean, skipped
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

Move driver and ops structs to avoid forward declaration after switching
to dump in clk_ops.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
---
 drivers/clk/meson/a1.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index d0f5bb3753..c91357ec27 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -607,14 +607,6 @@ static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
 	return meson_mux_set_parent_by_id(clk, parent_clk->id);
 }
 
-static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_rate	= meson_clk_set_rate,
-	.set_parent	= meson_clk_set_parent,
-};
-
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv = dev_get_priv(dev);
@@ -644,15 +636,6 @@ static const struct udevice_id meson_clk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(meson_clk) = {
-	.name		= "meson-clk-a1",
-	.id		= UCLASS_CLK,
-	.of_match	= meson_clk_ids,
-	.priv_auto	= sizeof(struct meson_clk),
-	.ops		= &meson_clk_ops,
-	.probe		= meson_clk_probe,
-};
-
 static const char *meson_clk_get_name(struct clk *clk, int id)
 {
 	const struct meson_clk_info *info;
@@ -733,3 +716,20 @@ int soc_clk_dump(void)
 
 	return 0;
 }
+
+static struct clk_ops meson_clk_ops = {
+	.disable	= meson_clk_disable,
+	.enable		= meson_clk_enable,
+	.get_rate	= meson_clk_get_rate,
+	.set_rate	= meson_clk_set_rate,
+	.set_parent	= meson_clk_set_parent,
+};
+
+U_BOOT_DRIVER(meson_clk) = {
+	.name		= "meson-clk-a1",
+	.id		= UCLASS_CLK,
+	.of_match	= meson_clk_ids,
+	.priv_auto	= sizeof(struct meson_clk),
+	.ops		= &meson_clk_ops,
+	.probe		= meson_clk_probe,
+};
-- 
2.34.1

