Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DE1C0218A
	for <u-boot@archiver.kernel.org>; Sat,  1 Feb 2025 06:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAC4809D0;
	Sat,  1 Feb 2025 07:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ut0cskg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4465480FB6; Sat,  1 Feb 2025 07:22:32 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AE0807C0
 for <u-boot@lists.denx.de>; Sat,  1 Feb 2025 07:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-068.46.114.pool.telefonica.de
 [46.114.111.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D32C93F187; 
 Sat,  1 Feb 2025 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738390946;
 bh=tOkId0jiRgkuimfvJ2z3sQ379/3SxNzyVkqW5tJJen8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Ut0cskg3d3nY1pYqPcLcE292u0bp13J1qwNX/ORUHX/YizdODS4yzri178XAh0TyH
 hAEi7NvFVkfT044AcA6jnQ94NAcWTt/EARu9712vNQFEk371dyBgLWJLvHSPJgo7lE
 BB0mSHe1kudPpHb3LH/On6rHCSCypacQuCN+3J8mDHdBJFkoLfU1UEbO4a6m/nnAn7
 FQZBkmgkDTXJ2ScwfJre2/bPhbFreSISJOrOGz/1n9VidarY38oDLJemJSoiE68eGr
 eN9rA/64vktiOuZf47RCCVnkKbhDTIu0s/2jMIYVuirzz79fFM3ZNpIIswbR8Vcbw6
 w8e3hs4FKVtWQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] net: use strnstr() for lwip_strnstr()
Date: Sat,  1 Feb 2025 07:22:10 +0100
Message-ID: <20250201062214.56747-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Using strstr() instead of strnstr() creates a security concern.

* Implement missing library function strnstr() and add unit tests.
* Use it for lwIP.
* Fix function find_option() which is used to find the TFTP blocksize.

v2:
	New patch for find_option()

Heinrich Schuchardt (4):
  net: lwip: tftp: fix find_option()
  lib: implement strnstr()
  test: unit tests for strstr() and strnstr()
  net: use strnstr() for lwip_strnstr()

 include/linux/string.h             |  3 ++
 lib/lwip/lwip/src/apps/tftp/tftp.c | 54 +++++++++++++++++++++++++-----
 lib/lwip/u-boot/arch/cc.h          |  2 +-
 lib/string.c                       | 49 ++++++++++++++++++---------
 test/lib/string.c                  | 40 ++++++++++++++++++++++
 5 files changed, 123 insertions(+), 25 deletions(-)

-- 
2.47.1

