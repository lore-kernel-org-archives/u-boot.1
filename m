Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2637C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 07:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066D481E72;
	Mon, 19 May 2025 09:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KZGkRBVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EC981F66; Mon, 19 May 2025 09:27:35 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68CD803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 09:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriano.cordova@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2ADC0405DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1747639653;
 bh=nWdd9zXKFEkJ0CCxp/MYBdBsOJkEp+o+z+RtmS4Aeto=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=KZGkRBVdyieXe6OKxWdj97L7cB0CrBXHCgTiHN2ijv/Mo/E054VcmhaaT7x8ptbtt
 OTy7iVYCIAxR8uPt8KJHrZhLPEzuEuO6RotVquRGtHN1X43pPTSkkG8U9RlvfTRhl/
 QwBSyFqABifGOTkM7Gn+zZSTQ6SM1FEEUwf5DmfnTXh+iNC/VGvNcdn/M8BYbO1qti
 UVv3CrhAZgb3MzmQL7bgxLqNXyBB9X0j7EDI0Ywrtxr2LYtYcaXr3dBIsnAjwLNG1P
 pxX5/8DgTyMvDMOTiVQrXRvcA/uM+AvO/k0t4vtOhir+AP7BxZiK73c1z+ZcY6JJ7k
 E5is1k0Q45H6Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so29118765e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 00:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747639652; x=1748244452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWdd9zXKFEkJ0CCxp/MYBdBsOJkEp+o+z+RtmS4Aeto=;
 b=Vb4dY9bnYZiij4aECYxdaDCgfxmFPn6k9fTLKTkf4Y8Pipv4gJt6ZpdEF4DSmBAdT3
 fLwmDGa+juiaQitmBlELSuET+ql2HGNvZPxAYiLm3HR9qy6VBI4oA66vJSAL476pzgv2
 ZE1L2KM8t2BSl0KbH1pAKtDQK4OOr/A84uP1kFXV46yyjGv3exdi9Dpaujhc0+To57uR
 PAaIP/SuYmWxxaPyurHCbLyfykqS3tiPOH/Y7ipOWZ7ntXY1Dab/5fmC3u9oj+cSwhKe
 Tz2iRKU33kS2wVj0YOyT5GGRGLky6qyAbLjHSkC8vWAl/mUphwvaTQ7TmIXmoe5cBdc1
 fSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbRQw6kqWke5D33kCuDbvnW0aqUFUFTsToHFv+dO8gBG0mlo1SJEX0nbWVmwCP0xpr/IK10xw=@lists.denx.de
X-Gm-Message-State: AOJu0YxIw5uFZG05Mr+IIKMZZ/Zix/QdMqv95NxnBwUgoqLasbQOIN9Y
 +qSQP+WeHp4SjhGs1UEoXCw46LTkYDTpS0+q5VPWjCkIpi7tCE22SPNqkHNd3G56H2HeEV72wAi
 wcindvTOWteUljzDkN6xb+sJJ2CtnccpLXEx8izP2FfRFMhOL0D8lnW5Vk1wb3SLm+pGeZCFX37
 qav2x98DvYfVf5N3HBOVrZoQOz61VcF+/tNPe4rR2Ye26R0w==
X-Gm-Gg: ASbGncvBNcwAtxwl2f09cWIZa9w1wZPkklMIluxIGGmKh51OWPTJOdlIJ5uuLJSyegm
 ZCg2YunpGalbvyq2bqiNHQqYr8+Uasedio9cFRk4QBqer7d+79la1MJs+GN6NY1opA1+/
X-Received: by 2002:a5d:598f:0:b0:3a0:830e:d1a8 with SMTP id
 ffacd0b85a97d-3a35ffd2ac0mr9668001f8f.46.1747639651643; 
 Mon, 19 May 2025 00:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUK+M+M4npOLu6P+Bb9nv/V16YKOEw6uf8ELjdjeKY/zvv1hW+VFlrgaBlnMhHyqlIlCxjHUbHdA9Zrqmx6tE=
X-Received: by 2002:a5d:598f:0:b0:3a0:830e:d1a8 with SMTP id
 ffacd0b85a97d-3a35ffd2ac0mr9667981f8f.46.1747639651334; Mon, 19 May 2025
 00:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
 <20250514161841.3591411-2-adriano.cordova@canonical.com>
 <CAC_iWjKYPFWcCCXe-RTeU0Q2A+2ku-JzE3A7z1yG_UWDk_ecuw@mail.gmail.com>
In-Reply-To: <CAC_iWjKYPFWcCCXe-RTeU0Q2A+2ku-JzE3A7z1yG_UWDk_ecuw@mail.gmail.com>
From: Adriano Cordova Fedeli <adriano.cordova@canonical.com>
Date: Mon, 19 May 2025 03:28:28 -0400
X-Gm-Features: AX0GCFt1B_h0aNa8hMAQaNOiKCOMsfEgYpmuEfCUQyhQsIP1IZTvmAC_Ki8xYV0
Message-ID: <CAFQa3M+21wpHZw09hD9ap3zMKOY+ES=34DDLLjLMWbk9L-21QA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI testing: add http server to CI tests
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, 
 sjg@chromium.org, trini@konsulko.com, jerome.forissier@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thanks for the review, but please use the v4 of this series.

On Mon, 19 May 2025 at 03:06, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Wed, 14 May 2025 at 19:17, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Add an http server to CI tests so that HTTP booting and
> > loading can be tested.
> >
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> >
> > changes in v2:
> >   - Remove HTTP_SERVER argument for test.py
> >
> >  .azure-pipelines.yml | 11 +++++++++++
> >  .gitlab-ci.yml       | 11 +++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index 9c136513bb9..334cf27cfb5 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -316,9 +316,20 @@ stages:
> >            fi
> >            export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
> >            export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
> > +          python3 -m http.server 80 --directory
> "\${UBOOT_TRAVIS_BUILD_DIR}" > /dev/null 2>&1 &
> > +          HTTP_PID=\$!
> > +          sleep 1  # Give the server a moment to start
> > +          if ps -p \${HTTP_PID} > /dev/null; then
> > +            export HTTP_PID
> > +          else
> > +            unset HTTP_PID
> > +          fi
> >            # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k
> \$var" if not
> >            ./test/py/test.py -ra -o
> cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD}
> \${TEST_PY_ID} \${TEST_PY_EXTRA} \${TEST_PY_TEST_SPEC:+"-k
> \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir
> "\$UBOOT_TRAVIS_BUILD_DIR"
> --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
> >            # the below corresponds to .gitlab-ci.yml "after_script"
> > +          if [[ -n "\${HTTP_PID}" ]]; then
> > +            kill \${HTTP_PID};
> > +          fi
> >            rm -rf /tmp/uboot-test-hooks /tmp/venv
> >            EOF
> >        - task: CopyFiles@2
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 7aadd5d8b73..f320de0c29c 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -106,10 +106,21 @@ stages:
> >      # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if
> not
> >      - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
> >        export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
> > +      python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}"
> > /dev/null 2>&1 &
> > +      HTTP_PID=$!
> > +      sleep 1  # Give the server a moment to start
>
This comment is removed in v4 as it is not correct yaml

> > +      if ps -p ${HTTP_PID} > /dev/null; then
> > +        export HTTP_PID
> > +      else
> > +        unset HTTP_PID
> > +      fi
> >        ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID}
> ${TEST_PY_EXTRA}
> >          ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
> >          --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
> >          --junitxml=/tmp/${TEST_PY_BD}/results.xml
> > +      if [[ -n "${HTTP_PID}" ]]; then
> > +        kill ${HTTP_PID};
> > +      fi
> >    artifacts:
> >      when: always
> >      paths:
> > --
> > 2.48.1
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
