Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F06EC142C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E7B838BB;
	Tue,  3 Mar 2026 12:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="S4BKwMet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2FA83F63; Tue,  3 Mar 2026 12:16:34 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E97D8063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQCt76PB7zFjr;
 Tue,  3 Mar 2026 12:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1772536591;
 bh=zxrrLsNIkT6ZdLcTFQHYaWui+9ppeOlycn6c/u7/x68=;
 h=From:Subject:Date:To:Cc:From;
 b=S4BKwMetWUOkTH7UGMOCUSduKcT60ypgKdM7/FnKldws/nOP9UuGPrzaS/ji8e/iO
 gJiafk0++ktKgFdUwq8XzG0SMhQ4CF0f0qmQX9Y1iCLIzte0Ao7a6Usau+X2WkyUmI
 Xvtl0E8ZC/jL74sVJQUNnB82O6buM+hg1s0yBv8bfbMK3qdYrgmf1dqZ76xMl8pKc6
 EEZ8i/yCVgODNwwczQpjKWuTaZuzrDlMJaE6db1VPUqO3aT5FPKWiKIOSt7Ms/zS6Q
 rEt/lvcpWTSZUJ4uFAztRzeCzOHl/hwxQA5gWCfvDWvwOW+E6jv3j68R1jh74X9ZRQ
 M9Tdpepg4rpaw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fQCt644ZMzcVy; Tue,  3 Mar 2026 12:16:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] update MAINTAINERS for PWM LED
Date: Tue, 03 Mar 2026 12:16:19 +0100
Message-Id: <20260303-pwm-led-orphan-v1-0-54d14a430cb7@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3YLyXN2c1BTd/KICoLyuiYmhgamhQaqlUUqyElBTQVFqWmYF2MD
 oWAi/uDQpKzW5BGSKUm0tADIs6pRyAAAA
X-Change-ID: 20260303-pwm-led-orphan-4410510e92dc
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

The entry is named LED while it only matches PWM LED binding and driver,
so rename it to PWM LED.

Ivan's email is bouncing, so mark the PWM LED entry as orphaned.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      MAINTAINERS: rename LED into PWM LED
      MAINTAINERS: make PWM LED orphan

 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
---
base-commit: 86219843e8489ca9c27a5a008ef4ccc427feece1
change-id: 20260303-pwm-led-orphan-4410510e92dc

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

