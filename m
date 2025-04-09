Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A6C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D856B838F0;
	Wed,  9 Apr 2025 18:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gc3r/+DC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F00838F3; Wed,  9 Apr 2025 18:46:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99BF6838EC
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=horia.geanta@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blr0Jc2kMbLJldXZHU7NLCBD8lrLlCrUFPo2tNSUixXjhltAN/cuvDcbffgSUzButiS5y55YppOLsEoUSXoR9aEPCMfu9NMjXYFzRiQguThZqpsjLmeYptw6ZKYAhem7pepzObTxQ5PEc0S6KUp1XTqbIsNNGIc3mqnbMqgezRdXtt4gMyyVhkXsyxWdQ8XXmkj0/mEuHHF86w4lOoAzxWIWqEzK9L6HXYkWHWj8iVrLV6VJLv4byBNJez6v4JB6bDu0wvJC91gxIL7r9pX3DSPc6v6yaENrKtbtjfdLTioy/AcBZNEj38VEaED16IQKu3fuPHkLzYSVEJmb6ADYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ppzb61LB2vvmUpVDBf4skTYr8kSjG1ZvWuGO0pEC68=;
 b=XHLcprInBaR6U/eKPd0jY3gbAWdSLDsGRD/SNff/KmDrZZNxsS2+F4P7HbqggHoLxhWRh9jX2E7F8PxDn3L3Tcy38aum9a4J0kFXdp6GmL0pEQ6QmgReNdd400oQJdt6VWkecP+135cdsinyiHPrq/zExcotS2y1VPKTNv4WeXtaZwy+ZDL9M+YRs5KEEGEEmZ8H/+RNxVt6q9nA5D7ut46T27QBNdZk2QrQHCTmegS0gdSpSi7dokzOToUVrRMAttv96x2tFeAT9kGpkoRkmn3Znr4XsUfPIq5tCXkGKFwATAFnaKEU40lBVVTfP2oXFqI/2VQG6fB1dHydUqvlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ppzb61LB2vvmUpVDBf4skTYr8kSjG1ZvWuGO0pEC68=;
 b=gc3r/+DCKSolbw0DMdweAc+CjQIvfz/tMimyGT0oICSKtQWK8h50tK8Cona10dofidDc9BBoHa+FguxpABdQ++XbuCzOu5/FDPtMDQnnymDVcPCP7juM+2MZrIsijHGEfU2vjAW+90jFQHP4bzHdW88ifqYdWl4gENiTRphLmms8WWQ/8LjFl8Wu8ChCZH5bg0Ago2YrFOA7P+aTqob9tHn/TLeSPHa/EwSbCiLlT2vYctmj7x6BHEeJun0bhCkTwwyoDK63IMRLjcHGyLCfk6fnUPD4dE5Y9hu0b5x4Y4GzpS5UnoT1ajy2RtwM8B7VT0Uac7fABrMHf9tZvSLCcA==
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 by VI2PR04MB10785.eurprd04.prod.outlook.com (2603:10a6:800:26e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 16:46:34 +0000
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::1009:ebb:d7ae:4628]) by PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::1009:ebb:d7ae:4628%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 16:46:34 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Gaurav Jain <gaurav.jain@nxp.com>, =?utf-8?B?UGF3ZcWCIEtvY2hhbm93c2tp?=
 <pkochanowski@sii.pl>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi
 <V.Sethi@nxp.com>
Subject: Re: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vfoLteovRn9keVz5MD6qtO3LOZjPCAgAAOeACAAUOuAIAAr1iA
Date: Wed, 9 Apr 2025 16:46:34 +0000
Message-ID: <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
 <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9709:EE_|VI2PR04MB10785:EE_
x-ms-office365-filtering-correlation-id: 0c5996d1-709c-46f2-1417-08dd7786169e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnBiTEhwcFZlT21oZkNXcldTQVdXSjVCQlRJRm5EMHdMVjExVVJVRlBqQnhK?=
 =?utf-8?B?QitOeWNOeDRQbVk0Y1lKeVVkVkRyNktzeTB0RWlhdmd2b3ArNkljNFNJYVFI?=
 =?utf-8?B?RU5teEJGR2hXUlVwR3RRaWtRWFRvNkUxeWlEbkxSWGNnUGxJUTYwOUdDTjZG?=
 =?utf-8?B?TGZPT0pxazZHVzVPOXQ4UUdWZVh0ZnVIcmhVdmpPQ09YR2tiaExrT3pLSFd2?=
 =?utf-8?B?U0JWWFI5R0Y2aEwzcEM3RFo1dUZtSmhwa09PRGtKSVhUWmI5VWJKODk5dGdT?=
 =?utf-8?B?QnZRRkJ6cVhxMmZ5WmphQThwenNlVFAxU2drZHV1M3A5WDZCMEVLMHl2R0xh?=
 =?utf-8?B?ZjRoRzBoSEUxNWJQTWtnTlU0UERMd21hNDcwelJPNnFxRWlTVkViNmxpYnNC?=
 =?utf-8?B?d25jNlVFSHc0YmdIN1B2bkQ0REQ5blJ4bEM5SURRTitkcUN6aUZramk4Rkt3?=
 =?utf-8?B?L2VUZmg0MjRFRW9SZ0IwQjIvbWVDYVZKUUUwQXlSUndwYUh6WkJWZ2Fza2xG?=
 =?utf-8?B?U3NjSEgzZVpUMDFHN2xUeTJKZ09ydFJiOU4va2tEOVR0Rmg0UUFNd3JpaU1Q?=
 =?utf-8?B?UHFubUdVYXNHOG5jbDFFTmROYkMzYWRualVPbW9PNE01WWxndWZKdVduS0tG?=
 =?utf-8?B?N2VyaWJhSVJaQm1UV1JZUWg5WXN6MTVVKzBKazh3eU9DZHFVRUdxbGJxUmFk?=
 =?utf-8?B?YklEblY4U09mOVVmMlE4WjA0aEJnaFRDZUg5aXR4RERIM1R3cE1ZV1RSQ3Jx?=
 =?utf-8?B?K0M4c244T1dEZXJqNllXZnpoeG9HbVROb1pqNmljWFptckxTZ2lNaUpMbDdi?=
 =?utf-8?B?bEJGLzRFVHptTldzbXUxeC91cC9HN21TTzhqV0N4NkNpZTNoL3ExM0lrZXZY?=
 =?utf-8?B?SThQN09MN20wMHJqSkwyNnRxazk2QnhhZEFHUXJLd3F0dXZmSHBuUnNXOEVP?=
 =?utf-8?B?WDF0SGs0WXY1OEl4TUVuNHZHdkFxNU1aRTNiQURsQzVQWnlxYVJ2RjUzcmJK?=
 =?utf-8?B?Mkd5VklQbFJNZWZvWnFHSEh2bklyMnp2SHhvZXNocnFnclliMENsR3h4aVla?=
 =?utf-8?B?NEdoMGhwZU5YVW5pUzhMdXpkQkI0Z0I1MU1UVEhSVnl6WWNDQUozWnpuaFBQ?=
 =?utf-8?B?MjNmd3lXdmNaUlYvaWhjQXBrcHlRR1JUbS8yZzZkOEZ3aWR0cXErem1JSU94?=
 =?utf-8?B?UDRpeVFwTUM2UklLVTJGK1JIMnRZeTBENHc1OThZMzNYNjZpMGc0NnVuTlhF?=
 =?utf-8?B?MURwR1BTNmowWmhBM3RXYk1xU0pCRkVPSlYwMkVFOVBub1AyQ0g0d1A4Ym9h?=
 =?utf-8?B?T085WklkSEhCS0Ywd0lpTEVYWjU5SXpsUVBZT1VkQlpCc2ZrVkxCN2g2ZC9s?=
 =?utf-8?B?dkFseUM0cWNzVHJVTW9ZUkdTVGM3b3dQUW5DejFMSVpCRzYrem1BZ0hqemJa?=
 =?utf-8?B?di8wakthbGM3SUdEWVgreXZ3RXJlK2tkb2VOL3VVWTZqbzZtY01WUkpzbDR0?=
 =?utf-8?B?QnJoRkdmNGUzT2RJYUlBNCtSUUJQWFArR0RpUXRhUmJvWXRhWnZHSUh3Smor?=
 =?utf-8?B?bTdBMWgyNXljQW5NeVJ4bWQzVGNNK05XaHRRR3BkTkVRTTh1LzZLVHFqVTQ0?=
 =?utf-8?B?VjhnN05HV1JSckpTNURHRHBVdmRZb2Y4T01ubm51ZWtzUnM4c0NrYnhwenJS?=
 =?utf-8?B?WnlJd1lsWDVWaER3STNJekVzMXZjSWhLbGd6Q1BGeUNsalJTdjI2VDdWTHI2?=
 =?utf-8?B?YjZOYmF3K0p6OUV5cDlLdjlrbCtmelN0UjRQR0hiQTJyc01ENGppOEhpVWtU?=
 =?utf-8?B?MzU2UmxvRUo2V1NTWGRpSlFRMDc1eW10TzZUdWFxRVpBb3laT015ZFpiT1Nh?=
 =?utf-8?B?cnY5dWtmd284d1JSTFN6Q1Z3YTRuQkR4elg2NnZDRGdub1R1S25Xeno3Mk5B?=
 =?utf-8?B?dGxCR294RjRCcSsxZ0pmOHdhL0tsckhrajV0MFcreWFPUTN4RXhwSndlM0Vn?=
 =?utf-8?Q?ueN9ES9Y5FBjmdOhSTWK5yT7nfqXBQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9709.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGlteU5UMUtacERaMnFRT1FCSEN0VzRxUDFsQm5Ed2ljZ0xJdzZVYnVERWZ6?=
 =?utf-8?B?Z3BOTlhRcjJpYisycU1DNlE4T3dKR1VWMDRRd0lyM3piRGZmR2NKR0h4RjBw?=
 =?utf-8?B?b1VTaGowWkRUS1UxRU56Z2puK1k4bUJUcVhtZXpXbWx1WVE3enNIUUk3SnNq?=
 =?utf-8?B?eUhJam5BcXJJZVI1WVp1NXRickpUdDRUUFF6bzRVVVpZV2puUnY0OEt6RTZs?=
 =?utf-8?B?QmZoL25TRE1Fb2syU21GNEZyemp3eTgyVmx6U203bW9kWmdlTFNCMTNYYm1G?=
 =?utf-8?B?VFZlK290Sk5UV0lLRE16SWljbGRaWGpkT29HZ1Juc3R6S3J5OWhJc20xK2VT?=
 =?utf-8?B?a09mVXdyRHZLYmRFckdxS2hTZnUzRjhlVlZjMGRlSnlpczZEUzhZdmdPL2pT?=
 =?utf-8?B?elB3ME84bUpSMExHdmFHR0xMYjhIaEF5WDQ2aU1TVlNzd29CQjArWWIzemlM?=
 =?utf-8?B?NHdZL1F1VWVTeHE1Z1pLYnlyZHRiOUxoVllOY2o0Qkw3UmxYTXJYWnNmcDdH?=
 =?utf-8?B?bThKUlZ0a1BqRG1tTmY2M2lJRWRveEwvMyt4azFKTTJWOUpCUTEwNDA0eFBO?=
 =?utf-8?B?NmFwV2tSbUJCMkV1ODZCYUtXRVZCVHZpOFJLNmppUkkwZjViVjRaS09laG9t?=
 =?utf-8?B?TmtWZ0ltdytPdFJmNGtxTWVzYXJ5RnVzR3BUUXVqMDRYK0gvdUR1VzIxM1NQ?=
 =?utf-8?B?QVJNa0JRMkNnSkZjdWJRZ242N2JtSFpNRkcxbU9YWWloZEZML29odjAvR1Ay?=
 =?utf-8?B?cnMxMHVjOENCVzJlSE1pVkdWOENDeGtOUDFkOHplZURtTmZab2dEVVE0ekVE?=
 =?utf-8?B?TWhDV0lOSGh4TFZDcE1QOHlvQ3JOWkliallmTVRtVytWeUNoY2hrL1M3ZU9o?=
 =?utf-8?B?RkVkL1l1bWJkWG5VWS9GTy9ncnpqdmlDRkNXaHZYbFowcjJiZEVvc2lYOFha?=
 =?utf-8?B?c3haWmtqbUpMNmJESlZMQ21OOFR4cCtVa0ZvWUU1NkFETUorbFpod211NVY2?=
 =?utf-8?B?WktNRlNRVlhXUElZQTJkQVlYRTE1VDNzWE9ZWWhLbllzQkxVMy9HZ3F0VXFI?=
 =?utf-8?B?OGNxM3JPNG5DV0VkWVN5ZSsyb1Z4NkdPeElNL2pGdU9PK0dyczVVQjY4emhp?=
 =?utf-8?B?bERxVDFMQ2dpN1JTNEFzMmhCMko4V0c2WFNKNU9lbFNUWjhrQnptMWxlZDdj?=
 =?utf-8?B?NFJOZ0VNdXFZcmlPSjV5dzM1VGlEYWFhMWFXbHliVE04WkhjQk5FNW1OeDZZ?=
 =?utf-8?B?U1U5VlZpczZQSUUwRks5UzZBVG0zMWR3YUIxT29MQ2IyYlFBUndjSXNicUtl?=
 =?utf-8?B?NjRDeGxEL0lOZHh5Y2lQT0pTM2ZJcDVxNkdxNmJ1azBud0srUURzWGFtenBk?=
 =?utf-8?B?RE1mS3YxalREVmpaVUxrbWRWNXlkbzYyUXEzNCtTbzdhRTRuUjNMY0ZCL1Fj?=
 =?utf-8?B?ZDdwQmRveFJzbERwYlpPNW0rclZDZk96RFVrQU1BMEE1am9FMXhyQ2VtVDJk?=
 =?utf-8?B?ZEJ4b29ybTZlcGtLbWROU1JrWldFdUU0bzhIQlpTS2doa2x3TjY4QmUzTTg3?=
 =?utf-8?B?eUM4Vk9OVFZJbU5ma2kxUGNXTTJscnF3NGthSm00Z0dRZ2hkZlMzMG1KaHB6?=
 =?utf-8?B?ckVkclJDbHNiQnprUkxJU3VHVm11WTdHeGdYMFY4ZkV0UmtXTlIyR0hqckxn?=
 =?utf-8?B?RmQrQUxrZHFFMWdWdGlMMXBtNldyQmlONkFYclk3T2hHamtQOUNZUzAxQzNy?=
 =?utf-8?B?SExKWWtscjMzcG5sbWFwYW9WdkpVYUtsUWl6azZvanJzWElvemd4WGo3WnUw?=
 =?utf-8?B?SGNySWRWVDNXNmxVZitZM0dEY2d0Qkl6MW92RGVCa2dPRDh6YzB1bW5tVzRB?=
 =?utf-8?B?eXl2Z0VvSFpFdEhuanpkdld2QUkvTU15Zk1ZcWdNTHRYQStobWZ4ajVnekcv?=
 =?utf-8?B?ZUtZODZGSmVwekxqL2VTTzZYd2lCTVgraW5pUUhGRXdIOGtBaTRPb0dOUG5U?=
 =?utf-8?B?b3J0azRKb1N6aU5UcEhNRDZHMjdzaUlBNU42MnhRZWRVaENUVGZYeHRYMG1E?=
 =?utf-8?B?czV4Sk1VTnNoZnVzV1JKUEl2M01IZnBGcTlsaURvRCt4Q2lIRm5qWmhnNmt4?=
 =?utf-8?B?YThUS0VReWlXQlJFVGR4aGdKaXJQb000Z0wxVzAxZnVJYVE0ZG96QnZweS9B?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D46F640F0AE5C54BB88C9C5B494B77B1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5996d1-709c-46f2-1417-08dd7786169e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 16:46:34.4982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJ9B9OD6+3is722+1NvNkZ7AXO2FwgL3vYGcJlbgvhdlmVIU7UJgrA1eSBE82sQ4Wa7H0Br4NznsD6kBmz4hHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10785
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

T24gNC85LzIwMjUgOToxOSBBTSwgR2F1cmF2IEphaW4gd3JvdGU6DQo+IEhpIFBhd2VsDQo+IA0K
Pj4gRnJvbTogUGF3ZcWCIEtvY2hhbm93c2tpIDxwa29jaGFub3dza2lAc2lpLnBsPg0KPj4NCj4+
IEhpIEdhdXJhdiwNCj4+DQo+PiBXaGF0IHdlIHNlZSBpcyB0aGF0IHRoZSBqcl9lbnF1ZXVlKCkg
Y2FsbGVkIGJ5IHJ1bl9kZXNjcmlwdG9yX2pyKCkgc3dhcHMgdGhlDQo+PiBlbmRpYW5uZXNzIG9m
IHRoZSBkZXNjcmlwdG9yIGluIHBsYWNlIChieSBtb2RpZnlpbmcgdGhlIGRhdGEgcG9pbnRlZCBi
eQ0KPj4gZGVzY19hZGQpOg0KPj4NCj4+ICAgICAgICAgLyogVGhlIGRlc2NyaXB0b3IgbXVzdCBi
ZSBzdWJtaXR0ZWQgdG8gU0VDIGJsb2NrIGFzIHBlciBlbmRpYW5uZXNzDQo+PiAgICAgICAgICAq
IG9mIHRoZSBTRUMgQmxvY2suDQo+PiAgICAgICAgICAqIFNvLCBpZiB0aGUgZW5kaWFubmVzcyBv
ZiBDb3JlIGFuZCBTRUMgYmxvY2sgaXMgZGlmZmVyZW50LCBlYWNoIHdvcmQNCj4+ICAgICAgICAg
ICogb2YgdGhlIGRlc2NyaXB0b3Igd2lsbCBiZSBieXRlLXN3YXBwZWQuDQo+PiAgICAgICAgICAq
Lw0KPj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbGVuZ3RoOyBpKyspIHsNCj4+ICAgICAgICAg
ICAgICAgICBkZXNjX3dvcmQgPSBkZXNjX2FkZHJbaV07DQo+PiAgICAgICAgICAgICAgICAgc2Vj
X291dDMyKCh1aW50MzJfdCAqKSZkZXNjX2FkZHJbaV0sIGRlc2Nfd29yZCk7DQo+PiAgICAgICAg
IH0NCj4+DQo+PiBTbyB0aGUgc2VxdWVuY2UgbG9va3MgbGlrZSB0aGlzOg0KPj4gMS4gY2FhbV9y
bmdfcHJvYmUgc2V0cyBjb3JyZWN0IGRlc2NyaXB0b3IgaW4gYCBjYWFtX3JuZ19wcml2ICpwcml2
YCAyLg0KPj4gY2FhbV9ybmdfcmVhZCBpcyBjYWxsZWQgd2l0aCAzMkIgMy4gY2FhbV9ybmdfcmVh
ZF9vbmUtPnJ1bl9kZXNjcmlwdG9yX2pyKCkgaXMNCj4+IGNhbGxlZCB0byBnZW5lcmF0ZSAxNkIg
d2l0aCBgcHJpdi0+ZGVzY2AgY29udGFpbmluZyB2YWxpZCBkZXNjcmlwdG9yIDQuIFRoZQ0KPj4g
ZGVzY3JpcHRvciBpcyBzd2FwcGVkIGluIGpyX2VucXVldWUoKSBiZWZvcmUgcGFzc2luZyBpdCB0
byBqb2IgcmluZw0KPiANCj4gSSBzZWUgeW91IGFyZSByaWdodC4gSW4gTGludXgsIGNhYW0gZW5k
aWFubmVzcyBpcyBoYW5kbGVkIGF0IHRoZSB0aW1lIG9mIGNyZWF0aW5nIHRoZSBkZXNjcmlwdG9y
Lg0KPiBCdXQgSW4gVWJvb3QsIGNhYW0gZW5kaWFubmVzcyBpcyBub3QgaGFuZGxlZCBhdCB0aGUg
dGltZSBvZiBkZXNjcmlwdG9yIGNyZWF0aW9uLg0KPiANCklNTyB0aGUgVS1Cb290IGFwcHJvYWNo
IGlzIGJyb2tlbi4NClRoZSBoYW5kbGluZyBvZiBlbmRpYW5uZXNzIG11c3QgYmUgZG9uZSBhdCBj
cmVhdGlvbiB0aW1lLCBvbmx5IHRoZW4gd2Uga25vdw0KaG93IHRvIGludGVycHJldCB0aGUgZGF0
YSBhbmQgcGVyZm9ybSBhZGVxdWF0ZSBieXRlc3dhcHMuDQpVLUJvb3QgbWFrZXMgdGhlIGFzc3Vt
cHRpb24gdGhhdCBldmVyeXRoaW5nIHNob3VsZCBiZSA0LWJ5dGUgc3dhcHBlZCwNCmJ1dCB0aGVy
ZSBhcmUgY2FzZXMgd2hlbiB0aGUgc3dhcCBoYXMgdG8gYmUgZG9uZSA4LWJ5dGUgd2lkZSAoZm9y
IGV4YW1wbGUNCmFkZHJlc3MgcG9pbnRlcnMgb3IgOC1ieXRlIGltbWVkaWF0ZSBkYXRhKS4NCg0K
PiA1LiBUaGUgbG9vcCBpbg0KPj4gY2FhbV9ybmdfcmVhZCBpcyBjYWxsZWQgc2Vjb25kIHRpbWUs
IHRoaXMgdGltZSB0aGUgYHByaXYtPmRlc2NgIGNvbnRhaW4gc3dhcHBlZA0KPj4gZGF0YS4NCj4+
DQo+PiBJbnRlcmVzdGluZyB0aGluZyBpcyB0aGF0IHRoZSBqb2Igc3RpbGwgc3VjY2VlZHMgYW5k
IHRoYXQgc29tZSBkYXRhIGFyZSBwcmVzZW50IGluDQo+PiB0aGUgYnVmZmVycywgYnV0IG1heWJl
IHN3YXBwZWQgZGVzY3JpcHRvciBjYW4gYWxzbyBiZSBhIHZhbGlkIG9uZT8NCj4gSSBhZ3JlZSB0
aGF0IHRoZSBkZXNjcmlwdG9yIHNob3VsZCBiZSByZWluaXRpYWxpemVkIGZvciBlYWNoIFJORyBq
b2IuDQpJIHdvdWxkIGFkdmlzZSBhZ2FpbnN0IHRoaXMsIGNvbnNpZGVyaW5nIHdoYXQgSSBzYWlk
IGFib3ZlLg0KSGFuZGxpbmcgZW5kaWFubmVzcyBzaG91bGQgYmUgZG9uZSBvbmx5IG9uY2UuDQoN
ClJlZ2FyZHMsDQpIb3JpYQ0KDQo=
