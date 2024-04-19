Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 20:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0918812C;
	Fri, 19 Apr 2024 22:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nkW5tZH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EAC882C9; Fri, 19 Apr 2024 22:04:11 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8648B8804F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5269c3f9c7so276939366b.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713557048; x=1714161848; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfPOm2CCr8oo+8wGA4yzOoeon39jk8kj0VdGhRUvj0I=;
 b=nkW5tZH9WLy4Jugbjag1roQNFx9DvClWjUIlPaYChrw6YzoLC2HaR/ofoV58l56/73
 qv6iSPIk1ZrUXRKlXpeSMFRZU/EEgXg+8dOeqUUeOBViht9Jvvhn2EDMEyMLMONv2ILa
 8Sd/1+aOdgR/vFHGJcRJgkkGSupVQql/8K4MYrmsTxFs9M8QmhrV2FXvvVoSMf6lm6+v
 WZTQSzERgMmVpT1kgveC3pEWhMRrcU71QjTy5dyGtiGcUmcXP9fj0jPT8RW4Zn4Gv6ok
 Khgqh/F5mo4N7UVh8FnGafDeMLx9KB0pXCcH/OdYrRoqLwiNgWnRWRhB0Ajcjh0evGKU
 qFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713557048; x=1714161848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfPOm2CCr8oo+8wGA4yzOoeon39jk8kj0VdGhRUvj0I=;
 b=MM7vh3vWLgy34WB2ol4TK/r8914C+gEFxN/XnV+y55V1F4mC9dCtTNvTxAcYz1Krpo
 Wq82zZiQNwKCJzBCvD159YqEFIxQ8MIGmX6GepfMXFoDJB6Oot5EIeoOgU36QwjzpT8y
 Wg2H9GOCZUz93h6Y0/5CEIEh37UGecUYjRlQaGqSRO5HR7VoKL2z0MSayHeWuDz+ehkP
 +7DTPhdKnjEHohTOcAQkhqibKMqYHY/aIyiiXTgQlocG0OlaW4BT694BbAxzQ3GAlYiE
 GM4BhV/bkYgwiIMB1mOuaOubl3BP7Tt4bQeY0j819trrsKjkMqwaATvvZd+xfIx6e/Z4
 9qQA==
X-Gm-Message-State: AOJu0YyT1rpZ2MLxIiEx2RuCLFhWZIj1q8k5XRtdF4AtEkt24ARNSXX/
 TtvPKZ12YVOuSSwmbcbwRRaw+2nfZIYouqO68p9Gp599rFQ9cLvasGsux1yb8mDkKH/sG1bHZHp
 ZnS4JoUQaeE65ubJoH0Fk2w/u61bLrkLJOvMiSw==
X-Google-Smtp-Source: AGHT+IG4NytDt5hEsMoIFrpnSa1zrBQdhTq3wudfUasPsmKkFs5nIv+k8IoNvakY9S3RP5MVM10jIlN9CDlbzVdCK44=
X-Received: by 2002:a17:906:1385:b0:a55:669d:3fab with SMTP id
 f5-20020a170906138500b00a55669d3fabmr2155714ejc.44.1713557047510; Fri, 19 Apr
 2024 13:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240405001722.2876240-1-tharvey@gateworks.com>
 <CAC_iWjL7nHxq7Yio6XqenxrMwfVBC-VK3UCDLX=4oNQWvcfTBQ@mail.gmail.com>
 <CAJ+vNU1H4GZ7Nq1MEcqWgSkZjPo9u-TDRVapLnn5Kq+3TyD-bA@mail.gmail.com>
 <CAC_iWjKA-bA=i6bzsnAvwn+JqtywbD8xWsQtECRjeswHBtT3fw@mail.gmail.com>
 <CAC_iWjJS+JhdDH8xPApna9ho8f4XxmTUGRZGZUEgt62xBcLRVQ@mail.gmail.com>
 <CAJ+vNU0ncveyq8M7PfQQrMEUr0z-qE5G6CDki9ms_4Ves=8G9g@mail.gmail.com>
In-Reply-To: <CAJ+vNU0ncveyq8M7PfQQrMEUr0z-qE5G6CDki9ms_4Ves=8G9g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Apr 2024 23:03:31 +0300
Message-ID: <CAC_iWj+Mm9is765HanRaMSc7Bntx9NrXu6uM2BdNT6PJcrdR5A@mail.gmail.com>
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

On Fri, 19 Apr 2024 at 20:52, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Fri, Apr 19, 2024 at 10:37=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Also quickly looking at this,  you need a new function for
> > tpm2_algorithm_to_mask() (look below)
> >
> > On Fri, 19 Apr 2024 at 20:20, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tim,
> > >
> > > On Fri, 19 Apr 2024 at 20:13, Tim Harvey <tharvey@gateworks.com> wrot=
e:
> > > >
> > > > On Sat, Apr 6, 2024 at 9:33=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Tim,
> > > > >
> > > > > Thanks for the patch
> > > > >
> > > > > I'll be away next week, I'll try to find time and take a closer l=
ook.
> > > > > The pipeline [0] shows some TPM related failures
> > > > >
> > > > > [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/=
9b4be64e41454e17269a968397933eeff300c380
> > > > >
> > > >
> > > > Hi Ilias,
> > > >
> > > > I changed the output of 'tpm pcr_read' so that it shows the algo an=
d
> > > > size causing the test in test/py/tests/test_tpm2.py to fail:
> > > > @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl
> > > > *cmdtp, int flag, int argc,
> > > >
> > > >         data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> > > >
> > > > -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2=
_ALG_SHA256,
> > > > -                          data, TPM2_DIGEST_LEN, &updates);
> > > > +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, algo=
,
> > > > +                          data, algo_len, &updates);
> > > >         if (!rc) {
> > > > -               printf("PCR #%u content (%u known updates):\n", ind=
ex, updates);
> > > > -               print_byte_string(data, TPM2_DIGEST_LEN);
> > > > +               printf("PCR #%u %s %d byte content (%u known
> > > > updates):\n", index,
> > > > +                      tpm2_algorithm_name(algo), algo_len, updates=
);
> > > > +               print_byte_string(data, algo_len);
> > > >         }
> > > >
> > > > failure:
> > > > E   AssertionError: assert 'PCR #10 content' in 'PCR #10 sha256 32
> > > > byte content (723 known updates):\r\r\n 00 00 00 00 00 00 00 00 00 =
00
> > > > 00 00 00 00 00 00\r\r\n 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
> > > > 00'
> > > >
> > > > So I suppose I need to update test/py/tests/test_tpm2.py as well.
> > >
> > > Yes
> > >
> > > >
> > > > Would I update test/py/tests/test_tpm2.py in the same patch as the =
one
> > > > that causes the failure?
> > >
> > > Yes please, I'd like patches merged that won't break the CI
> > >
> > > >
> > > > How do I go about running the tests manually to make sure I've addr=
essed it?
> > >
> > > You can send a PR against U-Boots repo (in github)
> > >
> > > Cheers
> > > /Ilias
> > > >
> > > > Best Regards,
> > > >
> > > > Tim
> > > >
> > > > > Cheers
> > > > > /Ilias
> > > > >
> > > > > On Fri, 5 Apr 2024 at 03:17, Tim Harvey <tharvey@gateworks.com> w=
rote:
> > > > > >
> > > > > > For pcr_read and pcr_extend commands allow the digest algorithm=
 to be
> > > > > > specified by an additional argument. If not specified it will d=
efault to
> > > > > > SHA256 for backwards compatibility.
> > > > > >
> > > > > > A follow-on to this could be to extend all PCR banks with the d=
etected
> > > > > > algo when the <digest_algo> argument is 'auto'.
> > > > > >
> > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > ---
> > > > > > v3:
> > > > > >  - replace tpm2_supported_algorithms with struct and use this t=
o relate hash algoirthm
> > > > > >    details
> > > > > > v2:
> > > > > >  - use tpm2_algorithm_to_len
> > > > > >  - use enum tpm2_algorithms
> > > > > >  - make function names and parameter names more consistent with=
 existing
> > > > > >    tpm-v2 functions
> > > > > >  - fix various spelling errors
> > > > > > ---
> > > > > >  cmd/tpm-v2.c              | 49 ++++++++++++++++++++--------
> > > > > >  include/tpm-v2.h          | 67 +++++++++++++++++++++++++++++++=
+++++++-
> > > > > >  lib/efi_loader/efi_tcg2.c |  4 +--
> > > > > >  lib/tpm-v2.c              | 62 +++++++++++++++++++++++--------=
-----
> > > > > >  4 files changed, 143 insertions(+), 39 deletions(-)
> > > > > >
> > > > > > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> > > > > > index 7e479b9dfe36..2343b4d9cb9e 100644
> > > > > > --- a/cmd/tpm-v2.c
> > > > > > +++ b/cmd/tpm-v2.c
> > > > > > @@ -99,11 +99,19 @@ static int do_tpm2_pcr_extend(struct cmd_tb=
l *cmdtp, int flag, int argc,
> > > > > >         struct tpm_chip_priv *priv;
> > > > > >         u32 index =3D simple_strtoul(argv[1], NULL, 0);
> > > > > >         void *digest =3D map_sysmem(simple_strtoul(argv[2], NUL=
L, 0), 0);
> > > > > > +       int algo =3D TPM2_ALG_SHA256;
> > > > > > +       int algo_len;
> > > > > >         int ret;
> > > > > >         u32 rc;
> > > > > >
> > > > > > -       if (argc !=3D 3)
> > > > > > +       if (argc < 3 || argc > 4)
> > > > > >                 return CMD_RET_USAGE;
> > > > > > +       if (argc =3D=3D 4) {
> > > > > > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > > > > > +               if (algo < 0)
> > > > > > +                       return CMD_RET_FAILURE;
> > > > > > +       }
> > > > > > +       algo_len =3D tpm2_algorithm_to_len(algo);
> > > > > >
> > > > > >         ret =3D get_tpm(&dev);
> > > > > >         if (ret)
> > > > > > @@ -116,8 +124,12 @@ static int do_tpm2_pcr_extend(struct cmd_t=
bl *cmdtp, int flag, int argc,
> > > > > >         if (index >=3D priv->pcr_count)
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > > -       rc =3D tpm2_pcr_extend(dev, index, TPM2_ALG_SHA256, dig=
est,
> > > > > > -                            TPM2_DIGEST_LEN);
> > > > > > +       rc =3D tpm2_pcr_extend(dev, index, algo, digest, algo_l=
en);
> > > > > > +       if (!rc) {
> > > > > > +               printf("PCR #%u extended with %d byte %s digest=
\n", index,
> > > > > > +                      algo_len, tpm2_algorithm_name(algo));
> > > > > > +               print_byte_string(digest, algo_len);
> > > > > > +       }
> > > > > >
> > > > > >         unmap_sysmem(digest);
> > > > > >
> > > > > > @@ -127,15 +139,23 @@ static int do_tpm2_pcr_extend(struct cmd_=
tbl *cmdtp, int flag, int argc,
> > > > > >  static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, in=
t argc,
> > > > > >                            char *const argv[])
> > > > > >  {
> > > > > > +       enum tpm2_algorithms algo =3D TPM2_ALG_SHA256;
> > > > > >         struct udevice *dev;
> > > > > >         struct tpm_chip_priv *priv;
> > > > > >         u32 index, rc;
> > > > > > +       int algo_len;
> > > > > >         unsigned int updates;
> > > > > >         void *data;
> > > > > >         int ret;
> > > > > >
> > > > > > -       if (argc !=3D 3)
> > > > > > +       if (argc < 3 || argc > 4)
> > > > > >                 return CMD_RET_USAGE;
> > > > > > +       if (argc =3D=3D 4) {
> > > > > > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > > > > > +               if (algo < 0)
> > > > > > +                       return CMD_RET_FAILURE;
> > > > > > +       }
> > > > > > +       algo_len =3D tpm2_algorithm_to_len(algo);
> > > > > >
> > > > > >         ret =3D get_tpm(&dev);
> > > > > >         if (ret)
> > > > > > @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl=
 *cmdtp, int flag, int argc,
> > > > > >
> > > > > >         data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0=
);
> > > > > >
> > > > > > -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, =
TPM2_ALG_SHA256,
> > > > > > -                          data, TPM2_DIGEST_LEN, &updates);
> > > > > > +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, =
algo,
> > > > > > +                          data, algo_len, &updates);
> > > > > >         if (!rc) {
> > > > > > -               printf("PCR #%u content (%u known updates):\n",=
 index, updates);
> > > > > > -               print_byte_string(data, TPM2_DIGEST_LEN);
> > > > > > +               printf("PCR #%u %s %d byte content (%u known up=
dates):\n", index,
> > > > > > +                      tpm2_algorithm_name(algo), algo_len, upd=
ates);
> > > > > > +               print_byte_string(data, algo_len);
> > > > > >         }
> > > > > >
> > > > > >         unmap_sysmem(data);
> > > > > > @@ -415,14 +436,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, d=
o_tpm, "Issue a TPMv2.x command",
> > > > > >  "    <hierarchy> is one of:\n"
> > > > > >  "        * TPM2_RH_LOCKOUT\n"
> > > > > >  "        * TPM2_RH_PLATFORM\n"
> > > > > > -"pcr_extend <pcr> <digest_addr>\n"
> > > > > > -"    Extend PCR #<pcr> with digest at <digest_addr>.\n"
> > > > > > +"pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
> > > > > > +"    Extend PCR #<pcr> with digest at <digest_addr> with diges=
t_algo.\n"
> > > > > >  "    <pcr>: index of the PCR\n"
> > > > > > -"    <digest_addr>: address of a 32-byte SHA256 digest\n"
> > > > > > -"pcr_read <pcr> <digest_addr>\n"
> > > > > > -"    Read PCR #<pcr> to memory address <digest_addr>.\n"
> > > > > > +"    <digest_addr>: address of digest of digest_algo type (def=
aults to SHA256)\n"
> > > > > > +"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> > > > > > +"    Read PCR #<pcr> to memory address <digest_addr> with <dig=
est_algo>.\n"
> > > > > >  "    <pcr>: index of the PCR\n"
> > > > > > -"    <digest_addr>: address to store the a 32-byte SHA256 dige=
st\n"
> > > > > > +"    <digest_addr>: address of digest of digest_algo type (def=
aults to SHA256)\n"
> > > > > >  "get_capability <capability> <property> <addr> <count>\n"
> > > > > >  "    Read and display <count> entries indexed by <capability>/=
<property>.\n"
> > > > > >  "    Values are 4 bytes long and are written at <addr>.\n"
> > > > > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > > > > > index 33dd103767c4..263f9529e55d 100644
> > > > > > --- a/include/tpm-v2.h
> > > > > > +++ b/include/tpm-v2.h
> > > > > > @@ -386,7 +386,54 @@ enum tpm2_algorithms {
> > > > > >         TPM2_ALG_SM3_256        =3D 0x12,
> > > > > >  };
> > > > > >
> > > > > > -extern const enum tpm2_algorithms tpm2_supported_algorithms[4]=
;
> > > > > > +/**
> > > > > > + * struct digest_info - details of supported digests
> > > > > > + *
> > > > > > + * @hash_name:                 hash name
> > > > > > + * @hash_alg:                  hash algorithm id
> > > > > > + * @hash_mask:                 hash registry mask
> > > > > > + * @hash_len:                  hash digest length
> > > > > > + */
> > > > > > +struct digest_info {
> > > > > > +       const char *hash_name;
> > > > > > +       u16 hash_alg;
> > > > > > +       u32 hash_mask;
> > > > > > +       u16 hash_len;
> > > > > > +};
> > > > > > +
> > > > > > +/* Algorithm Registry */
> > > > > > +#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> > > > > > +#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> > > > > > +#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> > > > > > +#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> > > > > > +#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > > > > > +
> > > > > > +static const struct digest_info hash_algo_list[] =3D {
> > > > > > +       {
> > > > > > +               "sha1",
> > > > > > +               TPM2_ALG_SHA1,
> > > > > > +               TCG2_BOOT_HASH_ALG_SHA1,
> > > > > > +               TPM2_SHA1_DIGEST_SIZE,
> > > > > > +       },
> > > > > > +       {
> > > > > > +               "sha256",
> > > > > > +               TPM2_ALG_SHA256,
> > > > > > +               TCG2_BOOT_HASH_ALG_SHA256,
> > > > > > +               TPM2_SHA256_DIGEST_SIZE,
> > > > > > +       },
> > > > > > +       {
> > > > > > +               "sha384",
> > > > > > +               TPM2_ALG_SHA384,
> > > > > > +               TCG2_BOOT_HASH_ALG_SHA384,
> > > > > > +               TPM2_SHA384_DIGEST_SIZE,
> > > > > > +       },
> > > > > > +       {
> > > > > > +               "sha512",
> > > > > > +               TPM2_ALG_SHA512,
> > > > > > +               TCG2_BOOT_HASH_ALG_SHA512,
> > > > > > +               TPM2_SHA512_DIGEST_SIZE,
> > > > > > +       },
> > > > > > +};
> > > > > >
> > > > > >  static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a=
)
> > > > > >  {
> > > > > > @@ -965,4 +1012,22 @@ u32 tpm2_enable_nvcommits(struct udevice =
*dev, uint vendor_cmd,
> > > > > >   */
> > > > > >  u32 tpm2_auto_start(struct udevice *dev);
> > > > > >
> > > > > > +/**
> > > > > > + * tpm2_name_to_algorithm() - Return an algorithm id given a s=
upported
> > > > > > + *                           algorithm name
> > > > > > + *
> > > > > > + * @name: algorithm name
> > > > > > + * Return: enum tpm2_algorithms or -EINVAL
> > > > > > + */
> > > > > > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> > > > > > +
> > > > > > +/**
> > > > > > + * tpm2_algorithm_name() - Return an algorithm name string for=
 a
> > > > > > + *                        supported algorithm id
> > > > > > + *
> > > > > > + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> > > > > > + * Return: algorithm name string or ""
> > > > > > + */
> > > > > > +const char *tpm2_algorithm_name(enum tpm2_algorithms);
> > > > > > +
> > > > > >  #endif /* __TPM_V2_H */
> > > > > > diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg=
2.c
> > > > > > index b07e0099c27e..cf5d8de018a7 100644
> > > > > > --- a/lib/efi_loader/efi_tcg2.c
> > > > > > +++ b/lib/efi_loader/efi_tcg2.c
> > > > > > @@ -414,8 +414,8 @@ static efi_status_t tcg2_hash_pe_image(void=
 *efi, u64 efi_size,
> > > > > >         }
> > > > > >
> > > > > >         digest_list->count =3D 0;
> > > > > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms)=
; i++) {
> > > > > > -               u16 hash_alg =3D tpm2_supported_algorithms[i];
> > > > > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> > > > > > +               u16 hash_alg =3D hash_algo_list[i].hash_alg;
> > > > > >
> > > > > >                 if (!(active & tpm2_algorithm_to_mask(hash_alg)=
))
> > > > > >                         continue;
> > > > > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > > > > index 68eaaa639f89..83f490c82541 100644
> > > > > > --- a/lib/tpm-v2.c
> > > > > > +++ b/lib/tpm-v2.c
> > > > > > @@ -22,13 +22,6 @@
> > > > > >
> > > > > >  #include "tpm-utils.h"
> > > > > >
> > > > > > -const enum tpm2_algorithms tpm2_supported_algorithms[4] =3D {
> > > > > > -       TPM2_ALG_SHA1,
> > > > > > -       ,
> > > > > > -       TPM2_ALG_SHA384,
> > > > > > -       TPM2_ALG_SHA512,
> > > > > > -};
> >
> > The current tpm2_algorithm_to_mask() operates on those values and bits
> > shifts based on the enum. Since you remove the enum above, you must
> > also change the function implementation and return
> > hash_algo_list.hash_mask
> >
>
> That's already taken care of as the calls to tpm2_algorithm_to_mask()
> in my patch were adjusted from:
> tpm2_algorithm_to_mask(tpm2_supported_algorithms[i])
> to
> tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg)
>
> The hash_alg is the value from the previous enum.

The previous enums were defining TPM2_ALG_SHA1=3D1, TPM2_ALG_SHA256=3D2 etc
The current values are different. On top of that the .hash_mask  entry
of digest_info is never used. So you need to change
tpm2_algorithm_to_mask() and directly return the hash_mask

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
> >
> >
> > > > > > -
> > > > > >  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active=
_pcr_banks)
> > > > > >  {
> > > > > >         u32 supported =3D 0;
> > > > > > @@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice *dev,=
 const u8 *input, u32 length,
> > > > > >                 return rc;
> > > > > >
> > > > > >         digest_list->count =3D 0;
> > > > > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms)=
; ++i) {
> > > > > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > > > > >                 u32 mask =3D
> > > > > > -                       tpm2_algorithm_to_mask(tpm2_supported_a=
lgorithms[i]);
> > > > > > +                       tpm2_algorithm_to_mask(hash_algo_list[i=
].hash_alg);
> > > > > >
> > > > > >                 if (!(active & mask))
