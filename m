Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A80D637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756EA89599;
	Thu, 14 Nov 2024 04:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lKZJ0x4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFF4895A3; Thu, 14 Nov 2024 04:42:55 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C298957F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQHpwHGsmCuZyM8YNWywOlajgQ6ODoojUMu0HCeuklcgjbk1isyEBnkwnpx6K6144GZN+v7dVWP8fh/FIY0uaZzz6S58XoQkdQ7UDqzAfl1x6w4UCvOjjO3WtHg1bm+3UJikoE0LItQ0m/GSjzOIMNm3g5ut4yU938ftDbhaqHITLI98UoCHVwc7sk21GThaLXPxM1RwMJVOzwDLDW6ZfIoed6COb5JIHWbyvyrd290njrp+RRbGeI+5ezfT03vb/os0SDR+Gbf0BgN3PiWT/sMI5wNn50ZYzo6H8YDSmfNJVOvWvuc+NA34mhsFV37IA0lNegExc/K+aHfF//ZXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOAWqpCiNmh8cq+XmT0zH6KnPs0v5MEa39Fh/cAP/yE=;
 b=LigdwLRt8Rg3GCbk4s+9g7037hZYQLgbCJWUzYV4V0/ROxAYjIEKTpRqZACTQZCvlArTlW6b/hF44pDiaoq4XSgtiDa/wjnxztHVMiO8qzIZQ0HAOBcv7/PoiExX++i4oHi25PwPUSV4JJejOVwce0E/1TfUFL4dY3gPARKeaI9VmSKVY8TL0monM6khib6XUjSG4XpUNiCf3WMcmIUvMyAJHroUnGzDl+rQ7sq/GJ/f0ypWygILbgOCrHbz2ospfBNN+GTsEW3x+iBwMy1T4jNE233iRz8Jzd6dfur2A9rPVrnqK8SKLi6aThjVuLd/a2T4lDGMstkaKqEKd+D9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOAWqpCiNmh8cq+XmT0zH6KnPs0v5MEa39Fh/cAP/yE=;
 b=lKZJ0x4BDdBXGZAdPOWvaAIDDJQZ7kk0ULr8cpkd2+uVQA4QfoiHSAKmIHTzMI3dBbcDtLsh5fCYRyBaP+kdET142kHv+bZeRsxPcg34jYr5YMOBz0qnEMvukRmKZw2wyhc7TMH4noTc7KW+DYBUxTOULahovVicwa2TatvRv6Wc0ozolD0/Kkee0wso3CLBycn55+yIAOeNwIwkV66OiVnan+n8p9JG44K6TFNR9Ko8UPax5kYRcElfkgJ1rgSuo/TigdLp6nS0szeJX946wPd/9q+xJS1N8Ln1smAxt1VwO12X0L5Pwt7b0bnTWxZOZNJGXEza299WMlTXqkUdvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8324.eurprd08.prod.outlook.com (2603:10a6:10:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 03:42:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:42:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] net/netcat: add netcat over tcp support for legacy ip stack
Date: Thu, 14 Nov 2024 06:42:42 +0300
Message-ID: <20241114034243.623906-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c2230e-422e-43a3-58b3-08dd045e69b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jPGnkyoGiXxaq4EmjPvUAfupJmg1dAr63PDn0zdA5V1y6R1ei9UDplh/ff4Y?=
 =?us-ascii?Q?+YV1JVyU5IxGO6nxv8MiYXKxyl70d4ndRl77ClaYs0CwLtmWYTaAfiPMKgmz?=
 =?us-ascii?Q?QkOldNbjYhkaWvOLMgUu1fU844iyRPXR1c3nm46JVB58QcjQNuDPZfPLnymI?=
 =?us-ascii?Q?yfoQJ66UsXByBbpGLKhuBPSa1xDxPfnmdflmZTW4v91wanpBpjbm+u1mv6jJ?=
 =?us-ascii?Q?SK4dhde2F49uFOOQ918Owt3vo4jyCamJnVwdl4Y83qNMbOk+MwIIXcE6g/tE?=
 =?us-ascii?Q?iiugGagYawqbt4xZzbI/9f60GV/Vs/Acam/c3sPJYbQos29zUMNWot9Dptz5?=
 =?us-ascii?Q?8574s9txcPIez175pHNBMb51KJreYhutQ17l/V+GEZANQf+nk8KzDEc0YAJt?=
 =?us-ascii?Q?87z8+RXe/+ECIJJc0IZCtyyoDTHTkesuN6G0Zx3egmZMMZUIQc2Tm5zzHlj1?=
 =?us-ascii?Q?1Bb5ckSOugHLeDiFfAaS2a1PWx69Ra6/HBqsQ/iHM/oKAzAcBzlkjnLYG0tO?=
 =?us-ascii?Q?vlhbue9B1EZhnQ1iCQtWQqq/NK4+oALrxBMQjm6RITKch24SUHqcPzc3bDeG?=
 =?us-ascii?Q?2/1zDk6M9DlHZShQhJQ4czrmvAOWc7ofaXhqhLHaSuuHbfJiRCbygQMjzggw?=
 =?us-ascii?Q?+Oq7wXwUNp08ty6mlJFZGpdYWltEbRElEXVdiM/sa/mMNPhtY5urRh5RUhWy?=
 =?us-ascii?Q?qFODNkqbaK6EMHfP6y5wgVSomh3ANF06V9S+Mp8CnO9B3OtnTchbUyyNT2f7?=
 =?us-ascii?Q?F0f1O6gwU9mW0tvO0g2BNI/8jGhJYW+5tA3szUgQqb9pEcjHSuNjxtL9AlV4?=
 =?us-ascii?Q?f0AV0ab3WK6C/ecc/8NKHxoyBVuc3c2r9d7bg80h1j5Qie6qmUQ+winwmmBJ?=
 =?us-ascii?Q?bJeS4molU++Ih49OATU0hNgGy3Q9w8ztCUbSDiMIBNoxWplWGK/Y+RO8VgZ0?=
 =?us-ascii?Q?KWJ+9xhjHmBq+iJtyAAc+LwNN/JY/U+5BbPjyaQqVC5atfzrzYWCSVfCkQVM?=
 =?us-ascii?Q?KekoXDlo2hea9px83EYZ8rYkMGWCUOrur5wrx9d5xdRu/3olmZWac/CxyZTL?=
 =?us-ascii?Q?j64LMvYgdEf4IaObTqEagkzO8NPAEjBm2R+hk9THp8GZoDTmIHUfnFcqPEUE?=
 =?us-ascii?Q?hio25a8m625mOuAD68+nMvIyex19DrUgvslBs6mGHw1aP3vpxHXkabhIOcIJ?=
 =?us-ascii?Q?lqsrXiqdisfWtl8vbkRfsjnOsHYzupHFWZaMTiOifQDsw5PQkT5EE3vl/4NF?=
 =?us-ascii?Q?xBqpVEtxtH+mSS2kTjWJm4zBf+StV2DShmoQfdbT9pLc55Va2RMsSz9nIbWC?=
 =?us-ascii?Q?X01BL3kBhJDMjB64jzhjYW1nhV1+CCqpfU8ESvL8JHF43yHRflU7cbw8A3A8?=
 =?us-ascii?Q?Qs5NU5R+tmIAPNROSz3ojCrzEPOg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOyjgy3LDIWqjXJ39vWeUI+TYv822hdRU4EZFRABnoxnknhHjIFH04zhAa/m?=
 =?us-ascii?Q?k0++ftvkleQrya9mfDpTqqKWYB3C7Or12LbAH9EEh6+Icdg5E4bV+6IdSAtZ?=
 =?us-ascii?Q?aZUEtAjB8zRdQsHI4KqVnW5SAxvZ5+uElK7rDMSIfhvJ5I3T3mNNJNy+hEuR?=
 =?us-ascii?Q?tW9G7/Kb8nUA7HBpNa8GV5hMcy3NFqXlP+2sXGv056GDUClH9gMOV5OYiSvU?=
 =?us-ascii?Q?MJ2ZWlZxxdwwCNAh+y7n5uzbspmSAJK3rP7HzJZC/ZTsR1sADLikeixWEO77?=
 =?us-ascii?Q?BZ2LOUKl/yoGY9YksyFqf/zv4AFAovuSUTtEzOuniwNuki6vyYV7iDGGpBt2?=
 =?us-ascii?Q?vI2owvVLRS4451cxs6mHr4AoJkIM9PTr95Ng0mMrFU8hlgXML9CP4H0aeUKO?=
 =?us-ascii?Q?qdCS2cUA1pDRX/NKPh3N6713+8d3XQdmK/uPfKL5z5tjQDeZpF7PJsoBCnhT?=
 =?us-ascii?Q?9TV61No5N892NBYI3OktilBW8dqUhxI19GZjeISxREDq5nToG7mrhyHsIQ4Z?=
 =?us-ascii?Q?WcPlZQDYaVDn2PmzaliyZugmcQh9aJj7Fk3OYY7Cdb2RVNXIaE3XAmKa0nZf?=
 =?us-ascii?Q?qRUuQBu2Adf1GUkrIQ5Nf41jEcfIbBE1wXR19MK8b9mCaJoXWpbrqObDA68o?=
 =?us-ascii?Q?5o2O0gvHXmt9zJS6FQNLuDszvyGxgq+HcCNz1VGLNrqfDkejLCAtJ3jz6igv?=
 =?us-ascii?Q?bkLZDQ0nD46/PpAyAlvffQuZfVxV6jQt867pZLCnwPTeFU6cR0zxl/tUuBJN?=
 =?us-ascii?Q?rWg44SDybw/futVr+dY5l7zfnS+5DadDRAmdp/kXHUCaPNirGC/z9NBWObH0?=
 =?us-ascii?Q?G/uyBF4GUZzwgGC3PwShTlC3ju3BdmHjg0AIgTQmsSk13bPtmlUyaW6FEcWi?=
 =?us-ascii?Q?X1iWFiYerYahNCER4BJFFWkX55bI43QkV1ZtIWxvUChDJ4TKs0NNHA+zicWa?=
 =?us-ascii?Q?5NIQQqrelbCXrC3HXgfOIMHArcSygJflg8KODxBJw1Lek6gsiqJ7pRv7OCi5?=
 =?us-ascii?Q?d/v93rPCJFMGV3u/3Py5sZOuWMY1r3t+4vZTYhepwXYfrn50W6A4hyq3G/A8?=
 =?us-ascii?Q?Azj8e1HMkVJSiwbgsFI/+baLs7LTfVfyuomXHAp2huKjO4X/nLsC0HxfaLJ9?=
 =?us-ascii?Q?f/dRNCyk3jbrWid51HL4pTnKuPtVAT5UtsD64CpHnn3pYD2nnKCSNn0RlPlb?=
 =?us-ascii?Q?MV20eL+oWTZVWZy7B3Pgcgld6U2xmw8hLhEEX0sctXXMTZecscdYq7FvPN1A?=
 =?us-ascii?Q?QiTxawzLgbzTUrNfMraBawfvSEQtetnjWt7ToY/Cdqkf22oPO+SG379+Hv+r?=
 =?us-ascii?Q?5O2EjZAwG7RkieFS/M4osppAK4LLI+oy3zHqIg05n4DOJNqcB432zsnTlfRz?=
 =?us-ascii?Q?8Xz4sjfV+kLr007bdxWZ1DHuYPC/FK5NWwDOM0xzUAdITGIGrYFpENy3Nx7f?=
 =?us-ascii?Q?MS+DsBbzju6/R+JQFJHjuaCAUVY0h5+ZcM7nv5pQuAktdvkdFwT9GbyyirZ1?=
 =?us-ascii?Q?DQcl23eLn3KWjdbJmKOwcIwEn1R4/56Mr9sHE14cyN1hl+yjYCLqUKtnBtjp?=
 =?us-ascii?Q?V3ORNRjc/Oi7a4mIDmDlHuG7aPb+VhFfX7s5l8mdqI8XlWgT5tspMxpxjtEs?=
 =?us-ascii?Q?MJ5BXa2tE6Q9IgSg75Y5oas=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c2230e-422e-43a3-58b3-08dd045e69b4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:42:50.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc/8mtd6mBWECn7BIUBz/yWNAiOZ7e6X/TAQYOjD/MGSbBhTr1p63f3Gtgo5lyV/zWGMWf239m5ToNv1of6mgmiCZwOtrs2UOwENrG3x2NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8324
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported. It can be treated as
an example of new legacy ip stack.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig          |  10 +++
 cmd/net.c            |  35 ++++++--
 include/net-legacy.h |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 265 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b2d0348fe30..18f8880b5d9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2077,6 +2077,16 @@ config CMD_DNS
 	help
 	  Lookup the IP of a hostname
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using well-known netcat (nc) utility. Unlike classic netcat utility
+	  this command supports TCP-based data transfer only, thus no data
+	  will be lost or reordered. Any netcat implementation should work,
+	  but openbsd one was tested only.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index c90578e1b9f..3dc9918207e 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,29 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
+}
+
+static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
+}
+
+U_BOOT_LONGHELP(netcat,
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]");
+
+U_BOOT_CMD_WITH_SUBCMDS(netcat,
+	"load/store data over plain TCP via netcat utility", netcat_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 3, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 4, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +346,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +378,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +390,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net-legacy.h b/include/net-legacy.h
index d6902508ebd..fdb6d2abb85 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -305,7 +305,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 /* Indicates whether the file name was specified on the command line */
 extern bool	net_boot_file_name_explicit;
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 209377aeb26..4cf13efe17c 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 39bc3ce8903..50e8cfa9ff2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -103,6 +103,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -572,6 +573,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..47dbebe5ae2
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+#define MARKER_STEP		10
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(int packets)
+{
+	for (; marker + MARKER_STEP <= packets; marker += MARKER_STEP) {
+		marks_in_line++;
+		putc('#');
+		if (marks_in_line == HASHES_PER_LINE) {
+			marks_in_line = 0;
+			puts("\n");
+		}
+	}
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS) {
+		net_boot_file_size = 0;
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	} else {
+		env_set_hex("filesize", net_boot_file_size);
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted",
+		       reading ? tcp->rx_packets : tcp->tx_packets);
+	}
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker(tcp->rx_packets);
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker(tcp->tx_packets);
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
+{
+	void *ptr;
+
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if (tcp->rhost.s_addr != server_ip.s_addr ||
+		    tcp->rport != server_port)
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	marker = 0;
+	marks_in_line = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (!strchr(net_boot_file_name, ':')) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (!tcp) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+
+	return netcat_start();
+}
-- 
2.45.2

