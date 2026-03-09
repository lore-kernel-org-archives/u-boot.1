Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC263F417EA
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A63883BC7;
	Mon,  9 Mar 2026 16:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D64483F14; Mon,  9 Mar 2026 16:02:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CB86683A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E02601570;
 Mon,  9 Mar 2026 08:02:04 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BE033F7BD;
 Mon,  9 Mar 2026 08:02:10 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:02:07 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/4] cmd: efidebug: add ecpt command
Message-ID: <aa7g7zd0L4SyDHt-@debian>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260305161349.2317130-4-vincent.stehle@arm.com>
 <a0d7e83b-1721-41c6-a416-cc88af49bb22@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0d7e83b-1721-41c6-a416-cc88af49bb22@gmx.de>
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

On Mon, Mar 09, 2026 at 01:23:53PM +0100, Heinrich Schuchardt wrote:

Hi Heinrich,

Thanks for your review, I will send a v2 adding your first suggestion; more
comments below.

Best regards,
Vincent.

> On 3/5/26 17:13, Vincent Stehlé wrote:
> > Add an "efidebug ecpt" command, to print the conformance profiles in the
> > ECPT:
> > 
> >    => efidebug ecpt
> >    cce33c35-74ac-4087-bce7-8b29b02eeb27  EFI EBBR 2.1 Conformance Profile
> > 
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >   cmd/efidebug.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 49 insertions(+)
> > 
> > diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> > index 109496d9e95..672214a54b7 100644
> > --- a/cmd/efidebug.c
> > +++ b/cmd/efidebug.c
> > @@ -533,6 +533,47 @@ static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
> >   	return CMD_RET_SUCCESS;
> >   }
> > +#if CONFIG_IS_ENABLED(EFI_ECPT)
> > +/**
> > + * do_efi_show_ecpt() - show UEFI conformance profiles in ECPT
> > + *
> > + * @cmdtp:	Command table
> > + * @flag:	Command flag
> > + * @argc:	Number of arguments
> > + * @argv:	Argument array
> > + * Return:	CMD_RET_SUCCESS on success,
> > + *		CMD_RET_USAGE or CMD_RET_FAILURE on failure
> > + *
> > + * Implement efidebug "ecpt" sub-command.
> > + * Show all the UEFI Conformance Profiles listed in the EFI Conformance Profiles
> > + * Table (ECPT).
> > + */
> > +static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, int flag, int argc,
> > +			    char *const argv[])
> > +{
> > +	const struct efi_conformance_profiles_table *ecpt;
> > +	u16 n;
> > +
> > +	if (argc != 1)
> > +		return CMD_RET_USAGE;
> > +
> > +	ecpt = efi_get_configuration_table(&efi_ecpt_guid);
> > +	if (!ecpt) {
> > +		log_info("ECPT: table not present\n");
> 
> This looks like an error situation. Should this be:
> 
> 	log_err("ECPT table missing\n");

Ok, I will change this as you suggest and send a v2, returning CMD_RET_FAILURE,
then.

Note that I did hesitate and finally opted to replicate what
do_efi_capsule_esrt() was doing, but I think reporting an error as you suggest
makes more sense as we know that we should have an ECPT when CONFIG_EFI_ECPT=y.

> 
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +
> > +	for (n = 0; n < ecpt->number_of_profiles; n++) {
> > +		const efi_guid_t *guid = &ecpt->conformance_profiles[n];
> > +
> > +		printf("%pUl  %s\n", guid->b,
> > +		       uuid_guid_get_str(guid->b) ?: "(unknown)");
> 
> Isn't the following enough:
> 
> 	printf("%pUs\n");
> 
> %pUs:   GUID text representation if known or fallback to %pUl

For this printing change I am not so sure; this is inspired from
efi_show_tables()'s behaviour and the intention is to have the following
outputs, depending on whether we know the GUID or not:

     cce33c35-74ac-4087-bce7-8b29b02eeb27  EFI EBBR 2.1 Conformance Profile
  or cce33c35-74ac-4087-bce7-8b29b02eeb27  (unknown)

With the change you suggest, we would have:

     EFI EBBR 2.1 Conformance Profile
  or cce33c35-74ac-4087-bce7-8b29b02eeb27

I think I prefer the original solution, as it more in line with `efidebug
tables' and it always shows the GUID in numerical form, but let me know if you
insist, in which case I will send a v3 with this change as well.

> 
> Best regards
> 
> Heinrich
> 
> > +	}
> > +
> > +	return CMD_RET_SUCCESS;
> > +}
> > +#endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
> > +
> >   static const char * const efi_mem_type_string[] = {
> >   	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
> >   	[EFI_LOADER_CODE] = "LOADER CODE",
> > @@ -1586,6 +1627,10 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
> >   			 "", ""),
> >   	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
> >   			 "", ""),
> > +#if CONFIG_IS_ENABLED(EFI_ECPT)
> > +	U_BOOT_CMD_MKENT(ecpt, CONFIG_SYS_MAXARGS, 1, do_efi_show_ecpt,
> > +			 "", ""),
> > +#endif
> >   	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
> >   			 "", ""),
> >   	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
> > @@ -1680,6 +1725,10 @@ U_BOOT_LONGHELP(efidebug,
> >   	"  - show UEFI handles\n"
> >   	"efidebug defaults\n"
> >   	"  - show default EFI filename and PXE architecture\n"
> > +#if CONFIG_IS_ENABLED(EFI_ECPT)
> > +	"efidebug ecpt\n"
> > +	"  - show conformance profiles in the ECPT\n"
> > +#endif
> >   	"efidebug images\n"
> >   	"  - show loaded images\n"
> >   	"efidebug memmap\n"
> 
