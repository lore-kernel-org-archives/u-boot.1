Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AD4C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678CE84A26;
	Wed,  1 Jul 2026 09:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vv4plSKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D8B84B18; Wed,  1 Jul 2026 09:31:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F01F084A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe7qTnjdaX0/CA898Y1iThRKKxUTasne5M3qnarFXiNb5i5OnhWOLQEr/yCI+TEliuTIDpjyxeHNWm0/xuaNmlWt34RpIacXHp65ea2o3Yur9ByQaKx1jVQnBMfBA8YhtSn50iF/hrnbU7k5CMRgaeY8/IjMQzdlXeWjE9h98vBbu8k/3upadcYjPp/ndXy5X6MVoYmHVvxA6yz/3r6Vvmp1Ek5qF04T3Lm2cfQf/tIO7zcUGNg4EjU48xx1TsWV0wWHn2NIL8BhBsh4cSBZT9nOU7qz3B4ucNrr8sQO5drhTJiZBKtfEPWxn4EeaaCZa/kfaYbwJCemDxBXrHBSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAx0H2sFgERbKpBsRWFWDodnWiQIn20r0gNVs09s50g=;
 b=uaz/2kbOd9PjpmLvUtpTgelPSolXSNZbNiwLuOIVHbcGgo00+60dsruXnEydYFoWmMIXa8L7DeSfJViMTZQQzrZ3RCgotRDSc5R9fRZNPz07kVyM5MOFH08jV3DgCqZrQxL47BnRxNhGQl2AKlJnbxkZtIcEu6Sh2bVQYfFIpH+//VLScF3DzAz5pcdiyne5nSYXTkLxfAZIM2+/mFclYaRIJFFW6ixdJ3oncdwa8ZnlB24+vAlP3S1xBjQTT7rGDFK+7kWHvPgONX8DKL9DGurzO4eDl4/r3QNsgPh2/Bazok/lTF+ORFFx8EM0vpjCCeJKWhRwvNF1Fod8uTcqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAx0H2sFgERbKpBsRWFWDodnWiQIn20r0gNVs09s50g=;
 b=vv4plSKSGf27BHyVdPT+fc1QXJNVggKdZ3QpusVHEEHmpcezaxhXYPcGcaXFT5N7tSl0W9VGg50L6FbEtlzoc4kaQVHPlx1iByDN52QgO2hXAGkDlJY0yzHOnqi0F6Dm5gJwWpeSQMatt23Q/cwyfk4IfHpyZJId84annkleXZ2zkH+DB7XngCDPmLUhl9x/qLCQaXi9JC3LBeCsXBxhpTswQnyOuAIUakr3z1F0zShaJqY8oMwPuV9iv2+NKgPm2MZDzLIiT/2eNong+Ds4Vu445c05gnT/ubqprFrBVjOf2/ijqffCuUtC8tOIB/IPcd8o/SLGKaR6YbAngaVcOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU2PR04MB8869.eurprd04.prod.outlook.com (2603:10a6:10:2e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:31:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 1 Jul 2026
 07:31:29 +0000
Date: Wed, 1 Jul 2026 15:34:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
Message-ID: <akTDHtvETMcAJ956@shlinux89>
References: <20260610161748.54824-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610161748.54824-1-marex@nabladev.com>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU2PR04MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 362164d9-d8fe-41fc-8348-08ded742c474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +HpRGNk+09f6GlBKzeL8QdvX2yQk71EiyPEy9awU3pWX62lKcP39wJnJ2HN+aHBaus4vCuvUsYJ6vdDLtvruW32v3BtAelHn1e/F8WuBesxpNj/kNlq4h+1rG45bAyPjadfNlW+02FvagqKTt5a2DuPP23GbIu2zXu3iruC+GUoMI7Edh99FF7AL/EYieFBQceZ4QFuPIMgaOZ3AfbzS7Z7Vo1s/5xuEjFPjOe+dloW2kKwoW5s3tTY6cgLMh+Xa2dK1M20aUgbmmI6gG0JD0CWB48a6cidxGjHeoAJIL6r9W2uus5A+IBPGPVTtm0pOeRPxg8SiT69qtpPs1Q9Np4M1BLoJPYQowVR9u3KLZAYWZ/ROmQa6wyNdRkHT8huV7ZuTp/jzeP8Gqp6bGXSty4K4tJvO2ESQ+2KzAaeXNLQp1ZXB9xwmJzBK+24JUwv+6u70J37qhrcraxovMZV7SRzT8+eQeKtMeZ8mfU4phtsUtKhYC+HLXxbUdzMyBwKZkSca6AArVxbcfJGAK2bXx1zIFOgyGkCUPEQY+vJE6f1Q6OtMQXOfRGTqUpfpjRZToefR+HFPmkU+UuPAY5sor5Crhyaf2hxnahFmR6CeGR0R8wPNXve264SwG6JPAagm1R0ziHxJMHsjd8PfjXUQ6n2rQNoJFDrXxxOBvf7Nlhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZu4kVnf+dRArDN4CMErZ/sc1aGc3KNTPgG81s1SkFNu4mi1YQC3Uo1F9qvq?=
 =?us-ascii?Q?oOvi1W4TgMSlEEDdnACe4TkL3SJm/jAecDfMIVy7k8A7aD7fq3Zrf5BFMwFg?=
 =?us-ascii?Q?j0Ufj/ltPj3fUNdr57tX6GriGUAVyfzNMM7b0+uaAskF+ER/wVAVDG7YYRbg?=
 =?us-ascii?Q?IvmwH40IT69MURRaA7wEhgvnsptaM7scS0EiNDyNnpci+e8Lw9N9KXJbCWtK?=
 =?us-ascii?Q?hiJmm9i1XtI1+Mol4O+ele8eNEJlMJzQBohJK+dx79pfZskIQFMMK1G189Io?=
 =?us-ascii?Q?O3WIhjTLh6ffMZNqmgCZ9JVkz8yWrpAQHAaKXxJS1xmFilp7LfDMXtzWr/3L?=
 =?us-ascii?Q?s2iKzeRenonHcngxBy60zT3tCdUJhYkq3NArKtbRaPJHZGTEfO+Bunpejl0H?=
 =?us-ascii?Q?AEs+oPf3Vm0JfWsP2wI0mRRd8LKBOVv/VyhAnfxXGVZYZ8ZX6M/sPKzniEw2?=
 =?us-ascii?Q?6Uw3EuElYjHFfCsFZO+nB2qKE9l4IGWZwX8hKn4T0sizjouMJ8nWEFBHbtBo?=
 =?us-ascii?Q?oB/wNBeKLU+mlOgrTt8uiRROfu150HL2pHwOk+nKMPN2Xyq+QLICzE9USkxg?=
 =?us-ascii?Q?Bmo13K88AFUk8ptY180xKmHAYI13rhRDputPxAycIrta7uMdi8XwZ9j3JcSH?=
 =?us-ascii?Q?Zxf5Lwy5MPeBnfKKlJ3QoZw7e+HSiGGHz0bA2XIQon7vvdNfP1eCIaloJCYv?=
 =?us-ascii?Q?7ezkrUwmYSy2Kc6SNAggA1Z41uExlx8EUkMHzMmlrAeWK0ZmkrDapII2fmMN?=
 =?us-ascii?Q?WZUjqESC5bICMzVhH92TKuwtLIcszdFb+tJiaQ+iQV9OBnfEoSfJzZr5uZ2v?=
 =?us-ascii?Q?l1CKqG7cHnTuvgesqfDsaVqDuC36WP49vS5ecDMh+kItZSicnIeooZ50oIFQ?=
 =?us-ascii?Q?ImwgbcyQN/aH+A0tVxpfaAiqKcBimpbKthDKVI3Q5VOpBi0U4g37bOTmZ4Oz?=
 =?us-ascii?Q?qSCfl80/ghNmtxFYIIandB3FggD0o5NlSLTEjGRabC+QfgvXHISLdKncBxb0?=
 =?us-ascii?Q?ktIt3mqNPIgzRRrxxCuEk3qhrtfPfdX29wmWzdcM1pPEGF2e1KUDDUAsCxgY?=
 =?us-ascii?Q?foRAez1lMfObI8K3GdRn2xjvZ+n1nnLICQDDzWgpbR4PvuYb9u4RXLcLX41w?=
 =?us-ascii?Q?RC1pscNN43TyDrrBjvuPTL2ZP3FjMlvZk4f8yK9C90QBKNc4gWL2TWobv1U2?=
 =?us-ascii?Q?8h74WVmn+NvpJh0VCoC2SPh8DzVGV6qCRinxhkLqEA1QoPVr+AiLVv9dG9b1?=
 =?us-ascii?Q?DqABXaDqavcfj+vepy4vI+vONtW4zYZVjm220+kS5N+gUGiwkg1ePTquI8NN?=
 =?us-ascii?Q?BAjMuZXM+seO626iVaZWeS4zyRz5mts+xYUwbWcy0TAZ6bT3zelbGbwGn7KR?=
 =?us-ascii?Q?etZQ+MEL5Z8gzTwUOMugXZcI4TrUhf1vmZhiyNbzYlAi8kd3NmxkchTDDKjD?=
 =?us-ascii?Q?THoov3+GFlx88WlBzejeCazjeCo18GeVwTaJ+VTqMxy4yo47Aqih1Pd3OZPe?=
 =?us-ascii?Q?/wchF6bkBIVjiFFfUBIyMTvtuS2lUj0YvIQ+4ou0HNEhBP3b8qJQHGnQPLAu?=
 =?us-ascii?Q?3rgW4wPSqvqLaQ3b4+qlcyit/qVoDfGi9KcW/vcn9KYHqjqUCvnz8Bl4fZ/R?=
 =?us-ascii?Q?gnmmk0mLy+RooymxrGVsSQhB2Vtd0FWUNjVPUXtgFsRQADyvVPH9OIrVdgBP?=
 =?us-ascii?Q?p37tRpDqjueQbpU03XcrdY7wnHwSyutGdDVPj19BJld02RYBptddUCYSExx2?=
 =?us-ascii?Q?jzWfWVTeKz021C1OVdmZdC/5CMYVfcYShMZuoY7CQIP31XJOzSd8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362164d9-d8fe-41fc-8348-08ded742c474
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:31:29.8549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilnQLyKs+SQ7xC/A8gKIhiUQysZeBNLjPTua5i+oerey0agy91aLXVPegqudfqxckD7KVDeiqViRc2BVV35vuSqHoJkpU91HBdUe6wso9lmmy+MI1hQ5TkXsVcgbGja0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8869
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

On Wed, Jun 10, 2026 at 06:17:03PM +0200, Marek Vasut wrote:
>Stop depending on the current mkimage method of generating the FSPI
>header, instead generate the FSPI header within binman itself. This
>is more flexible, as the FSPI header properties can be configured
>from within the board-specific DT instead of being hard-coded in
>mkimage at build time.
>
>Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
