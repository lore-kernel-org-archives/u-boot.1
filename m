Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F17CF3180
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E236D892E3;
	Tue,  1 Oct 2024 22:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="i2oRA6kt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 734C3892E9; Tue,  1 Oct 2024 22:45:06 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443BD89256
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNusK87UVFjOMgaiWW0s51GiYV1DJTlbMwN9eXrqh8jtNl6vJUfJApZmmNs+14CBd1L40AbNlZR8xq2ANE/8dpRCw8sB79gnG/9pGk9ufBCjeybLyaxFINuzc9tnUkA3vKdprzuJdmTICGkd6blwzQthebSOEO9/BP84SeAl+vUM/RJuJ4QjCr6rmfmBCPhBw8s8IMEmmBkkogpYmNldGp39CKO3rPbACPJ0o8rD/h2qlAxoftXKPH4gL/Cu9wanKaKOV2ycOCVDw5bN3mMvWNB0h1aRXu2N4CxYwkABUgLlDdS9D+oAHuWhf8cIhJQIIRBtvowaS3pe8VErC0ba2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/6p9hFb4G9HBd9BBmwi2nVPzvtan2Glp8fZHCixB3k=;
 b=BdDXlL+OYxtRuFqq3KNvve3hbPY/IajMiA3x+f6DZsjr5wsqZyish45K9/u8X9cuJLHrtlTsuJ4uYj3Szln+XHdDKHtnSy6OXsWJAIeDShI1dS16BLY8wzvj1MBe4p6/ihyV5lnjVevBtILIft3d5MQ8QKGsySYOR3G5dEn15ciHpYuN+9mtTYU2wSRHWloH+n1fQ+N/VtffVY2bt33slVuUjTOsqqruA5hpm4yI7RJYe5ZvmDvrZPq/WpJ3ClF6JJVXVmzo9MIOWdXD7GgiozFVeDnn3yMfWaSVTjli8B3MU73tgUFm6DdHKMUzujgSEOE5fXnS8RMiWY33eM+S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/6p9hFb4G9HBd9BBmwi2nVPzvtan2Glp8fZHCixB3k=;
 b=i2oRA6ktYJZy39BLzFWerYzqFRuVJbHCAlVx/b/R+qiK+a3k1RyWwalaLwncr0Rat620NvIqDlgAV3+p/CsxLeKxdrl7Bf3AEMjUm2VfLfVC8RGORlxRYbZ0ArXDXi8+2J8GWVR8W/BYT/GCCmrMrB+LVR1x6FdwFLeOmiC7j+PPDxJi7lDFK0m5ywTMYuXayXIgyo7+h6UvbQgprw3ADCzFkbXq5joR2eZjCVPkYPfj4hboEYnNRoP2+wAUpVARAFuWCw1tRiIpMBVdc+MJ63aSdiuGqsNuhiU1AOXcAB7Jce91PrUyCv6q/NMpsZODl1oMAU0LLOY+Xq9O9sV95w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:45:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:45:02 +0000
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
Subject: [RESEND PATCH v4 08/10] mtd: spinand: more refactoring
Date: Tue,  1 Oct 2024 23:44:40 +0300
Message-ID: <20241001204444.917238-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 4b0b076c-7d9c-441e-bb1e-08dce259ec7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?359Jagj3e+ylXNBDXgbNFNz1ZmYL13Po45l4BOFeiasDlQbG5COALD6cmzt0?=
 =?us-ascii?Q?7+kYsdHkjU9dHOgDwCmebMiVhYq2ZeU3V4td3WHwxOZjRpR5evH4viDJcrlx?=
 =?us-ascii?Q?f0ZKVwKg0ES9sWQwTEeKHSOb5FiwfFVf8jwrpx0P9z0KAJjs03j+ufHS+mzL?=
 =?us-ascii?Q?ll092QlscenZP/9JGbU1peY90ks32EbeqfFEjfZTMtXHYh/qPy2jEhb+Q7Vs?=
 =?us-ascii?Q?gfg6Pzz9ZtbXb6G7MJErtw7L8UPRXtOvHSWTxkpJcaZEikQThPEQG8WxmJH2?=
 =?us-ascii?Q?0orrkaWyM3j8HqzrrIMJarBJEJ9uC+iksXPMXyJJUXtkkqONx8i+84kT69QH?=
 =?us-ascii?Q?Er+sqodGf6TQkS0QKlSnn71LJoM5rfkWVfqq5HwdlRg9J4DHG90RO6W3Lxjr?=
 =?us-ascii?Q?K6wHJxL8Yf7WWC0ZHKV0ncb/9QRtF7zfFdaG+qvXb2+bwZv67SkEDMJHWX7W?=
 =?us-ascii?Q?y1tnulL5t/7LghUDlCOL/HxLJnkpabK1ukvJejWNAo6PLWgkS04ZbKi4vPpM?=
 =?us-ascii?Q?Bk7QMgb6QxxF+Ue5U1BBsc9KK9ycoZ1/alY/3PWCRPjMzcBhzH7zzJeFv58X?=
 =?us-ascii?Q?DrILOlu54fVZIGZK44gv++n49aBpImfnB+zAfh0AQTfCHWAcYudfHJJHLF+m?=
 =?us-ascii?Q?L52q3ZzGOLtUAHkvkWK6RsqAdNBD5uSZMqOJwNDTZYbdE9qeFI8t9z/OmnRy?=
 =?us-ascii?Q?az7GzunHwAjXefT73C4cSUXepJn3x7nbcFMJbfOtdrNscUI65d+MqDBMQ4Ad?=
 =?us-ascii?Q?DX/8GN5X3qYL4n9wS00tI9Ig6wtCiFjHGHe5S8eSitjxXbzqQYIX0GvLTvPw?=
 =?us-ascii?Q?1TPvqKe+5B5+ufGYaQxJYZTo7+7qx/tgyMPUJP0gRA0kG/tmtlvu8uUUoSBD?=
 =?us-ascii?Q?cAIEh2VD4UCwsgVXd4euY8mExbBuhrC4y4FCwpKgVNmB8BFDoMaCztb3l8++?=
 =?us-ascii?Q?zn/6NcoOBpxbv4BW9epH0yz/fXakbqOJqy4zveW2nGOMBxF5vQv4nPhxQPD0?=
 =?us-ascii?Q?miqnj3MEOGS+vT9eyeEZT0PV9iHNgK9CekXcsYfP1Y7mlZVFSWWr5MOIXRGk?=
 =?us-ascii?Q?s6BN8+IiLmTrzAnV1JgLH905hm6/anQlFYpE5eOkBXWx5kca3rKsVT3ZFvZ3?=
 =?us-ascii?Q?pJ1ABLw+xiPbpj6Z6a9CwKaDREFOCjHg9jdz9c8bqIENKXJu6bI2321LSqIb?=
 =?us-ascii?Q?zcJVUXAvwHvcv+qf9A76vpIZ1mKNxsZTTToH8mj77GQ6LVw833tFxcwYY1YP?=
 =?us-ascii?Q?0c7IQwXQk9YLJ6U8Kky8j22ozZwrTQazkd6SjRIGy8NbTEUirpl8FPXM2mLh?=
 =?us-ascii?Q?uI49sj7KpVB3gASKwoI8eeSdLNb0x16Y+enIyi72hZz+uA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tzA6H/ByiAXjSRdQF0Cg2TBAHOaJucNp0WlP2Igem9zJm0qXpmScV85hEva?=
 =?us-ascii?Q?du4RrzEPFA8XwQ92Ertm6TN9F9J5WXxy4LY0IQJv+tg1BS+IjxhL0mWZtqG+?=
 =?us-ascii?Q?f3npGqtmnMcCRtBYCBrlCvl2vavPktPT/9SWsSOHBjVwJxYHRHlYjHGSVQoD?=
 =?us-ascii?Q?xoH1qdWisNFAD8RIFxDLjg6DyA/RKSXKA3P2s0KQvEvRfHKfNlXfISf1JUqK?=
 =?us-ascii?Q?gSp4ejS6ghh+UHJHNuDaQBCPmCAeHodD3FdnYHKe6Sv4y4OLnEtAoS8z2Dpv?=
 =?us-ascii?Q?RMJ3PIZlCyYkScl+MB4vJTFLVv2w8xNjcrWv2SyM6sK9pSVAspu1tzk6e/L7?=
 =?us-ascii?Q?iKEHosHIRuWunPRcprLZN4oTjIY6YNHzShQg0tgDQF7TJQ9e5W48wPOpwT66?=
 =?us-ascii?Q?B+rTCdImFTUS7D3aPoqPjpKASecxyIo7VO5Rat2x8HC/9QBPOZXINwsN20Cc?=
 =?us-ascii?Q?Pfa8jCZfpxFg/tr0CihvAWohOySsuQvNxhRiBl7TMo8OeU+H0jwwpWCYgj+1?=
 =?us-ascii?Q?jndqf5gKZnzL5y2ktSrmo5QypP/oREeqp/6ugoeGKHCd/G0TvDm0WpQWBGcY?=
 =?us-ascii?Q?NqdBpUxiLwM/Nmau0EBdCM2gb3oeHOm86FLbCqScKv9edmpFHyEEUefoZlR1?=
 =?us-ascii?Q?xGSKwfh4oavy7WiHNhopkJkBFQdSujaOtQzHixrwZEs6gTwMNF4yyGa1+Dx8?=
 =?us-ascii?Q?klWpAkVYnk+NgqwcNY001OGC3ORSZuTgqL30reY6UcPLIRpLe9YVbKOp3w0T?=
 =?us-ascii?Q?CjQ8q6Zxo2oOAjnBcMiQTtWw+h1H59Q7lfM17+e3ByrE/Mav+D3Ar2NxuIdy?=
 =?us-ascii?Q?qxgS94C3sxYb4i7tgwGf2ryhAyAgRPVHm0jh6gkak544gbYCnqATC3EztRpu?=
 =?us-ascii?Q?T2ag8rLnBGERXEX1hQob4RYqjsQF19Lr7Sk+CUJiQLhjeNT+GnGw9bMZ5xCj?=
 =?us-ascii?Q?hzNfVWarLFK5MjpBWNew9TJqY3uGdU7CePdGHk71jpXUkGIo9yu2FflPvI8O?=
 =?us-ascii?Q?RI/wcP4PdTAbNU9MVudqDNY8AlLdvwnkLXP0t6Z6txLvOh1uK9e6TcJVX/CD?=
 =?us-ascii?Q?PMxjpjeLUGW7B/TE+TukgtfPSDqzztAlE+yw4VkOqf94h35rd21PKxRptBIE?=
 =?us-ascii?Q?ChdW2pPqA3RNkOIAZhpNaYg2slI8IGu6PDRkW9P8eOtkl1tqZ3mFtfnUHycC?=
 =?us-ascii?Q?Bc1WGUF3rDjFHrgh5T8kMK1Hj83jVf4Gku+hClqTEDA6b68dM+CAkpMxH0Tb?=
 =?us-ascii?Q?LXgxJG/G0njTK3A6hL0zOQ3SRFWLK2r0CkJauuSgen8tjCNzzPvjC6Al4gM9?=
 =?us-ascii?Q?jhxL0IPchdW2C2sLZiGrowF9Xjd3yq6noyzj0Y8LapOPD1uv/4pvAIGima4G?=
 =?us-ascii?Q?883sQP8xMUajMXRaZYc37P0YUbRdnh03sqIXGD+CcaWQ1eBOqAfq8AUVYRGs?=
 =?us-ascii?Q?rCvU/rdLiFNhPNOybdw5K3kFHLZoM/ufS4/0vTEcsqutSu6BLhb2/OdSNDz1?=
 =?us-ascii?Q?NZLvABOUobI1GcH07SXSc+ywMk2iOFFU0K8OKvZm2+OWiaICgjiWG1fRmw5x?=
 =?us-ascii?Q?zDWJqo0IGdGDpNkkxVUvku+rxlXmIE7sykuJkU1AsYCpsjE0HObdw9LV/dBO?=
 =?us-ascii?Q?Bx5+WfAM00dKtfb8IdvbSCk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0b076c-7d9c-441e-bb1e-08dce259ec7d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:45:02.8850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgoeQ82Eog/TLoV/x8U1qlpJO0DK2S1xcyTLSVLAXGAoL2t/RSUDvVW7aCVyCRHs9VpkxXrJYAM8h6JuRqesIec8qVarj8Vg90nBCyd62VA=
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
index 6ca8b7c80cc..548a7144ee3 100644
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
@@ -1056,30 +1079,6 @@ static int spinand_detect(struct spinand_device *spinand)
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
@@ -1169,10 +1168,6 @@ static int spinand_init(struct spinand_device *spinand)
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
2.45.2

