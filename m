Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D403C44503
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD648341A;
	Wed, 21 Jan 2026 11:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XioLz0zG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2881E839DF; Wed, 21 Jan 2026 11:43:29 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79CB82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRJcN7NluB68GwkyDnQIbcxG1esAZBdslqGuUnXUVVid3Oc/1WM2Lq1gbA5KTxVjeJ1qHRuY2/1FqCbMnctlhei1VmllPvo9XRZqCB+FtfLJt23k4ZiZnkq2w2qy1vyDwMM5extWfKjChceLZAyl4m5nOs2D5FERQVD97oYFa7RyB/2aQ52JALEMFHkxwm1OOW+lrcmtdNmtXO5UUw1cghthGE8NVUzUAeKJzzeBweKgO75qWycFWLv3H2wzMhLBD39h/ZXAU5MKjNHQUzQFq3D13W7m7Uvij7Xdnu16S5kHENWM0xz75EFgfXcsv8lI+iCCvvtNW2idFlgnDx+Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8d2KPj6+3IWHdW0XAKmgNaQFfDO4BqakNnh2LGhOtg=;
 b=RmTBDSK7Uhi/VQPvcNwIUaNWImZuMZQr3tbRewGnJYxmqsLZw4rJlTt0SmNi4R9UjZiumgHqpyAdaFolJ5S/TQAliFo/VcF+tw5dQoWfCWd6TPYvSGqdauBee5sLgdv0eRq/CujcVqa1wWWlUT1WXqdhBw6msge+zCschsF5RqDUA+F323mIXYoQ23TnKQfSeyiVn5cXm+tLTDXUFlLfaYZXNOv0b1RJnv0arGN2t/DWdHSakOQFkIlYVKJsrHdKEQHNZXqqlPKYw4zwL2+w/NedVX/xNiIplDm+X7g2U2rxOizWrRhxtgnBpXDBd2JZaHB8TgSa0bD0mi7K8w/0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8d2KPj6+3IWHdW0XAKmgNaQFfDO4BqakNnh2LGhOtg=;
 b=XioLz0zGko3wURXOjVMsrxSgYeQutjX67C0K8MB3FdqhSCypZLw0PtqvP21d7KpVhGUveQdzBb+LI0/xXGofJUfI8gRcnQcdLxEWCJX/DQ653IOGvgLaA5HhoxYUzoAB5IlK6i1X8Al+dLHa2tngncqO3fhc0mpfCcH94LH+YOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 10:43:23 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:43:23 +0000
Message-ID: <a755a0c4-0967-419c-9621-46e70fe64116@cherry.de>
Date: Wed, 21 Jan 2026 11:43:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] doc: develop: process: Move the existing block
 about patch application
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260120201327.451872-1-trini@konsulko.com>
 <20260120201327.451872-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120201327.451872-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: 631b0e72-37a2-4049-04c3-08de58d9e65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajYzZXd2NjBGWVlPdit5MGdSSEV1S3gzQzNmWEVodXNxc3RyZm5tWHRIWmh0?=
 =?utf-8?B?Wmt1TTgxZDVnMTBJSzBiaDJONzJ5ajJLb3FwZHcxc1pFMW45TVJuYkxLU2JJ?=
 =?utf-8?B?TzUxRDNabXBpZ1QwNzFoZnp0VHBvcjNJNTA4VFhxcmF0V0pxQnh1UmxvdXFl?=
 =?utf-8?B?V1phZXhzZTVHTURHTnlqUFhMWHdXMFduZFRKSUgvOHMwV2Q1ZkpVSVJOUis1?=
 =?utf-8?B?ODdsTERrTkRhRDJFbnFPMVJVYWlrdEc4elEzcHJxZUl2bjJEaVVORmZmMC9M?=
 =?utf-8?B?OVdmd2M2RWkyRHEyRGZ3dzhvblZ1U2JYVGt1ejNhbVdWMUMvclhrUWl5QnY3?=
 =?utf-8?B?UVdsOWJsRGZ5SWpHMUovUW9ubE5hU0ladmNnYUFXcGMxSEtUVkl1MUhJaFFq?=
 =?utf-8?B?QlJwak93RUtOOVVzbkNjcWRKY1hCd2orQ01RWU0rZkJyeGc3U3BEeEhZa1ln?=
 =?utf-8?B?TkIvRzFZdk4rZk51dmI2VDhaU1Irb3MyWE4rRUYrcWg1TDR0L0p5K1hmNEtq?=
 =?utf-8?B?SzJwbjU3WGN1Wmo2YUdCSm5OYUdiV0djTDhWeHc4N3pRanBVYWFzbmhUdjY1?=
 =?utf-8?B?SitIWDNQTDlxMWtKMndqMUczZTRhQU5xeURYYVdzdTdVOGVHM3VHbDRxOTB2?=
 =?utf-8?B?NTM5ZnBjYm83dVRWS2ZneVF4bW0zeUI2bVBTRVRBM1hPdkJPWDRxckZiaGl6?=
 =?utf-8?B?ZkFmT1NySWs3WVlucXdleWFMTDlmTThCN3J1OUt0TlRPUnU0cTNGNm5QM3dh?=
 =?utf-8?B?UmZicjlhcDByRmFOT0tlV2FnSVh3R0JWUUpORjlVdzRkdGsraWE3aGRMcHRx?=
 =?utf-8?B?WUFQdS95MXhxbjdzUzJXRVA5L1crZXZyRDFKNWMrc2ZZUFlJVjJFT1NENEd5?=
 =?utf-8?B?L3BjblBxZkNKV1BIaTVVUjgxV3F3LzgyV0QwY0tTTUtaeHRESEdpSDVoeXp4?=
 =?utf-8?B?Y0NhZVFxUjBISk9VdVkxNWtwN21Uano4RFl0bHN1SmRiNXA3UzFCRHNDbkl3?=
 =?utf-8?B?TlYzZVdXWXgyQ2VGS09VU1cyWFh2cU5yRy8wQ0N3N1pERzNBQkpJRzJhUy9Y?=
 =?utf-8?B?SDZvTkIwRW1KK3RaSnM0cDF1L1BvQWRIbnpsU0hCTUZIOHI2RkNhVUdsVEtZ?=
 =?utf-8?B?eTJaa01XNkxDN2RXQVNvcHlOSXc2WElhV0VCbXc3VForRHB4cGtvM2RDWHVk?=
 =?utf-8?B?blk2V3A2N1V3UkJJWXRvemRZVGxwTC9OMnIzV2pkQUtRam1pQ0o4VHpac0c0?=
 =?utf-8?B?Mmxndm1xRzlQOGdFV1FtMEhnS3dYZXd4T0xpVGZZOVl0S1UxZEVOMTRpTHFE?=
 =?utf-8?B?c3pPbjRQNHkvU3FBb2VrK3FkZ0FFYWdacHVWT0RvdjQyaStNNmdVSVJBYlpS?=
 =?utf-8?B?YStMVElwTTdOUzBGRERuR2JoalNhZTdoRmVoOWd3MmlMWk14NnRjclhIZ3h1?=
 =?utf-8?B?UkJxTWt6aStKUmkwMEZXY2VEeDNFK2NaU2FWZk5PVThkT3JuazFvMUxEaXpY?=
 =?utf-8?B?ZnM0Q3c0eC9IL1hveENMeVVHUGlWR0JoTVJzRjlFcHVadGRCUVZ2aTg2YjRv?=
 =?utf-8?B?cmp6b1NwQTdvWjM2VS9WV3BrOFJnNUlsZHY4ZXpldjhWeENVL0tZSFFxQzlz?=
 =?utf-8?B?dDV2UGJTV1AwblZ1Yjdjd25EbWtGdjNiMFZuQmpQWGhBZWgxQjJ0MEhoZ01X?=
 =?utf-8?B?NEZZUE5kM3hyNS9VM3hKZ1hIWjZTcVdoblZ1MlpZUWs5dTlSa1JzVE5nTDJX?=
 =?utf-8?B?WjBCNldaaSt6SWNtalZNdzdUdDZKVTJjTnRodklWT0NzdTdKNytKWDU4S05z?=
 =?utf-8?B?aEJtY3Zxc1hQT2wzb09EejNlazhBa0dXYjU5azV6SHBYZDJadW5KUHlKektU?=
 =?utf-8?B?K3ljclZaczNWMnhXblE5aUpnVWVyTkRlaXhJK3BkaE8wM2hwWjNNcytvTE9H?=
 =?utf-8?B?TFRoTlRRY3RnZWdOcFU4VHhRdWV1dGFZUVB0WCtZUnU4WWxneUpNZ3g2MVNG?=
 =?utf-8?B?WXIzd2MvOE5Xc0N2ZnFPbnRWRWdvNU1UZXIySXBuWkZraTZINVlyUDhLK2Nt?=
 =?utf-8?B?bityT1FaZGh1R3RiaXRTZ2JjRjdPcEQyTnRLWllIMGcxUit5UkdHbGdoQnNq?=
 =?utf-8?Q?DACg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVQc0tlSXZJYXFZUGViYXViOC9UY3BoelA1QjM5cnBXd0doSHdUU1RCYXpM?=
 =?utf-8?B?QkdweDV1QVVoSU1UclJhbklmSlBpdHV0SWNvWjZjaVFzSDQzVTNGZzBEZnkv?=
 =?utf-8?B?RThSMzc3UEdqM1Izckg5Vk0xWFJSYVJtV21heGJDNHNWWVEvVzhsREQyUHgw?=
 =?utf-8?B?bXdaQU5Vb0crMEJUT00rczFESitRaW9idzdYc3lwajZLVkp6dWszTzlRRGNo?=
 =?utf-8?B?MUp3dWgybncwejhpYmZ3bmhXYVQwcHdzbFhicnJFeHZlRERwQ2VjZytzUWdQ?=
 =?utf-8?B?emRUNUgyOC8rclBHTUVReThVSkg2TlJPVkpEMVpobytETXlaQUNLWEVkU1dS?=
 =?utf-8?B?UnI1U090K3NVUkQ5UHFBYWNMSW1qV1AyZmYzS1RnaFNVa2phNk8wNWNuZDFh?=
 =?utf-8?B?R25mRzVRN1FwemJQYnBVUUhGSis3RXlidVptYytNckhra3JKRm5FK0hUSVVQ?=
 =?utf-8?B?YUtoVmVOY2hPRS9YSjh1V3UwNmxMWU14VXdhSTZFNDlpMEppdW5HRVRwQW11?=
 =?utf-8?B?REF0SVVLUkw4U0ozRnFuSmI4WldNZlM3Z1RWTk44Q1hNczBQSDRmMzlVZDNG?=
 =?utf-8?B?NDhaREpIY3NhNmZwVnM5ckV5RWYxbEs5L05ZWHJCMSthbHNQUVM5TUJmUjFp?=
 =?utf-8?B?UGpWYWlBUkZuelQ3SEZVNU5wQ3ozRTUwcjl0RmFLaFpBSnVVVkhBWWdDMFdM?=
 =?utf-8?B?bVBjR01NWmc2OXFjNHdHOVJYWCtWMTVNOEs3S1RxTlBtQkczUDhNNENYV2U0?=
 =?utf-8?B?bjdnbk50WlZNZzdDdmV6aFl0ak9pbXdteVIvSDBsQWs0RnBLbGV2a0sxSTFI?=
 =?utf-8?B?MFR4QkdrNWd5YWl5Y1FVSVh4M2tBelIxdUVLMmUvcHZGRU9sTnRsSHJsMFNI?=
 =?utf-8?B?WU5PdlpMS1VPbXRvOWVESVk5bmFscS9RdllsblcySHV6dDJVbm5UMXdPemFw?=
 =?utf-8?B?Q0RML3VtdGdxOHovUkRqNjZVU0Y3UVRFVU04RnVzMGtRZXdZeFhKLzRUR0xi?=
 =?utf-8?B?Q0RkYWNadU5FU3RjL0N5WjJoYWNBU2ZmTm1WYk1rY0Q3aVpvNFJ4WFF1c2d4?=
 =?utf-8?B?MXFrUXNNWWFPanhUME5FTG1MUk1ZMnpNbW0rTE9BRVhyWkMxUHg3SFZNWmFs?=
 =?utf-8?B?OWpBTGpTck4wNUp2d2huTFA5citGN2JVY2VVV2RmTDkzZHRJZnBEWGs5d29u?=
 =?utf-8?B?ZGpUZkJaODdZbVBRT0VhMFd6dXRHdzhCT2dJa0RSWUdxNnVUclp5V3g1ellk?=
 =?utf-8?B?U3d0b1VaNGZTcjBZbzhLdkxwTmYrTmkyM2FBVGswcWZMS2JrU3dQeC9OWjN1?=
 =?utf-8?B?cXFwTGJnbDBXQVVvdjZkTHVtOUMzQnQwREtucVkxK1pkQmsyZm95SnE3WThV?=
 =?utf-8?B?cEo2YmdNOXk4WVR2TXdnWVJSTlluK0hOZHlHTFRKNkpQWXBURkkrWkdudk5p?=
 =?utf-8?B?V0Y3YVQrZkllRXFZVDA4T0dkdldvandRZjZqTXpzc0JDR3lTYkdQNVpIcldY?=
 =?utf-8?B?OWg0WGowcnQxaFhheEF2T1libzF3ODhLWjFjOW9EeDlwZmtQR1NpT0lsdUFx?=
 =?utf-8?B?VVhoekprL0NTOHFUWmtZb21YSzgxajdrTWpYQkVlWW5yN0todG5FM2g5ZllH?=
 =?utf-8?B?M21rMTJBWWZJSUwrVW56VEZWeXRyQ3NMRklJa0JKenpHeVBvSE02S0pwa29M?=
 =?utf-8?B?dEEzbFZNZVdEMEpoUzk2Wi9weXRiTjFpSzJydURYL0RaRkVhOU9ieGh6ZlRK?=
 =?utf-8?B?WEZsdGpiYkRFRW5HMm5VdmRKODZMbkkvR2Z6eHVaQ3p4RHRTUEJYVXYrQmxK?=
 =?utf-8?B?Rm1xSlA3NnkrWE9QUmZsTVBQQUhkSzFUa0c2eCtkbEpKNFQ5dEhBUzQ1UlY4?=
 =?utf-8?B?dFcvMGx0VWVBWS9GREZqdkFQVnBKRVFJdzJMVHRJQ2RlcWthYVdwSS9leTQ1?=
 =?utf-8?B?aGxMVkYyNEt1R0xZcVF2VnkyY1dNc05VMFB0N3J0TnQ0S3laU3NCSHFYdEZs?=
 =?utf-8?B?M2psTEFITzV5SVlpZ2FVNTg1Ui82dzJPdEhNRDU2WU9aR1B2Q1ZPOVZNU0pt?=
 =?utf-8?B?RU1UVllhQktGQ0M4ZC9yQzNDdmszMmVMUVVDdkwvZVVQVFdBZE9FK1UzZ0U4?=
 =?utf-8?B?NWFPOGs1UFFheXNSZEVaN2NhMlI4WlB1aDhhRXJqcnNrS3ZvZlpaRUNMVDVt?=
 =?utf-8?B?QkxkZEZQeVdlTG9lRzZUbHZmYmQ3dkJBSkxudlBTNjlVWnV2WkZuODEzQjZ4?=
 =?utf-8?B?Z3EwVWVUZ0wvZmhTYXhFZWFqRG90RXUvOTA1dGxXd1pXNzN0NEVnRmlxS21J?=
 =?utf-8?B?eFpkS1A1cEFGU1c4YkdiNTBaUUtPQ21lMWpyWmtjOEx2NXhBV0ZoZnNVR0xy?=
 =?utf-8?Q?OGs+eM0P0Mg8Y7vRYC5cX5Zkeu18qcBdxv6xR?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b0e72-37a2-4049-04c3-08de58d9e65a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:43:23.0681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEKcq/tRqIawLGDQhmrQSIo4TIWH/xWHqPxT8ppPf8LVB1xZ7BTzD3K28Zw3AtmEIuQ38jP8RD7ZK2BTtawEKLnZS/yYpYrgmUN87i82X7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
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

Hi Tom,

On 1/20/26 9:11 PM, Tom Rini wrote:
> We have a long block about the expectations and feedback about a patch
> applying, or not, as part of the Custodian workflow. Move this to the
> Custodians section from the Workflow of a custodian section.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
