Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBFCECD9AA
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4B183015;
	Fri,  6 Feb 2026 01:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qKf3lwTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453F28341A; Fri,  6 Feb 2026 01:33:13 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB39800AE
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdCDpdlzC/ELnxTLxqXcprCKs6pWDsJbP0efmg8+IYLJIhUqDdAwCf0Cr/I9LO3cQPR0DRnO/yq732PO4xptawTQlA95bd5UBiJev1v1XNsbSjsw6PgFx5Kkm5C3vuUvfzQyXZZTtT86XYvZ+FiQooYyc9Q4taxII3/yxQ+xuoCcSyqM5YP1ZFAFgIgL4oInNwALtaljLsYj5lf8wj9r5QuI8DWrEmT7n2E/qUDMJCsleIwWIuhh94RIakhgulVaC8IMl05q5lJTLSZ73kVa3qPIlltgIcm5NS1QacV7ZVlAhKZI8HiRxmeMmAocv4Gv/9O3GVRWsP6zVs0Ll8zJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pECqEeTaUSQIxR/NdMPD6bit0pebBI1KdcqCjePuQJM=;
 b=xQrRp2ZxpDMb1NdzzADQGJXYPgPpqx6+t90B+7HlmUqm7z7uwvqWWSbISwZPMZ9O8iMev7//v06kId5k9cvT6HIrDB+N2D9yTnc7bxkM+0l77KO8HrH/vmvzo6NylsVpkkWp3sWkrfu0Qz2IamZtwC/IQIdNw3Mxy48CuYK5OjZ5BqS28VWEqVbpHV3YdGy/Ldz+cP4+wOP1lPhR8lF0ahz7E/TKecAhXBUekHbVpD77XNdnEA1OcroRkUXLg9kaQTwWOhtPB9piNJxhoRgPfDD094v5s39/mHcPlR/uTpYTn1v2b5qgK7RjC1LJe/rUGRz3PySlRTj/b+W54c+nXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pECqEeTaUSQIxR/NdMPD6bit0pebBI1KdcqCjePuQJM=;
 b=qKf3lwTahu8yElNuUW6jpDaCbaa4vgXkhckNWIl510CNApxDRLJJMhpfbsWrzKpAy4imDVpLeFFLAgbCa5Ee3DbMgCrE3T1emfivx2XjdYIREDdCXPEsEiB8NynZMuJXutwVLVXKiq/OYheMvavEq/VfKItnd9JUax4z3zvZ+cMI2bA3WWDV8cgqVAqqumfcH4KH+/E2pi7rzGP11w6hsFj3wG7Mu9fp0OaUC29Oy4Jz7pHLnRC2CPiz8Ypp3zk8OtAu1Anl5xY5PDluQLd6klFwTMveUXaTgK/RNv7wuVgjZk8n6emD202lXdQa3Bn5xzs6LCunzyw50N1ysDq1ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:33:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:33:07 +0000
Date: Fri, 6 Feb 2026 08:34:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 01/12] imx9: scmi: Get DDR size through SM SCMI API
Message-ID: <aYU3H4T7shROL+60@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-1-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-1-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10925:EE_
X-MS-Office365-Filtering-Correlation-Id: 692940a2-ca90-425e-bdca-08de65174be2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mMKcqdyhdPLEjRIaEK1rEvuvUAeZnOTj6mtZI06p/K0168v1hNAivuFuj3rl?=
 =?us-ascii?Q?k59Gc+X0bZ7AL33Ho2WxQQHaXPQ11zyuPstg3mHdKqF8Jla8JeGRYOBaABGj?=
 =?us-ascii?Q?3sDgIPNHrrfJ1SDOtLQY98KVaLeSSXERiIRn2Wtm10Ir4yB7W9446yNIqRuj?=
 =?us-ascii?Q?sAZzHDR+QmHUv/IRKdiiBRxqa78QOEazEqR581cITGSpupn+dRHH0uYIWtsv?=
 =?us-ascii?Q?UiFtzX7Vjf9rya3Xn31mwZgwcsQih2m4yyE+dUZ9+w7uFgKDE+Py9AQPRzsq?=
 =?us-ascii?Q?rx72Hj7ns0pKhXPl6Vmzw2NYsRa+pxOp4Uay5jC91MjAiDADODtcrot6vn3j?=
 =?us-ascii?Q?kqFJjNgHif0L084L18EsBhmWdOM180m65J97qb7VRRWZ9el2mPjyRV3zzh0U?=
 =?us-ascii?Q?L4mNqYuN5UO4Y2A/4m+W/WZwTBd/LjYZyjV3o8msEY3gdwpQbWKefn73tnO3?=
 =?us-ascii?Q?hQsfI8ocQMuZTv31TSAHWPnG9Sy+mjaPiUxmisEpLTNYIgSXiygVHHkg461+?=
 =?us-ascii?Q?w5zMlg/Z1EyVXNSk39AeBGeg0/mtn/s9NAQqhyupFevplNJW3osMo7qmdsCR?=
 =?us-ascii?Q?lZMkBO+xArOBujdmJzz94O9CS8itU0QjNiydocr72v5nB3ind8eQuU6Cydmp?=
 =?us-ascii?Q?WQqwfbE4Mm6n0OQF8xizS6r/dRDmjX939s1QYD9rIbqCJBs1mRl7ma1GByZf?=
 =?us-ascii?Q?SrLudsAI5lLHe9s4inTekhnMs2004T0k3k4S31heghuNAzsCO0UB2Ue4hhQd?=
 =?us-ascii?Q?KU35ULCBLqKLsOFnZ/zqrJ8T+YBDkKFaSkwmWy3W0r1D+KcXeOhP1tMqpg6K?=
 =?us-ascii?Q?LslhAJU07CLWoQfcT/HTPqepbeCguLm+o5jZKYAaItwHHHl9VGDMKc8B1pwl?=
 =?us-ascii?Q?a5TnWTZPzXZcOr2SC+ZNlZxG5EvxSlVZKqLRZ1pGtBDyODXHId55GhDnkRQx?=
 =?us-ascii?Q?NWfBJy7gNttOgzAB1nMpWDSOb4d1+YSDAPxgOf3j0hJcbhBBS1vVg9rzb2U7?=
 =?us-ascii?Q?JFUVkTu0CVDNUKFDWgi0THKXqXoSvMqbVLDU+JZ+3j73yiHEeBRBAYFNLg9j?=
 =?us-ascii?Q?Wq00bgeYzJxxivDf6X/RjSEbWquNG8tsmS+mq5L6eDYhcZ9nm6a72Znn3biH?=
 =?us-ascii?Q?PMLuuCENuqJ0w3zCi/Z5XPmDg38cEbVSw5yKCF+XairuIc9+a1MGFcKZKAT+?=
 =?us-ascii?Q?HBBFiOBY2KoCNjfK63MrLSRX1RHnqQcyYW4NP2puW3vgvXUVVNu7x+HmerC/?=
 =?us-ascii?Q?WSxM1NPBOdkAbYPE8AmLzcKhT60pW1JRFN7DZbiTKLO97WIN1k4Jsqa3mLLz?=
 =?us-ascii?Q?ZCsvIzgbbftMwPvrGL85hFvCuYGgFnVPgkhZwSHjwjKP0faJzIczZ4ThxkKQ?=
 =?us-ascii?Q?vnNh+R+W9v3RNH0pvzIJ0EVXPKBLAqF1Hu1W6XqBdde2AVWrQsNxOHOIGOWi?=
 =?us-ascii?Q?qFBGCd1d/YS2FSdkidQxXTX8/zcfwTfIGfLabG6NRKzZhfXg+pQITG1DoZeP?=
 =?us-ascii?Q?na9tk9KeS5cicIyCt6uoax5XpXHO+JnBXZHfIbV81WqnG8IoGyOXGMTxMx82?=
 =?us-ascii?Q?ezUBpMObp4eGN1JbIRCXA5NN88ROIF1XUZ/tkthhcGnHjRWwNt4tQVE/aiAn?=
 =?us-ascii?Q?/nCAGCkA+Wiwnq79b3MKxBw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jVXLpjzaKn4xXZLBiH+IuqrwQIczkZBYRyVLCDd+rcFoIDo8QW3hvVaZ2T76?=
 =?us-ascii?Q?K3qcce0VDgFoKBMJiuzJU/ej/HbwqaMO7mfIEeKy+au97mwjuDqHEO/NMJ5O?=
 =?us-ascii?Q?PvEhTbVj/yMvlTbDVpbQTlaHcKi6RvWOYZVBkh1BfEhoZO/FmiRuP6Ef6db8?=
 =?us-ascii?Q?lOXytG4RR4c8iMH8vAxQ6RyAxVCv4JMHrxC5Z6v5Ana0nYTBey3CBWNogykq?=
 =?us-ascii?Q?/rCnNU9G4QSUwrsFAMowSEGRv7IVWlj+c/YPGp164f3phs8oj+6yn5mBgng2?=
 =?us-ascii?Q?PbWoreX0XMXehJSO/cZzEmB0JT9rzBn09kwMDRd7k0W02crkLleyW2nOGzyT?=
 =?us-ascii?Q?HpJAtyBfVz4/bSqio+rEnbX5E92DW2HCW/o+kssRXDersAoQCfXl65mGo/K7?=
 =?us-ascii?Q?iEF0sw7JjO0VJ/Bn92DZSaudtsqwcLnYaAJItBjM1cC62dTR5vbra4+6MIOp?=
 =?us-ascii?Q?u7cRefBrq9hMIuwyj5IEODaoy4LQ9SVho5MKob6kkggrr+lpgoWQbUbZD3XC?=
 =?us-ascii?Q?e9Qq0+bYPOPq2U8akv4iNm3At0qKdO0smKmnD7ZPwY+qioFdw86xFaNDZEap?=
 =?us-ascii?Q?a71wIJWtQrX05Y6i7bNFM3J5OKKGg/aXizkVJKm+QGDn9vcq5LMKyVdDqaKS?=
 =?us-ascii?Q?VxszTRZdzoHpjsOf8PNYatvAlelz1xSKtF1Iv/evPbbFXFO7PgrObRulCljI?=
 =?us-ascii?Q?DqwVtTHSbjChcwj+KYQ4wmbd4WvavsmiJ03QFo4Y+944nuEWWtcvu4JNtKyF?=
 =?us-ascii?Q?kyToQt9xIdHMI7DGnZtmBgHR/mK2IqJPnL0khV5291xkZi2KzlhGc1qEbv4C?=
 =?us-ascii?Q?38spnHy6ztzJYqjPV9ZXlCqRKDSolFlNmIZ4tECnoUnnLSCwNTUQSyin09SU?=
 =?us-ascii?Q?JvnxS1oHsU7tvRxFRcY2mfRZwoBCBLIJ4ACqQOXvFjFec+AsYZkEnRlIRn7u?=
 =?us-ascii?Q?uxAfF2YLGEdcwQ7d9c25IWeii5qhS5t48J+TOfiU6xmCFXYSxnzsXMRxVQXH?=
 =?us-ascii?Q?oWuLeUC5T4tTQ30Joqc/Foe+vyjdoFMXfJEjIZhWqCFJog/bZ59HQLpqx9Xm?=
 =?us-ascii?Q?Hq3QGfHcqlUai+T+KF5yY32I9SNlN97exFBEF2/QNRxViz4iXKB6blKZCvZq?=
 =?us-ascii?Q?9Ss58NTr93UCajDiORN5AqD6tOQbru3eaD7NxnZsPiGmewfUfL0Y4U4TmGWB?=
 =?us-ascii?Q?tQNsALXAX9qs+O5rFlERh+E3EeeFk+UP29RCDWAHrOa/gO1Y6DVxcQJOkP0J?=
 =?us-ascii?Q?hdsefdj/RM0N6O8ETZhUsjOB+K8T4qgXvwIvU2jGaB4S6Q4Pzm6/hJdVRUcd?=
 =?us-ascii?Q?K2O4r4tTASP+RZGhUileSKK6Qb0I+A9e3cVTouqbdK0BgBI9eYzsKaiPQ4RA?=
 =?us-ascii?Q?qpeLrxbW7YnuSmOVSJLAZvHyUft9oic0euGQOnHXe1G8QJN3NFfS6PQwGs8b?=
 =?us-ascii?Q?tOhX4kadUKwprKGsgNdmaXGl6K/cE5DJUjDb1K3x2CUK88xtTQgyqFgUfmms?=
 =?us-ascii?Q?5dqUSrMeEDem0bYMvSggpgMtMPm1tqTGs0LXAFp4XJNUDKd7+6hvaadndg5P?=
 =?us-ascii?Q?IDiUjI+kD80JmdBZ5dhK9o2snwW5L8lEkGuQ0Kpg6qp407oBgEtnksyZijKD?=
 =?us-ascii?Q?RcngGyZ+23sIRa33cM3jwobW1veVYIhBtYxj9OpED3rIN8WXm+1roEmrpYZh?=
 =?us-ascii?Q?qEObOpuqx4nV2WtH+9MFNQ8khWSUNa8J34x10RW+HjQfinZNt2zYR8BJg1Kx?=
 =?us-ascii?Q?10cVVkodJg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692940a2-ca90-425e-bdca-08de65174be2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:33:06.9326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nLUTGvrTzYPoiD3lZ7GynZczXqmgyHMQXL47YaS04cWoBQ8y454LZBuAYVVX5ynyGKszXV6UUuwUN6q1ULxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925
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

On Thu, Feb 05, 2026 at 09:55:07PM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>SM has implemented MISC protocol for get DDR info. Using this API, u-boot
>could get DDR size instead of static configs. This will facilitate the DDR
>ECC enabled case which has 1/8 DDR size reserved by ECC data. SM get DDR info
>API provides the reduced DDR size.
>To be compatible with old SM, if calling this API failed, will fall back
>to static configs.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/include/asm/mach-imx/sys_proto.h | 10 ++++
> arch/arm/mach-imx/imx9/scmi/soc.c         | 76 +++++++++++++++++++++++++------
> include/scmi_protocols.h                  |  3 +-
> 3 files changed, 74 insertions(+), 15 deletions(-)
>
>diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
>index 46da7a1eff5..6c8bd6c9085 100644
>--- a/arch/arm/include/asm/mach-imx/sys_proto.h
>+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
>@@ -254,6 +254,16 @@ struct scmi_rom_passover_get_out {
> 	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
> };
> 
>+struct scmi_ddr_info_out {
>+	s32 status;
>+	u32 attributes;
>+	u32 mts;
>+	u32 startlow;
>+	u32 starthigh;
>+	u32 endlow;
>+	u32 endhigh;
>+};

Add comment to explain the fields of the structure.

>+
> #endif
> 
> /* For i.MX ULP */
>diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>index c1458ccca3c..e573736825c 100644
>--- a/arch/arm/mach-imx/imx9/scmi/soc.c
>+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>@@ -58,6 +58,35 @@ uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
> 	return 0;
> }
> 
>+int scmi_misc_ddrinfo(u32 ddrc_id, struct scmi_ddr_info_out *out)
>+{
>+	u32 in = ddrc_id;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
>+		.message_id = SCMI_MISC_DDR_INFO_GET,
>+		.in_msg = (u8 *)&in,
>+		.in_msg_sz = sizeof(in),
>+		.out_msg = (u8 *)out,
>+		.out_msg_sz = sizeof(*out),
>+	};
>+	int ret;
>+	struct udevice *dev;
>+
>+	memset(out, 0, sizeof(*out));

This could be done in caller by set an initialization value to 0.

>+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
>+	if (ret)
>+		return ret;
>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret != 0 || out->status != 0) {
>+		printf("Failed to get ddr cfg, scmi_err = %d\n",
>+		       out->status);
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> #if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
> __weak int board_mmc_get_env_dev(int devno)
> {
>@@ -335,25 +364,44 @@ void enable_caches(void)
> 
> __weak int board_phys_sdram_size(phys_size_t *size)
> {
>+	struct scmi_ddr_info_out ddr_info;

Init with "= { 0 }"

>+	int ret;
>+	u32 ddrc_id = 0, ddrc_num = 1;
> 	phys_size_t start, end;
>-	phys_size_t val;
> 
> 	if (!size)
> 		return -EINVAL;
> 
>-	val = readl(REG_DDR_CS0_BNDS);
>-	start = (val >> 16) << 24;
>-	end   = (val & 0xFFFF);
>-	end   = end ? end + 1 : 0;
>-	end   = end << 24;
>-	*size = end - start;
>-
>-	val = readl(REG_DDR_CS1_BNDS);
>-	start = (val >> 16) << 24;
>-	end   = (val & 0xFFFF);
>-	end   = end ? end + 1 : 0;
>-	end   = end << 24;
>-	*size += end - start;
>+	*size = 0;
>+	do {
>+		ret = scmi_misc_ddrinfo(ddrc_id++, &ddr_info);
>+		if (ret) {
>+			/* if get DDR info failed, fall to default config */
>+			*size = PHYS_SDRAM_SIZE;
>+#ifdef PHYS_SDRAM_2_SIZE
>+			*size += PHYS_SDRAM_2_SIZE;
>+#endif

You dropped the method of directly reading REG_DDR_CS[0,1]_BNDS but switch
to using PHYS_SDRAM[x]_SIZE, and commit log does not mention it.

>+			return 0;
>+		} else {
>+			ddrc_num = ((ddr_info.attributes >> 16) & 0x3);
>+			start = ddr_info.starthigh;
>+			start <<= 32;
>+			start += ddr_info.startlow;
>+
>+			end = ddr_info.endhigh;
>+			end <<= 32;
>+			end += ddr_info.endlow;
>+
>+			*size += end + 1 - start;
>+
>+			debug("ddr info attr 0x%x, start 0x%x 0x%x, end 0x%x 0x%x, mts %u\n",
>+			      ddr_info.attributes, ddr_info.starthigh, ddr_info.startlow,
>+			      ddr_info.endhigh, ddr_info.endlow, ddr_info.mts);
>+		}
>+	} while (ddrc_id < ddrc_num);
>+
>+	/* SM reports total DDR size, need remove secure memory */
>+	*size -= PHYS_SDRAM - 0x80000000;

secure memory size is 2GB? Need to mention in commit log or at the place
of struct scmi_ddr_info_out definition about this behavior.

Regards
Peng
