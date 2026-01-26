Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A9DD778BE
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CF183DFA;
	Mon, 26 Jan 2026 02:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dvkmoJHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AAFA83DFA; Mon, 26 Jan 2026 02:42:11 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEB283DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK1IH9Kyqcr5Z4stqcBs5Uh0qifZvE8ViD0VYry4Tn+qbDBscFNmZ1ruw5CwI5X8MNSCYCI/APl2n2NfZMWDeq0n1CqgatxYLiaXXjnJqSIQp+WMW51p9n33h3Rc+H0OD9lbHsmFjHcZWSiYWeKrJuoi3Y0rRuw8AuCdYr6E/XxY2AcU1Ztz0kdRFKHqGQHBXcWOMQ2lAEBAcmBWY6/6TjvjBfu91HTERRhKb9tMlX4HCHGWIOfpJiQ8eIdFgNuRQrnJbKIzAXbHCxftx8EUuJfxDn4aTbOjAQJcDTjvE/TZz0+V+vK3g+BcL9g1g38AOokn5e5zsnGO52phyPTmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyvkABT/ftHVufsjClwq0xb5LL3HDMVxi4fETt4ZDhg=;
 b=cF/4mmXkGDdlMAakWOc7fI1XR7fV0U398C3S7K4X7ccd7/Z79i6ME2hPN8wWNmLjftGL8FzcB0D8KHaZcqDOPpygL51yJjnuvhHtKStPQBNx8+e2h+8qgp5QJ/cRy+dETjgQ0ErHWlVIrhtt4LgVhvbsJ2C/0Gh/KVzMjjPdxRck5nG9x/SSWjARSU8xScHV4mjNGrJZUZr9mJfHGeQsRy3lt3akzU4yF9XOR2WyQ9C5puGTaHtRKDAJylbuG28HlMCHcPlj1Hek7gE32y6lATcAXamd6uBDeBvjdoCZHh5FsBrhzM2rAD+Ink+HUU0bG2s1vo28KmK9AbZfQbR2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyvkABT/ftHVufsjClwq0xb5LL3HDMVxi4fETt4ZDhg=;
 b=dvkmoJHY3ldR/SQsPalI1WYWCOAUEaEJGxUi8ceJSzPNswXMW2E4KYzcR/94xz9lguRG52Mp8ooA08ge4Oc+SYZqgjQYbDK+zZ2qEuhQ0gf+Oty81HPEPD+ALojwTuucT5R44PZsB3uD5zducbz863BsMGCoI5TytYyRy7Hf0oXGGtx2aPUaVpCnOl8W7+3+ITzRGt8c08LWTYJH+wnqd5eFI2gBCmvQRHapnsfa1mMug+U12+GtG3YXqGHU2n5XPw8eBkGY4aCrjfTGemB2ZxGuaJgeT00KiRineCzoh/is0LG+5YFyVMCNIq9AoIgEDspAmqLd8f22GAx7ei/R/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB7268.eurprd04.prod.outlook.com (2603:10a6:20b:1de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 01:42:03 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:42:03 +0000
Date: Mon, 26 Jan 2026 09:41:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/2] fastboot: mmc: make boot partition offset
 configurable
Message-ID: <aXbGZ22OTwTbbGEw@shlinux89>
References: <20260124054712.7939-1-hs@nabladev.com>
 <20260124054712.7939-2-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124054712.7939-2-hs@nabladev.com>
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7e993b-a04b-4dea-c294-08de5c7c1b28
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4mC95ycQkfnNaGh0tgfOU+5kIb6mqT8Zsm0udfu0X7g1rjKKXpl1h4YCiz6M?=
 =?us-ascii?Q?s9ZYWgk9x8rWZUPbeGciU5iZJ04mJL3zPrTV4XfrFVU+JbecFh40yZ4rFEMy?=
 =?us-ascii?Q?ctw26RPostov9sUUZJlAPR4tkyErwvkJlVwNGhf9C2tFIjB+2XJQ2XVAB+XY?=
 =?us-ascii?Q?IN1latmrR0mw8t8CnbGWY1zPC13+PNdmyiTN8x325qdJskMchcdqoNCvsth/?=
 =?us-ascii?Q?oMYzNehOjO0hSeP9IE0a6Qx8Er7T5jOWA2f4aUfvXOglZzc5Agr9CnVxIVKh?=
 =?us-ascii?Q?DzN90hI1VGJvdwnutAdCwjo4e1uIVCEHVvwLRuHMmiy+v4YFxOouAwTDe9lM?=
 =?us-ascii?Q?M4wrcnue1iGNk9oO7YH0vWqL6HOkWjRq2WyY3SXwFXhx/fO+RJnqwn+aOFe7?=
 =?us-ascii?Q?eYIn+ElPTt/zg24B8J1SJEo9TugNlKrGpSRegMwvLdGjYs0ERIZDA114SzXu?=
 =?us-ascii?Q?ACFQI4/cTd9jhOT39PX0Y/MB7EkNZ84RJPnqC08zHPkGK+I0hVOI5qy53isG?=
 =?us-ascii?Q?gydH5CmxFpyJNr204YPDiwPxgcbn/4pZ4d/Telqs6eqmgMjV253AjbgdJEb3?=
 =?us-ascii?Q?xQPubS5Q3M21rML/Hx6FAYrQwnb00u3aoWtlyVeZqhWgrpXFNqYmbRa+Ovo6?=
 =?us-ascii?Q?bfpPvcqzhrinzgY6SLPat+giivHx1K+mmqfRWoRMhxJYW+QYXE2KvDiTtz1R?=
 =?us-ascii?Q?c5aAqI6/LA7WdE3JPAs+r/TnsoPCsArKPdrJAxM7YB5gyVYArEy2/Bs09sLE?=
 =?us-ascii?Q?cfg+SVFlQCx1xVBgj9NzyMCQHVLI/1LMo7FmJTVYhkT73tSaZe7JgaloZ0EZ?=
 =?us-ascii?Q?DbSLCKAbxVMOFJcyMC9BtkEwvs0croBZyfltcz0xfWBc+WdhstiQF2mnXM5m?=
 =?us-ascii?Q?oBuP7PyL/74PxvMJCFv9wYDOB82C+pAAtmXl0vLiacF7fV9i2n7D8OiEBiUV?=
 =?us-ascii?Q?YPqR7v0MA6Ns4aSVfcZQGS3QNPA4+SQFKVN203LgsnTly0m589KXKCtCl45d?=
 =?us-ascii?Q?HuoJ0hyVmaDh6QpTdSfWPT+kWOZd5l8MK4pZL6FqcDBcagph4FSI7VHMTUcw?=
 =?us-ascii?Q?a/XkaDnybgQReu3IK2TRpG8M9Eh/306rod25p8A9Si7iOV5nGHsJwH5qa80P?=
 =?us-ascii?Q?dIBjWSdXBTiplGFPAljySa1dZrn66A6pmd4XS/+najxGhyaARniUS00z2NKB?=
 =?us-ascii?Q?OsR4RzNzHg8j6vh43ZuiDKx5YJs1oZJlkQHEm+htrDz+rl/irkSKejVExTmA?=
 =?us-ascii?Q?iTXMj4EB/xWcfp4HeqFFE243jJT4yhXP+3ScgEhI0l+GjXoqaWJM8opckvtE?=
 =?us-ascii?Q?TZlNC31ekR5sOAl3GtM4tUpt1D1JCiNGgqFWVymjPd0Sm6K0WUfsL7Z26a9V?=
 =?us-ascii?Q?g00D4QC1+mb+Rh7xNdw0M7vHPwQblKM25vISkLa1n9nf6INAeJJYoItMpgRr?=
 =?us-ascii?Q?d+BBzfyLBEVCerQyMicnLI8vtgg6QK1sGEF7qrbbSD4rFKUFBeUfgO5l9biF?=
 =?us-ascii?Q?0sBSCzjwbecuOT009oGTCg0vK8iJTjJbKYTm+d0x0xhyH1As9O/2+81Lc0RU?=
 =?us-ascii?Q?v13ktYL9KZyHJMRbKOxAHSqjvLwuUiiFTaoS5oTDyUOeQDOCRECwUTTmBB17?=
 =?us-ascii?Q?J2ohDHBvr8Hx9ilJ2AYA6YI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbp4I6D0GEjNXo1Da9xi3BgCx/YcpjPetDfzjvdzbM8AlUsLyk1WDDSi0rxk?=
 =?us-ascii?Q?vzrQUDcTu+g6ecKdS72lvnpwlhK6m4P2x8VaPu3gUXGOJICEJRg2P8JFfnFx?=
 =?us-ascii?Q?c73rE70acE+j/h7Jj3TAIOEYC7aacvfNSkST7zt1+uIkC8Vao3Zb3IsI3b+F?=
 =?us-ascii?Q?lxjf/JcGZiyrqkn66C/kIaeub1vTlXPty96+9Gwto9++VY0YFHZvg/q5ThVo?=
 =?us-ascii?Q?zaL+0IUahFUxmzuIUISDWjv3/4/flReBHOUeYdgUXPbSrpsB5mTrmKyimaex?=
 =?us-ascii?Q?1YuCjtBr2+18buo+HfwWJCnw/hqPepwIamuD0aAOAtvYDIVEMHVfCtsNYE+d?=
 =?us-ascii?Q?aRz25AmY6k+DlT3txorhweUnDLAcHnVVyFaKE2QqyR0TFFJwWT0rBelHyiD/?=
 =?us-ascii?Q?wV5x5HMDHHHB4qEqDdc52CmiGmcogQF5a/SnQjp4AsLrAUvm+BWUoX6HYnbJ?=
 =?us-ascii?Q?Zj0XgCLTg20o8uSdSE41VC0WlA5U8PzvBwOPO7P40NPN171wCFbslWm+BjvD?=
 =?us-ascii?Q?ZoqOP5q1uxf9UIigVIYZLudEtifXsVNQsCqx1r1TmcIoF029slPH2PGsaYyS?=
 =?us-ascii?Q?ttY3qMIzMkwYglxSz7T9Y/Lyww9UflBdZ+YZ1tx1dDFstr6wFgIewK+SSa8k?=
 =?us-ascii?Q?xBG5A7C1UyRqQVPqnGwp0XCS9qG8S+L14ER+eYI/qGFPV6hQkOgWgivf9ODQ?=
 =?us-ascii?Q?1+Z/5lImmOgljNCjSTR7Ox90ATzACO5a1KuTFA0ricPlxwbeNnq6yQCFDrUO?=
 =?us-ascii?Q?Qj45XB+m8OMqgjGr4wvNdQzIH2TsZhApiIoprlxbAZ2z4rTv7E7pZCly79yh?=
 =?us-ascii?Q?gmaNzp9IGQ/oHVbvJZt2F8erlFkvn1Xlp9RGYfNWHrhKU9VEiUuWkX8exE3W?=
 =?us-ascii?Q?xCREP/NpSAuGvr+CPaXipiS6Mo3MkyeG4ObNmgc7y1aBfwbFrgvg2N/ANEfF?=
 =?us-ascii?Q?xUpvVWIo32G9UWngvBgz9oMST+JCJTMYZ+mxk/NCL8i7fOByL7RP9eDjgOcA?=
 =?us-ascii?Q?NS5+GRqahyI2nE6FhdPJOHPnGDofiCOa0Zwv/4aHz1r1daB2+f8CobouHhCz?=
 =?us-ascii?Q?HTihr2Gh9v1IdsmI74TvO6NRWmJI6Sc0HnrnJzXXx4uJSw5IaPsMIxR1XWAC?=
 =?us-ascii?Q?LKkzp0siV4b9pdZvZn6RtO/TJe/8HakGE1hjpjELuq+0ApkvlEbUlsHIyp71?=
 =?us-ascii?Q?+hVWzWURNGvsqQzA1EKC0RrQC9KuD1KQ0FBvjw6pAfFWZCZy5OVc0ghzfW/+?=
 =?us-ascii?Q?s8tlj47fT93Khv0apIamzQnHWaxc1c1u66GLOQvKDzygwwfNJC7qJWhFEKAk?=
 =?us-ascii?Q?kr7FdC4fp1oadvhIRKNK9MxxAxHXgLNXv0fsJNvpHZo81z7+emY54rro5BFY?=
 =?us-ascii?Q?vT6MB1Ks9FcWT4ltzlnyOPV8cqVi0xgqkAafS6HyGkq7mVZsxt80w1mTm+28?=
 =?us-ascii?Q?P0D1W3ryrfH8OOsHvSoJF7+pBfZsKb8wyLi9LS/I4ujjP0AQ9h/qDO0og6oj?=
 =?us-ascii?Q?gh1hSz/OX3ToiT2/tQBO8Jisn1WQVYXYY4VGT3xcu1AOjffoS2T0LE+FflTH?=
 =?us-ascii?Q?nFKiq2NuSRBttkTjvHf+dI8xLNYYDuktQINzPaKDWyreBMNAKcAUfvr8C16v?=
 =?us-ascii?Q?yjJY6nZSJJount7B2VMUz4UaUSlzEd3kj2qRK+59NITI58EMmBjHPOlCmY2H?=
 =?us-ascii?Q?qwDraez91lTUjovolYMJM7yYdJjKoWklCwQXVGYDzoDLEbB+vaa1faNqNqqH?=
 =?us-ascii?Q?p05BkhGlNw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7e993b-a04b-4dea-c294-08de5c7c1b28
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:42:03.6486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMzk8AehdGkvxtehhDoXYVa3q8kTqfIZFYxNX25U8zBlIDic1NpGW5xK7mTrv/ZLz1dZLfVBF0HyvikRMQb8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
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

Hi Heiko,

On Sat, Jan 24, 2026 at 06:47:10AM +0100, Heiko Schocher wrote:
>From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
>Add a weak function fb_mmc_get_boot_offset() to allow to override
>the default offset (0) when writing to eMMC boot partitions.

>This enables support for devices with non-standard boot partition
>layouts, such as those requiring an offset for correct bootloader
>placement.
>
>The imx8qxp processors are an example where older revisions need a
>32kB offset.
>
>Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

I am thinking to write as below:

i.MX8QXP rev C.0 requires boot container stored at offset 0KB for eMMC,
while i.MX8QXP pre C.0 requires boot container stored at offset 32KB for eMMC.

To use one U-Boot binary to support different chip revisions, introduce
fb_mmc_get_boot_offset() to allow override the default offset when writting
to eMMC boot partitions.

This enables support for devices with non-standard boot partition
layouts, such as those requiring an offset for correct bootloader
placement.

Regards
Peng
