Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7BFC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22AC817D3;
	Thu, 13 Mar 2025 20:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893254;
	bh=z7rEGAQbIxtpfLV8EtaMnCW1vcAHVP/8RARrTNZomMY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pAkJBZphWXcAWSX99zZ93KKRMNb8c2klgNZm1Ko5UKHZiXocEUqQ/WNbFLRpztN4T
	 XZ78R5IZx+/dXJV3kYe0hXj1K7JBiUWczcN3Z2sr8I+laXCP/8imcRmlEd+W6dIZlx
	 aO02w04fkCO36xMU1hwzWxRTfvzgNBb0DXaf/m9kz4moetN3vHhaIuzgoEsDSBpcBU
	 5iqExvLET+CLY2FoiZIo2KKKv/T+LfkJmvtL5Kui68/Myu0wh4aIggjUf86y050q18
	 kyXFPWJd3YJipb9NVkYprT23UL/FtgZQXDDyng9LmoZgnTtPNXb+36ytQBxr4d4KIQ
	 QyZ/B3dkKGIGQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16ACC8186D; Thu, 13 Mar 2025 20:14:13 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 895E380F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Uevb4oy+"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 47067103D43BD; Thu, 13 Mar 2025 20:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893249; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=z7rEGAQbIxtpfLV8EtaMnCW1vcAHVP/8RARrTNZomMY=;
 b=Uevb4oy+z0Vfi4a0SGVxjc5CL3leXVCJK7GR6A83GlyNSZQzWku5cgHMnj02g1UYR7p6L9
 QAg45XPUjnV8MQyyxwvP9a92fABN1m7jIm+tUDvtDDk8dewY/T4zAB/IsCx68HqyBtN4Mh
 LDTLdtFetu7mH5Q6annrPW4nC4G2jE0L1eHAVL1GYK7bCf9bGmBSTNcscdEOLjZ7xQ2h5X
 amMkfxFp6sU3+rr+pID/obQi36F7kDi5f1swNuvp7TL+MI+al44ONuBA7YKpi7yEfBYhm5
 LJaexYkv60klV95XR1dqZVkf1Kp38wc2E2FIVVALwu5gxHDAjtSXx9Y6iGsfpg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/11] fs: exfat: Add exfat port based on exfat-fuse
Date: Thu, 13 Mar 2025 20:13:16 +0100
Message-ID: <20250313191348.170054-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Import exfat-fuse libexfat, add U-Boot filesystem layer porting glue
code and wire exfat support into generic filesystem support code. This
adds exfat support to U-Boot.

Fill in generic filesystem interface for mkdir and rm commands.
Make filesystem tests test the generic interface as well as exfat,
to make sure this code does not fall apart.

[1] https://github.com/relan/exfat
    0b41c6d3560d ("CI: bump FreeBSD to 13.1.")

Marek Vasut (11):
  cmd: fs: Add generic mkdir implementation
  cmd: fs: Add generic rm implementation
  test_fs: Allow testing FS_GENERIC
  linux: Add generic struct stat {}
  fs: Add generic fs_devread() implementation
  fs: exfat: Import libexfat from fuse-exfat
  fs: exfat: Add U-Boot porting layer
  fs: exfat: Fix conversion overflow errors
  fs: exfat: Demote filesystem detection failure message to debug()
  configs: sandbox: Enable exfat support
  test_fs: Add exfat tests

 cmd/fs.c                                |   28 +
 configs/sandbox64_defconfig             |    1 +
 configs/sandbox_defconfig               |    1 +
 fs/Kconfig                              |    2 +
 fs/Makefile                             |    1 +
 fs/exfat/Kconfig                        |    5 +
 fs/exfat/Makefile                       |   13 +
 fs/exfat/byteorder.h                    |   68 ++
 fs/exfat/cluster.c                      |  496 +++++++++
 fs/exfat/compiler.h                     |   69 ++
 fs/exfat/exfat.h                        |  259 +++++
 fs/exfat/exfatfs.h                      |  200 ++++
 fs/exfat/io.c                           | 1000 ++++++++++++++++++
 fs/exfat/lookup.c                       |  225 ++++
 fs/exfat/mount.c                        |  380 +++++++
 fs/exfat/node.c                         | 1243 +++++++++++++++++++++++
 fs/exfat/platform.h                     |   75 ++
 fs/exfat/repair.c                       |  115 +++
 fs/exfat/time.c                         |  175 ++++
 fs/exfat/utf.c                          |  254 +++++
 fs/exfat/utils.c                        |  192 ++++
 fs/fs.c                                 |   22 +
 fs/fs_internal.c                        |  102 ++
 include/exfat.h                         |   24 +
 include/fs.h                            |    3 +-
 include/fs_internal.h                   |    2 +
 include/linux/stat.h                    |   45 +-
 test/py/requirements.txt                |    1 +
 test/py/tests/fs_helper.py              |    8 +-
 test/py/tests/test_fs/conftest.py       |   44 +-
 test/py/tests/test_fs/fstest_helpers.py |    2 +
 test/py/tests/test_fs/test_basic.py     |   71 +-
 test/py/tests/test_fs/test_ext.py       |  176 ++--
 test/py/tests/test_fs/test_mkdir.py     |   42 +-
 test/py/tests/test_fs/test_unlink.py    |   38 +-
 tools/docker/Dockerfile                 |    1 +
 36 files changed, 5202 insertions(+), 181 deletions(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile
 create mode 100644 fs/exfat/byteorder.h
 create mode 100644 fs/exfat/cluster.c
 create mode 100644 fs/exfat/compiler.h
 create mode 100644 fs/exfat/exfat.h
 create mode 100644 fs/exfat/exfatfs.h
 create mode 100644 fs/exfat/io.c
 create mode 100644 fs/exfat/lookup.c
 create mode 100644 fs/exfat/mount.c
 create mode 100644 fs/exfat/node.c
 create mode 100644 fs/exfat/platform.h
 create mode 100644 fs/exfat/repair.c
 create mode 100644 fs/exfat/time.c
 create mode 100644 fs/exfat/utf.c
 create mode 100644 fs/exfat/utils.c
 create mode 100644 include/exfat.h

---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de

-- 
2.47.2

