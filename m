Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1D8CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B1C839E2;
	Tue, 28 Oct 2025 09:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uQkN0NvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3068397B; Tue, 28 Oct 2025 03:47:51 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB3E838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMmhG0AmheXnBvwOjWyg3Sy94ymafu0qs8Q8qwT0u+jpuDZzexkGzxjyJ2P1VjcJ1BJ8VLo+osAe+BJLJ7i0aP7M94/szMZPqMwl79tBjqqBnlsEqg5j5w1OkJWouasiVOdJ7st1CxQidHH7EiWVdrI+549xomxEfIYIL0SXXUgVYrMlySPit5djmvQydIFAOIAdBZw0lpWTERGl6A1Ar9JZQfSgmfljRkK82MtVvvu1Tq+rpfVCfOfGZxxOkOjxCrJl5BRimAzVVEQ5LKsGvPdC8dzB8u017Y0KTKCMW60N35Ww6kBj7UZ8ZrVqho7g6VDRofVKHuSJeaNOQhu40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=tMRbEpmX4uarAvOcwxwUYPHBCw/ATTZTu0LfApeylbhbKbF3FXfQgwemZ7dD4oT3192JlbrdvfTl5rWQtqyw1gg3Cb18TXjVPOFPVwNSPZvtptWyZSvid6868pLramRkb89ANetCzfBdCLq/X5lw5RvUMeWJTqes9sgstd9xgZepdzM8WFs4c4f5E/RMvJ7GTdPYfo9Qcxk7hkTtDG06ZZzln568vsgKUfEn0pon7sMuhPGs/jhosqx8Niml4qcsC9Rm0t9NYeVZNVwGt9yvalZsuOn32r1DlSiuD9aOdBcp0rTgVmnuCfLk2EDdbMqWRhqqmJzGCwZn+o8nfY82YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=uQkN0NvUf7KNdne5/Cy6e8MpM/lGLsl+/IB7jcN5a4XyiSqmidhLy5IcV71/dfrOtMmCOHR+wBdEORqW33mvxGTwpuA6MeMytOpevPDvPs6buZbFKa2ma1WiAz+kyaY+CPmTCN/3eJBM3puVawAkFlrzYouxlymbccxl/+mFPU5t/e5l7QLPnZRvt+4lCwDNkQ/29qSjdswraPbP/tPnv9BAMS5R+dbGs2BwEFweR0YZXe6FC6t3nsyPNchX35/6GRwUA11SDAF9dmJGQJAGBuBv8+dWWeMRcrEnxScIL6JYt85z7NKjEAhonTny8vx8pDIHFxhrWkfNU0WcjFZXBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:47:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:47:47 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:24 +0800
Subject: [PATCH v4 03/10] imx943_evk: Enable USB 2.0 controller host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-3-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2a1a33-dd32-488f-ddcb-08de15cc608a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1hzUGZTTlRJV29FUGU4a2Eza2R4QVdKZkVodkE5NlZZUHYwZ2k2U0dvN0NF?=
 =?utf-8?B?b254T0h0SlVLelhJMFk0eXM2NFV3RkFwQmxUV0FEanlJemZxT3R1R20ySWNS?=
 =?utf-8?B?bWNKV1BpcWFSc0EwQlNzWCtxVTFJUldSZ2ZDbmE0ZDRWdFdSblVRc2w2RGdx?=
 =?utf-8?B?V3JuRmFDNmtRRkN3LzhJa0ZNMUdKRndkVWxrL1EyZG0raXljOC9ZdDF3NXl1?=
 =?utf-8?B?aGhTR3ZhbHFZSysrWXVpRzZROEgySTdkK3lDblU5aDlUTjZBbE1qdmNLTHNI?=
 =?utf-8?B?YzhaOFdBb2ZhbkdSbCszODNrWXZHd2tCU2RtaHZKeVFWZGNLbmhPNm1PNXVF?=
 =?utf-8?B?cDlISUVaNDBsUTBmd0FRNElVd1QyQzFFWTZEZWZqMVZUS1NvQjdRQWNMQjZu?=
 =?utf-8?B?QkFkN0owemlvK09ZbzkyMGp1MVJlQVgrSWthcEQ2UkNZNUhWczdtNlpsWjMr?=
 =?utf-8?B?NXpKSCtOZ2E3cURHSU1SQ3p4M3JFazZzUlZvbGx6aGhEZEpEMVVuT2FOd2lR?=
 =?utf-8?B?cm5pSTVDVG1OK0JYeGhUaFJPWjVPYXJsYldSZkZEd3EyZHlxM3Z3czJ2RU9W?=
 =?utf-8?B?bDZkN0xNMitkUkZ6MjN2NmZ6RS8zSy9FcjVLN2NmSjZ6RytjQWxRa3BwMnRS?=
 =?utf-8?B?ZkhreFJVaWcvVWVWb1AzM3NnWTRWUnljc2ZwVS80QTc0SHdIR2UzR002SHNn?=
 =?utf-8?B?bFFxZU4yOGUwckdNYnFBTlR6cWNjY2NSZDlRSkNXVDF2LzE4ZVhZNGNwVUdh?=
 =?utf-8?B?QzdFNXRkQnlRMHJGa1pndk91TUJwUGVWQ0VVa21UQU5tMXRsclh2aUc1cngy?=
 =?utf-8?B?Z3Z3c1J0cXR4blp2T1FEZFkzSFdXV1gxVzljcUtaWkY0VUZHZWEwdkZEVzhZ?=
 =?utf-8?B?YUEyRWYyZlc2SVNrU1VzYm1yZ0p2TXY5ajl3MTJIWURhbWM4ZWJXYTkzUEJJ?=
 =?utf-8?B?d3FHUEZQRS8xZnpyYTR4dFkxMW9NU093ZVg4YzhjNFR4WGY4RFp1dU9UYUxi?=
 =?utf-8?B?OUZsUnZvV3JFSW5COGgxMEEzanlSbUFUL05oanVORkdDVTVHbnZaWmg5b05i?=
 =?utf-8?B?YXJ1bHg3a3d2ZU1GRnNQNEpqd1hvcU1uZ21VUlFNVFYzZVUwdnFDcEpWZklN?=
 =?utf-8?B?SjJTWmROTFRPSjRRdm9JZXlxaDhvVGdrZUhsbFgxVHBKaVBPWlNsOXNYNE9Z?=
 =?utf-8?B?ZjZuN2dERDFRVjJndm5yR21EbGcycWJKOWFQVUZUcmZIRDNJcHdaa3pKK0VR?=
 =?utf-8?B?My90OW9KcDB6RDhmRHVHSkFqTVVSY0tucHRhdnkxckRNTWdTT0JqMzdxQ1ht?=
 =?utf-8?B?dmhpZ005UXRnVFF2ZkdXcWVYQzVXekxmMFFydjVlbExFK2J5MTZ1ZjcrYlVO?=
 =?utf-8?B?c0hJaFB4Z1ZLZ2JrUWdYa1p4c1JyTFgwVGFkcHRFQ0VwOVJDZUZBUytPSTk0?=
 =?utf-8?B?SHJrc0VZL0NLS1YwRDRXdy9semRrbWZUekpBQWJ4ZDJCUXZwMWtkL1J3cHc4?=
 =?utf-8?B?dmFwUHBNdUtjMVhocTkyT05EbnBzNDBqRDQ2R2ZjSi93czhGNXN6UEt6Y0xu?=
 =?utf-8?B?Ly95TnAvcTczZUVIejR1UEM3SHpZY2M4VGtyOFUrcnpGUSt6N3V3ZkpIQlNF?=
 =?utf-8?B?eHg2anFKdTB1WkszL3ZCbmV4QWRjNmVwWnVrUzd1SWFYUWgrM0hQcStvRFB1?=
 =?utf-8?B?M0FvamYvUzBzM1pxS0FLb2FhR1VJUlB6VWRDQ29RTHltT2ZUUi9UNytGVzhQ?=
 =?utf-8?B?bzBxZGFvUXE5QjVITlhGcVFqUGRuclhHUVRPZjQ5R2dsOTRySk9qZENmUXB0?=
 =?utf-8?B?SjdYSUV4ZGxQSEQzODNsV0NKRE9jcWc4a0ZDY21xWXY1a3EyTzZFTmh3bHJn?=
 =?utf-8?B?eU1rQlFySVlMeWQzU0NvSzNwTG5GYi80ZzZ4VWVBK1BuNFZKQWZCRGI5N3lG?=
 =?utf-8?B?amJZWndkTlpvR2MxYVJ0UUVLWTFLWCtsQWVHUmhtRjkvVXY0YnRUU29GeWFk?=
 =?utf-8?B?OCt3dkNsOHlWWVlDNzlpdkRzRDNSL09LN1pEeFhkbDJzMGZLdklkWVNZbjN3?=
 =?utf-8?Q?bPUA09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllyaFdsVFQ5aFhLNWlrQXlFckl6YitxQ2poUmNDRG5XQkM4WUhKdFYySC9L?=
 =?utf-8?B?ZWtGT0hDMkRLc0k2dUhmR2h0blljdThUdmhoR2RndWcwdjFhd0NNYTA5VWtW?=
 =?utf-8?B?NTd6ZzdndVVBRmVvcmhZWHNLTEZEc0dRa1lzaGpVQ0JDOGdJWTlsRnJxTEwy?=
 =?utf-8?B?NFRjcFZHRzVqMXBsNDl0T081ZU83TzM1V3gyVnIxVFFTVlNWL2RNMDUrNFE1?=
 =?utf-8?B?QlNzMHlpR3F5ZHRqOE1VaGRreTYvWENDMTdHT2tDeklqTFFiMHdTWWZhT2xh?=
 =?utf-8?B?WGN3Nzlhb0NFZU9haTA0UURFeHAyZzVUNnZiQzNmVTRuVWVOMDR6K0RVc0w5?=
 =?utf-8?B?VFJoY1ZmUWJZM0YrTXVqbks5S2tWK1RHOWZSMzRzeEkyajQ2Z0NjTTU1ZWNj?=
 =?utf-8?B?UDBSSEdQVUZmbDZwTStFc09oT3htRVV3ay9VTUtSWjdIOStwZDRRWFBabkJM?=
 =?utf-8?B?UmQyVk1mcmtVdnRGaGJ3Y0dzKzZwVDZzMGw5MHRORlpMRjZzN3hwalFIWkJs?=
 =?utf-8?B?QTZnd0owVTZGSmpqM3p0ZXdUVXpJUUFmaTR0eUlXalNuVTVYM2ZGZ2EwZDNl?=
 =?utf-8?B?cXh4amxqdnlPNWNmVTB0RTJtcE5SNjlvSDYvYTlYVjltWFZTRXNWTGVXdlNS?=
 =?utf-8?B?SEZLaGwvUEZrRHdDR3lLZGZKd1V6TmxhTXZzYkpFdGowdjZIWGpZWVlnMno4?=
 =?utf-8?B?VFJYVTZ3VGJJTVJKT3JBejdkUzUyaVR5OG1xNnF6QTdOWlRQUnRwM3VFQS9I?=
 =?utf-8?B?VUVZWDBac3JDNlhxcjRMS01FOFYxakpYZTJtTC9EVHprT0czWTE3UjVaM0hu?=
 =?utf-8?B?c280bUlWSnQ2bU03eUxabFdBWWkrbHB4amc0UGI5a0Q1c1VIU01mMWF3YXd5?=
 =?utf-8?B?eVJpUXMrb3pKU1ZHaGhYbW56WXUzalRvbGU2eGpDN3NTMXZOcEhUdHJ3Vlph?=
 =?utf-8?B?ejJyTTZNNFR2MUJqSlpPVHBmTGNoek5McGdHYkVJWXNPTG9XdEEwN0pNa2ds?=
 =?utf-8?B?cEFOTUtJekhvU04rWE1GWWxUSjV5WlY3VWQ0Qm92eFVKODkvNDZiam92K0Ix?=
 =?utf-8?B?b25wV2ttVDlaeDUyakwrVGhHMUJCU3JXdmpNTmFOUHI4OHFjS0dqdExVUnhj?=
 =?utf-8?B?YmcyTHVGWlJCSkVRK1BaR05lQTdZSUE2WkFDOCtnTlI0N0w4bnBaNFo3SW9R?=
 =?utf-8?B?bWV6NitXcVpOeWMzTXdaSmcxbUtyazVBdDU4cmEzdHVRaVpyRXIwYUYyd0Zl?=
 =?utf-8?B?Z0g3bEkxR0pZSjlxRmRhejZSL3lVNUVlY0R5RHpkRVB1Q1ArNmVLNnlieFov?=
 =?utf-8?B?L3ZTQ2NuYWRPTFptNDlYQjNEYXNKS3pxdUJ2RUM2THdUYk02SytUYlF6Z29u?=
 =?utf-8?B?bTFpSG9xTVhqOXd5NDVYZ3phQ1JwK2hnQXE5VHd1b0d3MHFMOXRLM2dVRzhy?=
 =?utf-8?B?VllvVHgveDVTMGVKK3FYTW53dkRSazZiWmcyR05FSVZWSU1VQ2JtNmhlaFJh?=
 =?utf-8?B?TUJPa2ZSWEtUbkxWSE42Q3BYSTZINDdDWFlnY3FsTy9JU1l4T0cxeWU0Ylpu?=
 =?utf-8?B?TFR3QkUzeHJPSWJTZ3BGaEY2SHhaVHJsWnJRd3BreHVVaFJubDVtR1ZNMmVE?=
 =?utf-8?B?ZlBrMnFaSVhSdWoxd29uRlB4VUREVjViRk9WbTI4R2ZPdTNBaDV5OFlBMlVs?=
 =?utf-8?B?UnZIWWh3SEdIem40WFZuSUpmVU84azE4a3NndlBWMDBRUXNLMVlvK0Z2aGE0?=
 =?utf-8?B?QVd4aVNCK2hKL0ZWZnBVUXY0dzFLOS84R2k0citUREFnUXVvWXp3ajFZZVBB?=
 =?utf-8?B?dWQxWlU3dXA2RzEwZmhMaFJoS2JDdnEzQmhSck16MlArMnowYURRMUlxV040?=
 =?utf-8?B?ZzRwRmNoVmdtQUZ6S2NMSEg0R3NGWWdxT1I3cDRJMmFkUnZXVVZRb1FPS2Qy?=
 =?utf-8?B?WTVDSHJvYmErUFdaZDh5eHZQeXl6YW01TXFRMi9sNGd6S0tOSUZCZ3krREw3?=
 =?utf-8?B?Z0x6cXdQNE5Kb0RJUTI0OUl4S3lmQW5kZlIwZHBQSUhBNUlKekttZHhJdFR6?=
 =?utf-8?B?NjhlYmdFcUlML015T1phb3lwOWdkb0YvbTFMcTFVMFJ1ZTVKNHRQOEVoRnZh?=
 =?utf-8?Q?XKiQCSBZc4dlqJsGVCXvtrpqd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2a1a33-dd32-488f-ddcb-08de15cc608a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:47:47.2717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roVc1vY//r79ZHRoPi1vJGguFepNAM4NUdmy9AYB7CyrmtSJTBuwAkfVF/m2NiHeNg5Vi/NgmEbgNNXLHATEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

From: Alice Guo <alice.guo@nxp.com>

This patch enables the USB 2.0 controller to operate in host mode on the
i.MX943 EVK board. It updates the device tree files to configure the USB
2.0 controller appropriately and modifies the defconfig to include
necessary support.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 28 ++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 5496385dc4d..e6abe7ed2e0 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -13,6 +13,15 @@
 	bootph-pre-ram;
 };
 
+&usb2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9c4882f7d79..9b2c1072366 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -83,6 +83,13 @@
 			};
 		};
 	};
+
+	usbphynop: usbphynop {
+		compatible = "usb-nop-xceiv";
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+	};
 };
 
 &cpu0 {
@@ -192,6 +199,27 @@
 &{/soc} {
 	bootph-all;
 
+	usb2: usb@4c200000 {
+		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x0 0x4c200000 0x0 0x200>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "usb_ctrl_root", "usb_wakeup";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		phys = <&usbphynop>;
+		fsl,usbmisc = <&usbmisc 0>;
+		status = "disabled";
+	};
+
+	usbmisc: usbmisc@4c200200 {
+		compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x0 0x4c200200 0x0 0x200>,
+		      <0x0 0x4c010014 0x0 0x04>;
+		#index-cells = <1>;
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 27230ed3207..d308d29a1a5 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -112,4 +113,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

