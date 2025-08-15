Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F6CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 08:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8013783A9A;
	Fri, 15 Aug 2025 10:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="t37dgXUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F41D83845; Fri, 15 Aug 2025 10:51:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4388783845
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 10:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3XQ3lTof+NKyr3IIGplsuB12Lw1hFlDGVceLfCnPCA6tPDo+5Tl7M8rM5Z4Aj7mOVa8LqlDeTptjAiHIuK7X1rkG2QjVfo6u1ZTV1lNgjQKerzBtHNZvTKQLIe+llsj5Y+TEeNbKKo80g2B44/4RUWzQsWxhbOwGyP0h2ybsfrrMmC923CrmJoRMEjaa8CGT4IfRw0NcmU5Z4LWCrqs/5QAsGMqQVKpHEFVcvjNXPM53KkaT/Lfy2SomLweJzwy1lm+IUg8y5Y8dL+tyLV+LzLKhbiFg/Q2lsEyR9OR7YoZH/zxTxXWl2TOkwtySTUyRgp9kuRwBofLBHNqgcNEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nPXRy7g+ftly/MAMgdA1Rpha3IS/MJ8akf7D4nRxhg=;
 b=oIgqGCxUPWikUk282Dhabe7vVctF9mZRob+RYusdqUK4N72pnCNre8UKTB7T2HMnepBt95MBCy+Yuk7XRtmQ5ZoEuvfL3iDFxZBR44PCZKbg5XJmvueB6Am2WL3+iFBxj3eJhVenP5vtpOLPC28vWlN4kscOs/oFTCxH107ipI6Ek1Hgm8LA0L9P1xNJLgYRmLJnEdY+0Q4f8pX01kneOB83SXf5f+VwG6yqISYXVv1xKeiB8IF6ZR7U7UbTo+S0zjMhLFJZLRFGJu7wCgxU70x+v/kYrC1Zy+u3MYVoQ3QoKuNXCFRuRFtim5mN9yQip+Koi2p7CTiKdHELXC5lwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nPXRy7g+ftly/MAMgdA1Rpha3IS/MJ8akf7D4nRxhg=;
 b=t37dgXUTfw46Ru9feJ/Ysycse5m/TQvPHuVQnPeAQFi+fW0IDvbPo3+FkYQjtbtCR5Ood0lMoAyIwaGnhd60QSsiJhCX5Ah6VUDp8kLBGYQ9HDdD6SFYuUXDKIstlZgiMoNm4vm+hC6635gdNVZK0JigzpsGgpofN5qj8uaPLh7XN1UyLssOdTdf/0rBXfDB12pXEg+yUT8aRcSW3RqeQk4ZFeUrrQ2xnPjBNQaio2Cv0QNoNNMfmFneLWWNHoZp3i6w1szvD58yHupO+SQb+PUXwizRKxgrFK0HBUJZ26gIOaOBaUVkqaCnGXnWqO7d0xrHomKBwK/N5lZqnG9itA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8568.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 08:51:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:51:46 +0000
Message-ID: <e47448fb-feb7-4ca9-8d81-e29f77d81d82@siemens.com>
Date: Fri, 15 Aug 2025 10:51:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl
References: <20250814165932.1584854-1-festevam@gmail.com>
 <20250814165932.1584854-2-festevam@gmail.com>
 <20250814175041.GN124814@bill-the-cat>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250814175041.GN124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: e23b3237-8df1-4808-7915-08dddbd8f71a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjJNdlJjbTdzMHVMTHpZc2JIcmtKbjBKV1YvMjZqZ2o2TnpJRVdVQjIyRXdB?=
 =?utf-8?B?MUhtVmdqV05lYUM4NjVsSk5aRWsvaHJhemV4MHg1OXorMkJlVGFBcDFSc09P?=
 =?utf-8?B?bnlGQWRsazJ4TUk3VFJWOXRsUzltZHVQVE42QWJZWExSQkxYMGo4Mnowb1hz?=
 =?utf-8?B?ZmNyUzZzVnBCSGo0dTFNdHc3dFllbTJXTFZDSm51VWhaZ1h2QTA4MUVTSWJB?=
 =?utf-8?B?ZEZKRXNLSzRwV29kQ2hKUk91QmxzNUpoWk9KamtuUTQwNUxycHZ1dGV1amM3?=
 =?utf-8?B?QTRpSFdvNnZUdzFZZURYcnNEL3o3Nys1T1M5Y05XOTNkeDhZNXlsRVRDMHF3?=
 =?utf-8?B?S2RWWml0bzg3eW13Vm15RGd5ZTF6dkpRNXpHSiszY2lETTFwYXhLNFdWaDJK?=
 =?utf-8?B?bUREOHNCYnl4SlErYWl3bGJGVU5JK3ZQTU1SbUU1dGZQeXlmL0lna1RTNC8w?=
 =?utf-8?B?NHhHKzlrRm5YL0hicUhmNjBnUW4rL21QM3oxSERtamFmWGpXK1hlaFF4aS90?=
 =?utf-8?B?d0IzWmo5dndvc2JxOVhiVUprSG81WFBBd0NKYnkyd3FzMWN1UjBlSUpDRFdh?=
 =?utf-8?B?Y0g4Z1FwM3Y3dHNXQlNrbHhvTFFmWDBMNGRKaHpDTm1BQ0VqeGxlWTA2WEdI?=
 =?utf-8?B?SjJHNS91VTNkQUZDS2N3ZndLT1JQOHd5RXNleUNNZE1mR3RUSkJRMmlQRC9M?=
 =?utf-8?B?WStvMzhCQVFZZDBtVjFhQjBTdDkwUklBWEFLQjFqUkV0ZVYzUTJFaklQNTk3?=
 =?utf-8?B?TExjclByT01INzhjMS9XSGpXd2pVVmVGSnVyYTFYQTEzSko4eDZFcGIzSUY0?=
 =?utf-8?B?KzZ0ZjJFbnEwZVdGbUZxekZQRHV5eU1NazlxTk9TUk9rZUtSRWd1NFNpNGxR?=
 =?utf-8?B?TmkvNHNweUdsSFUwdG0vRnpaelczY1g1TWd6bVIwUlFSM2dCVEhSTi9zaFY4?=
 =?utf-8?B?NERBa3l5UitTMmZqK0tLT3NxZmRtUTl5UzlZMEJHR0Voejd2czlTUlczM1Nl?=
 =?utf-8?B?NWttZVZzeVJFSkV1VUVpeHdmVno1TXJjcWhQM09tcUFMTkQrMXpqWnNFb0Nl?=
 =?utf-8?B?bGZQL3AwcHlhYzMyT1IyZzBSeEc3WUcvKzd2SHArSGFnUDZpdlZNWTZOQnJL?=
 =?utf-8?B?elVFajNzOUFxMEJZcmtybHpIdUE5cFF3b21COTJYcWlRdVNIa0M2WUx0a09X?=
 =?utf-8?B?VkEzV1ZHbk15TTVZUkdqakhHRDlNdVoyckFseHNhK01JTzdKUTdyajc3Y0hL?=
 =?utf-8?B?cDF1czNwclB0bTBYY0hWWGg2YU5iSmZJZHZjQnFOWlFvRUFKYVBPUnN3VU9N?=
 =?utf-8?B?aFFRMnFOeHBIdWcwdzV1R0lKcUYrK2ZZWS9mbXlHb05memVmVnNFVHZCY1Mz?=
 =?utf-8?B?TjVlRFZmTTI5NW90c1NwQU1pTmtVQUtpTzJETWpjVlRsdFoySkxGUnJJNG8x?=
 =?utf-8?B?dWU1blljKzhBbGxheHVXRjZsb05jMVZiSkRZZTNSTXR5aUJyZHR2ajR5UkNn?=
 =?utf-8?B?aVk5cVQxRUlhM2xEWWJBQTBjdXU5UEkyVHpmQ2V0VUVOY2ZQeFUxRnRTVjNo?=
 =?utf-8?B?R2c1Z09yTmxSMjRGTlorTzUvYXFYbHZCUFozR2JLODRhKytnRS9DVnN5cWlG?=
 =?utf-8?B?L0FhLzdOWHRKbHpVRzZZUDl2VnJPZlhuem1YbWRYYXkzNld0S1VKRVlpTnJ3?=
 =?utf-8?B?QUFqRXF5L2JoSG9rNCtXSE92Wmc1K1JaeFJYQ0RzbTFJa2FaN3YwZFRxamhr?=
 =?utf-8?B?c2x4UHMybEtMNEo2c3lQN0pRL2JIT0JVcTdrOGVUeGpRbmtkaEFwVXcwYzU5?=
 =?utf-8?B?a01Qb1ArajFScVpUV0JmRlk0U2E2R1BjUGZiNlhGTDhQTnpXUVNkV3BmZldP?=
 =?utf-8?B?bnRYT1ZzRmZxWUppeCt3WDdtY0tKa2Z6NWhOczYzckFqRFo5RGdaVVBtaXA3?=
 =?utf-8?Q?Wxvl27a7Zss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21SSFovU0tJendnbEpDeDh6eEhBUzFnM042MVFTOE5zNm15N0prSTJqL3lv?=
 =?utf-8?B?Y1dLeXJBNHJoaDdFZHVUMHExemdGTXNkS1JzR2xWMGtIRGFQdnhlRC9Ma3Ez?=
 =?utf-8?B?ZWN1cDRNNnc1ODY2dCtBaHRGMklkSTZEV3pqbzNJOUZ3cUZ0Q3g2Yi80R1Fq?=
 =?utf-8?B?ZjlhdER1bEVVRk51OGVSWSt4S3N1V3NaNnpramtHQUVqbVc1S0crbFI2NjFZ?=
 =?utf-8?B?eHVvNk5MUzhqTllQcFk5QzVRSVlvY3JxSTFEMExFNEdDUDJERjQrNk4waGVR?=
 =?utf-8?B?cmRXMXJ6RFdTOXhlRG96LzVRVStlbFUvbGJLZDlick1uSzBPR1BZY3FhdjdZ?=
 =?utf-8?B?RlpjaHRPd0VCTHc2VmJ5dWc2WCtrM3E3c1pXUzdLODhnQnFWTmRjVHUwTkFQ?=
 =?utf-8?B?MTF6bkFHeEh6SFBqQWE4T092SVBSZnQ2L0tsMVdtQ3FEcFRJU01Pd1ZXaEE1?=
 =?utf-8?B?OTBSb01hUDl5RW92eFhpMVoyK1huTjlSZ2hpaWd4MlVHOGo0QVBmSWtHVXR0?=
 =?utf-8?B?K0RaQ2dmZTVjR3haSyt2MGgzQnNkd3c1QWhQWlJtMHV4YTE3YVJqTzBLRzgy?=
 =?utf-8?B?RUFkbitSU1ZlL001RXdhOHZRR2JrQS9wZVM1VldkemQ2MEJlT3gwbWM0c2lN?=
 =?utf-8?B?eWd4U0Y3UXI4VU1NMnVGNUFENWxhV3p0a1ZLNE5BbTF4QlhCMCtkVkFUTS9G?=
 =?utf-8?B?SXl0LytyZTFwNEFQYkFyQmNJV1EyZzFYQUw1Smc3eTJaWEJTQVJrTk5SRWFx?=
 =?utf-8?B?Y29kZFFSR0g3MjhqTEZ4SlFJRWE0bDVqZnQ5cXZsdGQ3eUE5UW1mNDRyUTRy?=
 =?utf-8?B?NEJlZmZZMWkrSFNjUTdXTlU2UkVFZSt3WC8zaXFNVDUrajBkL1hncjdyalBH?=
 =?utf-8?B?c3IvdEE4NlFSMEZPM2wvRGNLazlMdndWazlmVjFIY0UxTW0vY29NU0Q2dzNS?=
 =?utf-8?B?d01uaW05bkEzQ0g2b3lTRk84T0VEa3dBQTVVdy8ya2drbVNiakIxSVNDV2VQ?=
 =?utf-8?B?V3dtTy9tcjVaUURzRnd5U1ZDcVlvdzhYSnI2ZXlpdWZ3K0Evbk9zWS9VWVhR?=
 =?utf-8?B?YVRBWnJqUDZxQXNkckdTcWlIaTRCTVJ1aGtwT2dyOFpwdXJEOUZTS2tNRStv?=
 =?utf-8?B?MlF6OGdiUitsRnFpTi9SUitGN3pISnkxNVZ4YyswMU9nTVAzSERlWVg0YVBp?=
 =?utf-8?B?UXloSzNDYndJQ09sS3FoNEt4SFBTNThYUG1kZklRZ25WQUZodEx6dEgxRzJm?=
 =?utf-8?B?alA3bjJKeko2Uyt0RkxhQ3p5STdHQjdGeHdsQmhFUHpzMWlka3Z5VTRIRE84?=
 =?utf-8?B?WmxpZEFYa3pxM1lwOVNVZmswMXlkcDdZa1gvZlhWQ2J2L0hnazlNQ2NBcVJa?=
 =?utf-8?B?dC9pVWgrS2dabDFGTmlZanIzaVBGNW12NE5YbURGM3JweFlWZGxJV1habFFU?=
 =?utf-8?B?NFJiNnJUdDVUT0xpTmFsYS9uQkhlMkJ6UVFBeWxzSTdIbGJXK2EwazVmc2hC?=
 =?utf-8?B?KzN2dkpVb2UvR0RmSjJVWkFTdGRkbFFzQ2p4NTdyQzhJVXg0RWVXaWc5c3Y4?=
 =?utf-8?B?ejVrNWFDWlN4SFRZekVzYUE0bnR2V2ZwZGdKMCtibnhCc3M5eUx5YlJsOXYr?=
 =?utf-8?B?Mk9ZaTE4dWtqTXBIOXQxVFAzc0M2SzdsZEs3UUVYMkpkRCtvUlRCVHR2cjA5?=
 =?utf-8?B?alFFY2dNdytCdWpQUGh1cnROS3A0TDlHTWVyNHkyajMyYitBNVkrZ2VQdVlp?=
 =?utf-8?B?bFlCMzZlekxKWTZ2WWhraTVlclRZZ3NwYk1tTWNOdCtlOFVWMEJRbDBtVkFO?=
 =?utf-8?B?ZjAweDRJN1RvcnFtV3Zqa1hrcjcyQWVQaC9Qdm5oSzViR1dHNzhYbEdMdi9z?=
 =?utf-8?B?a3Q1SDgxR2pyakt2SEp2K3NJYUNQZk5JMmVocEprUGkwb2RXLzhTbVhpYmNj?=
 =?utf-8?B?QnZrSmRtVmZxaEd4U2k1RHZleXlJNklrMUFZV1hGNFV3LzI1MW1jd0E2dzhL?=
 =?utf-8?B?UUJlTmFwRTNOcHpxeUFnRzBBMWFaUDlXSWRYRHMvSXBNOTVwb3FVZVlKdXFO?=
 =?utf-8?B?RWZUOGZOTW9RcHZWQXBiUzdOS0I2RE1wQTkveFkyalNRampUUVorM1V3d216?=
 =?utf-8?Q?oSgiAHhOobGi2gViTuR11YEIp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23b3237-8df1-4808-7915-08dddbd8f71a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:51:46.3422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /otRT1sWH/Q3jEutm07xDRZeAX/3LIpZ6OHP8/jpw9SCyJXDX2Gq9S7oUOTf54AiOpsjAJaVqBZM2K0dVosPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8568
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

On 14.08.25 19:50, Tom Rini wrote:
> On Thu, Aug 14, 2025 at 01:59:32PM -0300, Fabio Estevam wrote:
> 
>> Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
>> work.
>>
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
>> ---
>>  configs/qemu_arm_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
>> index d5890bf87fb3..db60f7de6da9 100644
>> --- a/configs/qemu_arm_defconfig
>> +++ b/configs/qemu_arm_defconfig
>> @@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=y
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  # CONFIG_DISPLAY_BOARDINFO is not set
>>  # CONFIG_BOARD_INIT is not set
>> +CONFIG_SYS_EARLY_PCI_INIT=y
>>  CONFIG_PCI_INIT_R=y
>>  CONFIG_CMD_BOOTEFI_SELFTEST=y
>>  CONFIG_CMD_NVEDIT_EFI=y
> 
> I thought Jan was doing this on arm64? But we should probably imply it
> under BOARD_SPECIFIC_OPTIONS in board/emulation/qemu-arm/Kconfig.
> 

I'm currently doing that for qemu-arm64, but qemu-arm will be just the
same and is planned as well. Actually, riscv64 should work as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
