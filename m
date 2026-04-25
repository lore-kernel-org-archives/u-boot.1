Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA2FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1778410D;
	Sat, 25 Apr 2026 18:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ejfElEyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C615F8407E; Sat, 25 Apr 2026 18:14:42 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1749840CB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by DU4PR04MB11726.eurprd04.prod.outlook.com (2603:10a6:10:615::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX5V18felxY9IM/jOSiN38jyrz1Fp+X/6zje6Xu6XCVBomA7CrfVANbJYOq/QmJ6rgXxeKhijTAsW03MYUV5cY7nKa2Z+kMT4GK0f/F9WMEbaobhcPX/wbxchtl8HJneBhNIn4ge/DzGHOiddHFR8cObQ2vg/pWioMK+o2sZU6Zla5vfGwnjmRCwt3WPcffxJObiSzyYFsJOAQJq3NhDpL5vR7vrMl/IOsHhrpXkBctXYiMxVkf+0eF5GoxaBJ3sEQpOG379aNLRqBTw0DNMmPuTTxezQc+jk4sFnWTqH/G42sSro4yOjglCAwCqgSqouUPxRL5yA8uOAAl1dEtUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCVLNAABM7TYdGDj9S0yjdpijRZegTNxJTTgme0VX/M=;
 b=joF8kj0qKH3UHU21aVL3yFYMGCYnNVj3WL7q23lVxLLPLiA19jupr+QSQoVNdXNsJqrcZ5DiFtvbSTIuozfPrCZZPCKX7328dLzq+cQ+PGc4QLyKHK2m8beu2jmfS3qeuo5uO9OwVih11e75aPOEZGSbaxvGDFpZQcocxhYfB0yYGYBiJp4PrjTeZlhOiTNR9Ez+CgDPBK3dzAooxvHMzSQ8dzhD9bQ14EkFXGy/rdgC8wWiCu36opbZVXU7DtyCHAqTxL9vtdQvoh3L0pCC8zSMuKWCAxHcoAY4a1MuosBpYvmHl+AhG3OLHbkTTANNGlyd6+oJOgcKoF7BL9OZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCVLNAABM7TYdGDj9S0yjdpijRZegTNxJTTgme0VX/M=;
 b=ejfElEyWnDkz9yP40tRuWO9jp8ZHXuIkUUZKn+mt9E/bsGHw1saZ7ZdTCMdVOyJbqXIXArkeXpdzbAvnGWt+PSaho57/Ab6UwTuslDo1eI2nC2YtryCHWtyaSKJUQ5NuLPyTREIFOVZDT1GUdguaq/NHyLCNsl7qu34wuDF1cEwfgXlUYzBYA+thk86hoMsRnuyAOhKdSQsLVmT/ygV2+maWMz554oN42y4FkBrCmXtCZCDYkAV08mC8RGwXLZwnytsFhWQzfAUsL5SKfZkfrUA82em33jaBTETm6zp2DcE2C7oSqX/swtRdgHrniB7l5EDXiUKeS3XKonfEXSyBNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:37:03 +0800
Subject: [PATCH 11/13] imx8mp: dhcom-drc02/picoitx: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-11-07527be92e5d@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|DU4PR04MB11726:EE_
X-MS-Office365-Filtering-Correlation-Id: 116a872c-d322-4ef5-734a-08dea25837eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 3uuc8nEmD3taOH6cRWDl5ByTi0X4HRsrHiuRh2t60/agCy3kpTy4CruAYoTCFQWwTKeRF5Z+g7LByDSFvyN6GlGrtjoW+Wb4cfPXoKfLTiqWXVCT95PnYqYkhdmllkSDDj83QxnyLu5HlkOJ0eJOTY4xlgbMvXi1KS/KDrb9o8cquWjE/7bMEOkP4z3cNNxz2rA0qzngPdsY5iJ7CVCx+hMbSpc1FjiRXC9ih7hgedvGMagQmMHoFpmQUYaKi/M4DiUGp6j+XhH1nWG+Ju0RMLT2Ic9AjjmK0lQyl1WZ42EhHTnZdvgtDcYyq9uIYRArLB9rEkp3z8oogp8g00XZesHGCkO8FfUuAXic1fQ7dZ5jRLuTB2W4TY1IcdaUNoZsap2Km2VH0RhJKh/CBHbP8RZd9czNa7B7LCX2f0PxfT+R6N/WffPAU+MR93AS4MdFnuk+jCMtWnNJwm414NitNHCuW9/ohfcxWWdCKzdMYhU16iG4D8I1pP2HtIKvDFiyA4rfymQJ/RznxzxXW4GjolgLOK7zZQBWGmoYqhz53CNrVVgfYEgm36ZMgtDULqx9pdEFR7Fbs8UCN66k4p8SLtO3QhqJva95Tt+wSzsx9UFLTI+QJAF3dBnNzTvY0658ckPlVNyAYiVwANJ0NL97WicMyYsExRf8VPbOx4YbdVmZbHc2DjKj5gJdFrA/zSEXbGqM0Gr2MO0dairhX2x34VISZN91QHeibbEz6CBR+Mh4FdtC9MUaeaD1EJTCuy3Dwoq7nxn7JoALANdj1sAJQnyq/2I9nHZrB/QkLo21r5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJOOWZsVUhqMk9vdEJiWUhzd3JiYUtBNEVtN0xPUXM5ZHplQncvVThaRTNn?=
 =?utf-8?B?UUYyWnNaSGduR3M3R2dWZkVoNXZrWGdpbVRiNStWcjRRTFFGWWQwUGJ2Q21s?=
 =?utf-8?B?dzEwRk9TekY4T25aVm1BSkRaZU5sR05mTXdLOVBzUkRlWks0d3pMVFJFa0M1?=
 =?utf-8?B?MVlQL3NaWTJpRWI1cTRJRVhoTjNUd0g1V21neXV6dHdNTWY3U0ZHSDlMQm11?=
 =?utf-8?B?bHNwN256WjAzdnZNMEE3SnpGNmpRWlc1Y2UrOTBvSzRETFdBU2J4VzJBTjhn?=
 =?utf-8?B?UVh2eXNtd05pT0tFcVI2Mm9wOGhHT3BBQjZsUDYvRVF3a1Z1UVNkZWFqdUgw?=
 =?utf-8?B?UUozNTNTbCtVN0VoWVNZUVNuc1NoS1JkNUF6cGRqRzkyaWdRT045cHNhTTBG?=
 =?utf-8?B?dllUeHN6K2pwTk82SFpxd2VZYlhVd3FvZmtNL0taOHNlZlZPUHo4VHRjMTl6?=
 =?utf-8?B?V2Y0VU12M3RXWUNiQXp0NFI4VTBhOGxwT0RSb3oyOEUwbUM2NlgwUE5wWTNo?=
 =?utf-8?B?WXZmbjdidUdIN1ZWQnRVMzVHNG9XVklZVjVBeFVCT0NRMFhMUXIyZ3hYQ1oy?=
 =?utf-8?B?bHRZNGpaMzFRSHlnZWtYeWV5ZUlvaU9IemtrUzJaMkpoMEc2TlgvS3Zjck9F?=
 =?utf-8?B?WXB3dUovQ3BmQnpHK2h3djNXaFZuMy9FQ3dieUxJQ3VITDhvaXFlVDRnbmF2?=
 =?utf-8?B?VlAza0krSVBHQ09SS3g4YnE0c2Q2MVZLZVFpdnFkY0F2aG5BTjc4THlodWNV?=
 =?utf-8?B?L1g1NnlVY1pwMytpR3d6RVl2TVY4S3ZnUnlmZ0hzMlpIT1VyaHBaNGtkSEtH?=
 =?utf-8?B?aXJOOHRBTjA3ankySGhTenR5UVErRFpzUUFTSVI2eG1GU3F4ZUJuam5lNXVw?=
 =?utf-8?B?SjVIQW5WVFNJVFBTbUxlaFY4azMvbVJ2NnIxK3JpY1dmUXdXcVBBTGl3ZlZ0?=
 =?utf-8?B?U3REeTJzSGQ3S1JtbWR2YTRVZkRVVG80RHg1VjdJQkZWVnBNT0pOWVZCOE81?=
 =?utf-8?B?ZkFCSWpnRmpYYkhxRFZ5aXRFMkJmRFJTY0xuN1VCeHMwcmZrQ0JEdWxxR3Jv?=
 =?utf-8?B?OW5YQWVTWVc3VEcwdnNzbzZ0UE5ESUtralJsbzlnRHNjdUpjdG54RkgrdEdZ?=
 =?utf-8?B?MEh1QXFKYUVJL29TVFk2eWZTeVNMM2dTQWRGdmsrM2d3S25zTHFTeWk3QTEy?=
 =?utf-8?B?cmNrTThLc3BsanlvN3M3WWw5cVZYMmVvMkVsOGZvMjE5YngzaEpHREx3bGNG?=
 =?utf-8?B?VmN4ZENmZCtoQ1AyREFrL0VVV1pWTHF2ZkNNN1ZwL0pzZStkWEppRHR5ZmV4?=
 =?utf-8?B?dzgrbGg3aHd1clQzVnM5bExnblJ6b3ljdzBzMmpEY1JnMmcrZ1M5RTJBcEd0?=
 =?utf-8?B?MWVhU3JWOFFPWFpPanBuVTZyYThDVzIrbkttV1BxZ1NHc2JabGN5NS9EMXFo?=
 =?utf-8?B?RDNwQ2VIM2JEcDI4MmNnYmZrQnNhRU1XRUt6ZHdpK1k5eE83U3hMSHdTalph?=
 =?utf-8?B?dmdmWXE0Yk5oclJCUjhDKzJSckVWcmRtdFNYL3ovdWp5cDR3V1F2NWMyUWtU?=
 =?utf-8?B?bGRUWTF5TmdPNVRDSHhMTWdma2luMVhzSVlMaGd4Szh3aFFOcHE3WFdzUEkw?=
 =?utf-8?B?VEFaTWVqTnF2N3lqR0hLNEZvRllhMlFJTVR0YXkwZTVUQ3NsdGFnU1Bkbm5p?=
 =?utf-8?B?UTM0UkNoZ2ZKZzVTSVo2TVZkQ3VTSjlpOFB2UENENVFzaHJCZzFTYnFRTFVS?=
 =?utf-8?B?NVhyK3FuWngvUE9RWnZhb0VkdHVESGMwNGlDd2YxaDU5MWNsemVWNFdwNmkx?=
 =?utf-8?B?bDlQdVlhdzVlZlhyUi9WRGE4NjVHeDBqRkdFakpyTnNmZXkycnBWcy8zZGdU?=
 =?utf-8?B?aGJxekNubmpETHIyMFlhRDdabE9UdmRhbWtSd1BnL0NYK0dlRE84MzFhSjU3?=
 =?utf-8?B?L3NMWm5Zd0RTd2x0N2dsVzh4eTBGa2l2VU5HRFZGSS9DRENFSXBEQmYweUta?=
 =?utf-8?B?bmlsczEvR1dsZS9WSlhEWVlHaXlkMXJFWWorV1dGcWllRVNNQWtrVDFpRDM2?=
 =?utf-8?B?OVU4N2ZaUExqUVVlOGluUGVDdllMREVxV2o1U05uZklTWEJHemQ0ZEdYV0c4?=
 =?utf-8?B?dHBLYmZHaGE0elNNYjkzZHVzVFl1R0lmOFJRSWlkSVA4ZlZHL253ZnRRaGpE?=
 =?utf-8?B?UHdFTmgwVkQyQmxmNCtTbWgvaGtiQmxkS0k1YnRZc2RvNkErTnBvME41eEkw?=
 =?utf-8?B?cWlzdWN0K1pYS0RIeiszd3R1cldEWFJ6bHdWNVc2VzZiQ0FWcVo0Wm8yTkJB?=
 =?utf-8?B?RU90dWNYQVowMnFTcytZSEhtY0pnZlg1akIvZEJaQ01QaXlsT0NxQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 116a872c-d322-4ef5-734a-08dea25837eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:31.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQpqI2/zkQk/+J36BpVdQyVPYcfKz3HWbw7Pjxhvh/UWg7uyaCixYsokxqZ7qG5KXAl6muwr220apWqm3FnM5g==
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

The arch/arm/dts/imx8mp-dhcom-drc02.dts,imx8mp-dhcom-picoitx.dts are
almost same as the ones in dts/upstream, so switch the board to
OF_UPSTREAM by dropping copies and selecting OF_UPSTREAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                  |    2 -
 arch/arm/dts/imx8mp-dhcom-drc02.dts    |  230 -------
 arch/arm/dts/imx8mp-dhcom-picoitx.dts  |  152 -----
 arch/arm/dts/imx8mp-dhcom-som.dtsi     | 1153 --------------------------------
 configs/imx8mp_dhcom_drc02_defconfig   |    3 +-
 configs/imx8mp_dhcom_picoitx_defconfig |    3 +-
 6 files changed, 4 insertions(+), 1539 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aa9437ecb43..434bcbfef32 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -880,9 +880,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-som-overlay-eth1xfast.dtbo \
 	imx8mp-dhcom-som-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
-	imx8mp-dhcom-drc02.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
-	imx8mp-dhcom-picoitx.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb
 
diff --git a/arch/arm/dts/imx8mp-dhcom-drc02.dts b/arch/arm/dts/imx8mp-dhcom-drc02.dts
deleted file mode 100644
index b3ab6e94508..00000000000
--- a/arch/arm/dts/imx8mp-dhcom-drc02.dts
+++ /dev/null
@@ -1,230 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2024 Marek Vasut <marex@denx.de>
- *
- * DHCOM iMX8MP variant:
- * DHCM-iMX8ML8-C160-R204-F1638-SPI16-E2-CAN2-RTC-I-01D2
- * DHCOM PCB number: 660-100 or newer
- * DRC02 PCB number: 568-100 or newer
- */
-
-/dts-v1/;
-
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mp-dhcom-som.dtsi"
-
-/ {
-	model = "DH electronics i.MX8M Plus DHCOM on DRC02";
-	compatible = "dh,imx8mp-dhcom-drc02", "dh,imx8mp-dhcom-som",
-		     "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-};
-
-&eqos {	/* First ethernet */
-	pinctrl-0 = <&pinctrl_eqos_rmii>;
-	phy-handle = <&ethphy0f>;
-	phy-mode = "rmii";
-
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
-				 <&clk IMX8MP_SYS_PLL2_100M>,
-				 <&clk IMX8MP_SYS_PLL2_50M>;
-	assigned-clock-rates = <0>, <100000000>, <50000000>;
-};
-
-&ethphy0g {	/* Micrel KSZ9131RNXI */
-	status = "disabled";
-};
-
-&ethphy0f {	/* SMSC LAN8740Ai */
-	status = "okay";
-};
-
-&fec {	/* Second ethernet */
-	pinctrl-0 = <&pinctrl_fec_rmii>;
-	phy-handle = <&ethphy1f>;
-	phy-mode = "rmii";
-	status = "okay";
-
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
-				 <&clk IMX8MP_SYS_PLL2_100M>,
-				 <&clk IMX8MP_SYS_PLL2_50M>,
-				 <&clk IMX8MP_SYS_PLL2_50M>;
-	assigned-clock-rates = <0>, <100000000>, <50000000>, <0>;
-};
-
-&ethphy1f {	/* SMSC LAN8740Ai */
-	status = "okay";
-};
-
-&flexcan1 {
-	status = "okay";
-};
-
-&flexcan2 {
-	status = "okay";
-};
-
-&gpio1 {
-	gpio-line-names =
-		"DRC02-In1", "", "", "", "", "DHCOM-I", "DRC02-HW2", "DRC02-HW0",
-		"DHCOM-B", "DHCOM-A", "", "DHCOM-H", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-
-	/*
-	 * NOTE: On DRC02, the RS485_RX_En is controlled by a separate
-	 * GPIO line, however the i.MX8 UART driver assumes RX happens
-	 * during TX anyway and that it only controls drive enable DE
-	 * line. Hence, the RX is always enabled here.
-	 */
-	rs485-rx-en-hog {
-		gpio-hog;
-		gpios = <13 0>; /* GPIO Q */
-		line-name = "rs485-rx-en";
-		output-low;
-	};
-};
-
-&gpio2 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"DHCOM-O", "DHCOM-N", "", "SOM-HW1", "", "", "", "",
-		"", "", "", "", "DRC02-In2", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "SOM-HW0", "",
-		"", "", "", "", "", "", "SOM-MEM0", "SOM-MEM1",
-		"SOM-MEM2", "SOM-HW2", "", "", "", "", "", "";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "SOM-HW1", "", "", "", "",
-		"", "", "", "DRC02-Out2", "", "", "", "";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "DHCOM-C", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "DHCOM-E", "DRC02-Out1",
-		"", "", "", "", "", "", "", "";
-};
-
-&i2c3 {
-	/* Resistive touch controller not populated on this one SoM variant. */
-	touchscreen@49 {
-		status = "disabled";
-	};
-};
-
-&pcie_phy {
-	status = "disabled";
-};
-
-&pcie {
-	status = "disabled";
-};
-
-/* Console UART */
-&pinctrl_uart1 {
-	fsl,pins = <
-		/* No pull-ups on DRC02, enable in-SoC pull-ups */
-		MX8MP_IOMUXC_SAI2_RXC__UART1_DCE_RX		0x149
-		MX8MP_IOMUXC_SAI2_RXFS__UART1_DCE_TX		0x149
-	>;
-};
-
-&pinctrl_uart3 {
-	fsl,pins = <
-		/* No pull-ups on DRC02, enable in-SoC pull-ups */
-		MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x149
-		MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x149
-	>;
-};
-
-&uart1 {
-	/*
-	 * Due to the use of CAN2 the signals for CAN2 Tx and Rx are routed to
-	 * DHCOM UART1 RTS/CTS pins. Therefore this UART have to use DHCOM GPIOs
-	 * for RTS/CTS. So configure DHCOM GPIO I as RTS and GPIO M as CTS.
-	 */
-	/delete-property/ uart-has-rtscts;
-	cts-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>; /* GPIO M */
-	pinctrl-0 = <&pinctrl_uart1 &pinctrl_dhcom_i &pinctrl_dhcom_m>;
-	pinctrl-names = "default";
-	rts-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO I */
-};
-
-&uart3 {
-	/*
-	 * On DRC02 this UART is used as RS485 interface and RS485_TX_En is
-	 * controlled by DHCOM GPIO P. So remove RTS/CTS pins and the property
-	 * uart-has-rtscts from this UART and add the DHCOM GPIO P pin via
-	 * rts-gpios. The RS485_RX_En is controlled by DHCOM GPIO Q, see gpio1
-	 * node above.
-	 */
-	/delete-property/ uart-has-rtscts;
-	linux,rs485-enabled-at-boot-time;
-	pinctrl-0 = <&pinctrl_uart3 &pinctrl_dhcom_p &pinctrl_dhcom_q>;
-	pinctrl-names = "default";
-	rts-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>; /* GPIO P */
-};
-
-/* No WiFi/BT chipset on this SoM variant. */
-&uart2 {
-	bluetooth {
-		status = "disabled";
-	};
-};
-
-/* USB_OTG port is not routed out on DRC02. */
-&usb3_0 {
-	status = "disabled";
-};
-
-&usb_dwc3_0 {
-	status = "disabled";
-};
-
-/* USB_HOST port has USB Hub connected to it, PWR/OC pins are unused */
-&usb3_1 {
-	fsl,disable-port-power-control;
-	fsl,permanently-attached;
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	maximum-speed = "high-speed";
-};
-
-/* No WiFi/BT chipset on this SoM variant. */
-&usdhc1 {
-	status = "disabled";
-};
-
-&iomuxc {
-	/*
-	 * GPIO I is connected to UART1_RTS
-	 * GPIO M is connected to UART1_CTS
-	 * GPIO P is connected to RS485_TX_En
-	 * GPIO Q is connected to RS485_RX_En
-	 */
-	pinctrl-0 = <&pinctrl_hog_base
-		     &pinctrl_dhcom_a &pinctrl_dhcom_b &pinctrl_dhcom_c
-		     &pinctrl_dhcom_d &pinctrl_dhcom_e &pinctrl_dhcom_f
-		     &pinctrl_dhcom_g &pinctrl_dhcom_h &pinctrl_dhcom_j
-		     &pinctrl_dhcom_k &pinctrl_dhcom_l &pinctrl_dhcom_n
-		     &pinctrl_dhcom_o &pinctrl_dhcom_r &pinctrl_dhcom_s
-		     &pinctrl_dhcom_int>;
-};
diff --git a/arch/arm/dts/imx8mp-dhcom-picoitx.dts b/arch/arm/dts/imx8mp-dhcom-picoitx.dts
deleted file mode 100644
index 285aaa5b6c0..00000000000
--- a/arch/arm/dts/imx8mp-dhcom-picoitx.dts
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2023-2024 Marek Vasut <marex@denx.de>
- *
- * DHCOM iMX8MP variant:
- * DHCM-iMX8ML8-C160-R204-F1638-SPI16-E-SD-RTC-T-RGB-I-01D2
- * DHCOM PCB number: 660-200 or newer
- * PicoITX PCB number: 487-600 or newer
- */
-
-/dts-v1/;
-
-#include <dt-bindings/leds/common.h>
-#include "imx8mp-dhcom-som.dtsi"
-
-/ {
-	model = "DH electronics i.MX8M Plus DHCOM PicoITX";
-	compatible = "dh,imx8mp-dhcom-picoitx", "dh,imx8mp-dhcom-som",
-		     "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	led {
-		compatible = "gpio-leds";
-
-		led-0 {
-			color = <LED_COLOR_ID_YELLOW>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO I */
-			pinctrl-0 = <&pinctrl_dhcom_i>;
-			pinctrl-names = "default";
-		};
-	};
-};
-
-&eqos {	/* First ethernet */
-	pinctrl-0 = <&pinctrl_eqos_rmii>;
-	phy-handle = <&ethphy0f>;
-	phy-mode = "rmii";
-
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
-				 <&clk IMX8MP_SYS_PLL2_100M>,
-				 <&clk IMX8MP_SYS_PLL2_50M>;
-	assigned-clock-rates = <0>, <100000000>, <50000000>;
-};
-
-&ethphy0g {	/* Micrel KSZ9131RNXI */
-	status = "disabled";
-};
-
-&ethphy0f {	/* SMSC LAN8740Ai */
-	status = "okay";
-};
-
-&fec {
-	status = "disabled";
-};
-
-&flexcan1 {
-	status = "okay";
-};
-
-&gpio1 {
-	gpio-line-names =
-		"DHCOM-G", "", "", "",
-		"", "DHCOM-I", "PicoITX-HW0", "PicoITX-HW2",
-		"DHCOM-B", "DHCOM-A", "", "DHCOM-H", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "PicoITX-HW1", "", "", "", "",
-		"", "", "", "", "DHCOM-INT", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "SOM-HW1", "", "", "", "",
-		"", "", "", "PicoITX-Out2", "", "", "", "";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "PicoITX-In2", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "",
-		"", "", "PicoITX-In1", "PicoITX-Out1",
-		"", "", "", "", "", "", "", "";
-};
-
-/* No HS connector on this SoM variant, so no HDMI, PCIe and only USB HS. */
-&pcie_phy {
-	status = "disabled";
-};
-
-&pcie {
-	status = "disabled";
-};
-
-/* No WiFi/BT chipset on this SoM variant. */
-&uart2 {
-	bluetooth {
-		status = "disabled";
-	};
-};
-
-/* USB_OTG port is not routed out on PicoITX. */
-&usb3_0 {
-	status = "disabled";
-};
-
-&usb_dwc3_0 {
-	status = "disabled";
-};
-
-&usb3_1 {
-	fsl,over-current-active-low;
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	maximum-speed = "high-speed";
-};
-
-/* No WiFi/BT chipset on this SoM variant. */
-&usdhc1 {
-	status = "disabled";
-};
-
-&iomuxc {
-	/*
-	 * The following DHCOM GPIOs are used on this board.
-	 * Therefore, they have been removed from the list below.
-	 * I: yellow led
-	 */
-	pinctrl-0 = <&pinctrl_dhcom_a &pinctrl_dhcom_b &pinctrl_dhcom_c
-		     &pinctrl_dhcom_d &pinctrl_dhcom_e &pinctrl_dhcom_f
-		     &pinctrl_dhcom_g &pinctrl_dhcom_h &pinctrl_dhcom_j
-		     &pinctrl_dhcom_k &pinctrl_dhcom_l &pinctrl_dhcom_m
-		     &pinctrl_dhcom_n &pinctrl_dhcom_o &pinctrl_dhcom_p
-		     &pinctrl_dhcom_q &pinctrl_dhcom_r &pinctrl_dhcom_s
-		     &pinctrl_dhcom_int>;
-};
diff --git a/arch/arm/dts/imx8mp-dhcom-som.dtsi b/arch/arm/dts/imx8mp-dhcom-som.dtsi
deleted file mode 100644
index c1ca3805737..00000000000
--- a/arch/arm/dts/imx8mp-dhcom-som.dtsi
+++ /dev/null
@@ -1,1153 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2021-2022 Marek Vasut <marex@denx.de>
- */
-
-#include "imx8mp.dtsi"
-
-/ {
-	model = "DH electronics i.MX8M Plus DHCOM SoM";
-	compatible = "dh,imx8mp-dhcom-som", "fsl,imx8mp";
-
-	aliases {
-		ethernet0 = &eqos;
-		ethernet1 = &fec;
-		rtc0 = &rv3032;
-		rtc1 = &snvs_rtc;
-		spi0 = &flexspi;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		/* Memory size 512 MiB..8 GiB will be filled by U-Boot */
-		reg = <0x0 0x40000000 0 0x08000000>;
-	};
-
-	reg_eth_vio: regulator-eth-vio {
-		compatible = "regulator-fixed";
-		gpio = <&ioexp 2 GPIO_ACTIVE_LOW>;
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "eth_vio";
-		vin-supply = <&buck4>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 19 0>; /* SD2_RESET */
-		off-on-delay-us = <12000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VDD_3V3_SD";
-		startup-delay-us = <100>;
-		vin-supply = <&buck4>;
-	};
-
-	reg_vdd_3p3v_awo: regulator-vdd-3p3v-awo {	/* VDD_3V3_AWO */
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "VDD_3P3V_AWO";
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
-	status = "disabled";
-};
-
-&ecspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	status = "disabled";
-};
-
-&eqos {	/* First ethernet */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos_rgmii>;
-	phy-handle = <&ethphy0g>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Up to one of these two PHYs may be populated. */
-		ethphy0f: ethernet-phy@1 { /* SMSC LAN8740Ai */
-			compatible = "ethernet-phy-id0007.c110",
-				     "ethernet-phy-ieee802.3-c22";
-			interrupt-parent = <&gpio3>;
-			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
-			pinctrl-0 = <&pinctrl_ethphy0>;
-			pinctrl-names = "default";
-			reg = <1>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-			reset-gpios = <&ioexp 4 GPIO_ACTIVE_LOW>;
-			/* Non-default PHY population option. */
-			status = "disabled";
-		};
-
-		ethphy0g: ethernet-phy@5 { /* Micrel KSZ9131RNXI */
-			compatible = "ethernet-phy-id0022.1642",
-				     "ethernet-phy-ieee802.3-c22";
-			interrupt-parent = <&gpio3>;
-			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
-			micrel,led-mode = <0>;
-			pinctrl-0 = <&pinctrl_ethphy0>;
-			pinctrl-names = "default";
-			reg = <5>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-			reset-gpios = <&ioexp 4 GPIO_ACTIVE_LOW>;
-			/* Default PHY population option. */
-			status = "okay";
-		};
-	};
-};
-
-&fec {	/* Second ethernet */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec_rmii>;
-	phy-handle = <&ethphy1f>;
-	phy-mode = "rmii";
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Up to one PHY may be populated. */
-		ethphy1f: ethernet-phy@2 { /* SMSC LAN8740Ai */
-			compatible = "ethernet-phy-id0007.c110",
-				     "ethernet-phy-ieee802.3-c22";
-			interrupt-parent = <&gpio4>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-			pinctrl-0 = <&pinctrl_ethphy1>;
-			pinctrl-names = "default";
-			reg = <2>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-			/* Non-default PHY population option. */
-			status = "disabled";
-		};
-	};
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "disabled";
-};
-
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	status = "disabled";
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi>;
-	status = "okay";
-
-	flash@0 {	/* W25Q128JWPIM */
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <80000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"DHCOM-G", "", "", "", "", "DHCOM-I", "DHCOM-J", "DHCOM-L",
-		"DHCOM-B", "DHCOM-A", "", "DHCOM-H", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "DHCOM-K", "", "", "", "",
-		"", "", "", "", "DHCOM-INT", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "SOM-HW0", "",
-		"", "", "", "", "", "", "SOM-MEM0", "SOM-MEM1",
-		"SOM-MEM2", "SOM-HW2", "", "", "", "", "", "";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "SOM-HW1", "", "", "", "",
-		"", "", "", "DHCOM-D", "", "", "", "";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "DHCOM-C", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "DHCOM-E", "DHCOM-F",
-		"", "", "", "", "", "", "", "";
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	pinctrl-1 = <&pinctrl_i2c3_gpio>;
-	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	pmic: pmic@25 {
-		compatible = "nxp,pca9450c";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		/*
-		 * i.MX 8M Plus Data Sheet for Consumer Products
-		 * 3.1.4 Operating ranges
-		 * MIMX8ML8CVNKZAB
-		 */
-		regulators {
-			buck1: BUCK1 {	/* VDD_SOC (dual-phase with BUCK3) */
-				regulator-compatible = "BUCK1";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-ramp-delay = <3125>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck2: BUCK2 {	/* VDD_ARM */
-				regulator-compatible = "BUCK2";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-ramp-delay = <3125>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck4: BUCK4 {	/* VDD_3V3 */
-				regulator-compatible = "BUCK4";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck5: BUCK5 {	/* VDD_1V8 */
-				regulator-compatible = "BUCK5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck6: BUCK6 {	/* NVCC_DRAM_1V1 */
-				regulator-compatible = "BUCK6";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			ldo1: LDO1 {	/* NVCC_SNVS_1V8 */
-				regulator-compatible = "LDO1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			ldo3: LDO3 {	/* VDDA_1V8 */
-				regulator-compatible = "LDO3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			ldo4: LDO4 {	/* PMIC_LDO4 */
-				regulator-compatible = "LDO4";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo5: LDO5 {	/* NVCC_SD2 */
-				regulator-compatible = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-
-	adc@48 {
-		compatible = "ti,ads1015";
-		reg = <0x48>;
-		interrupts-extended = <&ioexp 7 IRQ_TYPE_EDGE_FALLING>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		channel@0 {	/* Voltage over AIN0 and AIN1. */
-			reg = <0>;
-		};
-
-		channel@1 {	/* Voltage over AIN0 and AIN3. */
-			reg = <1>;
-		};
-
-		channel@2 {	/* Voltage over AIN1 and AIN3. */
-			reg = <2>;
-		};
-
-		channel@3 {	/* Voltage over AIN2 and AIN3. */
-			reg = <3>;
-		};
-
-		channel@4 {	/* Voltage over AIN0 and GND. */
-			reg = <4>;
-		};
-
-		channel@5 {	/* Voltage over AIN1 and GND. */
-			reg = <5>;
-		};
-
-		channel@6 {	/* Voltage over AIN2 and GND. */
-			reg = <6>;
-		};
-
-		channel@7 {	/* Voltage over AIN3 and GND. */
-			reg = <7>;
-		};
-	};
-
-	touchscreen@49 {
-		compatible = "ti,tsc2004";
-		reg = <0x49>;
-		interrupts-extended = <&gpio4 0 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_touch>;
-		vio-supply = <&buck4>;
-	};
-
-	eeprom0: eeprom@50 {	/* EEPROM with EQoS MAC address */
-		compatible = "atmel,24c32";	/* M24C32-D */
-		pagesize = <32>;
-		reg = <0x50>;
-	};
-
-	rv3032: rtc@51 {
-		compatible = "microcrystal,rv3032";
-		reg = <0x51>;
-		interrupts-extended = <&ioexp 3 IRQ_TYPE_EDGE_FALLING>;
-	};
-
-	eeprom1: eeprom@53 {	/* EEPROM with FEC MAC address */
-		compatible = "atmel,24c32";	/* M24C32-D */
-		pagesize = <32>;
-		reg = <0x53>;
-	};
-
-	eeprom0wl: eeprom@58 {
-		compatible = "atmel,24c32d-wl";	/* M24C32-D WL page of 0x50 */
-		pagesize = <32>;
-		reg = <0x58>;
-	};
-
-	eeprom1wl: eeprom@5b {
-		compatible = "atmel,24c32d-wl";	/* M24C32-D WL page of 0x53 */
-		pagesize = <32>;
-		reg = <0x5b>;
-	};
-
-	ioexp: gpio@74 {
-		compatible = "nxp,pca9539";
-		reg = <0x74>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupts-extended = <&gpio3 20 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ioexp>;
-
-		gpio-line-names =
-			"BT_REG_EN", "WL_REG_EN", "VIO_SWITCHED_#EN", "RTC_#INT",
-			"ENET_QOS_#RST", "RGB_OSZ_ENABLE", "USB1_ID", "ADC_ALTER_RDY",
-			"DHCOM-W", "DHCOM-V", "DHCOM-U", "DHCOM-T",
-			"BT_HOST_WAKE", "BT_DEV_WAKE", "", "";
-	};
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	pinctrl-1 = <&pinctrl_i2c4_gpio>;
-	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&i2c5 {	/* HDMI EDID bus */
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c5>;
-	pinctrl-1 = <&pinctrl_i2c5_gpio>;
-	scl-gpios = <&gpio3 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio3 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&pwm1 {
-	pinctrl-0 = <&pinctrl_pwm1>;
-	pinctrl-names = "default";
-	status = "disabled";
-};
-
-&uart1 {
-	/* CA53 console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	/* Bluetooth */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-
-	/*
-	 * PLL1 at 80 MHz supplies UART2 root with 80 MHz clock,
-	 * which with 16x oversampling yields 5 Mbdps baud base,
-	 * which can be well divided by 5/4 to achieve 4 Mbdps,
-	 * which is exactly the maximum rate supported by muRata
-	 * 2AE bluetooth UART.
-	 */
-	assigned-clocks = <&clk IMX8MP_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
-	assigned-clock-rates = <80000000>;
-
-	bluetooth {
-		compatible = "cypress,cyw4373a0-bt";
-		shutdown-gpios = <&ioexp 0 GPIO_ACTIVE_HIGH>;
-		max-speed = <4000000>;
-	};
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_0 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb1_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-/* SDIO WiFi */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vmmc-supply = <&buck4>;
-	bus-width = <4>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	status = "okay";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	brcmf: bcrmf@1 {	/* muRata 2AE */
-		reg = <1>;
-		compatible = "cypress,cyw4373-fmac", "brcm,bcm4329-fmac";
-		/*
-		 * The "host-wake" interrupt output is by default not
-		 * connected to the SoC, but can be connected on to
-		 * SoC pin on the carrier board.
-		 */
-		reset-gpios = <&ioexp 1 GPIO_ACTIVE_LOW>;
-	};
-};
-
-/* SD slot */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-/* eMMC */
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	vmmc-supply = <&buck4>;
-	vqmmc-supply = <&buck5>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-0 = <&pinctrl_hog_base
-		     &pinctrl_dhcom_a &pinctrl_dhcom_b &pinctrl_dhcom_c
-		     &pinctrl_dhcom_d &pinctrl_dhcom_e &pinctrl_dhcom_f
-		     &pinctrl_dhcom_g &pinctrl_dhcom_h &pinctrl_dhcom_i
-		     &pinctrl_dhcom_j &pinctrl_dhcom_k &pinctrl_dhcom_l
-		     &pinctrl_dhcom_m &pinctrl_dhcom_n &pinctrl_dhcom_o
-		     &pinctrl_dhcom_p &pinctrl_dhcom_q &pinctrl_dhcom_r
-		     &pinctrl_dhcom_s &pinctrl_dhcom_int>;
-	pinctrl-names = "default";
-
-	pinctrl_dhcom_a: dhcom-a-grp {
-		fsl,pins = <
-			/* ENET_QOS_EVENT0-OUT */
-			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09		0x2
-		>;
-	};
-
-	pinctrl_dhcom_b: dhcom-b-grp {
-		fsl,pins = <
-			/* ENET_QOS_EVENT0-IN */
-			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x2
-		>;
-	};
-
-	pinctrl_dhcom_c: dhcom-c-grp {
-		fsl,pins = <
-			/* GPIO_C */
-			MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02		0x2
-		>;
-	};
-
-	pinctrl_dhcom_d: dhcom-d-grp {
-		fsl,pins = <
-			/* GPIO_D */
-			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27		0x2
-		>;
-	};
-
-	pinctrl_dhcom_e: dhcom-e-grp {
-		fsl,pins = <
-			/* GPIO_E */
-			MX8MP_IOMUXC_UART1_RXD__GPIO5_IO22		0x2
-		>;
-	};
-
-	pinctrl_dhcom_f: dhcom-f-grp {
-		fsl,pins = <
-			/* GPIO_F */
-			MX8MP_IOMUXC_UART1_TXD__GPIO5_IO23		0x2
-		>;
-	};
-
-	pinctrl_dhcom_g: dhcom-g-grp {
-		fsl,pins = <
-			/* GPIO_G */
-			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00		0x2
-		>;
-	};
-
-	pinctrl_dhcom_h: dhcom-h-grp {
-		fsl,pins = <
-			/* GPIO_H */
-			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x2
-		>;
-	};
-
-	pinctrl_dhcom_i: dhcom-i-grp {
-		fsl,pins = <
-			/* CSI1_SYNC */
-			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x2
-		>;
-	};
-
-	pinctrl_dhcom_j: dhcom-j-grp {
-		fsl,pins = <
-			/* CSIx_#RST */
-			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x2
-		>;
-	};
-
-	pinctrl_dhcom_k: dhcom-k-grp {
-		fsl,pins = <
-			/* CSIx_PWDN */
-			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x2
-		>;
-	};
-
-	pinctrl_dhcom_l: dhcom-l-grp {
-		fsl,pins = <
-			/* CSI2_SYNC */
-			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x2
-		>;
-	};
-
-	pinctrl_dhcom_m: dhcom-m-grp {
-		fsl,pins = <
-			/* CSIx_MCLK */
-			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x2
-		>;
-	};
-
-	pinctrl_dhcom_n: dhcom-n-grp {
-		fsl,pins = <
-			/* CSI2_D3- */
-			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x2
-		>;
-	};
-
-	pinctrl_dhcom_o: dhcom-o-grp {
-		fsl,pins = <
-			/* CSI2_D3+ */
-			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x2
-		>;
-	};
-
-	pinctrl_dhcom_p: dhcom-p-grp {
-		fsl,pins = <
-			/* CSI2_D2- */
-			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x2
-		>;
-	};
-
-	pinctrl_dhcom_q: dhcom-q-grp {
-		fsl,pins = <
-			/* CSI2_D2+ */
-			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x2
-		>;
-	};
-
-	pinctrl_dhcom_r: dhcom-r-grp {
-		fsl,pins = <
-			/* CSI2_D1- */
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x2
-		>;
-	};
-
-	pinctrl_dhcom_s: dhcom-s-grp {
-		fsl,pins = <
-			/* CSI2_D1+ */
-			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x2
-		>;
-	};
-
-	pinctrl_dhcom_int: dhcom-int-grp {
-		fsl,pins = <
-			/* INT_HIGHEST_PRIO */
-			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20			0x2
-		>;
-	};
-
-	pinctrl_hog_base: dhcom-hog-base-grp {
-		fsl,pins = <
-			/* GPIOs for memory coding */
-			MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22		0x40000080
-			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23		0x40000080
-			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24		0x40000080
-			/* GPIOs for hardware coding */
-			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x40000080
-			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x40000080
-			MX8MP_IOMUXC_SAI5_MCLK__GPIO3_IO25		0x40000080
-		>;
-	};
-
-	pinctrl_ecspi1: dhcom-ecspi1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__ECSPI1_SCLK		0x44
-			MX8MP_IOMUXC_I2C1_SDA__ECSPI1_MOSI		0x44
-			MX8MP_IOMUXC_I2C2_SCL__ECSPI1_MISO		0x44
-			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0x40
-		>;
-	};
-
-	pinctrl_ecspi2: dhcom-ecspi2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x44
-			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x44
-			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x44
-			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40
-		>;
-	};
-
-	pinctrl_eqos_rgmii: dhcom-eqos-rgmii-grp {	/* RGMII */
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91
-		>;
-	};
-
-	pinctrl_eqos_rmii: dhcom-eqos-rmii-grp {	/* RMII */
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f
-			MX8MP_IOMUXC_ENET_RXC__ENET_QOS_RX_ER		0x1f
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91
-			/* Clock */
-			MX8MP_IOMUXC_ENET_TD2__CCM_ENET_QOS_CLOCK_GENERATE_REF_CLK	0x4000001f
-		>;
-	};
-
-	pinctrl_ethphy0: dhcom-ethphy0-grp {
-		fsl,pins = <
-			/* ENET_QOS_#INT Interrupt */
-			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x22
-		>;
-	};
-
-	pinctrl_ethphy1: dhcom-ethphy1-grp {
-		fsl,pins = <
-			/* ENET1_#RST Reset */
-			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x11
-			/* ENET1_#INT Interrupt */
-			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x11
-		>;
-	};
-
-	pinctrl_fec_rgmii: dhcom-fec-rgmii-grp {	/* RGMII */
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_MCLK__ENET1_TX_CLK		0x1f
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
-			MX8MP_IOMUXC_SAI1_TXD6__ENET1_RX_ER		0x1f
-		>;
-	};
-
-	pinctrl_fec_rmii: dhcom-fec-rmii-grp {	/* RMII */
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_SAI1_TXD6__ENET1_RX_ER		0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
-			/* Clock */
-			MX8MP_IOMUXC_SAI1_MCLK__ENET1_TX_CLK		0x4000001f
-		>;
-	};
-
-	pinctrl_flexcan1: dhcom-flexcan1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX			0x154
-			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX			0x154
-		>;
-	};
-
-	pinctrl_flexcan2: dhcom-flexcan2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__CAN2_TX			0x154
-			MX8MP_IOMUXC_UART3_TXD__CAN2_RX			0x154
-		>;
-	};
-
-	pinctrl_flexspi: dhcom-flexspi-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2
-			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82
-			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82
-			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82
-			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82
-			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82
-		>;
-	};
-
-	pinctrl_hdmi: dhcom-hdmi-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
-			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
-		>;
-	};
-
-	pinctrl_i2c3: dhcom-i2c3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x40000084
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c3_gpio: dhcom-i2c3-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0x84
-			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0x84
-		>;
-	};
-
-	pinctrl_i2c4: dhcom-i2c4-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL			0x40000084
-			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c4_gpio: dhcom-i2c4-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20		0x84
-			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21		0x84
-		>;
-	};
-
-	pinctrl_i2c5: dhcom-i2c5-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_HDMI_DDC_SCL__I2C5_SCL		0x40000084
-			MX8MP_IOMUXC_HDMI_DDC_SDA__I2C5_SDA		0x40000084
-		>;
-	};
-
-	pinctrl_i2c5_gpio: dhcom-i2c5-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_HDMI_DDC_SCL__GPIO3_IO26		0x84
-			MX8MP_IOMUXC_HDMI_DDC_SDA__GPIO3_IO27		0x84
-		>;
-	};
-
-	pinctrl_ioexp: dhcom-ioexp-grp {
-		fsl,pins = <
-			/* #GPIO_EXP_INT */
-			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x22
-		>;
-	};
-
-	pinctrl_pmic: dhcom-pmic-grp {
-		fsl,pins = <
-			/* PMIC_nINT */
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x40000090
-		>;
-	};
-
-	pinctrl_pwm1: dhcom-pwm1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT		0x6
-		>;
-	};
-
-	pinctrl_tc9595: dhcom-tc9595-grp {
-		fsl,pins = <
-			/* RESET_DSIBRIDGE */
-			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01		0x40000146
-			/* DSI-CONV_INT Interrupt */
-			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x141
-		>;
-	};
-
-	pinctrl_sai3: dhcom-sai3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
-			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
-			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
-			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
-		>;
-	};
-
-	pinctrl_touch: dhcom-touch-grp {
-		fsl,pins = <
-			/* #TOUCH_INT */
-			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00		0x40000080
-		>;
-	};
-
-	pinctrl_uart1: dhcom-uart1-grp {
-		fsl,pins = <
-			/* Console UART */
-			MX8MP_IOMUXC_SAI2_RXC__UART1_DCE_RX		0x49
-			MX8MP_IOMUXC_SAI2_RXFS__UART1_DCE_TX		0x49
-			MX8MP_IOMUXC_SAI2_RXD0__UART1_DCE_RTS		0x49
-			MX8MP_IOMUXC_SAI2_TXFS__UART1_DCE_CTS		0x49
-		>;
-	};
-
-	pinctrl_uart2: dhcom-uart2-grp {
-		fsl,pins = <
-			/* Bluetooth UART */
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x49
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x49
-			MX8MP_IOMUXC_SD1_DATA4__UART2_DCE_RTS		0x49
-			MX8MP_IOMUXC_SD1_DATA5__UART2_DCE_CTS		0x49
-		>;
-	};
-
-	pinctrl_uart3: dhcom-uart3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x49
-			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x49
-			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS		0x49
-			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x49
-		>;
-	};
-
-	pinctrl_uart4: dhcom-uart4-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x49
-			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x49
-		>;
-	};
-
-	pinctrl_usb1_vbus: dhcom-usb1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR		0x6
-			MX8MP_IOMUXC_GPIO1_IO15__USB2_OTG_OC		0x80
-		>;
-	};
-
-	pinctrl_usdhc1: dhcom-usdhc1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x190
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d0
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d0
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d0
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d0
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d0
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: dhcom-usdhc1-100mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x194
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d4
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d4
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d4
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d4
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d4
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: dhcom-usdhc1-200mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x196
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d6
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d6
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d6
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d6
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d6
-		>;
-	};
-
-	pinctrl_usdhc2: dhcom-usdhc2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: dhcom-usdhc2-100mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: dhcom-usdhc2-200mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_vmmc: dhcom-usdhc2-vmmc-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x20
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: dhcom-usdhc2-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x40000080
-		>;
-	};
-
-	pinctrl_usdhc3: dhcom-usdhc3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
-			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x141
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: dhcom-usdhc3-100mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
-			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x141
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: dhcom-usdhc3-200mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196
-			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x141
-		>;
-	};
-
-	pinctrl_wdog: dhcom-wdog-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0xc6
-		>;
-	};
-};
diff --git a/configs/imx8mp_dhcom_drc02_defconfig b/configs/imx8mp_dhcom_drc02_defconfig
index c43839cecf5..82de0eb391a 100644
--- a/configs/imx8mp_dhcom_drc02_defconfig
+++ b/configs/imx8mp_dhcom_drc02_defconfig
@@ -2,6 +2,7 @@
 
 CONFIG_ARM=y
 CONFIG_ARCH_IMX8M=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-drc02"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-dhcom-drc02"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-drc02.dtb"
+CONFIG_OF_UPSTREAM=y
 CONFIG_PREBOOT=""
diff --git a/configs/imx8mp_dhcom_picoitx_defconfig b/configs/imx8mp_dhcom_picoitx_defconfig
index 99cd5f279dc..2442e260f9f 100644
--- a/configs/imx8mp_dhcom_picoitx_defconfig
+++ b/configs/imx8mp_dhcom_picoitx_defconfig
@@ -2,6 +2,7 @@
 
 CONFIG_ARM=y
 CONFIG_ARCH_IMX8M=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-picoitx"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-dhcom-picoitx"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-picoitx.dtb"
+CONFIG_OF_UPSTREAM=y
 CONFIG_PREBOOT=""

-- 
2.51.0

