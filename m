Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC40CD342F
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 03:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9107484936;
	Wed,  6 May 2026 05:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FennN7MF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0658493F; Wed,  6 May 2026 05:19:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C8184915
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 05:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYA0ifoccgfcrzb3HeR+EOaC1G6dY5nozlskVWix/qrAx0hJ8mCrYVndIyDi2Zs25XBIHIlmyLpIc1hnTM4QMVmNT0MQQedPQvVWVvIpEIufMeN52vXJ9y3uOGNBKXQrUVpubNIkEzN2Y3bc0kJWmV1aH+QAZ8LBSZbWMBrDzSk+eAY6qmJtyXSXNLpCH4+KTQbr3ekdYiy7AsclUtbOmG9qZ+OoDqERmpAXXmZ2BgS4/1qm5HFmZ/82t5wPKOB1gcgFUkvwJgG7xufeVlUmOpTf2lFo9BNIOIADs5yK2xhAmo31k9r+dCcq4TIMGQ1+pHMSKA8DAaDuxaQk8kvmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tagn2TsM47Ku4XXIJH0wvigE1GaMUoYirLoezKSh3K4=;
 b=rC6rq0VkCYBHfOiHByhPbNvgWSiczMBMhf++1cdiFqQ9gpB685EE64OhG6VQbUPAhbmb+EDuuZrbO4gsQDm1RJQrGk2FjFCIhmAmkWc2nkhP+kzaROrVny3ckVVcorQVbQhGyQ6NdaatmAhC+8K+f+vyOxontWkGjgZL9591jDlEwHQPj7/0XO56da+mb6Hp+6OZ3oZPDUNwTUiD3ZDC2ZOlPZr0CfXtMWeM9P6nWOmNjKtOPhCjQu0CMZCQtylqCf8anr5/mbwnQuii2ifxrV4Q3FC7HR2pTxzJXYZEDW7EzBpf9XwfCSAAxyCw23Ez0hLSzb/+MuVqBLbM1dKu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tagn2TsM47Ku4XXIJH0wvigE1GaMUoYirLoezKSh3K4=;
 b=FennN7MFKqgOEwaLjG2A/yLq/IaWj3fVrzlo7ZLoEEkt6kQuCTmJ8zqKu1EIV4WM+zQ6ymVhoW1aSKCpBW5omAVpWBvcaxAZl+HgXFl1SQFs06Jf/A0cPlb4UrGO0zqfkgq9UbjB18br5cmUgd0mVIV6/lLFvwkNnVixND9W2eFkYvv7N86Ljd3UkJ+hTE9Yi8uaAMGa9jbBVzbIPYmnFBygcFX498cXDvo66K8sOtCt2cuHpXxmWBRJtBqjf/iaeh58Hzdb87eWbLVAV5WHxURwtIOVWSPaSo+GYO8+WGBQJTf8qGINEuICh1utgBS1uLkPXbgzp2NgFoMZFhQfDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:19:01 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:19:00 +0000
Date: Wed, 6 May 2026 12:35:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Marek Beh??n <kabel@kernel.org>, Tom Rini <trini@konsulko.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
 Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/10] Generic powerpc fixes and NXP board cleanup
Message-ID: <afrFLD8EXaQ5WCxe@nxa18884-linux.ap.freescale.net>
References: <20260429121816.1026326-1-mwalle@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429121816.1026326-1-mwalle@kernel.org>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a01a74-9e2c-44f6-487b-08deab1e37a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HP7hRhc+DHlYaR1HKigKZrFJWkdNKjDeSHyHpTG+hRAqIf72e2oPiy4qBUUsgsAExn4h3yTQcxzSpQSOpEPxdXiVfb05e2DgASuu0Z4aNLdAIBu1y4Mx2kTd8WFsmPUcCglNw2cRNJIXZ2IY2dvx+Q7gW/GP5KVXIlR3ZSefLdMs5f0o4LPSpF0NvPN+1+jPDUv7qlDqOx/2ErHCJEfLyHgYtdOovW0jjuvaT6V6fBeGQ4YS9/Nbku8oiWb9jWwbwAwjixgnVoHwlOJFDXZr6PS6UiXc6IPCSocGJY0gp0HEN09uSI5cJ0SRsF68WeFqYq831xXOOGuLaaqBdpeZrg4hj64O74bZeUMqQOuZKzQIBPykoOkOL4ucMNbt1KFJNgqEGL2gF7eHuNWAOnVmfI1TugcuJ8UxWcNnV7O2n7EmTp43EeO+e5yszmi2VrzypOzqpKI6j0tkgC9hOKn9mm3fd/JdhKWkM4O/7YsphdtUa/HzmPo+2Oeee7tJT9QbDpywsWooOAVKHPWFrLF2pf4L7rvUFTssblLXfWsES1QTSwVt76Mwm1x6cVY9In3ejZNEdYlDsK+Ip9+7gVNqbR9QlnUedviRarsJDsOO0IvTcrD4VoIgaChSYXzbpVEDKH6Wvk+0ri9acpvZIj64I7UORytMm0CqhL1M6MpRYNAkhYMny6T7YHJa4FEiyLKEvJZD04/2tK9WLsOL5mETp7yoASP1Vgnu1WoTQuCpUuXk5+y2fdABW0g2m5oBnfNE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmkR7QNCnItrN1/LNlmVS52m2i5cr61X4iVu8g8uErVdSqBu6StRtdkVYaLp?=
 =?us-ascii?Q?T5U2fGwCfWgkLJft0RBSUiYtk0cZeLS9DHIdGh9kWwXgf9pZUNw7q6NBo1gb?=
 =?us-ascii?Q?7bb8gKus1KXiVEqlObC7iTKZL9jj9lcTOJ2bQHJWggQ26s31aTHFbyFAP95n?=
 =?us-ascii?Q?aN0RQiw4WpJqm/bs8MWy+2ZE/ZzWxwNGUdDL29jCdC9Wa5hcskEfWxmFHK9o?=
 =?us-ascii?Q?tt+agaVPsCjpkJofJu43g2bM1SADbH6YqKniA0cShLKPzzKjgmYp2xucXjNO?=
 =?us-ascii?Q?FrSD/GNQyqmZnMoN13UbJZsd0N3lZGIW6xe/UAGBEYBEkN4ttcZur3zeVQ+A?=
 =?us-ascii?Q?5o0S+Q9DI9JQM+dEIXKxs/QN1kB34N8r+s7O0WdZxk+LIq8WJTZX19X8MhI8?=
 =?us-ascii?Q?S6FDnQpY2BNOuacTxLovj5t4D8i7KA2+1LK5vEYCqxMfi0cO8ImhA8O3vxg7?=
 =?us-ascii?Q?x+mxju/rrM5LTM9Ov+VdgGz1ZTfLxZhqAMDfD5L1v1p7JZHrIZxZYFukhDB5?=
 =?us-ascii?Q?3gkdO3/KNUx7zxg5tzJsiel8IaX/Gen0OqDERwbogxR4PoFcXpz1V1TM53oc?=
 =?us-ascii?Q?zu1nOg10IRHRImbra5n8jNy6UJf6hqDoS9zzrNQUAf/p3kUwQAWtND6HCHA5?=
 =?us-ascii?Q?AvdyB1yOj78On7Nbxf1jRJ0MAjje54hzH6+2eqwt1//vPme/fk7guC28RKyj?=
 =?us-ascii?Q?/hgQBpmvnJzEJ/b6d8RYZ9OHt52jUbE/dw0N1mJDpwKr72R78W4GF8aNC6sE?=
 =?us-ascii?Q?mb2bNsLJKpr9ndjrjrlfweENDE/EeL9/cygip+Xa7qyvlQb/1dqb+GuNXMQz?=
 =?us-ascii?Q?B5zdyl15pJQgzfmvOXRdDochgI66ryPkfpto6VHstf84XRICkfPdCtm7TAZm?=
 =?us-ascii?Q?GCaLhR5fy6cgbV2jIPDImleQZR4Z/GywvNmq9Mq+z2xT58zWZ8MmY+uqkbqv?=
 =?us-ascii?Q?ttSLEeN5rEp6CYWTZ/ee8a1uVEZjDvngFIiuRcRGtN1p01NHDavIDJLFB2AW?=
 =?us-ascii?Q?vlEwloTwFmg4wV0xNmC7E0kxBb0ux5YvlsioWGxi1zIEiaM7OQqidAeJvlst?=
 =?us-ascii?Q?6PORBIjDDm2qP6dIOb2oi5bVhn7ZxlB9oRR57tREG6szZOtPQoT+BoDwJsBx?=
 =?us-ascii?Q?vB22YO6TJJyQJoLoPyijVfW2JH8JGgOeritH2OGx4h5AWLpNMCgl4/caxC8B?=
 =?us-ascii?Q?vxYOadsFwCpX69zhGfSmWfqO4qzdakaK0tNvrAtdaci3C0c1ZWs3Sz9JSnw4?=
 =?us-ascii?Q?0m8q8a+Xa2JtvdeGwrL/S1Zf+kpHmi7w1E3Uu5BeIer0kSYjcdPRZ8kGzl9P?=
 =?us-ascii?Q?1CshUyD0PE1O9GSk/NrQXL8PNBJ4p1o5RmEXhD9swuQt00JlSO46X4qD5XuX?=
 =?us-ascii?Q?aps+Z0Z7OWy7w27Y0a3QF44z8/taP0+nYrJmYi39pe0f3Kx3PPkNa3CZEnF0?=
 =?us-ascii?Q?2i1GD0gWNBBwppUadze+sXAEGCdjmB3REluwDBtYZqGRA/ykdNwuACMStRFB?=
 =?us-ascii?Q?KnbB6I5rkl59SfsiXMH+tXQsWIgLZYNV6fe6lBe7yDENLuIU6C5PY5NW3dgR?=
 =?us-ascii?Q?qQFPZOoX8aUFUQ4wmbmQahsiyoEDzO92GgAzJAjg2KbM9jjZdj4nvwQt6NPU?=
 =?us-ascii?Q?JKzp4/mMJw53Nrcp+9pnQ4kyaH8dc1jMJgbJYMOLQrmR0GWPOEOAEJ9E6jRt?=
 =?us-ascii?Q?GM4nMXkL9NiS6/uYpjiNrXVlY6kPCx8EF7TylGr9hOkeUy2nJMxofO7EeRes?=
 =?us-ascii?Q?4a/yxCTbMg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a01a74-9e2c-44f6-487b-08deab1e37a0
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:19:00.5722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGPQr8Oe5yyagq7C6QupnEVgVkkm63iOyRfD3+XFKYnay56QW2o6r54wEMOcyr63Yr002AirxnaZHyKOTU5slg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
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

On Wed, Apr 29, 2026 at 02:17:14PM +0200, Michael Walle wrote:
>While working on an ancient P2041 based board, I've encountered
>several issues.
>
>cpu_init_r wasn't called anymore, but u-boot was still somehow
>working. CAAM was reading/writing on address 0 because pamu_init()
>is never called if secure boot isn't enabled.
>
>Since legacy ethernet was removed, board_eth_init() and
>fdt_fixup_board_enet() won't be called anymore, but the functions
>are still defined. I've just removed the ones for the NXP boards,
>though I think the code there did something useful. But given that
>it wasn't called for two years now and nobody complained, it can't
>be that important.
>
>Lastly, because I have a p2041rdb, move that to a upstream DTS.
>Keep in mind, that the uboot dts doesn't define an UART, so any
>output was broken since the move to DM provided serial support.
>
>Michael Walle (10):
>  powerpc: fix call to cpu_init_r
>  caam: don't write memory at 0 on PPC
>  spi: fsl_espi: fix read transactions
>  boards: remove dead fman code
>  boards/nxp: remove board_eth_init()
>  boards/nxp: remove empty fdt_fixup_board_enet()
>  p2041rdb: use the upstream device tree
>  p2041rdb: support SDcard boot
>  p2041rdb: update README and fix typos
>  p2041rdb: remove NAND defconfig
>
> arch/powerpc/cpu/mpc85xx/cpu_init.c           |   4 +-
> arch/powerpc/dts/p2041.dtsi                   | 138 ----
> arch/powerpc/dts/p2041rdb-u-boot.dtsi         |  19 +
> arch/powerpc/dts/p2041rdb.dts                 | 127 ---
> arch/powerpc/dts/p2041si-post.dtsi            |  43 --
> board/nxp/ls1012afrdm/eth.c                   |  10 -
> board/nxp/ls1012ardb/eth.c                    |  12 -
> board/nxp/ls1021atsn/ls1021atsn.c             |   5 -
> board/nxp/ls1021atwr/ls1021atwr.c             |   5 -
> board/nxp/ls1028a/ls1028a.c                   |   5 -
> board/nxp/ls1043aqds/Makefile                 |   3 -
> board/nxp/ls1043aqds/eth.c                    | 501 ------------
> board/nxp/ls1043aqds/ls1043aqds.c             |   4 -
> board/nxp/ls1043ardb/Makefile                 |   1 -
> board/nxp/ls1043ardb/eth.c                    |  77 --
> board/nxp/ls1046afrwy/eth.c                   |  57 --
> board/nxp/ls1046aqds/Makefile                 |   3 -
> board/nxp/ls1046aqds/eth.c                    | 431 -----------
> board/nxp/ls1046aqds/ls1046aqds.c             |   4 -
> board/nxp/ls1046ardb/eth.c                    |  71 --
> board/nxp/ls2080ardb/eth_ls2080rdb.c          |  19 -
> board/nxp/lx2160a/eth_lx2160aqds.c            |  18 -
> board/nxp/lx2160a/eth_lx2160ardb.c            |  17 -
> board/nxp/lx2160a/eth_lx2162aqds.c            |  18 -
> board/nxp/m5253demo/m5253demo.c               |   7 -
> board/nxp/mx6sxsabreauto/mx6sxsabreauto.c     |  52 --
> board/nxp/mx6sxsabresd/mx6sxsabresd.c         |  78 --
> board/nxp/p2041rdb/Makefile                   |   1 -
> board/nxp/p2041rdb/README                     |  34 +-
> board/nxp/p2041rdb/eth.c                      | 210 -----
> board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg        |  11 +
> ...{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg} |   0
> board/nxp/t102xrdb/Makefile                   |   1 -
> board/nxp/t102xrdb/eth_t102xrdb.c             | 149 ----
> board/nxp/t102xrdb/t102xrdb.c                 |   1 -
> board/nxp/t102xrdb/t102xrdb.h                 |   1 -
> board/nxp/t104xrdb/Makefile                   |   1 -
> board/nxp/t104xrdb/eth.c                      |  91 ---
> board/nxp/t104xrdb/t104xrdb.h                 |   1 -
> board/nxp/t208xqds/Makefile                   |   2 +-
> board/nxp/t208xqds/eth_t208xqds.c             | 723 ------------------
> board/nxp/t208xrdb/eth_t208xrdb.c             |   5 -
> board/nxp/t208xrdb/t208xrdb.c                 |   1 -
> board/nxp/t208xrdb/t208xrdb.h                 |   1 -
> board/nxp/t4rdb/Makefile                      |   1 -
> board/nxp/t4rdb/eth.c                         | 152 ----
> board/nxp/t4rdb/t4240rdb.c                    |   1 -
> board/nxp/t4rdb/t4rdb.h                       |   1 -
> common/board_r.c                              |   2 +-
> configs/P2041RDB_NAND_defconfig               | 117 ---
> configs/P2041RDB_SDCARD_defconfig             |   3 +-
> configs/P2041RDB_SPIFLASH_defconfig           |   6 +-
> configs/P2041RDB_defconfig                    |   4 +-
> drivers/spi/fsl_espi.c                        |   6 +-
> include/configs/P2041RDB.h                    |   2 +
> 55 files changed, 61 insertions(+), 3196 deletions(-)
> delete mode 100644 arch/powerpc/dts/p2041.dtsi
> create mode 100644 arch/powerpc/dts/p2041rdb-u-boot.dtsi
> delete mode 100644 arch/powerpc/dts/p2041rdb.dts
> delete mode 100644 arch/powerpc/dts/p2041si-post.dtsi
> delete mode 100644 board/nxp/ls1043aqds/eth.c
> delete mode 100644 board/nxp/ls1043ardb/eth.c
> delete mode 100644 board/nxp/ls1046aqds/eth.c
> delete mode 100644 board/nxp/p2041rdb/eth.c
> create mode 100644 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg
> rename board/nxp/p2041rdb/{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg} (100%)
> delete mode 100644 board/nxp/t102xrdb/eth_t102xrdb.c
> delete mode 100644 board/nxp/t104xrdb/eth.c
> delete mode 100644 board/nxp/t208xqds/eth_t208xqds.c
> delete mode 100644 board/nxp/t4rdb/eth.c
> delete mode 100644 configs/P2041RDB_NAND_defconfig

+make[3]: *** No rule to make target 'arch/powerpc/dts/p2041rdb.dtb', needed by 'dtbs'.  Stop.
+make[2]: *** [dts/Makefile:64: arch-dtbs] Error 2
+make[1]: *** [Makefile:1427: dts/dt.dtb] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
+powerpc-linux-ld: board/nxp/t208xqds/t208xqds.o: in function `ft_board_setup':
+board/nxp/t208xqds/t208xqds.c:422:(.text.ft_board_setup+0x68): undefined reference to `fdt_fixup_board_enet'
+make[1]: *** [Makefile:2109: u-boot] Error 1

Regards
Peng
>
>-- 
>2.47.3
>
>
