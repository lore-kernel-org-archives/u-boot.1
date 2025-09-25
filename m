Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17312CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 22:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710E18206E;
	Fri, 26 Sep 2025 00:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iEp5919p";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jODrVedd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEB98206E; Fri, 26 Sep 2025 00:40:41 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ACFB802C1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXpZt2Vp8z9tTp;
 Fri, 26 Sep 2025 00:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758840038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ka/vhg6QuDYA6Ze1fRW3xhDo7rd/B/3rL/T43bbEPJA=;
 b=iEp5919p1lBilfGCEVeoh5KN7r+L5Om3L9fuLSa7+PLXmwnUG21EjUqt6eStBKSvH0RLQX
 I2MvrQa5O1NPZFKPiSl2ptk05u8s8OaW1UiD3wvaEpMVOcRgBxPpAAesgvoZmHUQpBb0zT
 aoOsBZyk+YoTH97pRqCX2NmPer+lHdDuev2NJuwdi1+YxTw1jLV2GScRRySdrtNoTmzE3M
 nNnOnR0JkCIXvUFK4A1q5hkeHp3iN8rofj7TCyNoCFqzl9stXOum/8m9ngQ9jd+8Ls+v3X
 5IOl7LtrLb/4PtUT78/DbP4MnGmlvkSKtCcYx6S097NJzTl4l55odSCqoAyeTg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758840036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ka/vhg6QuDYA6Ze1fRW3xhDo7rd/B/3rL/T43bbEPJA=;
 b=jODrVeddrlOQLv5+ui3CzyC4pw8Yt7CNApN4DircriQDfrB4N2MAUH5IB6n33CuldY05zt
 8sK/UMiywwn5WKir8XgOnkVKqHsUlLR8iCT0vuRhn54cOP7srzCUi6h2raYjN1nG5maHpe
 DEZWzmbi57hLXyme+rjOUaBkudna7ucfqfxcAXrJ/jQpzqLf+cJOPf6TmM3Lwbji+GIyoW
 XtnoVB7/FiD8u1tTYXjKIbA08rXkDAkubE+DsHfsoF+8sHmP8HHuakoK+/2JgkyMNx3R3j
 QBfNW0tAXNgJ3loTs/Fzhg01Fwprv/XnVXK+5JiuQfoEE6AvyIINE4Cj9fDVRA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>
Subject: [PULL] u-boot-sh/master
Date: Fri, 26 Sep 2025 00:39:16 +0200
Message-ID: <20250925224019.181523-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 56p5nyo6ydn3oy6aywb16c8r7oo78557
X-MBO-RS-ID: 06b466e268775c54a9e
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

RZG2 boot failure fix for boot with TFA which does not pass DT,
and R-Car Gen4 PCIe controller driver alignment with Linux fixes.

The following changes since commit f53fe908ac3dd44f7ad63dff319636541710b98c:

  Merge patch series "Fix boot w/ scriptaddr & minor newline issue" (2025-09-24 07:50:13 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 19c292a8c5d0e2d0b85279d22643c6a4f6db9139:

  pci: pcie-rcar-gen4: Add missing 1ms delay after PWR reset assertion (2025-09-25 23:19:17 +0200)

----------------------------------------------------------------
Marek Vasut (3):
      pci: pcie-rcar-gen4: Fix inverted break condition in PHY initialization
      pci: pcie-rcar-gen4: Assure reset occurs before DBI access
      pci: pcie-rcar-gen4: Add missing 1ms delay after PWR reset assertion

Mathieu Othacehe (1):
      board: rzg2l: Check the DTB pointer passed by the TF-A.

 arch/arm/mach-renesas/cpu_info-rzg2l.c | 2 +-
 board/renesas/rzg2l/rzg2l.c            | 4 ++--
 drivers/pci/pci-rcar-gen4.c            | 7 ++++++-
 3 files changed, 9 insertions(+), 4 deletions(-)
