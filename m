Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5D3C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1CD8409C;
	Tue,  5 Aug 2025 00:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xIVAnrHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3169084097; Tue,  5 Aug 2025 00:11:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC768406D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlqmDdmmIySAmUuZE+C45ob/g1iz6uOCVGDeYdR/xXq35yM1gas+9kd67be5G+tXslsZEmq5KMJ7N4hf5G5dV5O9saG9rELkU8mOXvNDaEY/7Oz4tZhfNvgt//IeH1JdgC3lM0MDX6y4CEGgBeXfU8t45Ko9Lb1UTarek6IXkLa2yiEfTpGNllHGyXWQT1SwCCHYYlZtHZCzA1uD6j/2PgQrepCrhsnTcp3M3iaIFk5oOOILVqQYk+9VhDPTCrcJEDxGQZHWGflvwabxpdL9VScZ3T4K+SG3hUYoCC/MApdi6q00/tkYKXsEd7IgSoYPfRNNqnALQ7ohkaWK6qTzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=Gx26FJmXUUVUh4SvUWu/sKJQpU1AV0r6vwnAqXNdKTMI7OQhcV5qbuhulV0OXKdqayru/qWrvT0R5vGlzXIFVSAby8QK6hT7DGDgTtTEGyGZ4B5cML10ys1bGXL46X6fywEIRG98ZgPaA5lNC7aV/Exn9rBaNFv3e8jeWfRdG8eQxw12Drgwukt9tNg1+LFNiz81dJf8zu4CFCAn0GwDMTckogwPAKS+KfLPsv0EakqrMeOuwwh6wsXS+Kfb9Kq4igarY5ek5QzSe02LWa3gZS5dCZFiO4kPkQC6Ep2J7i0tP3rML6jZE0gpPW+Vsv8cgtuF5ncFK9ZE2kVNZNvVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=xIVAnrHJ9m/y2X44HLukEpiIBRK64f94lF5YFmaH/QPagkaEIGZGhee+NefWyZ7Sn7VncCnLibXtoM0wUdTarm0JUXXaZNljLVO3ckgg6jTacc9JcZi75rMOAAJMQDXB7Oc2cLWwSR73GqIYqwtFe2tbLKJWfGQ8ETNIX8o6odmF+5I29kKlHlecJ971jnlN4LlZPFmJS8HVbdh99nsIhee88v8xEP2SbRL6N0J2Gqw6gWU+ASgd5i99jAto2PM0k6/jYsK/1+huR9rwj+yLD9DZ3DgQ8GO/C0DefFQewugcPUspqo1lrnBx44oZ/LtuY3h5VOarqWNLMD3lqyLxyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 09/22] drivers: mtd: spi-nand: more refactoring
Date: Tue,  5 Aug 2025 01:11:09 +0300
Message-ID: <20250804221122.1420516-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3e8414-fd60-4c02-75f8-08ddd3a3e48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PQhdoN7Ey6MVM0HlwHmDC7H1ZTpWPPzNgAqdFEmSOH7KpkNDjAir2dxNN6eJ?=
 =?us-ascii?Q?CDtYyWbv+W6w8PuSe36A1yJAla8G0X+GvvWBhtRw/kHdMBD0Y+5QvedGrTlr?=
 =?us-ascii?Q?G2ZvOFxOdVKEbPaRoXb59oVX8iv0PeML24P2YSHJ/S10P3grA2YttnZp/R1y?=
 =?us-ascii?Q?d3k3e79vVeWmjzvlffIK7+WWQBVOqGJu61FbLBfrD8zsw2UHt3uc4+F0lhqq?=
 =?us-ascii?Q?3+z9YZk8lcU6trvDDGOPmlif4xwRRJ6XbUspAdzQHHGE/3GQG4M/qhVXyV5X?=
 =?us-ascii?Q?SwNm5pKgPwUZlHnRHe09fEuT2L18LM/o7cngu6IzhQhu/nXG2Qe95ks6xi7p?=
 =?us-ascii?Q?yQyVYQdwfDWVaIFN9wiBSwF6mhifJICVMOjCAii8dadUqpbw6XpIxUVPQ+Z7?=
 =?us-ascii?Q?BVVYKxUBnfxYXka1LAxAV0h/7yJsZqOdfliakSPqg9+LUuqJPvakvuKiXpQI?=
 =?us-ascii?Q?W5EmhYTbR1U/BPZPaJXdrwRtNIagzFCM97gFbmSAh15N9ipXg1I1MDEUszms?=
 =?us-ascii?Q?1yRyXkbv6VKlOSQkiz5xdRyhna8y9u+WO8mTlgjYKfKydrgfWioHhYfEquBn?=
 =?us-ascii?Q?jTUf5FW4tWzOyxBG1gDQFzU69htRoKzF5n19nA550MPzbV9zEO2WgFmDgh/z?=
 =?us-ascii?Q?BS8wX9ejhyVk26qGvT/P8jguHHtyVEu5vXFDaPBM1ofF/Qod08TKuwwsGoC9?=
 =?us-ascii?Q?5/g2kGbDrf9JQddIszasE49UehSBxn60rpA3v1e/xyHRw5TQ3mV11MOt1sqX?=
 =?us-ascii?Q?fhQaOt1kLq0xfVXO3A/aqNVLNPL0INJmNOpggiCAA9KrZ59/H9m4JHhgUKAU?=
 =?us-ascii?Q?YtlxP4eymE8Oy6YGbI+rz5FL/t7m5UYOLuzL7NHr5sM45QIe0XFs9e/Xd35y?=
 =?us-ascii?Q?MZFyJsE6JUN2Nia3oBMyMw2NIGeIRJUdVlwlF3WPTrhWve1o3EYXSV8mcUH+?=
 =?us-ascii?Q?4nqVyr4n4pcxi/GgQNAaKuFfhBHCJrzAzcb6okVqQNFKHZs+ZFp3dHTjltmC?=
 =?us-ascii?Q?YrZILrFNBBEsJlkV5nxR7uo2KpL4l62X1+y5n7uOsf2jN3+y89nl/NaeqZFd?=
 =?us-ascii?Q?lntX32fgVjPbh49nFjH/PckXJ9OB/J+Wvk+vfG3I7HJV1+ofFOBOM19rI1Dk?=
 =?us-ascii?Q?iPqtDJhtOXDmZpklDt5O+pOptUQDvDxupQfnVSnMXPvYEFQMTCMb78zWUv4E?=
 =?us-ascii?Q?hDJahM2gAbym3kzUZhUGYs1urcHvZ7SnKZWEDN3ybh2Xf93wHc+HPVg1f1op?=
 =?us-ascii?Q?vT5XgX1lA6KeKYh5hme8n8Q/S8KED5SBHJsfGIwSlwyuGpBYsHI1DEqH3uHQ?=
 =?us-ascii?Q?gpOky95VTx7UiOImk6kETL891KGsJPcIENn+QkoN7fowUPoHJeneCdqg6CYg?=
 =?us-ascii?Q?8yJwxOG9W9dSxSUn6GxOnNmBpD5rh/w+FfP9PxAzTLTOkSMLJVKrSkMdata6?=
 =?us-ascii?Q?jf4ZJfz5moDYTFJAM716KXkr7gh1w/EUvUoofkPSBuAQb8NjAp3q9FzL3EzO?=
 =?us-ascii?Q?CD4vgWgm8V7vqvA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAROP2Mv+Gicf41GT7eG3X1UhyUIPj4ipRrcsQt4U0s5IjQIUsUmHL48Ut33?=
 =?us-ascii?Q?HBg+U+7fKqfVTvKFZ4TIq242fDVrAk4CCe6uhyo8CgfebluvCNuAPsAW2Nlk?=
 =?us-ascii?Q?YI9PNfbpcbkkKTTJV9pjhi6rB9bImgyP8xTslQr2nFU2zINld+8b1hta6tfy?=
 =?us-ascii?Q?2Gn8ivnh6RoIt3a5DvfCKD6NPUoiwhSVm1oLWrPSN0duugijdcEBWAZqFN7y?=
 =?us-ascii?Q?uzlgGdJFVVr1D85SsTVvncCGGXMKK3n+7xE2Jw+LiydE3r386zIo1bXGD0tb?=
 =?us-ascii?Q?kG9qEWEiG1gl5B1DnkiF7OWpH77uVZp0ClghVG+FOcxTfRQLvdzkTaZzwa5C?=
 =?us-ascii?Q?1tUwaNq1KAzwnx+NtZW/m6E/nHly+BaTBHh/rjvMuZGTxzFlkrymFn7KGhNn?=
 =?us-ascii?Q?et4/Ff5AhqXwbbNB0IRNTpchsnHEVjxcKLdgDwcFBSHbp4b8bPNeh5AHt42b?=
 =?us-ascii?Q?/+SDlIUk+xTk685OXGW7glztkGXP2mY0lVh4bRd9s3ZTpYWjNdFzHTgP7l55?=
 =?us-ascii?Q?EikNMpNCGpzZ2sDslGLLox1TNJOSHX3+1yxNaERi20uh6rRMfSAiYaCQNatz?=
 =?us-ascii?Q?RLlzU4w1UMSbly8irqOaQK0fZeWMjLktpRmk1jOIkfWWfeiy0F081MMFgSN1?=
 =?us-ascii?Q?FAqMQtH1FnFYEdfv7iWLbimM4+BKevAS6+I1UJxEMvJRJucIBxrmTMrzPblx?=
 =?us-ascii?Q?lWurw3Mp2fwTFt1tFSYPb38FUYKq3KXnS6lW2CEiAOrPEJRc3pAmuqGccH28?=
 =?us-ascii?Q?xDNWg7KTBNZHfm3TdD7IxpsKjtsq5MLKoBeyc1KaEEqqBQ8P0DOdoqJ0QQZ5?=
 =?us-ascii?Q?1xvn2H6/B2lu1cF1LwV9W0JF6hT+16j/2U9nyrNoQZLejtI1dpos85lc4qHr?=
 =?us-ascii?Q?niOIK/OntrIo5L51Pp9qBWAlYUwwbUXi+p2ForDqAYZCxQNxjL7FVmUH4WfD?=
 =?us-ascii?Q?cDk2f5zHtgtgivgNSRq9bQCMLTlUdEH1BB2N72JMeEquQo02wKVyVz0kZsm+?=
 =?us-ascii?Q?8kuTdECED+KVcEdnCR6TTZqsrttnGUhILViGDdleIbqFNej9T1POKUeHzQr2?=
 =?us-ascii?Q?TH1KRDP4G6mHARcXOH0ffz6p/Hq4qi72wnwp7dWm945UUvJW+5VQ8x0gvO+9?=
 =?us-ascii?Q?hfemhx75kEbPWUe+ZMOX2v7lDr+lfhCuPi5EO71Ct9UQY9tViyZQlynoAGHQ?=
 =?us-ascii?Q?RqQLWsr6u3HNVNjBhQx+5yV686n74k7Q5wUESRAULYzCTGqOJvCkxnIn3i7Q?=
 =?us-ascii?Q?4Y/2+TooNsqZ95IPioDitMuiwUp7It63zyC0JdCJvWVdvD+Q5HFb3ck1te1z?=
 =?us-ascii?Q?RS8mzaD+Oc6qbWaexjW81bhfuZ9FfxXEr9nU8DkmcUdgkim3aXjZmTyiM16l?=
 =?us-ascii?Q?zF8r3y9iKuE0L0yhNJdxF81mE2BDBmJZVlKps3iUaNLHdia72vOB271LjU32?=
 =?us-ascii?Q?kM8WoZh/uSPMFQ8nTOuG6EwensDVX0lYe55AArSuUk2ZvQgE9JtvJsZLPUIc?=
 =?us-ascii?Q?0dPFPUKKnL1+l98QstPEC3cCYTnN9/p1spqk0Qxb5m06OfmJDJBP6f9pgENN?=
 =?us-ascii?Q?lQjnzbA/Uxq2OMBbveyiAg/cIbXF3I58kOfQya98StE63yA4KvwIn+PmSc+R?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3e8414-fd60-4c02-75f8-08ddd3a3e48a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:42.5583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3907yANfuCrrkvIGIXMg80AtovntAbdGPp/cD05p1+uvhSmbYOonDXlDl4Fp+DN+RSa7DeUDF8D/xjIDf2k4lbzSSEQHr3zSXolmGNfd5x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This make code more close to linux-6.10 kernel driver

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index df59d3d23ce..a6353b37e7f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -413,9 +466,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -445,35 +497,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1074,30 +1097,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1187,10 +1186,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.47.2

