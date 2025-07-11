Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EF3C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5641836E7;
	Fri, 11 Jul 2025 04:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rR9tqMsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DBB83744; Fri, 11 Jul 2025 04:38:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09D4836D1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2CgQO9D1W42mtGqUmrKZ2vIHKRrb6d+mgv+THp82b5aOKDG7eMuXP6NtSUGHIXfwEy91T5Gb0F7ncg1G7hMQ7etv0hmrpQUAcP+9sCFv6LYlH8IhgW5JjsVsbKp5xui8cQPhivXg603ueseOWmiZT7FXhAM6YPVbBbYy4x/7t0YCI3X258KDwGrSx17EhHkfa+orKAYtsvy8LODT+JaS8zIWvqOIu4eZm5nNtjsbUbh2qkjDETHsE4R+S22g6UERgKWJGtbDCGH96FrZLJW1w/7mMWLNJDRdw+7i728UgIt88qDgIWLh1rpc9zaaNNRW6MbHiONJrf7iIkeA1vXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq0zdk2gHGY1ATx/tS5N1aCxRJd9VUsLLeW/NkCuxGg=;
 b=dvV+nVd8i4c6LOuVbEdvGDuoJiO0l5eRy8H5sJPqz0kz4hzANh6akCqpzg1JGECs6kTIHDyDu+Df18GazMEQZ1OuO1bmfyZKM2rmNMOB5bDU508cvLjPQkiwgwhbbbPYvdpH90KaqaP6+uU/eS//ULP3DcbOTSfBf1glIshQOY+gMKF61RmlVftp3PD5BAZavoB2Q4OsTKdpFqbwlWQBDCty3A3VFKQuZng5y7aAO2/y9xvFuqciF0MsgHVtzl+/U+C1IYAiqyornl/CdcBhtmWCVbnWdOudhJwz+cr35ukAROYogd/NkYYKWqGEsMiV0eEkmQbpw2fvzKvwh1Iq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq0zdk2gHGY1ATx/tS5N1aCxRJd9VUsLLeW/NkCuxGg=;
 b=rR9tqMsV9lnmAi/FPcYAnvmzTauB9tCAOgWglS6ZRw86L3WmpVzHpW7owB5E28f5HrQmrHICN+oxfjFUnXlzNR8hsQeNJdyW5plAvpawjoWqz12ssbDlaG52iwyD06YoDqGUbRGeFsQMes2P2Ds5IlqHeG3C3CUarEItapcK4DM29EH2ISfbWECrwt3+ASVGChZhpQitdhFI8cdCuwJDTsWrJiuConlNjIbDQtSYoz+EzGcLnGsSDZ7kEULQ5amhY4MiHXu+fjowh/PP92S98V3SIgtbG9WRGqO4dkXYTi998qIfWf8Yd1oKvhKj9EGd1iofmxhBYw85KNo1JvFoBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 02:38:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 02:38:27 +0000
Date: Fri, 11 Jul 2025 11:48:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yannic Moog <y.moog@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH] phycore-imx8mp: Enable standard boot
Message-ID: <20250711034840.GA1654@nxa18884-linux>
References: <20250710081717.435585-1-l.anderweit@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710081717.435585-1-l.anderweit@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c00d54-5d44-41ca-93d1-08ddc02402f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pz2bN8xZLLkACbHvORpNoxG3vczG+O2of2vykb3uEtqnsSPr3wJK/XU3iF+P?=
 =?us-ascii?Q?rwo4AnIBd6k5yTV6Get6QR7OzldFe68VaiIv5W79HXc4hoqlsOoD3xRkMFHc?=
 =?us-ascii?Q?O0zc1uZlge4ZrzUVmNFxuudSG4qAxwL4QNHZ6wqn36KkYByElYG0AEpmIzB9?=
 =?us-ascii?Q?cQBvWWnT06ty5dQnEmtlpXsNYllkayTPSfx8X4NTDN6bBGuVoFzW7xZJ/r9v?=
 =?us-ascii?Q?uYTWmn8hrkbQqEa8magyJEtfRP29tgw01AzjvnZiSnazppheBaXKscUHWAhF?=
 =?us-ascii?Q?pPUZOvLkChCAA9Qc/nIhEka0NTJAKucxuKVlbaTyMVtoLbvq8/bbuYPn/mtw?=
 =?us-ascii?Q?BUDcjfu4H2zZ6ZmEPQc8BFHSncL5FCHEnkjP0nRKMgZZNOnaXZ1BQr+JEyFe?=
 =?us-ascii?Q?CFkes9TWNTJFFAQzsFeDbZ4OhG3WsxuYE9Zj23iUJ6hUazHW4L1J0NaIIuAf?=
 =?us-ascii?Q?1LtQK8TkSlV+rwHopeFDfxMdzkSTLb4Cy+UU+RkBaBTkqnBlvAGR4pyEAbnK?=
 =?us-ascii?Q?EX5b7QK+e42ONXa9jXp/yEB6cNtyLNEMN1oP+c56MPWm2ggIZFoYxDRVPjBn?=
 =?us-ascii?Q?4L7Ca4hSG8ksjiPaAqhZ1Q5zCraE/JyOft1FE8HwZPvSUMP76avuKFTjz8wA?=
 =?us-ascii?Q?PfUab4t8E6Kip2ugZSw1G/XP8WiTVR//CxkaLillfyMYsKCvHBMldh9OwJTj?=
 =?us-ascii?Q?gZnGrqqZoZWZBI4Q6uy1s6CqvhCK8KB7QG4ZnIJ0d9VhyGmS0xKnaHaYd3An?=
 =?us-ascii?Q?tPwHAWzLoWhGXMacr7AVO+oHNZH+mTqipfw39JajV2BgP4eOWS/B7j62QykL?=
 =?us-ascii?Q?krnJK+NohdGuunB1ddE/A/M0fWvst2pOfJTk0woyrafo/5tV0QVcI2dpSanK?=
 =?us-ascii?Q?ElsQ/Hvqw+rzoMQN2ZHQy7d/e9SolTyPgedPJSxvdsdb6BjSRX4lFYD20nyo?=
 =?us-ascii?Q?HuCMkrBuPDTR7fxtcNE3Xq9ESsqnlyiGxqHL4jVXG+z6Ia3ISWRCOy2AdCvN?=
 =?us-ascii?Q?O7gqBDEiI296pqYAFIdr4LBtCIy+nvevkjKbB/W2JvBQQhCWUM68nGG7/WqV?=
 =?us-ascii?Q?x6bij8PyOVZbDJlaVu+ThotBDqfzpgrz3ANBcG+gN0Y4TAWyBX/P0vstcpV+?=
 =?us-ascii?Q?mvhUi3dAM9STiLPH+IjIHn88+qAFL9yJVQIb527KW83Xfvs9/PLhCmyHgN/Z?=
 =?us-ascii?Q?vpceOWt/5y1Gd3+Xi8ScK4V7oDBhSmabPGP4PYgL6CctsIxs5S9xh4qZJxsb?=
 =?us-ascii?Q?4Po4na6eaEsTKqZIg5adOtA9I5j0Xk7lj8aLPBWH5Ul7S/wucZ2/pxfkkbOS?=
 =?us-ascii?Q?ALdAtGQWxoRh2DSHSTHRGyh+jiiimu2i0rj7CebEbipQHpTaQMkW34NfhiC2?=
 =?us-ascii?Q?JogXhnnxq7BYsZcZhqoSYphGrhxJZthwm99yL3M2usZsvXiBDZNjSzx79ak+?=
 =?us-ascii?Q?rt0pWQB/lEezVMwsSnRBc6fH8CG7TP29YjzJ2mi4+B9UFSsOR8yR0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eEFIPGHNABYdxab4dlZ+/ta6RkmSTUhu0HOzJozSoUnr0r+K51dEiuh6yAW?=
 =?us-ascii?Q?C0dSQrP6PufVcuz/6bC1nQaBgb3druVTlDX1Iss8My2t2O4y3Q9yLyfuaCLK?=
 =?us-ascii?Q?3xKveRBmqFNsMZVHOy535UkaslxriS/31/SLc/tB6ZenkkbJ6QT2mnfhOud8?=
 =?us-ascii?Q?gdXpZIHmIZbu8mKpQcsCPpxtNF0fsiFVOdjxzirsc92ULMuN6KOszlBOTCUA?=
 =?us-ascii?Q?q1SdXu9iMahLWjfTAePDKXv/VaMwzK6TfrHwLq6oj8UsB8sUXoDBojzupYg+?=
 =?us-ascii?Q?CNjw3D2BlTQrAF2kv3I1jfPkdGJJzn0epKUTnuD+/hvdwdGKZ8dcdImaLUFI?=
 =?us-ascii?Q?1rR+eoAB5udf2zU1+T5uDgydBQ6iIcfTL7BgIvVk6vO84NS5E2aX1mOM9mVq?=
 =?us-ascii?Q?ZyZ3SkXY7W3N4gThcUnrNYILtKdFt80UY7rUfoUShc0iKCzabVDlu56RaET+?=
 =?us-ascii?Q?JOx5Iqr6jKxW4VrlrK3RXGJ4mg/DubEZzFg1WcNHk+xRSRFK9J/8IMOv/UqC?=
 =?us-ascii?Q?HvwzUUsOnNZ0fswVn7RbEFS+DPNHLYuAXYjjinJKsEQAzFaC0qGu6TkrN/q1?=
 =?us-ascii?Q?2+SZu+S6YrWZI++oMBBXIofBZ9sP12g/L/ytg+ikjFN6U6EWvBZoOXmBEsLk?=
 =?us-ascii?Q?lU2Gm0q9hNjzgtYM62Mdfb+I4sn28MV1YUaVRMDrdVewfFUZLLuqb19cA5ye?=
 =?us-ascii?Q?Ij69Y7bWpN3W7vcVV9PR5nEi1g92GNz601Rj+NzBSjU2KNQBls7ykGuUESLe?=
 =?us-ascii?Q?zPFhtMwE5TdA6ics+gc7f2MfIw2u7/QuQXWdNeUeSQOmM29Tm0ak67zk5+sQ?=
 =?us-ascii?Q?+6sTCnUlzh60bhTb8UYoxJMl7r0nW0FLmvkAkMR4+DVh+pEHgqo45ylk2/es?=
 =?us-ascii?Q?IHIZbLEVh/jEfBHwGSK3LZL4R0luFxZ+YGw9GCHOpLjb1/kuLThxyM7cDGyS?=
 =?us-ascii?Q?QQIv4rtjXg0b3JHELz4++2K7j/tYd/gu8hvU+gfLW5CoCMDVIafVmaT8HaSY?=
 =?us-ascii?Q?U6u/+Wqm0A1uVxk+wooM/PE66ngOuFam1Wjyc9lxpBxIq2SMT1GYmpigsFRP?=
 =?us-ascii?Q?NU76gX4TuJL7snJxGgNvDpZgHruixvUp5im77LfY2GFIcya5AfYlYmYw7zA3?=
 =?us-ascii?Q?xOUNkrItpXUQVJIMt/qy49wCN8LLE8NEhizU0w8MBWC3Jo6BbE7G0fEs8PHx?=
 =?us-ascii?Q?FDwByvScO2TKWqB0M0JZiaXWdx+qejwg9FrjF5bZfdYDTg8G7n3fpAlk/7Qk?=
 =?us-ascii?Q?QAEeekyxj+W3HA3oddRjN8NJF0UuSfcszs5HU6JcsiKTF2ciqDII8VcACzKc?=
 =?us-ascii?Q?eHgvVCKmn32iA3p7JvxfSlTt59J0OW2/KtvqaOK5eT8LikMa2lgp/97tAcz5?=
 =?us-ascii?Q?M9+ouOPgusKaCfAxckFyj8TeMIKFkaqes6zA7ybQdsXA+ePDqlh3ZvLq8zl7?=
 =?us-ascii?Q?eFRrT6aTK0a0OWQDiBgjcVUQmb4yX/Rh13owbvJcvA+0DrmfiDDhn0b8TBIU?=
 =?us-ascii?Q?ApxN45k7dLJoF2T5H0DROuTUzpxVG+eclrBC5fD07S5WBeH8ghf/wHxF1074?=
 =?us-ascii?Q?YnYV02l/qshDx2c5SheTDLmlHIqy6rxsaG9XetIu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c00d54-5d44-41ca-93d1-08ddc02402f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:38:27.6121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdGV117V5o13pGIA6CXwaQClZP+9IF+wJU8/mFR97tCEnpvg72+o8BIKhHwb8IVcpBjC0/Ms2xZAmrIYOTdQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
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

On Thu, Jul 10, 2025 at 10:17:17AM +0200, Leonard Anderweit wrote:
>Enable standard boot for the phycore-imx8mp and use it as default. Add
>all variables required for standard boot to the environment.
>
>Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
>Tested-by: Martin Schwan <m.schwan@phytec.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
