Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CDCC369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D5F84008;
	Fri, 11 Apr 2025 14:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CyC+uAR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7326D8401A; Fri, 11 Apr 2025 14:59:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9EC984006
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0I82sMCVqQwtEJ4k65WN4/g3pI42m4DFp/g3CBme3NFOMfhFKXNc7JG/CG/NBWfXJJr6tYJ/2bfDlQc4HHEij1ciS3LKS0EJhq+WDxFTdHHFSW6ZM6dnb0h/xkFvV1q1JaSJvqx9xLTAnGpqwbXtD3NzmBeNaiCBme2julK6Re7QzfFDjdmZSSicLd/xWLU9c6MtZ3vH2xeBsCZJx7fQXx1pHDfwkzgq+ElgRSOKtPMZKuoKk07kck2z7GP11M0NbtiMF1GfXPGjHWOAuy+XIwYcyxp1DTOFPuymiw4B4KdGxo2S+C6pQ4pZAVpkubiAsEh6h5WLLz96Y5LfT4tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTGcVMbyuNZ3yC+4xUNhBsmmfRuuGWgO9iFsspzVGdE=;
 b=Pp1zPZ9/YazJY62iIbzjdSmbERnlU+C0FS3JfIdyBp3/FSu5q+njpFLzZrcA1kuxnnhAcNN2kHVg6WNPnvjq27RcRvI4pdeafLMm/ngBOqS2phJkC2BbjskL7qvcigOI/z7LD0fa66JbUDhwAVqmlIW1LbClCVyDtkJ8n5o2T1pGaV6F1mDWd4/A/0I5aUO0N7F4tbaFzbKGNDDO4ruAnTWasj3IIamHqm9s+ZSOg/bV5MjNbfAUn5R1hKuqdruxwVLWWFj4hs0yiw66MMhjcV+NzfULo4sR/rH5DQIyq2XPf+uhrw8GWvwZIvVwzYi30qL3OUK97Nbyqm3di24t6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTGcVMbyuNZ3yC+4xUNhBsmmfRuuGWgO9iFsspzVGdE=;
 b=CyC+uAR8LiEHeBG6kqLTV2/fC+86R5w83P3b3MPLd1922mZcf0zLwebFk9ll9sR+0dnGXhIisCGupJk6K/cxfvYLfprUB5p2l013dKPWMU0s6jqPHRtKlw2+rL3NF0qYNpf8M/zqckz7DzZpOwhBweVKwa7yRhvVaTx4vzv7bv9qNAMICFXXTAEU0U1SyP2t9UKLh29wpdlJrPUOOeW1Wj4jVQ43+egc4/336bqX1lwo3Wlfc71W+KD+1mCWEPOMrOt4D0xiwtovL7JwSL8YrXbQzg7nsvinZR7VvNG0JSgD+ZNCifZZO+MPjJAOZ7Vf5dU6Tf9NV6Q1hjqdJnE9Hw==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AS8PR04MB8481.eurprd04.prod.outlook.com (2603:10a6:20b:349::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 12:59:02 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 12:59:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: "marex@denx.de" <marex@denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkVTRU5EXSBmaXJtd2FyZTogc2NtaTogc3VwcG9y?=
 =?utf-8?B?dCB0byBtYW5hZ2UgU0NNSSBwcm90b2NvbCBkcml2ZXJzIHdpdGggYSBsaW5r?=
 =?utf-8?Q?er-genetated_array?=
Thread-Topic: [PATCH RESEND] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
Thread-Index: AQHbqSSptIJ+uzxN5k2QQjAfqkTII7OebQSAgAACP6A=
Date: Fri, 11 Apr 2025 12:59:01 +0000
Message-ID: <DU0PR04MB963656129C2D75D1AD90FFA8E2B62@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20250409075352.535194-1-alice.guo@oss.nxp.com>
 <CAOMZO5BodWZDVcrZnzy+Qjb9nYks64v6_CFPvxotv1=dWR5MGQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BodWZDVcrZnzy+Qjb9nYks64v6_CFPvxotv1=dWR5MGQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|AS8PR04MB8481:EE_
x-ms-office365-filtering-correlation-id: 58e3e0d9-3d83-4b2f-0cb1-08dd78f8a1e8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b0F0MzI0Ly9IQ3pvNjhiQmZkVXc4NWhlWkd2MlprcGkwcEM0anNZWFVwR05p?=
 =?utf-8?B?QXdEU0NNTE0rNm9SNXVwaDNNbm9GaE1JYjVHcHRvckFrenlQbEJ0NmVOVFla?=
 =?utf-8?B?Ti9ieFo4czI4bzhndkNxQ09MalNaQ3hCMnNyR3E0NjhRYXRTUk1RaDRHQ1Fq?=
 =?utf-8?B?bFR6elcwNDQwMHAyeEFKTm1zRTYzQzlLZkF5cTJtOXZadExlM0NKNHlxNHAr?=
 =?utf-8?B?T09tYmQ1M0VhMGJRVXZoV1hEc2Zxa2Uzc1E5ZTdnYWxlNXhVTHdlYjg4aXdV?=
 =?utf-8?B?ZFZjWHlsQ3VHa3RwK3lPZjFZcllpaFRidXBobXh1SnRPRDNHbVVjQ2k2Mm9z?=
 =?utf-8?B?NzVPYUo4M211K29HUDRTaXhBNDFPTGtNd0crLzVzakorSGM4dUF6dE8yYmFV?=
 =?utf-8?B?bFNRRW16N0lFRVVIcnhNWTBXSU13aWZCczJITWF3VFZ6bHRLWDZMSmo2QzRs?=
 =?utf-8?B?bitvdVBuQmdMRk1FN1VjSEw0STB1RHVkcWZGUTdXTXphQzZVSmV3MmNBRDJY?=
 =?utf-8?B?SEw2cGRnYXVkQ0RkWFZVRStLbUduQ3NFUEV0QmcyV3NuSHQ5RnFFSzJBYXFX?=
 =?utf-8?B?SkswQ1RHdHBhUnpjYnpXSitvZWcvMkhrc1FsTThnMjNWUjBoZnFaVmUrd2Vv?=
 =?utf-8?B?aWpnY0Z6SUlYSXl2a0U3aGdaOHpyM2tBZzNFVUdhZ2kzeWcxRENPek1EWndN?=
 =?utf-8?B?ZlJUWWNlSUpST2lBdFM2MXd3UHZOVk5JcmNNYU1jeTRjV21OTUljYVRaNjIr?=
 =?utf-8?B?MXJ3dExIamVzYjdaQ1BIaVVmMmdoMGZGR0ZJVzNHSEZQbnVBdWd2MTdvRzNV?=
 =?utf-8?B?TXhrT1F6aFZ4aUw4aDhTLzEvSDRNWTArNjlKb1FFUk9jcXExSkUyTjY2d2hP?=
 =?utf-8?B?RTFVV21TY0ZmemFlZVNtQUxjV1ZRSlNiYXpGVDhpSVFkdzhrQUViOEFmQVVi?=
 =?utf-8?B?WEtBMlg3ZHRIbHErVWVudTJjN2szVmNOUzZUaTZpS2ZjN0NaMWJGWW9HbXVO?=
 =?utf-8?B?VWlBUU81TmJ4UVZnM0I4aTNnWXIrUi94cmY5TnYwVGVldThtY1VCaVZRZGdp?=
 =?utf-8?B?TVhwbGVwL2EvYkhxaG5ud1VTclpwRHVIdzJZeWpZMjkxVXpiSk9SRi82ZzRE?=
 =?utf-8?B?NTJqQVpEMjBPMkpTOFZscHo4cWVwV0ttcUZkZE52N1orV1NYS0tPUDE3QTdR?=
 =?utf-8?B?VEFSQTNDSmtCR3RqTXNPNnVjQnhadGtyVVZvd05qMDlSa2lySlJvUFlxWVpk?=
 =?utf-8?B?NzlVSmZSS2s0QmRSTDJhc3U1SjQ0L1c3d1U1K1p3QytLQzVNRmdRNFFydmV3?=
 =?utf-8?B?UzFXNnFPS2JrTDZWSFJndFJJUUVtQ3p2WUNGUzF4eFVzdnk1ek5jKy9JM0lD?=
 =?utf-8?B?Y201UWpkRWlMQnhqaDB3Rzh2Q1BWWVNWSE9TTTJuZG5nRUp0cndXaThuWTFJ?=
 =?utf-8?B?NSs3TEkyVGFMTWdOLzF2MGg4NGtYVzgzOGFQSlIxOGNZaFdhYXpJQlZxU1pu?=
 =?utf-8?B?ZzdkRTBMR3loTzI1dmFIOXRSS01VV3l4Vm0yMVlJd0FzTUtuL2t6QmFQNjVG?=
 =?utf-8?B?RFRBNkpsaVBtMXkrYVZCMVJTV1NaK3pUbFF5b2VBdHRlWmtnV2w2WFMyM1lp?=
 =?utf-8?B?a3A1MnppMHFWV1k5RFNvZENYOUE2RVBjbDF6bElLZmdtYzZVR2o0d0JCcHJo?=
 =?utf-8?B?c3Z2RmZQQVg1cW9mbms2U1c2QkhUQ0JzRFNBVDFYOFRrVUFVM3h2SGxOQlMw?=
 =?utf-8?B?TjN1OXoxYjJUZHJxNnovbjVBOXVVUXdYRUZGbWxXWXdvcnNlT3llcktWbXBX?=
 =?utf-8?B?KzNhT3FkSER4RjdIYlB6cWw0UWhKUWZVUlgzbFU3S2VtTUJOODBtR1pLWWM5?=
 =?utf-8?B?cmFlK0FZQ0FJZ3kzaklFUzkrUFpSN3JBc1FlN2s3aTQzMzJSSFNjVTFDeXNS?=
 =?utf-8?B?ZytvZkhNWkV3amp4dmdJa2JsV0w2OVdlOTFLMUR0bUV0NkZOQXpqOUkvOUkz?=
 =?utf-8?Q?twZAeUcx1eSpZZdPpQlVUtASfugwMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3FkVkhKODdvZkJ4VVBOK2V0cTdPVVVSaVk5Qm54bEkvWGRhYXVEL2xXbEFJ?=
 =?utf-8?B?UGNhbUxjcmlkRW9Way9LT3hWVzBHczBZSXlsbE1FalZSYzM1NDFyMGk4RE9p?=
 =?utf-8?B?VHNaS0YxU0loR25UOHoyU1ZKcG4wZWtBTTN0M0l2b3VrWVBhRmZzV0xqVWhI?=
 =?utf-8?B?L3llclRQT3U0dE1kZ05jeVNjd28rbmJRU0t6VnJGQXdNL3daL1NiNkhRcVk5?=
 =?utf-8?B?QzhuWkt3NjNMQ2NnRHVIMVNpMEpsQUQ0RHlXcUNMR1JYY1Y3T1dkN1ZCbjZw?=
 =?utf-8?B?RnRITy9UNWlRSkNRRkpvcDdBWXZpTWsxZitIMGhyUzA2elN5ZkNIc3NiTTNM?=
 =?utf-8?B?aGVyQmxVYjBqYVlYUHA0UTBwK080ckdCTEpUNEhLMkM2VGZPaW1GSkhZY0ls?=
 =?utf-8?B?S3dQbmhmNXdtUSt1MHg2dTgyY2NSclhLcTJYZ0k0bzNZY3Jqc001SEFyOEE5?=
 =?utf-8?B?ZzBlemFqYmpnYXhoSXRHZnFQRmpHc0lXTkhLcmJ1Ym01NkRnVStvQlpZclNt?=
 =?utf-8?B?OHpwYmw5WUE0RjhuSzZ6MEpkWHVORTR5UXVwUTh2SUZXZmdmSEZ3TDhac2pv?=
 =?utf-8?B?MFg5MnJoWkM2Rjh3VkkzT284alIvd3VVWk84RnFVbVBidzdvVE9IbEIxVzNm?=
 =?utf-8?B?ei92eWpxSFRMYm9wNlpYeEpqb2pXODh0Rms5THN6dGpYUmdTZzVOTEpBcmpo?=
 =?utf-8?B?alo1dUU3enVHZlNZRG5pSndTTndXbkM0d1FienRETXA5bTkybmlKSGhIOWdn?=
 =?utf-8?B?K3RXRTNXL2QzYjc3eHhZQVZPbGJCRm92UTNhM1RJOEF5RFFEallvT2RJNHJV?=
 =?utf-8?B?cUorMTNiQUVPQ3JFSmhSbEhwMjZKd0YrcHhWYS96bzFJQ0tycmVhUHYveTFR?=
 =?utf-8?B?YkJHNitDWFREVGh1SDI1NVJmZ3puWSt4MU83TEJ0R1IxY3pwRUNoOXFiUU1o?=
 =?utf-8?B?UThUanBYMEZNdlNWQ2pyeWFCZ0JxUXk5NGhRcU1kOW5XeUpibDJCNUdVd2w0?=
 =?utf-8?B?bk16YmJJTnJXaU5hN004eEpXbk9wV0cydDc5SW91RURwQ1UxVDZ3MU5aT1hy?=
 =?utf-8?B?RUNvNGhBdWtjMGlnWWVWUU1zYnJZUjBUUVd3Qm1HZzVNT0RFa0h5RjhFOFJI?=
 =?utf-8?B?aWhYdXM0dlVDYmlmd3Z2RWIrRjY0aVBTajNpWXE4WWRhbStFS0Q0QW5NRzhJ?=
 =?utf-8?B?L2l0QkVsQWNMZis5bDJ5OFd3eE9MeXZLRGVkS3BZeHl1d2ZodHpUMTh5cFhr?=
 =?utf-8?B?UW1xVDhuOG9GMEV1eTI5TDhSWGI2aXA3SGRickVBTm00QzlWL1RqbGVXREJO?=
 =?utf-8?B?bE9BSi9NR1N1MkJ3SnJRQ0dRdDlRQXpmUjg2N0lybWxuMmdDYndBQm9OUkJX?=
 =?utf-8?B?YUJEdHd2S3pFQjRaajRqdzFJcjN0YVJOSVpqbWZkZnVpb3Nmbmp6V0svd09a?=
 =?utf-8?B?RVBqZkhZNVRiOUt3TVhwVGI3Unl4OVBaOGxaYXZ4VVdlbVo2QVJadzNJcitO?=
 =?utf-8?B?T0dKMndUYmorV0hCbmFJRlgyU2xMZW5CYmZOdjhwdmNkeXlOUEFFeDV4cHJH?=
 =?utf-8?B?S0h0U1A1dlJzT0RvbE5rZ2s2dE1ZWVpWY0VNbzQ2OVR3Y3RvSlhZZXRzaGQ4?=
 =?utf-8?B?b0E1YmM2eXVwWnBlZ2pGMzdvRDZ0dzVzRzJiZ3BrZERJaXpLSW1sQkp5L0kx?=
 =?utf-8?B?YTcrNHFObjdaNzNUckZuR0JEYXQ4bTd6R3dqcWRpVnVveHJmdG0xOXNvSGpZ?=
 =?utf-8?B?Ry85N0FEeVNCdUMybFY5UFZnNzArNW00VTQ3UWdwd0NjZVFQUGJOdjdnZmpK?=
 =?utf-8?B?djJ6UVdxZHRTbGtlU3ZLNzJ6dE5UMW9sRGhtbVRFc3hQNnpqOUdybHVGZzlM?=
 =?utf-8?B?anJPcSsyREZtcWRyS05GcTdHNmhYNW1HZ0pDcDlGbGprTmE3dnMxNk9TZW0v?=
 =?utf-8?B?Qm9UbzA3TXRBYnN6K2FEK09Yc3VEUnFuKzFPVE1Nc2dTMld1enpFU2tpZmFN?=
 =?utf-8?B?ZjdaTkp0ci82ajJaMWRYZ04xdjREeEVlSDBGUjMyUlFuTFh5VWhmTTFUbmtY?=
 =?utf-8?B?RWVBYjVOekRSK2ZTSWpSTlJadUtuZ0FFTFovRkh6VU9NQVZHN3huR0ZaREhk?=
 =?utf-8?Q?Ui+7ogQz7oZcR61K+zwXFoFNW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e3e0d9-3d83-4b2f-0cb1-08dd78f8a1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 12:59:01.9559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bd8HhsUPtGppjsTOnB90Ow+uW1aQA2SzL2BasN+hOE6jtOgnfYiMJYO1sV2mcl3UIHHxXpdcxz5feGpeX9j/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8481
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ05pyIMTHml6UgMjA6NDYN
Cj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
5oqE6YCBOiBtYXJleEBkZW54LmRlOyB0cmluaUBrb25zdWxrby5jb207IHUtYm9vdEBsaXN0cy5k
ZW54LmRlDQo+IOS4u+mimDogUmU6IFtQQVRDSCBSRVNFTkRdIGZpcm13YXJlOiBzY21pOiBzdXBw
b3J0IHRvIG1hbmFnZSBTQ01JIHByb3RvY29sDQo+IGRyaXZlcnMgd2l0aCBhIGxpbmtlci1nZW5l
dGF0ZWQgYXJyYXkNCj4gDQo+IE9uIFdlZCwgQXByIDksIDIwMjUgYXQgNDo1NOKAr0FNIEFsaWNl
IEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gK3N0
YXRpYyBzdHJ1Y3QgZHJpdmVyICpzY21pX3Byb3RvX2RyaXZlcl9nZXQodW5zaWduZWQgaW50IHBy
b3RvX2lkKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc2NtaV9wcm90b19kcml2ZXIgKnN0YXJ0LCAq
ZW50cnk7DQo+ID4gKyAgICAgICBpbnQgbl9lbnRzOw0KPiA+ICsNCj4gPiArICAgICAgIHN0YXJ0
ID0gbGxfZW50cnlfc3RhcnQoc3RydWN0IHNjbWlfcHJvdG9fZHJpdmVyLCBzY21pX3Byb3RvX2Ry
aXZlcik7DQo+ID4gKyAgICAgICBuX2VudHMgPSBsbF9lbnRyeV9jb3VudChzdHJ1Y3Qgc2NtaV9w
cm90b19kcml2ZXIsDQo+ID4gKyBzY21pX3Byb3RvX2RyaXZlcik7DQo+ID4gKw0KPiA+ICsgICAg
ICAgZm9yIChlbnRyeSA9IHN0YXJ0OyBlbnRyeSAhPSBzdGFydCArIG5fZW50czsgZW50cnkrKykg
ew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZW50cnktPm1hdGNoLT5wcm90b19pZCA9PSBwcm90
b19pZCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZW50cnktPmRyaXZlcjsN
Cj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gTlVMTDsNCj4gDQo+IFBs
ZWFzZSBzZW5kIHRoaXMgd2l0aCBhbiBhY3R1YWwgdXNhZ2UuIE90aGVyd2lzZSwgd2UgZ2V0Og0K
PiANCj4gc2FuZGJveDogKyBzYW5kYm94DQo+IDEwMitkcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2Nt
aV9hZ2VudC11Y2xhc3MuYzozNTU6MjM6IGVycm9yOg0KPiDigJhzY21pX3Byb3RvX2RyaXZlcl9n
ZXTigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiAx
MDMrIDM1NSB8IHN0YXRpYyBzdHJ1Y3QgZHJpdmVyICpzY21pX3Byb3RvX2RyaXZlcl9nZXQodW5z
aWduZWQgaW50DQo+IDEwMysgcHJvdG9faWQpDQo+IDEwNCsgfCBefn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gMTA1K2NjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IDEw
NittYWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjU2Og0KPiBkcml2ZXJzL2Zp
cm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xhc3Mub10gRXJyb3IgMQ0KPiAxMDcrbWFrZVszXTog
KioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjM5ODogZHJpdmVycy9maXJtd2FyZS9zY21pXQ0K
PiAxMDcrRXJyb3IgMg0KPiAxMDgrbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxk
OjM5ODogZHJpdmVycy9maXJtd2FyZV0gRXJyb3IgMg0KPiAxMDkrbWFrZVsxXTogKioqIFtNYWtl
ZmlsZToxOTE5OiBkcml2ZXJzXSBFcnJvciAyDQo+IDExMCttYWtlOiAqKiogW01ha2VmaWxlOjE3
Nzogc3ViLW1ha2VdIEVycm9yIDINCg0KSGkgRmFiaW8sDQoNCkFjdHVhbCB1c2FnZSBpcyBpbiB0
aGlzIHBhdGNoLg0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3Bh
dGNoLzIwMjUwNDExMDgwNzA3LjYwMjM3MS0yLWFsaWNlLmd1b0Bvc3MubnhwLmNvbS8NCg0KQmVz
dCBSZWdhcmRzLA0KQWxpY2UgR3VvDQo=
