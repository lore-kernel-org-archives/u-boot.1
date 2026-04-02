Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3756AD6AAFF
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A510983D8A;
	Thu,  2 Apr 2026 21:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uTyoJMYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550BB83DC9; Thu,  2 Apr 2026 21:21:42 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D15C83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 21:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w73AAFsDEU8sqDQ8R0AWmwlXsL3y+MpwegSzZTKKkmu3PFvp7uT1TpZE8h/hz2h7Qhun2C94K29hCAj9sZwA+dz9vEeggL1qu4ewFgqzce8rseqgxhf75mLQX+EkUEiP8OpXUNBeJ5zjWKwtxv280dJr8WVEqkDrsdvnSf0JxtIkvDiQktBwV1V+TVShDC2H8JDjRkze+mkl+0lVt0VBjVRv1ZnU+dxJo+YSFU40Ev3ADWapDAH9b2mcPT4urFXlJz3SJTysT2F1JYumIZo81ZtpSvrj+a1Uoa951Q0jeb6rqSf6S0q8P6hXxM58ZOn6LaStWIR3d2BcrWHcIP2lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en8A6/fLVjBdZyT+z3/5/BSfG+X7aA+VIjHq9uCxdZU=;
 b=JDhaiEfoyvIw8EtPv9ZRQEciVSPl7t1Aj483GETtdZz09h7pjU4+NHVbeBxuGWRADU2EhvaQqF6l1ELpMGMJAEl5ZEq8dmGBFOBK5p4bIuYRXg+608jEMVv160Ca7xn6AObIuxKHhTpJw1h1rLyvGk4ZT9R09GUBq2tN0Va0rkVF79st1lQYf1tKnLhJC3222dprbrTgs9afeSQPOcN7HjM1hmZG6X8oztsRfPNSC+RgLkhZDefjuM7t3UM1rHfUDHYrjFwqw15Fkka8mItnDCvaocT3PwNFeD229Sag+KLeb9Vxhk6KT0uVtVVmA4+8fllZAMwF913mSOulIVk0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en8A6/fLVjBdZyT+z3/5/BSfG+X7aA+VIjHq9uCxdZU=;
 b=uTyoJMYWQtDAK3yjGbflu1sHXS9BnZvyCScDNm5vuJkBix9Kez1woUtlJXzbT+u33F+Zq1RLhN+xkJFz3xbbUKC+k5CdtUyGpvb1bNUhywVvGvxAAwygNvwo4S5akszHQmIU9fm2FAWZ/YvfGbeEs/xPQdlbaFp+szpe4F2WS+M=
Received: from BY3PR10CA0022.namprd10.prod.outlook.com (2603:10b6:a03:255::27)
 by SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:21:37 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::30) by BY3PR10CA0022.outlook.office365.com
 (2603:10b6:a03:255::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 19:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:21:36 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 14:21:36 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 14:21:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 14:21:36 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632JLZsR3042246;
 Thu, 2 Apr 2026 14:21:35 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 2 Apr 2026 14:21:35 -0500
Message-ID: <DHIWVVH1JXD5.11ARAOXG1SPKS@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/6] efi_memory: nitpick removal loop
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-5-rs@ti.com>
 <CAC_iWjK8BNOtyreZR6WRO98z673hthQENN9Fp73+igzaifUuLQ@mail.gmail.com>
 <DHIUPNVL4BG7.1UZWSP0MV8LBE@ti.com>
 <CAC_iWjLJc68iL0swF8XcJK8x27aL2DR9bRBvq0VW21-CTXx2jg@mail.gmail.com>
In-Reply-To: <CAC_iWjLJc68iL0swF8XcJK8x27aL2DR9bRBvq0VW21-CTXx2jg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SJ0PR10MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fe7ad7-eaf5-44a1-1ae1-08de90ed0f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HnR6q6itPSI/YCKM20csYnsiQ3WI3fUMlzVEey4MeY3bRFKDOdfvZC141OH4lpJIrP/dCEJJvHvD56wcZo1fYSa0S8U+vk0/pPrVCf2mK3oGV2v9JkMwgB+WsDuBO/jL6m49e2tKh2hEHU5yklUAiG/BYZoLkz0Hh/MmSho/IS69vzNRKPDQ/c+k2Yd8UzqQD5Z1I30ezxovrBQ7x5XbKkADny54VPERafptD3hRZfyIlLRS/oJSI/gQmuBSMJns9FyrbAjdpOb+tQiE8J6xVBjtctC0UyEnJGAV/U7Qo11VQ7xlFTHKGPjaR4zwRncHEDewpNjMfKJpYiD1c4yeQ4iui6qs33W1PfhTDmqtQr5j1CaKFjH7Eo5enm7451obkwqSo6Dl7+wQltsjxoqOIt5f5J04yxuSx8nMiNflnDul4YnXOEg3y2+q7opKI7WiC5yNRrDqijN/lNO77MfmSJd/4jas6ShyENZjYfu6sI8G5yHtYUqsez6a0aaWn1SbZOCFR5sV89NqkXyfKeGURk69yfxzRrmTTryIds5z+PQgcl+FQbI7QDC8z9HScKCwu3aiUODOJBgVWdzuvzOztPO8Jh3+0SjhSzqAnXFbmdoTxt8E0Uaw+KZy7Ql0TTJRHIRuquFgvfZP6prXputwrRgJ43ospFsc+AFhFp6xnyXev+wcGUQrktvpAi/Wt3vCedHlfkex/hozQgbcJzU8w8WWkJ1wb87z0BfoMqR5R0ldteMJICFSyaoLv+HKpwNMw7DnGHdOE75b37cALv5lwQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F60E/rpcrq9vd7JqrfAf8FeBpyZ0DA7Bm1mVj8fkDrUPwOpWOE3FGUCkQctcRsksjiHemBDo6bE+iVVC/m2YCYdD2idwHg/Sw7usVzyDd1dr51mjQs0deXYchPYU0uxBuw547NveePrX6n9h0YHzrfLNsFJlZZ+VvkktVHjFSGMH1gOu+7Q2WA0SgpJ0DaugD8j0H0hoSF9XMSZRHBrM/9Oy1eAUuNKTOnmxnGo1t+6dyTjEvSjVousmxELQuzoqpjlYw7X81z+qUUytCpK/wYY1wiW3cyGE12vV2UVYymLqsoGt73+zvCGNlQl7DmV+G33jJZlTjS+SU6HSRtuCEI44u/IYzXrMjgnrpTfEy0wtV9uAVQhzveIfJn+ue/OuxPZha932Y++gnguWWfxzl1wYkO606ItBOWivm/ObZAVogWxLa/BJuPoNIo2+voUf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:21:36.8404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fe7ad7-eaf5-44a1-1ae1-08de90ed0f33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
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

On Thu Apr 2, 2026 at 2:02 PM CDT, Ilias Apalodimas wrote:
> On Thu, 2 Apr 2026 at 20:39, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Thu Apr 2, 2026 at 4:04 AM CDT, Ilias Apalodimas wrote:
>> > I don't mind merging this, but why is the current code flawed?
>> >
>> > Looking at the function even if prevmem contains a previous valid
>> > entry the check will fail
>> >
>> > if ((desc_get_end(cur) =3D=3D prev->physical_start) &&
>> >     (prev->type =3D=3D cur->type) &&
>> >     (prev->attribute =3D=3D cur->attribute)) {
>> >
>> > and re-assign prevmem.
>> >
>> > So please adjust the commit message if you want this merged.
>> >
>> > Thanks
>> > /Ilias
>>
>> Ah, not really that it is "flawed" right now, but more so that we should=
 never
>> even have to think about that occurrence, because at best it's an unnece=
ssary
>> compare. Why waste time trying to defend or attack a line of code that s=
imply
>> shouldn't exist?
>
> Not attacking anything. But the commit message wasn't as clear and I
> ended up looking all the code. Chances are this is going to happen if
> someone reads that commit message in a few moths. So something along
> the lines of "This not currently a problem but ...." etc is what we
> should have in that commit.
>
> Cheers
> /Ilias

I didn't mean for it to sound as if you were attacking it. Change requests =
(like
this patch) are always the "attack." I'm just being lazy and saying I didn'=
t
want to parse this and come up with some specific scenario where it could b=
e a
problem.

I'll adjust the description to indicate the *usually* unnecessary compariso=
n
that's occurring right now. Should be a good enough justification on it's o=
wn.

>>
>> > On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>> >>
>> >> From: Randolph Sapp <rs@ti.com>
>> >>
>> >> I don't even want to think about the possibility of this pointer
>> >> containing a reference to something from a previous iteration.
>> >>
>> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >> ---
>> >>  lib/efi_loader/efi_memory.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.=
c
>> >> index b77c2f980cc..882366a9f8a 100644
>> >> --- a/lib/efi_loader/efi_memory.c
>> >> +++ b/lib/efi_loader/efi_memory.c
>> >> @@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_des=
c *desc)
>> >>  static void efi_mem_sort(void)
>> >>  {
>> >>         struct efi_mem_list *lmem;
>> >> -       struct efi_mem_list *prevmem =3D NULL;
>> >>         bool merge_again =3D true;
>> >>
>> >>         list_sort(NULL, &efi_mem, efi_mem_cmp);
>> >>
>> >>         /* Now merge entries that can be merged */
>> >>         while (merge_again) {
>> >> +               struct efi_mem_list *prevmem =3D NULL;
>> >>                 merge_again =3D false;
>> >>                 list_for_each_entry(lmem, &efi_mem, link) {
>> >>                         struct efi_mem_desc *prev;
>> >> --
>> >> 2.53.0
>> >>
>>

