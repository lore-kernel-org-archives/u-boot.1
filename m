Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD90D2ECF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 22:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A7F83A3B;
	Mon, 19 Jan 2026 23:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="k6EJz7BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71BF83A2D; Mon, 19 Jan 2026 23:33:21 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8860839DF
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEvRMbUvGKhbdknqraXQ98oS5We7KvEomVOxj9PNlGZPyo1NEpx4/bHY2ReHX2zW1+bzz2TiljcZr+ozL6cfA/YOYUzS3f615TyDZWI6BvZhPKW996YG/VdZ8p73v77qSNFm6iKdJqGd0A756huqM/ypftsiWaFfMQN+u5Osc4sIYMN+lXWGa0DaZh4syFC2WbhQzlD/4Bm3aHDd3LwkrwNswxAvGuHUW2UPiAGDnkSjfDTFxDsmjApMlGFU/vYrbnb669n/47K75bN03HjnGs3BcJXtWNh1IWv4izEMtGhTY7b17cHy4eT5fhrnpfV69Xf/luAptjpkwezKe1XWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0UkiIINhJYo97IJvqstoAoAFaLc/DuKiD6dk54QoFU=;
 b=mwIOxMN/SyaeAN+H/yJiKF9+z7tZDq/WSrzdvzrW6fUZvNGlQ17AB9xfvrB/020cCMWQL07E0DwLHvCF8b6D33DlE/8hVpc2JXw1rM7q5j9JyqHTDuNymKExgVG9tdJQpWYCpqZEoiy8c16nOsIQmN8KxHDi/9qLQZTNnuriD8Qkg6TLIBtfxEm+KyjjgQyajj+zDiZyHM1OgsoCAuM8o+LcNXwVk7eoaRNqhS0OwjUVCAaz/6UKOIQoirpdLQ9W5MJEeR3luQcgfYra+EsxtlCQNBNoAzpwc2bEJytz/GVoRBbwAXPxZnXPxbw9Trodc92fAd1j3s9iNkI/xtws1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0UkiIINhJYo97IJvqstoAoAFaLc/DuKiD6dk54QoFU=;
 b=k6EJz7BRuu2pZy5y7vVYCHpnCNUu20npeqnXsd1aBwJuRrp2bFlJuJHyA557gftLOF4ubCnUYEIcV1yTN9Qq0vk2zLZU+B4+RgutmZwooiLmGfclKg1Ep9qpH7wo5J9pa2E7Cpk3d6LfyYRjtXbCQBZ4Tv6rbVTBGqYQlcybM74T2BGC6xzQcXFNGm9V/UlsonFvFw4frn3pRpBXCoRhXYcXKCq4zokz8FDFv0Dm5WmEaG6s4ijDjDtR6avPUixEnINZrxjIYiINHPIlcdaKTBMLwYeKn7oOrzLCHckpEXCw7ccbbPz+BorbQG6DLArLkvf5xmU+DuGCpllV1A5iGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by AS4PR08MB8242.eurprd08.prod.outlook.com
 (2603:10a6:20b:51e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:33:18 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 22:33:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/3] disk: part: fix partition search boundaries
Date: Tue, 20 Jan 2026 01:33:03 +0300
Message-ID: <20260119223305.3022690-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|AS4PR08MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: a8070cd1-1937-4ea3-8d32-08de57aabe4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z+4c6GG7elTfApVONEXYDj0zeVBcENm4KD0Ral3ccXcx+vNHW4XjTe8s1lw8?=
 =?us-ascii?Q?0vABjnJ6UzqQbJ+9RcmeZ3nfhpolKp9bsUr2JNICy4LdFfXejvsLXswuszce?=
 =?us-ascii?Q?TA209ZoAFLgnlavMCg1HRCUUo44WsvlNZCnhgjaG7XH+d9K9eooz8SM14Gb9?=
 =?us-ascii?Q?2ydqwwIBz9KO/G/MLxe00HDV0VQ51GtjZBREzgb+DaetmqzDxR2ns3ISwt3r?=
 =?us-ascii?Q?3PYWXEgtlw1bOaVWA7L8EmFAHX6kVpjxQEzRSmfs3tHX2nfRZLRb+jxxUypU?=
 =?us-ascii?Q?svbbad1bXuyPUSvTEbMXxhiW2/PMKzsxI/NE+DPspFZv/HJPgCek+zdXsXC5?=
 =?us-ascii?Q?wTDFNkoEo5deDXSXfv//J2DyxQ2+2FEK/cZXmQQy30YegE/f3IY/slN58C3l?=
 =?us-ascii?Q?e+4S9E2/N1rDkf3vLVECPQAk8fU4rDnnxK2CuJ6MgK5y4r9MLwGEqm2T2SQH?=
 =?us-ascii?Q?6wSRMt5+HSD5e54/D5w0t/e27/BwXXteUhxdK/BgLCNb54jm7TaqEtpD2U+W?=
 =?us-ascii?Q?F/UD63JA/3BEXIpKHPOZk2MtaZ+gfy835Vrab9w4BitblNQFdleeKf8zxlAt?=
 =?us-ascii?Q?PSJ6+jxpoJznHPj1gdRPbklE0SOvX9Md+lcSgmYwdgDrJ0lFInn/IE/KrJ/6?=
 =?us-ascii?Q?K1yqSEB3l+ny5za2vgGxXeyDHKye0oaPdNngxI/EFWZwkULHnSBFYZ/jK20+?=
 =?us-ascii?Q?D6JLwhgNbZRNBJ2BpBqL5qN674Os5uaUltpMNDza0hFgD9jPLtdZd5rR1HE6?=
 =?us-ascii?Q?oDU2U2yzAUXh60Xay9SrvbSqzI89iQ7oSsc0lpzIQ06qCAlSpSd7VKG5DNjD?=
 =?us-ascii?Q?Y8AHh5y3L6e6ms+ioWH6o6xdlOhxDeaouNqXOcXADjMbo/NVXHJDgcAKGlYe?=
 =?us-ascii?Q?MHoxJSfgk9VR7OcE0izksVwQlPD8GZ7IkTJRAFP/aSuDUv/mjkQMz7s6d4sn?=
 =?us-ascii?Q?8fptNJQZiM/hJDu1KfEduKoC1WHHBw2oreTjJm0wZIohrs7x+c2mIKqzoaAZ?=
 =?us-ascii?Q?9+P7hK1f50WvjJBIIyeZ4B22Hz9gPqkciWVUTGRyGes8Dn1RQLYrfvSCSQRq?=
 =?us-ascii?Q?rG6pt9QvuW8NiML8QajgslLJQc/H9AWOVZV0oXTR05cdWTNoj17jTREIwu8h?=
 =?us-ascii?Q?+kNeTQi6m69NKDnXkObGaPU+XBmNf7dW2DryexAqgTUBTPoEq47VsG2ejq/8?=
 =?us-ascii?Q?FDHEKuJs2F0JPKsMdmVjITWWskmmOzBoY+iOLU2OiLcWMrHiwXcvy+OMulDd?=
 =?us-ascii?Q?o//xE/a+VRmeE96cljbQ9ebKoCbB6QjJNWTmzYB92XNwnGx93aHGp7n/jGZP?=
 =?us-ascii?Q?coRxKpMN4a90jlYr4sTMHF0TT4Ronurx2poQQvYwBTGQpy2BWkh+f/LLPZT4?=
 =?us-ascii?Q?82PVeUmqmexeywAb1x7kvBem1mwfzCFZWnaCFu3QiNy5B5qHn0UL7jP5Obw7?=
 =?us-ascii?Q?UJ11Lb1rJf6fCppRAflhnFGG1oXBtrhOgNuDDhrnu6xaqOUUlZfMuchTZsmw?=
 =?us-ascii?Q?UC0bolbAi1KMx4mj5+GjcPAx/5abqIxlxRAIL+sEjiBIscRD6GEZgw3YQT0F?=
 =?us-ascii?Q?AoNx6ex2RO6SijEZxBiNW5qvth+WVZhKZIMPRWr3hC3NOeOwMVt+jSmeTJRW?=
 =?us-ascii?Q?vvmzXsubOJi1/uIJI1HJBR0uxBvrmLEj7MkF+izuJEok?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjvUpgAQRcMHnfEiVz2vtOOySukRkgfKCjX65th6TMSL1j6QRkY3WHSFbpQf?=
 =?us-ascii?Q?JzpFIJmS4E9wQIqPzbyagO4kJc37gChUVEsbbRKexubfYF/f6aC5rCXIK/nH?=
 =?us-ascii?Q?cYBNvy1T/cjj0pdQxpeKKY8FEFR6dnnQiud/4g6tPOeai47wFKMUVHlGcVSk?=
 =?us-ascii?Q?JYtzelxurvv1O23QpCmVpK6Oh7XbDcOdUe2cFDDNg/ZzpwVEFEarcT26RBij?=
 =?us-ascii?Q?FoX9lNvaKroUcFPM3EbH4pdyL9d/92SR8VncI9FSzKFZgyaLiiP6CkJgupiI?=
 =?us-ascii?Q?Q8OAo+NiOxP+KKcOjjyz6eK5XUtXGbdkYRA2UPIsiNxs1tw9sw9I72+yuF4N?=
 =?us-ascii?Q?3+dSZ29VVyKJsSnAdMr/lPgO3zTnmE1oc1dUjGKXswfF+69+y57H5lYkId0W?=
 =?us-ascii?Q?drZklkjGPPh7TnhoKjHfTTet24tHjek1Bf5s510J6H1QSfVOXByQ5PPhVfWz?=
 =?us-ascii?Q?uekkg4UZC4brvYUp0pifBKPG+MKYRgUEdq/pI4zaX7WdUr2IMIukt2q/uTr2?=
 =?us-ascii?Q?RRlR3gdrYKE8euaVeD2S/Jzbgt3FPAwqbn3h4M2gIMxSGMg7VYM/aC3AIRx8?=
 =?us-ascii?Q?hOhZoWzzSdDzW9HgnY6buIqmZxvMsMkqQQxptfwfJ0qg6yG2IP2qCbFbcsV0?=
 =?us-ascii?Q?oVor0uzo6DxMd0/ESgXwLS22cFyo7jYOnp5sPmvsjascEtc8bn8zisulI+RC?=
 =?us-ascii?Q?5fiTaDdIuwJd7MQ7ZMyxplofZIMSXwXm0ipAppAMtTTJuOb/A2j04OYESrI/?=
 =?us-ascii?Q?C7HmYqgOFDN2+oOHHJkUfiDk/zWo3YDvA/S07pc4qZkJOou101R1S36ivUva?=
 =?us-ascii?Q?ImEB/RjNpr7I/ni1Xxpg9vqJIwhK+7KU4Gx2dewfPhgEn3oDXlPqF6Yz/qS/?=
 =?us-ascii?Q?gG7qCLBSyDPCs3CY/IbrFwaJCY83sCbr8fkgn6s2fGeNNvQE8K1gGy9mVOpq?=
 =?us-ascii?Q?7INBZbjiGrfDNMN2Da9gyJ4Zy1J6I12Pi/pzwPMPOm4lBwJWhqcaUwoQ5FCs?=
 =?us-ascii?Q?VYqfvHEGIjS1iaKnXmWg+G6qHqyrANoah6ctJTXDjnSZyuGFzmuGm5YsqDpw?=
 =?us-ascii?Q?3syDkGfwKdN6P8RwC3VsEbQEBBgGYzfEZuGZsw9X36/M5rsNJMMAq67tdsR1?=
 =?us-ascii?Q?3ggUwwT2XgIUYLQ5iM6fTnh92AkpFj5c/yDEwRpn5Zkm9kpquiBQBYjRFZeO?=
 =?us-ascii?Q?Mhy+uKJ9HfCMV4e7H7dxRhT+UtGScysXeUUyDjeyLvslMcLdYlblhPKvmDX/?=
 =?us-ascii?Q?81KY5wQdFrVU0x+GUilEFdOnpK9J2inTyXTknMzd832HHrWaBqlRbeBnZgTa?=
 =?us-ascii?Q?rfKCrjRgXXnWMA5nsr9wDCrfK0mOIvZ4NplrvHxPHK5p6lgqQ6/s5oSrJb9V?=
 =?us-ascii?Q?48ldbRde8JNr4uyADzQSaHBG5Z2eHFe57d059SZG+J+ajIzSHJIIOwDCnVas?=
 =?us-ascii?Q?BZ3YJc1qMzXJBdzd8VYiC9nHBiO6/uHLWK31jotMBwyM7IgFsKnbDpUz6/AI?=
 =?us-ascii?Q?aIFfvE5zY/3SXsxVSiv8pmqQaRX8awPcQbhaAASDEynzp89rw6zgNgAMmtKX?=
 =?us-ascii?Q?z/6+/rgGJNmaR2WZP9be3iC2OxAKYGM4vbfbnDN7XRV9WnNhA5hpsMRMqeXV?=
 =?us-ascii?Q?smnfam1SEiqYyobN1JIkyBuGKSWP4x+gWYfpwtL7m9nJOsIe1Hjx2SBOluEu?=
 =?us-ascii?Q?3r0DzwyBzDyGYDeuN/LcM2uLgTbTr//3/PXqvj7ckVvRCZAE9V1+fr27aeGD?=
 =?us-ascii?Q?UzOeUH/pkw1193y1Q0CylJTBtpoGrTE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a8070cd1-1937-4ea3-8d32-08de57aabe4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:33:18.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGV4zmVqGHtiEvpwjHa/6XO/SGwAbWb02Iag4dMQhari+lxVQW98VqUG+y3fe3F6S6/RVYdCbpuyUzRtCHAepnEu4Ki7KNwv9rYOCa7tAvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8242
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
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
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

