Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E2C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 15:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B75876C9;
	Wed,  3 Jan 2024 16:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HTCVvdqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D9D876DD; Wed,  3 Jan 2024 16:22:31 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9EC876A6
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 16:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B3884B811A0
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 15:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62368C43397
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704295347;
 bh=PSULNPafTiN5YA/zznHKljEYILe0lgiiOYnPvIBLCtU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HTCVvdqZyxiXxnTanJVRMJKPFRpS9n90G2HKitP4aY/wBhmMUdJ53AsIa/Gyl/4Jz
 pLkz9apw4Rim6otI0sGhlUTS2iqiCWEa3hp739v+hUiMUAxOtvb33hj666Vi5bZvuJ
 fvzcGHlQMBAt1WqUkYrIWo8lfzxiLZ+8u19gY1e1W5JsS1XnH0xTngSdeOTujLwcKz
 VpAZNDzQG9AYcV+R6bZfBgwTehETca+wsNrozRuYNycZOxUS8ftq55ZRjIPN+t6yL+
 uuvihs48iNhQJaz1R9ps25naygJYNwSJTmPHLEZ05ePe1M3Kwgn1TzVDNt8unNxKHl
 Rh7pRU/LdxtMQ==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-50e7dd8bce8so7814462e87.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 07:22:27 -0800 (PST)
X-Gm-Message-State: AOJu0YyYeCBwlXHp+8pFu3yPgnlOSLz7yeDXeRQH+8j0VgkPxKYyyP0P
 DWcMm0Xg1qn9pOANOpsa3wEaadlV9IW11puXKIQ=
X-Google-Smtp-Source: AGHT+IGFcFYO2J618BYFfSaaCdih8PzDV/WsOJ6Eg0j1h8wQdMvLsG1eT5V9WrmOXvxhn44h3RXmYuOstjkzgkiucVI=
X-Received: by 2002:a05:6512:12cd:b0:50e:a08d:172 with SMTP id
 p13-20020a05651212cd00b0050ea08d0172mr1429415lfg.85.1704295345418; Wed, 03
 Jan 2024 07:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
 <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com>
 <BN9PR11MB5483C2FBCD07DE61DCCDB523E6BCA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
 <BN9PR11MB54837EEB391CC2A8FA6C0BF5E695A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com>
 <BN9PR11MB5483E191F1906641565A1337E694A@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483E191F1906641565A1337E694A@BN9PR11MB5483.namprd11.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Jan 2024 16:22:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGcZP99hyURXFAZfwKmYqj-xBN9BcW7R3h9Mm2k937Buw@mail.gmail.com>
Message-ID: <CAMj1kXGcZP99hyURXFAZfwKmYqj-xBN9BcW7R3h9Mm2k937Buw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: "Chiu, Chasel" <chasel.chiu@intel.com>
Cc: Simon Glass <sjg@chromium.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, 
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
 "Brune, Maximilian" <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
 ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 22 Dec 2023 at 20:52, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
> Please see my reply below inline.
>
> Thanks,
> Chasel
>
...
> > > > The gEfiMemoryTypeInformationGuid HOB typically carries platform
> > > > defaults, and the actual memory type information is kept in a
> > > > non-volatile EFI variable, which gets updated when the memory usage
> > > > changes. Is this different for UefiPayloadPkg?
> > > >
> > > > (For those among the cc'ees less versed in EFI/EDK2: when you get
> > > > the 'config changed -rebooting' message from the boot firmware, it
> > > > typically means that this memory type table has changed, and a
> > > > reboot is necessary.)
> > > >
> > > > So the platform init needs to read this variable, or get the
> > > > information in a different way. I assume it is the payload, not the
> > > > platform init that updates the variable when necessary. This means
> > > > the information flows from payload(n) to platform init(n+1), where =
n
> > > > is a monotonic index tracking consecutive boots of the system.
> > > >
> > > > Can you explain how the DT fits into this? How are the runtime-code
> > > > and runtime-data memory reservation nodes under /reserved-memory
> > > > used to implement this information exchange between platform init
> > > > and payload? And how do the HOB and the EFI variable fit into this =
picture?
> > >
> > >
> > > 1. With some offline discussion, we would move
> > > gEfiMemoryTypeInformationGuid usage to FDT->upl-custom node. This is
> > > because it is edk2 implementation choice and non-edk2 PlatformInit or
> > > Payload may not have such memory optimization implementation. (not a
> > > generic usage/requirement for PlatformInit and Payload)
> > >
> > > The edk2 example flow will be like below:
> > >
> > > PlatformInit to GetVariable of gEfiMemoryTypeInformationGuid and crea=
te Hob-
> > >
> > >   PlatformInit to initialize FDT->upl-custom node to report
> > gEfiMemoryTypeInformationGuid HOB information ->
> > >     UefiPayload entry to re-create gEfiMemoryTypeInformationGuid HOB =
basing
> > on FDT input (instead of the default MemoryType inside UefiPayload) ->
> > >       UefiPayload DxeMain/Gcd will consume gEfiMemoryTypeInformationG=
uid
> > Hob for memory type information ->
> > >         UefiPayload to initialize UEFI environment (mainly DXE dispat=
cher) ->
> > >           (additional FV binary appended to common UefiPayload binary=
)
> > PlatformPayload to provide VariableService which is platform specific -=
>
> > >             UefiPayload UefiBootManager will SetVariable if memory ty=
pe change
> > needed and request a warm reset ->
> > >               Back to PlatformInit ...
> > >
> >
> > OK so the upl-custom node can do whatever it needs to. I imagine these =
will
> > include the memory descriptor attribute field, and other parts that may=
 be missing
> > from the /reserved-memory DT node specification?
>
>
> Yes, if needed by edk2 specific implementation, not generic enough, we ma=
y consider to use upl-custom node to pass those data.
>
>
> >
> > >
> > > 2. Now the proposed reserved-memory node usages will be for PlatformI=
nit to
> > provide data which may be used by Payload or OS. This is not edk2 speci=
fic and
> > any PlatformInit/Payload could have same support.
> > > Note: all of below are optional and PlatformInit may choose to implem=
ent some
> > of them or not.
> > >
> > >       - acpi
> > > If PlatformInit created some ACPI tables, this will report a memory r=
egion which
> > contains all the tables to Payload and Payload may base on this to add =
some more
> > tables if required.
> > >
> > >       - acpi-nvs
> > > If PlatformInit has created some ACPI tables which having ACPI NVS me=
mory
> > dependency, this will be that nvs region.
> > >
> >
> > These make sense.
> >
> > >       - boot-code
> > > When PlatformInit having some FW boot phase code that could be freed
> > > for OS to use when payload transferring control to UEFI OS
> > >
> > >       - boot-data
> > > When PlatformInit having some FW boot phase data that could be freed =
for OS
> > to use when payload transferring control to UEFI OS.
> > >
> > >       - runtime-code
> > > PlatformInit may provide some services code that can be used for Payl=
oad to
> > initialize UEFI Runtime Services for supporting UEFI OS.
> > >
> > >       - runtime-data
> > > PlatformInit may provide some services data that can be used for Payl=
oad to
> > Initialize UEFI Runtime Services for supporting UEFI OS.
> > >
> >
> > A UEFI OS must consume this information from the UEFI memory map, not f=
rom
> > the /reserved-memory nodes. So these nodes must either not be visible t=
o the OS
> > at all, or carry an annotation that the OS must ignore them.
> >
> > Would it be possible to include a restriction in the DT schema that the=
se are only
> > valid in the firmware boot phase?
>
>
> https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#efi-boot-=
services-exitbootservices
> Per UEFI specification, UEFI OS will always call UEFI GetMemoryMap functi=
on to retrieve memory map, so FDT node present or not does not matter to UE=
FI OS. We probably could have annotation in UPL specification to emphasize =
this.
> I'm not familiar with Linux FDT boot, but if non-UEFI OS does not call UE=
FI GetMemoryMap() and does not know what is runtime-code/data, boot-code/da=
ta, it might just treat such reserved-memory nodes as 'regular' reserved me=
mory nodes, and that's still ok because non-UEFI OS will not call to any ru=
ntime service or re-purpose boot-code/data memory regions.
>

You are saying the same thing but in a different way. A UEFI OS must
only rely on GetMemoryMap(), and not on the /reserved-memory node to
obtain this information. But this requirement needs to be stated
somewhere: the UEFI spec does not reason about other sources of EFI
memory information at all, and this DT schema does not mention any of
this either.

> Would you provide a real OS case which will be impacted by this reserved-=
memory schema so we can discuss basing on real case?
>

Funny, that is what I have been trying to get from you :-)

The problem I am anticipating here is that the information in
/reserved-memory may be out of sync with the EFI memory map. It needs
to be made clear that the EFI memory map is the only source of truth
when the OS is involved, and this /reserved-memory mechanism should
only be used by other firmware stages. But the schema does not mention
this at all. The schema also does not mention that the information in
/reserved-memory is not actually sufficient to reconstruct the EFI
memory map that the firmware payload expects (which is why the
upl-custom-node exists too)
