Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D72C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E1482AC4;
	Wed, 13 Aug 2025 12:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XpwO7xLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBFE8331C; Wed, 13 Aug 2025 12:11:17 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC73182063
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id BD12122FCC;
 Wed, 13 Aug 2025 12:11:15 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQr02dIUXH6a; Wed, 13 Aug 2025 12:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1755079871; bh=XU/XiQtLCqtgaWAb5mIpgCggz8Z99ov+1w9Vq3y7kCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XpwO7xLTVrIZd3TPM/+68ugcct3S1Jp9gBmcOgMFFbha4wGGRxuzNTKKP7q6RBmuI
 3JjPTQ3r1OFaGvofoJG8dBL7V7vblGua5/EkNRGSWfhkrG6dcHtt9XXF8KJeNgmB2Y
 BzawFiOGcvfpIYtV+zrPVUfYiI5QiTIb33NxRiXQ2JVPJ+mJAPl0fB15qGrwZTW6WV
 apKLPki6ylIsMdUxNfaLFPrIjQ/lKUZAqXbhRo31P19xiyKOn+yjKKrsufLUavaRDr
 owB7suWXFhUcws8tITdoVzS38g4NfYobZUOUYGknCjUKf80IBKs/kMM6XP0xbWMUNO
 4MdGx2zcranoQ==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 3/4] pinctrl: th1520: Mark driver as DM_FLAG_PRE_RELOC
Date: Wed, 13 Aug 2025 10:09:26 +0000
Message-ID: <20250813100926.51725-5-ziyao@disroot.org>
In-Reply-To: <20250813100926.51725-2-ziyao@disroot.org>
References: <20250813100926.51725-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It's common that UARTs are bound and probed before U-Boot relocation, in
which case the UART's pincontroller and pinconfig must be probed first.
Let's apply DM_FLAG_PRE_RELOC to the driver, allow it to bind before
relocation.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/pinctrl/pinctrl-th1520.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index be7e508f8a4..4eead0875d8 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -697,4 +697,5 @@ U_BOOT_DRIVER(th1520_pinctrl) = {
 	.probe = th1520_pinctrl_probe,
 	.priv_auto = sizeof(struct th1520_pinctrl),
 	.ops = &th1520_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
-- 
2.50.1

