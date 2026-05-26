Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B33CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 15:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F131F84671;
	Tue, 26 May 2026 17:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Em6+EAMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68BAE848BB; Tue, 26 May 2026 16:26:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BDCE28341A
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A425A169C;
 Tue, 26 May 2026 07:25:57 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.31.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 267F93F7B4;
 Tue, 26 May 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779805562; bh=AkYpbV6E8On/7vDzYZoJ/9p/QdvPsQUgcY+QOXwCC8c=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=Em6+EAMsG5/TgC2P8gxne0g27lcMujmV+XbgUKzPjCdWT613+ATLBThZI6QwZkmQ1
 bzsVg+1tel7yvnb+zsz6VMZI+QD1Hkcr/EAvOJcj7ZqI0vrfyXjLUIxRKFEB0z1zuo
 XQ8K0t/+vZTSMwNB7S6LrmFo5U1dA1g0z78gsfng=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 04/11] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com
In-Reply-To: <CAFLszTjgLKxRxxBSTXS7xWqWmzrF9zCiJRGKXAQcvEKvu1hcfw@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-5-harsimransingh.tungal@arm.com>
 <CAFLszTjgLKxRxxBSTXS7xWqWmzrF9zCiJRGKXAQcvEKvu1hcfw@mail.gmail.com>
Date: Tue, 26 May 2026 15:25:55 +0100
Message-Id: <177980555527.3468345.11573032224583442684.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 26 May 2026 17:05:53 +0200
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

On 2026-05-15 12:26 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-05-14T12:49:13, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A transport
> >
> > Route EFI runtime variable APIs through FF-A MM communication
> >
> > Route EFI runtime variable services through the FF-A/MM backend in
> > lib/efi_loader/efi_variable_tee.c. After ExitBootServices(),
> > GetVariable(), SetVariable(), GetNextVariableName(), and
> > QueryVariableInfo() use the runtime entry points and continue to reach
> > the MM secure partition.
> >
> > Keep the existing boot-time helpers unchanged and add runtime service
> > wrappers for variable access and property handling. Reuse the
> > runtime-safe setup_mm_hdr() and common mm_communicate() path, which
> > selects the FF-A transport appropriate for the current phase, and use
> > the EFI runtime-safe memory helpers in the runtime-only code.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > lib/efi_loader/efi_variable_tee.c | 320 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 315 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -830,6 +905,95 @@ out:
> > +efi_status_t __efi_runtime efi_get_variable_runtime(u16 *variable_name,
> > +                                                 const efi_guid_t *vendor,
> > +                                                 u32 *attributes,
> > +                                                 efi_uintn_t *data_size,
> > +                                                 void *data)
> 
> EFIAPI is missing so this will break on x86_64 where there is a
> different ABI. Same for efi_get_next_variable_name_runtime() below -
> please match efi_set_variable_runtime() /
> efi_query_variable_info_runtime() which already carry EFIAPI.
> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -743,6 +775,49 @@ out:
> > +     ret = mm_communicate(comm_buf, payload_size);
> > +     /*
> > +      * Currently only R/O property is supported in StMM.
> > +      * Variables that are not set to R/O will not set the property in StMM
> > +      * and the call will return EFI_NOT_FOUND. We are setting the
> > +      * properties to 0x0 so checking against that is enough for the
> > +      * EFI_NOT_FOUND case.
> > +      */
> > +     if (ret == EFI_NOT_FOUND)
> > +             ret = EFI_SUCCESS;
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +     efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));
> 
> When EFI_NOT_FOUND is mapped to EFI_SUCCESS we still fall through and
> memcpy smm_property->property over the zeroed var_property - at
> runtime smm_property aliases the FF-A shared buffer, so whatever the
> SP left in those bytes ends up in var_property and undoes the memset
> above. Either move the memcpy under an explicit found branch, or skip
> it on the NOT_FOUND-mapped-to-SUCCESS path. The boot-time copy doesn't
> matter because the SP fills the response into the local buffer; here
> the shared buffer is the response.
> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -1067,7 +1319,65 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> > +     if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)) {
> > +             var_property.revision = VAR_CHECK_VARIABLE_PROPERTY_REVISION;
> > +             var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
> > +             var_property.attributes = attributes;
> > +             var_property.minsize = 1;
> > +             var_property.maxsize = var_acc->data_size;
> > +             ret = set_property_int_runtime(variable_name, name_size, guid, &var_property);
> > +     }
> 
> Just to check - at runtime var_acc points into the FF-A shared buffer,
> and the preceding mm_communicate() has already let the SP write its
> response there, so var_acc->data_size is whatever the SP reported (and
> may be 0 on failure). Is that what we want as maxsize, or should this
> be the original data_size argument? Please confirm the SP guarantees
> data_size on the way out for SET_VARIABLE before relying on it.
> 
> Regards,
> Simon
>

Hi Simon,

Thanks for pointing this out.

It make sense to allow the boot-time and runtime TEE SetVariable() paths to use the
original data_size argument for var_property.maxsize, instead of relying
on var_acc->data_size after the MM exchange.
I will update this in v3.

Regards,
Harsimran Singh Tungal


