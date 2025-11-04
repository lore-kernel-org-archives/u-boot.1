Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABF2CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 13:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A161F838EC;
	Tue,  4 Nov 2025 14:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nxAu32tN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c8vBcNkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECC4808AF; Tue,  4 Nov 2025 14:36:30 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35448003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 14:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d18cX4DQtz9vC2;
 Tue,  4 Nov 2025 14:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762263388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8ldnHui4KtVGjob2ASj7GWXhJt9435yLGoH8Wgtx2/o=;
 b=nxAu32tNqouk3e8OkjfkyyNvHvLTe+PMb30fCon7IFjnnWk/bNlobTTd5+rWSZbD5sErwN
 ZCZR/WfryT6F/0/UHmP0E+jkMopFwOnspiO8xceCReDXOp1PP4mx9fueS39djXiZFohK7K
 jx7UaR/Qjh/Pto10M6rey0S7ANlHhowzwqNPsJst92sHgWmWrFmNbfyPTp2SNwz2oMERk5
 9q09G0RR7eRM2QVRaiuXduQUHhG0fm0iM20yeGYlwqdW5a4yJz2irXuV42yNkQUzAL7jaR
 LZAIrlN6tL7pn0UobEPKoUm7UPHmqTmp9ShxBOLAcYfHLb7quyZy+4PbvNtiYQ==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762263386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8ldnHui4KtVGjob2ASj7GWXhJt9435yLGoH8Wgtx2/o=;
 b=c8vBcNkTk6ar2wB2k2ADT1k5xLrICUc3OI2TKrLWWFU7iD5qnJje1Ng+/Ol2Lw2F2XjXC5
 +Byq5CxImXjG/PrggsgY8VWioDYNtwgJVEs4AMrfSDgf6WbBUx9TLOztRrokOY3viHh3Ty
 yxrlgoLWGeMKbh7IJe2HSR1il1ZaLwRIijR/IhuVxcqp1S9t0aJtXOi8g49nVr0y4Hd87J
 OC7CvzffaSs4KL8iJ24z3HYn2ENlpWVwoqqhWal3aNgyNwBmcOmXJd2/lvmGyKdmwjQenl
 /C5CjCOd4QhP7B3RB/qfxE3SaPjMbAj0Pq7R6NHBC7ozSx/L6od0cHVZxj9Zzg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PULL] u-boot-usb/master
Date: Tue,  4 Nov 2025 14:35:58 +0100
Message-ID: <20251104133611.11009-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4bc19e7cfcc24334f6a
X-MBO-RS-META: fsjmmc4hgaes94frpy7ddowmradn8mi3
X-Mailman-Approved-At: Tue, 04 Nov 2025 14:51:55 +0100
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

The following changes since commit c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5:

  Merge patch series "Allow falcon boot from A-core SPL on K3 devices" (2025-11-03 13:18:26 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to f0f23e0618dd4534a57f843105a2c1b3f4f44d22:

  usb: musb-new: fix typos (2025-11-04 12:42:10 +0100)

----------------------------------------------------------------
Yegor Yefremov (2):
      usb: musb-new: fix ti-musb dependencies
      usb: musb-new: fix typos

 drivers/usb/musb-new/Kconfig       | 1 +
 drivers/usb/musb-new/musb_core.c   | 2 +-
 drivers/usb/musb-new/musb_gadget.c | 4 ++--
 drivers/usb/musb-new/musb_host.c   | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)
