Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF3D1F9CC
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88C683FDB;
	Thu,  4 Dec 2025 12:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LBPp/pal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4405184027; Thu,  4 Dec 2025 12:52:29 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D466183A84
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwZ7Arqehzt0eHZxcKCnB1S1BdDo7wbZ1t3q9JyKXdwBlnq0YRl6Y4BAErVNbgiDKZkjME0vkje0D1ag5xFME/QxVQafFJO2MAKEQamWBmVRIU3kvXpwUR7166qIjuH+lV/s24tw2Bv7DILTepBKCJdp/+puVP4Q+oQTfQcCzY8QYRWoW7RL+v/1fsuT3JMl6/axcC6v8p1grnL5JZOYEkS40fP+fySACvzTtnOFdCiYVqOsSnoyMqSF15lAqGSbfxfnSFIMghYcvXqPqJcx46K7yzMdS71PZwepp1zaW0kbPOKyOKq9GE4MOv4xZZVg7sCAocsOIOozGuO2d0cO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lLfqdicl5Nu/1COunx05Jg48GXOE1bqAaV4Nn2t9jw=;
 b=d1zsf2AuY6tkoS4koFckmWWo/3utAPItKLh9ZVox3KWl8NDF0RVR4Q87vAiERYBiAJTDBXeEqMvtq2We3miaD4SKQE7ff1VG7EveyPwBE4Jq5OLK75tsbO2GjNnoX7r8PoiLn7SAAQ98ZOpQ+QE7WISvqI+YEu5ZXhF/ebFZMoNHyHGhMyG8fzdBwj+rOLOHert6DOFcnMiTWFggvwLasolTSRKxkPuEiaDwipOXCUWb4ejk9+bKnNAKTYHm+n35nLQlWBuRp061kH3GaEtViPtx2ckOZ1sgK3UXtG41H59i0LCAKq5yK9szJ6uAp9OT4oWas/53jxxX2YZwLt9/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lLfqdicl5Nu/1COunx05Jg48GXOE1bqAaV4Nn2t9jw=;
 b=LBPp/palf2Gqf2HYYAVD+SV3ST/674CxXxRySqzpGYi7aN6qbX3a4GxnsXSvKpuWOKVbp8w95L6OxrY+hLC+VURqNxlT7zJ/9GDAmv68SR/y9ka0Cyx6OWvOtIa86l6DX0qrZ8U0mL7E3kxEG+8F0wMRV64thHdzeltfv/P3Fnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 11:52:20 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 11:52:20 +0000
Message-ID: <23273f44-32e3-4f8e-be7b-996af8a10c8b@cherry.de>
Date: Thu, 4 Dec 2025 12:52:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
 <20251202201451.GL303283@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251202201451.GL303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bc986a-035c-4352-52bb-08de332b946e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmVjVXpFalJ6WmxqSXFjQVBxZ0VsejVUTFBFM1ZwbjJDajFScXJKL3pvd2hF?=
 =?utf-8?B?aGRyZ2xOc2E3MzM2VExZNW03UjZneWM1ajdJYWRMSHo2cERaMlhhNy80ZjJ5?=
 =?utf-8?B?SHAxY1BzRHVjVWtnSkM0a0c1Zk5VM2VQVFhjc3dYcERZSnllN2lGVkkwZTZQ?=
 =?utf-8?B?aHlTa2IxaU9lMXBjaXZJeksxemhEWGtoNGRSZWRiTnJzcytYV2ZaUzVCUkRl?=
 =?utf-8?B?Yk5iMWhDOWlYMlNJN05vY29ld000L0lVNHM0RHN3UGlMbGlJUXdscUQ3WDdm?=
 =?utf-8?B?QS9tMU9RcGlBVGxRaGl3bDNFcFB5SHkvaWJZangwekRIclFkQmVRSm1yaHJt?=
 =?utf-8?B?Y3ZBcW8ydjBET1ZFcXRQUXQxcWZzZGxjR2w0TTlQUUpsUVF4akowNUF2bjNx?=
 =?utf-8?B?THA3eEdwNHNQSnBLUjE0cEZmNG9WWUJSTTVtNUttYllaV0xIM2Zqb2VBaytu?=
 =?utf-8?B?VkovcnFEZkNVeTZxV0tMMjZtWmpTWUU3U1NwQnFuc016eHpjUEJpajdsVHlY?=
 =?utf-8?B?T1pKbFRqY3Q5MFUrb0ZZRno0S1dDWnRacitBWnd3Y0RpWlFlWFo0em1mSWR0?=
 =?utf-8?B?UTdXSnNVMm85bXdjRStMbVplVk1VY2lHdUcwcXNnT0dza29odWtGYWlCV3RL?=
 =?utf-8?B?Y3BtYkFoQkFWVzdyK1VuMXVXMlQ0LzR4eVcxcWtBTVVndmZYUUFiclNDNSt3?=
 =?utf-8?B?dE5YdE5LSURrbUZmY29zMDA3NmlVcjk1SURVUkFTTU9JcGlHbjFoOE14UVYy?=
 =?utf-8?B?d2Nlb0Q4SlJHMmdQakk2Z0dEbVFaWkNhSEVlelJPRWtiQS9oS3JhRDd4ZWtO?=
 =?utf-8?B?Zng1Vm1yTGFodG5LTlNLRUhxUmFtdjRuN0h1OXArcGhZVFZ3QXdlSzJxaDYy?=
 =?utf-8?B?cVhZdVJMR2l6RThwbmtUMDFoNXg3UEhOY1FLcjRYVHVhQjlRODE2QnlpN0h5?=
 =?utf-8?B?RkdYV3V0MnlnVDJlRit0azhucmZaRUR2Nmg0a25temJNdHFoU1N3Qmx6OWFW?=
 =?utf-8?B?MFI5d09BUVhZN3VPU3ZESCs2WnNpUGJwcjNYa0ZVK3BzdWpDQXFBcFg4R1Nr?=
 =?utf-8?B?ejRaNURrWWJGQUNBYVpkY0dkWTBmWGVpQkxqNXoxazBZNmoxVmE1bld3SzVq?=
 =?utf-8?B?SWZBYXlrTkN6YnltTTdvY1A2QUN0RlpOWU16c1dGQ2N3SjNJRWs5d3BUK2ds?=
 =?utf-8?B?UE4waVNWRGx6TW9mTitWcWRMQ3JCSnBqLy83bHVhSHNvR0VBQnZDYWw0eTIz?=
 =?utf-8?B?VGh1bzdrV3ZBRk05QytVUDdDa1lFYm9Xa3FRdHBSeHpWZDdINDZMR1hjb1lC?=
 =?utf-8?B?TXA5NVgzbGZURUdxQVYwbkRxR2JQL0VkWGoyRldXQVpxeUJibkYwN2QrZmlw?=
 =?utf-8?B?MWNRY08zenB0OGxiY3oxTFRZRTVuU2RqTWRYZFI2MDNscGFLenhmZzY3WEFn?=
 =?utf-8?B?MlVWaHQ0TUUvZE82blF3TDI1bkJucm96L3c2YTdBNkNSaXJseFNIV2diRW9U?=
 =?utf-8?B?VXo4cGRaRkpuL0wzWjhYdXBRRER6ZnNoVWRvNWtBWUQyN3Bta0xMTjhuWnpm?=
 =?utf-8?B?YXQ2K2dzVVVVN0xHeFI0Mmx3VFdQRXRhTkRmL04rWDdlcmM5WFVhYkN3OE5M?=
 =?utf-8?B?MDhzZ1Y1UFFydWlNRW93NmdTQmQzTHVUNGxtQThxazV2cnRPN1JjT1VrWXV1?=
 =?utf-8?B?TDlEUzg3RndXR2dPT1lkcVdEc0RzWGRadVNrZWZPRERyeGpVVzgwQ0RqOTN2?=
 =?utf-8?B?eGRxaUFwYmV3YTgvRFVqMFVDZ1VjTG52TFM2RzAxMzgrWWU2NVNHakRuWlFk?=
 =?utf-8?B?VG96K3JSZDVJMjhzVlMxbVpxQVEzWDhNTE1TZDJ3TXZqY2pyWFJqL1BTYUhP?=
 =?utf-8?B?TElMNWhzNHZJdlJuZU9MdVJvaFY4dzlNYXhUYXZjbmRITmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEV1b09xZFkzakhXczN3YzFheDdCaVgvMTJySkg4Vml2RXdEZmNIQ0RQWnVy?=
 =?utf-8?B?ZUxYaUNablBqQXZQeTJDNDhWNjFjV2wreU0vR0RMOVZldFZEd1VZdlNjcngr?=
 =?utf-8?B?TjFPVTVhK3J6TEMyUUs3Wm1YRnNxSHY3U0RPNk5QSFFRSlUwQnJwWHBKUnNz?=
 =?utf-8?B?WjBiMmtOckE5UGdmYXRZb2JXUGw0eW9VVnM0Y3lqUWJHNzEwQm50b09vQXd1?=
 =?utf-8?B?VWp5VjBnYVMyYUU3YS94S0dpTHVhU2ZzaFVPbjU5dk1nN01ySzZ3WlY0SVZy?=
 =?utf-8?B?WmxsUlArRU9vWnVTNHBiNzh6dGVQdnBVMDl0TFdQK2tlellaYTByUjR1TzVy?=
 =?utf-8?B?RlBhd0hHMWsxdWpiNFU3MFNMblFzTXJjRy9jMWJHdTdERTV1aHBRRE5UMUkz?=
 =?utf-8?B?Q0U1dnRyTWxHbHNvQW11bHJyclp5RkpvT2dxTzJrUGx4YlNIU1J0Mk5QVGZM?=
 =?utf-8?B?U3FUMGJ0WlA3VDlzdlBaUjl3Uk5NQW9EcE9hbHNHU01tVThrd2xLWDJ4eXpM?=
 =?utf-8?B?V09vZkRZdy9kdVNZRVByZG1FOFViNFhGYkplcUgrSVNWeTlUb0VvTmVxU1NM?=
 =?utf-8?B?d3RDbEFUWnFJZzVvaUl4QVpqaVNycFNYVUR1LzQ2NFVKSjcxcHpPQnh5b0Vv?=
 =?utf-8?B?T20vaHhhZ2NhcEpIUE4vWnBCSEpjRHBrbWUyVjFFSEh6bmdJVUY4bzJSdzRa?=
 =?utf-8?B?dlZGOURseEFycTNEc0RwekRkN0hkWFppTExvczUydXozRGRLZko2bHh4YlIv?=
 =?utf-8?B?aTVhRkJWRWxXZ1FHcXN3NHNOcnZsU1Nyd1JacWJldFFhOGlyYmFqTzlIRXNC?=
 =?utf-8?B?bU8weUQxdlBQdUlRb3VmcExXWGtmbDlLREVYb1JpZ1p0SU9VUm5yUWNmVFlw?=
 =?utf-8?B?eFBEN01oMVcyZXlORC8yQXJOR3ZReFBmZkE3U3NUM2NhYXN1YW50TW8xUHJp?=
 =?utf-8?B?U0p0SjVNd0M4aFRWQWg0aDVNT3k1cGFUaG55eVhVV01FOE1TSDJRc1lDVEhO?=
 =?utf-8?B?STR4MnhoWjJtbHpzYnd4eUNwWU91ekFxZzZBRHE2K2pSVEJiTEUxNHNQalo1?=
 =?utf-8?B?MkZ0eEFjUFhOL3BHbnBRUkw2L0dGZUh2R0lya3pvelpGaVZ2MTZ2UWlwUXhG?=
 =?utf-8?B?K3crVDgzM21FcStuTHlpRWU5YngxRVBFdVgzQVZCSG5lL3B5c0xWNGtXb1Ix?=
 =?utf-8?B?VHRKUVJxbUJFRS90ZjQwZTNNQzBDU1pFUlA3OVZEaW1Sc25rY0pXVWZDUGQ2?=
 =?utf-8?B?WjVlMVd1U1l1a05PeGMyWGhBOGNkaVRUYVh3NGVBWXh1dnN3Y3Ayd3BBTERw?=
 =?utf-8?B?Wmg3Mk44Y3RmckZzU2lEZ05BZEQzNGdVQ0NkajgxazRHVFVhcWc5WUo2R2Zi?=
 =?utf-8?B?d2JtZnZZSzIvMVFPN0dYVEpwTVBzV2hrd1JxSE1jdFJaVjV2ckZ5aENWZm1q?=
 =?utf-8?B?R3pkUE5WdFd3WjFUVG5qWEZrQUR1YU9wb3FUN3gzMk9aWnhpeVRHRWl5WWFW?=
 =?utf-8?B?WjhZU244ZlRXeGx1M3VORTl1ajZnVG5mSFNPUnVIT3cveTZ0QlBZTFJOUmVa?=
 =?utf-8?B?cjZoN0l6SkNodEFleEFvZGdyY3lwWlhnakdUYkE1M1JDM1QzMjNJNEl2aXhB?=
 =?utf-8?B?MHJxb0RtRmdqVWxhbGQ0UFEzWlBkQ1NiT1Y4WEpzK1IvdENPQWFtcnRubVRu?=
 =?utf-8?B?N1VzSUVqdVFRbWYyZnNSVlBwSldWY3Brc0ZUc1FFdDVvYUxpSGR4MmNraG5u?=
 =?utf-8?B?RDEyRzF1aHdON3YwemhzUE1ZM05IRmt5eWlSTCtDNTgwY0t5R01hRDRZM2pv?=
 =?utf-8?B?WE14eFYyM1ovMkRzZ2FHL2pmRXVlYkhLNWFENFhhbUJkTkZQYVc0c3JmOTNy?=
 =?utf-8?B?eVR6K2s3Vmk1dXdhdThML0xjSHpFblEyUnNWWk9EMWRlSGhDZ2lTTHlva24w?=
 =?utf-8?B?VE1LRWFLL0Zpa1FGdVJnbmQ2NVorblg1Y1hTY294WkZVMWpsNnBzcWV6b2l1?=
 =?utf-8?B?eGdKTVhOQVVkNklTYm9uR0p1U2JkTit4Qk5GWnc2Y3hQeEFKTG9pekRwMllK?=
 =?utf-8?B?RmtxTEZqSUV6dEEwSkdmWkpwbTVza2ZmVXhmdmdkQ2R1S1BnMkttWlNqSEVK?=
 =?utf-8?B?YTBJdndVY043dTcwaitia2V6MWFLV05mUm1jTG9GNk9FQ2YwMDhwK3B3cVBv?=
 =?utf-8?Q?5fB/MoqZg/1cpfkWs4h9dOw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc986a-035c-4352-52bb-08de332b946e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 11:52:20.0924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHx3vqtqPK1LUsf9Vg4md+r1x5T+/6glajYGhEIZRqSkfPdstvwLhTw6pHlEqeO55OW0jvmIXgs2OQ1svH8C9x9tVEX69A2CYp7navvYaHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849
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

Hi Tom,

On 12/2/25 9:14 PM, Tom Rini wrote:
> On Tue, Dec 02, 2025 at 08:06:02PM +0000, Simon Glass wrote:
>> Hi Quentin,
>>
>> On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>
>>> Hi Simon,
>>>
>>> On 11/25/25 11:15 PM, Simon Glass wrote:
>>>> Hi Quentin,
>>>>
>>>> On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>>>>
>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>
>>>>> This adds a test that signs a FIT and verifies the signature with
>>>>> fit_check_sign.
>>>>>
>>>>> OpenSSL engines are typically for signing with external HW so it's not
>>>>> that straight-forward to simulate.
>>>>>
>>>>> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
>>>>> 4096 private key is made available. It can be selected by setting the
>>>>> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
>>>>> the engine is detected by OpenSSL, which works by setting the
>>>>> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
>>>>> is properly implementing what is expected from an RSA engine, but it
>>>>> seems to be enough for testing.
>>>>>
>>>>> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
>>>>> without specific hardware. The keypairs and tokens are generated on the
>>>>> fly. The "prod" token is generated with a different PIN (1234 instead of
>>>>> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
>>>>>
>>>>> Binman will not mess with the local SoftHSMv2 setup as it will only use
>>>>> tokens from a per-test temporary directory enforced via the temporary
>>>>> configuration file set via SOFTHSM2_CONF env variable in the tests. The
>>>>> files created in the input dir should NOT be named the same as it is
>>>>> shared between all tests in the same process (which is all tests when
>>>>> running binman with -P 1 or with -T).
>>>>>
>>>>> Once signed, it's checked with fit_check_sign with the associated
>>>>> certificate.
>>>>>
>>>>> Finally, a new softhsm2_util bintool is added so that we can initialize
>>>>> the token and import keypairs. On Debian, the package also brings
>>>>> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
>>>>> is not the only package required though, as it also needs p11-kit and
>>>>> libengine-pkcs11-openssl (the latter bringing the former). We can detect
>>>>> if it's properly installed by running openssl engine dynamic -c pkcs11.
>>>>> If that fails, we simply skip the test.
>>>>> The package is installed in the CI container by default.
>>>>>
>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>> ---
>>>>>    tools/binman/btool/softhsm2_util.py                |  21 ++
>>>>>    tools/binman/ftest.py                              | 223 +++++++++++++++++++++
>>>>>    tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
>>>>>    tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
>>>>>    .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
>>>>>    .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
>>>>>    .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
>>>>>    tools/binman/test/340_openssl.conf                 |  10 +
>>>>>    tools/binman/test/340_softhsm2.conf                |  16 ++
>>>>>    tools/binman/test/Makefile                         |   6 +-
>>>>>    tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
>>>>>    11 files changed, 853 insertions(+), 1 deletion(-)
>>>>
>>>> Not sure of the changes from last time, but I assume the test coverage
>>>> is finished.
>>>>
>>>
>>> They are listed in the cover letter in the Changes section.
>>>
>>> $ b4 diff -v 2 3 --
>>> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t
>>>
>>> will show you the git-range-diff between both versions for a given commit.
>>
>> I normally review just in email (often on a Chromebook) so I don't
>> have that. It is also an extra step and I don't know where your log
>> argument comes from. It would be better to put the change log in the
>> patch as well.
> 
> The cover letter is just an email. Perhaps a handy tips bit of
> documentation (and external ref to the general b4 docs) would be
> helpful, especially since b4 is a common and widely used tool these
> days.
> 

I can do that, what do you have in mind? What should we add to the docs?

Cheers,
Quentin
