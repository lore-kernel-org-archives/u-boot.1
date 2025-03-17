Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8609C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 19:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C51C80F70;
	Mon, 17 Mar 2025 20:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LyWQdgtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F4480F70; Mon, 17 Mar 2025 20:12:53 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CC0800B3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 20:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e63c3a53a4cso3953136276.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742238770; x=1742843570; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AJM6HFJ1Yy5uaGw3qNNQ0z4iKK4t8vYz5ws9hC+56x0=;
 b=LyWQdgtv53ZFVYDEhj27RSkyxf8pmz79de3Y7amh16dFoonUP5cNGXQrDTGYERGTNL
 qd6RHZUp8rd5nWF3YvKY0Xy5On5IJwiMxO6s2bxIO27XMrrwisVWfWKI4g9lU+HNLSyu
 HTVFJm/TlODCJuHvJyY2zgMlaW3rd4zV1fAJPJL51KuG7h3UA+dlxIfJPNJcD8Yxh/9K
 D1mtqKx13FSIRxpFMmgQj9SNte0n2cgQZ8Re2+np+eekkfY/zQoOO4HPucVKmOhS7CNK
 veP9D7+07QjaKg5p822bJtkZNlBEfwudiAqkQXbkBjwY+DiqnnQXvGZavlLECjqwzFA9
 sJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742238770; x=1742843570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJM6HFJ1Yy5uaGw3qNNQ0z4iKK4t8vYz5ws9hC+56x0=;
 b=k64EWRlZjBg8yEYGz6Zpj60LcS/Z1egBakMUsFKh0wto+8OE5u1LeTVUI9Avns5M9C
 Q1HyvfXy5EWOCWRmZjhheCr/NQxOVlIRn0i8cl4lkla1kAhND155oTSYws9TdrIAUrc9
 g4vnBDvVSwrIrISTOKGTuw0rkRAT/R4LclQZOIdM6wpbk4XxJYrnnvViJtjj90MUPtDT
 SEOEi43UZCPHa3/5PUS9jkgcHtuLLUQN/Qk6UZzUrLvjZ3llk7WgJQiZh6qbxvpqN02C
 R56geeT6UoiQPd/rpvSwbXNh9dU5dxLLrSatgAEOlrPmj5UOgenTUzPeKPUwQIHmI6vH
 SyUQ==
X-Gm-Message-State: AOJu0YxQjC9RHBnS4yopoTHdEJuUtPGogDnknfDG+wATyUPFJK5M705A
 sFsYWGIKdLgw7NdR3WDApwWuG7v0ZrUeUdrgaMhiwhTxHLDJd2Gt4jOE69lN9D7A2LyMFsErRmY
 7kDWqNxm8cA6X47hXp8OLU1BOhAbUwVk2Jh/r0g==
X-Gm-Gg: ASbGncuhEhxk5hsIFQgX5gEY1quI8KbE7NiH/hDbhxYRHNF8EucW9OkUl9WojkQN7Bm
 gKSjtu1Vk6F4DBtGkhqdkpr9Oxmw9+h3QBDRkvb55ReC5tMkWsYP8S8uP3hercr/+odDKWbRzpk
 CNoq6tRTkOCmhYOgz71jc63sQ5KRM=
X-Google-Smtp-Source: AGHT+IEXLr7nVEYtLC3H64j5S/c4krGsltMyscIoZ0wEQNZpSltsbZQFwh8/HCNidyh1Gid/CY0tBYmgnEG8R7856Bg=
X-Received: by 2002:a05:6902:2382:b0:e65:c4be:6fa8 with SMTP id
 3f1490d57ef6-e65c4be741fmr384848276.9.1742238770193; Mon, 17 Mar 2025
 12:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250315141744.452073-1-trini@konsulko.com>
In-Reply-To: <20250315141744.452073-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 17 Mar 2025 21:12:14 +0200
X-Gm-Features: AQ5f1JqWy026gek_xLEQtzoEW2gzhgp0FiwrsQ409FtSHtda8dWktvavuXj5uyQ
Message-ID: <CAC_iWj+W2Z8raS5_wuKRNpCwi_N5E-zfNX2r0L9AD23Qf2fi3A@mail.gmail.com>
Subject: Re: [RFC PATCH] Gitlab CI: Clean up more
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi Tom,

On Sat, 15 Mar 2025 at 16:17, Tom Rini <trini@konsulko.com> wrote:
>
> A problem we hit on our CI runners themselves, from time to time, is a
> lack of disk space on the host. This is because Gitlab has no automation
> itself around the removal of items it put in a "cache". While part of
> the way to alleviate this is for the runners to run various docker
> cleanup commands on their own, periodically, another thing to
> potentially help would be to further clean-up in the job itself.
>
> This patch adds "git clean -dfx" in jobs that leave some files in the
> source tree (these files may lead to a cache miss, more investigation
> would be required) and deleting the board build directory. This part is
> both a minimal size reclamation and minimal time increase (a few
> seconds).
>
> The other part this adds is making the world build use "/tmp/world" as
> the output directory not "/tmp" so that we can then delete "/tmp/world"
> afterwards. This adds between 1m30 and 3m to the build.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  .gitlab-ci.yml | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 2dbe6325f334..ce7a391bbd00 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -63,8 +63,9 @@ stages:
>          -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
>
>    after_script:
> +    - git clean -dfx
>      - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
> -    - rm -rf /tmp/uboot-test-hooks /tmp/venv
> +    - rm -rf /tmp/uboot-test-hooks /tmp/venv /tmp/${TEST_PY_BD}

This deletes less?

>    script:
>      # If we've been asked to use clang only do one configuration.
>      - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
> @@ -130,11 +131,13 @@ build all platforms in a single job:
>          -r tools/buildman/requirements.txt
>      - ret=0;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
> -      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
> +      ./tools/buildman/buildman -o /tmp/world -PEWM -x xtensa || ret=$?;

Since you are making the tmp-> /tmp/world it might make more sense to
define a variable for the output directory.

>        if [[ $ret -ne 0 ]]; then
> -        ./tools/buildman/buildman -o /tmp -seP;
> +        ./tools/buildman/buildman -o /tmp/world -seP;
>          exit $ret;
>        fi;
[...]

Other than that I think it looks sane. The added 1 - 3 min build time
is small enough to ignore

Thanks
/Ilias
