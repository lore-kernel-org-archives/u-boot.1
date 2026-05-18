Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B41CD4F50
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE9484664;
	Mon, 18 May 2026 07:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eW4qI1JP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5513C84659; Mon, 18 May 2026 07:57:53 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51105803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F3DF440A19; 
 Mon, 18 May 2026 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083870;
 bh=OZCpZu/c2ag8M1KotSGygZRzDu6zm5Wmre3bZsCXr94=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=eW4qI1JPnxllEZ3juCi/YoB84yR1JKObD9+X9b+sHs+5Q07vEPsP6mKYP5xEBHGZy
 dxMxMm+OYx4WVWJBDrjPUOFQ3DkEW/+Z8g+XDIWHKNhypA7inRLI+E58zENrAu2H3l
 hCT1yz5CaHD3ZRe1+ybz78GRBl6wDBLkj5Wyub9txKkbDKdSA9zwdUJ4qBFPppRYos
 4ukjn5R0bHqmavZLJ49jcgaRX+57v3zvtjjU/tywjLMv8pAmaQ8Ein/eju/PIECtiB
 7j5YvSui9ViGpzB4NSTjp8M7/Ypv7ztChvO2Vl4b2mi1RBgpIaQN+pqd+ZAovz5lly
 kYM9arsQcs/5qKV95/xEEoqEzke7QetUxkD9cnsadqj6aY/Nt2x0BdBV7fwcQ6sFYE
 wNaAplRj5Yh6+ZwGZlMX0pgbCFGL51OKbCd8jUtDD0sp/0d94ZghdQIfYcAwdMFkBK
 UU9JDD3KtqTlbMRW/nN8NSPkrV/sS3y9xL05Mu6CLLBDv/N+uSCB7YODGX26ug/BWO
 jIm75Kfeyh9G0/akc7c0BUNyk2EZiILYVur62qOjUe+v7iFhzum8j9MDFbsRrqiHuU
 HZCQQkJAM+d5cHXn7GZ5SP4EnSClSFe3bEHQDt5FQmik7m1Oh/y1qNVsxxfdVpyZo/
 z6PybPceYE+YN+tb4L94du6Q=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/9] fs: add change date to ls output
Date: Mon, 18 May 2026 07:57:19 +0200
Message-ID: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The ls command currently only displays the size and name of files and
directories.

* Add the change date to the output on FAT and ext2/3/4.
* Use the actual date when updating the change date in ext2/3/4
  file-systems.

Heinrich Schuchardt (9):
  fs: move struct fstype_info definition to top of file
  fs: print change date in directory listing for FAT
  fs: ext4: print change date in directory listing
  fs: ext4: don't read time fields in XPL
  fs: ext4: set inode timestamps on write
  test: Probe RTC early in dm_test_host()
  test: fs: allow optional date field in ls output assertion
  test: env: allow optional date field in ls output assertion
  test: test_erofs: adjust expected ls output

 fs/ext4/ext4_write.c                |  41 ++++++++-
 fs/ext4/ext4fs.c                    |   8 +-
 fs/fat/fat.c                        |   2 +-
 fs/fs.c                             | 127 ++++++++++++++++++----------
 test/dm/host.c                      |  13 +++
 test/py/tests/test_env.py           |   2 +-
 test/py/tests/test_fs/test_basic.py |   4 +-
 test/py/tests/test_fs/test_erofs.py |   8 +-
 8 files changed, 146 insertions(+), 59 deletions(-)

-- 
2.53.0

