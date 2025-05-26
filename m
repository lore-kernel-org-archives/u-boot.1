Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B36C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F4582CBC;
	Mon, 26 May 2025 09:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oNyvn5Ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C30E82CBC; Mon, 26 May 2025 09:09:43 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4145F82B26
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTHt1EhdlcfhmCHy4vmn0muRjxs5gEi7XmbxlU00dvzJntfSnocJAsTkSOLSA9l/YbtodmxcRWTPtcXMKoukPGbMqfXjdgD+0hniVgoDnbh2E4q63KkMPX81uTwpJIK0jasBVpz6uP2SUGDNl564P5nOrRowl4vP4XN7iwsiEtNqOoBmfRyb7fT5I4adeU8JglKGDWdBAlXt2bN4WNWQdghe92cvny69heAQVYLHpkV2XFL6t4fJcYv29zQB35vUMhAllHOx4PQk0awuzOmqRXFoC+EgHDpXxI24T5110XfB8jrhzkA2XMQ5OFkyCqny3/kAbBPEVL08gnS4nDsOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao5D7BGPWnSWipF1wvVrpquWTBuazMHrKM/BOO0C7Xw=;
 b=pRzLjotP9wNG1trtzOSPNbNhdz/QXODNjZ3RvfBzu2HfAdiJI4FRxo/1lrEWSsd3hdRHvMZ6H3t2zRTEIaFk9/F8K9uoC9nq9HGwPGPwaFLlTQMsH8o3bqFNs8zLyXGs/bY5QDJ+BByP46ZLi36zDVtk9RC0W4nqLvLM2HLeJ+g0qmWBUeSyZuL7CYphauthVsMXLsbUGJOnldN3XYfKn9keUgPaANyEYlMyTIhRoGWU4IH5B2uv1eC2/bZdRX/QROLT2JJ4DgFBv1O1tuJwgCaO5ul2iz/0ZdMjX0MkNAysoVk9MM5Buk2fqtd6FIo5RAsgvfiNF0WBsOjnfAd4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao5D7BGPWnSWipF1wvVrpquWTBuazMHrKM/BOO0C7Xw=;
 b=oNyvn5KoaJucow/9eQWLsO5Avncue61aUn4fcg3SC9Hi4tcO1BpI43Aq8A/ZbnfnrlWKIdWp8cB1paaTMrNrbiJX+RjvEljA29q/pdv+5Sp04u/3OvEmvVdyEuhUz0Swgvy9l5+sz0tnEqcMHR0/Yi+xmCcMBh+VyOXW1W3d3wjpWy5r5KwxXqop6yiZUyXVsZPhdOaHEKZqXOJ5LdMfXF+Oh9SIE49U4HRvcK27/72JPYXy1B/enLj4TwKHAylg7gEodeLvs2Kwnid82RH2yklol9TKZ4aCUcMb9f2LJ9aL5djbmILFlRY/guwrLpze0Aqe6l8aB9Pn/StbOVyToQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:09:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:09:39 +0000
Date: Mon, 26 May 2025 16:19:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 09/13] board: venice: add imx8mp-gw82xx support
Message-ID: <20250526081925.GG19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-9-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-9-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c2f868-d46f-420b-f7a8-08dd9c24477a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q2o0QXFvJexbZpshvOCXULaD3en5Z7Pp+rIe2CXgXaPM41gRIKvVJuMgVaIy?=
 =?us-ascii?Q?nR9Pbov2CyLdDTdfWrV6VZAFW0ShJukK9ERCXi6lMqggGHTpeEz/M4IDVM+u?=
 =?us-ascii?Q?14obpnteyVRDAl54PKl1h9LKj8vKSbPe6fOioZqM9TZdkAyCBAZauqUuCPdF?=
 =?us-ascii?Q?Th8mnH55NWF741GezGIreONsH14Yx2edFhcCJK+nFrcfWG+geub4veQtzQTr?=
 =?us-ascii?Q?blPx2hggZEXrcINd+FNaJMuD7WP/dyRukR1Bk9LzCyqwLEIjq5+bMRg+8Fgs?=
 =?us-ascii?Q?tTS1tM9q+XRZP0ykgfFi8J+xksBfOlt7OgoJkz8I46hQRCTXO3JpzdjxZXA0?=
 =?us-ascii?Q?0SGT6IM1Xwe7fvEFBVx/dYEZtkWsMgh40cm8RRAt922Q8wuZTnRCITyaDyMj?=
 =?us-ascii?Q?jmxY2Cl4fmUaJq26M2hKq/BvBvidMsDjFUQ9dBD0tUCCAuwK+tnt6MozTdD0?=
 =?us-ascii?Q?sGQHi8R0Ud71m53wZSwTB3HqT3dXN2Gxa9sMw0gTor/av6v0M2p1PPSi0yhr?=
 =?us-ascii?Q?YpZSbmJB5y3DN+2pYXPYIgmoiL3o12gEcVQiFkD0hlWSnmcWYKxTXxOlab/r?=
 =?us-ascii?Q?PNZ/+5gEz1CMMaeU11oyo+JrRPhxavqguYZ0yCVbgNyVTEM7tm0sodU+/guw?=
 =?us-ascii?Q?DIlEGTjkozd3Fu9ixoVBiH28FFD7S6NBZuohpIorV9ph5qfC2VMqFQiFOCOd?=
 =?us-ascii?Q?EQqjXwkOKkIgP93ZVLFHlMocdOotvHF7bm/ZDl8MBdhr0VFIExzXzbUzzffh?=
 =?us-ascii?Q?wyLJX78fXgl2VYhhvjD82Agxz0yuXp9Z/iiz+fN5oFGyKvB/yzIZe1VlCGeY?=
 =?us-ascii?Q?uaFCPg1L5LTNeTTxuyXUQRynXj4tb1qtSYwJyqzLxGzUD1ckwm3cz0NRs68D?=
 =?us-ascii?Q?cnBda3TDkB1Ojs12pl7CcCRfwX9sPnjRVA6jT6bV9U09d9ir1FDJN2Nurct5?=
 =?us-ascii?Q?rFFFBkhpAwWhdTdX6xz0sKqB6XNePELSAKdrtnoF6iKyOwumCCtSGen8RlGD?=
 =?us-ascii?Q?3VpUzSoodJgk6tOAPodCBfp7sZuhXGEzrB1nUqUc8a9evdWZMWUFLFqo4TIz?=
 =?us-ascii?Q?2d154W/MZm24sEMFEJxUEHl+nSX62JDJltqprcKEczWqzZrWZok6CVc2oblc?=
 =?us-ascii?Q?0bxz+v9m1lgkg9aBdmoIH4tNbO4ftgv4hIkOcdwDZ5LE4l5l2+tFaTStXQNo?=
 =?us-ascii?Q?cyC3cW0bq4wsHreBk4sqjxB77iaexWdUpfDmOyq4yl8aryQKUJkjKiaRySVX?=
 =?us-ascii?Q?lDukJGxRhxoEwVEOZSGSeP6ZW4Z1K0azPJLDgPq/K1frsZuu0XtEQd5uKFyz?=
 =?us-ascii?Q?LtkTcPl0H1vdH/OApJdu+F74DUkr4CLkkIEz9Fo3lyzMYTuF0TPZyp0euPcc?=
 =?us-ascii?Q?vQ2KjGtBdFhWBVitFNQCWqrZ/R0gFON9gn/Pdz6hSvz64oCQFq8Mr6iALweo?=
 =?us-ascii?Q?+90SNX6J0uo5J9XmQr+p6rBAW4QcPFuFSppvbovGvhCBgxlD0neo/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4L7UvsNUCTm9mdWLHOti5NKfzZjds6eWkjIMD4cyKLRQlynZwe08l4Gx2Va7?=
 =?us-ascii?Q?8FBjZakyl02P6EGZZOZpD+HJsJxdNWHswlb0AickwXeC5irkYz7ajfqnC46/?=
 =?us-ascii?Q?+DZkWhQ6GaToezGo7B+z856R5jGR8lQ3ZoukDq9JcS2xKYKJrMtpzdrEPBRs?=
 =?us-ascii?Q?NgzHBl8w39rbAR2AbQ+05KzDyx4QPHRbHW1424yvM9AenVegsnOHSg+mrabL?=
 =?us-ascii?Q?IJ5mMzFyzoAN/F6JK9PfCoSPODHZUwxMyOqNoon5XNwoOu9CIM3Tqp9YmHyW?=
 =?us-ascii?Q?8GGKg3egJvmLcxTQcM6CgajTGn/KW8e94S+9FEqWk7WsEHpfltttkoX6ydk1?=
 =?us-ascii?Q?q4F09M8ZBguK6vEf/1lzeUvIL7718a6oFnKO634c6WqV2aNjY0lhRfHjLNuU?=
 =?us-ascii?Q?LdcwaLjggUYLKzI97RpWf/0Ei6M/FQGHssC2zkoZ7/wRcvAQHmRoGdjSGVkU?=
 =?us-ascii?Q?ASwzHp22wmoJGbKPUdTAcR8rX36uhxXg2l0RB/lAtRgH3A4lDIxN5CN/SiU9?=
 =?us-ascii?Q?kETLVnK9kEj8gcQJgnot2D14HYBhb4r761Scl3v7dm1minLq6biHyMCUjj8N?=
 =?us-ascii?Q?L2AnnUc9B3B1AdH/rSMhXK2WrqL4xs7eRrSEQvIDP4On5tjZ1dUPyN/uaNfk?=
 =?us-ascii?Q?4kv9ZQuMsU1HhdhyE6JtkOdHDA9hr2TFbRunyPvEKtu2rUCw9M0d+TJDneit?=
 =?us-ascii?Q?uRD6/Et2dkvgF8QenAn35kFaufI0id6P5rPXYj2dV4TR17mMSjtCTngwBijn?=
 =?us-ascii?Q?JL67Etp3KeBrhX9kj2giihuIh8jCCxzLRVkoctdhnGWVn/gFcEppED4zZlkn?=
 =?us-ascii?Q?JQVBR+qwnSc10n3PxdgXL7IRmarbGNOVDXeI71RUgtLU9mtCruWFca/W8AZz?=
 =?us-ascii?Q?jxqk1Sed5f7dYH3qpuM1dQrJHwZXbpiy7u2zNQCL++QwKjZ6EuP+YRT676j2?=
 =?us-ascii?Q?g0Heq7TY1pXoxS9LQO2PRq4iuamKOAT9c51qNwgliMcsmi/uTGdP95ZcCbmz?=
 =?us-ascii?Q?dHNGHFdHCrAV7B4iXJukiv7OXUko2xfFzJQiLGAxf/UBvdYof8VAm59D9dKl?=
 =?us-ascii?Q?nIhuYsQVdOybEKrfZG7xl+2IExuVf2MejVo8VlB/Ewnx3SKnCh+liuRzrooR?=
 =?us-ascii?Q?ELThH2uDZLmAcXO9p1k5MrMyxfxATHGikDV/hsO2FfJBgj/a31OZCKIdlyKu?=
 =?us-ascii?Q?VisQXpqOVOFWY16CWDEPofHY7DYNy8TBPWox+TSZpQi44B4F02Wl6BZKsYRr?=
 =?us-ascii?Q?pmUv2vxPGvEBOkTY4SldAPXXnUoMpWDt0jSNiNxY5qAsheowhbS8eUy2Fp25?=
 =?us-ascii?Q?DJ8n2rCFcBnCiwqhxIhRDqnMsib57QTvs7XSFhKM33fLdXOVXlYL0SuMHVyN?=
 =?us-ascii?Q?npD9Smi3axX2oUQ+0nk6OayadlZmiEhDce0Gga5SOk94mLVqR0/SAkUDi2uF?=
 =?us-ascii?Q?lFCz+CwnmH3gRKhLa1zDn156JvQpnXhp7UgxQChBUMNh0ZngpzcURghzfznH?=
 =?us-ascii?Q?WmK7RhF781pQyMeI/ZDwnntc2ulUmNd8RyvhHg9bLAoZ0fQEt+mF+ed7+xZ7?=
 =?us-ascii?Q?TPn9Ucbmi3DieWqdRL2731W5vhGLxlXQ7mQfSNBe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c2f868-d46f-420b-f7a8-08dd9c24477a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:09:39.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ND0LM4nQgzPJyLVQZZJhmNj4ImEtCmpSLF/3/BPsoLTXV6o30dt+TT8NeahTLQwAkOZzrJlI/SE1FUKLXPLBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:14AM -0700, Tim Harvey wrote:
>The Gateworks GW82XX-2X is an ARM based single board computer (SBC)
>comprised of the i.MX8M Plus based gw702x SoM and the gw82xx
>baseboard featuring:
> - i.MX8M Plus SoC
> - LPDDR4 DRAM
> - eMMC FLASH
> - Gateworks System Controller (GSC)
> - microSD (1.8V/3.3V Capable)
> - panel status bi-color LED
> - pushbutton switch
> - fan controller with tachometer
> - USB Type-C connector
> - PCIe switch
> - 2x GbE RJ45 connectors
> - multi-protocol RS232/RS485/RS422 Serial ports
> - 2x Flexible Socket Adapters with SDIO/UART/USB/PCIe
>   (for M.2 and miniPCIe expansion)
> - 2x isolated CAN
> - GPS
> - accelerometer
> - magnetometer
> - off-board connectors for: SPI, GPIO, I2C, ADC
> - Wide range DC power input
> - support for 802.3at PoE (via adapter)
>
>Add support for it by providing its device-tree.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
