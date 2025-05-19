Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DC3C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 07:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E53481E72;
	Mon, 19 May 2025 09:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RXB4rndT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667C181F66; Mon, 19 May 2025 09:29:16 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA03803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 09:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7082ad1355bso33516777b3.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747639753; x=1748244553; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRPcjKMiJmjLuxckEuBVvM2bcstLhSnr5ZfXh5WXz78=;
 b=RXB4rndTtzPjYds/6UkLEdGJdaS6v+8PapSWncFpsipBdIvONCPspmW77u1jidvf3z
 v7t8yf5ORLkmVVPWNmG/KxJbQXn92mG2RFkvbecNQ93dwaymx4MGpCf+J/TWeZgYoN0w
 ntV0WOWusV0G5tAdtD+n9570jOWBVyl61SdKJ0sWTMxKayS4hKU8AdylGCZaVS3jdE4G
 78c5m/5GM/sQXWZ26Q3NgLJUhZy3FpT0QOKvGjAuktKKpT22yGNvCzFCWkzPZ86HnR/n
 Atox5oFj4yzTom2Hdnf92HiUJp3iVNgvGRybhkkOa2DN+JP9uy5BuS2npGNSzhmGjiU0
 rXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747639753; x=1748244553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRPcjKMiJmjLuxckEuBVvM2bcstLhSnr5ZfXh5WXz78=;
 b=agnwyuC80FqEsnRLw6y3PPtAz8nupWn0UVVpWFOHgr5JH1gRUCVfTNKsWLlA53ThMC
 hws2Gu+pTzl6jh0k0/PEu/yQnN/Q4kd5AYp15Tc8miDgqQd4MZGitG3hSiP/tkA+071W
 n+ilvfI/xwhcURDQR8lubBg9N/ZuVSs/VjU+GJW8IgyuGp6PHyc/OvawHOLZ+wYFmUC7
 g3/F5w8IWTrobW54xBDR18ZTyLVuQh+59rzdP5UKaMbPMwj17bliOyFkb+TOz8I+6YG7
 s6DN/U9V4QUFBk5Tot4lYCDCTXhrdt2ZENfn7azE4yZBDr8eyHlZCI8bNQwQH35ZxwOi
 NZmQ==
X-Gm-Message-State: AOJu0YzYHggNVh3NPp2WkG6ram2w5DvT/hSL6tuznGY5DQarWMbl06S6
 51mMOiSmpTEzFHhvB/9z/oOkc01+npbFiXWNAR9BqeBBR6LfpktQkQN5o8F99kghST/s6/KrZ0Y
 QuLnH/yb7fhwZCWJ+5o/96raZ5miio8jPJ0a7EYKzSWJQtfPLFNKORys=
X-Gm-Gg: ASbGnctyy2okIli+5cVZ/yR4LvjQDUTXkCDQ3lfbWWA9tjKrls08lsbRryat+8LHrHV
 zjh4L7myhmDC8PAtJrGfprbv6RDXGYAA0YrYo4y7VQ2AV5hCiCBCgrfVfb5Ly8c/AmIaHxXUyx0
 ivb6E2dqB/XXx4SEPBt4pCgZRZrANCs0Y+yw==
X-Google-Smtp-Source: AGHT+IEiVVWhfStSmpQTxVsYOM/O71HTrYGsiUSDZFYyYPEKosebkIsUx7ORrjj92qgV40X8tuR6n3FFQN36qzmoSKs=
X-Received: by 2002:a05:690c:3389:b0:703:b5ae:a3da with SMTP id
 00721157ae682-70ca7b8fd45mr184937727b3.32.1747639752689; Mon, 19 May 2025
 00:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250516085256.30386-1-adriano.cordova@canonical.com>
 <20250516085256.30386-2-adriano.cordova@canonical.com>
In-Reply-To: <20250516085256.30386-2-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 10:28:36 +0300
X-Gm-Features: AX0GCFsJgXX35ctb5HVH9f2bIvBh8K4f0znHzyYJbxk6Vk-_EhrD503GVRroucM
Message-ID: <CAC_iWj+OAxGfzzLDCePb3=0CyFpzHo1bA_B+nWmoMBmDH3x-hQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] CI testing: add http server to CI tests
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com, 
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

On Fri, 16 May 2025 at 11:52, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add an http server to CI tests so that HTTP booting and
> loading can be tested.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> changes in v2:
>   - Remove HTTP_SERVER argument for test.py
>
> changes in v4:
>   - Remove comment in .gitlab-ci.yml that was preventing
>     parsing
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
> index 7aadd5d8b73..88f7861656e 100644
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
> +      sleep 1
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
