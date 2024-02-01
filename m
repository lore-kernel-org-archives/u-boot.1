Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B2EC47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB8E87CD5;
	Thu,  1 Feb 2024 04:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OH7s+rvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0165687C8E; Thu,  1 Feb 2024 04:06:52 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB4C87CD4
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bZj007075;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=tUNwL7io28aLtP39+LG/p0YMsnVm8nSZ+NlclCgIr1M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OH7s+rvKektYTp0FThAxLc8IrKs/jUPWk8fWKxNp94ALjEXAWCVJP/V8ad+X5Zp19
 ltVLClY86UdrzmUA6eKGitKED4VoFXEaM66M8rEq1mmBgj0JExDzQa4vDbP8VkpvtF
 EV8mpS+qOxEIaLVHRmKJBjFX08GsK3tXiM3ihmS4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136b5Q013790
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bqG043569;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 01/13] soc: add info to identify the am62p SoC family
Date: Wed, 31 Jan 2024 21:06:37 -0600
Message-ID: <20240201030634.1120963-18-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=bb@ti.com;
 h=from:subject; bh=k13I1EcfFpfmrbdnqszZz8igAEXOtS+1DwqUF2G2b8I=;
 b=owNCWmg5MUFZJlNZoC4fmAAAZn///79/f3VqH//59/vu/33zjbNz/I3/XsLVXd/r/7Nx7/6wA
 RtqBijQ0Bo0ABo0D1AA0ADQBoNADQA0ADQD1ANABoAaNBiaDRpo0ZM1NPUem1IcQGhkGRgEDQ00
 GmmQxGQAaAAAZABk0aMTCNDIA9TIGjRoA0aPUNAGhoNMch6QNANNMjCZANGTBBpkBpo00GTTQBk
 yYmmgAMJiYgABoA0ZMgAAAAyAAGoN3bIclHBX2ZAhoeLBTMoANGwH3Qh4UFr8YO8WMLUqJHStfE
 efx9VY9R3g1HRHcnucdpfuWXm6lwLu50pbBi3dtsSth0qflrllnpQhl75u71qgQCKdRatMusvof
 3ByJDLSLkz7H4Qn8wRNisfkgKGoymh5S5VI8ox0QgoqdjXjTQkppDNzY5tBzMAhmExEQVomlGoK
 MJNuM0BzoufbyZOtrZxW1ZjY7GJvRiDq69PlFlQB4ZgCymJZKbVeKNWsKiqTlZ7Gb095GrpDcMh
 izIeMMfBIeRzHpA1f+GomXHGouEYYeClQrgnwodQtConR7Fo3uicdUJtQCr1acRHVCIER3lyw91
 bH5oY/s8UP3Hj2/B1CRWQRn2Qaw8gZqF5JaipaiYxFx8uQwSz20/hOgBiHKFIegEgrQyCfxgABs
 qyACEpGf+LuSKcKEhQFw/MA
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
2.43.0

