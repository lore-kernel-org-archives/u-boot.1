Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFEBC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A2688233;
	Tue, 21 May 2024 12:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B0BIJXUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8C0882DF; Tue, 21 May 2024 12:30:31 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBBDA88261
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e1fa824504so46227171fa.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716287428; x=1716892228; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUo6XNqx1cjnYFZUogsABHl+orhEQes826kTaX1WMgI=;
 b=B0BIJXUbAUKTXYVkL+6lt4ArhI7o0vJjwN0eYjJAc9YGacUiJXejv/pCd/8Jd1RMOu
 jG5PdXtbIJOVf32RUf8k9YPqysRKa6lhd8iWxzOug73sP1bDd3yrl7G7Ha7m5LTu+Svy
 4ryrgI0SE/ljX1ZcSwHxPmIXbw1aVqF9jJWEQuBQrk8lgkh4WEOvjh8I+HHntLYBSFto
 2Mq8iRejPLjWHfMBQKYSo+E0LUXRaLauP+23d3YP51dbcvZT5C1ch/jdu6aYQHrH+wEA
 CGfSucluFqxf+8VFY3N3zZsjbuGzuYkXS+mA2u/ssGGAo57HlVr89ISDyzQgJv0B91qJ
 TnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716287428; x=1716892228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUo6XNqx1cjnYFZUogsABHl+orhEQes826kTaX1WMgI=;
 b=A/36OxFc7t5ISAXHCzI4GpOctRFF19prrbSC5dQDwSFoo9qFwhk+K5o5Fia5jiUcR/
 1wzU8/qjr8JRVbVgk4EaOZ3Yp9kxxU3AJjF9XwMpeu9pQjhdtlaIxLYnoScRx9Hqd6zV
 z1CaMXxxV6AY9EmZ7wTu+2d2chSznPc+qkdOH/oy4j7VVuHuNvhRavAPx9sBCicUa2Y/
 L4yCPBAJS9AvmUALXdEYedsjhoSLZ1Vs3+iNOySSDl3X9cXObnYntSqYS8ooa+MoUJxt
 cNVXsYxMptKY+zS0vc/MGutUDB+r9ZYpgnKAdldaoSTfsWdWXvUNFCbVKtcn7voS9QEh
 5Jlw==
X-Gm-Message-State: AOJu0Yxb8OUS7JUsqWwkUeSe+GRWYHF/V4kkm6aksz5zCed6Ky5nVu3x
 wxZFBMa8yCe7mZqvllLwlMH4+OIUXojWzwqz5rs9OsoRmILnZ/8r7D7Rjv7RZKQFFI+S1+blRXN
 k63R9SjRGWfDcFJg6Tlmtpq2+oAsOfN1Ehvb/XQ==
X-Google-Smtp-Source: AGHT+IEccfOtOxx8rCsEDHEJs5pcTYeI19ul4durbZDubGflcM7WJPiFUg3pK7etOV11S/EvGsODR0k2hmSethRTRo8=
X-Received: by 2002:a2e:a456:0:b0:2e7:16c9:2e0e with SMTP id
 38308e7fff4ca-2e716c9332bmr47490151fa.9.1716287427944; Tue, 21 May 2024
 03:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240405001722.2876240-1-tharvey@gateworks.com>
 <CAC_iWjL7nHxq7Yio6XqenxrMwfVBC-VK3UCDLX=4oNQWvcfTBQ@mail.gmail.com>
 <CAJ+vNU1H4GZ7Nq1MEcqWgSkZjPo9u-TDRVapLnn5Kq+3TyD-bA@mail.gmail.com>
 <CAC_iWjKA-bA=i6bzsnAvwn+JqtywbD8xWsQtECRjeswHBtT3fw@mail.gmail.com>
 <CAC_iWjJS+JhdDH8xPApna9ho8f4XxmTUGRZGZUEgt62xBcLRVQ@mail.gmail.com>
 <CAJ+vNU0ncveyq8M7PfQQrMEUr0z-qE5G6CDki9ms_4Ves=8G9g@mail.gmail.com>
 <CAC_iWj+Mm9is765HanRaMSc7Bntx9NrXu6uM2BdNT6PJcrdR5A@mail.gmail.com>
 <CAJ+vNU04G1y68ZCaS7+SEAWqCx+WPL99HQu8FmyGYduMS1PZRw@mail.gmail.com>
 <CAC_iWjJXsJFGQmzCqsArM50wvkDBR0HsCdMcYHW-ZjenhkWjCA@mail.gmail.com>
In-Reply-To: <CAC_iWjJXsJFGQmzCqsArM50wvkDBR0HsCdMcYHW-ZjenhkWjCA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 13:29:51 +0300
Message-ID: <CAC_iWjJeP9gP_xyRULGsvvXtq=Po8kLiSUspGKYZaNrVy506oA@mail.gmail.com>
Subject: Re: [PATCH v3] tpm-v2: allow algoirthm name to be configured for
 pcr_read and pcr_extend
To: Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de
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

On Tue, 21 May 2024 at 13:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> Apologies for the late reply. I was attending a conference.
>
>
> On Thu, 16 May 2024 at 03:28, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Fri, Apr 19, 2024 at 1:04=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Fri, 19 Apr 2024 at 20:52, Tim Harvey <tharvey@gateworks.com> wrot=
e:
> > > >
> > > > On Fri, Apr 19, 2024 at 10:37=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Also quickly looking at this,  you need a new function for
> > > > > tpm2_algorithm_to_mask() (look below)
> > > > >
> > > > > On Fri, 19 Apr 2024 at 20:20, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Tim,
> > > > > >
> > > > > > On Fri, 19 Apr 2024 at 20:13, Tim Harvey <tharvey@gateworks.com=
> wrote:
> > > > > > >
> > > > > > > On Sat, Apr 6, 2024 at 9:33=E2=80=AFAM Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Tim,
> > > > > > > >
> > > > > > > > Thanks for the patch
> > > > > > > >
> > > > > > > > I'll be away next week, I'll try to find time and take a cl=
oser look.
> > > > > > > > The pipeline [0] shows some TPM related failures
> > > > > > > >
> > > > > > > > [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/c=
ommit/9b4be64e41454e17269a968397933eeff300c380
> > > > > > > >
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > I changed the output of 'tpm pcr_read' so that it shows the a=
lgo and
> > > > > > > size causing the test in test/py/tests/test_tpm2.py to fail:
> > > > > > > @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_t=
bl
> > > > > > > *cmdtp, int flag, int argc,
> > > > > > >
> > > > > > >         data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0),=
 0);
> > > > > > >
> > > > > > > -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min=
, TPM2_ALG_SHA256,
> > > > > > > -                          data, TPM2_DIGEST_LEN, &updates);
> > > > > > > +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min=
, algo,
> > > > > > > +                          data, algo_len, &updates);
> > > > > > >         if (!rc) {
> > > > > > > -               printf("PCR #%u content (%u known updates):\n=
", index, updates);
> > > > > > > -               print_byte_string(data, TPM2_DIGEST_LEN);
> > > > > > > +               printf("PCR #%u %s %d byte content (%u known
> > > > > > > updates):\n", index,
> > > > > > > +                      tpm2_algorithm_name(algo), algo_len, u=
pdates);
> > > > > > > +               print_byte_string(data, algo_len);
> > > > > > >         }
> > > > > > >
> > > > > > > failure:
> > > > > > > E   AssertionError: assert 'PCR #10 content' in 'PCR #10 sha2=
56 32
> > > > > > > byte content (723 known updates):\r\r\n 00 00 00 00 00 00 00 =
00 00 00
> > > > > > > 00 00 00 00 00 00\r\r\n 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00
> > > > > > > 00'
> > > > > > >
> > > > > > > So I suppose I need to update test/py/tests/test_tpm2.py as w=
ell.
> > > > > >
> > > > > > Yes
> > > > > >
> > > > > > >
> > > > > > > Would I update test/py/tests/test_tpm2.py in the same patch a=
s the one
> > > > > > > that causes the failure?
> > > > > >
> > > > > > Yes please, I'd like patches merged that won't break the CI
> > > > > >
> > > > > > >
> > > > > > > How do I go about running the tests manually to make sure I'v=
e addressed it?
> > > > > >
> > > > > > You can send a PR against U-Boots repo (in github)
> > > > > >
> > > > > > Cheers
> > > > > > /Ilias
> > > > > > >
> > > > > > > Best Regards,
> > > > > > >
> > > > > > > Tim
> > > > > > >
> > > > > > > > Cheers
> > > > > > > > /Ilias
> > > > > > > >
> > > > > > > > On Fri, 5 Apr 2024 at 03:17, Tim Harvey <tharvey@gateworks.=
com> wrote:
> > > > > > > > >
> > > > > > > > > For pcr_read and pcr_extend commands allow the digest alg=
orithm to be
> > > > > > > > > specified by an additional argument. If not specified it =
will default to
> > > > > > > > > SHA256 for backwards compatibility.
> > > > > > > > >
> > > > > > > > > A follow-on to this could be to extend all PCR banks with=
 the detected
> > > > > > > > > algo when the <digest_algo> argument is 'auto'.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > > > > ---
> > > > > > > > > v3:
> > > > > > > > >  - replace tpm2_supported_algorithms with struct and use =
this to relate hash algoirthm
> > > > > > > > >    details
> > > > > > > > > v2:
> > > > > > > > >  - use tpm2_algorithm_to_len
> > > > > > > > >  - use enum tpm2_algorithms
> > > > > > > > >  - make function names and parameter names more consisten=
t with existing
> > > > > > > > >    tpm-v2 functions
> > > > > > > > >  - fix various spelling errors
> > > > > > > > > ---
> > > > > > > > >  cmd/tpm-v2.c              | 49 ++++++++++++++++++++-----=
---
> > > > > > > > >  include/tpm-v2.h          | 67 +++++++++++++++++++++++++=
+++++++++++++-
> > > > > > > > >  lib/efi_loader/efi_tcg2.c |  4 +--
> > > > > > > > >  lib/tpm-v2.c              | 62 +++++++++++++++++++++++--=
-----------
> > > > > > > > >  4 files changed, 143 insertions(+), 39 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> > > > > > > > > index 7e479b9dfe36..2343b4d9cb9e 100644
> > > > > > > > > --- a/cmd/tpm-v2.c
> > > > > > > > > +++ b/cmd/tpm-v2.c
> > > > > > > > > @@ -99,11 +99,19 @@ static int do_tpm2_pcr_extend(struct =
cmd_tbl *cmdtp, int flag, int argc,
> > > > > > > > >         struct tpm_chip_priv *priv;
> > > > > > > > >         u32 index =3D simple_strtoul(argv[1], NULL, 0);
> > > > > > > > >         void *digest =3D map_sysmem(simple_strtoul(argv[2=
], NULL, 0), 0);
> > > > > > > > > +       int algo =3D TPM2_ALG_SHA256;
> > > > > > > > > +       int algo_len;
> > > > > > > > >         int ret;
> > > > > > > > >         u32 rc;
> > > > > > > > >
> > > > > > > > > -       if (argc !=3D 3)
> > > > > > > > > +       if (argc < 3 || argc > 4)
> > > > > > > > >                 return CMD_RET_USAGE;
> > > > > > > > > +       if (argc =3D=3D 4) {
> > > > > > > > > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > > > > > > > > +               if (algo < 0)
> > > > > > > > > +                       return CMD_RET_FAILURE;
> > > > > > > > > +       }
> > > > > > > > > +       algo_len =3D tpm2_algorithm_to_len(algo);
> > > > > > > > >
> > > > > > > > >         ret =3D get_tpm(&dev);
> > > > > > > > >         if (ret)
> > > > > > > > > @@ -116,8 +124,12 @@ static int do_tpm2_pcr_extend(struct=
 cmd_tbl *cmdtp, int flag, int argc,
> > > > > > > > >         if (index >=3D priv->pcr_count)
> > > > > > > > >                 return -EINVAL;
> > > > > > > > >
> > > > > > > > > -       rc =3D tpm2_pcr_extend(dev, index, TPM2_ALG_SHA25=
6, digest,
> > > > > > > > > -                            TPM2_DIGEST_LEN);
> > > > > > > > > +       rc =3D tpm2_pcr_extend(dev, index, algo, digest, =
algo_len);
> > > > > > > > > +       if (!rc) {
> > > > > > > > > +               printf("PCR #%u extended with %d byte %s =
digest\n", index,
> > > > > > > > > +                      algo_len, tpm2_algorithm_name(algo=
));
> > > > > > > > > +               print_byte_string(digest, algo_len);
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >         unmap_sysmem(digest);
> > > > > > > > >
> > > > > > > > > @@ -127,15 +139,23 @@ static int do_tpm2_pcr_extend(struc=
t cmd_tbl *cmdtp, int flag, int argc,
> > > > > > > > >  static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
> > > > > > > > >                            char *const argv[])
> > > > > > > > >  {
> > > > > > > > > +       enum tpm2_algorithms algo =3D TPM2_ALG_SHA256;
> > > > > > > > >         struct udevice *dev;
> > > > > > > > >         struct tpm_chip_priv *priv;
> > > > > > > > >         u32 index, rc;
> > > > > > > > > +       int algo_len;
> > > > > > > > >         unsigned int updates;
> > > > > > > > >         void *data;
> > > > > > > > >         int ret;
> > > > > > > > >
> > > > > > > > > -       if (argc !=3D 3)
> > > > > > > > > +       if (argc < 3 || argc > 4)
> > > > > > > > >                 return CMD_RET_USAGE;
> > > > > > > > > +       if (argc =3D=3D 4) {
> > > > > > > > > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > > > > > > > > +               if (algo < 0)
> > > > > > > > > +                       return CMD_RET_FAILURE;
> > > > > > > > > +       }
> > > > > > > > > +       algo_len =3D tpm2_algorithm_to_len(algo);
> > > > > > > > >
> > > > > > > > >         ret =3D get_tpm(&dev);
> > > > > > > > >         if (ret)
> > > > > > > > > @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct c=
md_tbl *cmdtp, int flag, int argc,
> > > > > > > > >
> > > > > > > > >         data =3D map_sysmem(simple_strtoul(argv[2], NULL,=
 0), 0);
> > > > > > > > >
> > > > > > > > > -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select=
_min, TPM2_ALG_SHA256,
> > > > > > > > > -                          data, TPM2_DIGEST_LEN, &update=
s);
> > > > > > > > > +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select=
_min, algo,
> > > > > > > > > +                          data, algo_len, &updates);
> > > > > > > > >         if (!rc) {
> > > > > > > > > -               printf("PCR #%u content (%u known updates=
):\n", index, updates);
> > > > > > > > > -               print_byte_string(data, TPM2_DIGEST_LEN);
> > > > > > > > > +               printf("PCR #%u %s %d byte content (%u kn=
own updates):\n", index,
> > > > > > > > > +                      tpm2_algorithm_name(algo), algo_le=
n, updates);
> > > > > > > > > +               print_byte_string(data, algo_len);
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > >         unmap_sysmem(data);
> > > > > > > > > @@ -415,14 +436,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS=
, 1, do_tpm, "Issue a TPMv2.x command",
> > > > > > > > >  "    <hierarchy> is one of:\n"
> > > > > > > > >  "        * TPM2_RH_LOCKOUT\n"
> > > > > > > > >  "        * TPM2_RH_PLATFORM\n"
> > > > > > > > > -"pcr_extend <pcr> <digest_addr>\n"
> > > > > > > > > -"    Extend PCR #<pcr> with digest at <digest_addr>.\n"
> > > > > > > > > +"pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
> > > > > > > > > +"    Extend PCR #<pcr> with digest at <digest_addr> with=
 digest_algo.\n"
> > > > > > > > >  "    <pcr>: index of the PCR\n"
> > > > > > > > > -"    <digest_addr>: address of a 32-byte SHA256 digest\n=
"
> > > > > > > > > -"pcr_read <pcr> <digest_addr>\n"
> > > > > > > > > -"    Read PCR #<pcr> to memory address <digest_addr>.\n"
> > > > > > > > > +"    <digest_addr>: address of digest of digest_algo typ=
e (defaults to SHA256)\n"
> > > > > > > > > +"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> > > > > > > > > +"    Read PCR #<pcr> to memory address <digest_addr> wit=
h <digest_algo>.\n"
> > > > > > > > >  "    <pcr>: index of the PCR\n"
> > > > > > > > > -"    <digest_addr>: address to store the a 32-byte SHA25=
6 digest\n"
> > > > > > > > > +"    <digest_addr>: address of digest of digest_algo typ=
e (defaults to SHA256)\n"
> > > > > > > > >  "get_capability <capability> <property> <addr> <count>\n=
"
> > > > > > > > >  "    Read and display <count> entries indexed by <capabi=
lity>/<property>.\n"
> > > > > > > > >  "    Values are 4 bytes long and are written at <addr>.\=
n"
> > > > > > > > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > > > > > > > > index 33dd103767c4..263f9529e55d 100644
> > > > > > > > > --- a/include/tpm-v2.h
> > > > > > > > > +++ b/include/tpm-v2.h
> > > > > > > > > @@ -386,7 +386,54 @@ enum tpm2_algorithms {
> > > > > > > > >         TPM2_ALG_SM3_256        =3D 0x12,
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > -extern const enum tpm2_algorithms tpm2_supported_algorit=
hms[4];
> > > > > > > > > +/**
> > > > > > > > > + * struct digest_info - details of supported digests
> > > > > > > > > + *
> > > > > > > > > + * @hash_name:                 hash name
> > > > > > > > > + * @hash_alg:                  hash algorithm id
> > > > > > > > > + * @hash_mask:                 hash registry mask
> > > > > > > > > + * @hash_len:                  hash digest length
> > > > > > > > > + */
> > > > > > > > > +struct digest_info {
> > > > > > > > > +       const char *hash_name;
> > > > > > > > > +       u16 hash_alg;
> > > > > > > > > +       u32 hash_mask;
> > > > > > > > > +       u16 hash_len;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +/* Algorithm Registry */
> > > > > > > > > +#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> > > > > > > > > +#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> > > > > > > > > +#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> > > > > > > > > +#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> > > > > > > > > +#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > > > > > > > > +
> > > > > > > > > +static const struct digest_info hash_algo_list[] =3D {
> > > > > > > > > +       {
> > > > > > > > > +               "sha1",
> > > > > > > > > +               TPM2_ALG_SHA1,
> > > > > > > > > +               TCG2_BOOT_HASH_ALG_SHA1,
> > > > > > > > > +               TPM2_SHA1_DIGEST_SIZE,
> > > > > > > > > +       },
> > > > > > > > > +       {
> > > > > > > > > +               "sha256",
> > > > > > > > > +               TPM2_ALG_SHA256,
> > > > > > > > > +               TCG2_BOOT_HASH_ALG_SHA256,
> > > > > > > > > +               TPM2_SHA256_DIGEST_SIZE,
> > > > > > > > > +       },
> > > > > > > > > +       {
> > > > > > > > > +               "sha384",
> > > > > > > > > +               TPM2_ALG_SHA384,
> > > > > > > > > +               TCG2_BOOT_HASH_ALG_SHA384,
> > > > > > > > > +               TPM2_SHA384_DIGEST_SIZE,
> > > > > > > > > +       },
> > > > > > > > > +       {
> > > > > > > > > +               "sha512",
> > > > > > > > > +               TPM2_ALG_SHA512,
> > > > > > > > > +               TCG2_BOOT_HASH_ALG_SHA512,
> > > > > > > > > +               TPM2_SHA512_DIGEST_SIZE,
> > > > > > > > > +       },
> > > > > > > > > +};
> > > > > > > > >
> > > > > > > > >  static inline u16 tpm2_algorithm_to_len(enum tpm2_algori=
thms a)
> > > > > > > > >  {
> > > > > > > > > @@ -965,4 +1012,22 @@ u32 tpm2_enable_nvcommits(struct ud=
evice *dev, uint vendor_cmd,
> > > > > > > > >   */
> > > > > > > > >  u32 tpm2_auto_start(struct udevice *dev);
> > > > > > > > >
> > > > > > > > > +/**
> > > > > > > > > + * tpm2_name_to_algorithm() - Return an algorithm id giv=
en a supported
> > > > > > > > > + *                           algorithm name
> > > > > > > > > + *
> > > > > > > > > + * @name: algorithm name
> > > > > > > > > + * Return: enum tpm2_algorithms or -EINVAL
> > > > > > > > > + */
> > > > > > > > > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *=
name);
> > > > > > > > > +
> > > > > > > > > +/**
> > > > > > > > > + * tpm2_algorithm_name() - Return an algorithm name stri=
ng for a
> > > > > > > > > + *                        supported algorithm id
> > > > > > > > > + *
> > > > > > > > > + * @algorithm_id: algorithm defined in enum tpm2_algorit=
hms
> > > > > > > > > + * Return: algorithm name string or ""
> > > > > > > > > + */
> > > > > > > > > +const char *tpm2_algorithm_name(enum tpm2_algorithms);
> > > > > > > > > +
> > > > > > > > >  #endif /* __TPM_V2_H */
> > > > > > > > > diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/e=
fi_tcg2.c
> > > > > > > > > index b07e0099c27e..cf5d8de018a7 100644
> > > > > > > > > --- a/lib/efi_loader/efi_tcg2.c
> > > > > > > > > +++ b/lib/efi_loader/efi_tcg2.c
> > > > > > > > > @@ -414,8 +414,8 @@ static efi_status_t tcg2_hash_pe_imag=
e(void *efi, u64 efi_size,
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > >         digest_list->count =3D 0;
> > > > > > > > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algor=
ithms); i++) {
> > > > > > > > > -               u16 hash_alg =3D tpm2_supported_algorithm=
s[i];
> > > > > > > > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); i++=
) {
> > > > > > > > > +               u16 hash_alg =3D hash_algo_list[i].hash_a=
lg;
> > > > > > > > >
> > > > > > > > >                 if (!(active & tpm2_algorithm_to_mask(has=
h_alg)))
> > > > > > > > >                         continue;
> > > > > > > > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > > > > > > > index 68eaaa639f89..83f490c82541 100644
> > > > > > > > > --- a/lib/tpm-v2.c
> > > > > > > > > +++ b/lib/tpm-v2.c
> > > > > > > > > @@ -22,13 +22,6 @@
> > > > > > > > >
> > > > > > > > >  #include "tpm-utils.h"
> > > > > > > > >
> > > > > > > > > -const enum tpm2_algorithms tpm2_supported_algorithms[4] =
=3D {
> > > > > > > > > -       TPM2_ALG_SHA1,
> > > > > > > > > -       ,
> > > > > > > > > -       TPM2_ALG_SHA384,
> > > > > > > > > -       TPM2_ALG_SHA512,
> > > > > > > > > -};
> > > > >
> > > > > The current tpm2_algorithm_to_mask() operates on those values and=
 bits
> > > > > shifts based on the enum. Since you remove the enum above, you mu=
st
> > > > > also change the function implementation and return
> > > > > hash_algo_list.hash_mask
> > > > >
> > > >
> > > > That's already taken care of as the calls to tpm2_algorithm_to_mask=
()
> > > > in my patch were adjusted from:
> > > > tpm2_algorithm_to_mask(tpm2_supported_algorithms[i])
> > > > to
> > > > tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg)
> > > >
> > > > The hash_alg is the value from the previous enum.
> > >
> > > The previous enums were defining TPM2_ALG_SHA1=3D1, TPM2_ALG_SHA256=
=3D2 etc
> > > The current values are different. On top of that the .hash_mask  entr=
y
> > > of digest_info is never used. So you need to change
> > > tpm2_algorithm_to_mask() and directly return the hash_mask
> > >
> >
> > Hi Ilias,
> >
> > Just getting back to this. I don't agree with your assessment.
> >
> > The previous enum:
> > -const enum tpm2_algorithms tpm2_supported_algorithms[4] =3D {
> > -       TPM2_ALG_SHA1,
> > -       TPM2_ALG_SHA256,
> > -       TPM2_ALG_SHA384,
> > -       TPM2_ALG_SHA512,
> > -};
> >
> > is defining 4 values which equate to 0x04, 0x0B, 0x0C, 0x0D (not 1, 2,
> > 3, 4 as you say) which is what I'm putting in the hash_alg field. The
> > tpm2_algorithm_to_mask macro shifts those values (not the index into
> > the enum).
> >
> > So with the current code:
> > for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
> >         int alg =3D tpm2_supported_algorithms[i];
> >         printf("alg:0x%02x mask=3D0x%02x\n", alg, tpm2_algorithm_to_mas=
k(alg));
> > }
> > alg:0x04 mask=3D0x10
> > alg:0x0b mask=3D0x800
> > alg:0x0c mask=3D0x1000
> > alg:0x0d mask=3D0x2000
> >
> > With this proposed patch:
> > for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> >         int alg =3D hash_algo_list[i].hash_alg;
> >         printf("alg:0x%02x mask=3D0x%02x %s\n", alg,
> > tpm2_algorithm_to_mask(alg), tpm2_algorithm_name(alg));
> > }
> > alg:0x04 mask=3D0x10 sha1
> > alg:0x0b mask=3D0x800 sha256
> > alg:0x0c mask=3D0x1000 sha384
> > alg:0x0d mask=3D0x2000 sha512
> >
> > Am I misunderstanding something else you are pointing out?
> >
> > Maybe it would be easier to compare if I named the new struct
> > tpm2_supported_algorithms?
>
> Ok, I think we are looking at a preexisting bug, because the prints
> above make no sense to me.
>
> There was an enum in the current code
> const enum tpm2_algorithms tpm2_supported_algorithms[4] =3D {
>        TPM2_ALG_SHA1,
>        TPM2_ALG_SHA256,
>        TPM2_ALG_SHA384,
>        TPM2_ALG_SHA512,
> }
> But those values are defined in include/tpm-v2.h hence the enum values
> were not starting from 0...
>
> Reading at the TCG spec [0] we should be adding any of the values
> defined below to HashAlgorithmBitMap.
> #define EFI_TCG2_BOOT_HASH_ALG_SHA1 0x00000001
> #define EFI_TCG2_BOOT_HASH_ALG_SHA256 0x00000002
> #define EFI_TCG2_BOOT_HASH_ALG_SHA384 0x00000004
> #define EFI_TCG2_BOOT_HASH_ALG_SHA512 0x00000008
> #define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
>
> We used to do that in v2023.01. The patch below is on top of 2023.01
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index a525ebf75b58..7371c9e94b5c 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -1628,6 +1628,7 @@ static efi_status_t create_specid_event(struct
> udevice *dev, void *buffer,
>                 u16 hash_alg =3D hash_algo_list[i].hash_alg;
>                 u16 hash_len =3D hash_algo_list[i].hash_len;
>
> +               printf("Trying to add %08x and %08x\n", hash_alg,
> alg_to_mask(hash_alg));
>                 if (active & alg_to_mask(hash_alg)) {
>                         put_unaligned_le16(hash_alg,
>
> &spec_event->digest_sizes[alg_count].algorithm_id);
>
> prints
>
> Trying to add 00000004 and 00000001
> Trying to add 0000000b and 00000002
> Trying to add 0000000c and 00000004
> Trying to add 0000000d and 00000008
>
> The values of 0x00000001, 0x00000002 etc are what's added to the eventlog
>
> But since 97707f12fdabf we are putting different values (which I think
> is wrong and not what the spec expects....)
> I also think Eddie intended to make tpm2_supported_algorithms an enum
> that starts from 0, but the values he used were already defined and
> that's how we missed it ...
>
> Eddie any idea if that's what happened?
>
> Tim, we will need to fix all this regardless.  The fix should be
> relatively simple, just return the newly added values instead of the
> algorithm_to_mask value, when adding it on the eventlog.
> Can you take a look at the spec and verify what I am seeing? At some
> point, we also need to add the value checking in self-tests, rather
> than only looking at the EFI return code.

Apologies for the noise, I wasn't remembering the spec properly.
The hash values are only supposed to be used on getting the capability
and active PCR banks.

Let me read this patch again

Thanks
/Ilias
>
>
> [0] 6.4.3 Related Definitions
> https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specifi=
cation-rev13-160330final.pdf
>
> Thanks
> /Ilias
>
>
>
> >
> > Best Regards,
> >
> > Tim
> >
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
> > > > >
> > > > >
> > > > > > > > > -
> > > > > > > > >  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *=
active_pcr_banks)
> > > > > > > > >  {
> > > > > > > > >         u32 supported =3D 0;
> > > > > > > > > @@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice=
 *dev, const u8 *input, u32 length,
> > > > > > > > >                 return rc;
> > > > > > > > >
> > > > > > > > >         digest_list->count =3D 0;
> > > > > > > > > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algor=
ithms); ++i) {
> > > > > > > > > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i=
) {
> > > > > > > > >                 u32 mask =3D
> > > > > > > > > -                       tpm2_algorithm_to_mask(tpm2_suppo=
rted_algorithms[i]);
> > > > > > > > > +                       tpm2_algorithm_to_mask(hash_algo_=
list[i].hash_alg);
> > > > > > > > >
> > > > > > > > >                 if (!(active & mask))
