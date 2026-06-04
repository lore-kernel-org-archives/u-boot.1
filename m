Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D09DCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 02:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BCE848F5;
	Thu,  4 Jun 2026 04:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KkBHw4km";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BE284878; Thu,  4 Jun 2026 04:02:20 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E29D848F0
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 04:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giJ5+ABm+IaRtWvdL77JSlbhbvhpeVIFP6E5Nn+TvnVK0F09Fk9rnhT61iWA1nA2nBn5U/6Aflhzs99Ud84QZB/1UaaTBvasGIQUi5QGQtoTZUHV1uee53SoDbjodJKKLhLLjQG90KDLGaUMGenmoPcSm2wdG6lkMXpEDLoNsIgdIt+HlJ/+Eo8DXogU80ns9VKj8MVHb5eJfQDaJ32Xku4fdNXced3+6zU+htcZnqgkHmZAQncxOEqmu64ODsBJs33X2uFcMO0bMn9rw+zz6+PlBlf4X/iNLZ87q3FdJ3IwnciRer8hPsQvPR5AtFJAk8WIWlXFUoJM7qhY5yFtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9rQnHI4mgayA3CylLFFF66iBLPGOkCD81UEHZR8StQ=;
 b=Em+K4ASAdPzuYBB3vaHPbxO8LR6tW/ReBrPtkyZrcEzlxb6IbxuYyGowQKW0jQxy5Xq0eHjHw/kthp7qmfNqD6nfYS+GSiaYwsvRHzBG+PfYaIw6iFxXOlluJHSUFq0Lqp+zVB+XUEYJ/ZXdhXL9Rkk6kzyOFauPfIr6yi6cmhxEtrtbUjiebx6f6v5QxyQqfmtC/WZuqjblEt8qzWVCkf98hSTf7krFa7pk45+TXYrlOe3wETmpSBt4eG2EawDnmrsr3wWFLVVwk3ScP7vZf/evs8edl7Se19Wsx4Z0PZwD8hRA5lU0sWimrzKiXwnw1+ncX5EZixw8jJiHT7yh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9rQnHI4mgayA3CylLFFF66iBLPGOkCD81UEHZR8StQ=;
 b=KkBHw4kmCaO+LjM1XuVHqB6UI7ow3LDC9cUbhoBCAi0EYh55JAFdkt5tbqSTottWUWty2vdZ4v6+sUBArM9RcEB4aAfWS50nJ8n9m5m4DHFopIkz5NOl4O527eXHaT6pk6iRnLh7tqzGaHpCHRfpOKD6AX8v/DbapTIOueVL7okOp99UXvVUYqDifbC3tJlfaHs2IofTcwCFpw4DaDJptfY8TcZlwX34QtDvRFEaWQqv5QGdDK486PiaSFuNsElw5WraY5ZrvGeZDiuvQRAr8XdugzQZZjzacp00jt5C+p+uO/3LFIdMtuWsnzpksTvrwQCcpCsyS35ZASFgDZDwJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA6PR04MB11803.eurprd04.prod.outlook.com (2603:10a6:102:523::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:02:16 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:02:16 +0000
Date: Thu, 4 Jun 2026 10:05:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH 3/4] iMX9: scmi: Disable fused modules for iMX95/94/952
Message-ID: <aiDdYPfF5XmN1FNJ@shlinux89>
References: <20260603055159.414338-1-ye.li@nxp.com>
 <20260603055159.414338-3-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603055159.414338-3-ye.li@nxp.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA6PR04MB11803:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c39825-65da-4602-48b5-08dec1dd4d31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099006|18002099003|22082099003|11063799006|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info: ckkS4BJa4OmXDoUozAYqnygmq3N3wav82NX7k3zqmvFa3227zvfYu3nWaMnEjwFDMwksWtPeaJ89ciJxDLKti2O/4SyeB0OjGi8gBSBzFyPeykHmu/0FNhtM5w7jEmLE15WtkQ1iiXsKaaWRlH8w/TXv6h2LsPApc2zpp3NY72ffqI6+27ZQKxFyUpX5I52WOUQipQEzldNwutdQxYjre1i3AUCQhmhDQy0ccmz4ARiPpuOqYdRpugBOFaWTFtO9SddFBroDJ/gMv0VNmBdlXgWpcs1nUf314/jTfpNMyZflJIaRAGZiOYjaEGVOjc+Vya+1NJOoTidjy2y5zYhtMCvYpvJiwQTjL9zXnNDA7I9bdLn173feCYoGzawxmaVVU9CPMHoLeu65LrpBnRWJu5r9ph9oyXgt5cn38hogbRIH0j2hXYzmO7djA5PQQMn+K6ZxkR9QJAJrNDi090gusHkBhm6YgdyXLTk4fLX9InkZWvsm9xQG40hc4oqbMiJpeOJSg1hdVeY4a5/Y30o7+JzigGrvb45414Hlc9zxmZ+brFKW8MFtDjD6Kcyqv7/85oCwoVOzmaa7+cwDgrdTt9C6NNwrjCyfAOhyBzDhPUDktTvlqtFxiETcJQNW0o93vHnW2h8xgFPXHwwm81xVQfn8VL2HzhodF6Ur3+flPEjp00MRa6TQdT46c7rnwQY0UvlDKOrstwFxJzW9RZO+cETpQiM2/FjXgRQFjkgn2fxubl3cuT76B7fOmdiZ5foN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sk8vvuMVNL8ySg/83FrlzfMJcAlLfvQYweM+g//7mhLdwfSMvDB/+W47cNN?=
 =?us-ascii?Q?825Q9507aetmFczrGccnvKwwhNs75WoLKB0kSV0wjD6p2vzLSexgBBSj2u6z?=
 =?us-ascii?Q?1CRjQHFJp6CPK+6JTe++dW+DSfQrLxUuiFdmpktTiFJgRPZtvxgM3hDnITVu?=
 =?us-ascii?Q?5nQ+tmIIqyMeSQOVCUwPBjWvlvbF++1jUfXu7JFZNlHknJ9bQHDe0WAM5X2c?=
 =?us-ascii?Q?IGZbkzpLJXlL1s8/s7qKPt+4QU7OcR4vDY4fEEc1kh9u8aMHlywCatqC3Q36?=
 =?us-ascii?Q?j8uz/er8HQxftpHD2vb2TFQF+tiAOVR7M3SKe2xXYJjj6ZtCJ2I6DhIxcPNo?=
 =?us-ascii?Q?oKOXT4XEivd0ziGi76Hk1IVxeIsfQBOSJBU59k3cFQkpIg0lv3Uq5oiqP1eE?=
 =?us-ascii?Q?WANGaZAZe1vByO/UhNMZhYS78+XsfdEiKWB2kEn0vb4qBsbfssRA+G35+vlX?=
 =?us-ascii?Q?/gklnsELgObmMDAM+DzvSA/pOkzenjRgT6R9ISZkI6XA68WkS/RiOUjpX6UZ?=
 =?us-ascii?Q?Nt4IMTi5LE/1PB4AnMfmhm4P+KjykIrEHvf1a4NbQKB6FzBDPxGP7WZ+Q1P2?=
 =?us-ascii?Q?mdRJaRCxGXHPHMP5+MDse/pfjQw+XIbgjzLJIrglMYT+iBbA7fVj3grW+lOI?=
 =?us-ascii?Q?DVJHSYFEkollq3FMGEjLpMGxG0G1picp7FDBk/uTWVRh0fZQ/QKbKgHoT+pe?=
 =?us-ascii?Q?qT6L6yP1df6fkQWvSLi1NtxKyonGsT1GiJG9Z/dhYhynXKe4MH99hDGYWJn4?=
 =?us-ascii?Q?+sOaEK1b9x2ai4uV6koZVMOcXg/+mlAZiqnaC4QNUyWETKQ5eE8Bp1cJP1AY?=
 =?us-ascii?Q?goambS4ca3fsEcxue+yKVRir6/pNgZrJm2oqqwD9i3wYAjp/+zH2mUoGL1DI?=
 =?us-ascii?Q?ZMWJoTZF63hftwLy/Nbb75bjEPYik1YXFUUNm2pQ5VFjOppyX56SetrvSAGx?=
 =?us-ascii?Q?BEbG1asz+7sJ+cx7qJQuRlEZHPkwCMNd3wx39V3GR3teP3ac9laDc+hveXiv?=
 =?us-ascii?Q?IRJyU9KOXWtODZFQpELmvTsjndgeubyyD4XaIRiaQr9wnPgJd71AhNfOoq8H?=
 =?us-ascii?Q?gE4WDuIpOCYUKH4ofckj2QsefbFpY4YX2+dsswHO2jxfil01dVb6Cw+gQpgV?=
 =?us-ascii?Q?xc20uFvPb+MXOme0K3+HbuYq6focNUwCOakPoaQC3iEgTaZMwv/SyYLua0+Q?=
 =?us-ascii?Q?oo2aSBKfc949kqaF2KQxscIt+CcfPfNnGEXtnHuxrjgs5quTg0cNdclprp17?=
 =?us-ascii?Q?C/MX+08rH4eNCn6eGQrLQFHbxMEYiBzQiu9Px4euhpCkSxYDOPMnhkwGvNdz?=
 =?us-ascii?Q?1iMkbOGVsy2V/4pgu+/b9BevF22+HbQPq+OMuHd+vsxTqp8KyVXOxnCknNQR?=
 =?us-ascii?Q?EUNtNbhiPleNwXvisfkpuG5yGGr79m0HOuMm+0p3BQMrXptqB4rVfUIRQ5DO?=
 =?us-ascii?Q?zJSw/rL90opEUyDgRjBFXzDDYDnpoJQ4M2yqahBvcbSnlDx5zCdEb5d9df21?=
 =?us-ascii?Q?BQTEre/TUzxuDRl2f1U7xY6TgxIuobY+6x2TSay/g86yqjlnM/yUhM4CBlZU?=
 =?us-ascii?Q?WeV6Kgy/5KLhKxEz9JkVfQKZHvw3zg5mQz+Rtudekx9eBa0n8zVfq8+cCFg3?=
 =?us-ascii?Q?1xsdPFbFNH68/vepL4vh49iOLRY+/bMxOGDnrB8MZvmxQP8uCA0Am0VezQ7f?=
 =?us-ascii?Q?xDu4G7QHT/NUCC0G7xV+3r8fRAYsh5QhxQ+VCYsqEWrRiXsYJReouSKYAwlu?=
 =?us-ascii?Q?mmsyur1qUw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c39825-65da-4602-48b5-08dec1dd4d31
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:02:16.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhC0ACqxklvmVs+baf9VOaR7UuxQscSHwxEP84ZJKpRYrv0ihkNhk2mrhUnulvbSSmcO56gXmeYATyipilfCMQ==
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

On Wed, Jun 03, 2026 at 01:51:58PM +0800, Ye Li wrote:
>Disable relevant modules in kernel FDT and u-boot FDT according to
>fuse settings on iMX95/94/952.
>For u-boot FDT fixup, introduce a common function that each board
>needs this fixup could select OF_BOARD_FIXUP and implement
>board_fix_fdt to call imx9_uboot_fixup_by_fuse.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
