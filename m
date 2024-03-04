Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D1C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1642187E6F;
	Mon,  4 Mar 2024 12:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Lj4h1h2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0574187ECC; Mon,  4 Mar 2024 12:49:09 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E81D87E4F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709552946; x=1712144946;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ir+wDywwrTcS/vcW390tytbpYn6S4hyWLNtSR5OYkrQ=;
 b=Lj4h1h2WED3L0hbZjwLjfaF8kplSzqDFdgleEQZkRQJRaLPdyNetPLnx/8blEQSP
 245e2sjZC0tS/iAkNX7u+4X9y+Io0Bbfm5OcJ/QIqi/mk1S7+ymRM47ZrTfv32U7
 YKESwEDJONFGRDcOsyvmGyI+pr3wUSPL0INA4LddzFo=;
X-AuditID: ac14000a-fbefe7000000290d-78-65e5b532b354
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 81.06.10509.235B5E56;
 Mon,  4 Mar 2024 12:49:06 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 12:49:32 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 4 Mar 2024 12:48:54 +0100
Subject: [PATCH] drivers: imx_tmu: Select polling-rate from cpu-thermal
 devicetree node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-fix-thermal-driver-issue-v1-1-f30daeaf1055@phytec.de>
X-B4-Tracking: v=1; b=H4sIACW15WUC/x2MQQqDQAwAvyI5G0h3Uw9+pXhY3NgNqC2JiiD+v
 UuPAzNzgYupOPTNBSaHun7WCo+2gbGk9S2ouTIECkyRGCc9cStiS5oxmx5iqO67YGQifoYuJZ6
 g5l+T6v7Xr+G+f8jucGxqAAAA
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709552946; l=1575;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=Ir+wDywwrTcS/vcW390tytbpYn6S4hyWLNtSR5OYkrQ=;
 b=ZA6osgmOOGR/DwBTVyfNdn/evYKlY8wNbi6z61XIWbRnSChsgsOhVtNwkITN+qwE+0wOKb47J
 JJB+K7GzvQrCgFTTqbwevoQK4sS6Zalc53E3qoT0diwMEmxIx4Q7qXC
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR9do69NUg96PGhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyVp7uZi5Y
 yVPR1/aBrYFxNVcXIyeHhICJxO6pu5i6GLk4hAQWM0mcvtDDDOE8YJRYenMWE0gVm4CaxK43
 r1lBbBYBFYndZ7uYQWxhgUiJxVfPsIDYvAKCEidnPgGyOTiYBTQl1u/SBwkzC8hLbH87hxmi
 xFvi4pZrbCDzJQS2MEpc2LCNESQhIuAqcWPVclaI3iiJdxODQEwJAWGJTTu1IMp3M0lcO/GU
 CSKeKLHztRxIp5CArMTN81vYIH6Rl5h27jUzhB0qsfXLdqYJjMKzkBw3C+G4WUiOW8DIvIpR
 KDczOTu1KDNbryCjsiQ1WS8ldRMjKPBFGLh2MPbN8TjEyMTBeIhRgoNZSYS35teTVCHelMTK
 qtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MS9+nqh9z4hU/4ful
 1PjR7pLw4NK0pjAHjcLa+P0RLUvyX/ydurd0k+L9hzkyFrMmOiYolq1gXyJvfbe2Uant8abw
 bzvrn8n+/OrvlnLTsVE5sXd3iZ+p6OrTko9+6h441ZTTwTmHv/mVVVmKocR24XOZZ46WG9k8
 OHFxj6uh0L4rM1TrNyoosRRnJBpqMRcVJwIAxBXhy2oCAAA=
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

The polling rate is already specified in some devicetrees, like
imx8mp.dtsi for example, but was not selected so far. For the
trippoints, the cpu-thermal node is used. Also get the polling rate from
this node. Use the default of 5000ms if the polling rate should not be
specified in the devicetree.

NOTE: The polling rate from the devicetree will be used after this
patch. In imx8*.dtsi devicetrees the polling delay is set to 2000ms for
example.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 drivers/thermal/imx_tmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 4721cfbc0218..c7fe0f07a607 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -570,12 +570,14 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 {
 	struct imx_tmu_plat *pdata = dev_get_plat(dev), *p_parent_data;
 	struct ofnode_phandle_args args;
-	ofnode trips_np;
+	ofnode trips_np, cpu_thermal_np;
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	pdata->polling_delay = IMX_TMU_POLLING_DELAY_MS;
+	cpu_thermal_np = ofnode_path("/thermal-zones/cpu-thermal");
+	pdata->polling_delay = ofnode_read_u32_default(cpu_thermal_np, "polling-delay",
+						       IMX_TMU_POLLING_DELAY_MS);
 
 	if (pdata->zone_node) {
 		pdata->regs = (union tmu_regs *)dev_read_addr_ptr(dev);

---
base-commit: eac52e4be4e234d563d6911737ee7ccdc0ada1f1
change-id: 20240304-fix-thermal-driver-issue-34004526aa4f

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

