Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5784CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 02:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4752E84E0F;
	Sat,  9 May 2026 04:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ei9PZem0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gA6DGqwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FC184E2E; Sat,  9 May 2026 04:29:47 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A615384CD2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 04:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gC91P31pHz9t74;
 Sat,  9 May 2026 04:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778293785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5D+pSpDLkMvQ/yWqlyhNGGZfTw0om7Odtv4HalU/RXc=;
 b=Ei9PZem07lR2nmxOaKDMMfDuuqAHRgS6pKZwAcGCgEknav3eHI1s7L9S1O0cNKhA/s5JVP
 HjmpmTOieqSuyEYIrMvewZiahjBTMlePxlg7M9xHDG0uJW+JC+oGUdMdGKsykjx2txamAt
 aqKjgLGjy9fghUwAjy56JkOquPqZX6nZERkcg3e3Og4SsfpNAGQU0EDA5XXQ5PeqUd6P/1
 ZVAucuaZ7ZNaFEJ6KPAFztphZvFUyLtPJgGZo36fn6r+/EKSGxXQ+zyzl6+ePZlrI4KJq8
 XKAzgbytMeT9mo331PNcqzeyV8sY3NTpIgiIwo2VzHJaZ8LxrMt0Vv8cps2YRw==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778293783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5D+pSpDLkMvQ/yWqlyhNGGZfTw0om7Odtv4HalU/RXc=;
 b=gA6DGqwrEHtKdvBI5yURVhSJ+1W90B4SyiNoS4/aX/4RaX5HZF0TQFlrUOstCys9hS5auZ
 bbUjVbiulbzC4MTgtXv/Ahh4A1CjlMP2YXEsLbU9/kmDrBrl89+8Ig28qJEBzedsOO5PQG
 VQqTYthMTIeHQLOjQowxgYGPH/DVJ8+C5MIG3HkjUdNAXPUGTOGtGGzzemKY6BkZAJ0ROA
 JybLDdLOBvpV1nLIb6putarzPKoPP8qZidZBxXVCDhexFn05zlKHXahcUH2mv3y4tydqqP
 KDPgx4TRF4Dxg4p85WqwfLi+7vO4h9EWTrm0YUMTqPGILJ8xqDoTEX7zzR9/5Q==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PULL] u-boot-usb/master
Date: Sat,  9 May 2026 04:28:58 +0200
Message-ID: <20260509022931.898897-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ktfycmcjpx6x4a6wryoh4o1cgf534jqh
X-MBO-RS-ID: ad54ef73fc07d6440e9
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

The following changes since commit 3cdd19089f1b1b7cd08530f33ff4708abcfd426c:

  Merge tag 'mmc-for-2026.07-rc2' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2026-05-06 20:13:39 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to cc8195b13b12cde3192978df64fd8bfac0f591f4:

  usb: dwc3: Fix crash on fastboot exit due to incorrect memory free (2026-05-09 02:26:58 +0200)

----------------------------------------------------------------
Balaji Selvanathan (1):
      usb: dwc3: Fix crash on fastboot exit due to incorrect memory free

Tom Rini (3):
      usb: gadget: Correct dependencies for USB_RENESAS_USBHS
      reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
      usb: Correct dependencies around USB_EMUL

 drivers/reset/Kconfig      | 3 +--
 drivers/usb/dwc3/core.c    | 1 -
 drivers/usb/emul/Kconfig   | 1 +
 drivers/usb/gadget/Kconfig | 1 +
 drivers/usb/host/Makefile  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
