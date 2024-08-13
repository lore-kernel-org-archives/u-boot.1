Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E17DC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 10:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA8A8897C;
	Tue, 13 Aug 2024 12:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k2rxvrfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC1288966; Tue, 13 Aug 2024 12:54:31 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5F58897C
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 12:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsDHe044488;
 Tue, 13 Aug 2024 05:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723546453;
 bh=KQLiLCVeUs0mV1V8kiV8FQmw2uVJOXFHd4TJej2AGN4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=k2rxvrfcRQVxVfvsSjFXnvzWTF1kwDZoFGQ52Y9OsO/+DyeVpq9GzQNX49tyv/Hjl
 nlMxIry+1QOvmZONtnNKM23ylRWVMeQTuFezq8QqQroWltbzr6zIdSqG1zf+z54I2M
 fRv0Fg1A5JorRRzOZyG/LSYOXhsQxPyS9zhQQVa4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DAsDd7071805
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 05:54:13 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 05:54:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 05:54:13 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsCe0075470;
 Tue, 13 Aug 2024 05:54:13 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, =?UTF-8?q?Marek=20Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Nishanth Menon" <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Kishon Vijay Abraham I <kishon@ti.com>, "Chintan
 Vankar" <c-vankar@ti.com>
Subject: [PATCH v5 02/10] firmware: ti_sci: Add No-OP for "RX_FL_CFG"
Date: Tue, 13 Aug 2024 16:23:52 +0530
Message-ID: <20240813105400.4054657-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813105400.4054657-1-c-vankar@ti.com>
References: <20240813105400.4054657-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Kishon Vijay Abraham I <kishon@ti.com>

RX_FL_CFG message should not be forwarded to TIFS and should be
handled within R5 SPL (when DM services are not available). Add
a no-op function to not handle RX_FL_CFG messages.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v4:
https://lore.kernel.org/r/20240812114714.3843192-1-c-vankar@ti.com/

Changes from v4 to v5:
- No Changes.

 drivers/firmware/ti_sci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index e591333ba38..719cfa771b4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2450,6 +2450,12 @@ fail:
 	return ret;
 }
 
+static int ti_sci_cmd_rm_udmap_rx_flow_cfg_noop(const struct ti_sci_handle *handle,
+						const struct ti_sci_msg_rm_udmap_flow_cfg *params)
+{
+	return 0;
+}
+
 /**
  * ti_sci_cmd_set_fwl_region() - Request for configuring a firewall region
  * @handle:    pointer to TI SCI handle
@@ -2895,7 +2901,7 @@ static __maybe_unused int ti_sci_dm_probe(struct udevice *dev)
 	udmap_ops = &ops->rm_udmap_ops;
 	udmap_ops->tx_ch_cfg = ti_sci_cmd_rm_udmap_tx_ch_cfg;
 	udmap_ops->rx_ch_cfg = ti_sci_cmd_rm_udmap_rx_ch_cfg;
-	udmap_ops->rx_flow_cfg = ti_sci_cmd_rm_udmap_rx_flow_cfg;
+	udmap_ops->rx_flow_cfg = ti_sci_cmd_rm_udmap_rx_flow_cfg_noop;
 
 	return ret;
 }
-- 
2.34.1

