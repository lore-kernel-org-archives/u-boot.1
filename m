Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13499CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 13:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E57849CE;
	Wed, 24 Jun 2026 15:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MRNlYLjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD47848DC; Wed, 24 Jun 2026 14:15:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4C00D84671
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 14:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C324E1713;
 Wed, 24 Jun 2026 05:15:23 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.29.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E91B73F62B;
 Wed, 24 Jun 2026 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782303328; bh=olbUXZqQiYHGCABeqDpbcyXm5K4WduGY0NCqwFnle6E=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=MRNlYLjIb4B5SJfG4jS64RcA/I2HSP+PDO5d57lW5FeFmXFeDn5qx6FzoYnvMZ4AR
 XR+mRsYtWiVUZYsX+Bdf7oK2diIsFKw5BC3dG6JEiZpv4M2NgPfcffZmj/W8tgC12A
 yzVeuzMoybfJyAP37LeLxqN/eWYE/BquzmHI1AM0=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/11] efi_loader: move runtime variable read
 helpers to efi_variable.c
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 xypron.glpk@gmx.de, hugues.kambampiana@arm.com, sjg@chromium.org
In-Reply-To: <CAC_iWjLBc2sCTeO-voXRaJu34vft+cq4s2qbF=cpqNvNYxZc_w@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
 <CAC_iWjLBc2sCTeO-voXRaJu34vft+cq4s2qbF=cpqNvNYxZc_w@mail.gmail.com>
Date: Wed, 24 Jun 2026 13:15:21 +0100
Message-Id: <178230332182.4122019.1939205928978533568.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 24 Jun 2026 15:15:53 +0200
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

On 2026-06-05 14:04 +0300, Ilias Apalodimas wrote:
> Hi Harsiman
> 
> On Thu, 14 May 2026 at 15:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Relocate the generic runtime variable read helpers from
> > efi_var_common.c to efi_variable.c.
> >
> > efi_var_common.c is always built, while efi_variable.c is only built
> > when CONFIG_EFI_MM_COMM_TEE is unset. Earlier patches in this series
> > add TEE/FF-A-specific runtime read helpers in efi_variable_tee.c.
> > Leaving the generic definitions in efi_var_common.c would therefore
> > cause a symbol clash in EFI_MM_COMM_TEE builds.
> >
> > Move efi_get_variable_runtime() and
> > efi_get_next_variable_name_runtime() into efi_variable.c so the
> > non-TEE backend keeps the generic memory-backed implementations,
> > while the TEE/FF-A backend continues to provide its own runtime read
> > helpers in efi_variable_tee.c.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > ---
> >
> > Changelog:
> > ===============
> >
> > v2:
> >
> > Ilias, Simon:
> >
> > - Reword commit message to include relocation of generic non-TEE
> >   helpers and broaden the wording to cover both runtime read helpers
> >
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
> 
> I think I mentioned this on the previous version as well.
> The reason that we represent variables in memory at runtime, is that
> it works for both secure and non secure world storage. In the secure
> world case, Linux scans that OP-TEE can support variables at runtime
> and swtiches get/setVariable to point in op-tee functions.
> Due to the above we were less strict wth the API, since evenryone just
> called the _mem variant for runtime calls and it saved us a function
> call.
> 
>  If we want to change this, the right fix would be to define _int
> variants in the efi_variable.c and efi_variable_tee.c and call them
> from efi_var_common.c. This basically boils down to calling the _int
> version in efi_get_variable_runtime and efi_get_next_variable_runtime
> on the common code.
> 
> Thanks
> /Ilias
> 
>
Hi Ilias,
Thanks, that makes sense.

Just to confirm the intended scope: should I apply this pattern only to
efi_get_variable_runtime() and efi_get_next_variable_name_runtime(), since
those are the helpers moved by this patch, or would you prefer the same
common-wrapper plus backend-specific _int pattern for all four runtime
variable service functions:

efi_get_variable_runtime()
efi_get_next_variable_name_runtime()
efi_set_variable_runtime()
efi_query_variable_info_runtime()

I will make relevant changes as per your feedback in v3.
Thanks

Regards
Harsimran Singh Tungal

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


