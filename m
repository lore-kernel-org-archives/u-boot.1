Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962CDCD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025F584855;
	Wed,  3 Jun 2026 02:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pDp7PNRp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MyzjLI7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8032A84857; Wed,  3 Jun 2026 02:41:08 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975BA839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 02:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gVTQT2MYBz9tsv;
 Wed,  3 Jun 2026 02:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780447265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DKyAsChLC3x82Ko7yhIIURXVUu28LlA7dXn21V4GG8s=;
 b=pDp7PNRpAl2aDhpLbSGwqRIQiNlISO1/tvkDyE9t7wR5k/Zeb5TPnw3IoKr5GFmsBytrqo
 FpD9sTY9uxBSWdJ2A9VlZTQZYaWevVLepOf47/vBFyXDuVhKbaqTbwqsXziWOyzTJ5pqFM
 N/40iMxiws4oDyIDGSP1S7ixsG2kHQSp5dtURHxQ0Cv5e+NWynQykru/1/IpdtLGc7dwHu
 TeurBOSxwcmUtv8iQZt+HOtKiyWS3TUk41Bh+Q9Q2FQE2vyXEpzY62rmDO8NLKG2+qmPW7
 FIOskiF/zC2AKm/HwX5gEDnaa3h2ylNdc+PY1Q8tSCB9IqOL0EzKKGwAYQsrxw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MyzjLI7e;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780447264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DKyAsChLC3x82Ko7yhIIURXVUu28LlA7dXn21V4GG8s=;
 b=MyzjLI7ef//7ndikrUMZ36r/2TJblwMHCeemCyIdyJpEJHC4ZzidAc8pkfASQ12V6SK9JT
 fFJ4d+vfDfz+iYUEsz/TTEYvoqOwQGL8MevOY3kzohJhshRH/ljaYzA8AUYI4tTGGlY0db
 vdGywuZZF3vRrCvSur0TDNEcwDHKNoG/tRqgHRV+SFbRU32d+yF3kNWti0D8VLW7mjB5qJ
 Md2iVCBseQvv6LtvqEzZq3SDiFvwo4wXCDMmkvvux8L907mXGJlZSxX+FkU7db5fXzd8Yt
 aQJJH56TOYpXsbqZUgM335DUWwhrhTZJyRb2kPokCAjIyc9zQ2AWFCLsuvPs5A==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-usb/next
Date: Wed,  3 Jun 2026 02:40:11 +0200
Message-ID: <20260603004050.204724-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 75bafbb11c38c253872
X-MBO-RS-META: 98dtjc5uch4aq986cxgeoxh5sa1b778u
X-Rspamd-Queue-Id: 4gVTQT2MYBz9tsv
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

The USB part of the staticize and constify changes.

The following changes since commit 4674475760d293d6cca07c2f85ef48029e08078b:

  Merge patch series "Enable splashscreen functionality on AM62X" (2026-06-02 13:49:16 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to 2e9e8915616b1b323aac37c2073964d7d112e06d:

  usb: dwc3: generic: Staticize and constify driver ops (2026-06-03 02:00:59 +0200)

----------------------------------------------------------------
Marek Vasut (3):
      usb: dwc3: am62: Staticize and constify driver ops
      usb: dwc3: sti: Staticize and constify driver ops
      usb: dwc3: generic: Staticize and constify driver ops

 drivers/usb/dwc3/dwc3-am62.c        |  2 +-
 drivers/usb/dwc3/dwc3-generic-sti.c |  2 +-
 drivers/usb/dwc3/dwc3-generic.c     | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)
