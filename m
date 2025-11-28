Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3B5CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 10:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7965842CD;
	Fri, 28 Nov 2025 11:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IIvoOgyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761E384445; Fri, 28 Nov 2025 11:11:48 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099FE83B9B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L54YDtnHa4AnDncPS+8q3MBpp6VSu8GKVqTwYVpO9iD+QTZ2TqAEKksS5n55ncjD+EW/iMr2YPGXTWn4IIvuGkL6zyJE1k9r7zDaqhA0HreyqlbF4/brzAN6mH7wkwz6Fd8FBjndEOs5htuuRY+uSzf1+ahiRSAjTB31/rWpJK1Cx2PsUmjy8RM08xVllgG14GJ7McgOQmJYDwvIgYNyVgK3XgodniBlIK8FTMvtZXvR8Na5Jm4jidBUvz0G0O50GTEkeCuMcEgvJqaXLtwSkZcvnBm91linwfYdBs3RnBQkP7raTI+c4gBlm+tRiU2qHJcKa0jn5foKuc9WYEo/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD92nyertBxNJAiIwVyP18+D2/Bxir404pq8zFeVexE=;
 b=IcsZdVth7VakelgD4UGHTd3CclAQHQzg3D8MaJ+j/qsDRM1TUHOphLKMVq7EgHIbL3YIH7PqYLECG+ZoxNWx87Aok4OZYYuU0ZBLvDrT+C1VLClWd/5vBMqaRsvjUPz0XN+Cz6/dJsb39hVfQ4YZV3M8GjloZXUEjFrb3nsfo2yYMMSFUwvarcWd1sgG7lOgaBlr2sAHbXpkIBvcBXTNHFSlfUQpkJzOqEQKV5XN1pwEUkVA7yslq4pxdVit6qqnZyS1/h4b8/sbz2fP23D8fOcLYKQkD6xkmzQswaOGXdxW7XeeW79SLryXHjamglIjbyfqDT7soGGqL0+/y+M0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD92nyertBxNJAiIwVyP18+D2/Bxir404pq8zFeVexE=;
 b=IIvoOgyWyZSRuRG3XejhA9Kri9zm45zxrzG1kiGRNJpnsIEUnd5Q4uduLXyjIz7weJNY1neiVe8hSBbUpHBc/xMWq7bWT2e22NUY1gYfNbZwz1pJMU751x7Fnedw3Xrs9SO3Ms6PrMiq56i+UZm/dPtsi52gimV9/5ouFvW4Caw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VE1PR04MB7357.eurprd04.prod.outlook.com (2603:10a6:800:1ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 10:11:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:11:42 +0000
Message-ID: <3a22faec-320c-4ffa-976c-2c0d8207d267@cherry.de>
Date: Fri, 28 Nov 2025 11:11:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VE1PR04MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0b32eb-457f-47cf-061d-08de2e668706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nms1RFNxYmo4OUpRWmd2QkdsS1JkdGEyV2JXQS9CQWVJZkhERFBWZjFMajRa?=
 =?utf-8?B?Y3BPYXpINUpsL2hQRVhLR0hiNHlsVWFNQ1pwd2l5WFdwQjZhNDc3TGs4blRt?=
 =?utf-8?B?Qks2UUlEekxINjNXR2hrbWNCMmJVOVVmR0ZrWHd0STZSVG5IVnlPSEtSbnRa?=
 =?utf-8?B?NDM4VGVQcEJ1TG5WWXF6TE5IS2lJVm00Mmx1YVhhVmVKbkovZUlJTy9BQ2dI?=
 =?utf-8?B?MGI3bm15Znh2aHcwVy96NkVWem9tZGN0TjZGc2IrdWZRMDk2RlpWR1lldXA4?=
 =?utf-8?B?R1hvN1I2bk5KYk40R204N1hqbjN1d01jaUdMR3B2bTNjRkoraGtVZ0ZuWDM5?=
 =?utf-8?B?MkxPOGdSUG9hc0JzT01pU1BkcHZQTzFLSUc4SFpLV0tnSyswVUxCZFpPVzBo?=
 =?utf-8?B?SVpiSG9HQXIvNjlrOHJsZWFsNGtza3k0UW5RaCtNZ29mdUV6ODFqSU9kT1NC?=
 =?utf-8?B?Z3gyelhjaTNRTzc0Mys3R0czcnIxc1ZwWHB3L0xVcUprTVFpRHJsYjNHbGo5?=
 =?utf-8?B?S3NDYVVoYllUVGdQczJqWWdBYW11L2dDbWhmZC9WNVo0azlzVW9xTTZneEJx?=
 =?utf-8?B?UHVXMk1STWkzUkZIWE5JU1NGMytrQW5Xaks5V2pOV0w5RExSSGluQWlzbDQx?=
 =?utf-8?B?QWNqSEZZeXJyRWhNV1FvR0djWGlJWFMyUlA0RzR6dFRacFY5VzJRbGdaaUV5?=
 =?utf-8?B?RTJhVFBNU0JXcXo4WXROM2owcVVPYkpsdXJHUS9JV3BMNUh1VE0vZmZtOW9R?=
 =?utf-8?B?eENzem1RNGxvNzluQStMNmJaQlMxc3pJUHRLRytHQllsYXdIUHpPeXZxWE1w?=
 =?utf-8?B?VjNkRGxGVkdqdGNVL0pGeDFQeXUwcmtoNjV1M0ErU3JvclhZWmxObWYzRHBj?=
 =?utf-8?B?cXRJSnN3VFdBWHlYQmJYS09obGx4WlY5RSs1QkRwRitHQUk2U0drZ3V5aWFH?=
 =?utf-8?B?akhXMTRINmtUTk5VN2E4RldyclR0MkdvMW4vOEpSbXFjNDlCY25ZQnFtcTJW?=
 =?utf-8?B?M3dGTE1XeURPaElCcWEyWHYrU3dqaHpqelJJaGdWOW9MbngrVzRKbjlSdGM1?=
 =?utf-8?B?YzFpUkJkb2NEUCtYd1FYcmVTVTk2Tzg0RnN2MitoQW5rcDhJbXp6WENqNEs2?=
 =?utf-8?B?YnhRTjNvanhlTEVyNEpUbEQvYWxKS3BEeFFPNHJXWXcrNHdWMlpNTk0rVlZX?=
 =?utf-8?B?NFF2djR2aHpaQjFZWU0rZ0thM2ZzTm8wVGtKZ3NkeWpkZ3NkOEhKc25KN1dv?=
 =?utf-8?B?dmIrdElVN3l0cjFUSkRJZlBtbVFHb28wNUdZL1VGbkgzNVB5cURJV0VuY1Uz?=
 =?utf-8?B?eHNTTFlPQTdmWUc2UGZmaEJwdU55L3hMVjU5YWVBdTBnUmFIVHBNMm1JQUU5?=
 =?utf-8?B?dEIxUUFLTXowRy84VXVOLzQyRmlPK1JLcVJRcW5SZnMzMncyNjd3K0tjL1VU?=
 =?utf-8?B?MW4yT2s1VURlZFNVQmc4UCtSOFVzWDErMnpWcEdySDdyV2xiNHh4ME1FNHV3?=
 =?utf-8?B?eHN2Rm1FZUVaSWtad3dFdE5ONFVBRWs3ZkxsUmRONEg5MG85ZWd0MUxvL1Ez?=
 =?utf-8?B?UFMxNXpMVnJ1T0ZzU0cxMUZyRmNGTE5jWXhXbUlQQ3d0alF6cmYrMUpIQzFa?=
 =?utf-8?B?NjhDZFdTUjhOOEl0ZWE5Rk92VnJJZ2JtTnplOVNMUzhLTGY3V3poUExBV3Zx?=
 =?utf-8?B?VDNqdC95WmFGL0EwUGlVQ1N5K2lIemFDTERXaHExY0hNQlEyQi9KY3FpN1lv?=
 =?utf-8?B?K0xBNjJZc2hVd0VFazhmWGkwKzFSOEYyT2RxWk5naEhGaWxlLzczNmFQeEhZ?=
 =?utf-8?B?Qm5ISDNCQ1NBbEtBeWIwcGJFUVZtUUdGOU5VOTFXbU5VV2ZQNHVFREFpRFFT?=
 =?utf-8?B?OUdHM1psV2lWaUlob1ViZGZkZ1M4b1NKTTZqRWNwWmljZ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGd2ZkpEQWJCSko5STY5Tm9Xcm05OHpPVkxXK3E0cHBwQnY3S2NXVE8zc1RW?=
 =?utf-8?B?VXZYUzVWWGE4eHdXZ2xxR3hDSGVPZEIwWHlETThwQ3lHdGhGbkh5bUw2cjJw?=
 =?utf-8?B?Rk5yd0xNaHFzNTZ3ODd3TkdqYStaMTJ3cEJYOE1iY1lCRlNoZUhrdnd4VTBi?=
 =?utf-8?B?V09ZdHpHYzdyMkVQMEhoQWlRdFZZZzRJYlNuRXZCaThsSWlqKzBROTJIU3BV?=
 =?utf-8?B?V1grL3Y3ZjVpQUVWekdHN1haU1FJUnZJenlObzJaRVd6VHVBRkwybkViU1FX?=
 =?utf-8?B?Q1RlOTRqc0xzam9pV01mT3pkMWd5MHN3TVF6cHp3SVE0Ni9IVDlRZjFrYjhj?=
 =?utf-8?B?R3kxdFJ5VUNwQ1NELzVwRkVNTHJvc081cGpDb1UrM25PLzh5WjR3L2dnN0Jk?=
 =?utf-8?B?bHMybnRwd0JNVmh5RjZpL1RiWXlQVVBNRUdLRVBya1lmcEhHK2ZvV21sWGNE?=
 =?utf-8?B?RFNJa3RyUlB2MUZWNXh6THR0SEVqYklWSGZQeit5ei9BNEl4SHRuMWlmS0k3?=
 =?utf-8?B?N3djMXdCTWR1Y0VaZWRwcnJiMmpIZ2RVTjVDa1BITVRQeDFnd2V5ZVZyOG5P?=
 =?utf-8?B?UHk5Y3BmMUNLWTJLS0RoSlJyWXZoaVYyd2FsOEIvbXdPTE5HWXYrL2t3bzRm?=
 =?utf-8?B?TUFHcTAyRmpWREE1MC9YK3kyOFdtZU9Oa3hROEVHZkdpazkwdzg0V3FPU0lB?=
 =?utf-8?B?MWVFV2tTeHpBSks2MktodXpQU0xPVktHVkNkbWErQUFUSTZDdlJiSDJ6ckxy?=
 =?utf-8?B?V1pwSmhjVDRVWlFVQWF1bWk5ck9PeFdyWVlZN1QxbkFNRzlYcEF6S1R3VkFN?=
 =?utf-8?B?RnVybk1MZVd5dVhrSWVnU3RMSUs1Y1l4SU5MSUM2b2huUFRad1VmZU5HVzZR?=
 =?utf-8?B?VGhuNW1yUzNSRTRnQzRtTG13RWlPbGVCUGc1bVF2NzNXMGFYRWtGSnpGNU9m?=
 =?utf-8?B?VndpYjBBWGQ5MGpRL24wdkNaV2xkQ1U2U0wzd0RDbHV1KzNtUkg5Wjlrak9n?=
 =?utf-8?B?UjVXNCsvWUQwd2lwNmlycGdkS1dSZ1djRmpuL3ZCU096eWhOanNpOGdQVGNM?=
 =?utf-8?B?dlBLVnFvaCtBSG5iZzFURkxkMDJkTWkwUmV1WlYwWUYyY2Z5OFBYVXJuREZ5?=
 =?utf-8?B?bS9NSktaL3RudkJTOWdzMm90U0RldkIzQU45Ynd4cFA5NFVhWFhMcGZmMm1U?=
 =?utf-8?B?MzBpWmo3dWwxRkdlS3dpbUZLM2pMZnI0SlFlaHNudVVNeHUwUW1XajhyendO?=
 =?utf-8?B?dnBrQjhuVjNIOUxGczczU3liZGw3MkljNVlZeVo0UnJ3NG9kbVd3WEJPdVdF?=
 =?utf-8?B?cTUxVlUvcU5LTG5lTTJuV2NPS2VwaXhnSE5RMys4QnIvaU1xTmNpb3RLczRG?=
 =?utf-8?B?dlRoS3Faa3kvY0Y1SC9HakowMFgxc1h1Qk1XekRSem9VV2VEZ0JKcnhndGhM?=
 =?utf-8?B?Q0dyZkl3Y1NMY3RrSWlqcmdRZlBLOEhZZ1Bnc2VSWHowQXp4S3RKR3VWVDZW?=
 =?utf-8?B?RFM4elNPR2tMTXp6Um1XMnRiNTEra2R3SmY2UkYzUTBkZVFZaVdQbWFhRGpI?=
 =?utf-8?B?MVFZandGK3JGd0x1cTVDY0FBMG8vdDNzR2JROTdtM1FJeHZwZXluYnZiUWJJ?=
 =?utf-8?B?SXZHeGMxUEZ4YU5wK1FWclBid0syMC9nQS9DTFRENjcxMzMxUjY3a3Q0VGdG?=
 =?utf-8?B?Rk9JeElEN1d5QmE2bEQvaHZFRVBPL3Z4L21rZU43NEE4WlVFcHlpVnFWcmVU?=
 =?utf-8?B?cWJpU2lMM0NkQTczazEyZ3ZvWDNlSENONm9aaTFxZmRqcjVNNldVS0NtZ3Yy?=
 =?utf-8?B?NHJGMUUzbkhZSFpoYTF3ZlJySTMwOXdZKytGcE56U3pDNEQ5WXdVbUtPYVBG?=
 =?utf-8?B?VXJWaTI4SWwyREN3V2F4Q0huOUxmc1NIbDlBeGhSNmNBNnlkckNJR1VqUXBj?=
 =?utf-8?B?YlQ2TU1EbG9rS3lDZlgrQTdDazViNTk5cDhxVUE5YVpBSzBjelZZTzl0eWNM?=
 =?utf-8?B?dzlCL0hsQnhENUM5ZGtSVnZQb2xIQmNkaUgwa252QXdNYytYZmZjZVJnWVor?=
 =?utf-8?B?dFlpUHAvNi9sQWdua0lzcTVTcm42N05INlVzaVRkUCs3dHdxajBnbHpjckhF?=
 =?utf-8?B?cHcvRUJCTnZobHROYlgvQ2laT3NCMDFTRWlKa0VKeC9uUTJYc2lmQXdDRFlJ?=
 =?utf-8?Q?AkLdt42/Q7DZYaj75CBLL9I=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0b32eb-457f-47cf-061d-08de2e668706
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:11:42.1550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrzc944SLmJY2HbduGrRsO/jvELSG1etY7VkgEQAgi9L2QnEE5rtG5+IkutNo6dU6aVDK2zPm63/yEDSc9pL2dTJigcEn/xp6psaNRQX/80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357
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

Hi Anand,

On 11/28/25 6:50 AM, Anand Moon wrote:
> Hi Heinrich,
> 
>>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
>>>
>>> But I am booting from SPI flash, so I cannot stop this board in the
>>> U-Boot prompt.
>>>
>>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
>>> in the user space to spi flash? using dd coammnd
>>>
>>>   From the schematics, it has W25Q64FWZPIG
>>>
>>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
>>>
>>> I have tried to enable SPI flash, but it is not getting detected on
>>> the board in userspace.
>>
>>
>> https://wiki2.radxa.com/Rockpi4/dev/usb-install
>> has some guidance how to avoid booting from SPI NOR flash.
>>
> Thanks for your tip.
> 
> I've attempted this method, but it hasn't worked for me.
> Could you provide the SPI details for this board so I can map it in driver code
> and from userspace and then attempt to erase or reflash the image?
> 
> on my board
> [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff

I believe this just means that you have improperly set up the SPI 
controller, pinconf or whatnot and that it returns always the same thing?

> [    1.285967] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
> 
>> Set the jumper as shown in the picture to boot from SD-card.
>> Once booted remove the jumper to erase or update the SPI flash from U-Boot.
>>
> This board does not return to the U-Boot prompt.

If you write U-Boot (u-boot-rockchip.bin) at the proper address (block 
64, or 32KiB if you prefer) on an SD card, insert that into the board's 
SD card slot and make sure the SPI flash cannot be accessed and then 
power the board, then you should be able to boot into the U-Boot on the 
SD card. The process documented by Radxa to render the SPI flash 
non-operational seems to be grounding the SPI clock pin via the headers. 
Once you've booted into U-boot on the SD card, don't forget to remove 
the "short-circuit" contraption otherwise you won't be able to access 
the SPI flash.

> So I cannot debug this further.
> 

I would really recommend getting familiar with this process as if you 
flash a broken U-Boot on a non-removable storage medium and you don't 
know how to make the board NOT boot from it you'll have a bricked device.

Cheers,
Quentin
