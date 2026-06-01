Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F419DCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B13384894;
	Mon,  1 Jun 2026 15:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="t5hpkUbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E468489D; Mon,  1 Jun 2026 15:13:45 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6864F840CB
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 14AD9B00583;
 Mon,  1 Jun 2026 15:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1780319623;
 bh=d+UsTc7m3myDOed8dljQ4W5+tHExl4uFOXJNHRJRyMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t5hpkUbLZ9SAwc71w6OhYxuciESwJy7Iao+aHQW0IfpoCQX8LhOUMlGwBr7NNQC2w
 3B+6uzj4T0sEy62ytuiJAyejY+zExryLyVoYT8fCuWcxIOxiiQMtkilAsLWl2WByZ4
 iAkimnTTjhl4V973hTR3xQgvA8iN6YSO2WAPFKv+Dz70fqlNHOvMr5USMS5WdGkpes
 6cCTsCYDAbUOvGjDo5BDxaRmVjENN+Bgv+6EHqrMSGyyngZTVQa57DS4Phqp7cPQda
 TO9YYfA1Vph1cdGNCFPiBy6s0HpJ3l0qGC6hcBmtz1uZJVLdNaqhoC6LLhR34zmVEv
 AcF3gsIQ3LTRA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/3] fs: regression-safe load <iface> for null_dev_desc_ok
 fstypes
Date: Mon,  1 Jun 2026 15:12:01 +0200
Message-ID: <20260601131311.1163914-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <"<20260511115340.675883-1-vjardin@free.fr>">
References: <"<20260511115340.675883-1-vjardin@free.fr>">
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


3 commits providing documentation of impacts and testing the dispatch
for null_dev_desc_ok fstypes (semihosting, ubifs, sandbox) in the
generic `load <iface> ...` command.

The test does not cover ubifs, I could not make it work with
qemu. Since the code logic is there and testing with semihost
is done, it should cover the needed cases.


Changes in v3:
- Apply Simon Glass's v1 review:
    * Fix typo "thue" -> "the" in the commit body
    * Refactor the dispatch loop with a fs_lookup_null_dev_info()
      helper
- Add doc/usage/cmd/load.rst "Null-block-device interfaces"
- Add pytest regression tests for the `semihosting` and
  sandbox ifnames, verified passing on qemu_arm64 (with
  CONFIG_SEMIHOSTING=y) and on a sandbox build respectively. A
  ubifs test is intentionally not done.

Changes in v2:
- (v2 is my local iteration, not good for the list, included ubifs tests;
  the changes since v1 are captured in the v3 changelog below.)

Vincent Jardin (3):
  fs: dispatch null_dev_desc_ok filesystems before lookup
  doc: usage: cmd: load: null-block-device
  test: py: load: check null_dev_desc_ok dispatch

 doc/usage/cmd/load.rst                        | 37 +++++++++++++
 fs/fs.c                                       | 42 +++++++++++++++
 test/py/tests/test_load_sandbox.py            | 53 +++++++++++++++++++
 .../test_semihosting/test_load_semihosting.py | 39 ++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 test/py/tests/test_load_sandbox.py
 create mode 100644 test/py/tests/test_semihosting/test_load_semihosting.py

-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/fs-null-dev-desc-dispatch-v3
