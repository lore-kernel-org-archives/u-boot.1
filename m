Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9F6EC142C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EC183F75;
	Tue,  3 Mar 2026 12:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Ub121Lgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF4083F63; Tue,  3 Mar 2026 12:16:36 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BCA83F4C
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQCt92X3mzDnx;
 Tue,  3 Mar 2026 12:16:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1772536593;
 bh=z+HFN3jD+U8rY6QdjluZPJx5HedP68LBL5uzAkFfC0s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Ub121Lgt/1ETZ50i1o9b+oHkJhsMm0Q6idWYNxx31z75eQ7Epx4PCEMszAVAoxbPC
 CX9RxzHoO6JPt5Z93BUpvu5eCpUE8J40GK0Q6qSmmZirJlV3kuE45opXDe+bmwhfyf
 WDgZRXldzUvGilh8LCvMJklIjDLBe4AlYC3L6LV8xD3360X94kazR1wXSjh8i9o6g4
 9iDW/CCxbVmoaxML0X+qJPFaqMdj3sKdd+e3nPzm4ssRkM0hbajpQp9lU4QOj7Niao
 wf01R2d4qtCoV8tPLb75VM6Q+5QUyzKfO3EwcKb+8n2F/aOjjQVrVny97p2i4HTcn4
 EY+6g/2n/WFYA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fQCt84PRYzYCg; Tue,  3 Mar 2026 12:16:32 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 03 Mar 2026 12:16:21 +0100
Subject: [PATCH 2/2] MAINTAINERS: make PWM LED orphan
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pwm-led-orphan-v1-2-54d14a430cb7@cherry.de>
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

Ivan's mail is bouncing, so update the entry status.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b50ac0ea21a..56aa82eecbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1597,8 +1597,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
 F:	arch/powerpc/cpu/mpc85xx/
 
 PWM LED
-M:	Ivan Vozvakhov <i.vozvakhov@vk.team>
-S:	Supported
+S:	Orphan
 F:	doc/device-tree-bindings/leds/leds-pwm.txt
 F:	drivers/led/led_pwm.c
 

-- 
2.53.0

