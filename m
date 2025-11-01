Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBF5CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 09:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA76083A91;
	Sat,  1 Nov 2025 10:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BC+a+4SG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE66839B9; Sat,  1 Nov 2025 10:04:22 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC8683A6A
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b6d2f5c0e8eso636636466b.3
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761987860; x=1762592660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mhe5WvEO4omnoB/cHcISOSLWqKeluir0m4d/cFDCO6Y=;
 b=BC+a+4SG0191ZEYdyaHzslXKKBq6J+EBaOYK/gKep/sG3xEcLC9VjZDXgkmKNAfO8J
 IZ4ngZ3JT55Qiu4Np3Tj4oXFeJuAQomtBXRPoWkd+AroMofj3f5pgmVhhVvvqVcSYsue
 9C4uZCIH3/l//Jzzd8NhjkzW51T502AQma2FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761987860; x=1762592660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mhe5WvEO4omnoB/cHcISOSLWqKeluir0m4d/cFDCO6Y=;
 b=vHrjIwSVwfqaCoCo9jh3aO8B9psfXU16M0FhLaY80uC+3tOnRwhpkac1ZsIs4Tcb0g
 4uNSYIDCRGCooPnimJQWcRQeMMPpVLV9TvIldErAyYTmWdsb7NxNdui594vCyQB1+/bd
 iJ0MLAA/63tsu2CUkE7GRf2HNRe/znFR39+0IGUbrcRcDInlLs/e8bwbou38Gi9ILwko
 b0UWSv3TUJRKdTm+Eux87SG/fYjgkmivVtbqP7YPHGXoiJ6fD70qDdo2Uvcfni82hewU
 gY9jr818A7WQaPYyGxhBQhcRilaeWr2SLD+iFgGJTEfM+O4pSWNURPICFF+gwHeE/bNQ
 w7rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1rk3jAx9Jp5fDSdgfQRW/mxFWBfGY6DNleI9v+xssMmjIFZVuTrNhANHVMbZt3to7a7s5oKI=@lists.denx.de
X-Gm-Message-State: AOJu0YxbipQGOr5LzK8FsR2SaIbA0qB7MIzfIxSW1+l0S3C+WKyzZHdq
 ZJ/ISYNU8sH+dEzdeusog6BfkuyKvxFZDJHNfL9N5qOrgpBKyge7IixIe0gI8jjG/AMB6UvQr8W
 bSmONAawT47HBWhknA8o5MGvNyi82zlQdYoRXe//l
X-Gm-Gg: ASbGncu06YRX3/A38sBb9Xffm4VLYBOASBWYHSn7/LocbSDZMwlxEjEh+7xEwO8MFf8
 o8dew7iHol1jNlWq5sRAEr0/kwnZG1b3w9Q5IoQHj0N3vAEHMxfjrJ7gaJhpfVGwHPQ8XpfNgYc
 VD7/q0QtYx0ogWDqjjUnLexI2M/9KVGrEez8ssfGOLUGa7Tw7/mb4fRG8KJajCxzmQTY8eh6rpi
 eA9qItm64k9IX/N6FzFM6kDIQTt3Rv8QZYLOKdveMEWeyCxE/yeV6zFZ+jLlu1rW3zwnQY=
X-Google-Smtp-Source: AGHT+IHOZiq9ElBXcx7ozC1sy8sj/5l2icQWmhV6IZxrgDaw5RkGdtc+kuSGlNDUber784/BTWVA1aWfRcmcfvc8rwU=
X-Received: by 2002:a17:906:c149:b0:b60:52f6:a32 with SMTP id
 a640c23a62f3a-b70700b3413mr608636666b.7.1761987859999; Sat, 01 Nov 2025
 02:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251028131720.55212-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251028131720.55212-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 1 Nov 2025 10:04:02 +0100
X-Gm-Features: AWmQ_bnd11VwX-F8BmrZ0Q5qaihlTj9oOBJxTJ-gYc6WVRQAvveU7AWUMcRNU9I
Message-ID: <CAFLszTjKphT4fj13jdAdwxydnJ_xK5hAE0_+-DzAfC+uk=+8Eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] CI: test qemu-riscv64_smode[_acpi]
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 28 Oct 2025 at 14:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> QEMU comes with its own OpenSBI. For running RISC-V virtual machine
> using one of qemu-riscv64_smode_defconfig or
> qemu-riscv64_smode_acpi_defconfig is the natural choice.
>
> Add the riscv64 smode configurations to the test scope.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .azure-pipelines.yml |  6 ++++++
>  .gitlab-ci.yml       | 12 ++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index fc55c8b2100..be310b85eda 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -506,6 +506,12 @@ stages:
>          qemu_riscv64_spl:
>            TEST_PY_BD: "qemu-riscv64_spl"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        qemu_riscv64_smode:
> +          TEST_PY_BD: "qemu-riscv64_smode"
> +          TEST_PY_TEST_SPEC: "not sleep"
> +        qemu_riscv64_smode_acpi:
> +          TEST_PY_BD: "qemu-riscv64_smode_acpi"
> +          TEST_PY_TEST_SPEC: "not sleep"
>          qemu_x86:
>            TEST_PY_BD: "qemu-x86"
>            TEST_PY_TEST_SPEC: "not sleep"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 73ff975e574..e3cba5d6b90 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -471,6 +471,18 @@ qemu-riscv64_spl test.py:
>      TEST_PY_TEST_SPEC: "not sleep"
>    <<: *buildman_and_testpy_dfn
>
> +qemu-riscv64_smode test.py:
> +  variables:
> +    TEST_PY_BD: "qemu-riscv64_smode"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +  <<: *buildman_and_testpy_dfn
> +
> +qemu-riscv64_smode_acpi test.py:
> +  variables:
> +    TEST_PY_BD: "qemu-riscv64_smode_acpi"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +  <<: *buildman_and_testpy_dfn
> +
>  qemu-x86 test.py:
>    variables:
>      TEST_PY_BD: "qemu-x86"
> --
> 2.51.0
>
