Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E01C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE6687B5D;
	Thu, 11 Jan 2024 14:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="UvKhIKnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91E787AE6; Thu, 11 Jan 2024 13:56:28 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB27887AD4
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 13:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z65w8RJwRMrnbHYMP6PMPpIDGEoiPnwaCPuxqkveBH8=; b=UvKhIKnOBQg0WzABVSymHIk71z
 2jhOn4/+v4VgEgxFKrtBI4oXcNRek0IwQsUl55+yIVJlwGzcgsvr7ECg0FjCeU8jlC9cReCtJZOo2
 C1fjhp76txAMDRlJeQqI6W3yeO2FCgtKnOu44iUxbcQ0cBFaxJB8XAM2+wxPa/d0DjuIUmERcqKmf
 ji8mhjhl+d8UzgAGNmFwOiYpJBmP2J8uBkgW4Q+7iTtWWOKvyIzQch+gCcTqZ/5ck/bsAbsnv0EJV
 ZOzxToKkI2LK6VjFWKhMOv2JoYVY2xKls4dl3lT+PQ7cJjfa5ede3hIrW3u/0Lpj756s47CLs6+iR
 JHBeeJpQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:36540
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rNubi-00BMKF-1T;
 Thu, 11 Jan 2024 13:56:26 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	PHYTEC upstream <upstream@lists.phytec.de>
Subject: [PATCH 1/1] imx: imx9: fixup thermal trips from fuses
Date: Thu, 11 Jan 2024 13:56:25 +0100
Message-Id: <20240111125625.2815180-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111125625.2815180-1-primoz.fiser@norik.com>
References: <20240111125625.2815180-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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

Read i.MX9 CPU temp grade from fuses and fixup thermal trips in Linux
device-tree accordingly.

Based on commit 0543a1ed2787 ("imx8m: fixup thermal trips")

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/mach-imx/imx9/soc.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 86b45be3d804..f06339f13880 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -507,8 +507,53 @@ int print_cpuinfo(void)
 	return 0;
 }
 
+static int fixup_thermal_trips(void *blob, const char *name)
+{
+	int minc, maxc;
+	int node, trip;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, name);
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, "trips");
+	if (node < 0)
+		return node;
+
+	get_cpu_temp_grade(&minc, &maxc);
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type;
+		int temp, ret;
+
+		type = fdt_getprop(blob, trip, "type", NULL);
+		if (!type)
+			continue;
+
+		temp = 0;
+		if (!strcmp(type, "critical"))
+			temp = 1000 * (maxc - 5);
+		else if (!strcmp(type, "passive"))
+			temp = 1000 * (maxc - 10);
+		if (temp) {
+			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	if (fixup_thermal_trips(blob, "cpu-thermal"))
+		printf("Failed to update cpu-thermal trip(s)");
+
 	return 0;
 }
 
-- 
2.25.1

