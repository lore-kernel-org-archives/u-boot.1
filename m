Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EFED29DE8
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45E9830E4;
	Tue, 13 Jan 2026 09:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="by0OBH8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0EFB8389A; Tue, 13 Jan 2026 07:40:43 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA3E83678
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc2HEfX6RANB54USzUQ442Xww23tg/G7GbzWvKSkruGswN73geTmdv0jfJPYKIWVWDzcvubpNtjIEbU8sokcxsn+7i5jQbjMxU4blzZsMMQkxFJoc+wK1FX22LlBGyU3EBVwJQUz8I0CqZFABWK1ifSbB8gXoV2p/h0+oJQaNOBS66Vks2X+jnBw3tjXjoCMyjSKc1Bd3CWtJMq9siq7/9OzFSkI4WvNbKhaADxETkzV1+uo31TyyKMRU+JNgxHlIvU3S0sw9RbDrTkDj2UkaIpUEQD+IXBbkGz8zZk6P5c+fS2v33sabf0LwODj5kPqntpA+UztV80JA1m2Wev4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MuRSCXtYwtHwaWjfIGy25lV8RD1+klI73iDhJGgkFM=;
 b=ajWVlNP7lc+JTxraiQqCodYeG4Uo8Na7I7rp4GmkkAa/67FcvEBmo2eX1Db3uxbESv6zDiVZRDZCqZildx+jX1SiJ0Iyyw5e4t3DFhNjY1dHgORNhyLsuqiBJf3//lEbRNVS60WZ4PIVkF1COMmwKSkO43FhKPYQJK9TFpxBck++5mwghIFm4A8+w5Cx0hM5qrdLtYGFi3b1H5PB96/QgHeU6PyG3wuYE0ukYXASE+sDlidqvSzKtfdR0Hn4wX1/CXd8V/gcCcc2+siyyLlyV3dzneFB8kAW9pjQ7AaiXCkYW5/bMo/aU6fzu2ketWZojxJoVBvHGtfRSCp21J1b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MuRSCXtYwtHwaWjfIGy25lV8RD1+klI73iDhJGgkFM=;
 b=by0OBH8zmxH510zcuCn1+5nToAk7Nj1IK3XXtXIYAHmMTajYS4HmWsHennj9XjTMEglSLTl+/IeVO7SAUnRas9P31Yg8EcqqoOrUSZ8RUVqaFiXemNo3BAX73ZWD5Q8xSnCcBDpvnMEM0uLxoK7DYTJWpS1RlUR6u1YyGeYrB7jB6zIxAEUyGGqi/8x+LChVqpaas7bmmvyfbv02zlrNiolGNe7dUA+WdVVHMw03WSgRSO1RI2RN5pdkH8kevUvVQWyvxNCLtq7zzqhOLNL6x5jLNMlmSR3Z17NKrFWxhBaowbcFrmCuKiHnbavj8RjcERHISaFOYP1kdyVmXLLnKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB8236.eurprd04.prod.outlook.com (2603:10a6:10:245::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:40:40 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:40:39 +0000
Date: Tue, 13 Jan 2026 15:54:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yanir Levin <yanir.levin@tandemg.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 Eran Moshe <emoshe@gsitechnology.com>
Subject: Re: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Message-ID: <aWX6Sjrdr-u3OA83@nxa18884-linux.ap.freescale.net>
References: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae85269-7390-455e-8ab3-08de526eaa84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O8eGmStFQzjRS5EYD+CEau7XvPjo6UO1QvEECYfbBkt1zmFU52GaNNnQomD5?=
 =?us-ascii?Q?fBpwgqRBuUGVyHt/XPlz0yUfA6iVdIrIQub4TBA1LjgOKnYGvzgBMjBbi4ns?=
 =?us-ascii?Q?trQlN0jngHLd57qPT/q28zwiiB8zN2D7eulbfk5zX0pCS6vijPVqaDPIb9Mu?=
 =?us-ascii?Q?g+nVBQBWubbQiu4FyraDuZDCZbb6U8tqXI6+XZ06L8fnRBEkbdAILH8UeZqp?=
 =?us-ascii?Q?KCVBiH93pxvVfpNAhMlbJSAPALiXZ8Dv0bHWMT2AmKZnx5gA4xYHHJfRtagm?=
 =?us-ascii?Q?r6g9dKlH9vdE1p4sR4wozd1Wp7N5fs+6kSC56bYizxAVK+CriOsI2c7uHi3e?=
 =?us-ascii?Q?o4rpsPzFV/p7CZhNeErrhQum4D9KeTxQ27KJcAQP6q/4Mz3kolO/8Cvln0JW?=
 =?us-ascii?Q?alJtQuAC5r6RXWwiLxzNc4OQaEJmnGDoqD8N9p38sKIsLSixweXjLv0fip/V?=
 =?us-ascii?Q?V3/CeoqcVWhvkTsBihCiETp1bTkj7TJ9DXcVVG5H+xhvD7e6nVSiMwkDbIM+?=
 =?us-ascii?Q?AISRc060ZGD0WmktVx1TGEY4DGcpA+EGN+macx7FfJSkbYzt9fgYaUR4WNod?=
 =?us-ascii?Q?ayfiHm//MF5/X5jg5Wza08DbGUKgDAey+xxCQ2RMU5Iv6HLjjV0fgSIQHD+z?=
 =?us-ascii?Q?4PGmIa7QQiSclKlhAYnUSbx+uMcnBU7ERugVGgKDrnQ4ug8Zn/g1fwBuaCqn?=
 =?us-ascii?Q?A+4xtLwxvQown2KhbZec1e0ikt7HeH3Vqt8uNQ/fT9CfQC8zQjdIhfarbPKv?=
 =?us-ascii?Q?UWuez9G//uqNr45dGrT8ECvwOlrs/CZihcHKQE/t4rAiP+VzPfWHuB8xcNel?=
 =?us-ascii?Q?SwYmvxjbN27zIFfbFUD+nFKbXsYlTwzaAIzcdC0o3d8UfDLFcd/AE5YeTQ+W?=
 =?us-ascii?Q?z94KelR1qIjEJJHG5Rmejkg8f5Z4VhuT5lA756pa0OlS4pQqS9/6X32G/N3A?=
 =?us-ascii?Q?mdeDpxdJKlNwCchMGZYMqGnpajmanNuN6tL4opFYp1vblMpKVWeMca7MDBt4?=
 =?us-ascii?Q?84ZUSabQ6G/LbUsT5d8qdeRfrQUQZg4cecCZmEAeCAzsr0GC7hte93n2LZPo?=
 =?us-ascii?Q?yoskam09rsedNWnKKSko0OfUKH6kX4lPuCj/NZTANFhxT+obKchHSuzthYXe?=
 =?us-ascii?Q?EYPILQ8rICQPEge9v4XCxJKe2cVtRGj70kK2U8oin4xkS3a3KiDKTqPgQksy?=
 =?us-ascii?Q?YYE0s5uD2SoXfOhaUbsmA7F5+vviCpWs3CbB5Aw4wCVSdSs260VNNUJdbFh7?=
 =?us-ascii?Q?lu9Q7b4SGXXtDpgJKrh/Tj2BODLX8ODnHPZ1IM6XaAFNUkCoWeJ+ePACKvOt?=
 =?us-ascii?Q?mby1eMyVLPxR2e2/oQq5joPIElUckfpRPxuHC34eLMcmq2aFDVceQxEkbmK5?=
 =?us-ascii?Q?YN48ORkgW3SVL7qF1NGyWXo9me0Aps2S1aSON4uFWGmOlR2dtjCWZh8osuzK?=
 =?us-ascii?Q?ROKGVTbgH2t1YHHUoQyT4LnWoJ+VNWf0/XWnC/C+85e5FLzriHPxZQCHdeUm?=
 =?us-ascii?Q?3NIMSiFA4k7yEw0g5QPrwyCIWp+79Dd74IKt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSV68/2BHclECoO1eU3ezaQ40VVzSrtjrigctXuYMRhXmi6KNpsL5f5Qjue8?=
 =?us-ascii?Q?bJ+mmlb9tTSGApDj+PsZFYE8mZhiFpQjJFm8VP0ml0xEIKYC2vPV3MIop2zn?=
 =?us-ascii?Q?IiNzJneemO9hZ0zrT1qmfNk6SEmg/Qtf/JnPLqJAAwgp96DU6z97ov8HxNmV?=
 =?us-ascii?Q?WN55Pwz5Gon85G+XUeHuvAsgoAfvJLtQJ/PgodjUHhDcur03aZ/xXeMSIyvV?=
 =?us-ascii?Q?a8DCgKa0G6MKyB2e9ZZPmYuuAppXMPnJT6z7GX3Il4lHjIbVtxWqYKMbgcEH?=
 =?us-ascii?Q?70xu5s9RWqQjBe80cdse2LuzXaSRDHMsBlWfkN7JB79U2fLv4ahKlKdWwFX2?=
 =?us-ascii?Q?itqmaQWmtTN+DV9Zze33wdxyG7YIYpKz4ZZke9h9H5Yp58BxYbKAuHCKuKDg?=
 =?us-ascii?Q?lVrnZ9mkZFkLWJjXyYBHy6DvEIInFkckpsAarBoJpsp6GvscD4EbIJccgbZf?=
 =?us-ascii?Q?0Kcwv/ImmB7aLluljp3Ygs+JsK2xfFzBSY33L8QYSbKzseOQ7g3QM41YvMRs?=
 =?us-ascii?Q?fnyRRI89t+S6n8i+UZGZVzFNkVlt8Ac3U2Q6cA1mT0OLnN0nDWa5FKW2bdLI?=
 =?us-ascii?Q?YeJwKmCCa8mkbP8Zvli0CQDfBYihqGqAWboIXwpcf/J+6XQ2IlMIES4BZK3+?=
 =?us-ascii?Q?Dcp7NHHEd1Lp3hwt8KRdwTK2fO0D7zPq9EtxKDxZ2bHrtv/gHTGeHo84C5To?=
 =?us-ascii?Q?Q2/HL7Pw0UNVfWd0lpYoVFi2z9F/rXKGxfgD6SVXnIuVCjoskwu/Zm6aA5hz?=
 =?us-ascii?Q?aADZBH4FqNr1NpXytFhsR9XucE+KYNdCZn1f85dUQH+6bt/nx0sDhqrXL5zR?=
 =?us-ascii?Q?Ls7waZc6zFbEZOvxBokFutL+wxvudyOtCN1trTmVFgP7EtMvDd00TGS9QisT?=
 =?us-ascii?Q?g4jipVIDLBv4Se7BGck+dpq1NCv6Az48NwuMVZoqF3Drw0PZ29EA5yO/yyUu?=
 =?us-ascii?Q?nJGCzRUyfymcxdzfWOALKXln+9UpXMMoJBQgjp5ZgN3dgNpB5n3huy380HP4?=
 =?us-ascii?Q?Tq2j+jjGx3Ii5rsv+rP50GDnrk3/S1zYDhAdsLnIc8vCqGgRB1pykTIE5P/q?=
 =?us-ascii?Q?YMBhb5e4vhGGDR/WKZzMLVG4uvztIcCiYLvznQtjTVrTsCNhGKsUUYPBPEAb?=
 =?us-ascii?Q?mVE/YKTcf4LQ/wMwctvIgAEj/6YcswkKuWsEANpCYNaELl72kxL/DgwNaNcq?=
 =?us-ascii?Q?AxivSaXYvhbF8wYMbjHOuitJztGoKX1UE6I+fdkr03+0c7oyd3c09qvujdTV?=
 =?us-ascii?Q?GgcGbqQc0jvP4s0L0wdVX1y0srqPsoDLWgTLnMBLRSLnAJuTVfnInKuQ37Qo?=
 =?us-ascii?Q?O4tuP/Yiypo5SjKwdpGK0dztJpWzNhFq19i1evDPfbJeuxklOZnRh8I7NrNz?=
 =?us-ascii?Q?vgsrUHPm7NRX2TXze/+muHiztMe34FO/kakzUOhGMcnUf41kVPffE50VO6LU?=
 =?us-ascii?Q?DWhaV1NOigemiByF1pVB5ypICnd4LttluEgVTN2kVVnsQjZUt0qgpD5y2cqf?=
 =?us-ascii?Q?XJIEDmm2ZDtcbjNVNcaSjZid6uCJdhBu33HPlmjTLk712Q4X51JEnNZxu4gQ?=
 =?us-ascii?Q?9U24DChvteiHBnjplTKYBfNqj8jSgyCd5AtXuyXXcw8VZL3Lvl7dXjfxq2nt?=
 =?us-ascii?Q?GgzHX8vPOVHUp1fFBGxSQ305hAktPeURQhuQvyJONmTWXOZVfY/HflgUJEwB?=
 =?us-ascii?Q?1lVl8Re+KLu9u84oZwIrEIq7ugYheA6RHvdBLcaEIMf28ndD3FOQclZ9zuG5?=
 =?us-ascii?Q?BU/Nbe7HcQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae85269-7390-455e-8ab3-08de526eaa84
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:40:39.6015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiKdxbcORmrXO2JgN4mbSdgZLAiv+znzWAB6qN3Em9OD1EeLQ7fYhTyVpTLd7n8fW0bortUzFFII18D1xot6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8236
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

Hi Yanir,

On Sun, Jan 11, 2026 at 08:21:13AM +0000, Yanir Levin wrote:
>In sd_get_capabilities an ACMD is sent (SD_CMD_APP_SEND_SCR),
>which requires sending APP_CMD (MMC_CMD_APP_CMD) before.
>
>Currently, the ACMD is retried on error, however APP_CMD isn't.
>In this case, when the ACMD fails and it is tried again,
>the retry attempts will not be handled as ACMD, which is wrong.
>
>The fix performs the retry attempts on the sequence of
>APP_CMD and the ACMD together.

Did you meet any issues, or is this just code inspection?

Thanks,
Peng

>
>Signed-off-by: Yanir Levin <yanir.levin@tandemg.com>
>Reviewed-by: Eran Moshe <emoshe@gsitechnology.com>
>---
> drivers/mmc/mmc.c | 41 ++++++++++++++++++++++-------------------
> 1 file changed, 22 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>index bf82c515600..c1146ab3648 100644
>--- a/drivers/mmc/mmc.c
>+++ b/drivers/mmc/mmc.c
>@@ -1389,25 +1389,28 @@ static int sd_get_capabilities(struct mmc *mmc)
>                return 0;
>
>        /* Read the SCR to find out if this card supports higher speeds */
>-       cmd.cmdidx = MMC_CMD_APP_CMD;
>-       cmd.resp_type = MMC_RSP_R1;
>-       cmd.cmdarg = mmc->rca << 16;
>-
>-       err = mmc_send_cmd(mmc, &cmd, NULL);
>-
>-       if (err)
>-               return err;
>-
>-       cmd.cmdidx = SD_CMD_APP_SEND_SCR;
>-       cmd.resp_type = MMC_RSP_R1;
>-       cmd.cmdarg = 0;
>-
>-       data.dest = (char *)scr;
>-       data.blocksize = 8;
>-       data.blocks = 1;
>-       data.flags = MMC_DATA_READ;
>-
>-       err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);
>+       uint retries = 3;
>+       do {
>+               cmd.cmdidx = MMC_CMD_APP_CMD;
>+               cmd.resp_type = MMC_RSP_R1;
>+               cmd.cmdarg = mmc->rca << 16;
>+
>+               err = mmc_send_cmd(mmc, &cmd, NULL);
>+
>+               if (err)
>+                       continue;
>+
>+               cmd.cmdidx = SD_CMD_APP_SEND_SCR;
>+               cmd.resp_type = MMC_RSP_R1;
>+               cmd.cmdarg = 0;
>+
>+               data.dest = (char *)scr;
>+               data.blocksize = 8;
>+               data.blocks = 1;
>+               data.flags = MMC_DATA_READ;
>+
>+               err = mmc_send_cmd(mmc, &cmd, &data);
>+       } while (err && retries--);
>
>        if (err)
>                return err;
>--
>2.43.0
>
>
