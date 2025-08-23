Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BFFCA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 19:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D1B180548;
	Sat, 23 Aug 2025 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j4sKo+Sh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ItBVEA1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154BC80548; Sat, 23 Aug 2025 21:03:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E8180077
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 21:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c8RK73Lh5z9v1t;
 Sat, 23 Aug 2025 21:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755975787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D4QxHxjXPhJjFs1Iw2z23poh8AqeMwPxUEyOrfAXcRE=;
 b=j4sKo+ShtMMd5LpcLy+iXNa8JztK4y7d3izx3YhO2N34u5P8z3mDhK7CZRzpoRm30T+38r
 DUagdemMo3ID+jG6mCoOelTCrha0rvMjjnfiC8kmaJA4eY8gfoyDbmVuULW+Ulkt2Ge2Rn
 1k49qAoc7qFzpttlyh+rbo9Ol1tMHMqPcsSn+AsjNIOZhhkTMPv8LCan6pE2o+vKJ7e/zp
 Vv1JXWwInkjaA+Mv5D3IVe1VqOUo/AazwdQit8FiuanZ9wnv2BT+yxplaOPwlz/4sdExzD
 s43ICRiu7mbNXW4YAilh0/X4XuWpjash8qtZL0PBiX+vK674202fBLO3CrBx7Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ItBVEA1y;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755975785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D4QxHxjXPhJjFs1Iw2z23poh8AqeMwPxUEyOrfAXcRE=;
 b=ItBVEA1y6xXOAX9MZGz6r2cgs0/3Fl4tVlwG0OqALohIKdBfXQ6aucVtXOdCVgBmWpCRMX
 c5TFWPdRyymckX18/AjksoKgzrNJUpTCuVsBAcahNOV6f5LxHCFl0TklvN5Qfg2jG3h81u
 lSI+87PIF2m4cAwuEhIiKsyhm7AscYmCzQ2vEcZtMy3s863xLEaQcPb6/xajNBsoDVTK3r
 WSgHQBt+Bbi607u4FYP1lMNlm15kWe9yOauAA+Hd3FqO5v90IOFIBlcuSni92WiBL4JntD
 MSkm3Ri8E1PogoQsPMgUIUOSPlBeFiLKdAjLvYJl2c/CIqxw45/dilyfjKX4QA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PULL] u-boot-usb/master
Date: Sat, 23 Aug 2025 21:02:35 +0200
Message-ID: <20250823190249.352162-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f77fbdf376bad37b636
X-MBO-RS-META: fii3p8m9agmsfk8j5cbh69bw73fxipeu
X-Rspamd-Queue-Id: 4c8RK73Lh5z9v1t
X-Mailman-Approved-At: Sat, 23 Aug 2025 21:52:22 +0200
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

The following changes since commit 94e690c44a03959c39f0f5a44a9b89c851af3b60:

  Merge patch series "bootstd: rauc: Fix segfault when scanning device with unsupported layout" (2025-08-21 15:05:15 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 332714b905923d9e97a2cc7590dfc41e49980d35:

  usb: dwc2: fix reset logic in dwc2_core_reset (2025-08-23 18:20:01 +0200)

----------------------------------------------------------------
Patrick Delaunay (1):
      usb: dwc2: fix reset logic in dwc2_core_reset

Tim Harvey (2):
      phy: phy-imx8mq-usb: Add support for i.MX95 USB3 PHY
      usb: ehci-mx6: Add i.MX95 OTG support

 drivers/phy/Kconfig            |  6 +--
 drivers/phy/phy-imx8mq-usb.c   | 91 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/common/dwc2_core.c |  2 +-
 drivers/usb/host/ehci-mx6.c    |  2 +-
 4 files changed, 95 insertions(+), 6 deletions(-)
