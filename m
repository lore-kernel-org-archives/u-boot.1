Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64578CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA4E7809A5;
	Mon,  8 Sep 2025 16:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HwtODcYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F32F82AE9; Mon,  8 Sep 2025 16:20:52 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D516480077
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 16:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5xdy+couQOCerkWKgMGdK7GkHC6Y5dNDeBxhBDgQSZZAKOVDcaW9Su/HZXWyP5Mwkdh0sjWB2vdCEoY5xzatMcbuAHurRXJoT/8Oh5wPi1pgpNX9ruVO4FwNYn/HFHFcdJGhNJO5uPmdLLgb8M7eF0TVMNRbf0GXkAuxrIO6ht2LVtK+YONf6lDhLlaXP8QjZJhMLdktHHAi3vbPq0HLNahYSr5sm1VEXHD1NVQ3YFXz1OPStdx444GEJoLbdDdr8qG9O8UoY/AkFZJDq8hW/OYhPjuOhNF/TM1lrKAFN/fi6rHk0I6QcaDXK4oC2U4u/SGErvq+oIR1+NBGjGKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afK7E4SLFvLNR9YH2/kBY2N3p0MoziOHIZ0j+QdRce4=;
 b=mHrD0DDyrGCD4CKTvL7yv8ItSisvrBqyQB5nehODUvJ0RlaRuK5VTs++xsp8Dp66K0OHJTTGIxtBYDRIHCy05qmbiEjva5yumPRZ8DLtB0IZ6igDZ7OzY8C4SPwPZ0Beve4U2JG8JKsl9EDx+AB7v/DBNXBVn8yqIIdEFCGNvV89olzOp+WR0ALRLYXQ34bwOXbLI0buqQxK9Cj4rOK77BmV+XKUZEa0b94HRQnlZ+oZmVk9IhVi5uPfyMcJDMockU/Ek3XQk3hdykbDNXZDncBT49cjDpbXD0RSnmC23P56CmQLucS4lkzLeJmaSi5axI7UihOTkD4l9pctRKBXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afK7E4SLFvLNR9YH2/kBY2N3p0MoziOHIZ0j+QdRce4=;
 b=HwtODcYRVR3fCOscmkDm48lLaJokdXw1MPX+esra2wR2Trr1RJtz2pk/RFS/GIhG0Tz4Wr+1pcVwdiBrjYSeGIYaRrXYyAmlX6odvHKpJzPqZu7P+Wmly2qj+1UHC71lB0SwdbbAffwmujoJIMLmvnwX94HxVpp+wxp3urHXLZ8hTovjSPlfKFCcg/plIcoL62G86HgZvJpMkgVxIO86ySp1pcHA8zWN8a5m6DZ8wy9AF/tuBmQU/KIn7/o8s1r4uCizGVAEZBEL7NfEpZxpbTuIXZIk3OTHmVlIpExafGxvDVCM3CoaXXAqVVoTgG3322inwM88NsbF0h1OJADxyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by GVXP195MB2501.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 14:20:44 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::a4ad:a30e:789a:db7b]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::a4ad:a30e:789a:db7b%4]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 14:20:44 +0000
Message-ID: <8373045c-92f8-49ac-8b74-939d865ff0d3@phytec.de>
Date: Mon, 8 Sep 2025 17:20:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v6 0/9] Add support for dynamic MMU configuration
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Cc: d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, trini@konsulko.com,
 nm@ti.com, robertcnelson@gmail.com, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, m-chawdhry@ti.com, a-nandan@ti.com, afd@ti.com,
 bb@ti.com, u-kumar1@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
References: <20250905081902.489345-1-anshuld@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250905081902.489345-1-anshuld@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::6) To DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|GVXP195MB2501:EE_
X-MS-Office365-Filtering-Correlation-Id: 24803d55-479f-4503-5d7d-08ddeee2e5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHFUU1UvVFdpb0o5RUF2ZkI2elpuR3FQdzNEUWd6c3REU3pNYjErd3oyNmJr?=
 =?utf-8?B?VG54V3QvN1BMbnQzVitqQkYrL2RNenBudjhNSzFTdm0vbnMxZzQzdmRFRlF5?=
 =?utf-8?B?bjNCd0I4aDJOdGJseUszcDNva1ZCWXkzZm1HbUMyVW5YenBYcmt0aTdLZ2lB?=
 =?utf-8?B?VzdoUVgyR05wTXNWQUpTRXRjWmZGMW5TdHRYci90d3lGWXRFZVdRZWRhRXY3?=
 =?utf-8?B?TjVJb3ZWWC9aMk56cHV6TmhPRjhJY3BERjJHRmlpallwSi9xT21JWWJKS1Qr?=
 =?utf-8?B?bU1SbW9INFRmMnVkaitNMStwNWlRVUFXamZrMXAzUVpEZjNHWVBmZTJ4cjNs?=
 =?utf-8?B?emc3NTY0WFB4c2E5Zkh2dzRMeFJsNzhDNTlBZjBYMWFIc2lkMEtBQW9hQ092?=
 =?utf-8?B?ajlJa1VEWXF4em5Bb0doVTltVHFSYWQrWVhYTEt0NmQ3WmFyd3NkcnVicjRx?=
 =?utf-8?B?aXN4VWlBUFdXUStkUkw3eUl0RjlSbVAyQkRxb1FYS1l2YTRMVU1raW92NFdS?=
 =?utf-8?B?QWE4Q01OY2o3eFczMi9iLzNGOWhmNFlLNVNvZU02eFFuUEI0U2VkQUhsRTNF?=
 =?utf-8?B?TnhWVVZ4cktERzJIV1h6aVMwcFAza0VDUnRNeGx1VkIwRnZxZ0FNRGdPQXp0?=
 =?utf-8?B?ZndPNnlhcU1xc0s5ZTFEOGdCMm9pSjZOYkNhaFZIMWt3TWlDcEo4Qk1NRWlq?=
 =?utf-8?B?eXhyNFdIUDdJL1dJRDlIelU0OTZLSmFvZ3prb1h0YTlaeVFxRmEyZldLY0pH?=
 =?utf-8?B?REpza2FGQ2tvcVhNWkdzYUkrU1QxTTZmTVp2SGZkRjRMRkhZcnArVnpZMlpZ?=
 =?utf-8?B?bmJpQ3FKZGtpSGp1ZVJ2VFRwdnFwQ3RCVkhoYXRyaUMyZ1o2ZWFTQ3BWQ3ha?=
 =?utf-8?B?eEppWFRxOHhYNjlSNVZvemlKamhhY0dqVmxPTHdiUGdLcFFGQkdZQWpEeUND?=
 =?utf-8?B?UUU3TjA5RktySTh0WUhUbVovSmQ5TGVRUytiTXQ0R2ZMOEpXUGJrRXNSRXRa?=
 =?utf-8?B?RmpydklzNDUwV3M4eW1UQlY2cEdOMk9QL3pCc0kyc1l5a05peVRlUENZcjJm?=
 =?utf-8?B?b2grOUlzd0xyYmwybFlBUU9kRFdoMHVZVk11NStRWXRqWDdBK2NhRG5VWk5C?=
 =?utf-8?B?ZUsxTmQ4bGUrYWxLNUQ3SWRwTXZYR2k3NnFRN0szdU9ISlNxUEFFTkpCeWV3?=
 =?utf-8?B?NFZPMkNrY3BCbG1CZHBEaXphd0Zld3B6cGdVZmlYaXE5RG96QnR4WU9Ybzlt?=
 =?utf-8?B?WlZWMnUya1BwRWF1c2JWUzN0NzR1b3FxNDNUTmpaZ3BQMlFqaGJ5T3F6STgy?=
 =?utf-8?B?aUMrSDBLYk02ZjFqa0NCZW9XZWlUYkNLeUtKSUJTY2xSUXkvMVpGd1FzWXFS?=
 =?utf-8?B?cVIwelZzYzVvRXM5U0dRZVp4WkNxak5lMEFJSHVFRWZoa3BPOVl6T09qaUdl?=
 =?utf-8?B?VUJIaEt5NmJHamlXWUFCYUVnZzZrb29FenlDRC9QT0xGRlFidm93THlKbjNB?=
 =?utf-8?B?UXJncGQ5OGlJSnp0Sy8vVmI4VVdNRVpEdHVHaWFLQUMwSzRxQlBKWEk0RXpL?=
 =?utf-8?B?RktXWVc2QlI3cTFxYXUyOTIxR2RidUJncGhDOVFpYWV3RWEwbU8rdGhSWUZN?=
 =?utf-8?B?a09JaGpVcFRwYU5KK2IydGYrdHVzenF6eVZVVWhDNjFtQnVPd3R3ZUpCbUJu?=
 =?utf-8?B?Q0VUaEZhU3FueG9iNzRubTBHTnhMeEFIRjBVOGpxOWpWc3BWUzNmU00vNURl?=
 =?utf-8?B?Y0JkUG1aQnNvV0ZrbmorWmRkSWdPU0N5cWcxRGRaUktlaEpHblVJRFNCS2Z0?=
 =?utf-8?B?OUFXV3VKc1Y2SGgzZUxReXZ0Y0VrUnk3cHUxV29jQVhabTVEWTBCVzhHUDdV?=
 =?utf-8?B?enByZ3JUOVBubzl2aHhlRVQ0QlNKMEZFcjFMaUFQTjU1eXU2c2NzQ1BxbWln?=
 =?utf-8?Q?djZ44Olp+W4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VkSUw0RzVQRnJTOFRDV094TjlnVUNBS2VtM016QVl6OWJ0bkNQeDY2MWpD?=
 =?utf-8?B?cnBoWUJQOXUzS21FQ0JEZ1hhaE8rZzJKdjBZSlZWUytIRk1EMXZ3WS9yK1Z5?=
 =?utf-8?B?a29QQTlObEt3OExDbHJua01MTmtZamUrOEFicERpZ05mY3dXWTVwUUQzWkt5?=
 =?utf-8?B?VThRY3JZWUE5S2xET0YvSzZ5OXYxcnZZcnVQMExCK3ljazZQMVhoVkRoejRG?=
 =?utf-8?B?VnlJczJzUzVCd0tjTENpTlQzOVlKaCttcU15Ym9POHMyN2EzOURaaVFWbHcz?=
 =?utf-8?B?c1FudWNZb2cvbkNNOFdwYVZRMTlTaEJOSTNMdDBJd3hvOFY0enQxWFZTYXc2?=
 =?utf-8?B?N29RNUYrRnRYbThReEcya3lRbEtvMXNKMlhFUXRkdEF0ZHdlajNBZ09NZ0Vz?=
 =?utf-8?B?Qms5dEtIR0FCcVF6UkwxOXJiaEg1a0NhTXZpckNZREY4MmIwYWNNZjFnRHcz?=
 =?utf-8?B?MjBtK3U3cXpiMEsvV25OdkdGWEdJeHFIK1pHY0N2RDg3MzNnREdqTkg2dnpa?=
 =?utf-8?B?UE1BdG1hcU5mcm1hMTR0MjM4Y0Z6dDFVMHNvVzcydUVFQ3k0d0lOZjVLU2JF?=
 =?utf-8?B?ZlVTVllSWGxsRlYwM0hoRjRBZFp1aUdqS2wzdUxZRTd4c3ZQM0Q3UG9CN0dN?=
 =?utf-8?B?YU40NkNnaGhUZ2N4bGRwVGIwenNoNnV1QUE0TzA3amhQUWppb2JsbDRkNDVT?=
 =?utf-8?B?ZzVYQ2RweEN1Vk4yN2lKMzhjQzNmV0IrcmxkNnJiOG91YmU4SjJDQXhpalVa?=
 =?utf-8?B?c0oxN2JnK2xyRVVRVEFNWEU1cjk1Tm1mcUcwL3huV2FYT0NLOWtoUHh5cFlT?=
 =?utf-8?B?NkQ2N3E1cW5keStvTXM5eFRwVnpsYWRtK2MrSDNFWG1sVENxUGNqMU5zNEd0?=
 =?utf-8?B?SHNwd0hWYlVDdlJib01RSVBPYjVoSExVNDVBK0dMY3diVkxtRkFQRVg0empv?=
 =?utf-8?B?TjU5aEJIWFRTTG5tYXY4UFllVlEwQmRuR09QRnA2WmxETmxDVDNLRmZMSkdH?=
 =?utf-8?B?aytnNGRrNmFFRW1EWXIrVmZEREM5V0FlYjhKbWZHRXRlQm03OU5yNGFiVERM?=
 =?utf-8?B?cnVNbWJSczhRTXlHVUQ4b1hvSmFxd1NQbm9aNHRjcFAzWEJDOGJTSzNFR0VG?=
 =?utf-8?B?TXhxZVMreFBLcUJmdHNqYzI5RldKbE1PVDdvenF4VE8vSGZlbUljOUZQQnd0?=
 =?utf-8?B?Vmk1MVk2V1Q0UFMwNzBQZ1ZFdDBVRUdZOTIvL2Z6WWd0MTZQMzJCbVBPSFZO?=
 =?utf-8?B?VTVuZ3NjYkpMNjR1enNYdzJtMHdYNUJNamVPOTVJU3Z0Zys4QVR5RllpYWdL?=
 =?utf-8?B?R2p3VFRSTThKR1Q0cHQzT0d4bHBlWFVoUkFLZWdVNWM4TXBZb1hjaUFSZ0h2?=
 =?utf-8?B?SjBmdjhKZXpMd2JaTk5TSGlCaFNIMVU1U1dhS2hPNmJQb3lXTDZoeU0rNGRT?=
 =?utf-8?B?bVF4c0VsRHFJR0pWMWp1U1I4L1JYYjhKZUtDQWgrb3h2ME5FeWhVQ1BicVh1?=
 =?utf-8?B?NU5CWnAraHp1SEtiVzJmbFkvQnYyQ2hGYkdLNmZXdHR4c1BKLytrM3dJOUJ5?=
 =?utf-8?B?QjNMdE14SkxGL1BFQVlzSkpKVUtDZTN4THdiRDJmQnlFTU41cUU1VVBDNlBD?=
 =?utf-8?B?cGZXejdoUjZpNzNtaVp2eTBlalZLa0xXb255WGtGQ0Z4TXJhZHRVMXNuWVhV?=
 =?utf-8?B?RWxnY2dueUNMR3hJNHlBVEwzcTBvNUcrdFFTNU4wc0xtYWtiRWFlMXlZVjdQ?=
 =?utf-8?B?eCtQQUFuK2ljVmF0L2dzeXFRdFFVMlVJQ2lDbEErLzYvK2RaMlFGYVpSS3Ir?=
 =?utf-8?B?bUVYQmNtNEw5T0dheTB1bzVEM1JMbVlKenV3VnplNnNZbGVHRm80by9CVHpo?=
 =?utf-8?B?citCd0RXcFZEbFI5azBaMmhDS21hT2gwanNkV1lsK3p1Sjc3SHJLaUF3U0lx?=
 =?utf-8?B?bVZoYnYrNlQ2NnFvVnBNcEtjVm1Hck1zWG9iQk9MT01QTkVvU0hocXd6ZEVB?=
 =?utf-8?B?TWxrQjdyL1QvbURmYjc3NEllNmFseUpzd0ZBbTJkcHlwc0tKNzNicEJSK2dq?=
 =?utf-8?B?VHh6WUp1NmJHZXhRMzVKMytqbGlvZG4xQmtNOHVwQlpRWCtTZXVjb2NKYTZJ?=
 =?utf-8?Q?aeL1cAsp/G73tkqvW2/yIYosR?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 24803d55-479f-4503-5d7d-08ddeee2e5ab
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:20:44.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD+Nj7VOJJgMHUVeIClbFFRNAJsc7NGALe26vfdWBarw5vjyhc7le5Gr7XlKQ2GSPU2goy38rdc4lZMzOxHrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2501
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



On 9/5/25 11:18 AM, Anshul Dalal wrote:
> Hi all,
> 
> In U-Boot, TI only provides a single memory map for all k3 platforms, this
> does not scale for devices where atf and optee lie outside the range 0x80000000
> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
> 
> There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB.
> Furthermore the second DRAM bank is mapped even for devices that only have one.
> 
> Therefore this patch set adds the required functionality to create the MMU table
> at runtime.
> 
> The patch set has been build tested on all effected platforms but boot-tested
> only on TI's K3 EVMs and the beagleplay.
> 
> The following effected boards have not been boot tested:
>   - phycore-am62a
>   - phycore-am62x
>   - phycore-am64x
>   - verdin-am62
>   - iot2050
> 
> Depends on:
>    [PATCH v1] mach-k3: fix reading size and addr from fdt on R5
>    https://lore.kernel.org/u-boot/20250903111704.530700-1-anshuld@ti.com/

For this series,

Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am6*


> 
> Best Wishes,
> Anshul
> ---
> Changes in v6:
>   - Make use of generic MMU APIs
>   - Extend core U-Boot functionality by adding mmu_unmap_reserved_mem and
>     mem_map_fix_dram_banks
>   - Keep same memory maps for SPL and U-Boot proper
>   - Add fdt fixups from SPL stage for reserved memory nodes
> v5: https://lore.kernel.org/u-boot/20250703133533.104758-1-anshuld@ti.com/
> 
> Changes in v5:
>   - Don't create carveouts for every reserved-memory node
>   - Only create carveouts for ATF/OP-TEE
>   - Expand the call to k3_mem_map_init to vendor boards as well
>   - Map area for framebuffer for CONFIG_VIDEO=y platforms
> v4: https://lore.kernel.org/u-boot/20250618124210.1936140-1-anshuld@ti.com/
> 
> Changes for v4:
>   - Add call to k3_mem_map_init for beagleplay
>   - Mark reserved regions as non-cacheable
>   - More debug logs
> v3: https://lore.kernel.org/u-boot/20250617135844.2873701-1-anshuld@ti.com/
> 
> Changes for v3:
>   - Remove unused memory regions in SPL's map
>   - Add runtime addition of MMU entry for the framebuffer in SPL
>   - Refactor k3_mem_map_init to use standard u-boot APIs
>   - Unmap reserved-memory regions instead of keeping them uncached
> v2: https://lore.kernel.org/u-boot/20250610160833.1705534-1-anshuld@ti.com/
> 
> Changes in v2:
> - Removed dependency to:
>    https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/
> v1: https://lore.kernel.org/u-boot/20250602120054.1466951-1-anshuld@ti.com/
> ---
> Anshul Dalal (9):
>    mach-k3: use minimal memory map for all K3
>    mach-k3: use custom enable_cache
>    arm: armv8: mmu: export mmu_setup
>    arm: armv8: mmu: add mem_map_fix_dram_banks
>    mach-k3: map all banks using mem_map_fix_dram_banks
>    arm: armv8: mmu: add mmu_unmap_reserved_mem
>    spl: split spl_board_fixups to arch/board specific
>    mach-k3: add reserved memory fixups for next boot stage
>    mach-k3: add carveouts for TFA and optee
> 
>   arch/arm/cpu/armv7m/cpu.c                  |  2 +-
>   arch/arm/cpu/armv8/cache_v8.c              | 50 ++++++++++++++++++++
>   arch/arm/include/asm/armv8/mmu.h           | 24 ++++++++++
>   arch/arm/mach-k3/arm64/arm64-mmu.c         | 35 +++++---------
>   arch/arm/mach-k3/common.c                  | 55 ++++++++++++++++++++++
>   arch/arm/mach-k3/include/mach/k3-ddr.h     |  6 +++
>   arch/arm/mach-rockchip/spl-boot-order.c    |  2 +-
>   arch/arm/mach-socfpga/spl_soc64.c          |  2 +-
>   board/beagle/beagley-ai/beagley-ai.c       |  2 +-
>   board/dhelectronics/dh_stm32mp1/board.c    |  2 +-
>   board/phytec/phycore_am62x/phycore-am62x.c |  2 +-
>   board/phytec/phycore_am64x/phycore-am64x.c |  2 +-
>   board/renesas/sparrowhawk/sparrowhawk.c    |  2 +-
>   board/starfive/visionfive2/spl.c           |  2 +-
>   board/ti/am62ax/evm.c                      |  2 +-
>   board/ti/am62px/evm.c                      |  2 +-
>   board/ti/am62x/evm.c                       |  2 +-
>   board/ti/am64x/evm.c                       |  2 +-
>   board/ti/j721e/evm.c                       |  2 +-
>   board/ti/j721s2/evm.c                      |  2 +-
>   board/ti/j722s/evm.c                       |  2 +-
>   board/ti/j784s4/evm.c                      |  2 +-
>   common/spl/spl.c                           | 12 +++--
>   include/spl.h                              | 12 +++--
>   24 files changed, 182 insertions(+), 46 deletions(-)
> 

