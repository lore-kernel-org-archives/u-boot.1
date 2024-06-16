Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A20C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137BD8804F;
	Sun, 16 Jun 2024 12:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="tE3MD9qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F52087FC2; Sun, 16 Jun 2024 12:24:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B2987FC2
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G9cgFt010004;
 Sun, 16 Jun 2024 03:24:37 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ysafh212m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Jun 2024 03:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjwR9tMN09Bag88/fwzDFbO1HSU7N1HRBylrVHO7zm2s0UJp37J6dOytqf62WUyIm5ICubB6GEfN3ew8RnKXuVKDqJKpQzGt8SNkOiiU1ylHTJy0Hs9k7446PjGBN+yvo6PpgPLIt0xYLR0d/1Fc24/1XqQWXIOGDpWYjgP+AXvhnC/D2ECJnD5iXXTN/yr7nC+xj+dofNFCK0g51UkSE7hPeANLYa1YhkKVpTfdPAuOeJBjprVfUTzuyP8WKh1jpnQTD4uKQ/Q0tabqkkjIrYYDcz+/JUdV6smA9hYkE9grViGtKztsViOAcL3cHSjKfmrkqJ9ySTe6xy18wkY1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axZ+W48LhxmFQqtHo9gCkQeFVqIX3p5ObJeRx5yjc24=;
 b=QE/QlU8/pPGGg+rkcTwsF1Jfm22jk98q3vjfw0U9Lhynh50EOQ5804BzCufuWgLYAcRcg0wLSrc+4PeJKgNUPxI7XmchQ0REhQnSQAym7OZI5XLZKHs2UNFE398CQ9kTVKfJrIxwhjgQEvnMapM/188Wg1g/CXSyC2gcO/p/G6Kjochgop1Fedwg5KAkT5w2fsFSW6w61qfVqeAKSqrteVrkkDPbmlURCKWUNFI2OVdZnCNKXSbpDHW1sEoKG4xrZ1AGMdJ6YK71+yBpFKhyfqrZ0J1BcQhXWX4mpr26ASyffCwe5qgRSHwER3BdOP/ML8CwQ2Urfda+SPdjrLcbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axZ+W48LhxmFQqtHo9gCkQeFVqIX3p5ObJeRx5yjc24=;
 b=tE3MD9qfpdKKV28Zd87v0LSjMgyeYZ7YoKdGUvfm1IGA6LzimgyYNFBgrqjZU6c1UYSNY5k4CRk8hFDr4tYdPFAAoQYKT+CEi8bB1Wn7c91uLFN2tD+D4U30lrmZRhu2tGf9OxmbDjTOn0iAQHfTomqrcNKNvn/YV6U+ockUQPQ=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by MW5PR18MB5041.namprd18.prod.outlook.com (2603:10b6:303:1cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Sun, 16 Jun
 2024 10:24:34 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%4]) with mapi id 15.20.7677.027; Sun, 16 Jun 2024
 10:24:34 +0000
Message-ID: <0e387552-7df6-c14f-d23f-175d122fdaf5@marvell.com>
Date: Sun, 16 Jun 2024 03:24:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip return on page read
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>,
 Stefan Roese <sr@denx.de>
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
 <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
 <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
 <06d001bc-0bd0-53e3-4408-21f6d6dac141@marvell.com>
 <CAOf5uwktymi4uvZTBA5hJ6EfdyytteSUDM_b2TyPKFJsu2LLSQ@mail.gmail.com>
 <89eef6cf-c2c1-24ac-225f-e104580e99b8@marvell.com>
 <CAOf5uw=ct9u=K-F_WHOaR0n7oKJ_Xq2MAOU4Aewg_0fLR+cAYw@mail.gmail.com>
Content-Language: en-US
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAOf5uw=ct9u=K-F_WHOaR0n7oKJ_Xq2MAOU4Aewg_0fLR+cAYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|MW5PR18MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 05966a61-25a9-4673-c3a2-08dc8dee8418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkRvcmZyTGVuK3Y4enFBODh4clgzZTE0Q2tqR0ViRnJiRVJhcE5LNUxwUEJB?=
 =?utf-8?B?OWRkbXgxaGxUekhJRnNxTmI1aXYxSFZJWWJTS2lVUHdtTDgvRGlZQXFyZ0ov?=
 =?utf-8?B?NHBTcEI4VnF2NnJCTHc2Yjk2WDNWNW96RTl4ZkxXc21oVGdIRm1zdU1nVGNU?=
 =?utf-8?B?Q1NDeExlV01oaERUd04yTUFzQStaaG5VdVpXVWoxaWx0cXZSdXdEV0JlWVVY?=
 =?utf-8?B?WDAyZFdMTFUybUFMMzdYS00rUVRyYW1od1ZFSVNuSlc0T1kySEpPMS8waG9r?=
 =?utf-8?B?M2U3YW5OSXBxYzJxZ1Q5V2VEc3p4b3dGTVgrc2piR1pWUnJhK21FN1dWaEI2?=
 =?utf-8?B?R25PU2NpSDVraEsyUmtCcCtqMm5NcXl2MU10L09YaThla3lNRWtsVG1kSHdE?=
 =?utf-8?B?amh0UVVrVXZ4bUZDRTB0M2wzQlB1TEloZ3RrMlV0MWllZnR3NlVWQm1pbG96?=
 =?utf-8?B?ZUl1eXBIVWdDNnNoQXpNaHR1OThZMWlXczZ6T2wyZzM2ZHJIcjRqSStJbldw?=
 =?utf-8?B?aFU3czBEbmdLV2FXOXJ3T1ZDenBOMGdxcHA3TDQrZ0h0WjQ4U0ZIWGJscHps?=
 =?utf-8?B?c01VNmprYWJEN2ZEdTJUekhJMGovOVg4czJ3WUV0bmxiZ1FueTlCL29QelFP?=
 =?utf-8?B?R2o1OTRxdWdIZnVnNmE3Rzk1NVRjSXVmaFh2WE1TQzdVd3pqOC9PQ2xaWFhF?=
 =?utf-8?B?MGFHKzhQZjlFbEtLOEN5SmRLTzRUaDgzZXhjb0s4R05MbXRNL09TL3RyNzF1?=
 =?utf-8?B?ckpQUmJ5bDBSVUVMZVlkY0pIeTRTRU9UcW9pZXZJaVVOOENGblZYeFZhTUw4?=
 =?utf-8?B?ZmpUMjFSKzRqK3E3dDF2ekxJMW5Mc0hLQ0ZyMnpJNlphNmdjaVR5aU5SMzNi?=
 =?utf-8?B?Tmk3c1BJNjh0Z2pZWVpRUCtLcjlFSXJydkt1bDZMYUg5cjBRMThYQzRTRDRy?=
 =?utf-8?B?RnIvdFp3WXZucnUwNndyS2lUanhhTVFJU0ErWER3cFJ2THlpUHVZd2M5ZkV2?=
 =?utf-8?B?MDFwNzNCWms3c2kxelhVMkpSLzFkV01kbE1ESUx4QWZPTnlOSTlPS0VmL0RM?=
 =?utf-8?B?bVVVblhHeGgyYVBVV0xiVnU2eUxUQnhHWjFoT2U3KzFLZnVQK2FGOU8rR1NM?=
 =?utf-8?B?K1JWRnBjTU5vSWZDeGpVRHRiZE9IcllLUVgveFdxb2RZYkY0TGc5Y2l5WkV4?=
 =?utf-8?B?aUU5UUhWblRIdFVoS0IxcVNXTWhMZEI3T3ZjdkxGb3NwemVIRlZweXJKWW1B?=
 =?utf-8?B?M1hZL0YzL2hQS2Vad2xDVmVZcDR2Mjg2MnBaWjEyM1VkSTNFVHdrYVdVK3Nr?=
 =?utf-8?B?cE5MczF1UmdUT2QrNlpTaFdBMmorWWJzRi9KdFdWZXNLMkpRUE5tVXpxandZ?=
 =?utf-8?B?WDhMbTI5SFZJV1dNZi9Gbmx2U2dabjBLZEtINnZZUWNIa0swNStuckVKTnBm?=
 =?utf-8?B?aitCSE85MWJ2ejFmaTVadFJIYUNNNmNBZDlCQmwyRnVKaEVBVjhZYTBaS0Iz?=
 =?utf-8?B?OWtYNW1RYnBuSEUxNENReExEUjRXendPdkM4Z202dGZUNGgvTVk0OGY0WDc0?=
 =?utf-8?B?K3NVWnE2ZzZOVW9WU2RFN1o2NlYzdDkzc0ttMnVncW9ndmE5VEx5OStacGRm?=
 =?utf-8?B?blRXWTNYUmptaGFZcWlhV25nVHZzbXliV1hqZDNiVWcvVE5iNVZtWkk0S3Jt?=
 =?utf-8?B?OWRKdk5UNjVQeEJuU1N4YVVBZlFwUkNLdEp4SVd4U0luZnlNWVJzeUU3cnFR?=
 =?utf-8?Q?rg3NRHfesu0HOQR08fJG5psV4+uFOqBzHR0WGQ6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXFkdytUNENQL1paT3IwMFJSUW0rZFRmNG5tY284OFdSNDBCSFFkZ0c5aHVv?=
 =?utf-8?B?YzM3UjVvSTRhQ1JYWWx6YVV6Wms0OFU4b0JMSytCQW50WGxqekowd3hTMUFq?=
 =?utf-8?B?TGRoUlFwY2wyM010QWJoeDF3MUNXTXJydDNCbmNFQnVSeHhCTVU1aE9SdG9X?=
 =?utf-8?B?V2krT1c2UncwSml6SVZaQTVuSkUwbktyaFJkdUlWUTZwVzV1dVFhdnUxWG1t?=
 =?utf-8?B?OHFtSWxtZWlXUncrTS9mbm1FbmRZeldGcGdnblNuMDZFam1aM1NUZDF1aFpU?=
 =?utf-8?B?R3R5VkgreHZ3Sk5udnp1Q3BDTVVtK2tPM1NnVU43bXVBTkRhNTV2VTR5WCtF?=
 =?utf-8?B?NkFtR1JZMkRKNjFNTzFwV283RGp5VlpqLzM1VmNCS0tyV2lka3hXRjZIR3lq?=
 =?utf-8?B?NmZZbjZxaEE5cDhxbG9naGswb0g4ejVRMzk4ZDNmT0l0bnVPNnFxb1huT3hs?=
 =?utf-8?B?Wk9WWWk3UnRuNUdrV3ZWQVlVZXBqTVk3YWN5andZWVdiR0txbEhZSm4wM0Yw?=
 =?utf-8?B?NW1KUW92azBzNXpTQ2R0VU00amk3Y3lKNWw0SzlIR1dvSE5EUldpdGFzV3Vl?=
 =?utf-8?B?NU9QeHE5a2UyUWtNQWFFTkw2dVJRYmIxNXgwdldOSWZWTkNxallJekZQVy9n?=
 =?utf-8?B?TDYxNU5YWndJclBJa3BoMVJ3SUpyVWI5TkM1VTVMWkhpS2hvak5ZWGR4aE5W?=
 =?utf-8?B?dSs4TDhwcDN2M1FnUnE2V2psTUdVTGNaRWRxSGgvdWVNV1YxT0NhMkhFQzRK?=
 =?utf-8?B?UkxsUmtIek0xamlrSXBmajlpeFVrajZnQ0lPK2NUVGdEa1Jld3NRT0oxeEs0?=
 =?utf-8?B?VHg5aGxzT0ttVlVVR0RnYU00aFBHZllSNVZPN25hNlBQOGYwMkwxYUxUK1Ja?=
 =?utf-8?B?eVVwVENtTzhDSGNBbkpEMEFaaUdMZFM3WDN1NUNrdytXNDA4aVZIaGJzc0tz?=
 =?utf-8?B?YVJwK0tYMGRvV1U4V2RzaXo3S1MzYUlNNkgrZmJSam1UMldrSnl1azZBeEI0?=
 =?utf-8?B?UE81d0VWNFVadXBjaGt6cUcvdi80L0V5TThGZjVOUzRRZmluSi9wMkZEbmMw?=
 =?utf-8?B?cU5URHRJVkJxOTd2aEEvRDRtcS9Nd3cxNTN6WU8xMUhyOTZVWGFFQ05TMFVl?=
 =?utf-8?B?bWdLd1BkREM5aFNibDkydjlhZjNKR05WdE1tUlhlaE1XMDFqeUNMRUFUL3ZS?=
 =?utf-8?B?SmxBdStPbi9OWTY3TUdvM1dFUEhwdkxmNXFVMTZRSVF5YU1MZUtERDBWZ1Jq?=
 =?utf-8?B?Y2dHNngzcGs4UE5jZkpkRXkwT0xmK0Z4djZqSE5kcFhwTWF0cVhiNnJ1Mzdk?=
 =?utf-8?B?bnpZS3lwSXlNZGhibTlzMkhkQjJtTitCN1JNdCtwWmtTanFyeWdYN0hzbzFQ?=
 =?utf-8?B?RUtLK1ZVS3piMklZdVZ6czNNSXo4ZWdzU2M4WXh0WmFBS04xV0J0cnNnUDRS?=
 =?utf-8?B?MVBBaDJHakErQVgrbmR2QmhrYi9ZTXlxK2pBZFNiQ1JxMHRrZEZqWTRiaUwy?=
 =?utf-8?B?L2JWbWxheDVGd1llRUE4NTZsYVE2N21PdzlaQjQxd0dVeXdhNWZRcVBRTng3?=
 =?utf-8?B?aGhLS3E2RUZRSk40K1QyNjkrQkhZNnZuVWdPbkw0azNqbjB3VTZpa254K3pH?=
 =?utf-8?B?WllJZkYveWxjWE1rM1NMTzlsS0lSdlR6UzVlL1psdDc4ZGQwdnNraTY5N2p3?=
 =?utf-8?B?UmpVR2oxNzJSd01oRG1uZGFqNmw1d2JvN1grMzVLVFlCWDlESGJaTTF4VGJJ?=
 =?utf-8?B?TlhWdGdQRmtjZjl4RzlCK0tZNU9XZHgrcGhjYkRSZUY2RjMxUlhTNklmZHZl?=
 =?utf-8?B?ejI5NHhLQUlGcjB3ZWZsQjFNTFhLempMQ1VEcmU3RWRrczlSNTZDd2Fta202?=
 =?utf-8?B?d1RkTUhvd0dVWFlwVFV3QTFSY2R3WXdkRURvcFZIN2g4ZE5yUTBNUjRRWlhk?=
 =?utf-8?B?WEVzYnMvUzFiNnd3Z3p1RkVwOTJrdzRMTEtRRmx6QU1VMWZaZHh0clY1T1pM?=
 =?utf-8?B?QkcwZC9sRnczMEJ1eVo1VW1idWc0eU1vNDFIWkVDUTMvc0JnNHJvaWZZajFz?=
 =?utf-8?B?Q29FUmI3Ymw2cFZERXZaY1RhRktUK0daZFkwV2JjQjkySHNXdFNxVldXTitq?=
 =?utf-8?B?ZThRZ2UzTlRTSnNid21TcUU0STVJa2c2UGV5NStDY2NLS3BxelRUZGFqSTBI?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05966a61-25a9-4673-c3a2-08dc8dee8418
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 10:24:33.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnpetWH/Z9updb40uda5V+fOcBcp4GhKn8JUmjWamNveiusK4TUm8I0sBO0hv+WQWfDOYMIAADXLZLRnBsVczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5041
X-Proofpoint-ORIG-GUID: EqDvvt2U4nrk_WyfBXt-4S875QXJHMgz
X-Proofpoint-GUID: EqDvvt2U4nrk_WyfBXt-4S875QXJHMgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_08,2024-06-14_03,2024-05-17_01
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

Hi

Can this be merged?
Let me know if I missed any process.

Thanks,
Ravi

On 5/21/24 13:15, Michael Nazzareno Trimarchi wrote:
> Hi Dario
> 
> Can you add to next pull?
> 
> Michael
> 
> On Tue, May 21, 2024, 4:31 PM Ravi Minnikanti <rminnikanti@marvell.com>
> wrote:
> 
>> Hi,
>>
>> Can you please merge this PR, if there are no more review comments?
>>
>> Thanks,
>> Ravi
>> On 5/6/24 11:28, Michael Nazzareno Trimarchi wrote:
>>
>>> ----------------------------------------------------------------------
>>> Hi Ravi
>>>
>>> On Mon, May 6, 2024 at 7:33 PM Ravi Minnikanti <rminnikanti@marvell.com>
>> wrote:
>>>>
>>>> On 5/6/24 00:35, Michael Nazzareno Trimarchi wrote:
>>>>> Hi Ravi
>>>>>
>>>>> On Tue, Apr 30, 2024 at 6:25 AM Ravi Minnikanti <
>> rminnikanti@marvell.com> wrote:
>>>>>>
>>>>>> On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:
>>>>>>
>>>>>>>
>> ----------------------------------------------------------------------
>>>>>>> On Mon, Apr 29, 2024 at 6:22 PM Chris Packham <
>> judge.packham@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Sun, Apr 28, 2024 at 4:15 AM Ravi Minnikanti <
>> rminnikanti@marvell.com> wrote:
>>>>>>>>>
>>>>>>>>> Once a page is read with higher bitflips all subsequent reads
>>>>>>>>> are returning the same bitflip value even though they have none.
>>>>>>>>> max_bitflip variable is not being reset to 0 across page reads.
>>>>>>>>>
>>>>>>>>> This is causing problems like incorrectly
>>>>>>>>> marking erase blocks bad by UBI and causing read failures.
>>>>>>>>>
>>>>>>>>> Verified the change with both MTD reads and UBI.
>>>>>>>>> This change is inline with other NFC drivers.
>>>>>>>>>
>>>>>>>>> Sample error log where a block is marked bad incorrectly:
>>>>>>>>>
>>>>>>>>> ubi0: fixable bit-flip detected at PEB 125
>>>>>>>>> ubi0: run torture test for PEB 125
>>>>>>>>> ubi0: fixable bit-flip detected at PEB 125
>>>>>>>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
>>>>>>>>> must be bad
>>>>>>>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
>>>>>>>>> ubi0: mark PEB 125 as bad
>>>>>>>>>
>>>>>>>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>>>>>>>>
>>>>>>>> Looks good to me
>>>>>>>>
>>>>>>>> Reviewed-by: Chris Packham <judge.packham@gmail.com>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c
>> b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>>>>>> index 1d9a6d107b..d2a4faad56 100644
>>>>>>>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>>>>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>>>>>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct
>> pxa3xx_nand_info *info, int command)
>>>>>>>>>         info->ecc_err_cnt       = 0;
>>>>>>>>>         info->ndcb3             = 0;
>>>>>>>>>         info->need_wait         = 0;
>>>>>>>>> +       /*
>>>>>>>>> +        * Reset max_bitflips to zero. Once command is complete,
>>>>>>>>> +        * max_bitflips for this READ is returned in
>> ecc.read_page()
>>>>>>>>> +        */
>>>>>>>>> +       info->max_bitflips      = 0;
>>>>>>>>>
>>>>>>>
>>>>>>> Why this should not be put to 0 in read_page instead on
>> prepare_start_command?
>>>>>>>
>>>>>>> Michael
>>>>>>>
>>>>>>
>>>>>> ecc.read_page is invoked after the read command execution.
>>>>>> First chip->cmdfunc is executed with NAND_CMD_READ0 and then
>> ecc.read_page is invoked
>>>>>> to read the page from buffer. So, by the time read_page is invoked,
>> info->max_bitflips
>>>>>> must already have the bit flip value.
>>>>>>
>>>>>
>>>>> All the other implementation has a slight different way to handle.
>>>>> From what you said the reset should
>>>>> be done on for NAND_CMD_READ0 command and should be sufficient.
>>>>> Technically should be moved
>>>>> in switch and not unconditionally.
>>>>>
>>>>> Michael
>>>>>
>>>>
>>>> max_bitflip is not being reset to 0 across page reads.
>>>> Once a page is read with higher bitflips all subsequent reads
>>>> are returning the same bitflip value even though they have none.
>>>>
>>>> This is causing problems like incorrectly
>>>> marking erase blocks bad by UBI and read failures.
>>>>
>>>> Tested it with both MTD reads and UBI attach.
>>>> This change is inline with other NFC drivers.
>>>>
>>>> Sample error log where a block is marked bad incorrectly:
>>>>
>>>> ubi0: fixable bit-flip detected at PEB 125
>>>> ubi0: run torture test for PEB 125
>>>> ubi0: fixable bit-flip detected at PEB 125
>>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
>>>> must be bad
>>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
>>>> ubi0: mark PEB 125 as bad
>>>>
>>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>>>> ---
>>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c
>> b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>> index 1d9a6d107b..97f250483f 100644
>>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>> @@ -803,6 +803,11 @@ static void prepare_start_command(struct
>> pxa3xx_nand_info *info, int command)
>>>>
>>>>         switch (command) {
>>>>         case NAND_CMD_READ0:
>>>> +               /*
>>>> +                * Reset max_bitflips to zero. Once command is complete,
>>>> +                * max_bitflips for this READ is returned in
>> ecc.read_page()
>>>> +                */
>>>> +               info->max_bitflips = 0;
>>>>         case NAND_CMD_READOOB:
>>>>         case NAND_CMD_PAGEPROG:
>>>>                 if (!info->force_raw)
>>>> --
>>>> 2.17.1
>>>>
>>>> Thanks Michael. Fixed it.
>>>>
>>>>>> Thanks, Ravi.
>>>>>>
>>>>>>>>>         switch (command) {
>>>>>>>>>         case NAND_CMD_READ0:
>>>>>>>>> --
>>>>>>>>> 2.17.1
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>
>>> Acked-by: Michael Trimarchi <michael@amarulasolutions.com>
>>>
>>>
>>>
>>
> 
