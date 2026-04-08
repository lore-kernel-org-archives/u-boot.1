Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA98FD5F94
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 08:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0276183693;
	Wed,  8 Apr 2026 10:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RvtHzXsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB6383D8A; Wed,  8 Apr 2026 10:27:24 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B9880433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 10:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFYbkS1bAv2R5fVgfxA1bpBPjAJ2DMdEk8RE47eukmrLzs4WYK4X4GRQ40p4OO4N6lPgleFLXjFdekWPiHSOF3xG7qpNiLhcjewhV+HkxWN5ujOF7KmZItSWKSXa/oUE+aSNn1DngzcQHOr2XnlfgXT6lampgPj9JmheFIQjAFJ6WeFaBxGYg5zzPsWDB5EBZz/D18OYprNsCWhE3PfmEJrTvLpfXk5/tJCUZi4IJLJnqYdEDKu77CMh5y5JuVpKm+kfwGCVwd21IQ4ggZ1bsdq7LCu6hV66Ku+r58ptM6FlEjHXoHW7ID35Bo7mTZpAazbF3r39gpc7CXf6jORTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxO84eWIUD7/3DWItTkevkklPOMNiM/PBCkxOqImuro=;
 b=dXEQeI0Jh6iQRf5q77OxOKIz0c00srjE0qC+8z7ieeQR8HFGdJ6iXhHLuX/RIM2KWa/ULmuopolw0YpI3k7Oi5UQ1S+4h0e4Zncww3Y8zU2SJW+8cHa/HDJU1m0hMUP71qao9ABmqxHJ14k+IxS8aNVd/hFfLbnd0Py+u1Ay7fBMqbkc9lNgXz0rv36qiAbOZZAMtwJt/iZ/LGgzwFIPoEBnwrboir2zsn95TMr0YxbU08u/2yV91wcWqjSgxebjB/Rr6n1Um28WFVX89qzibqaF/Ocvdo3VbgQBPMk0YNkZEPnNDQfFPziOR4Z4KySFU01GCh4O3iKXe7pR+p3Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxO84eWIUD7/3DWItTkevkklPOMNiM/PBCkxOqImuro=;
 b=RvtHzXsk96Kl5MG0k/lHMUnKboSZEFVXSRHdhNlCPox5RCKGEEmIuzXovqBJ4KqXcT3UQd8wDN366x6h4dKSDj9xNI3sAwF6u2IngXXiie+HZHZ09lV+yq4r8j/GEegl4a+mG5hRPbMyi7jpSXgHYrQ57A/Q9o4bDqzeWZJ/GVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:27:18 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:27:18 +0000
Message-ID: <ce5f1f87-7f01-4842-ab3c-bf3520ede41c@cherry.de>
Date: Wed, 8 Apr 2026 10:27:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sunxi: spl: fix SPL_SUNXI_LED active low configuration
To: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
References: <20260407223447.4956-1-andre.przywara@arm.com>
 <20260407223447.4956-2-andre.przywara@arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260407223447.4956-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000213.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ca) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 77472c7e-1234-4ae7-07a2-08de9548a570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8E0P5U9O+2M+gC9PIuAGk11WBCn3PIxtPD0hrDN8vLVxPEUk4hv5z5Fu5NwpSA7fqS6ciI6wXuHWMyWyhRyDM4KfqbL10pZqH5QtMH6Athg0ufFyU+NS/Aqei/CRljw8uQSvIS/NqIQ8qpb+g4S/a6b7UUJ76eFbDa9uYUxVH9AYdW0QW03OXYFKNeG8sff25Alz+r/7kgkSjlTfs1XTmVYPiiyEg4/edEZ9FzwLpDmCDWNKhNgr8nz+UU7gyh05S93/cOsZ6Rs5m05YXW+ofBppCsGwGhFT0lC4tzJl8RCqMV6xqMJcjSPm/GzvHoqf+Hw5Z/uKJhdOgOQCojBL7g0ZLEAvvPFpl88RVWGCy51bi4AiJld9orHin564UowWwcv6PAAKpq3k5iLqfwK3uLMPdgB1gDtFLodvezg+EaB+Zu8PVa7/eg44L2j/T3/JSa28kcGjgf4NtbXhaixEwvqRYlgWYin95eqb6ub3gnQC8g9FUug2DVJqIZnqMcWScrOJns3TYdgFTFBom46qNmphq2j3Glv5ut/dswuk54KB+Lc2YKYIAbuTj5jezCetMrRyBLumcNep+DKfOGrToDlB7UYhmiXWixKUsgPABoInC7L1yFKVQx/n3u7XNmbo/gFQiXBmB7NK/M93JPUKXrw9q2dVX5oTTeWFJQMXZJaV38+8LEJFxd6geMvU4ckgq6FA635ryRiKPdlSCs0PvuOkqUWTF73C6wK5yAh+E80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VaRjNSSkx0dEZNcnpPQnpTb2RrRU1zVHFrTjhkTEJPZVlWTkRaSStaZWc4?=
 =?utf-8?B?Q2pDaEs5aXJVeFJaZytFTTlHcHA5MjBmdnNiNDNXVVU5TFZNTi9FT0dUVTBV?=
 =?utf-8?B?WldJUk12TVRFQThPQmdHd0JIL1ozdjc1Z25ndGVzUXk2MFlmeDl1YmxURUtm?=
 =?utf-8?B?dnZ0R0pGb08vQVo3cEVGRmlabG00TlI2cDBMeVUzemlid1o1Q2RXK01xbUZL?=
 =?utf-8?B?OGxLRmdVSHJveWk4Y3NaOG9FTk9lWUl1bVRwL1dGUzFvUGQ2SWEwbElzMFda?=
 =?utf-8?B?RkE3dzZxZXBFbzQ3aGFGQXhjQkVxbTRsQkVUbDZiVWFuM0RLaDBnckxrTmJT?=
 =?utf-8?B?NGc2bEZUV002V0VmVHVIOUE2Z1pYK0hHeTZrcnZMNjdhbldvaUJuaEw4d085?=
 =?utf-8?B?ajl3SWlVb2VZMUd2Wk13a0VFWG9RUDg0cWtrT29nVUIyU1dIL3ZkcFdyWFBy?=
 =?utf-8?B?MEM5dTBUcmRmZERsV0ZrK2pXSkZFTnJHSUVZWjNtVTltVy9NSGRyeFIyRlZG?=
 =?utf-8?B?dll1NzRqLzlNbjM0QmtkaVd2WkRDQmhmN0RtbHozN3haZUFXTkdpa1B1a2NM?=
 =?utf-8?B?TlZZOVN5TDFHU2YvNEZoM1VHRS9NcVd1eXlSY3hCb2JyWERCc3VyZFNtclJs?=
 =?utf-8?B?WmFQSGlzUmdqdDlpN0NiQlNBdE93MytKRXhDaWN0RjE3RVIxTENsWUYwMy9J?=
 =?utf-8?B?K0xkZFFnTzF3TFpCdE1oZUR2VDdSTlpxOUJ5cUNSVW9pV3NJT0ZLZUVCL2I3?=
 =?utf-8?B?RGpVeUtjdUdBaW5DT0NtWndsbXdtRHVNYVRWbUV6SklwaU1HTmZLUXJlOEZX?=
 =?utf-8?B?UkZNQ1l3aUNGSXVHZmg1a2ZLamp3OWgzRzZtZ2hVUEpjbnRaS3d3QXFkcTk0?=
 =?utf-8?B?S0Zod3JXblgxWXc5ZlF1UmJUcCs0aE45UHMwRVpYRjVldWN3ZUU2ZXNEZFlX?=
 =?utf-8?B?c05pSzJ1VmRGaHdLQVVEVjlQeFFzS2pxUUs4Wm5pMDFsYnFIejhvcUc2Q1A1?=
 =?utf-8?B?WE5vT3FGRzdiY1RqZmRhUkNQV1hNM1E3NW1rQXhmN1h1VFJUakFXY3R0R3I4?=
 =?utf-8?B?clI3dWVzTlJOcDFVSWFwMFRyOVNxU2k0ZjRTMHBYQnNWMUFrWnY2eVU3ZHBM?=
 =?utf-8?B?Unp4TkovSkpQM1pkMmdRUG91bkhMNXZvT3VVWGdvZDJ2Vmd0R1ovbUhybW4x?=
 =?utf-8?B?VVE2dFFicVU1RFRTRnU4Q1gzSkhFYndaelE0cCtyTTJhaWdOK1FQTVBZUFo0?=
 =?utf-8?B?Y1pLcStZeExjYTMvVWN4d2oyUWxxNG9uYTJoTGxjVWFkNFBwcG1pWjRuam15?=
 =?utf-8?B?eE5Na1UzUUVuaEdVNk5Nd2I1NzNKaHJTV29ub2RNeTZ6dGFTTFZ2TlB5VndT?=
 =?utf-8?B?a1dXMVRjL0ZoanFkY0w5RHhjKzlnZ3hqSVBYeU1IUE96SW1TS0JnWnBYNE1K?=
 =?utf-8?B?NTlkK0d2NS95eVNlbGlqcEs3UVRnL1lqbDdmKzFJYmhuYTNJNENhdXlQVjFO?=
 =?utf-8?B?US9NYkEyUmxmbkovTmZSbWJzUW5CTzJTZVF3QjFta3FMUVFNK2xUN3FYdjZS?=
 =?utf-8?B?U3NxUm1QQmh4WnZZbjBMbGU1L2hHVGwvbG1tSFdlT0pRc1BmVzl0Q2pXa2ZC?=
 =?utf-8?B?ZE5yTmpoQWpXT3poSm5rY3lQc3AxWHVJQlFsSW4zZUgxYXNvQjdpZ1BGQkZj?=
 =?utf-8?B?blFTN3hxb3FmKzRKSjI1S0IrMk52TGFpWVA2d0NOZGFLaUg3ZDJGczV3bDF6?=
 =?utf-8?B?YjUzQVMxQW0zSFQ5c016ZGkvbVJ1c2RCZXpmcUhTSVYvVTcxbG8wYWxQYSt3?=
 =?utf-8?B?TXVEeWxSYkZ2N1hReFR5UHFkVjU4a0duaDRKekt5MWZYdWQrUlFidFd2aUta?=
 =?utf-8?B?R3RGT3B6Tmx4TlV4Y0pSRGdQL0M5eGlNQ0FWMHVkanQrb2twSW5vZE9IODA4?=
 =?utf-8?B?WkJmeHhtdXloVFZzbFVUcjFCbGVPdVJQMXFXZzVkYXd6VnJwQ0ZFbEs4a1JS?=
 =?utf-8?B?a1E0UG1CTUp6NkpkZU9kNk4yY0ZKM1Q0dVJUMWszYnZvYWVkVUZ1T3czSEdp?=
 =?utf-8?B?dEhSRlZ0OWVBYVk4aFBFZ2ErY3NmTlhXalJVM1dhZWxVcjJRMGhlMEhTMDFs?=
 =?utf-8?B?TEJGS0p0cndUZE0zUTJIVFE1VlNiNzlBZVV4MGRadnRrS3ZOSHBpa2NpbUV6?=
 =?utf-8?B?bTVlOFJPdHB2Vmg3d1A3OEl6dnI4ckU5TlFzU1V2azNZL0M3MVhUSHBjM25Y?=
 =?utf-8?B?ZEM0K081NnlvRnFQQmFJK2VPamVmNUt3ejk3ck9pNERnSkxiNEs0QkFUc2xK?=
 =?utf-8?B?ZzdDNEtwZjlHNGM3bVZPaDVERVRZWDZkYmM4elJvc1dxaUx5c1M3QWlRVDV1?=
 =?utf-8?Q?UW72AxvFGv5z9a2jXJHpzvqCQHQHnn3LW5JMp?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 77472c7e-1234-4ae7-07a2-08de9548a570
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:27:18.1850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fyfcykmkTxlIdVzwdkRq9aozAFIQjfYjKnL/fAsjwR4l+ZBSCmHK4UCWtVWJH1091coJ/KXs9JLRBqwQ3lnuSWmnAljSWuI9nJqt2ZwVQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927
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

Hi Andre,

On 4/8/26 12:34 AM, Andre Przywara wrote:
> The newly introduced Allwinner SPL LED "framework" defined a
> SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
> the active-low vs. active-high polarity of the LED. However this is
> a bool symbol, so it will simply vanish if not defined, and we cannot use
> it directly inside a C statement.
> 

Ugh, thanks for catching that!

> Filter the symbol through the IS_ENABLED() macro, which will return 0 if
> the symbol is not defined, which is the intended value here.
> 
> This fixes configuring LEDs with active-low polarity.
> 

Fixes: 256557dd9aae ("sunxi: remove usage of legacy LED API")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
