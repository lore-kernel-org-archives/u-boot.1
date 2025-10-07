Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45832CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 10:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C3F8409B;
	Tue,  7 Oct 2025 12:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hiM1nHXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C2A8409C; Tue,  7 Oct 2025 12:27:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E0218409A
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 12:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTGCNHp60x9/bwCSJJaj4oYmo4RCjmEugSuHTgiB9Ofn/3xtAjx0cPXhbFmNWXfnxpAOpPAFzhcKOIQPjTNJAY0nbQzvz/sD5fTfNegLwRezsYdudLi77+igvkI3QFzwTnlj7bGsnASCeiL4dBLgLAT+77monb1kASW7yxBh2yotswTzvqgWv/GBm6u3HdlrxW9eeBnc+tJW/I4Yw8DGi9CKd3dVKeQU9dJJ9Jjn5gpnGxhYJq9G9lrVhKyr6TLfB2UDWE2le7WD5dAjO/CovbIX/TwHJs1pHOSlX7vjbE5GUulyfkq3H3a7bjBkAGcjIknrXsOyVvDdAeYCKAO8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt++K9us2m35D4lD6A0qsb8ahoeKtzh3wlp5jWiWk2k=;
 b=siTZwYXXpVzpdo1FKBhIKBQs0tv88jYDNoY+5McsaLKtlVo3zx3BF/4D7YTdjbu+VSCvsYLszg32BzTwIpOtedZh4Lgy/EU85bLMYlnvKozuwssDnmElvQsolQn+4VVKcijQ4QbTPtK4opMitjaT4yUdZEg3XVyFmhOdJMd1IR0EdSj8SCQOw7o6udImzoTG0X/EJ2RDZEn7TBvZ09jEJXe+WsaV0dA3KJvvFbZL6R4EKzMVNewaVbVAzPjsk4+LWrM1BKhasvBoIIXbfhCSPROU6fw3V8bKvVtqEsByDH6Dq3TcpYFrNBsY1OJkCt3pk7ntmSE90OcewFqRB2Wc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt++K9us2m35D4lD6A0qsb8ahoeKtzh3wlp5jWiWk2k=;
 b=hiM1nHXVaxYS/Qxl2q27WGu6gTzlZIhONMO+yItoTC1SNAXLi9ralrwPz/5SP5vXsCFCJVBRlqGxPE9JPIfefItk/HLHBRjjZ9cIvAXXvwKzwofpe9O9ZkzpXOiB++1vDisClKnpH+/X27a7reyKi1bebIoTZpf5mIW5O1fgHEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA1PR10MB8918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:26:59 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 10:26:59 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] gpio: search gpio-line-names property in dm_gpio_lookup_name
Date: Tue,  7 Oct 2025 12:26:37 +0200
Message-ID: <20251007102637.792524-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA1PR10MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 772f0989-5913-4e10-4936-08de058c0bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VQUm9SRj1W/UN0sPEf/zjB0AASpgXRE285ER2+6Zr8rzb8P26WSByNtdOcbI?=
 =?us-ascii?Q?gxwhmU2o7phqPg34i9YsVH/1wYlZH89EcoPPV+KLm5KqFTMcF3ST2ZSHhWxG?=
 =?us-ascii?Q?h89tYfIKXkYgDzFyaBr0S4/UhnOSlO0QRQNnGXUCWBJniRBIae7C9Yx2P5GF?=
 =?us-ascii?Q?3KICpMC10822LvQ7mnf9UAis2vgddo6SmPL49HeMt5xmLaDaAUOvC9GiPTwM?=
 =?us-ascii?Q?6RjknoPG6p8rwR/4fHLmXiwSXATfXa/QJeHYinEY5eBInFCk2nh2Nal66Zvr?=
 =?us-ascii?Q?mhNAThzLy3M+hpDPlJbaTYLz3pn3u5aZaEf7mDXmZb/132AMtBkLZm1h3qHN?=
 =?us-ascii?Q?AR2ZlNN/xSndSZyduWtHzyKJNcYy1Fl/LfutOQH1dYJd60C2k9WSxnEgEOlu?=
 =?us-ascii?Q?AZ+sAOrnfBUz8oksTTWgCOvp4Ot3JDcmGQ6TQpiHhB/72MvcKn1muRQcHP8X?=
 =?us-ascii?Q?qaiR8zJuHjASmO3FPbYMVXvB8yHPIDYzVLxDH/57/+ED12Kfe9BjsPC5SGmv?=
 =?us-ascii?Q?438Mpd69xrFqxqgpPv/QlJHE1LvkL+rSBly9viNYZ3Zul7ycwGlJZZq6q8eE?=
 =?us-ascii?Q?rhU/W/uIIhAGz21YJVXbZDqhPmOSwwVwfPGA8I/uSkSveLGfXHcx1mkU+3SF?=
 =?us-ascii?Q?j3gO2Wmf06zvR7c72OH3M5RSDabtYTbeBabZ8/QtKoQOF5c9Kdeyd1KnMK+0?=
 =?us-ascii?Q?Q04gsJvjsUMVBBBUutQEof04EyT3pGKXf24rBD/SDJmQDW0hQRZyNV5CZxBa?=
 =?us-ascii?Q?BFRBWUbEMLCCb9m/h4vooNb9ydtzGQhyCd1DFjCHac/cTxouwxgFBXTGS+Md?=
 =?us-ascii?Q?E5M6307+OmZ3bE3M/woBW9BE9HDf0LBfamG9uP7ZIhzSBmuvjRnyRgo8AYvH?=
 =?us-ascii?Q?irsKZYVohuM1VbGvrjjhKcrEFu9eIf24gmcoDScJ+HGC+OGvhx4hG0opdy3E?=
 =?us-ascii?Q?hsYFDe6Vhp6BmiHNBhwB1ypeQjengHTDwvrcE+BLo1lwZ1i9QrELu/KJ5fBl?=
 =?us-ascii?Q?AWa4GCFTSRufP4nUkdK7L0GU3aZj7gC1C0f/k5FI1DfmYwHkxamNf1O4vYzd?=
 =?us-ascii?Q?0sQqZsk0g9d+ZW9Qij2u3fHoJos/Zxto1IzOEblGXl0SfzcQyVKARSOM7axf?=
 =?us-ascii?Q?iRV3u+dUfVC1rL9BfDT/JcDPLoaaYsynco0Q3c8I5+tXFJ64IZTKl6kctMrJ?=
 =?us-ascii?Q?kaIMcw/FFNcNkYJCzqRYPIlXV29J5/3u5OR8czMtEBzEly3NKuwNSUC8gbTv?=
 =?us-ascii?Q?jxaUzlWDro3TcoPkto7kN0wsBXNYX2V+bGNzrkwdiYbMw6s4cRQNyVsiLKzk?=
 =?us-ascii?Q?V7ocPGqPx4yd8XaW7HTqLovrvsf3oYDSfKXwhAb+61hf6bUNx4As8d9FwDCu?=
 =?us-ascii?Q?+b4NIYpZ5nU8DCpBZTwHBuMUGpu33tnZNe2DtOzA2l7TI4RvjHx8bIFKpm9u?=
 =?us-ascii?Q?ZdH2gl1Kg4HI96cQ5FnOJF/OKw2mTTzvJ4q+ThlKMKfYtEECzA20msne5LQB?=
 =?us-ascii?Q?qOQihqNLprPy/FAyE/YReXDkOVHVxcrbKWeb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKyR0qbDuyWFR0WmfGIdvDGVsRY8Nw9uP3dsQe3zoa0CWYqERoWQJRisHWNr?=
 =?us-ascii?Q?NcQGQxNVj3/9BG7+n/RnJ/70JcbKSpndjwvyJ4LCcAISKaH4d36PE5dCtR42?=
 =?us-ascii?Q?4iPDER3v7JVxeHoH7MCHzg2varIN8Pd8k9pqMd7iY10gS9xDmt7VOO7Iigj5?=
 =?us-ascii?Q?kR6kGubvibHh1jem/zFkexjQReRyR8mXL0Vu+7LB5GXNqfjvQa7cRZ8JyYH2?=
 =?us-ascii?Q?SwQbGR8o8IMnIGidPu+3856H8dN2Y9Abz1mobgskpcVa7IvFeesXdk6AHDsL?=
 =?us-ascii?Q?6XMRVk8C/hNZta51q8e+oRJXWqlFKuqomGuWVRZIn1Zeza8ffFj7jMOPjHBW?=
 =?us-ascii?Q?bKztR0TPN65bekgpjelKtrey0qrUmb0RkAKOjeAps3NNoNn6gJ7P2rMY7mj/?=
 =?us-ascii?Q?RM5tP28HCIKe3gMBpShiK7N8ffaZXhF8mYu/4mogWQVPNdzXHeYjoEJprRsW?=
 =?us-ascii?Q?PjzspxpRIOtp65BOhmOx9ns1Db5xyL1JnnyHowpORRrqwRewWstVOBMfuIRT?=
 =?us-ascii?Q?T58fGho5PDesBv5UIcd89nflXgodUn55AMzSohJKaJJ01TrkemrBFCmcahKq?=
 =?us-ascii?Q?99M53zsjL9k2YsU5B/UhF9Bjt/7Z04i7x3WBt5qelGzgBk6aWm9sEkCN2uKl?=
 =?us-ascii?Q?jZcSVZFaM6sDMEEyAm2Hrdlrbrug3AGfqwKc0zsmPdYxMsDDzXcNJfCPBIhG?=
 =?us-ascii?Q?PvYw9GzmM3ZEvSSEIYy9mwXrYA2fG19ZAHk7NuNHMyWbG58qpGZ/J1b+wO4W?=
 =?us-ascii?Q?TUx9eoCIR7c+20oOLtxHY7P+qgQakVMh7uTXLnbDP6VTuP3etQ/f5ttnvsJQ?=
 =?us-ascii?Q?MMJYNihMVVuPpWcxbLdRHmUFK6+ADlw3tYL2jvLRUcQMTD7KI7W1FSOa5JbE?=
 =?us-ascii?Q?LdEvQAaGfnO67lCX8Pn+0HdbQFXOApej4DL/viWmp4znGs+X+ciGV+JkgODu?=
 =?us-ascii?Q?M+/8o7dhde21Tfh2kul/CscGnSMSXglqn8QUEaml2E9wtEZb/NPVTQ+pwm9W?=
 =?us-ascii?Q?WT/zLZELNoQMOJnvY+30P+nPAKNIQznmOJfzmkRk8/eU90M5lPIEzLE6LXyj?=
 =?us-ascii?Q?GKSWyxcCnpvJfMq5GYfRVSut2bh73GO6MdUvcZ+RRGvLOfQCpkkv6xYhZ+dT?=
 =?us-ascii?Q?qMwq+Mlto6Qzpu3g/Ofb76IIPkDpGH1hpDldFUPqX+nqr6xrYM8P9b7fbxzW?=
 =?us-ascii?Q?78tM6kEUPtfGkQ/yA7n7JW63Yu/I2wLtq/aepZJjXtsVjyRKRETTuvvQlkMR?=
 =?us-ascii?Q?vHXG37JRhdQrwHksMApGwxLjVJnkSBbm1Si04AhHdsM/5KAAsXBiTHNnMENi?=
 =?us-ascii?Q?PrSrU0pP3ClxJGUKopC5tXN0JLWJqju2oTyxZy/e0hKKS+B+xYegbKykE6kM?=
 =?us-ascii?Q?h4UNQ+XFbpkKRpqiKGd+da254qZXVrauwkS/YNbr13UQKu8lOk2pCVlfJ0G4?=
 =?us-ascii?Q?uo2/HQSxY/uuigKdqkfW7m5GnpD59GkA9SzrcNEM5dHDCOm4gvoJCOuk1jj5?=
 =?us-ascii?Q?3kj09XuRMrDiLbxPo3NRTpx1Wg3BwbJNrUeGS9b634Ju3SEbeV8uSHp18Op1?=
 =?us-ascii?Q?aD/ptjrhPfixRtQKPOLRQPCa1zwNQqSdAd1rSdzO9N70dkVLG1frBDRLhrYv?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 772f0989-5913-4e10-4936-08de058c0bed
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 10:26:59.0016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijowvRw0sjuImuTeZ2sNF0X6sF/RN4Ox2fRCib5V3bdGn8ZH8Ft64+1gEa7A3FYVLznm7FgSeZWlW0pD55STLd3KwmC1HfE2OX85/iRXdA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8918
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

In scripts as well as interactively, it's much nicer to be able to
refer to GPIOs via their names defined in the device tree property
"gpio-line-names", instead of the rather opaque names derived from the
bank name with a _xx suffix. E.g.

  gpio read factory_reset FACTORY_RESET
  if test $factory_reset = 1 ; then ...

versus

  gpio read factory_reset gpio@481ac000_16
  if test $factory_reset = 1 ; then ...

This is also consistent with the move on the linux/userspace side towards
using line names instead of legacy chip+offset or the even more legacy
global gpio numbering in sysfs.

As this seems to only add about ~50 bytes of code to U-Boot proper,
and dm_gpio_lookup_name() most often ends up being GC'ed for SPL, so
adds no overhead there, adding yet another config knob (or two, if it
also needed an SPL variant) for this does not seem warranted.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/gpio/gpio-uclass.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 3d9f8b32b8d..6b357a2671b 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -164,7 +164,7 @@ int dm_gpio_lookup_name(const char *name, struct gpio_desc *desc)
 	for (uclass_first_device(UCLASS_GPIO, &dev);
 	     dev;
 	     uclass_next_device(&dev)) {
-		int len;
+		int len, ret;
 
 		uc_priv = dev_get_uclass_priv(dev);
 		if (numeric != -1) {
@@ -188,6 +188,13 @@ int dm_gpio_lookup_name(const char *name, struct gpio_desc *desc)
 		 */
 		if (!dm_gpio_lookup_label(name, uc_priv, &offset))
 			break;
+
+		/* Also search the "gpio-line-names" property in DT for a match. */
+		ret = dev_read_stringlist_search(dev, "gpio-line-names", name);
+		if (ret >= 0) {
+			offset = ret;
+			break;
+		}
 	}
 
 	if (!dev)
-- 
2.51.0

