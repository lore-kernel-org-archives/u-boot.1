Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AA1C28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAE28058A;
	Mon, 17 Mar 2025 04:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181295;
	bh=z7rEGAQbIxtpfLV8EtaMnCW1vcAHVP/8RARrTNZomMY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hbYrllnjn4IJI70lMF2TwxsjdfBW0glPAXZVYyLqs5S7WlskuZlhJL+OxbihZlrNv
	 y8QwDUOT1a644g0sUiWPb8PuMwOxwaESHqGVtdgAInRCbSoy7IfbHZhJH7e8g72p5X
	 knSusKTI8LWpzCMMde0Yr55sv1SKckO+TuBMKgtiOOxHq0KhFTETKMRchYMQTihqoa
	 eKvKzol0jL12aKjrIDLF8bxXpfxoKJRD6AeDIBFIW3TcrSwmOtlJa9O9KMF6Sczhct
	 CUeyJ7kVz24AleTytDT75/GwyzYgCUnuiazgP91z1cx4F25kUa7yIJgJIKXF6oGonk
	 XDOcaVvcf1egw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A477D81101; Mon, 17 Mar 2025 04:14:54 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48684801DE
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="et3UvUBF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8619103D1FFE; Mon, 17 Mar 2025 04:14:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181290; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=z7rEGAQbIxtpfLV8EtaMnCW1vcAHVP/8RARrTNZomMY=;
 b=et3UvUBFwo5OKAzaLR09nPR9bS+yi6IVPHOhI3RBKXJIiTWaszqIgG9Pv2rXyuoHHza2sz
 L6fUXwMZaR73ck3r3JoBg+pwEoXd6MFvSWX+GrF1vOBI3/D3zVSyjOBgjyeR6rlPLHr4kC
 MmZYaVUMVjPHrH2dlrRL9tQywAkryoQ+MSe7cquDXIGMwrOL8BhJ8EO3u5VFwUc+S2+WyS
 +Q7ZQpBDHcl/l1S3JbNtpIUSvu3YT21EYEgF33vBZbyA1yFzQ2qowe81cC+Rqc8t6Gcqt/
 Y2EbP9k5OhDBZcDVGE6D28Nvi3cfq68CHaXdbBmWHOQy1BZ2TQsZkCLZ1Mb+RA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 00/11] fs: exfat: Add exfat port based on exfat-fuse
Date: Mon, 17 Mar 2025 04:12:39 +0100
Message-ID: <20250317031418.223019-1-marex@denx.de>
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

