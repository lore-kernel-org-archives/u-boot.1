Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3058C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 05:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0940B81FEE;
	Thu,  3 Jul 2025 07:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RvkkqYmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF13A82063; Thu,  3 Jul 2025 07:20:02 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CD080E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 07:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 501C93F201; 
 Thu,  3 Jul 2025 05:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751519999;
 bh=/WD3PWG4s19qUBLBmkfGBd57mUTkBNrgBhuVzjk1IZA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=RvkkqYmBCtrBHNFs4z66otyejuhpuRsCjRj8FKbYUpdIFhR9zw5RvGZfwQAZn8cRU
 izMNp0kZl+/9x1B9Cs1iCl4UNStqSnwCgmwUueUdSDOFGUYYMA6sv/WjAQfNP1jqrd
 bV0TDSPGU+TnOrXwun8JkJJGuy0OUIHbRl0i1sGTYI0ww1Q0DHfggRB06MNOTd6wTE
 cxm/srjeVbcmLzSc9n6edz2LgC2jQYl5fIDhoyF/vpKAFnh6XOxU4tG4h1a67yy45L
 kxcfNXe3bvhw7U+u+RvblGq+MB8fLA8lepokydgLdVyZNnwNmAbLaHzq5yoIYsHxGP
 IMYY6aawXQKuw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/5] arm64: stack backtraces
Date: Thu,  3 Jul 2025 07:19:46 +0200
Message-ID: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On RISC-V we already can show backtraces if CONFIG_FRAMEPOINTER=y or
CONFIG_SPL_FRAMEPOINTER=y. Extend this functionality to arm64.

Show all 64 bits of the exception syndrom register esr.

Here is an example output:

    => exception undefined
    "Synchronous Abort" handler, esr 0x0000000002000000
    elr: 000000000002c258 lr : 000000000003967c (reloc)
    elr: 000000007f6c8258 lr : 000000007f6d567c
    x0 : 000000007f7c0200 x1 : 0000000000000000
    x2 : 0000000000000001 x3 : 000000007e662988
    x4 : 000000007f6c8258 x5 : 000000007e6629c0
    x6 : 0000000000000064 x7 : 0000000000000000
    x8 : 00000000ffffffd8 x9 : 6db6db6db6db6db7
    x10: 000000000000000d x11: 0000000000000006
    x12: 000000007e558ef8 x13: 000000007e55bdc0
    x14: 0000000000000000 x15: 000000007e558aac
    x16: 000000007f6c8258 x17: 0000000000000000
    x18: 000000007e65bdc0 x19: 000000007f7c0200
    x20: 0000000000000000 x21: 0000000000000000
    x22: 000000007e662980 x23: 0000000000000002
    x24: 000000007f7d5304 x25: 0000000000000000
    x26: 0000000000000000 x27: 000000007e6629e0
    x28: 000000007e662980 x29: 000000007e558d80

    Code: 97ffff63 a94153f3 a8c37bfd d65f03c0 (00001234)

    backtrace:
      0: fp: 000000007e558d80 lr: 000000007f6cad20 - 000000000002ed20 (reloc)
      1: fp: 000000007e558de0 lr: 000000007f6caeac - 000000000002eeac (reloc)
      2: fp: 000000007e558e90 lr: 000000007f6cb3f0 - 000000000002f3f0 (reloc)
      3: fp: 000000007e558f50 lr: 000000007f6d4af8 - 0000000000038af8 (reloc)
      4: fp: 000000007e558f80 lr: 000000007f6c847c - 000000000002c47c (reloc)
      5: fp: 000000007e558f90 lr: 000000007f6cc028 - 0000000000030028 (reloc)
      6: fp: 000000007e558fb0 lr: 000000007f69f010 - 0000000000003010 (reloc)

    Resetting CPU ...

    resetting ...

Heinrich Schuchardt (5):
  cmd/exception: missing include string.h
  arm64: initialize the frame pointer register
  arm64: implement printing backtraces
  Kconfig: make CONFIG_FRAMEPOINTER available on arm64
  arm64: simplify interrupt code

 Kconfig                      | 25 ++++++++++
 arch/arm/Makefile            |  9 +++-
 arch/arm/lib/crt0_64.S       |  1 +
 arch/arm/lib/interrupts_64.c | 94 ++++++++++++++++++++++--------------
 arch/riscv/Kconfig           | 21 --------
 include/exception.h          |  1 +
 6 files changed, 93 insertions(+), 58 deletions(-)

-- 
2.48.1

