Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D002EFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC08983BC4;
	Mon, 27 Apr 2026 15:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Zg6y2G2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BFF84178; Mon, 27 Apr 2026 15:53:45 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04FE083BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD6NFGmhtcmraE4+kvyDPiGgHl0x8TSwcHDwTvWPoucjeJagGXD6bINdpb6YCaCdZ9SZ0V9tipxe0/xfe/OliWZfSm/itDe33tYk3gRQtgTtWclyN7jex/7TeIMYx7vNogxrFZpKqjsQd71723Eb3SQLN8J1l0+cMCt2CLp+a9i3Yeu2oldZLKH6vJXWXLvC91jp8EgFeUTj8efEaoy6EAV17kWhwZ1/CD1CNBKmJqsyjN11XnzpuGFcDVU8xEBtEUHFnhMf4XYQ0Hiru16MSo/5siGvBOXp5b2QsrFClpnMhnUounqdZrMHL7DJ95JZxO9ZjtZA5bCRigPkLotAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx7Q4RFrCbGYJvpesgWsmfDiAnGUBARNLTP/RlrpYcM=;
 b=Dh0mCH08PDcZQb/9eU4uomApzGXNpUsnWZx9k1dS4CM0amDJqXP1zTPBu7UGN/95z65enXEY2jnxnnqyWkf4akCHCgtqJQY2vwAj08GBZISYM/8yHMVj/jdpIh3pnNXO7axjGenk2xIHST9o1gtPYUrgTdwSEwWog/qbe3O0owauojcH92hazwCisoaDpDcE6SoVlEjezSeetdQwACkASyvDYWuqKzHTH0JNNI0K8KU761JJ/DQKMB5Yg9CeptjjYc1JPDxOGQzn+u8ECG13nsIQ/x4oADjtb4m7c3dvcnBDnysYoLNhOiLyjKILVPalnF2hBgxv2p0/2yKWaSiZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx7Q4RFrCbGYJvpesgWsmfDiAnGUBARNLTP/RlrpYcM=;
 b=Zg6y2G2ljfE/oSZRs0ekLinCdOxx+R5S+amqShyN6s2yAHVO4xv6MfTSSv1ZPvjE1BHWMe6IVzlE7/FH2/aGJvu8HCBWdZk+3mqcFpxDxspyboSO5VkQ8DVLG/EwFpKLBPaSNtRtiF0hgM/Lzw5nyCpQWwecaRSTNXvwi8frzGRk/bqPNX6qo0oaa4hGZWgeynmmFK0WDloZvS0ZXp6PKuKGfh1sqof9Q3cnoo81MK721PkuBo8VTRLxAYr+W16ThX4EbGOa/r79ctzMJh7BzNJb+e7THpqrgGRC+oVNN+T3uvmR5Jhg+NY1ek5aEk2t4z5G5NcwwruYM9B30chxtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11519.eurprd08.prod.outlook.com (2603:10a6:150:2b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.25; Mon, 27 Apr
 2026 13:53:37 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:53:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/2] configs: airoha: an7581: disable ENV_IS_IN_MTD to avoid
 boot panic
Date: Mon, 27 Apr 2026 16:53:26 +0300
Message-ID: <20260427135326.773903-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11519:EE_
X-MS-Office365-Filtering-Correlation-Id: dfce35e3-0deb-46c2-65fc-08dea4646194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /ST66G8t9mjbDTmN4o5yb6/PIkuYv09oXkSHXStUrL5NVkXku/7/tTmqU36NFBQc8QaKm5QosQ2gDWI2phFTrF5azBRKNVD9EI7ZxXPjnTpYC8OUmgPWUfLkwXzBmeWENw/9vC6ARlpOSvsL3qCu+KPySXPbS1+31mvoiioFAPeo7n313tlblIQU9uJsicS/2Sk2w0J48zHgekrEKIWxtZFEgXGfDfxmJETGaKmTbbC7J0acq0dRTMfYhasdaroat71wDxsZuUO48wJtDeHS5AkHP+jVBUUZtXk61KvWMzJz7Eu8nYktKjJBeAf9uct/7cHM5LAJLcgVIG4t1e5bHUMLygJhXguFPrTjpTDQPkn6oA73WIr6wi+7tKLKLsZzu0f72uCu+yDAml4K5CwpHid/HyuEAC4MbZs5g1YRNiwVyiWa6NZ9bWmYDIIMP1BI9F9Kyxl4YLRIdMZ6b4rDUTot4In2fpN2n2JYzPErctekRS6MI7dTPYoje4G7fBrzyJ1nWg4Q7uHJ6ZCadgoWmzOFqt1FhTlCtSqCzHVnU0/o07p9DzRtcQXsx+0ADpasymDXS0dqXnfWRrspMY34gbQor9PzzF3lBGVGq92jAWOIua71vLmPcrevIzo94Qs8A0GPrluF+NxtZDynE/uWUjCyhwy6ZusCr947YxrqKeEC31nW6m9IG8LAQVbygzpZG2Zl2iWKtUjfd9aWItn3hqYdZVOcM1GpXyxOE4aIX6S/7aOvXKvZdk12H18huFKfDcC5VLeOrq1uLc32fsEo7EaUN5TPq3I6MTkRMXreIjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brR2XrqUaznR18V6qEgnZ7LhOIsPBG+rjGlAHJ8mcPgb0JnggVZRB2lFhOIF?=
 =?us-ascii?Q?CEH99/njYvz37UNMWXNxl6xn+YkBoYCn0mTMEAQi+1KqlQ0nlH1l+XMyUhu7?=
 =?us-ascii?Q?XTW3SoQnqzE7o+peVcSmLaFDAcpV7bSTeJb0JhFU+yfsIqXh3L9WEfKyG6Dh?=
 =?us-ascii?Q?9UsLljA4CqBslA4na6RKoJlbGYNBEtO/Tggr27SytGsBA4XbZkf7y2RUeN4o?=
 =?us-ascii?Q?5Ud61i8Co/5zIcSMg+OOD+GMpyi9CDwJnUPjr1psRy5S2OSZjixJ6w5DYm4q?=
 =?us-ascii?Q?NycW3/8yfuQ/63JM3z/286WsoUHfgWDM+qBYgwDBXHRdg+mckywCIZ/R3cD+?=
 =?us-ascii?Q?9LdRATQTV2qT1K6ZUaWhnAL/piEb9FCdtGFZ2FDxKHjSb4c86zViI/b8/nJT?=
 =?us-ascii?Q?J06aorSgLFIZIvBTZ7wHZe1CuM4J9H7o25Vqm6gf1VpM9kSzOUjnx78AfSYd?=
 =?us-ascii?Q?pp6cPjFKhEQam1ttslrN05HTdO7P7FfSSOVgR4MfFguZNDSHEE71goXIdNZT?=
 =?us-ascii?Q?S4R7at63iYLcYrQZw4iKLtrCiSpiQdFIAucpttgSJowwszC9tNLAlE4OfFH0?=
 =?us-ascii?Q?2h4I6OZVVIzpgyczePSzOYslteWknJcFBiaBBc5D3AfoNuLY9Xk1vOVZPgiJ?=
 =?us-ascii?Q?BEcuBni56l6j9aDmADhmoEN+WleCKPxWV+78DSyle9qbtUD+e1EhjPsQTo/J?=
 =?us-ascii?Q?g59zCJ+JJ0G0/GX/HOlveIjXqKv9fz+DJftl8UB2SdCqiQgleQLPKVB9ELC5?=
 =?us-ascii?Q?2XmNaPzHS+J5OjdRlcQndOVls+9P07hCvCX7oh+z+dKT31sOg0un4YQRWeFR?=
 =?us-ascii?Q?cTAOOgjHT1NrUzGdLaGSrhN4p1/5mWOwqHqg5FV1DikRFHobfnWQr/FuCJpm?=
 =?us-ascii?Q?7iwULBshrCd+f1jllVHhhtW27x1I2RGA9oLJUuR+sKeZnUx0OINQ9a4RIVdu?=
 =?us-ascii?Q?BxSVAA0E1443oWKulevhsyQMCO9FLYmzNidj1uaZDBecOlsnEULuOkjnft3f?=
 =?us-ascii?Q?YZmbeIKfZpJd6v6V4LiMCLwrCqijAWX9cFTDICGLcfHXQBcefjX9KZXgJF3I?=
 =?us-ascii?Q?NfLCWeV5sKwp/1OUUgGZQxvL7EDaM7tKsPpm4APmfW7kY78qbTELs5L/+aqR?=
 =?us-ascii?Q?6kD4AK6aF1EHBrQ4UwiT22dvp3teZh7WN4iZblaNFvPwa0WUvqZHSk0Dc53r?=
 =?us-ascii?Q?QesfGe7S+LQVVZ98hPF7dGFVB4eoxE8ZzvUhDxLwDjkJgjfHb8bVeQ5Rz99M?=
 =?us-ascii?Q?a0HkybMRyPgISUWYPHnE/rHQlVEqAPH2n+RFD59fk7QV/zXlgg6rNXZziPEZ?=
 =?us-ascii?Q?FKb0KPa1aM97xxApZrmjriMNU9gLC/QbEjqW6iTZ2e0PiL+bPy18JH8ih0MX?=
 =?us-ascii?Q?iE06L7CkvcFvg+84rxNhb6D4XNLFOnccQdH1jaTmn6TdAjFfL+7kFhl5HQtS?=
 =?us-ascii?Q?Im/lNflLRcOWdqe3RrEyUJo2rpEpFbNLulhylcrcRmp0BUtMG+fVkdr0O0a+?=
 =?us-ascii?Q?52jQEnYFU62xl9KQJjxn6WPp0kJAZIeUmd5xqdrl15faQmArG0NOQQijP+N+?=
 =?us-ascii?Q?LNMpGoVTLfEJNwkpoLOHzit4MSCiuHunfR6fTbix8MW2HiWfRjqxcGg9XYaZ?=
 =?us-ascii?Q?5nBAcY0UGSPi0K4NISKwQzwA/YjqrcgNcRBzL9dR0Hpnm7U/euq5BReNZ8uT?=
 =?us-ascii?Q?jlsCNacxvCXDvZikqRn6nMIT5cMFFqVsR+Y0JJZuvuA7olHxd/BohmKsJ/0K?=
 =?us-ascii?Q?TTdipWcaubR6B8XxVE6ld3P7NXWwF68=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dfce35e3-0deb-46c2-65fc-08dea4646194
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:53:37.6224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Wtb7yUmBBFLPlnDmewmU8BAEaI7+ajZYKOkNF3QzJkt6KFV6hUB/5teTA6IzluZkCv3wiT1o88yO0fgXD8ZY47g3oeX0DkGI0dEFHrw4rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11519
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

Booting image generated with

  make an7581_evb_defconfig

will results in

  U-Boot 2026.04-00924-gfb815bd8793b (Apr 27 2026 - 15:08:30 +0300)

  CPU:   Airoha AN7581
  DRAM:  512 MiB
  Core:  35 devices, 19 uclasses, devicetree: separate
  MMC:   mmc@1fa0e000: 0
  Loading Environment from MMC... *** Warning - No block device, using default environment

  Loading Environment from MTD... *** Warning - get_mtd_device_nm() failed, using default environment

  BUG at drivers/mtd/mtdcore.c:898/__put_mtd_device()!
  BUG!
  resetting ...

This happens because no any mtd partition defined in dts/mtdparts.
Disabling of ENV_IS_IN_MTD fixes an issue.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 16100d00f98..a0afe249ce5 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_LOG=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+# CONFIG_ENV_IS_IN_MTD is not set
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.53.0

