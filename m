Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A30CA0EF8
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E6E82E37;
	Tue, 19 Aug 2025 10:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="IlcQ2NTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C452C80FA1; Tue, 19 Aug 2025 10:49:04 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DE582E34
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-afcb78d5e74so854683566b.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1755593341; x=1756198141;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CvEtbrfhqAf9HU9+EoLtaVXOhH3ai2v8VPbLRNv8nzs=;
 b=IlcQ2NTS/3BNDBJEcJPvEGkvV/+SX4JHKUs8iWjEn6gv2YROQ+/gkhyjfaCe6VI0AT
 G6OlXXBtvrxqGZ9yWEFYDNyErL45tWZrqvv2ny8aZBwsQTpaHKR0rgRgnN3I0Ae6ltCC
 IL7La1u7tta2fqL4uB7LZWwC9QF3Ql74Q5BOErL/vDTbf0BtoBlowJJY+EuDZhrGN8KK
 vZbmWZHLK9vJItdkHtk5jO1Hns1521PQl8/A/8QSgwNJJobxApC1q+/Xcini+wzRzga5
 f+U9Oe1mUNZX7BKFTCScdM/qZr11s3uz4Tt0x4EMkcJmb0NSr5oG1/gqO92K1+e2ptTZ
 ZTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755593341; x=1756198141;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvEtbrfhqAf9HU9+EoLtaVXOhH3ai2v8VPbLRNv8nzs=;
 b=RZ+RhbOnF2IwNPoGnjbihxk6VdzDkSuoljBnHKUuPyMz76tuw2+ZqW0Jr/d1zHlPTA
 CwN22k2Gqzd86KvXfBm4e/GuGEaLz/vWquBvDXTZlq1od6zSlEW3oxwQ4hr1RgJ2tu1t
 DPPMVn9Cp5zuLvXJPi/WpgID/ZW/j/vR+oC7Jwp9N8az5sQgkOETJVefBXDYVP2Ltaaa
 XpkzawWGmAXesMX1TEbxgruwIDUDFQReTAcAtzKa7zfS6M+3YufABTKs5zQ/4MVaxrav
 GbvBjcRuu9D34mPxWQ23C4iBnUCiFjaIbRd86OlkuAea/LYzBFAWV9nN+m/XzjF1jcP8
 VEMw==
X-Gm-Message-State: AOJu0Yym5TSxsHQUDhgNjZJBFcS+i4gtp6nBNa09c/ufPmVThLFX9pnB
 s/+b+o/3UNQs6GCag8Dk8LVQ0pa7O/Nm2exGxwxSRXKen+u5Ss6HRTzXOZoTz6rUnNueyoiX/9s
 bBmos9vDl
X-Gm-Gg: ASbGncvf3DOdGozWJCayE/0l/YI4QXfoJEhH/M8X7iecYVyAufWSCW3iS6Q8zJzon75
 scLTDlkMeczC9xYzIJhObHgjUV/N59utkmqrf4JXKTtfF+gZaGB7Z3FbbhmScfhxntux04qV9vT
 0V3PXev0gM89UnABrBM6SUF90oojCCL2qCR+li+HPHxYED0KmdzpRzU8ZnIAW7ceNDmWDQCnT2o
 9Bp5trUpGRZvkPv3+qkbsoeWTrcCgS1DmnkC3Oi/8eL+qBrvyRsZ939FRpYScAIbXwFRcb2mlwq
 aKK6pnnwA3T95WCAWYJx0kSqfK+Nr0fgwUnLnfG5vhAklGL6lpLColMDBSHd/tj31ffXLPZWHQi
 oPld1WnvGyPQkjiMcXmsxmOy1
X-Google-Smtp-Source: AGHT+IHsmpS2Vg8few53J0R2t1couT9+WG6D5V7sVi3l/VhCmSaxtC+Rf/OOymI8JLSVhyQ3v5goiQ==
X-Received: by 2002:a17:907:868b:b0:ade:9b52:4cc0 with SMTP id
 a640c23a62f3a-afddcb8fb06mr152685266b.26.1755593340994; 
 Tue, 19 Aug 2025 01:49:00 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a75778c5dsm1325203a12.31.2025.08.19.01.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 01:49:00 -0700 (PDT)
Message-ID: <d1912d8c-eb84-43b0-9428-a52d2efa5e1a@monstr.eu>
Date: Tue, 19 Aug 2025 10:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] CI: Wire mbv32 combinations
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <02e5c14552b05200ece94136db0077cbdd47738c.1753945577.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <02e5c14552b05200ece94136db0077cbdd47738c.1753945577.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/31/25 09:06, Michal Simek wrote:
> After upgrading to QEMU 10 by commit 1d782a3f229c ("Docker, CI: Update to
> latest Ubuntu and Dockerfile") let's wire mbv32 which is the part of QEMU
> to have it under regression.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Add missing backslash to azure pipeline
> 
> gitlab I have tested.
> azure I didn't test it but did blindly all changes as they are in github
> one.
> 
> This patch has be applied on the top of this series
> https://lore.kernel.org/r/cover.1753182218.git.michal.simek@amd.com
> 
> ---
>   .azure-pipelines.yml | 20 ++++++++++++++++++--
>   .gitlab-ci.yml       | 32 ++++++++++++++++++++++++++++++--
>   2 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 8209d2b329cb..d4bf43e7a923 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -258,11 +258,11 @@ stages:
>             ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
>             ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
>             ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
> -          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
> +          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]] || [[ "\${TEST_PY_BD}" == "xilinx_mbv32_smode" ]]; then
>                 wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                 export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
>             fi
> -          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> +          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]] || [[ "\${TEST_PY_BD}" == "xilinx_mbv64_smode" ]]; then
>                 wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                 export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>             fi
> @@ -540,6 +540,22 @@ stages:
>             TEST_PY_BD: "sifive_unleashed"
>             TEST_PY_ID: "--id spi-nor_qemu"
>             TEST_PY_TEST_SPEC: "not sleep"
> +        xilinx_mbv32:
> +          TEST_PY_BD: "xilinx_mbv32"
> +          TEST_PY_ID: "--id qemu"
> +          TEST_PY_TEST_SPEC: "not sleep"
> +        xilinx_mbv32_smode test.py:
> +          TEST_PY_BD: "xilinx_mbv32_smode"
> +          TEST_PY_ID: "--id qemu"
> +          TEST_PY_TEST_SPEC: "not sleep"
> +        xilinx_mbv64 test.py:
> +          TEST_PY_BD: "xilinx_mbv64"
> +          TEST_PY_ID: "--id qemu"
> +          TEST_PY_TEST_SPEC: "not sleep"
> +        xilinx_mbv64_smode test.py:
> +          TEST_PY_BD: "xilinx_mbv64_smode"
> +          TEST_PY_ID: "--id qemu"
> +          TEST_PY_TEST_SPEC: "not sleep"
>           xilinx_zynq_virt:
>             TEST_PY_BD: "xilinx_zynq_virt"
>             TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 85401d3e09b1..b83cd1a5b232 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -43,11 +43,11 @@ stages:
>       - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
>       - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
>       - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
> -    - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
> +    - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv32_smode" ]]; then
>           wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>           export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
>         fi
> -    - if [[ "${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> +    - if [[ "${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "${TEST_PY_BD}" == "sifive_unleashed" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv64_smode" ]]; then
>           wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>           export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>         fi
> @@ -550,6 +550,34 @@ vexpress_fvp_bloblist test.py:
>       - ${DEFAULT_AMD64_TAG}
>     <<: *buildman_and_testpy_dfn
>   
> +xilinx_mbv32 test.py:
> +  variables:
> +    TEST_PY_BD: "xilinx_mbv32"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +    TEST_PY_ID: "--id qemu"
> +  <<: *buildman_and_testpy_dfn
> +
> +xilinx_mbv32_smode test.py:
> +  variables:
> +    TEST_PY_BD: "xilinx_mbv32_smode"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +    TEST_PY_ID: "--id qemu"
> +  <<: *buildman_and_testpy_dfn
> +
> +xilinx_mbv64 test.py:
> +  variables:
> +    TEST_PY_BD: "xilinx_mbv64"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +    TEST_PY_ID: "--id qemu"
> +  <<: *buildman_and_testpy_dfn
> +
> +xilinx_mbv64_smode test.py:
> +  variables:
> +    TEST_PY_BD: "xilinx_mbv64_smode"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +    TEST_PY_ID: "--id qemu"
> +  <<: *buildman_and_testpy_dfn
> +
>   xilinx_zynq_virt test.py:
>     variables:
>       TEST_PY_BD: "xilinx_zynq_virt"

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

