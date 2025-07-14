Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EC3C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646C482B07;
	Mon, 14 Jul 2025 14:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="idIrIK75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99CB82FC7; Mon, 14 Jul 2025 14:31:37 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EF182AC4
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH0r4DEMGkstcpN/yImDX/KRDatYmRdz7CYY3uAzmFOnbNebtHrmu0+IxYweGs33BBuELtW9lhclEegSNnWDXWm9xWM0SMfpVWnn7Rdv0FIfyaD+Rpv0+85prRNQdXTRBJ0c9MY2yfhMi4cBuiyBcJzr8bN+qfT03Z5DDjyv/D61cQSBzdOGEPwdzQu68Nuqa7OoNBqm1hYgbG32/oeTtb7NgYxouHE4UOw8IL18BO5c7kbcADwQlnGrtqIgN3Ikaebviit+fZiQf58zw+FPSZarzFzK0TaQa4u8IR9E1TmACOf2DpuWs5yvrJxJ6XBzb2R7EQfOmgF+JVaVuRcKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkyJFW6Xe/8Z+vc3e5AJUK15doDSpFUmVJ+oc+tpUcw=;
 b=r2Tkkl2K+tTQjRH4V9dGxef4iLs8ZvInBgnFhCMxR9TivCUH+lbqR5aKFXbM1PqJAXkNK4G3o0X/8PV49qFX6ui4DJks+ipIYeyJ1T+FCbl1cLPGYSQ02rdf3df9V/jG3iLyse0U7Zu41pbWn0VthC82bYQxiUWA4vAMOmdoo1Yfp2iJ/z74SOXJFDRBXwfQkTWHqVBf/P/cxueg/KSxyAO/UxNLDbsQrpLuzn4HRjPOjcnOSrJTJEYu1XpMpXP/kDgvSvWotVeVfhfqHaiLGv26ifh4Kqa903OMWTVThPg8FWaTP9EN2c5g1nuRX+XZvoFhSaQMLYRtgDcSLY8GDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkyJFW6Xe/8Z+vc3e5AJUK15doDSpFUmVJ+oc+tpUcw=;
 b=idIrIK75DdUh2Om5nSePV9nGuEeXl6A54mAcRj7CfZhHC5pLUcXs6TUjssP/7Gb47GqhjHgwjybiyusbEu6Qus82s7JUyy/HYYfAD9UepoBFXU7I5ZjCC6xtyFRtVqhJb1ru0+UPwu868D4m9f4c5WcgBRMHKt+oooWnIQpP3KA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10999.eurprd04.prod.outlook.com (2603:10a6:800:266::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 12:31:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:31:32 +0000
Message-ID: <977ae9e0-c34d-41a2-a615-640d484e7c1f@cherry.de>
Date: Mon, 14 Jul 2025 14:31:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix incorrect use of binary and
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10999:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8c0ee1-242f-4abf-4e61-08ddc2d25d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b29vSXB4Ri92WXA1RnVaNENMWk1VNGxQakUwaWUxekVHOWd0dng2ZDRocHp5?=
 =?utf-8?B?NjN1Y2swVlpvemJtWVFIYk1mUkhYMUYxTGV1QzFRMGdYaUNwQmJUN0RQdzRt?=
 =?utf-8?B?SkdWSFFtUHpzejkveFAxQ0JzcjhndTlHbkMvdUlhbFZXS3ZZTmIrV1l1czZL?=
 =?utf-8?B?YXlld1duWDdHd0d3clVKZGNTWE9sb0U5K0QwTlExVnpUa29VNGFuTWZGdlE1?=
 =?utf-8?B?WEN6YmZOUTQxOHQzUUxnNzZrUjdFWTRQUEo4V1h0ZXhCbk5VbTBJZlJ3Skhs?=
 =?utf-8?B?WEp5Ny9HK2ozRzNLTGVhQVpLbER4Y1FUZEk3elVFNnluckRpc1FIZWo4STBt?=
 =?utf-8?B?WFpicTI1dkRVWFJWa2FqT29qOVBxWWdzMk93UlBsMGlmMllGaThiWE92V3Jz?=
 =?utf-8?B?SFArNlVDbHJMU2pLZVg4RTZteHRIMDk0Y3djWXdIZEpOcjF2Z3p6czAycGt6?=
 =?utf-8?B?SXJpNVhuejRPWFVmNFdaR25YQzUxaStkZHNQQzk0ZHEzUjlpUE5yOUFZV2N0?=
 =?utf-8?B?eHpXaWo2U1c0Y0NLWm1ERGhmR0pvSmJWS2l3SkdxamVyTytsMDMxaUNCYXQ3?=
 =?utf-8?B?dXo2SlpLTjJ3bGtnSmZyeXlSYkRZY3FCelZYbVdtZS9yUmZIb0lIZmlSaFJr?=
 =?utf-8?B?TENXTDZUSTdEV0hpcUgxWHFKdzF3WFFSMktRQmthVk5yZ2tldzhCZkwzYU5K?=
 =?utf-8?B?aTlQVm9pOHVJVDBvSXRnTktkSE5XQUZxbkhRYk1tQXZEY1pJZ1FGRDlBdWYv?=
 =?utf-8?B?UVIrb3Zlcjk1eCswdFR6U0k0LytQSEZMSDRoVGQ0d2o1TWhkZ0FCOThWTDdj?=
 =?utf-8?B?bnoyN1RzaXZXRUNXUzJJcFZoRWc0MWNyNmFKeDB6R1U2RE9FeEUyMG8rQ2E1?=
 =?utf-8?B?emJiZlRhNFo3Qnk1N2RvdlVYWnRQYkpKdzBQUHY5U0JUWVJ3c2RFUGxnbWhC?=
 =?utf-8?B?dXVSZlFzWkZKL3hSaVA1d1puVlJpblU3Y2dNeWQyaDM3MUJVaHdWY2tnNVJK?=
 =?utf-8?B?T3VzSm1GVG1DUFk4TSsxNlpEc3k4MnVHeE5ZZTNhbXBtdVB3c3F4WWo4UWlo?=
 =?utf-8?B?VlN1QXVKUHNQRzJlRzJNSGhOaFJmU3JLeHJYZy9vTUF2SmE3RVNOZUhnUnZE?=
 =?utf-8?B?c0hUUVhETnlKaWQzcVc5cUtRVFlveEUyODZ2OUt6blh2dFA2QVdSVnZ5Y0kw?=
 =?utf-8?B?dFdyVDZyam9ocUJ3bTNvUmlkTHpnVlBOV29IOE1iWjd3UldpNEdwZ3dORk90?=
 =?utf-8?B?YjlxeHZ1ai93c3dZRU40Z1UyeXNEdGhNZGx3Q1huTmhDT096Vm1nSzN4T1py?=
 =?utf-8?B?RWZVQ1pFbjdrTFVkRXBPNXpVbmVhcU40amQ1UlFqZThhSEsyd05YMUx5YTh4?=
 =?utf-8?B?RnJ1YlRMTzkxQ2pTai9DYWZxYXMxYVpmVUdZZGRnSHZDeGlmRHg2dmdYTCtl?=
 =?utf-8?B?ZStxdC80VDEvTjQ0Y20xdUdHZHhBRVpwQTRWVWQ2VFVUZGtjOGtjSFlaZlJU?=
 =?utf-8?B?ZkxyM1BjUUI1Ymtqd0d4c3lud01aaVlPdEN5dDQxYTFYUjg1TncyRE5sWHc1?=
 =?utf-8?B?d1BYWmxZVEpJRlFDaks3di9oNmUycGYvbkdBcFhZbDN6VjQwNDBiOUo0MWxj?=
 =?utf-8?B?RmVvMHdCOXUwS2JsdGcvMlhNRXhGZW4zYjZ6VS9URlMrbG54Ky9PUlRJOGFa?=
 =?utf-8?B?cjRhT25tZUFMSWMrVURqQzRkQ2ZmU0VYSXgxeXh1eU9wZm8xZVkrOFFmOVFN?=
 =?utf-8?B?UXFIU3g3SXA4a1JUaVd2RHpsdnVqeWR3b2VVQllUVTNOWk1tU0k1L0FYMVpG?=
 =?utf-8?B?SGE5YVdvdzRHa3loYStDSS91djFGMVZ4cEhGM1FKN3VMek02VjF6NDY5b1B2?=
 =?utf-8?B?U0l0bWdrVnAvT2toZVN1WS9JNW0weUlYWStyeU9NelFLeWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFkNW1qSHMxdit1TEY4RHJWZitpV1ZuWDA4SjB5TzBUbm8zUkFEYVJjRHlr?=
 =?utf-8?B?aEk4QUJDR29WOWQ0a0x0RUMyUHJnYlBscVJHeDNmaS9uamtFZ2I2NkFydHhT?=
 =?utf-8?B?VGIrSmZkTjJvMjBHSVVlNThlVytZQWRwTE1pL0ljcURlUVIxRWtHalZyZWdK?=
 =?utf-8?B?cGJyK05EcDg1dXRMNVRYWlJGYU42dzQxcWprVXYzS2JnbzF5QXZqY0JkWktW?=
 =?utf-8?B?b1ZPdmRJMEIzQWxpNGUvajMxVU45eW1RdUJpSHZQMjFDWWFNUWhKRHhWc1pa?=
 =?utf-8?B?TER4N1JISUhmbWFLRUpHOXBTU0hWTWRZSGN0ZWRLZGhqb1dMaHdRVDJ3a1pr?=
 =?utf-8?B?Mm15S29VNmJOVE5FMTlxVjAyNjJ4RlVUUmN5SEFYb3poWXlvSjd0N1k5RnE0?=
 =?utf-8?B?cit0eHdTbkNQelkwQk92RXBtd1dBNWdBQ0hMUHlmanRwakdkQzRlb1F4Yysy?=
 =?utf-8?B?M050VzJ6WVlscEtpdWRRRWp3OFZMOTI1QTVGdnF0WHY5NmtETjJscHlyclFE?=
 =?utf-8?B?cm5GOFRsblFXMmx3N0htZkE4Rm9JVnF6WjRReHpHMGxkWlkralcyT2pwYjlm?=
 =?utf-8?B?dWQvTlZ4WTV0aFZnTTZ6Rlh1RTZqZ1NsM3lmWTNhN3RMdjhxdFJhcVVqeXNh?=
 =?utf-8?B?MHhmQzlEcjJtS05UNUlCSk5uckJ2WFdwZ0JHSjFSTVdoV3FqZ1RpQ056YVpE?=
 =?utf-8?B?UE05OTlldlhqdWk4R1M2T2pvU2c2SXhpNHdoSTYvRm1JR0dINk1KNnRyN2xQ?=
 =?utf-8?B?R3MwOFR6Nm5pOTlRR0RmY3hnenZOUnJHWTVueUpoVG1reEJsRUk2OVV1RXpa?=
 =?utf-8?B?S2U2N0xVbEsxVnljVW44SFlaT0lFWFFsamtxeFIwTDV1VUZkYVAvWUcxS2Y1?=
 =?utf-8?B?bEZWSk9oeURkSW5pYmw5K0tpY2JMY2ttL2dhWXhuMlBHSTU0d3RFS2dWWXVj?=
 =?utf-8?B?ZWJnOWVpZU1nT1ZXek9pL2Q1SEVta2xraGMrY2FXYTVBOFFxOCtTMVdTbDlv?=
 =?utf-8?B?RmlZRU91ajFiY1dVUXFGcDluVmtHNkJIQVgyYWJNajlxL243RlQ0bWl2RSt4?=
 =?utf-8?B?Sk56VWhJYUdsZXRzN3ZEbVZmUldxSHNDOG9oMXJGbGxsVGZyZWRLcW1LMzdi?=
 =?utf-8?B?UmhSRGtLVWd1aEhRMytPQ1Uvdmpsa0R2ZGl2SEkySm5abWw1R1B5MWtPZDFW?=
 =?utf-8?B?N29Mb2dPU2xHTTgvR3ZISTRFSitaZjcwWmNkY2xzY2M3UUxBdlMySVZWUnlk?=
 =?utf-8?B?aVI4N210aS9zRXNnazFzRWVmd2NXbVFiOTVIOUdGcmR1WWY2dzVCZCtXcytB?=
 =?utf-8?B?REFvU3RMVUMwRDZmKy9XeVZTdWkxQ1dOTTVTN1NjdEhBam9QdVU4U2t5Q1VE?=
 =?utf-8?B?dWZIL0MxOHJQOGxpdTlJbDFGOXBrbXZrZ2RZd3czQklUUlplUmpod2lvMDFE?=
 =?utf-8?B?bnB4THZ1VWxCVHM0amlkQm9GZ2dYYXMvdVJtcmxQSWo1dzhoK3ExSEZhSGV3?=
 =?utf-8?B?R0c4RUpsNmY4cmludkNwSlFvc1FGNUJwU3RFTDV4eS9kanNMSUVpRnM3V2o0?=
 =?utf-8?B?SEpFV2J0a3pLT1IwOGRzWUk5MHdrV0M0dFEvRlpQOW1sRGxPK0VPeHZ3Wk85?=
 =?utf-8?B?YXZ3bXBESTlTNVFZU0FydUxVTHZGYmV3V1RYclBoNHpubUpwU081d0VIdkJH?=
 =?utf-8?B?QUlnMmQxWjhqRU1wNzdzV0R6SWhLNENYZDIyR3I1bXJQSG1BMkxPQTZJSTRx?=
 =?utf-8?B?OTRqcGE4aHJ1TjQzVU9Ib1V4bERqVmtjNE5pcWRWd1ZGTXFGTWptKy9uRDg1?=
 =?utf-8?B?OWh0ajRhY1ZqR3pGVVR3bVlYUkpLSkNHaFFCeC8zNTNoU3Jpa0xKZlBDOUFJ?=
 =?utf-8?B?RC96MG5kV2E0YkdTZG9yUk9mK0dDQkYyekR2TGtNd09NQ3h1clpLd1FOa3cr?=
 =?utf-8?B?V3QzNkhDTmd0R0Y2NjBKYkpNQmMyeTdMNG9lTDRZdHhxOVRZYjdncGlVc1R3?=
 =?utf-8?B?T0FGL0RNc2NrTU1KN1JhNHZSSkEzYUdtbE5MeUVuSjZ5UG5FbDZKbWxhdExO?=
 =?utf-8?B?NVFQZVh6Y3lhc2N2T0VPVWhBTXE4QVB1K0hSUURVWU1OdEx6R0E4SGIzNnpK?=
 =?utf-8?B?a0R5VzU3aTNXc1VxdTVMc1N5QXlnT1ZwRFY5T0VuVkZRajBLODFiVzVoeitN?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8c0ee1-242f-4abf-4e61-08ddc2d25d2d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:31:32.0908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eRGdVXgmffQuJY5FC/8jKHxWH2eTR7xZBYiGc+9pgSeiDAprU6cn7EnUzg5KJGdXdFrysns2rAqtVOAKh6lqPp2+dRZ+OfX4GNQfUywWLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10999
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

On 7/3/25 1:53 PM, Andrew Goodbody wrote:
> In regulator_list_autoset there is a test for ret being non-zero and
> error being zero but it uses the binary '&' instead of the logical '&&'
> which could well lead to unexpected results. Correct this to use the
> logical '&&' instead.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

That seems like what was intended according to the documentation found 
in include/power/regulator.h

"""
Return: 0 on successfully setup of all list entries, otherwise first error.
"""

Therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
