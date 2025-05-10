Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EE9C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD6282A8B;
	Sat, 10 May 2025 13:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k1gv1hKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEEB8295C; Sat, 10 May 2025 13:25:32 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B49782A46
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5fbee322ddaso5523678a12.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876329; x=1747481129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8AUDXAXxTJB73SpZQff/JzQRvPBeJ9lnPShYrvjGoNE=;
 b=k1gv1hKtQZkIn1WpJJibFnN/F5Sw2AVMlcUkvQPcbFEqHiWYdzPQ0DlXKT68uyfhfO
 dmTTCHO7ALYEmoy6UEYS3T9zYz1GaRlcc3tN1Xrzt94Fl9lVyQNa97SwkfQBejtwUe8a
 kFj2I66qezg3HQBiwSKkDjfPmgFOQCrY65QG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876329; x=1747481129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AUDXAXxTJB73SpZQff/JzQRvPBeJ9lnPShYrvjGoNE=;
 b=GWgfJiRndkfZ5qHxoUvO8Akw/JBtd4hcvGRc85hkqMfJHuC7/66ceF2Amt5nzO0WuA
 RR3pFbuTgO998kCvwgyKVNGiJx6tc2TKhlGDFAJCPr4uYKPGQfWeFFLZnP/gjPGOBt9c
 jOyvHknjLZfvZZQmA6PBK5Ln7QYvlmpPO+tPhm3DbTxmtCgtlKlnPov/xaIsmJRgPYqh
 hiQlQu2K0k4BTpl23uWxp4Ms86FcoLFzJ0c+mNG1ngCf8fCJDVKp/FhVAFH7ir3w8L4d
 uDBbi4OFWf9srtkhUf2d4C3FiAJ2Ca40RPcjMOaIOjnnMty0ca9Sd2XhZY+M+KhBxIRW
 42Yw==
X-Gm-Message-State: AOJu0YyhmlSzOscMAUTuLenQ9UW4Ub8hrRMkfNhQEjXBC1V7OcBK1iSa
 JbA1PkSmjr2szjjngddXVWvRJNxQo6aHCKE7qRpeoQ9rx+AQQqeKCxygSrARjRkIMY7MD+Lqktx
 kWVexNgf+WIlH/pwJABtd8BlwND9+9DRsAfQS
X-Gm-Gg: ASbGncuoYJXPA/A1pghs/TmnhUfRnOkxz3IuNRoLRQmWBDePHkEB5p5As84TbtQUfAc
 enEkrJPrgLIk3ESmXssouvJUXr/3aK2UW1I5fa2ZZbRdaOXXwCjsOfFSYeo2cD8Nwh/dGA3dp9i
 Cq+UpWuqpRSNcEe/7igjYCvARtPtdSJ8fRvQ==
X-Google-Smtp-Source: AGHT+IFnZJxnuQ0XqMWMT+++Un6R1Nq+AKb9t220i6SavqmEWfdJSR4F9neUEqyrKbRlOkmC1ezVnZOHAzZabMQ8esQ=
X-Received: by 2002:a17:906:15c5:b0:ad2:212d:540e with SMTP id
 a640c23a62f3a-ad2212d5656mr442293566b.15.1746876329472; Sat, 10 May 2025
 04:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-3-trini@konsulko.com>
In-Reply-To: <20250507221112.518041-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:17 +0200
X-Gm-Features: AX0GCFsCP02q6I8MuzAPvOZWBI8lf7JbXQ0DZKbXCY513Hw0BKPbF3i3pEIhpfg
Message-ID: <CAFLszTgDc9SzBY4+V7+7hKNEEp5Xcja+1NDkj9rhnMR7gWZZdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: pytest: Framework for documenting tests and
 document test_000_version
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 00:11, Tom Rini <trini@konsulko.com> wrote:
>
> In order to easily document pytests, we need to include the autodoc
> extension. We also need to make sure that for building the docs, CI
> includes pytest and that we have PYTHONPATH configured such that it will
> find all of the tests and related files. Finally, we need to have our
> comments in the test file by in proper pydoc format in order to be
> included in the output.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  .azure-pipelines.yml                    |  2 +-
>  .gitlab-ci.yml                          |  2 +-
>  Makefile                                |  3 ++-
>  doc/conf.py                             |  2 +-
>  doc/develop/pytest/index.rst            |  8 ++++++++
>  doc/develop/pytest/test_000_version.rst |  8 ++++++++
>  test/py/tests/test_000_version.py       | 10 ++++++----
>  7 files changed, 27 insertions(+), 8 deletions(-)
>  create mode 100644 doc/develop/pytest/test_000_version.rst

Thank you for doing this.

>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 5e1938b05262..9c136513bb9e 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -92,7 +92,7 @@ stages:
>            set -e
>            python3 -m venv /tmp/venvhtml
>            . /tmp/venvhtml/bin/activate
> -          pip install -r doc/sphinx/requirements.txt
> +          pip install -r doc/sphinx/requirements.txt pytest
>            make htmldocs KDOC_WERROR=1
>            make infodocs
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6f11331514b8..7aadd5d8b735 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -164,7 +164,7 @@ docs:
>    script:
>      - python3 -m venv /tmp/venvhtml
>      - . /tmp/venvhtml/bin/activate
> -    - pip install -r doc/sphinx/requirements.txt
> +    - pip install -r doc/sphinx/requirements.txt pytest
>      - make htmldocs KDOC_WERROR=1
>      - make infodocs
>
> diff --git a/Makefile b/Makefile
> index 15c7e633b874..bd136a48982a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2448,7 +2448,8 @@ DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
>                linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
>  PHONY += $(DOC_TARGETS)
>  $(DOC_TARGETS): scripts_basic FORCE
> -       $(Q)$(MAKE) $(build)=doc $@
> +       $(Q)PYTHONPATH=$(srctree)/test/py/tests:$(srctree)/test/py \
> +       $(MAKE) $(build)=doc $@
>
>  PHONY += checkstack ubootrelease ubootversion
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 3cb9b2bb65e5..84d028feda83 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -48,7 +48,7 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
>                'maintainers_include', 'sphinx.ext.autosectionlabel',
>                'kernel_abi', 'kernel_feat', 'sphinx-prompt',
> -              'sphinx_reredirects' ]
> +              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
>
>  #
>  # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
> diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
> index 435d84fc619f..ca45e157d3be 100644
> --- a/doc/develop/pytest/index.rst
> +++ b/doc/develop/pytest/index.rst
> @@ -10,3 +10,11 @@ General
>     :maxdepth: 1
>
>     usage
> +
> +Individual tests
> +----------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   test_000_version
> diff --git a/doc/develop/pytest/test_000_version.rst b/doc/develop/pytest/test_000_version.rst
> new file mode 100644
> index 000000000000..09e9a361729b
> --- /dev/null
> +++ b/doc/develop/pytest/test_000_version.rst
> @@ -0,0 +1,8 @@
> +test_000_version
> +================
> +
> +.. automodule:: test_000_version
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:
> diff --git a/test/py/tests/test_000_version.py b/test/py/tests/test_000_version.py
> index b95ceae23465..63d392e956e0 100644
> --- a/test/py/tests/test_000_version.py
> +++ b/test/py/tests/test_000_version.py
> @@ -2,10 +2,12 @@
>  # Copyright (c) 2015 Stephen Warren
>  # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
>
> -# pytest runs tests the order of their module path, which is related to the
> -# filename containing the test. This file is named such that it is sorted
> -# first, simply as a very basic sanity check of the functionality of the U-Boot
> -# command prompt.
> +"""
> +pytest runs tests the order of their module path, which is related to the

in the order

> +filename containing the test. This file is named such that it is sorted
> +first, simply as a very basic sanity check of the functionality of the U-Boot
> +command prompt.
> +"""
>
>  def test_version(ubman):
>      """Test that the "version" command prints the U-Boot version."""
> --
> 2.43.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
