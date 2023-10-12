Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56CDCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 842ED86EA9;
	Fri, 13 Oct 2023 01:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ewLeyVfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9A486D33; Fri, 13 Oct 2023 01:07:39 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5599486E5A
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6J9Z067499;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=H2z2WtxYOx/iiWO400b+hZOvANPl7m2lfnkYtGJTkpQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ewLeyVfqErYWjUNQtzJHo22SpLTu4g5J8i1pba+dTiENQBAAaiiajvgOY+/zE9DTq
 HepGyIRunUOwzYqeRI2B9dHoPJKd2/RkqBUWGhv8XjoIlsWuvBo9hcIuFqEUOrxwtS
 /YOQ18/m8T5/gRR/VcdAEhAr2v4tiN7DwUPoY3Yo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6Jjt020812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6IpN038856;
 Thu, 12 Oct 2023 18:06:18 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 01/11] soc: add info to identify the am62p SoC family
Date: Thu, 12 Oct 2023 18:06:18 -0500
Message-ID: <20231012230616.2101992-14-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=bb@ti.com;
 h=from:subject; bh=0KJHA+2jyUW5985Hw3sPXsA4+7QCfKcd0HhBiacyv4k=;
 b=owNCWmg5MUFZJlNZoeCYfQAAaP///vfd9795W/Wjr757f9ffW3eydXbW/3f/+z8s/5Tt9t8wA
 RmWEPUBpoDQyaA0AaMQAANA0BoNAyNAZA0AAAA0A0DQGQyB6jJ6nqHqaN6o2mUQGg0eoDJoBpoZ
 NBpoyNNBkMmgw0QBiaANA0MhoAGI0aMmmjRk2o0DI0AAyDQMk09Ro0abUGgNqMjQAAaNGmg0D1P
 UABoBoA0AAAADIeoGgBoGyjGoyPUB6gAQVxsU22qgTg6o4EeiUJoMf5XuLM8EBJHyALluM4dixs
 KIQopErRKC2DQw2WkgjJj61Hi2TkzBwXN+u0rAolRLxZp/GZE5V+Bz6R2+2gyXTZ/r3MkVJ/AaL
 asIlMq52GCL2LJiwOAp5BHc35e3gfr5VQHIy6VdkDpQ4lK6R3YG5ek1K/G13DME4Alz8ImkQ8Hc
 E0oLhi5dWHxvp+XhEwRhg88FT595HNENFjxDaexJSA4614dau6FI0cRKsixssMVAKdQcSTvW92w
 OAIW7iGYhfk5uhvwiS1SmGLw1eDtphbpF5RC4Pd5AVylWyUdAlTjD95kUPWdetOYGjfl89nF7dF
 HuzMDNtsSGp0GQQYqD0CfhP6zTjKyHfNBuNICQC7dW6LzDQlv+r4cFozKiAWAakD3M7XEOxsoR+
 qQmC9rhkwRKz/F3JFOFCQoeCYfQ
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Include the part number for TI's am62px family of SoCs so we can
properly identify it during boot

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 2 ++
 drivers/soc/soc_ti_k3.c                  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 65742c4b7c8c7..85aa18918de9c 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -46,6 +46,7 @@
 #define JTAG_ID_PARTNO_J721S2	0xbb75
 #define JTAG_ID_PARTNO_AM62X	0xbb7e
 #define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_AM62PX	0xbb9d
 
 #define K3_SOC_ID(id, ID) \
 static inline bool soc_is_##id(void) \
@@ -61,6 +62,7 @@ K3_SOC_ID(am64x, AM64X)
 K3_SOC_ID(j721s2, J721S2)
 K3_SOC_ID(am62x, AM62X)
 K3_SOC_ID(am62ax, AM62AX)
+K3_SOC_ID(am62px, AM62PX)
 
 #define K3_SEC_MGR_SYS_STATUS		0x44234100
 #define SYS_STATUS_DEV_TYPE_SHIFT	0
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b720131ae5df9..85130ba5f6be3 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -45,6 +45,9 @@ static const char *get_family_string(u32 idreg)
 	case JTAG_ID_PARTNO_AM62AX:
 		family = "AM62AX";
 		break;
+	case JTAG_ID_PARTNO_AM62PX:
+		family = "AM62PX";
+		break;
 	default:
 		family = "Unknown Silicon";
 	};
-- 
2.42.0

