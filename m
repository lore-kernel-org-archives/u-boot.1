Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF518C8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D30C81D6A;
	Mon, 30 Jun 2025 17:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="vZ88+2kB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABF282ADA; Mon, 30 Jun 2025 17:14:56 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id 1D36D80B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1751296455;
 bh=f5C78VO0ZN+x8hJJM9RnzcT7N1NTygwW2iq9NoLjSAQ=;
 h=From:To:CC:Subject:Date:From;
 b=vZ88+2kB7oiVGYbY67KldOlKo9Hl30NUBT6C1hpGo7+W6F/8McTSKvDMR3cuFvIVk
 VfR+xHEXnMWgl3WX2hxQDhUDL0cYr3LOp7nGvvi521QtqVdhAL/sOwq1AL/XhUFhVI
 T4AVQPm++W6LW96iyL4zCH98wkqxAqt7ZHTIqvly2mmMnJ4wRuYkGiXroKO2cWQDy7
 oeJbHhMx4sDvnZGKvvGcgvMytgjs7i4P3dzkXJQ99ssuDk0JOM/MR/y6LVqBk77Hq9
 xb7wZBI1NDxY04J8saKNwzYiqW39i9pJ77ozoINaC1xMxJTTWts91tszJzXpFEFi2t
 nn1vMixXYwoGA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH V4 0/3] cmd: env: select: Add output for available environment
 targets
Date: Mon, 30 Jun 2025 17:12:29 +0200
Message-ID: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
commands. The second one adds unit tests for checking the env command.
These were used to check the env commands before and after the conversion.
The third patch adds the actual new parameter "-l" for the "env select"
command.

Christoph Niedermaier (3):
  cmd: nvedit: Convert the parsing of arguments to getopt()
  test: cmd: nvedit: Add basic unit tests
  cmd: env: select: Add output for available environment targets

 cmd/nvedit.c      | 353 +++++++++---------
 env/Kconfig       |   1 +
 env/env.c         |  16 +
 include/env.h     |   7 +
 test/cmd/Makefile |   1 +
 test/cmd/nvedit.c | 891 ++++++++++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c     |   2 +
 7 files changed, 1098 insertions(+), 173 deletions(-)
 create mode 100644 test/cmd/nvedit.c

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
-- 
2.30.2

