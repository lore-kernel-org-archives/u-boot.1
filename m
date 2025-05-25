Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BADFC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 20:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8544582B34;
	Sun, 25 May 2025 22:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BfGFDKc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B18082B37; Sun, 25 May 2025 22:08:06 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2365882B33
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 22:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/D4kuycxl+ZwKZOE6oQ/CEw4SgfdvWt7ulWc7hhUbYK8HK6XZEvdKk+oSDIdlNR0UfUfCXi5nDJLg9jNs0+mmY5chyLaZRv70pyhYcQwFIhuw1uym5VXhNzBAPYCGbEH/Ajj5qTZLQBzsWV8fKqqQIlWyXDHFtxObGeBqDlJ2rfjwpibIcD5Nkbj+gyxa6XurrzSR3dkfiqge1ftRvn7fRcJrzAkXWurhbdHKhWvvJiXP/HDicoyN5pxhVPl0zNu/ItDg3tg/0uRfBJcQzFJdLUNgHZeWCGAQnYqnSlUANcv16kXLG8r4HJyitX+addUwVboTdoe/jzMSpwu5VrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btEvzktvQuj1Jkg4Bd8hG8bNXfSQdFPeYazgmaq8Hj0=;
 b=ghBdcP4k5AgXoIc3XvR9Fo8zxSbGyCEhAjPGCxDtN2keORijc3/d+rpWZ826myoPalste9f23qxKzlT4ryDBaqDeKcqKwsavecpQc/haDXKoFn1KDR9M/WT4p3JtMIBNm9gD8cjaOwo5hkDAo6zuLLLRpJpgn9wLnKdI4yMHakilDO2W0wArZ2UtfAbimNsZ0GXo6px6okdbVyPacdNTA2xkb1wjWf/4rNbhpZEnp7yg8Pc7qacVyZcPGPmRV0OUee8cREzt7XhJWjMiFWpoONigu/2LdJWnEetXOJMr4HA/SPXgm9PYJX/ZN0sCRD8juLKlytq0PXRFikktcPhqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btEvzktvQuj1Jkg4Bd8hG8bNXfSQdFPeYazgmaq8Hj0=;
 b=BfGFDKc1+zC7IP1pVQJnD/L64tcAMpEjnD+tsgZXUdUIgyT/o10Ne1J6TXXdUOAFSdWRLHb4jRK9SOc2QGGlAInYooBMSTOJAGF0+FtAwmhufWedLdzvkkEke1ntm3vqoJN15XkK6BvbcTFBVao8b2jYhPqkRs1/WC5pNXKUOmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 20:07:58 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.031; Sun, 25 May 2025
 20:07:58 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>,  Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
In-Reply-To: <20250522165656.GB2179216@bill-the-cat> (Tom Rini's message of
 "Thu, 22 May 2025 10:56:56 -0600")
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat>
Date: Sun, 25 May 2025 22:07:56 +0200
Message-ID: <87r00c3143.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: ba217168-c21c-49fe-761e-08dd9bc7d7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+wR3wim3bpbdYYF2b9wZfDoeLPfVdGw36ZpD5NLcAcvk4Gczq4qknugCOX2+?=
 =?us-ascii?Q?5YdLI4OaW+HKHifNXJVtJULYItXXZJeOT8VtUWNMLH+KMPYATYyab0UpJbhZ?=
 =?us-ascii?Q?JAgYnO119/bVlS3dsawueIBKEmHcfZZBsuJ3BAuNrWIjQgIXcpXjvi+D+d4s?=
 =?us-ascii?Q?+OWgveyfcZrIklUS4FSZxHX2GJPI1Etgs4sUOcASZG7FkMuZKKjEHppKHdO6?=
 =?us-ascii?Q?amXGWNc/SzocRWRP2HAlNhWfSBPJu8h1S7LU2ryNg06iNtAC+/DWL6TCLayH?=
 =?us-ascii?Q?yUdefqx1UHR29shdlH3kRShJA3sntI5xZhA3bbxqP8o8qa9M9WI+c2WylsTB?=
 =?us-ascii?Q?Qg7L7gKNwod6cCVMbt7Xlr1lmGpf6pgKKmmklaDT2Q75opPNekctbbQrSkBZ?=
 =?us-ascii?Q?v614bg94XJkH/4S/gm2W+N2+qAp0DvczCA4Wql5zqIYvZ1Pqnk3AAIUDXrwk?=
 =?us-ascii?Q?hWA7bdCWgGrdNEVkUFJJpjvO9RnokyZQ3T4CxCFdJaT/OEDgsyXMZSymdlNO?=
 =?us-ascii?Q?OenGIImphtzPGI01GfE0fO3FwcvTHcxX82Uq1Oo01dGgUIB6tKEveLLw++x1?=
 =?us-ascii?Q?gQdlv6xLt4BsxkwHRjzyd00J3ER/UpTk+sfgLhBFjd0kg52xzlTSYL1QeTME?=
 =?us-ascii?Q?gp+a8I9GZ7VkVCfLtxM1cNqPyInPjWZcncJDBXo91SogxyTXIhvA2URalqcc?=
 =?us-ascii?Q?fOmZfUXl18lHspzpOHL8zFlvNT/E2lpIvMxBwt1WmatUSGCFlcfUjA+2/eVr?=
 =?us-ascii?Q?JSIjrKyFyAM6Zg1zMG3DxQGRbmvvSzJwSh33eVVpY4eXPQupWUR77SPUMkde?=
 =?us-ascii?Q?/3cHRogPfuVll/qnuNeJ4WrmbNTo40ITpICVvw4hyhw+wIsW49fS93I5+3IN?=
 =?us-ascii?Q?GXgik1+lhsAcKAW4zEHnKahjrg/24qEOcHX4ejuu2f1rKDpDFptXE68yYkOl?=
 =?us-ascii?Q?dI1ozUd/sW7aH3FC2mjXPLQi4F02tXBBMobYkAEI2cLJAhuNWXZSVFvdq6PZ?=
 =?us-ascii?Q?ejqOQ2HqNjCiTngYaZEPRweLJdSIcwMpwpMzdzRXxkVCGhton7zdFWM5TsPO?=
 =?us-ascii?Q?c1lTVno9tHmbLWthF4cObLayv9dvylbeEq1avNx6HX/7OcqhFezSsg0pz7hh?=
 =?us-ascii?Q?/or1NQ6h2WZOwGqLU4ac0Me5frSpE8KAd9LBsRdkbsSq76XJ1H9fw6zRXl7h?=
 =?us-ascii?Q?t3+AybYnIm4VKC0pHNdK6jlUrEPEHFWmZA2WduCOk2IX/sGgyIZCo7YR+JYm?=
 =?us-ascii?Q?91BoJx9lIhO1koh+QfgAhK0DVOUFyqeiVG/T7Ib6PDi9e2PH2t8gRCauajec?=
 =?us-ascii?Q?otdVxH4XxyNuYNQV8bZfbXIgww0nOz2qzliSWhqcxpYHiiBjGqstnl8J5+eN?=
 =?us-ascii?Q?ZnbmLqjZd2Dbj5A1drq5H6vpTT/Fn+xujQhO3TLUf4Fd/L68jZjF2syjhiWp?=
 =?us-ascii?Q?TbrTAZu6A/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eiANccif4M78CgvTfnG/3u9e7uOCIpKxa0BREng9m07/YZX5WgldkT0yQqkw?=
 =?us-ascii?Q?VpKnm93Lc2OQ9KyFIChgnK9JHg54VYTfeC8XBvuDYmNOkSQOeZ8dG0dLhaWr?=
 =?us-ascii?Q?EICz2EyOc09XwVMxfH1H35c2Fv6QiNNPQnEHxVNhIsvz+SDeC9/Kef6X7H8J?=
 =?us-ascii?Q?Zjk/DfDLkPxTYdsa9eR+1zs7Svbg0Ol2IbydRCv7UZzAcbambNx0v+3zpxT4?=
 =?us-ascii?Q?ctm9CMTAuvqDgRdTULHduZ9kWiG11GNE1Xs1/YJ9bSaUV3MRPHMrbnDUQERF?=
 =?us-ascii?Q?5tMH0BCrIMzqskEuRdusPNUT9R9PAnLmKLhfJz4aXz98MW1vmnzsmIg4otHi?=
 =?us-ascii?Q?QWQwWXmuV1qpwZQm1KS2CHHrJiK9Y3sjlBNQ+4BrMIotE6IwUaiCkfDcqIkG?=
 =?us-ascii?Q?YdOEH5J0dwm8G8iPneE/mzuD6ptlcfYqGT5FywRvGdIhZ+cekiFUJSxPPL9m?=
 =?us-ascii?Q?ln7e1rxWyO0N7IKUYsIzyk0UJI9GfKYdhVUv2tXt+xUCK1Z/g1pu5mKUIejD?=
 =?us-ascii?Q?WkOk6K5Dtgv983ZqcA6BQXdRnlcPc2r3gaJXqEEEPRN/cCLsiL7aFbIne7Ad?=
 =?us-ascii?Q?bU/GxSxdBNhKXjFygygIGBt8LgMnb1KAvcCMNlqI13mA07nhJx4r2ejtPqJ/?=
 =?us-ascii?Q?oVMqbmqIZ9pJgH8pGULk2L8EaRlUQBvZAvOkrmUYZgRciGjfvyTLDU8z58uW?=
 =?us-ascii?Q?2Gk6zMW4kA95MiBqQOWTiv/0N4uu93LvYd3FvTzd/o8REvC9NTLEOl+MeqLk?=
 =?us-ascii?Q?tFGxAYqf0Nj+7hI4NmQGaw3atSKkpP/uEOUmymoOCc8eEKRlaT5hCVCbPB5M?=
 =?us-ascii?Q?5jIxVtfw5OGmkITZfPc3bnCe7Hw4ZyPjQMS5OXKI5lxNlOa3m56BzvTAQlfK?=
 =?us-ascii?Q?zQqrtruapr6zircZBKbuPuqDegKhEX1uIo6aPEt34YvKsmQidBUUTGD58TuN?=
 =?us-ascii?Q?5dwNWZLm/cNWXNZQVyWPIKWtZwRWUXH1bzO5JWnBTrmt2O/dZ0SzXhuNopxI?=
 =?us-ascii?Q?UT+HxpuaK1TyMA2Po5HSXp0AX1X0jH3Wr41HEYXGgy4vpzWqX6NmhW3bHMib?=
 =?us-ascii?Q?Hur7icEHg4ZB2wjoEHlK8kAD8mPGz/IWAHQvEiV0TuR9BmW/ern2AHz04/7O?=
 =?us-ascii?Q?Wt3VWXuqRq5DrIke46da51bPgD2LcLCntrdNeY2rIqZrZ1lfYpvRTYBFocUm?=
 =?us-ascii?Q?GfTKW8gUUlukuHjl9yk5uJ+sO4RHFBJv31wiCAWTRgbkIqCTcX3d08Be8t/1?=
 =?us-ascii?Q?vS66yyY/4kdEtDMYB8hm0cUtnPMSbC2hPGEzSIj8NW2KHD8DjeLIuvSkSZ88?=
 =?us-ascii?Q?Tc+13oJbyamZSxlTSv8h630pLsWRu4Qsy8jnmim5itzdSmAo2sHvP7iSd3hU?=
 =?us-ascii?Q?vChuBoCGCSvcqEcsIvby/k6xQje4fLWOQ50OblfSUHF9nVTsOKBadBo/O9Uw?=
 =?us-ascii?Q?0N28Y1B0VbMxNpA54gd+0waeRdm5Qzy4VO5+P+t5Y5WxBEgBkFY46ULLo3Bq?=
 =?us-ascii?Q?PHo/iqENPMAEf8yAaYes+/WuZMlTT13N0WjKZEQ5RVVvN/ZBIL0pW9rFkWiQ?=
 =?us-ascii?Q?31t1lQHANaHfHyVx9XqJD4Q83dm1iu8sH2+SkQG/uTODY9Eo+iqJ2mJ+vsVB?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ba217168-c21c-49fe-761e-08dd9bc7d7b5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 20:07:57.8300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUQoFwaHoY0kgf0/rnstrzJh1WUr6PGUqO2DLfxV1Po9aUiW0SlB3WgA+ZskETp0oZEOIbvPtbPTjhpEWwLqzDePMeQE5MVu6vehVNEeqXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8705
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

On Thu, May 22 2025, Tom Rini <trini@konsulko.com> wrote:

> On Wed, May 07, 2025 at 02:12:42PM +0200, Rasmus Villemoes wrote:
>
>> While looking through list.h, I saw that the regular list_* helpers
>> (and one of the hlist_* ones) still contain the prefetch() that was
>> removed in linux 14 years ago. It doesn't do anything, but makes the
>> macros harder to read, so get rid of it, and the fallback, no-op
>> definition that they relied on. That requires removing a few uses
>> outside list.h as well.
>> 
>> checkpatch warns about some whitespace issues in list.h, but as I've
>> copied whole kerneldoc+#define blocks directly from the linux kernel,
>> I think it's better to just accept that so that we don't introduce
>> needless diffs. The "macro argument reuse" arguments should also be
>> ignored, as e.g. the "member" arguments are obviously always just bare
>> identifiers, and the "pos" arguments must be assigned to multiple
>> times.
>> 
>> Rasmus Villemoes (4):
>>   linux/list.h: drop use of prefetch()
>>   treewide: drop no-op prefetch() calls
>>   mips: drop unused prefetch code and logic
>>   linux/list.h: drop fallback definition of prefetch()
>> 
>>  arch/mips/include/asm/processor.h |  16 -----
>>  drivers/net/mvpp2.c               |   1 -
>>  drivers/net/octeontx/nicvf_main.c |   2 -
>>  drivers/usb/gadget/at91_udc.c     |   1 -
>>  drivers/usb/musb-new/musb_core.c  |   2 -
>>  include/linux/list.h              | 104 +++++++++++++++++-------------
>>  6 files changed, 59 insertions(+), 67 deletions(-)
>
> Unfortunately this leads to build problems on lots of platforms:
> https://source.denx.de/u-boot/u-boot/-/jobs/1141951

:( so we've been relying on that prefetch() laundering away the
volatile.

Which really begs the question: Why, exactly, is it that gd even has
that volatile qualifier in the first place? 

I'm 98% certain that we could drop that and get better code generation
and avoid a ton of places where we cast away that volatile which
shouldn't really be there anyway.

Rasmus
