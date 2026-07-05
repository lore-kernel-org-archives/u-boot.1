Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A5C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF36841F2;
	Sun,  5 Jul 2026 21:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gvwyEo0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFD5846F8; Sun,  5 Jul 2026 21:33:05 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E2084105
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso1131083a34.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783279981; x=1783884781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J1PewyB9A7qyRbddfOUlWIj1D4NyfokG4z5XNCMFYW8=;
 b=gvwyEo0h5X4INvjlrc1H4FTlwzgeLBoiXJyfTlF1oAkZWpVBImEAExbEZ4RYh6+FMn
 7iiZWkAuJ/CCKXUDdvv+YnBqEuc3OhMX+c/4mnBkika3vanYj6/YVdoan+Xl0Dou8G5c
 rn8BUVnlyVEt7hzDHbsLcMcx3Xen+qr2m9Cow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783279981; x=1783884781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J1PewyB9A7qyRbddfOUlWIj1D4NyfokG4z5XNCMFYW8=;
 b=FvNQbRmPQ122uMhMpJiNmglhbatrDrY89E+k68gZeeF7UGyGfHk002TsYCe2S1X+Eh
 7F2WU9byUhdMGUQK3Z2bnTRIaFEJXyb2iPoSyFZl7F0YxUfFrILNarwoE1SYWcmtOnNs
 PrMNeJrYXjPM/HDcMA/Ak9VjIIH8kLs3ax0jURDlz0aZKJ/uS95V7GQ0i9yxxfw2rx+d
 RsvhxfbpdWKZ+SrjJQM8412Q/o8+rZ/XFXMIktlilllXSMfSN2bGJEsIVPnWfDCTcy7k
 xNEXJlwKgDvyrNxSkqOwNNIPruxNVLftngzxBMmpiQd3nRAiLa+LmqrjV2jGNAFLTdb/
 PdPA==
X-Gm-Message-State: AOJu0Yx9QM1PUlOmKMcJyXkmRKDFMdn04HeXuF2REtX0/qWYhp7a963k
 zRDvnZ4v+GKKa8SWgACcTixfevoL4VNorSUZ4QH1zCuGMNUDQTvVUkMlBVq6eN30ejCqjm2EixV
 o/aWUPQ==
X-Gm-Gg: AfdE7clW9ubEFh9kzUqyCO6LXjqt9aZL0JwLVbOiPqIT262WB0nd9VS2mAPb/EALqPn
 fa5SyZEIe9SXdNFxTpVuIe9TWMxueEk1zxb8lCgQfcR+7/qrIvp3C/Jd1K2ejhMBD9oEdzkj0Jq
 sZOdK41X1Bv6kzDx+qrZJmptDsnFp4FEp6k3Rb9pdLZInu+WEBNdNKFbY0CnqvGXIcSw0QpyCbq
 VAS9715yvMFg1SYZDio4Yk4BJ3PkYJSNxz1ck1BZKt/C/dEhefZuaqVnHJLT1gDJ7LfaE24P4NT
 JWKCpf4K+d0zjuvyTPNVssVo0iZkqSiu+Ye0zVbSey9aN5Y87sSU60C3fLo69DLin88RWHKMGQO
 vN0g6mlp5+1LFFHEhQ5SbBnMwwdkPUI6MxQgKevxUxrPJYa5vZhEQ+paqaxJSFRhskYEX
X-Received: by 2002:a05:6820:c97:b0:6a1:50eb:2122 with SMTP id
 006d021491bc7-6a32f5f529cmr3824037eaf.70.1783279981389; 
 Sun, 05 Jul 2026 12:33:01 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:32:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, E Shattow <e@freeshell.de>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2 00/11] Remove patman from the U-Boot tree
Date: Sun,  5 Jul 2026 13:32:11 -0600
Message-ID: <20260705193251.2190705-1-sjg@chromium.org>
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
the tool's code, tests, CI hooks and packaging, and removes the in-tree
documentation, moving the b4 contributor guide alongside the patman note
in the patch-sending docs. It also adds a .patman-defaults file so the external
tool is set up for U-Boot, next to the existing .b4-config. Where the CI
jobs relied on patman's requirements for the setuptools that pylibfdt
needs, they now install scripts/dtc/pylibfdt/requirements.txt instead.

More could be done here: commit and patchstream (and their dependencies
series, get_maintainer and settings) only remain because buildman still
imports them. A follow-up could move those into u_boot_pylib (or
buildman itself) and drop the rest, leaving tools/patman as just the
stub.

Note: I was unable to run this through CI as it is not working at
present. I will check it in a few days.

Changes in v2:
- New patch: move the b4 guide into sending_patches.rst
- Remove the patman manual outright instead of leaving a stub
- Add a couple of lines on how patman works to the sending guide
- Point the SPI howto at the sending guide instead of the patman package
- New patch: add a .patman-defaults file for the external patman tool
- New patch, split from 'CI: Stop building and testing patman', to add
  scripts/dtc/pylibfdt/requirements.txt for setuptools
- Drop the 'u_boot_pylib: Require setuptools' patch
- Put the documentation and .patman-defaults patches at the front of the series

Simon Glass (11):
  doc: Move the b4 guide into sending_patches
  doc: Remove the patman documentation
  patman: Add a .patman-defaults file for U-Boot
  patman: Replace the tool with a stub for patch-manager
  patman: Remove the test suite
  patman: Remove the patch-management code
  CI: Install pylibfdt's requirements in the tool jobs
  CI: Stop building and testing patman
  tools: docker: Drop patman from the CI image
  tools: Stop packaging patman as a pip module
  test: Stop running the patman tests

 .azure-pipelines.yml                          |    9 +-
 .gitlab-ci.yml                                |   13 +-
 .patman-defaults                              |   32 +
 Makefile                                      |    1 -
 doc/develop/codingstyle.rst                   |   48 -
 doc/develop/driver-model/spi-howto.rst        |    4 +-
 doc/develop/index.rst                         |    1 -
 doc/develop/patman.rst                        |    1 -
 doc/develop/sending_patches.rst               |   63 +-
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
 41 files changed, 134 insertions(+), 13433 deletions(-)
 create mode 100644 .patman-defaults
 delete mode 120000 doc/develop/patman.rst
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
base-commit: 2569e25ddd5aa323cd87c7a3819c3a4f4b32302f
branch: patm2

-- 
2.43.0

