Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E292C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D990E838C8;
	Tue, 22 Jul 2025 13:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="D1CBTzBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E4083898; Tue, 22 Jul 2025 13:42:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17182838BB
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJBFkRN9aspv7lFPhYA6xh9jysFncnWw8er5H5PL1itYHKLzNICG6AnNWB6uDszLVEqlC1GSa34gfcV8n0LlzyDfCLNQqZyo+D5efNTv7emmbOJPesWOSQoRLOCU7DKeBGACfwKJkk05YiQKJcawXDtV4DEOkNuquYEe4QBaxBDQ1ZAWiw6BPAyjZsh8e/tRMHtc5lF4N+vsQvjMd0C7CiiYcEG/dl7q0x1+zYK5hxaFotDUChNaKDbc7zzOqTGXhsfVHaX1+b4acigSJ1tX2SZPQ/WDJkO+oIgLN9dXFQQjfcDep3AYOGpQYphoi+My6i8bU3zhZWLQsfNn2zNKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=solRFXJvvULD9GInm/+mGfuBiyDFqRlNlxdNpbmB01Y=;
 b=wcAwofjxLTSOZOZkxHfm3VRRLzkv2fPX1P+f6351kJlmMSlLaIAW4ftO9ajyEJJysmP6kDeydAbXm+cthMyaS19sJdiSO7a6P6ptrgjFzNpDcaWHwkk+zrGbImlFGdBfLucpBvegYO9bUyTPoklHHVh7uy5V1pNAIgfcuT3DjIQ/Idyd5UFbvUspoUWqLJlZlwXH3rrEt1GqRhcvIuI3VhK906sRYGni+mRdKlZ7xephNiCNLM6YAUjyreM9gtiV8/zsfaO290b/Odx9evu2i6ZuuVj6+FQzNjC4tGaUUTiyQcw7HkB2WY2APkbU3oDJubBJahCwFtLX9xu1z2FIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=solRFXJvvULD9GInm/+mGfuBiyDFqRlNlxdNpbmB01Y=;
 b=D1CBTzBMhzeQHJEa9dOgeL6BVoIXCEHia2JbdKQAm2VFCPEPsGVBPOi4rKJmfBEsV1jDm30pJy2/nhUb3+IdOp/MItWoQIrHekMaV8Rdhqf4uIsHmR1ywbRCW/XUOJUA0M34b/BLC8ekfMarKJ/nYE9Rx7EWUmHlbPv59EQmdx/KeLyYGe/CT4lx1MRAzr5fVdUTw3PgrLW9cDB7s8o5/CXYnodY9gVsVbPM0qu/Qx0lWigZvsdD4FXxUH4FEX9Sd0m/wapEEbx+1E1IK6jNdkSPxr1JrR8zzrj/NGKgVE5bpo5mAYuNS7/CmXu2SgC5mME1ReNenLa5V6imIKVM0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 15/19] mtd: spinand: add support of continuous reading mode
Date: Tue, 22 Jul 2025 14:41:31 +0300
Message-ID: <20250722114135.768998-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ebe973-4b1d-4d7e-ebd5-08ddc914cba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7xzqTwzugdUN0QSq9qZoz4eHugz8Ojx92YNmMg50K7sh28mOnu0msS2r1R/H?=
 =?us-ascii?Q?Lniv6nTZOmsr96RKBswasmZ61rgaknDRTYajQKYWiuxEvsLhaAm6fwADFrz5?=
 =?us-ascii?Q?7DNOWv8QhR+E+NG0UdCI3Suw+fZ01tPnAVOYVUgn8w3WSOFN7mrtuqbS3gZt?=
 =?us-ascii?Q?zjeo4THsc1kpe5NtBmpuu2HfMNfuXx7rcf/WMTCVvah502OhGtAphGayotOI?=
 =?us-ascii?Q?THkznfzBbwbpiqDPCaPx5Tow3FE+Rl9spB1QwkzHOSp1dC2isDS5X9eeXhli?=
 =?us-ascii?Q?s8iwtN4HuzXGm9srKwZ3/X1ol/tX3OhdvDXJQcS3jToVotvn/GjPGLHx5PK1?=
 =?us-ascii?Q?oH5eexuaLV3q+Wyj5KxEbaLVfUvv0BeHtmozRKIgHcE3IFd6gjX7DVA/EJv/?=
 =?us-ascii?Q?FaBYoASAuHL0jK5b/vLv+Bq5Pc20kNI+ndI7z/wN/rNMzYwUDFVkvDJ+YCAj?=
 =?us-ascii?Q?vOLmSvF461WFgxMKC7VGJTJHfTx1QPYjxxVMq1zNssidlNtnHA+qBp9Etxl2?=
 =?us-ascii?Q?so8s5/KiHhLdyb0vHjtf4/VnkCo9ke122xelOhepk+TCPDInsRmEmbHztseo?=
 =?us-ascii?Q?Y20QclmqniWMCEhjyBhOTKBI6VFA1ZTnHUy2JB9YM2LtuCxPuofbiNtBSrVo?=
 =?us-ascii?Q?dS/AgIuOFBHJgmv8xD0KCuVJhJ28fcecjox7tCF6M+mWhxNlAMbkvk+Zkizd?=
 =?us-ascii?Q?A/psRihRL6eKyuijeLuw+VPfecq8+51XpMCy9nOn3fXnVd37XF/1QHT9N0bW?=
 =?us-ascii?Q?GuX01OBCX4UAyS9QxOplbojN/rwH+ucRdTa373u2vRFlP+ruhwiJnY7D7jQU?=
 =?us-ascii?Q?3XAslT8nIqfa5vDR/OREqNeHTnTPhuYuwd9m3JWJEwbonvEH5yFTgpHpdLtb?=
 =?us-ascii?Q?dezIq9269Zu0EoM3/xqlSPu8YP60r6bobErbBf7mTGHeE1t1BKMARw0ghBN/?=
 =?us-ascii?Q?xiVT20oPTOLzMp+hyIMWInO9JMxRaswT0q+zSsqxp8KjoWHZkzLKoIjbxzMq?=
 =?us-ascii?Q?2vgOCnhuKdtHr+iAIoyPAXqqRV+ZYpMbVnLk34Vox/lgAZGyZdbg6uJz4q1h?=
 =?us-ascii?Q?KMcbRroB9VQoVJ9zV3UyeIFzrhw8hEVTU9+DPcqJhtT3AR1aEWDYQwEz6iCu?=
 =?us-ascii?Q?2C1wOZMsqMTka9vXDmr1BhGkqsT7Ao11dgy5H5xHYFxLb8gqK2cf9++BGO80?=
 =?us-ascii?Q?75vYn0asDHVXOQ+lD/rPcoYY4/sToR1vvpe8vPCFdQcJx1KMD95bmmbvlgdw?=
 =?us-ascii?Q?zMiY5BZ1ZH6XI3ovDf5nzOoMcwuZxSVW0Cn3yJq3th4r3LH1TRhyNbdQW3ta?=
 =?us-ascii?Q?D07nXFHWZpg8aGC6+w3LL7OBNtmUKjpmNPW8RmP6vDj3BN7hXib1JArjwAvD?=
 =?us-ascii?Q?fPw0RpLamQIUmxNdDcW7/ZrGC0iV7Z3Vk+RNjEyyQ3jBTbPrUYmLQXJYFtBA?=
 =?us-ascii?Q?7jAaM5bHDZZH02Tk7DS7730Q4023hgvAzbb2EbyA+11Cmev7l8I1SD1uDPI0?=
 =?us-ascii?Q?x5sSrzUwk67RcKQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJ7ieo3p8L95QJuqn55ZiNA21SfqI45Oldczi0UPPc6/rqKO4xzhbVM7LO2w?=
 =?us-ascii?Q?04sdbYAXSjdCnc+/XNMZtZMmpX3dSfXj/EznKUtd3crtRo2FWm13NFrIaEf5?=
 =?us-ascii?Q?P53VFZunGGdkt0Mxb9l45VmhPkFkNpPGt62Hdm+ZS0ZBOAsQ5iWlHvTau4F4?=
 =?us-ascii?Q?BnJyJqxgrNcXZqkSX2bnE19xF8sOgP5qQc/wRE8i7kUnHrVTH7uK3kiIXsT6?=
 =?us-ascii?Q?sEnUoUyH9Ir2HXwk2n7FGv9TlkRZytQCdLRCsv207iLy2qXtwX9v+h1xUfkC?=
 =?us-ascii?Q?ml3y18f4xvi/H3mrKbQBNk8hS7w4+Rr89OpCMH59CUKNEcxdVai+/lM7Aw4A?=
 =?us-ascii?Q?F1eITdkPrP0GgRGaF/qazyUURCpDdpIfYxK0h9yMq7xtk4sla2AUD4a6O01h?=
 =?us-ascii?Q?xhVfr/qQV2pcdVG/N6jkrydA3Bwk9bbsMR9vsAz3oOEt0dwgaEs+FdmT0cpB?=
 =?us-ascii?Q?lTaP5l2FqI43Ch612Ghipu0gLfhhBHcXggQrODoq9J7Zpp4fXXqQgLk/uXJI?=
 =?us-ascii?Q?TONT+D5yzayJ+FDaA3/Vv79lZx907EZHkBUjA8sj7HJU8nYfsGiDK8A8XaA5?=
 =?us-ascii?Q?USCoBekpLNHNRSjWI/QZaCU4W6R2i7kTxMJXzioWE2TQvVjsTLuS/XnyUSGu?=
 =?us-ascii?Q?fNHOsZAAWuhC+Ff5ZIIcP1CAz+MyN2krDDbjBGPBznk2vs9sLVIy5eKFo0K2?=
 =?us-ascii?Q?a2Tfti2r9OcRCTac0eDXccG/WlEgexyHVwlAu8tHHkXsdNERHh4P4Lmzo8zV?=
 =?us-ascii?Q?E279ltDUKOiHKBJxB/UEnwXEAR/zj6AmWEXFp52LNuHrJXx93nPnBHpP0P12?=
 =?us-ascii?Q?B11UhA8Qz4C5Uy6flZMU+PttR0nGNYJCim90yTZT/nEAkZCwh44rqo+XhXXr?=
 =?us-ascii?Q?z9H/PfdwdqtQyqvnN+C3n2Hu8h/5mBNz0yaVCGCbJBEWuzEfTCYpzKi6ucg2?=
 =?us-ascii?Q?jZ1qIP8mFtIR+hK04JyiFDLjxhkGibDSeePpGHbxuT8B3cmpZAenajryprRA?=
 =?us-ascii?Q?4k7rR2NGIt50v/kDhOxfcmPpXWhTL5rdWMqlVmkzOlG7LKrD4ah+qjtgBjlj?=
 =?us-ascii?Q?uZolCWxMboouyX5WdPBuCtXmN8eXfTsvrVAlvXna3XsjF7bfT6JcJCzKWZq0?=
 =?us-ascii?Q?FePM8+yFMrkcP334hxRw8FwvLsfm5erWVEm5W8nK4xSjVnq31f5sGAlrFt+P?=
 =?us-ascii?Q?pNOmLBVYO0o8PHk61u5LJicF6CQ7BvK1xpWeHFBKEugqKB1ETiE8wqlatJjP?=
 =?us-ascii?Q?8bfbjYDIwXHnSFjub3JBdVCdke3gj7GckEVu2zTUccU851dcoTSzpTldLHBv?=
 =?us-ascii?Q?xTAdx6JOChD7eYSbeTiX+/ypPDR7AN6EWfrb9WPWExZWa+AiWzI2leF+ND7F?=
 =?us-ascii?Q?G57jwdKSvPeH8GcLzA/PTa0AJcEBDLgMZzZPHSetmHZ7GStObixF+fBO32+R?=
 =?us-ascii?Q?zJhApjj8O2uKht5/KmfCAo/qfknHbJYIhrbKq0W0I4+ttmB++uQIEoL/Do26?=
 =?us-ascii?Q?i9TyMR7PXoA4l0qs/X0vZAlSN1Q+cIwoBb+q+Wk0y8JuqpH6m0jcBxxAsxf3?=
 =?us-ascii?Q?c4CD620k9X3RyIrEEoH0KG/oDinSC3rt+2L2GSXCuWi6B6cBGUk7Y0XgXBOv?=
 =?us-ascii?Q?tD4qSWhOXGFuwqyG+0mDdJo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ebe973-4b1d-4d7e-ebd5-08ddc914cba8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:11.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssOEof89jtePC+xvvZJYY1NweKEU441I9oSdm39KRdhRqIIiiqzsbTefEnR+ObXkAjzUGFAIOwYGFgZuYJi7pAi159GzAi2ctamSKzLnFSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

The code was ported from linux-6.12

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 210 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h    |  90 ++++++++++++++--
 include/linux/mtd/spinand.h |  19 +++-
 3 files changed, 291 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a8fb3177f8a..a52cc91dd3c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,13 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+
+static int spinand_cont_read_enable(struct spinand_device *spinand,
+				    bool enable)
+{
+	return spinand->set_cont_read(spinand, enable);
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -323,10 +330,22 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 
 	/* Finish a page read: check the status, report errors/bitflips */
 	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
-	if (ret == -EBADMSG)
+	if (ret == -EBADMSG) {
 		mtd->ecc_stats.failed++;
-	else if (ret > 0)
-		mtd->ecc_stats.corrected += ret;
+	} else if (ret > 0) {
+		unsigned int pages;
+
+		/*
+		 * Continuous reads don't allow us to get the detail,
+		 * so we may exagerate the actual number of corrected bitflips.
+		 */
+		if (!req->continuous)
+			pages = 1;
+		else
+			pages = req->datalen / nanddev_page_size(nand);
+
+		mtd->ecc_stats.corrected += ret * pages;
+	}
 
 	return ret;
 }
@@ -368,7 +387,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	if (req->datalen) {
 		buf = spinand->databuf;
-		nbytes = nanddev_page_size(nand);
+		if (!req->continuous)
+			nbytes = nanddev_page_size(nand);
+		else
+			nbytes = round_up(req->dataoffs + req->datalen,
+					  nanddev_page_size(nand));
 		column = 0;
 	}
 
@@ -399,6 +422,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		nbytes -= ret;
 		column += ret;
 		buf += ret;
+
+		/*
+		 * Dirmap accesses are allowed to toggle the CS.
+		 * Toggling the CS during a continuous read is forbidden.
+		 */
+		if (nbytes && req->continuous)
+			return -EIO;
 	}
 
 	if (req->datalen)
@@ -639,24 +669,20 @@ static int spinand_write_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
-			    struct mtd_oob_ops *ops)
+static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
+					 struct mtd_oob_ops *ops,
+					 unsigned int *max_bitflips)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
-	int ret = 0;
+	int ret;
 
-	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
-#ifndef __UBOOT__
-	mutex_lock(&spinand->lock);
-#endif
-
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		if (disable_ecc)
@@ -673,18 +699,152 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret == -EBADMSG)
 			ecc_failed = true;
 		else
-			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ecc_failed && !ret)
+		ret = -EBADMSG;
+
+	return ret;
+}
+
+static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
+					    struct mtd_oob_ops *ops,
+					    unsigned int *max_bitflips)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct nand_io_iter iter;
+	u8 status;
+	int ret;
+
+	ret = spinand_cont_read_enable(spinand, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * The cache is divided into two halves. While one half of the cache has
+	 * the requested data, the other half is loaded with the next chunk of data.
+	 * Therefore, the host can read out the data continuously from page to page.
+	 * Each data read must be a multiple of 4-bytes and full pages should be read;
+	 * otherwise, the data output might get out of sequence from one read command
+	 * to another.
+	 */
+	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
+		schedule();
+		ret = spinand_select_target(spinand, iter.req.pos.target);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_ondie_ecc_prepare_io_req(nand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_load_page_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+				   SPINAND_READ_POLL_DELAY_US, NULL);
+		if (ret < 0)
+			goto end_cont_read;
+
+		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ops->retlen += iter.req.datalen;
+
+		ret = spinand_read_status(spinand, &status);
+		if (ret)
+			goto end_cont_read;
+
+		spinand_ondie_ecc_save_status(nand, status);
+
+		ret = spinand_ondie_ecc_finish_io_req(nand, &iter.req);
+		if (ret < 0)
+			goto end_cont_read;
+
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		ret = 0;
+	}
+
+end_cont_read:
+	/*
+	 * Once all the data has been read out, the host can either pull CS#
+	 * high and wait for tRST or manually clear the bit in the configuration
+	 * register to terminate the continuous read operation. We have no
+	 * guarantee the SPI controller drivers will effectively deassert the CS
+	 * when we expect them to, so take the register based approach.
+	 */
+	spinand_cont_read_enable(spinand, false);
+
+	return ret;
+}
+
+static void spinand_cont_read_init(struct spinand_device *spinand)
+{
+	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
+	if (spinand->set_cont_read) {
+		spinand->cont_read_possible = true;
+	}
+}
+
+static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
+				  struct mtd_oob_ops *ops)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct nand_pos start_pos, end_pos;
+
+	if (!spinand->cont_read_possible)
+		return false;
+
+	/* OOBs won't be retrieved */
+	if (ops->ooblen || ops->oobbuf)
+		return false;
+
+	nanddev_offs_to_pos(nand, from, &start_pos);
+	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
+
+	/*
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so it is safer
+	 * and easier (can be improved) to only enable continuous reads when
+	 * reading within the same erase block.
+	 */
+	if (start_pos.target != end_pos.target ||
+	    start_pos.plane != end_pos.plane ||
+	    start_pos.eraseblock != end_pos.eraseblock)
+		return false;
+
+	return start_pos.page < end_pos.page;
+}
+
+static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+			    struct mtd_oob_ops *ops)
+{
+	unsigned int max_bitflips = 0;
+	int ret;
+
+#ifndef __UBOOT__
+	mutex_lock(&spinand->lock);
+#endif
+
+	if (spinand_use_cont_read(mtd, from, ops))
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
+	else
+		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
-	if (ecc_failed && !ret)
-		ret = -EBADMSG;
 
 	return ret ? ret : max_bitflips;
 }
@@ -821,6 +981,7 @@ static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
+
 	return ret;
 }
 
@@ -846,6 +1007,7 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 			   SPINAND_ERASE_INITIAL_DELAY_US,
 			   SPINAND_ERASE_POLL_DELAY_US,
 			   &status);
+
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
@@ -902,6 +1064,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1131,6 +1296,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->set_cont_read = table[i].set_cont_read;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1256,9 +1422,8 @@ static int spinand_init(struct spinand_device *spinand)
 	 * may use this buffer for DMA access.
 	 * Memory allocated by devm_ does not guarantee DMA-safe alignment.
 	 */
-	spinand->databuf = kzalloc(nanddev_page_size(nand) +
-			       nanddev_per_page_oobsize(nand),
-			       GFP_KERNEL);
+	spinand->databuf = kzalloc(nanddev_eraseblock_size(nand),
+				   GFP_KERNEL);
 	if (!spinand->databuf) {
 		ret = -ENOMEM;
 		goto err_free_bufs;
@@ -1283,6 +1448,12 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_cleanup_nanddev;
 
+	/*
+	 * Continuous read can only be enabled with an on-die ECC engine, so the
+	 * ECC initialization must have happened previously.
+	 */
+	spinand_cont_read_init(spinand);
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1330,6 +1501,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	spinand_ondie_ecc_cleanup_ctx(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 910ef56ed0c..9285edd5c4b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -101,6 +101,8 @@ enum nand_page_io_req_type {
  * @ooblen: the number of OOB bytes to read from/write to this page
  * @oobbuf: buffer to store OOB data in or get OOB data from
  * @mode: one of the %MTD_OPS_XXX mode
+ * @continuous: no need to start over the operation at the end of each page, the
+ * NAND device will automatically prepare the next one
  *
  * This object is used to pass per-page I/O requests to NAND sub-layers. This
  * way all useful information are already formatted in a useful way and
@@ -123,6 +125,7 @@ struct nand_page_io_req {
 		void *in;
 	} oobbuf;
 	int mode;
+	bool continuous;
 };
 
 /**
@@ -638,19 +641,19 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
 }
 
 /**
- * nand_io_iter_init - Initialize a NAND I/O iterator
+ * nand_io_page_iter_init - Initialize a NAND I/O iterator
  * @nand: NAND device
  * @offs: absolute offset
  * @req: MTD request
  * @iter: NAND I/O iterator
  *
  * Initializes a NAND iterator based on the information passed by the MTD
- * layer.
+ * layer for page jumps.
  */
-static inline void nanddev_io_iter_init(struct nand_device *nand,
-					enum nand_page_io_req_type reqtype,
-					loff_t offs, struct mtd_oob_ops *req,
-					struct nand_io_iter *iter)
+static inline void nanddev_io_page_iter_init(struct nand_device *nand,
+					     enum nand_page_io_req_type reqtype,
+					     loff_t offs, struct mtd_oob_ops *req,
+					     struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
@@ -669,6 +672,43 @@ static inline void nanddev_io_iter_init(struct nand_device *nand,
 	iter->req.ooblen = min_t(unsigned int,
 				 iter->oobbytes_per_page - iter->req.ooboffs,
 				 iter->oobleft);
+	iter->req.continuous = false;
+}
+
+/**
+ * nand_io_block_iter_init - Initialize a NAND I/O iterator
+ * @nand: NAND device
+ * @offs: absolute offset
+ * @req: MTD request
+ * @iter: NAND I/O iterator
+ *
+ * Initializes a NAND iterator based on the information passed by the MTD
+ * layer for block jumps (no OOB)
+ *
+ * In practice only reads may leverage this iterator.
+ */
+static inline void nanddev_io_block_iter_init(struct nand_device *nand,
+					      enum nand_page_io_req_type reqtype,
+					      loff_t offs, struct mtd_oob_ops *req,
+					      struct nand_io_iter *iter)
+{
+	unsigned int offs_in_eb;
+
+	iter->req.type = reqtype;
+	iter->req.mode = req->mode;
+	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
+	iter->req.ooboffs = 0;
+	iter->oobbytes_per_page = 0;
+	iter->dataleft = req->len;
+	iter->oobleft = 0;
+	iter->req.databuf.in = req->datbuf;
+	offs_in_eb = (nand->memorg.pagesize * iter->req.pos.page) + iter->req.dataoffs;
+	iter->req.datalen = min_t(unsigned int,
+				  nanddev_eraseblock_size(nand) - offs_in_eb,
+				  iter->dataleft);
+	iter->req.oobbuf.in = NULL;
+	iter->req.ooblen = 0;
+	iter->req.continuous = true;
 }
 
 /**
@@ -694,6 +734,25 @@ static inline void nanddev_io_iter_next_page(struct nand_device *nand,
 				 iter->oobleft);
 }
 
+/**
+ * nand_io_iter_next_block - Move to the next block
+ * @nand: NAND device
+ * @iter: NAND I/O iterator
+ *
+ * Updates the @iter to point to the next block.
+ * No OOB handling available.
+ */
+static inline void nanddev_io_iter_next_block(struct nand_device *nand,
+					      struct nand_io_iter *iter)
+{
+	nanddev_pos_next_eraseblock(nand, &iter->req.pos);
+	iter->dataleft -= iter->req.datalen;
+	iter->req.databuf.in += iter->req.datalen;
+	iter->req.dataoffs = 0;
+	iter->req.datalen = min_t(unsigned int, nanddev_eraseblock_size(nand),
+				  iter->dataleft);
+}
+
 /**
  * nand_io_iter_end - Should end iteration or not
  * @nand: NAND device
@@ -722,13 +781,28 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  * @req: MTD I/O request
  * @iter: NAND I/O iterator
  *
- * Should be used for iterate over pages that are contained in an MTD request.
+ * Should be used for iterating over pages that are contained in an MTD request.
  */
 #define nanddev_io_for_each_page(nand, type, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
+	for (nanddev_io_page_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
+/**
+ * nand_io_for_each_block - Iterate over all NAND pages contained in an MTD I/O
+ *			    request, one block at a time
+ * @nand: NAND device
+ * @start: start address to read/write from
+ * @req: MTD I/O request
+ * @iter: NAND I/O iterator
+ *
+ * Should be used for iterating over blocks that are contained in an MTD request.
+ */
+#define nanddev_io_for_each_block(nand, type, start, req, iter)		\
+	for (nanddev_io_block_iter_init(nand, type, start, req, iter);	\
+	     !nanddev_io_iter_end(nand, iter);				\
+	     nanddev_io_iter_next_block(nand, iter))
+
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 63626c9c27c..2f8212e4037 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -175,7 +175,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
@@ -336,6 +336,7 @@ struct spinand_ecc_info {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @set_cont_read: enable/disable continuous cached reads
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -354,6 +355,8 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +382,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONT_READ(__set_cont_read)				\
+	.set_cont_read = __set_cont_read,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -422,6 +428,12 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @cont_read_possible: Field filled by the core once the whole system
+ *		configuration is known to tell whether continuous reads are
+ *		suitable to use or not in general with this chip/configuration.
+ *		A per-transfer check must of course be done to ensure it is
+ *		actually relevant to enable this feature.
+ * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
@@ -457,7 +469,12 @@ struct spinand_device {
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+
 	u8 last_wait_status;
+
+	bool cont_read_possible;
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 /**
-- 
2.47.2

