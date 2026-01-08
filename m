Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCEFD1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE92884158;
	Thu,  8 Jan 2026 16:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LY2/nedQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ckquu+O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5972D83A26; Thu,  8 Jan 2026 16:11:31 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016E2839D7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 16:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dn7f857dCz9tYG;
 Thu,  8 Jan 2026 16:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767885088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WzRbI9fVdwAIVpvIHT9C1+CXA4g7MTRGF9eeOCSS39k=;
 b=LY2/nedQqhNMF0oMkg7kQqYsnoROvYAeFgTcLilDFLMb6GUdeF8MIYRfhGsGDd565tfGpN
 FZIzh1hSca0qcTa2KhYVk3cxYxxeFdHU+UgrkhJZRt1pd4DDFywpgeuTEPIvV/JE9z7OvF
 1LYhiP6CRR1GXIvqfI3gpqKre+fc/xoIn2+QU8je1USQbfYjLeVNivjBKbPpuuJTs3t48f
 Ggvd3Awg9/s8vy0fb4xSy0x7LSyc2yOUBes9YXuGNN9JCzJK6/4AlWhOdf/wH3iNI7TUZc
 MGytF8hwkXiq7fZZUa9JC+XrtSmTuY/eDbCfwVrmkEjqXtbv1KAeqhFEOLJQLQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Ckquu+O5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767885086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WzRbI9fVdwAIVpvIHT9C1+CXA4g7MTRGF9eeOCSS39k=;
 b=Ckquu+O53DC2oozwpX16mo1X116dZO7oSnCgPhEtIv56RxsKKLKhGnlg0ghve8YB21Sb5q
 sAaFZYvmH6B55/H4NCsCIu2+B/j1eHh1efx0jCrI+nCiXKJQQR3hzXhjL+p0KOG/oxtxBA
 c+cIvf91bKPO13OheI87of7Vg7CmAfVslFMSRImTTLDdV+74Q17zB4lCGqhQeXWXrqW2Sb
 Vq1IhPste2wneMVtGescqHjsfuTADQJ9/3EXg4p485gOpuRwuy9q0r0ASWgOb2zywU2SK1
 tYp+am5BC1Yd4XRVjDpqhyKptnqb6GWHhdGmTNNu9nvte4AmEIWe3eNeigHHwQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PULL] u-boot-usb/master
Date: Thu,  8 Jan 2026 16:11:01 +0100
Message-ID: <20260108151111.11593-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4465b23e440f5e7aa8a
X-MBO-RS-META: 3rtau41wupj1gmqmo4bnnagdy1ir7ngw
X-Rspamd-Queue-Id: 4dn7f857dCz9tYG
X-Mailman-Approved-At: Thu, 08 Jan 2026 16:58:06 +0100
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

The following changes since commit 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6:

  Merge patch series "test: env: Add test for environment storage in SPI NOR" (2026-01-07 12:31:56 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 14d9e84fc54b008ab1ad667bef73578b443dda73:

  usb: dwc3-generic: add support for exynos7870 (2026-01-08 15:13:19 +0100)

----------------------------------------------------------------
Heinrich Schuchardt (1):
      usb: xhci: avoid noisy 'Starting the controller' message.

Kaustabh Chakraborty (2):
      usb: dwc3-generic: allow fallback of dr_mode property to "otg"
      usb: dwc3-generic: add support for exynos7870

 drivers/usb/dwc3/dwc3-generic.c | 10 ++++++++--
 drivers/usb/host/xhci.c         |  2 +-
 test/py/tests/test_usb.py       |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)
