Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD6F5545D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1F683D8A;
	Wed, 25 Feb 2026 06:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ttC/GPgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923B783DCB; Wed, 25 Feb 2026 05:33:03 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB91183C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 05:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDA3mXXIdsPZPPlXo1ryQ276ZeKisB1OI0Ya8Iqma/Fw/uYvwDgw7L8Fr50/xXEh8j/9EvmYV703M3AjPy2wRNjTifbFejPjHnRaO3H9e3QQ/XigZUFIDaTSaKp1wOTTeZSypyBGCoqmnV7HHZAy/EDcAH5XxPfS/vpoO2FHFU2CQSH9tuxAG0rnZ0mw1QDpJ1BLwMJfNFrXOmThuxCWLImViTPDVGv7aiaiQKRXef2tv0DtxQlv9iak1xY7i3KVKhWXDpd3fvSa+fBy8OgT8LO149Jwnhew5Cfsjz9cIEr3StY9wXO7LFSbzAc7iakuu5Ov1bIbdmUwTARX7XpCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oePZj0UdbRYKte2dL6aqqUuZV53H8jVRF/mXpL96Ds=;
 b=TnU4O+Mg5XIpTzBRZuHhzDiQ21aEm4CrwRU/pEGzKoDoFbZgOwgEaeI5SJ//vZ8Az4x0G6Dhnh3JCfdpSQMVSuCw5nrZnznLRetSiYon2C8x4EX+XOMG4zKYWKtKidnHpPMCPzvbDySA9jCa/6TPL7wj2GleLHz4jz4JnTgCmTh6qSXYFHRXiPsO8E+DNcQaQ7R97jP+J+mraFaF4EZnhVcnuLnj/gfOFBSbL6VMpdxHhnex+4A/DWBj6mc6obirBQ/Ch/lsWasG7t4c3lIb1MbVQ7fEjsLHDMe5OoTFk1h3v6Sko4R+oupwvLbkR3H1Ybut70Z2/NKQ9BIe99CiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oePZj0UdbRYKte2dL6aqqUuZV53H8jVRF/mXpL96Ds=;
 b=ttC/GPgcmrhAtcumxOG4TVjqaB4LHvonM8EDaE1UE6JbYhgYYYVhZG6gwnwriYKRezOzq3Le0MqW9UBH2RGSTCkV9wK239MBHqufX6oauqJoI8W5D2kbgdqpo54nEdcL/vBx0OncQ5mRWK9PehWuTKJv321WnOHg0D4v0sUEV2GZUc2l8+rS9wH0XEgfUoM6WSGnvMxwZLaU+vjS1olpEdUjET7UhP8EgjI5pAGMjRZZWUi0Ot4HM7ry+SGci8cLYezTpmoH6NXdTPC14JzhPRhtvvxOvBqomOQ8Xten5GgtXAlwpohpfzbImz0pUr8A5Sd0vE7WSBBOBbaxDqMtig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA3PR03MB7188.namprd03.prod.outlook.com (2603:10b6:806:2f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 25 Feb
 2026 04:32:56 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 04:32:56 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arch: arm: mach-socfpga: Change U-Boot mailbox client ID
Date: Wed, 25 Feb 2026 12:32:09 +0800
Message-ID: <20260225043209.7512-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA3PR03MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a42e2d2-312d-43ca-218a-08de7426f248
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLrPOrWJOLVvCAyreNQg7axHmipJbJPxctOsFLCdIn96WpbKBJkD3AzBi/7R?=
 =?us-ascii?Q?w96g7maUgtkLFwuzeVGxfZb/dBZsKGPRihLAXL5MWiAimfREO2u/ycbVl8O7?=
 =?us-ascii?Q?EWvcz5wy2UfTpCQWqPVz9k8sDkyqlmQTX+8Cqz2ZDgDPsVqrchn9klbmLJ4d?=
 =?us-ascii?Q?az6hFDqhykH98suB09j7dPk/y0mKPcTVFBBzCh7VCFmtsnKP1C58bslCT2ks?=
 =?us-ascii?Q?lhmafIoZEBS42nSjKcRGjXWzsRITZCf0StWF2vRo9w7FtyB/tH+9yeFHcJdD?=
 =?us-ascii?Q?zUKnEMQPbVIVmYv/6us9kWKqq0rvKeE1XxzUfUspjNeFrgzIu4xk3E0K3vby?=
 =?us-ascii?Q?Ie24vUhYkx3SrITI2FkOtZTkmbf8BXcZmtyFaxX/foXI7fKdkyLkJuQizlsV?=
 =?us-ascii?Q?DupwBT5SAx3oktEqYvJa4p3tqywEaS8E9oXNELYpDcB/7oVM/7ZRJZTFKEp2?=
 =?us-ascii?Q?M28ljbEI+IBqU+naUaMTKH9cwY/LTAIM1jt3hmDCy+6OYXH0fHIlMBBcR5qt?=
 =?us-ascii?Q?ugvP9NkkmI30B2FSMRINBgaNJZVkVOPP6vBT9stvZP9XKGyOIFF1NsQG1yc/?=
 =?us-ascii?Q?di6ozEZjTbR2FIs8WaPjzBuYbwjgni7f2C85bQBe/Z72c27NLYi5eCkomxMK?=
 =?us-ascii?Q?QHNEt1SCI3kIPoB+cU1RWrw9bBmbfLhg1M4GrsZGihSoA3dIBMf/LCcayGEj?=
 =?us-ascii?Q?tf3ORoak5Ex6ZXQtwRXTw7jhwrqIOnNb72plm1RNmp81SaZY1/WotsF3SX+8?=
 =?us-ascii?Q?+8nk3HQmx57DFBEBarHuP6Z/YjBprU3YFlD2VxU5h8V9OYqXXSGXYCwfGUYq?=
 =?us-ascii?Q?rMffNRvHXoo/J7teHk5QqCJRnKSrFX+UH1w/ry7FH5mYup6rwj1KNkJRAhUk?=
 =?us-ascii?Q?64R2p/Iurn6CnsMh20O0rurxtwa/ehnNhyv/HFEo+ncnKnJD1YoDzfp0qNNt?=
 =?us-ascii?Q?RPSQ0bBPPDHO8Lf+BCWogmVc+DTk94R9t5qwxW13+algrr9WzWybsUfZit99?=
 =?us-ascii?Q?jXVWW8xRTm498Wy5Ys8OZQ6GEZDxU8Dmzho8kxF935Stav8VbCJZ5S9P8HEP?=
 =?us-ascii?Q?wUXJlH4kCeLzuOFOQwSoAIn08x0qusirbLismjNbSSFaAh8ngCAQbJsuA4PL?=
 =?us-ascii?Q?3CAdkpv56VEx0Q1Hmbc9nDNhxj5Sl4bygMaxEe7VRWp2oc4jYJnlEdJwB1L+?=
 =?us-ascii?Q?q83lwtQ2p0pIUVi7uS3CU6Rrvx4uD5ooA9ODNSba1ht0KIwDvkog06NBJTG7?=
 =?us-ascii?Q?Ls8FsPoopalC+hbgmp3+8uIglFL0aXDCKRBulTrAkJh0MAfqY+P6iIvwTJa8?=
 =?us-ascii?Q?b8f6CAlcDHso9vQx6CEDYGfh3qVQS2240NSE+wte9TKlVgppHyEM1YMvk8gP?=
 =?us-ascii?Q?awVeepUugu4lH6EAlKwx3Li4MClMIMk2FDliI/c/8/zAjrIGZ1QFtQu41twS?=
 =?us-ascii?Q?Qy5qX5rZ0rG8Sb6N8b6OW8jEF8lVYEwUkbEvkMI2cd4yQJ6LsRiTdZNgJ38S?=
 =?us-ascii?Q?VaSqj5Raq2A/jncFk+5+cq3PvJn0abA3HoV1biYBGVmSxcJe9ctZq848x+ah?=
 =?us-ascii?Q?Yyz6hZDnBJ1qdUVt6Fo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9nxfvMEqCI8gbJaRAHF1p0QigB19ua4ODGY2QVUXqtWrePkIFP5pKwepSZD?=
 =?us-ascii?Q?xn5xwN1iEUJWMHdtXnBv2Rk8aGpx2qYHsBl1LgyyIsCKod+BSq6fiBY1AYkb?=
 =?us-ascii?Q?0GuwJOyVcukZDf6aiKto8QjwN6A9PEr9xi0sif2hxphyTfrtg+t/CMQHoSLe?=
 =?us-ascii?Q?jjddomxHYchApNc68XlS9XMI4Umyhz0cSqtLWfmtmQWD1hnyiPZRj9K38XPO?=
 =?us-ascii?Q?FqUklpqcGv/N9ikmtb/CDnRK/38ZYzGKxax9zRpk+OkTwZwR9eVblBpUFHDT?=
 =?us-ascii?Q?x8WgBVjjRD5YzQAUb/1u685LA+crPYI/zHB3FXy/Bv3pZELt0igyOToFygZe?=
 =?us-ascii?Q?fkucv5/uWTC6MKPfvyBpIa9FoDhIf5+Anppz8dGnlv2mJUlS5x0Os12hEBaN?=
 =?us-ascii?Q?kOYnkT8ydev66OMm/5Wip4kTPAN825278Lj+NUOj0vpoItKcQ+eQUSkcXNGr?=
 =?us-ascii?Q?RwiiqT0zg237YlCxYvSZHih84F08JkZ6j/u/cE6qzVxFcSPVn1QJzdGF6A+E?=
 =?us-ascii?Q?qkatAjwKT01lU0u4xHbrUe9Wu+AZUIg2W2FW61nfU0wHJu4gTQgKqEouumo0?=
 =?us-ascii?Q?NuxWXten0IkJW209ErJYchLofQwHGwq8oFDSP0+YUl52w6EBHjn/+p5dvbV2?=
 =?us-ascii?Q?BwwPlyTNqayHp4PDMlQtT907vbMEmf8I12/uiZ/MyfGxp4dbQn2+P1eVAseJ?=
 =?us-ascii?Q?AxmaJD4v++b58swf4Mm3ZVSmn6ZzCWsDgBV7frze0rbI2J+/O+eGicakLdrC?=
 =?us-ascii?Q?b8BZy6F0SBtrTB/YN30oILX9OnTPKEy6t3yG1PSm75g2Hvq6HStvQW0/TGoC?=
 =?us-ascii?Q?izfatyVMu93SXpTHCeMR4Rg/6iv03qUfUSt5ZluscQMq5Ad1Js4Q82mR+fk3?=
 =?us-ascii?Q?YWJjY+QtfJs3rGVvnwTO9GQlxVeo868sK9Na1C+YMz/Ary7Ki0nxsmQkvr+Y?=
 =?us-ascii?Q?PZ0Lg/FqLrItmB5iKfZdcSeZ2UA5lu0EDE1rQKazjm+0EO/cmd+Oclkt7NIV?=
 =?us-ascii?Q?UILRhSeJGT1hAuMRy+SmR7pykHhYeRr3/77JG9BLs7u1QcdPPOk8TNIZdVvm?=
 =?us-ascii?Q?m9RY9SASP7jAAQsuxtc6VrtbJoQ7a3MJbn0tbJaI8oneTWcLj+hHz/vvg0tg?=
 =?us-ascii?Q?SHj/p/SP9L8SwlhrBNGntMpM0P9HTC1e4KcIBn9j2Gh8MbDsO52OPVU8F09d?=
 =?us-ascii?Q?nR5hB4Xn+9oFJlYMMazIqG0toMk3HGjV+8jyVIZ6DzFAxTpSTr5OR0sZlzkF?=
 =?us-ascii?Q?UocY+7xEn86Spcg9xY9nsUPsWMZ2Wq/4W79One0pT1AilNOOv2P/xjPbSe/V?=
 =?us-ascii?Q?k2w3b6XG20ERLubt2iUzuUbrxIpe6R8vOkJVFfXSnBxnysh4ZjNyPRDsC6+D?=
 =?us-ascii?Q?eFoSz9msPf7wA0yqNS5HGrN64Iy8gvI2FnSqDGSjxVe7+eioigVsSo6CHY1r?=
 =?us-ascii?Q?++5kPndlturjbi/ohyDzUfPQZrimzSJZl+feQ793EiochRCvqmsfIW1pRBYJ?=
 =?us-ascii?Q?9AUGrlpU/k8drmARUTr1TJvXweS+N+ogc16IpXU/vjhZiN5X1WGQtuFm1Zpm?=
 =?us-ascii?Q?k1JoasO1xgvTbSsvjDUAtUxnRBULlcIbZmef5XKx29YymfjsuPi4QRtjg7eO?=
 =?us-ascii?Q?olm0eG8S4LaMD7mb909SA/etjFQkAkfSjn6M63KfXKdUFK1L5vNA1WNrZ/zc?=
 =?us-ascii?Q?+NYXesiUEJQZJD9P4q5Bcegj9GA2ViG9VM0AEsBKlTpy9mxMH8cG3h4U69RE?=
 =?us-ascii?Q?xU0FJXttYghEgQclK6pMuDUw/5TzMQw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a42e2d2-312d-43ca-218a-08de7426f248
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 04:32:56.0652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwBlDuUB7X+33SsQ0s+Z1VQpQEsZhw7jV6wJz70JWfeg8IhliH7/ME2/EJUlBii1VjbVv9wzNQOehnjop8/s/enCQRJY004O1aVVK1aXUeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7188
X-Mailman-Approved-At: Wed, 25 Feb 2026 06:24:43 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Changed MBOX_CLIENT_ID_UBOOT to be the same with ATF's mailbox
client ID so that SDM can treat them as same client for related
request. Otherwise, under some specific cases, like QSPI_OPEN in
SPL stage used different client ID with ATF's client ID for QSPI
exclusive access, then following QSPI access like QSPI_CLOSE via
SMC call to ATF will fail.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/include/mach/mailbox_s10.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index 1a461de4819..0025ea2dbab 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -10,7 +10,7 @@
 /* user define Uboot ID */
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
-#define MBOX_CLIENT_ID_UBOOT	0xB
+#define MBOX_CLIENT_ID_UBOOT	0x1
 #define MBOX_ID_UBOOT		0x1
 
 #define MBOX_CMD_DIRECT	0
-- 
2.43.7

