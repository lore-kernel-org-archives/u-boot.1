Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EDECD128A
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 10:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC0487D08;
	Sun,  7 Apr 2024 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="N3huMwU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DD687F65; Sun,  7 Apr 2024 12:35:35 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0715.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0FA87EE6
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 12:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqG3a+urgnwx8wiGbDrPP9jLp8avUrSXG685PoTkiv/RTeo2QEpxMhrEVHH0S4GxW462jl04OBjrFlbq/5faCroS+Ki7CDvK80nBndrt2as/hLnWphu+5Fo6Gz8ofpvhpHMuWOHlN/T4cyBpCmGUiCQU18b44cQe5OGbdgrXuVLrzqoSt+/yJMO6sNQPEDOnxVCim3y9kIDnj5tQi23gmSXelwYS746pozChPtf0sv9RIvkRIwNDIW84i/11GfNDHvZnFCqf8KneBetFehDAzayEaIFQ62zWNyE7Gz4T8WEDtuDZPRXbIf6vOyfh0+F/2CrfBhlbC5eLL21WfwfyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ur+J1ps2MihN4GQGUnL9PdTgVku/nzM+c0MjbWlYKk=;
 b=JKc4vIc8HohLRxhZWFDlX+I5xF30kjCBdMApBYEf3WwpLNtLjtwCQhy9unRkMM6TUoBDPJroE9Ksq5pYjy5VPblxw3l/hVtnP54x0U03cqc54ZbUVb4dqpmo2hFAdMSx0AN8+WfkjiHpqouoy6MxuLtz1wlWwNPBjXGKxs0yery3dzadZSAK1E+hk6HwxDI3FNtihZunTlGfr8LKMHYdE9EWDb1cLve4HDIvPKOO9RGvE4gA+TbmNqK9Ul8rSVueU4RSGhjTU2pr9Yv92rjL5DyxLXQuN/NmZ96TyatKxKxtg26ecVMy9MGb/macRfvcL66J4Wqq4mcpSr9QUqgSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ur+J1ps2MihN4GQGUnL9PdTgVku/nzM+c0MjbWlYKk=;
 b=N3huMwU0U7fTXw57ZnwckmR+Tp+Rz8fiiFqlObOgIwBehrPxWv08H4gSb30QigNkErlxTkKn/zJkZJ2kOq2OLxbfQQS3GEvynzjR/QDHL8ZhBxfItO03ahTzz0Em47M7gbBitEd6BRf5B0zLgdmveptwTgMNV0NT9v5oWUVQn+c=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 10:35:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 10:35:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Mathieu Othacehe <othacehe@gnu.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Topic: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Index: AQHagMVDT80nSMU610ixQHv1ZnD59bFcqpGQgAAA/W6AAAB88A==
Date: Sun, 7 Apr 2024 10:35:29 +0000
Message-ID: <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87v84ta2jj.fsf@gnu.org>
In-Reply-To: <87v84ta2jj.fsf@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB9864:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GyQpuvWOEC6vzJyQboHagBzW9tKKd39Fft9HNzv2DpXzxylgJJ7ox6lYb4ndNAwEzvIc9ELKks67vZfTACbpKGCcVrqx4UNrA1NIuXUXtuImNXKLKVshaNpysYDSKXRwGxa9qY0DIXFZnnR4l4vvDhcgoisauptZv3iZl4SyKh0HStrOSr2sjmgeWXscCOKX4YnCMwkvGHjdNCOemzDPSDZuWHsNCkoKyPt4SL2RkeQSSy5pcTaXW9so8pB6GcjaTNG/xLdfgqYsQrJrvLg6ROv2IvYTeV21e/VcjAGX7SM5TPG7HB7sy+cnc6XkVmPgbhz8JvFFNfwjaLmU/9GJinW/nOEUmCpVNhF9MXShV9+rndK3Y3qZwzNp7LzFijyGrgIOA8y15VcRRMYKmsOwtVD9OKNUl0bPUsnReqfJZVmIwJJDGqq2gtwnqlgRP63yKlM2vv6enqiCL9KPWsjHVSYcathxgQYX6x0Xxb4ViSv2sfGZk9JHPynHosGAYrkgD0WlAJJCXzJzo3zvpgjqosZ7ZuwqeOBXpL6vcujeupmqFip58ZeGv9WVlk/H6kVxAQkBIEeLBKeUrAR6iLPifDVD5ac+KJPRFfp6H4Vi0aM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2FSXGjjqTPQlsY3tuPdFsjQDpKwNAgBw7vvbHCuTeKe2t7ZCF1jSIO2PVS?=
 =?iso-8859-1?Q?M1CISX/5L+jGTSImvTQ9zMapGzgNgAPzD7o9nXCaFQgPnGPhUYIshZ8Oox?=
 =?iso-8859-1?Q?2kEJovemTAK2EPYSYDsCZtGneG/LqjUeZd3niX70/r52FjYOlq8CvXuuIn?=
 =?iso-8859-1?Q?LLLf4p5bYpa9F4VHsDJ3cDoJcl8TasXgF35YjiMb0V1epA4rd/n29dKDdD?=
 =?iso-8859-1?Q?sgHI1EYyrwJZBBHNuQx7qbUGzyhNd3BvauXNHLZoJtlaiwmo6+s4J1xnx3?=
 =?iso-8859-1?Q?oTCQjEOyb5riWVbDV3OrasmVK+vn2VJBW1z1g0U0RbibE4NxZ2XR9wXcbi?=
 =?iso-8859-1?Q?ZM2dzWlZdDizrsBVG0tD6IYEeIoVL/ZwoD7a++ioedypAukt63EqAcvqMb?=
 =?iso-8859-1?Q?9AT+7q/AEZ4dJrFUMgrxSoRL2ZgQRQ2VUQ0EAtqB6FTL85o73ZAk1c0cf/?=
 =?iso-8859-1?Q?JoYAWWevtvkEAognzWvKNbg9Fz8bn2b04IGEDNfAqWB5dGKhU54LY4SuhT?=
 =?iso-8859-1?Q?LEiKtIe2K96hM84uW4ra9VxCNdrpRarZqL/RRBZfskfbw/1QwIxhufwVur?=
 =?iso-8859-1?Q?tPuvu+PwC5xcM0wRjYY2o4Z6V3G1qoX2JB10VUL0K9GZnZxfhJ4+Y2/Co9?=
 =?iso-8859-1?Q?oPSRpnECJBl1+lWw5fMPHgzb3GQdHZKHHVAqQ9mvSmCGFvMaAzWpiMkUBq?=
 =?iso-8859-1?Q?TxhL6Gt2V5nUbVVwtNJ906gO6ZSnyCANtIJk5rles0ND3rvHfYFTTTyHjx?=
 =?iso-8859-1?Q?3n7EU+/I63FhJuFn+BpSY/ht50Jy++ysxfhoR0e95lgG3YqC40o9QuzESD?=
 =?iso-8859-1?Q?im/ro33VcJhrH6ZsqTcTP9RjEv+FSGaqmtCNUhzI1Zutr44yLL3xEb9ZNu?=
 =?iso-8859-1?Q?3TU72l8dOCx9/m+F5xMXiU7bA0eZLDgEmL0b5CUdbjVxLrQJT++gMmb2g3?=
 =?iso-8859-1?Q?0+u3yTB/ewHFT+dUqUSgTcs6eldGRFzVxDQHC/yw11uxNgJGCq8s7fRhtp?=
 =?iso-8859-1?Q?zumvHFGnpbWRuARh+J4H0P8tXipW5TZ3jLPzlCpzeSh42LQ/YDHzQ/bJX4?=
 =?iso-8859-1?Q?So2zuIVAJsAWVQvc8EHdr0S1Mh+DeXPP9ffNr2EgfK3mZuyZ5RSy9dD7Rh?=
 =?iso-8859-1?Q?XqxsaU4OUHvdC3hxMUSGdJgjo4m8xkmddzfBjW6U5w1B/DZghON4HkT++K?=
 =?iso-8859-1?Q?EDwpJpXMaGJyhcJ6btYJTCOreif9QBWgDTyyy5LBAzyhsbvyJjztD2sc36?=
 =?iso-8859-1?Q?vKp+mXU2IQP1NjG9rbgdsqc7esPu872ynR0pDZymvFDdfqGGXvEGwFr2z1?=
 =?iso-8859-1?Q?u0Ah7tO0+RpeQojGn5qGL3UiCb2VBpJruerLjJ/gIfxJgqRFYgXUWAGG3n?=
 =?iso-8859-1?Q?nPSlKmSaRxhwgvl072HmIkEc0f5lsilCZ5zCszPQcJUC0AJzB9nTYyEzCi?=
 =?iso-8859-1?Q?aHQb1/2s7bc42tJFwoI3lemsgc6hQtsKltCJAhFAzXmTDRgqnQmb2snf8T?=
 =?iso-8859-1?Q?J28wWdUxa2QrKawNwM3enZO6Y7VlstZobtkh+gHT9us/TV5tR6pR8oq2Wa?=
 =?iso-8859-1?Q?Ox3A6X3PQ1gZPxzFMYiRWuWecReTjVYP8xBcUeJZWpE7cGEQdaocXS5YWl?=
 =?iso-8859-1?Q?K/jwBaXXPti9w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a99bcc-f3fb-47eb-0a8b-08dc56ee722b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 10:35:29.7267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qldFpRtx07VnJUpgFyJCp8nB76YkZ5U1JKtAwUSgui/LfbFuF9a+olQzehESch1T/XoNMa/Bc8POdNZuUzk18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864
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

Hi Mathieu,
> Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
>
>
> > Any comments?
>
> Yes, see:

Sorry, I missed your comment.

From my test just now, log below. For your uart not work proper, I think it=
 is
the uart clk not setup

U-Boot SPL 2024.04-rc5-00388-g351988e2dce (Apr 07 2024 - 19:29:56 +0800)
SOC: 0xa1009300
LC: 0x2040010
M33 prepare ok
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
Load image from 0x49800 by ROM_API
NOTICE:  BL31: v2.8(release):lf-6.6.3-1.0.0-10-gf12d90141
NOTICE:  BL31: Built : 09:34:44, Mar 27 2024


U-Boot 2024.04-rc5-00388-g351988e2dce (Apr 07 2024 - 19:29:56 +0800)

Reset Status: POR

Could not read CPU frequency: -2
CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 26C

Model: NXP i.MX93 11X11 EVK board
DRAM:  2 GiB
Core:  188 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... *** Warning - bad CRC, using default enviro=
nment

In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000
switch to partitions #0, OK
mmc1 is current device
Net:
Warning: ethernet@428a0000 (eth1) using random MAC address - 6a:c2:96:d2:68=
:a6
eth0: ethernet@42890000 [PRIME], eth1: ethernet@428a0000
Hit any key to stop autoboot:  0

I see you have:
&lpuart1 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_uart1>;
        clocks =3D <&clk IMX93_CLK_LPUART1_GATE>, <&clk IMX93_CLK_LPUART1_G=
ATE>;
        clock-names =3D "ipg", "per";
        status =3D "okay";
};

Could you please help give a look on your uart settings which not work with=
:
https://lore.kernel.org/all/20240328-imx93-of-v2-v4-2-338d15a65c36@nxp.com/

Thanks,
Peng.

> https://lists.d/
> enx.de%2Fpipermail%2Fu-boot%2F2024-
> March%2F549531.html&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C46ad4
> 24ef2cb4c09f8b908dc56edad0a%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C638480826025692986%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 0%7C%7C%7C&sdata=3D9oXIZF8Ihp1OfaDx3C%2Bcq9nstWJVhN8u3U7xQAhX2
> 2o%3D&reserved=3D0
>
> Thanks,
>
> Mathieu
