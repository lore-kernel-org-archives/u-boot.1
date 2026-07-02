Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A6FC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C603A84A75;
	Thu,  2 Jul 2026 16:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="e7i6E7Gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB6684A81; Thu,  2 Jul 2026 16:44:20 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1B684A75
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id BF731B0054C;
 Thu,  2 Jul 2026 16:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783003456;
 bh=n4BbTJ2rlGjPPFqu6FvBKvQlw8netIT0thDKUScEOug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e7i6E7Gvf7+W5UbUVREEM93V88J9DC1gfimwbTMrppcLgJ7DZk6O7NKV3fe79u64k
 3+5ikVTYxXOF+mNMQgZfXsBJ7TYA+Cx/D8yd3UsZr5lG7lE9G6uHKAjbs5u5ln6n4x
 r7DIXv94ThP22hTXZPtQ3iF2KvcSQJFB+Xl8Zi9AKyxWD1NJzuX3TxgHL9OgUB/7B1
 eN4H30JGvABgi/eLnB2S9SJiPzq513TGa1mK4/be6j2OLmGd6hXxLI82kCOukBDYrh
 c5WhqKVFEGJE1/tehRdKHDApW5IrG4kjmaYSArB4HN4qO4l2YME24yvAuu0O9hljQd
 SJ0Fxc3ftCWkw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 0/3] fs: regression-safe load <iface> for null_dev_desc_ok
 fstypes
Date: Thu,  2 Jul 2026 16:42:11 +0200
Message-ID: <20260702144359.1583239-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <"<20260601131311.1163914-1-vjardin@free.fr>">
References: <"<20260601131311.1163914-1-vjardin@free.fr>">
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
 .../test_semihosting/test_load_semihosting.py | 38 ++++++++++++++
 4 files changed, 164 insertions(+)
 create mode 100644 test/py/tests/test_load_sandbox.py
 create mode 100644 test/py/tests/test_semihosting/test_load_semihosting.py

-- 
2.43.0

base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
branch: for-upstream/fs-null-dev-desc-dispatch-v4
