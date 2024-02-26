Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC323C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E2E87F65;
	Mon, 26 Feb 2024 22:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gyoQknwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B46387A80; Mon, 26 Feb 2024 22:19:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DDB87F6D
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUT3069693;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=W6IKEoRwDRziwbbz39gwkBBdJRbzrneHKRfe+kUbJzE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=gyoQknwldDYFnmk0k4Stf9w3DZBY8oiRfdqnlB4Ni0kmz1vpL450GyJ5KGYO4ID4Z
 imlchxHiY/ONCFLwU+xAoc77L26w+vKQ9d3DsQbLgOnfYvJWFFC8pSO0wq7mCz/4CN
 AZRzzxB1CLiDWCFzu5lp+s0nR1g4wO7dobbLI0cQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJUee017093
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:29 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJTVO034699;
 Mon, 26 Feb 2024 15:19:29 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Feb 2024 15:19:07 -0600
Subject: [PATCH v3 01/13] soc: add info to identify the am62p SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v3-1-04cbb42eaa6f@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=bb@ti.com;
 h=from:subject:message-id; bh=1f+7UWh5YLRTKQILlFhzTgRzqGukrscTAn1fKwoTnNo=;
 b=owNCWmg5MUFZJlNZKyFtMQAAY/////d7Lj/5e3/9n1++v58fD7O24f/33/pfciv/u9xe9vUwA
 RsZo5NDQ0Ymg0aAaMjQ0aaNBoGg00ZNAANBkaAAGBANGgZDQaDRpiPUB4kGmTQYgDQNAaeoaHqA
 0D1AA00G1BoNAMgNBp6QZNA00DT1GnogD1HqA0ADRiDQaB6jRtQMUND0mgabU00ANNNDIeoMgaA
 DQ0DQMg0ABkAM1DEAAGjQANA0GCNGmnpMIOHVBD1Arn2UCJ4jkKCz4CBDViDFQiStZCDG6s/w3J
 0P3HwoHsCIKKXJvajG829ofNy2f+HGoOaAcomnpVB6jJtcfWAh6D+Y2ZqZIg0FGJ36oezqtc3JE
 Yw964BAsAVAnKzFghVljriHVpHaKe9kJXYaawpNdQbqpxv2BNSBv8nW9JFOciHNlJ3ycMB/aBYg
 XUviCMvWsdW8lwlUG6CFWpB6dDRjkskRh98Ci43GvYhbQAzEMLyWTTdY1i/fhNLqEwzBs4q6R8/
 rrhaxMd7WphkSD/3GkJt5OvblkwXpTuqtCTZgnmXf/XPcFJAYD8HM6H0Bez+JacnnAh0gDns0TU
 b+7s2uLDp3jdCQcZznSDEESIfm9E7tvwCsaEm4IxxrunmkW//KIUs1c/rqJeaM5kyTZE6r3Edyu
 AzYJeJeQBJ4/6bh6LuSKcKEgVkLaYg=
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
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 2 ++
 drivers/soc/soc_ti_k3.c                  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index a1a9dfbde66c8..040288150b12f 100644
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
index 355a5368dd45a..d7d0152b115fa 100644
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
2.43.2

