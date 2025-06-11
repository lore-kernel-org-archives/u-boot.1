Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C327CC678DC
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D734082C79;
	Wed, 11 Jun 2025 17:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BSnJdzYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E4282C67; Wed, 11 Jun 2025 17:10:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DE982B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 17:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4jLz4tZP0SEQDfDS/8oOZtRdhDj5OqrAKzbcY58u2Raz/Cjiph1OpYHe+zRoNYLIoomwn5xYvu4JJKHVNEcCQE+9WOK8aJA+fIp94dKQM/onGTEyFGq9LdDy9BElamHAmOAwX6LPZsn0mOk+YixY1W7AziE1Z7OPxL0eV8tt23mCnoHdDNo80Hg2U3SHY+yeX36fXh8REe/tLVdusUDnYVhSrcZF694RfVukBIgT48fNQywRUf1OTB9oqe8UjECsTEplOJETtSgAUklRJtarGrIMnOE7uhqQ305en96JEthDVQZqoj8PcQxg26qPgad+LCEFA6j6esl1+6I23fO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E10mp/CSZ45OnvWcov7/DnLz7gLFKNGd6av22Zde7xk=;
 b=Gmn2EgpmuE2ufC32ZaPwqSYLZdMHW/BbJdTsPcN/OdVhfk2LJKgc0Gzkb/cTW8KMIMzxTpsr4h8uHk/146bEyeC4bPC2A/VJn/o/rFFcsw3eRtyKmgLfhkww8QmVNmew1SuseDQ5CmHcqnhHCo8MiCI96R6QI4NoFK35i6UM+o1yiOrKFmcdYBDPbNytQC60Dgnq6Ajt930N7JolEs8bicsdt2H1tkdg4LY2fODNlShK+hGBQXk+V1qFPyZpysyjXuQJrrFSKAWexES/c1K9KbFXsYTXQZ4L0Fg5qQHSAw/pNz7+Qmg3pw9plgvvcOYTiQL+ZzhPpDUcRvGCqeHErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E10mp/CSZ45OnvWcov7/DnLz7gLFKNGd6av22Zde7xk=;
 b=BSnJdzYd0uFN3n83rDEuY8vpxdfCOR01HMX+yEXrt/nx0iyEZm60gXmYiiWiC6I0r0DB1KL1gKds4WmL7HJ6H/OCtdpP16o0kEd+j7clze7+XG5hZbdZHrn1BILa1VSqFEeh2b5iZQ+6UDv+HSTZNGqtS5sQwBJvIYIwvtr+nalPlEKzM8r0w5/pfp6EuKcVfh760F9+jVCPDNVtwTgeGrtJuT+KGypSNxL97g8OeyqyxLxKm2E3jAo5sbVDmgKmXMSsxTX6NVkxbGVxe33QV0hM3X5HjeZpus+kEvuLI5CvONix15ddNbX7PRixJKDYoon/7rycDRZdFRqeNSq0zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8089.eurprd08.prod.outlook.com (2603:10a6:10:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Wed, 11 Jun
 2025 15:10:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 15:10:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/3] drivers/spi/airoha_snfi_spi: dual/quad wires modes, dma
Date: Wed, 11 Jun 2025 18:10:40 +0300
Message-ID: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 14141e70-4a72-4e1f-5c79-08dda8fa277e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UXAosHIdqzb1+R60ZhaHeg9BkzlZYe1WdFxHxChYjLXyq5xcahEiNaM7A1DQ?=
 =?us-ascii?Q?qqP8ZXF2Lq/lO2tZah9xhLtW7sZDbRhbnZ87rMLXEgfsOn+rc1vfoviePGzZ?=
 =?us-ascii?Q?Rsl4dROvgAhnYwaiCCZTRp+sOjLPT8UE3ZmcQB+xY+ODMkKb6DOvl/7VSH9I?=
 =?us-ascii?Q?QpdMHIqnVGpT2lvPknVEZ0dMT9ckPhPNizgl9RC6W3M8Vtuu1Uqdys4hO2Pz?=
 =?us-ascii?Q?br0sAiT3fwTXPiUjMcBWx4NChmxgSXJsSr699KW7PZZwh/SFtNfV8DCJP0SK?=
 =?us-ascii?Q?RF182cdcXeYZwr/6JMQ5jaTH/QOwe5OQQhtWYdzdTPUQVYUrswZcPr8JofBY?=
 =?us-ascii?Q?NiUaDCQzZtVj1hdtDpNFN5ucie1CIVYSmKwboDGiYTB700k28e883A/KxiT9?=
 =?us-ascii?Q?+RZguD7KEqk0HUiz7686uFmy4YrCWQxWC9jGRozMh/5BW4uvzIsz+50kkTis?=
 =?us-ascii?Q?NpGR9culun2mSJoWM9WWjVO5qh1PwfpwXzDVMmeNeibm6mXGEevC3qFoUYL9?=
 =?us-ascii?Q?q0LnuHQhZddMmi/ejdfpMNgVHbj6WMcjNEv/pNfqcyvWsOxHGgd8xLPYgrNt?=
 =?us-ascii?Q?vsaiJgTpiUwv8HAcKMGGTJIcVBf4SbS1+5vweA8pKWeQgXpRyLDz/o00JB0t?=
 =?us-ascii?Q?aMPeUejzTa4UDP6wdskymNBq5/pEJPrpjQ9gLWuKBkr+qWoycallCRyKVn9O?=
 =?us-ascii?Q?rtArUfjZt1f6UlD34krpFolEBXyxi6BgsHK2A6gOkKel3E7jHmnxfuMfeq6H?=
 =?us-ascii?Q?OEAGJ+skoU+jCTHmeT7e77370GyrIuC4VUs3wvjHXiegCpLr+2a2kJTJXv5w?=
 =?us-ascii?Q?cKoHIsvaDahp1Xt472W0nu9B8BoogZzXD/LjXWuZsRqSRb+zL4dFUqMBA5kQ?=
 =?us-ascii?Q?VXBlqvg+oIXLwfGHW/YwskCh8Av+EpVkd29HWm+UJ07NYTN+qjScxVFEVJwQ?=
 =?us-ascii?Q?y+2gY9vXcbeNjUsOnHe9OuJpSLT9a6AUDNm/xmJkndbDcq+57jPw1KXHt1IW?=
 =?us-ascii?Q?b/Zhx2d5pmAjkUkeRSAS4+1FT16j/fZ3LKmK0CbilwkXFhIY33PxG+HZdW/I?=
 =?us-ascii?Q?laYq1NSAuecNUOSFVqMbRFpthIW37WJAe9319oUxev05nnkBytb8VIe0x1SV?=
 =?us-ascii?Q?bdeWivbZk1jg9EcVqKev/1kR/sv95JZkXlO56AqP07DFVkE0Vc1CbytHyRzP?=
 =?us-ascii?Q?l16rTQB322iMbhsjwpC9rlwvHoJMvVQvlCU6Hvv2vVfmnyLTq30KLDrznP6/?=
 =?us-ascii?Q?MC8kuDCC/Y3/YCzV7PTvuXvaWgLo6+gf78C1Pm4ByFUepd2LE/CAy1qiwl6c?=
 =?us-ascii?Q?AHnYUdDgU6g4khq7KvOC/gxmTW1IIFHDkdaeOX6EzRk3F6w1W8o7KTd/0LiT?=
 =?us-ascii?Q?H4lmvINUt7PWHCtvc/qSg4Nvu1m9NJCkF21qqw5oz3xJUz+78YT6jrI2YyDH?=
 =?us-ascii?Q?pxiGnYI/a4oKhdNXesvkSz4qfnW6MhWZDIbkClHGWkepWZmIHEaj3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQkLU9xQJ3kWbHmikeGbmDCd9O3jnndqXskV1L9iCkniQUZKz1/cd5MgElab?=
 =?us-ascii?Q?ILo4REI8Oh3ccf4+teSdomoa5jfoHDeobLy6p8ytDWE29rsINxAgJeIER8gl?=
 =?us-ascii?Q?IIEL/5hqoEm6niCQ1jV7ZY8z51kFw946b1irJ7MKl1WgnGQc17lVW7daDBRz?=
 =?us-ascii?Q?PTCrUDYrUmQkOHdydFd6CD4C3iHJElxQgLeR+Du65G153oFyEUcLS70xHjtb?=
 =?us-ascii?Q?5DTzOjeOGiBqNs3b0e5M+0n2HlYXbBjX9n+WKr+Tmw3Xn49ufaIIxPIUb5at?=
 =?us-ascii?Q?AUL90X8o44fiVwo0MuwK4BI6JYkcIRf1ol2CxD5esrUX6mbBmHbCKOLIaLRV?=
 =?us-ascii?Q?RwbYnOk/T7Snexf16BDJ6G0KIbZkg2P294nlB0fW0C8PARvo2nwJ7jqQXH3+?=
 =?us-ascii?Q?rHjjEfl4xOcSEY5YOLUTowGQWk+UzCEYMK1jMBMuExREgpN+wmLPrPEM/SeW?=
 =?us-ascii?Q?NRR/Lba08fzj7nYrNSzudL477+GqoVVHehKTeIfnrk/f6lx+zIQ1hVXCsxps?=
 =?us-ascii?Q?XD+Iudoeta/HDJiqnUB+BQhY1eza3vHpAsrsqHhVYM8oLTR1Kmtv+LYFlyrz?=
 =?us-ascii?Q?8Tpkxqk0Xrdz1o5VcaXSmhz9ZnOKs/MQgvhdCZXwMBr2XYg4IV4uxYINBQ+V?=
 =?us-ascii?Q?9YMAFJVGLmgdw2+h6KliT+fhKUJOsmnqMGII+cIzsO5MZmmvLzt7NWY0gXwK?=
 =?us-ascii?Q?s7H3XiSqTczoM0zbMW3LCYXnibkJO4Jo42RXMcyb/T+UItxKzGdmECzNNPEZ?=
 =?us-ascii?Q?WLf3nJLaMU3RpVLkM3UWipUFKdg/+ganZuMhT8XL99ZdlmYgq8a/mL0Z9WyU?=
 =?us-ascii?Q?6ku9zFIV/+MzKxprM4+CaFMX44DxzXe2sSji5ry66l5lr2fuTcWemwTar9iY?=
 =?us-ascii?Q?mTEO8eDSQaToLhNGnj6yMWa47efFhJui7qf7It33yKRUB99yAtPvTNaWY0DZ?=
 =?us-ascii?Q?Rhr97BlAjI2hIxv/POH3f3J4KMBXISRKFAo5nv4pO2sd/Aw3cSYZlTYGChmS?=
 =?us-ascii?Q?nkUMjKD4GHx6rKYvGW3ujiH/gpOIzyMvMAeMArgXHkd0sWpabyxjF4taUZHw?=
 =?us-ascii?Q?uLvTQHWDQIlEvnANf7C9XtCkJsvpxPEyndv/lmcWhkt4miSXGQX8TahuyDU+?=
 =?us-ascii?Q?WGnpAKsIE198/LXRk5udZkYKMJeLzS5TrZQ59lKCK0ynFj2Jw8blAEBxQG3T?=
 =?us-ascii?Q?AV7QIm7QONMOwgKGzGq60XZ/xsOLWupCR+PYFD56IZf2nrynZmrys+tWAv4j?=
 =?us-ascii?Q?ZaX8/W79hyKLGPHB9HTEc6xE58M7oWdAawZib3QKOfw9yRslO+3y4ziMKlTG?=
 =?us-ascii?Q?cLTEeVjB4qhHf87uESgT3mro1Tr5ZFXFc/LcRXWpsY4QZw7hI1OPPnr81HMs?=
 =?us-ascii?Q?ZtvxQU1p49iQ0z3Q59aY7kkgXD6pyzPugABd7hB1YYJ7EKQ0Jn0FP8g8NBje?=
 =?us-ascii?Q?AAgWolEkirw90W0Pu39VKAoVu+U+aDztZyzuevJw8Ttg3MQDrIsd+MECe1bo?=
 =?us-ascii?Q?Fe/xPuIP3CA08F3uVWxlRrVuINQ2quKlEfNyoVSSzc16svq6D6Ne8JKDFZx3?=
 =?us-ascii?Q?nMmJTYRZy3+eZhGEXhxtTg+ywV7NtntyhGLpIBVNvcpeQxzWKdcr2bF6KEFp?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 14141e70-4a72-4e1f-5c79-08dda8fa277e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:10:51.9046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JihCDOe3b3hqI3vc8nX0eLn9OAXbmllR4viw/8ajSMU7Gu7ckqt0VmvF1RU2ola0LWsdEgPMf2EP+FkKQ4Vh7vE7Cj/J6dSRh7HMF2c0NHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8089
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

This patch series adds
 * Support of 2-wire and 4-wire spi modes. It speeds up flash read/write
   by 2 (or 4) times on the corresponding hardware.
 * Support of DMA for spi-nand cache reading/writing/updating. It speeds
   up flash read/write very much.

Only 2-wire mode has been tested so far. It works fine with en7523/an7581
chips.

UBI attaching
-------------
before: 17 sec
after:  2.5 sec

reading of 0x1000000 bytes
--------------------------
before: 17 sec
after: 2 sec

Changes v2:
 * dma support was added

Mikhail Kshevetskiy (3):
  drivers/spi/airoha_snfi_spi: remove unnecessary operation
    adjust_op_size
  drivers/spi/airoha_snfi_spi: add support of dual/quad wires spi modes
  drivers/spi/airoha_snfi_spi: add dma support

 drivers/spi/airoha_snfi_spi.c | 634 ++++++++++++++++++++++++++++++++--
 1 file changed, 596 insertions(+), 38 deletions(-)

-- 
2.47.2

