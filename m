Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F377CFD314
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 01:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C346A83B8A;
	Sun, 23 Nov 2025 02:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ky7d8sWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC9583B99; Sun, 23 Nov 2025 02:19:31 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3451183B72
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 02:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D0BF6403F8; 
 Sun, 23 Nov 2025 01:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763860768;
 bh=lGabVCA3YCxydoPy+aQuEokXRgfIxbIeJFghvX10zu8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ky7d8sWfjyiWeDnL9pIfDQCKVxG5evDP7pWtCajqvdWG409opOIPLj/qh/+udKwOJ
 SCDTuMnuQ+4UXbtI3XXuDzVYCQtml48IA30YvEP1oe6g2mTjcca4q3urhYsy77ls/7
 SLpuzjxZ90Z7cy89yDw2r2X6PRCvRWO6NL8iwuOcLw0FWwSSLHiVH10/U3BY5ZKebj
 BcbXZLlioLyLI63YdsM7QizHiXZRGqufX5h8u8pdJlGOHTPPPZU5WCE4PUfJak9H3m
 t4DyFmi0bZ7aWuODeaphkBlYuH9bmPS2bENE04xgBjvEFS/pHNlcsHSatQ3hQgZFOQ
 yxxMsKBZl9uTUXHXq4Y/GE/rDdvjaJfJyQ8iapranK3npRQSfRTjGJnCdOeMkmErtq
 L4YN3e/gt0GMWNfmZiUI2+LWu+TnG8hfT9zhJ+fgz1QID2TLTqLoaK6xmx17Bo9Edg
 9SUgRMXmb90QztTAqrDWDWPE9Wfci+M9FlXUim5VXafWgVacRTT7/SnMi8Gp9gKpnZ
 7Qoj3htAiorMXUV2MVK80bfmylFuFV0k7aXcW3HTHM1W5yjRJFNoVixC35NL3sW+km
 c4tqhlnzSy5TdpgwvK8Nde19zvEi0CEqThitHvPQ5N2p1wSL3QTL1TsNw+XB6nnpUx
 CNeZMwH8d4eeNF4AGG+VryD8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] board: qemu-arm: enable CONFIG_CONSOLE_RECORD
Date: Sun, 23 Nov 2025 02:18:57 +0100
Message-ID: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Many C unit tests are skipped without CONFIG_CONSOLE_RECORD=y.
Enable it for all QEMU ARM boards.

As a prerequisite existing tests need to be fixed:

Consider the ARM architecture specific fields when testing the bdinfo
command.

In the print_display_buffer test consider if the system is 64-bit.

Heinrich Schuchardt (3):
  test: cmd/bdinfo: consider ARM architecture specific info
  test: print_display_buffer must consider 64bit support
  board: qemu-arm: enable CONFIG_CONSOLE_RECORD

 board/emulation/qemu-arm/Kconfig |  1 +
 test/cmd/bdinfo.c                | 28 ++++++++++++++++++++++++++++
 test/common/print.c              | 11 +++++++----
 3 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.51.0

