Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE492C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A7187494;
	Thu,  9 Nov 2023 11:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sberdevices.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sberdevices.ru header.i=@sberdevices.ru header.b="WZPiX9vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318C887480; Thu,  9 Nov 2023 11:55:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D779087259
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sberdevices.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6090710004C;
 Thu,  9 Nov 2023 13:55:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6090710004C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
 s=mail; t=1699527336;
 bh=lIig9u04yz0CnT8e2iu5TlOgOW6+rWLXHzg7JECemP8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=WZPiX9vJULR3UE/u0qy/Cy9hvnSv8joEdMi7ywqI8Pd0NboJpvR5UJAwfWXKGi4N2
 +8cAsSKhcObeg8FB6Jpe3tp+h/ZMU13x8ILupQNR1LL7AXJOiRIcbTDgt5/w4mYqCI
 C8H/yl2kmkVwk00puZE8YfNXx5zrthQ+jF9iQiJBYIysX8LKe3lx4PWIQ2HEYS8IGY
 v7fhxAna40uwANQMI4exEmr0JdAVYQJ8quGhGSSHTu4vnchHNav9WQqsTnGPHi2f1x
 7Er3Aq5Q/e316kuV88DoaX8psMGD4Kfr14fxUnb+rMibJdzh9631P8wfLZ3Pf/rJRI
 2aH62qV4Zc6AA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  9 Nov 2023 13:55:36 +0300 (MSK)
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
Subject: [PATCH v7 5/8] clk: Add dump operation to clk_ops
Date: Thu, 9 Nov 2023 13:55:13 +0300
Message-ID: <20231109105516.24892-6-ivprusov@sberdevices.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 181239 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from},
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; sberdevices.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch},
 {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
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

This adds dump function to struct clk_ops which should replace
soc_clk_dump. It allows clock drivers to provide custom dump
implementation without overriding generic CCF dump function.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
---
 include/clk-uclass.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/clk-uclass.h b/include/clk-uclass.h
index a22f1a5d84..f10dd213ff 100644
--- a/include/clk-uclass.h
+++ b/include/clk-uclass.h
@@ -25,6 +25,7 @@ struct ofnode_phandle_args;
  * @set_parent: Set current clock parent
  * @enable: Enable a clock.
  * @disable: Disable a clock.
+ * @dump: Print clock information.
  *
  * The individual methods are described more fully below.
  */
@@ -39,6 +40,9 @@ struct clk_ops {
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 	int (*enable)(struct clk *clk);
 	int (*disable)(struct clk *clk);
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	void (*dump)(struct udevice *dev);
+#endif
 };
 
 #if 0 /* For documentation only */
@@ -135,6 +139,15 @@ int enable(struct clk *clk);
  * Return: zero on success, or -ve error code.
  */
 int disable(struct clk *clk);
+
+/**
+ * dump() - Print clock information.
+ * @clk:	The clock device to dump.
+ *
+ * If present, this function is called by "clk dump" command for each
+ * bound device.
+ */
+void dump(struct udevice *dev);
 #endif
 
 #endif
-- 
2.34.1

