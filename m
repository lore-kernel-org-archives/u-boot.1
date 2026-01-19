Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66C7C98315
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256A88307F;
	Mon, 19 Jan 2026 01:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fm+Vyy73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF838397A; Mon, 19 Jan 2026 01:36:27 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC408004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxlQSjGGz6wdmd6ZRrcz9wSlnx7vqrzittjbr9PDvF5g57roeKd6mIeZrQeKogz40aT0drA/KfGeWN9ZnWeD7uhQyS+VC3DfWtTQEmyVR0mky4EAM5Fk3fdOlOPcq0Rv6KS2wLPHLY8EI8MI4HP7EnO//Mds4juFROkBxNQFbCsXD2JiLQuvNmMUwpEPxuC0HLW2JatQKtGBOkOHTuayGuvMbgfRRdvnxeWxn+jQi7IiDbMVlSpOf1+Y53vIxPsbYKs5G740cuTD5ty2MDMdgcAawIRjXBhvAxNFRwM5b0VBThU+dFBv5aGemY8yaadqqttDNlXgUaila/5/9iYaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZlNgKm0TzruCsy2y51N52hmKdYpPmu1CvO3sSHrMe0=;
 b=dwKS/6WMg3NX05CNs/3t15RonbGRAVVbGG45wfudZKtqraQEtNss6T0JUbqttskEKbDhg+2tpEx9SqC0igNfs/YMA68m48WSC8jAmuC93E6BcZSvi00BhLyfdB6HzP5O90G/D4HRmesiGTrwIpVlV+2e8S6FgH3yobGVm1G29Hu9bzUkd+p4lZTm2E8PdEql0HJG8bw6S/gpeioSy2JwHaXXJ/GhSHqAKKbc77HEOpEzyLlHORCl60dJ/s3GfI5ZrLLVYTmdj7TfGC3+lHSVcxlTG70Mv++GEI7IPd9cfEqWpq166cc5VDs44EHVZWeNPYQ+a9B6c5mmn3dSqYoBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZlNgKm0TzruCsy2y51N52hmKdYpPmu1CvO3sSHrMe0=;
 b=fm+Vyy733+PJvxgRKAg0sAc1t4vXKkt6VbFG2K2LcgJL5K1NmiS+k/OkImTOC3BNAjA40TE/xmyVTg9Ab19Oiclm9PUVVVgcj5JQC8OWpCfPpvCKCmd11MnL+Ef4K1BOHsSBRmfvT1/sGM8eWKHqDJIp6ls02D0oXG+TObdKCY/ZsEios2rB6eIDQSFutm1NmPQ3H80vgeCH+t/qD3hFPAmGxXFfNZtMznxZKd1AdMlF8dFYh67wMYlbOnfEpt26+o+FR/xXeChqgFZw/LvztU2JCcoV7ySJb7F7Mh4L/7yK3Sinbpl2T4dM6cWF25N4wYD92MKmI5Z+08ayeLUGxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GVXPR08MB10761.eurprd08.prod.outlook.com (2603:10a6:150:151::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 00:36:19 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 00:36:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/3] disk: part: fix partition search boundaries
Date: Mon, 19 Jan 2026 03:36:04 +0300
Message-ID: <20260119003606.748561-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GVXPR08MB10761:EE_
X-MS-Office365-Filtering-Correlation-Id: 00addae7-d5c2-43ac-5e93-08de56f2c370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nG5B4WUPKXLjzJvOixgYHulNy4/nhErDFMcGWY4lj8Ya09bCOdwCSwA0I4iZ?=
 =?us-ascii?Q?OmhYM0d/EoxZIUlG1GBa4NrwlnqjOhlAa6M2xCZfyPBP9zaSsD0iqm8QcR35?=
 =?us-ascii?Q?uFiEoeD6C55fgUqa9oCQiy7ZoqV2AJQ2qjo0qu+h+CqF8hMNYsC8i7M7OaXU?=
 =?us-ascii?Q?BcPDBaqPew3s/fBFRRBunfb8bbxpZQhZ7DmVJvM3631IVqrJfWg/5rKfh3Xh?=
 =?us-ascii?Q?1xj3xEQdC7DGgXa46XzM25fTLZFoUauit/SDwbEIDN/iv7b+b0/hgC0wlwna?=
 =?us-ascii?Q?4oQUK/uhSpVsoABZWuOy1g9Na5v2JL5BJhP3W3yZfU7/bDdn7FmEcgfRL7Jq?=
 =?us-ascii?Q?m65HF3UzkCR4NCINWE2B3hjOjK1+aIqYnqq2BhLD6TI5HyEhX2iBWcWlA0N3?=
 =?us-ascii?Q?qz0AIjZMijiKhYDM75kQ5IWPOx9FKiqqi11Uc0snSAsldQ2e+5GfpGipZGF2?=
 =?us-ascii?Q?6QblHxHYGcjVKcTGaeItqm7v0uFxPBEROd9x2hVq/QDHdbAX95q+Zd3F0HDB?=
 =?us-ascii?Q?14761UhVoNuuG9AFKZr462W6MY4p8mW/Y28X+XRpGfdX5qsv/+tW9BcEwZmu?=
 =?us-ascii?Q?9l3gTIUnATDzmls4Qq3aD8j+vQe++DDeeyXsfCRbxjVJXR2qMUo1FIZ4o4Tn?=
 =?us-ascii?Q?WcUEGBi4PTlpVUUvFKZNiMCB6x00YgSqDFlH8YGblzGWNS+Si5iciT+onDWM?=
 =?us-ascii?Q?tQO+a7S3Sv/jmradyww5rkra6SJ42Qpc+lpZ33uxCpqvGrOkT1vicVG+5FSj?=
 =?us-ascii?Q?mOIF5vOsIj/xdzhGoZMEak+ddvV367Ei+dBrmp6MlGK90igzaPEgEG7Ud7sU?=
 =?us-ascii?Q?lKUC7KBLel6W5/TRlJAgO2In3aj6+h2jW1u/yp/5H7zAWynwDalZ06Lv5p4b?=
 =?us-ascii?Q?tua3t+qZ/pgMYYzjQCmKkMXOVuY+/9SR0ssqj+lDJQubABZK7jCFN1H9cIAN?=
 =?us-ascii?Q?3jRP0BthP2mhKBfl5ZjfvSOscC3sbF5usyjrX+ayJMOmpLnPKeRXew7JJBQf?=
 =?us-ascii?Q?Y2vjWMLZXRsduemcS1id0sfcsG7FY38V8DgXsggkLIAddexzEoyKimL+PUM8?=
 =?us-ascii?Q?TZ6Nn7Fx4o8Kdvd/crHmSYTovs397T53f7RzYbbKt5I2VddDQKiQaqsAWF3f?=
 =?us-ascii?Q?KTL2sEx+/UGyH1WJoeWXlARhCGZNisU0yTxUguNeOPeYHgXFGGjh6e9prpBX?=
 =?us-ascii?Q?TzoDc9NVfEWKeOfBZ0ESIvNT70mavzoZdLh4B9zbtJ/l8E8s8111Ox5c7Mgy?=
 =?us-ascii?Q?6PQvuMJY9E5qdrY81NqL1qtXiY13fpdN2uA6ZAf3ADG6uftSl8fVZ1vm33UZ?=
 =?us-ascii?Q?kH64oQyY4sB7g9xxX9lhd/sBPWDGK6T/MGclT5hrFqK1m0iu2n13GIVv3LnT?=
 =?us-ascii?Q?dPmjwGMgx4tvPtx2ajppbblNRuAbtCTJ9X+g6rMUgWawgK3djDiBKriVK88f?=
 =?us-ascii?Q?E+2sq+VOvQooN9D3ioaUrwXBYX7QvMqX89w2eKxLRSrseLr5CR5JU51tpzzv?=
 =?us-ascii?Q?Lxc50XpB+CSoMVE8O3PxrMCRKyGqy8D5qVunSeHwC4rAAbuLDbby8guHKhu5?=
 =?us-ascii?Q?JW4SLnUIuhyuakYI24nSUjVl7CIS1oVYNGNxm9zcX1ju5W/E0gr+qGNAKlWm?=
 =?us-ascii?Q?Kxd0tx1Arp7a2+bJ0ndjyfERqI2qOKgyQWwKVumR4txi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8oSmRNWaYNCFFSRFg/tLHsOHqd2z7pxHb5nKKnJDE/h3vWCvXkvJEgWJAAoJ?=
 =?us-ascii?Q?aO9Ubx8DCaeqoQJxTk+E7wKvAaGqU2yXxZz4Ep5SaE2O6KRVNQR7efa9YuUM?=
 =?us-ascii?Q?yZEDizBBbrelX9xTTcpc0F/3Eas16lFh611h0rxsrLjccePwDjXL5TmOXys0?=
 =?us-ascii?Q?yjJW3c9K6JkDcdlmRU3M+jTM1btDF9fuaD+C3XGYNFltUlp4LcQLxjeKPmkY?=
 =?us-ascii?Q?KAeJCxD9OTbmzkJjU2WT4g1RJVAp6JqHhxBkfh8NHkQ4nWznYUZJAGkU/VuC?=
 =?us-ascii?Q?D+b9mawSgkLOWoTRgQr3PEKBf8OBbyLOnO+l+RVA60JCa0wNUD0/f3bi1Zuu?=
 =?us-ascii?Q?PbsXUN+KtgOL+Zn5LUg1W+unFIR5rmrPti6YFKyx1zfSXv2ZDykMUt87nRI2?=
 =?us-ascii?Q?iEDvqTmP/whcAv5MKNdJJ/3eJrqT4/kZBk3Mf60uNCQVAPA1rjyC3NHmwReI?=
 =?us-ascii?Q?EBLoGlx7NgcteuCVTkQMrx1qre3dHyzNobIyRvvSdbWqOuL1H6zXPE4rScna?=
 =?us-ascii?Q?TqcD41Rsg7rZxi6+honjlL8ZOgLfi0w1Lm/XVJ5B5epUoHwJ1rg3yFxEu4IX?=
 =?us-ascii?Q?Q6ErXbAH8cofrDKKfDjpBoIpXqNUxhMjx2ySt5k5WwyagYDttz+o60JFCbJF?=
 =?us-ascii?Q?odjj3tAU9WyYssgRpEcEKyN2T0yCou/3cBscuaDa57FEqCne43SBgHgBeWp3?=
 =?us-ascii?Q?g38+yvTtICKzY5JwAFH2KjEh+0XiUiH8mWfvjviefK0l8JUovtcJwxC98nSZ?=
 =?us-ascii?Q?lAcvxw1bSJDjQbbyI/G01L1RGj8PPFJ1Hmn+KCDPI6ukl2qK34YBeliMWW9L?=
 =?us-ascii?Q?26Z6GI3TNgaJdOomw4sGMp2pXqhctnGFDg7012fwoUf/L7XLa7CM9dAWvJlr?=
 =?us-ascii?Q?7oSveL40maxFyee0eHhh0Ut3KnEpFzt1OnktjQoaMo+PQ7MW27eqtM15czb8?=
 =?us-ascii?Q?reA5EOfFiB9dVm2zNWthTnXKRXz+GKxybr+DE4nd8rt4wbN+tCb37o1who+K?=
 =?us-ascii?Q?i2M/J3Bgd+hjpu3HGXeVXB22YuL9MzPSCQfzD6rymS6kxtcEMH/L+Phn6fMM?=
 =?us-ascii?Q?42Q2r9QxjSLp6/gGyRmPagG1YUXlPJ3s961M9yDdH9X1sDbKJWnbCa3Ry+dT?=
 =?us-ascii?Q?eeh4Ud6cXeFhhflEbNcaJCzXJOv6UzZylgIGC2msBz9zeUSipVg+8+gDQFcl?=
 =?us-ascii?Q?P12sybnQ7o5Vl3x774R55rUsdZknf1uZaR/3emNOB5tJgodr3zYajxaIybOt?=
 =?us-ascii?Q?vKZTp/LQUo4ku+ETZPxB576jkBhEDzQ9WM/iaKI7bXk1PKBus2yXYAD9l2uQ?=
 =?us-ascii?Q?rmzRFK4YMZ1VPDnHJWXxDYMt2MTr89SouVA81SYiZkjb2iH2OWOHxXgUiuLe?=
 =?us-ascii?Q?4nbmXF1001wTmDRoo+NwrXivbgKmqi9c/AL7URZGBi9VrclWmJChtV9g9m33?=
 =?us-ascii?Q?SMwxWfhf/qZtz/xFT7ifyXDQMJIYyCNQQ4m+GW7CsoFW6l552/b0z4N5hU0J?=
 =?us-ascii?Q?qg3wRv7u+s0VIdHlfqoOx0YhO9Axw9nIR83u8hyG6zAOrvpknBsHsZOvA+jt?=
 =?us-ascii?Q?yNZBag3gmIvY4W4LZAnOVc/AQh9E6ePmtlEp2qMdJVE/NDoH2YRMOgjhOEMI?=
 =?us-ascii?Q?OmY/D5QQvKyv2zbqX0PfSzjB2trAMTlGui7hL7lgnsDOY//UuOdhwf9jJ8Al?=
 =?us-ascii?Q?x5/pCqaCC69IlgYc0jjVVCuZJnLtCs1HLBjyuU7UvyqgZ45siDebG+D7bTrc?=
 =?us-ascii?Q?+FSPkPPEWx2h/CqXEuW/sp+3tRBPK6s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 00addae7-d5c2-43ac-5e93-08de56f2c370
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 00:36:19.6285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGqpHxxltQFyYPzdWmOnYKdC5FWYKSjsHNr7vjSZN8h7tKG/wVVEl43i7kHSGZKdYdHbZ77BNaPV904SpiG1wxIe17vEeYvgTy6pEXRvMcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10761
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

GPT disk partition with max available number (ex: /dev/mmcblk128) can't
be read/write from U-Boot using read/write command. Here is an example:

  => mmc part

  Partition Map for mmc device 0  --   Partition Type: EFI

  Part	Start LBA	End LBA		Name
	Attributes
	Type GUID
	Partition GUID
  1	0x00001000	0x000013ff	"env1"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb02
  2	0x00001400	0x000017ff	"env2"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb03
  .................
  8	0x00158000	0x0034bfff	"apps"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb09
  128	0x00000420	0x00000fff	"fip"
	attrs:	0x0000000000000000
	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
	guid:	5452574f-2211-4433-5566-778899aabb01

  => read mmc 0#fip ${loadaddr} 0 4
  Could not find "fip" partition
  ** Bad device specification mmc 0#fip **
  ** Bad device specification mmc 0#fip **
  Couldn't find partition mmc 0#fip

The error is caused by invalid boundary checks. This patch fixes an
issue.

Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_info_by_uuid()")
Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 disk/part.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 49a0fca6b89..4923dc44593 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	if (!part_drv)
 		return -1;
 
-	for (i = 1; i < part_drv->max_entries; i++) {
+	for (i = 1; i <= part_drv->max_entries; i++) {
 		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
 			/* -ENOSYS means no ->get_info method. */
@@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	if (!part_drv)
 		return -1;
 
-	for (i = 1; i < part_drv->max_entries; i++) {
+	for (i = 1; i <= part_drv->max_entries; i++) {
 		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
 			/* -ENOSYS means no ->get_info method. */
-- 
2.51.0

