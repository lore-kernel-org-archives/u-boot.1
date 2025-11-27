Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85211D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 20:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13465844D3;
	Thu, 27 Nov 2025 21:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hd5CDn2Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nLg1zbiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E82DE844C5; Thu, 27 Nov 2025 20:58:15 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCBD18449C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 20:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dHS0P3t3Tz9scQ;
 Thu, 27 Nov 2025 20:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764273493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v/DLDbnzaKFNiTiRUgt825cH7kdB5LbVSGi9/a7WZQs=;
 b=Hd5CDn2YMFSBQcYVQYb5zynpuOLCrSe1hEBtkn46vwWgXLNt9dOamqTTFsgDJbQZGWA6Sf
 ftX01PtzFVwR+A9klfULHFQ1IhcrFKikRyauKAfBjIilzATq/CKfzuGDwAsBxqsM9JDhVq
 VHqN5dOP4T9Ua3Cn1f8oMJzzJNa1OxovqBfdR/DVyW8lQVX0U1MPWUXFUE65g0Ha5uxHWj
 rQxBnV+bfuBEMhs0Ktnfxueo445ycjjkkknNpluw4uDuagIzkwGhyTqL03Kq2YGCY66/6V
 7NY1IMwrJxakb6XpIxQsfxlLcbGexDsoQIa/MqDWcKzT+p4/DxTAOjM98ge8+A==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764273491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v/DLDbnzaKFNiTiRUgt825cH7kdB5LbVSGi9/a7WZQs=;
 b=nLg1zbiLblrm89ReDpMPEWw20HW9k/rofSL8VhP4Yzzp0gQG+mTCbZEzpJeYiF3Ly5Awpn
 tZetpoBjwgDZ42IkGjg6JuQ1aoad3P+/ghwHAZ2uEHoi0GpFLLvyunjVhZOL4c/L5ygUld
 GDBmybPMaxQBWyLaeaswSsatvzbVz1JyaHeyCsybuwB7lRjvLV/3R0WUMGleIsJMsDW6qG
 IV8YiLjkZJTD4YO0P/Dg1DQUTz5Lmx5zpoyiHAUPpAhFqF8QIVZCA0g8qZLo3EC76eO+kV
 sUnybMGhunFdabaQuOmuLHHCqtIJLW0qcVraGjnijQnilfLlrJEZXPcI4VXcTQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PULL] u-boot-usb/master
Date: Thu, 27 Nov 2025 20:57:40 +0100
Message-ID: <20251127195749.81156-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82d14dba53c6d432002
X-MBO-RS-META: fpfnjmsfczpybyyasz6ezju7hdjmribh
X-Mailman-Approved-At: Thu, 27 Nov 2025 21:15:36 +0100
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

The following changes since commit 962711498ddac6179f1d1f3fa123397ba02a381b:

  bootstd: rauc: Only require partitions for one slot (2025-11-27 09:27:03 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 7dbcc316a64d3e5bf86632f078c5c08295e882fd:

  usb/xhci: avoid noisy 'Register NbrPorts' message (2025-11-27 19:41:03 +0100)

----------------------------------------------------------------
Heinrich Schuchardt (2):
      usb: USB_EHCI_PCI depends on PCI
      usb/xhci: avoid noisy 'Register NbrPorts' message

 drivers/usb/host/Kconfig | 1 +
 drivers/usb/host/xhci.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
