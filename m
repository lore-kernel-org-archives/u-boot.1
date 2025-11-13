Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD0CCFA18
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 04:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62A883C62;
	Thu, 13 Nov 2025 05:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LNmDfuKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389A8838A0; Thu, 13 Nov 2025 04:04:50 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082BF835B3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 04:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhm8nRH9tOJw82j96bhitgy7jqctjY8fKYilbKoAWujsd8ByMqglBf8ir7/zq8jhLfE7HtKFAR4qYN+SHliw7ZxFYgXzMHLGsw9izoSs3jt92LW5cS6eSTZatsztJg3TorhAP+Xc33jeyew0j2kKJszB+UYICGCfbwN3rR44shS2VEvZCRcDFfM9kfmr5HxkE8zhS8pS//C3Ht8E7SjsxA+Q5Bjsj+OpRFSfR4te0KEVNTBwNx1IrCsrXI5h3EIFkvSYkRrP43tQ3tiv68yBojUg9w0gv4DbgYljxiB2g6v0cVA7o1v9qX5/rVrwBTRspiWfvPSGf5TTFX9FPPRwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf76K1mSj9K3KSIngif/OYqBNNTVgWCFONuCdz9P0hg=;
 b=qlcQzm88kV6GeEu7G9J4dhlGei2bii02ylVsGUtnsyYG7PoqRG6bDOGSeB1izXtJASfuN7DaeSEZjPELs0h+bTiLGjrGpD4BF3DuSNpGM/G03Nvyja6WKJBqAfGYeTcoaflfObn9dtgRYeJp3fKBLKr/43k0gpLWg4hKGpKlEQ+XEQXjq+lVtaMT3wEvE65UtSqARZXDhhVZ8gGD0ht28mKhWRuGiiYx7YBYZ/LJgJ3gSPSsnd8QSp12Au8fMH4aN3dy+3nPQC5mC1C/TsVk7u1udHnRL1040FP888Y4L9dxzUnO203AbfHBcmu42U7JHxQaoIF3Xf7q9ijAJ6N2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf76K1mSj9K3KSIngif/OYqBNNTVgWCFONuCdz9P0hg=;
 b=LNmDfuKcayoI0Ie0xw7jupZBTQi3ws+aRQcTKeGERJQHiuPBZGuDyF+KJipzEsFNTPaR8C9sFUCFxU5xG8egbgpgMLTvffyPnmxl/TpU8ZtFyWWRLOKeigaFT6j4Z1EH7yJ7vRaDxc391Ybn69HpijMeVfOjfjZ0XEx7zkn/OSon2EvQBuuNf+4f2zzoPC1sxEuruwCsYdLD66ZsuUux2V9j8+dy2x5Ghh358xWjiRxQtj5HD10If5rTBAW7o/bXQLNAH7BS7xNwnNO4IXaCSjrPHkvVIj/B1LlQd+ztLxog80Mi/4Y7eK1a8kVMYV1Vf2mHNS8X0QWeIp9UsMaXCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV4PR03MB8331.namprd03.prod.outlook.com (2603:10b6:408:2db::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 03:04:45 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 03:04:45 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] driver: nand: skip BBT scan during SPL to reduce size and
 complexity
Date: Thu, 13 Nov 2025 11:03:57 +0800
Message-ID: <20251113030357.15397-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV4PR03MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3ac794-6d5b-4137-c835-08de226165b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7etFMKw5tHicaF8RFqtzbw9WBQIpVqVg3r6n9IpTtRdwO7pIbic1F75loJZ4?=
 =?us-ascii?Q?jaFsW+H5lpcJcwKD+HHhdV+AQvP/BLQHOSKzsSTbevzOxTVuqQZffwNmypMR?=
 =?us-ascii?Q?nVjUR4quYLsCORPjHwVG0JW6jWyIFfUlf0/vsgW2Qgy0tO8JbbBdv96nhA/D?=
 =?us-ascii?Q?ZBDHTNglBTHvJOgoaVwlQS7fyBuiP4Es4Vab8kqyMfONVQc7mA97sWgcDGN7?=
 =?us-ascii?Q?rZOtHOVUxMPB6JHDwmiv0+9rIWip1/idE0ixuRXu0lx5TFlX/ql5MiWm3wMK?=
 =?us-ascii?Q?MpsVogFRocDtvFQBvqxnEjar6OZHsZK1qvZAczUJp4f4VEZvnuZr4nR+Xat2?=
 =?us-ascii?Q?uQcl40BD6lUKTDwM4EsZy6dpPRciZZGMC/woKSW6s6xyxc8iNc8ql4OKk8xp?=
 =?us-ascii?Q?frwah1IWz5I78pbNUNJn4Q7o6u6KtQ95cULbQDcpM7gy5IWAXTx42C8TjJ6u?=
 =?us-ascii?Q?EQtV/u7kHjWw3cYzEwxkcXMs+yLg5B3LY8KVgnRqCTQ2M7sSN1tGJtNUhO61?=
 =?us-ascii?Q?JrfIUNsedSppEqkhpJzc95/EQV8LcKjzMA89jrFJqvryrwLcXppZBecIjU2e?=
 =?us-ascii?Q?2fpOqJeRzms9StA0N2ezgR9Lvh/FTi9otVfCdSZ3AbgdvOfK+JITbbPzaIEV?=
 =?us-ascii?Q?jWOVcGL+UFHrQ6iH1lgGb6mnUF/1SseW7dvZG5/j9siw1mpSN6lhr8HIqo7w?=
 =?us-ascii?Q?YekExWMMhP+jfvnyG/0QJ5gg/+JAPXeAx+pq++VM0eedxEBdax7A2cAub77k?=
 =?us-ascii?Q?cqUl7AGV0+OIoCXWnBhV6bwQOnM1RdK5kNEo/a1bszJVnPjbq3z/hO4/HW3T?=
 =?us-ascii?Q?TAaoc1+LVjl/BOepMLtlf9yo+/FH+da/A/kCD5vyaMxP2Kn5QCPUqKNawalP?=
 =?us-ascii?Q?7V4sQv/a9ahJsGudaKzlm8vSKZb7aqn64iWgd30PrMnQDKWx9yRVfIotzKSP?=
 =?us-ascii?Q?mhBY8XpkxPM2M4DahtPSK1D1GUUoTswTZDOEcqaKHYdtr4pIdfkhmZR6X/SX?=
 =?us-ascii?Q?t9TSONjVG9a37eTvoQ9lqr61MRALW50tCKeBwcB5x9ehCH90VS7DzJE9Iefk?=
 =?us-ascii?Q?9FYUuQb4xY7JIDdIDfVgnKeOIzSril123PwX4EaOWW0OiNFMAol/WjcLGlE1?=
 =?us-ascii?Q?xBcZTvLCkKyKLdWRcgNnccV36wY4bxTkf8eaIQsKhNta3zDQMG85TUvGL05W?=
 =?us-ascii?Q?o1EbnTEGlxuvBLz28VvnEgfFMk7sDWoD1suLDvedwyBSEIr1pHHvdUnUQySh?=
 =?us-ascii?Q?AKvc/Xc1eHK473JGX5Zoy6CZLmNztWXqUomYGCo1HbI32LtKsPdEfdrHighC?=
 =?us-ascii?Q?FAmQTJ2vZmM/L79POFK5MF0XBBSKiPq1fSVXbeOFSJWGcV7eYhUf3+AnlKup?=
 =?us-ascii?Q?/I20KgEwkrl+tnnwJXhAdDPUsJEILVKugNxgQQ/SX7iQ94GubETJ23wfJ+ts?=
 =?us-ascii?Q?84dr+upOz3pAGv/zb/fli6Wp6Yt9gYZl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SEiBT3vY3bEKqa6+7SkqZPWWnAUUJqaZJ3dI8dk1qxTEqOWUqmZkXJC71wy?=
 =?us-ascii?Q?MdbahnknBWfM9vhLcwhtfgcQ8DZcknytjM4t5fmFkRvsfR1fzduJymjVJ72F?=
 =?us-ascii?Q?GQgLyb+s/KwE3TDn530UWljT4+r9Z42OE07zXQZUrO1qRlXSRCD9HR3KNu65?=
 =?us-ascii?Q?IcutOK0ienXXmM2gBc2VCBNvdkmjpJJ7rOIyl+kEN1Dmp1iW1MxpKVFSn16D?=
 =?us-ascii?Q?qrWqwhU0jwCeQLGopf7Kru34AW9G8MI+AQ+WW9cv3mvZsdy5PdbBUPlIm5qY?=
 =?us-ascii?Q?QZFkKf4xki84RkegmGTGAYI48etSwkCwsZXtgcYLATJ6b/tPGCtPfYe2oj6S?=
 =?us-ascii?Q?7+tzdTqbbYwqF1ESHKnXhh31KUKFH+Ia2102FN4iFmj0lg+ZU6KRbNXAmLqq?=
 =?us-ascii?Q?VIUth/8cBcZfvONBDIH2K862csQ3OivQ5IOpH2cwYRoYNrpz1pdrdmYxgE+7?=
 =?us-ascii?Q?pSG6xl7Y89g+T48Hbo7OJ0DJa63u+Kr2qdfigIcq4oMKmFIMDeBAM92q6pcF?=
 =?us-ascii?Q?JDORAglQ+2ma8M4oFseLJNZcsmyKdgOIfd0U+USfn3wezJ9ijUcibPSOf0j3?=
 =?us-ascii?Q?OFcKAUR1nkPAinxs6Fh/5Km+bx9axIhyYnI2lfjvReiuzMdi4sWPsBspEPJc?=
 =?us-ascii?Q?1seRASnZjpmjLLQ1J4UpgxVKlDmJQBS/mZpdENy66JKb6cIpm3jMGjrFv45L?=
 =?us-ascii?Q?NH7EA4XxeYEDBkOHvZHp+la8Z1GN5XAzX4ZHDOFElJh2fEajfdz8FBy+z9K6?=
 =?us-ascii?Q?VS7ZRg1B92iCSLHOKeIRKG3UwyaYgbpUtSfnG23KRIiMr7i6uyG39LbpGa+B?=
 =?us-ascii?Q?SCtFuO9zJ5m9srXe7HjH1Vo7j3vf1POkVOlZF8bltlFUk8+Sw8u+i2MuePpw?=
 =?us-ascii?Q?UXA66DRtRrpsU8ibU8GuqBoBFgCf+yqc1TpFfNwVB9dKO0qm7ssccggHiJFf?=
 =?us-ascii?Q?n1GHCAfuKiFq03FiHRQ5a20q1FQ+OdC8d/ld8jSYomAj77aG0dXVCOwfp579?=
 =?us-ascii?Q?e6aWraBGYmFfqRWlpFzOH2wvAHYvTyozMBxWkQAAKa39isVMWnLOlytnNZfN?=
 =?us-ascii?Q?OBhMHViyk7OCb6NDwf9EbKOrYzAbyMA9lBEsl+iXAUcBvITKKngUBz83DMIx?=
 =?us-ascii?Q?UX5dOry2Ocf5OK9Sm+9+ipIgCZrnWynv/jKFD/lv0JvaeSCzDBaGzjVBvVrv?=
 =?us-ascii?Q?4Rym8St5OkVw41rkmgfXJCQ0Z9ghGJgvjszQMqOj+lkYr3PH0Kf2LWPwCdc/?=
 =?us-ascii?Q?x/K7KJAKGMuBj6H2mewrdAyCK1RimRuLOt5Fkl9A1tJrADmx8wPUm8+nfIy4?=
 =?us-ascii?Q?2lMLQDiQBeWJ1cJ7VoOQrROXfYraq/WkyQ1qUoev0CJ1r47AFRzuTJBXKW+X?=
 =?us-ascii?Q?EKZ6DCsUDhYxKuvJsSEabjv9ttq287/Lz1qo0knd0o3AAveqtC1RHXtTluhC?=
 =?us-ascii?Q?SOxACS5/ioaHqgS7SQW40KS3dZnn9nK6wcOSMWllu2gezIr+0a5OhJz11uoz?=
 =?us-ascii?Q?LVQvFK2ij7rymI2GuaW/jbkn17gLyxAWzITp3naQOh3uyhQiQPt3HC6+s4XA?=
 =?us-ascii?Q?ctay8OMAks2mXH38JomQQdm30TurxprFFyPGwOtXWvLuGjtKSHOa1qUz6nzD?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3ac794-6d5b-4137-c835-08de226165b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 03:04:45.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YBvgK9eu0s7Sz0Dp5pdwxeu2SrL9fpXcbz3MpJHzTLQnYxrrmqv3PFSi/T8Qkr7qk6I0KaIbSmSCnTLTNKtaSjCX0UWVFazoA4MEWauaIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8331
X-Mailman-Approved-At: Thu, 13 Nov 2025 05:53:04 +0100
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

Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`
to prevent running `chip->scan_bbt()` in SPL builds.

The SPL only requires basic NAND read functionality to load the next
stage and does not need full BBT management. Running the BBT scan in
SPL unnecessarily increases code size, memory usage, and boot time.

This change ensures the BBT is scanned only in U-Boot proper, where the
full NAND subsystem and dynamic memory are available.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/nand_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 48e3685d995..4dc2a19b8f6 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -532,7 +532,9 @@ static int nand_block_checkbad(struct mtd_info *mtd, loff_t ofs, int allowbbt)
 	if (!(chip->options & NAND_SKIP_BBTSCAN) &&
 	    !(chip->options & NAND_BBT_SCANNED)) {
 		chip->options |= NAND_BBT_SCANNED;
+#ifndef CONFIG_XPL_BUILD
 		chip->scan_bbt(mtd);
+#endif
 	}
 
 	if (!chip->bbt)
-- 
2.43.7

