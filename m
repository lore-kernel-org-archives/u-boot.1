Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017A5C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 17:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BA28353A;
	Fri, 18 Jul 2025 19:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="gKeMbPSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AF3835B0; Fri, 18 Jul 2025 19:08:39 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 9A727834B6
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1752858458;
 bh=kTeCjPMCUA2UsR+OJInewVpWTcQnzR6TSjApFjCi7To=;
 h=From:To:CC:Subject:Date:From;
 b=gKeMbPSDETqadF0J7WMLBZmnAT5no5JlA2wmWESWst2fwGTr/H+vTwWZwFFNiTyLW
 4JEivqoDIkjB8mVYM6JjO7RYjTEcAzD/JX/e/TUC5kEOJhgDeIHaOP9a+ntCGMb1l5
 zpsmg/03SwdRAgmiILS0GiLcqYzHFk7Grpx9lmCOIaqiuULbFYFvuHyIePsmhJFjkb
 puQScKtkjL/dx8nBRrd/YbdL422/Yma/uqC7SCgqf7aCCC9YWVPBmRUS81V/j/dl9K
 mDk4fSfeIa+2/AKmUtcGpKohk8EfuTxJ3Sswo/B90uRZBoRix7C1oRlAwyAOygm8G3
 7Se8y0sgoKkmQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Casey Connolly
 <casey.connolly@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH V5 0/4] cmd: env: select: Add output for available environment
 targets
Date: Fri, 18 Jul 2025 19:05:58 +0200
Message-ID: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Add the "-l" parameter to the "env select" command to print the available
environment targets, convert all argument parsing in the file nvedit.c to
getopt() and check that with unit tests.

The first patch converts the parsing of arguments to getopt() for all env
commands. The second one avoids stopping unit test on console output
"## Error: ". The third one adds unit tests for checking the env command.
These were used to check the env commands before and after the conversion.
The fourth patch adds the actual new parameter "-l" for the "env select"
command.

Christoph Niedermaier (3):
  cmd: nvedit: Convert the parsing of arguments to getopt()
  test/py: Avoid stopping the test on console output "## Error: "
  test: cmd: nvedit: Add basic unit tests
  cmd: env: select: Add output for available environment targets

 cmd/nvedit.c            | 353 +++++++++--------
 env/Kconfig             |   1 +
 env/env.c               |  16 +
 include/env.h           |   7 +
 test/cmd/Makefile       |   1 +
 test/cmd/nvedit.c       | 857 ++++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c           |   2 +
 test/py/console_base.py |   2 -
 8 files changed, 1064 insertions(+), 175 deletions(-)
 create mode 100644 test/cmd/nvedit.c

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: "Vincent Stehlé" <vincent.stehle@arm.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
-- 
2.30.2

