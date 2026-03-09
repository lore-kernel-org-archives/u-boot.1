Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC57FF4181C
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 17:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9743A83F75;
	Mon,  9 Mar 2026 18:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0421E83F82; Mon,  9 Mar 2026 18:34:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6A77683F20
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 18:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EACE61477;
 Mon,  9 Mar 2026 10:34:23 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86ABC3F694;
 Mon,  9 Mar 2026 10:34:29 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:34:26 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/4] efi_loader: export efi_ecpt_guid
Message-ID: <aa8Eoj5zDKs7P6W6@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-2-vincent.stehle@arm.com>
 <bc95625a-54cf-479b-ac6e-acb316bc867b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc95625a-54cf-479b-ac6e-acb316bc867b@gmx.de>
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

On Mon, Mar 09, 2026 at 05:40:12PM +0100, Heinrich Schuchardt wrote:

Hi Heinrich,

Thanks for the review; my comments below.

Best regards,
Vincent.

> On 3/9/26 17:36, Vincent Stehlé wrote:
> > Export the ECPT GUID, to prepare accessing it from more than one location.
> > 
> > The C file containing the GUID is compiled only when CONFIG_EFI_ECPT is
> > set; gate the export accordingly.
> > 
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > 
> > (No change in v2; re-sending in the series for consistency only.)
> > 
> >   include/efi_loader.h             | 4 ++++
> >   lib/efi_loader/efi_conformance.c | 2 +-
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 3e70ac07055..0ebc80e0af0 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -387,6 +387,10 @@ extern const efi_guid_t efi_guid_capsule_report;
> >   extern const efi_guid_t efi_guid_firmware_management_protocol;
> >   /* GUID for the ESRT */
> >   extern const efi_guid_t efi_esrt_guid;
> > +/* GUID for the ECPT */
> > +#if CONFIG_IS_ENABLED(EFI_ECPT)
> 
> This #if looks superfluous. The include should compile without it.

This should compile indeed, but it will not always link as the efi_ecpt_guid
symbol is defined in lib/efi_loader/efi_conformance.c, which is compiled only
when CONFIG_EFI_ECPT is set.

I think gating the declaration serves two purposes here:

1. It should make the build fail at the point where the symbol is used, which
   should be -arguably- easier to debug than having it fail at link-time.
2. It kind of documents the fact that the symbol is available only when
   CONFIG_EFI_ECPT is set. This should avoid having to find the symbol in
   efi_conformance.c and having to look into the corresponding Makefile to have
   this information.

Besides, other symbols are already declared conditionally in efi_loader.h.

Anyway, if you insist I could send a v3 without the #if; just let me know.

> 
> Best regards
> 
> Heinrich
> 
> > +extern const efi_guid_t efi_ecpt_guid;
> > +#endif
> >   /* GUID of the SMBIOS table */
> >   extern const efi_guid_t smbios_guid;
> >   extern const efi_guid_t smbios3_guid;
> > diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> > index 2d31800ccb8..470141af483 100644
> > --- a/lib/efi_loader/efi_conformance.c
> > +++ b/lib/efi_loader/efi_conformance.c
> > @@ -12,7 +12,7 @@
> >   #include <efi_api.h>
> >   #include <malloc.h>
> > -static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
> > +const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
> >   /**
> >    * efi_ecpt_register() - Install the ECPT system table.
> 
