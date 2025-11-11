Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64BFCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B9183AEC;
	Tue, 11 Nov 2025 09:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TNPsb9Pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7475583E63; Tue, 11 Nov 2025 09:42:31 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000A283AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-787e7aa1631so6713817b3.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762850548; x=1763455348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ds/6K9ltPJo3yZW5rrgr/wvWcnU3Nh9SWLzOh8KeJ0M=;
 b=TNPsb9Pl7OvjjviV0eIDj/s534NejDf6lNXk8q8cMVbygAfQHIQ2FcVFcZXgvCC5hy
 r6Q0O9hFrrr/g9uMl53Duaa+IzbeWA5a4f4Lgvys5xVMq2aYbcqIn2Rz1vpNQ/aM4/L0
 dZDYEG0VrXB/Sw6vqOSaRbyZ3uVBRZF9O8lBXBVHDysOTbqj+EODqh/JEVMwkgdXIMUN
 HldXK902fhTDrGLgzcHKbvujL9i7zAUgA9oInuy/LLDfWcBj963puzghHogsKKipaGnz
 7W4FLPvR+rO6XISrB1wyM6zCib7IERt75SRza00JUG5F8IiRhuLTRduPpQGG0K2IhOki
 AFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762850548; x=1763455348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds/6K9ltPJo3yZW5rrgr/wvWcnU3Nh9SWLzOh8KeJ0M=;
 b=Zv+8/WrQ+JrVyqOmzVKfqXsZpGIpsxaUwlluaRZ5fZefdZUQ/0NXFwvw3+UB1dJAHa
 D6suOTKyOu7fhRYkYUEXxasyzLyapQoDwJheSKl2/BIA3JbtTz5BgN5uhUrQQ/Av/iLI
 jlsDhJdJ8eley9byGSAiyUmVFDBEYAzrKwzH+745s114c68xYi9KkCqSV3wnt6wFWFJ/
 Ep+qMoQkLOIHdDyRXkT+73cWnntJd/vjy4JSsloOR9GpZgylS30tBFSqI0E9dI9C+AXy
 knXCUUCEb9xdumODDUg9KGXM6Xd2cRF8hXrEjj3fBHTzKG6n5IJCNC5rl3bJD76jmBKC
 h1rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiX6McP2KCa963S3bDohXmUdP+WJelvEI2MGZTF1+uCJIcfcoMtRLu/R/2eBWD8Udl/bD1rAM=@lists.denx.de
X-Gm-Message-State: AOJu0YyehGKa1x2cWSaNdDAkQpJYYd8BYL+KMjbf4gxeG0OdhFWIAgOx
 dii9I0BSCfyqS4i69oPqquiwhw6z09ipqYX1M5mIsjaybTUWZrUN4RKZOGdv/MhbGTN+0l1EccJ
 nQmJaLwatkseIsoOGunua/EmHLHfuw2r28XSsjZMv3A==
X-Gm-Gg: ASbGncuOQgz50W8jWqXef+W/f5gRHybvSzDYZoxw+cYEtY1FhnJd0Jjlqk1pWfkRz/M
 6vE8ypiwuNd32iiA9/2Z5wzefSlAo6VM5b4ZneFUGSsvufj+XvXkVUpa67Y1oem4szYbhiZLtzK
 dYxGytfICQwSpKEs0mb5hpab/1AfWrln6855bcnOJ7u7nRjzbdIeW9mZ4zqqjmwxLMLydtGOdmV
 Rb9xUnyn3BNvxkReaEvORh7eaciRIjw9N19fWR1z9AQO5/8sq6GCYgilfGqMDYEKCR1zbvSwxtl
 Rlks5hEcGGEp2KqGETQGlrlnLghNll3u7estR2u3
X-Google-Smtp-Source: AGHT+IH6VWrKxqXKctqmF8xXII95zFJrjYyAeX+t8EXzbfrlJ051XwJPY8tKqlzt+BysTDdD+vVxcQFNhmBpFsoGjJA=
X-Received: by 2002:a05:690c:289:b0:786:86e3:a494 with SMTP id
 00721157ae682-78803510d5amr21524537b3.2.1762850547724; Tue, 11 Nov 2025
 00:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20251110125828.1643327-1-bmeng.cn@gmail.com>
 <20251110125828.1643327-2-bmeng.cn@gmail.com>
In-Reply-To: <20251110125828.1643327-2-bmeng.cn@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:41:51 +0200
X-Gm-Features: AWmQ_blJgzBVh6LrGYgu9mr0M-ipLDKOYi6LxYtcg6dREFcyE9qQc8J8xygc_Ro
Message-ID: <CAC_iWj+bQLC87QEA3aNfrYX8_njT55_RFAiRHiBWfhRXa9xnJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

On Mon, 10 Nov 2025 at 14:58, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> The QEMU ARM SBSA virtual platform is 64-bit, so rename its defconfig
> to include 'arm64' for clarity.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v2:
> - Add missing azure and gitlab ci changes
>
>  .azure-pipelines.yml                                        | 6 +++---
>  .gitlab-ci.yml                                              | 6 +++---
>  board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
>  .../{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig}  | 0
>  doc/develop/driver-model/virtio.rst                         | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
>  rename configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} (100%)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 1009938f332..9216df16f70 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -268,7 +268,7 @@ stages:
>                wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>            fi
> -          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +          if [[ "\${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
>                wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
>                wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
>                export BINMAN_INDIRS=/tmp
> @@ -483,8 +483,8 @@ stages:
>            TEST_PY_BD: "qemu-arm64"
>            TEST_PY_ID: "--id fw_handoff_tfa_optee"
>            TEST_PY_TEST_SPEC: "test_fw_handoff"
> -        qemu-arm_sbsa_ref:
> -          TEST_PY_BD: "qemu-arm-sbsa"
> +        qemu-arm64-sbsa_ref:
> +          TEST_PY_BD: "qemu-arm64-sbsa"
>            TEST_PY_TEST_SPEC: "not sleep"
>          qemu_m68k:
>            TEST_PY_BD: "M5208EVBE"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5f91780c764..19ab1ad53a0 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -49,7 +49,7 @@ stages:
>          wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>          export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>        fi
> -    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +    - if [[ "${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
>          wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
>          wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
>          export BINMAN_INDIRS=/tmp;
> @@ -402,9 +402,9 @@ qemu-arm64_tfa_fw_handoff test.py:
>      TEST_PY_TEST_SPEC: "test_fw_handoff"
>    <<: *buildman_and_testpy_dfn
>
> -qemu-arm_sbsa test.py:
> +qemu-arm64-sbsa test.py:
>    variables:
> -    TEST_PY_BD: "qemu-arm-sbsa"
> +    TEST_PY_BD: "qemu-arm64-sbsa"
>      TEST_PY_TEST_SPEC: "not sleep"
>    <<: *buildman_and_testpy_dfn
>
> diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
> index b2b1fce75cf..fea9e97f868 100644
> --- a/board/emulation/qemu-arm/MAINTAINERS
> +++ b/board/emulation/qemu-arm/MAINTAINERS
> @@ -6,4 +6,4 @@ F:      board/emulation/common/
>  F:     include/configs/qemu-arm.h
>  F:     include/configs/qemu-sbsa.h
>  F:     configs/qemu-arm*
> -F:     configs/qemu-arm-sbsa_defconfig
> +F:     configs/qemu-arm64-sbsa_defconfig
> diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm64-sbsa_defconfig
> similarity index 100%
> rename from configs/qemu-arm-sbsa_defconfig
> rename to configs/qemu-arm64-sbsa_defconfig
> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> index 8750228693b..df07a0658b2 100644
> --- a/doc/develop/driver-model/virtio.rst
> +++ b/doc/develop/driver-model/virtio.rst
> @@ -34,7 +34,7 @@ The following QEMU targets are supported.
>
>    - qemu-arm_defconfig
>    - qemu-arm64_defconfig
> -  - qemu-arm-sbsa_defconfig
> +  - qemu-arm64-sbsa_defconfig
>    - qemu-riscv32_defconfig
>    - qemu-riscv64_defconfig
>    - qemu-x86_defconfig
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
