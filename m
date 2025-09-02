Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14167CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 07:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D8A83280;
	Tue,  2 Sep 2025 09:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BvraqkmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AAC5839A7; Tue,  2 Sep 2025 09:53:09 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F9B83253
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 09:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFjjIGrWBGqtFwgpTMpSbRdAInkMTj1Tw8S06jg/7O62KR5lKhguGJHmVXqqkiNYQyLLm0rzGFKFUkB8D4ajgU2wy69wGqZc1wYmEktobh3DAok7gBt5Ezo5I6XNv41YA4vz1aajwtuAmiM5WqNXXUrNy2TWJvPWNEI2PUesS9Lon0vLRaqWLUC5eD8nfVWlaRqGLBfOp94RitwPVFNWFg4FrDUr07GTbHUsWQ8YtsIos5Q4nnlVvNl/GcOAjyH2CNWXZbP5fpPmczyRcroYTofi52hj2wWlRlXQOjsLerASrL//Z310vetIXnjYPFUUFAVR7qNnnIcGnreKSpswsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcLJL0EpULClJvVLqBdInERh/YExJ5zodQ1xMxfmQsE=;
 b=MVMx2XSg+0F78vy+QfXsT8376c4iqjgGtypNPxoj86VbggaDadKXOkHurpnUyUpy4vu9LFwOjxJ1KiVG6+VHPebvrSCTkpvAY3Z7BixqseJJ2gVcl48HIspPZwU0Zqhs9OfjxY78D6qxKbo1EAzAWYC5guPCgxpMtinpCBXbbGiD6vUY1LUXsJ9zm2mgsNecm3F8U2TDV0F6hQC3hlnJwrBUPUr8qjcYwQy7zumomm/lGXGiK4vVQiPTqLvmTgA8GHsNBFyBp+t4EZafa4vaKg1QFIc3Ya96qEO1rmMSkdij8QxCEpK87VXEkoowj6vGKudtkB47EuLmyjJ9j0wLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcLJL0EpULClJvVLqBdInERh/YExJ5zodQ1xMxfmQsE=;
 b=BvraqkmB96/tR81HvB6ffLSVeJjKUk7LelkD8tJ5v0UXdZNl/7N1KVpoi+CeY11zZJISyTjgciTA/f5RGUmPbd2SizcvZXaRA6r6SCW4PyNUsxB10bxkX+QdRVLYm3XOmuFUtnZyvB1qNDjsLyC8CW1Wg2gWKE3d6p6Ag5nkG6ps1rrr13zdVcUohqBCuFawFYjUCvI5NxJgycKtGwOcEhPySvoGJP2TP3BcPGPr9K4PKPmnvX/Us7JvRzsoBCVkFRO/moqzc7b9a3DCsSdpJ633enXuPe/fu7JwAKhZAtN16G7K8GX9LC+E6mkICYsOqwSm8Iy+UiOJ2NJnFeZb3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SJ0PR03MB7024.namprd03.prod.outlook.com (2603:10b6:a03:433::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 07:53:04 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 07:53:03 +0000
Message-ID: <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
Date: Tue, 2 Sep 2025 13:22:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
 <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SJ0PR03MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: e616b9a3-4782-4afc-cd9a-08dde9f5beb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3M1OEUwZDh5cm5XcVBhc3diWThjeVlnMS9tUkxUUDJlR1pwbHlwSG13Qmg3?=
 =?utf-8?B?Wkc1RDJmRFZXUXN1VExLSUQzWGVLR05wZTY5dFAzS1Bvb0VVd0xlTFVWN3Jz?=
 =?utf-8?B?UnVmTHF5bUNTUGJxSlVBRllkUlRLakZHYmpHQVNSaktzV1MxNysvWHphSGth?=
 =?utf-8?B?YnhlRHpKVEJpTWI3d2w0RnhHcWxuMWJ0Q3l2Tk1FYmVITHJBWFJocEtoR1Bs?=
 =?utf-8?B?d21veEZHaVVTQUo3REo3dEFTWXFYQVAzeG0wNUFSTFdKaU5QdTU4MXNYamQv?=
 =?utf-8?B?c1NrZjY3NDlpYnhlU00vL0JUTnRTaUsxSHlkVXA2UWhiMGZiR1JwYXYyTDNX?=
 =?utf-8?B?R214NTFMOW5Gam5nTml1L3hTV1FzTzhYeHZYV1plUHlEUlhkTXdxZU15WmY2?=
 =?utf-8?B?SHc2aDBiN2p4YURIQjcvNGs0UEdjdEhQKzhDTFBaWTlaTUwrSkp5TWhQaWNB?=
 =?utf-8?B?SHQ4QUVpSjFwdVAycjlJalYrajZEK1VuVFZ3eEprYk1za0pyMHJHQkRLVGU3?=
 =?utf-8?B?WU5vS3ArUnBOOFlYYXl6NHkrcno0d1Z2WU1Od3c4SnhpNzhTMmlQV0tHQ0V5?=
 =?utf-8?B?ZzFiMlVyS3lOSHd3SDRwdElnbFE0eDI1RkVVc2M5dzdTbXh1VEhKMWZJanQz?=
 =?utf-8?B?RGFLTWpOVGFFbGdWWHk4cWd4am0xbGFwVFpHWjVQQVhCWTIwc25CeUE1Q3JH?=
 =?utf-8?B?b2w3am9wbmRkdzUvS3dzM0VocXluM0lkVlFmV29NY0NEV0tDcXJQd21WN0s1?=
 =?utf-8?B?Ym9SblJlNFY0amhuRlBLejY0SjlRaXFrQmcva21LV0ZoVkJNOHFISjJsT0VE?=
 =?utf-8?B?NXhIL3FXVThyRGJwbTF6YUhTdjZBRVdoTVRDOHk3cEt2VENRQ2RyQ1E2K0c3?=
 =?utf-8?B?K2t2MTg2ZGV2b0p5UHZILzhJUFBtZ1k1Wnd6RTkvc0NLbEllU0hMbUFCbVZY?=
 =?utf-8?B?RnpCRVUyc1FJYjRJdm5hQnUrMHlLWWFsM2RMbWllR1JzM3lQemR6TmthdXRu?=
 =?utf-8?B?YWJVZ29tQkcrN29qZjN6SUlENVllYzRaMlZ5RzcwMFEzMjVpcm83UVA4Y3JC?=
 =?utf-8?B?ZWs0aURHbUg4Q1dra3RZTFFsNkE0dDQ4eGw3U25UdWdSaWoyTS9aYmFFYVRN?=
 =?utf-8?B?QUJOazd2ZUQ4L2FVdGRjeHF4U3djTnBHM1JYMk9aRU9CemJxeERPVUtueUpo?=
 =?utf-8?B?OS9QM0k2eFc0dU9HK2V2b3owSGNlcHM3a0hBc2NFblRidWhTbXppWFlEOXl0?=
 =?utf-8?B?TVdCTVQ3bDJmdHB1eHdQVStWRVhmMTU1YnQzSmVGMzZ1alBuS0dGMHg5TmJZ?=
 =?utf-8?B?V1JNaXN0bEY5eDhMYjZ1RkRUVXNMNnc5NExyb0ZkNEJDUnRtTjV5Q2NSQWhk?=
 =?utf-8?B?WFprY2FuN1pxa0FCNXlzcHFVWGZ5U3JJME9uY2lKbUJ1S3N3dG01SFlSbEpV?=
 =?utf-8?B?OS9helVhTWdyTkcwdk1WYUhzNWMzWkFPc1NPQVoza3E0Y2NkUlorbmtQNFVo?=
 =?utf-8?B?NDNTM2ZJcFRGU1B5WHZvTUM4L3dGUmF0b0RNeHhIY24wOHVTaUd0a1hjT0c5?=
 =?utf-8?B?YzdUSkEyWFBEakc3NGtIZ1pTR3pVTTMva2lDLzh0OFJHbUNQRUp4a24zODMz?=
 =?utf-8?B?SDI0SEloc2dNZ3FxL0JoZ2ZCeWwxRFhjQ3lYRzhUQXVCUmU5VTVNb1hRaFJ1?=
 =?utf-8?B?QkVXdjVXT0FQaXBIUUJ1WGVkSisxOUJ0RHRSaDFFWWh5YWdYdldIckxCS1BD?=
 =?utf-8?B?aUEvTHJ4MXArZEU2aERwQm56ZDBTaE1KdllEKzFOcEhuQncwdVhuTll6S3lS?=
 =?utf-8?B?eXFXTml0aXdVTDVVb0Fld3IyczArQ0NiYUZMVS9BV1NXQS80RWhUUG9OWnh4?=
 =?utf-8?B?UWlyRGRCL0hYYnZNNjVjY3MxM0wrNjk2Yjl3dVhxWFBUc1BCZDlwQWU2bm1v?=
 =?utf-8?Q?Nhx9gdXj6Ak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1haVnJ4VlVlc3Vlaks2MHFJL0JKSW5tUVY3cW5WNkNYOUlrUmt2ZmNUT1Zw?=
 =?utf-8?B?UGxPUHFpb29VRnh3MGpMQzdIRzZURys5OStFZk9Kenc2MEkycTVWQ20ySXVY?=
 =?utf-8?B?bHdudkVTSDZQQXgwcUVpL2hBWkZVS1dua0U3YWZyak9oN3dpeEttL2N0TW5P?=
 =?utf-8?B?eFRmS3hNaGxHS09pSVdqeXhsZGJGa1U1WDg5cTFTWVBNcTgycWphUEVQWS9h?=
 =?utf-8?B?bkhqN2paYWlXUmhpZnd0bGJFOHlZRzdqY2M0ZEd6SzA4Ulczd2Evd1ZhYXpU?=
 =?utf-8?B?M1V0S1loSG5Gbm5RV29qeHRQUFRUK3Z2ZHJmeVQvdUphTXpmUy9JY3NQZ2Fl?=
 =?utf-8?B?WFQ0bklHWEtwWUs1STVHbVNHamJ4YkpZV0xtYW96QkZoWWZrU3Rxbm1JbkFr?=
 =?utf-8?B?M2hpazhTc3Mrb2c1VGRMbVVkVzZjMlhBOGpDQjNvZUVBc1phYVBSME5DTlQy?=
 =?utf-8?B?QnJYb1MxRkw2bHlxQ1M3OThLQmd3ajV0UE5PWWJhT1ZRaUlmc1pQK0tTclhq?=
 =?utf-8?B?S21TK0p5R21UU1Z1UUQ5QlVsVXIyQzBlcnNmRyszeEdLbFNXMjZ6d0RFeTVn?=
 =?utf-8?B?a2JHbWhvY0ZjeWxpLytaK0VhbGVjSmMvVVBVdm9kNmVUekVRMzVlZW1UV2ZQ?=
 =?utf-8?B?K3psU3BWT3pUMDF5SlFEVjhYQVZJSTd6YURzVHdURlkxYlppUzVyVUlUUEY4?=
 =?utf-8?B?NFFFVENwSUdWVmRVbjgySGgzTGlLWVhTTlhhcmJrNlVjQUg4TXBOenJ3YjM2?=
 =?utf-8?B?NXl1c3ViakNvUklaOEtBNjdVcWo2OEZsMlVaNkFmM0xLSHJ6TkN3NE0ycm9r?=
 =?utf-8?B?ZERyekh6LzhNNzlESmFtcmhYOFA4RTFqYTJsbVJHSm9RYUN4Ri90SytRM01j?=
 =?utf-8?B?c2kwRU53UUJkZ3FtS3hHOW5LUktPQ0dpU21jUHpsZDUvZVNEdmw5RzU3TDdy?=
 =?utf-8?B?TWtxbVJkdlljQTB4akZRa21QSDJYTnRqUVhGaFp4Zzd2azEvdEh4SU1GOFlT?=
 =?utf-8?B?VlRYR3pVU2JsM1V4OEVmVUNIQ0F5YVE4STczSTB5WllnYUdLUUlMb1NoTlAr?=
 =?utf-8?B?OFZBWnJpTWVQZ1hmWWZkOXdhZlJDMy9iS2Z6eVYyd1NKekFPcUtzZ3ZrbHJF?=
 =?utf-8?B?aDFLMmVYMXdlVnMraWJGVmF0NUNLZ3A0amh1NjQ1VGFFdU8xbUU0dGo4Qnlq?=
 =?utf-8?B?SnNlV1Z1N0pLVWd4U3h6aFl5NlB1bFo3ZFZhZnI5UEZTSXZ0STEzcC8wazU4?=
 =?utf-8?B?eUVtYW5ndkIxdC9yWUx4M2ZwbXRpWm95eThkZVFXK3hWYlZkZFZ4RXBJMFhw?=
 =?utf-8?B?UVh2eEUrclczTHQ1Q0wxbjJMR1JkM0NmNlN5K2NGZ2pCNXdGRitKR2NqVkFY?=
 =?utf-8?B?Q24vbVlsSWVvUmROK0Fka1dKbUhSTXhQWTkxdld1bGwyVU92QWpRdk9EU3Iv?=
 =?utf-8?B?Q0R5Q0R6czN4UGY3WVRYS2o4anVIQjZzVklncCswd2JpTDd0TFQzdytnR043?=
 =?utf-8?B?QVk1KzZ0MFpPU1RMM2NwQjlpTk5YQWkyb2JaNjlvQ1diVXVKcGVCN0VJbjM1?=
 =?utf-8?B?aGlGTnZNS0ZLRFBsSWdqWFNralpzUzlxQmxNS0xPOENiUWFmcDFMVVZYbGNG?=
 =?utf-8?B?TUM3ckVHWGVkdm13ai9BajVQVUZZVHN3cWxNV2dwNmozYTMzVjhudFp3WTVn?=
 =?utf-8?B?YTJod0R0M2tYTTdQYiszVGMxMkZvc2s2Nm5XRXRxNEd3MmpBZUNEajE3T1l3?=
 =?utf-8?B?WFdOMEQwelBOdVlrWVpMOFRyS1Y0NStVdjFicVd2N0hPU29zcGFkZ1hTbE9W?=
 =?utf-8?B?SnRaY0VWYTVjRjR4S1pnVTdnVFEzSzBUbHZHS2tqbU1BTU9ZNk0yN3JCNE5o?=
 =?utf-8?B?emdYWjRlcHJaSTJNWDJFdUpPcS9hTmpQR2F5RFFWbHl2ZDRmU3N5cGp3cjV3?=
 =?utf-8?B?YWg1bXhIWmpNeTF2SUJTcFVxcVFlc21DZWYxUWNLRjY4SWNjaTZubjJDdUg2?=
 =?utf-8?B?V3dtS3kxaUJvWGh1aVRsKzRCaUxxWUI1bUh6c0libGRMcWdXNTFITytXQzFE?=
 =?utf-8?B?QjdoQUttKzV6VVNNRFo0VVBNbVoySkgxdytrb1B4anBYdjNYSzRyRnVIaWUy?=
 =?utf-8?B?NElKalVSU0ZidGxGZFdMa2Y5S1RBLzNpa3Nta3Q2eFptQnFuV3RubGpYZUx6?=
 =?utf-8?Q?QsAdUCBtrvSNvTxUMvXHrY0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e616b9a3-4782-4afc-cd9a-08dde9f5beb7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:53:03.8877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7QPMTCOP9HM7kG9vrwgWjaNx7Vlw7c0gX9KAtDnNZHsTAO7Hci2JgZD/Buo1CxgMnEV7gYoyXJA68i2UlIElkqOGWv5oyPcbNJ1IoDW6JLvNnLOvmpe/a1AsxxBLQ+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7024
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



On 30-Aug-25 5:30 AM, Marek Vasut wrote:
> 
> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>> Hi Marek
>>
>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>
>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>> Some USB devices need more time to be initialized. Hence,
>>>> increasing the default USB Hub debounce timeout value for
>>>> devices to be discovered, connected to Agilex5 boards.
>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>
>>> Which devices are those, include that in the commit message.
>>
>> Yes, timeout is related to USB connect/disconnect signal bounces not
>> about bus stability during init.
>>
>> Issue was mainly observed with legacy flash drives. Maybe I will change
>> commit text from "Some USB devices need more time to be initialized..."
>> to "Some old USB flash drives need more time to be initialized during
>> connect or disconnect events ..."?
>>
>> Note that I am not modifying the default Kconfig value in general;
>> change is only made for an SoCFPGA devkit we tested.
> Does this same issue go away if you set usb_pgood_delay to 2000 or
> higher too ?

No, changing USB HUB debounce timeout is working for us.

