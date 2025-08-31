Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231F3CA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5FD83965;
	Mon,  1 Sep 2025 15:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=skothe.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7E783931; Sun, 31 Aug 2025 17:17:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1747D83447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 17:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=skothe.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=steffen.kothe@skothe.net
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cFFx50hPbz9tX0;
 Sun, 31 Aug 2025 17:17:29 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of steffen.kothe@skothe.net designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=steffen.kothe@skothe.net
From: Steffen Kothe <steffen.kothe@skothe.net>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
Subject: [PATCH 0/2] arm: mach-k3: am64x: Add reset cause for cpuinfo
Date: Sun, 31 Aug 2025 15:17:04 +0000
Message-ID: <20250831151706.404373-1-steffen.kothe@skothe.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cFFx50hPbz9tX0
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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
Reply-To: steffen.kothe@skothe.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi together,

AM64X hereby receives support for reset reason printing during boot.

Unfortunately does the AM64X register mapping slighlty differ from
the AM62X. WDT and PORZ are not part of the reset source register, but
the mapping remains the same for all other causes.

To prevent ifdef/else constructs, I decided to follow a simple
copy/paste approach and adjusted the logic accordingly.

Cheers,
  Steffen Kothe

Steffen Kothe (2):
  arm: mach-k3: am64_hardware.h: Add CTRLMMR_MCU_RST_SRC reset cause bit
    mappings
  arm: mach-k3: am64x: Implement get_reset_reason()

 arch/arm/mach-k3/am64x/boot.c                 | 36 +++++++++++++++++++
 arch/arm/mach-k3/include/mach/am64_hardware.h | 20 +++++++++++
 2 files changed, 56 insertions(+)

-- 
2.51.0

