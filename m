Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C33EE7FF3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EBF86AF4;
	Fri,  8 Sep 2023 16:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JmfgJzlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57BD86410; Fri,  8 Sep 2023 13:06:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E5F86A2F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B6LLS118535;
 Fri, 8 Sep 2023 06:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171181;
 bh=dFxYP3ElOnBa1fb//KHDY21+ApRfkUVXAEUWkNdfeUM=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=JmfgJzlSFA/NniYblHF8KjQ2HP41sp4UDBu4x9SBqym2eWQXJm6ZXDzlSOfFkFjrx
 Og3DY1B/+XV0hQwVveLAYDrxHq/vGqG+U/Qb9ZgGe8ZGpZxjFbaYXHrB7IkpKe7lED
 90R0YxzuAtuAyDhQ0ETxetVIzkddu46d6myoaFWY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B6LaD045138
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:06:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:06:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:06:20 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qEG018063;
 Fri, 8 Sep 2023 06:06:13 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 03/16] soc: ti: k3-socinfo: Add entry for J784S4 SoC
Date: Fri, 8 Sep 2023 16:35:38 +0530
Message-ID: <20230908110551.861575-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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

Add support for J784S4 SoC Identification.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 1 +
 drivers/soc/soc_ti_k3.c                  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 03b18f6bad..bada87d0b2 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -50,6 +50,7 @@
 #define JTAG_ID_PARTNO_J721S2	0xbb75
 #define JTAG_ID_PARTNO_AM62X	0xbb7e
 #define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_J784S4	0xbb80
 
 #define K3_SOC_ID(id, ID) \
 static inline bool soc_is_##id(void) \
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b720131ae5..6f7fcf9e11 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -45,6 +45,9 @@ static const char *get_family_string(u32 idreg)
 	case JTAG_ID_PARTNO_AM62AX:
 		family = "AM62AX";
 		break;
+	case JTAG_ID_PARTNO_J784S4:
+		family = "J784S4";
+		break;
 	default:
 		family = "Unknown Silicon";
 	};
-- 
2.34.1

