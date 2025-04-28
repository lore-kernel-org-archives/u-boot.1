Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8030C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D44880EFB;
	Mon, 28 Apr 2025 12:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I+1Gvq1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE78820B7; Mon, 28 Apr 2025 12:03:29 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6223780EE5
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7080dd5f9f1so30949667b3.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745834605; x=1746439405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BpxzvIAukrFnPR+cLt047y0bLLahCFiOu2MIqAHl0F4=;
 b=I+1Gvq1jd9NJbSaP6dQCs4uJ6ARr9pnZ+86pFn17D09Kj3hdX5wpC3BUP3Z/20Ih4B
 OQGr+ZqZMpMt20vucSbQ8PrKX52EMIf8zTriPjLtRNtXcKHICMtZSo5xBulTbWeq99rM
 43kqaW8EQDPmTHROR/kwsoGxendr99KC6nGnwhi3COrI4t7ns7vIJIB19eSKGW5+hUjN
 3njrhBqC97jpHf47sxPByCScAAdkgadSiAiImSLidlX21t1E0iRjyH8S5JiuSzaecb7U
 GTgcFPTQJVvQilbdxKPBAv90UY/Ff7pmSt85B6PQ9TXeTYNmtIqzopNLrF7OW+oxcUb/
 QuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745834605; x=1746439405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BpxzvIAukrFnPR+cLt047y0bLLahCFiOu2MIqAHl0F4=;
 b=k1dDkhQbdRnIGgPEch8ZdO/EHsA6j6GlLka6gcngnmbyulGyk3SDquDgD9+IdUWJ/E
 ahRvf2OIKsRL2IddGvQ1KD6m8rBiYh/CGKEoRLy3eFrKwS1rALikWGTPDxVcRYQ8wqgR
 +pofQW9BjWkasOvEQ23kym96s6U7dDpgjLQes93W+sv3jr1g5HTgPQB6k3jdkb0SFL9E
 Sd3HRlkxUfT/+FEeeOEntaGuKdW+LGCtOZIXlbuoOcLmgxQD4ScDxeFkKWFmFjhXDTj2
 PZNwwMrMPW/NsT9tpeQyxJ1GunuFd7CSJxrpvsjhisYb9MgmyvKx/rZFVXzHVttwWaHs
 voag==
X-Gm-Message-State: AOJu0YxhtEulE6ZJ2TKVXHmALGlIugCkhFf7pA/jjnCncTQKiiH/QlTb
 GnTDjuvJGC6SbgonyAgtg9eJ/ANoSCC9pbXTd9tUeVnn+qEpPQQOvP6I4e29k21pPZ2Bt5rHIUr
 iI0oJNEAQReJNd96s0asDoUXOnWE4sjLSsFAUMg==
X-Gm-Gg: ASbGncvK/xs5ljqiZYKLL18FU+aRDB9vsF5f4dvNWvxyhI1rRco5GZQgXKkyvCNMRpP
 iAJ+7yeSRuAnQtVdnas/9bwkv0ZneeF5fR/6LSMUbrbwDdpQpLCsONw1sa5h8JQc0y48wMBl16R
 W1KOaFmH6XB6fG82YI1bwLBDQ=
X-Google-Smtp-Source: AGHT+IFc8wZEzC2d60GGSGpUba/lghQbOCnVJIs0SwEHlDn518WU1w/7rq8+2oomlmOJ8cT7cw3IkGM3g2usF0XySTA=
X-Received: by 2002:a05:690c:6b88:b0:703:b5ae:a3da with SMTP id
 00721157ae682-708541df751mr152426247b3.32.1745834605158; Mon, 28 Apr 2025
 03:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250422193657.512324-1-trini@konsulko.com>
In-Reply-To: <20250422193657.512324-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 28 Apr 2025 13:02:49 +0300
X-Gm-Features: ATxdqUGPdnt8C3LELo6YRp8y9L1pBK6rhXnO2_qb4-l52jmwy_XDa7_6rj-v5qQ
Message-ID: <CAC_iWjJRwbu0xJ=-+GmEvoxgzfm8HM0ydaGTY8D4-5Z7D-1gVw@mail.gmail.com>
Subject: Re: [PATCH] Docker,
 CI: Add vexpress_fvp / vexpress_fvp_bloblist support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Harrison Mutai <harrison.mutai@arm.com>,
 nd <nd@arm.com>, Manish Pandey <Manish.Pandey2@arm.com>
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

Thanks for doing this

On Tue, 22 Apr 2025 at 22:36, Tom Rini <trini@konsulko.com> wrote:
>
> This adds the vexpress_fvp and vexpress_fvp_bloblist platforms to the
> list of platforms we test via emulator in CI. In order to do this we
> need to first have our container runtime have TF-A builds for the
> vexpress_fvp platform, both with and without transfer list support as
> well as installing "telnet" so that we can access console. In the CI
> files we check for the existence of /opt/tf-a/${TEST_PY_BD} and if
> found, copy bl1.bin and fip.bin to /tmp and set the variables so that we
> can later run FVP to run.
>
> Note that we currently disable the hostfs (semihosting) tests as they
> trigger a bug in FVP. This has been reported upstream, and can be
> enabled when fixed.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Harrison Mutai <harrison.mutai@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: nd <nd@arm.com>
> Cc: Manish Pandey <Manish.Pandey2@arm.com>
> ---
>  .azure-pipelines.yml    | 13 +++++++++++++
>  .gitlab-ci.yml          | 23 +++++++++++++++++++++++
>  tools/docker/Dockerfile | 17 +++++++++++++----
>  3 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index cb787d32f142..0a9f7b508ddd 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -307,6 +307,13 @@ stages:
>                /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
>                /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
>            fi
> +          # If we have TF-A binaries, we need to use them.
> +          if [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
> +            cp /opt/tf-a/"\${TEST_PY_BD}"/fip.bin /opt/tf-a/"\${TEST_PY_BD}"/bl1.bin /tmp;
> +            export fip=/tmp/fip.bin;
> +            export bl1=/tmp/bl1.bin;
> +            export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:\${PATH};
> +          fi
>            export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
>            export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
>            # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
> @@ -428,6 +435,12 @@ stages:
>            TEST_PY_BD: "vexpress_ca9x4"
>            TEST_PY_ID: "--id qemu"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        vexpress_fvp:
> +          TEST_PY_BD: "vexpress_fvp"
> +          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
> +        vexpress_fvp_bloblist:
> +          TEST_PY_BD: "vexpress_fvp_bloblist"
> +          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
>          integratorcp_cm926ejs:
>            TEST_PY_BD: "integratorcp_cm926ejs"
>            TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5f3418e482fe..0268938fea99 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -96,6 +96,13 @@ stages:
>          /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
>          /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
>        fi
> +    # If we have TF-A binaries, we need to use them.
> +    - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> +        cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
> +        export fip=/tmp/fip.bin;
> +        export bl1=/tmp/bl1.bin;
> +        export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
> +      fi
>      # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
>      - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
>        export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
> @@ -504,6 +511,22 @@ sifive_unleashed_spi-nor test.py:
>      TEST_PY_ID: "--id spi-nor_qemu"
>    <<: *buildman_and_testpy_dfn
>
> +vexpress_fvp test.py:
> +  variables:
> +    TEST_PY_BD: "vexpress_fvp"
> +    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
> +  tags:
> +    - ${DEFAULT_AMD64_TAG}
> +  <<: *buildman_and_testpy_dfn
> +
> +vexpress_fvp_bloblist test.py:
> +  variables:
> +    TEST_PY_BD: "vexpress_fvp_bloblist"
> +    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
> +  tags:
> +    - ${DEFAULT_AMD64_TAG}
> +  <<: *buildman_and_testpy_dfn
> +
>  xilinx_zynq_virt test.py:
>    variables:
>      TEST_PY_BD: "xilinx_zynq_virt"
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index be46135d6a52..37076de01011 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -90,6 +90,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>         help2man \
>         iasl \
>         imagemagick \
> +       inetutils-telnet \
>         iputils-ping \
>         libconfuse-dev \
>         libgit2-dev \
> @@ -233,10 +234,18 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>  RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
>         cd /tmp/tf-a/ && \
>         git checkout v2.12.0 && \
> -       cd tools/fiptool && \
> -       make -j$(nproc) && \
> -       mkdir -p /usr/local/bin && \
> -       cp fiptool /usr/local/bin && \
> +       make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +               PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
> +       mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
> +       cp tools/fiptool/fiptool /usr/local/bin && \
> +       cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
> +               /opt/tf-a/vexpress_fvp/ && \
> +       rm -rf build/fvp && \
> +       make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +               PLAT=fvp BL33=/dev/null TRANSFER_LIST=1 -j$(nproc) all fip && \
> +       mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
> +       cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
> +               /opt/tf-a/vexpress_fvp_bloblist/ && \
>         rm -rf /tmp/tf-a
>
>  # Download the Arm Architecture FVP platform. This file is double compressed.
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
