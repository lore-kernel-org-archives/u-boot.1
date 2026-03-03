Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C470EC142E
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2437383F59;
	Tue,  3 Mar 2026 12:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QtDyptr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7AD8063E; Tue,  3 Mar 2026 12:16:35 +0100 (CET)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0B983E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQCt84Wb3zDj8;
 Tue,  3 Mar 2026 12:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1772536592;
 bh=ouXqPNTbCss+TzYaGKADSYSO2LU7yKkhPDZ4uOi26W4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QtDyptr7xKal+Kx6FaIAH4mVOZibmpqo13lLHlId+VH7tdc97AgBjzG40H51PHfyT
 80AocsY2ChXAToj147Ev5tvqU1CG8g+cfsBkgGVi2KGjS9VlEase8N95wGfNnD+x/S
 Qed2A72vomSuRoezSNZF+BX5bcARetmvxqmCo4lckNzuF7TE9kbhbqz1G0LKEbKHWO
 e65TVO7nC4CMlmM1FTc89m4Nc9Awbp5m9rjciohhttywBwfEC4as/jqlqijJlKjjd2
 xMfhU7zy2lUouD/uxT98iJLqwff1S7QQduAJ99HxGJQ2pjtbGSus2xBzWQTvSz1oTm
 peuM2kUSp+VtA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fQCt76Gybzb64; Tue,  3 Mar 2026 12:16:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 03 Mar 2026 12:16:20 +0100
Subject: [PATCH 1/2] MAINTAINERS: rename LED into PWM LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pwm-led-orphan-v1-1-54d14a430cb7@cherry.de>
References: <20260303-pwm-led-orphan-v1-0-54d14a430cb7@cherry.de>
In-Reply-To: <20260303-pwm-led-orphan-v1-0-54d14a430cb7@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

It clearly only lists PWM LED driver and bindings so we should have the
entry reflect that.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8d4f6ee8b2..b50ac0ea21a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1298,12 +1298,6 @@ F:	doc/README.kwbimage
 F:	doc/kwboot.1
 F:	tools/kwb*
 
-LED
-M:	Ivan Vozvakhov <i.vozvakhov@vk.team>
-S:	Supported
-F:	doc/device-tree-bindings/leds/leds-pwm.txt
-F:	drivers/led/led_pwm.c
-
 LOGGING
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
@@ -1602,6 +1596,12 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
 F:	arch/powerpc/cpu/mpc85xx/
 
+PWM LED
+M:	Ivan Vozvakhov <i.vozvakhov@vk.team>
+S:	Supported
+F:	doc/device-tree-bindings/leds/leds-pwm.txt
+F:	drivers/led/led_pwm.c
+
 QEMU VIRTUAL SYSTEM CONTROLLER
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained

-- 
2.53.0

