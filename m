Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23F9C04FF6
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 17:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692A1887FE;
	Fri, 19 Apr 2024 19:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Y/lz2TOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432078880B; Fri, 19 Apr 2024 19:13:47 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465A1887F3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 19:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so254462266b.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713546823; x=1714151623; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsQEIo66Y8F24iIrulZCF8kZM/nLnYKu1AKuqIl3vn8=;
 b=Y/lz2TOxo6NepspYqsRQXUzd/4ZxxybsWqk/ldxF+kpB2+miggUCFcRtMxVrIuMh5A
 Tm9crjN5vauDWqpunGlIZqWQiRd9I52KW/qDynWY5y5Z0Pfquezl39/jPpvT6Sw7tNsW
 F89VJ8L2S6MWJ1fk9I/W77n894tstoV52Io8oQmKbgAuEIPFua9tlEBQ5qBKA8d025v4
 GGwgN45uv5rj/zcvLPNWVVbDhjIucBcN3CR9VBZ6aoJhQfHuNxoX9wjbJ379y3yAYyC/
 OTu9f5vTOjKp0SMWjkpraWZ24ulYK4/LoQgykT5EPKPFwgWbAGI0FNN+7AiIMsZY4agi
 KT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713546823; x=1714151623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsQEIo66Y8F24iIrulZCF8kZM/nLnYKu1AKuqIl3vn8=;
 b=ZvL1RGQPvpi4mxfMre7UjpE5x1uIPyvJ7VtCEEZKMRwTacEyBinXA/2qpzPi577DY5
 hlr1rUWM3tMWSvBocN4vtqumQGHooBifYcEObKc7KnV0PRR4cy4YNWSP2QUJXySxmDxu
 fGLzGM/w4ALUf1jYfi4Q+u6whTuKuKXZqxMZV/Bhg5BgL89spbWcYYaRdRmml4whzh09
 OD0sc0vIxZRA/CNImMBdfOnI9+ToqHyn+KdJv983ZuJ7D9IaQOTn6B0vgaa4ellIKpzo
 VjqlI0WUb0JjTS29/nVRlmpnoaq+BxxKeUtrgZdGAaIwmY7g7qnYjEof1c8BAboViHz0
 2+Rw==
X-Gm-Message-State: AOJu0YydhUEJ4psQJU66Pd7x2ujw7S9CFncb9ftCByB6A/knXws/FFz1
 /MwovmxSYFyfQ2qZg9UryLEZHfv+fgpaAcLihbgdsketLG1W/dqVmforIXRssWn+4G0V0DQncqE
 mtIZtoc5V1koErMyzy71/N5BuTVVcnrN/cVdW9w==
X-Google-Smtp-Source: AGHT+IEEQaNPuJbrJhAyAfq6daMpwzXpLaL+ysL8KrhGIFyhhghqfe28DQoDwvzFFT15L/k4rfw+gAgHxHOYLXTz528=
X-Received: by 2002:a17:906:c242:b0:a55:61cf:f859 with SMTP id
 bl2-20020a170906c24200b00a5561cff859mr1766214ejb.1.1713546823312; Fri, 19 Apr
 2024 10:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240405001722.2876240-1-tharvey@gateworks.com>
 <CAC_iWjL7nHxq7Yio6XqenxrMwfVBC-VK3UCDLX=4oNQWvcfTBQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL7nHxq7Yio6XqenxrMwfVBC-VK3UCDLX=4oNQWvcfTBQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 19 Apr 2024 10:13:31 -0700
Message-ID: <CAJ+vNU1H4GZ7Nq1MEcqWgSkZjPo9u-TDRVapLnn5Kq+3TyD-bA@mail.gmail.com>
Subject: Re: [PATCH v3] tpm-v2: allow algoirthm name to be configured for
 pcr_read and pcr_extend
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sat, Apr 6, 2024 at 9:33=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> Thanks for the patch
>
> I'll be away next week, I'll try to find time and take a closer look.
> The pipeline [0] shows some TPM related failures
>
> [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/9b4be64e=
41454e17269a968397933eeff300c380
>

Hi Ilias,

I changed the output of 'tpm pcr_read' so that it shows the algo and
size causing the test in test/py/tests/test_tpm2.py to fail:
@@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl
*cmdtp, int flag, int argc,

        data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);

-       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_ALG_SHA=
256,
-                          data, TPM2_DIGEST_LEN, &updates);
+       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
+                          data, algo_len, &updates);
        if (!rc) {
-               printf("PCR #%u content (%u known updates):\n", index, upda=
tes);
-               print_byte_string(data, TPM2_DIGEST_LEN);
+               printf("PCR #%u %s %d byte content (%u known
updates):\n", index,
+                      tpm2_algorithm_name(algo), algo_len, updates);
+               print_byte_string(data, algo_len);
        }

failure:
E   AssertionError: assert 'PCR #10 content' in 'PCR #10 sha256 32
byte content (723 known updates):\r\r\n 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00\r\r\n 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00'

So I suppose I need to update test/py/tests/test_tpm2.py as well.

Would I update test/py/tests/test_tpm2.py in the same patch as the one
that causes the failure?

How do I go about running the tests manually to make sure I've addressed it=
?

Best Regards,

Tim

> Cheers
> /Ilias
>
> On Fri, 5 Apr 2024 at 03:17, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > For pcr_read and pcr_extend commands allow the digest algorithm to be
> > specified by an additional argument. If not specified it will default t=
o
> > SHA256 for backwards compatibility.
> >
> > A follow-on to this could be to extend all PCR banks with the detected
> > algo when the <digest_algo> argument is 'auto'.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v3:
> >  - replace tpm2_supported_algorithms with struct and use this to relate=
 hash algoirthm
> >    details
> > v2:
> >  - use tpm2_algorithm_to_len
> >  - use enum tpm2_algorithms
> >  - make function names and parameter names more consistent with existin=
g
> >    tpm-v2 functions
> >  - fix various spelling errors
> > ---
> >  cmd/tpm-v2.c              | 49 ++++++++++++++++++++--------
> >  include/tpm-v2.h          | 67 ++++++++++++++++++++++++++++++++++++++-
> >  lib/efi_loader/efi_tcg2.c |  4 +--
> >  lib/tpm-v2.c              | 62 +++++++++++++++++++++++-------------
> >  4 files changed, 143 insertions(+), 39 deletions(-)
> >
> > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> > index 7e479b9dfe36..2343b4d9cb9e 100644
> > --- a/cmd/tpm-v2.c
> > +++ b/cmd/tpm-v2.c
> > @@ -99,11 +99,19 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp=
, int flag, int argc,
> >         struct tpm_chip_priv *priv;
> >         u32 index =3D simple_strtoul(argv[1], NULL, 0);
> >         void *digest =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0=
);
> > +       int algo =3D TPM2_ALG_SHA256;
> > +       int algo_len;
> >         int ret;
> >         u32 rc;
> >
> > -       if (argc !=3D 3)
> > +       if (argc < 3 || argc > 4)
> >                 return CMD_RET_USAGE;
> > +       if (argc =3D=3D 4) {
> > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > +               if (algo < 0)
> > +                       return CMD_RET_FAILURE;
> > +       }
> > +       algo_len =3D tpm2_algorithm_to_len(algo);
> >
> >         ret =3D get_tpm(&dev);
> >         if (ret)
> > @@ -116,8 +124,12 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdt=
p, int flag, int argc,
> >         if (index >=3D priv->pcr_count)
> >                 return -EINVAL;
> >
> > -       rc =3D tpm2_pcr_extend(dev, index, TPM2_ALG_SHA256, digest,
> > -                            TPM2_DIGEST_LEN);
> > +       rc =3D tpm2_pcr_extend(dev, index, algo, digest, algo_len);
> > +       if (!rc) {
> > +               printf("PCR #%u extended with %d byte %s digest\n", ind=
ex,
> > +                      algo_len, tpm2_algorithm_name(algo));
> > +               print_byte_string(digest, algo_len);
> > +       }
> >
> >         unmap_sysmem(digest);
> >
> > @@ -127,15 +139,23 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmd=
tp, int flag, int argc,
> >  static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
> >                            char *const argv[])
> >  {
> > +       enum tpm2_algorithms algo =3D TPM2_ALG_SHA256;
> >         struct udevice *dev;
> >         struct tpm_chip_priv *priv;
> >         u32 index, rc;
> > +       int algo_len;
> >         unsigned int updates;
> >         void *data;
> >         int ret;
> >
> > -       if (argc !=3D 3)
> > +       if (argc < 3 || argc > 4)
> >                 return CMD_RET_USAGE;
> > +       if (argc =3D=3D 4) {
> > +               algo =3D tpm2_name_to_algorithm(argv[3]);
> > +               if (algo < 0)
> > +                       return CMD_RET_FAILURE;
> > +       }
> > +       algo_len =3D tpm2_algorithm_to_len(algo);
> >
> >         ret =3D get_tpm(&dev);
> >         if (ret)
> > @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp,=
 int flag, int argc,
> >
> >         data =3D map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> >
> > -       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_ALG=
_SHA256,
> > -                          data, TPM2_DIGEST_LEN, &updates);
> > +       rc =3D tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> > +                          data, algo_len, &updates);
> >         if (!rc) {
> > -               printf("PCR #%u content (%u known updates):\n", index, =
updates);
> > -               print_byte_string(data, TPM2_DIGEST_LEN);
> > +               printf("PCR #%u %s %d byte content (%u known updates):\=
n", index,
> > +                      tpm2_algorithm_name(algo), algo_len, updates);
> > +               print_byte_string(data, algo_len);
> >         }
> >
> >         unmap_sysmem(data);
> > @@ -415,14 +436,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "=
Issue a TPMv2.x command",
> >  "    <hierarchy> is one of:\n"
> >  "        * TPM2_RH_LOCKOUT\n"
> >  "        * TPM2_RH_PLATFORM\n"
> > -"pcr_extend <pcr> <digest_addr>\n"
> > -"    Extend PCR #<pcr> with digest at <digest_addr>.\n"
> > +"pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
> > +"    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\=
n"
> >  "    <pcr>: index of the PCR\n"
> > -"    <digest_addr>: address of a 32-byte SHA256 digest\n"
> > -"pcr_read <pcr> <digest_addr>\n"
> > -"    Read PCR #<pcr> to memory address <digest_addr>.\n"
> > +"    <digest_addr>: address of digest of digest_algo type (defaults to=
 SHA256)\n"
> > +"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> > +"    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo=
>.\n"
> >  "    <pcr>: index of the PCR\n"
> > -"    <digest_addr>: address to store the a 32-byte SHA256 digest\n"
> > +"    <digest_addr>: address of digest of digest_algo type (defaults to=
 SHA256)\n"
> >  "get_capability <capability> <property> <addr> <count>\n"
> >  "    Read and display <count> entries indexed by <capability>/<propert=
y>.\n"
> >  "    Values are 4 bytes long and are written at <addr>.\n"
> > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > index 33dd103767c4..263f9529e55d 100644
> > --- a/include/tpm-v2.h
> > +++ b/include/tpm-v2.h
> > @@ -386,7 +386,54 @@ enum tpm2_algorithms {
> >         TPM2_ALG_SM3_256        =3D 0x12,
> >  };
> >
> > -extern const enum tpm2_algorithms tpm2_supported_algorithms[4];
> > +/**
> > + * struct digest_info - details of supported digests
> > + *
> > + * @hash_name:                 hash name
> > + * @hash_alg:                  hash algorithm id
> > + * @hash_mask:                 hash registry mask
> > + * @hash_len:                  hash digest length
> > + */
> > +struct digest_info {
> > +       const char *hash_name;
> > +       u16 hash_alg;
> > +       u32 hash_mask;
> > +       u16 hash_len;
> > +};
> > +
> > +/* Algorithm Registry */
> > +#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> > +#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> > +#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> > +#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> > +#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > +
> > +static const struct digest_info hash_algo_list[] =3D {
> > +       {
> > +               "sha1",
> > +               TPM2_ALG_SHA1,
> > +               TCG2_BOOT_HASH_ALG_SHA1,
> > +               TPM2_SHA1_DIGEST_SIZE,
> > +       },
> > +       {
> > +               "sha256",
> > +               TPM2_ALG_SHA256,
> > +               TCG2_BOOT_HASH_ALG_SHA256,
> > +               TPM2_SHA256_DIGEST_SIZE,
> > +       },
> > +       {
> > +               "sha384",
> > +               TPM2_ALG_SHA384,
> > +               TCG2_BOOT_HASH_ALG_SHA384,
> > +               TPM2_SHA384_DIGEST_SIZE,
> > +       },
> > +       {
> > +               "sha512",
> > +               TPM2_ALG_SHA512,
> > +               TCG2_BOOT_HASH_ALG_SHA512,
> > +               TPM2_SHA512_DIGEST_SIZE,
> > +       },
> > +};
> >
> >  static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
> >  {
> > @@ -965,4 +1012,22 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, ui=
nt vendor_cmd,
> >   */
> >  u32 tpm2_auto_start(struct udevice *dev);
> >
> > +/**
> > + * tpm2_name_to_algorithm() - Return an algorithm id given a supported
> > + *                           algorithm name
> > + *
> > + * @name: algorithm name
> > + * Return: enum tpm2_algorithms or -EINVAL
> > + */
> > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> > +
> > +/**
> > + * tpm2_algorithm_name() - Return an algorithm name string for a
> > + *                        supported algorithm id
> > + *
> > + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> > + * Return: algorithm name string or ""
> > + */
> > +const char *tpm2_algorithm_name(enum tpm2_algorithms);
> > +
> >  #endif /* __TPM_V2_H */
> > diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> > index b07e0099c27e..cf5d8de018a7 100644
> > --- a/lib/efi_loader/efi_tcg2.c
> > +++ b/lib/efi_loader/efi_tcg2.c
> > @@ -414,8 +414,8 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u=
64 efi_size,
> >         }
> >
> >         digest_list->count =3D 0;
> > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
> > -               u16 hash_alg =3D tpm2_supported_algorithms[i];
> > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> > +               u16 hash_alg =3D hash_algo_list[i].hash_alg;
> >
> >                 if (!(active & tpm2_algorithm_to_mask(hash_alg)))
> >                         continue;
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 68eaaa639f89..83f490c82541 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -22,13 +22,6 @@
> >
> >  #include "tpm-utils.h"
> >
> > -const enum tpm2_algorithms tpm2_supported_algorithms[4] =3D {
> > -       TPM2_ALG_SHA1,
> > -       TPM2_ALG_SHA256,
> > -       TPM2_ALG_SHA384,
> > -       TPM2_ALG_SHA512,
> > -};
> > -
> >  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_ban=
ks)
> >  {
> >         u32 supported =3D 0;
> > @@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice *dev, const u=
8 *input, u32 length,
> >                 return rc;
> >
> >         digest_list->count =3D 0;
> > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> >                 u32 mask =3D
> > -                       tpm2_algorithm_to_mask(tpm2_supported_algorithm=
s[i]);
> > +                       tpm2_algorithm_to_mask(hash_algo_list[i].hash_a=
lg);
> >
> >                 if (!(active & mask))
> >                         continue;
> >
> > -               switch (tpm2_supported_algorithms[i]) {
> > +               switch (hash_algo_list[i].hash_alg) {
> >                 case TPM2_ALG_SHA1:
> >                         sha1_starts(&ctx);
> >                         sha1_update(&ctx, input, length);
> > @@ -116,12 +109,12 @@ int tcg2_create_digest(struct udevice *dev, const=
 u8 *input, u32 length,
> >                         break;
> >                 default:
> >                         printf("%s: unsupported algorithm %x\n", __func=
__,
> > -                              tpm2_supported_algorithms[i]);
> > +                              hash_algo_list[i].hash_alg);
> >                         continue;
> >                 }
> >
> >                 digest_list->digests[digest_list->count].hash_alg =3D
> > -                       tpm2_supported_algorithms[i];
> > +                       hash_algo_list[i].hash_alg;
> >                 memcpy(&digest_list->digests[digest_list->count].digest=
, final,
> >                        len);
> >                 digest_list->count++;
> > @@ -208,13 +201,13 @@ static int tcg2_log_init(struct udevice *dev, str=
uct tcg2_event_log *elog)
> >                 return rc;
> >
> >         event_size =3D offsetof(struct tcg_efi_spec_id_event, digest_si=
zes);
> > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> > -               mask =3D tpm2_algorithm_to_mask(tpm2_supported_algorith=
ms[i]);
> > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > +               mask =3D tpm2_algorithm_to_mask(hash_algo_list[i].hash_=
alg);
> >
> >                 if (!(active & mask))
> >                         continue;
> >
> > -               switch (tpm2_supported_algorithms[i]) {
> > +               switch (hash_algo_list[i].hash_alg) {
> >                 case TPM2_ALG_SHA1:
> >                 case TPM2_ALG_SHA256:
> >                 case TPM2_ALG_SHA384:
> > @@ -253,17 +246,17 @@ static int tcg2_log_init(struct udevice *dev, str=
uct tcg2_event_log *elog)
> >         put_unaligned_le32(count, &ev->number_of_algorithms);
> >
> >         count =3D 0;
> > -       for (i =3D 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> > -               mask =3D tpm2_algorithm_to_mask(tpm2_supported_algorith=
ms[i]);
> > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > +               mask =3D tpm2_algorithm_to_mask(hash_algo_list[i].hash_=
alg);
> >
> >                 if (!(active & mask))
> >                         continue;
> >
> > -               len =3D tpm2_algorithm_to_len(tpm2_supported_algorithms=
[i]);
> > +               len =3D hash_algo_list[i].hash_len;
> >                 if (!len)
> >                         continue;
> >
> > -               put_unaligned_le16(tpm2_supported_algorithms[i],
> > +               put_unaligned_le16(hash_algo_list[i].hash_alg,
> >                                    &ev->digest_sizes[count].algorithm_i=
d);
> >                 put_unaligned_le16(len, &ev->digest_sizes[count].digest=
_size);
> >                 count++;
> > @@ -304,7 +297,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_l=
og *elog,
> >                 pos =3D offsetof(struct tcg_pcr_event2, digests) +
> >                         offsetof(struct tpml_digest_values, count);
> >                 count =3D get_unaligned_le32(log + pos);
> > -               if (count > ARRAY_SIZE(tpm2_supported_algorithms) ||
> > +               if (count > ARRAY_SIZE(hash_algo_list) ||
> >                     (digest_list->count && digest_list->count !=3D coun=
t))
> >                         return 0;
> >
> > @@ -407,7 +400,7 @@ static int tcg2_log_parse(struct udevice *dev, stru=
ct tcg2_event_log *elog)
> >                 return 0;
> >
> >         count =3D get_unaligned_le32(&event->number_of_algorithms);
> > -       if (count > ARRAY_SIZE(tpm2_supported_algorithms))
> > +       if (count > ARRAY_SIZE(hash_algo_list))
> >                 return 0;
> >
> >         calc_size =3D offsetof(struct tcg_efi_spec_id_event, digest_siz=
es) +
> > @@ -1110,7 +1103,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *s=
upported_pcr, u32 *active_pcr,
> >          * We only support 5 algorithms for now so check against that
> >          * instead of TPM2_NUM_PCR_BANKS
> >          */
> > -       if (pcrs.count > ARRAY_SIZE(tpm2_supported_algorithms) ||
> > +       if (pcrs.count > ARRAY_SIZE(hash_algo_list) ||
> >             pcrs.count < 1) {
> >                 printf("%s: too many pcrs: %u\n", __func__, pcrs.count)=
;
> >                 return -EMSGSIZE;
> > @@ -1555,3 +1548,28 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, u=
int vendor_cmd,
> >
> >         return 0;
> >  }
> > +
> > +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
> > +{
> > +       size_t i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > +               if (!strcasecmp(name, hash_algo_list[i].hash_name))
> > +                       return hash_algo_list[i].hash_alg;
> > +       }
> > +       printf("%s: unsupported algorithm %s\n", __func__, name);
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
> > +{
> > +       size_t i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> > +               if (hash_algo_list[i].hash_alg =3D=3D algo)
> > +                       return hash_algo_list[i].hash_name;
> > +       }
> > +
> > +       return "";
> > +}
> > --
> > 2.25.1
> >
