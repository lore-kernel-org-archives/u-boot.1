Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E00CD5BD1
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 23:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4E9840ED;
	Wed,  3 Jun 2026 01:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pP9l8X+E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aWc9iKc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDD284857; Wed,  3 Jun 2026 01:17:36 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88C683EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 01:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gVRZ42lHRz9v5h;
 Wed,  3 Jun 2026 01:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780442252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K39zw007NKpFGbE83jkMRyx0VxsNJiTm4MmrQTXWzWc=;
 b=pP9l8X+EN2A8mL6khOgRzAVDrdoeGzXMwWP8VYsIKlSD9s9eubLELrBWcAEWOF9BuUue1u
 QFnZByONdGSJ3uWt1blre16pmGA0CaVfMpPohRCRcKdaiNUlBXtqeoxd0RwMvBL6zqkyQF
 y1FrRMteili1okQwH9OfcCbur+xkW2km8O55n6EWKuFV2/17LvKpnn1hAvJ4W6/oj3rrby
 kKulFkD90Rl0KC1IJiV6fPvxF3b8onE5qa9qlfhhWDVySru90uT7ZOzKnnszS68JIvClor
 Y//G8F1k8u89tRyuw7CB9yZYFHkEw46LC/krBVEqaXL7kxsDPaUwHgPwc0JyFw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=aWc9iKc0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780442250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K39zw007NKpFGbE83jkMRyx0VxsNJiTm4MmrQTXWzWc=;
 b=aWc9iKc059E5VGCO50uKWlqIriOJwtYZwnTNcr4U5yuq2Rn6ppdPgRJLFtQKR8fAZZqxVj
 w4QjiFsllC/H9xCPS96sdVHAT16cEIvfWq9VVKIRifQ9Fi7VsdN6BsoXmwEJu7AhpZPQl0
 o+1PNozMTh1pGIncFdTHgvrNtBYjGll2vqzlYgUUzeHP9IUYd3+nWMJa1Sh2fwnjrch56D
 VWiuXLAT2muxRvl/7lX6ApGdQG5GBA1GXqiQJIjvS7bwh7sVTMoqby0iIjwJY1Yu0gCMvJ
 ruR1HEKRlqFuYer1R6AFXvk2WqIVuePcoQsK6+OBJP10d30j6oEDIo6LyuxZVw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PULL] u-boot-usb/master
Date: Wed,  3 Jun 2026 01:17:02 +0200
Message-ID: <20260602231715.113057-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ouwng9b9uh5an8jr1dm54cq3bexwymoq
X-MBO-RS-ID: 93e2b7b756fb192595b
X-Rspamd-Queue-Id: 4gVRZ42lHRz9v5h
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

The following changes since commit 30b77f6aa146c96b831cb4ece038130b655b6a41:

  CI: Sage: Drop rpi_arm64 lwIP variants (2026-05-29 11:03:25 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 38eeda675b299d35b3655a3fb3609df0537021d9:

  usb: xhci-mvebu: Enable Armada 375 in XHCI driver (2026-06-02 22:48:04 +0200)

----------------------------------------------------------------
Tony Dinh (1):
      usb: xhci-mvebu: Enable Armada 375 in XHCI driver

 drivers/usb/host/xhci-mvebu.c | 1 +
 1 file changed, 1 insertion(+)
