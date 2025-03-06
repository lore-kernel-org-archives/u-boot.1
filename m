Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEBBC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703A781298;
	Thu,  6 Mar 2025 17:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JNivqNsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6895C810DC; Thu,  6 Mar 2025 17:03:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAB080E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741276983; x=1741881783; i=xypron.glpk@gmx.de;
 bh=4q7kkQ5tFqf8l7SkYnk4q/dUv0ptF5e3kOKs243XHFU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JNivqNsbAvPmy7OObBjsLY7/rBdKgL4z8j4YHZQG4eOL5QdI9IcbvIsOCD4+V8ox
 +C9PJWFFcoeoSdZ+bIxv4vGnuQD7rxwpCcPckK9+YVD6GO2MLCVL5SzD4ZmphokiS
 fjUcTXoY/GbSQjdfMPxR84T/O3pcNnhJWWBmkuKZVKcFnZEiwaT7JMrHO/WPfHNcn
 laNBLKFaRUWx1JAmtHK4+ALsLCsx5UNi4DwKQB6jIz5AfGCpRCbM2IVjOTKJkO3JU
 fHeOSiShqpG1zLmir11iEuc1bLfAl7L9YPMqh3Eoa5UaYjCoX4nyYJWBW+iVPAdCy
 0xudZCfX5FO30CDvNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1tmLo447Uo-00ShiZ; Thu, 06
 Mar 2025 17:03:03 +0100
Message-ID: <a83e7acd-7345-4a51-9720-568226a2767b@gmx.de>
Date: Thu, 6 Mar 2025 17:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] doc: Include pytests directly in documentation
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250225205003.2640910-1-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250225205003.2640910-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4okyiHHylT0VO2JI/yKmkj7OlOy2zDTI3u2DLrSqCw4UU+O6jde
 DrPvnuo3EalRys4sYg71P05tfE1wJVs/AGBi0yV08+zBGJsECGwxfbYiQ8x+mpn9JhJH3hW
 LNfMj62ATH3n8Mwo3ZSizMFd+Uygfzjvr/hITaSrsevaTfQkN5biFKq1lh9pXo7Irce/CKf
 GGyxqlI0YmlAcoPSvfZQg==
UI-OutboundReport: notjunk:1;M01:P0:JhRQYND0nuk=;OMh8pXwqKQwGYiZmURKyePMcGoc
 uxCIqZU5qZ68PTgvd7dwLvRbsO+Rknvjac41yoIFujZlanDCdxiOXSx3dS4T7ofd4iFAbbVHv
 5mQIF7XTR9maMKo152D5LfGlaZvSTlekpDJ1jICwWRJi1NwMNsQPbpyF7M2b5n3NE0WLSIheO
 yOCabGnv9ShqDuPdVO9SzKPdfMOxuPtHiZtQthKoRQyM41ocmE3IAS02kowg2ngLxlSJoqxZl
 qnT8B9RVLUobBF6Q/w4vr4Cr8Au5grzRFhLaVWTXpRG4C088ndl3ZJs7DVV5BkreDSYh+C3Rx
 BfxGFAw36KxpNK40QddFaqEMo69FlPZH8NiocofOOhbxTW9EnnLlYNzCZJrrjLFzIEW3f5Haf
 B/88eMTCQ4nGsf3MbEkATRPk0BMmAIWLlWOPb4pWpmLKqXlfWy3h3YXWHe5F1LYYTZXRTWvfR
 4GilB5dvkBj7yWmsKLAjumqfgifb3xLgBZ0EJuXcnAQJH/sltxZVe+EjQT24Q9PIjA2WrBzst
 06Ui1IAkpwvoq1eWFrDtOOqVfHOWnGexri4jdxtv5epZsdHMQBgv8KPbSC4vFGFCvcXrp4Tv6
 EYhzUVMUeqcRNrD62cIOBpCYyRoLuTIn4mQ5G1jRglMIKR+eoRg5jrpca0keT/ygZeBXRxSUK
 9TxxYbVoqHs4YX2jH4zZkMCaOyUqfWBgpW+W2sqZ+Ub358Dy+f1u73QgfoVZ6dCP27MhvF+ki
 T///Ne8C16+A769qZypzcxcVrPEHLrwLQwpcjgQYBwFxw19gwuEN/+sxyY+Sk4wp1NjIhnMBp
 8RUppSTKXJdHHPpmxcfmP/Pi5vwKamIsb/iYbdUzhdarphpg9lrN7SybrpXU/wFhslnSr40Q8
 Qb75M9J6jP/mPDHStzDwnCXY7FCnkGEJt5F80ghxNtQYWkE2ZEU39D1Kzb0fBQSbtneqdoxwn
 fH/X91+wepq3cKCVT1Y5A50Y04vrOnEfkEGZOhtxMBAfSkxWKSXQvl8Pvsg7v6jVfRqByN7dw
 uMwo2ljwml5jwLZdh2UNP8bGr1PPQJ5NMtW1aAfCBD+vwGxxiu5zPEYlxJEosaNBWV/cq98+x
 3SUyk7AG5yHSXBrGdo9fbh/boFVkeKthqUltotctSPQfze7d25HU7L8Li8FnccApa27AVnDu7
 Bi0HlbysWLZB73B5/c9v690uWUmuKc04L+m7reQaaJEqzBK/cGCH3SjLuNlHI+T9Vd+n81Jje
 dhoWpSHyKUyGg/kC6pZQwk4MScbmgXzQ/6klstvQOWarWxn+cl16mNKCulW1iLpEN/LdaCxBJ
 YwDfWH6gOZoMQMyqoD6zqCkzfiG9oJ5fG1boLMTqpyR7YpWHgn/tFcSMqkqFDBvmkwxbwaXPa
 ZtuJ8j6rwnmVTieiruo1CujIdzJCQupb6InOwNjxQY6FnLHSRLTZZYDh0F
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

On 25.02.25 21:50, Tom Rini wrote:
> As there is support within the Sphinx framework to take Python
> docstrings and generate documentation from it, we can make use of that
> to more clearly and consistently document our pytests and how to
> configure them. To do this we:
> - Add PYTHONPATH to DOC_TARGETS so that modules will be found, have CI
>    install pytest module as well.
> - Add the autodoc extension for Python and then redirects so we can move
>    py_testing.html (which is heavily referenced in archives, etc).
> - Create a doc/develop/pytest directory and move the existing py_testing
>    file there, update references.
> - Update the test_000_version.py test to have a docstring
> - Move the imports in test_net_boot.py so the docstring is in the
>    correct place.
> - Use code-block for all of the code blocks in test_net_boot.py so they
>    are rendered correctly in documentation.
>    - Adding these code-block lines makes the diff larger when read but a
>      "git show -w" for example makes it clearer that the textual changes
>      are removing '#' from lines so the output reads nicer.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Some of the test functions seem to lack documentation:

test_net_boot.setup_networking()
test_net_boot.setup_tftpboot_boot()

Would you know what 000 in the following filename corresponds to?

test/py/tests/test_000_version.py

Maybe we should rename to test_version.py it before adding this patch.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
>
> As this is a RFC, I didn't split it up as much as it needs to be as I'm
> looking for some feedback on the concept.
> ---
>   .azure-pipelines.yml                          |   2 +-
>   .gitlab-ci.yml                                |   2 +-
>   Makefile                                      |   3 +-
>   doc/conf.py                                   |   8 +-
>   doc/develop/ci_testing.rst                    |   2 +-
>   doc/develop/index.rst                         |   2 +-
>   doc/develop/pytest/index.rst                  |  21 +++
>   doc/develop/pytest/test_000_version.rst       |   8 +
>   doc/develop/pytest/test_net_boot.rst          |   8 +
>   .../{py_testing.rst =3D> pytest/usage.rst}      |   2 +-
>   doc/develop/testing.rst                       |   4 +-
>   doc/develop/tests_writing.rst                 |   2 +-
>   doc/sphinx/requirements.txt                   |   1 +
>   test/py/tests/test_000_version.py             |  10 +-
>   test/py/tests/test_net_boot.py                | 163 ++++++++++--------
>   15 files changed, 150 insertions(+), 88 deletions(-)
>   create mode 100644 doc/develop/pytest/index.rst
>   create mode 100644 doc/develop/pytest/test_000_version.rst
>   create mode 100644 doc/develop/pytest/test_net_boot.rst
>   rename doc/develop/{py_testing.rst =3D> pytest/usage.rst} (99%)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index d5cfa59a8a61..e401e5cf99b4 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -92,7 +92,7 @@ stages:
>             set -e
>             virtualenv -p /usr/bin/python3 /tmp/venvhtml
>             . /tmp/venvhtml/bin/activate
> -          pip install -r doc/sphinx/requirements.txt
> +          pip install -r doc/sphinx/requirements.txt pytest
>             make htmldocs KDOC_WERROR=3D1
>             make infodocs
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 64f92f8b5b9d..083f67695081 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -156,7 +156,7 @@ docs:
>     script:
>       - virtualenv -p /usr/bin/python3 /tmp/venvhtml
>       - . /tmp/venvhtml/bin/activate
> -    - pip install -r doc/sphinx/requirements.txt
> +    - pip install -r doc/sphinx/requirements.txt pytest
>       - make htmldocs KDOC_WERROR=3D1
>       - make infodocs
>
> diff --git a/Makefile b/Makefile
> index 93fa86a18705..e2e452ae4aa0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2445,7 +2445,8 @@ DOC_TARGETS :=3D xmldocs latexdocs pdfdocs htmldoc=
s epubdocs cleandocs \
>   	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
>   PHONY +=3D $(DOC_TARGETS)
>   $(DOC_TARGETS): scripts_basic FORCE
> -	$(Q)$(MAKE) $(build)=3Ddoc $@
> +	$(Q)PYTHONPATH=3D$(srctree)/test/py/tests:$(srctree)/test/py \
> +	$(MAKE) $(build)=3Ddoc $@
>
>   PHONY +=3D checkstack ubootrelease ubootversion
>
> diff --git a/doc/conf.py b/doc/conf.py
> index c50daf874a53..a935d674aae9 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -47,7 +47,8 @@ needs_sphinx =3D '2.4.4'
>   extensions =3D ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                 'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
>                 'maintainers_include', 'sphinx.ext.autosectionlabel',
> -              'kernel_abi', 'kernel_feat', 'sphinx-prompt']
> +              'kernel_abi', 'kernel_feat', 'sphinx-prompt',
> +              'sphinx.ext.autodoc', 'sphinx_reredirects' ]
>
>   #
>   # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *mos=
t*
> @@ -148,6 +149,11 @@ project =3D 'Das U-Boot'
>   copyright =3D 'The U-Boot development community'
>   author =3D 'The U-Boot development community'
>
> +# Pages we have moved after being heavily referenced externally
> +redirects =3D {
> +    "develop/py_testing": "pytest/usage.html"
> +}
> +
>   # The version info for the project you're documenting, acts as replace=
ment for
>   # |version| and |release|, also used in various other places throughou=
t the
>   # built documents.
> diff --git a/doc/develop/ci_testing.rst b/doc/develop/ci_testing.rst
> index ffaacedc3d88..2033e3447e9e 100644
> --- a/doc/develop/ci_testing.rst
> +++ b/doc/develop/ci_testing.rst
> @@ -18,7 +18,7 @@ be built with mingw to run on Windows.
>   Each of the pipelines is written in such as way as to be a "world buil=
d" style
>   test and as such we try and build all possible platforms.  In addition=
, for all
>   platforms that support being run in QEMU we run them in QEMU and use o=
ur pytest
> -suite.  See :doc:`py_testing` for more information about those tests.
> +suite.  See :doc:`pytest/usage` for more information about those tests.
>
>   Azure Pipelines
>   ---------------
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index d9f2a8382077..131e5fb3188f 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -81,7 +81,7 @@ Testing
>      :maxdepth: 1
>
>      testing
> -   py_testing
> +   pytest/index
>      tests_writing
>      tests_sandbox
>      binman_tests
> diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
> new file mode 100644
> index 000000000000..36083882584f
> --- /dev/null
> +++ b/doc/develop/pytest/index.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +pytest Framework within U-Boot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +General
> +-------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   usage
> +
> +Individual tests
> +----------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   test_000_version
> +   test_net_boot
> diff --git a/doc/develop/pytest/test_000_version.rst b/doc/develop/pytes=
t/test_000_version.rst
> new file mode 100644
> index 000000000000..09e9a361729b
> --- /dev/null
> +++ b/doc/develop/pytest/test_000_version.rst
> @@ -0,0 +1,8 @@
> +test_000_version
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: test_000_version
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:
> diff --git a/doc/develop/pytest/test_net_boot.rst b/doc/develop/pytest/t=
est_net_boot.rst
> new file mode 100644
> index 000000000000..369bd3b809cf
> --- /dev/null
> +++ b/doc/develop/pytest/test_net_boot.rst
> @@ -0,0 +1,8 @@
> +test_net_boot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: test_net_boot
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:
> diff --git a/doc/develop/py_testing.rst b/doc/develop/pytest/usage.rst
> similarity index 99%
> rename from doc/develop/py_testing.rst
> rename to doc/develop/pytest/usage.rst
> index b50473039be4..0b0038ba1899 100644
> --- a/doc/develop/py_testing.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -13,7 +13,7 @@ results. Advantages of this approach are:
>     U-Boot; there can be no disconnect.
>   - There is no need to write or embed test-related code into U-Boot its=
elf.
>     It is asserted that writing test-related code in Python is simpler a=
nd more
> -  flexible than writing it all in C. But see :doc:`tests_writing` for c=
aveats
> +  flexible than writing it all in C. But see :doc:`../tests_writing` fo=
r caveats
>     and more discussion / analysis.
>   - It is reasonably simple to interact with U-Boot in this way.
>
> diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
> index 9114d11ad26d..aa7786c99fd5 100644
> --- a/doc/develop/testing.rst
> +++ b/doc/develop/testing.rst
> @@ -33,7 +33,7 @@ You can also run a selection tests in parallel with::
>       make pcheck
>
>   All of the above use the test/run script with a paremeter to select wh=
ich tests
> -are run. See :doc:`py_testing` for more information.
> +are run. See :doc:`pytest/usage` for more information.
>
>
>   Sandbox
> @@ -69,7 +69,7 @@ build::
>
>      ./test/py/test.py --bd sandbox_spl --build -k test_spl
>
> -See :doc:`py_testing` for more information about the pytest suite.
> +See :doc:`pytest/usage` for more information about the pytest suite.
>
>   See :doc:`tests_sandbox` for how to run tests directly (not through py=
test).
>
> diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.r=
st
> index 5f3c43d5da24..2adcfb072099 100644
> --- a/doc/develop/tests_writing.rst
> +++ b/doc/develop/tests_writing.rst
> @@ -376,5 +376,5 @@ An example SPL test is spl_test_load().
>   Writing Python tests
>   --------------------
>
> -See :doc:`py_testing` for brief notes how to write Python tests. You
> +See :doc:`pytest/usage` for brief notes how to write Python tests. You
>   should be able to use the existing tests in test/py/tests as examples.
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index 13e0327c0f67..12c5772684dc 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -15,6 +15,7 @@ six=3D=3D1.16.0
>   snowballstemmer=3D=3D2.2.0
>   Sphinx=3D=3D8.1.3
>   sphinx-prompt=3D=3D1.9.0
> +sphinx-reredirects=3D=3D0.1.5
>   sphinx-rtd-theme=3D=3D3.0.1
>   sphinxcontrib-applehelp=3D=3D2.0.0
>   sphinxcontrib-devhelp=3D=3D2.0.0
> diff --git a/test/py/tests/test_000_version.py b/test/py/tests/test_000_=
version.py
> index bd089ab5439d..77effbbc38f4 100644
> --- a/test/py/tests/test_000_version.py
> +++ b/test/py/tests/test_000_version.py
> @@ -2,10 +2,12 @@
>   # Copyright (c) 2015 Stephen Warren
>   # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
>
> -# pytest runs tests the order of their module path, which is related to=
 the
> -# filename containing the test. This file is named such that it is sort=
ed
> -# first, simply as a very basic sanity check of the functionality of th=
e U-Boot
> -# command prompt.
> +"""
> +pytest runs tests the order of their module path, which is related to t=
he
> +filename containing the test. This file is named such that it is sorted
> +first, simply as a very basic sanity check of the functionality of the =
U-Boot
> +command prompt.
> +"""
>
>   def test_version(u_boot_console):
>       """Test that the "version" command prints the U-Boot version."""
> diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boo=
t.py
> index d7d74356928e..68a91ef5b518 100644
> --- a/test/py/tests/test_net_boot.py
> +++ b/test/py/tests/test_net_boot.py
> @@ -1,11 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # (C) Copyright 2023, Advanced Micro Devices, Inc.
>
> -import pytest
> -import u_boot_utils
> -import test_net
> -import re
> -
>   """
>   Note: This test relies on boardenv_* containing configuration values t=
o define
>   which the network environment available for testing. Without this, thi=
s test
> @@ -13,77 +8,88 @@ will be automatically skipped.
>
>   For example:
>
> -# Details regarding a boot image file that may be read from a TFTP serv=
er. This
> -# variable may be omitted or set to None if TFTP boot testing is not po=
ssible
> -# or desired.
> -env__net_tftp_bootable_file =3D {
> -    'fn': 'image.ub',
> -    'addr': 0x10000000,
> -    'size': 5058624,
> -    'crc32': 'c2244b26',
> -    'pattern': 'Linux',
> -    'config': 'config@2',
> -    'timeout': 50000,
> -    'check_type': 'boot_error',
> -    'check_pattern': 'ERROR',
> -}
> -
> -# False or omitted if a TFTP boot test should be tested.
> -# If TFTP boot testing is not possible or desired, set this variable to=
 True.
> -# For example: If FIT image is not proper to boot
> -env__tftp_boot_test_skip =3D False
> -
> -# Here is the example of FIT image configurations:
> -configurations {
> -    default =3D "config@1";
> -    config@1 {
> -        description =3D "Boot Linux kernel with config@1";
> -        kernel =3D "kernel@0";
> -        fdt =3D "fdt@0";
> -        ramdisk =3D "ramdisk@0";
> -        hash@1 {
> -            algo =3D "sha1";
> -        };
> -    };
> -    config@2 {
> -        description =3D "Boot Linux kernel with config@2";
> -        kernel =3D "kernel@1";
> -        fdt =3D "fdt@1";
> -        ramdisk =3D "ramdisk@1";
> -        hash@1 {
> -            algo =3D "sha1";
> -        };
> -    };
> -};
> -
> -# Details regarding a file that may be read from a TFTP server. This va=
riable
> -# may be omitted or set to None if PXE testing is not possible or desir=
ed.
> -env__net_pxe_bootable_file =3D {
> -    'fn': 'default',
> -    'addr': 0x10000000,
> -    'size': 74,
> -    'timeout': 50000,
> -    'pattern': 'Linux',
> -    'valid_label': '1',
> -    'invalid_label': '2',
> -    'exp_str_invalid': 'Skipping install for failure retrieving',
> -    'local_label': '3',
> -    'exp_str_local': 'missing environment variable: localcmd',
> -    'empty_label': '4',
> -    'exp_str_empty': 'No kernel given, skipping boot',
> -    'check_type': 'boot_error',
> -    'check_pattern': 'ERROR',
> -}
> -
> -# False if a PXE boot test should be tested.
> -# If PXE boot testing is not possible or desired, set this variable to =
True.
> -# For example: If pxe configuration file is not proper to boot
> -env__pxe_boot_test_skip =3D False
> -
> -# Here is the example of pxe configuration file ordered based on the ex=
ecution
> -# flow:
> +.. code-block:: python
> +
> +   # Details regarding a boot image file that may be read from a TFTP s=
erver. This
> +   # variable may be omitted or set to None if TFTP boot testing is not=
 possible
> +   # or desired.
> +   env__net_tftp_bootable_file =3D {
> +       'fn': 'image.ub',
> +       'addr': 0x10000000,
> +       'size': 5058624,
> +       'crc32': 'c2244b26',
> +       'pattern': 'Linux',
> +       'config': 'config@2',
> +       'timeout': 50000,
> +       'check_type': 'boot_error',
> +       'check_pattern': 'ERROR',
> +   }
> +
> +   # False or omitted if a TFTP boot test should be tested.
> +   # If TFTP boot testing is not possible or desired, set this variable=
 to True.
> +   # For example: If FIT image is not proper to boot
> +   env__tftp_boot_test_skip =3D False
> +
> +
> +Here is the example of FIT image configurations:
> +
> +.. code-block:: devicetree
> +
> +   configurations {
> +       default =3D "config@1";
> +       config@1 {
> +           description =3D "Boot Linux kernel with config@1";
> +           kernel =3D "kernel@0";
> +           fdt =3D "fdt@0";
> +           ramdisk =3D "ramdisk@0";
> +           hash@1 {
> +               algo =3D "sha1";
> +           };
> +       };
> +       config@2 {
> +           description =3D "Boot Linux kernel with config@2";
> +           kernel =3D "kernel@1";
> +           fdt =3D "fdt@1";
> +           ramdisk =3D "ramdisk@1";
> +           hash@1 {
> +               algo =3D "sha1";
> +           };
> +       };
> +   };
> +
> +.. code-block:: python
> +
> +   # Details regarding a file that may be read from a TFTP server. This=
 variable
> +   # may be omitted or set to None if PXE testing is not possible or de=
sired.
> +   env__net_pxe_bootable_file =3D {
> +       'fn': 'default',
> +       'addr': 0x10000000,
> +       'size': 74,
> +       'timeout': 50000,
> +       'pattern': 'Linux',
> +       'valid_label': '1',
> +       'invalid_label': '2',
> +       'exp_str_invalid': 'Skipping install for failure retrieving',
> +       'local_label': '3',
> +       'exp_str_local': 'missing environment variable: localcmd',
> +       'empty_label': '4',
> +       'exp_str_empty': 'No kernel given, skipping boot',
> +       'check_type': 'boot_error',
> +       'check_pattern': 'ERROR',
> +   }
> +
> +   # False if a PXE boot test should be tested.
> +   # If PXE boot testing is not possible or desired, set this variable =
to True.
> +   # For example: If pxe configuration file is not proper to boot
> +   env__pxe_boot_test_skip =3D False
> +
> +Here is the example of pxe configuration file ordered based on the exec=
ution
> +flow:
> +
>   1) /tftpboot/pxelinux.cfg/default-arm-zynqmp
>
> +.. code-block::
> +
>       menu include pxelinux.cfg/default-arm
>       timeout 50
>
> @@ -91,6 +97,8 @@ env__pxe_boot_test_skip =3D False
>
>   2) /tftpboot/pxelinux.cfg/default-arm
>
> +.. code-block::
> +
>       menu title Linux boot selections
>       menu include pxelinux.cfg/default
>
> @@ -110,6 +118,8 @@ env__pxe_boot_test_skip =3D False
>
>   3) /tftpboot/pxelinux.cfg/default
>
> +.. code-block::
> +
>       label Linux
>           menu label Boot kernel
>           kernel Image
> @@ -117,6 +127,11 @@ env__pxe_boot_test_skip =3D False
>           initrd rootfs.cpio.gz.u-boot
>   """
>
> +import pytest
> +import u_boot_utils
> +import test_net
> +import re
> +
>   def setup_networking(u_boot_console):
>       test_net.test_net_dhcp(u_boot_console)
>       if not test_net.net_set_up:

