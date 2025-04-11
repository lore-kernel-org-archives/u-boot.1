Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAAEC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A82583F86;
	Fri, 11 Apr 2025 10:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QssPMcyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1643C83F80; Fri, 11 Apr 2025 10:12:28 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8CA83F61
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctRIjzLUE4sCYxMiCTBPxzV8Or8ZIiP3ZvcWbqP3ryvkfgUrdqYcCaV9Sq/FJVcPE7nDtNDn7YX8a0fgw9Pfq6vegewC2b9+366O6PW4Qyni7Zg3RHN+Zzc5Ww3GfsozcMcNOJjyASTam29twaBUji25+JTH6yNAz/TIff4fNnWSIrOwBkQ5F0nke/jFjM9RgHUsBl2IPx6FA/CO1XYtFB5wAsGFf+1QysHybsiCpgX5N2TdOOlR19zZ3l+PF6C4y/+dwYRYZYMQlQwbFx0ib6IyV7iZsnv11LGYj3goN3HPFR8I0+7ksNhsFB9DmMtH1eJqi8T+pZddsLrXjFY15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stPZ55OS3G8WuWXm/VeHmISPokA59RT2W5W8YkTi8tk=;
 b=M7AapAOkgMuj5ZA1b1XIg9K5CzuWRyXAMePuA3prPujRj6X627D3Mmd6/hafpONkz/9FTgZI/ysF2ddUjYi3XJoSu5ucMRXNBl6LHxeTQV6/+mAC26x/hatH4B7Mwwz8RW9xjzRiHkGkVg4U0KORfEsN/g3xzPOHp8UdEaaEQnCrOQrFpfCgzH03hsCFizE1COHkjOwf3YRiWST202bo5UF8BnZF2y37UH57udzfG/59Qfv2J5bUwiZqnQ6BDz2Hz2HZik/CtzVMXmgV1fFZe3FLdZ33+zOVwQQ8DPbYkzGYNc/InVz/Z6xKsx0LHAWqmtuVxbKIyvRs/SWOsSnlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stPZ55OS3G8WuWXm/VeHmISPokA59RT2W5W8YkTi8tk=;
 b=QssPMcycdF1UjGD1DQUOR0VEWApH4g8ow5R8m9V6FetfGCeF8eKmK5jRaP1rOv653PBWBTTcpbUJGnOlv5GGsR+111g5qJMWIOxGGdvaTVehBvmnZLWJ1U7vwXkE6i8YRv/uOilpIq/pfkyGeel0we4GX9tN+0bn1KqSfuDd8f83UUksTUBkGaqCYwoWNgt+4dK8rUgybuUdT8PrF6eC9EmVlNoUZpfJU7lM7NJ4Mtgsxmfcg5OZDS9hd0uzDOaK97teg2/Uvk7/NsnWRCWc2VrEqkf6N5hzBrqJgrgiz6EC3agdcxV8LmJFyMkDK3cVfFkVaqdoiWRyr3x+av3nKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Fri, 11 Apr
 2025 08:12:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:12:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 11/20] cpu: imx95: add i.MX95 support
Date: Fri, 11 Apr 2025 16:06:54 +0800
Message-ID: <20250411080707.602371-12-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3256dbba-a256-4ae8-d376-08dd78d096f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XkjPxBVFUvtXEi4XGVHc2YKEajoSS1W04bbZYc/wnQtECxSHJ2LJapyVtPbD?=
 =?us-ascii?Q?NE9EB0krGLCT4Ce0FqrdRGOoC3Lnr0jGqzvtSYU2NaVypYxJF3Txc+ve7mKh?=
 =?us-ascii?Q?Q+d+vUbFk/po9D7h9zuwUVlxh9cghVbrdJHqpt56gv5XT7/zLefm0Sa831J5?=
 =?us-ascii?Q?D7Ki69GQJYXCEpe2Ih/ac1FTU/TY19uvw2FkC5AIh4W+rSQO0FUsugWHQ6JT?=
 =?us-ascii?Q?XjDXNmh4g+awY7CRFGbewSDU7mAyJ+aAhjm7xkGesVOB7PgB9S7Gz7LGLCnW?=
 =?us-ascii?Q?y8Vyi6/FTHN1W9g7dPpLWX5Nd/J9DsH079aVKbTVMd1+6M8gk9sk2PdcT6tQ?=
 =?us-ascii?Q?WZgZiOVbQNxcRcUKDyuru014bxBwJPopQVAEM5750H/X8+UykiyPfcAEvyIH?=
 =?us-ascii?Q?+7FQppfT2m1nZuyp5bvVEotzB4PDGdO6TflqU13rIysg3O9S/jczJVpByU/U?=
 =?us-ascii?Q?Schdi8xDFwyy5ZOK23jmH8cLL7yxxvxopmppnIgZPEdVQzKDz5zWum1M6vYY?=
 =?us-ascii?Q?tDsoY3ue989vMCU2YN7Gogs4zAYD9r5NEgVgpDDwR5QeZfx4akUXSzLDEYkN?=
 =?us-ascii?Q?2BTF6jJVhfwevqgh6ljlDuwX9do1ym7g21w63bDrkJn0BqGzyqOw4+8cGc4m?=
 =?us-ascii?Q?ihcAuqt9IZRDYvXs0veCeqeIkh6lNmlY3pIqaTW3WjBoOSnUGpFpwTtPvJCl?=
 =?us-ascii?Q?Ud3Ks0vfTdYPaNGh1HWA23bZCv4k/FxyDCQAhy7BbzC9BP6GRqSJaM8tB8OJ?=
 =?us-ascii?Q?Ga9jmo+7ogDe17yADLoO8YmG5aKfsnk/xsZaoSUS7p8vYSxd77+ked9x0xgX?=
 =?us-ascii?Q?+j3eG/S0O8ehRQ7tpUZ5s+j90tDOh/QIrl3d9/GhAwHqBjbuUyYJ6LfhbJFM?=
 =?us-ascii?Q?cvFOCsxcxsaafQfbV2t7aFT8F2wEeWOGgzfZsLaRus6KlU8rJqHs/OQSgUof?=
 =?us-ascii?Q?BZjZxxui4QR8PA9nNbUPq4Z+dA1qMUUUnQB2U2d1phtqboEhzOkDzgMD1L80?=
 =?us-ascii?Q?oPbINsRuEG/JG9NahgbEkuqmA/Bw2ELLXyk2jW0JCP8HtgZa9cf1TLLv567R?=
 =?us-ascii?Q?oqStYnuJ5kvsVNlZ2nM5A7WixkgLpnQMlWJsH4UZKTESbl516XKqodGfniYr?=
 =?us-ascii?Q?+iXrf5gqPuEFVIpwGm1qNuVjD1AXaSVTCul5kfXEpmGOKCKmbSi2B0Ic01P+?=
 =?us-ascii?Q?0YOHlAqcazfvKdnffvNT82mKTGu0uMDJw5Tm1beapnbze7z2JzvLkmc6nl9o?=
 =?us-ascii?Q?i5QMa1r9SXRietsz4LfRTVu/6y2YCcWSIKalAdNTc/0EELYI26hz854Zn/pi?=
 =?us-ascii?Q?AVRH3lgZncFKmibx0+rzHPnN7SxqmqgUrPsHuteZO9m/UqLq9WPItI3+sshZ?=
 =?us-ascii?Q?4MbAXVxxK40GzhuBZW3Yh+8jmCit21An05L1cW8uAdygAC9aDEu6j2a/7NKw?=
 =?us-ascii?Q?8lYjRndkheUuDEZZZQOOIf52vpAUWuz6H/NvvlSExVGld0L1HVwOyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1wNPSRa5X/O7IBeqT2aIfuDyBxzVdWuFXDONLzBPJnzWC0pyyaJ2TwP+ZIau?=
 =?us-ascii?Q?EfpnmevxkMfIM5QtvQRSd6ADhAdv8oCpoOC/jEZjgEntzddQauAtjfegRvCn?=
 =?us-ascii?Q?45+O0L8BaUhq5ecbpu78RGQQ6gfzJqCV3HI6/eH4B7poYYVXgd8fopVSvCA6?=
 =?us-ascii?Q?u3UVmffjqtWDL77Nwj3M+2dVIyw3QXtvRZyO2PDhDgzhEvQBGddYCe/cPBmH?=
 =?us-ascii?Q?G9uAU9a8feQsAr82Cha8KXLv60zO9hK2ZZIHPUXACD+7+ZaOJ635MYMmh+0Z?=
 =?us-ascii?Q?QiFItDtrum5gNSRPEC8dDCp0sjjkhwwslWxTZMJyhN01vSeUT7SRnbqQh4ui?=
 =?us-ascii?Q?K5pyNQvIpEysUUEu0aMg1krfmf5F3+Qk9OxPNxLUvlpWQjeA1xfAagcZaigW?=
 =?us-ascii?Q?LFENY1Nl8S1LOyPIUyqyOcuvqnqNnVryoMuc+/gZphfZaKTF+fcccIyHklO2?=
 =?us-ascii?Q?WyCHkq4bo0C0CPMnYrAGMhheiN558nkJJy1c2zJ0bFGaWi+AamEyfPWFiVlt?=
 =?us-ascii?Q?9ew+fto++pRk91tG9lZeq/20XBGE51ym+RKpIG7ns0QJEd2cJ8K12u73LMhl?=
 =?us-ascii?Q?l/x43uwfZufuIQ9IcX3ogAEDFOi7AuGXmJjZTzSHDUVc2jCs+Bh/6+ZhTQ64?=
 =?us-ascii?Q?tvGAyR5PcHPufRwFO3tZ27utOrpYTa/NaZE5CF9zfQxT0UGGL1bpv0dsAeCG?=
 =?us-ascii?Q?soaCsEbFub7IGZcX4f858R76LNG4LA0VHjbIyNIxoWxqA+5e1HBZOkncj7Kw?=
 =?us-ascii?Q?WufFDu8Whmf+/OLYj7gvuGsRlU7buue17RB30gd235Z3wv2oMyG9JxTtDtPj?=
 =?us-ascii?Q?J5AAs7E44uez+PnGDxLthz0/EREO0qVG/C9k1Dv1T7GEDpd3m/YT1wjSfVsy?=
 =?us-ascii?Q?mOsv0zaVcd9Ih+snTcrEhbAs6gySj+ABBfb8AlKIC7sZdfUsvoA3l9wtAwPP?=
 =?us-ascii?Q?5mYQ06iARyWfiO+brhWnXFGz3D6+y8X7hThuNSWk8MZmVyTlDUUkhYiyqRxw?=
 =?us-ascii?Q?8aeefl9SnmA+a8RUx/UgD1FwOavSh6AJc9LPQDZ9Bm9k8hfvJxhVZ7mO77ev?=
 =?us-ascii?Q?pmzDezjQGzKsXwo7S8GePOewmme0T0/zC319U4wPleowZNUemuphGuZXMPcn?=
 =?us-ascii?Q?CP9Y3TTbX1xZkoTV5+ykS5RRCx+PTfaRlLIchcHJnyUkq4bBXO8VnblK/j50?=
 =?us-ascii?Q?4AUJolL5XdaUtdm+V/ShdChI4fIrTq3spAoEA28Sc/GLbiUZBtSv/Kd1DT5H?=
 =?us-ascii?Q?0Zfm00Q+t5m084hT9CvF+mMjXEXu+L2VvKNiwmeDIXWs3DSHWBu213FtsK7q?=
 =?us-ascii?Q?pIZtvTP5yYrgI0cVhaCaYss+zlhi4aGqpFpPI7s+nDrsezi32mNDlxJLjzvD?=
 =?us-ascii?Q?/iJQ+oJwn+yNwtsSiYpP1DTqS2qICI3LrYbHQVjoRn0QfxOwe0IfHUgw7IBB?=
 =?us-ascii?Q?QdfSkCRNOQqS4LBV/ZwxGVVboqd3MOpaGEJqQE5CGXw/9HQcSPBpWCA/UtE3?=
 =?us-ascii?Q?efXMlSIOnDX5WE9SW4Y+deMbS3FqJs1B3FZ/ZzOr/nqwfsOScULMMdbGYvX3?=
 =?us-ascii?Q?8rCcdVnJ0hNlqYP5hOVLkftudHPbZVxgfthLFH4R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3256dbba-a256-4ae8-d376-08dd78d096f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:12:24.2082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UM62ztfx/u8bJYs/zdOSqQkXdpaOXf6J9AfyfW9WnLK3i3JZ2SRQOXtlkKLsT2EvHTtuiuV/xFqX8JEOGntEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to add the imx type string of i.MX95 ao that the
i.MX95 CPU info can be printed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 4e1eccaa5b0..4836bddd93b 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -111,6 +111,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "91(11)";/* iMX91 9x9 Reduced feature */
 	case MXC_CPU_IMX9101:
 		return "91(01)";/* iMX91 9x9 Specific feature */
+	case MXC_CPU_IMX95:
+		return "95";
 	default:
 		return "??";
 	}
-- 
2.43.0

