Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1797D3EE65
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6088397D;
	Thu, 22 Jan 2026 14:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="bRWNG0uN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA0983A6A; Thu, 22 Jan 2026 14:19:07 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F0C80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbZ3M+ZB7M9m8Pe9orr2WWAAbOPu/iyedlOATAWDaA1aLnA43O0Ylb+dhihSqfOLH6ST2ilkcyRGL+PWpHYmPuv1fanxUvlP2jWP78Ac1ckfTsJTQUtjpxgAM94jy7g/psoIlGxW+RbDfKqsquXtI5Y3mJVS+w16uSc0pNIJ3UWzPpwjMtIt4LADJ+zX3gu6jiEEDJ+iaIzJHj7S+ApDzRXjtmW3H608ntGjgFCAMpRKVmkF9DoVbO7etMrLjzlEDx4FFolJabeS7k3zCh1j2tMHSMNZJf8nKNVpvMWoZqIAeS00sCPosDFp4RHwazgZLREBzvMR8g+G/NdYPeqpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2za/WzoCAH3o9zgXzOpjFfUGFtwXXa/e9Ge/YtibuI=;
 b=WF0fo7wdZpO54umP+KqcKq7Y9v6WxxJYQCZ6RqLEKvnMN96/bjBGheY3ht9fLfHlCsx8raRTuQMy5uB8D4WxAAfAUnkNIgnJ8oPDgvqNPOLoPhp0+6UCJYGw55yz/ykSKYGsYwvk+9HJk/aV/spQUKtWEGtvcqqvAoegcJW+kbbY+OyX3nGmoAduCC3BRyCIOBAXgb4I8PmzFIhsf7CT9q6NFB4ohzlHDs9fOfd2ATNinwYqLOfiS9Tboo12PZuu+7kmPy+8KpFmI8FSKa1p1zlrvs7w2Fwlrtb7rdPTplFSsnXuqrSrN7LEJtsJVmiYg2iNCtVhKToSPxDACRY8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2za/WzoCAH3o9zgXzOpjFfUGFtwXXa/e9Ge/YtibuI=;
 b=bRWNG0uNpD9lXTZGs3YoAbAUfW0dvV8z7lrlwDUC4vV/zS298Oo9+wrJBzuYyBmCeol3F8fpYA5cxIMGZF+ESu6aPeyLi5JIu1j5jrB1F3OXSTxbh695UrDEVeb35vMmuy3Ethihh3gVinYQeqZVlYl82QIBGlBt66AgbxOF5n2nlyCntDU86DWFW/XLGN+s5M9O215/YPf9s9/j6V01iM8tIpH5J3HhqXlIQiVs/Gu+3VDsACXekkHvIC9CbOCSqVAXd4c3C6hnRF3UgJrHwfHtHLKpMOaq7ASC8l66INGujCfyQq+xFFSpkKVBVSphhWuiYcuffKymT9ZdxmyLqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by GV1PR06MB8388.eurprd06.prod.outlook.com (2603:10a6:150:23::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:18:59 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 13:18:59 +0000
Message-ID: <a7acf012-bc74-4503-a141-a73d02617bab@vaisala.com>
Date: Thu, 22 Jan 2026 15:19:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] imx93_qsb: Enable AHAB_BOOT by default
To: Ye Li <ye.li@oss.nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, uboot-imx@nxp.com, vesa.jaaskelainen@vaisala.com
References: <20260121163358.21322-1-niko.mauno@vaisala.com>
 <20260121163358.21322-2-niko.mauno@vaisala.com>
 <ae96d38e-4e50-48cd-8c2f-71cc359bcbf0@oss.nxp.com>
Content-Language: en-US
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <ae96d38e-4e50-48cd-8c2f-71cc359bcbf0@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::22) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|GV1PR06MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 027f62db-c973-4d96-f42d-08de59b8cd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTdSLzZ0cldpWTgwMERlb2poeXU5Qy8rT04zN1NadnBGS21RMVVPdkJ1a0NS?=
 =?utf-8?B?KzdRL1h4d2xVSGg2SHZIMFdHVEVjTTBBdzdEVHBIWlZTUmNXMjdhcUovV0xO?=
 =?utf-8?B?V05vdEgrYStxM3BMVFZlNEVQbEZ2R0tXTnNTV3JpN285Z0k4aGx4K0NWS2Y5?=
 =?utf-8?B?aWNLU1haTlRYWXNMcFdYanRUWU5QNnFHZmpsNDd2QzRaUjJqNFY0SnE2U1RF?=
 =?utf-8?B?ZnNSNW9lc21DMUtuU0wyL25HdlZ1WE9JVFE2NThvL0hadG1pSEVhWTdBMTlN?=
 =?utf-8?B?T0Z3Tm05Y2FhR2Jjb0tIaDdKSTQxSk5sVnBjNGV3WjBQVGdqa3V5T0lpSTln?=
 =?utf-8?B?SU9yMExhamcwVU85RGVEWk5ZeUFYTzhDOXJiVVhiZFVCVjRpZTFhRXZNLzAy?=
 =?utf-8?B?Rm1qTTNwMmZtMTA2SmdsTUgxeUdsenlyelgxSkFFZExCVmJ5VVJ0Y2crd3F6?=
 =?utf-8?B?aEd0WFhBWjZuQkw3MG85anZadTJSY2dYdVFaM2xiWU5zVS9LSGQ0eXlXYWpu?=
 =?utf-8?B?dW00VFJGUmhnSkt0ZjdmTlN3U2ZSUmJyZnhEVGEwbmJLemZpaGkwdkV3cks4?=
 =?utf-8?B?R1RSMjgzZDZQUGg3bFdqaGEzQitjeFZIZ0xNK2hHZWdHT0JJY0liOW1FbGU2?=
 =?utf-8?B?eGw5bU9lL0JQTmJiWXNyRk9HYkF1OG5NSCs1Z2g4MDhuMWpydEZhblF4VFFX?=
 =?utf-8?B?UWhWOXVGY3dtZmE5QjBzQksxaEYyNHJxclBTQlRzNkFaM0ZQdnI2VUJPUk9M?=
 =?utf-8?B?UHpFdGlCWEtLdTVUdzhvY1I0bmVVOXltTWwzbGFrdU1lK3JZeTViNktsbjdR?=
 =?utf-8?B?ZE5JQTRyUUxCdDE2NCtEV2RlQjlaWHl6VEp6bE9BbWVEcVNBaFFMT2RzWnJ3?=
 =?utf-8?B?YjRyTkkyaG91R3dlR05xK21YUjNDS01lWXZlSDM5YWRQYUZvL3lnbjFmYVpy?=
 =?utf-8?B?NDlOU3pxejA4amhIbUwvRHhmbWYyVTd3dFV2N2xyMEdIZnVsYUZxUDlPUG45?=
 =?utf-8?B?dWdUdjM0WExXTHBtTnE5WDlacVVlQ1FOWW11YU5pbWhOdkIxQWJrUC9vWXEz?=
 =?utf-8?B?RTlQeTA2ODRFQkNGS1VHaEtKbXB2NXFtVVFhR3NPUkVmQ2FzSHpJMVBmOGV2?=
 =?utf-8?B?R1Y2cjFUeXVOeHFxNHZWUHdYSTlERitpclQxOGVmUDUzWTN4OUxIRWpqVnBL?=
 =?utf-8?B?RHRBSWhjSldaSzJtaFZaOXZQZ3NlOFo3UnVmaDlZT1hRdmJmOTJxcy96RkN6?=
 =?utf-8?B?U08zMnI3TzMwTHpTQituK2RQSlBLNS9JTHFEU0FUNVdLLzBxakFuWDhtaGs3?=
 =?utf-8?B?azQ4UWJaMDQxWG9ieE15eCsvYmN4bkR2RzVvSkdzcUJDM3BQaUcrdEMzRlh2?=
 =?utf-8?B?ZnpwSitwdk93bm56V1VndkRjZ0t5L1ZOWDJoajdGMW5HYmtTNmtBd1FWUk5p?=
 =?utf-8?B?UFh5TFdva0NlNWU4LzQyMWsyS04vTG5xbWZDelFrVWRVQVZKNnFmdEJvcHFI?=
 =?utf-8?B?dHZ0RVNUS1JNeHFWZE5uTWhLcjZDYXp5S2k0bnk2ekR2dStZZmkybms1ZUsr?=
 =?utf-8?B?RTcvYzZhMy9lWW43UFFsQlBDUnNUbG9UamVzVGV0M1lzOVlrczVOM2NzVFI5?=
 =?utf-8?B?UnJMalhEVFlOK1k2VGRGVE5EY1J1aTF4b2twNWJDNHZSTWd2U0NEK3U5bVV3?=
 =?utf-8?B?MVI0ZVVvYndET1RIdmhZc3cxT2ltcjBWQWNVU08za3JDQmRYZEJ6U1Z5VXZY?=
 =?utf-8?B?Vk9vOFZrazM2MzByVlF5YTZsMklDeDVySS9TbUdIYmVRZ1FYQXFWaTMwdk5Q?=
 =?utf-8?B?NDN5Y2dGczJjVzU3d1J4bkgrakQ3aW44VGxMWFcwQUtLenBFT21aNmhRaXR3?=
 =?utf-8?B?NDFBcDhYUkJwdy9HZ1QrcUJseFJrR3RuY1hVd3dPTDlhSEVnQlhqRFFoUXN3?=
 =?utf-8?B?ODdwNi9GYi9nTnJRdWdydnRxaWtDSENpOHdRUlR6cldnSDdjZVRsdnNjdXVh?=
 =?utf-8?B?ZnVRMUhmQjFJTWlrdzduK0s0Y2VhVVB3VExDZEFpWTJabEd1M2VVZVlRZExy?=
 =?utf-8?B?WG5pbTJmZUNoL3JxYldkVXBnNi9QLzNCOVRucVIvWUlDcEsvaW9lUTRmbUFU?=
 =?utf-8?Q?4+Pc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxPTUhOaHkyRDdWdkQ2YWN6b3MvakV2dytwNnZkVnNLdTZFcGdaNkhlQ3hQ?=
 =?utf-8?B?aGZyMjBkQjlsZWk5elpzZUx5QStWdjJYV2xLVllvQTV3TzVtQ25PWThTc1Zt?=
 =?utf-8?B?QUttSTJiTWVQYmdYSEFuRkRXYlJRUi9NeDF2Q1N3ZmdWaUtsYmpKL0hPTlFp?=
 =?utf-8?B?eTRLVktFNG05OFFGbjlsYmlJMitlbGQyeDViMWVLVkRkVG9TUDlLd2tzdm1S?=
 =?utf-8?B?eHBmb0ltYnVLTEJUUGJsNjBqclY0MW0xNTlOV1g5cjAwbysycWJqVXhnK2Fs?=
 =?utf-8?B?RktOekdRa0lNVDd1OXZaMUVYbDJXTzRtQUlpNTBKenJWZGh5YUxKSDZMQ0Rk?=
 =?utf-8?B?Q2t6MmVWVVBoWEFuL1FUUGsyS1JGcWlYT29vMy9MYXZjVXdaTnAyVVdpS25o?=
 =?utf-8?B?Qzd2L1BaUFJTaFA4ZERPUHpPUGV2N1puYlBkV3IrdmVIYUt2RUlZcm1rS1kw?=
 =?utf-8?B?VFg3VURHdksrKzI5bkQyTDJyMkJwSzRKSkczQ2N1UmpMRG5iN0ZkTUphaDJZ?=
 =?utf-8?B?ZEhROWQ5WGg3T2RsbGtxZlJIWkVBMmxsRTNERkF0b0J6Vk4xWjM4d3o1V0hC?=
 =?utf-8?B?QWRHUHA0MDQ1cmlpSDN1UHZTVDdkRDhyZjlrVFBZd05FRytGMGd5OUM0T2Vo?=
 =?utf-8?B?ZFphOEJJZnZ6VmZyay9IWUdmeXBUSnp1cDZqdGdvemhGcGxVWTVCQkRYLzBl?=
 =?utf-8?B?QXZoY1RtbG5qRnVWUFZUNExvT3pIUDZzd3VSd0dIdFBseVRxRkY5V2ZmUERM?=
 =?utf-8?B?NGxNcmRZL3lmdWQ4L2E5d3ZNL3IvUjJKMUdQa2xYRklKM0VWNWtOK0pJeTVv?=
 =?utf-8?B?U3FXTFRpQjA4dHJVS3JuejVuMXBSeloxWE5pYkZhYlZkUkxMY21VZEUxb1pT?=
 =?utf-8?B?djhnTDVMZ204T3R5c0hzWDBlU0RuVmQ2MHE4cjVzbjVLL0Ria1kzVFRlUkk4?=
 =?utf-8?B?VXBsRkc2dmdSMFBWeXkyQmIwV1JsNVRXTFl6aVFmRkNGRzBlTUhrRXBwRnpo?=
 =?utf-8?B?cS85Y0hwZG52SWk5MGRnSDJ5UHlGYUtYZy92amFHTzN0Zi9JNUl6MjhMREpV?=
 =?utf-8?B?QTVHeTdwY3dWaUYxbjA5QWJVSHlQQWduYkZSL0xRcHp5dnY3OU5pTXdsdTlv?=
 =?utf-8?B?Q3dBOXpNSXJRUTR0N09oaCtBK3VtUnNQOUViclB6TEJSVHplZ2RlcXIxTUlt?=
 =?utf-8?B?L21DNHhOTjNNZ243QnBJMXkrVzBPSjRLZ1Q2UEFvYlFuNEFoUmVMMHZrQjIw?=
 =?utf-8?B?K2pkY0lVRFc1cVVzbkRYbjcxa1FFODB2cG96MW5uQ2JCQ2FVRFN0L09XUHNm?=
 =?utf-8?B?Smw2d1c3MVpueDM5eVdDYkQwb0c3aGJRRUdjMVZySExQcjFNR1RHOU5DSGlj?=
 =?utf-8?B?SmNoV0tkVXNmYlcra0ttRDdUQldSTWpWck8yUXhBVFRUKzJlMEJyZGtNellr?=
 =?utf-8?B?SVhyYjUxVFdiWUVuQldOMXo2V3h3NjZoOG1hUUs4OGxFNUhVR3Q5MEhBaGpC?=
 =?utf-8?B?QVdLUHRrUVFadWNHRmxrN0k1bnAzWk9VbmpmbzhwVzc5bFJJd3Q1Y0JBY09B?=
 =?utf-8?B?ckNyS3dQbHVNMjVKVzdRaC9NL1kzeU9PT0ZqSTMzYXBrVmNQTGtPUWVZU0VF?=
 =?utf-8?B?M210WWlZbHVYZUxzVzZJajR4ZWxJdEpwbjdrQVhSbmVOVzhTUVgrOTN2WTJD?=
 =?utf-8?B?dVcwUUFLcEE4ejVaNElPKzQ3TW5xa1NLQlNTNzlIV3FJQzV0LzVpemhmZUtV?=
 =?utf-8?B?Q2xNZGVobXpYa0dZWW5HMmFJTWZGMlNicTdqRHVaOG9zN2o0NzBUVSs5TWk0?=
 =?utf-8?B?VXd4Um85R0VzRXo5a1l2WEloc3ZNU3QyYjBDc3hpNEZnc0xNM1ppVnVwaUxt?=
 =?utf-8?B?Vzg3Qk9CSmdkaGtYNG1TNHkrSmtRYmhkV2V2c1dmUEJhaWhPSTZqc0dFUzFw?=
 =?utf-8?B?WThVQzVlNVZzbGlYNlRXdTA2UVR3T040SnRQWkNCdFlDWEFRN1dyUlhGTVM5?=
 =?utf-8?B?czM5K1hBRjFEc08xVDE3NlNCMVVvd3crN0I4dllUK0xyb0FPNCtac0ZsdFpk?=
 =?utf-8?B?RDdRb0l3Zmk0ZS83c0JaaHREaHhFYWkxM1drY2NBTUNSdEE4bWVoQ2hMSTFj?=
 =?utf-8?B?OUozeVkxaXVDSnNQWUVKZnBLbDlkWERlV2xSbmV6T3kyekxtaWJ3MUJWeEtO?=
 =?utf-8?B?TUhpaU9qcGZGRVFOMVhLaHBPQ1FONFNkK24vMktTQ0ltYzYwYndweGFwQkdH?=
 =?utf-8?B?SmYrdWFjOFVjV21IWnlXTFVRWVFKdW9TVkQ4YllQQ0FQc0ZPK21DOHB6YUF0?=
 =?utf-8?B?cEVBMERXdU54VTU4MzJDcm10M1FFVTdDNUNteDlaNVcxQ1VvMmxXMXN4STFC?=
 =?utf-8?Q?uyZu4cLduRSrHfyQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027f62db-c973-4d96-f42d-08de59b8cd6c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:18:58.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCbVVcTZe/kjkL01rdAr92oEOhSFiChj+mOiHpvdDTdJyWkMdkxZDJ08kAbqeSRcq56fm5YKaZ5xSohSeXAhsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB8388
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

On 1/22/26 3:33 AM, Ye Li wrote:
> 
> 
> On 1/22/2026 12:33 AM, niko.mauno@vaisala.com wrote:
>> [Some people who received this message don't often get email from niko.mauno@vaisala.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> From: Niko Mauno <niko.mauno@vaisala.com>
>>
>> Enable the support for AHAB secure boot.
>>
>> With this change, one can issue 'ahab_status' from U-Boot command line,
>> and see e.g. following kind of output:
>>
>>    Lifecycle: 0x00000008, OEM Open
>>
>>        0x0287eed6
>>        IPC = MU APD (0x2)
>>        CMD = ELE_OEM_CNTN_AUTH_REQ (0x87)
>>        IND = ELE_NO_AUTHENTICATION_FAILURE_IND (0xEE)
>>        STA = ELE_SUCCESS_IND (0xD6)
>>
> I don't agree to enable CONFIG_AHAB_BOOT by default. It is only for secure product for OEM closed LC and secure boot development in open.
> 
> Best regards,
> Ye Li>

Thank you, submitted v2 which contains only fix for imx93_qsb build error: https://lists.denx.de/pipermail/u-boot/2026-January/608341.html
-Niko
