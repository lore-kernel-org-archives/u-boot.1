Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A15C47DD9
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 07:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195C18825A;
	Sat, 30 Mar 2024 08:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UGlpxz2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEE688268; Sat, 30 Mar 2024 08:16:00 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FFC88150
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 08:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-515c198e835so2850235e87.3
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711782957; x=1712387757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJ8HLt/mL0jor3wBoQ/YlxJ6NHGwt/Sgrqj5jV9jTjg=;
 b=UGlpxz2+vUOaCIbnIyXN0PWVFCZpiMlJMSVlj834g7QiTsrylgEPBwRigmcKohoSrq
 vTYSPFD3ciXSLw4e9rlEmVHNTuOInpAPEKUCuJMHaQWzAGD+tCHzOWnYMMhbPArmbw8d
 O3/owDxNJlHxNqEB23Wi3U4pws8X0SwVKfl+VjFP0RSaqU0kp1UC2S8OBd2+GUoJ2Hhe
 Ov2S+8LeqoxrjpMbIEZjiI1AkD4cs6zUTjXPpDo7wM5EFZ/LOtjT/suKbigd83VOAeAo
 HybNcJlFc3VNFHtxuGJYCElS0fkLmbkirz9mLQ2zqrYWlCWdCdQ2bmd5MMFXorO9cbnq
 sV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711782957; x=1712387757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJ8HLt/mL0jor3wBoQ/YlxJ6NHGwt/Sgrqj5jV9jTjg=;
 b=UYL2a93aTXgH+mqCl31kL3jOgH4U7myHLOYqLK/UO5O7QsY3USLtgZQTKKFklXVKIB
 Bn6NoTk9VJ/poB3Mmv3Czmfnfq1IxWcDVaKjJj9u7ngO1y05muWdgBp3WmUJGKS9/axB
 xYTS1pWPdpHB3cb9QxaxbwXaS/7GBlDGuvgKBcEDVKkrS2Sbn/9B/CR9FjaDFoz05iWh
 qbIPalaGVPytABCwUwfVFDm4cSB3tH6ruofxJwM6rRFH7FWzHtIpQpyPfXBn6O31FlqM
 U/y9gJs4fEpdixoprvU2zae4vlnOoXPt/7nKYctS3sxbvD+Ste1uAXAt64O+J5vBZXqz
 HhqQ==
X-Gm-Message-State: AOJu0YzlTpc663UcDGjGKaAzMbVG7DimnIhUdyBLYPWyPCcfY6ZAuNSX
 hzqDtTRjx3WQmfQgtRF21ZvHzVWseXH+jyPXJ34i6cdo/git95Txf7PZOELK30AoFJCRSWL9Rhs
 8rC+nYxqmem110L2xyA8GwCsOrYb/yHUdRmibCHA2FEPJa9nfqI8=
X-Google-Smtp-Source: AGHT+IHtbDVA3zFRxE1xjH+lkLn9MmTgA9w+GNR2f+79K9YsQZZdbzlWLnUhmnGdcWy6HuE/c8yon0RgazyYsqQvCpg=
X-Received: by 2002:ac2:4c39:0:b0:515:a8e0:dfd8 with SMTP id
 u25-20020ac24c39000000b00515a8e0dfd8mr2558333lfq.3.1711782956737; Sat, 30 Mar
 2024 00:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240328170110.1960631-1-tharvey@gateworks.com>
 <CAC_iWj+Vv9cxUvzbzm1iVitELYs-RNc25yEG6FMg5DGsb+h+vA@mail.gmail.com>
 <CAJ+vNU36ejaEoBLEoDDEAFDdFh0LfRPWteBpokqO+RkrdMfN0Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU36ejaEoBLEoDDEAFDdFh0LfRPWteBpokqO+RkrdMfN0Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 30 Mar 2024 09:15:20 +0200
Message-ID: <CAC_iWjKxcpWE1vpNX0uiwBdbiyYbtAm=6Q-T6_xnbnO2+pMewg@mail.gmail.com>
Subject: Re: [PATCH v2] tpm-v2: allow algoirthm name to be configured for
 pcr_read and pcr_extend
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Eddie James <eajames@linux.ibm.com>,
 slee@gateworks.com
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

Hi Tim

On Sat, 30 Mar 2024 at 02:40, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Mar 28, 2024 at 11:18=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tim,
> >
> > On Thu, 28 Mar 2024 at 19:01, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > For pcr_read and pcr_extend commands allow the digest algorithm to be
> > > specified by an additional argument. If not specified it will default=
 to
> > > SHA256 for backwards compatibility.
> > >
> > > A follow-on to this could be to extend all PCR banks with the detecte=
d
> > > algo when the <digest_algo> argument is 'auto'.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > > v2:
> > >  - use tpm2_algorithm_to_len
> > >  - use enum tpm2_algorithms
> > >  - make function names and parameter names more consistent with exist=
ing
> > >    tpm-v2 functions
> > >  - fix various spelling errors
> > > ---
> > >  cmd/tpm-v2.c     | 49 ++++++++++++++++++++++++++++++++++------------=
--
> > >  include/tpm-v2.h | 18 ++++++++++++++++++
> > >  lib/tpm-v2.c     | 34 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 87 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> > > index 7e479b9dfe36..2343b4d9cb9e 100644
> > > --- a/cmd/tpm-v2.c
> > > +++ b/cmd/tpm-v2.c
> > > @@ -99,11 +99,19 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmd=
tp, int flag, int argc,
> > >         struct tpm_chip_priv *priv;
> > >         u32 index =3D simple_strtoul(argv[1], NULL, 0);
> > >         void *digest =3D map_sysmem(simple_strtoul(argv[2], NULL, 0),=
 0);
> > > +       int algo =3D TPM2_ALG_SHA256;
> > > +       int algo_len;
> > >         int ret;
> > >         u32 rc;
> > >
> > > -       if (argc !=3D 3)
> > > +       if (argc < 3 || argc > 4)
> > >                 return CMD_RET_USAGE;
> > > +       if (argc =3D=3D 4) {
> > > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > > +               if (algo < 0)
> > > +                       return CMD_RET_FAILURE;
> > > +       }
> > > +       algo_len =3D tpm2_algorithm_to_len(algo);
> > >
> > >         ret =3D get_tpm(&dev);
> > >         if (ret)
> > > @@ -116,8 +124,12 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cm=
dtp, int flag, int argc,
> > >         if (index >=3D priv->pcr_count)
> > >                 return -EINVAL;
> > >
> > > -       rc =3D tpm2_pcr_extend(dev, index, TPM2_ALG_SHA256, digest,
> > > -                            TPM2_DIGEST_LEN);
> > > +       rc =3D tpm2_pcr_extend(dev, index, algo, digest, algo_len);
> > > +       if (!rc) {
> > > +               printf("PCR #%u extended with %d byte %s digest\n", i=
ndex,
> > > +                      algo_len, tpm2_algorithm_name(algo));
> > > +               print_byte_string(digest, algo_len);
> > > +       }
> > >
> > >         unmap_sysmem(digest);
> > >
> > > @@ -127,15 +139,23 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *c=
mdtp, int flag, int argc,
> > >  static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc=
,
> > >                            char *const argv[])
> > >  {
> > > +       enum tpm2_algorithms algo =3D TPM2_ALG_SHA256;
> > >         struct udevice *dev;
> > >         struct tpm_chip_priv *priv;
> > >         u32 index, rc;
> > > +       int algo_len;
> > >         unsigned int updates;
> > >         void *data;
> > >         int ret;
> > >
> > > -       if (argc !=3D 3)
> > > +       if (argc < 3 || argc > 4)
> > >                 return CMD_RET_USAGE;
> > > +       if (argc =3D=3D 4) {
> > > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > > +               if (algo < 0)
> > > +                       return CMD_RET_FAILURE;
> > > +       }
> > > +       algo_len =3D tpm2_algorithm_to_len(algo);
> > >
> > >         ret =3D get_tpm(&dev);
> > >         if (ret)
> > > @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdt=
p, int flag, int argc,
> > >
> > >         data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> > >
> > > -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_A=
LG_SHA256,
> > > -                          data, TPM2_DIGEST_LEN, &updates);
> > > +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> > > +                          data, algo_len, &updates);
> > >         if (!rc) {
> > > -               printf("PCR #%u content (%u known updates):\n", index=
, updates);
> > > -               print_byte_string(data, TPM2_DIGEST_LEN);
> > > +               printf("PCR #%u %s %d byte content (%u known updates)=
:\n", index,
> > > +                      tpm2_algorithm_name(algo), algo_len, updates);
> > > +               print_byte_string(data, algo_len);
> > >         }
> > >
> > >         unmap_sysmem(data);
> > > @@ -415,14 +436,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm,=
 "Issue a TPMv2.x command",
> > >  "    <hierarchy> is one of:\n"
> > >  "        * TPM2_RH_LOCKOUT\n"
> > >  "        * TPM2_RH_PLATFORM\n"
> > > -"pcr_extend <pcr> <digest_addr>\n"
> > > -"    Extend PCR #<pcr> with digest at <digest_addr>.\n"
> > > +"pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
> > > +"    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo=
.\n"
> > >  "    <pcr>: index of the PCR\n"
> > > -"    <digest_addr>: address of a 32-byte SHA256 digest\n"
> > > -"pcr_read <pcr> <digest_addr>\n"
> > > -"    Read PCR #<pcr> to memory address <digest_addr>.\n"
> > > +"    <digest_addr>: address of digest of digest_algo type (defaults =
to SHA256)\n"
> > > +"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> > > +"    Read PCR #<pcr> to memory address <digest_addr> with <digest_al=
go>.\n"
> > >  "    <pcr>: index of the PCR\n"
> > > -"    <digest_addr>: address to store the a 32-byte SHA256 digest\n"
> > > +"    <digest_addr>: address of digest of digest_algo type (defaults =
to SHA256)\n"
> > >  "get_capability <capability> <property> <addr> <count>\n"
> > >  "    Read and display <count> entries indexed by <capability>/<prope=
rty>.\n"
> > >  "    Values are 4 bytes long and are written at <addr>.\n"
> > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > > index 33dd103767c4..933882fcbf97 100644
> > > --- a/include/tpm-v2.h
> > > +++ b/include/tpm-v2.h
> > > @@ -965,4 +965,22 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, u=
int vendor_cmd,
> > >   */
> > >  u32 tpm2_auto_start(struct udevice *dev);
> > >
> > > +/**
> > > + * tpm2_name_to_algorithm() - Return an algorithm id given a support=
ed
> > > + *                           algorithm name
> > > + *
> > > + * @name: algorithm name
> > > + * Return: enum tpm2_algorithms or -EINVAL
> > > + */
> > > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> > > +
> > > +/**
> > > + * tpm2_algorithm_name() - Return an algorithm name string for a
> > > + *                        supported algorithm id
> > > + *
> > > + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> > > + * Return: algorithm name string or ""
> > > + */
> > > +const char *tpm2_algorithm_name(enum tpm2_algorithms);
> > > +
> > >  #endif /* __TPM_V2_H */
> > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > index 68eaaa639f89..19b2535682e1 100644
> > > --- a/lib/tpm-v2.c
> > > +++ b/lib/tpm-v2.c
> > > @@ -29,6 +29,13 @@ const enum tpm2_algorithms tpm2_supported_algorith=
ms[4] =3D {
> > >         TPM2_ALG_SHA512,
> > >  };
> > >
> > > +const char *tpm2_supported_algorithm_names[4] =3D {
> > > +       "sha1",
> > > +       "sha256",
> > > +       "sha384",
> > > +       "sha512",
> > > +};
> > > +
> >
> > Overall this looks correct(but we don't need the [4] in the definition
> > tbh). However, keeping the info in 2 different places is not ideal.
> > We used to have a nice struct array that had all the info tightly toget=
her [0].
> >
> > The struct looked like
> >
> > struct digest_info {
> > u16 hash_alg;
> > u32 hash_mask;
> > u16 hash_len;
> > };
> >
> > static const struct digest_info hash_algo_list[] =3D {
> > {
> > TPM2_ALG_SHA1,
> > EFI_TCG2_BOOT_HASH_ALG_SHA1,
> > TPM2_SHA1_DIGEST_SIZE,
> > },
> > {
> > TPM2_ALG_SHA256,
> > EFI_TCG2_BOOT_HASH_ALG_SHA256,
> > TPM2_SHA256_DIGEST_SIZE,
> > },
> > {
> > TPM2_ALG_SHA384,
> > EFI_TCG2_BOOT_HASH_ALG_SHA384,
> > TPM2_SHA384_DIGEST_SIZE,
> > },
> > {
> > TPM2_ALG_SHA512,
> > EFI_TCG2_BOOT_HASH_ALG_SHA512,
> > TPM2_SHA512_DIGEST_SIZE,
> > },
> > };
> >
> > In short, we need to
> > - define the algorithm registry as defined by the TCG spec
> >   /* Algorithm Registry */
> >   #define EFI_TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> >   #define EFI_TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> >   #define EFI_TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> >   #define EFI_TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> >   #define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> >
>
> the above defines do not make sense to me if they are truely supposed
> to be masks compared to what we currently have:
>
> enum tpm2_algorithms {
>         TPM2_ALG_SHA1           =3D 0x04,
>         TPM2_ALG_XOR            =3D 0x0A,
>         TPM2_ALG_SHA256         =3D 0x0B,
>         TPM2_ALG_SHA384         =3D 0x0C,
>         TPM2_ALG_SHA512         =3D 0x0D,
>         TPM2_ALG_NULL           =3D 0x10,
>         TPM2_ALG_SM3_256        =3D 0x12,
> };
> #define tpm2_algorithm_to_mask(a)       (1 << (a))

Yes, this is a bit confusing.  We are *not* using those definitions
when calling tpm2_algorithm_to_mask(). Instead const enum of
tpm2_supported_algorithms[] is used which yields the same values.

>
> Is digest_info.hash_mask from 2023.04 something else or were those
> defines just wrong (struct digest_info didn't seem to be used anywhere
> in 2023.04)

It's probably present in 2022.X versions. The link included in the
mail is from 2022.01
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/blob/v2022.01-rc3/lib=
/efi_loader/efi_tcg2.c?ref_type=3Dtags#L75

>
> I'm ok with changing tpm2_supported_algorithms to a struct which
> defines name, algorithm_id, mask and len if I understand what values
> they should be.

I hope that's clear now. Basically if you checkout v2023.01 all the
functions are in lib/efi_loader/efi_tcg.c
You will need

static const struct digest_info hash_algo_list[], alg_to_len and
alg_to_mask functions. You can then add a new const char filed with
the names you want to support in the command line

Thanks for picking this up!

/Ilias

>
> Sounds like your suggesting:
> - add back struct digest_info
> - make tpm2_supported_algorithms be an array of struct digtest_info
> - use that array for tpm2_algorithm_to_len, tpm2_algorithm_to_mask,
> tpm2_algorithm_to_len and tpm2_name_to_algorithm
>
> Tim
>
> > - Bring back the functions that exist in that branch. Pre 2023.07 all
> > measured boot code lived in lib/efi_loader/efi_tcg.c, so we just need
> > to copy them over
> > - Add a new struct member with the name and a new function to retrieve =
it.
> >
> > [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/blob/v2022.01=
-rc3/lib/efi_loader/efi_tcg2.c?ref_type=3Dtags#L75
> >
> > I understand that's more than what your patch tries to achieve here. I
> > am fine pulling this as-is and you/I can fix it up later unless you
> > don't mind doing it in a v3.
> >
> > Thanks
> > /Ilias
> > >  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_b=
anks)
> > >  {
> > >         u32 supported =3D 0;
> > > @@ -1555,3 +1562,30 @@ u32 tpm2_enable_nvcommits(struct udevice *dev,=
 uint vendor_cmd,
> > >
> > >         return 0;
> > >  }
> > > +
> > > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
> > > +{
> > > +       enum tpm2_algorithms algo;
> > > +       size_t i;
> > > +
> > > +       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i)=
 {
> > > +               algo =3D tpm2_supported_algorithms[i];
> > > +               if (!strcasecmp(name, tpm2_supported_algorithm_names[=
i]))
> > > +                       return algo;
> > > +       }
> > > +       printf("%s: unsupported algorithm %s\n", __func__, name);
> > > +
> > > +       return -EINVAL;
> > > +}
> > > +
> > > +const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
> > > +{
> > > +       size_t i;
> > > +
> > > +       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i)=
 {
> > > +               if (tpm2_supported_algorithms[i] =3D=3D algo)
> > > +                       return tpm2_supported_algorithm_names[i];
> > > +       }
> > > +
> > > +       return "";
> > > +}
> > > --
> > > 2.25.1
> > >
