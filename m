Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10731C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686A980E9A;
	Sat,  7 Jun 2025 14:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ByvjgflO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B4E82AA7; Sat,  7 Jun 2025 14:03:30 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617F6807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 14:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C20A33F191; 
 Sat,  7 Jun 2025 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749297807;
 bh=4KbLBf8mPCssDIPGIBZOfinm7rZ/+E1As1cGszQada4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ByvjgflOQ4rAAh26PPNEGTMFL6JTMUpbAM3jNo5kzUcycEGO+ypc1ji/nJWufcp/+
 MKkTVipcHnosf1J6Oqmi7qRZKQgMKRsD+hC37jOYlfEpEhK+MVGkK4nnLzLqoe2Z3S
 RHA1yZFaqhmRySBGWoEQguexo7vhmM5kOucC+T9ixNw/JU/j0XQfI/5aL5bhz8IyPr
 wrtlJbfg2g6lJEtT8lfS7kjRQDyZnzAwyGEwKmt9u1YSdrAjvxdtrn1e4rroXQlBOJ
 NQx8u+HEiS5xTtxGEGx2naWwE7OF9PFtBLzyu12I0s1nzOPgAPi2ru+/Kk28UxJln5
 adan5jGWZipSw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] net: consolidate PXE processor architecture type Kconfig
Date: Sat,  7 Jun 2025 14:03:00 +0200
Message-ID: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
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

DHCP and DHCPv6 use the same value defined in
https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
to encode the processor architecture type. We should only use a single
Kconfig symbol for both protocols.

Furthermore we should make the value customizable. This allows for instance
to choose between "x86 BIOS" or "x64 UEFI".

As "x86 BIOS" is encoded as 0, we should not use this value to switch
off transmission of the DHCP option. Use 0xFF instead.

Fix missing declarations when bulding verdin-am62p_defconfig.

Heinrich Schuchardt (3):
  verdin-am62p: include linux/sizes.h
  cmd: remove duplicate DHCPv6 Kconfig definitions
  net: consolidate PXE processor architecture type Kconfig

 board/toradex/verdin-am62p/verdin-am62p.c |  1 +
 cmd/Kconfig                               | 45 ++++++++---------------
 include/configs/verdin-am62p.h            |  2 +
 net/bootp.c                               |  6 +--
 net/dhcpv6.c                              |  6 +--
 5 files changed, 25 insertions(+), 35 deletions(-)

-- 
2.48.1

