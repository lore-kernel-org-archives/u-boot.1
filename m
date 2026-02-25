Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E311FF55431
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E8183E88;
	Wed, 25 Feb 2026 01:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L+6aBedo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD0183EBA; Wed, 25 Feb 2026 01:14:33 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40BA83D17
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAkuXLiufC3WJTaWiYDzYtrJ5ieau2PEVUq4hS/cfjs3pozndvuog2pL6kbesF2zEtJ+E75UTN+Z5r9rZyo8cqMAXVMWOPMljecj1ebdMpzbmgW0ePdNgP/AvEEuqD0ljH9rZfwfzmh8Ch2gH8WOxWJwAVu/HAuDBJq6QF78VRK7zslGxz/rgGPi4x/pP4z3umhaMbQXMbMyjnFKjHgcfRvbdKU2TLHhiD24mUrlVo+i6tSndwXzyeDEip/YfcTQjX0ZuPUdcEWTEHMjE8WNMZHJFr6xsHHMk0mNHeQMS+LZqy8sbylfz3HR8lY7ReeZmPTFkwBxPB1yipd9fDE5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM183C/3RSghFxICJ1P9ij5WlL4VHrpVIfHQvRay4WQ=;
 b=HHB9dqZ2DPMyJN+W2iUXHaDjt8ubViZ/fJdjb0QUoHsF3rM/M6LpHnjnVPfTW5egzSjSwhy33U+4F9yaj4DEDs32zAh+t2oPyxDZF8jAqDbFS4/YaNq3o1c/H+UMIJM4XU6nU/nkOB9wl2rMwco5J6SmP69CbxvJG/tnMYHwz4akuQWThdxcXQYDlJ7Z4/4xr1kyJaJ+BPgH7TXKs0/yRRaN9On0IaD6lA37HNdM1zEHjE2jJOzqzbGCIcXQ27JFYL6aMvaJgPJp26uHniN1roXjZoUH9RRjkZDpLgsZ1FmQd8i7WI7xENvyGr9YTooTI3jUL185MEvLW36p0Ob/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM183C/3RSghFxICJ1P9ij5WlL4VHrpVIfHQvRay4WQ=;
 b=L+6aBedoJNIsQkgYKWjnYK/OTyDpSWxWi5NX4UJp7fK8gkompK+UvpHJLxwgnk4ovTMwJTgs2JmY+SKL5tVMasE6gBwURB6a6V7vfMbMCqWWUtV6vJ2lDGzpQIaGE7/4+rEHMbNbpkV1Y2jg8VBXPukHQD+CfAG6y7PRMN5aL4YFPwdZHd4iX3c1a2yvg3TnrtOrBnqaO8DewaAzlnF6PeX2pZcvYfREL/FcMt+pIbYH5hfsFYDnfpgTu6L6/zPhCL5oToKmFfcMOt5tkf9+6Ah2059zMyzjbCdzhSBZYn5DpNLPMrYiazZ+ifqrtp3fuXWkd1/dMnCFX/X30RRg4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:31 +0800
Subject: [PATCH 05/10] pinctrl: nxp: imx8mq: Support print pin muxing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-5-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff21ca5-480d-4483-2bff-08de7402d7f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXFNZ0VyTGFtZldHNUozck8vVnlGQkxRQUZLNDk2b08xc3NuVXNsbVZJWjFo?=
 =?utf-8?B?WDNoSDlib3lqZHJHSjRpMTdJeTFsNHdQcWYxaDhsem1KdTljYmZZWXJpejlo?=
 =?utf-8?B?RG5QWjBUNzlEYkhyZU14SFphSFhUaVFkc2dJWVpDbEhoL25nMFFxb1FIdEVt?=
 =?utf-8?B?MzFwZWkvNTVncXdYdm85MVJmQ2ZjOU94R21FTzhKeS9wc1k1YWNPS3JwVG04?=
 =?utf-8?B?Y2wzRis4NDR0VWMzNUZ2b09tQTM3RXZNT1BVcTlqeFM1VjRLVHdWVVdLY3Jp?=
 =?utf-8?B?TFhiOWtIaVZjelZjeVd3MU9DSUR1TmVxUnFvVXNhWXA3NzBDRFRFOHBKd0hX?=
 =?utf-8?B?S0c0OEROeFdaSHNXUlJlZ2Eva3pjbFVtQnQzbXV2TVNwRXRHVFhIK2N2dVpm?=
 =?utf-8?B?ZUZVbENsUEdEdkEzNWNjTjB6OUhUeHFuNnB6T1dNYlVya2M2elM4TWZVWTln?=
 =?utf-8?B?dWptYld0YWtvRThNNWNzVHBqUnpuVHdlTHJ3YXFFZm1MeW9xa3Y1WEdkTU5o?=
 =?utf-8?B?bVBTS0ZMR0dUaUN0UUZtVzNIYk5icFRqQkQvQ2lCS2tvU0RxZWRmRWErODV2?=
 =?utf-8?B?cW1CcldldzlUSHlmaEZhbWFZR2RYTDllRnlVeFFyeStrZ0w0QjFJMTJuTm9x?=
 =?utf-8?B?UkR0bWFYajBnUDVnOVNSd2dlMEhlUmY4UEhranROSlI0UU9PbTBWR0UzQmJC?=
 =?utf-8?B?RGs5RGIzdkdHQVZUK1JFajVmSVJ5bnJUaGZ1MC90QXJkRmxFVm9PUUVEd1dJ?=
 =?utf-8?B?cXpWUHVyVGUwWWhuMlJUbWNlU2ZyTTB3NE15N1V1Z1ppWVBjR0g2WSttRXNo?=
 =?utf-8?B?QlpoN0tySDQyNFFMU0pHMFBUcG9semRBSXpweHJWclZ4WWErMDN2WUZ1QXFm?=
 =?utf-8?B?WXh4b1g4NlBaN1U5aktrUndjMFBZMmVtbHk2UlZIbGZvU3RWRW1tcFRwRUdi?=
 =?utf-8?B?Q2Q4QlVmU3U3bWlWL2dXQ0FkSTdjZ3dCN2hsSzJjSGs3TzFLa1RUUDVuWjNU?=
 =?utf-8?B?Q3YwUjFqdnZPSGhmeU01bkNqOEFWSm9sTC9hOXBicCt5Y0RyZlIvN0pDcCsr?=
 =?utf-8?B?RVdSQ3lmRDQ3QS9GVVEvWUJteTJ4bElML29VUzlGbTFvWURtQkluaU1vdlV6?=
 =?utf-8?B?azZEMVZ0VVh1QWVGaXlEaUpMcUwxZ211bEp4Q0RwNXVOaWF0cXVLUDV4ZlNI?=
 =?utf-8?B?R09oUDZHcnl0NXBPZjFPdzVaL04zMnFVZ25OY3Bkb01OMWU1NkxjWTZoY3Iw?=
 =?utf-8?B?YS8rdUkzNjBtZ2lFT21EcG1xQmFsNTQzSDI1Vi9rOGgvRWxZeDVPR3dDSkt6?=
 =?utf-8?B?UjJzSHE4S0wvZitUQzh5RkJCcTAzS1ZRTFJlcWsyMGxaRmROdHF0NlNEcUdU?=
 =?utf-8?B?SjIyRFNRTkZZczF0clpFT3NkZ29ESFI1ZlJoa094V0FDaGorQjhpbFNFWDNz?=
 =?utf-8?B?RFBmRG84a2wvQ1JoTjFib0ZnMjJzNmxLNmJWR3M1elJxQnNiMW9CK242S3Fy?=
 =?utf-8?B?L3BVY0dXYzAyTkFJUXVaQUpWWkJLL0FSc0VYdkV2QmRxR3BkajZ0ZERMNjBL?=
 =?utf-8?B?UVlBdFdBRFhNTi95L3k4VEhrcTU4LzA3ZE0yOHkvR3hsS2dSclRYcGsxQkUz?=
 =?utf-8?B?RVN5UHpkRWhWeDZ6TVpqcFRxaVpnaFRzYTlIOXhYbmY1UVlZcnhZeDRhV2xs?=
 =?utf-8?B?YUJpQklLakFwczhYUzhTaEJZVTEzWi96bGlHeXFmUjROZ2hQUVJnanRQa2Rv?=
 =?utf-8?B?QnlZSmMxMFE1YWxid3YwMk8xUWRSOTBlSmo3NEMvOGE5ZzQzK2dXSGsrMms0?=
 =?utf-8?B?MlhIMXQzNUN2TUh4WmRJOTdReHFNUTcyOTlWY21HZWVLb0FpV1pqU2lIc1NW?=
 =?utf-8?B?d1FqTWI1T1B5T0NzQWwwR3lYb3FDUWRrY3Z0WE1XaVgrcitrbElYdUVHTmRz?=
 =?utf-8?B?TytjU3VFSjlrdmVuWDd4SUdzTTA0dS8zUEovaTNnU0JxMThWcUQzRkhSZmk4?=
 =?utf-8?B?VU5qMVE0L3dXTXUxUWlKUE5pcVF3dnJkY3hyczlEWXlXUGtBRHFaZnAzRDdL?=
 =?utf-8?B?VWcrWURBU2pKczZmSytrWlJtYmpxa3NVcHhlYkNWU3hoK0hRNE9Tc3UxRnFG?=
 =?utf-8?B?WmJpOHFZOUFFRnlURDdITmRQTk9wUW1NTEUzMWRvQUpDMFZISWM5REwxaHBR?=
 =?utf-8?Q?eyTipL+bV02daHRSsQ5K6PE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1EvK1dmK2YySjFXeXBqbWdNdXFWM1IyWkhPcElEa3dIa2RXdFpyWGlPam5G?=
 =?utf-8?B?Smp2eFJkRHhjYjRTbWY5Tmw2V0E1QTE3eUZMU28yNHNXbTFtb0FSSEVVVUFx?=
 =?utf-8?B?TDh6dVAyZXRLU2ZyVU1UMUhoZWlrcjNsSG0rREpZdkY2NGV6VU1HWkFUR2Fa?=
 =?utf-8?B?czk1MWZwRVYrcnRmaVpvTktVRVdsM2lzeHhaS2EzbGQ4QlFEazJUdmczdGpV?=
 =?utf-8?B?ajhHU29seTY3ZHBUY1ZlTGlQek10SndNa01jNEd5Umt4TDdLb2I2dkhqcENK?=
 =?utf-8?B?U1FSdVc1Qm5ETEFad2pPZm8xdkRQeExITDViSU5Bc1hvdDFKL2hrSDJoMGFI?=
 =?utf-8?B?VGhuUVRCb05jWkRpbGFSNGNRalpUZ3pIakJjZEtaNEd1WUNDbWlSRzZhZld2?=
 =?utf-8?B?anlxeEc4WjlHUDFiRTB3UXJmbW9jalZzZ2tBSHJxZ290dDZWTmRsUFRBOGZi?=
 =?utf-8?B?RE1kampqc3F3STJmemRIeDZMSU9TK0dMK1B3bVFidVJVQmk0a1pNQXVXTmZi?=
 =?utf-8?B?SGMwemFXSG5ZVzA5b05oTWJPRWpKaHZ0L2FyU1J0MDBoSXFQUDNPY2pwTjQv?=
 =?utf-8?B?TGN4NXd0Y1RZSkVNcHowb2t5SFlmMWkvdWhIdDFEeGZ5SkdFOGpCaVdkMTU5?=
 =?utf-8?B?Znhtdk02a21XZnZGZWtCNkEzZ1FKdkNFU0tXZkt2c1puSzA3eHowUklvaWdZ?=
 =?utf-8?B?RFVHdzE0dGpoeWRPZHJkbTRoVElPM3hGNzBoVWxuckhTT3VUZFcrRGhiZnRt?=
 =?utf-8?B?aWJiaTV6NSt6ZUdKcUtIN1ZvUlBVUElqdDhFcXJ4VCttM21ncVh6eVhtODRo?=
 =?utf-8?B?Tm9ySHpweUt5a09HUlgvTkdUMjAweUpDZmwyRFdtRnRvazI1NWl3aWJYbVBO?=
 =?utf-8?B?a3lCRWtLZmVJUlN0Vm1Pb21aREVWM2pOV2djTFJsZWFVbVN4dVp5WlRLUk1L?=
 =?utf-8?B?dEZndG5SNTRpdDVCUThYSTcwYnlmeEhwakpqUTZWTGhONlk3VkovOWtWbEV0?=
 =?utf-8?B?b01ldDlRM1BzSSthMzJrdzlJUitFYzhLejdRYlJEcy9EYmxrNkN1blluRlAz?=
 =?utf-8?B?c3kzNVRCeXlPdjdFc2syc3hldGhxb2d6Wk1TK3I3M3lBYysvb0ZVTERkekpm?=
 =?utf-8?B?QXRDL1FmU3JjNTg0Q283Wmlob1NZamkvMDBUU2RxZmJQRFV3N0p3dWVZdEE0?=
 =?utf-8?B?NEVHOTRqQ3h0cnE1ekVyVUNGVDAwNDh0aFRhNGpHK2lxZXpvYkNBa003T3M1?=
 =?utf-8?B?VnBuZjlkeTRaMkNnQWR5V2NDUFdjWjJqMHJTYXVJUkFET3RlVmJmQlN0MzF0?=
 =?utf-8?B?OXBBS0QzaDdFN09zV2Y0TVVNb2YxUGYwYU9nRkJteUxjMnUyK0ticnV4TlVS?=
 =?utf-8?B?YmgzVVcwMFRacHkxYTlTbEI2eFppdDQwY0JqNlRiY1FiL3Zib1VUYkNST3hH?=
 =?utf-8?B?T3RTcnhlNWliaUl1VWJEajdVV2ZUaUVPODFodGNPdmhldlRsQmVnOWZvMy9v?=
 =?utf-8?B?bXlwbVppTGZscm9jM3hPZEpFTmFWLzZFNGNkREtQNzZtTjhMeno0ZHg3Zjk1?=
 =?utf-8?B?RWlSQVpuYUlCL0wrcWZVdjRGZHpNZnJxZmJQck12NkI1SW9CY0FlK3F0dDdH?=
 =?utf-8?B?ZlF6STZsRGlXQTNuWVR6bVBXR01zRjBOS2Z6SVJDbENTTHNIWGpITG9obyt3?=
 =?utf-8?B?LzRBOGxobjI1SWlwaDFEWmE3RUpBdmtjSzJpd1kwTGxnV1V1ek5udnp5anpz?=
 =?utf-8?B?cGt2TkdKN1B1NHBIeVEzTnU3Sm1JSEt1MTc4ajA5NEhnWldLcEN1ZTl4UXdR?=
 =?utf-8?B?YktOZUw1VnREUmNrNmVaQlhsRWIrRjB0T2xPUy9HN1pBL1hhZ0VrQXNIZE9J?=
 =?utf-8?B?aE9IbTVGazlIOTgrcHFjTlVuSUI5cUNhY3YwbkgvNVF3Si9sZytDaUJwY2w4?=
 =?utf-8?B?YjQ5UVZjMndTRTRZMURnWjlsQlltTW4wYTcvekFNQ2wzYnkwbzNTRDFTdjdl?=
 =?utf-8?B?K3pWTlNLM3lXc3R1Q3JpazRET2dGVitxZnpIVGlwUHQvUlA2S3UxK05hNGU0?=
 =?utf-8?B?dnFnWUR0UlovS3ZoY0ZmUFR0bUpLWWFLUCs0Rzk4Y0wzTHE4T3hNMjBDRmwr?=
 =?utf-8?B?S3BrKzM0VnB4aEJNMk14Z0UwLzFYVEUwRkV3Q1h0UVBnSENqOG43TkVZSmlK?=
 =?utf-8?B?VXMrY0FXWHY3dVp1b3NaNFZicEFpQWJqcEs0U2gySHRLM0JXZGZIcDQ1aXJh?=
 =?utf-8?B?enRBa1pZbVdvTTl6cjVFRGlZMmxBK1R2Sjl0UnAwTER2VFhTRGgrSllCc2d3?=
 =?utf-8?B?MEhLaXFwa3h4WmNub0VXSkc5V056bTNOeUVqS0dKK0xYUTlBamR3QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff21ca5-480d-4483-2bff-08de7402d7f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:29.6986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgcZH8Mx4LforWfvLtaINxXctJ1JA0+u3rSutQfMEnFoKfjQ3Fp0jDxDH17CZbFe22rjXIzrsVZkn/kFv2GnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

Add support for printing pin names and current mux configuration on i.MX8MQ
when CMD_PINMUX is enabled by adding full pin descriptor table for i.MX8MQ
pads.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx8m.c  |   2 +
 drivers/pinctrl/nxp/pinctrl-imx8mq.c | 310 +++++++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index 1ae2656b8c6..f1cadb9f142 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -30,6 +30,8 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 #include "pinctrl-imx8mn.c"
 #elif IS_ENABLED(CONFIG_IMX8MM)
 #include "pinctrl-imx8mm.c"
+#elif IS_ENABLED(CONFIG_IMX8MQ)
+#include "pinctrl-imx8mq.c"
 #endif
 
 static int imx8m_get_pins_count(struct udevice *dev)
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8mq.c b/drivers/pinctrl/nxp/pinctrl-imx8mq.c
new file mode 100644
index 00000000000..bcc3e8ecbcf
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx8mq.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "pinctrl-imx.h"
+
+enum imx8mq_pads {
+	RESERVE0 = 0,
+	RESERVE1 = 1,
+	RESERVE2 = 2,
+	RESERVE3 = 3,
+	RESERVE4 = 4,
+	PMIC_STBY_REQ_CCMSRCGPCMIX = 5,
+	PMIC_ON_REQ_SNVSMIX = 6,
+	ONOFF_SNVSMIX = 7,
+	POR_B_SNVSMIX = 8,
+	RTC_RESET_B_SNVSMIX = 9,
+	GPIO1_IO00 = 10,
+	GPIO1_IO01 = 11,
+	GPIO1_IO02 = 12,
+	GPIO1_IO03 = 13,
+	GPIO1_IO04 = 14,
+	GPIO1_IO05 = 15,
+	GPIO1_IO06 = 16,
+	GPIO1_IO07 = 17,
+	GPIO1_IO08 = 18,
+	GPIO1_IO09 = 19,
+	GPIO1_IO10 = 20,
+	GPIO1_IO11 = 21,
+	GPIO1_IO12 = 22,
+	GPIO1_IO13 = 23,
+	GPIO1_IO14 = 24,
+	GPIO1_IO15 = 25,
+	ENET_MDC = 26,
+	ENET_MDIO = 27,
+	ENET_TD3 = 28,
+	ENET_TD2 = 29,
+	ENET_TD1 = 30,
+	ENET_TD0 = 31,
+	ENET_TX_CTL = 32,
+	ENET_TXC = 33,
+	ENET_RX_CTL = 34,
+	ENET_RXC = 35,
+	ENET_RD0 = 36,
+	ENET_RD1 = 37,
+	ENET_RD2 = 38,
+	ENET_RD3 = 39,
+	SD1_CLK = 40,
+	SD1_CMD = 41,
+	SD1_DATA0 = 42,
+	SD1_DATA1 = 43,
+	SD1_DATA2 = 44,
+	SD1_DATA3 = 45,
+	SD1_DATA4 = 46,
+	SD1_DATA5 = 47,
+	SD1_DATA6 = 48,
+	SD1_DATA7 = 49,
+	SD1_RESET_B = 50,
+	SD1_STROBE = 51,
+	SD2_CD_B = 52,
+	SD2_CLK = 53,
+	SD2_CMD = 54,
+	SD2_DATA0 = 55,
+	SD2_DATA1 = 56,
+	SD2_DATA2 = 57,
+	SD2_DATA3 = 58,
+	SD2_RESET_B = 59,
+	SD2_WP = 60,
+	NAND_ALE = 61,
+	NAND_CE0_B = 62,
+	NAND_CE1_B = 63,
+	NAND_CE2_B = 64,
+	NAND_CE3_B = 65,
+	NAND_CLE = 66,
+	NAND_DATA00 = 67,
+	NAND_DATA01 = 68,
+	NAND_DATA02 = 69,
+	NAND_DATA03 = 70,
+	NAND_DATA04 = 71,
+	NAND_DATA05 = 72,
+	NAND_DATA06 = 73,
+	NAND_DATA07 = 74,
+	NAND_DQS = 75,
+	NAND_RE_B = 76,
+	NAND_READY_B = 77,
+	NAND_WE_B = 78,
+	NAND_WP_B = 79,
+	SAI5_RXFS = 80,
+	SAI5_RXC = 81,
+	SAI5_RXD0 = 82,
+	SAI5_RXD1 = 83,
+	SAI5_RXD2 = 84,
+	SAI5_RXD3 = 85,
+	SAI5_MCLK = 86,
+	SAI1_RXFS = 87,
+	SAI1_RXC = 88,
+	SAI1_RXD0 = 89,
+	SAI1_RXD1 = 90,
+	SAI1_RXD2 = 91,
+	SAI1_RXD3 = 92,
+	SAI1_RXD4 = 93,
+	SAI1_RXD5 = 94,
+	SAI1_RXD6 = 95,
+	SAI1_RXD7 = 96,
+	SAI1_TXFS = 97,
+	SAI1_TXC = 98,
+	SAI1_TXD0 = 99,
+	SAI1_TXD1 = 100,
+	SAI1_TXD2 = 101,
+	SAI1_TXD3 = 102,
+	SAI1_TXD4 = 103,
+	SAI1_TXD5 = 104,
+	SAI1_TXD6 = 105,
+	SAI1_TXD7 = 106,
+	SAI1_MCLK = 107,
+	SAI2_RXFS = 108,
+	SAI2_RXC = 109,
+	SAI2_RXD0 = 110,
+	SAI2_TXFS = 111,
+	SAI2_TXC = 112,
+	SAI2_TXD0 = 113,
+	SAI2_MCLK = 114,
+	SAI3_RXFS = 115,
+	SAI3_RXC = 116,
+	SAI3_RXD = 117,
+	SAI3_TXFS = 118,
+	SAI3_TXC = 119,
+	SAI3_TXD = 120,
+	SAI3_MCLK = 121,
+	SPDIF_TX = 122,
+	SPDIF_RX = 123,
+	SPDIF_EXT_CLK = 124,
+	ECSPI1_SCLK = 125,
+	ECSPI1_MOSI = 126,
+	ECSPI1_MISO = 127,
+	ECSPI1_SS0 = 128,
+	ECSPI2_SCLK = 129,
+	ECSPI2_MOSI = 130,
+	ECSPI2_MISO = 131,
+	ECSPI2_SS0 = 132,
+	I2C1_SCL = 133,
+	I2C1_SDA = 134,
+	I2C2_SCL = 135,
+	I2C2_SDA = 136,
+	I2C3_SCL = 137,
+	I2C3_SDA = 138,
+	I2C4_SCL = 139,
+	I2C4_SDA = 140,
+	UART1_RXD = 141,
+	UART1_TXD = 142,
+	UART2_RXD = 143,
+	UART2_TXD = 144,
+	UART3_RXD = 145,
+	UART3_TXD = 146,
+	UART4_RXD = 147,
+	UART4_TXD = 148,
+};
+
+static const struct imx_pinctrl_pin_desc imx8m_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(RESERVE0),
+	IMX_PINCTRL_PIN(RESERVE1),
+	IMX_PINCTRL_PIN(RESERVE2),
+	IMX_PINCTRL_PIN(RESERVE3),
+	IMX_PINCTRL_PIN(RESERVE4),
+	IMX_PINCTRL_PIN(PMIC_STBY_REQ_CCMSRCGPCMIX),
+	IMX_PINCTRL_PIN(PMIC_ON_REQ_SNVSMIX),
+	IMX_PINCTRL_PIN(ONOFF_SNVSMIX),
+	IMX_PINCTRL_PIN(POR_B_SNVSMIX),
+	IMX_PINCTRL_PIN(RTC_RESET_B_SNVSMIX),
+	IMX_PINCTRL_PIN(GPIO1_IO00),
+	IMX_PINCTRL_PIN(GPIO1_IO01),
+	IMX_PINCTRL_PIN(GPIO1_IO02),
+	IMX_PINCTRL_PIN(GPIO1_IO03),
+	IMX_PINCTRL_PIN(GPIO1_IO04),
+	IMX_PINCTRL_PIN(GPIO1_IO05),
+	IMX_PINCTRL_PIN(GPIO1_IO06),
+	IMX_PINCTRL_PIN(GPIO1_IO07),
+	IMX_PINCTRL_PIN(GPIO1_IO08),
+	IMX_PINCTRL_PIN(GPIO1_IO09),
+	IMX_PINCTRL_PIN(GPIO1_IO10),
+	IMX_PINCTRL_PIN(GPIO1_IO11),
+	IMX_PINCTRL_PIN(GPIO1_IO12),
+	IMX_PINCTRL_PIN(GPIO1_IO13),
+	IMX_PINCTRL_PIN(GPIO1_IO14),
+	IMX_PINCTRL_PIN(GPIO1_IO15),
+	IMX_PINCTRL_PIN(ENET_MDC),
+	IMX_PINCTRL_PIN(ENET_MDIO),
+	IMX_PINCTRL_PIN(ENET_TD3),
+	IMX_PINCTRL_PIN(ENET_TD2),
+	IMX_PINCTRL_PIN(ENET_TD1),
+	IMX_PINCTRL_PIN(ENET_TD0),
+	IMX_PINCTRL_PIN(ENET_TX_CTL),
+	IMX_PINCTRL_PIN(ENET_TXC),
+	IMX_PINCTRL_PIN(ENET_RX_CTL),
+	IMX_PINCTRL_PIN(ENET_RXC),
+	IMX_PINCTRL_PIN(ENET_RD0),
+	IMX_PINCTRL_PIN(ENET_RD1),
+	IMX_PINCTRL_PIN(ENET_RD2),
+	IMX_PINCTRL_PIN(ENET_RD3),
+	IMX_PINCTRL_PIN(SD1_CLK),
+	IMX_PINCTRL_PIN(SD1_CMD),
+	IMX_PINCTRL_PIN(SD1_DATA0),
+	IMX_PINCTRL_PIN(SD1_DATA1),
+	IMX_PINCTRL_PIN(SD1_DATA2),
+	IMX_PINCTRL_PIN(SD1_DATA3),
+	IMX_PINCTRL_PIN(SD1_DATA4),
+	IMX_PINCTRL_PIN(SD1_DATA5),
+	IMX_PINCTRL_PIN(SD1_DATA6),
+	IMX_PINCTRL_PIN(SD1_DATA7),
+	IMX_PINCTRL_PIN(SD1_RESET_B),
+	IMX_PINCTRL_PIN(SD1_STROBE),
+	IMX_PINCTRL_PIN(SD2_CD_B),
+	IMX_PINCTRL_PIN(SD2_CLK),
+	IMX_PINCTRL_PIN(SD2_CMD),
+	IMX_PINCTRL_PIN(SD2_DATA0),
+	IMX_PINCTRL_PIN(SD2_DATA1),
+	IMX_PINCTRL_PIN(SD2_DATA2),
+	IMX_PINCTRL_PIN(SD2_DATA3),
+	IMX_PINCTRL_PIN(SD2_RESET_B),
+	IMX_PINCTRL_PIN(SD2_WP),
+	IMX_PINCTRL_PIN(NAND_ALE),
+	IMX_PINCTRL_PIN(NAND_CE0_B),
+	IMX_PINCTRL_PIN(NAND_CE1_B),
+	IMX_PINCTRL_PIN(NAND_CE2_B),
+	IMX_PINCTRL_PIN(NAND_CE3_B),
+	IMX_PINCTRL_PIN(NAND_CLE),
+	IMX_PINCTRL_PIN(NAND_DATA00),
+	IMX_PINCTRL_PIN(NAND_DATA01),
+	IMX_PINCTRL_PIN(NAND_DATA02),
+	IMX_PINCTRL_PIN(NAND_DATA03),
+	IMX_PINCTRL_PIN(NAND_DATA04),
+	IMX_PINCTRL_PIN(NAND_DATA05),
+	IMX_PINCTRL_PIN(NAND_DATA06),
+	IMX_PINCTRL_PIN(NAND_DATA07),
+	IMX_PINCTRL_PIN(NAND_DQS),
+	IMX_PINCTRL_PIN(NAND_RE_B),
+	IMX_PINCTRL_PIN(NAND_READY_B),
+	IMX_PINCTRL_PIN(NAND_WE_B),
+	IMX_PINCTRL_PIN(NAND_WP_B),
+	IMX_PINCTRL_PIN(SAI5_RXFS),
+	IMX_PINCTRL_PIN(SAI5_RXC),
+	IMX_PINCTRL_PIN(SAI5_RXD0),
+	IMX_PINCTRL_PIN(SAI5_RXD1),
+	IMX_PINCTRL_PIN(SAI5_RXD2),
+	IMX_PINCTRL_PIN(SAI5_RXD3),
+	IMX_PINCTRL_PIN(SAI5_MCLK),
+	IMX_PINCTRL_PIN(SAI1_RXFS),
+	IMX_PINCTRL_PIN(SAI1_RXC),
+	IMX_PINCTRL_PIN(SAI1_RXD0),
+	IMX_PINCTRL_PIN(SAI1_RXD1),
+	IMX_PINCTRL_PIN(SAI1_RXD2),
+	IMX_PINCTRL_PIN(SAI1_RXD3),
+	IMX_PINCTRL_PIN(SAI1_RXD4),
+	IMX_PINCTRL_PIN(SAI1_RXD5),
+	IMX_PINCTRL_PIN(SAI1_RXD6),
+	IMX_PINCTRL_PIN(SAI1_RXD7),
+	IMX_PINCTRL_PIN(SAI1_TXFS),
+	IMX_PINCTRL_PIN(SAI1_TXC),
+	IMX_PINCTRL_PIN(SAI1_TXD0),
+	IMX_PINCTRL_PIN(SAI1_TXD1),
+	IMX_PINCTRL_PIN(SAI1_TXD2),
+	IMX_PINCTRL_PIN(SAI1_TXD3),
+	IMX_PINCTRL_PIN(SAI1_TXD4),
+	IMX_PINCTRL_PIN(SAI1_TXD5),
+	IMX_PINCTRL_PIN(SAI1_TXD6),
+	IMX_PINCTRL_PIN(SAI1_TXD7),
+	IMX_PINCTRL_PIN(SAI1_MCLK),
+	IMX_PINCTRL_PIN(SAI2_RXFS),
+	IMX_PINCTRL_PIN(SAI2_RXC),
+	IMX_PINCTRL_PIN(SAI2_RXD0),
+	IMX_PINCTRL_PIN(SAI2_TXFS),
+	IMX_PINCTRL_PIN(SAI2_TXC),
+	IMX_PINCTRL_PIN(SAI2_TXD0),
+	IMX_PINCTRL_PIN(SAI2_MCLK),
+	IMX_PINCTRL_PIN(SAI3_RXFS),
+	IMX_PINCTRL_PIN(SAI3_RXC),
+	IMX_PINCTRL_PIN(SAI3_RXD),
+	IMX_PINCTRL_PIN(SAI3_TXFS),
+	IMX_PINCTRL_PIN(SAI3_TXC),
+	IMX_PINCTRL_PIN(SAI3_TXD),
+	IMX_PINCTRL_PIN(SAI3_MCLK),
+	IMX_PINCTRL_PIN(SPDIF_TX),
+	IMX_PINCTRL_PIN(SPDIF_RX),
+	IMX_PINCTRL_PIN(SPDIF_EXT_CLK),
+	IMX_PINCTRL_PIN(ECSPI1_SCLK),
+	IMX_PINCTRL_PIN(ECSPI1_MOSI),
+	IMX_PINCTRL_PIN(ECSPI1_MISO),
+	IMX_PINCTRL_PIN(ECSPI1_SS0),
+	IMX_PINCTRL_PIN(ECSPI2_SCLK),
+	IMX_PINCTRL_PIN(ECSPI2_MOSI),
+	IMX_PINCTRL_PIN(ECSPI2_MISO),
+	IMX_PINCTRL_PIN(ECSPI2_SS0),
+	IMX_PINCTRL_PIN(I2C1_SCL),
+	IMX_PINCTRL_PIN(I2C1_SDA),
+	IMX_PINCTRL_PIN(I2C2_SCL),
+	IMX_PINCTRL_PIN(I2C2_SDA),
+	IMX_PINCTRL_PIN(I2C3_SCL),
+	IMX_PINCTRL_PIN(I2C3_SDA),
+	IMX_PINCTRL_PIN(I2C4_SCL),
+	IMX_PINCTRL_PIN(I2C4_SDA),
+	IMX_PINCTRL_PIN(UART1_RXD),
+	IMX_PINCTRL_PIN(UART1_TXD),
+	IMX_PINCTRL_PIN(UART2_RXD),
+	IMX_PINCTRL_PIN(UART2_TXD),
+	IMX_PINCTRL_PIN(UART3_RXD),
+	IMX_PINCTRL_PIN(UART3_TXD),
+	IMX_PINCTRL_PIN(UART4_RXD),
+	IMX_PINCTRL_PIN(UART4_TXD),
+};

-- 
2.51.0

