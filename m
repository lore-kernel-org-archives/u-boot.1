Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ACFC282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 14:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14C6806FC;
	Sun,  2 Mar 2025 15:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hvwIwVqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6520D80050; Sun,  2 Mar 2025 15:21:42 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEE880050
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 15:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3EC5C3FF63; 
 Sun,  2 Mar 2025 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740925297;
 bh=RjSERoMKnL/cOA5ZaXC8cxiZ+tuCXn9wJAUPrxAIpTc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hvwIwVqtfRvITEPQYhC7BG//iwG7QlGZLSqIIlAhQo7eHkaRRGunpOMaGIOwczIgN
 H6sdRfm9vnPzP0nnrxXz9TGoc60EMxnN/wKCiPChbqaOrvhuJ7XhbO3Wwu4HCjegBZ
 0B30mlEzUYcQUH7gDQSr0/MNmAJMOwTGgg2e69Zez49riB0ixE5uMf9a/6EWIJZrzt
 JWJTVPB5euHG8Dv6lodl1CFtMmi7U6ST6rVXVJDpXpRqCMOlwLO3iUb1Ymu32xtr8N
 7a5TZB63lgp9phfNcQxN44+EoysGU2Mu+T6ZG5qoAN+ETyKbLKwYDdW1G+3ueCxpGz
 QtJdy2bfpCnAQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/5] common: clean up usage of structure jmp_buf_data
Date: Sun,  2 Mar 2025 15:21:16 +0100
Message-ID: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
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

When implementing setjmp() we did not clearly separate the architecture
specific part from the non-specific part. The lead to code directly
accessing the architecture specific struct jmp_buf_data instead of using
jmp_buf.

With this series include setjmp.h is carved out from the architecture
specific implementations asm/setjmp.h.

All direct usages of asm/setjmp.h and struct jmp_buf_data are corrected.

Thanks to Zi for starting this clean-up.

Heinrich Schuchardt (4):
  sandbox: remove linux/types.h dependency in setjmp.h
  arm: include asm-generic/int-ll64.h in setjmp.h
  common: clean up setjmp.h
  arm: use type jmp_buf instead of struct jmp_buf_data

Yao Zi (1):
  efi_loader: Clean up usage of structure jmp_buf_data

 arch/arm/cpu/armv7/exception_level.c |  8 +++---
 arch/arm/cpu/armv8/exception_level.c |  8 +++---
 arch/arm/include/asm/setjmp.h        | 17 ++++--------
 arch/arm/mach-rockchip/bootrom.c     |  2 +-
 arch/riscv/include/asm/setjmp.h      | 15 +++--------
 arch/sandbox/cpu/cpu.c               |  2 +-
 arch/sandbox/include/asm/setjmp.h    | 18 +++----------
 arch/x86/include/asm/setjmp.h        | 11 +++-----
 include/efi_loader.h                 |  4 +--
 include/interrupt.h                  |  2 +-
 include/setjmp.h                     | 40 ++++++++++++++++++++++++++++
 lib/efi_loader/efi_boottime.c        |  9 +++----
 test/lib/longjmp.c                   |  2 +-
 13 files changed, 73 insertions(+), 65 deletions(-)
 create mode 100644 include/setjmp.h

-- 
2.48.1

