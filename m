Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68881C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 06:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FD688222;
	Fri, 29 Mar 2024 07:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nuUCcudv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A4288229; Fri, 29 Mar 2024 07:18:57 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB9488220
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 07:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d48f03a8bbso23422631fa.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711693134; x=1712297934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ITW4x5gArD+L+hhaTyyxIf7TL4gyCi9YmYBHEJn14KQ=;
 b=nuUCcudvIiwSkJU99tVXjHquUw7Y2MGdCiPSgCbRJu+sJwy1HxR8L0Zzp9vQbiJZ0n
 a4ELmgNWdatwCVpO6Qp22mx0E93sTEEqYnOxwqMQwOe8J703fOJ6+JbzrIll/GWmfR3p
 /Wcb+vY5DKgrwFrByNgxURQ27oRaL9rLqx/Sv4YmVUxhxV7gFqv9fIPA1Q9feDSnaF5n
 rcCmuIhwOC3i/e1VzyMPFWCOjR83aR6a0Y9jeDQkH5Q+7HDWIRPjQ1rtgcc1lqFS0kS1
 1p9KOHzKprtJtxBCHE/+WnTZDlBaGvmcxXs5sW/ZO16W5C4KR7vZh2iRsKLCH6cC8GVy
 Uq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711693134; x=1712297934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITW4x5gArD+L+hhaTyyxIf7TL4gyCi9YmYBHEJn14KQ=;
 b=jjn/7NSDn/rfC7xlx8oOSloNOBO8S9kOW0dRUfIn+J4ttZzt7ke2aLM5VBxBeftbz4
 fIC3Lp6FfT7gc2lUw1u0sqhLxlxwucDn+dJdm8YHE8D0oftPTrjZ8Tb608u3yNnquCt3
 j1IBLW3BVlwAVMMlVQan08c5qULMAwT6jdabK3IdSF7a4nnQQMGk24wW9nEtryCjtHOH
 3vS41Ao/VHCmPlL0DbfZiqWUMnWwMGTTOJMgFm81ihyRV1YDXF+zzA6XdSXqBw07FAjy
 pZoPjbpkV84Wh0zPdreXTqs7KJtAZOfPjtyg3/f0PUH65Z2+FEw7+0hB88gqmYz5p2Sl
 fcfg==
X-Gm-Message-State: AOJu0YxUX2SMWacd02c+eXg031nsqHHPAfZ6dGoXw0mM91RVaiRiKHoG
 YPTcf9nRAcy1kW/lVC/N3ErxNcmSK0aXqTsWrwPXyZ5UGpvmkdDDLuVkR61YnqGFepsN3fLRlgz
 NF06eRB1R0xfJptfDtrpTMnsq4c3Kwrb166tMyg==
X-Google-Smtp-Source: AGHT+IEe30MyhPyC16+Dt9/b51n5bKtql4GwzDl8JWqO3ynRwiKLTdW92W3znj1iNMHBW8IIjP0gspAuKEVRae0gGzc=
X-Received: by 2002:a2e:7a0e:0:b0:2d6:fc27:2e9b with SMTP id
 v14-20020a2e7a0e000000b002d6fc272e9bmr1331120ljc.25.1711693134417; Thu, 28
 Mar 2024 23:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240328170110.1960631-1-tharvey@gateworks.com>
In-Reply-To: <20240328170110.1960631-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Mar 2024 08:18:18 +0200
Message-ID: <CAC_iWj+Vv9cxUvzbzm1iVitELYs-RNc25yEG6FMg5DGsb+h+vA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm-v2: allow algoirthm name to be configured for
 pcr_read and pcr_extend
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Eddie James <eajames@linux.ibm.com>,
 slee@gateworks.com
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

Hi Tim,

On Thu, 28 Mar 2024 at 19:01, Tim Harvey <tharvey@gateworks.com> wrote:
>
> For pcr_read and pcr_extend commands allow the digest algorithm to be
> specified by an additional argument. If not specified it will default to
> SHA256 for backwards compatibility.
>
> A follow-on to this could be to extend all PCR banks with the detected
> algo when the <digest_algo> argument is 'auto'.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>  - use tpm2_algorithm_to_len
>  - use enum tpm2_algorithms
>  - make function names and parameter names more consistent with existing
>    tpm-v2 functions
>  - fix various spelling errors
> ---
>  cmd/tpm-v2.c     | 49 ++++++++++++++++++++++++++++++++++--------------
>  include/tpm-v2.h | 18 ++++++++++++++++++
>  lib/tpm-v2.c     | 34 +++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 14 deletions(-)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index 7e479b9dfe36..2343b4d9cb9e 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -99,11 +99,19 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
>         struct tpm_chip_priv *priv;
>         u32 index = simple_strtoul(argv[1], NULL, 0);
>         void *digest = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> +       int algo = TPM2_ALG_SHA256;
> +       int algo_len;
>         int ret;
>         u32 rc;
>
> -       if (argc != 3)
> +       if (argc < 3 || argc > 4)
>                 return CMD_RET_USAGE;
> +       if (argc == 4) {
> +               algo = tpm2_name_to_algorithm(argv[3]);
> +               if (algo < 0)
> +                       return CMD_RET_FAILURE;
> +       }
> +       algo_len = tpm2_algorithm_to_len(algo);
>
>         ret = get_tpm(&dev);
>         if (ret)
> @@ -116,8 +124,12 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
>         if (index >= priv->pcr_count)
>                 return -EINVAL;
>
> -       rc = tpm2_pcr_extend(dev, index, TPM2_ALG_SHA256, digest,
> -                            TPM2_DIGEST_LEN);
> +       rc = tpm2_pcr_extend(dev, index, algo, digest, algo_len);
> +       if (!rc) {
> +               printf("PCR #%u extended with %d byte %s digest\n", index,
> +                      algo_len, tpm2_algorithm_name(algo));
> +               print_byte_string(digest, algo_len);
> +       }
>
>         unmap_sysmem(digest);
>
> @@ -127,15 +139,23 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
>  static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>                            char *const argv[])
>  {
> +       enum tpm2_algorithms algo = TPM2_ALG_SHA256;
>         struct udevice *dev;
>         struct tpm_chip_priv *priv;
>         u32 index, rc;
> +       int algo_len;
>         unsigned int updates;
>         void *data;
>         int ret;
>
> -       if (argc != 3)
> +       if (argc < 3 || argc > 4)
>                 return CMD_RET_USAGE;
> +       if (argc == 4) {
> +               algo = tpm2_name_to_algorithm(argv[3]);
> +               if (algo < 0)
> +                       return CMD_RET_FAILURE;
> +       }
> +       algo_len = tpm2_algorithm_to_len(algo);
>
>         ret = get_tpm(&dev);
>         if (ret)
> @@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>
>         data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
>
> -       rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_ALG_SHA256,
> -                          data, TPM2_DIGEST_LEN, &updates);
> +       rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> +                          data, algo_len, &updates);
>         if (!rc) {
> -               printf("PCR #%u content (%u known updates):\n", index, updates);
> -               print_byte_string(data, TPM2_DIGEST_LEN);
> +               printf("PCR #%u %s %d byte content (%u known updates):\n", index,
> +                      tpm2_algorithm_name(algo), algo_len, updates);
> +               print_byte_string(data, algo_len);
>         }
>
>         unmap_sysmem(data);
> @@ -415,14 +436,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "    <hierarchy> is one of:\n"
>  "        * TPM2_RH_LOCKOUT\n"
>  "        * TPM2_RH_PLATFORM\n"
> -"pcr_extend <pcr> <digest_addr>\n"
> -"    Extend PCR #<pcr> with digest at <digest_addr>.\n"
> +"pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
> +"    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\n"
>  "    <pcr>: index of the PCR\n"
> -"    <digest_addr>: address of a 32-byte SHA256 digest\n"
> -"pcr_read <pcr> <digest_addr>\n"
> -"    Read PCR #<pcr> to memory address <digest_addr>.\n"
> +"    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
> +"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> +"    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo>.\n"
>  "    <pcr>: index of the PCR\n"
> -"    <digest_addr>: address to store the a 32-byte SHA256 digest\n"
> +"    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
>  "get_capability <capability> <property> <addr> <count>\n"
>  "    Read and display <count> entries indexed by <capability>/<property>.\n"
>  "    Values are 4 bytes long and are written at <addr>.\n"
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 33dd103767c4..933882fcbf97 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -965,4 +965,22 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>   */
>  u32 tpm2_auto_start(struct udevice *dev);
>
> +/**
> + * tpm2_name_to_algorithm() - Return an algorithm id given a supported
> + *                           algorithm name
> + *
> + * @name: algorithm name
> + * Return: enum tpm2_algorithms or -EINVAL
> + */
> +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
> +
> +/**
> + * tpm2_algorithm_name() - Return an algorithm name string for a
> + *                        supported algorithm id
> + *
> + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> + * Return: algorithm name string or ""
> + */
> +const char *tpm2_algorithm_name(enum tpm2_algorithms);
> +
>  #endif /* __TPM_V2_H */
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 68eaaa639f89..19b2535682e1 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -29,6 +29,13 @@ const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
>         TPM2_ALG_SHA512,
>  };
>
> +const char *tpm2_supported_algorithm_names[4] = {
> +       "sha1",
> +       "sha256",
> +       "sha384",
> +       "sha512",
> +};
> +

Overall this looks correct(but we don't need the [4] in the definition
tbh). However, keeping the info in 2 different places is not ideal.
We used to have a nice struct array that had all the info tightly together [0].

The struct looked like

struct digest_info {
u16 hash_alg;
u32 hash_mask;
u16 hash_len;
};

static const struct digest_info hash_algo_list[] = {
{
TPM2_ALG_SHA1,
EFI_TCG2_BOOT_HASH_ALG_SHA1,
TPM2_SHA1_DIGEST_SIZE,
},
{
TPM2_ALG_SHA256,
EFI_TCG2_BOOT_HASH_ALG_SHA256,
TPM2_SHA256_DIGEST_SIZE,
},
{
TPM2_ALG_SHA384,
EFI_TCG2_BOOT_HASH_ALG_SHA384,
TPM2_SHA384_DIGEST_SIZE,
},
{
TPM2_ALG_SHA512,
EFI_TCG2_BOOT_HASH_ALG_SHA512,
TPM2_SHA512_DIGEST_SIZE,
},
};

In short, we need to
- define the algorithm registry as defined by the TCG spec
  /* Algorithm Registry */
  #define EFI_TCG2_BOOT_HASH_ALG_SHA1    0x00000001
  #define EFI_TCG2_BOOT_HASH_ALG_SHA256  0x00000002
  #define EFI_TCG2_BOOT_HASH_ALG_SHA384  0x00000004
  #define EFI_TCG2_BOOT_HASH_ALG_SHA512  0x00000008
  #define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010

- Bring back the functions that exist in that branch. Pre 2023.07 all
measured boot code lived in lib/efi_loader/efi_tcg.c, so we just need
to copy them over
- Add a new struct member with the name and a new function to retrieve it.

[0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/blob/v2022.01-rc3/lib/efi_loader/efi_tcg2.c?ref_type=tags#L75

I understand that's more than what your patch tries to achieve here. I
am fine pulling this as-is and you/I can fix it up later unless you
don't mind doing it in a v3.

Thanks
/Ilias
>  int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
>  {
>         u32 supported = 0;
> @@ -1555,3 +1562,30 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>
>         return 0;
>  }
> +
> +enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
> +{
> +       enum tpm2_algorithms algo;
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> +               algo = tpm2_supported_algorithms[i];
> +               if (!strcasecmp(name, tpm2_supported_algorithm_names[i]))
> +                       return algo;
> +       }
> +       printf("%s: unsupported algorithm %s\n", __func__, name);
> +
> +       return -EINVAL;
> +}
> +
> +const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
> +               if (tpm2_supported_algorithms[i] == algo)
> +                       return tpm2_supported_algorithm_names[i];
> +       }
> +
> +       return "";
> +}
> --
> 2.25.1
>
