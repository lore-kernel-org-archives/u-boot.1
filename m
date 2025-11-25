Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EA3CFD379
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AA383FBD;
	Tue, 25 Nov 2025 10:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="btwYZpmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CD483FC0; Tue, 25 Nov 2025 10:42:06 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013064.outbound.protection.outlook.com
 [52.101.83.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C2183F88
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qff84Q2ebsUpc6Mg7b0wpuzxYecfqTVsQRB25GJ4XT+vwJbCCktl1oYtBBHX/ijThVdBgWgsjp0ulEobXQ5XiNFqNK/fVLw8HzcL03TH5zHlmzeA9/6PmfG1vS+gF/uLZA4pS+wGHWgvfFh46+oak0oe+iRyMR4nCDcuyLWyvo2vBiodCUFuFrFzlEHELB1hOiQOAGac7G0cRbo/saZ1oZZgqZ4Oj7JT+3qvelHwHRGv5u+veGuXmMFOfUBwhlRYqVJ2Y7bUCL067Uj2y4shdWKnfsIApEhMevJgeDKcAhUcm9UROU0JQPAHihp/Ebmc76zsFSmnBOTcuyp3fTFstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaNtbbpm5wj403xZn8YPoDW3DnQYBaTLU3bOjbqLs7A=;
 b=qxSEeBZ/kVlUHi9liLiT0VvJOGxnZNYkbo1INHBDETXH6OlGrfcnGAuJ63t5wUFP7bfbhdgObQi9QEGBLHxpPMN4QNw4k9uzMvUUPUYnE4KaEn5fWZVGPh6xMEGIPAadojZMH2oT/LO04jGTWl2p68CvcbLWRyXgSSxJJeEFfDnErd8qqoC0nbap8q0MViyV6nIXeRWLhOzxPIUbSAlFPUZv4pGgfTP0epAWHWiZNfAp54VCAFyx0d66V9xXL+JPGHKR+icdoEUxPZIHIiwCff+FYPJElliIPkFlZhqailnPYAMvzYfZgJuTXr+f577aJHBGiaFTib70vR2jUmzyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaNtbbpm5wj403xZn8YPoDW3DnQYBaTLU3bOjbqLs7A=;
 b=btwYZpmDZAylN2Vx1gN/NJD+mAinmTkn4XcZ44IBY9nDg8dERprTZliwMo3qi7BkRNOEChaNk0bHtKtqtc5i+VH3X5KbyBYuSl+bL9EBvVw/sIaDLaIL7s3F9aJpmlzlRb97BiWP0fcviCEXQeIY3/LPleQRw85NlQo0+FFQOVJ5GGzTZm3Nr4o7EtyVJTAolaLnCyFSyh6QTUPG5/EY1eztDSTE9tXu9zyFOFP7lALF8eLnwBBqgdCi1IO/z1E5uL4mdTZEsdrTCX0bEio0ZYhGPex4N3fLzH+n+wcbTeDu+oQrHyAIndrpezQ9JF+0flty6zeduzyPeJe4C74fIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 09:41:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:41:43 +0000
Message-ID: <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
Date: Tue, 25 Nov 2025 10:41:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:610:4c::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 533bd086-edef-4466-5c4a-08de2c06d79c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEp4U0J5NllwQjZMaHp0ZkJBM3dVSkJNTEFLOFZ6dDR5bWpDRnI1NGFkQnA1?=
 =?utf-8?B?c29VUjVqSXhrOHpIYzIzNkpua3lPM0llVTJSNExDWU03bkZXV0RlTGNvS3VP?=
 =?utf-8?B?NGNTWVNUNXhRWXlkcitMU3hKMlZuc1Q2SUxxV3VyM2w1aGNSZ2cwZ2xMa1p1?=
 =?utf-8?B?ckx4UGwrS0lMTjJZRDJXalF3OVNxRWgwQW82QlczR2s2ZVpHaVh0dUl1ZEdW?=
 =?utf-8?B?WXpBSEhvb1ZFN1ZZdGs5OGIza3FSeUJKRHhCaFVmeUozaWlCcVcyYzNReVJH?=
 =?utf-8?B?MFplUFRhTFU0dnVFNFgwOW15KzBIL2FXMzQvYmxWcTdha2hiUTBKQXdJb3lP?=
 =?utf-8?B?K0hFY2tNWFpnejdBTzBLdndJWUZ2REVxdlMxWTQwM1ExQ05Fdzg3NmxKUW4v?=
 =?utf-8?B?SmFOMG02dFpqTExheERlRU5DVU96TkVHWGhxTThQbVFPN0kvcHVjN21lVnBj?=
 =?utf-8?B?K3VMTkZLd1dKVmpiYzUwSEwxT095bStNSVA2VGdFb25HY25kUmhzY0ZGdVEy?=
 =?utf-8?B?ZWJiSmRld0tETG1HUE53dUkrT3NWZ3hJcmU3MGpOeExkYXJBTEVOTHdhL3pQ?=
 =?utf-8?B?K0VvbWhHSGtwRmRCa0lNV3dhcWlQMHphOWprcVp6YVV1NTJSSldNNzVQYnVh?=
 =?utf-8?B?ZUZGQk5rL2gyQk55N0dWYW1UaDBrMVh6MkpmZytTOVJhRDRnTURoS2l5azd4?=
 =?utf-8?B?SU9uUW56ZEVoaTdKcEcvOTNoelZzdWtwTnFpSDdsZEdhdC9hRUpTZG91eVJO?=
 =?utf-8?B?UnFJUDVvOTArWWVSeTJRNzY5anZvQWp3NW9XMWdrMFBTTG5nOUxKNGxwdmlF?=
 =?utf-8?B?UHAzMGxqK2Y4cURtcUdMaVl1SkU3bDZJSFR6S0JxUWdodklLOEQ0NTBZSlRr?=
 =?utf-8?B?cUtzQjJ2Qk5NTlFLaXZYVFZ0S1lzWnUraVNjSzc5R3F5dGoyaGNkamlVczR5?=
 =?utf-8?B?UjFGdjFhRTlZdXIzdmdWN3VtYVZwZXVHWHV4YlZHdTVRUDJ5YnVSVHBndzJF?=
 =?utf-8?B?SmdaTmJwdi94c2pBY0ZQRXRKanJzakdsUTNTUS9ybGtaSWI4c2p5dWdNVnBu?=
 =?utf-8?B?WmZxT0lnZXhWOWVwM2E1L3NIejc1b0tybkhDQVBrbVBsaWJEOThnMUlUNTBl?=
 =?utf-8?B?ZzV6MlR4RmIrMExLNmhaNWJzY1VGSVBPaWJvakxkVDJiZzNkVStybTc4RzJX?=
 =?utf-8?B?b3k2VS9jeFMxcDEweUpkVkI1NTl6R01Cd2N0NzAvQXUwTkgvSE9rTjZLd3hz?=
 =?utf-8?B?Zlh5aE1lL3hxRTYydjltazY1RWdENFc1eDhmTWduL1d2MURrVXl5d2NjaE1F?=
 =?utf-8?B?L21JYytDdy9LZjlBa04zNlRoMEM4Q21YM0RHb2Rtd1Z5anZobUFWR3QwREhF?=
 =?utf-8?B?ZEV3MzJ1UlVxOXhaekUwS0E5TG5QeklpVG1EUnhkalNYT1k5NGlRWXhsT2g5?=
 =?utf-8?B?V3V1L3ZYZXhmaXlBeCtJQ2c2VXdsZ3BTbCs5NTU4TWo4cjJxUmpvT3VmdVRp?=
 =?utf-8?B?YVpWSWdRd3dyNkh3eXJyVWVZYkJHSTEySUhoSzFuVW0xbDNHSG1kajdXRmp2?=
 =?utf-8?B?ejJabnpvWFgyaXhYLzU1Tmw2eFBCVzVZandCTWhGdzdJcXBGZEQ0MER3QUpH?=
 =?utf-8?B?cnlCbWRZMStJb1BUZlU2aVVoaHlReUxDTTdGYkRUR2N5UEl1QnhGWHpDdlQ1?=
 =?utf-8?B?dHBNbzZPQnAzZ2U5SmUvSEc1UmxPY2l6STRjUktJNDZqMkRoUFJRazlMbWdB?=
 =?utf-8?B?T2dZVzZvVDJFWW5VbFFSeUVMQ1F2T0FaVHVFSzZjLzZOSTliWEprM1Z5Sk05?=
 =?utf-8?B?KzBZZWQ4STIzQ1BHdUtHRytLRTNIYUxVMWJnZjBuWWtpOGNzMlQ3RjZpZWNj?=
 =?utf-8?B?YjZnajJiZVExTncvcHlUR2JRUEkxemRnZnZteWpvR0hpTEYySk56ZStmUzVF?=
 =?utf-8?Q?jY04DK3VDwXNprz/g9hvDEuwxohY+DQM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3djRGFNMzN5WFdTMzZNRWlLSW9UZlhwbS9Mdk5GbGVzMDc5dTBoWW9yTUdo?=
 =?utf-8?B?RlFSU3MvSVJuQk5PdzA3aDRFbWt1N0k2ai9FeDR6VCtQdHBzSE5ndnZhVmVU?=
 =?utf-8?B?eWQ4QUYzT0p6NWlhRlRJVG5Lak9PamV2bUI1dkxhWW1iQTlBVWNwdVBoSktw?=
 =?utf-8?B?Qlo1aGhSVzl4dm9adlUxdFBoclFMK0JjRVA1NmZlNElvZlFIRVRBSDlNZU9t?=
 =?utf-8?B?NzZBb3NacjY2VVFWSEVFZjNwakFNK1Q4U0swUWYwSU9wbE4yRERrMjhyUGlT?=
 =?utf-8?B?c0xqZExlM2M1enRveGVUazE4UVZQeGxNeXpKYnBkN3JYam1sRTlGZ0J2OXUv?=
 =?utf-8?B?dVJqNkk0V0ZrbEpILzAzUE1oMWJkK0NzS3J3akttd1RWdkRwaXpZT1o1N3N6?=
 =?utf-8?B?NGlDa0Y2MXZEOFg2Q0gySGdrSXhKZjYzSUNjb2N1dXJvYzROVWNRZ3VUSG96?=
 =?utf-8?B?U2t4OHdGVDdjRHNnSnBZb1dkMElGRVNDSkhNeW9XYlJRQUpPTWVSNHBmZEsw?=
 =?utf-8?B?N0hjY0NRZW5ER1VjVHRCaW1VSEJVVzB2cmdHNmllNCtYSTVFcitGR2x2dUJy?=
 =?utf-8?B?QmlMVWpjUG5TWktnT1ZPNUhmZlFiNlFMYndPdE9ZdHBSYlQ0TEkwd2FYSjFV?=
 =?utf-8?B?NU1kNEEvbGVhNVdSeStVK1FoQjIydjVhTnRhL0FCcnh6bjJGemt1R3VFQVlo?=
 =?utf-8?B?SWtYRHZtVHBEZlBxcWRRMmQwQ3c4bVVHalZFY0Y0dTVHblVvYnZnRCtEeUIz?=
 =?utf-8?B?cktHcW50aDF1ckJSSUlkTHUvVlBFQmQxdlg1U3RQdlhHa0hDekx4dnlsSmhG?=
 =?utf-8?B?L001cnlKQVN5VENmeVRIdEI3ZjBXNHV1S0NwbDJpNWZiUnl6S0tvRVJDSXFa?=
 =?utf-8?B?YlFVUUV1dm9pL3VSd0k4SGxxcUhuTjVXdXM2cG9sdUhyZk5Kb1l0cFZsL3Br?=
 =?utf-8?B?VGJ0anp5U002OXczN2MvNnh3RDlIR290c3FuRFlKZ3BoTDBoamZvK2M0OThZ?=
 =?utf-8?B?MDQvVWJHVlZweXZTenEyN094Ri9Xc0ZLWlc0Z0pnWjZDTnBtQlZxWDRxak5x?=
 =?utf-8?B?MjNwMXZQVU1IY2JVUkQ2eHBGd3FLMVpVdldTNkVBRVBJdEtRWHFhNHRVZ2xl?=
 =?utf-8?B?SlhsUThMYW9YZkZQSkREaDhUNGpzbUlLV1ExSklBL25SVlZMbS9YM1FWNVhh?=
 =?utf-8?B?ekgzbllESDF6cGZsS0pkcHMvMnRSQ01IMjhlS2I0U3dydXB6czQwNU9aQnZX?=
 =?utf-8?B?TkdIU0lzQWRGUFVRRXR2Y3NYTUNWZjI0K0lVOHBwcWpqWU1DR2R4bHF1dWFn?=
 =?utf-8?B?cUUySVl6Sm9HVnFEdVFmMzVYbVVSM0JDT3FOYnFvaldOM0svRzdnN0FzcVgw?=
 =?utf-8?B?NGJiNENkS1laMUMxK0dJMVlJNkFXOVhmR216bmxDSEFMMCtsbWpOVTNKREFM?=
 =?utf-8?B?QSt0cWEwZU43YVNmbGliQTNMYXloRGtaMkFiLy9FRWR5alVVenNWMlFhVG12?=
 =?utf-8?B?UmJhTGcwRmsreVhvMSt2S3ZLSUlLOWdmWkkwY1JmT0hmMjJ4djFtSUU5MWJJ?=
 =?utf-8?B?cU9vemRSU2RZeFpodEpObVV2YW9LT1BlaXA2dHl6RURYQmVvRCtRYmprWXZW?=
 =?utf-8?B?RnZxK1hMZGppekNNZ3l0eW1LeDRuUVRiUm1oenhyd1cwTm44ZnZzUTRCZGEz?=
 =?utf-8?B?R0kwc2E1bEt3cXhzbUtxemlCWEQrbVpLbWo0TVZJbEI3QkNXUDFGYUdxSzVU?=
 =?utf-8?B?NlZ0SHFUaFpVTzR3VkQrY2Rwc1h5bEJLVzQ0QVpiZGtlZG9qY1FJV1RaTjdv?=
 =?utf-8?B?WHk3cElGVEFucm5BWXhaVHBYSEd1T0pteXQvNXAwMEpQVUZpb2UxdE9aVVNJ?=
 =?utf-8?B?WlIzaWNQb0cwd3IzL09qUDlmNzFVOE53bXVCQmtiV282a3N4TzNzZkczM2hV?=
 =?utf-8?B?QU5JdWVSem1WLzVtQVk0RVdVRXJqdzdBank3b0k2NisxUG5kUmF1U0ZWU2xN?=
 =?utf-8?B?Vi9GaXhOTWMyMzMvbG92RXlRakQ5QlNDKzIrcmNVMG1FOG0veXVzVjlGNTRp?=
 =?utf-8?B?VEhSclB5WWo5aHFCWGMweld3SG9uWElFdHBOcC91RzhEbWRrbTlUazR6N3B2?=
 =?utf-8?B?cm8wVHVEclFFWGpTWVVJVitrN3BuNDFzZTFVWTkwd2drVDBKVlQ2SkRjWTBq?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533bd086-edef-4466-5c4a-08de2c06d79c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:41:43.2754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/53bOMR4DMtRz3whLohEafU87FuoWJ7dX5yOBxik6RYEaqjElA5sWXCr/Xr3VrskQQY2gvLkiTp82+X9tDZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6218
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

On 25.11.25 09:13, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> Enable support for FAT filesystem with SPL for CycloneV instead of raw
> mode.
> 
> Recent changes breaks CycloneV MMC boot from raw mode, and so we are taking
> this opportunity to migrate MMC boot mode to FAT as smaller OCRAM size is
> required, as well as aligning MMC boot flow with our other devices.
> 
> Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")
> 
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  configs/socfpga_cyclone5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index 2bec82b0625..2b2435a27bb 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>  CONFIG_SPL_STACK=0x0
>  CONFIG_SPL_TEXT_BASE=0xFFFF0000
>  CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
> +CONFIG_SPL_FS_FAT=y
>  CONFIG_TIMESTAMP=y
>  CONFIG_FIT=y
>  CONFIG_DISTRO_DEFAULTS=y
> @@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=y
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_HAVE_INIT_STACK=y
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>  CONFIG_SYS_MAXARGS=32

But what about other boards for the cycline5? If you want to switch,
switch them all. This looks half-backed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
