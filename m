Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A75CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DABB848BA;
	Tue, 16 Jun 2026 16:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CitiRjzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35398848A6; Tue, 16 Jun 2026 16:29:47 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E476184869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e718d46a6aso2608482a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620183; x=1782224983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ysfmXTonCVHa83qna1ffO7nI0fotImf5CgrsI3paImA=;
 b=CitiRjzyTo50bCM3ccb93r27cqUobiyZmH3txq57XBlc25SW5nQ6NnAV/XKyG6lETw
 y6Nr07ODjFgLU5eELdDFrt9DqG6gaWZkpNUj+AlOWzswCvZxhuJv9uTbhl9AIMT/aB4w
 UOQ/nisUVdLeBiqdIOXPfr9v5gt5TMfpp2ok4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620183; x=1782224983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysfmXTonCVHa83qna1ffO7nI0fotImf5CgrsI3paImA=;
 b=hgqmYd+nK8JummfhJjtrGs+SIl7bSFu//Y1YThYpvlE6KSMDxHkXkT4mtsirfBrcwp
 0sKHhFY7CXHNJSgbxumLnusc51Cch6AYUwSo3Ivg9aPT2OUfPH2VxVI2olFSPeF0qLWv
 QShWqUJsofCbo4tVW3jnh4wFadCYYYjs4xLC4RieHITe+Fqf122jFf4i9DtFQ3X1iiX4
 qYuM7DUTxYqYKRcQkmcU7uYeIONBFJCsm3Oul4Lz5oJIl7ALZKhb5DxooAcKbByNh+XN
 JX/epmao9Qg7Y/yoqHnlDSrtk6n5iBiv/FCO+C0qQRx4WjE3afCVMzJHThzYGjPzreW0
 uxAg==
X-Gm-Message-State: AOJu0Ywzcn1tycMk1KivdtWzpy9/ZX4T+6TCEgwaVFMO6jdwDze1IRD+
 vxkFFyLmaXBnp+jrdHK9goWl3oPZomV8o7YsxLJ7Pd7Dsbc9RmlpFeQLmBNf/+6I13yyCtf751w
 6vQw=
X-Gm-Gg: Acq92OHgh0YYwkXj76z3FAM/V7RRzrJnGnfBC3ev3kS76jQlzCMd4hjUP58BBkAiBgG
 CA4cbEFSVcxi6349X509eXu8k0jEtF4og+JqEV+LNKSSZfy+WOZCifg16VG8xGtxPy8bdmdcWX4
 oQf80iclLwgFhw9/NXtQC/vCkHCykQb23yaPmCFlm3ziks1BsF+3zlYF0XfxODcyXE+/BrhPufb
 206Ju94ofSxskTSguHRQRtjY5lgydeMBNJXczMu/ZkTEtusTRfkfHdcFNWtVcd2g1+72HNpyvwj
 7pazE8DpwDgkxyMI7hxHdKlQziJN7YSTt88jKYamzl91KIiCX4p22jZQWm2ft8J7u9oMyjTfr9Y
 V431kVphGzaqHFs24SqfaRSTF/qz/a6znoj57Msq0kOjw3zNHT8MUvNIt1fsECKi1msmZfiqcDC
 vEvqhubZjeOuOJS4I2HA==
X-Received: by 2002:a05:6830:2117:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7e8fe591f72mr4084951a34.24.1781620183610; 
 Tue, 16 Jun 2026 07:29:43 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:29:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, E Shattow <e@freeshell.de>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 0/9] Remove patman from the U-Boot tree
Date: Tue, 16 Jun 2026 08:28:40 -0600
Message-ID: <20260616142859.54136-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

patman is now maintained as a standalone 'patch-manager' package, so
remove it from the tree. The command becomes a stub that tells people to
run 'pip install patch-manager'.

buildman still imports the shared modules commit and patchstream (along
with their dependencies), so this series leaves those in place. It drops
the tool's code, tests, CI hooks and packaging, and cuts the in-tree
documentation down to a stub that points at the package. It also moves
setuptools to u_boot_pylib, since pylibfdt needs it to build and
patman's requirements currently supply it.

More could be done here: commit and patchstream (and their dependencies
series, get_maintainer and settings) only remain because buildman still
imports them. A follow-up could move those into u_boot_pylib (or
buildman itself) and drop the rest, leaving tools/patman as just the
stub.


Simon Glass (9):
  patman: Replace the tool with a stub for patch-manager
  patman: Remove the test suite
  patman: Remove the patch-management code
  u_boot_pylib: Require setuptools for building pylibfdt
  patman: Replace the documentation with a stub
  CI: Stop building and testing patman
  tools: docker: Drop patman from the CI image
  tools: Stop packaging patman as a pip module
  test: Stop running the patman tests

 .azure-pipelines.yml                          |    5 +-
 .gitlab-ci.yml                                |    7 +-
 Makefile                                      |    1 -
 doc/develop/driver-model/spi-howto.rst        |    5 +-
 doc/develop/patman.rst                        |   15 +-
 doc/develop/sending_patches.rst               |    4 +-
 doc/develop/testing.rst                       |    2 +-
 scripts/make_pip.sh                           |   10 +-
 test/run                                      |    1 -
 tools/binman/pyproject.toml                   |    2 +-
 tools/docker/Dockerfile                       |    2 -
 tools/patman/README.rst                       |    1 -
 tools/patman/__init__.py                      |    5 +-
 tools/patman/__main__.py                      |   68 +-
 tools/patman/checkpatch.py                    |  287 --
 tools/patman/cmdline.py                       |  516 ---
 tools/patman/control.py                       |  333 --
 tools/patman/cser_helper.py                   | 1524 -------
 tools/patman/cseries.py                       | 1165 ------
 tools/patman/database.py                      |  823 ----
 tools/patman/func_test.py                     | 1342 ------
 tools/patman/patchwork.py                     |  852 ----
 tools/patman/patman.rst                       | 1023 -----
 tools/patman/project.py                       |   27 -
 tools/patman/pyproject.toml                   |   29 -
 tools/patman/pytest.ini                       |    2 -
 tools/patman/requirements.txt                 |    6 -
 tools/patman/send.py                          |  197 -
 tools/patman/setup.py                         |   11 -
 tools/patman/status.py                        |  405 --
 tools/patman/test/0000-cover-letter.patch     |   23 -
 .../0001-pci-Correct-cast-for-sandbox.patch   |   51 -
 ...-for-sandbox-in-fdtdec_setup_mem_siz.patch |   85 -
 tools/patman/test/test01.txt                  |   72 -
 tools/patman/test_checkpatch.py               |  526 ---
 tools/patman/test_common.py                   |  254 --
 tools/patman/test_cseries.py                  | 3684 -----------------
 tools/patman/test_settings.py                 |   67 -
 tools/u_boot_pylib/requirements.txt           |    2 +
 39 files changed, 55 insertions(+), 13379 deletions(-)
 mode change 120000 => 100644 doc/develop/patman.rst
 delete mode 120000 tools/patman/README.rst
 delete mode 100644 tools/patman/checkpatch.py
 delete mode 100644 tools/patman/cmdline.py
 delete mode 100644 tools/patman/control.py
 delete mode 100644 tools/patman/cser_helper.py
 delete mode 100644 tools/patman/cseries.py
 delete mode 100644 tools/patman/database.py
 delete mode 100644 tools/patman/func_test.py
 delete mode 100644 tools/patman/patchwork.py
 delete mode 100644 tools/patman/patman.rst
 delete mode 100644 tools/patman/project.py
 delete mode 100644 tools/patman/pyproject.toml
 delete mode 100644 tools/patman/pytest.ini
 delete mode 100644 tools/patman/requirements.txt
 delete mode 100644 tools/patman/send.py
 delete mode 100644 tools/patman/setup.py
 delete mode 100644 tools/patman/status.py
 delete mode 100644 tools/patman/test/0000-cover-letter.patch
 delete mode 100644 tools/patman/test/0001-pci-Correct-cast-for-sandbox.patch
 delete mode 100644 tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
 delete mode 100644 tools/patman/test/test01.txt
 delete mode 100644 tools/patman/test_checkpatch.py
 delete mode 100644 tools/patman/test_common.py
 delete mode 100644 tools/patman/test_cseries.py
 delete mode 100644 tools/patman/test_settings.py

---
base-commit: 7c290d20cd8a9f3ae1700a0707c774e9b83f7f27
branch: patm

-- 
2.43.0

