Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A29CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C618753E;
	Wed, 20 Dec 2023 05:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WN68kkdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D808753E; Wed, 20 Dec 2023 05:46:19 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA986870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2370535060so64890166b.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047576; x=1703652376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ObOjGHxxzANzBA20+fRUpz/qy8ssxRN2M1oEwSnchMg=;
 b=WN68kkdRWGGhdv3BINAztTdBiSyv4celyGG0CykFBnqEjtW/sYa9YYzEedzO/lNpYQ
 CucZ50YbdhxaHayKSPIRz8hXioNRx4NbdgC9g6CYhek6PdP72f8GzLNW0Oe47XjVwPU8
 TLqszz+SDUI10rMsErDm8xPYFtmqC0JKvAbdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047576; x=1703652376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ObOjGHxxzANzBA20+fRUpz/qy8ssxRN2M1oEwSnchMg=;
 b=H73IBe2eFPWwMyC/UG1a6t7vvCEm2KmHqm00ngLXd+L4eCl+oWZ95+NSPn7ai26xaK
 W2fJiz6kdoT9En1m+NaJ/uT6ldeqWIoSXKoZ7QDOvG/5JI0Lj7fNuI4QMiIQ82L1VIdP
 dw+S3/DdrPgH4dkCnZsRXgN40TDYbyOaJC9yiXV5d5ZHStZelVQ9Fi03HzvYBM6YpwQQ
 ElVpr/WZtMEACnP8OX3y2sWHKySmEf3cera7BWoXufEpXY+iNWONmBi8BEXM3OqhMa8r
 M5vBOdQDul8FJ9Y7RQ+rfsj27Up+Ez5Y3o9akjqb5akvBjUL8pHw7saTiIrz96tD2AK5
 e5rA==
X-Gm-Message-State: AOJu0YwSYAToQsVkSjhlwQQ3m9HnC5Apsz5dtn9Q/KDWpgI0+bacjaK7
 e8sJtLupSsnPlRHCAO3Zqr4DfufG5Gf600AJ3oAptCemIQvy
X-Google-Smtp-Source: AGHT+IFiAtnYS6LXvMS3hEaXi1ylgrBmLLhNN+uioKFv9mVb/Ycop0Bj8klqTrKKv5ovgt1osw7sDYHdsp6TNkdiWcg=
X-Received: by 2002:a17:906:c15:b0:a26:8f35:20e3 with SMTP id
 s21-20020a1709060c1500b00a268f3520e3mr484981ejf.4.1703047576066; Tue, 19 Dec
 2023 20:46:16 -0800 (PST)
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
 <CAPnjgZ0ngqCyC36QVAFWu07p+7SHNQhsuo0MYstTawnbDEEmLw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0ngqCyC36QVAFWu07p+7SHNQhsuo0MYstTawnbDEEmLw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:04 -0700
Message-ID: <CAPnjgZ1EDx=NtC9aPSVYUwoLRzA3M0rXnDeWxxsEnSUVs8N4FQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: "Chiu, Chasel" <chasel.chiu@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
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

Hi,

On Mon, 11 Dec 2023 at 10:52, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Tue, 28 Nov 2023 at 13:31, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> >
> >
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Tuesday, November 28, 2023 10:08 AM
> > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark Rutland
> > > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Sheng
> > > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhaval
> > > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com>;
> > > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron minnich
> > > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > usages
> > >
> > > You are referring to a 2000 line patch so it is not 100% clear where to look tbh.
> > >
> > >
> > > On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> > > >
> > > >
> > > > In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, line 268 is for
> > > related example code.
> > > >
> > >
> > > That refers to a 'memory-allocation' node, right? How does that relate to the
> > > 'reserved-memory' node?
> > >
> > > And crucially, how does this clarify in which way "runtime-code" and "runtime-
> > > data" reservations are being used?
> > >
> > > Since the very beginning of this discussion, I have been asking repeatedly for
> > > examples that describe the wider context in which these reservations are used.
> > > The "runtime" into runtime-code and runtime-data means that these regions have
> > > a special significance to the operating system, not just to the next bootloader
> > > stage. So I want to understand exactly why it is necessary to describe these
> > > regions in a way where the operating system might be expected to interpret this
> > > information and act upon it.
> > >
> >
> >
> > I think runtime code and data today are mainly for supporting UEFI runtime services - some BIOS functions for OS to utilize, OS may follow below ACPI spec to treat them as reserved range:
> > https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html#uefi-memory-types-and-mapping-to-acpi-address-range-types
> >
> > Like I mentioned earlier, that PR is still in early phase and has not reflected all the required changes yet, but the idea is to build gEfiMemoryTypeInformationGuid HOB from FDT reserved-memory nodes.
> > UEFI generic Payload has DxeMain integrated, however Memory Types are platform-specific, for example, some platforms may need bigger runtime memory for their implementation, that's why we want such FDT reserved-memory node to tell DxeMain.
> >
> > The Payload flow will be like this:
> >   Payload creates built-in default MemoryTypes table ->
> >     FDT reserved-memory node to override if required (this also ensures the same memory map cross boots so ACPI S4 works) ->
> >       Build gEfiMemoryTypeInformationGuid HOB by "platfom specific" MemoryTypes Table ->
> >         DxeMain/GCD to consume this MemoryTypes table and setup memory service ->
> >           Install memory types table to UEFI system table.Configuration table...
> >
> > Note: if Payload built-in default MemoryTypes table works fine for the platform, then FDT reserved-memory node does not need to provide such 'usage' compatible strings. (optional)
> > This FDT node could allow flexibility/compatibility without rebuilding Payload binary.
> >
> > Not sure if I answered all your questions, please highlight which area you need more information.
>
> Any more thoughts on this? If not, I would like to see this patch
> applied, please.

I am really not sure who or what is holding this up, so far.

Can we perhaps get this applied in time for Christmas? It would be a
nice end to the year.

Regards,
Simon
