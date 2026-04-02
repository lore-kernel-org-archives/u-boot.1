Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E77D6AAEC
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 17:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFC483F7D;
	Thu,  2 Apr 2026 19:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UQdiytKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F361684020; Thu,  2 Apr 2026 19:39:37 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFCF83D8A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 19:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vls1AsYOr3pYzVhRSZCnu6qxZkbQb+W8M3KnUzOlL+yN3JML9rj9Q+GV2F3oncSTdhIXq24gDdqn21eJynfhruWLcziRZ2KuxwaDm7jGLnjY/TAQhEU6YyYEN8cNryuUG+YYyvc5Q5QM5evsE85Ysgv9y2NqxahPoeAinTs6AFqb7javHC1C1js9r08d1tapbqvPEASqpRswgBp6Dt9K4EV6XABH4SFC+yGlsZpEtsPxYHYhX2d4Kv4CAJuO0TzRWZOVMJw5gVzGrsc+karixbn6kYrIHCpqCoWUM+oux/5rGR45kRuviSiv+JorOG0xzrZioPbo7aU1xh/HuyfO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A4+qFL8M96mXEsh40exBvaHWDnwa1CTYkHWQPiBaFg=;
 b=QuqdBWVuM5R5iHmb64nAeEyhsL2/Ob75Q0uNBzxdnvSnVfpnrcgDsgk8z9gGGtEBmlJmoixTN2j+HXELIpQpWAvqMIo1qQCCg+3crBOpRdGTR+6EPjkmXv3jvgdOgM6kM3FizitiXdkEO0m22I2Sem7nNsE9/Q+bocu40nXcDj5hHAd9XQX6fXNrHoeVbI+kWtCgp5Cdim9obSD5Pzahc+dAT4LKI/sE5Lmr1kTjdT7KsTKlDuoanIhl4IKm8eiyyi3ktUIR3pwTg7a/2a9M0qwDq+jtqvfaE+SBNmsMzP0se85Xa9QhP9JNbJy50q36JYV4++0V1+h9jI8uKbnTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A4+qFL8M96mXEsh40exBvaHWDnwa1CTYkHWQPiBaFg=;
 b=UQdiytKdkOcOlokqJAUZuREZjpzUWgt0EYUySFWlucly0o9STGxFEVL8mYQwbwuAS82AW2NQYxZhUokcVbXEkBswxd/GFstVROtxrDao1ZD520NDhcDjS+AJUvdVkOBnM/gJm7NcO1XpF5lhMSGC1+O9asorKQRDnW5/D3rkC+4=
Received: from PH7P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::18)
 by MW4PR10MB6631.namprd10.prod.outlook.com (2603:10b6:303:22c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 17:39:31 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::c3) by PH7P220CA0037.outlook.office365.com
 (2603:10b6:510:32b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 17:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 17:39:28 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:39:27 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:39:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 12:39:27 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632HdR7e2435419;
 Thu, 2 Apr 2026 12:39:27 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 2 Apr 2026 12:39:27 -0500
Message-ID: <DHIUPNVL4BG7.1UZWSP0MV8LBE@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/6] efi_memory: nitpick removal loop
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-5-rs@ti.com>
 <CAC_iWjK8BNOtyreZR6WRO98z673hthQENN9Fp73+igzaifUuLQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK8BNOtyreZR6WRO98z673hthQENN9Fp73+igzaifUuLQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MW4PR10MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b481655-b7bd-47eb-dc3e-08de90deca43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Qzj74Z+LkMqZSycjsyhgg85BRx1cH8zukIP7Su36u7OsM5oxmMmBIiI85HvGQBx1+hiukrZh12Zi6b30te+xprPdExA4/8SKKqSzgCNcJocn0AOC97mLpUJ9wy+lnOwTl4Tv5TFTcXonGjWbwrSv+NVVjDHvGyC4YojhvwyFcw5PBAyB2geX8zWL5IHjzxJkloxMDLAQyTSd+m/IonSFahsPgjC02JruXxt+pgTtUajUnNOBAmpq545MkW35hW6LjA56VEoseViuSgx4nrbwwWic7iAP5JPnLG5fx9Bs0ZFj/RAkKyhFAln+cakYCxdvXG4ONujcZ2zcPMBf79eQnQVyouzRcUvD34kvvuh+5CF0IPH5+21rU6SPxSQcbvKEhYNjmOfomXUqkjiof3H+o660FVL5SGL+y4aK8MPo5dbZ+/c7MYNCDjpIERxkTd/hYfw5tdZBvmujU4VUtYgGwMqXh7lO4HDl44XUGvIpZFA86ljGDuK7LykAMoMOb2nOrFTGHt1oZ02lczORisMtUSS8CzbpOXu9rloqtrgJUONEt1Xb3kgMxuSTIRLgmwHF3W9xEnzTOgo+dcvY9VUGQbRCylx/8u/MOWWU9hKW4K4SIjqkEI9namMqF7uC0qjGyutzoPnrljK9uDwk5ATiEpqcDyWP9Db91mmejKH+ux+8K7FvTtPRcj/nROFhOEAXL/lSD2v8dj0t1ChAaQov+boBpEsDflAU022pvCNPjNwQDCtmDv1MlKvaYCrFLinxop/MpCkWEJPzOcZp3Q44KA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kDoUrrf4gfGEhmWfCrGbArssIbhlF4om5D2WXdJbwo3EUjlb6v8O3Fngvdr6mT/kTtL1D1PA+L/yPNwkdIYBBO8lmZF69nk1AAPRjN074QJiRFE2g8r1qMPedKZRbQJo7T0lqpy1D9IKpQOgSbpl1v9SuHRBfJnvxs4AnVKJ1rUZe+M+efiEXZnO/FJwAA5DFanrW/wkP/ec7wTjytSAevQlbJ77XJQaj3ySStZaM8Z8QMG26GTONJifvzbrPmeT9/rTBM/QfIO4SgDrw3vJ7z/2EWs7xjiIi5f2qkaGE/bW5pUVfWAtR1JXteLRvdb2Yky9lCTwLWzgRZBB82gc2R9cE7/x2Qi34iSUdsB91xA1ylbj8/cznqQ/b8HMyTonx3Z/SJPibOWJNNRVxNYMq3o9LycKEaSppN4XuK/+nCcSAJNGKjAV/57CEs7mRrDz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:39:28.2769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b481655-b7bd-47eb-dc3e-08de90deca43
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6631
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

On Thu Apr 2, 2026 at 4:04 AM CDT, Ilias Apalodimas wrote:
> I don't mind merging this, but why is the current code flawed?
>
> Looking at the function even if prevmem contains a previous valid
> entry the check will fail
>
> if ((desc_get_end(cur) =3D=3D prev->physical_start) &&
>     (prev->type =3D=3D cur->type) &&
>     (prev->attribute =3D=3D cur->attribute)) {
>
> and re-assign prevmem.
>
> So please adjust the commit message if you want this merged.
>
> Thanks
> /Ilias

Ah, not really that it is "flawed" right now, but more so that we should ne=
ver
even have to think about that occurrence, because at best it's an unnecessa=
ry
compare. Why waste time trying to defend or attack a line of code that simp=
ly
shouldn't exist?

> On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> I don't even want to think about the possibility of this pointer
>> containing a reference to something from a previous iteration.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  lib/efi_loader/efi_memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index b77c2f980cc..882366a9f8a 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *=
desc)
>>  static void efi_mem_sort(void)
>>  {
>>         struct efi_mem_list *lmem;
>> -       struct efi_mem_list *prevmem =3D NULL;
>>         bool merge_again =3D true;
>>
>>         list_sort(NULL, &efi_mem, efi_mem_cmp);
>>
>>         /* Now merge entries that can be merged */
>>         while (merge_again) {
>> +               struct efi_mem_list *prevmem =3D NULL;
>>                 merge_again =3D false;
>>                 list_for_each_entry(lmem, &efi_mem, link) {
>>                         struct efi_mem_desc *prev;
>> --
>> 2.53.0
>>

