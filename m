Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BD8CE8D52
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834FE8901A;
	Thu, 19 Sep 2024 09:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MHq4S+0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7806088B64; Thu, 19 Sep 2024 09:01:44 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9068901A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML2cwwUxtONs9MebJDAcxxbm1UxqSg949qSqq+LbJRxfmVUuCf5pKSvMyziRr6W25/7g2gJCBmqwG9QvPQT4obkZIzeIwi+zuikC2AOEsx8cHeq/S5nxFcKo1b0wgPZkN1mEwL6t/JFKagkdN+H7sI+InXayYo2e+hu19aU2azP/x0pwT52AvZD4G++0xXY2mJ4sb7r7G1Bd1ynVTLl7rJ2NQrSXg8XvnU3Sw0/k2XL9Qw7paeHc7WxPul2VYB40martD4AfKK1HcfFC3rAcGQsUwMsyf4TIc0SEIeTuFfphX3PUx+Zn2qejlg0vf+KiGK+znkf3V6dbFjJjfECi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVWdU/tTQjnwmQKGef9CH9rATx5bRC7+OmMNLJHIRmc=;
 b=nCv51tix0oqLu/g8OupCU4eKG1TwJ7lIRC4Shce9tAJxf51EIiG3oUcTRhl5OdDNRmgbXNnLgfoGHTaZx8uLfPNZT8ZZ3k9wDQY/TpquDD3M0NnbqY+DM9f1wz5g8QrfvhLbpYntnqJ6tnzIFhZ53kgoJr9L95RfqYr024HS2QSIujbFXvYDwtek00fh+UauKMeOr3DRh9BXirjwCG8zsytVbUABQOYWK7Gk6aGFwTzHUV+R5ZOXGAaDmvlLN84C+n94MqZXDTPTZzmVIA2CkpOODVuVo9+IiBu95L6LJ9fqwAAxWlqZD+o9L3uytJ1hXgnhrqeXXj8UJLUSbNymyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVWdU/tTQjnwmQKGef9CH9rATx5bRC7+OmMNLJHIRmc=;
 b=MHq4S+0RUPexmbMGSwM+lwJBJOLXmRwSvUDy63WqHTaWb+rPUVgJD6bKelBmYkWCYCJqWMl0qVg2BLcaJ6DONmG4EmNQGYbyRq35OLWqLGOQroRzxTKsmfGwpViuaE1RH1P0SeiSzuy7nj9q8xV98uYENZOnWKNapbCo9AjYF2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB5690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Thu, 19 Sep
 2024 07:01:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 07:01:39 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Patrick Delaunay
 <patrick.delaunay@foss.st.com>,  Marek Vasut <marex@denx.de>,  Emil
 Kronborg <emil.kronborg@protonmail.com>
Subject: Re: [PATCH 3/3] env: mmc: rework mmc_env_partition_by_guid() to
 work with two separate partitions
In-Reply-To: <72e37714-bdac-4334-a2a9-18d6ea954b73@cherry.de> (Quentin
 Schulz's message of "Wed, 18 Sep 2024 18:59:29 +0200")
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <20240912134141.4143855-4-rasmus.villemoes@prevas.dk>
 <72e37714-bdac-4334-a2a9-18d6ea954b73@cherry.de>
Date: Thu, 19 Sep 2024 09:01:40 +0200
Message-ID: <87y13oktyj.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: 262c8ba0-bac0-4c81-2d26-08dcd878e8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rZ+SVGZ1gfHtw1ow6Wg5KBOyILmheH669CqjDMYfg9z+2lamk8cNh9RySfR3?=
 =?us-ascii?Q?cCKm7s17/5KNU6HlXEfP2mNrou73OxuqIWd+pP1cnbnWJyrJlm8XvyQrN2XA?=
 =?us-ascii?Q?uUu+vzEqRQhLL3xQOGIL+M8adkdRgTSAQQmwBL2HgVx1XvkB4G5IFNhqyLuW?=
 =?us-ascii?Q?RCtmQKtZy3dMmvLJrPd6VAuQBZ6fqq2BhxZfdJRkJ4BJUnaOuQXSnapwFdWX?=
 =?us-ascii?Q?E1Gm6AOjWe0nsm2gY8ct5DgxBPYhpzFZV9nSdF0j1cf4UrgmAiu2htTHyNu7?=
 =?us-ascii?Q?B/g3+y0IgEDRhIip9L9OOOwRPLqu2DKP4ux/IRcF4umYVjEJIR06bxQok/lo?=
 =?us-ascii?Q?8iut3C529K3otLpeRKR4SqSgFSCXHB3efnGlf86e0KZkeswloVCICpTCX8Gu?=
 =?us-ascii?Q?Yx5Ss5GLDgks3is5+z/w7WqZruWB7EkX9i2VhD/m0vN0U0QU2H7vnb+L99aD?=
 =?us-ascii?Q?vakQjii2wsjmWK8OG2xM89j18s5vzfmN3+RFRj1YxNCkV5KKM3K660DP6330?=
 =?us-ascii?Q?JO2BHVbOd/FlgyoWiHsQSlDzxLuXyf4kL7Cn63p1gGQErlnCcbHj2gM4dxWh?=
 =?us-ascii?Q?NAootifKWgORv1M73Qs0NE3PhaUlDhViludK/VWPHHwioukS7TZn8Wun2L24?=
 =?us-ascii?Q?bAasB+pP9cqQcvmlTqUHzsnYb4fikloHJWpSA/2a6tkcocsyJFCVf4xomZlW?=
 =?us-ascii?Q?o5M5VNajF257zRIUOVfj0q3Dx5O1sDL6u8yPy3r8FpsX5IHKmkg7Rlsdad7h?=
 =?us-ascii?Q?i9sOXyNOvdVQ5sEEvMinZz+oOijWPYIvMLzoH/VhVcEU4fYo/EWBjsS60AHk?=
 =?us-ascii?Q?qXA4XJzxGdLCJQZJx/fvvrUIqShzTTaBdyafxK0PZYqDdnPZRlDrWoX3g0CC?=
 =?us-ascii?Q?OIcn1nQ4ZIE1NCBL76M8phYUIDLPPxRKpvTEMbbnT8vHWq5gtQSbnZXdKhqY?=
 =?us-ascii?Q?Xxp2VbN49/FLdX3OhQs90A8Tbi8Xc/vQbHY0g9HBmpzFbz0Fwt3LN94S++TN?=
 =?us-ascii?Q?tpB6tuiay89T2gM0S1cRysNwIDQn/ELDt76pRiuAorbg8Kz8pdxfVz2KHE0N?=
 =?us-ascii?Q?6xiJEMP7+cFplwTkQ9aBtsxf1pUqMTeFzCq8sJEJdZvWXYtxuiO/cnc9bc4U?=
 =?us-ascii?Q?vCu9tvyShhf6+PEGHC1WdIB4XVN5mX4M/TBIf6vcpf9gw6G/F8c5WTzyq+wT?=
 =?us-ascii?Q?497ofR9E4K7G9y+9EVdYd6ea78155aemOoMTKM5XD2UTnEaoAwNeVC9L6KTY?=
 =?us-ascii?Q?YTwBm1qO/hpOmqEJPfbPzYOpnorq3BgDTK1xeQCza4zXB0bUCUMpmcVwXidH?=
 =?us-ascii?Q?COBRHZC6mINmoSH5C1GrQ9+L//7E3Yr4QXeT6DblMdhuS8SYjDEa2/xYSpyD?=
 =?us-ascii?Q?jjY9EPd77l/+ScgufYt1XW8kSHYPZqACzje/yRzkJ0+smLxufA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZFqYOaox//NzAS+uCioIEyH+NzRuFOZlENxowvIR8uu4AC5skeCxkqaLg/T?=
 =?us-ascii?Q?YVkA7s+fzhEb/aaeafRVuZnD+lZ+CqhZ76fRfUSeKCmNRHqUUrlXIKPt8AGj?=
 =?us-ascii?Q?qxLnC5/i+QW/pZO9LHZ+ykDuzhScMI7bIRSIcDeN4SPZSlZ292hEwYZEiONV?=
 =?us-ascii?Q?DxcUaSbmL4MLrCvwDP432ccEYPNCvd3XfJ+q728rFSGFt+gJb5Tj0ry/6Pqj?=
 =?us-ascii?Q?M40SazHEqGOVlruuQ+YUgAfiVvjD8rTk9qODo76HTYKWyM8yBQxPv1qSBMAy?=
 =?us-ascii?Q?jZrdx9fBUnVl5K4dwXlg4wclqfaheFQh3w7+opZ8c2G70xNoSUpGmiFDGJbP?=
 =?us-ascii?Q?DwKUzkwCSE36mymHoVksLtfLznHmBs6SAKK9j5JosvYw7yGnRx+amvO6q7qQ?=
 =?us-ascii?Q?q7vpn41FWenT9/ZBIwk5H9Ml/Q72zg9GwldvJyqNqu66aF1CSngLk0H9/MfD?=
 =?us-ascii?Q?ZoshYZeDB0S0gJ56Axrkhalfy75mePv+2MS7KzS6oGQekueA9ZIKUhvg4bsE?=
 =?us-ascii?Q?YjCk3L3tfzTAolOMo6AQmtb/GKKl18/wf27TsB6JyQxDYD2QXQKWmMfoGfNI?=
 =?us-ascii?Q?7liVz8P+vT5SWXA0nCAFJk3sZZGUFYNZDSR54+dLD+md2b9OlOXHDGweGgu0?=
 =?us-ascii?Q?9vIoEzhSBZlNgEGjrnEXEoG9u0ZX22OBT3TbfX2enKLVJv//Da7ouswdxl3E?=
 =?us-ascii?Q?1WgzEG+7OR9ae+1iv0tYIKMvJP7xvwRPzeuKqqhKKtFVUqPjy2/gjjE4poSz?=
 =?us-ascii?Q?LMSC2FUqNIJ7303KthgsmgnT7q5P+FFqUH5Tg3FGqoZEQ1810fGlgYgl5G4N?=
 =?us-ascii?Q?uAn4+HsidRwI2t+t2BfWXYztrkmsoyFWkg6BRQ0BlpfwO/23G3vXCAaPXMTv?=
 =?us-ascii?Q?hQ/Gk3lm3OLb6tTufJE2SlKtm5w5KVQn9tz1eoGbl1dEqWZxlaglQNhB3dIe?=
 =?us-ascii?Q?IDP0+M+5gwMN0P687ih+ilsvB4Gyw9SKNRyMdEsiUA68lml48cWcEZv3353E?=
 =?us-ascii?Q?Ouz0cp+9DrD2UI5OOapUtr+KOupD/b1zzEd31Ja7pPfPxiZ+hwGyLEvTGtsx?=
 =?us-ascii?Q?BXU6OjbAXs0Y9gzzFU7QDktZmuTHQAAf/td/b7OFUMUQEcNcYSlUOA95IIGR?=
 =?us-ascii?Q?QMqvktgjaIbi4XYFJbEatgqO0Mil2Z7XbIDQbSUlNmE/HonwJInR41TxH3IL?=
 =?us-ascii?Q?bs2ODrYkvPbwx0qHtakTdelPTIUw1v9QIgjJa4iD0AqTYD6C++kl+iZkYeNk?=
 =?us-ascii?Q?Q+jf8KMoeiUirmnmPa+lNiLrWX+gSO9yPrypos5OGGxqYkY2WqFpLwKCQHaq?=
 =?us-ascii?Q?eztwlJArYfheNERFC44cPlJkCKoMBwwM9osbumYtfwJ4UlOSlpFGxdJglnW7?=
 =?us-ascii?Q?W/X1GQW1sa1AF9RC5C1xPPDBuzTxpPIHfCEDlR3ED4aNGzjltM5uqEAjAG2I?=
 =?us-ascii?Q?Qr/EmweBapK+EEW2JJGkqwSsGJ5MmqRyRPk4miKrn2vnvA+b8Q3/pRV8VcOM?=
 =?us-ascii?Q?aHEm+QLz1V//OPoZuxpZ+ZfqFslVf8J+Bzq+Lq9bEZAjk3JB5gpUWaD3mYUX?=
 =?us-ascii?Q?kY6+V8oJaTslNWQ8a/sm41aKOplA0F45BmPfUXQspuIIyNS2Ta8hnfIW7gbf?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 262c8ba0-bac0-4c81-2d26-08dcd878e8f2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 07:01:39.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pwhtv1pfFfNjRjWCJb1kfF37upAqexaYWa7ik0PgMWZeWibjZG60dHzm8DbY9UBnXkJJcm7jVc28cbawH3PvfzYdTCPntfSmwC8pIkAwuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5690
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

Quentin Schulz <quentin.schulz@cherry.de> writes:

> Hi Rasmus,
>
> For this patch and the previous one, should we have test(s) to make
> sure we don't regress?
>

That's obviously a good idea. But I don't have any idea how I'd go about
writing such tests. AFAICT, there is no existing tests of the "find env
partition by GUID" logic that I could amend, or any tests of any of the
"find the mmc partition containing the env" for that matter. Pointers
appreciated.

FWIW, on my end, I think I'll enable CONFIG_PARTITION_TYPE_GUID on all
our configs and stop defining the real values of the ENV_OFFSET, so that
our boards will start depending on the guid logic to find the env
partitions. Which will then at least eventually find a regression, but
unfortunately we usually lag some months behind on upgrading, and very
rarely have resources for checking -rcX, so we would only find it after
a release.

Rasmus
