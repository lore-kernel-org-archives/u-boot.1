Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FECDCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 04:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFDA83106;
	Tue,  9 Sep 2025 06:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tFIg0IKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A63082A9E; Tue,  9 Sep 2025 03:25:48 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1FE800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 03:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyMy8pTgJU3Mow7QxKabrQAIKJ/d9tEJTJ+cn1+R1EZ4ShWNh9OGDhqLSC7BrFiqkzF4ioyjqm5n8OfJXsb/09oOzZRKRTtc01iZHr1vSb7tBPlj5hrJRk9Aog516SyvmFBNtu+chFzjIgzt9x9t2e+dEsY204Hkt/b9BKpZAY2ODk5IKc+ysSBrvXozFmq8rVblxlDVjoZQj8lV7Pn3P4iLZAH+gRobvDNxUiOLNajpJEWE+ZRAd488VsBeI6Z4rVz1WCDHUx9l0ZW8THfo9/yS1PiVZeORqlXPun7sn4q+8OIiQx0Y4QA2BhrRdO/3ketZQnMfAHFwMr5hMR7Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4ENNxpv1F73bPyYCfOxNdQ5dOLAoFkviUzHhebuTtE=;
 b=EsFIj6o32dUNn8BV5t7yHl/9m1LmdibOjxSrard8OK8RRrWJYzplKUHRcE4gAffbbzKvIyQNyvydw3q7NZksSND/fWygHzf+V/Fn6YSB8r6HfpPuzVvJOADkyM1GdRvfh/lzkXLPoB9ngmuwLDLXuZ9ufyC+LHRNQUOFjYhlu5tA5X42SwwlO45mP70JpcbGaSF4JQ1lI5zHZ+OVAaDpGG44adR4m3mVquKt+3bcNpWoihnDStg8PI6Kq0BaxFrPtfWU58oPlCkT3xjN14SCvwfzIrR4GXXMhr5dMssG7t/nQEBV/twf5s7nPgqX+7WbQ0vakWZumdjdKgcEqHLAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4ENNxpv1F73bPyYCfOxNdQ5dOLAoFkviUzHhebuTtE=;
 b=tFIg0IKKoSvQxgy/Vw1ZXmFpU+azfpDmN98556cxX9CClrTnoIAf7ojx16ObHxX0khN2ApQM5Pi5XnABlEoeRwYFQz0jz45gzoSmwSYGqzlE/z+Bj9Xhw+p8cA0bj6B6pMq2Mr7jlK4dx1C0tjjI6OaByaiMFDmQ6B3HUkakVLUV2Ey9xlRMCkyk6ic7QIIMOkkCLazFb8IDSbYklwPQ7kn+w82wTvW1Ip+tv88CWrybrbJDAXzvEEFBFhCSwmLMTOYSH2IOsS3qt6eKwq1E2XJVn7jjYjHNLg4F0SuLVyjOYy2sYcbF57asTikE9L0Z0RicG+SUlT4iri08HphDZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 01:25:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 01:25:43 +0000
Date: Tue, 9 Sep 2025 10:37:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: John Ripple <john.ripple@keysight.com>
Cc: alexander.sverdlin@siemens.com, andrej.valek@siemens.com,
 festevam@gmail.com, hs@denx.de, peng.fan@nxp.com,
 sbabic@nabladev.com, sr@denx.de, trini@konsulko.com,
 u-boot@lists.denx.de, uboot-imx@nxp.com
Subject: Re: [PATCH v3] imx8: Add ahab_commit command
Message-ID: <20250909023709.GA11150@nxa18884-linux.ap.freescale.net>
References: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
 <20250908211838.3772709-1-john.ripple@keysight.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908211838.3772709-1-john.ripple@keysight.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 69232e9f-47a5-444b-4cc6-08ddef3fcb95
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zntlQ2ZIU6EmMk7xOLDcVGi8uVC9lbit4pcf3BYhkQ6BTDakCGPpm8+Hp2uW?=
 =?us-ascii?Q?rZr8LhDBs1nlAcLvgy5URJVFQtorxo1uooIvmNYvUW9jQnUKvaW9h9IBfkBn?=
 =?us-ascii?Q?jUp2IHY9klwx44Z8id/1QCoWGG4ISSUcIlXulbAeJcgDR5UHfzBK7Ts6Mhp8?=
 =?us-ascii?Q?lcrZBMHkYrA6WY/+B6eXPqNB2nWgxyLaasU7yuk/h/WinbPzP+STwcWRZn7T?=
 =?us-ascii?Q?tKqA/tassl7Rcsvukr3GIuLjSJnB9zWO6vWjPaGr2+//OdN7d0mnNijKsGRp?=
 =?us-ascii?Q?Mvh0PXshObAZPfGJBxfvhpZP3004hQI6l3UoDX6I9aIHCmLgGDd+rdlGCwl0?=
 =?us-ascii?Q?zZzp64qDj+eV+T9DL9b2MkbLS1UQ8wyn6PzLKu0xBuIgzvvi67M0oZII0ZdM?=
 =?us-ascii?Q?lDQnadCpHpIqhLg5WSSlrZIVrv4fntdTX0CpQe7AmmwZnvFwrAt+r564v1GE?=
 =?us-ascii?Q?IrPx/tBQsYgseMm4uFsO1voW0O73S0Uy/VLvAoxKKm7Nk/+t5EZZED9YLVqW?=
 =?us-ascii?Q?F9BzBZoL2SQPBH705T/nHLD1w58d60NgsewsKd2GvcVySBmla3ngrNHDP0Pu?=
 =?us-ascii?Q?1QBi1r8sYs57gxeo1g5WvpSSEBtDkGq3dyUVkEPqB8OKHvGM/2wo8JrvXQty?=
 =?us-ascii?Q?r6/6junrcoPyfNR4g9s0QugwTHo0fYQl6U/+H0VCpkg8Z0KKYmvg8U78j8LZ?=
 =?us-ascii?Q?x8ITUu/1Sf90ket7zQzn5H6t01QZPCaCxW8MnQdD3ewvy9eMdALWWXPKjZua?=
 =?us-ascii?Q?bFbl9rC6Ln1gkEmJDzg1m4AX69rse2qPGPqGb7xEAX72qZ1QyI2hwh4EOu1C?=
 =?us-ascii?Q?pvlaPfrhTkT9w8ZFal6HhNiFTkRkZBXdITmbt6dpMIIGwJAho4MrdSszaEws?=
 =?us-ascii?Q?R/Wrwc5GznsihPSqBtDONiPGZTJx6M37NY+Q8+d+mkAIiiVcgKwQsba0nDQE?=
 =?us-ascii?Q?SThMX5yqZt6xJ6DyKJLxMv4JUu7YlsUFIViq36LTbkeenSSkw4DIGxm1X1av?=
 =?us-ascii?Q?EFgkXCTETIFNZMjVEsqE8XXJ/OowVsRyLLanqRElv5izVLtV0TKoWDO/CPtE?=
 =?us-ascii?Q?3BicQp6iJWY+SRlIiCo5DAgarD1y4jF/9GUrlcLmG+YvNl8yUZkMk92hBZHV?=
 =?us-ascii?Q?GDuXiZ9XgoJZufXUpsmSxR/YNyh1qh1p35+he6Md8XHNuqcrVcT5X101PgLM?=
 =?us-ascii?Q?4D9RZAgkkBeNzkMTd1ifXETubVpDt/3DngENctMGXVYghoXm9RefP/oHBfzl?=
 =?us-ascii?Q?E/XzTayQtEiH9CXQ1Je42PKJ7VdAMSx3ZMVltd1pwI26QTp45f6tMduJx6GJ?=
 =?us-ascii?Q?tbNTRLpLPOVSsseGC5uKPb9iK4IudiXCAdnE9tAfrUMBX+48Mmk5UsrhXJSg?=
 =?us-ascii?Q?pDKdcjbAZxhb3M7DacAMPd6Bx803lM/W6IB2N9JdUmWdD05OdzgliDi9Gh6h?=
 =?us-ascii?Q?GCNn31HCnHd684UR8UwomTWPCIgECSAHyIrx9/xFnR1ZFjowGVlbgxoAxRT5?=
 =?us-ascii?Q?FIdX+8PW4NSOP8c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dka4LeP6OJ1MOYNyEfM7zSAYCabXLpHxlWuO2HHWkZgg1eVgpCcimhLWjRT4?=
 =?us-ascii?Q?BCo0/uTYayjgnoIkhH7aPYOCIPCrmr9H5pLAurHWvL/yiKlJhBmdTd0BLUhS?=
 =?us-ascii?Q?LMgK4VEDWHPjewS2mqnbAKLHlBLIOcayDkODL8nHte21PdSTSevTDd30ctQN?=
 =?us-ascii?Q?MtxXVXfW9hKVqZ9yf06E2Qe/URusmVGw+tjwZEqNxhxRHWaoXeVQi1Zha7EG?=
 =?us-ascii?Q?6I7ONGou2Eso6wJGOFAyy+NvHgTADh8Ck48ZseNv6LopwC8oBcnB0OMrPFBn?=
 =?us-ascii?Q?asjaorejYJDXZqhwxNMGqHG0cX8BqSLFedHpwzLsIL5Fmf/xpn5b+7aB2bkG?=
 =?us-ascii?Q?yhwQB8XmsJCvpkyZNnstx1gkmTdeEvle1K5XWV8GRf5tOf94+R3kSkIvV2Fk?=
 =?us-ascii?Q?F6EhT2yoM8f02afLKbeqmhZiRytE+u2y9L25gpa23sAB42CA+7aw0WZ7rMo9?=
 =?us-ascii?Q?dt/sm9Yf4hlz9z/X6OagRM4VOma/sfoT77aR0tw5EAfAfbkQsQBEsYdlyb+c?=
 =?us-ascii?Q?jxGZvfYRcWajlSDAfFESaO07nCSJ8oPdecFAEnTKzjNYd2Gf1S2S8pr5YprI?=
 =?us-ascii?Q?K2ItzS+QWszUMf2SVZPQq0OjBz5GQYmFHEWHvZZcZrz9BHi9X3ZENyS1VbkD?=
 =?us-ascii?Q?dzxFQ/6erUr/knOd4M0h9CalVIGY6xjQebJ3P+BbUP0ioYivyX7b7vXeYlSz?=
 =?us-ascii?Q?w9/ltgchmRVQFzPASG4PpOLxV/xxFtimGi33jQndt0PXTOs/mO7UNirjT3sF?=
 =?us-ascii?Q?u7RtM/muOu2wHO4S0ojlB/RmsP4NcRFPjCT9iby9avjORCrThUrTpE611ALr?=
 =?us-ascii?Q?gvneQN291pA2R7dK0j4/DL4LopaCo8SuT+aC2BUxrJlCq66T/BZ70Q5DlF5+?=
 =?us-ascii?Q?nzxGyn9ui5rH52KYnR/cPTNci4MW5Vn9lEiXf2sr2rHkbgV0p4b96AMonVNB?=
 =?us-ascii?Q?qnd6/bljXDyYFF/Cg4f1sV7NVHR8/JnNbzgEWIfj0m+xwuYq29L1cHjNtgrs?=
 =?us-ascii?Q?GjdBmAya6+pnNeY/k6aoa+Ozum0T/5CZLNBFoel6SPEtu8HWv/r5NLV4k3za?=
 =?us-ascii?Q?PpUIFyZ4h6KLI52AVQeHOFMXyyp1oKg/pvtzJ+UuPrddWs1A6YI2Cs+HR90g?=
 =?us-ascii?Q?kMIlZngElcK5Vl/UR5/nJ5XMu6qEImGZKOzmnY804EfSp2LuLsXiYo9om46Z?=
 =?us-ascii?Q?rAgovGAZZiRXlNODr4IiK6NGc4qSZjBO5zXbcgxi0Q0BOs4dsLzMdoIti1E7?=
 =?us-ascii?Q?9u4y+NjJoQ514y+g88DxJjp4pU5zEuKhRie7CLAHxPvrNKaPtpAg6sPduZ1z?=
 =?us-ascii?Q?T+Hv7C8CkuFQ1kPBd9lTVk05COvSnMAftll6ss7ih2BtazFYBer/k3SJTAMu?=
 =?us-ascii?Q?xG9HwTXeTOXZ/FqJb2EJ2ne+pusFWq62OgmRfBnpz+uXR5EPAkHGv4IkZouz?=
 =?us-ascii?Q?Wf/8rBD4Hnm/31zFxI6hqSm2wN4K+GCzcIv8cxNcUWH5VqNdLk8jD0PANSf9?=
 =?us-ascii?Q?XUt1Li/wWC9DwoLqEWG30FD/QXIkeozuOROwqIHFKAx2YoGvoHbIw4GZPD9H?=
 =?us-ascii?Q?XXIHaTKcIRzQa/58h+AYbmzWqUP0X0v14ppljpbn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69232e9f-47a5-444b-4cc6-08ddef3fcb95
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 01:25:43.8671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1hlqGbAwTR+faH1BLXDbik8RP04APhuM4/Yxjw4dAi1I0cVX9gn5WpLwipGHVNTmKWnhH86eU5vMLbgGTAsbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835
X-Mailman-Approved-At: Tue, 09 Sep 2025 06:36:00 +0200
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

On Mon, Sep 08, 2025 at 03:18:38PM -0600, John Ripple wrote:
>The ahab_commit command allows the user to commit into the SECO fuses
>that control the SRK key revocation information. This is used to Revoke
>compromised SRK keys.
>
>To use ahab_commit, the boot container must be built with an SRK
>revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
>means setting the 'srk_revoke_mask' option in the config file used to
>sign the boot container. The 'ahab_commit 0x10' can then be used to commit
>the SRK revocation information into the SECO fuses.
>
>Signed-off-by: John Ripple <john.ripple@keysight.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
