Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D47E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4082283AC5;
	Wed, 18 Feb 2026 15:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="b7/nOtog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4038D83D17; Wed, 18 Feb 2026 15:59:40 +0100 (CET)
Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net
 [46.105.56.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7470C802C1
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.231.103])
 by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4fGKRX4y81z5xJy
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:59:36 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-62b48 (unknown [10.110.101.145])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 4092CC01C9;
 Wed, 18 Feb 2026 14:59:36 +0000 (UTC)
Received: from armadeus.com ([37.59.142.110])
 by ghost-submission-7d8d68f679-62b48 with ESMTPSA
 id hnYEB9jTlWnVjAAAa7HxRw
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 18 Feb 2026 14:59:36 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0040da32969-884c-4f6a-a1e8-f14e886230c0,
 BCC414E58A87BDF8F3171654DA18834A20810328)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 86.243.239.229
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 0/2] serial: lpuart: fix RXFE filed offset and handle
 Overrun flag
Date: Wed, 18 Feb 2026 15:59:17 +0100
Message-Id: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMXTlWkC/x3MUQqDQAyE4atIng3sLkW0Vyl9WOxEA6KSbWVBv
 HuDjx/8MycVmKLQsznJcGjRbXXEtqFxzusE1o+bUkhdSLHnZf9l+7JoZasC3kQK3OEB6buYMQz
 k493gyX38el/XH7wMfS1oAAAA
X-Change-ID: 20260218-lpuart-fix-rxfe-offset-f04ef861ae99
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Julien Boibessot <julien.boibessot@armadeus.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.3
x-ovh-tracer-id: 15264950939735938761
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGT2+BOqQmKGWy+4NY18UTeaihDDWmFcw9hg+cK/GtQ/dpffk7aPmnOOiH7aP0rc/2FyPKj4KZeickMgGEAM57Mnr9QE9HhxnLK247wLds4vEfP21fLH/1pAfOHmqE6/DDH0PY2azgit22TP63ese/AEzyq5BWgVcq39JVmPhc4Ts7BjKRoyGfe5hpkxmQTBOKBAJPqIA3LVzJDcieMQr3QWDktdGSXAMtWRO0S2607bHuGGROyMCFroLHWTLmREQE9xHOEUiLhMt7PMMX2G3YEMhsXLJW0MCIgZzLIsYp7qY141/JKweAJTSRbdiLJ31OFiRpFtsLRz0o0W/Dj7PIFqiYU6CUpEiXADu6TYRcSPPMGWETD37BGIV0NFTkjIeXM8Lb+5u/fwhZL+xQ0iQ0Tn8KQZGkpODgQLDKGl1drODQVyj/ChHpAe/lLiuHt05gAtW31AVRRDBXa/0LdlJlbvppQyFVjTlac1KvhEu+p0lC5ieeSYqjsTxZYPnPTbgTpPmyYf3BF4kfU9h5Pmo50qs5Ie94NPoXQY83DQX3/AhfXSjPg30gpfdbhH35JoF0GdB77vMpffI5PHwIt/5NI/PwzEwM5ouQZJ0ETcNy3njYroUVCYX00AqIYfGiW1oyQVtu5csESpUyiexbSbzdxCLUoHYAci9KK5XBs43IANg
DKIM-Signature: a=rsa-sha256; bh=uCQge3wu4adIvvCERIK6ucoLOXufmVfoHKmZuPL3Ju0=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1771426776; v=1;
 b=b7/nOtogd1TsI5T6yVc2pAuxr2fmnbxcOv+iFvfNNR8zN2qBCGjXBOQJdiWmHeAmFFtdQ9Ld
 nK0b+FTSQZPDkqmgXovHpLi8I2acdXFHsTK12IHko5FAUyRAVIGDgW095OZcJEKi9DY/v4My14z
 re8MbVT8JYK4ki1ro2HFUSBye9u9n366Wls6w+ZP3hhkA+zWjT6WabvqMrkeJtR/TBMdcPmONav
 hJur5IOsA3a+oFkgXzM49d1yCFD7+7qPPdYKC5CrMGUKJB9PoNRh3pQuunQsXbEkh+P8KprhLhj
 J/fqKtf3S7GrQ4dZrO2Vo2+zhH7G7tPwoc8VjG2vzGW8g==
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

This couple patches fixes the RXFE filed offset on i.MX9 platforms and handle
the Overrun flag which can prevent user from accessing the U-Boot prompt.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
Sébastien Szymanski (2):
      serial: lpuart: fix RXFE filed offset for i.MX9
      serial: lpuart: handle Overrun flag

 drivers/serial/serial_lpuart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 8666b16015d4212facacc514e2eb626f3630dcf0
change-id: 20260218-lpuart-fix-rxfe-offset-f04ef861ae99

Best regards,
-- 
Sébastien Szymanski <sebastien.szymanski@armadeus.com>

