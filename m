Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7EBCCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 23:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E5D83D52;
	Sat,  8 Nov 2025 00:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bo7HaFTD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UEgIw7j3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83C6183D52; Sat,  8 Nov 2025 00:28:32 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FBE83D0C
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 00:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d3Fc94zcVz9t7b;
 Sat,  8 Nov 2025 00:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762558105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6KLSrHKBtaht6j+GMI9ce/c+2a4rhVdfF/NPwnBKik8=;
 b=bo7HaFTDQiFHWRvnnvStLi+ynFOWrhzvc0tyiVGA2RC5/CN6fn7SAX70YdfqJIggc2Z9V/
 u5fQJvvkG7n4M9bayi0AVxIX4fsCt78g0qEhdmZO5ZC0mtPjkkMMk9h3AFBlK+Vxqh0Fa/
 1kKn3YNaEMpsCQ/7yE8t1ekYzxcyjlFNRroxnGkMCSJ4qXCtTObmIQWdXKx7xJbLDrt8fK
 xfFVe1AToH3TC7MpT62fkaYZYGc8O6dzqDw5W/nXiJc9CPimvvl8NzLu+4fiaeI4pYWUb+
 4SVxoSl62+uCsMCLFIAnZ0mKFa6C/yTHjXU0p6dokYWxpHROBxPwp5cihhcBjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762558103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6KLSrHKBtaht6j+GMI9ce/c+2a4rhVdfF/NPwnBKik8=;
 b=UEgIw7j3lZFexyWpNdELjPQPFqymqFp43rQnV/S1ERRm5egaWeB429iDXMs3iwOWkYBwzb
 lh3kq9VRaz8YPVnO2XTyph5J2dlSOLKLU9okPNiFNIr70IfCDmCH8aKJGhVobGJXcOe8Qe
 OGDhaDSlZdA8pSeeljil/Hp4QjABM8dq/4/NzYshEi7bJSU8HxgkYfRhIOH0oZZdM54Uoh
 wJ62J149G76CAXxgmNRNO2PtWNAOjI1YofxCnFxYTC+pDw5uk7fSpWAuXWtdv4cEizO5pj
 J1oPsu65OjklDYAygrn0BV94etHiiRClTddEOp1nVq8Mus2X4UPEYSt93atU0g==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Sat,  8 Nov 2025 00:27:20 +0100
Message-ID: <20251107232811.480532-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 59e44fd500801a1ad49
X-MBO-RS-META: szfcme3onkurwq1p9iyxjsh57yc74oxm
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

Remaining R-Car Gen5 driver patches, MMC, clock.
Also a trivial adjustment for mailbox core to
allow operation without .recv callback.

The following changes since commit fdf36c2e9ad4f770ee951398a86bd55404d9b7ec:

  spl: remove redundant prints in boot_from_devices (2025-11-06 17:42:07 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 9535cdf0cb16671131ff2c3001c9f04f93d2fb99:

  mmc: renesas-sdhi: Add R-Car Gen5 support (2025-11-07 17:40:42 +0100)

----------------------------------------------------------------
Hai Pham (1):
      mmc: renesas-sdhi: Add R-Car Gen5 support

Marek Vasut (2):
      clk: renesas: Isolate R-Car Gen3 driver to Gen3, Gen4 and RZ/G2L
      mailbox: Allow operation without .recv callback

 drivers/clk/renesas/Kconfig      | 4 ++--
 drivers/mailbox/mailbox-uclass.c | 9 +++++++++
 drivers/mmc/renesas-sdhi.c       | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)
