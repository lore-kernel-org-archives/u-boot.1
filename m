Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E237EC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BDC87F8A;
	Tue, 12 Mar 2024 21:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ikY4sm4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6F787F5A; Tue, 12 Mar 2024 21:20:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E2287F49
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTO4004633;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=J/VjCNbx15UErMplO/+UdlDmmkDgQaq9rBmO7Fw/OYk=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=ikY4sm4XJ2K71E5bt5GS5vpilQoshE9ADxcLZLosce43Bjd6Ou67DSnV8f8VdqVV5
 BALOsPqT8oPKYHv4fJwUi8ljRmGDMLZ8B+t44Y6l8hs2Vfz4Dd5FqBypT0fslFt3TH
 O7ycqWLHFj82SotnEfOkfZd99wwfaEmOJigFCfWg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTGj038137
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKSDM097247;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:19 -0500
Subject: [PATCH v4 01/13] soc: add info to identify the am62p SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-1-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=bb@ti.com;
 h=from:subject:message-id; bh=B1ZUOSzdSwBeFJtMjI9mEyQ/KnKcncqSQA6WFaYDsfA=;
 b=owNCWmg5MUFZJlNZdXABCwAAZP///vbvz+s7e5n/f+3R/n9TYeOv//59/MP/6h+rmtfq+82wA
 RswHagaMjTQPUBoAADRoAGRoGmhoADQaBoGgADQ0ZGjEZNDI00GmTE2mptJk2mocmjI0yDQGCDQ
 0AA0Ymj1AyNBoNDTQGQBkGJiZNABkyBpo9I0PUyaABpo9QeoHT0mmTIaaNMEAxBoNGjJphNAZGm
 QAAyGIGIYAgxGQNANBiZDQNANAAAQIAHRB4rgxLUKJtI4UVK7GTbgyU2IGjwYxFbCh4wFBBfQGX
 +sZeYnOyIxd37oqEPfOklnsc5Qc1rbKTqNK6lAtjnBlkF0ESyqL7A/cmF40tumvg1Kdrnl6vydI
 0+1ugub8B/W3BDA1Atlg56WzIGVe0+mBzG1sezVh+bLMhGybhPPxPARcIwPmZpGERPYJhVapU9y
 iB61zo0zNKfYwg3mLEf3gqVjf9qu7tOk9EqEygZawJT9TdZTzAaqEj5D2SpJqNwxJAQsD2OSiJq
 wLGiAYfknYl+WsarSulTUpA+BxtJlGcvXhkuE0XTgo6vPCONx/Qmz5xyRz2Tkw2bP2tEMw7cRns
 cEFVq86xXrHEjkfKZgUAd/QQH8mdHUZkZwNkocMBJLuxVEI6er6EZKKL9kr4cbwtMf6LfNXK2z0
 PHQAUHMTlBmH+LuSKcKEg6uACFg
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 2 ++
 drivers/soc/soc_ti_k3.c                  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 055715f20d6f2..224367d9f1adc 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -43,6 +43,7 @@
 #define JTAG_ID_PARTNO_SHIFT	12
 #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
 #define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_AM62PX	0xbb9d
 #define JTAG_ID_PARTNO_AM62X	0xbb7e
 #define JTAG_ID_PARTNO_AM64X	0xbb38
 #define JTAG_ID_PARTNO_AM65X	0xbb5a
@@ -65,6 +66,7 @@ K3_SOC_ID(am64x, AM64X)
 K3_SOC_ID(j721s2, J721S2)
 K3_SOC_ID(am62x, AM62X)
 K3_SOC_ID(am62ax, AM62AX)
+K3_SOC_ID(am62px, AM62PX)
 
 #define K3_SEC_MGR_SYS_STATUS		0x44234100
 #define SYS_STATUS_DEV_TYPE_SHIFT	0
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index d176980915605..3a4e58bba6715 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -48,6 +48,9 @@ static const char *get_family_string(u32 idreg)
 	case JTAG_ID_PARTNO_J784S4:
 		family = "J784S4";
 		break;
+	case JTAG_ID_PARTNO_AM62PX:
+		family = "AM62PX";
+		break;
 	default:
 		family = "Unknown Silicon";
 	};

-- 
2.43.2

