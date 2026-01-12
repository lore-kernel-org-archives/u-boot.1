Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58498D25032
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 07:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9887683B85;
	Mon, 12 Jan 2026 08:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="U0OvTtgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7135C83BC9; Mon, 12 Jan 2026 08:31:42 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DBD83B0B
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf3AICfOFwhh2zMkegnDXe8vsD4jG7/UsAQEJ6z5UTAzI8SXa5lHr3CDzkWi0bj9IABTJChGxyEDtAiKOGpSX/6gglfC/lkr/1/hzCtU5ElqVSjYvZuZRaebHzNHDQT1p7UqbeUJbBSBJyhBPgOOz1cqguCOEadWVT8VllSCJ5yQRFAdww0VSKzVT+YWspFGxI5UD51iCmNk6gWZCkp7tUViQ285+HC06x7yn3hpbIsHADTBzePj0mAHfTvM4gaXTYhH5/HpTG1ZaNKqrPc9eUVsFQB71dnxYhU4P3U64VZ+CyXLFEm99XH4ZGUN3Yh7dITyuiRR7KCgMNt+nvaE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cojR3S26sYQr4cte2dKr87K3t7Ov35RarEzjxjt/tw=;
 b=KbJWUvwRz2c7wgiQ8+5HGmFw7bebI8ljEVM01NhrvifGoTvdbPeuQcUdMRv3wnR6/xWSmuxtyj66LDpNUa2aEFKpsFHfQKPwhuWy2NXwiI+kFz5Wb5ImkNWnwDT/cElNXXF4SXzZc3MBoAPY4dLaRLha18Dh4a4XwgWB1xEZ+mMRdz2fgrCmxzJ3l47OTmQnBLE1FiT7OHOacVGmCBRGDcIo0CTZGmbV54TBQEwHOhdFeZVlf+9QcvVerGUnkFupNSYj/ZhcGf8jr+Nu/3ORbJVQIbFlIP1s8CavOLFwAvHxEMpi6JbYbzi/uBZblRUCxZEmZ81O2PR3GEgDp552Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cojR3S26sYQr4cte2dKr87K3t7Ov35RarEzjxjt/tw=;
 b=U0OvTtgkwHqBe4oFs8JmRTJWbx3oz2oY/2AzzRM7djLmwOXYLSlfaYq30AB/hzKAffFHv7dO8axTDboPPTO7NIRD9oywdb2WkwgeN6cfNIaRzjNnlGpg3z8kML/pLQ9NC5+yAfSn9LJ/qm+AE4ufaBAmWt03U4fE/1scUIOIw7n/QuDe6J/DjaLbamagE+f1CzuXH2Zv/ZARUUXcZltZXnykgL6BPb9qBXypoOwSPQ0j3fUZ+qdrbpuNTUp6RgUqp6d5ZoRppMU4fgHogKRBwyYpAhe0fPs1XDKzI52RMu2KCJfU5JgHW9y3OGDOWs/VFwQWfs85hB32mAEWv3xHeA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB5982.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 07:31:38 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:31:38 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "d.schultz@phytec.de" <d.schultz@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "kishon@ti.com" <kishon@ti.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Topic: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Index: AQHcDf4Tk1i6NjlF406dY4By04l0srVPDveA
Date: Mon, 12 Jan 2026 07:31:37 +0000
Message-ID: <ca61411b69c1bfc3c9eedc0e30cbe2670788c888.camel@siemens.com>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
In-Reply-To: <20250815160240.3575140-1-d.schultz@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB5982:EE_
x-ms-office365-filtering-correlation-id: a315bb84-61cc-4d32-1c55-08de51ac9f3b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dG5wTUZhdG9BNG84cmVhaWF5RVpRRGlwYU5lUHhjdFloRTZFdFNnVHFORFpV?=
 =?utf-8?B?alJJaytDdDZwSzcxaU4rQ252dWlIbUFkbFg2S3hnQ2t6Vm95WjhxR2c3bTdz?=
 =?utf-8?B?aTNNajQ1TEJCZ0FIZ3dnbXg1QlRhWXNyUkNQUWNTdG1EVXFrTFQvZDBLSVIz?=
 =?utf-8?B?Y25lQU5LanVQaFNZenJvQUQvWUVPalBYME0zZHhNNUlaYkFCRHJUMDI2YS9Z?=
 =?utf-8?B?RDNqU1QvZXgvamI3dVlCZzIzaTZubk4vUmFNbE43M0lqQWVVREhGbjJVeHJu?=
 =?utf-8?B?TytGTkMvQ0x6ZTFHZjd1MXA1MnhOclBYWFhSTTkvZ25uNlpVVXd2ZysvbGxz?=
 =?utf-8?B?eWZOV1lCaW9tTDl4TXJMSkcyRFFIcnRRTmJBWHh4VFlQWlhUWDJpejRSb1Av?=
 =?utf-8?B?OFl5YVpCMWVOQ05TU0RGRTBNNDRQQUhIT2FtRGJjV1FoVFJ4TXJVNURhWCtq?=
 =?utf-8?B?Ylcybm14L3NvS3pqd0VnaExQNUNEN3J4ZkoyUDdNNk5tUGpPRzRWcUJaR1Jj?=
 =?utf-8?B?NTZyZEoxM0RvNWVVQUN5Q3Z5S1VFdXltSGdtZEV3RHk2Mm42NFBVZ3BlSkRm?=
 =?utf-8?B?S1NsQ29tU2ZJMG9URlB6NnplaCtRLzJBRGpRalNodU5XNnhGcE1QM0dnNDNj?=
 =?utf-8?B?RWJMRWVCdnJIeTlpSFdxVU9KaDF5YVdjaGlPeWFaQWZ1RENGcXpYU3lwZGNt?=
 =?utf-8?B?bWJLMVRyZEVnZTFhWmNWSWw3djNyazZWTlQ1dm9Vejh1WGVCcDJTVFVqRkk4?=
 =?utf-8?B?RG5SN3RrbnVFRzhJUXE5WHFUNzRlTW1pa1Noem1tdUZ0Z1pyOUNxZmRSUmpY?=
 =?utf-8?B?djlHVzdsZU04Uy9qeVMxNjFja00wMWFXYnloL1M1UWdJTU9PdWxPMk1wRGR3?=
 =?utf-8?B?Ym9xT2pMdkpQMEI5SUhWWkw1VnY2SldUZnMrRjF1dWMwcXNqa2F3Y2hwSnJ0?=
 =?utf-8?B?MU1mZFZkSHZEN1h1TG9NMFFUV1k3SUFqUkJ0TkgxRlBldG1jc2FacENBYU9r?=
 =?utf-8?B?L2FWK3BsWldzVjZ0aXFsSjQ2THRNL0FYdkcrRnozTWkySXdCN0IxZVJsK0Er?=
 =?utf-8?B?T0txWGlpb0Nqcjk3aDA5VytnUmh5VTJMTVRlSFYxSW1aZldjQ2RJMFkza29q?=
 =?utf-8?B?T1d0YndtQ0FidEpscFVqZ2NFbi9OMTVQLzJsNStCcEtad3N5MVg1bjNRNldF?=
 =?utf-8?B?RnFtZWVQdXRXWTdTeGovQzAvcGR6Qk5lQzBub1IrN0VQNkMwVFhDUjBpUkxr?=
 =?utf-8?B?K3dtVTJBSWpqWHhGb0s3b2VSVmNvL09oSW5wdnhRT1NVWmExdURGSU1IRE9y?=
 =?utf-8?B?TGlvUHlXWDJxUUpvMm1nN24ybTFZL2dsY3d5V3ZQUWRydFVsS05yekFyMVRE?=
 =?utf-8?B?MC9saTZwUlE4ODdYdHBjbzExVytyZ3BvM2lYNFYzSVdRWVFQVnNZdWMwSVVw?=
 =?utf-8?B?WU1sWS9kaTQ2TWF6UTVIVzFOZ3Ztd2x1Zm9XUTl0UFV4R29tZFlLbHJ0b3Y4?=
 =?utf-8?B?VlRONjQ2aE03S2J4V0kyM2s4aW9EZU9jbHpWNG1HWHJkN2V1VTVreDF1MGg2?=
 =?utf-8?B?aEJaeXpvZXVYdHhuTm00Tjk0QTErNHJWUThVUWdMMW94UWpSOEdoeXlaMlJF?=
 =?utf-8?B?SXkwYmRORmJjc1ozUDZyd0JnczJMZFdCbVVMaFJxdllLQzF6ZkNwaE13RjdN?=
 =?utf-8?B?SGhPYTkyZi9EVVA2WWVuLzJJekhuanFlc3FRbkpiQTFiMjhrSnYxMnZJR0d4?=
 =?utf-8?B?M0t1bXFRaUN5Z2VZTFNhSWQ3anFacW8yQkFiTkFlelVZWVZXU1hhMlREN1dU?=
 =?utf-8?B?NlNPMXdZcEhtYW50T1BuM0t4eDhEMHFuS0NJRElSR0o4ZVUxeWgxTGNXcVQ2?=
 =?utf-8?B?SnFONC9zR0ozZVJXcXlsVjNta0lGdnY2dm5QQ29Ua202UFJ0WmJMYjdVM1Qx?=
 =?utf-8?Q?/zK7KpI8F+udJISBdluH1NLZ4NPN+j+9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFrWWZkRmM0RndpT1FlSUxMM29Pc0tWSUNMSURzMmhRYXlQTVBnbEJMUXhx?=
 =?utf-8?B?bHNpZDF1UDVUUWFLckI1NW5NT0NQcVIvQTlyWFJrQ2ZtVUNINWhva2NzVTl0?=
 =?utf-8?B?SVlGRHdWWE9NRlp4UGU5MjBVOFVSU0NkcEt6ZGc5TVIzQWg0cWVCblVCMkU0?=
 =?utf-8?B?aEhHUThhTkpYenQwdFc1c3lJbzlXMlBPNWVQTzVXVFNFcjN6cnh1dVROT3hU?=
 =?utf-8?B?bFJQZktTU2NNZnd1REREMzBMT3N1MEk1aDkvMzgwNEp4ZldjbSt3TTRzb3hW?=
 =?utf-8?B?djExMnRHWHBWVVVQQnFqa1YvMytsSml5RDZ5bERqRnR6ZDc5alpTeTF1amlW?=
 =?utf-8?B?eGdVcDVzK1BWQ0VKSW4wSFZhcThFQjAvWnk3L2RVQTdOUHl1RjFIWEw5ZDVu?=
 =?utf-8?B?djhpbWFQaVJTRHhnMTZzSUVJSTZwQVJKL3BGZXVTN0U1WWVCbW5mbUJmdXd0?=
 =?utf-8?B?VWRmVWFiT1Jvd2FCUzBodWMvMWVVeEpyVlE2d0tyMzA2TWxIY0FWVTBlSC8r?=
 =?utf-8?B?SDBwWFYvWVl1RzVjSFg5Y0xJVW5zTFpJNmZaRmFHMzU5aDdSZkJDZld5TEIr?=
 =?utf-8?B?U0JJa1gxUEcyd1loSS9NS09NYU81a0hLeTZ2dDJQQ0hwUlZWRU5KaFJueElC?=
 =?utf-8?B?NGMwVzRaWm9sUnFpaFpILzdZN1dLb3IrYXRiTlFiNE9EaVBXaXZhaEFNcDBI?=
 =?utf-8?B?QVpOanQ4ZnEvM1pWalZhOW5sL0JSMWdyYk9wYXFRZGlXQkdTa3IxTDdTVnNS?=
 =?utf-8?B?cXg2ZFcrNlNKR2FDd0o0cnhXbEplWHJpLzIwWVhBcFB1ODZyMlpEVGphdThC?=
 =?utf-8?B?K25PRFlReDg0ck8zKzVnMWFXWjB1WmJVSUNDV3pCQ2Qvdi9DQjBZZDRJV0Ir?=
 =?utf-8?B?RnV3TWlHRzQwcHd4NGJWdFQzMHowQUFUZGlVKzlxQ0FuSmNGaHRDMWNTeFJF?=
 =?utf-8?B?bUxNOGI0Q0oydW1VdFdJeFdETzR5UExjMVNCdU55QWtTNlJ6ZjBubmYvalRp?=
 =?utf-8?B?WTh2SzliMGxGbkxvb3NLVUxETm41N1hmbWMzVEF0NXo1Ty9kMjNvOGpxK1pP?=
 =?utf-8?B?eHJySFRoRHhEODRpd0RsUSsrK2NXalFvL1RHMUs0eWJkSlBYbDlOU3o1YXRa?=
 =?utf-8?B?OUxGOXlKRVVqb2lycDJwV2VGOG1SMjVWNXFaVGVOaWQySjB2RGhPN1FydzQw?=
 =?utf-8?B?eVhqMEFZZ0pNdkhYbDN5NFBxbk1ua09RaVZnbkR1Y3A1emJ0Z3VhV3YwQzNW?=
 =?utf-8?B?UCtkKzF3TWttSXZFV1ZnWkY0QjNZY2lpM0dIM1I1bllaNWt1ZXVuL21zWFhy?=
 =?utf-8?B?TU9mNjBFN1JYTlNiTThObXhTY1c2d1NHN3cycHM0OC9rczN5Q2ZhZUlDajJj?=
 =?utf-8?B?a1l2bjg2dG1TcldiZEJtNTRKdDNFd0pFVFloYjhEL0gyUTF6YWk0L1R4VWtz?=
 =?utf-8?B?dnJwS1A2aVpCKzNEbjdwRGN0ZzllZDRQM28reHhwU0J3SlB3WTc3aW5mcTJO?=
 =?utf-8?B?QjhrMnY0TnUraEUzT3pjVS9wdzB0WEYyOEhsV1haT0FlNVZkQk8ySDRXaVRs?=
 =?utf-8?B?bDg4ZU5vVEc4NU1WZ2xlcS9lL0k3OXhTcUxCcys5VWtOSloyUVhweStWL0V6?=
 =?utf-8?B?UUdUdklONE1LUFFyM2JXQ0VLOHpNRkt6QXdkNkJBSVVydFdyU1llTVg5R1p0?=
 =?utf-8?B?bk9pdDhKd01jSmRRczMvaVpkNjdQQUlPVkpwOVhSblRWUnJkZkIrQUN2UkJB?=
 =?utf-8?B?Y2lha0VKaFVzQWdIc29uRlIrRXBaVkpBbFZhRUNURkxUaE8xR1J3WGIxMjFO?=
 =?utf-8?B?cVlpYXM4amtueVRVck5ETUJTdGozeDJxNHp4a01CamRuVndHYjNmbDFIOVYv?=
 =?utf-8?B?eG1CcGhpRTJoUWxJcElSajNuRm5na1dseSt2VGIzSUhURUI4QXk2NitodU1F?=
 =?utf-8?B?dHFsL3Q3c05ISUtQYUtxZWtubk1IMUJiWEJQL2xaWWh5ODJvU1d5b0MrVnNZ?=
 =?utf-8?B?Vk1BWWJRYittUjl4TnJFOFNzdWYvQWppQ2JmM3lSdHc5a2xBN3Z2VTRwMmNh?=
 =?utf-8?B?UitSN0tkVFhNY0VGUWRNQkx0WmxnbWttRmFsWm11OFhKNkJTTlpZY2xLeUtp?=
 =?utf-8?B?WjJMVDZLR1RIb0Q5cDFka1JvVERhNXp6YUw4RC9SNGphQjNON3YwbWFpTFk0?=
 =?utf-8?B?Mi9zNHlOQ0pqaS9ubVBHc0pCRVhyVThtYy9kQTZDbXdiR2hnYXRwdG8yNWZ5?=
 =?utf-8?B?WVQ0dWhBN2puaElFRTNlSXRENHNBYUdUTkxqQTVQaWtnK2F3d1NQdmZ4cVZI?=
 =?utf-8?B?RFhGOEI0ZEwxYUJGSHRFWFZ1YWoyMmlhYnkvNWdUWXdhTjJMOXNaRVNaSkpq?=
 =?utf-8?Q?vPhZ7eA2U7KToT67u5eM5M7WnksY8enfqctJr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5748D7617CA06742BAE558ACF5257695@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a315bb84-61cc-4d32-1c55-08de51ac9f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 07:31:38.0617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5/pxb3b7AEtcZVANKtOhjmhFa4AElhz+EPB7lm/qltgDzfMtYlB1MEUAIHQvBPTMG5Mnb4rPm406U1K55W2+5biSgL8KxH4gZx4lp+KJx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5982
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

T24gRnJpLCAyMDI1LTA4LTE1IGF0IDA5OjAyIC0wNzAwLCBEYW5pZWwgU2NodWx0eiB3cm90ZToN
Cj4gVGhlIHdhdGNoZG9nIHJlcXVpcmVzIHRvIGhhdmUgdGhlIE1DVSBFU00gZXJyb3Igc291cmNl
IGVuYWJsZWQgdG8NCj4gdHJpZ2dlciBhIHN5c3RlbSByZWJvb3QuIFdoZW4gYm9vdGluZyBIUy1T
RSAoc2VjdXJpdHkgZW5mb3JjZWQpDQo+IGRldmljZXMsIHRoZSBNTVIgcmVnaXN0ZXJzIGFyZSBs
b2NrZWQgYWdhaW4gYW5kIGFsbCB3cml0ZSBjb21tYW5kcw0KPiBhcmUgc2ltcGx5IGlnbm9yZWQu
DQo+IA0KPiBVbmxvY2sgdGhlIE1NUiByZWdpc3RlcnMgYWdhaW4gdG8gc3VjY2Vzc2Z1bGx5IGVu
YWJsZSB0aGUgTUNVIEVTTQ0KPiBzb3VyY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwg
U2NodWx0eiA8ZC5zY2h1bHR6QHBoeXRlYy5kZT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBT
dmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDCoGFy
Y2gvYXJtL21hY2gtazMvYW02MngvYW02MjVfaW5pdC5jIHwgMyArKysNCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1r
My9hbTYyeC9hbTYyNV9pbml0LmMgYi9hcmNoL2FybS9tYWNoLWszL2FtNjJ4L2FtNjI1X2luaXQu
Yw0KPiBpbmRleCBhNDIyOTE5ZmFiMS4uNDk4YmJlNDViMzggMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL21hY2gtazMvYW02MngvYW02MjVfaW5pdC5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtazMv
YW02MngvYW02MjVfaW5pdC5jDQo+IEBAIC04NCw2ICs4NCw5IEBAIHN0YXRpYyB2b2lkIGN0cmxf
bW1yX3VubG9jayh2b2lkKQ0KPiDCoA0KPiDCoHN0YXRpYyBfX21heWJlX3VudXNlZCB2b2lkIGVu
YWJsZV9tY3VfZXNtX3Jlc2V0KHZvaWQpDQo+IMKgew0KPiArCS8qIENUUkxNTVJfTUNVX1JTVCBy
ZWdpc3RlcnMgYXJlIGxvY2tlZCBhZ2FpbiBvbiBIUy1TRSBkZXZpY2VzICovDQo+ICsJbW1yX3Vu
bG9jayhNQ1VfQ1RSTF9NTVIwX0JBU0UsIDYpOw0KPiArDQo+IMKgCS8qIFNldCBDVFJMTU1SX01D
VV9SU1RfQ1RSTDpNQ1VfRVNNX0VSUk9SX1JTVF9FTl9awqAgdG8gJzAnIChsb3cgYWN0aXZlKSAq
Lw0KPiDCoAl1MzIgc3RhdCA9IHJlYWRsKENUUkxNTVJfTUNVX1JTVF9DVFJMKTsNCg0KLS0gDQpB
bGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
