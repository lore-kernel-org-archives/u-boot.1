Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70509CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E50B848A1;
	Wed,  6 May 2026 14:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dTiYtPw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519918488B; Wed,  6 May 2026 12:30:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AA11D84882
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 12:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8931D331A;
 Wed,  6 May 2026 03:30:11 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.35.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731683F836;
 Wed,  6 May 2026 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778063416; bh=TsprfV9LAyEQrgTSxDX/OiKBfNvJ2hYcgIHWMT3Os18=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=dTiYtPw7QacbQOzUpXdJ5LI0aMFvJ3nqO7kS/pU5PKfOL3IUMK1b4ZZoxnfS5FK5v
 eqPvmgUl4MveAwqtIA4pphkzakKez28ANLsncq4b0dtcN2sxXJQyYkNmWBsDoXH7+o
 HpdWroPcIgvsV8/iFhidYsLVzEEIXJN7vJ/4ivVw=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/12] efi_loader: move runtime GetVariable() helpers
 to efi_variable.c
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjLeroR7T1dgrULkOjx93-=enGHuwuY7Wn9i-t0oBn+mJg@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-6-harsimransingh.tungal@arm.com>
 <CAC_iWjLeroR7T1dgrULkOjx93-=enGHuwuY7Wn9i-t0oBn+mJg@mail.gmail.com>
Date: Wed, 06 May 2026 11:30:10 +0100
Message-Id: <177806341010.876188.14183050768550732016.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

On 2026-04-28 15:03 +0300, Ilias Apalodimas wrote:
> Hi Harsiman,
> 
> On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Consolidate runtime GetVariable helpers to avoid duplicates
> >
> > The functions efi_get_variable_runtime() and
> > efi_get_next_variable_name_runtime() were implemented in
> > efi_variable_tee.c as part of the FF-A runtime variable handling work.
> > However, default implementations for these same runtime helpers also
> > exist in efi_var_common.c.
> 
> efi_variable.c is there to deal with variables stored in the
> non-secure world and efi_variable_tee.c for the variables stored on
> the non secure world.
> You can't compile both. By moving efi_get_next_variable_name_runtime
> out of common you will break efi_variable_tee.c for example.
> 
> The reason these are in common is that U-Boot exposes the memory
> backend to the kernel for get/setvariable. Then the kernel at runtime
> decides to ignore the u-boot runtime functions and rewires them to
> internal op-tee functions. If you want a variable variant for FF-A
> that belongs into efi_variable_tee.c
> 
> Thanks
> /Ilias
> 
>

Thanks, that is the intent here as well.

This patch is not trying to move the FF-A-specific runtime path out of
efi_variable_tee.c. The TEE/FF-A runtime variants stay in
efi_variable_tee.c.

What this patch does is relocate the generic runtime read helpers out of
efi_var_common.c, which is always built, into efi_variable.c, which is
only built for the non-TEE backend. That way the non-TEE backend keeps
the generic memory-backed runtime implementations, while the TEE/FF-A
backend can provide its own runtime read helpers in efi_variable_tee.c
without a symbol clash.

I'll reword the commit message in v2 to make that clearer.

Regards
Harsimran Singh Tungal

> > This results in duplicate symbol definitions.
> > To resolve the conflict and centralize the runtime API, this patch moves
> > the default implementations of the two runtime GetVariable() helpers
> > from efi_var_common.c to efi_variable.c. This ensures that:
> >
> >  - only a single definition of each runtime helper exists,
> >  - backend-specific implementations can override these cleanly,
> >  - the EFI runtime variable service table continues to reference the
> >    correct functions.
> >
> > No functional changes are introduced; this is a structural cleanup to
> > avoid build-time conflicts and consolidate EFI runtime variable support
> > in the appropriate file.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > ---
> >  lib/efi_loader/efi_var_common.c | 24 ------------------------
> >  lib/efi_loader/efi_variable.c   | 24 ++++++++++++++++++++++++
> >  2 files changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> > index d63c2d1b1cd..7cbf098c64a 100644
> > --- a/lib/efi_loader/efi_var_common.c
> > +++ b/lib/efi_loader/efi_var_common.c
> > @@ -173,30 +173,6 @@ efi_status_t EFIAPI efi_query_variable_info(
> >         return EFI_EXIT(ret);
> >  }
> >
> > -efi_status_t __efi_runtime EFIAPI
> > -efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> > -                        u32 *attributes, efi_uintn_t *data_size, void *data)
> > -{
> > -       efi_status_t ret;
> > -
> > -       ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
> > -                                  data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
> > -
> > -       /* Remove EFI_VARIABLE_READ_ONLY flag */
> > -       if (attributes)
> > -               *attributes &= EFI_VARIABLE_MASK;
> > -
> > -       return ret;
> > -}
> > -
> > -efi_status_t __efi_runtime EFIAPI
> > -efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> > -                                  u16 *variable_name, efi_guid_t *guid)
> > -{
> > -       return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> > -                                             guid, EFI_VARIABLE_RUNTIME_ACCESS);
> > -}
> > -
> >  /**
> >   * efi_set_secure_state - modify secure boot state variables
> >   * @secure_boot:       value of SecureBoot
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index 9923936c1b5..f2e0e1ad4e2 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -579,6 +579,30 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
> >         return EFI_SUCCESS;
> >  }
> >
> > +efi_status_t __efi_runtime EFIAPI
> > +efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> > +                        u32 *attributes, efi_uintn_t *data_size, void *data)
> > +{
> > +       efi_status_t ret;
> > +
> > +       ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
> > +                                  data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
> > +
> > +       /* Remove EFI_VARIABLE_READ_ONLY flag */
> > +       if (attributes)
> > +               *attributes &= EFI_VARIABLE_MASK;
> > +
> > +       return ret;
> > +}
> > +
> > +efi_status_t __efi_runtime EFIAPI
> > +efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> > +                                  u16 *variable_name, efi_guid_t *guid)
> > +{
> > +       return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> > +                                             guid, EFI_VARIABLE_RUNTIME_ACCESS);
> > +}
> > +
> >  /**
> >   * efi_variables_boot_exit_notify() - notify ExitBootServices() is called
> >   */
> > --
> > 2.34.1
> >
> 


