Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C74D1A613
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 12:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4609D8430F;
	Fri,  9 Jan 2026 13:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="RvhVAhIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC0784329; Fri,  9 Jan 2026 13:50:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550E0842FE
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 13:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0Wy1XkcMfSslB4q3P7TwNWdsWiHJpy4pN6+8ZOBbYvrZpFPYN4bLlt3ejEeN9QsrMM07Cgv4m7NzwaKmiV7JvUeB97DOS0U28ULwi00BVbc+86kfj8poMRsSb5K33iPL+QE4lcHD75hxaYkNXrI/SIYwuY0lJ4jxp+H/SyFwjFtVd8wYG1uF6Unn4/a/SpXQyOicvIGD3osJ/syDfPsBEESahBP1eQ8TjVSCIMkR7mj1MwGcH9Ph2GyL+qxtqJipdEj94goXQFiXRlBT/xfszJDYsphrDhtXmxYxhgF2Ls+pDl4ngRKV64SnHkcHBNo7gobM4WAU2GredFMMX/h+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YXlqk7A4L+/inFjux7P9ga4o6lqvwsbtRlv7YSvZIs=;
 b=fqwg2JHFu96GkJyx79Qm3jmW6IrGVqeRcDbDIu+YSszSWK7grX8yNLlO2WXalPly5h0KkAuk+lMSqrt0PJoxHvhgagtxT7z7uFZ9ItEDceDUWN1Sz+CLsBFSR+N1M4qCQtOPhr0ZhQCx3hOQSI9Q9dodEX+MT/zTyBoi7BVMO+T5o3abP5nJtAg8dFohHLPc3ux5klpHInl8+o4nsLZUNE8ggDlUafutmMZ3uTqLYUx5dTOxJh9GYd1xmjtVgJBz/HLDKSEctkk18apCt9ZNgUVwlr2ZO93GHui89ox00hvnO3mhQMfjXP7dQvKxkP8dlDQre+UQ+QZ4T7XsjBb1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YXlqk7A4L+/inFjux7P9ga4o6lqvwsbtRlv7YSvZIs=;
 b=RvhVAhIfQwBGwtBUptr5IN1uFVJzdhloliSPw0h9e+290lsoFivQRP0lEl3PB2obt5GcwbEjQRQ2thUBvPQLolLZ4aDv3CeVHyUew3keeGLFWcar4TnODpDUjuZrtFD7sf0GzKoqOdbNngTpc8qKwmPcL+puG/F6uRKwq0xP+ODaGkAEo6+CKoFpgLz3DA1rCQYD/FoV4EDxnPggqH6KFFx6hAbAoymSb+12jMRXtXqAUQbzYSXmleQ+QLuwnkTuUpNsZWMvYzI21N1H6aqPkLQZHUs71fdheSuha9j2OC7WoNY4bCU/syD91AyEBpVX5AL/TCvt5CMHCZqI+eM1GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6609.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 12:50:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 12:50:45 +0000
Message-ID: <e462d29b-fabd-43e8-8bae-7f28a9b1d7ed@siemens.com>
Date: Fri, 9 Jan 2026 13:50:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 simon.glass@canonical.com, adrianox@gmail.com, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 mkorpershoek@kernel.org, michal.simek@amd.com, ravi@prevas.dk,
 raymondmaoca@gmail.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 me@ziyao.cc, paul.liu@linaro.org
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
 <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
 <CAFLszTgtgYm67w2KmEo5nSZKuohD7sRNQKSrA0=mBxr9vd2gLQ@mail.gmail.com>
 <87jyxt9ps4.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgUw=TdheWVUzKLO+2+YECQv=19cJk3tdkFfsUhtRfyAQ@mail.gmail.com>
 <73b5f060-5405-4857-b8fd-1160c09cfd41@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <73b5f060-5405-4857-b8fd-1160c09cfd41@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 863a59d7-d895-4637-8136-08de4f7db4a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFc2bXZEcXdUZEh4VWJMRml1d0VxU3RZd1lKWEZWOTd2eTZYTWpRbnJHbFlT?=
 =?utf-8?B?a3RJT3JhVHA5RktQZzFNcUtmaFRuNWJHamMzVWhab3FIem9taDJVZ1JFano2?=
 =?utf-8?B?NkZzaUxVZmJ4TUJPZmdHV0tDSkpnTzJSRHVVV3Fra1JENWhOK1h3ek12RExo?=
 =?utf-8?B?R0M1Q08wWTlOcEd2YWRMOFN1RVgrb3pQdWxPYThuUC9MelVKUWhOclVnQkEz?=
 =?utf-8?B?ODIrQkYycE5JSFNtSXU3UXZJU0xnYlhVamFRZk42M1dubWIzcVc2SE9JWFpC?=
 =?utf-8?B?MWEyakpDay8xRzBzOU9tNXlRL1lwYVlMR3ZuZy91Z2NwZVluaWRocnR3K2RL?=
 =?utf-8?B?OHdrVWRVSGVkWGRWandlQ2ZhNDVJRG5WMFhBRmtzN1ZkbTBpdlFST2RIVk0z?=
 =?utf-8?B?YXE0Z3ZDN0QxS1kxZkVUZW9jQmlMakU3MnFBZGkvRXJMelg2clF2c21qb2lt?=
 =?utf-8?B?YTg3MzB4VWJJK2hxeXBiWHdNWjRZZGFmbC8rRGRJTWI2SFJNNEtFeFo5bHVy?=
 =?utf-8?B?RDNocVhMRGpGOStvVjR2VjREbHluLzNIMUhzSDExRitQZEw0YVBoY2VTTTJH?=
 =?utf-8?B?U1g2TU91VEdDNVYrVzgwa1Q2WjZrSU1UZzdQdHhzdWFVRDR1RTk1QWpqUC9m?=
 =?utf-8?B?dUdIcUJmTjllL1owYmxQOTNjZWt6cWRyWnNQRGJTWGNMQ0NadXBXc3dQeWhw?=
 =?utf-8?B?RjlWekFVLytVVUhLZlBBUmt2WlJtR3Z0ZGwyMCtSdW91RDhFcDlDbnNPL002?=
 =?utf-8?B?eXUyOGE4OVN4N3dDc1dqMU1UQm9CNitiYUVwU0E2Rk9kQWRqWnVOM0JwV2ZY?=
 =?utf-8?B?WFM4TjdOUzRqc2VpenVpeXRvckVIaHArWmk5aVVtbmpaTExiamsveVNoSmM2?=
 =?utf-8?B?QitMMDBsWkVuM012SWF1ck9JOW5xZVRTUmUyUm1FcWpxZEQ0bVN0U2djLzMx?=
 =?utf-8?B?NE5TRnAxTnZ3Yy8yRGNoQ29memVaWllDS1RPNDVWWU9uRlo1ek1LUnNTU3pP?=
 =?utf-8?B?WFlYcDFpWlZPN2dxUHVJNWtZcWttekNrdWRSYmVCM1hKZUtXREEwUEVEbS82?=
 =?utf-8?B?SzRQOGtsZzZlNGhTVVdpbXRDZ04rNGI1bThhR25HTk9UdUJKYzNSeERWYmNQ?=
 =?utf-8?B?TkwvVHA3ZnIrNmVDZXk3QlpLRjZKQ0NZaWpPTEZDVkZSVnB1ZEVDRk5vdUdT?=
 =?utf-8?B?ZEQ1WkhZODFUdERGUnYwd3Y0b1g2ZVowVXZYVlI3YzhaYUFJRnBUL0JUYjhq?=
 =?utf-8?B?NDJDVUdGQTBhRnlncVNjdWROMmVmZzc5c0NlKzlZY3o2UDFtd2VYbHFtL0Vp?=
 =?utf-8?B?RGt2N2NZM251SVdIU0xzWERCdDRGVUp5SXYzVHMxZHRTNE83Mm8zcXE1bVht?=
 =?utf-8?B?c3luUFlnUkZTeFlaRDhjd0pyN1ZmVnlSeWRabFVnbXNiSGF0Nk1GV3p1Vk85?=
 =?utf-8?B?RGM1NElPRUhBa0NHVHFHV0xIYWdJUCtmbE1PaWVub1UxaW8xZUhDYXpQZms3?=
 =?utf-8?B?UG9uMHlJRlZ4eUg3eHFZZG4zZjcrVjJWM3NLWE13VzRkYzhFM2lqZEZOdFA4?=
 =?utf-8?B?ZzJjZi9NTTBaQ3VCamp4TldxcWpobkJWbmUzaFp0ZGVXZmpCa3NVdWYveWEw?=
 =?utf-8?B?Nnc1ektoRkZhNkIwcUFtWk00a05tb1J6c1lVRVMxemhRdmh3cE94ZkxSUzNz?=
 =?utf-8?B?UDBUMmFueStqVkNLN1l3QnRqWWlLWk54bmVCUnJJZ05PM1RzZVM0VXJNYWJU?=
 =?utf-8?B?cjdTWStQYm1pamFGcVAzaEpJUnVaT3hzRmlSb25Feks3RnN2OFBGdlhMMlEv?=
 =?utf-8?B?QWs0KzRCMHpsS3NJdzdrWEtSNk4yeXBXdjZqLzJ1aEJsZWJJcllFNU5rTHZK?=
 =?utf-8?B?SUNnNmxBOURyK3FVTTdWaVFIckV2TUcyb2xEaEhYZm5ZMTdZS0ZnRTFMNCsw?=
 =?utf-8?Q?0fhWN4z/FxbNqGd746QH9DLTBfNUq9/9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZKMWxpYkpYdjJUZ2xhNk9LVTNwOEZoUzkwZnB3ajRIUFduZERnUXhWN1Uy?=
 =?utf-8?B?aS9qOEpybG84UXhNQWJCUE1HTUtYWk8zZ00vaTlMODNZdjBrdjNDL0w3QVhY?=
 =?utf-8?B?MitxdC8xYnJHWWJIV2FMa1g2Vzc4V2JaMUFFckVQeDlHbjQ4cWZIMGNlODNq?=
 =?utf-8?B?cW05Wk84RjhqQ2JlczZiSFBwUm92WGdmNnh4RCt0Wk42RXh3NXBuMjEzcWFr?=
 =?utf-8?B?Q2RDM0NoUzFDalI5eGR3UmJoeU5QN3c0OEZsc09ESlRUQWRZRy8yaWZDbWEy?=
 =?utf-8?B?Q0ZsMEdEWDNyTHdYS05uK3VmdCtvNGlwN2FIV2I5MXBGUlNFSTdvem5oZ3Zx?=
 =?utf-8?B?Sng5WUVXUldad0EydjVFanQrS0NyeG1XVWxDVWpvbEh4RE9BSXNlVTdraTRt?=
 =?utf-8?B?QTVwN1ZIL3N5R3p4S1ZiaFIrTzBTWDZ5c1RJeFJQZUUySUpUZlovUDZZMSt4?=
 =?utf-8?B?UjNYc3piSE9WL3c2MXcvbktLeHY1TW9DVUprdFNRUlYrK1BXc2NvNS9NOHZK?=
 =?utf-8?B?YWd6THBnNmVXNk00UlZ3bDAxU1RNczFzTFZlTWZldzVoQzBzdkNLd3pFbWc1?=
 =?utf-8?B?cXAxQklnSmVBV05HdGpCT2xSa0JxQVQyVmhFeHdzdVpRQkZ3djhZcDFTblFr?=
 =?utf-8?B?bHlxVytDMDI0c3AzYXNaSElkR3h2cDNSV2FuZlRPcjY0Qk1saTdab1J3dzZM?=
 =?utf-8?B?aCs4QjYvVDF6cHJIMjlBaXRlbTc1R1NUbXlhdXQ2TERrNFIyTjd6N2oxYXhV?=
 =?utf-8?B?MXpvMU8vVG9uMDRXTDNWd3VUcndHeGtUYnpnNUtWS0wxRUZsQ21mZm43QnF4?=
 =?utf-8?B?dXB1Tk1Da0llaGV3emRQemE1dEMwdXJ1NWxsRkZqTmRJbjFCeDFKQW5TV2dH?=
 =?utf-8?B?djBjR05ud0RHak9wYW1CdVBNcytCWHhaQzV4WEQ4Q0JVdU8wZlNtS2M1NGc2?=
 =?utf-8?B?NjU0V1hqRjk2eUdkSno1czcrVWJtOWVIOXBjUTFPQ1VrWHFrRWxCbGlrN05n?=
 =?utf-8?B?aDBMSitLMWRkOTZFdG1TSis5V3hLSHZpS2srUHFqMzI4dkZmNGR2Z2VaYzdG?=
 =?utf-8?B?UjNKdWFST2lxTUJjdlJES291NWdsNUllRFVCQlNOMTNRM2ZTTm1HZHBuOHVs?=
 =?utf-8?B?d05MdVN2bHVSVi8yNkk0YXAreWtrbnRnVFBEWUhWV1RsQUV3NUNraW5FazV5?=
 =?utf-8?B?YnFJVTdKZ1ZLbU9IOHpjN2gxVHZqZnFaSk5URm9sZUh3MXhzQ0dXVDhnRHpw?=
 =?utf-8?B?bk1aZWo2dWxXRldvN0xwalhBRUxZV3lDYnpMa2dWOWVIUXFGMjlGWUUxaWJH?=
 =?utf-8?B?UjJSSzJnblQwazVtamp0L1U2cXBxYTVQdDR2enloU1lPejArclBzdnluOWcx?=
 =?utf-8?B?VFUzdEZlb1Z6NGF5bUxOSmdCdkJMejNkbWV5N3ZmNEZzWW5QOFJJdFkwNUkx?=
 =?utf-8?B?aGpYOEx0SFBoNkRjd0tBbkRkdVhLVytMMlYrWXllR050ejl3RU1UbjZLeTdi?=
 =?utf-8?B?QjdRMTViUnQveTAxcURBaFJ3UURnRFBnL0tlSnprMWtPYzlrYjE4K2FxYUl3?=
 =?utf-8?B?RHRGZmpvZDJGZXB1OXp5aGFST2NSekM1S0tQNFZiWHp0MlBkSzBqamNMMGZU?=
 =?utf-8?B?MXpKb1BudDRZeTJSRU9PZjY0M3N4NUNvbmg2MWlIZWcybXA0NzJ5bGZFR0o5?=
 =?utf-8?B?blVwZnFTQS9mK0VYajdkTjN1MjhDS2pTMEVWK3E0TDgwMnNMSnNUcy9iU3BF?=
 =?utf-8?B?ak9PelpUelhEZmcyQjRqcW80RnpaVDIvU2twamllS0trUDJ0TS80OFNBUjFQ?=
 =?utf-8?B?V2JFcXRQVXJaSU1BZk9HQ216VXc5NnlKRy84TEthQ2F6VGdTUzRJWnZ6Y2Qx?=
 =?utf-8?B?U3RHdEpsWmpIc2FyQUp6WEkzMUJtWGFBWGN2VllrMm9FQzQwaFJsclhOcmlj?=
 =?utf-8?B?ZnNweWpGWHNiVVpBM3dZbGNaT3dlZ2JUOWpERE5oZElOWTRSODkyNjkxNVVu?=
 =?utf-8?B?ZG5GY3VjNDQyenlLb1NtZnRlUCt1N1NhMGV0dlJ3VWFySW45M2xLVklFTVdM?=
 =?utf-8?B?QTg1clQyY29NKzlkbENGZXduVXdFY2hramh3WnBlcGUyM21jMGJBaUFaVjhI?=
 =?utf-8?B?L1dMYjVmYjA5YWxvdE9YYzR1dXNqdG5oYm5sSnNKQzRHUVN6cHNNNzdOM1Nl?=
 =?utf-8?B?SFpkOHRxMHJCM0cxck5zdWpHU1cyTytxR3FuWkpDZEJTRmhEMzJHdlNDZUxr?=
 =?utf-8?B?WkNiMjlzdVY2Wkg4dEY0d2l2QjlWVzRxQ0lnVGJpeEF5SW1FOGVTQ0hkN0Vh?=
 =?utf-8?B?RENRL25ocGk0Rm1wR1ViZUlXd1ZNMUpPZTF1VDVXcHB0aWw0REtvUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863a59d7-d895-4637-8136-08de4f7db4a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:50:45.4623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4lXNnK+uS273h7k4IPtwrKZXMGhl0WJ5Ota/9DvxejLa63mdyiPDTVBY889tWLjlT+txOy8GWLQkEqesbN/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6609
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

On 09.01.26 12:45, Jan Kiszka wrote:
> On 09.01.26 12:34, Simon Glass wrote:
>> Hi Mark,
>>
>> On Wed, 7 Jan 2026 at 12:38, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>>
>>>> From: Simon Glass <sjg@chromium.org>
>>>> Date: Wed, 7 Jan 2026 12:02:27 -0700
>>>>
>>>> On Tue, 6 Jan 2026 at 19:42, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>
>>>>> On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
>>>>>>
>>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>>
>>>>>> This work-around dates from 2019 and grub 2.04 which is quite old. New
>>>>>> builds of grub don't have the problem and old boards presumably use an
>>>>>> older U-Boot, so don't need this.
>>>>>>
>>>>>> Drop it.
>>>>>>
>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>>>>>> ---
>>>>>>
>>>>>>  configs/mt7623n_bpir2_defconfig |  1 -
>>>>>>  lib/efi_loader/Kconfig          | 10 ----------
>>>>>>  lib/efi_loader/efi_boottime.c   | 26 --------------------------
>>>>>>  3 files changed, 37 deletions(-)
>>>>>>
>>>>>> diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
>>>>>> index 404380558f2..d75168a72ed 100644
>>>>>> --- a/configs/mt7623n_bpir2_defconfig
>>>>>> +++ b/configs/mt7623n_bpir2_defconfig
>>>>>> @@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
>>>>>>  CONFIG_TARGET_MT7623=y
>>>>>>  CONFIG_SYS_BOOTM_LEN=0x4000000
>>>>>>  CONFIG_SYS_LOAD_ADDR=0x84000000
>>>>>> -# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
>>>>>>  CONFIG_FIT=y
>>>>>>  CONFIG_FIT_VERBOSE=y
>>>>>>  CONFIG_DISTRO_DEFAULTS=y
>>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>>> index 13e44be1d06..5585c841c27 100644
>>>>>> --- a/lib/efi_loader/Kconfig
>>>>>> +++ b/lib/efi_loader/Kconfig
>>>>>> @@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
>>>>>>           hardware we can create a bounce buffer so that payloads don't have to
>>>>>>           worry about platform details.
>>>>>>
>>>>>> -config EFI_GRUB_ARM32_WORKAROUND
>>>>>> -       bool "Workaround for GRUB on 32bit ARM"
>>>>>> -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
>>>>>> -       default y
>>>>>> -       depends on ARM && !ARM64
>>>>>> -       help
>>>>>> -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
>>>>>> -         workaround currently is also needed on systems with caches that
>>>>>> -         cannot be managed via CP15.
>>>>>
>>>>> This also states that it's needed for systems that can't be managed by
>>>>> CP15, what systems are they, how are those platforms addressed?
>>>>
>>>> I'm guessing that some systems have level2 caches with their own
>>>> software interface. I certainly have seen this with Tegra2/3, for
>>>> example.
>>>
>>> This is already being discussed in another thread on the mailing list
>>> started by Jan Kiszka:
>>>
>>>   https://lists.denx.de/pipermail/u-boot/2026-January/606817.html
>>>
>>> My suggestion would be to drop this patch from your set and let that
>>> thread run its course.
>>
>> Yes I did see that and I was pleased to see that someone else was
>> interested in this topic.
>>
>> Still, that thread does not actually include a patch. So let's see how
>> it pans out.
>>
> 
> I'm played with turning off the workaround on a socfpga target, and that
> apparently causes troubles:
> https://lore.kernel.org/cip-dev/ba08992d-17f5-4689-b05c-93af612e4539@siemens.com/
> 
> I'm inclined now to keep cache disabling by default, only enable caches
> on known-good boards. If someone has a hint how to reliable identify
> targets that have architected CR15 cache control, I would use that as
> input. Otherwise, we need to maintain a positive list in Kconfig.
> 
> Along that, the control may need renaming because the original reason -
> broken bootloaders - is really history.
> 

 * TODO:
 * According to the UEFI spec caches that can be managed via CP15
 * operations should be enabled. Caches requiring platform information
 * to manage should be disabled. This should not happen in
 * ExitBootServices() but before invoking any UEFI binary is invoked.

So, that last sentence points out another issue for targets with
non-architected caches: The current logic seems to disable them too
late, right? Should the cache disabling move to do_bootefi_exec?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
