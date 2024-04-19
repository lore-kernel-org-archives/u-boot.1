Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407DDC071FD
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 17:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D10F8883E;
	Fri, 19 Apr 2024 19:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CgT68g5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E228884B; Fri, 19 Apr 2024 19:21:04 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ACB88837
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 19:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so2778085e87.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713547260; x=1714152060; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzrgstAMOcYeye1KX5Ee4F73vDT/MTwoRnRaUYYhYZs=;
 b=CgT68g5aF/6oXETVZMwvqZFPjMpf5fM/Axlt22y79g/5RHPPPB7r/bNrgJDO0mcfFZ
 UZGFs0vC8dJCc6VWhgmfcRZHhLB/8fB4iY+RPJcrn/llrjtXgDvzipFALXo9BCntxH1H
 qh94ZFP/4wuWm35B9BO8venHnZThOXGGk5YGYP42MZDaZQiVCvr3ERuiuEjNg4fcPybL
 UgFa8LFLhQFfSsiCM/oelO5MCxUcuMqw791CrcelfOSOzf7xy8tXbdqi48JZ01zf1OFP
 Rs3QkImY11I30s3UI9qfWLW7F9YuvapOkYJzXFbG/1+pDnmvB2kQ3Md05AkogJQSCYmv
 NcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713547260; x=1714152060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzrgstAMOcYeye1KX5Ee4F73vDT/MTwoRnRaUYYhYZs=;
 b=FPbTcsLfxwCpmtONlkikLPgIBwYkKuCspOZvOuFVCnxF1c9csOIiQ4sv/IeDlEaeh5
 6uknLkWOixKq80b1dQMyZ1RHxri111KOSD00p5wn6KnZx+kP7ntFGRcVgZVtTXqCIpCt
 gmJS8PVLE88fK5uYe8bk8a+9tbi5yFACgoHnaDDHXfC+jG+yZNzapTVokGggkBkEfdiU
 89Df8fUXUINpQLV0w+VF4a/dVNMnbxPG7x9hUY9ShQZgQMUNNGID/jjliaBq41sdo6D4
 /of99Wbjqs71bxq+WZbsM6ilh3Vqtano1mLfyQzXbXlMvj8FuNiSCwo0ejQXGzT9IzE+
 yovQ==
X-Gm-Message-State: AOJu0Ywl0Lwp1tLHU5uABtKOVO5WiDzXLEj+8jVPez8ZOl+LrpkYppFq
 uJ0OncwxZT0+ZVTgalAgWFKsPlnPUQ0aYJ/IQVVR5GszfLkIOmNK+ET8jgAzNj7Ttdh6lrvw2Ha
 UFRrlfaKLEIxhdQwMiEz5gVwZn9vhNkVtl5VQwQ==
X-Google-Smtp-Source: AGHT+IGH1sNFVMfBc8r97GvnPoHiiEP/R55oiXKUHHykHxRZ+3hN03M3dajXtIDj1NJhxrGRaPM5RY8sB//Tkswit1U=
X-Received: by 2002:a05:6512:521:b0:518:9c3b:16d8 with SMTP id
 o1-20020a056512052100b005189c3b16d8mr1679564lfc.52.1713547259916; Fri, 19 Apr
 2024 10:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240405001722.2876240-1-tharvey@gateworks.com>
 <CAC_iWjL7nHxq7Yio6XqenxrMwfVBC-VK3UCDLX=4oNQWvcfTBQ@mail.gmail.com>
 <CAJ+vNU1H4GZ7Nq1MEcqWgSkZjPo9u-TDRVapLnn5Kq+3TyD-bA@mail.gmail.com>
In-Reply-To: <CAJ+vNU1H4GZ7Nq1MEcqWgSkZjPo9u-TDRVapLnn5Kq+3TyD-bA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Apr 2024 20:20:23 +0300
Message-ID: <CAC_iWjKA-bA=i6bzsnAvwn+JqtywbD8xWsQtECRjeswHBtT3fw@mail.gmail.com>
Subject: Re: [PATCH v3] tpm-v2: allow algoirthm name to be configured for
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

Hi Tim,

On Fri, 19 Apr 2024 at 20:13, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Sat, Apr 6, 2024 at 9:33=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tim,
> >
> > Thanks for the patch
> >
> > I'll be away next week, I'll try to find time and take a closer look.
> > The pipeline [0] shows some TPM related failures
> >
> > [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/9b4be6=
4e41454e17269a968397933eeff300c380
> >
>
> Hi Ilias,
>
> I changed the output of 'tpm pcr_read' so that it shows the algo and
> size causing the test in test/py/tests/test_tpm2.py to fail:
> @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl
> *cmdtp, int flag, int argc,
>
>         data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
>
> -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_ALG_S=
HA256,
> -                          data, TPM2_DIGEST_LEN, &updates);
> +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> +                          data, algo_len, &updates);
>         if (!rc) {
> -               printf("PCR #%u content (%u known updates):\n", index, up=
dates);
> -               print_byte_string(data, TPM2_DIGEST_LEN);
> +               printf("PCR #%u %s %d byte content (%u known
> updates):\n", index,
> +                      tpm2_algorithm_name(algo), algo_len, updates);
> +               print_byte_string(data, algo_len);
>         }
>
> failure:
> E   AssertionError: assert 'PCR #10 content' in 'PCR #10 sha256 32
> byte content (723 known updates):\r\r\n 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00\r\r\n 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00'
>
> So I suppose I need to update test/py/tests/test_tpm2.py as well.

Yes

>
> Would I update test/py/tests/test_tpm2.py in the same patch as the one
> that causes the failure?

Yes please, I'd like patches merged that won't break the CI

>
> How do I go about running the tests manually to make sure I've addressed =
it?

You can send a PR against U-Boots repo (in github)

Cheers
/Ilias
>
> Best Regards,
>
> Tim
>
> > Cheers
> > /Ilias
> >
> > On Fri, 5 Apr 2024 at 03:17, Tim Harvey <tharvey@gateworks.com> wrote:
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
> > > v3:
> > >  - replace tpm2_supported_algorithms with struct and use this to rela=
te hash algoirthm
> > >    details
> > > v2:
> > >  - use tpm2_algorithm_to_len
> > >  - use enum tpm2_algorithms
> > >  - make function names and parameter names more consistent with exist=
ing
> > >    tpm-v2 functions
> > >  - fix various spelling errors
> > > ---
> > >  cmd/tpm-v2.c              | 49 ++++++++++++++++++++--------
> > >  include/tpm-v2.h          | 67 +++++++++++++++++++++++++++++++++++++=
+-
> > >  lib/efi_loader/efi_tcg2.c |  4 +--
> > >  lib/tpm-v2.c              | 62 +++++++++++++++++++++++-------------
> > >  4 files changed, 143 insertions(+), 39 deletions(-)
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
> > > index 33dd103767c4..263f9529e55d 100644
> > > --- a/include/tpm-v2.h
> > > +++ b/include/tpm-v2.h
> > > @@ -386,7 +386,54 @@ enum tpm2_algorithms {
> > >         TPM2_ALG_SM3_256        =3D 0x12,
> > >  };
> > >
> > > -extern const enum tpm2_algorithms tpm2_supported_algorithms[4];
> > > +/**
> > > + * struct digest_info - details of supported digests
> > > + *
> > > + * @hash_name:                 hash name
> > > + * @hash_alg:                  hash algorithm id
> > > + * @hash_mask:                 hash registry mask
> > > + * @hash_len:                  hash digest length
> > > + */
> > > +struct digest_info {
> > > +       const char *hash_name;
> > > +       u16 hash_alg;
> > > +       u32 hash_mask;
> > > +       u16 hash_len;
> > > +};
> > > +
> > > +/* Algorithm Registry */
> > > +#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> > > +#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> > > +#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> > > +#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> > > +#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > > +
> > > +static const struct digest_info hash_algo_list[] =3D {
> > > +       {
> > > +               "sha1",
> > > +               TPM2_ALG_SHA1,
> > > +               TCG2_BOOT_HASH_ALG_SHA1,
> > > +               TPM2_SHA1_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha256",
> > > +               TPM2_ALG_SHA256,
> > > +               TCG2_BOOT_HASH_ALG_SHA256,
> > > +               TPM2_SHA256_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha384",
> > > +               TPM2_ALG_SHA384,
> > > +               TCG2_BOOT_HASH_ALG_SHA384,
> > > +               TPM2_SHA384_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha512",
> > > +               TPM2_ALG_SHA512,
> > > +               TCG2_BOOT_HASH_ALG_SHA512,
> > > +               TPM2_SHA512_DIGEST_SIZE,
> > > +       },
> > > +};
> > >
> > >  static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
> > >  {
> > > @@ -965,4 +1012,22 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, =
uint vendor_cmd,
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
> > > diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> > > index b07e0099c27e..cf5d8de018a7 100644
> > > --- a/lib/efi_loader/efi_tcg2.c
> > > +++ b/lib/efi_loader/efi_tcg2.c
> > > @@ -414,8 +414,8 @@ static efi_status_t tcg2_hash_pe_image(void *efi,=
 u64 efi_size,
> > >         }
> > >
> > >         digest_list->count =3D 0;
> > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++)=
 {
> > > -               u16 hash_alg =3D tpm2_supported_algorithms[i];
> > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> > > +               u16 hash_alg =3D hash_algo_list[i].hash_alg;
> > >
> > >                 if (!(active & tpm2_algorithm_to_mask(hash_alg)))
> > >                         continue;
> > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > index 68eaaa639f89..83f490c82541 100644
> > > --- a/lib/tpm-v2.c
> > > +++ b/lib/tpm-v2.c
> > > @@ -22,13 +22,6 @@
> > >
> > >  #include "tpm-utils.h"
> > >
> > > -const enum tpm2_algorithms tpm2_supported_algorithms[4] =3D {
> > > -       TPM2_ALG_SHA1,
> > > -       TPM2_ALG_SHA256,
> > > -       TPM2_ALG_SHA384,
> > > -       TPM2_ALG_SHA512,
> > > -};
> > > -
> > >  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_b=
anks)
> > >  {
> > >         u32 supported =3D 0;
> > > @@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice *dev, const=
 u8 *input, u32 length,
> > >                 return rc;
> > >
> > >         digest_list->count =3D 0;
> > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i)=
 {
> > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > >                 u32 mask =3D
> > > -                       tpm2_algorithm_to_mask(tpm2_supported_algorit=
hms[i]);
> > > +                       tpm2_algorithm_to_mask(hash_algo_list[i].hash=
_alg);
> > >
> > >                 if (!(active & mask))
> > >                         continue;
> > >
> > > -               switch (tpm2_supported_algorithms[i]) {
> > > +               switch (hash_algo_list[i].hash_alg) {
> > >                 case TPM2_ALG_SHA1:
> > >                         sha1_starts(&ctx);
> > >                         sha1_update(&ctx, input, length);
> > > @@ -116,12 +109,12 @@ int tcg2_create_digest(struct udevice *dev, con=
st u8 *input, u32 length,
> > >                         break;
> > >                 default:
> > >                         printf("%s: unsupported algorithm %x\n", __fu=
nc__,
> > > -                              tpm2_supported_algorithms[i]);
> > > +                              hash_algo_list[i].hash_alg);
> > >                         continue;
> > >                 }
> > >
> > >                 digest_list->digests[digest_list->count].hash_alg =3D
> > > -                       tpm2_supported_algorithms[i];
> > > +                       hash_algo_list[i].hash_alg;
> > >                 memcpy(&digest_list->digests[digest_list->count].dige=
st, final,
> > >                        len);
> > >                 digest_list->count++;
> > > @@ -208,13 +201,13 @@ static int tcg2_log_init(struct udevice *dev, s=
truct tcg2_event_log *elog)
> > >                 return rc;
> > >
> > >         event_size =3D offsetof(struct tcg_efi_spec_id_event, digest_=
sizes);
> > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i)=
 {
> > > -               mask =3D tpm2_algorithm_to_mask(tpm2_supported_algori=
thms[i]);
> > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > > +               mask =3D tpm2_algorithm_to_mask(hash_algo_list[i].has=
h_alg);
> > >
> > >                 if (!(active & mask))
> > >                         continue;
> > >
> > > -               switch (tpm2_supported_algorithms[i]) {
> > > +               switch (hash_algo_list[i].hash_alg) {
> > >                 case TPM2_ALG_SHA1:
> > >                 case TPM2_ALG_SHA256:
> > >                 case TPM2_ALG_SHA384:
> > > @@ -253,17 +246,17 @@ static int tcg2_log_init(struct udevice *dev, s=
truct tcg2_event_log *elog)
> > >         put_unaligned_le32(count, &ev->number_of_algorithms);
> > >
> > >         count =3D 0;
> > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i)=
 {
> > > -               mask =3D tpm2_algorithm_to_mask(tpm2_supported_algori=
thms[i]);
> > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > > +               mask =3D tpm2_algorithm_to_mask(hash_algo_list[i].has=
h_alg);
> > >
> > >                 if (!(active & mask))
> > >                         continue;
> > >
> > > -               len =3D tpm2_algorithm_to_len(tpm2_supported_algorith=
ms[i]);
> > > +               len =3D hash_algo_list[i].hash_len;
> > >                 if (!len)
> > >                         continue;
> > >
> > > -               put_unaligned_le16(tpm2_supported_algorithms[i],
> > > +               put_unaligned_le16(hash_algo_list[i].hash_alg,
> > >                                    &ev->digest_sizes[count].algorithm=
_id);
> > >                 put_unaligned_le16(len, &ev->digest_sizes[count].dige=
st_size);
> > >                 count++;
> > > @@ -304,7 +297,7 @@ static int tcg2_replay_eventlog(struct tcg2_event=
_log *elog,
> > >                 pos =3D offsetof(struct tcg_pcr_event2, digests) +
> > >                         offsetof(struct tpml_digest_values, count);
> > >                 count =3D get_unaligned_le32(log + pos);
> > > -               if (count > ARRAY_SIZE(tpm2_supported_algorithms) ||
> > > +               if (count > ARRAY_SIZE(hash_algo_list) ||
> > >                     (digest_list->count && digest_list->count !=3D co=
unt))
> > >                         return 0;
> > >
> > > @@ -407,7 +400,7 @@ static int tcg2_log_parse(struct udevice *dev, st=
ruct tcg2_event_log *elog)
> > >                 return 0;
> > >
> > >         count =3D get_unaligned_le32(&event->number_of_algorithms);
> > > -       if (count > ARRAY_SIZE(tpm2_supported_algorithms))
> > > +       if (count > ARRAY_SIZE(hash_algo_list))
> > >                 return 0;
> > >
> > >         calc_size =3D offsetof(struct tcg_efi_spec_id_event, digest_s=
izes) +
> > > @@ -1110,7 +1103,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 =
*supported_pcr, u32 *active_pcr,
> > >          * We only support 5 algorithms for now so check against that
> > >          * instead of TPM2_NUM_PCR_BANKS
> > >          */
> > > -       if (pcrs.count > ARRAY_SIZE(tpm2_supported_algorithms) ||
> > > +       if (pcrs.count > ARRAY_SIZE(hash_algo_list) ||
> > >             pcrs.count < 1) {
> > >                 printf("%s: too many pcrs: %u\n", __func__, pcrs.coun=
t);
> > >                 return -EMSGSIZE;
> > > @@ -1555,3 +1548,28 @@ u32 tpm2_enable_nvcommits(struct udevice *dev,=
 uint vendor_cmd,
> > >
> > >         return 0;
> > >  }
> > > +
> > > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
> > > +{
> > > +       size_t i;
> > > +
> > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > > +               if (!strcasecmp(name, hash_algo_list[i].hash_name))
> > > +                       return hash_algo_list[i].hash_alg;
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
> > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > > +               if (hash_algo_list[i].hash_alg =3D=3D algo)
> > > +                       return hash_algo_list[i].hash_name;
> > > +       }
> > > +
> > > +       return "";
> > > +}
> > > --
> > > 2.25.1
> > >
