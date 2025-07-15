Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A29C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 12:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE5882BF6;
	Tue, 15 Jul 2025 14:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OtqR0kvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417D282E37; Tue, 15 Jul 2025 14:06:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2903D8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 14:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE1UycEP+YWc/wm0hWSctjjr2yoYllxZj4aI1icGDDTdijv/YcR5HrgJYsbrCmn8njT9zwWApfiD6FjqngDMUd/bD99+yBZcy7uenRrb0kcLsfscWViuMGytmiw3eQvBh1wNc2tw/8sKYiK2oHERQ16d2ZCfAyNov6L/uwYqjr3z1VSznY7ICLnpGQfai3EnjBg4b02hwpsy/W3sXVtgYMcQRFjCrkRM3EKiLVONs7VdmQyNlG2IX7YW8U200W3lUNSDXNbDxxfSl1cf4zWi/f+ELjuy0FXWmkI1p465PK247ovUjC2XsQF4SdCnK4qeyy6yC7xBoMskBeAEzgda0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwr8pLQOF3maIW89qDZMZ7nlNs759lV6SqevXa43mq8=;
 b=FjxmVmoXldSo5beudiAS7e+glM1RjoZzUmcFyyF1CZYUFJr0u1ofrCe4y2BAsoR2tZ4sCz+WgyV6VgqwxweYh/E3oqp39oc1/fa2XAOu0YofR1twSqMiZ6edDrk+oHc3zOS91N2JS5r+1K4PeM8dlVLRA34iudpR2nRONSTH6lCmFTj7IFKtWl4WSWZAMIkUD6018U1ZptUOkbImUlP8bdAIBhlbepkh7jIG5NFsF9s6I9ZY979aTzCchgTzUUVpNViNRdQXE8OrEm/YEHJcWxtkbWDXc54nk4zH/FICU+GKskdaPQSyK1UskwaioNs/MFWt/APRi0dURyrsPCkKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwr8pLQOF3maIW89qDZMZ7nlNs759lV6SqevXa43mq8=;
 b=OtqR0kvX8LA7w8/KtLNNUNGpPqskrGL2KWuAUtifcPiblNl+7pWpZZJc0SJ7nvRjt0rRmZczpTpRQ9j8WrqUYy/lQpEqOuJkeAb3HuxYFp/5M6TXLYI1c1vm0tn/LwnGY9aiPximNZK1NjJfRV1nsYJrAYDj32H2zMvwGklecJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7755.eurprd04.prod.outlook.com (2603:10a6:10:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 12:06:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:06:23 +0000
Message-ID: <a836de8e-5de1-4cdd-8dcc-643ffa0463b1@cherry.de>
Date: Tue, 15 Jul 2025 14:06:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] uclass: Cleanup uclass_find_next_device
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
 <20250714-blk-uclass-v2-2-1bb1d2eee896@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250714-blk-uclass-v2-2-1bb1d2eee896@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0257.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: def13961-49f6-4dc1-8fd1-08ddc398046f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OStraHI4SHhmbUw1L0E4SHp0Y3d0cHdrL2NkYWdDV0lLWjVxZWFwMGpGSitp?=
 =?utf-8?B?QVpxY202QXdKcE5SdVF4UUpWdk40N0FlYjdqdXk3Ni9IamJIdkptVzZNcExi?=
 =?utf-8?B?V0RFcFJsamRWNFY3RmtRL0hobjJsNmwweGNvYzZnRjFidkFWM3lqMjlZUS92?=
 =?utf-8?B?NTA1ZzBXZVdIK3FvZ2ZzSVhMNURJWFZnYXU4am5od2pLVkluMFgvNURXamtk?=
 =?utf-8?B?MHJMa1lEdFlwRzQ2OGhHbS9VSGx6RDN1RGVTZE9UYm03cGxiVHhzQW91QTBr?=
 =?utf-8?B?TGFMTTRuOXVpT1l6VFdIOUQ2Nk5LeU1CYjRNOTAxbjBiN2NBVmx1QnZyWUZR?=
 =?utf-8?B?SkxlblRaMm5YS0VyekxlRlZ0VVZ0QkJtZjRycWl4eWVhOVBDaWNOYm9zam1y?=
 =?utf-8?B?VlJTN2hmQWZWN3A0aWlGaVVmdWx3MWpIeDlIeE5ZVUhPajJTSGdidkRPRkxV?=
 =?utf-8?B?Y2pzSklJeFZOcVowNmNYcTVqZmwwVkpMYjRpQng4LzFFRlYzQ3l3dmE3Y1pX?=
 =?utf-8?B?N0tDYTMraldZTy9hOU91dHRQM0szLy9OdytCQWIxcHA5dldTZ0RCemEyb2o5?=
 =?utf-8?B?dkk4ZHdRNHBmWldnRnVlNmpya05FTkNTVGNxM0tXRndqUzh6b3JnL2swVHE3?=
 =?utf-8?B?RUN1RGNGdVVsMzlxV292cnNPMDZ1TEUvVjBYR3FFc0JFb1FKUGJ0NlNCdEM5?=
 =?utf-8?B?V0xFbUx0em5VVUVpa0IwL3VFalFDaXU5dWlBQzJTZ1U3aGJ1czdhRlJNSmdB?=
 =?utf-8?B?RWVKcXZKRWxINVZRUTNaYWVvUHkyUEFFS1hqT0tDb1pFZlk4dFhSZDdzNVFt?=
 =?utf-8?B?b1BzUHJkOStKWDlYcTY5YUQwQjZ4b1poeGppSlkreU1TOTBMSWZHMmR1TnNl?=
 =?utf-8?B?cXFHWnFPdjNFZVBjdzY1UzV1eE5DK0FWYi9GR0lEdnVpbHN1em83SDR4OU8v?=
 =?utf-8?B?K1oxTXM3eTQ1TnNzbmI3eStzVm01d3pIWUwrblFsM2s2OC9sMEJ6eUNKQWZC?=
 =?utf-8?B?anNEZTkxOXdtbDhYdThBMHJ6TG9qdjFibkh5dmJJK2JGeVJsUTBWOEs0NTFy?=
 =?utf-8?B?Rnp1aDZJR0hLSHMraHVHeFVobjcxa2I1MjJCTFI3RzlnbG5DOG5qUk9zc0la?=
 =?utf-8?B?RGFjKzNVeGtFeE43ODVsRVhac2RTOCtJenoxeURWK0R0Z0dZTFUxK0E1cHJT?=
 =?utf-8?B?Qm0yZDI1ZFpURHZOTk1OZXVXMGZxU0k4NkJnSllHeWJsdGhLZHVNT0ZsSWZR?=
 =?utf-8?B?UDRoUCtyZHhwT2xtd3paV1lPeldYVjd3ZFI2Vkt1TFFtRnl4RkpPN2RWMTdo?=
 =?utf-8?B?UFV6L2wrNGhVTjg5U1ZOMlJYV3hUTkJ0OFJ3UHNDa1crZ1NJS3RiWjBoVUJY?=
 =?utf-8?B?NExEaGJZWDkxejBUWDlJTWtnYkZiWVZEak1lbHVzOTJxb1JOQXl2K3RlMkpI?=
 =?utf-8?B?VktKUWpXdWhvT0NLc2g4SkozZXgwWlZ4VVJQUUNFU3ZkVE1DUllxejNEbkMx?=
 =?utf-8?B?ckN5V0dpK2NpM0gwbmVoVlhxM3N2MWNlVExnckwrVTJORW5MZUJ2NFFuTCtP?=
 =?utf-8?B?M1h4dmgyUDRzb0J4eVpNR05pV2Z1dVdVbDg5YS9YczFmc2gvcjYzU0MvM0lW?=
 =?utf-8?B?NWp3ZUZiN0pPTVdKazlBK0RDWVZJQnpOdDFKNzZBa3EwSzE2eGtDU2doZVZI?=
 =?utf-8?B?QWovRDNWcG52cXNSWENGeHc5anM3MTJWMEdHTE9TazZjWDV4T01zYzBvMDlG?=
 =?utf-8?B?YWs0VjFEci9SODYvTjFTVkRHOFRGZ2NuWVk4U0daN25sdWt1YnBQQkJEaEZF?=
 =?utf-8?B?YWpJZ0h3TDNBZzNnRlhwSjl1Vm9PT05nMVY3OXhBZ2ZRYUdVMW5rYjRsMFl4?=
 =?utf-8?B?TzBub21veC8vMDluZkZDWUNlYkxaSWl5cVlXanNXM3AzaDRkTndPejAzTjFX?=
 =?utf-8?Q?b9QAHcPnrtg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklLaW9rS1krZ21CemlNbUo3ak1vRThTZlI2OUU4WEduSDkzcE0rQ011R1cx?=
 =?utf-8?B?endrUmwva3UwS09lKzl2dFNJVmdwMmdHQkVSbWhmN2h5M2RUbU5PRlJVazJj?=
 =?utf-8?B?cVNLdVZFbmwxTGczMWxMMGVXVkc4Vnp6SGxzZkNXZk9XbWN6aW9XdkZSV0JM?=
 =?utf-8?B?bHRFbjNVMXR6ejhxRlhLUGU5OWw1VVB2RUk1K2M1dk5EcEF6b2k4SzZlWGJQ?=
 =?utf-8?B?dFpnNExBNUVKRnZZRnlXeVByNjNvKzNTbzFvRm9OaWh2YzNQYWhIbXFDUjBZ?=
 =?utf-8?B?MFM2bkcwelkxV2ZrK1pEWDZveStSVkFNYXl3bUNQcXB3MnFxZ1Fza3NNRXQv?=
 =?utf-8?B?NEZ2aFV2NmY4Ujh1eTJMaW90cDNXcW5rNFJLeEVIZHdCYXR4aFNyQldBNEND?=
 =?utf-8?B?dUR3UTBkYlZBOWxZcGFzOXZkaitGbjNGRzNrOUp5Yy9oR3drZTNQQXhHdENy?=
 =?utf-8?B?ZFQ0MXNPbGtaOUU1M1gvTm1Ia2FtLzlPMjFFR0Mzcm9LYW14MlhFVTZUTjl3?=
 =?utf-8?B?Q2E0WUlNd1JweXJMaUgySGpFeWZCZlYvcTRrRWhZa3dRejVyODJDdFVuOGdj?=
 =?utf-8?B?YVljUVpGTzdDK2Uxb2xkV3gwSTRUQWRXb1VUSWZ4SGQ1cjNTQ2hEYVJHQUJx?=
 =?utf-8?B?a2RKT3BjV21XSHQvenFLNHh4ZzR0S1VvUDFITVR3MzY0VWlPV05GbTYwaENX?=
 =?utf-8?B?TU1QdEtHclF6Y2Z1TEtvSWR2SHNpSXpXU3N5dmdkS3h3Mll0Ri9ZeXJuMlJ3?=
 =?utf-8?B?TnVtVks3VTBWNGxNMUdCMHZnUzRDTHNGaEYyWXdpVnFjWXlmaERBdmVreFlu?=
 =?utf-8?B?dUZ5ZDh0ODBDMFd5U2RCbUxxanJ1N21BcGFKcXhnNi9hckVaQ28wM2lKaW9m?=
 =?utf-8?B?QmFkYXBoOGpLNG9GRGhYY2tJWTVIbE5BSjJyS200bGR6aU4xWFFUYmt3QTlq?=
 =?utf-8?B?dXNnb2RzQmxGZVVvZG5DNk5KMXJFUnNvaUhJdzlOeW5Mbm1IVHN2RTROZURV?=
 =?utf-8?B?L0JCcFFMSUJGeXJ3cVhwTk40ZGc2Wk90cmJONk45aURJWkdjVDNyM2tERzdq?=
 =?utf-8?B?R3p1ZHlpN2h2YzlPd05VakhSTmk0OWVkWmxEVmtnSnNwK1hXdkNYa2lYeGFC?=
 =?utf-8?B?R1RlYW9UbHl0SGdtdURVVVNPRDBRbDV0dTgvVG1sM0JuZVdLWWJVUTU3TjRa?=
 =?utf-8?B?VjJCNGR0Q1pFR0R5SThzaDlUSWZubUxBaUtjTkFQNEtMdXp4a1hiR2NtaTdq?=
 =?utf-8?B?M25oYUREMUsvbklHSG14cmlOSE1oQXhkMFNmenNjY2wzNUNmNG53dVViZ010?=
 =?utf-8?B?L1RxR2JLMGZRUmgvdVdnWGNkSml1cjhHTG56clo3TWtDR3lwVzhkU204MUJw?=
 =?utf-8?B?TnRodHJOaEdkZ2lxL1YxZmJTb3ZtRk1QYm1Fdkx5MTZHNFBuOXFlMjg5NWg5?=
 =?utf-8?B?S1VwS2pSSDJxREVOazRKbWUvVUVHTUUwRUV1SWMwMVN3eDQ0RXVnL2Rib0J6?=
 =?utf-8?B?enUvS2FHeTFldU9XdytJN2NlZHdHem9pVU9xL3grclBwRURLd2VrWkd1c1ly?=
 =?utf-8?B?VHpaV2FjRXQ1QXVha05TeHR0ZUZJOHJYZ29pSnJBbEJDSkNSZzIycU1uUzE0?=
 =?utf-8?B?SGdwZDcreHhmQ0QvcUNyTlpBRVRIbkNFTEMzeGpmdTEwQUhodE96MUtoRGVk?=
 =?utf-8?B?NTRTS1ZPck9TT3J2NkROMVJUdVIyUUcveEoyK2drRDUrL0xZZVU2M1VIdnhw?=
 =?utf-8?B?NFhwZFlGbWJSNUxsRHFwR2NOUURaTVQvaXlpdTVnQjUwRXFGS1FDTlhDNml2?=
 =?utf-8?B?Q1FvMUZuWTB0NVplbnd3M2JlejhaTHZWRDBIR3g4U1Jxc0w4elRhOFpTc0dn?=
 =?utf-8?B?V2NGSGU0K0w2SkF3a3Rid1hnS3hyWVp0UjJGdFpmQ3dnQ25UZlBGei80Q05l?=
 =?utf-8?B?N1ovV04zREQzY2lqUU1wVzh6Wk13YWxWb2RrTVhJSTN0aUpUZm9KZ2NtRFpT?=
 =?utf-8?B?MjNjY0Jjc0NPallCY2VUazRtWmF1L0FiTXRPTGNOT3d5S3JKdnlmcG5rZFhF?=
 =?utf-8?B?bmQ2WlpCbmZvazZJN2NRWGg2U1kvUjFPNjcwaUc2RXFzUlVEVFh3dHZDT09V?=
 =?utf-8?B?MDRBY2NoRVY1VHNRZHdPUlMwUE8xV2dBZXV6UklTWHBURU9FZk5VWEJ6Ym4w?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: def13961-49f6-4dc1-8fd1-08ddc398046f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:06:23.7107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe4o061Ph6PxjVX/0kYgZPmpGKGEaUU+FSzXqRhQmpxqTyfqHCu0rI3INJVkrt3jbn0xuGDjg254r+sdodBOpkTKHx7gC9+Zdh2M4D7RfnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7755
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

Hi Andrew,

On 7/15/25 11:23 AM, Andrew Goodbody wrote:
> uclass_find_next_device always returns 0, so instead make it a void and
> update calling sites.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   board/emulation/qemu-ppce500/qemu-ppce500.c |  4 ++--
>   boot/bootdev-uclass.c                       |  2 +-
>   cmd/regulator.c                             |  4 ++--
>   drivers/core/uclass.c                       | 16 +++++-----------
>   drivers/power/regulator/regulator-uclass.c  | 10 ++++++----
>   drivers/remoteproc/rproc-uclass.c           |  6 ++++--
>   include/dm/uclass-internal.h                |  4 +---
>   test/dm/core.c                              | 28 ++++++++++++++--------------
>   8 files changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
> index 40d295dbf06..58de4a05296 100644
> --- a/board/emulation/qemu-ppce500/qemu-ppce500.c
> +++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
> @@ -170,9 +170,9 @@ int misc_init_r(void)
>   	 * Detect the presence of the platform bus node, and
>   	 * create a virtual memory mapping for it.
>   	 */
> -	for (ret = uclass_find_first_device(UCLASS_SIMPLE_BUS, &dev);
> +	for (uclass_find_first_device(UCLASS_SIMPLE_BUS, &dev);
>   	     dev;
> -	     ret = uclass_find_next_device(&dev)) {
> +	     uclass_find_next_device(&dev)) {
>   		if (device_is_compatible(dev, "qemu,platform")) {
>   			struct simple_bus_plat *plat = dev_get_uclass_plat(dev);
>   
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index 3791ebfcb42..6718c482e52 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -216,7 +216,7 @@ void bootdev_list(bool probe)
>   		if (probe)
>   			ret = uclass_next_device_check(&dev);
>   		else
> -			ret = uclass_find_next_device(&dev);
> +			uclass_find_next_device(&dev);

I think we need to ret = 0 here as well? Otherwise the printf at the top 
of the for-loop will return whatever was the last return value?

>   	}
>   	printf("---  ------  ------  --------  ------------------\n");
>   	printf("(%d bootdev%s)\n", i, i != 1 ? "s" : "");
> diff --git a/cmd/regulator.c b/cmd/regulator.c
> index da298090bb7..db843283662 100644
> --- a/cmd/regulator.c
> +++ b/cmd/regulator.c
> @@ -97,9 +97,9 @@ static int do_list(struct cmd_tbl *cmdtp, int flag, int argc,
>   	       "Parent");
>   
>   	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
> -	     ret = uclass_find_next_device(&dev)) {
> +	     uclass_find_next_device(&dev)) {
>   		if (ret)
> -			continue;
> +			break;

I think it would make this more readable by having

ret = uclass_find_first_device(UCLASS_REGULATOR, &dev);
if (ret)
     return ret;

for (; dev; uclass_find_next_device(&dev)) {
     uc_pdata...
}

return ret;

What do you think? This also avoids checking for ret in every loop 
considering it won't ever change.

[...]

> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 09567eb9dbb..eac025c9c02 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -261,10 +261,10 @@ int regulator_get_by_platname(const char *plat_name, struct udevice **devp)
>   	*devp = NULL;
>   
>   	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
> -	     ret = uclass_find_next_device(&dev)) {
> +	     uclass_find_next_device(&dev)) {
>   		if (ret) {
>   			dev_dbg(dev, "ret=%d\n", ret);
> -			continue;
> +			break;
>   		}

Same here.

>   
>   		uc_pdata = dev_get_uclass_plat(dev);
> @@ -411,8 +411,10 @@ static bool regulator_name_is_unique(struct udevice *check_dev,
>   	int len;
>   
>   	for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
> -	     ret = uclass_find_next_device(&dev)) {
> -		if (ret || dev == check_dev)
> +	     uclass_find_next_device(&dev)) {
> +		if (ret)
> +			break;

Ditto.

> +		if (dev == check_dev)
>   			continue;
>   
>   		uc_pdata = dev_get_uclass_plat(dev);
> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
> index 3233ff80419..7916cb27e3d 100644
> --- a/drivers/remoteproc/rproc-uclass.c
> +++ b/drivers/remoteproc/rproc-uclass.c
> @@ -56,8 +56,10 @@ static int for_each_remoteproc_device(int (*fn) (struct udevice *dev,
>   	int ret;
>   
>   	for (ret = uclass_find_first_device(UCLASS_REMOTEPROC, &dev); dev;
> -	     ret = uclass_find_next_device(&dev)) {
> -		if (ret || dev == skip_dev)
> +	     uclass_find_next_device(&dev)) {
> +		if (ret)
> +			return ret;

Ditto.

> +		if (dev == skip_dev)
>   			continue;
>   		uc_pdata = dev_get_uclass_plat(dev);
>   		ret = fn(dev, uc_pdata, data);
> diff --git a/include/dm/uclass-internal.h b/include/dm/uclass-internal.h
> index 3ddcdd21439..9cb3f090271 100644
> --- a/include/dm/uclass-internal.h
> +++ b/include/dm/uclass-internal.h
> @@ -149,10 +149,8 @@ int uclass_find_first_device(enum uclass_id id, struct udevice **devp);
>    *
>    * The device is not prepared for use - this is an internal function.
>    * The function uclass_get_device_tail() can be used to probe the device.
> - *
> - * Return: 0 if OK (found or not found), -ve on error
>    */
> -int uclass_find_next_device(struct udevice **devp);
> +void uclass_find_next_device(struct udevice **devp);
>   
>   /**
>    * uclass_find_device_by_namelen() - Find uclass device based on ID and name
> diff --git a/test/dm/core.c b/test/dm/core.c
> index 959b834576f..201daee6836 100644
> --- a/test/dm/core.c
> +++ b/test/dm/core.c
> @@ -737,7 +737,7 @@ static int dm_test_device_reparent(struct unit_test_state *uts)
>   	/* try to get devices */
>   	for (ret = uclass_find_first_device(UCLASS_TEST, &dev);
>   	     dev;
> -	     ret = uclass_find_next_device(&dev)) {
> +	     uclass_find_next_device(&dev)) {
>   		ut_assert(!ret);

Ditto for all the tests in test/dm/core.c.

Cheers,
Quentin
