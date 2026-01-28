Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B92CD35687
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B138429E;
	Wed, 28 Jan 2026 09:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="s2TCkYas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5972C83B87; Wed, 28 Jan 2026 09:05:33 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E94B84280
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byNA5J9C+P1IjP3qouCI3oJ1nvjYHssS+zW3ew+Pu+4/aL9NFYEr7Ls5QmAenxZW//l3TZ4Cgg7Ak3Qhjw2R6IMp7qCium/loAnuntbR/xiHSrch1w9b3GKCW3CahR6YrzjuC+xTUrwRXUFyCvVoFz0tusDpa3n52SBW+Q7cFEywy4xxnqPObPPXYrKpI+JQ7mbc4yEg/iRI7s7ZVa7bZrcXkVpEtJFiW8ELnFpmSUbJTMTMNPcLB2cg1NZCnXW4FjpHfrp0yIP5gOdHWhKsTUspXD4LavL+77L0gIq42x1oX7wa8oPPDx7tz4QPq68XNkMg8gp/2OosEzranO16RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2dzx/1dvm8+sPnkdSr9YxIewr+2aqAqhCFKoOR+Kqo=;
 b=QrT8zKn4H9DBea61A8UVApncVwwaG+Ds1b27bI/dJcStZHeqgeUHpEMhEb3GhDh0Ie2JKwyuN2fAkC5j9+/dBcoLF2D2g1AtGVx5LArQyK609CW7/ROvJODK7OwmuuyTrPSAjS6iZcHE96Xmp9Vx0UJlQmE3L1uf+YCnQLqONr+3BwphipBKtPz6KvcstVsKzNH1cy2prKqQacwd789m8k9fwN6rUWoFoVv1mnCNkIO2PnqbOlYswlIfxkPk7j9s0cM0TQB0cs/JP41d6Dv9b6CJ62i+COx35tLcTkiHw+FI3sfTtAtC4Lqy9LR+DuyFTiwBqHqvGDIBNDhX5NM40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2dzx/1dvm8+sPnkdSr9YxIewr+2aqAqhCFKoOR+Kqo=;
 b=s2TCkYas2/DwQs5BKrL2IodiwHeiTIZMlE/d5OTelEj0zqJARCA4ChaJ5XikIW/yC0KmHgYGEgicFBUsE49CJIb/6EHz2tWv9+nTCEiC8n0V+cVsIAKZc13no0aomZzWqA3FNTi7rnghH6nt8cUf8caJ+UezH3wYH86q02SAXRciiLHv2E3TnOEQR+8J6fGhoQqQszYR/IuwvPPE83L2jYx0eprrVH7Es8rjc/f64tSemt2TlbXgXvldxxqlKi4dwCMylfkL0u9RC3KaDtymMlwJU2ZLdz8Lqfz8u+FcMuqCrCvRAWtdy8VKB9cNmpwkvCKCYDFyfb09tsOfQCitow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by VI0PR03MB11456.eurprd03.prod.outlook.com (2603:10a6:800:321::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 28 Jan
 2026 08:05:28 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:28 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 3/6] tools: mkeficapsule: Fix dump signature long option
Date: Wed, 28 Jan 2026 09:05:10 +0100
Message-ID: <20260128080515.1275941-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::7) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|VI0PR03MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: d1024b87-a78f-4117-270c-08de5e43ffeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nOboSqiZJO0DMM8Z3c6J7aR4Z6IHSicyO1fUbPcObo4zy7xoP1UvFR7o654Z?=
 =?us-ascii?Q?6ZitNzn+vHb23yw3gwYOJbhUzgWMhZmRjtJb3KoSmCZYgeeJvP1+2NIwxN6Q?=
 =?us-ascii?Q?ZSUE/WEO8ubjuT6l/JB6TkTPQXM02nqhc42mNt08CpgcVKmT0yKf2bkjH+T6?=
 =?us-ascii?Q?XKUcXr/xjXwoUCxiYd3RR24BAPiKryybNc+1041f9RO3uU8nVqTT/qLvvaGb?=
 =?us-ascii?Q?T2eFPABNX7InxAh1V+MAP6VCxk9+S456QPcfkE4nCjZ3e7vILV/S+nCUiy9r?=
 =?us-ascii?Q?2vpEONUgwjNQRlgtu6xDoggE3DnyCSfToeNS2tm9lPGv64VwLfB58WBmH79V?=
 =?us-ascii?Q?LFrvQnIi573sCvbibBhQFforiHM0EscYT3CIOhvAtms7x8p7VSxGUHOcQM0n?=
 =?us-ascii?Q?wDzazkpDK69Hzd3k4mhIhg4sVMjr3zVnpjdkuX8Ooq8yuJ6qFHN9v3BgUTKF?=
 =?us-ascii?Q?wICHSBljaoSJSbm8yHcJvZ75qSKwWxEUFUyqmEPAFZrsB2U7e/G6bH3A4MQG?=
 =?us-ascii?Q?l4vS1tF1v++yGuxb6Bvkv9duASc/uBFpwIuBw5U0koD3ZwzlHTgwCeX6992N?=
 =?us-ascii?Q?UQnUeeAaFAcBKW5wOcXkC5ApBKOntMUbVwBqWAxniU6aHygKvkC5LOLRBFmC?=
 =?us-ascii?Q?wLDr8GFravcE/i8ImVN7QJ1557YeecJ4ZalOmzulUCq6pK3+v6uH7YzuoEb4?=
 =?us-ascii?Q?G7qxisZs+vqqtj1qYABf5+vdbnm3pc6RIDK0m5cujy5GyKR/nENQoYJyn22T?=
 =?us-ascii?Q?ye3s3Ha2Uvu5GWLgls9lCjb0i9utiTf7eG0cCZCMfnbcjbtvC+fY1rZm+9Rn?=
 =?us-ascii?Q?uemGj+5EfXvY9VkH1K6rA0z0Jy3ZaE+lEFmYlJ6vyAEsqAFxzovCCqkzQMlq?=
 =?us-ascii?Q?OA4TbMySLD8axredckxh+1M/C5oIvxyMrrTaExANuwSGwRFMSegABv07E4s1?=
 =?us-ascii?Q?Ubm9VaYbXK2oA43e05I3U2Dywv3ZqEvkN2vdWL2WtvDYphdHchF61Q0fFyQY?=
 =?us-ascii?Q?ojnx/pCQ76/aIuthPXyrTdGQxJzIdqve9UJZjQkXukOBtda1XNKrRQTeKuz+?=
 =?us-ascii?Q?t4iTPgyFophKa9sIAvg/x5p1qEwHR8dVpMqg82Tx2JZXApWUEWpl6IVNqB+n?=
 =?us-ascii?Q?u0W71/v5Qt47NUyv3oD0eCY36lyIAQjklgbWG4TJYy4wX99p1meBcYBKS/qh?=
 =?us-ascii?Q?gt6kScZHSorTdAblJjvicOCryYTxYtno8+dL/NqZhf+KvIm09+TC+QaW8JVd?=
 =?us-ascii?Q?t5efXGaWSD7zJFaCC79A6AXAZYQ0jkBuQql3cdibB21EdeZ5R9NXKM0q+GzV?=
 =?us-ascii?Q?48wBb8qb8/5NePNgmlA4nrCfq24G9W/l1hmyS0Kvk7rjSNAAf4EM74uG5V0a?=
 =?us-ascii?Q?bMSC/rERzsCi565/QWNqTCiKD1nnsCPccxHRqhdwK00OY38iFaHKtYlBctLw?=
 =?us-ascii?Q?dMnnrw8EP1BbD3d0G6ZeESkAvsqi0+vc2xHRXOHoDdiHQalBedGNCU2q2GYp?=
 =?us-ascii?Q?LRhYGtVn/OWfrDJ/DVjRKaErZZjt5u2MyyOn21tg+kUPJE1pUAENTPiYHdEX?=
 =?us-ascii?Q?YzxF4uXX+ok9d/TFAcifTVoaJY48cPm+9Voo+HsMhaVfqgD+/Nm9hFKqYhMY?=
 =?us-ascii?Q?Ovc1NVc4JNHvNumrfMwUoew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXTxELWGywGvw0IwUpS58b/h3XQHHD1DfKoyuvzR6nqGRSBHNpl9BCSLZe77?=
 =?us-ascii?Q?aWS9D8gtTbObHwEQzKgwbGe0xU+ntp8yQUrnkQBilgSSgB9snGZZANgxsJ/X?=
 =?us-ascii?Q?Cqe+F5GAc38RpsRPTqCg5Ul081xXGSBMCiGif1h/PKtviNEFL2G3fz1JCArH?=
 =?us-ascii?Q?MWnHB6VqcI+aLGhfgHpl+c39gKxtCfKdqM9hB7YZG5JDF4gk/b1PyGbkyntn?=
 =?us-ascii?Q?38Uv2J3x3zGxFMMRBOVPZ1ludGzP+n4qS7/x/qZjyz25FDYKZAMIl3tjllV/?=
 =?us-ascii?Q?vKJzHOGUJ+Yr3KVwImd1SDCbmfJdhfrIPnwPUPK8RS3wLLp2xkeJJba3FliY?=
 =?us-ascii?Q?cB5We6VmWWzfEb19+b6kFfPYoWmNd8ligPXtKRrGbCUz/PxtpppoMUbeQuDv?=
 =?us-ascii?Q?jspX2apUliHWvf+VnspLBSujOqIUxYAT8JY50s6l6hgNEGohuMxhkv7xMPtn?=
 =?us-ascii?Q?xDljBBs/FU9xozQi31GiF0Mv6Q63Be+Maf2gvMx06qxjBN+6K/ybxGZOwQVo?=
 =?us-ascii?Q?TZ+XK7Y4NO11a5mapiVuH2/DcpVCrnx9kyzGXavoxUCiee7FVXQQcIbKUkOc?=
 =?us-ascii?Q?PaJFJIFsmzQY8g5fJDMAQa8qq0C7RZ2FLTRBBmGgaOCEf5at1Gai0bXBsnCM?=
 =?us-ascii?Q?83ypvHU42SocJHVIm6an9ziFzmfETQWhPR6+7CTnFB9UkYPHnACcUYNsknQ0?=
 =?us-ascii?Q?DzUSqNwzbE0gXMyUIkvad85DBJRcgDzLt3iNfG+4kWRkt5aXAWCfFMJhLbxX?=
 =?us-ascii?Q?V/nm18P6PTY20aJSetgjEmzYeAKjWXO2gZeKq9TsXyrd6LAdAJxPsakGkM1S?=
 =?us-ascii?Q?U8hxpwwacf7gsu9DvhHpfxISY2YXGacdIXUZq56lHzNo106HE9RR7qmQpwZ6?=
 =?us-ascii?Q?nr/y7FHoVB/gpNgl3hIecqmyiig/kHC0NPeu5ChvI2N6d3RQ117RHcnIkabY?=
 =?us-ascii?Q?iuLIJ0P5kTgDH43UGEXs0dv3xPx/3gpyGREWot96pi0Vf/gaxXDA7q+71dhd?=
 =?us-ascii?Q?e2WldAgUqEbLQpkALtA6M2FnkO72PS3jphzPa01TqLlEMDDWiqbg9lxc9gCk?=
 =?us-ascii?Q?7R2mby00zIhV43dITF2DcOMuPZb4ciobapNgvU2nH8th0Jw8UfIhzWES0o+j?=
 =?us-ascii?Q?kWaqvOVunj/tjNjpv5NFN9avhyGVX8qGuJqv8+QgzmC8NwrB2/AW8L8M9mj9?=
 =?us-ascii?Q?5yjQPoa6SvCia03sfx9ugtrO32NHWSGnmceYEf2t8AZ2hnJroyH7eBsYMmby?=
 =?us-ascii?Q?7UfvgM7LahljiYwDLqXxWB306MyOIN0VFzO69s+WNdDvgZhT9Sx++uMu47tf?=
 =?us-ascii?Q?eor/bCfD+zW2vSqEEglX0DgEKYGOcnc5jH5SsWweRKqo0uKfnicL/CiWeDh7?=
 =?us-ascii?Q?ugbb/jbYpjORAkeCxg0FKN8bULsWV5Ha56P1sF7CFcgZpuuROCAJn+9sL49R?=
 =?us-ascii?Q?Gyhkc93U9AVwM//S1f8RcKpwZSk+0veagMQAVKsbV1q+2w5Ya1UhscNipaAk?=
 =?us-ascii?Q?bN+RaSD4IiT2doeWBq8rYTyoFuwb4OIK78kzOAUB2gYWQfJeJdUNxmWdfUfi?=
 =?us-ascii?Q?/14JQqYnEYfGdN/fYIXl3U2msvTG/HDVwfu0oN6XCzZzGOA7xaIXhPojU5Oo?=
 =?us-ascii?Q?tBRf51ssKU9G4pYeB0yXbsU7bmJsw/sW3hNTOHFp0kVeFEjPO49gdDDNTxrL?=
 =?us-ascii?Q?mlUz3kS8wbyVMmCgVtmiZF9LXZyvxikfRXD2K1LlDaPNNfr4kqkOKp1OoSEQ?=
 =?us-ascii?Q?AZrCmESihA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1024b87-a78f-4117-270c-08de5e43ffeb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:28.3466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+odARXUwgfLoajzEeOfmz3GqNS1uxglCbIDTjKS3fvDIdYOb9g9Tdkx3wLuvh2lYJjCBctkgH0dvIKTTxmqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11456
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

Only short option has been present. Also rename dump_sig
to dump-sig to match with other parameter names.

Fixes: 16abff246b40 ("tools: mkeficapsule: add firmware image signing")

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 doc/mkeficapsule.1                 | 4 ++--
 tools/binman/btool/mkeficapsule.py | 2 +-
 tools/mkeficapsule.c               | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index a726149ba2ce..d6653ec42472 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -121,8 +121,8 @@ Specify a monotonic count which is set to be monotonically incremented
 at every firmware update.
 
 .TP
-.B "-d\fR,\fB --dump_sig"
-Dump signature data into *.p7 file
+.B "-d\fR,\fB --dump-sig"
+Dump signature data into <capsule-file-name>.p7 file
 
 .SH "GUIDGEN OPTIONS"
 
diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index f7e5a8868495..f2ac654db81e 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -16,7 +16,7 @@ Options:
 	-p, --private-key <privkey file>  private key file
 	-c, --certificate <cert file>     signer's certificate file
 	-m, --monotonic-count <count>     monotonic count
-	-d, --dump_sig              dump signature (*.p7)
+	-d, --dump-sig              dump signature to <output file>.p7
 	-A, --fw-accept  firmware accept capsule, requires GUID, no image blob
 	-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob
 	-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index a61557b73bef..e9b9ffe9b774 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -56,6 +56,7 @@ static struct option options[] = {
 	{"fw-revert", no_argument, NULL, 'R'},
 	{"capoemflag", required_argument, NULL, 'o'},
 	{"dump-capsule", no_argument, NULL, 'D'},
+	{"dump-sig", no_argument, NULL, 'd'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -83,7 +84,7 @@ static void print_usage_mkeficapsule(void)
 		"\t-p, --private-key <privkey file>  private key file\n"
 		"\t-c, --certificate <cert file>     signer's certificate file\n"
 		"\t-m, --monotonic-count <count>     monotonic count\n"
-		"\t-d, --dump_sig              dump signature (*.p7)\n"
+		"\t-d, --dump-sig              dump signature to <output file>.p7\n"
 		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
-- 
2.47.3

