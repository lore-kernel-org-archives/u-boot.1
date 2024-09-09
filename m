Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67353ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B77E88D9C;
	Mon,  9 Sep 2024 13:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KmsrloCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978F088D9C; Mon,  9 Sep 2024 13:19:37 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA1988CBD
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so2597443a12.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725880773; x=1726485573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnqTYLWL4LDgkvtdLE0qAYHGl+2MSeyDXdvlDI4bolQ=;
 b=KmsrloCLEYlhn5MqZkezaP6hOFyTLPp18VwRNbYEviV6ce6JH/UfXRIbk2ZnbSI/as
 MD9eTZWJe9BADVXIuLmx15O8ZwaS/CED4NjTrXeQnJS0WKpJVhGSC7ItMDM2sqWRTz+a
 3QnXVsH6EMfia0dRxJEdmkkQgSN1Xo1sAzsQZjY5/nhUg0xdWJlINbcKK+Sxdg8tJ+ht
 aiJArmCO7fl91R2FD1mPw8l/Tqjs46C1Ve5I0ewRInaVcIgNtktMAMaVguO1ZIvNTeYM
 r/+Bbzoc2L7tXmgePD5m7aa52whbK0jqHn98VXxX14hECHl1Ug8hUPaI72VfJgK1CfAC
 umGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725880773; x=1726485573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnqTYLWL4LDgkvtdLE0qAYHGl+2MSeyDXdvlDI4bolQ=;
 b=gwTRQvgDTn1SEHTOdhh/i7XDycqB9CMyw53lvY6PSitojBVa93Q1mxtixKmDP6SXjl
 ZwiPX1nP4qpUojXp+1tymkb4PmZZ3NkHXkLgKck0xogAPRqlyCVmzbzrOJvxAHmoCpCw
 TOUnIP9tAHC5K3MLlRKJK0AXE39lWjTGwM+X3jFxG38I0unomYcWNMDzreDe+QysB4KT
 Q/DE/bs3f9sTmqsc+uEE1W92UkoKJRJj9tccf1aLLrim1NkI1g/hTzR93Ko7kIz0cH4T
 RM/hFsuwoSt/+FU0kT0Sb01+RhOmL+HSx8YML6FDdTiNj3XeQ2VYlfXLeQBuvLwVWFE1
 T5eg==
X-Gm-Message-State: AOJu0Yx95bWQzMe9I5YtiGiX3ER/Ryym/wWlqOBFnqgFTe1ykGmZk5L9
 Xa3isOkjBBDAnvThngS+vpf2JKqdfh+Rh/Uza0mwEvwfORssJ6CuyNeMm3IVCfwvop22/wRTCx8
 5xDlcNcdIlvfbqFwzbwkAXozpsME4p57GWj3N6A==
X-Google-Smtp-Source: AGHT+IFUpd3oBTzJadpf/qc/zCM45e1NLkxraS6ZobqH1oc4X/ng6zzsl0g0uJ9L+Gv0Gm3eRMfoXpMv9BqfOB7wieE=
X-Received: by 2002:a17:902:d551:b0:1fd:9c2d:2f27 with SMTP id
 d9443c01a7336-206f05428e1mr148024305ad.24.1725880772913; Mon, 09 Sep 2024
 04:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR10MB5244DD7996739E6063425201E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <ZqeitfLsRW8_Tet_@hera>
 <DU0PR10MB5244E4B10953B67C52F06322E1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <CAC_iWjJ0-qf=H1a-bE6fZ1KU5_tB3uCN19gNUUEbgdxXs5KTNg@mail.gmail.com>
 <DU0PR10MB52443107BB94781D0658FED3E19E2@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU0PR10MB52443107BB94781D0658FED3E19E2@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 9 Sep 2024 14:18:56 +0300
Message-ID: <CAC_iWjKKCGVRtP+UdiWHXzYwAensvex-zrOQ96xKTz_x_OPcdw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tpm_tcg2: hash algo optimization
To: Benjamin BARATTE <benjamin.baratte@st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "akashi.tkhro@gmail.com" <akashi.tkhro@gmail.com>, 
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>, 
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, 
 "kojima.masahisa@socionext.com" <kojima.masahisa@socionext.com>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "sughosh.ganu@linaro.org" <sughosh.ganu@linaro.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 "trini@konsulko.com" <trini@konsulko.com>
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

Hi Benjamin


On Fri, 6 Sept 2024 at 17:21, Benjamin BARATTE <benjamin.baratte@st.com> wrote:
>
> Hi Ilas,
>
> > -----Original Message-----
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Tuesday, August 27, 2024 10:05 AM
> > To: Benjamin BARATTE <benjamin.baratte@st.com>
> > Cc: u-boot@lists.denx.de; akashi.tkhro@gmail.com;
> > abdellatif.elkhlifi@arm.com; eajames@linux.ibm.com; xypron.glpk@gmx.de;
> > kojima.masahisa@socionext.com; sjg@chromium.org;
> > sughosh.ganu@linaro.org; tharvey@gateworks.com; trini@konsulko.com
> > Subject: Re: [PATCH 3/3] tpm_tcg2: hash algo optimization
> >
> > Hi Benjamin,
> >
> >
> > On Fri, 23 Aug 2024 at 15:29, Benjamin BARATTE
> > <benjamin.baratte@st.com> wrote:
> > >
> > > Hi @Ilias Apalodimas,
> > >
> > >
> > > ST Restricted
> > > > -----Original Message-----
> > > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Sent: Monday, July 29, 2024 4:10 PM
> > > > To: Benjamin BARATTE <benjamin.baratte@st.com>
> > > > Cc: u-boot@lists.denx.de; akashi.tkhro@gmail.com;
> > > > abdellatif.elkhlifi@arm.com; eajames@linux.ibm.com;
> > > > xypron.glpk@gmx.de; kojima.masahisa@socionext.com;
> > sjg@chromium.org;
> > > > sughosh.ganu@linaro.org; tharvey@gateworks.com; trini@konsulko.com
> > > > Subject: Re: [PATCH 3/3] tpm_tcg2: hash algo optimization
> > > >
> > > > On Mon, Jul 15, 2024 at 01:33:19PM +0000, Benjamin BARATTE wrote:
> > > > > To properly enable code optimization with hash algorithm, all the
> > > > > reference of the hash algo should condition to hash enablement.
> > > > > It is possible to fine tune the list of hash algorithms based on
> > > > > dTPM configuration.
> > > > > Therefore if dTPM supports only one bank, on one hash algorithm
> > > > > could be selected (TCG PTP specification mention in case of single
> > > > > bank support that SHA256 must be support and default value)
> > > >
> > > > Yes, but...
> > > > In order to apply this we need a function that *configures* the TPM
> > > > with only the supported compiled algorithms.  If a TPM is configured
> > > > with more than what u-boot supports, there might be security
> > > > implications since we will fail to cap all active PCRs. On top of
> > > > that the EFI TCG explicitly says that all the active PCR banks needs to be
> > updated when extending measurements.
> > > >
> > >
> > > I'm agree with you, but this is more a configuration issue in that case.
> > > Today to do such configuration, we need to do it with tpm2-tools under
> > > Linux But if U-boot is preventing the Linux kernel to boot, this will become
> > problematic.
> >
> > It's the same configuration issue for u-boot. If you enable all hashing
> > algorithms Linux will be just fine.
> >
> > > And U-boot API to configure the TPM PCR will be more than welcome in U-
> > boot.
> >
> > Configuring the TPM PCR available banks shouldnt be too much code, we
> > already have a function to read the available ones.
> >
> > >
> > > This will allow industrial user to manage this configuration in U-boot instead
> > of Linux.
> >
> > Failing to cap all available PCR banks might lead to misconfiguration errors and
> > eventually compromise the TPM security -- e.g unseal keys you shouldnt.
> > There's an extended discussion about the same issue here [0]. Keeping that in
> > mind, I don't want to pick patches that allow people to shoot themselves in
> > the foot.
> >
> > [0] https://lore.kernel.org/linux-integrity/20240531010331.134441-7-
> > ross.philipson@oracle.com/
> >
>
> OK understood.
>
> What could be done is to generate an error if, at runtime, there is a mismatch between U-Boot compilation and TPM configuration.

Isn't e7505b3b8bcd enough?

Thanks
/Ilias
>
> Best Regards,
>
> Benjamin
> > Thanks
> > /Ilias
> >
> >
> > >
> > > Best Regards,
> > >
> > > Benjamin
> > >
> > > > Thanks
> > > > /Ilias
> > > >
> > > > >
> > > > > Signed-off-by: Benjamin BARATTE <benjamin.baratte@st.com>
> > > > > ---
> > > > >
> > > > >  include/tpm-v2.h       |  8 --------
> > > > >  lib/efi_loader/Kconfig |  4 ----
> > > > >  lib/tpm_tcg2.c         | 38
> > ++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 38 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h index
> > > > > 9848e1fd10..ec3504de44 100644
> > > > > --- a/include/tpm-v2.h
> > > > > +++ b/include/tpm-v2.h
> > > > > @@ -285,38 +285,30 @@ struct digest_info {
> > > > >
> > > > >
> > > > >  static const struct digest_info hash_algo_list[] = { -#if
> > > > > IS_ENABLED(CONFIG_SHA1)
> > > > >         {
> > > > >                 "sha1",
> > > > >                 TPM2_ALG_SHA1,
> > > > >                 TCG2_BOOT_HASH_ALG_SHA1,
> > > > >                 TPM2_SHA1_DIGEST_SIZE,
> > > > >         },
> > > > > -#endif
> > > > > -#if IS_ENABLED(CONFIG_SHA256)
> > > > >         {
> > > > >                 "sha256",
> > > > >                 TPM2_ALG_SHA256,
> > > > >                 TCG2_BOOT_HASH_ALG_SHA256,
> > > > >                 TPM2_SHA256_DIGEST_SIZE,
> > > > >         },
> > > > > -#endif
> > > > > -#if IS_ENABLED(CONFIG_SHA384)
> > > > >         {
> > > > >                 "sha384",
> > > > >                 TPM2_ALG_SHA384,
> > > > >                 TCG2_BOOT_HASH_ALG_SHA384,
> > > > >                 TPM2_SHA384_DIGEST_SIZE,
> > > > >         },
> > > > > -#endif
> > > > > -#if IS_ENABLED(CONFIG_SHA512)
> > > > >         {
> > > > >                 "sha512",
> > > > >                 TPM2_ALG_SHA512,
> > > > >                 TCG2_BOOT_HASH_ALG_SHA512,
> > > > >                 TPM2_SHA512_DIGEST_SIZE,
> > > > >         },
> > > > > -#endif
> > > > >         {
> > > > >                 "sha3_256",
> > > > >                 TPM2_ALG_SHA3_256, diff --git
> > > > > a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig index
> > > > > ee71f41714..512fb710b5 100644
> > > > > --- a/lib/efi_loader/Kconfig
> > > > > +++ b/lib/efi_loader/Kconfig
> > > > > @@ -405,10 +405,6 @@ config EFI_TCG2_PROTOCOL
> > > > >         bool "EFI_TCG2_PROTOCOL support"
> > > > >         default y
> > > > >         depends on TPM_V2
> > > > > -       select SHA1
> > > > > -       select SHA256
> > > > > -       select SHA384
> > > > > -       select SHA512
> > > > >         select HASH
> > > > >         select SMBIOS_PARSER
> > > > >         help
> > > > > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c index
> > > > > 7f868cc883..66573b838d 100644
> > > > > --- a/lib/tpm_tcg2.c
> > > > > +++ b/lib/tpm_tcg2.c
> > > > > @@ -96,9 +96,15 @@ int tcg2_create_digest(struct udevice *dev,
> > > > > const u8
> > > > *input, u32 length,
> > > > >                        struct tpml_digest_values *digest_list)  {
> > > > >         u8 final[sizeof(union tpmu_ha)];
> > > > > +#if IS_ENABLED(CONFIG_SHA256)
> > > > >         sha256_context ctx_256;
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA384) || IS_ENABLED(CONFIG_SHA512)
> > > > >         sha512_context ctx_512;
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA1)
> > > > >         sha1_context ctx;
> > > > > +#endif
> > > > >         u32 active;
> > > > >         size_t i;
> > > > >         u32 len;
> > > > > @@ -114,30 +120,38 @@ int tcg2_create_digest(struct udevice *dev,
> > > > > const
> > > > u8 *input, u32 length,
> > > > >                         continue;
> > > > >
> > > > >                 switch (hash_algo_list[i].hash_alg) {
> > > > > +#if IS_ENABLED(CONFIG_SHA1)
> > > > >                 case TPM2_ALG_SHA1:
> > > > >                         sha1_starts(&ctx);
> > > > >                         sha1_update(&ctx, input, length);
> > > > >                         sha1_finish(&ctx, final);
> > > > >                         len = TPM2_SHA1_DIGEST_SIZE;
> > > > >                         break;
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA256)
> > > > >                 case TPM2_ALG_SHA256:
> > > > >                         sha256_starts(&ctx_256);
> > > > >                         sha256_update(&ctx_256, input, length);
> > > > >                         sha256_finish(&ctx_256, final);
> > > > >                         len = TPM2_SHA256_DIGEST_SIZE;
> > > > >                         break;
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA384)
> > > > >                 case TPM2_ALG_SHA384:
> > > > >                         sha384_starts(&ctx_512);
> > > > >                         sha384_update(&ctx_512, input, length);
> > > > >                         sha384_finish(&ctx_512, final);
> > > > >                         len = TPM2_SHA384_DIGEST_SIZE;
> > > > >                         break;
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA512)
> > > > >                 case TPM2_ALG_SHA512:
> > > > >                         sha512_starts(&ctx_512);
> > > > >                         sha512_update(&ctx_512, input, length);
> > > > >                         sha512_finish(&ctx_512, final);
> > > > >                         len = TPM2_SHA512_DIGEST_SIZE;
> > > > >                         break;
> > > > > +#endif
> > > > >                 default:
> > > > >                         printf("%s: unsupported algorithm %x\n", __func__,
> > > > >                                hash_algo_list[i].hash_alg); @@
> > > > > -236,10
> > > > > +250,18 @@ static int tcg2_log_init(struct udevice *dev, struct
> > > > tcg2_event_log *elog)
> > > > >                         continue;
> > > > >
> > > > >                 switch (hash_algo_list[i].hash_alg) {
> > > > > +#if IS_ENABLED(CONFIG_SHA1)
> > > > >                 case TPM2_ALG_SHA1:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA256)
> > > > >                 case TPM2_ALG_SHA256:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA384)
> > > > >                 case TPM2_ALG_SHA384:
> > > > > +#endif
> > > > > +#if  IS_ENABLED(CONFIG_SHA512)
> > > > >                 case TPM2_ALG_SHA512:
> > > > > +#endif
> > > > >                         count++;
> > > > >                         break;
> > > > >                 default:
> > > > > @@ -337,10 +359,18 @@ static int tcg2_replay_eventlog(struct
> > > > tcg2_event_log *elog,
> > > > >                         algo = get_unaligned_le16(log + pos);
> > > > >                         pos += offsetof(struct tpmt_ha, digest);
> > > > >                         switch (algo) {
> > > > > +#if IS_ENABLED(CONFIG_SHA1)
> > > > >                         case TPM2_ALG_SHA1:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA256)
> > > > >                         case TPM2_ALG_SHA256:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA384)
> > > > >                         case TPM2_ALG_SHA384:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA512)
> > > > >                         case TPM2_ALG_SHA512:
> > > > > +#endif
> > > > >                                 len = tpm2_algorithm_to_len(algo);
> > > > >                                 break;
> > > > >                         default:
> > > > > @@ -450,10 +480,18 @@ static int tcg2_log_parse(struct udevice
> > > > > *dev,
> > > > struct tcg2_event_log *elog)
> > > > >                         return 0;
> > > > >
> > > > >                 switch (algo) {
> > > > > +#if IS_ENABLED(CONFIG_SHA1)
> > > > >                 case TPM2_ALG_SHA1:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA256)
> > > > >                 case TPM2_ALG_SHA256:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA384)
> > > > >                 case TPM2_ALG_SHA384:
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_SHA512)
> > > > >                 case TPM2_ALG_SHA512:
> > > > > +#endif
> > > > >                         len = get_unaligned_le16(&event-
> > >digest_sizes[i].digest_size);
> > > > >                         if (tpm2_algorithm_to_len(algo) != len)
> > > > >                                 return 0;
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > > ST Restricted
