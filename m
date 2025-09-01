Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D37FCA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28ECD83A24;
	Mon,  1 Sep 2025 15:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74C9833E9; Mon,  1 Sep 2025 10:25:23 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB62831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 10:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byJNOZ6b7oSSUVPcIevyUWOjP5JkcLeF8vNralujCm9aBUHdTOs8v+vYSEV3fiDiXIjgeOZ6GDya6zeOtUA1flo1yM/GVpwulO4u3Fkw47xCRKpdHmfd3vTiVP6W3f3YzCvaQep8iShhlQHP5FI2f3EOFFF/nyPMjhs9ITXGI28dGF18ct9x4l/TCceGQfImgst7WL1xPXtBlOKIJj/NoeX6EWFRkQeZnq7yU8j/Y4Bsve08JLg169nfCbs7vsfW3/Y8xo4kU7fncrXKBpKS3FYwg95QzLv8PPMcZFAIuDbup+TraAi/BNylfZFFhtr/LnTrXwDXr+b+qpxq2yxe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqvLeCHPB6Ii0rUw9XN/ST5g+IuaUlY3Eu8582jcYqs=;
 b=bPRHhVKV3khbDCYYR5DmYjZX758nCJcyjWIFu/H8mIMel50Le3rEJkg5UyAOtsGbR8c81T+wFJxDjPhZIJw7ZK0NppdehFS1Hra3kElQDUJr4oWZqql6jM3OWYUGMOkCdVXVnreWY6xPiAKb3t9TcBt+FUREssrBTKfkQ5OJCXTNmxQ9iDq7gUEoixW4QhBcZiEk9oqcrcotE8XwI0UueyDRMXuZ0T0wm9JfUukOhB7ZJU4aVEANQhGdVgEaCQ9S6o5oLjlpCQixumhNrna8z+vkjj6Wy0U8BoVvDgsiJV1QA/qG+kVm3B3+xdQ3O9FSlZzwjgH0pl5pPqyA2GULmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 08:25:15 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 08:25:15 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2] pcie: starfive: Remove the redundant print of probe success
Date: Mon,  1 Sep 2025 16:24:18 +0800
Message-ID: <20250901082418.60834-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::15) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da9fee8-6c67-45ce-281e-08dde9311400
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: 37toxWdfaa9Q19RyGmsjTBA3zzBQAYXLz7SyqRpI7LgXN9KAlozdYelSI9wWLMr/lgAZ1oq5QMr32yRNOZlCSijaMok9YHvuIDv8naGMNk/oqKoFWhnIh4lfSlWC+JItd22J/8gvcuDCTYzKjYTA75yvdhqSXfOAeI3OZUIkzBDn4ab54OqCRdhh88uUO2ySGhKVFQHLDVAxmDJCqgECT96ySHA+p6rd6LaB2QNZ/XHdUyYGxDWZwcxwwx8CI4CK6hO5h1QTRPVOhMlVeZ6tHeX5UXUVQuE8GhKv+LinFnsXGvGJjK0+sjNIhdJ2GcGLAr9oQPUgHw5z6jeT6k+d64ED3UCwwRX9NrJ5I8PV0IHOeafMBtoJ/FM6KswN2C4DNK5PFUCFdsAPzd03TZBMpZ5DC1NJ10PQKisCwRl44BTLe0IHp/O79LT20avKwcLjEBuqXjcQcAcgjFcVF9sCkwgJE1Q6iCMo8CKQ/NEvWv+9Liqls/UJbcyV7oM+aiue6OkNPfdy9Fhkc5lE9wwjkOmwwlCc3YXt8YPZnmybndHrr3a6BkQO+PoJF1hrIDPGP8byXwhzKsv2rGlRbO5Jk0Pin/8uWMNQ7wBgIl/nW+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xv4zEA00Da1uc13qvI3QV7KmCOGqFuyBfL5WujvboBDGwYHfdQ3vfc9gM/hY?=
 =?us-ascii?Q?UuPped21CbkkNKYWqVEqNwjACs0zTFUdttluY2KJcv8uoy/SBu0KgAjj7ksn?=
 =?us-ascii?Q?8QUb48lnA80PSHlykVkJ37UJnufF8WUxluZIbCHlLkOBlU7pCJAQ9D4d+pLL?=
 =?us-ascii?Q?E8fgpmbwBKQlNHPquxwSVGLitHMkqm+rPdifJceAlPSGct2AJGUGcJ4P+rak?=
 =?us-ascii?Q?esgUwS9lJXyX3RDq3dZedEl6jVig2J21FxMwC9br253GMaqoMnERib5alslH?=
 =?us-ascii?Q?a+9XhkXyJnpwTvpIOc6HQNYOT6OzxfmN8TNRL/dGjrKyR24OvxbMVp3M/x23?=
 =?us-ascii?Q?C67RJDTF0rqhi9p1+W8llMIX0RxVb2jLCRBHGO3CdR36be+PCBQ2idWMtVcj?=
 =?us-ascii?Q?I/2GTQJbucipciZNs8tQNf9J/wxaVl6UcGUudTy2o6hSgW1AIreQiNgp5pID?=
 =?us-ascii?Q?UaI6QBkUAB82wwZM6YZUfVyBjJzrMDGbtur6zzWyD9a32jehhv9xJyOsI3NM?=
 =?us-ascii?Q?nZopdz8yKy2WM7zUvie5P8NrU0PH+9Qv/6sy8i4Dekh5XbTFDxAaspmip1O/?=
 =?us-ascii?Q?m/bu7mAvk1Kjs9Re/PvW+zoVTN/RY6d/uD42kcNh0BuDSzCTIN7VZPfe9Zi6?=
 =?us-ascii?Q?M+gd/lZ5mHZTsxt/KvNjNOwOJSq7jayagBb1+/9MxG9v0rtdW3qVS2ZEicAP?=
 =?us-ascii?Q?HVLNDcNzQLETksOTGwslkrJGqVrDbZKKaiHKhJSfKZqXWQhwAD6kxJMXhQJB?=
 =?us-ascii?Q?F7yKyKGmYB1EG3yi7hEPisIgN6Y5bdKt/pNwB0UIc7nyH6RoPibiHfOLhSOl?=
 =?us-ascii?Q?bLn2G+LczzkVgGpfNZl7dzp3PnK4XyxMBQ6QDL/nqw3G1QKV+7qxzXK4mnwk?=
 =?us-ascii?Q?ubXxYd4n2Pi2Y0Kpr+zpz/SQ6Vnpqp6VHBBNRvtc/rL1GwG/LHYtkP28sKtI?=
 =?us-ascii?Q?ivdnu/lBQhsacFkTpZmEIHztsCUKe7kLQqgJVeHaOOHnsfZq5uuqEbBhG/tZ?=
 =?us-ascii?Q?IRRvhs+nRkE9POZ0t63hXtocQAF0u+8LLe/4vR49L3xSILNuuvYwkoiROv5M?=
 =?us-ascii?Q?SzC6yfhcY5E4cZiWN4sIIm8ZrBLQb8kQULS2CyW13voc5Bw20suR+6oiFv6E?=
 =?us-ascii?Q?LhlGDYBS7o0cqgWRVlgOTcri5lcEGSWY4gM42W4ybvsyUSv8Jsb9R1G2K8Y5?=
 =?us-ascii?Q?ExMbi2FoUh3le2M4ytWY0ImO3vvV1FIP9azDbfuQ9s8WvTQRydkV9Uc6Ze5h?=
 =?us-ascii?Q?i6MXSAGp3yh6cxTJ4YZ8qwTnz8utpV18RoaqLpR3xA3uMOq7hhsW7mAxrYsr?=
 =?us-ascii?Q?pVg18+mMD6dSc56kJiomMOXfrZOuX3qusF6QzTv+/vC0/8HPlfYri/hapiQJ?=
 =?us-ascii?Q?/4vmT4guoshecp9VQ4AWcVGh4sva7yRX2L4zmg3yaitPSonqKQHGNt/VAy0+?=
 =?us-ascii?Q?tBEnRsCWE4uO1StGpNC4t8hz/tB9r6878IY2GSggw8GjMXhLr+APMt77OxCL?=
 =?us-ascii?Q?MN1xCKOe1Ay/krxCxHDXm9C22KpzVN8iiPAoMauyyQNcN3YkwnOc91vH4u7w?=
 =?us-ascii?Q?Ru4AgGUj3RbW7+tE56OSA2xdYwLDQvj3RLoUIDmVrA6ska08GtGbX0m4ciQ1?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da9fee8-6c67-45ce-281e-08dde9311400
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:25:15.6659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykQLdkW/rHozk635SAEyvbmmcy06BKio8QizdXVzcQZwaYzoLL9Ez3Q/rZ6DwT94lQGIQiykdx5fPs8DhXauiPdyp5yzOnggj98LTTJG3ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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

The dev_err() is used incorrectly and we don't need the driver
to state probe success.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pci/pcie_starfive_jh7110.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 51aca7359ff..0908ae16b67 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -292,8 +292,6 @@ static int starfive_pcie_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	dev_err(dev, "Starfive PCIe bus probed.\n");
-
 	return 0;
 }
 

base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0
-- 
2.43.2

