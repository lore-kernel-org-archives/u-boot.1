Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE11EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 23:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF88A84A9E;
	Sat, 11 Jul 2026 01:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q/+qfRoy";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jTRT56L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1268884AC7; Sat, 11 Jul 2026 01:04:24 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092B1848A1
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 01:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK5Zuw584333; Fri, 10 Jul 2026 18:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=/ZsCUtLHfOpDh
 kdMjgs16lAOG5UHM0Da/XvABOI4MHI=; b=Q/+qfRoyUutyvSTYGRQyRCaJEHQu5
 QzB7JWZlfkzdfeNGkEKRVuVryPMxXTyJFCjF8bo4p04jrX9yZn+Ap3TpYWujZitW
 jhu1oI84pwG41GpofpPs2sao91Qvmfv59L2Fp5vTlVnhnS5uDKbz7oq1DOW3zwCV
 0PSCV+OW9FEtsDzSzG0j4zvOB0bb/w8lWwCtZtU/c/TKTQinP+0n4ryr8r5if9w8
 PwVlr+X7Tu6lhD+feOzrr0X8Eg3/AVEQgB7L+yoA0rAMACbDbd7hfB+wHik5CenZ
 Lsos43Rt2AJXFjGk1RgWDvomQF9wtVkp0jS7A+Ff1ameL8EO0qz4ajpbw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fb0q5bpfj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 18:04:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+IGoENsNm/7sBcSMRb+OxXQknGsMx3h23/JrJKAcZ2EZpIRGXC/Jd6ICo7waYVWocMbKkGBsA5Sd40DHk5Z4DajYyQrfQs2sNeS0lfnBvVLByu8ycp5T+Uyhal9UEofinrodRGzBFXeLJcpMDbY0mW1AZw00JStS9UNvMNhA98C6N6NtD8RQTMYPkrTxB6+QL4UgIOoAKHeWLZA2MbwS5jEMCsMLamW0Pycxqg0DFqPP1JXqOcUwYJpChRAmM8RU+GC3ZT3+CbY7NjWQIOrdKKked/tiGbuiTnyDh4sIqGgpBLtcTPqtS6nY6lZSwaf9Bs6JZog7UAZnLxZmOJGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZsCUtLHfOpDhkdMjgs16lAOG5UHM0Da/XvABOI4MHI=;
 b=Gap02tYgRJuzKoO1XoUDiIdvJal9FGFk2l1tv3lKvy2SDFdYMMnsdt7weV9096yfdbRPB5PPPJihUa2jGG8G8Wz1IVGKlCIVJvbHTeiSSJstVWh7btZdyxhSQWnXqZN1q/0lKTCWUB5X7blS4+6pYIGsgC0NrNuU6pO+ftHl8ont5T/4gE7uxIFQJI6CbxEAfQYW4jsoz51ORAijT8um/5xnJBc1zijFa0AiEDaeTHwANDybZuWqeW7r4XdBgeVXleBAusFtX6SOYCONSAs+5SnWuSR5Mn5pXE/uZWWxxfbyj7zfAyvDwO4dYDXmD3+Ql995xnjiM1p5yawvDFucxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZsCUtLHfOpDhkdMjgs16lAOG5UHM0Da/XvABOI4MHI=;
 b=jTRT56L1Qb9vZeSDv3E8CB4O7SE8cuedHY19g8qZvK+zOGzFFIXHyEMnZUusFeTJbeig/w72OlhbJmofNqAhMeGimevbZ0AspTm/Tw1x3wDx9vTKN8xyYKw0w26QJsYJ5H5i0IsENahT+fz+JppdSk8aMStu/M/JOVLAJ8Q4244=
Received: from SJ2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:a03:505::14)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 23:04:12 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::3) by SJ2PR07CA0024.outlook.office365.com
 (2603:10b6:a03:505::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 23:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 23:04:10 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 18:04:10 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 18:04:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 10 Jul 2026 18:04:09 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66AN49Kp550633;
 Fri, 10 Jul 2026 18:04:09 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
CC: Francois Berder <fberder@outlook.fr>, <u-boot@lists.denx.de>
Subject: [PATCH] gpio: pca953x: Add GPIO settle delay
Date: Fri, 10 Jul 2026 18:04:09 -0500
Message-ID: <20260710230409.147210-1-jm@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|BLAPR10MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bec00b2-25c1-4a9f-d5b2-08deded78d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|32650700020|36860700016|82310400026|23010399003|376014|1800799024|5023799004|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: QXslZjFB5k/DyWpBueRVO4+8DtyVdRDpRW1SVWHYwZmwpZX0Wxx18VRkW3o0Zh4WrQgSlyJ6qG4/7HTiVkRUtNbL7FaFSWPHTfO6D4cc8CoTOjhrH3HaE6w3Z4wDByDBPx6u7ez3l/h5M5QPVOxcKwq8CSwbo80cIyjZSg4MuAaMg2uEOYqQteE4nXpiXA2R78wPKTPC4Zp6m1muaiL4V8M4mjxmzNY78PfCVKPCJo+0YJaGrBEOOLwmV9Fwt3F+MIkhlr5J4KM/u8uxHf27J08TDJ/0SV0BfNqMigBGGREtg0obxMbuklAEPldMJv8s9zT/8u678LaV+Y3hwSjyMMA/bLyZ2NT0cwrwgVAWLQ4RXczOUj4ZbNta2zLNMSqijQJvLMpBObiANK6SOGwQLOQ5z5g6q/fzpzV3FFJ1uIPwZb+up1PvabKVHR8Of+kTGo2hsVupqdrUjGsIpx21GhpBZNYg6vzenQNXedPUw1GfcDoUQBkzkYh2hiVYbaLWGZjWy6uHcviTrI7LWcWQZmHUr4sXNjWBG7iSMVFaVIeTVcmJkf9pmgG2uv0iwgizGqhbEOmR7pYcMsNGOQebSlzKSIzZlSY7w9k3iQcWv5vqlqstJ6KTCTvIDhMxzrxrdR2SKe8IvQm4zd+MEC8xTC9w9yjug1OrKofz4FEXPFLmNzTsu6QIF/sWLQ+fHSUbjJTsj/Z6njqovOt02xCi0g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(32650700020)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(5023799004)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NV3CXfqqWJ9xecB9yjwG8ZbSrV3cBk5dimkBgcQxuU+W8vXqIe5QGzUMB+4B/qWlxlmtaig8Yy4dlW8NDpM3mJ2V2OqbK9BrlNP6VaZzcb2abXUpztfSJlQekecBa9D9sm7DcpJH3dPMNmn6u70QNu1weqIdx+4MVEVPhTMdefGblRwAj9zaoLct32zj4FM0jGtQSLbsGBWDLSboquQf3h1i9C4iBNvLiucRzKlvQOfH15YTO6x++A2m1cVu3glvunoDf7jiGkf+XOEdjCh9AamSPoXMsKFn3p1zsoc8/hsQZaue9cYgd1oGy821j2RhCoM1PSYu0w5v5CRc9bAGwwVTH3SiRJP89EhGfGnLSk2uozchiUjs+BfyNbF5vpST4xoiRvu5UM50prmlx5X05UKKVdf33S7OUiGiSk/SZJChyvO9QBrHLSMUcChSn0iD
X-Exchange-RoutingPolicyChecked: RPLKucEy3idFYFYlJf49GSUbtRw0Sxy9LmAGRt+SXewQ13khnsBjVQWohHyIGaKSid0DuGRWdRiUk7ybqqZOarGdoy0pBYKBqy8upv4riHPcN0GmQs7HhchDOiDhVrzs8AsLKcNydPRaj6v09qfEo34yC0ZZCGo+Yb98QWGqpWc9yq3cuVuFcadvW9/t1MXs9zs7vuBdB+qdSXIcbWrMsssMyZQXidj7F02KFJDkPriVA8AeRJDIEEG0pGmfMYSQ8ZSQsxCDRYlsB8WT2E/bPQokIkgNK0cbW4g8K6cpHZrqbg/6c7+2k9Pxh8K90puyYZCJmV8hkTf+o6E1czLXhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 23:04:10.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec00b2-25c1-4a9f-d5b2-08deded78d97
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-GUID: PteIiy6QNyGXt3DpQdjFnBsGplmFi-tf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzMSBTYWx0ZWRfXwVqhTxeFgzzN
 34e12aiiwyjm/32hzdTzV+jddZZesBuoctnnhyGkQlxGBRqUVGUiEqgAz1xYwCWrV9zt/8fmyz1
 GBeKECULxrz6RfDmo3f/VxIp1ztsGQ7axFMK4pESmt/yqxHT0zabBTCD8qtyT/D5Kjs+voSgDM0
 H4aZiCjHXtuCOYDzDxQdXax3rXBUZXlvceCMYHQxQRW/w0UOPZ6Jylue14PCe14S5IQ/fYnbXoc
 U98ZSTZJbB4ggo/9rykE5kiqNIJxiTeZqMMtQfvfzRIMpM6+edfN16ktZR934OSLeIVucc5gizO
 h343w8NXfB53C7i+tW4wWKTooj+1AOiWjHtgzSL2nYiudY4IxMYtgHRX9o6vvVT1YpftCQ2ygCm
 WHYwvW6+EAEe4OSOkjrzg2rkq3jTlygDgMkrQlrFCTYWop/oQYpuYeKYIr6Q+QcC1Wa3aZtIEH7
 CIMv64DHMJx6+yzbDpA==
X-Proofpoint-ORIG-GUID: PteIiy6QNyGXt3DpQdjFnBsGplmFi-tf
X-Authority-Analysis: v=2.4 cv=UvVT8ewB c=1 sm=1 tr=0 ts=6a517a72 cx=c_pps
 a=cEhcA1GRg4KA0mca7hj4fQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=iRzyWor0Kp6vSfrL0oEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzMSBTYWx0ZWRfXxqUCfK6t9CsK
 AcpEF3+aNuMu/SKMiJftTQOITmUt8ble9oo822gMk0/MCOYKEvrDwDQhpVkypyIuYGNCPT2ZGpE
 d8+hHNKV1wPg7TZ3BkIa2yl5uHI0+eY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100231
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

Some board designs have slow RC circuits on GPIO outputs controlled by
PCA953X I2C expanders. On some board designs, pin voltage transitions
can take significant time after I2C write command completes.

Add an optional "gpio-settle-delay-ms" device tree property for the
pca953x driver to add a delay after I2C write if specified, allowing to
compensate for slow RC circuits.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/gpio/pca953x_gpio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index 965a5fcf30b..54b957069c9 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -28,6 +28,7 @@
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #define PCA953X_INPUT           0
 #define PCA953X_OUTPUT          1
@@ -89,6 +90,7 @@ static const struct pca95xx_reg pca957x_regs = {
  * @reg_output: array to hold the value of output registers
  * @reg_direction: array to hold the value of direction registers
  * @regs: struct to hold the registers addresses
+ * @settle_delay_ms: GPIO pin settle delay in milliseconds
  */
 struct pca953x_info {
 	struct udevice *dev;
@@ -100,6 +102,7 @@ struct pca953x_info {
 	u8 reg_output[MAX_BANK];
 	u8 reg_direction[MAX_BANK];
 	const struct pca95xx_reg *regs;
+	u32 settle_delay_ms;
 };
 
 static int pca953x_write_single(struct udevice *dev, int reg, u8 val,
@@ -116,6 +119,9 @@ static int pca953x_write_single(struct udevice *dev, int reg, u8 val,
 		return ret;
 	}
 
+	if (info->settle_delay_ms)
+		mdelay(info->settle_delay_ms);
+
 	return 0;
 }
 
@@ -333,6 +339,8 @@ static int pca953x_probe(struct udevice *dev)
 
 	info->bank_count = DIV_ROUND_UP(info->gpio_count, BANK_SZ);
 
+	info->settle_delay_ms = dev_read_u32_default(dev, "gpio-settle-delay-ms", 0);
+
 	ret = pca953x_read_regs(dev, info->regs->output, info->reg_output);
 	if (ret) {
 		dev_err(dev, "Error reading output register\n");
-- 
2.54.0

