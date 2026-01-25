Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE4EE63C8E
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 14:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE90183C39;
	Sun, 25 Jan 2026 15:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YRDdmiPA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pWoiAdjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDA683CDC; Sun, 25 Jan 2026 15:53:46 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CAA683C19
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 15:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dzZRq65tvz9v99;
 Sun, 25 Jan 2026 15:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769352823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fzXqR5fRfZT+ROp41x++VPhwgsC1QEnRPoWxGomvAUk=;
 b=YRDdmiPAK3vsR8iPrcePsDnW01MqLmIepF5249uNmQRm6UKXY+HT6yu5o5TTMmI0HjCaL/
 iTlSbhrjx8xr5VQfryiTGuBKsBqv6QjIBP4ivqV/X6WwpM4YyI7BK4Ypc29qQdOe6MOsJn
 akyq7NyBXDOr6rbyCOPSxrnP939TPK/viiOaACdOcj4ZYoaUjg3B5J39OFQEE9Xgw9G/9G
 xBKlz1mTphWyI8i8KJ9gnz8MX70mgP+mVPxxArQbv8EpdSaUuliXgiYovBxbztfuBXjxgD
 qy/xE8vJLMg/ZVpjaE1d3OponHM+sEm7MlzBUiHKI16G+Mhi3oveKac/4e9nHw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pWoiAdjR;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769352822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fzXqR5fRfZT+ROp41x++VPhwgsC1QEnRPoWxGomvAUk=;
 b=pWoiAdjR7V/9/cy5O3rZ60FYI/eHjwoRiILmYgxfHsms0Rn+mvrhB8KW6cQ95mRD0sU+48
 naE9gL2IDL2TIGgh1fwwJjFMQfN0AKXHVw+TWIoQNv3thC5ScuQp7CVoS31LRjNNNO29Lb
 p3Izp21LNO+/SzfJNrQ6wEMPPUozJL25LyjlqwpzJqnju7IGD8xGy0z82amaDxLmTrwenh
 1A3P5p8cvmSEPQ3cphVEJDgpS/U2OJ8n8oEtwqMqWkovK9UwFDI61SJ+8epQRVWAYz9O6i
 DPvTEGSFSCGMRm4cPrdanEvT1jWhgWunyseY+7+ptJqQISZjO1uheytoSj+IIw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
Subject: [PULL] u-boot-usb/master
Date: Sun, 25 Jan 2026 15:53:09 +0100
Message-ID: <20260125145333.527572-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a6my4h5k1tn3ugsnxkomimoy969xe46u
X-MBO-RS-ID: 7767b227e5c0eb51d6d
X-Rspamd-Queue-Id: 4dzZRq65tvz9v99
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

The following changes since commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec:

  Merge patch series "sc5xx: Add complete board support for all ADI SC5xx boards" (2026-01-23 14:55:32 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to ba94fb3003bd4155284c00c1b37613dd8e284816:

  usb: xhci: fix DMA address corruption in abort_td (2026-01-25 10:40:42 +0100)

----------------------------------------------------------------
ANANDHAKRISHNAN S (1):
      usb: xhci: fix DMA address corruption in abort_td

 drivers/usb/host/xhci-ring.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)
