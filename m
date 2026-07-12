Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BD9C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 08:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA5B8467B;
	Sun, 12 Jul 2026 10:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qy5Ve/lc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33848848A1; Sun, 12 Jul 2026 10:23:58 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C9B844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 10:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9ZK6SXJj8Am2MGkEBcwRfJjvi9MwH19UYLzeE+9cY5Dql2x+3SWkpcLHnWL2OGYguOUX2GWxkoly6PM4QEwBq/rNBHUb8ND2xXX5Vstvn2lPnDkEGNCdCJj3F354eAoRySGObCnH5eM2Oh7iB3B8S3UJcQNUcmj8NuBHY1eWozDqf1aa+RYSqN1n3jH+gq6k8KZGPC93SWCQgIJRLi2xfbGidFkKchdMnSxkF1Yq75hn0kmcLWC6UnOhsqSJV0QElMOv3dVz6JyEi/fMD654H1C6hm/8kVjtLdLG/woPTzGr0vif2UyTTTQ0cACTDqZw6l0hG3xNQ7xYdTzB7suLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIZIhBh3W45eX8vnL8noGJlnt8CR2cL6ZB15O1e24Tg=;
 b=rFZIENMCXKF2rb2zHcjuR5h3XOFB6jb69Acs7JsZCEE/hCgCM0bGcYekAenSB224miOqN+WreoDXT0aqHQ34GCHT1IUHjoJ7FWqyIQ5HE+Ut34SpzguJ0HQprkWP+YiVKooW6iJ8qfblWJcFa/DrYRacVaVyuyrvH4wyTg3xGFxkhqV1U848HsMLcwx9Bz8wZIAs00LFz0bv/+wSY8HZkTYMgNFky3Wt5RjtI0DbO9UjzDZQ8NBXnmLf0mRW6QG+dh4Fzm0HLxEZJ0cM/aevsrUC+RHwl+I2fIDUyWvqBd7aJVlWxrW5CcdVy/HtpgKx2EEc4f/HDTuklmgrXthN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIZIhBh3W45eX8vnL8noGJlnt8CR2cL6ZB15O1e24Tg=;
 b=qy5Ve/lcw5Rs+TlpQb0HK9PzBdOxSAgXJxrs+11hvGgM67+DfbHn7jlIt3845+PrR5mjiu2doTvSs5uqKhDFnlKPgooepSojl20i8LfhgYhAzH1RkEJ2ZkaqnOzUP6rMVeTjQWWqu+YaqxAjh7HWTI8HtGkQHL6vLwshQALMG5XwTSCDQk/+7h0bp6r5LVeAdK2AXljgCQ8/z4epgm4Q6khFk4jtyBFeTu9rOigGBbAZNkCUdgtpiu6JY/Tny6X54xNwZP02yRkbT5QKfEQYpglM0jSjK8827JjBYTZEhK8wy2jzK/3OhidGI2A0Mu22yHpCd+dv3KUHsAwj6N8O/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sun, 12 Jul
 2026 08:23:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.017; Sun, 12 Jul 2026
 08:23:53 +0000
Date: Sun, 12 Jul 2026 16:22:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alice Guo <alice.guo@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH v4 0/7] pmbus: PMBus 1.x framework, CLI, regulator and
 thermal support
Message-ID: <alNOwfA-Jqqfuv5y@nxa18884-linux-1.ap.freescale.net>
References: <20260710201631.2469728-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710201631.2469728-1-vjardin@free.fr>
X-ClientProxiedBy: MA5P287CA0342.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ee6c44-4c1e-4d49-0f85-08dedfeee8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|19092799006|376014|11063799006|56012099006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: nnB7TJmi1viQ50QdVaTmkDSeI3785mnTv5565s1+quOIfsw3+1QbpGNnm/Ynu6o9wtrGLSYIWBIpMlkgianZFnJ/3a5duQGGWjkC2TIyLkqBv3QN8Q0DOITTjDobIOCwo2n7mgPpOITJRxpbao9zQ/T+Y0xOzqF5C+/NiY0QYgKHqGfp5vNweBt/q1SVfhUKoTV+nQ4j6mxVSUVTuZ94b2SoepMnqjBje//82uM/1y8wju49OcMNen664VLfKpHcH/0i2JCfUYrAeSd6CMWZeemEB2OSWeb7DWe1zrjBFdwnpys9AO82SO4/Lx4dBCupnvnJdDF7nprFYmdvJYbgc7qmVhKBKGCuP9w23HLYnxxcpafPFNGzOm22gBoREXfSE+dw36qzfLyHV25cnyDrbrNds2I0K8/LN9vEkUyUypVH6UmQP1sepJ+4SbJXtP5oGexVZSB5WwehUf0Uoh7FVZNE4BShKpY02QoRpMD8ZEHx8g48KLg9rpDkYYy0Y/mRksjqu4nb9ca/kr74wx23++qs0EKs0xuA8IkTXMrXPzs3/bN03mQa/JhETKFW+PoKyV6DOru4O+ohG0eH2Alf/yH+mvNOETOjLPezd3G+B4uJpKMMFP0Kea+LO1Sd0/T2Tu8t99ZWBwydz7ghYpaTwmIiitQCZ1nznRQxAGCjekcF34adBAHYtSlhCrbcjDA2lYgkG5FoStvx5zsMCnw8Ua9/qDTObtQaC5u90WytCY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?64r2Faac6IiCJwBVhL5vTuF5ertprLgK3ncNaDnPlJI0niomVH4rFKWPmqs1?=
 =?us-ascii?Q?ok2Pc03PQgvNI/oXlqlh7l0U3h8l5gsWAxo/eSI/ksRrS99JLt5Gdh6JEsIo?=
 =?us-ascii?Q?jyowPMwIP8HIjFPcJjvBadhnurw6+UX6xChPqNSKTJysm8sh5s54IzLTZjkv?=
 =?us-ascii?Q?U2Pya8gnLVWravs5UfAq/V1t2irUIX+Wo4OF7jnovPdR4Cshz0aooFxITe4o?=
 =?us-ascii?Q?iY7Q1LX6bJ6VKlnjmq6+l4XJCJTTOwx2eZtp8mEk8/yw9qMqxcLpb/hXhkPn?=
 =?us-ascii?Q?CWB+X9iVAvfgasDIXimtUvLukdXNpGbC5S7dzjiVRx4/nlZqcqM8KhXlpRGQ?=
 =?us-ascii?Q?XBAtBWLd0dvwYRKNNvgU4U6gg9Sqi+k58AYlyF0UettMg+qYMGqpFShuFO7g?=
 =?us-ascii?Q?biLNljNGpOS0qWzxwqa4+S6vyQYrdPCeOR52cRCoc4ml6cl4YAw2PB5zVnmk?=
 =?us-ascii?Q?MTIXthbSu2JPLIGqCHirFzayXx1uL0vx1EubDc+1Fi3fjsO6TEMXeawXoEW7?=
 =?us-ascii?Q?tnKvJZwjEjmDcfX2u78F0CfB1q/FNbb3jKtCMoy/PY7p3p10jGeXr2Tb9/DI?=
 =?us-ascii?Q?UJkRk/Ka23UsMyY4WhDxy7+iMqybdWaM1rXu/19XuSe4VtE5TjUciEjg1ccJ?=
 =?us-ascii?Q?A5PnkD6va6OPK5KNl/fuLo5rb4ODpUPP6ml1yYHAyM3JXRhPrRtarLYlVgPj?=
 =?us-ascii?Q?MXohYw8HwE0qCwQBdZnvLEc1UIc3PgKVTR26PnQoLzgvV8nHBKDpXSU2eqZc?=
 =?us-ascii?Q?r4IjlhNC6ZhMSB+Ouqocpkh6JbQlV6xqhaYebxxuTzof+gJPC+EEZ5NP+UM9?=
 =?us-ascii?Q?a0OM64WcAqn9r1g0cOUc1YvwWuWooPu25F/KmPDqY4etwGplIHwoMZmfrRO2?=
 =?us-ascii?Q?t5jT+aopeHRY81j4w5IxxJybvJrHHt7FdLztgd5U/9JWrutxO6xZ1Rdgw7Ic?=
 =?us-ascii?Q?V41fq969u9fOFPJvO36bIjGO6PVBA+26rmONu8e39zewCP8h64TAuG5q+68a?=
 =?us-ascii?Q?ZhQjmar/eL8IY4EWB3XlS6fV73RDv83prF5Yyhlo050NvqdJi3J9O5kUW5Fr?=
 =?us-ascii?Q?llAFGZwUbQte07KRkPmxnYg04LDHsRZvtVrplLQVLhE9aWC2QXz/n3VM8AC9?=
 =?us-ascii?Q?wVL8CbfK+v4lEnWdJM1ALDu+4LSotdiwEi1qehM+MUTufCXhquXXBFgrE8GQ?=
 =?us-ascii?Q?MyflQ22jwGlo5Wd/vE+YF4f5DfVRZ2yBpGrC/2bt0S3BXX9nLnhL7v0LOLeL?=
 =?us-ascii?Q?LWJfWp56cmA5PDOPQXFsqSPbI3/WHs1Gp8BJh5iBYSSGAQ+wEcdGjV+5FLaE?=
 =?us-ascii?Q?4kisqEanI3xSTmXTIK9JSAqeoI7iGcZJwqTTcO5D0fk9pTEeMmgqbOrZnbzk?=
 =?us-ascii?Q?/IKjU9IQkOw4EECEx0d4A6mVDCZ30aUh/qUD/ZqZmqQn2JG2fHMjnieDK1Sg?=
 =?us-ascii?Q?7W7+XkhH+cdVqys2w0wP0Iil+xbbwPeFM8FQZkdc+QUf7E2nHboYu3V5a+50?=
 =?us-ascii?Q?DjgsGJBvneuSsUrxteqfYKhxUtagiQa5K+TpDqcNgR1jvEFSysBCzq10yXXO?=
 =?us-ascii?Q?Nl0xJexXLcxis0W3VTTKXBFU757yj+jkPaXguy5tVenp9aDLF2tBLfEzYvd3?=
 =?us-ascii?Q?c4+FKXe3imCL1xmNde9djVvMvkrwILpwZotz77coBuUseVBHLQk2il2lk3f6?=
 =?us-ascii?Q?L5ZiwVjMDxlnOECipZU/LYsOorMgbwsOSr9ssew2JesL+xZK00p5ellIrvbE?=
 =?us-ascii?Q?HuHcmPqUGWQE67ba7sL27oAmfyWOFP1LF8Ucr3utYhhwaZ4K05Q1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ee6c44-4c1e-4d49-0f85-08dedfeee8c7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 08:23:53.8233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4uG1Y4/OnobWL4B71KnKwR5SL9XluZADvjVK9nI408VEmGQleeW8pGjDM59w5jEahD8IQZdDj56bY7MYAH/BkF4+k8TBDjGxIY+6ZpNWu8xxz4jcfnnRST7V59u+8+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
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

On Fri, Jul 10, 2026 at 10:16:05PM +0200, Vincent Jardin wrote:
>
>This series adds U-Boot's PMBus 1.x support as a small boot-time
>layer (not a hwmon clone):
>
>  - a decoder + transport library and the pmbus CLI command
>  - a shared UCLASS_REGULATOR adapter plus a catch-all driver for
>    compliant chips, add the MPS MPQ8785 per-chip driver
>  - a generic PMBus die-temperature UCLASS_THERMAL bridge
>  - migration of the shared NXP VID rail-trim code to this framework
>  - a sandbox PMBus chip emulator and "ut dm pmbus" unit tests that
>    exercise most subcommand of the CLI.
>
>The goal is to identify PMBus regulators at boot, print telemetry and
>decode chip alerts before the kernel takes over - no polling, no
>sysfs, no fan loops. Linux owns the runtime side.
>

+board/nxp/ls1088a/ls1088a.c: In function 'get_serdes_volt':
+board/nxp/ls1088a/ls1088a.c:676:41: error: 'PMBUS_CMD_PAGE' undeclared (first use in this function)
+  676 |                 ret = dm_i2c_write(dev, PMBUS_CMD_PAGE,
+      |                                         ^~~~~~~~~~~~~~
+board/nxp/ls1088a/ls1088a.c:676:41: note: each undeclared identifier is reported only once for each function it appears in
+board/nxp/ls1088a/ls1088a.c:690:26: error: 'PMBUS_CMD_READ_VOUT' undeclared (first use in this function)
+  690 |         dm_i2c_read(dev, PMBUS_CMD_READ_VOUT, (void *)&vcode, 2);
+      |                          ^~~~~~~~~~~~~~~~~~~
+board/nxp/ls1088a/ls1088a.c: In function 'set_serdes_volt':
+board/nxp/ls1088a/ls1088a.c:703:43: error: 'PMBUS_CMD_VOUT_COMMAND' undeclared (first use in this function)
+  703 |         u8 buff[5] = {0x04, PWM_CHANNEL0, PMBUS_CMD_VOUT_COMMAND,
+      |                                           ^~~~~~~~~~~~~~~~~~~~~~
+make[2]: *** [scripts/Makefile.build:272: board/nxp/ls1088a/ls1088a.o] Error 1
+make[1]: *** [Makefile:2210: board/nxp/ls1088a] Error 2
+make: *** [Makefile:189: __sub-make] Error 2

Please run a CI build next build.

Thanks,
Peng.
