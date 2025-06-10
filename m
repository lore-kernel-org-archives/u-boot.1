Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE25C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 06:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C1D8070C;
	Tue, 10 Jun 2025 08:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="opG+cG6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325EF80C83; Tue, 10 Jun 2025 08:48:59 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7910E805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDpHhyo9YWVJMJy2lUneKuqJNr1Lv2urD0Z7AEZGqB2GirDkybo+m4T8iSJ3/Dhm9sFgTeM6awWrQCvxaGACgV6bVCBqHzm1zZYrXiy1FV94lojbrwmF7R5/9uljNvAfznEiEXzFJCUdQA5dXtZFhrmkoCcvS+JB9ej7QXIIX1PKSLmdyp98JKMYqm1D+TPrOlstwjgbu08l4YomD6QmVwl1n52g3FnOuwEi0uVhDyiPAktwMweT8VKu9FQ8W53tQ8JiTG3gclRmUxiShxLt9jhw/a1QMKO3TpiTOKvjv8jPkPeYey57Bd4wZ+LSvpWuYMGMNymB2F2wYQuBPYrbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e9p6muPBUmVtn1rTmuEgPFp7/b9VEayZHnj9lC6Hfc=;
 b=XeHnwJLICphZdY6CW2krcqTQt9hEnFfKxmH8G9g9FukTMAY0IULLq0WLOtnl/5iCziEEH8FYTc/1XzO3O/GlRxRTqYwTh8ATP9XE0GZ2XPr2jLKoHEkIkoWOQvsFPZBIkG607MLk7H/Gcv/Q/QIsucQJsBfWsMf9xBtyEJWOFyJiEGTvsZ9+BFt703IUXnGtQEeVSLEEzJo8p/IXX+ntRBR8aW9pR+XN6+Bo1wi5fXzMRjOxngWuh0c4HGBUccNQn70G9a0rmymawQgU4aD/9jwUmvyLlvTNJY6CbchcFxU68vydU0myVDHxTJupj+7HGjyjp0bXK6sQY9osIyIjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e9p6muPBUmVtn1rTmuEgPFp7/b9VEayZHnj9lC6Hfc=;
 b=opG+cG6lRESUJYI073DCUt6E+nQp1Hpcl+JY81Gi67/2h0M4YON6e7IhswN1qAAZ2cWEZZmqDbw2EhC8AtB3lw/TCFHUnwEHXnl+MbeDM0SNvWDGxh4789SjIyYw3q712I1nfyvqeT07EGIWQiVlWbh3ncr0j4hc/aLKqBwR9esyLkFJPUSJpxb9nAsJUXC5GWXo+cZZ1QGXfl+MB6Hu18rjzxScnbpV7ANzD6Ztmfm7jjLUV8Cj6/itx35ZST1Nz8KFhBCMSFhoezhnJaesw56Mm6hASCn+54PR6rPzoF/zknaaYm2oS9t8WBKLW1q+eLklCpTqTBYXSjjXJmFylA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 06:48:53 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 06:48:51 +0000
Message-ID: <da6b44a3-a848-4b3f-b67e-09dba2e728e6@altera.com>
Date: Tue, 10 Jun 2025 12:18:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drivers: ddr: altera: Add valid RAM size check for
 arria10
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-3-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB8137377105E0819B9F6C6466A76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <LV8PR03MB8137377105E0819B9F6C6466A76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::16) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcaa057-d02d-4427-7211-08dda7eadbf1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjZQWEZOMXFsNG9VWUh0YWF1MDMwVlRtazNsQnlMRjExYzUxMldxOGQ4Qm52?=
 =?utf-8?B?OEZFcFdGdGRRM3RJWGwreTJhZzkrTTBUaytJcnExeDFmc3hkR1NGL2IwdnVl?=
 =?utf-8?B?eEpXN1VOeHM4SWR4ZEU0NjFyTXNoYWsvU0hRQktuSTdrek4xSDQwSEt5UHls?=
 =?utf-8?B?eHZSOHR4Kzcra3FkK2owVXJHcHEvTFBKWXRxbmowQU1zMnNIZnZOTDgrcTB6?=
 =?utf-8?B?aXB0UUJmWkZWOUlQeUNobFRZSEhVSkFLZnNpUFhaRjFSVzc3dGQzNFVXaEdk?=
 =?utf-8?B?QzBRbmd2STJzSm1SMWZzMENhOTZzV1NCRnZXN0tGMHFrTFZjWnZjN3I1UzVK?=
 =?utf-8?B?TEk4OTQyQm8vNFE0THhFTmRJUFAwOVhSZ3UyK3Q2UlUzSFYxL3F0blg5RjRa?=
 =?utf-8?B?RnlwTXRPVnV3cUhrL2Rndkh5aS9yRFoxQ1J2QkVDR0IwTngxU0g1T2gvN0RD?=
 =?utf-8?B?OU83Wkp3cXlucnF0QlFMNVpxb3hycXQ4Q2hSR25TWWhyUEUyUlIxeTJyQnpX?=
 =?utf-8?B?NVhaTHR6Z1kwS3ZNMVdlUnE4UmNuY1hoVmIvTG1KMHM4bzF5NmxpMXFmSUt6?=
 =?utf-8?B?WGVVeGw3amppZnNzOGZVL0xRcHgyZGJPREgzL3VlL29pb1dZczZTRHZ0VWdr?=
 =?utf-8?B?QTdxWCtNdnlEcjdsamhTV0M5cTJnRUJnZFRIQzZoQk1IQVduZVlvb2d2WmZU?=
 =?utf-8?B?M0JjZGNnK0kyYXREdnR6K3ViQm9nQkRuKyt6ZFNIUTc5TWJhcmh5NHpVUk90?=
 =?utf-8?B?RFBZV2tCRTBKd2hMckhwTjhVaDZzajkvZ3JrUmhreUJuSUZBR1dCSi9hSU9O?=
 =?utf-8?B?UHlFVE9PQ1VjSVZKUFhwVE5MN3lZVjhublZBekhRK1BkUHpHcWd2T0RBRU9K?=
 =?utf-8?B?K2k3dlZUY1AyMG43R21OS2ZvNk9ld0NCTEhTb3VxT1VVdjZzbmlBdldTeHhz?=
 =?utf-8?B?Z1VHUW5QYWlLUk8rSWFoQ1REaEh5VW9jYXFNdHRQTENqcEd5VTNXVGNCWlE4?=
 =?utf-8?B?RDJ6VjNNM0pVMjR4dTVId1h6dXhEeWZPc3VmTXpZYTZ0U3ZGblkvTDN5SnM0?=
 =?utf-8?B?d3NIMXpXTVJLcHFsN3o0aXR1ZXh4cUczbE5VVmoxZFREbmxhbG9sYU15MytD?=
 =?utf-8?B?NVNJRWlBbjJOTE00ellUbWkyYURKcEV4MU5NSFVGSGo4UXl2ZDZLVVNhSm4x?=
 =?utf-8?B?VUZNZDMrVjcyUzBJVzlUeDByb2ZKTG80UWgrbXNYaWc5bzVYMVBGWlMwak5m?=
 =?utf-8?B?ckxLNDVUeXdDZ2V1VGpUaUE4NEZ4UVFsUUNOUUUzS3lwd3cvSnBWMUxkUVRM?=
 =?utf-8?B?SUUvd1JIKzJjK2FHRytiL3kzM0RVUGRJdk5XZ0kvbG04MzJOMjdySk1xbVVR?=
 =?utf-8?B?TGswbGFPU3B2N0x5MmZyUDg3UjBYdUtSNUtaeGlOYVQ2K3N4WnNqd0JvQXov?=
 =?utf-8?B?OHd5WU9nSW9xdVdEWnJscGI5SGVUcjVXUHBXMURUcGwxU1Nsa21qbi9RVkpE?=
 =?utf-8?B?cXYzNno5NVFoNzZIZ0ppY2pUZDlCYUJTNzNjaU10Z29tcTFmM2EvREx4OVk3?=
 =?utf-8?B?RytLaGwvdXVMcjdVZGxCcUVNUVNLSWwyekd2a3ArSFNKZVRjNzRIVmlRTS9j?=
 =?utf-8?B?dUpNZERsMmljZytNdkxZNUc3NHdJLzJxWmhTQWR0VmlYc3dodW5tbk9KR1JC?=
 =?utf-8?B?T1NDdjByQzVHcloreEhpOGFuc3BJcUdGNU1qMFZ6YTRnOEh0cUtoNEFTdmda?=
 =?utf-8?B?blJFcGI0RHBHYXdRKzFWS1FvUnprNk9MS0xvenhTT0R2Y1R5T3dFcTFOc1Fz?=
 =?utf-8?B?T2pqM0g2RDB2dk94TDBXVGJOMU03b3gzVjYxUFJGWTd5KzAxZG90U1RCQm9T?=
 =?utf-8?B?NlpNVVIxRU9LSXlqTldGdWdNT0RjNkhXUGpwMHpXTGVZNW5wb2ZtbkJTUlB6?=
 =?utf-8?Q?VaBJ4m7Nohc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndwaFEyemIyL3l2S1FVVlVPR0hZTHpvZlJKdmF5Vkk2Ym9aWlkremZwdlVK?=
 =?utf-8?B?cGRSNytDWFdLKzlIRWpqMzdPMVM2USs4ZzlZVXhoYk41d1B0MjR5dy95S0FN?=
 =?utf-8?B?VlJBNTdqWTV3TnIzVGJVQi9GRlFzVkl3OEtudVYwOThKUG91RWZIS0gvc2RV?=
 =?utf-8?B?OXNYVjBiQmNHckZNQ0hCSnhqRkU5Snp2WUYzdE5ER2NKQzFBbU9KNTlEUnBz?=
 =?utf-8?B?ZEtNQkdENDYydmViZk9Zb0ZSUGhhUWFUQ1Nqc1VDSlQxN0FZMVBXR2ZFdTNh?=
 =?utf-8?B?eEtTc1dDTmllRjRaTDZZZGwvYUdIUlk1WnpzKy9pWVZZN0JRczR1c1k5eThP?=
 =?utf-8?B?MkFjQnJFRXZBdlRkbGk3Z09WM1V0TDRrMTZ4VmxPVnV4Yi9uaksvRXFicWg2?=
 =?utf-8?B?OUN2QWRPVytMVlFqTGlVTTB5WUFsSk5RWm1oTDlQbG0yUUQyV2NQK2xCOUxK?=
 =?utf-8?B?N0wxRmM2QkZuNzY3KzhkV1JDNkJsVkRpZUdTSmUwdXZLZk9sQnJXcGt3MHRV?=
 =?utf-8?B?T043OWxKeUJyUGVYbEtKb0E3SWNaZHRpa0Y4L2xiUTZ0SU9lQnJ0MVAxLy91?=
 =?utf-8?B?YlVSVFdqNDlpSWlTeCt5VlEyS3prZTJNanc2d1l2aUkvRE9Kem1ScS8xMExn?=
 =?utf-8?B?WXZkWWloWmpTY3RVWjcxcDB5VERTOGhNbW9ubjdwd3JmNEh0c0t2clpJdnZm?=
 =?utf-8?B?dVBIQTlYcCtXV0lSTG1sT1BVWkpGbGVTenp3R0c5TmVueE1hMXZpeGtneFBm?=
 =?utf-8?B?WUhaaFlvODQzOFEySVpPendpTEIwK1A5YlNvZC9hVGV5MGt6RUdaODBmdmtj?=
 =?utf-8?B?UitWV1drSHpkNXFoVXZQblVIaVJYNDhuU01QSFB1WHA3VE93VjNwQzRsZ0JF?=
 =?utf-8?B?RU1WWVNsTkF0YmVmakxpK2RzRnROS3NSNDR0TWh3SkRobU9HK0t2d0xKbW9L?=
 =?utf-8?B?dFRGWGdhbzE0Z29adEQ3TVV4WEluTUN3VGV0a3lKZ3k5eDJJNWNpT3UwZ1RO?=
 =?utf-8?B?cHVvSUdnR1NKbGRiWFArMWRudG1iS3lkS1hLajRta2JJcWJpOVB5NGMvek9J?=
 =?utf-8?B?Y3ZvUHBZVFpGaW43SStQNTV3ZTdlMHlFaEo3MnppNTc3MVh5WDcwL0krZTBK?=
 =?utf-8?B?Wm9qU0htR0kvT2Y1VHVIeW5pSm1iUzVPV1VaaDl3OTFWaHhZRUVQVnMwWXpm?=
 =?utf-8?B?SytHeVI0S2xHZE0zeUJVTjB4QlNWQVVIaTZtQ1dGelN2eldUbFVrSGpBRGxs?=
 =?utf-8?B?dTU5ZUptVzYvSFplMTM1WDlKVnRSd1VmWllJV2wyWERNMUtXVjh2L0pEN09u?=
 =?utf-8?B?aTBVdklVbDNHQllXOUsxM0dGeWtLWjVXaTlrQTY4RjlHWjluZWtuRzF3S2hG?=
 =?utf-8?B?YnIweUxXYzJSUHBvaDZjQzZXYU9ydnJ3bGhDYmtkcHcybVFCNGY0bzc0b3hB?=
 =?utf-8?B?VGJNcDFIMFIwMkgxL0dYOHd4OHNZNksrNlU5QWw1UXlLRDYyNjhNWGR6V25K?=
 =?utf-8?B?c3d4TElOSmNRb0FZSmErM1l3bVZJNFdJVjFCc3JJZDRpTHNOZE54K1hYQzB6?=
 =?utf-8?B?cUxCUFZjUkJ4bWpyOC9xRGs2UzVGMU9pUHlvT2laTkl0NEVEckJFTVMyWE5p?=
 =?utf-8?B?N0ZkRG56TTM1c1RCQzhFclA4aXAwa2NHVXRvc0EzZVplTVZSVGp4R2FXbFpR?=
 =?utf-8?B?L0FDTGk4SVBGczdRKzhDRmpDRHFMOXRtWmpiU2t6WEcvTVZKU3JOeGNkUVJq?=
 =?utf-8?B?N0xEa21aT0FkU21YUTFnTkVaaGE4OVliWjBYeVkzK2JRQzY1dTB5ekwra1dZ?=
 =?utf-8?B?aVMvSkFwc0hkVW9IQ25XaFh1aGh2M3I4OTFTUVdMODZ4WHdyL0dhejFndjRX?=
 =?utf-8?B?RGtWWWJHbXBZWlBVWWtkQ3hENlh3SzVCK0xnRGZoVFZkNXlRTXhZL010Qldr?=
 =?utf-8?B?Qmp2ZlpNSU5lb0ZZK0xlL1RpOVpPakwrbmdqbStlVFZ0ak5CaTFPSXNlcUM3?=
 =?utf-8?B?anl6b244TlNBQlFyZTdBeEoxNzhFNTlZb3BFRndiYXZ4RGJFL0R0dG1lQzJ3?=
 =?utf-8?B?V0c4TlhiZEpKL1F5ZmxRZ09vMWIwNEQrclBLRk1YWWk0WVZwMGQ3OXhObHFQ?=
 =?utf-8?B?aFAySEVHcVhza1RyMWo2eEcrd3drWkRwcm4rTVRGMk9tUmxTUGJHRzRUeTc2?=
 =?utf-8?Q?6Ww9xaizC3UcgO1c520eaao=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcaa057-d02d-4427-7211-08dda7eadbf1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:48:51.6150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LplZ+1B5yJq8nt5erzqrZ3Y/bFXXBiZ2OT+RzkhiN4E6KAMvrAvBdEq3LQlAE/hF/sZnNX41ol2BExgjjo3s7tR+GXmaYKJgKj2QDqOGo751nMpGk80cYAzPLKnTJY+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
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

Hi Tien Fong

On 06-Jun-25 11:58 AM, Chee, Tien Fong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Sent: Tuesday, June 3, 2025 7:55 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
>> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
>> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Subject: [PATCH v3 2/7] drivers: ddr: altera: Add valid RAM size check for
>> arria10
>>
>> Add call to get_ram_size() function to check memory range for valid RAM.
>>
>> Signed-off-by: Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com>
>> ---
>>   drivers/ddr/altera/sdram_arria10.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/ddr/altera/sdram_arria10.c
>> b/drivers/ddr/altera/sdram_arria10.c
>> index 088dc1cb33f..7d7bea153c8 100644
>> --- a/drivers/ddr/altera/sdram_arria10.c
>> +++ b/drivers/ddr/altera/sdram_arria10.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/delay.h>
>>   #include <linux/kernel.h>
>> +#include <hang.h>
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> @@ -668,6 +669,22 @@ static int of_sdram_firewall_setup(const void *blob)
>>   	return 0;
>>   }
>>
>> +static void sdram_size_check(void)
>> +{
>> +	phys_size_t ram_check = 0;
>> +
>> +	debug("DDR: Running SDRAM size sanity check\n");
>> +
>> +	ram_check = get_ram_size((long *)gd->bd->bi_dram[0].start,
>> +				 gd->bd->bi_dram[0].size);
>> +	if (ram_check != gd->bd->bi_dram[0].size) {
>> +		puts("DDR: SDRAM size check failed!\n");
>> +		hang();
>> +	}
>> +
>> +	debug("DDR: SDRAM size check passed!\n"); }
> 
> "}" should be located at new line below

I don't see this issue in submitted patch 
https://patchwork.ozlabs.org/project/uboot/patch/20250603115442.19971-3-nareshkumar.ravulapalli@altera.com/. 
Could you please check if your email client is wrapping the braces?

> 
>> +
>>   int ddr_calibration_sequence(void)
>>   {
>>   	schedule();
>> @@ -722,5 +739,7 @@ int ddr_calibration_sequence(void)
>>   	if (sdram_is_ecc_enabled())
>>   		sdram_init_ecc_bits(gd->ram_size);
>>
>> +	sdram_size_check();
>> +
>>   	return 0;
>>   }
>> --
>> 2.35.3

Kind Regards
Naresh

