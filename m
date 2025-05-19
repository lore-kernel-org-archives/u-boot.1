Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5593CC3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 07:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 839E981E72;
	Mon, 19 May 2025 09:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FAIyB961";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F97481F66; Mon, 19 May 2025 09:06:16 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0018A803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 09:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7086dcab64bso35936107b3.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747638373; x=1748243173; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SGyvB94KlKf2lnjhmb3bGu0Ltw0u3HzLTfZ8r4AdOE=;
 b=FAIyB961n3mEtJxXgT9RILsqpxx5EJ6pm/jNzfxWDdmAHzuJur/SoyclpRzKRtyZYv
 TbhkZ86v4JDQG8bvOH/L+r90L15Q7C5fE2/8pR+XdgmA04hGXr3KN5ZC4D8w4LnWVtLG
 v1ZltzTpkqFpUFB3sTZgoc5V48ndTs5MjxQ7iYyIZ4ST7TzuERInFw6C8gbg7bMNnM87
 5yHC/cvj1lJrcN8NdXCDhNE27tfrqPiM/7KrYJP4tlM3iXDIQnYs3H/DDiwMUpwRs9VM
 cToIiBF7dzvIIXOAu7sqxOsvyi3qTss9iFeR4inTVFzX0Z/aY9KWhunFbeXj79HVy1RG
 a0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747638373; x=1748243173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SGyvB94KlKf2lnjhmb3bGu0Ltw0u3HzLTfZ8r4AdOE=;
 b=wxVlND/Nknyqr0tMnXDMujaqaO65WER3GeBsEZHs1oSNWxGSILxGS8+GSk/qgprE40
 3A7KD3GUKzaMKd8+oGbuZU+SkrLacG6WjT0LOZi96kKPmGrME5RR2KPe0tzPg0vgT9SC
 ZgUSYgiI66gxMGCardwjgzzQZp88Hz9MlL0hGQmwsrxpE6YDyHs9vL5d+olJSG9jZaY3
 fGJzAwsiRLd+VqGXX6xNXZ+VBjjquey0RkDhgXtkqrdFoyxbx5EP8jfwQcO5+xedvg8z
 +VJt54Exd+s14Eb1sWAc1z2pot+CYm+tUk6ivox7LB1zThHQON9scGrXkArRYOVdyBUU
 DLwA==
X-Gm-Message-State: AOJu0YwQCI9If0Rkg+rZ1l5iFwBgmpCGR+UiXrcmRnKYtK2u90+R3WF4
 l6uL7PWp7iM8e667AyCYA2+5gu8oQtReA8I2Csw0XD9yre0LQy4LFv3ip3Yfw9YyjLGFzMQUS9q
 zpbXpChNjuwinyIyvkuRX2xrn55Tqj8sHQJSBsj71aw==
X-Gm-Gg: ASbGncurIZ18+pnUlcXQw7ajBbm3y6kQbfY51+zP8/amVXqKthVHzuDtkLZqtYz1z3n
 RFfWvmhR7TL2/cPet3aeMxQdXCttirxiETZe56lr1ZlMR6JIJIdmtkTiHjNR9ZTW4cJvGy3+ZxB
 GYcGWMVaWC1hApQiV8WzY5ioVfvDC4ITKwUA==
X-Google-Smtp-Source: AGHT+IGvTSHtNvNjBwLVrs/isVwR5All/v4VHvA3CYl/Wai6bTimsIMlXf2D1xQzGD2QSlxcM9jHJcOdorBIzA/y6Bw=
X-Received: by 2002:a05:690c:4986:b0:708:bc95:7ca4 with SMTP id
 00721157ae682-70ca799b91amr168288547b3.4.1747638372838; Mon, 19 May 2025
 00:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
 <20250514161841.3591411-2-adriano.cordova@canonical.com>
In-Reply-To: <20250514161841.3591411-2-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 10:05:37 +0300
X-Gm-Features: AX0GCFtp3EQWcop_KbpMqOw8-Rus5yxvRfUw6mvKWIIuABw4MvVgjbZn6zO4R6E
Message-ID: <CAC_iWjKYPFWcCCXe-RTeU0Q2A+2ku-JzE3A7z1yG_UWDk_ecuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI testing: add http server to CI tests
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, jerome.forissier@linaro.org, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 14 May 2025 at 19:17, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add an http server to CI tests so that HTTP booting and
> loading can be tested.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>
> changes in v2:
>   - Remove HTTP_SERVER argument for test.py
>
>  .azure-pipelines.yml | 11 +++++++++++
>  .gitlab-ci.yml       | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 9c136513bb9..334cf27cfb5 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -316,9 +316,20 @@ stages:
>            fi
>            export PATH=3D/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
>            export PYTHONPATH=3D/tmp/uboot-test-hooks/py/travis-ci
> +          python3 -m http.server 80 --directory "\${UBOOT_TRAVIS_BUILD_D=
IR}" > /dev/null 2>&1 &
> +          HTTP_PID=3D\$!
> +          sleep 1  # Give the server a moment to start
> +          if ps -p \${HTTP_PID} > /dev/null; then
> +            export HTTP_PID
> +          else
> +            unset HTTP_PID
> +          fi
>            # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \=
$var" if not
>            ./test/py/test.py -ra -o cache_dir=3D"\$UBOOT_TRAVIS_BUILD_DIR=
"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_EXTRA} \${TES=
T_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUI=
LD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=3D\$(System.Defa=
ultWorkingDirectory)/results.xml
>            # the below corresponds to .gitlab-ci.yml "after_script"
> +          if [[ -n "\${HTTP_PID}" ]]; then
> +            kill \${HTTP_PID};
> +          fi
>            rm -rf /tmp/uboot-test-hooks /tmp/venv
>            EOF
>        - task: CopyFiles@2
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7aadd5d8b73..f320de0c29c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -106,10 +106,21 @@ stages:
>      # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if n=
ot
>      - export PATH=3D/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
>        export PYTHONPATH=3D/tmp/uboot-test-hooks/py/travis-ci;
> +      python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}" =
> /dev/null 2>&1 &
> +      HTTP_PID=3D$!
> +      sleep 1  # Give the server a moment to start
> +      if ps -p ${HTTP_PID} > /dev/null; then
> +        export HTTP_PID
> +      else
> +        unset HTTP_PID
> +      fi
>        ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_PY_E=
XTRA}
>          ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
>          --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
>          --junitxml=3D/tmp/${TEST_PY_BD}/results.xml
> +      if [[ -n "${HTTP_PID}" ]]; then
> +        kill ${HTTP_PID};
> +      fi
>    artifacts:
>      when: always
>      paths:
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
