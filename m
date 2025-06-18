Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAF8C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 12:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657CE82BCD;
	Wed, 18 Jun 2025 14:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gbHywBxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FC182C84; Wed, 18 Jun 2025 14:05:24 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B85082B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 14:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e812c817de0so5987517276.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750248318; x=1750853118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XGH4veHQRvIsaImhLuPSMnWOiltbUZ8yS62n/YEVh+g=;
 b=gbHywBxVLdCOuJhTGf3m518NWdbwcrCH5PLXSvVKVYdHQ8pZQaC2IjBIpypWaejnqK
 K09IpRXS+QU6L/ImIKaV1B4ymcFYIf0dy1NQGYBwDijxt4vqUhU+QySBVGCAmtLO324S
 EyEzokWgYIGN5l/ojQcGnYloqul/QqL9G0eI5KiE2ewtOmBKhevM30gILfvsQsbSQiI2
 +d5CAIjZdmav0M2rOo42V/erpOehEQTQQn1TuraDhE7RT5Jlx3aIQYyGzt3yBRRmSd3C
 5hD6WNcm0YtUJpIoDW66BCHze8Tm+4oZaUrUS5XDT5YPxzwexU0di/6XkG2t+UYVj+3+
 PwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750248318; x=1750853118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGH4veHQRvIsaImhLuPSMnWOiltbUZ8yS62n/YEVh+g=;
 b=fRAJTHi2HI3+kfl6pE+I+ITh1uRVjggwV4BAEw8AoUdlRHjLaWSJADD2UYgzqXyDVD
 pKWyXZJMTyTxJte3vXJpqEutpFGmv4V03w1hQUeSLAuqfiMKZfNHYMjkTF+aGTY9k/4O
 aNKvNLQh3CO257CQazCgIBi/2WLUHAQAuJfFAZHu3YyGzHo40o6uT+NIk6l8IWZveaa1
 UhyWBP1bgRSfQa1A1/Fhxp/umU12/FuBFlBSP7PxMw2fFGP5TrQsBZpUBzwlUN4zX2NI
 RZ1LiIy7XyVZ72PfmFxyr6uovIfWuNed3FnG6wSJidqOcZtm9Tkv2icpbJ+P01A750Go
 gf3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWgOjfy4umIfHOqfybUd8LLBkgra6/Jxz+S//TJzumRcCFuLvNaePpM/k7AjwQq0fs7j4YXvE=@lists.denx.de
X-Gm-Message-State: AOJu0YwL6v+ingBP9JG2fPc/PUKT2C1xkp5iKZIrqpKrakxx9zcpk7yO
 d1zUv+zBQ5gMmsRCRlyRvf6OzfvJmPSPoQOG3tllMDObkWI1blvlfZuSqzkbK26cGJ91PCNUwLR
 gS+nqDBeSn7FGI8jKEDe9kbh2E9VCrxmhEwQ3fRe9wQ==
X-Gm-Gg: ASbGncsEr37vbWxSd4GYDPDzj85vw8OcWXxD87dAzVBqflnk1kLRo+DsN35MFjZfguu
 cez2FCCw89YsgKnuRzqFybo+8MHUNnGqXiaS8JxdMVZ5vSrEVmwx02VnMBt9Z7ymY0ILk5Q+gzh
 rZ6m14dGwGLD+es5BYoEiugsJJhffolfFsicPtu0jI56oA
X-Google-Smtp-Source: AGHT+IHPmbcaj3RS+NoBIztQBOC9BoT6Ihaln4xB+H4DCta+tYXlU/vLa5lCCnE2bZ82Dwged/ygcggI1eu5aHlhi3k=
X-Received: by 2002:a05:690c:f83:b0:70d:f47a:7e40 with SMTP id
 00721157ae682-71175394eacmr260708127b3.16.1750248318054; Wed, 18 Jun 2025
 05:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
 <c61e6238-82ce-4b51-9314-231f613a1430@linaro.org>
In-Reply-To: <c61e6238-82ce-4b51-9314-231f613a1430@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Jun 2025 15:04:42 +0300
X-Gm-Features: AX0GCFsTbff1wEmH3G0AS5gjqq3GMe3ptOcEcGxKxAoTZ15u1gFPKTnxCb5ap4o
Message-ID: <CAC_iWjJ4VX5MF+GQyKVs9Tq0wFJ_0Zs3o48oN9Nuu9AX=9ALig@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix io accessors for KVM
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: trini@konsulko.com, mikko.rapeli@linaro.org, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Liya Huang <1425075683@qq.com>, Boyan Karatotev <boyan.karatotev@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Jerome,

On Wed, 18 Jun 2025 at 14:03, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 6/18/25 08:58, Ilias Apalodimas wrote:
> > Instructions that lead ito an exception in the hypervisor can't modify two
> > CPU registers at once for the ARM ISA.
> >
> > These instructions cannot be emulated by KVM as they do not produce
> > syndrome information data that KVM can use to infer the destination
> > register, the faulting address, whether it was a load or store, or
> > if it's a 32 or 64 bit general-purpose register.
> > As a result an external abort is injected from QEMU, via ext_dabt_pending.
> >
> > Patch #1 prepares some function for the modified macros
> > Patch #2 modifies the macros
> > Patch #3 enables the functionality for armv7/8 QEMU
>
> Again, IMHO this is more complex than necessary because you're combining
> the KVM fix with some code refactoring. Patch #1 can be dropped altogether
> and patch #2 can be simplified (from "2 files changed, 123 insertions(+),
> 39 deletions(-)" to "2 files changed, 97 insertions(+)". Unless I missed
> something? Please see [1]. Of course it also passes the LVM test ;)

No you aren't. I just kept it as is because Tom said he was fine and
makes the final code easier to read, rather than having 2 macros doing
the same thing.

Thanks
/Ilias
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/26751.
>
> --
> Jerome
>
> >
> > Changes since v1:
> > - Split the function modification in its own patch
> > - Don't limit the changes to v8 only
> >
> > Ilias Apalodimas (3):
> >   nxp: Prepare macros for KVM changes
> >   arm: io.h: Fix io accessors for KVM
> >   qemu: arm: Enable virtualizable IO accesors
> >
> >  arch/arm/Kconfig             |  12 +++
> >  arch/arm/include/asm/io.h    | 152 ++++++++++++++++++++++++++---------
> >  configs/qemu_arm64_defconfig |   1 +
> >  configs/qemu_arm_defconfig   |   1 +
> >  drivers/spi/fsl_dspi.c       |   6 +-
> >  include/fsl_ifc.h            |  24 +++---
> >  6 files changed, 142 insertions(+), 54 deletions(-)
> >
> > --
> > 2.43.0
> >
