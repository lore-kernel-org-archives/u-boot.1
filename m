Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACED0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B070A8842C;
	Tue, 18 Jun 2024 20:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB0387E49; Tue, 18 Jun 2024 20:16:49 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED02787CDA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jhumphreysti@gmail.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IIGeYI104198;
 Tue, 18 Jun 2024 13:16:40 -0500
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IIGeHG017869
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 13:16:40 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 13:16:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 13:16:40 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IIGeL3003659;
 Tue, 18 Jun 2024 13:16:40 -0500
From: Jon Humphreys <jhumphreysti@gmail.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
In-Reply-To: <CAC_iWjJVSJCokmQsDVJphAVWX=vfwrDGmj=cqyiGHCvkPPbcug@mail.gmail.com>
References: <20240618154952.12314-1-ilias.apalodimas@linaro.org>
 <86iky6i4b9.fsf@udb0321960.dhcp.ti.com>
 <CAC_iWjJVSJCokmQsDVJphAVWX=vfwrDGmj=cqyiGHCvkPPbcug@mail.gmail.com>
Date: Tue, 18 Jun 2024 13:16:40 -0500
Message-ID: <86frtai0af.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 18 Jun 2024 20:58:28 +0200
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

> Hi Jon,
>
> On Tue, 18 Jun 2024 at 19:49, Jon Humphreys <jhumphreysti@gmail.com> wrote:
>>
>> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>>
>> > EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
>> > at runtime is not supported and allow the platform to perform capsule
>> > updates on disk. With the recent changes boards can conditionally enable
>> > setvariable at runtime using EFI_RT_VOLATILE_STORE.
>> >
>> > So let's make the options depend on each other and clarify their
>> > functionality. When EFI_RT_VOLATILE_STORE, setvariable at runtime is
>> > supported and EFI_IGNORE_OSINDICATIONS, which also breaks the EFI spec, is
>> > not needed anymore.
>>
>> Hi Ilias,
>>
>> Is there a corresponding effort to update fwupdmgr to set OSIndications
>> (and set it correctly so the change persists a reboot)?
>>
>
> We are not trying to fix anything atm, we probably will in the future.
>
>> Otherwise, fwupdmgr provided capsules will now get ignored for boards that
>> enable setvariable at runtime.
>
> That goes beyond fwupd, EFI variable changes will be ignored in
> general unless you sync the file manually -- e.g. dd
> if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c
> of=/boot/efi/ubootefi.var skip=4 bs=1
> after every variable change. Unless you do that, enabling
> EFI_RT_VOLATILE_STORE makes little sense (and that's why it's not
> enabled by default).
> So, I prefer making EFI_IGNORE_OSINDICATIONS, which was a hack,
> mutually exclusive and start going in the right direction.
>

I agree with the principle.  My concern is that we want to encourage people
to move to setvariable at runtime, but until LVFS is updated, people who
care about LVFS will be deincentivized.

Jon

> Regards
> /Ilias
>>
>> Jon
>>
>> >
>> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > ---
>> >  lib/efi_loader/Kconfig | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> > index 430bb7f0f7dc..c84064de1366 100644
>> > --- a/lib/efi_loader/Kconfig
>> > +++ b/lib/efi_loader/Kconfig
>> > @@ -220,6 +220,8 @@ config EFI_CAPSULE_ON_DISK
>> >  config EFI_IGNORE_OSINDICATIONS
>> >       bool "Ignore OsIndications for CapsuleUpdate on-disk"
>> >       depends on EFI_CAPSULE_ON_DISK
>> > +     depends on !EFI_RT_VOLATILE_STORE
>> > +     default y
>> >       help
>> >         There are boards where U-Boot does not support SetVariable at runtime.
>> >         Select this option if you want to use the capsule-on-disk feature
>> > --
>> > 2.45.2
