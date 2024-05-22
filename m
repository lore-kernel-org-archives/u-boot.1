Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E741FC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643B887F5C;
	Wed, 22 May 2024 12:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="df6j42JM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCE087F41; Wed, 22 May 2024 12:34:45 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E14087E9B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51f2ebbd8a7so7810042e87.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716374082; x=1716978882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=26QHWheCvCVbFppCw7jgEqB2b/msYtdvWvSFfQB2RpU=;
 b=df6j42JMPmLfzrmiDjoAoWr7ws9qahO7o8sYsumgB4kM4alSoK0JzGaIv14k6RwvGJ
 Ze2tJwqe94pLvmnJWrtc84vHIwxgyKxj+LPXnZbPMmDa+c7xV1DXC5LJolib/RTLzTSv
 dKP182i2J4DGQ3o9EqXP4LtKZbxTMsOBDiuOzN5NbRqA/XEpORL/psrdDW3u3aQh68vf
 GAtkFIFLO/rO3ooBP+KnMR+cZEl/qsd7dMCu2BVLdznfzUrvUGr7pZt2JilByln0IOlG
 bhotZMFJT4f1djd/uSS6Xuj9GmHBJEd8W9bvh7QAsBx/OyLB5HLkziKD9NVeGfqh+/tv
 uOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374082; x=1716978882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26QHWheCvCVbFppCw7jgEqB2b/msYtdvWvSFfQB2RpU=;
 b=WKS7Q9zrl7pKIJPjmVpYtKuBaOzgTfbSlKptxSkMrdJbl9cMflMsZpBYA3KwARqbWp
 49tFQmY971GZFHPXviu1h3aBmSJSUOPRY8pCbHPGNlz3QlJrStctlJ8lLUfWUk27FCzh
 bIN7B0oEU1uoWWzscmZuveMzC+/+ZcbBoDWDZMyy3wRbSd04JgGHynvO1bRd4CBuoo5M
 ShP9OPsgmgUBS3mI+c25d541jnzSOGwo3auJfdv4FE64bmKnPmrwXsjBAJkuF7CjjgLR
 iLVzSUqYCfJ2ITtPoKa9QrKCMRPkMCAD9e7RA+1K78arMlIFGjF4ezlqpaVTui9ir6Dh
 cIcA==
X-Gm-Message-State: AOJu0YzsE7II2DAjwD60zH9tFmaQ2RUWXNLFHkOaTOdsU8zKIDhcgQRZ
 SKBRNLPBgMnxojjljf7gOnC6ZidtAlq+KhSCa8YuFTDtQmAUlpcfNNtTSvW/TC5T1frxqdv/t8j
 GcMPV4wk7J05WDx5wsFH62aUd6rUHLdWU1FbGNQ==
X-Google-Smtp-Source: AGHT+IEv14A4Dr/RsUB/cmoxww5/qQ77Xe3k3YY6119PoFwOtNMk6qGbchtPkxUrHjIOczJfMa196Bst1zOCYsJEkbk=
X-Received: by 2002:a05:6512:1583:b0:51f:5d0a:d71a with SMTP id
 2adb3069b0e04-526bd694ab4mr1014933e87.10.1716374082384; Wed, 22 May 2024
 03:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240521213842.3587607-1-tharvey@gateworks.com>
 <20240521213842.3587607-2-tharvey@gateworks.com>
In-Reply-To: <20240521213842.3587607-2-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 May 2024 13:34:06 +0300
Message-ID: <CAC_iWjKFt4PbBzoqCLM4pwz8KYHgLQLR4R6kF+jc+_dsYsSZmw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] tpm-v2: allow algoirthm name to be configured for
 pcr_read and pcr_extend
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
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


Minor typo on the commit message. Since there's a small change in
patch #1 please fix this as well

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On Wed, 22 May 2024 at 00:38, Tim Harvey <tharvey@gateworks.com> wrote:
>
> For pcr_read and pcr_extend commands allow the digest algorithm to be
> specified by an additional argument. If not specified it will default to
> SHA256 for backwards compatibility.
>
> Additionally update test_tpm2.py for the changes in output in pcr_read
> which now shows the algo and algo length in the output.
>
> A follow-on to this could be to extend all PCR banks with the detected
> algo when the <digest_algo> argument is 'auto'.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v4:
>  - update test_tpm2.py as required by changes in pcr_read output
>  - split out moving algos to an array of structs to its own patch
>    and encorporate a fix for tpm2_algorithm_to_mask
> v3:
>  - replace tpm2_supported_algorithms with struct and use this to
>    relate hash algoirthm details
> v2:
>  - use tpm2_algorithm_to_len
>  - use enum tpm2_algorithms
>  - make function names and parameter names more consistent with existing
>    tpm-v2 functions
>  - fix various spelling errors
> ---
>  cmd/tpm-v2.c               | 49 +++++++++++++++++++++++++++-----------
>  test/py/tests/test_tpm2.py |  2 +-
>  2 files changed, 36 insertions(+), 15 deletions(-)
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
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index 1d654cd4a23b..75f5d31fc675 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -257,7 +257,7 @@ def test_tpm2_pcr_read(u_boot_console):
>      updates = int(re.findall(r'\d+', str)[0])
>
>      # Check the output value
> -    assert 'PCR #10 content' in read_pcr
> +    assert 'PCR #10 sha256 32 byte content' in read_pcr
>      assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
>
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
> --
> 2.25.1
>
