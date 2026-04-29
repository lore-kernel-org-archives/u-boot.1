Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC63FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CBB84843;
	Wed, 29 Apr 2026 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r0BeZYrt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="huOXmiE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD11884848; Wed, 29 Apr 2026 14:28:31 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE3E8483F
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g5Gms2hX5z9vKq;
 Wed, 29 Apr 2026 14:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777465709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7VDeHm+DP49ng7QKJ3cdFBL3oxEZXDdEiZvA+wlaG2s=;
 b=r0BeZYrtjqplBZBWe5A+46/JhFy84rHpa+4/2+LPViIoi+ZczszNbWyCfefrLfap+yj+sV
 6nWO1zVSE7ocK4NMAUUFzoLSibdLzgQoaGo2Eyaj3wITPr2mKUHB5nhIKWqiILUYpm2TR+
 1ZC6CJmNfdSQr8aUNi55M6lZ4LjBQ07Qceg+kcEkIIfy90mjhR55NyNrE8v4FG76iENBhE
 Mai3oS6jyzcgnAFUVTN4643GhbLcyidvyM2AEDFn68SEPVZSAI/Vcep//sH4gl8kPFkfev
 LnCD+C01DEyAUzMKjcUkIPyrL2IzC5RH8P45GLd6LxM+CEoBL7e10Gcvp4WD3Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=huOXmiE1;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777465708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7VDeHm+DP49ng7QKJ3cdFBL3oxEZXDdEiZvA+wlaG2s=;
 b=huOXmiE1IX2xEj+DBb/05NooIObKM3mKbZQudNDHf4jmUMNDHkP1XFXG8cKud7vxNaPBb2
 C1H3Ia22MbfraIZ5FmYjiUcFjKNSpFc6LNmmow6IrmQnwgRDzEcn7Nk353/yLu8zckZpXk
 ThPOeHh+Jrr8B1coe6w6kkjn1i7xCkXlWN7TKkejkepnLspeWzUVRbu1hyWFO7LqmzmXd0
 mx/dPe0a1gCjGZUTe9GSo6sVXKuxbM4fypt1M5W1/OTTNHdfQJ7GBFyTIIMZTUdA+8Fl9y
 q/5HVbIN+clEk8uRHmQWDIXVTQvknkawbi6M1ZCIhphiDkdUaijU7MUgHh6MDQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Marek Vasut <marex@nabladev.com>
Subject: [PULL] u-boot-usb/master
Date: Wed, 29 Apr 2026 14:27:49 +0200
Message-ID: <20260429122818.392911-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a28eb890ab31574b3c
X-MBO-RS-META: k4eybo1jpec5wc1t6ebf7wzs5smzukz7
X-Rspamd-Queue-Id: 4g5Gms2hX5z9vKq
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

The following changes since commit d0d1d11119282b76551d45e531235238da51d7bc:

  usb: gadget: rcar: Add support for RZ/G2L (R9A07G044) (2026-04-26 17:52:36 +0200)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to b27a31665da75134ec1ef25f91f27e56aa45e392:

  cmd: ums: Switch HW partition before block access (2026-04-29 10:32:04 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      cmd: ums: Switch HW partition before block access

 cmd/usb_mass_storage.c     | 11 +++++++++++
 include/usb_mass_storage.h |  1 +
 2 files changed, 12 insertions(+)
