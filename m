Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610CBC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22DE488685;
	Mon,  8 Jul 2024 08:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eFgrVW14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7E488663; Mon,  8 Jul 2024 08:07:59 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3550688663
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418877; x=1723010877;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Czy1JiyExXvrW22vWvISyI1O+6N8WCUjZ8dOteBeKH0=;
 b=eFgrVW14jtLBCD1DZ+uN7vljPFjcjQpjo47FK5eWY07wn2V/agG3momkFCZQn/NN
 +poYiK/hFWnoBdnavBk9zgefS6PubjmmRFy+aYcWB0D2o3YBnRmXEtNWztBbufBR
 9vnhDp1FJCxxF2cy2yPpAJIQkrX3gjOIJlK5OhLppQ0=;
X-AuditID: ac14000a-03e52700000021bc-4b-668b823c0f54
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id ED.11.08636.C328B866;
 Mon,  8 Jul 2024 08:07:56 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:07:53 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/6] include: env: phytec: k3_mmc: Apply extension overlays
Date: Sun, 7 Jul 2024 23:07:30 -0700
Message-ID: <20240708060734.4029040-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR9emqTvNYN5rU4uWtR4Wnz5kWnza
 +ZjV4mj/GmaLSw9SLV4cm8tu8ebHWSaLqZM2s1u83dvJbtH9Tt2By+P9jVZ2j1cHVrF7nL2z
 g9Gjv7uF1eP6me1MHsdvbGcKYIvisklJzcksSy3St0vgymh7soq54DJLxbcpW1kbGL8xdzFy
 ckgImEi86d/KCGILCSxhkrgwLw/CvscocX1FMIjNJqAlcWfLXLB6EYEkiWUXO1m7GLk4mAW+
 M0q8+PiLFSQhLOAt0bFtLQuIzSKgInHx/jKwobwCVhKn3zSzQiyTl5h56Ts7iM0pYC3xaFon
 C8QyK4m5kzewQdQLSpyc+QQszgxU37x1NjOELSFx8MULZoh6BYnZ2yYzwsycdu411DOhEkc2
 rWaawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoIgRYeDawdg3x+MQ
 IxMH4yFGCQ5mJRHe04/b04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1I
 LYLJMnFwSjUwamy4qXkm3/qszGrnx158Ycw3+hlOP321LGFR6nIXgazKGUK6ZYvnVwXyrLbe
 oOu+dvMBZ4MEjm8PuCTSztf4TGVmqp6xZEPHMX05w3UcSyp7/1m/PHOpbcr9KZ7XffirBXzm
 c60ub53t/f+TH6vb6rvFEjeOc9k/+VYornN3x3mmG03JM6R3K7EUZyQaajEXFScCAKmYuHGG
 AgAA
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

Run the mmc_apply_extensions routine to apply overlays
added by the extension framework.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index 3d3595ceb7e..3c0b1359dda 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -18,4 +18,5 @@ mmcboot=run mmcargs;
 	run loadimage;
 	run loadfdt;
 	run mmc_apply_overlays;
+	run mmc_apply_extensions;
 	booti ${loadaddr} - ${fdt_addr_r}
-- 
2.25.1

