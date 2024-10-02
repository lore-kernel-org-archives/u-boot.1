Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F031CF8547
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 22:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305DB89051;
	Thu,  3 Oct 2024 00:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FUcBM+Bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3406C89065; Thu,  3 Oct 2024 00:55:52 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA3188F5B
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb2dffcdbbso2955386d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909748; x=1728514548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w0wRBiF9Rrq/nk1qOOkidGdoqSZa5Yv+cMyCurX9NgE=;
 b=FUcBM+BlXI+ezv5bs89AxH2/86MdQkxrTmgB97OY1aXrY9UIMKKnBGKE7q+gDp9bAS
 1zWY/+HnZ7PdeIj31JUD/+wxaR8ELboWop425lqZ58m4HuPRZU6nRo5/IPxfPA2pf6KD
 ER/RlxQ0jFededSYwzh485qAPlUkn8kYDgzqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909748; x=1728514548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0wRBiF9Rrq/nk1qOOkidGdoqSZa5Yv+cMyCurX9NgE=;
 b=tlqD4TQlk0lsFf88gs8iuFEJDXG2sUGpf328k1QFSOxYTdK8asMATxR3JMxJBn8q8s
 tLM70JZg8TUBChl91Qak+Hi4GMMHzuGLiK90JOWgq5a2pBwHQYCSKcyFALBGPIaQR6Ck
 67qU4ywkwri3kiuXe5tiEsETbau5uTO0fIEz9EXSA7UBxPgthL/GK7k7xN5QujuQtBet
 CpAV3G0KtFiDRKUJod/0Me3+FKDQrscd2plOyqoOPqbIN/neJI0ZAiwp+H+04Zlyyph3
 /63d6WU3EgK7dbIb6X504PKjPeVO3gkOTs3Dq7cQsIDvbFTwAMMHgwqJMK8wScv4kAXx
 URYA==
X-Gm-Message-State: AOJu0Yx4zbC7xB6fhfVIWNfvHuIeSxx0xfTF3uVwqBWRZQw9AKLydTde
 7lsYwaxs+mFFVej0SIZ4oQ/hURQD7CKWCW99WNjWXIn7xt8kSqrCSoRPCAmQwHVbAMhcoKDws4b
 neWa1hEybjHJ3JKT7V23rxGZvZqj4OuVZNUngHTBn1LeZdVE=
X-Google-Smtp-Source: AGHT+IHL1HC5Bxh89FeivUSbspMXQhnq7+8AMWkPyBQ6rmdnNoLUr8vpMrliTrhS9SBZSxg6Mtwdp4u2L+3mxPdxQnU=
X-Received: by 2002:a05:6214:3c98:b0:6cb:3c08:30a0 with SMTP id
 6a1803df08f44-6cb81cc8093mr76540236d6.49.1727909748611; Wed, 02 Oct 2024
 15:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-38-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-38-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:38 -0600
Message-ID: <CAFLszTgKa46eQsf=RpEsKoiOW7CsFj-8aK5xTCfQ7H1PGG35Xw@mail.gmail.com>
Subject: Re: [PATCH v6 37/37] CI: Enable qemu_sbsa
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 2 Oct 2024 at 03:58, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests on it.
> TEST: Run on Azure pipelines and confirmed that tests succeed.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
> Changelog v6:
> - Add gitlab CI support
> ---
>  .azure-pipelines.yml |  8 ++++++++
>  .gitlab-ci.yml       | 11 +++++++++++
>  2 files changed, 19 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 93111eb612..2881851ecf 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -250,6 +250,11 @@ stages:
>                wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>            fi
> +          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
> +              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
> +              export BINMAN_INDIRS=/tmp
> +          fi
>            # the below corresponds to .gitlab-ci.yml "script"
>            cd \${WORK_DIR}
>            export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
> @@ -415,6 +420,9 @@ stages:
>          qemu_arm64:
>            TEST_PY_BD: "qemu_arm64"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        qemu_arm_sbsa_ref:
> +          TEST_PY_BD: "qemu-arm-sbsa"
> +          TEST_PY_TEST_SPEC: "not sleep"
>          qemu_m68k:
>            TEST_PY_BD: "M5208EVBE"
>            TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7d621031b8..3f02a492d5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -39,6 +39,11 @@ stages:
>          wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>          export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>        fi
> +    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +        wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
> +        wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
> +        export BINMAN_INDIRS=/tmp
> +      fi
>
>    after_script:
>      - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
> @@ -344,6 +349,12 @@ qemu_arm64 test.py:
>      TEST_PY_TEST_SPEC: "not sleep"
>    <<: *buildman_and_testpy_dfn
>
> +qemu_arm_sbsa test.py:
> +  variables:
> +    TEST_PY_BD: "qemu-arm-sbsa"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +  <<: *buildman_and_testpy_dfn
> +
>  qemu_m68k test.py:
>    variables:
>      TEST_PY_BD: "M5208EVBE"
> --
> 2.46.2
>
