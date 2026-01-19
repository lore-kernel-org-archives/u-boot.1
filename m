Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4968CCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5043183015;
	Mon, 19 Jan 2026 10:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VZGHw9Gi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9DE8313B; Mon, 19 Jan 2026 10:41:07 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CB080B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCDbpAQk2KsDyn/vySFf2XfyyDM3jb9m8uy2xEq+lETyWGDbV4XiVCPu7dyNl4lkVEq7bjc0/dBru4pFI7MQbSSFVLhRiYxYN3CtWoBw3WVkM9eLJMXzuKUCi8je1B/RJ7OiQJNg0nPlHwEDcXTZqDzrD7Ond58oQm7W7vCxMN5JZYZ8YDrS3NGj1Njn32b7aUKL8gVybOUG6vGCW+qjiJ+sMf6QGf0f4u0r6Q87j2nBB2Jb7bRI3SaRyaAiyInNan8t5odXiO0Gt1BIS1ffUO4McliBWm+eNWpWZIk+gA9gb/WZRb4vNfRmATPrV2pQl2HiZ72yUlIhe7Z06UCHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVDjvCGcrMHBX87Yj8xJ/RRseKxNK9V81qgG5Y4Q0UI=;
 b=YosDrsRfrsUICKrwDpY7UiAUH5omh1/+tO0VQ/Sxvu2Tk7DDSRHYvFzqmgSc62WYSr7JWjg65dHMORtghCHe6MN2vpAQajnOFTqOnGxLo+jMNEgKU20aBQR5jtMw3CEwGYM/Zp9M383rJKy9Nd5d0QaQA8+/wEfYAgdWpTt42rprh2YURXH1BsgmC7opgqbz/8cCeuNQJAAq8ACaOwQiiMfa0B7YMRfaE1e9cMlDfElWq9MN2n48BBkKg9DfWXzqzPlmG3L2gDGh471A4//mzXvSOh2n/Dnjx4Wj9xIHglZp1cKs9Q4iAKS4tbsZCvylsPkxe6Bd90U0jAuE+qLDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVDjvCGcrMHBX87Yj8xJ/RRseKxNK9V81qgG5Y4Q0UI=;
 b=VZGHw9Gi+iwCstUHnXpLlWAahLMPTHimTFxHleiA2N2tYtP/GXpikp0/8fUJM/kDsfQLsPKvF9KpRTSYPP00CkD10j0xVYF6Fsz6Zm2KDRHkh7QPa+X9qA5vsEE3PQaOBjCB9Jh9nce5CKsR6vOQIhNl8oFXc91AF4nGiExTq1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:41:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:40:59 +0000
Message-ID: <48b24c2e-c779-440c-b32a-d6d8095cb90f@cherry.de>
Date: Mon, 19 Jan 2026 10:40:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot/fit: print name of config node not found
To: Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de
References: <20260116182903.20652-1-linux@fw-web.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260116182903.20652-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2c7bf8-88e1-42bd-0786-08de573eda43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am5CdDljOG1HTkViYXBNaVU0VktSeHB1QVd4UmJLZ0xhVk9TeWV0Nkd3R2xF?=
 =?utf-8?B?RXRONk1ScnkxS1BBQWcyZEEvaXdkek03VXdEVkhKUE1HR2VRbFAreVNnRlpH?=
 =?utf-8?B?VHV5S2ZSRWIwajBaQW16WGZudUl3VUlMbWRPdGFENDYrU0p3bnVtK21YTUZi?=
 =?utf-8?B?UGx3TGhJem91aHBvUVB4dHkzbVZUSGNqcXJPQlVBTHBCckw3Qm9KR1R0eTIx?=
 =?utf-8?B?RkkyZExYZnhPRjJHNktBam1RTUg2VU5MRmFQMG1hKzN3eVhWSkRHZktMU3Js?=
 =?utf-8?B?cTJQbStEZlE2YmpzZHNzTFpwc2JtYXNWSVVKc1h3cmJFMFIyZ3JMRE9tREFi?=
 =?utf-8?B?b2xmME1sUTJMREdRODdaVU1FMWtoVmhyR0VQL29EbHZnNGdvKys3TGlDRlAy?=
 =?utf-8?B?b2s2ZTZIOENPaTRRbWtqSFNvNE0yS04rbjRPUDA3OEMrL005S01WVGVKenJl?=
 =?utf-8?B?MTk4Wk9DVm1PN2xTK01yQWhYbWN4U1FURk1QSjRZWUZwZlk2cFZkRkE5dk4x?=
 =?utf-8?B?MWEyTkhJOWw3ZGR4TWs3VkF3eXBKR003TXRhd28reVlWQndaREl3b3lSZ1Vo?=
 =?utf-8?B?YkdzenllTTFJMEJscnMvZHVZS08zSU9Lci8zU3V1aXk0QVBsNHVsWXBDZmIr?=
 =?utf-8?B?dm9DTW1wb1h0OEpob2pQbm1IVW93dDhFbjZrdHF0Z3gvWnVCbmdEbktTT1Vi?=
 =?utf-8?B?ano4VHJUZHlSbUUzdUxyL2o4MWlsN2NFTDFsQklEMEVvWWJNYnkzKy8vT0Jl?=
 =?utf-8?B?ZHloMkZxV1pSSkpUeDRpWGcxeUt0OUpZN2RSK3pCb3ZWV2R1N29vSlFqMDA5?=
 =?utf-8?B?cVZUS3lOM0pGbTJQbHJyT0pKbXBhd2hHYTFvRzV4aXdsb3AwVnVYb1hOZVBW?=
 =?utf-8?B?TmdjVlBQWElJU0dZeWxLSHY4cTl1Y1VXM0tGcHZXVEQydkVpQzdIbzlYRys2?=
 =?utf-8?B?VnFQdEhuYXF5ejlPSm9BWU90c0w4Z1RNSHl4WXIxODJEV1pXZGY2OWpSc1U3?=
 =?utf-8?B?dy9ubHFkWVNUcnJsejZqTjZ6d2s5VFVTSEdFWEYwQlBvZktUd2sxTGpmNG40?=
 =?utf-8?B?ZStwRUR3a2M2eXpadE9zeWZJQ3R5TmR6NUJQdTBLNjRSa1JUQ3NxQm5MZ3Mv?=
 =?utf-8?B?bVZXdm1WcllIOHFTbGtQTVk4T3FCZ2NxNkFRT0F6TW13RnNyN1ptYkxITUlx?=
 =?utf-8?B?NEpidDcrZ2NFb0piRmlETjFpYUZ1QmsydHUyMzYxT25FRDc5Q2pKd0k0S1B2?=
 =?utf-8?B?blN2U1QvWTVZUmN6Y2JRaGFUcmkyc0FkdFRHcnJUTXlXMHBIc3B6VXBEQm1n?=
 =?utf-8?B?RmNSeGZJUHFPTU5HakhPN0dabG4rR2ZVeEF6T3I2Uml2M0xVU2lucEtYYmV2?=
 =?utf-8?B?Ny9peG5ZUm1qMkxKbFdnTlJBeWM1c3NZV21pZ2dURUpPQlVmaHQ1Zk5FQmRk?=
 =?utf-8?B?USs2d2RvVFFjUWl1ZHhwN1Y0S05CRkdSSmtWOUVZdFR1S0JiYTdYL1RNeERF?=
 =?utf-8?B?MjQ1cXpGZm1PMXZDZWM0c3BwTEVBTW1KNVg2USttVldPT2t0cnhGVjJoWDAz?=
 =?utf-8?B?QzdaSENlalVWY3FKZ3FSM0FGaE8xTGxNeFRqbHFRMVdVSmtUZ21yY1JmS0Rs?=
 =?utf-8?B?ell4emZVanFGTW90SmJoWlF5WEdRUXRCWDdsUm1DQXpFUGxKM3dGczRlQ0Ux?=
 =?utf-8?B?UUZzTkk0K2FjbTNoK2xlQkVXeFQ3QmgrMVNvbmN6ZzRBZHhsK3lEV3Fpa2Nw?=
 =?utf-8?B?VFB1Yi9mL01WZXlKZDZINFY5eHo3azhOSHJjckwvNnV0YzhkNCtQbEdyZko4?=
 =?utf-8?B?M2krQlZqK0dWTlozVFFCdENRN3lrdGhmV1FITTdPSDU0dHdtQ0JjVmhySmhX?=
 =?utf-8?B?eHJFdUdmVkp4SzhITHAyaFU5ZjNIdUt3V2lnR2k3VCtCL3lMTGFnYlo2a1Fj?=
 =?utf-8?B?TU1HREpYaHFxQk5scHFvaHVSenJmRStMVHhLQUhvdFdDajFYZ005MmhpVllB?=
 =?utf-8?B?bjNXaUlXd2QyWGNjUlJqcExicmtJYzIyUEp4ZHQ5VTZ2SHdKbXo1aU8va1VJ?=
 =?utf-8?B?akxqK09rZ0ZLK2lBN3lqRDhFcTlaaC9qTlVnbzFlSm9hZ0NnVXY2ZG5YK214?=
 =?utf-8?Q?eb00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVuMi8zZzRmdjZYZDlHWVJoTkRTK2cxY1ZmYmY3KzhRUlg4R2xTM0V2a2NF?=
 =?utf-8?B?R2s3Z1prUEJ0VVFXVVNiaGtzUVRaZGt6Nks5TFkrYTk4OWx1cy90YmUxcEov?=
 =?utf-8?B?NFJ1U000NWFkWUJhbW85dWdYTWRFcURJZHg4L3Y3NFA0ZTlPc3VkbE92cWRs?=
 =?utf-8?B?eW40bjhVZUI3K2tmWGw1RUZmUk9VN2V4TGZNSEZmMFpQcGxhd29acThxQlFM?=
 =?utf-8?B?bjc4SzBaajk5dmt6ZVM5TlcxQ0N4V3U5NjFXWE5DR0JMaFdyajJ2RTdPOHQ0?=
 =?utf-8?B?aGlFRXlZV3prZytiZGdpUlJlOGtJcnF6SmFOcDdHUUdIT0VNUUlwMnlKa2ww?=
 =?utf-8?B?N3dkOEVxa0xYWjA0dTRPYmJock4zTzV6ZkNIVnhIZkNlTVpGeUhMSVhLQU1F?=
 =?utf-8?B?Q3h4RGNYTDVYeGVCOVdmTzVXRnBlVzdkMkZsSFZHMHFNYU1xd0lHbUZoTmxF?=
 =?utf-8?B?YlV0bzU1Z2FyMFZHVFRJekwxRGZ2Y0pqNUxmQ2kxRE9mOWF6bDVDdWtEMlI5?=
 =?utf-8?B?azI2Q0NqTUNSeUtiMzgyd01sN2NZVmV3QlVJN3lOQVlWUVdvRTNjN3B1Y2dT?=
 =?utf-8?B?dGV6ZFgyOVdWWGU1bVZCSk1ndzJ5Q2FsY0xGcG8wRndGQXhQMXFNM280dUF3?=
 =?utf-8?B?WW5KdC9LS1V6STYzWkR6R2JHajZOV2FWeW5yVzh6TlhtcnpYUjMydVNtRm1T?=
 =?utf-8?B?SlkxNHJZYkluS0VvSkhld2habEhsSUY4ektpQVNWcnFTbm02OG8yRkkwZURR?=
 =?utf-8?B?N2lseEFJdTVDYTRCQy92eVBRNGJURXhzWkFtM09JaG4vcWxHOElNR3hERnhp?=
 =?utf-8?B?aDIyeisrSTRpRHFOTlRqcDIwU3NybUtaeDN4YjlZdWRxY2wwb0tWdWlkVmpk?=
 =?utf-8?B?V3kzd3N5TmhPYXo2a3BuSHV4YzRmb2tOQnFGY2FvM0w1NzdXWDFpK2RsUXlw?=
 =?utf-8?B?Nmp5YURJN3dvVUlpTnh0c2ttc1NXTFYwT2JvK3JqNFRBcFplWndrVlAwY2th?=
 =?utf-8?B?SWdTcVR5TGZKRkhET1l5Vy8ybG1uUTg1Nm10VFUvY0VCbnBiTDNZMnc0dU1t?=
 =?utf-8?B?R0w5SmJTbTB4bXhldUlHay9tQTlTYmtMN1pqenI1R2svSnI4SUtVTEZHbmtI?=
 =?utf-8?B?WDJDNkFjKzBUeG1WQ29UNGlmaHltMTZQSUFtRTZ1OGdPdHUwRXZiTGRUSUZ5?=
 =?utf-8?B?bjFjZ2FFUVduSStES251ZzdDTDJmQVZpb0k4eENidUhQUHhnd1hWanBzYU5N?=
 =?utf-8?B?VTFaVTk4T0dLV2pqOERKUzc2eTdVUzVHZTd3U3FPRDA4bGljUDVUbUtxbG1F?=
 =?utf-8?B?QUJmSmY2ZkhQOG93Q0k0VjZqd2tBMFhJL3lVSE9iVGVmZXVPaEE5a1BMZDMz?=
 =?utf-8?B?bzBkOVBPK2M0azBhZmEwcnp6VURxN2o4Q2FlVlJueFEvbUIwZDB1dzNzSWhp?=
 =?utf-8?B?S0QxN3FnR3MxbE9PUWh4OFdvQlc5aXBlVjBLeGsyUE1oNlRxTzc1ZUFSYkl5?=
 =?utf-8?B?c0hQWXREYTZrb3hhbys4eXhjdjhOZHJSWkV5eFBKL1J6QlB5VHdCV3hVRWVK?=
 =?utf-8?B?dU4zN1lSOVJhSWVCYTlmU0pJWHcvSjFLdEFMQW0yWFRCZkV1NTlQWVdPSWxB?=
 =?utf-8?B?aU1YQVkraC9TVWdvOWNXNS9Ydzl4VGNFWmpFNGZLaXdFYVpIdGJtdnVRT2JP?=
 =?utf-8?B?T2lNYkJlZUMyMWo4N3BoS3NLZ0UzalJJaXNEOE4vY0ppcjd0ZFBpWkV5UTNX?=
 =?utf-8?B?elB1QlVMVlk0TVdnOEhnQ0tIRGh2L0grOXAyeTh5UFh1akFrUWtmSGVVc0Nm?=
 =?utf-8?B?L25DaEhsTFhQeTMxWGhJVEg2aWFNWTJRZE1iZHdTa09WaG1UMGZkWmZOZmFo?=
 =?utf-8?B?SWY5NllSZEQ2QWlld3RtL3ZrUVl4bUtINUZORTNhMVJNaGxFbTZzUjBRVndH?=
 =?utf-8?B?S1lyQUdEdk40Umh3RFBvbzlGUmREUDRaaW1TSHhVZnNCTVlCNld3RUs5Z1VE?=
 =?utf-8?B?MzZDYVBIRzBweXNEQXFocU5yRVVHTCtmSXlkZDFoVUpxT3k4cnZrcEVXUzh0?=
 =?utf-8?B?MndwTmJnRHRBN3pYZTltUmpaU211dFdoSU51a1BlTys5Q1IxVDI2dGVUb0Jn?=
 =?utf-8?B?bDFWcEJSV3Z0VGIwU3VBNTJYMW9TUlRuOTNmREM1ZjBGWDJFUXRvMFdLK2p1?=
 =?utf-8?B?Zjk4VDY1dWFYbHlBTVJmNWhIUml2SmpNYmQrWWhCdm12MUdTL3JBdFNIWHln?=
 =?utf-8?B?MVMxcFhhNmhhVmdKd3JxRUR2Rm1PSmhJK1lPZDlZRytPZ1dZcDIvVkZGT3Qr?=
 =?utf-8?B?WUVnMDU4dVdNWmpCRnBsYitmN3Jhci83aXE3OTV4dnpCTGtDc2crRGV6c0FC?=
 =?utf-8?Q?IGM9p9RdmdQqloZPNVpXMRZ3XiQyJViygWjFT?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2c7bf8-88e1-42bd-0786-08de573eda43
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:40:59.6030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFV1GOEzWvcu56LyvQpv6a0k774XyebOOjZlQih9YVw6eJMhlb51SJqY2V5xxy6QiS4hdKnugU9fchzciqcekDUk1atbHgiBvhaKXyW9ab8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572
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

Hi Frank,

On 1/16/26 7:29 PM, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Show name of configuration node which was not found.
> 
> current state gives no hint if fit image is wrong or the requested name.
> 
> Could not find configuration node
> load of <NULL> failed
> 
> After this patch we see name like this:
> 
> Could not find configuration node '#ov-test'
> load of <NULL> failed
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2
> - handle null
> ---
>   boot/image-fit.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 2d040e38d97b..85026c2d1d02 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2125,7 +2125,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>   		if (ret < 0 && ret != -EINVAL)
>   			ret = fit_conf_get_node(fit, fit_uname_config);
>   		if (ret < 0) {
> -			puts("Could not find configuration node\n");
> +			printf("Could not find configuration node '%s'\n",
> +			       fit_uname_config ? fit_uname_config : "(null)");

Given that DT node names cannot contain parentheses according to the 
Device Tree specification, "(null)" should hopefully not confuse users?

Thus,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
