Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA96C54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF9487C48;
	Fri, 23 Feb 2024 21:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="smZT+sLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE9987653; Fri, 23 Feb 2024 19:53:31 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29DA87BFE
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 19:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NIr5a0097763;
 Fri, 23 Feb 2024 12:53:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708714385;
 bh=iP7ODdRphe5dp1Y9SalGVMtDJ52909XxZBR9cngYx2M=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=smZT+sLHzcUt4rIZTRpHFFjVN4VKguzxTVSdDAsgnuKsal60ZIv6bdeCh4+01Zwgl
 wmx3F620BXDq41wErAo+zhLPxfsPtI8+8fMMQJzZAPw0iT4sfgB9hBjTWUTq/WiN8V
 FQdmeZmgNntgg/cx/vLqlEIg7n7+wVGMeIoIWV00=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NIr5Ig100042
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 12:53:05 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 12:53:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 12:53:05 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NIpvhm051632; 
 Fri, 23 Feb 2024 12:52:54 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>,
 "Aradhya Bhatia" <a-bhatia1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Bhavya Kapoor <b-kapoor@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Jason
 Kacines <j-kacines@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v9 05/15] soc: ti: k3-socinfo: Add entry for J784S4 SoC
Date: Sat, 24 Feb 2024 00:21:46 +0530
Message-ID: <20240223185156.3065032-6-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223185156.3065032-1-a-nandan@ti.com>
References: <20240223185156.3065032-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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
Reviewed-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/mach-k3/include/mach/hardware.h | 1 +
 drivers/soc/soc_ti_k3.c                  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 7e143c6bdc8..74692b745ad 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -50,6 +50,7 @@
 #define JTAG_ID_PARTNO_J7200	0xbb6d
 #define JTAG_ID_PARTNO_J721E	0xbb64
 #define JTAG_ID_PARTNO_J721S2	0xbb75
+#define JTAG_ID_PARTNO_J784S4	0xbb80
 
 #define K3_SOC_ID(id, ID) \
 static inline bool soc_is_##id(void) \
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index 355a5368dd4..d1769809156 100644
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

