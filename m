Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F6EE6F061
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6130892C6;
	Fri,  1 Nov 2024 15:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FA1892E1; Fri,  1 Nov 2024 15:20:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7D7BA889A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E2ED1007;
 Fri,  1 Nov 2024 07:21:02 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB763F528;
 Fri,  1 Nov 2024 07:20:30 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Achin Gupta <achin.gupta@arm.com>, Drew Reed <Drew.Reed@arm.com>,
 Hugues Kamba Mpiana <Hugues.KambaMpiana@arm.com>
Subject: [PATCH 0/8] arm_ffa: Add FFA_MEM_SHARE and FFA_MEM_RECLAIM support
Date: Fri,  1 Nov 2024 14:20:09 +0000
Message-Id: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add to the FF-A bus FFA_MEM_SHARE and FFA_MEM_RECLAIM ABIs.

These FF-A ABIs are for memory management. They are used for sharing
memory between U-Boot and secure world.

FFA_MEM_SHARE starts a transaction to grant access to a memory region
to one or more Borrowers (aka Secure Partitions or endpoints).
FFA_MEM_RECLAIM restores exclusive access to a memory region back to
its Owner (U-Boot).

For more details about these ABIs please refer to the FF-A v1.0
specification [1]. For more details about FF-A in U-Boot please
refer to the readme [2].

This work is based on the implementation in Linux kernel [3].

This work is provided with sandbox support (emulation and test cases).

[1]: https://developer.arm.com/documentation/den0077/a/?lang=en
[2]: doc/arch/arm64.ffa.rst
[3]: commit cc2195fe536c28e192df5d07e6dd277af36814b4
     Files: drivers/firmware/arm_ffa/driver.c , include/linux/arm_ffa.h

Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Achin Gupta <achin.gupta@arm.com>
Cc: Drew Reed <Drew.Reed@arm.com>
Cc: Hugues Kamba Mpiana <Hugues.KambaMpiana@arm.com>

Cheers,
Abdellatif

Abdellatif El Khlifi (8):
  arm_ffa: Add NULL pointer check to the driver operations
  arm_ffa: Add FFA_MEM_SHARE support
  arm_ffa: Add FFA_MEM_RECLAIM support
  arm_ffa: sandbox: Replace the emulator error log with debug log
  arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
  arm_ffa: sandbox: Add FFA_MEM_SHARE tests
  arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
  arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests

 .../include/asm/sandbox_arm_ffa_priv.h        |   5 +-
 doc/arch/arm64.ffa.rst                        |   4 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 286 +++++++++++++++++-
 drivers/firmware/arm-ffa/arm-ffa.c            |   4 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  92 +++++-
 drivers/firmware/arm-ffa/sandbox_ffa.c        |   4 +-
 include/arm_ffa.h                             | 111 ++++++-
 include/arm_ffa_priv.h                        | 143 ++++++++-
 test/dm/ffa.c                                 |  73 ++++-
 9 files changed, 707 insertions(+), 15 deletions(-)


base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
-- 
2.25.1

