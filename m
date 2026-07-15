Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0D5C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 16:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2654384B49;
	Wed, 15 Jul 2026 18:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Xyc30NrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364EB84B86; Wed, 15 Jul 2026 18:57:48 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F2584B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 18:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5A90CB00593;
 Wed, 15 Jul 2026 18:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784134665;
 bh=dy088rUI5InY/3hyc6qUkS9dv8qRa1L3oxV03f6ppFs=;
 h=From:To:Cc:Subject:Date:From;
 b=Xyc30NrStkS9Ro3yT/hoswL1vApHeg+9dOLrJmWuikvKX+UTdnVCtt+phQt4Uwf8s
 6bETiRNDbprOyZ0XaCE9Z6kTT+bnfrgxCB6mq7vJ47vmpRlA3AWMNO9BeP9hIzPBLu
 k7Cibjc0n4aq+p47M2PlkqvVudVrQdTDW77VPqVCk3JYdnsm0yWHLOaKwgNHjUXyY2
 jfUiAVh4Acqx9Y0ntTFvE57gZ39wxeMQp4sT7R1o0tJNWyQx59XJzG18sDcIXcj1EB
 JB0RzTVTAo7LebOHjVasQbb+h6kMFDPWn38+CwBibr66Kd/giq0zZVEPu59SrUHw47
 lW0a1DZ61sSHg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 0/3] fs: regression-safe load <iface> for null_dev_desc_ok
 fstypes
Date: Wed, 15 Jul 2026 18:57:14 +0200
Message-ID: <20260715165735.3207801-1-vjardin@free.fr>
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


3 commits providing documentation of impacts and testing the dispatch
for null_dev_desc_ok fstypes (semihosting, ubifs, sandbox) in the
generic `load <iface> ...` command.

The test does not cover ubifs, I could not make it work with
qemu. Since the code logic is there and testing with semihost
is done, it should cover the needed cases.


Changes in v5:
- test/py/tests/test_semihosting/conftest.py: fix CI
  issue reported by Tom Rini

Changes in v4:
- Apply Simon Glass's v3 review:
    * commit body: "-" in the example
    * load.rst: drop the internal code references; fixes
    * test: drop redundant negative guard
- Add Simon Glass's Reviewed-by to all three patches

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
- (v2 is my local iteration, not good for the list; the changes
  since v1 are captured in the v3 changelog below.)

Vincent Jardin (3):
  fs: dispatch null_dev_desc_ok filesystems before lookup
  doc: usage: cmd: load: null-block-device
  test: py: load: check null_dev_desc_ok dispatch

 doc/usage/cmd/load.rst                        | 33 ++++++++++++
 fs/fs.c                                       | 42 +++++++++++++++
 test/py/tests/test_load_sandbox.py            | 51 +++++++++++++++++++
 test/py/tests/test_semihosting/conftest.py    |  4 +-
 .../test_semihosting/test_load_semihosting.py | 38 ++++++++++++++
 5 files changed, 166 insertions(+), 2 deletions(-)
 create mode 100644 test/py/tests/test_load_sandbox.py
 create mode 100644 test/py/tests/test_semihosting/test_load_semihosting.py

-- 
2.43.0

base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
branch: for-upstream/fs-null-dev-desc-dispatch-v5
