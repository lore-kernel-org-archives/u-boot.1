Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CAECDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EA289059;
	Thu, 19 Sep 2024 04:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mmZSZOLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E43189071; Thu, 19 Sep 2024 04:58:48 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26B589057
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhzfcCWTL5jkgv+vikeoDRn9E7hTmsxvIqkvSvGPtXOxQLnx9QIQP/TatF1vSs4mc7UbBmdzVYHSmrR7BCWP2x6JWf8Cml/01HaCi/x6SXZuQIdXh/Q6bA7/Ic+u5xjOdj4c2R/qMX+naBzTH0xobYIkdU2gPjqDdplf2YIPLDib4LD+q2EyEuCJFLVQuD5ZmPlioKeOoP8mdOA9h90p5TPWtty+NxrMpwRIEykCirMvFPAEYfdL9CwUt2DT3PfnaV6C0nvNgdYvxvqKi/RRjQCzsDmWvh0NtXwZubBN+J6GMKmsFNyG0iEhc9CSTy9pXyn4hvJ1zQJ2L3ZuLBcXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JphzD/Efo6XrjkKulD7o3ySqmy0H1Lo6WrMyypPaNaA=;
 b=MXfkEbiV6lMbo6taXHjpBOsmrnoA87lBed7O+HsQHqp4AGi5prXKSeGqGR8Op/s9GlEkZA0DYjlGb5bPHmKK8481NWmEikJzpPdUXP+Mdiyjk2XAPoDSCdYWbQCoV48zkO8KQUuS8LKfEU1zgFD+cllHUziOu9hHqp3EIJFlmmZ+slTMxWmnkJ4c9q8GX8F5C0b8WPQFT3XJwm/QmRVoEZjsG4JoQZS17Yf6K0o52gkJuNH6M6bDkVHzus47sLgZWUIF78PNPVnXifvn1ucaYettAQZFP1Lm96TbtyM7RpiTEdRwZnbzRBHoN2kz5ZxFFretVYofb9PHwzu+ychemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JphzD/Efo6XrjkKulD7o3ySqmy0H1Lo6WrMyypPaNaA=;
 b=mmZSZOLKq11oHHcd3cToQ9gl4T6+9i/k9ORnqAA6JVhP8Ol7q+GSaKDpLV5fhmzHm+5+YUXUsu2inS57pgqqCAx5yd4hwDxbd6ahydUqwFXm9sGnAQ8Q+3k1T0IpbUIwuRL1kLDpk5aBpH4KmR7zZ3HVusI7L7RvtD6YudiL1BwF+Wc5WJ2sm27jc+SLUOPXe7TgPjvRcoessuTYSJ41Gppu5+ucV5xm33CwoDtKkG/0RmAshH91KRzZwThEmN8xgzmELOISx0C55tNjk6PIgi0oCWghqBn7teScHgLSTmKdy54/XQJo87WqLTsLMorZmQu6aNiqOE9Jzl3qzHp8Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:34 +0800
Subject: [PATCH v3 16/21] imx: Generalize fixup_thermal_trips
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-16-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: e60e33db-90a7-4606-56b6-08dcd856f9ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBOM0dOWkIxNW9NdDAzNnBGU3haWDRBVXhIdEVlUkM3RWN3OCtML2JBd0Nz?=
 =?utf-8?B?VUg0NWhldGhqbWV2ZUdxVjJaVlZyempBbktWcVFFUDZhclRxMU1wTmZMbzFQ?=
 =?utf-8?B?TlNKMFJzc0o3VkNGT1ZkVWErU2MxZzQ0TmozVnRlNTFnM3B3VlhkMGRsOEx4?=
 =?utf-8?B?V05JdVhTY2NiZE1rSkIrTlBjWkYxa2k5S25ERlkxMGFhWXJJN2xTeFhVSFVm?=
 =?utf-8?B?bFF3c0w1NEs3MGtWNVZlY214VXcrMkgvYUx4bGNlT25aREJzYUw1Y1R6U3ky?=
 =?utf-8?B?eTBvSXFOVHZTVFJzNkNKTjBUWGt6NFdrTDdIZVhYejhkOU10WnlIbkFBaGJI?=
 =?utf-8?B?cWNPSldoTWZvYTFjM0loazhmS0ZWUEVHRWRoNmZ0Z2FuSXhaNkpsL0d0ZEho?=
 =?utf-8?B?VTN4ZzBqeUtiRFA1aURRT2pQZkNNM3dObmF0K3lSdUt3dVBlR3JMVXZtb2V5?=
 =?utf-8?B?TSszS3VNREhYMy9Tc2Z2a3NOMWY4TjM1bHlOVjJjc1QwazlUaGFhYUFWcW5r?=
 =?utf-8?B?MFptckplVkRick1LME03ejJ5d2tRcE1sM1RVYXBxOXFPSEM0ZTNiWW94bi9R?=
 =?utf-8?B?WEovVHI3TElzR2lTUlJ0UHpVdENCei9jb3ZYd2NKbDZjSGV3b2h3UGFXbjhJ?=
 =?utf-8?B?QTJTTGFiSWcyZm1SaU5wNEtnY2dVWUwyTWVDUnN0d2hBRmY0QkNEL0VPWVRz?=
 =?utf-8?B?MjdVMDRIa3o4T0trK0tMRXNkOXRQMGtrRjJqWmRCZkJPNVRiUHdIdDZ1cWlW?=
 =?utf-8?B?ZVM5M2JSV3l4NmhrMHQxcjBFWndGL3M0RFNHVXMyNG8zZjdpYjBQQVBDaHhi?=
 =?utf-8?B?NzRPbTEvSUNpR0lnWXRaK2d1SFAwZHlXKzZMNG1KNXdBczNOY01KeHB1WFZn?=
 =?utf-8?B?ei9DdCtlMVZxR0U0dFpWOXpUTm14eFY4TERRVDVvdEFpVExqbzQ5dUdpdEVv?=
 =?utf-8?B?MnNOQnBLUW5vaFd2dnU2dXRIbDNwYjlhUmRicW5CNlUxTE93SVVnQnREL0Z3?=
 =?utf-8?B?MVRSYW1KY05sZzlvallqV3ArcExCQU56T0daeThkd1F2eENFYnBIZndWejk5?=
 =?utf-8?B?Mng4M3oyTjhHNVNYSWZqMXcxRElLVG1ac2RxTjFpK0Rhd1pydUdKVm5EckFl?=
 =?utf-8?B?WFRKaXN3SDltSzd4bDJLcWkydUkxUE8wa2Z4Z0lwRUd0bXVJblRsUDQ1QUVs?=
 =?utf-8?B?cXpoSWpRQ0pBMWNBRm9VUG9nVXR5Zk8yT3A5N1RCckFyRHZtbUM5UW93SGMx?=
 =?utf-8?B?WER6cVhoR1NFcTZ6L0ZxU2lUMVg5cU9SKzJXUFdTbndhNUVyRjdwRnowUWU2?=
 =?utf-8?B?UUsvZGwvYVU1bmc2UmpVTU94R3l2Nm1Fa2ZzbHhqRlM0cnR2bHFoK2FrOWJt?=
 =?utf-8?B?eTZTRGYwQlNyMi9EazZKSWFEL0RyaWRHUHFMLytJYTF3eUZSTjZBRHZuQ0Jl?=
 =?utf-8?B?ZjFMSldwalEzekNrK242Wlh0VXNBMldPaTdoUWM1U3NWa2pCd1d3MjFEcGd4?=
 =?utf-8?B?NThsajliOExpS1lDdlhGR2h3NUhZWGl6dWNEUUJzUGExay9mUFZodjhsajRO?=
 =?utf-8?B?VllONE10dnZIbjlJckljVkUyamUrdGNuVHZESFE1eFZtNGd5ZC9INXcwQXQr?=
 =?utf-8?B?SndvbU16dDBmYm96enhVRk5CWTM0b3dHbytBTlhaWmc4VVpjVE9kSWI2MGEw?=
 =?utf-8?B?V0Y0MnpabXJ6eG4vUGdGZ1lrR09BSDBxQnZkVkJhVGl0STZtRm50RGZyM0NE?=
 =?utf-8?B?S3QySkZqTVhGNk5mdHpPT1ZjWmNhcUN4Si9WOElYekpoYzNKcW1rNWpYWlVF?=
 =?utf-8?B?L0JSMGxBdGxHRHdjMUJNZ0RDQVoyWmN5blU4MUtjQ0M4N1FBN0ExeW1qT1lQ?=
 =?utf-8?B?cm5VYWRZZEhmV2cvb0NWQ25HYXVCT2QvWWwyVjBkbjhlM3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFR3Y3RtRVBGQlJ4czJHbCt1djJBdlo4ZllhSjA4STQ4Q2dUSm9QZFNkcDRq?=
 =?utf-8?B?VlNQQWk0aTJBRHZoZjhaL3IyUTZsMWVrS1dlczhYZm1YL2gxUTRqc002NUIr?=
 =?utf-8?B?TTQ0czlRU3l4NlFLVnlCM0ZSd1VyU3oxRGlJTDlMSUVBMktZN1BGaktGQm5F?=
 =?utf-8?B?K3dOSWJWaVV0ZERJcDZ5VzBHRXRrRkp3bXdDMWFicHM1WW0vclgrSUJPQndW?=
 =?utf-8?B?Y2xqeThMWGZidzZMUEVBZHM4RDdMcFZqZkVzUDFCdDlscExTMmhQeGIybVBk?=
 =?utf-8?B?dTF2WmVSdlVjQk1EbTk5UWwzQXR0bjlQeFI2aTVKcEl4a3hnVWVZYmJDL2JS?=
 =?utf-8?B?K0VZOWRLZGxoUktJWis3VGhkTkp0Y3RNNmduWndxTFdFSURaUXZ1K2RLaFdw?=
 =?utf-8?B?Z1NyZHVScEJiT1JnbjlHTE0vWTQrV3pjd0xJZzh5Y2JxbEtKaHQrSFgvenFD?=
 =?utf-8?B?TEpTOEtlY0hOdGRVRWpHcXhQS2NLNUhMY0xOc0ZpcC9xN2dPS1drYS9uYm9Y?=
 =?utf-8?B?NFk5V1laRjZ5T3VMUHNsZTBFWFpESGdRWVVSSk42QUh5SW1Dc1c2bHhjNU94?=
 =?utf-8?B?ZFJjYjRwUnJ6eVY5Y1krNHZZVEg4cmlhNU53U3JVQ0FiWkZMK3ZQM1RPeDZQ?=
 =?utf-8?B?ZWVUa2RsTTV6MHAvMjI1eHB6bGJ1YitoYWJTaVpnak5wU20vZ0NwOW55MkhZ?=
 =?utf-8?B?VUd2OE44dzE0NitERnJUR2dreVVLNTVuTFhGWXdmalNxVkpwVGVzb3pHbThn?=
 =?utf-8?B?K2hiRDU3QjFJZWhpV0JucjhQdFB5MFpDVVFFcDFLdjdnT1FweGk4a3N4WFpD?=
 =?utf-8?B?K3dkdXpmOEVXZnRtcVdwaWd6S1FCZ3hWT3RvaGsxZVNCN2o5TzNvSzJvYWh5?=
 =?utf-8?B?T3VQL0V3ZW9GVklCbmlqazhsQzh0NlFYTmIzN1lsYUNJRmc3amQzeDlTYklM?=
 =?utf-8?B?aW5Rek9ldmFtRWE2T01EakxyTGFVNWVFZngyNmxDaFRTaCtHQjVWaE5pV0xQ?=
 =?utf-8?B?dHpuU2NaVGR2NHpWdzljcXVCL2F1NkJZVE14aTF1Sm5XUmxIMG5nZWlHbVJK?=
 =?utf-8?B?UHFQVHl5RzhVdlk2RVY3SWYxYzVmNzRxblQ5Z1YrcnVvNldmaUd4T1ZoT1lY?=
 =?utf-8?B?WVNLaXVWY2FteTl6eFRGWGtDZVh5Uy9qK0dOOTVYRjBreDB4V0VSWmR4djNC?=
 =?utf-8?B?OWhpSEQ4UkZRQjM1RzRPV0dHWVByRFRkTDZWMTZtT1dhdmRRUnlHVXBWZGFz?=
 =?utf-8?B?UnJweUFKcjhWYjJTN2JsWHZoSVdZam1ZRVJ5VHNDUWwwNXUxYnNuYnN0SitU?=
 =?utf-8?B?OVQxSjgzQ1dGblBRNDBSaW9Nb3ZRUjR6SUxtVGJJbnNpbWlVdUF1QjYySlcr?=
 =?utf-8?B?NXJyeDE2a1FmNkhTVlp0VVpJVXNPSmpuTGV0UXpkNElTSG5ycVhRKzVtR0RZ?=
 =?utf-8?B?WHErNVVHSER6RWNjVmtKcFFqZ01wWHNOVDdId1lRTXFmSnBrdHVremk0QS9z?=
 =?utf-8?B?TW5sa0Jwb1pKdkZqempCSzVQT0liei9KTUhiM0J4MmZidSs0QVJwcGVjWTFZ?=
 =?utf-8?B?cTRSWmMyNGNCaUJZQTlqcmhyOVBmOE5zQXZOcVVTV2lIN0FtcGhKYnJvS1N6?=
 =?utf-8?B?OW9mVjdrL1hWSVdaWWN0VW9nZFhwMkFobHdZOVZ0WlhSZEVxQlQ2OE4vNlQ3?=
 =?utf-8?B?SVBXZ1FWaHFFck9yZExBZGp1V0pJWitRTEpXK2dhTnNqWnE0WGdtdWtpZE50?=
 =?utf-8?B?N0hBZUFQWEdnbS93aU0xTDE1K3BWdDdZck5meDVHem5oU3AzamVlcnJyNG5o?=
 =?utf-8?B?WWNRN1dnRWxUTVF2a0dad1pWbzBndW40OWV5M3VIaUs0WEFWam9ndTFFUlFV?=
 =?utf-8?B?OVZKUkE2eDllOGEyaDZBUmtDeUphTzdRaHlqRWFpU0xzRDNxMUcyVUpLb1Fy?=
 =?utf-8?B?c09kR1FlSEdtV0F0c3Zhc0NLNitQaGVnbTBVSVZnMU1IbUpLZ05NMHlYdi9s?=
 =?utf-8?B?eTRtUXNMaG1ublQ0U1J0UUpZamdzQitrT0FIcExEMFhvR3ZERlh4OTBTZGps?=
 =?utf-8?B?RmJ3cDZWQzMvYWl6VzZKZzdnVFV6U0VyVUwzUUlqWDNCbVhEK0VhZjBnQTA5?=
 =?utf-8?Q?QpfIxK8L0A9xoMhhrtWrARGVX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60e33db-90a7-4606-56b6-08dcd856f9ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:45.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HW8OPJ5VfqY7FfUV8/ZxOUoZT3F5jLUiklCVCM+Km4UV0LyeBk9FMiyHZTCz6ZrVPE6iJ7qYCXQ3B30N9c/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

i.MX8M and i.MX9 have duplicated fixup_thermal_trips, so move it
to arch/arm/mach-imx/fdt.c to avoid duplicated code.

The critial temperature point for i.MX9 set to "maxc - 5" back to give
some margin.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  1 +
 arch/arm/mach-imx/fdt.c                   | 42 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/soc.c             | 42 -------------------------------
 arch/arm/mach-imx/imx9/soc.c              | 42 -------------------------------
 4 files changed, 43 insertions(+), 84 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index c146a223b71..31ace977d2b 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -280,4 +280,5 @@ enum boot_device get_boot_device(void);
 
 int disable_cpu_nodes(void *blob, const char * const *nodes_path,
 		      u32 num_disabled_cores, u32 max_cores);
+int fixup_thermal_trips(void *blob, const char *name);
 #endif
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index df6fbf51dba..ac782e3ee63 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -85,3 +85,45 @@ int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabl
 
 	return 0;
 }
+
+int fixup_thermal_trips(void *blob, const char *name)
+{
+	int minc, maxc;
+	int node, trip;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, name);
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, "trips");
+	if (node < 0)
+		return node;
+
+	get_cpu_temp_grade(&minc, &maxc);
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type;
+		int temp, ret;
+
+		type = fdt_getprop(blob, trip, "type", NULL);
+		if (!type)
+			continue;
+
+		temp = 0;
+		if (!strcmp(type, "critical"))
+			temp = 1000 * (maxc - 5);
+		else if (!strcmp(type, "passive"))
+			temp = 1000 * (maxc - 10);
+		if (temp) {
+			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index b8a026fb840..46974bf0618 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1215,48 +1215,6 @@ static int cleanup_nodes_for_efi(void *blob)
 	return 0;
 }
 
-static int fixup_thermal_trips(void *blob, const char *name)
-{
-	int minc, maxc;
-	int node, trip;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, name);
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, "trips");
-	if (node < 0)
-		return node;
-
-	get_cpu_temp_grade(&minc, &maxc);
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type;
-		int temp, ret;
-
-		type = fdt_getprop(blob, trip, "type", NULL);
-		if (!type)
-			continue;
-
-		temp = 0;
-		if (!strcmp(type, "critical"))
-			temp = 1000 * maxc;
-		else if (!strcmp(type, "passive"))
-			temp = 1000 * (maxc - 10);
-		if (temp) {
-			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 #define OPTEE_SHM_SIZE 0x00400000
 static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 {
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 63647092782..04b21207a28 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -538,48 +538,6 @@ int print_cpuinfo(void)
 	return 0;
 }
 
-static int fixup_thermal_trips(void *blob, const char *name)
-{
-	int minc, maxc;
-	int node, trip;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, name);
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, "trips");
-	if (node < 0)
-		return node;
-
-	get_cpu_temp_grade(&minc, &maxc);
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type;
-		int temp, ret;
-
-		type = fdt_getprop(blob, trip, "type", NULL);
-		if (!type)
-			continue;
-
-		temp = 0;
-		if (!strcmp(type, "critical"))
-			temp = 1000 * maxc;
-		else if (!strcmp(type, "passive"))
-			temp = 1000 * (maxc - 10);
-		if (temp) {
-			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 void build_info(void)
 {
 	u32 fw_version, sha1, res, status;

-- 
2.35.3

