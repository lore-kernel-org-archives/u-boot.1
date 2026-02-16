Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5689E63F3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0108063E;
	Mon, 16 Feb 2026 18:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aLTRb/qq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p8eWLBCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817C883AAB; Mon, 16 Feb 2026 18:46:34 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961AA80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fF9F42m78z9tgB;
 Mon, 16 Feb 2026 18:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771263992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fWSSbqzEwbinEB40nnrZEGDIZJwbsxPPpTranAjSSWk=;
 b=aLTRb/qqxR7d1DE5CHDQDwnwkSQbJvTay4M7L6M7Ok4BUHhVNG7pviQWYmejZmml7Bz4rf
 MvtiMSw9XZ5dW0ckqWVMt2J/Tm516LU76j2cINetyzfn1wovgiZAyKPh4Kh9z1YNtCKnA0
 IQ4kPiDexS65xvcxLaHQ6EKbacz2nhDELNgYtgM6ynYdg6eruT9kVmjoPrRSUpqPBYpfAB
 7x2KhDvSN2X8G1NNatIXpKweqpl+J5It4Jc7ABafNwJB95q78vQtSQAn3IyOsz+SxABROq
 0yOA/1fwm1T9636OwZc5SIf+UKZiop2tS7di+PKMBen6MNmJ3x84QxBUOapO5Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=p8eWLBCr;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771263990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fWSSbqzEwbinEB40nnrZEGDIZJwbsxPPpTranAjSSWk=;
 b=p8eWLBCr5n6KHyC00ERajvMCo1MRgaySOUhI7BS34JBW/n7RZFvNggGz2n1N8vaYFImIR8
 iqYYTlDXi+CccEUqabKZmXzgKHfvqtXROUnfD23YvJnvALvVYR5C6BaW8JxIKdrBuqOrop
 H+kr2ecREWsvG7arEkdhNhCy9p5dBhK7H5wHRPNYCKAROSqhp7nrDMOq3qUHIxpJvNbPg2
 ODcrp8slEj4VMZasUML7Uo65lJwAoKzvE82lxrwsvhzxutdVkAqNDnKUeXsQBxQagkkls2
 66rqoZEzXtU8d/Iar4R/eRlfW6phu+bUNlqS08IcStYGOO37gXR3yaLmQY9Rtg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PULL] u-boot-usb/master
Date: Mon, 16 Feb 2026 18:45:42 +0100
Message-ID: <20260216174618.56494-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3cb74fed57a9dd54d27
X-MBO-RS-META: fwox8c7i6rcpsn1bi6mz3xyd5c6k5g7n
X-Rspamd-Queue-Id: 4fF9F42m78z9tgB
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

The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde78fee8:

  board: toradex: Make A53 get RAM size from DT in K3 boards (2026-02-12 08:12:09 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to bfb530e06ca6c19f66c079601e568c761a001993:

  usb: cdns3: use VBUS Valid to determine role for dr_mode OTG (2026-02-16 15:08:43 +0100)

----------------------------------------------------------------
Siddharth Vadapalli (1):
      usb: cdns3: use VBUS Valid to determine role for dr_mode OTG

 drivers/usb/cdns3/core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.c  | 11 ++++++++++
 2 files changed, 64 insertions(+)
