Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D9ECAC5B0
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 00:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12418802C1;
	Fri, 26 Sep 2025 02:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a/ixde2V";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lt3YaA7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA0482998; Fri, 26 Sep 2025 01:09:05 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2200980107
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 01:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cXqCd5PVNz9tHV;
 Fri, 26 Sep 2025 01:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758841741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ny/N3CgwEJi5VQAtQMc4ASae0MhR5yT1dMgpc9eT0Ps=;
 b=a/ixde2VJ8HvveYuQ1u7/1X+kx1mYheU5zbuodwV/OcHyPvV8I7WnQtYNG+G3JVPp7hKsn
 zbr2BUHPhpaS1/EVEvvVpu1CkoOAyERv7QjdS4oL5uZ1m01ufPoBA8N8o7QzHBBszLMiGF
 WS18RRHdlqrzHko4XZcOdkiKJ9fCyMDcLU05KYRYkTdlvOkio1rwaB2h3/YPdEQRdW6ncc
 etg908lg/grnus6+UDhMsb9hi4IALf//C13iIgpNrf6mKJaqxVSylceP8bci2TB29gk82X
 Q98G6pvlqECDzzLf/RUI/2hdYbpIWHIs/UqQUSNMaey8DWMmF8/Iyzv4k56G9A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="lt3YaA7/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758841739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ny/N3CgwEJi5VQAtQMc4ASae0MhR5yT1dMgpc9eT0Ps=;
 b=lt3YaA7/eYm7mZdYXTCYDr8EVbBUrJjahWpsgvCSAEfouReN0dC2x1gSIl7CAdtsX03KCw
 k0ql/cJRuAQar9jK3QWQKkKYDlj74DOKxadwVAeyc15g9mj43Ik5xQv++cJ+3eRF0nZd3M
 m9602JITpZCanNmvuTfRa6eJgb7TYlMqIM9TkQL7QRCNjHDtX7c5M/80LT9qu123bW99s8
 AvPUZMbljcjTturz7BhSJJiXxLaCtlxoJAOKf+2YfnAFP6LFh1jABxp/xAfURoEsFTxATz
 JtBrwsnY/pJ2RNO/49rtfBiVqmasMdYp5pvVgERzvaxDIyH9HFtSu0/JXJ/9Iw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: [PULL] u-boot-usb/next
Date: Fri, 26 Sep 2025 01:08:33 +0200
Message-ID: <20250925230847.183416-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pp8ewoyjtpuddzx497t1na5k6c3jfnju
X-MBO-RS-ID: d424e2b84178c3af088
X-Rspamd-Queue-Id: 4cXqCd5PVNz9tHV
X-Mailman-Approved-At: Fri, 26 Sep 2025 02:51:22 +0200
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

The following changes since commit 44c4919e9dd6c162b237633ba689441eca9a149c:

  test: Fix optee unit test (2025-09-24 11:04:11 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to 3285584429ba09df602011784f40e2c2d59a26b9:

  usb: host: Tighten USB musb-new host glue driver dependencies (2025-09-26 00:06:00 +0200)

----------------------------------------------------------------
Tom Rini (6):
      usb: dwc3: Tighten driver glue dependencies
      usb: gadget: Tighten requirements on USB_GADGET_ATMEL_USBA
      usb: gadget: bcm_udc_otg: Remove unused driver
      usb: gadget: max3420_udc: Remove unused driver
      usb: host: Tighten USB host driver dependencies
      usb: host: Tighten USB musb-new host glue driver dependencies

 drivers/usb/dwc3/Kconfig             |   9 +-
 drivers/usb/gadget/Kconfig           |  12 +-
 drivers/usb/gadget/Makefile          |   2 -
 drivers/usb/gadget/bcm_udc_otg.h     |  19 -
 drivers/usb/gadget/bcm_udc_otg_phy.c |  54 ---
 drivers/usb/gadget/max3420_udc.c     | 879 -----------------------------------
 drivers/usb/host/Kconfig             |   8 +-
 drivers/usb/musb-new/Kconfig         |   2 +
 8 files changed, 15 insertions(+), 970 deletions(-)
 delete mode 100644 drivers/usb/gadget/bcm_udc_otg.h
 delete mode 100644 drivers/usb/gadget/bcm_udc_otg_phy.c
 delete mode 100644 drivers/usb/gadget/max3420_udc.c
