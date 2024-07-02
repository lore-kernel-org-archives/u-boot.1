Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46306C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 12:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B9688096;
	Tue,  2 Jul 2024 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="3x7zebNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B37883AC; Tue,  2 Jul 2024 14:59:02 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63DA587FF7
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAOuRq988Hj08vHbumBf9E/c4fBzKSgoXQZ3PheJ+tIMUwPav/j6MqSfpj/cBU5uf6PId3TBEVF1DAQWPr7w9NAHVlCyA2jcpDru0xqWpSLcXVFT/an/6tFf3au5aWCZW73GErOv4zbAbbEiRf0oyrh+fSd5Se+4vk3DnCdqR3dFOndMHKuVxZTYFHuBZnL4oEB7gEZA9Nl52jsjZ00ShRvvI8voagOmW9OiqdncNqtFyatxiv+KVjGzKHtKlQfEl4YK7ckwEEdbHdb6JzDxq0apNv58jFXmeh4AVWP9bzcS7VnAWwts0MzRT2aVL7pmp8vFun4R7gLg+sItewy9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58tyml8tkjtPZ72Q9uGH731M8yifgdm9ZDHQzCBEcJk=;
 b=mte3kqviMCQElVIG89ZXj/Md3KocHVguN0DjQBA6COreJtb2ELwPGbdthkUY4Q8Y5s9Z5jHf9twA69BNIrNn7pTv63Mi1FJpsc+kg2LH0Gp/R1Ajig9Qii/0H+BPGqc8CLgSB5df0AsMgdVwpZ1f3Klc/7Ar9/g0ZtrtVBeRiWRV0dof/kfnXXqZsGVBJJsydC6qTkVA/34p8SdQwzLjjTfywN67i7nIOsJP0igr4uNSKqIJPAIm9rPKMWwfeWByGDMN+1rdBz38nsV4N6hEvzx/rSJphgP3c6lZv2RCEV71diq8rxBFPDL73Rmk+zBF5yJkPFYl+5x9owswIaPUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58tyml8tkjtPZ72Q9uGH731M8yifgdm9ZDHQzCBEcJk=;
 b=3x7zebNQ3p5lYDnOtjO1tchjnSvJ4b+XTSyfP5JtDguD8UWj3tGqaeV4r3EKiVcvTaTjLrOgzR2eFarVBVr/2vCuDvxWfZr/H5l6vXLZUAUjM3D1etIB6SnRqz1J+jz981lTUn461qO40Qq1PU5hsHrITVNd9L0E/cSloh93bqtGZeuTDbfCQiv2+ORfi7xH36SG3HuuaLmPflXuLLiJ6/ro31Gi5Q4d7DA6tK25izPXQGu8mLK4lgVvFArpyxORVmTpZOIh3zToUxlg7IReYkNQqxBAbOB7UsJRLS4ITxELcqlvGF2wrl7wkggEp0AlDiRn8tkU/4v+6xfcFUeKRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB7878.eurprd08.prod.outlook.com (2603:10a6:20b:51d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 12:58:57 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 12:58:57 +0000
Message-ID: <4ae22738-3292-4c03-902e-4a7aa4b45cca@weidmueller.com>
Date: Tue, 2 Jul 2024 14:58:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
 <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
 <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
 <7687e15d-c601-4f91-b07f-a4f9d5114362@cherry.de>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <7687e15d-c601-4f91-b07f-a4f9d5114362@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef38abe-1254-43d9-ebf4-08dc9a96bc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ukt5YkIremZVaDE3VDlCOTRZQ3V6aGZ0Vld0NVZZVFFhSTRMYU81NEhZc1lN?=
 =?utf-8?B?ektrZlhabkYwOGp5QUh3dXB1RkZlZzY1azRXVHhXYXFkRGd3bzF5R084cnp3?=
 =?utf-8?B?cytlZ3dxSnZ3NjZBUDNieHRLTXY4a00ySDZpQUZZLy9Oa3VvZjgycHRJaGY0?=
 =?utf-8?B?aXRRcWhycDlLWDcrdkcxT29HSjZVQTJKK29FMFBUMzJISHZKZjgvcXM0UzFY?=
 =?utf-8?B?dEh5aTNzMllEam1kMlAyenVzWFJ0Ky9BT01qeWZsbUxEK3ZmeGNpOGJncm5K?=
 =?utf-8?B?bUF0UU5FQ2R6MUh6MkhpRy9QaWRvRHFSTUFOWDU2clVXZGtENVNWZld2cXhh?=
 =?utf-8?B?QloyT0NvNDVUNG1JYUUxUkE0YkFCcnYxQVdJSjNQR3pyMldDVU9RVkZGeEFT?=
 =?utf-8?B?MDBYc2hNMkxVQmRUTWo0VW5XOUNDak1TQlMrTGN2YklrK1J5WWczNzRxRTN3?=
 =?utf-8?B?dWU4VjV4OHQ2WEQ3OTY0MjJWNTRKUk1EbGdUaVlhYUhtd1YrdjFBQUd0amhE?=
 =?utf-8?B?K3M5OG9od0QranVlUE1OdEZxVFNQL3pVcER1RzBkbGowdi9KUk1vZjg3aWFE?=
 =?utf-8?B?R0REb3c4cWdrSjRPaGdFREQ4Y3NZaUt3WVJCbXdaL2I4MkxBbFJNZXlDRXk5?=
 =?utf-8?B?UmM3QzZpZDZqZkNZajR3aG1jMFdLUk9wOGNJRUhXTkxRdGt6c0pNZjdYMy9J?=
 =?utf-8?B?eGpuUnJnMnZLTTRyS01zQWpYUHVDVGxrbUNPVWorbS9naHN1TnVZWitJalpX?=
 =?utf-8?B?ejE4dDFIV0RHYVZ2QnpNbUZoUDlndmFDZUNBWmFKbFV6MEZSQmNvN1A4M0Ix?=
 =?utf-8?B?T1JSWm1la0dVMjZGQ29xZnhuaXNreU9vNUtBTkZsbmp1RHMrSFVvZkErNzho?=
 =?utf-8?B?UFdXWEN0VGVyTU8rRUVPeW1Gb1FjeXlSY2Q2WGNrOGVzVmg4QW1ocWh3cEto?=
 =?utf-8?B?amVwYjIxYWNNU1lHVXVMbGtKYWZXZ2lKV1RmYm9DaDdpTkYvcW5GK1lxb2du?=
 =?utf-8?B?cGsyRWlkc2hMOElWRFNUQ3BNclNFZGYreGdnVWVQRHgzV3JacUtGMWFJbXNy?=
 =?utf-8?B?MTd1Tnd0VHJIbjZ3a3lSdFRQeFprT1ZkN0xjNUFZZ0RhUWlublVWOW5uT1Rk?=
 =?utf-8?B?NjQvUnBzcGdWK0ExYnlHVEFkWlA4NTM4MTFxV3VpbUZxU212SFlHS3NXUk1q?=
 =?utf-8?B?Z3Jqd0FacUU2RUVNUjNMRUxlR3ZTVC9HWjQ4aDArZGhZaHBETDdBUG83T1RY?=
 =?utf-8?B?a0k4R3BBY2hlVmdLcGhUeUJ3WXFjT0NqWnE2WXJib2l2V1NXU2ZSRzJYOW1t?=
 =?utf-8?B?cGJ1Sm9kVWE3TDhqblV3UVFMeUladWx0YkMxQnkyazU1WGlHTnhIOGxGQTMv?=
 =?utf-8?B?OXgxQVJRQlBpSkxPaCtmWXhOSFFtUmxadjUwaloxa1FwMkdVbmpXOEpNemdH?=
 =?utf-8?B?bUtEeWFGQkNWRnFYTTQwRFVpUWtqT3d5R3o3aXR2cXFYNDRXMlU0YzhTNjEy?=
 =?utf-8?B?SEw2ZFloRzdtK0l3eHlmZ1JpK2xuQlI4eTlGam9VdnRDUmNORWdlSElDazYy?=
 =?utf-8?B?ZXZNT0xrUGprYzhBUGllR1NjbDQ4RFZ4Y0o1VVVWMFR0S3BGVWZSeURrRjdF?=
 =?utf-8?B?cGVQNm5ZOU1rdWt0eEdQY0RGR29HNTdRK1pHSGZ4TXlFUTUxbUJZeVBTN0NL?=
 =?utf-8?B?TUZ4c2N4N2JnSzNiY3BVM2ZrSHpiSlhNUlQ4N0NNOHE1OHNSbXZyY3RYaGd3?=
 =?utf-8?B?eUdsQ2xDOHNrb2VPb2FNMDZpQ3dtQW1Pek9YUEVyM21jWFlLUnB2M1BTeEZn?=
 =?utf-8?B?Q2hpZkNUbVhXM3BUbWFZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUt2VXRHTWNDVVhaZHNJNzFWUnkveTY3TGRSNDhYR2tkSXpZMkFkVm1DdkJL?=
 =?utf-8?B?YmM5cEJQRDZrRWJyTGlMRGw2OFBhanVsUjVCT0YzS1F2S0V1QWk1Sms0U1h2?=
 =?utf-8?B?d0F5YW41bFR2akRueDMwZmdzQ1g0Tm5KcjlrS1RFa1J3Z1lnNnJvSS93OVh0?=
 =?utf-8?B?cnNJNXZsbDBlWk9xSlRWa1BxSVRnOUxYT0NpZE5qQ2ZxdG91ZUY3NEQ2L1J6?=
 =?utf-8?B?UURNZjRJZzVvb1hrL0JrWXY2ZytOdGxmaGhRWG5pYk1DWG9adnV5RTBGMkJ3?=
 =?utf-8?B?RitabHlqL2J2MmRRY0IxSGxvNjZCbXo0NVlyOWJWblpTN1RkMWN0NldCV2o0?=
 =?utf-8?B?RDNvMHV6eEVEYU0wYzhrcFN6NE9mNWl4LzByeVk0ZzhZQk1MWVIwOXEyYXZY?=
 =?utf-8?B?bEEzNjZrZ1dTSk91M0k3NHN1MDlZNldiRnFaSG5keElRRVhXb20vaG9UT3BR?=
 =?utf-8?B?NjNtanJma1EzalNSU0xBam1RSzFyNjE1UTI2VUwrYWYxNVVOZStUcjd1Vk5M?=
 =?utf-8?B?c1VNWnhtdjMwS29ad0o1VlJSV24yenI5UnZEU3JmK3VxRmZmSVRrS1JyUXEx?=
 =?utf-8?B?RkFTNXdlT2tiYVZzbXpjN0R6eU5teE5zNDBxelVtZDdBTmd2SlRETEhyZ1Mw?=
 =?utf-8?B?RjFOZWJvL3F1QzFDbnU3L21RY3pKUHlQLzVjVSt5aHlhcXYrMmQwUVVUVzRT?=
 =?utf-8?B?RzBCYUhYU3drRkZPYXZsZGZPcTl3SnIwelFwZlRCbmVheU11NHdaN2gvekRW?=
 =?utf-8?B?RnZVb1crUkpWb3ZibXVGbGRhYklndHI5RVVsWHB4RjQyeHlPSzk5NkN3Y2tn?=
 =?utf-8?B?NHhKcllDbUF5YWlBMnF4UFlKVEs5dFJsdGpJajE0T01zbmw2ZFZ3VElrTU1X?=
 =?utf-8?B?VGVlNXRYM0ovVzhZb1VpaUtncElvMGxNVXFkS1BlNGpQeDhCdmZFQyt4bFkr?=
 =?utf-8?B?c0VuMXZXMHpPejI1ZTRzMU9ENFdjNFdGZTlKMUFBTzVUYW1oWmplVjNlaUJa?=
 =?utf-8?B?VHRELzVCbWkvMDZIQ3J5dEFyZlZSVVk4RkFqL1dGcmVCL3pOK21XRnpNNUts?=
 =?utf-8?B?VVZ4bEZGK1QvK2JhVy9XTFdrSEdUcGNMZnZ5K1VKNmtUWE1BYTRhZTcwSGpL?=
 =?utf-8?B?RGUwSnlnU0wyMHliaFdvSHpQd05tWE12SUEwL0FqM1RGTnlGYktQTm1sQ3ZY?=
 =?utf-8?B?ZDhHZ2R0aUR1d3loeFFDWXpYSzBISGFaSUw5T1BIZ05jNjl5aS9oRkdWZ2I1?=
 =?utf-8?B?enYrQkFXdmI5bjRHcTV3K1p6Q1RmL1dBUWwrUThDb25xeW4vRVdNQ3RuUDhp?=
 =?utf-8?B?SzBHaGR6azdydnVKbUNkdGNGNzZDbnoyNS9FVHZCTTc4TFVMT1NHT3B4M0U3?=
 =?utf-8?B?WWMyTWhkRmxGb1ErV2dqMTJvMFF6Q0VlWFU4OUphRzFzSGM4K012TC9xZVNP?=
 =?utf-8?B?SFB1dUd4RjhWNmprMXduL2ZMMkNWQ2l3Rm1LVy95czFObFY3VG1ISkhrQTFr?=
 =?utf-8?B?T3pveTFUK2NEdjJMdm1nY3ZMU25pelltUWsyQkVDUUJBbjlCYnozTmd6S0FL?=
 =?utf-8?B?bFZTOG1LcUtqMHpzZmNHYVVTT296cFFZdUVZT0J3QlZzNjhxK3VneUNHTUl6?=
 =?utf-8?B?OEtlTXB4RjJVMGdBaE80aDZJdG9UMGFxd1ZHTVlLQnV3M2tSVkRHa3NOS09J?=
 =?utf-8?B?SUdQZFB3aUJMcW9zZTRLL25yQ1R2MXFjOVJncXVQM3VTOTZHOXVsYzRTanE3?=
 =?utf-8?B?RzVIV0tzWWRuWVhTY2Z3TVBiR1l3ZXlEdkE4KzI5TmxRT1NZS1l6SjJNTEwz?=
 =?utf-8?B?Rm05RVBHU1lFRVRqb3BRWnFwbHpnWndDWVZXa29DRnVOa1k1V3d3SnFYRmsv?=
 =?utf-8?B?UU5UV2hSa3JacGtvOStxTDRXQTcwQmVxZC9kcGNQWHdpU3BjL2RHOWRCZitl?=
 =?utf-8?B?bHdmZjMzSzc1b1JoMGwwc0VER1JneUFKcUZhOGk4R05QU3daQkNtbW9RVHdS?=
 =?utf-8?B?TDV5OEs4d3VKTnkrNGJkeDlpdHE1Z3Jmb2taVExNc1IvS2JyUmFJNnRoWWJD?=
 =?utf-8?B?ZS85bmtxd2RodkxwOW1iQkUvTjFpWk9mdzd4clZyMmI1QlMvMldWYmE2bjdM?=
 =?utf-8?B?a1pZRzl1TTBWZmNZYWdwa09VZ0k3L3ZTTlcwOEkrdFFjb3FVMnN0dlpCN3FJ?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef38abe-1254-43d9-ebf4-08dc9a96bc4c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 12:58:57.5627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDLWoqgrhXGk9XTFurjHrnoZRl6CEMcbYj4GbtzrnrB8UZ5Y/9qBc6mtnSifkQZrpvxXR0+/IBFI8CMhcbG67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7878
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

Hi Quentin,

On 02.07.2024 13:37, Quentin Schulz wrote:
> Hi Lukas,
> 
> On 7/2/24 1:01 PM, Lukas Funke wrote:
>> Hi Quentin,
>>
>> On 02.07.2024 11:16, Quentin Schulz wrote:
>>> Hi Lukas,
>>>
>>> On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>
>>>>
>>>> This series enables U-Boot to import environment variables from the
>>>> selectd FIT configuration. One use-case is that the overall build 
>>>> process
>>>> enriches the FIT configuration node with dm-verity information which
>>>> should be injected into the kernel commandline. U-Boot will then read
>>>> these (possibly signed) environment variables and put them into the
>>>> actual Kernel commandline using variable replacement
>>>> (see CONFIG_BOOTARGS_SUBST).
>>>>
>>>> Example:
>>>>
>>>> Config:
>>>> CONFIG_BOOTARGS_SUBST=y
>>>> CONFIG_ENV_IMPORT_FIT_CONF=y
>>>>
>>>> FIT:
>>>>      configurations {
>>>>          default = "conf-1";
>>>>              conf-1 {
>>>>                  kernel = "kernel-1";
>>>>                  fdt = "fdt-1";
>>>>                  env,dm-verity-args = "dm-mod.create=...";
>>>>                  env,bar = "someothervalue";
>>>>              };
>>>>      };
>>>>
>>>> U-Boot cmdline:
>>>> => env set bootargs="rootfstype=squashfs root=/dev/xyz 
>>>> ${dm-verity-args} ro"
>>>> => boot
>>>>
>>>> Kernel cmdline:
>>>> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
>>>>
>>>>
>>>
>>> I think FIT supports storing U-Boot scripts and running those via 
>>> `source` command (usually the file extension is .scr).
>>>
>>> I do not know if there's support for automatically loading this .scr 
>>> as part of a config node though, but if there isn't I guess it'd make 
>>> more sense to support this case than to come up with yet another 
>>> implementation?
>>>
>>> What do you think?
>>
>> I wasn't aware of this, thanks for pointing it out!
>>
>> This patch was mainly inspired by the dm-vertiy use-case which 
>> requires just env-variables and no (complex) scripts.
>>
>> There is currently no mechanism to source/run such scripts automatically.
>>
>> How would you distinguish between scripts that should run 
>> automatically und scripts which are sourced by a specific 
>> board/shell-script implementation? I guess there are good reasons to 
>> not run such scripts 
> 
> Scripts in conf would be automatically run? Scripts not in conf needs to 
> be executed via `source` command for example?
> 
> Not sure what to do if you want a script linked to a conf but not run 
> automatically though (and what would be the use-case?). I guess you 
> could have a script automatically run (so in conf node) that sets a 
> variable to know where to look for the other script that isn't 
> automatically executed?

Sounds like yet another level of indirection. Not sure if this a good or 
a bad thing, but makes things definitely more complicated.

> 
>> per default. I would also change current behaviour. For env variables 
>> I see no harm.
>>
> 
> If the env properties in the FIT image are part of the checksum and 
> signature of the conf node, which is necessary for secure boot, I guess 
> "no harm" fits the bill.

To my current knowledge the configuration node itself is signed. Thus, 
all env-properties are signed. Please correct me if I'm wrong.

> 
> Cheers,
> Quentin

