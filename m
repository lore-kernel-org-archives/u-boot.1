Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B2CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 02:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F45848DF;
	Thu,  4 Jun 2026 04:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YkhQT8e1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829E6848F0; Thu,  4 Jun 2026 04:02:36 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE50848D1
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 04:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHpbYLHrwroWvZDa5bdNx5oQEAJSFgyOPBuiAcFyOVQ0w8w97rqXjIiJGNEDQ+SIT4Gb9b6Lvo9wjOMfNDX0bRigqHZwf53Wz7EoJv2xMLavr+HzEqs84YEF21WVUAMgmAJihPcwdZ7vROmuSArchZo0RpexiyI7gblmVb8qzX3C9FSVBYfN+XigaWC2w0OEf81k+eGpXZQF2g60eUOvglat6eSyHufFeovjo3tg7p8k+PPBLpNFJAyOstCKv2Sl9tKP6EvtLdarPuydPVKo2zwmjpEKQJoZZTsDmXYdUCAUsLJNzZBpEunRwTgzFArnkAXArUjAhv2Er3W4nLxU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8nB6sRdoGv6lT8cFUhD5JobB+R5kp2ltCe4r/GDbTI=;
 b=fNhInzTIWYKdxgpoD/R0rbAsySs7+d3NLOyJSlWtqqbL4ThtDsu7ZHM1MGjdQQn2ZYg5gEp++O+qrb2qomFiDD9+ZHmRaSSW5LA4CAA3B3VIJcFWnJPyLL2EaSNcsRl4QbvdEoQpKWt0ZpgPtvHr9McF/oxZv2WD27v1s+Z7cLn+p/Zrz3l4Esm5uh/zmm3h7UjkDogRxhVPLpyaw7KFFb51AbuJaUJW7Gg5+HL3fdZpzbZv986Uak3R65kpsAsw9yspKkvPA/ar6RONScdfTuYasSoAgol37+PuCy7RRdfUP7Wouxk5PsoR1sam6ZRost40ce9DjFl+9GxY5YUFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8nB6sRdoGv6lT8cFUhD5JobB+R5kp2ltCe4r/GDbTI=;
 b=YkhQT8e1TSDl97FUeJlmTKad0rj2EuVgqpqidArRhTIKpmpWJ8qk35PlKVUrf86939unfD/Mbpi4UCclO5cD4Iq1FoSMRP+wP7IsywYtn0CwPKVboEe+bYNWy0KFcmPTMQRIj5BMCghtaK8Om4RWMkXKwquQhSaHhqPmnVbHPpn6RyUwvbbI0GKgI07pZ5ZkppiW3avD8z3w1rZ4h6Hv8YkWxtEUi3l8dZkJQsjDrqVibgY9Efow+cYMzL2A+4kvc0bpacZn3jhYnTqvKXmTREvLZWmAUQhsyVjbopXBzzVd9VqB6BJLJvggPLvLIDdXHCRkb81m/oo0VHhQSruSqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA6PR04MB11803.eurprd04.prod.outlook.com (2603:10a6:102:523::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:02:33 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:02:33 +0000
Date: Thu, 4 Jun 2026 10:05:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH 4/4] nxp: imx[95,94,952]_evk: Implement board_fix_fdt
Message-ID: <aiDdci7zTao4psWZ@shlinux89>
References: <20260603055159.414338-1-ye.li@nxp.com>
 <20260603055159.414338-4-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603055159.414338-4-ye.li@nxp.com>
X-ClientProxiedBy: MA5P287CA0309.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA6PR04MB11803:EE_
X-MS-Office365-Filtering-Correlation-Id: a23862fe-dbcc-48e9-f01f-08dec1dd573d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099006|18002099003|22082099003|11063799006|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info: IoGaP1Pa8i8yoRTs+hYfJcqefZvTHxLXdwbiysJlWmgJaolnEsMZPDZTIHuJWZRlLYCjLDu64t3SgWF7NPB7fpup9W7NTzibvPiHNHJwKBAcuieKGQnCPjujA5g7vpvVxBm5rTaobSoHh1D/NyhMPW6hvqI6QiMuhsHKuchAELK1qCorSpxy3uAEM8jaijrmEabbziUFj3PGtSY+DC+p9Xui/mrNpbb/A/N/ttiN3PaDrSC2KJT/vSX018v90cGGQf7cLzAKK8MasaVLAkdyi2jSzvSM+F17OuEbu7vBvAGlw0Oy68L8sx0Evt42Lhhu4jnAcQgxJ8jkNOrotO8TW+kT9ntJjT9+7jq2/y+fJRNSY/VK1kiJxAcKANkmiedPvonI3lwlXDiFef6fWyoB5vYtVRPo4CbcZDjlhzK6hXxNZx6OlGMqMkaBYqcQOUd92uzyJeNESN+Rqt1ActXPbRxuTkm0P+CD6bhFz299MquS3lCaJtnKjWQ+mOlNB03g2tCZrAAuw8xCtRaX9wDxbfedGpScK/XYu/Hujlweqa66rE69MRBRileLoAIgh79TJ+5r/JFqFEXd92o2WNJ+U1EP6++9uUI2z28/Jdk7DU7TZL2cFz30Jcqvhj6L8c+IDCZpuZd2upV+eQFD5xZK4dBLl5Cfz2hHVFX/xUNFuFTwDu3bY6mnYy9JokLimriJMrK7PdbkC38KnhBMdZT+uUnoffpsOkirpnQQTRsV2iuDzaOPR9BXbeIuHz7g6tZm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFHa+VJqT0DN18QpCOi1yfsCFJkjkIfRb2UcZ1eJt0QHGvtZgijm65H5G65n?=
 =?us-ascii?Q?wyTpZgD9FWOSCCCdJWbsQ2o/s3RUm9/kbDPtBXQBz2S0oIVUdmgbGIslk5Uv?=
 =?us-ascii?Q?+n44bVBvjC5xtJnD4QtiIN6WO/GMZD31GX2BAXAgyJZAHIUhyWdUoExhMgPk?=
 =?us-ascii?Q?Sp1mQa2uT7hYZm4/gRpA/26CEVOFh/4LP29+O42hzyHHQryeoAjMQwQj+U1X?=
 =?us-ascii?Q?1664jHZQYal6Q7s4XhHjOpUGcDIOi8N3lqZnQZQzb19+GUX2XBgP+APtX5tW?=
 =?us-ascii?Q?X1CxJ45zATdoX6P7IA55xZNxu5lXqpZNsZI6hax7tuHmmsIP40V+PaEnEPYL?=
 =?us-ascii?Q?24IWJO7ofOCbRcNctvZO0UlcTOAs3RYzEy9H+WIPDB5OCd/jO2cN6iZ5Z2uV?=
 =?us-ascii?Q?+noh1V1RacgJ5O2ADKUvQ+mIG2OAg1JV5+DMU3R536JgkgEpx0tkzmgB6gjP?=
 =?us-ascii?Q?OONgbpDjvvtaXJfYKO5tsHnVMQEyFla9FlqbWgKUjvPfMX84r5I6alxJEqMf?=
 =?us-ascii?Q?/JmXW4gQn/DVzns1Ri2eyYvC1eQjjWK/g+I7dgiW+D3Uyj4lERkNHwsCeb/g?=
 =?us-ascii?Q?YfJ/L+UV1vBoujEOyv8Wnq6avAGewFimVrZGubYZCW07wilodjdwotEAAJ6G?=
 =?us-ascii?Q?eXzr6gD9PH6zQSJ2zz1oZ7MGdftAjc/6IATHP2Eizod5sAa/qUCDIPEPAsXT?=
 =?us-ascii?Q?9w9/HXtrD5O+S2XdU5VunWW6J/0ZABt6RDN4KBUO2fZssyw8Lx7gLokQXbw0?=
 =?us-ascii?Q?sorz0J5kYReLI9Hc2YmPr2CRwFkeZDSIlCSW84bFobTaNOERMRGSBWeu5sbw?=
 =?us-ascii?Q?Ds+WkWrdQa87PwIhruxF4GktLQyHiplE0jcoesHV32GSFTxGwg/V6RJPVDii?=
 =?us-ascii?Q?+VC5Ouf7n0XEznOobZLXDkZTCzhq7/4/VTMWgTbajA5stAhL91qYm7jOvD2T?=
 =?us-ascii?Q?uIp+fVOcHQ8cSRn+MXgYBZW84Vrtm3xRW4XBF30WrMg2KLnCBU4EkJ87Pj1R?=
 =?us-ascii?Q?zxE3KPZ1j7LJHyuzE9KUsq7wcH7c5yDBfke1NQmZm71sJbCvEQyBCfbirWwS?=
 =?us-ascii?Q?LXP4yWkI2lLYYDQQ+A/6zpQn1ZfouRp19dqMFEQqS+PK/9iDjZNSYK3PoXtr?=
 =?us-ascii?Q?y9fCkFXPYeKeQ//d39XTdrsI0jbfjgHqfYUtZDsDJdIenbyrICAbw1IoDK6u?=
 =?us-ascii?Q?ztekleAR1tY7dC3J9Jz1RkABVIYNwI+K3bnrsLzIYc2urVHtx44zEEw+ZD8h?=
 =?us-ascii?Q?2GbqIOJWDMQR3D3zuqE5H09/HoEQygNxBRxpwbWfqGfgF6z9/5QpKBeymCci?=
 =?us-ascii?Q?ePD2wQ1VGHpJB8o6xIuIu1uPAxcSod2YuPZgQ6VL8qxQleP9hAdDQJc1lJ2W?=
 =?us-ascii?Q?I/qJ9Oas9JbM+k94bn7mFOuiy2+XbRtwWKNY83jgFgGVLqT3iz3w2t0snarO?=
 =?us-ascii?Q?BboshgAWtm1+smGviVLwRS/Ihs0A+yutVZZeGnHOdZSfRFY1yJvQFVqsHVZd?=
 =?us-ascii?Q?L7zBAG91vkFWB/QmryvpybrrBcOoZfJejutVSHOpQI0diuolhZMmXC4B+s2f?=
 =?us-ascii?Q?fiRR6Eygy6kHcV+PDZndXqETufj4J7hHVdtGPrR6YuGM/3r7hwqeKHT45yIZ?=
 =?us-ascii?Q?M56IDtf4gkgd1gsH69cJKxnwy5z1yp+3C9jeUDNaASk2bKHLlrmLoAAQCVDW?=
 =?us-ascii?Q?fRDedAge2Qj15CB2aUX9JFyG5BBEJPrDtZa9z0skalxZbAHwOIPaEtnidcBx?=
 =?us-ascii?Q?sJNt7T2XrQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23862fe-dbcc-48e9-f01f-08dec1dd573d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:02:32.9658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N09V41awtn/FaCzo2V679fKRMrSL4dSGULJuefE0P7OcCXgg04dPAzhoi6pdcGcsl4wUcPmUofGihWrEDejMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11803
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

On Wed, Jun 03, 2026 at 01:51:59PM +0800, Ye Li wrote:
>Select the OF_BOARD_FIXUP and implement board_fix_fdt in board codes of
>iMX95/952/94 EVK to handle fuse setting on various part numbers.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
