Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31961FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61738840D8;
	Sat, 25 Apr 2026 18:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EKrNMMV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5812D84099; Sat, 25 Apr 2026 18:18:01 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE3E840D8
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13)
 by AMVPR04MB12628.eurprd04.prod.outlook.com (2603:10a6:20b:773::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 12:21:37 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWOJlSKEKnKxvx/MpvhV6cPUTaIZuMKsNQFB+nt9CcpnBmHGbTScnuMPh17ICpj0vwhf4/ssKFO//SUfnyyyyb+WeItaQE/i+tHBI3Wldv/d96sA4kYjyQhMIYuacTYbBW8l/VVM9+oNiQz0R85WRvNnIiSb33+x/6QwFhJyV6Q15xnB3SpV+hx51kSkZURBo99nNtnWHiUSk+9qR/KnZp/mLqWErDT0WIH1DfHXc3NNTwSgTuyFp4a1mtx9JE1bIc/OkvkiuVmVNWv3BvSNy1U4wQFv9+M1UE1VrVVeUGWa1yRyAOJiuWoDOxfliT9Mpq6DqkKXxayYXCnuK5fBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVjLBsLEpbsY7oH2Xgyrh1+9rUZYgYDQCcIvUGt0Y+8=;
 b=XKXdkxmiELMcLrV/UYBcIrL3Zus+4Rblf7QqaMIdNw5q2btJn1MPkA4hDM8Ger7WSuslw0jrpp2SjnrOdp0WdRxajNIZTaowxAibTrExKiQ2+lxrUVVH+oDCdBPShOFTCNlK3B/2fqo2ES/jeOE7GtJqU5b/2uroxp+k0XqfLv9/df13ObbiYLDllKjZhHRC1D3YpXgz0ApPX7kLs1EAlA6E4RiSpTJ2Hsie8175bYL6wfUy8GAnnFYpddGa+KDBO+cCZU3Jo7hvda1JCBL7sUqEJuxdHFULxSv9jWPjIr/oF96AW1xBnLsPsrEWzOhCRgfOIhUDJ+6VaE6fx123DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVjLBsLEpbsY7oH2Xgyrh1+9rUZYgYDQCcIvUGt0Y+8=;
 b=EKrNMMV8Y7Cp9WyXYn4E5KxZFdlyNyGoGAMvAZO95Hs6AbHB6sBxIR1/3RjH++ujHwEUHv1aN/qKib24grLcg7aCLr7l7MwiAl7lYGZRoR35J0NmZYe6vTZBNclEywWUblv740RvCeujTBJsg0L4mc/4I4YePRHnz/8EZLgaTZ5Ozk7B3KB954BMeaI+aIJo9lWRiCJgpw+EwbZOfoUSvJiwbow1StNd/aJLsMBPbaSvcXCWI8fHjJk3L6N7lD1THOAM70UNK2n8wzOhY7OQg+VsvzxL7xuCaEKh84mlj5lEPi+d/S0cBS3PTxWUYCZy4pATDKwT7VwHeB/rek2/KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:37:01 +0800
Subject: [PATCH 09/13] imx8mm: data-modul-edm-sbc: Switch OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-9-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|PAXPR04MB8427:EE_|AMVPR04MB12628:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a16fb36-82ca-4282-e5e8-08dea258304a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: WRbu4y8y86tbR9EZe8RstPuedOMWU4CTNCPsf9lByAy9OrIuw6Fu5WiJpxzk5u2y8YNT5DxVOuQpOE6y8PoKijbvJ+Gjcbik5JYNCGpVGLFi7Fy0EMH/X61dEzEEGEwZR0Q5GUzSixzktJ2SVRwuRTGQjIOe7zQfcZyz5rrBo+zJd/6nFoScwnu8p57oVhL2Orvs3BcN4d9N2OWohX9o4NdtidkBX5Sd/qsPH6qd3+8/lnI2i8Ln7d8EJde1WdrhSD63S4OvcFM6GgbN1GPkLNRZW1Ta9Zamt/JtTkfTZviye+YKSdJvayNnAMkU58psPWubnn00FK6m5GdQJc8bVYcfiTDU+nR7wKYI696CUscUtelQ9M2pdqF52VQlqHmMIiuUOJ9MeFYUaU46hdn3nqakym2zAh+CXKtX2uBvaSM9T3kf/83fOxd8a/JMTGc4NYXFl+I4a46NAAwfZNIAGnTcE8XfgdAuPrwKz3bBfhiLNFdwYSQTBYNFCPK2sM+v/Krx0cYIbY4dcBPGZD4FHfolYMdN5SxLdtbD6jLr2BUjXRCFSsPbrh8qXdiau52OTy5IHM+1a42gqYpeyL3oov4mvHxI8vj7EMfJR8lgpYc0VZ2yvFAle4zHO6hnDcssVX7yL2xhv7Yjhw7m4zpdpuhrDd+XnkiOK6h4Vz2gR6jhjagpKmCLrAWb/41gKoHdEAXcYmm4EHfoY2nFa/RJaFmoJwBCRTDjMeUUAn9IVgzljpr7LLvQR9UzgKbdIELN57qJdB4kk/c0OL3mkht9TBv9N6zKTnx6NQ10dAWrWGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1B5TERvd041VnRDUzlDemJXL2FteDZPeFpKYzlEazlSYWJvemxENU0wRlFw?=
 =?utf-8?B?b09rUi9SRFRVeitpTmVqbmlBUTJQMkhYWkhITUFyc05KbVFrMFJlaExWb0xs?=
 =?utf-8?B?eG01MHJ6RTFzeXpwVE1kODkwR0h5OHlnOVdjSVV3TXp3aXI2NGp6WHNJZlFq?=
 =?utf-8?B?Y1lWRkxRL0o5ak15c2VYUEViS2h4U2s1U0wxalk4Wis5bFpocnJvK1RYVWY5?=
 =?utf-8?B?YkdFUTdvNzRwRmpSOFgxTE5BQWtWT0tkR0ZUczJmdW1yNEJqdUl6TUUzeHhQ?=
 =?utf-8?B?eGNybHdsTWlFMlI0RGdpZ0t4YkwyekptRXFLYW1MTExyczNXNEFKaUsxQ1VF?=
 =?utf-8?B?cXNLSTRxWUx3ZWc5aWhtRlJYZGtsT3RwVEo2V0U4cjdXSjFCSTFreExja3Zl?=
 =?utf-8?B?SVRmdmJId2ZkVkh6dS9takQ1ZDhWbTYvZ0ZNZmIwamd1bVBUOTN5cHgxMUVu?=
 =?utf-8?B?UEJoekFpOG1EaXpNa2p2a2NNK015ai81U3pIQjFIYTdyaWV5SjNuelB1a1Ix?=
 =?utf-8?B?eUFIWWllUDhHMUtxSzN0OXlNNHltKytsZVZ3US9nSWlKQzJ5d1J0emdoTjI1?=
 =?utf-8?B?a1dDL2xCNGlUMkN1M0xRVUJVQUd0ZWR3bDVwN1N5bFpoeEthVHpFa2M3by9q?=
 =?utf-8?B?TDYxUUhhMTYvOGhjSlEzS2J2MVRicCt0OHcvNU1YaEgxUFFtWm91V3VjM0Fs?=
 =?utf-8?B?VDFSRkNWcG1NbW40ZmsxV0dMLzQ0OTNIM052MUhjc3BuR2t4ekFMUzQvclk4?=
 =?utf-8?B?L3ZNMzJld2RqRHhWSGlVbjFyenpnME14bWg3RFB4eE1Sbk5PcldaVFErMVkx?=
 =?utf-8?B?M25Ca2ZjL2xRVTQ5UzBUOWRTcVlodTVTSENPQ3l4eGVHcS9UOHo1ZXBaRlpS?=
 =?utf-8?B?ZEZOb2RpOWJCQWJ0QlFaMFpGSTQ3Z2ltMGlCRGk4VWZxa00yNHRGYVZNYkhj?=
 =?utf-8?B?VGpERnl5c2hRV1dsVXNXRUcxSmVYejVBM2NNUDd6S0tvUksvcEUyV0dxL2s3?=
 =?utf-8?B?eW9HT2x0QW1Mc3h4b3JpUUw4cm5hUUdJVUlHbmJrVmZkRWcvTGQrZXgyWm1M?=
 =?utf-8?B?b1BNQkJxN1lGVGxnWGoyTGNPNnh0ZGRIZ21VSjk2MFlBWW9HWTJZL1hhWm5n?=
 =?utf-8?B?clVsZUNrMGJmYytocmpMS3d0a3ltWnZsM3I2S0FwYTdvRVJyK1J1b1B3VEcz?=
 =?utf-8?B?KzFQM2hiQjBld0FJTUZEUkFVNmd6WWgvM1V6bnNmME1NZHB4c2c2Zmx4YjE4?=
 =?utf-8?B?TytmL1A0bDRYZnZ4OFFTV1orVm9CcFhhU3M0M0NVby91bE1PdGZmUi82WTI3?=
 =?utf-8?B?R3Jla3Vpc3h1cTVPVFFIZmZnaElXZ1pid1lWak5xQktpS3NNQi8yclBiUmVW?=
 =?utf-8?B?TlppK3JYSGpwTW0xWWp1cjF2SEkxQVZTeWFQUXJTZVZrUW15ZTg4WjB0Q1Rn?=
 =?utf-8?B?cjFrV1M5a0VUNjIveWxBT1BQVlJvenNWOTZ1Rk5DcXVLakVvOHd1T0YrK1Jr?=
 =?utf-8?B?c2NSK1liT2hpT3c0QTNNeEFscVptS29DblRFVnJXdmFjdWVuZXFIdVM5TDhP?=
 =?utf-8?B?aGdlcVpGRXYydEFRLzNGdzVuc0FTTVV0THEvajg1dTl6V2dZeWljVE51Q202?=
 =?utf-8?B?dDJLM3VtQVJpNTViTnZ2VWFQQWFpcytSVExaMFUzcUZ2STRUTXk2LzBuUktx?=
 =?utf-8?B?Qy85eU9ZMzNvU2ZBejNiWHV4dWJmU0k4b0NOK3JsYVRyaVpWc2ExdU5vWW9Z?=
 =?utf-8?B?dEk1bmJpSnkwSjA0NTFLUzBaOTArUHRQc1RXSkd0T2ZoQ0gxL0NRN1RrakJF?=
 =?utf-8?B?N2U1VndwSkhSV25WbGtDVVlVb3g3ajQreUYyWC9TOWpub25vbks3UnUzMDVG?=
 =?utf-8?B?dE56d0lTWERNL0hGc1AzVVY0NjFHSDdvL1ZnSGJneHNNNklvRFJoNi8yV0k2?=
 =?utf-8?B?RE1ySEpkM2RDd2pTMDJPNjdlMWY0RWVsZWRVVVFUTXIrUzBud3E4aGVNV1Vu?=
 =?utf-8?B?ZklKeUFFNzdTN2RWRm9BN0NnQ01TZ2FCUm9iTi94aGdsUkdFYmNYSzd3U2ha?=
 =?utf-8?B?eUQ2VjV4L1RIajZoL2ZkWW1rd2ZwZFYzN0lYZ3lsYk5aZlBFazRmYkVLZ2tG?=
 =?utf-8?B?bytOelU5TzR1ZWMxRENQODZ0QVRWbHpOZ0FPeWNqYXBlMlg4N053NXExSWFo?=
 =?utf-8?B?K2JGeG9STEtFcXVONGhtZW1abjBaRnBPbEhMMkRlMkhEMHZwT1I3NExsNTkr?=
 =?utf-8?B?S2Fic0d2R0NrL3lhaVA5SWxXMUMrT0VPVG9RdU52UlhVTU1mbmhoT0xuUnZo?=
 =?utf-8?B?T0IvTC8xdUJrZ3BSU0UreWNlbWxIamZJbWZTeEZvMGs5UmsrNGRvZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16fb36-82ca-4282-e5e8-08dea258304a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:18.6117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyuoj8NTzYglDEkQXmGC9qoIm8Wu8AlXGnqUDQ8QIoi7B3gfGDQyONQZIi/ZFa3vfrEdjs1LdYmQK/VZGg5vBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

arch/arm/dts/imx8mm-data-modul-edm-sbc.dts is almost same as upstream Linux
dts with minor differences in fec phy usage, which should work well
because it is generic phy. So switch to OF_UPSTREAM by dropping the U-Boot
copy of the dts, enabling OF_UPSTREAM and updating CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                       |   1 -
 arch/arm/dts/imx8mm-data-modul-edm-sbc.dts  | 997 ----------------------------
 arch/arm/mach-imx/imx8m/Kconfig             |   1 +
 board/data_modul/imx8mm_edm_sbc/MAINTAINERS |   1 -
 configs/imx8mm_data_modul_edm_sbc_defconfig |   2 +-
 5 files changed, 2 insertions(+), 1000 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dff05dd5888..8656100fea2 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -873,7 +873,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 	imx8-capricorn-cxg3.dtb \
 
 dtb-$(CONFIG_ARCH_IMX8M) += \
-	imx8mm-data-modul-edm-sbc.dtb \
 	imx8mm-icore-mx8mm-ctouch2.dtb \
 	imx8mm-icore-mx8mm-edimm2.2.dtb \
 	imx8mm-phg.dtb \
diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc.dts b/arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
deleted file mode 100644
index 778bdbe228d..00000000000
--- a/arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
+++ /dev/null
@@ -1,997 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Marek Vasut <marex@denx.de>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/net/qca-ar803x.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mm.dtsi"
-
-/ {
-	model = "Data Modul i.MX8M Mini eDM SBC";
-	compatible = "dmo,imx8mm-data-modul-edm-sbc", "fsl,imx8mm";
-
-	aliases {
-		rtc0 = &rtc;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		/* There are 1/2/4 GiB options, adjusted by bootloader. */
-		reg = <0x0 0x40000000 0 0x40000000>;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_panel_backlight>;
-		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
-		default-brightness-level = <7>;
-		enable-gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm1 0 5000000 0>;
-		/* Disabled by default, unless display board plugged in. */
-		status = "disabled";
-	};
-
-	clk_xtal25: clk-xtal25 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	panel: panel {
-		backlight = <&backlight>;
-		power-supply = <&reg_panel_vcc>;
-		/* Disabled by default, unless display board plugged in. */
-		status = "disabled";
-	};
-
-	reg_panel_vcc: regulator-panel-vcc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_panel_vcc_reg>;
-		regulator-name = "PANEL_VCC";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 6 0>;
-		enable-active-high;
-		/* Disabled by default, unless display board plugged in. */
-		status = "disabled";
-	};
-
-	reg_usdhc2_vcc: regulator-usdhc2-vcc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_vcc_reg>;
-		regulator-name = "V_3V3_SD";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 0>;
-		enable-active-high;
-	};
-
-	watchdog-gpio {
-		/* TPS3813 */
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_watchdog_gpio>;
-		compatible = "linux,wdt-gpio";
-		always-enabled;
-		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
-		hw_algo = "level";
-		/* Reset triggers in 2..3 seconds */
-		hw_margin_ms = <1500>;
-		/* Disabled by default */
-		status = "disabled";
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-750M {
-			opp-hz = /bits/ 64 <750000000>;
-		};
-	};
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	flash@0 {	/* W25Q128FVSI */
-		compatible = "jedec,spi-nor";
-		m25p,fast-read;
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
-
-&ecspi2 {	/* Feature connector SPI */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	/* Disabled by default, unless feature board plugged in. */
-	status = "disabled";
-};
-
-&ecspi3 {	/* Display connector SPI */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
-	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
-	/* Disabled by default, unless display board plugged in. */
-	status = "disabled";
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&fec1_phy>;
-	phy-supply = <&buck4_reg>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Atheros AR8031 PHY */
-		fec1_phy: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			/*
-			 * Dedicated ENET_WOL# signal is unused, the PHY
-			 * can wake the SoC up via INT signal as well.
-			 */
-			interrupts-extended = <&gpio1 15 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <10000>;
-			qca,clk-out-frequency = <125000000>;
-			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-			qca,keep-pll-enabled;
-			vddio-supply = <&vddio>;
-
-			vddio: vddio-regulator {
-				regulator-name = "VDDIO";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vddh: vddh-regulator {
-				regulator-name = "VDDH";
-			};
-		};
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"", "ENET_RST#", "WDOG_B#", "PMIC_INT#",
-		"", "M2-B_PCIE_RST#", "M2-B_PCIE_WAKE#", "RTC_IRQ#",
-		"WDOG_KICK#", "M2-B_PCIE_CLKREQ#",
-		"USB1_OTG_ID_3V3", "ENET_WOL#",
-		"", "", "", "ENET_INT#",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"MEMCFG2", "MEMCFG1", "DSI_RESET_1V8#", "DSI_IRQ_1V8#",
-		"M2-B_FULL_CARD_PWROFF_1V8#", "EEPROM_WP_1V8#",
-		"PCIE_CLK_GEN_CLKPWRGD_PD_1V8#", "GRAPHICS_PRSNT_1V8#",
-		"MEMCFG0", "WDOG_EN",
-		"M2-B_W_DISABLE1_WWAN_1V8#", "M2-B_W_DISABLE2_GPS_1V8#",
-		"", "", "", "",
-		"", "", "", "SD2_RESET#", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"BL_ENABLE_1V8", "PG_V_IN_VAR#", "", "",
-		"", "", "TFT_ENABLE_1V8", "GRAPHICS_GPIO0_1V8",
-		"CSI_PD_1V8", "CSI_RESET_1V8#", "", "",
-		"", "", "", "",
-		"", "", "", "M2-B_WAKE_WWAN_1V8#",
-		"M2-B_RESET_1V8#", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"NC0", "NC1", "BOOTCFG0", "BOOTCFG1",
-		"BOOTCFG2", "BOOTCFG3", "BOOTCFG4", "BOOTCFG5",
-		"BOOTCFG6", "BOOTCFG7", "NC10", "NC11",
-		"BOOTCFG8", "BOOTCFG9", "BOOTCFG10", "BOOTCFG11",
-		"BOOTCFG12", "BOOTCFG13", "BOOTCFG14", "BOOTCFG15",
-		"NC20", "", "", "",
-		"", "CAN_INT#", "CAN_RST#", "GPIO4_IO27",
-		"DIS_USB_DN2", "", "", "";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "DIS_USB_DN1", "USBHUB_RESET#", "GPIO5_IO03",
-		"GPIO5_IO04", "", "", "",
-		"", "SPI1_CS#", "", "",
-		"", "SPI2_CS#", "I2C1_SCL_3V3", "I2C1_SDA_3V3",
-		"I2C2_SCL_3V3", "I2C2_SDA_3V3", "I2C3_SCL_3V3", "I2C3_SDA_3V3",
-		"I2C4_SCL_3V3", "I2C4_SDA_3V3", "", "",
-		"", "SPI3_CS#", "", "", "", "", "", "";
-};
-
-&i2c1 {
-	/* IMX8MM ERRATA e7805 -- I2C is limited to 384 kHz due to SoC bug */
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	pmic: pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		rohm,reset-snvs-powered;
-
-		/*
-		 * i.MX 8M Mini Data Sheet for Consumer Products
-		 * 3.1.3 Operating ranges
-		 * MIMX8MM4DVTLZAA
-		 */
-		regulators {
-			/* VDD_SOC */
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			/* VDD_ARM */
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1050000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <950000>;
-			};
-
-			/* VDD_DRAM, BUCK5 */
-			buck3_reg: BUCK3 {
-				regulator-name = "buck3";
-				/* 1.5 GHz DDR bus clock */
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 3V3_VDD, BUCK6 */
-			buck4_reg: BUCK4 {
-				regulator-name = "buck4";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 1V8_VDD, BUCK7 */
-			buck5_reg: BUCK5 {
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 1V1_NVCC_DRAM, BUCK8 */
-			buck6_reg: BUCK6 {
-				regulator-name = "buck6";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 1V8_NVCC_SNVS */
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 0V8_VDD_SNVS */
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 1V8_VDDA */
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 0V9_VDD_PHY */
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* 1V2_VDD_PHY */
-			ldo6_reg: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	/* IMX8MM ERRATA e7805 -- I2C is limited to 384 kHz due to SoC bug */
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	usb-hub@2c {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb_hub>;
-		compatible = "microchip,usb2514bi";
-		reg = <0x2c>;
-		individual-port-switching;
-		reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
-		self-powered;
-	};
-
-	eeprom: eeprom@50 {
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-
-	rtc: rtc@68 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
-		compatible = "st,m41t62";
-		reg = <0x68>;
-		interrupts-extended = <&gpio1 7 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	pcieclk: clk@6a {
-		compatible = "renesas,9fgv0241";
-		reg = <0x6a>;
-		clocks = <&clk_xtal25>;
-		#clock-cells = <1>;
-	};
-};
-
-&i2c3 {	/* Display connector I2C */
-	/* IMX8MM ERRATA e7805 -- I2C is limited to 384 kHz due to SoC bug */
-	clock-frequency = <320000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	pinctrl-1 = <&pinctrl_i2c3_gpio>;
-	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&i2c4 {	/* Feature connector I2C */
-	/* IMX8MM ERRATA e7805 -- I2C is limited to 384 kHz due to SoC bug */
-	clock-frequency = <320000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	pinctrl-1 = <&pinctrl_i2c4_gpio>;
-	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog_feature>, <&pinctrl_hog_misc>,
-		    <&pinctrl_hog_panel>, <&pinctrl_hog_sbc>,
-		    <&pinctrl_panel_expansion>;
-
-	pinctrl_ecspi1: ecspi1-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x44
-			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x44
-			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x44
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x40
-		>;
-	};
-
-	pinctrl_ecspi2: ecspi2-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x44
-			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x44
-			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x44
-			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x40
-		>;
-	};
-
-	pinctrl_ecspi3: ecspi3-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x44
-			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x44
-			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x44
-			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x40
-		>;
-	};
-
-	pinctrl_fec1: fec1-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			/* ENET_RST# */
-			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x6
-			/* ENET_WOL# */
-			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x40000090
-			/* ENET_INT# */
-			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x40000090
-		>;
-	};
-
-	pinctrl_hog_feature: hog-feature-grp {
-		fsl,pins = <
-			/* GPIO4_IO27 */
-			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x40000006
-			/* GPIO5_IO03 */
-			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3			0x40000006
-			/* GPIO5_IO04 */
-			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4			0x40000006
-
-			/* CAN_INT# */
-			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x40000090
-			/* CAN_RST# */
-			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x26
-		>;
-	};
-
-	pinctrl_hog_panel: hog-panel-grp {
-		fsl,pins = <
-			/* GRAPHICS_GPIO0_1V8 */
-			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7		0x26
-		>;
-	};
-
-	pinctrl_hog_misc: hog-misc-grp {
-		fsl,pins = <
-			/* PG_V_IN_VAR# */
-			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1		0x40000000
-			/* CSI_PD_1V8 */
-			MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8		0x0
-			/* CSI_RESET_1V8# */
-			MX8MM_IOMUXC_NAND_DATA03_GPIO3_IO9		0x0
-
-			/* DIS_USB_DN1 */
-			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x0
-			/* DIS_USB_DN2 */
-			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x0
-
-			/* EEPROM_WP_1V8# */
-			MX8MM_IOMUXC_SD1_DATA3_GPIO2_IO5		0x100
-			/* PCIE_CLK_GEN_CLKPWRGD_PD_1V8# */
-			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6		0x0
-			/* GRAPHICS_PRSNT_1V8# */
-			MX8MM_IOMUXC_SD1_DATA5_GPIO2_IO7		0x40000000
-
-			/* CLK_CCM_CLKO1_3V3 */
-			MX8MM_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1	0x10
-		>;
-	};
-
-	pinctrl_hog_sbc: hog-sbc-grp {
-		fsl,pins = <
-			/* MEMCFG[0..2] straps */
-			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8		0x40000140
-			MX8MM_IOMUXC_SD1_CMD_GPIO2_IO1			0x40000140
-			MX8MM_IOMUXC_SD1_CLK_GPIO2_IO0			0x40000140
-
-			/* BOOT_CFG[0..15] straps */
-			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x40000000
-			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x40000000
-			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x40000000
-
-			/* Not connected pins */
-			MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20		0x0
-			MX8MM_IOMUXC_SAI1_TXFS_GPIO4_IO10		0x0
-			MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11		0x0
-			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x0
-			MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1			0x0
-		>;
-	};
-
-	pinctrl_i2c1: i2c1-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000084
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c1_gpio: i2c1-gpio-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x84
-			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x84
-		>;
-	};
-
-	pinctrl_i2c2: i2c2-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000084
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c2_gpio: i2c2-gpio-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x84
-			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x84
-		>;
-	};
-
-	pinctrl_i2c3: i2c3-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000084
-			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c3_gpio: i2c3-gpio-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x84
-			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x84
-		>;
-	};
-
-	pinctrl_i2c4: i2c4-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000084
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c4_gpio: i2c4-gpio-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x84
-			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x84
-		>;
-	};
-
-	pinctrl_panel_backlight: panel-backlight-grp {
-		fsl,pins = <
-			/* BL_ENABLE_1V8 */
-			MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0			0x104
-		>;
-	};
-
-	pinctrl_panel_expansion: panel-expansion-grp {
-		fsl,pins = <
-			/* DSI_RESET_1V8# */
-			MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2		0x2
-			/* DSI_IRQ_1V8# */
-			MX8MM_IOMUXC_SD1_DATA1_GPIO2_IO3		0x40000090
-		>;
-	};
-
-	pinctrl_panel_vcc_reg: panel-vcc-grp {
-		fsl,pins = <
-			/* TFT_ENABLE_1V8 */
-			MX8MM_IOMUXC_NAND_DATA00_GPIO3_IO6		0x104
-		>;
-	};
-
-	pinctrl_panel_pwm: panel-pwm-grp {
-		fsl,pins = <
-			/* BL_PWM_3V3 */
-			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x12
-		>;
-	};
-
-	pinctrl_pcie0: pcie-grp {
-		fsl,pins = <
-			/* M2-B_RESET_1V8# */
-			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x102
-			/* M2-B_PCIE_RST# */
-			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x2
-			/* M2-B_FULL_CARD_PWROFF_1V8# */
-			MX8MM_IOMUXC_SD1_DATA2_GPIO2_IO4		0x102
-			/* M2-B_W_DISABLE1_WWAN_1V8# */
-			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10		0x102
-			/* M2-B_W_DISABLE2_GPS_1V8# */
-			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11		0x102
-			/* CLK_M2_32K768 */
-			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x14
-			/* M2-B_WAKE_WWAN_1V8# */
-			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x40000140
-			/* M2-B_PCIE_WAKE# */
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x40000140
-			/* M2-B_PCIE_CLKREQ# */
-			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x40000140
-		>;
-	};
-
-	pinctrl_pmic: pmic-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x40000090
-		>;
-	};
-
-	pinctrl_rtc: rtc-grp {
-		fsl,pins = <
-			/* RTC_IRQ# */
-			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x40000090
-		>;
-	};
-
-	pinctrl_sai5: sai5-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI5_MCLK_SAI5_MCLK		0x100
-			MX8MM_IOMUXC_SAI5_RXD0_SAI5_RX_DATA0		0x0
-			MX8MM_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC		0x100
-			MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK		0x100
-			MX8MM_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0		0x100
-		>;
-	};
-
-	pinctrl_uart1: uart1-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x90
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x90
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x50
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x50
-		>;
-	};
-
-	pinctrl_uart2: uart2-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x50
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x90
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x50
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x90
-		>;
-	};
-
-	pinctrl_uart3: uart3-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x40
-			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x40
-		>;
-	};
-
-	pinctrl_uart4: uart4-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX		0x40
-			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX		0x40
-		>;
-	};
-
-	pinctrl_usb_hub: usb-hub-grp {
-		fsl,pins = <
-			/* USBHUB_RESET# */
-			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x4
-		>;
-	};
-
-	pinctrl_usb_otg1: usb-otg1-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x40000000
-			MX8MM_IOMUXC_GPIO1_IO12_USB1_OTG_PWR		0x4
-			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x40000090
-		>;
-	};
-
-	pinctrl_usdhc2_vcc_reg: usdhc2-vcc-reg-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x4
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
-			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6
-			MX8MM_IOMUXC_SD2_CD_B_USDHC2_CD_B		0x0d6
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
-			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6
-			MX8MM_IOMUXC_SD2_CD_B_USDHC2_CD_B		0x0d6
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
-			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6
-			MX8MM_IOMUXC_SD2_CD_B_USDHC2_CD_B		0x0d6
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
-			MX8MM_IOMUXC_NAND_READY_B_SD3_RESET_B		0x40
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
-			MX8MM_IOMUXC_NAND_READY_B_SD3_RESET_B		0x40
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
-			MX8MM_IOMUXC_NAND_READY_B_SD3_RESET_B		0x40
-		>;
-	};
-
-	pinctrl_watchdog_gpio: watchdog-gpio-grp {
-		fsl,pins = <
-			/* WDOG_B# */
-			MX8MM_IOMUXC_GPIO1_IO02_GPIO1_IO2		0x26
-			/* WDOG_EN -- ungate WDT RESET# signal propagation */
-			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9		0x6
-			/* WDOG_KICK# / WDI */
-			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x26
-		>;
-	};
-};
-
-&pcie_phy {
-	fsl,clkreq-unsupported;	/* CLKREQ_B is not connected to suitable input */
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	fsl,tx-deemph-gen1 = <0x2d>;
-	fsl,tx-deemph-gen2 = <0xf>;
-	clocks = <&pcieclk 0>;
-	status = "okay";
-};
-
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
-		 <&pcieclk 0>;
-	clock-names = "pcie", "pcie_aux", "pcie_bus";
-	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
-			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
-	assigned-clock-rates = <10000000>, <250000000>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
-				 <&clk IMX8MM_SYS_PLL2_250M>;
-	status = "okay";
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_panel_pwm>;
-	/* Disabled by default, unless display board plugged in. */
-	status = "disabled";
-};
-
-&sai5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai5>;
-	fsl,sai-mclk-direction-output;
-	/* Input into codec PLL */
-	assigned-clocks = <&clk IMX8MM_CLK_SAI5>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL2_OUT>;
-	assigned-clock-rates = <22579200>;
-	/* Disabled by default, unless display board plugged in. */
-	status = "disabled";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	uart-has-rtscts;
-	status = "disabled";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "disabled";
-};
-
-&uart3 {	/* A53 Debug */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart4 {	/* M4 Debug */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	/* UART4 is reserved for CM and RDC blocks CA access to UART4. */
-	status = "disabled";
-};
-
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb_otg1>;
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbotg2 {
-	disable-over-current;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {	/* MicroSD */
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC2_ROOT>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vcc>;
-	status = "okay";
-};
-
-&usdhc3 {	/* eMMC */
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	vmmc-supply = <&buck4_reg>;
-	vqmmc-supply = <&buck5_reg>;
-	status = "okay";
-};
-
-&wdog1 {
-	status = "okay";
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index fbabd17288f..db138a8da34 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -92,6 +92,7 @@ config TARGET_IMX8MM_DATA_MODUL_EDM_SBC
 	select IMX8MM
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_EVK
 	bool "imx8mm LPDDR4 EVK board"
diff --git a/board/data_modul/imx8mm_edm_sbc/MAINTAINERS b/board/data_modul/imx8mm_edm_sbc/MAINTAINERS
index 36af19b78f9..46f591f4f03 100644
--- a/board/data_modul/imx8mm_edm_sbc/MAINTAINERS
+++ b/board/data_modul/imx8mm_edm_sbc/MAINTAINERS
@@ -1,7 +1,6 @@
 Data Modul eDM SBC i.MX8M Mini
 M:	Marek Vasut <marex@denx.de>
 S:	Maintained
-F:	arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
 F:	arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
 F:	board/data_modul/imx8mm_edm_sbc/
 F:	configs/imx8mm_data_modul_edm_sbc_defconfig
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 47f0d3cc050..70dad87f3ff 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -6,7 +6,7 @@ CONFIG_TARGET_IMX8MM_DATA_MODUL_EDM_SBC=y
 CONFIG_CI_UDC=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_CMD_PCI=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-data-modul-edm-sbc"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-data-modul-edm-sbc"
 CONFIG_DEFAULT_FDT_FILE="imx8mm-data-modul-edm-sbc.dtb"
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_DM_REGULATOR_BD71837=y

-- 
2.51.0

