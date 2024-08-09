Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F316C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9467F886B1;
	Fri,  9 Aug 2024 21:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="S97r4RfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F59886B1; Fri,  9 Aug 2024 21:36:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45D8889B8
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 21:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479HIMer031359;
 Fri, 9 Aug 2024 12:36:16 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40wmwns16d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Aug 2024 12:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI5PeSCTUJ1F4+Rtwq+ZePF+pK+0ir8uODaXOo1grMCc6quW4GP3jECjSdbEV+DHuzs4Obqx0XNWxMrlvSkw3xCjzPEdwpjKg4dQnVl8hsgUHN013UwOxD+nkiPSopA3hBlDFf3KqrzZ8oyXLQQrLMQG3Q5E3lOeEYocE0uj1iFKYiKfYZHS9RXuA+i8ZrCh9DlPsqMT0ueMhaLQBaueT7Lk9qWAS3O9csGn0x8weLAGmNwEyZxSXYyXdnYAfaHjVQJL/7xnaBYsLPbVWQXGIkLFkidMKuuE3XPQopErUlnjS/Wa1om5SIKcl5HA45cLmNUILASyGjGRRZrSZb4emQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+4jChnNBe+kzVQys9BdN+jDZoc8OMqW7YDtEOcT3Y0=;
 b=iW7ghn7zksPmB9KoZu8ksqapzFPe6XslRczsRpzkCGWdR2/y7gbPKXZ4F/A2uperaNkBoZjLP5K4GAJsS3S8PcX+ktctjiUX0qo8KG2VJHbAxePPh1jWauAqGPs4m+UOe92n6WYkfgFdCnRl3W5wkKefd0bJdUl703tgqKY1oEwNCDntGfU4anr9aPfLMbwB0gO5uZJCqovQHauBVnhf/dDckANfctk4ZkhSwn/uuISe3H9M9Bzh42+vLJiPjrrd6iuUOL7Sdr92P8cONkJJj92X9cSdinVA0qrA5470wUjMX2DFvSVKGM7THSF1TXcu8wep0umM/1hVqaRPYbNH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+4jChnNBe+kzVQys9BdN+jDZoc8OMqW7YDtEOcT3Y0=;
 b=S97r4RfZr6YlRIgBuKgntzRzNdRdsDHe1luLN19l1qCYkXVeYZYHkS2NLUyF1hS1rcwXyOZkwshGFvq8UsCksmqMvhEbtAvCLIjp+T+QzWyerLMoRGm4j0utd1Fk4RJCNDVYla3ss0irTkMES+UQQbFf/4/5oCblAX48kgzFt58=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by LV8PR18MB6045.namprd18.prod.outlook.com (2603:10b6:408:230::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 9 Aug
 2024 19:36:14 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%6]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 19:36:13 +0000
Message-ID: <b4d4fe48-c3b0-98cc-dccf-8b96318ec204@marvell.com>
Date: Fri, 9 Aug 2024 12:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH v2] env: remove vars that are not in default env
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, quentin.schulz@bootlin.com,
 U-Boot-Denx <u-boot@lists.denx.de>
References: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
 <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
X-ClientProxiedBy: BYAPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:a03:40::44) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|LV8PR18MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be3cbeb-51d2-4ed2-5314-08dcb8aa877d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlNPR1VDZlVrR2tYcjJ0UkxYR1hiZnN5VzhBYVFsOGVxSS9JNGJmVXZKVlVj?=
 =?utf-8?B?MGVYanFFZTl0UWh3Y1RVS0VlOEFWYUxQWmJZYW9yQUtNOVUyN2Ztb0NMcUg0?=
 =?utf-8?B?aWxCR1JjQzZYZVowWHNsRTY2U3NibXdicWhNZjUrYUtObnVoSExsUnl3ckth?=
 =?utf-8?B?Ukgrbjk5VURLR09HclByektnb1V4cmQxb3F4Nm1KMUR3T2IwM20zcCtCWFkv?=
 =?utf-8?B?bkpseXNsSDNKNjlidDM2S3o5dEc2RjdVcXZaNmx3YjcyRjZDZGIyTTcrdDV1?=
 =?utf-8?B?R2MvNEc1cnB1UkRzb0RuQWlHY0ZRcWpESjVYek13cFdCMTlJYTJST1J3WUJX?=
 =?utf-8?B?Y1BxL21oa0l0MmJkR2dsTVduMndBMytuYVBOeVJKWGFEYmJWQ3FLWTBmcnJ4?=
 =?utf-8?B?STVGS2ZqOEpKa0tNMFgra21taGp6UGh5VGJrUUJwMEcvTUw3UWE1MjZqU0ww?=
 =?utf-8?B?eUVVaENrbXp3WU8yd1YwMmY2RjVCRXBnaEF3elJXZjUwS2dhcXoyZk1zTGdk?=
 =?utf-8?B?bHdjNXoxb1EwTUMvQVBwcnQyUDJNVEE0ZlBQQXBOLzkyaUNwQzV0czJ4ZmF4?=
 =?utf-8?B?cjBLVHMxTkF5ZEJ4MHI3S3A3ZWY1aHlxMHVHYWNtZVlEU1YzM2I2YnVFWlV3?=
 =?utf-8?B?QnFOUVFKVGd3NnprYWw3ajdlb2s5SFR3WXBGOWkzcHFPSVlRR2RzTnFNK21l?=
 =?utf-8?B?c3lSWVF6K0NtRU16WDZCTlAyS3RqVlVuQTRWU29CUjk2K2xBQVBWQkFod3lT?=
 =?utf-8?B?NGJMamVPNjRyRjVuZ2JQUXpobmRXZ3YwQlQ1bUlBZWxRTEdXdFc0Q3c4d3Vh?=
 =?utf-8?B?ajhXaitMS002SG1Xa1VKK3NkT25hTm9FWGI3OWM4aWFNd0VuZTdwTkQweUFa?=
 =?utf-8?B?cGxsbDVQT05VamF3STVxQnVzbHdIVjNwcjQyVFo2WXFiemhFU1RQUnR1eENx?=
 =?utf-8?B?V25sU0J0QWhvTytTM0Q0TVRBYU9CcmNVTXlQbTY3WTVWMmduOVBUQmJURm5D?=
 =?utf-8?B?QjlYOWxoY3pScTV1Ukl6MzQ3K2x2YjZVQmVoNXoycFZONGJENnhEOHBnb0tL?=
 =?utf-8?B?SWtFaHB2MXFZUTUvZjhTY1BLZUVMWjI5WFBRVGZFUDFhaGVIWW9TU3VCbnhs?=
 =?utf-8?B?TEFEZ1dFNVEyeE95OEtVNytjZzFFamF5UzNMRnErRE1DOCt4czNKNi93R1BW?=
 =?utf-8?B?UDRrWmtVZDVzaktSaGJpbDcveFdnVCs2NjA2elJrYVc0SFkrU25TNWhqbmdS?=
 =?utf-8?B?OW8yVzI2QndmMEZFaUd0SWdOSHhrakR6bWNnNG4zalMwc0RTMmZTRk1Uc292?=
 =?utf-8?B?Ulp0UjRWOWtlWm43VWw5anJIVG84Z0xMRnI1bVZOZnh2bUtnc3QzOXVrNzJl?=
 =?utf-8?B?NjJCaTVwK1h1U3NIMlVrK1d4cXEvTmV5UGlMN0VUK0FVOXdhRGFyNmt4aS9l?=
 =?utf-8?B?YXlQSnBVUG5FRzNzY3p6V01EaEdpVkM0enJQY2I0L3lOcHNZOWVkM05ncFlO?=
 =?utf-8?B?ZUh2WU9McDUvcnpPbWVWWlo0Z2UxVnQzTTFiZTh2YzI2ckRWQ0ZlVXo2Z3Bl?=
 =?utf-8?B?K2w2SzVnQ2N4ZGI4VmhCVm0xRWl4OXViZ01IWWNwQnl4Q0lyOUt0RE9yZys0?=
 =?utf-8?B?dnZiM0pWS1EvOGhkdzJPYUxMOWUydXg4SXZ4bEFSR1BwVzV5Z25mVVhDYlc4?=
 =?utf-8?B?NEhmaERQcXc3Mk5odjh6eXhXbytKVXhCRjBDbGdwQW1nQ25idlViQUVnaXFi?=
 =?utf-8?Q?0uC3p7pm/TrKGPXSMw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJIUlFWbDQyUEN3T21TT3dDNmx3cTFMQi9hQ0NvYzFYU1hVSWxHaDRrWUtL?=
 =?utf-8?B?cExoQ1B4V0hTQ1RxRmthNlBIbWUzTzF2UGR0YkxmK1o3WmtkUm5YVXN3OHQ3?=
 =?utf-8?B?ZW1Ld1QvZzlTeXZzbzg3YnNrUWdQeE1wVy9oTjdianNtdDdxa2RzM2p3Qnky?=
 =?utf-8?B?V002OEUzWVJheVdKdllmOC9qbzRMcjExYzRyYWptZWI4SXB4YmZMaEoyU0gx?=
 =?utf-8?B?TW1hd0taUjdHU2FDRS9GcTJtMGJFRGo2QmtVTGdJd1ZvVzNVckNLcVRJN0g5?=
 =?utf-8?B?WTZLVU95V1dQRXhldGcwWGttcTdkNWtBUThSbXpOZWVuajhYd2VYRlhZTVhH?=
 =?utf-8?B?em9JV2RyK3V5NzZmb01oWUZFcFJDNUltbWc0b2pKOUdYbUdYeWJSVlhtRmk1?=
 =?utf-8?B?N3h6QUFhWWJKNmJqWVc3bzUrNWhjb3Z5WUNpbjRncS9oRjZSckxUcXJoakNN?=
 =?utf-8?B?c2oxOXJ6Skt0UHNlSmV2NWVHZTBuZTlpU2hnRlBISXNNS2dKTlBnTlpoZnNr?=
 =?utf-8?B?dUFpVDlJYXBLSzhIdytZZTdBMndNZ294MEFidWtvUGp6djg4NU1KNFJQSjE1?=
 =?utf-8?B?WmZya3VjTmUrRk5pWFNGOVdlb25OR25NaHVjM2FxQko5SHRBeVJHWnBlQk5H?=
 =?utf-8?B?aklWL2VMZ1h2NkU4aHBTNUgrbURGWGNlZ05XdHhldE4ySlp4b1hDMVJ2TXJk?=
 =?utf-8?B?V3Blbkh1YTMwTlJvNGEwTXhFUlFiUEVubEVOYUxGSk1QQ09xUjh5MFJ1NG5M?=
 =?utf-8?B?bnNTVFd6eVF0b3craENOZWpLNlE3L0Q5MTZHYVovclF1NWlVemFkb0dKMjZY?=
 =?utf-8?B?K3BGL0xjbGRrZmJOaytaRkExUWVXN2xOWHRDN2cyS21YdWJ6VHExSndFdUNi?=
 =?utf-8?B?YktTaGFOaW5YNTRRSUJ6cjVnTmJYNkY4a2pSSzFFdC80THhZL0pIVWdVQmZy?=
 =?utf-8?B?L0dIaXNwUWxQYkdMcWhNNTFRTVFrYzlVem90enhnam9ld254dVUwS21TS3Z2?=
 =?utf-8?B?bkk4ZFZVbk54bVFpbjcvRFBZT3J1N3NJYnhsZHVlZnZYQTdnM01MWERhMGNO?=
 =?utf-8?B?ZWVXZkVFSmpPT1d6UThoWWgvTkVaZTJzTEFKVkhGWkNhK3pnaStwbmswUHNt?=
 =?utf-8?B?WGJXeExuaGRuVkVSc3I1Zk92RC8vdlMvV2NrenlaODZyeUk4Z21NbnpZOU42?=
 =?utf-8?B?dHpwSTJzTjZEQUJBcitQVjN3RDV3NXJZblhoaVdnellCMTBscUFYZXZOL1Ey?=
 =?utf-8?B?TW1CQWE0YVJvVkhsdGxDQWYzbGtpWDg4cmtDTXZOaFpnYUJ3bTE3SVpwbEZv?=
 =?utf-8?B?b2NXVXczcXZCNzlKTUlwNllNYktydy82ODNNSHZJc2pQYk9WcjQ2VXdsUlBE?=
 =?utf-8?B?ZnlBOXhLRi9Rc0JKbjg2NlgyUmxlYnRIdFlVRGV2K2hnK3VDUEl6Z2ltVkZy?=
 =?utf-8?B?UlhUZkZSY0VzK0I4ZTVIc1pnOWF2c2EwcGJHblZ0ZWpGRVZFYkhqMVl3cDIx?=
 =?utf-8?B?VE9tOWoxRjU4dEg5bFpxaXJNSkV4d1cwV0VOSG1NY3gvZE5KVDRXMEJESm40?=
 =?utf-8?B?UTBQRUVUVjJYMFFndDVrTHNFM1J5a2NhZlk3ZjhobGcrWEVTaVpqOHdYMlNj?=
 =?utf-8?B?cmxmcWIyQXF2KzExUjhQU1AxcGY1VmRMeTFhSlV4RjQyWDZreTJNbUJUbjlq?=
 =?utf-8?B?bk9nN2crWjFuNURYYzhIdGo3MnlQd3EraURvRHQ5eUlLVDk2bEY4WXNQZkdJ?=
 =?utf-8?B?RWl6UWZ5cFBjK0V1eWlwQy81RWlsVDJyN0s3QTdSS2tGM1N6OVdJUGJyWFpU?=
 =?utf-8?B?TnRPZGpmY0I4T3cvWlZNUEFXVlhoL1NxWll3a2dHNFp6RzVwY01zZXYwakdV?=
 =?utf-8?B?blJEblQxVys3UWNMWFFHWUEwMVBUOGF0VDhzOFg4TEgxM3NnR2Q5Z0JEek00?=
 =?utf-8?B?YWJoait2b1lib3g2QkNqTUhxZTJTcnJPbmg1U3BMWWl0MVJDemZSYU9lTEFQ?=
 =?utf-8?B?TDJEUGlCbDZMdXdkVVVpdWFzbVRmTTJKRCtQWjkrZzJKeUhMeUl5d0lBZFQ3?=
 =?utf-8?B?Wi9URWFIVGExMmQwell2ZHd5c0hxNitYRkVBalR4RmdpeXBLNDk4a2Y5K0VZ?=
 =?utf-8?B?U216U1pOd0ppai81OHlKeDJSc0tiaVVwT0FTTEE4UU1XNk94dC9udDZLR3ll?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be3cbeb-51d2-4ed2-5314-08dcb8aa877d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:36:13.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEXmVqtJRcgyWhW4R2L+3LBK7+zWOIrxIMeAbm+ROlzmIvdsGXGGDq1PPEvfRgDn5F6lOIY16AFCydk/32LcuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6045
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: DOl4gC-hywcTL1UtZKPGlFgkAWF6r3Fb
X-Proofpoint-GUID: DOl4gC-hywcTL1UtZKPGlFgkAWF6r3Fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_16,2024-08-07_01,2024-05-17_01
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


current env_set_default_vars() doesn't delete
var that are not in the imported env. hashtable
removes vars that are not in the imported
env but present in the current env only if H_NOCLEAR
flag is not set.

This change is to avoid passing H_NOCLEAR flag if
specific vars are passed to env_set_default_vars()

Without this change:
Marvell>> env default boot_mode
Marvell>>

With the change:
Marvell>> env default boot_mode
WARNING: 'boot_mode' not in imported env, deleting it!

Signed-off-by: rminnikanti <rminnikanti@marvell.com>
---
Changes in v2:
- Added env ut to test the scenario
- Updated doc usage/cmd/env.rst

=3D> ut env
Running 5 environment tests
Test: env_test_attrs_lookup: attr.c
Test: env_test_attrs_lookup_regex: attr.c
Test: env_test_env_cmd: cmd_ut_env.c
Test: env_test_htab_deletes: hashtable.c
Test: env_test_htab_fill: hashtable.c
Failures: 0

 doc/usage/cmd/env.rst |  4 +++-
 env/common.c          | 10 +++++++++-
 test/env/cmd_ut_env.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index 9629f97ffc..9104c88525 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -79,7 +79,8 @@ The *env default* command resets the selected variables i=
n the U-Boot
 environment to their default values.
=20
     var
-        list of variable name.
+        list of variable name. If variable is not part of default
+        environment, it is deleted with a warning message on console.
     \-a
         all U-Boot environment.
     \-f
@@ -309,6 +310,7 @@ Delete environment variable in memory::
 Reset environment variable to default value, in memory::
=20
     =3D> env default bootcmd
+    =3D> env default ipaddr serverip
     =3D> env default -a
=20
 Save current environment in persistent storage::
diff --git a/env/common.c b/env/common.c
index 8d47d72605..2f783e3a69 100644
--- a/env/common.c
+++ b/env/common.c
@@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const vars[=
], int flags)
 	 * Special use-case: import from default environment
 	 * (and use \0 as a separator)
 	 */
-	flags |=3D H_NOCLEAR | H_DEFAULT;
+
+	/*=20
+	 * When vars are passed remove variables that are not in
+	 * the default environment.
+	 */
+	if (!nvars)
+		flags |=3D H_NOCLEAR;
+
+	flags |=3D H_DEFAULT;
 	return himport_r(&env_htab, default_environment,
 				sizeof(default_environment), '\0',
 				flags, 0, nvars, vars);
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 13e0998341..99961311aa 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -9,6 +9,42 @@
 #include <test/suites.h>
 #include <test/ut.h>
=20
+static int env_test_env_cmd(struct unit_test_state *uts)
+{
+	console_record_reset_enable();
+	ut_assertok(run_command("setenv non_default_var1 1", 0));
+	ut_assert_console_end();
+
+	console_record_reset_enable();
+	ut_assertok(run_command("setenv non_default_var2 1", 0));
+	ut_assert_console_end();
+
+	console_record_reset_enable();
+	ut_assertok(run_command("env print non_default_var1", 0));
+	ut_assert_nextline("non_default_var1=3D1");
+	ut_assert_console_end();
+
+	console_record_reset_enable();
+	ut_assertok(run_command("env default non_default_var1 non_default_var2", =
0));
+	ut_assert_nextline("WARNING: 'non_default_var1' not in imported env, dele=
ting it!");
+	ut_assert_nextline("WARNING: 'non_default_var2' not in imported env, dele=
ting it!");
+	ut_assert_console_end();
+
+	console_record_reset_enable();
+	ut_asserteq(1, run_command("env exists non_default_var1", 0));
+	ut_assert_nextline_empty();
+	ut_assert_console_end();
+
+	console_record_reset_enable();
+	ut_asserteq(1, run_command("env exists non_default_var2", 0));
+	ut_assert_nextline_empty();
+	ut_assert_console_end();
+
+	return 0;
+}
+
+ENV_TEST(env_test_env_cmd, 0);
+
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
])
 {
 	struct unit_test *tests =3D UNIT_TEST_SUITE_START(env_test);
--=20
2.25.1

Thanks,
Ravi

On 8/9/24 08:58, Simon Glass wrote:
> Hi Ravi, On Fri, 9 Aug 2024 at 09:=E2=80=8A38, Ravi Minnikanti <rminnikan=
ti@=E2=80=8Amarvell.=20
> =E2=80=8Acom> wrote: > > > current env_set_default_vars() doesn't delete =
> var that are=20
> not in the imported env. hashtable > removes vars that are not in
>=20
>=20
> Hi Ravi,
>=20
> On Fri, 9 Aug 2024 at 09:38, Ravi Minnikanti <rminnikanti@marvell.com> wr=
ote:
>>
>>
>> current env_set_default_vars() doesn't delete
>> var that are not in the imported env. hashtable
>> removes vars that are not in the imported
>> env but present in the current env only if H_NOCLEAR
>> flag is not set.
>>
>> This change is to avoid passing H_NOCLEAR flag if
>> specific vars are passed to env_set_default_vars()
>>
>> Test:
>>
>> Without this change:
>> Marvell>> env default boot_mode
>> Marvell>>
>>
>> With the change:
>> Marvell>> env default boot_mode
>> WARNING: 'boot_mode' not in imported env, deleting it!
>>
>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>> ---
>>  env/common.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> Could you add to usage/environment.rst and also update the tests for
> this - test/env/ - I suppose your patch fixes a bug, but it is hard to
> figure out what it is supposed to do from the docs.
>=20
> See for example dm_test_acpi_cmd_set() for how to check output from a com=
mand.
>=20
>>
>> diff --git a/env/common.c b/env/common.c
>> index 8d47d72605..2f783e3a69 100644
>> --- a/env/common.c
>> +++ b/env/common.c
>> @@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const va=
rs[], int flags)
>>          * Special use-case: import from default environment
>>          * (and use \0 as a separator)
>>          */
>> -       flags |=3D H_NOCLEAR | H_DEFAULT;
>> +
>> +       /*
>> +        * When vars are passed remove variables that are not in
>> +        * the default environment.
>> +        */
>> +       if (!nvars)
>> +               flags |=3D H_NOCLEAR;
>> +
>> +       flags |=3D H_DEFAULT;
>>         return himport_r(&env_htab, default_environment,
>>                                 sizeof(default_environment), '\0',
>>                                 flags, 0, nvars, vars);
>> --
>> 2.25.1
> Regards,
> Simon
>=20
