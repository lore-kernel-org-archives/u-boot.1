Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6D5C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1226F8899D;
	Wed, 14 Aug 2024 12:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="s1rFlG9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516E7889BD; Wed, 14 Aug 2024 12:14:19 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C75F888CC
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwN59cyDkGEFlQeiuYoPrkQHE8NfDQh4Dy6Z/NoRsgY+RBc1N8R52ZliqI6CxYDlwBW+be/twMQteASQmheZRz9TkdIk77MZu5Y2T+LIXm9D+fmIkKgunwXQ+MKXeyOyYTbtmiYEP0Oqnzx3bIzlwe6I9JTfzuK4ZzWnzuoh5JQtyXrNHjkq8TJJs+w7OBATQJnK3abDAdvrFZ+fOVrd3mtBeVcJByTA1tdvc8FJR2jDycACi9S8IXzj2LA5Z3LMIS2eVq/KZgesxJDvuVlo3/veqQji7Xjiz6K1erMbtEyq433/uKcALgFQAzzzXqXwtZYUbQ2Cg+sIxlNzl6ExBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzLawb8dV//VHBWFLogbp7s/tUUK0M7A/JzvdkuimYk=;
 b=yMkGZtf5BR/dDbEslG5MnbgGw/ldlqeuJTHAQh6iC71dfs9f7btiKvI+6x+Gws2kHBG7xNJ3IUOaBXGl7W7LbsZgaK7htaZl4p2LYKOHT28PAxFT1b/TcSWGVqMjpJgtIroC7022VbVrbnTPhG6owde0JlPJoywde+ad9jRm9MoeBsCWEf9e770hrHXOTtTmPbFm19K7BCdmBE7XVzoQe1AyOyfKJncFvuGV2uIWKXNww4Vht210cyKZ365rPOiLgvnp4ZE2KwPhmgFO3C/IFwlZrVYuRwr0ZxePX0CLQ4DS2sM74gIQq3z++kLj1MgbiXTqq5fMaWue8pqTHgnjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzLawb8dV//VHBWFLogbp7s/tUUK0M7A/JzvdkuimYk=;
 b=s1rFlG9ijlzxOSDbBmrapObiVEaCMxd9YmS9ieBZKYf/mQqXgeoLBvbkMcn9eCRowTl++oCLVUyahdEVLEXPaJgFaKk8lDOveoXQUCpgK1h8Ha3QXFUfXZy9IvNryq42pnX3B8hxaAQzhgEA97txOfP6M6+q3zPW+AnmKRvlgINpfDRYFIhEBWphXc69VF7TXp4IBGqeJ3wd8js+8bV9l2gfRPBDJxNlr856lyg4Xr9gwfLqzR6xZimssJ9AjL1BBt7DdmyjBXCWgIoj2L8M0d9YWG69qZmrcJr3Xo9dqfAPh+mdjmkRyxWKeO6rMHBXKCGugGQSsZPQdz9DzX0Hqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5709.eurprd08.prod.outlook.com (2603:10a6:800:1a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:14:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:14:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 0/2] spi: dtb parsing fixes
Date: Wed, 14 Aug 2024 14:14:00 +0400
Message-Id: <20240814101402.1346941-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: c43ca174-7c08-4fe9-9d75-08dcbc49d8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5hK0VWgBb/C7KsNs7pkUL8YLJ13R9um5FeJrG6yCB1taUKv7S3ibydruhufI?=
 =?us-ascii?Q?iPbuRWCSk393oEY4dzALnhuZG/Ste4u9wiKwrJIcIm2Yt2GtUlPU7oqy016L?=
 =?us-ascii?Q?r4zGZwvey5qEnWT0cXgi5AHicqRWduJMYhWOEhMWGjCP0FRyOv0loWNlA5kp?=
 =?us-ascii?Q?mzYEPSDuydihPyL3Enr6r1pjnt8ep3A6q5gneo/uBGyc3tOX+kBa9mX6j60s?=
 =?us-ascii?Q?Y0epyJLRL5VfLaMkMflytOxzJg0X76ip6PN8kbo1yRrhFUgjNfzo1+kWl8O6?=
 =?us-ascii?Q?fJMzrZ2HF48kGa33V+1cLReR8Zc3Uq7vbtwNZqdRUjFHFiKenQUiZ1y08tic?=
 =?us-ascii?Q?KG2G14Lr2AJ5hssuATbYvd4k33Qfc/FHTuzMzHT/VRCe39rNaiaB1SbkP/Zy?=
 =?us-ascii?Q?V1y/i6+aaAlRPK8edEG3Bhh3PUTnWxQ+xgLcWuSf21yZdZ0ZNISCZLPVF1GV?=
 =?us-ascii?Q?ABlmDSVt3s1mridxPIwmb/5DAtEa+L92EzmAkIFO4wtDGMaAOpl3CwFXSSQG?=
 =?us-ascii?Q?F5zRm60rlK2diCoNBvb4K9IIRtTJqJaHmi3HfDFOkQ9vgvYBRhUJZdlqXnQ1?=
 =?us-ascii?Q?zvxGC025/pOJtaLfJ11SZ1bdezioSvpjoYe2K2MQ91mdqWnIs1oaGJ0TEiPA?=
 =?us-ascii?Q?A8d1eynABKPtGW7htAUGSEByuZPOEfJVwurI9HeEEJsOf9oALiHapErxGGRU?=
 =?us-ascii?Q?H6DuZbWINaMavnsJjeed52+oy5gEVR4MjRFj9lsChKonKiOnk/gicJisRH5C?=
 =?us-ascii?Q?bPzEROlbvE+koKAydCuUURXt0Tie08NCvV0FuZmeI4Ngf5tFWO+OohSyLFB2?=
 =?us-ascii?Q?UQq4Sumg6XdDa4b47JsmErXAdYr5DnBSjnMH3oM84sO/OXlBR8VwFBs4ql5i?=
 =?us-ascii?Q?B2Z+y5VpAuuu1+CTHmx46RKogTtYYLd0lDZsQaXYBwL6vCfw+b0PKNTmyoKH?=
 =?us-ascii?Q?mbXDm0l9skTZKcBXiqWwy5KrRQ6JqcRimcSiGYq611bNPMbByOeTD6UlOPjW?=
 =?us-ascii?Q?8GCwa7zEtTNmO0IZqr73TnBQsRfUv6aw9ztmejMMW2jRMPTYsx1ycS1SpaH1?=
 =?us-ascii?Q?vVvL1HedoHrAXzqLYMYDnpoYMWFSDpYz72fC4KFCvlFXApmU89M6okAx/QkI?=
 =?us-ascii?Q?WdTdOpvOHpSRwe4evbI0Sxb9KXBeo8W6VeIYDxnrqQhV6nuf2pu/SLC5DOpt?=
 =?us-ascii?Q?C3WDxh3mEQhrj3f59geI2kg2PUP844wy6Ke0znVRExzZso2r6Xsj2FOsMhtv?=
 =?us-ascii?Q?t30MQQFYQtoaRyoKx54+CqTVkYxUA5cuVYrXu5xQZuHONnxxhYF3Zhtg418O?=
 =?us-ascii?Q?nlIsVWSQvo/ROwpBjmDYcNLjjSoWleYN0kXukRdbdDKQ/yisrauOGkgUAuAY?=
 =?us-ascii?Q?0L2XMi7Q3bKsIy04nkqxkRWqy52ABq+ol7QBSFDu6PwZPJOssg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vR4Q2Rtj56eFdBkXudFfcSX6KxmPxin2pV+DrIDJ6H+fFTCAj62Z8Exywr1I?=
 =?us-ascii?Q?fi+TwLYPhdLMprfuZsd0haUsWNP2eM8RXQUPstqco8N+0i57SkmDbPkhpOBS?=
 =?us-ascii?Q?Hin1gm+eiwUWwG2I+EAELSa12MkaNvVAUbmkCElsg7UQnuTBzQcuxGFLmfxL?=
 =?us-ascii?Q?+uCrH3vE1+92mHG/21TvmJJK7SywiO9WmjcPCZRPYO0oZAuMrgEFjL3sgszQ?=
 =?us-ascii?Q?O91yqFUYd7D3xV34PcFGSaeAsFfyB+JO7k6LhQbUuYi95RIixGYbUvoGUxSH?=
 =?us-ascii?Q?CsL6qY1VPvn5pFlbBd+oOOwmlcABCHG/58yjZNMxT9s9AX0GUol8s9ebLVMt?=
 =?us-ascii?Q?t4qrqey+dUO2On5slXFX83d6o1FfCgz5mzGadg3l/kLCWTmLYFVbbwttwTC1?=
 =?us-ascii?Q?FW+bC9V6ezJapldVe6Izkcs4WJ818MaXuRW9w0nZRgmMCMnuc+OlMTBP7V5I?=
 =?us-ascii?Q?rnisybc6WE+AsoFp+aMg716eGQ9trRfOgP+CBiFIfEyq8pZFRdmpuTXslPFc?=
 =?us-ascii?Q?QlKhhgxHhfJXMMrXUih26C0e6S3zWGhHRjNVJ6J9n2qCdca7c/5JXuKFVxaY?=
 =?us-ascii?Q?DDxH3VxosprIP5mczqIWjFQsb37D989jaMMGrxPxBYRP2yH2WuVtYvdFbAMm?=
 =?us-ascii?Q?cdR59CLpgIsok0TUIdUQm7R6Qy58QgAQ3hg4q1/L5XraDaaOw3vBGKn6G7XD?=
 =?us-ascii?Q?+ReklFvMMgOZyK6jkcGHl3pF3Bw0rKY9nEEyByPkPGyZDNgauUDNqFPURSMh?=
 =?us-ascii?Q?ZMJis1StT4lxvsAi3rWJwUeGJ+1MSKXBR7zM+YDXx2Y+z+DqdatTTG0RN309?=
 =?us-ascii?Q?1vu761YETZhU2N3ulCqgD1RhZ8Cf45nb8Xqf1RYjvsxCgyWMidm60rgCruan?=
 =?us-ascii?Q?Mt34rNuzYMUzjI2h4lQaJGWp5OweuL7kGndsf1BCdjCaumsL1TvcxhOVVeg9?=
 =?us-ascii?Q?6JJnrYqs0XzFK88ZBaAmHL5n6enmthkrAn0ZH0/ikF36/6EkoAHK/qk14RcA?=
 =?us-ascii?Q?ZkyYaiXEhtL6GKV+rbaGJEQA0bB4hAV2XpxUSU0ecwUJOnPQyx4pIHIlcfi4?=
 =?us-ascii?Q?L9pLpr+enxkinwibUK4mEyNlo73SmIQ3JODDTBC6l44tQiXEp09jr4VoCsIY?=
 =?us-ascii?Q?WRJq0gGM4uF17vpd6d7c32VUn+sEauRYBD/UbtxFIzB1FmxVVmDw4AYRdgsj?=
 =?us-ascii?Q?DJDIPDC4VVWmQBRghnE3MkfK8waIkIv0B1QXs68MP3h5pBtu+g5vqzgAGm5G?=
 =?us-ascii?Q?dywScUvovrpJKCog2QeB8D+I/7qAww85Velh5DM8rQXiqAMlULZTXhgaDQI4?=
 =?us-ascii?Q?b3tfiotz/JLpqDWqCvOzLSaHYjN7cX5PjgrzdySirCjSDJdiZM6vuTVHuMLj?=
 =?us-ascii?Q?DdmQYzjVV3IRFEt7CjnRGIposYYBRgEeNzBF8G3PhF8/vMK7XuJuEYs1q6yV?=
 =?us-ascii?Q?4zKNJIrXTMn8U90e/3hic1GpfdDoaC9Xf0CMN/ilfXjcoH32ycrXxqueR6uy?=
 =?us-ascii?Q?z4N23sNcdGGCQCTYmQJsrtUD94GskjrlXr2bGk8m5xXswDeaaKARD4RJkHW+?=
 =?us-ascii?Q?vYlVVwYXHV8CPqEPQld2sTWmS78IEQA1rnT4j0wezumvS5QgKxtQ2T4KU2hz?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c43ca174-7c08-4fe9-9d75-08dcbc49d8a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:14:13.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uO5En0VEM7s12K08rCpm1XJmxPiYwMkcdWdxXw3/eXCmWuW9h/ke3RecIFL+9lmcmwP0Yhr/15v97F5Q4+kdkEUuRx0CVuRmezUzKzZ+XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5709
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

Changes from v1:
 * patches description was updated

Michael Polyntsov (1):
  spi: soft_spi: Parse cs-gpios only if num-chipselects is not <0>

Mikhail Kshevetskiy (1):
  spi: soft_spi: fix miso gpio property name

 doc/device-tree-bindings/spi/soft-spi.txt |  5 +++--
 drivers/spi/soft_spi.c                    | 24 +++++++++++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.39.2

