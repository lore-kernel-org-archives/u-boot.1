Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADBCF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85116892EA;
	Tue,  1 Oct 2024 22:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="tYyndZPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604A8892CF; Tue,  1 Oct 2024 22:45:05 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F98D892D4
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubfGKofa2F1tCSte/MM3Bja1MW60vchqn04mCc+CuPWdAU6DMbxya/VAkKqLNp7BDQvKPBwocqqAuf1TkrxoP1Dx3+uw+nIuTBQUFC20nhlwdfH4UX04DXZyspqLNTSyb6egPkXl4n0aAGp5FwDbnxD5+WrC0hh2XmvPkZG2vXtht6GVTt0sS+Y6lpX20rezkTH/N5mQTxFNv+sLVOMhf9SVO4Kyh27/Tdd7SShxyw8Cd6juEmqC93WcRBW/jZhbV8+AaXyNG6LS+9wSInwdJqqTiCHG1ojdJwn8kkjjryx7EReJ4dDhdOM2PxkHpPaqx4cRnBRY1yV7M0DtFdSDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHIpUbd1tqYqQ+cvO4iqyoaIM/DkUZef+50hZighZbo=;
 b=xPkCciz63LMlm8XkyV0mGaygSkK7vfOoVDC2v/sZB/9VUeJTf0/IBydpmMhESf7AE14FFwS/VvyYZ1ai5oQ3TTWZPqGphjgX3E9qvv/D8bNUTFdtI2iBYgrJIU1/udXtE14UHQwVJ80/vMT8/nheh6TbMoGohfLD9fap4GKBkfmx+//g07gzwTzcrNzpcmirscfrgQRZNhlCQLQAOwYs7znKiBqZ/IX49TmX1Cvv0sVwKhbKdIHvC2/TJw9OUHC3guhEV9xlVlcC4DhPiG5UtcFMYCTk2o9HLpYJdbINqku6z9V5GUR8VQfIMsqSnzgE/+xKtAVwrn78e2DvOKloKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHIpUbd1tqYqQ+cvO4iqyoaIM/DkUZef+50hZighZbo=;
 b=tYyndZPVCpFYEz5u0kNfC8cZejd2x3oz3wxWF0eMaJCv3QrsbUio5aMT0TF8reWwjYkEFm74Pcf5InQYwRzZhxN2CUpiS0g/rHWM/ODIVN6kG0Whi9wC18YtsgcMIBAaNSwUrFDNqSSZ/kJNmpr0sLDPNR088CBX6FPPg9FuxUWSdWofmUsIB8JzDFkp07qa6bj39/McM6BNc7KpDWfTbFkrXvlPxCbHw06ubLqBNoPgqZj4T7NLe1Dld82Xl/1qzWjqxiUPAsXqufNe6tD/b0Lb+9L15mDZCTRw6DFLDikqjhNkRzmSY9LbawOJvmp7G/DnxRKwbWT7lOZyGVM3Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:45:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:45:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 07/10] mtd: spinand: minor refactoring
Date: Tue,  1 Oct 2024 23:44:39 +0300
Message-ID: <20241001204444.917238-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1485deb1-99a8-4651-53e1-08dce259eba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OlFw9zvgAOCU8pBA39Yz/3AwA1QmALMM+ipNcDFB6z7gE4gANEUgZLH71Rnf?=
 =?us-ascii?Q?HK+fRE26nx7qxaj8ihWbGa7b6px2GcO7oC2ueVklSPaDesfHQoZV+YLJz7lU?=
 =?us-ascii?Q?dJR28yJJGUpZa98l+EoE6ooWkz508l8wfyTdYX86uQbYEer6U7ARb2G/r8FV?=
 =?us-ascii?Q?z6UBLyzfO4FHMLM4pF6UcwtPzN7dmKXdQGKasrYxL365xprb257DjxVLFma6?=
 =?us-ascii?Q?HIIn6oeWFeyYNlsxr7FjzOJMkRyxKDa8W5KsYWDGXDN3nTdKjNPucURVNvOm?=
 =?us-ascii?Q?0b6owbt4H9aSAuFAVM3yUoGOiG10kRrov30JBokVb5K/qaC+FTMmyK4sKvgW?=
 =?us-ascii?Q?vk9mD/PNuzgpkdaNpu5JIk8+2DaIWxc8K0ZVycD9qIQmF3g7cKrMVohmvZ8j?=
 =?us-ascii?Q?PYmOruIoT4N9sdgeU54nc07B9VAhKPlvQcTYtPlAlPKFIxz23CTQR6n9Em5y?=
 =?us-ascii?Q?GN4F0VA0G7VDJTCbb5HUppFSIy7B/p2c8wxsIOdaKbAAnctg/I7v5+cOC41X?=
 =?us-ascii?Q?EtaobCqjNWbC8nPSwJ1fDChs8ELHiYZkBVvuXiHkKa/4WCtbkFTfHadiYVaj?=
 =?us-ascii?Q?tA3VJ733DhLnU5uB4hp73SlBeFK9zBm/vF489mS31xqHfe5q1UtfB8A5zuvP?=
 =?us-ascii?Q?oXwlMEbtWfQTmoFPwwvRTAwXhriwczHEfMwz+T258r3CX1n3lSYm7+nhVwQv?=
 =?us-ascii?Q?jUlGC1tr5XUKfqMlULGUv1EcMa1WtfcZQsjzQvk/geaCpL6p8/MU7CErAcBd?=
 =?us-ascii?Q?UtZxlp4dBuusLav0s6zhiqIIvSNNf8O3EPTCt0Tsd/emQ3vtum8Fi7nFcG3p?=
 =?us-ascii?Q?HyKFrNpcQe0Io2xyxb/sWF2Q1Go+xiwGoB5oidtFQx2OPI32aiDWCE6d6p3M?=
 =?us-ascii?Q?wUyKbrBlVMIKOw1RzE+7kSW0YD83bKV03jijXy56YlZxeSTP6ZA1SbqOJnUH?=
 =?us-ascii?Q?ds5REV3CjsJpzL/c96zpCpWr9wtaaAW+JaSGvPZARTnSg95nzLGuMn666T0I?=
 =?us-ascii?Q?MaYon97GAutt8xYdV06oC9qubiOG1m02Rp0Yw8bF0Qjq0ymnrd1JmDyJGaIm?=
 =?us-ascii?Q?qGsGRnO2MIDRIPBGkciZuUrlp/o5Ud3sB2uKZ+50ZgFX2xpnLLITU3HDXUjp?=
 =?us-ascii?Q?b+57CkZ8ln5FsCsJ8NJORu2+L+xlJW2tJrfLufBIKJS+J0b4QhOzkcFOENmu?=
 =?us-ascii?Q?jMQ4M9VM7SxuJ69xD/L20IkaD8S2B5z6TrZbN8NcVUx/J8bFGdphrHR747nt?=
 =?us-ascii?Q?7CYXEFK/rCgpQqjPB9fjbxkVetOWdX07bo6vhcL8vtwQ2KySk8ZNrxk/H829?=
 =?us-ascii?Q?7dpDgLNAofJvksfq2vpdE3v2Qc7MEUNlkYvOi30/5cm0lkN8EhY937yY3Nb1?=
 =?us-ascii?Q?Xv2Uh4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Y8KO6Jt00qZXSz7vGCThafx0nv3ZlHkYgqdqYHUYrTjGYx3sHdMq+xz3eyU?=
 =?us-ascii?Q?xy4QGoqzbfwm4sYJDoIjMUYsxoZshz6y8NhuuZIptMQvXnS1stCuKuQAP2Cb?=
 =?us-ascii?Q?IbDaWdsrqGLeSuFwz0BKdM6pHZyHMabLBXwG//CuHgvQYcezWEIAF71SR50i?=
 =?us-ascii?Q?rRS1M3h1Wgo495i22ZtsZzWyjcEVcTxUpXDwRF3QWqpihInNx1+/j7LHQHDO?=
 =?us-ascii?Q?aULoC2w6FwHSZkQuLa3Fr3+FV7B4dmSLFwwbMBXjA6fOvgnuAnl09+ncz1hb?=
 =?us-ascii?Q?SOd0sIioE+1c0c80dAmvMfXtZSw2nLh58MfB4ScZmY/+XfD3ZyxkTNsil6Ui?=
 =?us-ascii?Q?L0ODdMmghbLffGavSMu+YVJSPFt08d14lQHZ3ZjCCKMI81ENCWXV4d6C50Yf?=
 =?us-ascii?Q?/A7WFGygpZUZDTeL2F7fcdYyYD5YpzzniziMfWUY4K97LAa828kGcY85RIgA?=
 =?us-ascii?Q?582ofH3ccNDPbgZ3uhYCN1FJX9lZaOU+3zOing2A8NgPlOJM3Nt9xTGtya5J?=
 =?us-ascii?Q?VBmaf6r3yfXfV0QZJEUzCqFqibYNqPHNz8ZoYQy0h73cwy4/cmfF3jG6v+op?=
 =?us-ascii?Q?9jARhvh8hndGjXnf/npXRfsbatMXrHVG2fd9zNtzozMWMjGa+TYIP0ldg5DY?=
 =?us-ascii?Q?sL/D+lqdxzDTNvzOKFwStCIDmIT89FoaN9eY1cr3M/2i8Hjxeph0/WJGtHTO?=
 =?us-ascii?Q?4+64lP3JaW2mkU8oeGGS7HgbrgcT49qCLOZO+qq9ZcZc/ZektRZ7DpMKUAtQ?=
 =?us-ascii?Q?vmqQebhdyRmAnoYWnwagP+CEB5vACN6uvUwk+dymK0g1UpAEx5+hSyoHPYj7?=
 =?us-ascii?Q?tsQ1P+eRJQBqZ/spdKj/PHUp76PhbS/fqqhwakKnz5Xxgi0rOdjFE3yQI0SO?=
 =?us-ascii?Q?3CoT0fYDojmWJYucPqfH7L7doQ2tZMLrILHbvsILhcnlmeS6N6fEnxQjlLhq?=
 =?us-ascii?Q?5ciIbciwPsHIiOZS80gwdV3Tn1767bOI7My10yHId+2S/FjkJnuQHDC/j+KT?=
 =?us-ascii?Q?Ke0gU0YfFU/HG4vYWpqYx0pjXnb6TgS8n8wtFh1PSCBSvXwNhwG82kkL7hbJ?=
 =?us-ascii?Q?eDx7wMDScw1v/XQXpt0bWUDvISoFf9JuCpTTSn0ze/+Y+nheFcjySys26wJ+?=
 =?us-ascii?Q?udi1BSECg15VZEqBtwiZN2T9tGvFJ+RBOzKrnaooCRsek11n7HX6LsqpOEBt?=
 =?us-ascii?Q?OYFbRIk7i4PPQT8h+ATMtWvCnTkQJt9K8TgJz5eyObTOpvM9LVm7MLknXxYQ?=
 =?us-ascii?Q?y0urPKV1r5jVN8MeroQDxuayxQrlVc/R70N5wjKk2l2LnWv5uH/k8GB6c1BR?=
 =?us-ascii?Q?9picNsI5mINAramEeTS4POpuzpV5p6KucpRV0VRO93tCh+XU4zC8gjzsI6e8?=
 =?us-ascii?Q?FepsKR8szXHiSMdteegUAGfRdUa8TRNx/zael1vI3JidBbIaw8LfF/IU5C3o?=
 =?us-ascii?Q?kOlNeW+azGkJsd46DSRlCl/agTn4llNXXG/yn3HIoBOTQnJuFw+YnN3PUktR?=
 =?us-ascii?Q?kSLrqrf6PmKh1X5s9Yp+ZiKut8eyzqL9POTzD0FTiFVqjoNmrlt3GVEpHx6w?=
 =?us-ascii?Q?FjuFTvrUzaaiA4iHNCDD03eYP0niBWjJN9MnM9floQMLjQGoAvyp6j0B6iDj?=
 =?us-ascii?Q?x5fCd5BOWb5XEZGQOHTtn50=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1485deb1-99a8-4651-53e1-08dce259eba5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:45:01.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzCmUNDtlul8ipTWDPy81bKVym1yOabHWt3hyezsTl/jd7GCzBEcPjKNp0cJFjlHG36JTH4V4I+6M74RZnBJzhCzaot601rgPny7ZPOFFW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
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

No functional changes, just some refactoring to match better linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9629fac3388..6ca8b7c80cc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1073,11 +1080,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1110,41 +1161,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1171,6 +1191,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.45.2

