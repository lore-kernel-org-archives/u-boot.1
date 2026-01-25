Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBF1E63CBF
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 20:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8AEB83D6C;
	Sun, 25 Jan 2026 21:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R52pb4pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963CB83D8A; Sun, 25 Jan 2026 21:30:29 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B7883D3D
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIZ2zzJRta5P+WLjiMZ9HNRJ8HCHm2pkkrhMJCUZMzD+u68MpZPk8ClCEbBuclnCeit0oUzMsAQMBPmdFBTfW4kdJFWUWdFID20s+8Ns2sFxYJlpVtVhwNt/9g1PT8AmpqjEVjrXoEfmXqRJFUWjsmzcGW/LZsL4nCYTrKG4YvADAAsvu3MYnt3IiVB6hbhaEdQ3bj6ykx0WbpYQfkSBYpRIbBiwoYajPOO2hl1/J9U522Scs3xJY/I3XWyes1nCMTn6cFtfG5NX45iWcgoFf5IQ4CHlExjCOMNEoDxGnFTYxrNRFxMyACguSUAEl6VZSwo+gut4UjRUiVWZgBItpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zNNQLsEOn2fZusTuaRDEMpS122VX8F/ZR0Qp8bLTAw=;
 b=Mditq/kZ2HoLN+mOgk/rWbeZRB3onoT5AoshJ05hOwYAh9qxgDcZl7dOK8Y7M47C1jUW3sEnW5hubYVY+uECyiuz4lGOYcECu3na2m+DXfR4HcJiS8tD+Aim6GB/sQ50iMWG+W41XtI98YAt59O6nnQPrZiD8wHxIgDdXzoao5vVQYhXmeHRNBitpfKMl10MdJ2J4YhnSDxhmgOBhooniSrGMZm78voOzwn8DckixfBCGkS+/jZ5ufN+fmUOGQYne22vTUpGcqz+kh9qP0/Udf/7fFGGTefBnUtZEbLpo6FjnHJ4p6Ugl21caGVzLGD1SZwBVYk15fFcSyBzGDxK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zNNQLsEOn2fZusTuaRDEMpS122VX8F/ZR0Qp8bLTAw=;
 b=R52pb4pnDNcV9MIXli5IvDGEjAUP4M1+jZLXGjEtVptJ8keHBjQDf+WD3qFsAfj+KYmGq92Ttlh32T8eYk+Uk4iyKYWaLl2/ni0bmtrofUaBN0ko9ArvlQSLWl2d3c/im2BdmAGd2F2XjbyRGRPms7hc7vzsFyVO+hgwR80VyuCeRhEgCWtv93yPs9disd44uc6WRq2vwIIdbIIc6jbN1u95bdHY0p9q/Yy0jycy2kc5ElVx5B84b4ri+zDU+EzJkzc5aga1MWUhH1XyKqv/uaZLslDFLEQFPRaVCPwuXuC/L1/DAlc9asoxo5bnlu9DAV5YtvmoR4YL6NPSQwmtzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 20:30:20 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 20:30:20 +0000
Message-ID: <4ea51968-388a-4b81-9c1a-62bb748e52fd@altera.com>
Date: Mon, 26 Jan 2026 02:00:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm: agilex5: Enable eMMC HS200 and HS400 mode
 support
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
 <20260125202329.12738-4-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <20260125202329.12738-4-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: b6405e8b-c1ca-4b44-cb66-08de5c508f15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEpaMjdPQ2VTTWlzT2tvTStKSnI0NnNDOHV3SVBpU2l5REo2VEg2S1JDZHB0?=
 =?utf-8?B?b0pwaW5kVWpiY3dWbWVmVmo1ZWNiME5neUx2eE1zblc1VStQSmlqaTAyN2tI?=
 =?utf-8?B?bDB1RlprR2FBL1ZCWlpYUnVNVUQ1Q1BkOXIrMmR0TFdGckVvbEIrbndvTGU2?=
 =?utf-8?B?c3JtWCtsWXNLUG1sYmlUdkVtUnRkZVJSUHZQRHFWRVZiY1ZCLzc2MTZWS2hn?=
 =?utf-8?B?MUNrMTQrUjhOWGN4aC80dnJCN2h0NHJ4Y3NKd1docHFXbHJERkl2NnBLbmlv?=
 =?utf-8?B?UGR5NmRzOXJ1Y2ZvVFE4blRFeVJrdHZTUnVCbVJmSVI1ZWsydTN6TllwaWt6?=
 =?utf-8?B?SGdaT0d6cHg4UWh1UkhjS2xFbVJ0RmVldm9BMHpvSENZdXVqdG1nWGczbklR?=
 =?utf-8?B?SFduVFdhTGI1ZHdNcndHM1MxT3ZKUTFhTHRwSUtxMGRHMC8vZDFIQys2NWVY?=
 =?utf-8?B?eStSM0xETkxZTjBkN0tCNHgvbmlPQ1BvZVcwK3RVYnNEV0szUVc0Ny9kazd2?=
 =?utf-8?B?cXJQRlpwRTFIVElOZXgwNWxGWFFSckZZNStYVzBCVnFTSVNIK0pXTEdkeEpu?=
 =?utf-8?B?RnUyRzNqRFpYY3NocVU5MWhyQjJGRTE3UTdCUUIrQnhlbmVFdFV0SVNvYkJ4?=
 =?utf-8?B?UUlWOEg3Y0tOTHA5MFp3VUQ1ZU9EVjdvSlF6NXJ2SEdrVUljeHZvNWdqQ0dP?=
 =?utf-8?B?YXpjUmFaTEZwTnVJdWNKZ3IxSmdtMDY0aXRPYTg3QWtmYTMyd3U1VFFTcVBr?=
 =?utf-8?B?TjVySzFDRFlLTW8vZmh0RFV1UHNFMjI1TCtXUndGc1krWERXN21KMjJQTldL?=
 =?utf-8?B?UlZCVjhEN3RRR3hNVXNIMnlvMzVwSGg2Y0UzSDBBNkltWktBUzJaaUVZZ21t?=
 =?utf-8?B?SHpDcmRyc09KQm1WUFdTYUk5cWI0czZ2T0phOFZxZ0JESTh4eVNVajZPeHIv?=
 =?utf-8?B?dnJsOGZlQzRjYkJQemprdTJOcGJ5bDFDOXM0ZzJOZGJnZGhtM0lvUTFIV2pF?=
 =?utf-8?B?bG5rM2VzdHBWakNzS1VUR0pHaUxwU1dpUFpRT2VGUUFjUklRTzZCY2d0S1By?=
 =?utf-8?B?VXVKVFZhazNUN3ZlNnNJTmU2SDNIUFdKdEpDVGV1Sm91ZWFrL3JGYjAvb2JD?=
 =?utf-8?B?K2g3bzFEOEFPMkVJSUJCK21zYXdRTGZiZzdMUkdtak90OVkyMlNtbTkvTW5t?=
 =?utf-8?B?Z1Ezc1N2dUdlSmZZK1hjS1FSd1hFbC9HZkR5ZlVBemF2dmh5N2l5QThFTEdp?=
 =?utf-8?B?Vnh4Tjk1NEloQzgvV0lNdEtobHNsdkhjNm9Qd0hKTmhZRUlkRUFOU05JRDY1?=
 =?utf-8?B?a3IyWDUrT0JIR1JhMExlOXNteExhVGFUdk51NlBmY0xNdFVERnM5ZEEzUXpw?=
 =?utf-8?B?bkEvejNYWkFRT0lqU3F1cXc2VzBsb0sveHp1SHd0YUs1c1NRdzFzOVhKUDBJ?=
 =?utf-8?B?U0ZJYkVUSnNUV0VxY085ZGZKbkRMOWVnQ2Nub2VVb0VvRjZkNnBiVUp0Skl4?=
 =?utf-8?B?TFhZbmNnQUpHdExBbUNhSGtreDJQZlpIa0FvbnJ2cVJDQ3RrZzUyZkdOdFZO?=
 =?utf-8?B?bFBzSzZXR0Urb1lxVHBibS9CanVSS2ZjUjR1ZTZWblhWZjdndm44a3A2ZEpB?=
 =?utf-8?B?YTVxcFZyMmJJbnJBSktYYUkzdHUwWjZDRDF0NC9KM3I5NzE2eGh6VjQ3Vlhn?=
 =?utf-8?B?QWZwTUZweW1yUmQ3NUhLa1hUUEpiRXRxaHgrNDRicnNBZ1E2RUk5dE1YQXNr?=
 =?utf-8?B?TDZodW9TTkZQaHdxd1BQbUJvUEE5cFJsUFF5bFY2ZzdQSjhOR1E5aTROV0hl?=
 =?utf-8?B?ay9UVFZaTmFxa3BvSG5NNTVlTVcyUkQrcnZYVXpsSDZCak0xc2UyZlRyVFJl?=
 =?utf-8?B?QVpzU29NSHFmRzVhWC9Rdm83K2lKQ3h1RE5SZmxyNkN5T3Z6N1NueHlvWHNz?=
 =?utf-8?B?VzJkeWloNUdjUjNYOTkyVUlvd28rU1V0alFtVjdRNDNYQmIvSzBqQm5MbFhI?=
 =?utf-8?B?eTNydnlVTklCMXhDLzhkYnQxWWQ5WEdJNnBCUnVOM1djQkZ0aXpMcG5KYTY1?=
 =?utf-8?Q?wHiLKq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjdHVVFWdTMxT0YwZXBuYTIxQnE1aitBSEZpTEdKaE9jUTk5VzFHWlJkRXhZ?=
 =?utf-8?B?T2lBZEpBSlJmZFNyODVMM2h6VzU3K0Fpc0VnTG9OR01mbHJCNU1Kci9jZ1lo?=
 =?utf-8?B?anhIT2J6WEkzRjZsYkdZM2pmN3BsUk02K2V0dVVaZWw3QmlRUHdDLytLWXBM?=
 =?utf-8?B?S3pFSGpkK3dIK0djSWlLd3k4OElVazNxK3NtTmlpWmQ4RFhJZ3k1VmUxYVZU?=
 =?utf-8?B?U2ppN1hraFBzcEpjRDEvUGg0Rmo3ZlhCbWNQRGxRYXRpUkxsdCtsR2c0U0ho?=
 =?utf-8?B?MkJVQURKVVdhMk13cnhpRGhRaHJmalZreWczaXNpQzFPTHNhVE5NYzZtTmV2?=
 =?utf-8?B?TDlkTlhzNXZ6YzFuNTdrNnZmNlVhYTROWkQyTDZ1eWdCbEY1WGRlOEM0dHFx?=
 =?utf-8?B?S3piMVNwUGNnM0N1dW1CYVRkcy9sQWllSHNGZmlNcTdmRHpWeVExOURES01m?=
 =?utf-8?B?NWU5U1hCS2hkNE5EcnAxRW5UV3lEQ1c3U2lIekN5a0duTUxVZUlVUGVhTFJ5?=
 =?utf-8?B?VXF3VWRXSTh2UnZQU1UzSmhYWHJqc0YreW80ZmhCL2xuT2x1Mmt1UVZBa2dY?=
 =?utf-8?B?ZDQ3SU51T3RIWDBSSUJUdTBKODAwVVhHR3VnSTJER1h3V0RWS000RFdqZXhH?=
 =?utf-8?B?K1YwRVQrVkgvajFKYnVQSUxiK2tzdmowY3VPazNQNWUveE54QlFDU2tjWmdP?=
 =?utf-8?B?bjl6bGRyTGtESm5LUFp3eDV1TEpDcWc3T0NXWGluNmc4aSt2QkhlSzN0UThK?=
 =?utf-8?B?RUgySGNZamZCakQ1QTM5aUcwYlRvdnBBbHRTdUowcksvNzkxY0dudWJRMTJk?=
 =?utf-8?B?ekZudWhFSDUyejVVUEtPTnJEMDJZS0VuRVpFbTdiR1lSYVNHeDFzWlgySnpq?=
 =?utf-8?B?ZXRUUDl6S2Z4QVI4OUxWdTRrZWFyeHJHL3I4WE1vUGpxL1kwR2xmc1hYOU5X?=
 =?utf-8?B?YXllWVZtUmRWYktrUjlDOHRNa1pyUEpuSWlKem9ZL1FKckFZZHNHSldXeVlY?=
 =?utf-8?B?T3hPdXF3UGxLSFEzdHhlNFc3d2s0WXJwMm56MExINUdQSnh4RTFHRk42UkZD?=
 =?utf-8?B?T2RPTXVMWEpIUzVRSmdtVnNsMnVGYmZJcndZSDdCdDV4ZmVIelUwME1TSFlj?=
 =?utf-8?B?dUFZeDVzRGZ3TUNGZlNMaFB3V0FYc2krbDJwUllSYzhic3hUVVZESWg3dm5l?=
 =?utf-8?B?UkI4aitGRXFobGpxdmdNMTgvd2JmbE1SRWZwUER2NDJYSTVkaEJZZk96bXFE?=
 =?utf-8?B?NTRFcVF5SUxvYkhtd1FOdU16cklVY0pQTVJQdldGMlAreGcrYnNmNHdtT0FE?=
 =?utf-8?B?aDRpc0o4T1VDdTJrSWpUay9BYm5DVHROZ2JOZkltblhmUTB5YkYyT0NKTmQx?=
 =?utf-8?B?Tkl0aVlNZXVKcDVhTzdYcGZXbnlyQzdqd3htaktMM3c5bW1wSHBacW5JY2pi?=
 =?utf-8?B?UnBHVW4xYWdlN1B0ekFkNjVKMFk0YkFyUmNqRDlINW83cUEyWnpOQXZmTlBB?=
 =?utf-8?B?YmFDYUpRb2IvMVpKZXA3WVFidDZKRGlyOFZmbW1RNjBReXhzbUk5NktyRW41?=
 =?utf-8?B?SmVBWlg5cktra1hRQWsvM2NveHFCYXpSVHgvanY0amlyV3ZBSWJQckU0dUhK?=
 =?utf-8?B?eHBTODZObkVtNWdwMTlhQjBkVkcrWDlrY1UrRUMwZU8zY3hQZUhONmpPQ1Mx?=
 =?utf-8?B?b0lNUjlkaFdJdjE3U014MkRRd1NzNHJZV3dWVS9PNFptSU5aOG5EQ0lOY2tl?=
 =?utf-8?B?NStkZlJNQm45RTJnY0xNMUI5WkMzRWI3akpkeW9aOW5KdEtlT3NFSVNmekZi?=
 =?utf-8?B?Z0tEYTlNTkIwbUZUTEFQMldtK1pNYzNZbHN6NkxoRGtWeis0UTBGUTFTVnVz?=
 =?utf-8?B?L2RwS0pnL3M3TE9PZXNLMEk3MzJ0bFhtak5SZ01ja3V2MUg1YUt2ekZvNGEr?=
 =?utf-8?B?aGhLNUVPKzVtOUZGQUM3dEtBT0QwWjRTczVmdVJqV3JkNzZsZnVyMnN1c2pj?=
 =?utf-8?B?dmE2QUczZGN4bHZENG41cUl5WEZqQXpCaDN6aSs4clFiMjdVU0FtUFkrVHRt?=
 =?utf-8?B?L0JtQmRJbGNZYjdGNndiYU1RS01wb0o0WUdPa0ZOS2Z6ZmZwZmdSdFI4SFdS?=
 =?utf-8?B?UzJWUk0zUVNSRDNlUUVTVmEvemR4L0F0VUU3aG5vUVJJT09JaTJmLy96emJT?=
 =?utf-8?B?TmtPSDVldjVwY1VNZWl1QUVOaXNPak1PM3BrUEV2aFM1TXE4R1hKNDJJWmxK?=
 =?utf-8?B?clF1R08yTEllS1JZbTNJWk9FYUhFWjNZVFRYNkpKZ054bVc4ODI3WTdrR1Y1?=
 =?utf-8?B?M25JYUxYRkNUWHlTRFBEL2RwZm83ZStNakNsMDM1MWt1ZCt4THdWQmxic0pR?=
 =?utf-8?Q?PzCb130l9eFaJP6s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6405e8b-c1ca-4b44-cb66-08de5c508f15
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 20:30:20.1896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raFdJMHz8U7X2uvu2xtCEne56LXgX4udebW4STy7NaeM2Th7dyAq/KTXZ4a7+KvCbCafLgx6A7eXU0wgx1Q1bhJCT+ycc8SokUFsfGzeww4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837
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



On 1/26/2026 1:53 AM, Tanmay Kathpalia wrote:
> Enable high-speed eMMC modes on Agilex5 SoC development kit for
> improved storage performance.
> 
> Defconfig changes:
> - Enable CONFIG_MMC_HS400_SUPPORT and CONFIG_SPL_MMC_HS400_SUPPORT
> 
> Device tree changes:
> - Add mmc-hs200-1_8v and mmc-hs400-1_8v capabilities
> - Add sdhci-caps-mask to mask SDHCI_CLOCK_V3_BASE_MASK bits
> - Add sdhci-caps to set 200MHz base clock and 8-bit bus width
> - Add PHY and controller timing configuration for HS200 mode
> - Add PHY and controller timing configuration for HS400 mode
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 28 ++++++++++++++++++++-
>   configs/socfpga_agilex5_emmc_defconfig      |  2 ++
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> index f6848c373cd..49b4a85783c 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier:     GPL-2.0
>   /*
> - * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>
>    */
>   
>   #include "socfpga_agilex5_socdk.dts"
> @@ -25,11 +25,15 @@
>   	disable-wp;
>   	non-removable;
>   	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
>   
>   	bus-width = <8>;
>   	vmmc-supply = <&sd_emmc_power>;
>   	vqmmc-supply = <&emmc_io_1v8_reg>;
>   	max-frequency = <200000000>;
> +	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
> +	sdhci-caps-mask = <0x00000000 0x0000ff00>;
>   
>   	/* eMMC legacy mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> @@ -46,4 +50,26 @@
>   	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
>   	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
>   	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
> +
> +	/* eMMC HS200 mode timing configuration */
> +	cdns,phy-dq-timing-delay-emmc-hs200 = <0x10000001>;
> +	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
> +	cdns,phy-dll-master-ctrl-emmc-hs200 = <0x4>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
> +
> +	/* eMMC HS400 mode timing configuration */
> +	cdns,phy-dq-timing-delay-emmc-hs400 = <0x10000001>;
> +	cdns,phy-dqs-timing-delay-emmc-hs400 = <0x680004>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs400 = <0x4d4b40>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400 = <0x81a40040>;
> +	cdns,phy-dll-master-ctrl-emmc-hs400 = <0x4>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs400 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
>   };
> diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
> index 9254ab92e0c..d2d359cd1d4 100644
> --- a/configs/socfpga_agilex5_emmc_defconfig
> +++ b/configs/socfpga_agilex5_emmc_defconfig
> @@ -4,3 +4,5 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
>   # CONFIG_SPL_DM_REGULATOR_GPIO is not set
>   # CONFIG_DM_REGULATOR_GPIO is not set
>   # CONFIG_SPL_DWAPB_GPIO is not set
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> \ No newline at end of file

Add newline at end of file.

