Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70E2F513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 00:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED2C838BB;
	Fri,  6 Mar 2026 01:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LJqdV9Ay";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pxtNuQxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423B1839A8; Fri,  6 Mar 2026 01:56:44 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED32836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 01:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fRnzY6gM1z9thy;
 Fri,  6 Mar 2026 01:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772758601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mWLG1zPWBW2Hc0qctMU944do9wzFJfWvIBUDSRMRi+c=;
 b=LJqdV9AyF0wchXCQYah20FuRwTXGjSiYIyrGvwrL6ulegjhkIfJPebkh6jiANLVMQo+HNt
 XP0/90YY+K/l86/hm96108S5sK1fBGPNKvcq03jLHn8nc8ioBKSnghvKr1QxX4a8CyTB02
 b6PlhPXEQipsEPFI6zL0KpF+WBr2uHNxypnZ96anFMgY4DinTtjrhZSmeQl/PPOb6GaP4l
 wBdTdfY3ir3sKX/v1hX44mzxbTiG/MCdAUVe2uldPIogne4x7HJZFvWJ0yTLHOSkLNT9V0
 YTxjgFuJ0yS7aavqmzeIhZxU5/wm3o6GLemO4t4mgGXd5J/fud0BOHbCPJH6KA==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772758600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mWLG1zPWBW2Hc0qctMU944do9wzFJfWvIBUDSRMRi+c=;
 b=pxtNuQxLlb+5krgxFqtp+QMAgsH8WvcP0wHj9F2miyTn9r5FbF4BH7DYneq6TieoG4m7jB
 KzX/V6VR/R4FBivX2ymbeySa5nkjldGSBc6J0iD7NlpZDWVN7lPQrLOVH6md2w1JpGdRnO
 kixonZXKmkcHRthU4mPlcEV18x9Rmaa1USD9u6JTJlgMnt94NGj1BVcg1R3jOYpPCRdeP0
 wKVYs1s+6qhxaIoHKlYLkFrfxo/HPMjTgd8pBUKGO3cPAaGlI/3T+0+XSDLtaqc/QMGGZr
 52/wvBAaqNICr/INqCohywKYxkxw00CyORWAubxf3N4b+PA41cUrPcMHZRNjww==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PULL] u-boot-usb/master
Date: Fri,  6 Mar 2026 01:56:22 +0100
Message-ID: <20260306005631.175834-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0998e7b82f7f6bd2b52
X-MBO-RS-META: qi8p3n46x7enknd5gzj65iezck34gbmr
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

The following changes since commit b26cc03b7cecaabdb306c2f68eebde764161a545:

  Merge patch series "MAINTAINERS: Update ADI ADSP platform maintainers" (2026-03-04 14:25:30 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to cd86e8fe811157ea708444a8b3b98564a46b313c:

  usb: musb-new: Add compatibles for ti,musb-am33xx (2026-03-05 22:21:30 +0100)

----------------------------------------------------------------
Markus Schneider-Pargmann (TI.com) (2):
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 drivers/usb/musb-new/ti-musb.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)
