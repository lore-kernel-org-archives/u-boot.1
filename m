Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77499C369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 13:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E60681F7B;
	Sat,  3 May 2025 15:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Zjom7uzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291188210D; Sat,  3 May 2025 15:32:04 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099CC80F9C
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 15:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-064.46.114.pool.telefonica.de
 [46.114.111.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1C59A3F77E; 
 Sat,  3 May 2025 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746279120;
 bh=j8ACPudaXkQvp0t2O7njYzWuFA00r7zC7EeMtAx0c3s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Zjom7uzmOJpXr3DvQB0QWpn0n+ODmlRiaEh5Fk757UvLloMiHCH9icS1wRP0Zz73I
 MUvGrVVikxaHHHV65pTxVKv2ZBXb5ypriUWgIkjEez9/6ZesyKDY0yutCAMCVJTq0X
 qSSlJrkGL75vECSJ/HVnmA5SPvTMiz5/d5/7szBTreP7AFFwOPeqQQumzWzmFD2e8b
 DQLWi24GCkPQLnuyCRyMqCoh+Rbj2iXiCIHOg+gx3qlFaERpEI3MAP1XGt17CiYTka
 1xd52wOrESD6MuQHgxRacIUQSZIKGMv67htP1+1Gzy8aJC1lTp0j64QBrIaGplL6eG
 VyhuwOKsASYaw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] test: run tests on boards with LWIP_NET
Date: Sat,  3 May 2025 15:31:53 +0200
Message-ID: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Some python tests require CONFIG_NET though they should run if either
of CONFIG_NET or CONFIG_NET_LWIP is available.

Change the pytest.mark.buildconfigspec to allow specifying multiple
alternative config options.

Update the tests that rely on CONFIG_NET=y.

Heinrich Schuchardt (2):
  test: allow multiple config options in buildconfigspec
  test: allow testing with NET_LWIP=y

 doc/develop/py_testing.rst       | 24 ++++++++++++++++++++++++
 test/py/conftest.py              | 10 +++++++---
 test/py/tests/test_efi_loader.py |  2 +-
 test/py/tests/test_fpga.py       |  4 ++--
 test/py/tests/test_net.py        |  2 +-
 5 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.43.0

