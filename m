Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0336C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 08:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0ACF8891B;
	Tue, 27 Aug 2024 10:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QLn+VCz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C7C88955; Tue, 27 Aug 2024 10:05:36 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341A580544
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 10:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7141b04e7b5so3167687b3a.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724745932; x=1725350732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f7bZwR3sskNLne6gdUvh+Y5W336V2CaeTV4RqrOFoVE=;
 b=QLn+VCz1TDgpxPQZl0fDC86CBc66iQyCT3v3rs0gdpX5cAiSmoPR2Vu3pe19NHiTuM
 3dVrlwHk5ygQ/QMLeT5j9QxsHrlkLJDblMhBGHguP259lg9gDScObGSIzNDB5apN8DGV
 sjsDyFdyedzBxx61YKYWSniw7OmhPKA0ZXwRMRrWRqkjH7YPPLMDnPeGK4MlCbnSXzWa
 MYENMEyGWYX1kUhp3kKgZJNKadtogsuo96r/D3nEKYzdn9AWybS9VGO7DXxbMTzQG9Qi
 EkuOoIyFn1LW9zrZgqsWDY3y+bKxpZx2Xslhc1yyJoSekvoG6XCDO+5TcdcfofRzY64Q
 1/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724745932; x=1725350732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f7bZwR3sskNLne6gdUvh+Y5W336V2CaeTV4RqrOFoVE=;
 b=ROrP+uIyGrF8AVRoXGSfwr+0ugCenDnGsIVLwNq1JO3yQLPHk16/i5R9zcOxjCJ527
 QpmaIiTZ3BE1OcpnrbkeVm6EiZU1TV2nDKGcnN4Xb3Y7QEf6nh0foTCckdTnAq1+WhL+
 boNCbqJAhqDpeM+XD5rqsugJJTjb+h/2SGcuR7EEqhfsjp7wK+xezNgQSmV8azJszZzQ
 /MVyjPqIoz3BE/wj5oOzoqwuMykUbQusFAQgh9lPkiAB+IxN0v7imUc5fyl/j7Jun2YN
 rvo12YyJtf4yY0sLzN8f8YoYxpjdeKsvsGXxVuiqhASVaEiKczO/QA+K/zPUZAtc1Wzv
 flKw==
X-Gm-Message-State: AOJu0Yx1We4CXFrK1H3Fn/1CFJFSoDPwh38ceqLPr27Sq7IeHzJfqVft
 dmKHCUJNLJryyf9dWiERBAdG6EZt8gz3yWXDHaUdbpnfwSttuTNVPvrG8k8BqIcwd+le/SfzDwE
 c++APfqpmeAvaDKC85a+YTs/E+9YYfacpkc1U2g==
X-Google-Smtp-Source: AGHT+IH+5gCesm6sf9+mOHPpYH9dHTYFdT8S9DAX+LnBEeqxHsBTOfPiaxPnMmz6Ij5w0WNi975t4iYmV44p9Zp0NHU=
X-Received: by 2002:a05:6a20:439f:b0:1ca:cc16:1ebc with SMTP id
 adf61e73a8af0-1cc89d29a8amr14427980637.11.1724745931455; Tue, 27 Aug 2024
 01:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR10MB5244DD7996739E6063425201E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <ZqeitfLsRW8_Tet_@hera>
 <DU0PR10MB5244E4B10953B67C52F06322E1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU0PR10MB5244E4B10953B67C52F06322E1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Aug 2024 11:04:55 +0300
Message-ID: <CAC_iWjJ0-qf=H1a-bE6fZ1KU5_tB3uCN19gNUUEbgdxXs5KTNg@mail.gmail.com>
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

Hi Benjamin,


On Fri, 23 Aug 2024 at 15:29, Benjamin BARATTE <benjamin.baratte@st.com> wrote:
>
> Hi @Ilias Apalodimas,
>
>
> ST Restricted
> > -----Original Message-----
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Monday, July 29, 2024 4:10 PM
> > To: Benjamin BARATTE <benjamin.baratte@st.com>
> > Cc: u-boot@lists.denx.de; akashi.tkhro@gmail.com;
> > abdellatif.elkhlifi@arm.com; eajames@linux.ibm.com; xypron.glpk@gmx.de;
> > kojima.masahisa@socionext.com; sjg@chromium.org;
> > sughosh.ganu@linaro.org; tharvey@gateworks.com; trini@konsulko.com
> > Subject: Re: [PATCH 3/3] tpm_tcg2: hash algo optimization
> >
> > On Mon, Jul 15, 2024 at 01:33:19PM +0000, Benjamin BARATTE wrote:
> > > To properly enable code optimization with hash algorithm, all the
> > > reference of the hash algo should condition to hash enablement.
> > > It is possible to fine tune the list of hash algorithms based on dTPM
> > > configuration.
> > > Therefore if dTPM supports only one bank, on one hash algorithm could
> > > be selected (TCG PTP specification mention in case of single bank
> > > support that SHA256 must be support and default value)
> >
> > Yes, but...
> > In order to apply this we need a function that *configures* the TPM with only
> > the supported compiled algorithms.  If a TPM is configured with more than
> > what u-boot supports, there might be security implications since we will fail to
> > cap all active PCRs. On top of that the EFI TCG explicitly says that all the active
> > PCR banks needs to be updated when extending measurements.
> >
>
> I'm agree with you, but this is more a configuration issue in that case.
> Today to do such configuration, we need to do it with tpm2-tools under Linux
> But if U-boot is preventing the Linux kernel to boot, this will become problematic.

It's the same configuration issue for u-boot. If you enable all
hashing algorithms Linux will be just fine.

> And U-boot API to configure the TPM PCR will be more than welcome in U-boot.

Configuring the TPM PCR available banks shouldnt be too much code, we
already have a function to read the available ones.

>
> This will allow industrial user to manage this configuration in U-boot instead of Linux.

Failing to cap all available PCR banks might lead to misconfiguration
errors and eventually compromise the TPM security -- e.g unseal keys
you shouldnt. There's an extended discussion about the same issue here
[0]. Keeping that in mind, I don't want to pick patches that allow
people to shoot themselves in the foot.

[0] https://lore.kernel.org/linux-integrity/20240531010331.134441-7-ross.philipson@oracle.com/

Thanks
/Ilias


>
> Best Regards,
>
> Benjamin
>
> > Thanks
> > /Ilias
> >
> > >
> > > Signed-off-by: Benjamin BARATTE <benjamin.baratte@st.com>
> > > ---
> > >
> > >  include/tpm-v2.h       |  8 --------
> > >  lib/efi_loader/Kconfig |  4 ----
> > >  lib/tpm_tcg2.c         | 38 ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 38 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h index
> > > 9848e1fd10..ec3504de44 100644
> > > --- a/include/tpm-v2.h
> > > +++ b/include/tpm-v2.h
> > > @@ -285,38 +285,30 @@ struct digest_info {
> > >
> > >
> > >  static const struct digest_info hash_algo_list[] = { -#if
> > > IS_ENABLED(CONFIG_SHA1)
> > >         {
> > >                 "sha1",
> > >                 TPM2_ALG_SHA1,
> > >                 TCG2_BOOT_HASH_ALG_SHA1,
> > >                 TPM2_SHA1_DIGEST_SIZE,
> > >         },
> > > -#endif
> > > -#if IS_ENABLED(CONFIG_SHA256)
> > >         {
> > >                 "sha256",
> > >                 TPM2_ALG_SHA256,
> > >                 TCG2_BOOT_HASH_ALG_SHA256,
> > >                 TPM2_SHA256_DIGEST_SIZE,
> > >         },
> > > -#endif
> > > -#if IS_ENABLED(CONFIG_SHA384)
> > >         {
> > >                 "sha384",
> > >                 TPM2_ALG_SHA384,
> > >                 TCG2_BOOT_HASH_ALG_SHA384,
> > >                 TPM2_SHA384_DIGEST_SIZE,
> > >         },
> > > -#endif
> > > -#if IS_ENABLED(CONFIG_SHA512)
> > >         {
> > >                 "sha512",
> > >                 TPM2_ALG_SHA512,
> > >                 TCG2_BOOT_HASH_ALG_SHA512,
> > >                 TPM2_SHA512_DIGEST_SIZE,
> > >         },
> > > -#endif
> > >         {
> > >                 "sha3_256",
> > >                 TPM2_ALG_SHA3_256,
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig index
> > > ee71f41714..512fb710b5 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -405,10 +405,6 @@ config EFI_TCG2_PROTOCOL
> > >         bool "EFI_TCG2_PROTOCOL support"
> > >         default y
> > >         depends on TPM_V2
> > > -       select SHA1
> > > -       select SHA256
> > > -       select SHA384
> > > -       select SHA512
> > >         select HASH
> > >         select SMBIOS_PARSER
> > >         help
> > > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c index
> > > 7f868cc883..66573b838d 100644
> > > --- a/lib/tpm_tcg2.c
> > > +++ b/lib/tpm_tcg2.c
> > > @@ -96,9 +96,15 @@ int tcg2_create_digest(struct udevice *dev, const u8
> > *input, u32 length,
> > >                        struct tpml_digest_values *digest_list)  {
> > >         u8 final[sizeof(union tpmu_ha)];
> > > +#if IS_ENABLED(CONFIG_SHA256)
> > >         sha256_context ctx_256;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA384) || IS_ENABLED(CONFIG_SHA512)
> > >         sha512_context ctx_512;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA1)
> > >         sha1_context ctx;
> > > +#endif
> > >         u32 active;
> > >         size_t i;
> > >         u32 len;
> > > @@ -114,30 +120,38 @@ int tcg2_create_digest(struct udevice *dev, const
> > u8 *input, u32 length,
> > >                         continue;
> > >
> > >                 switch (hash_algo_list[i].hash_alg) {
> > > +#if IS_ENABLED(CONFIG_SHA1)
> > >                 case TPM2_ALG_SHA1:
> > >                         sha1_starts(&ctx);
> > >                         sha1_update(&ctx, input, length);
> > >                         sha1_finish(&ctx, final);
> > >                         len = TPM2_SHA1_DIGEST_SIZE;
> > >                         break;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA256)
> > >                 case TPM2_ALG_SHA256:
> > >                         sha256_starts(&ctx_256);
> > >                         sha256_update(&ctx_256, input, length);
> > >                         sha256_finish(&ctx_256, final);
> > >                         len = TPM2_SHA256_DIGEST_SIZE;
> > >                         break;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA384)
> > >                 case TPM2_ALG_SHA384:
> > >                         sha384_starts(&ctx_512);
> > >                         sha384_update(&ctx_512, input, length);
> > >                         sha384_finish(&ctx_512, final);
> > >                         len = TPM2_SHA384_DIGEST_SIZE;
> > >                         break;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA512)
> > >                 case TPM2_ALG_SHA512:
> > >                         sha512_starts(&ctx_512);
> > >                         sha512_update(&ctx_512, input, length);
> > >                         sha512_finish(&ctx_512, final);
> > >                         len = TPM2_SHA512_DIGEST_SIZE;
> > >                         break;
> > > +#endif
> > >                 default:
> > >                         printf("%s: unsupported algorithm %x\n", __func__,
> > >                                hash_algo_list[i].hash_alg); @@ -236,10
> > > +250,18 @@ static int tcg2_log_init(struct udevice *dev, struct
> > tcg2_event_log *elog)
> > >                         continue;
> > >
> > >                 switch (hash_algo_list[i].hash_alg) {
> > > +#if IS_ENABLED(CONFIG_SHA1)
> > >                 case TPM2_ALG_SHA1:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA256)
> > >                 case TPM2_ALG_SHA256:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA384)
> > >                 case TPM2_ALG_SHA384:
> > > +#endif
> > > +#if  IS_ENABLED(CONFIG_SHA512)
> > >                 case TPM2_ALG_SHA512:
> > > +#endif
> > >                         count++;
> > >                         break;
> > >                 default:
> > > @@ -337,10 +359,18 @@ static int tcg2_replay_eventlog(struct
> > tcg2_event_log *elog,
> > >                         algo = get_unaligned_le16(log + pos);
> > >                         pos += offsetof(struct tpmt_ha, digest);
> > >                         switch (algo) {
> > > +#if IS_ENABLED(CONFIG_SHA1)
> > >                         case TPM2_ALG_SHA1:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA256)
> > >                         case TPM2_ALG_SHA256:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA384)
> > >                         case TPM2_ALG_SHA384:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA512)
> > >                         case TPM2_ALG_SHA512:
> > > +#endif
> > >                                 len = tpm2_algorithm_to_len(algo);
> > >                                 break;
> > >                         default:
> > > @@ -450,10 +480,18 @@ static int tcg2_log_parse(struct udevice *dev,
> > struct tcg2_event_log *elog)
> > >                         return 0;
> > >
> > >                 switch (algo) {
> > > +#if IS_ENABLED(CONFIG_SHA1)
> > >                 case TPM2_ALG_SHA1:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA256)
> > >                 case TPM2_ALG_SHA256:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA384)
> > >                 case TPM2_ALG_SHA384:
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_SHA512)
> > >                 case TPM2_ALG_SHA512:
> > > +#endif
> > >                         len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
> > >                         if (tpm2_algorithm_to_len(algo) != len)
> > >                                 return 0;
> > > --
> > > 2.34.1
> > >
> > > ST Restricted
