Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA920C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 13:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095DB803DF;
	Fri, 21 Mar 2025 14:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sqB+1J6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271DF806D8; Fri, 21 Mar 2025 14:16:58 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7469C8001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 14:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so19092035e9.2
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742563012; x=1743167812;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3n9JGL7k33s5bE+2UJ83UeoR9PHPuZ4R4vorfRQJDM4=;
 b=sqB+1J6SImzHQz02aWd1f9/QLlFZyk5+0tmH4WSBOOdni8LOjJRw0bzTN/v6lFJSD2
 eLhdvLt933G7fON+dbmNAcnnaC8w5LRmRxCXZlqdgnjTajVLlLJdj9V04/61pJ/F8+KB
 Isj4r5v+YKp14HI3zimrWQ+Ac0g4p1hivNC/kPISpvBhzzcJba39soA0PdBHt6zeI8/e
 O7rWzJoEevqQQGM9OhKp1T+jtYzIlHBvgdAtQ2THpnGb3mg+be1kWjiR2S9rGQFTMCyw
 v7/1XrHsdOvwb6eHqYQ6rgYq4ErNMM1JeaAj+/trrkib972Hkdfc7E4DIw83HFb6Yzvg
 Ldng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742563012; x=1743167812;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3n9JGL7k33s5bE+2UJ83UeoR9PHPuZ4R4vorfRQJDM4=;
 b=IVd6EHFv31DzXL8z2BmoOnjLmwdD3p/tTMGoF2J89HlWEkuPs7nEsNWJviUbRI87ix
 aRw0Q/+IfCTlNlvhM2SUXnQEW82SyPLJgxJJzxE0TNmShU6yR6etETnQKQFZ853M/qax
 YT+BOyI3lZP1NSTINACUvffPPRjTFzxZf7pCF187eMP4vA1WAgujbrxt3KO0w393Htm1
 FnEIhKOjIFQyqVt8Tee87LUpWs83yYrwtjEFgegoMsoec3J7WTXweOZacj1pIy30L/Qt
 gsqYI5EB+SIsKKfvmdAicf/Nm9m7/7nxvJJvQyy+IxJS2kR0Vx5B0TF2DQFULU8sZbKa
 +b2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw49iCLyuE+a4U4BfJmen5p4fwHmaDnMUgb1lj21jre8rOH1Gp73JNXxLBiEBC+fFHkEDRL4g=@lists.denx.de
X-Gm-Message-State: AOJu0YwzacAZMo2RSvLpOph9kJBBuwmam6HKCq+WXp+JtBne54gHnXnI
 C8NLukeTxfyleTMn+QaLfMh5flaHbY3CuxVkDfMdZh0QbL5YmGRUkSpUYnuXSy0=
X-Gm-Gg: ASbGncssLwc/bj2NqBQI9EJ4DI0/RTkfLb3UkBYTyvqQ78LLirhWUwEntwn5BF+gOuB
 YaI5Z1BIEY5WpKtnzqwD/AFWz302YBRDtr+P4XmcFZQmu6stahxjdjv8EtWPPuR55U5wzW6e77O
 zuE2NZmg+UZUfJfOSx+6xQYXbfGCRaN3bZOI85MSptvmZMgIJiczJaBAg5KYEFNcv3xz3iMybsh
 xDx8frAl7wPb0/0fpXJBZpFlqeikN5T0WQbqHAmlqFddNR7qr2J91EXa3w5yv1CZSfUMJfq5Urp
 nc4Q8x0zdTF0Ef4TUQRDTeI2HlKOPMGED/17s7TFpT1by8SBh9XMgxE=
X-Google-Smtp-Source: AGHT+IFKRQyLRvrlVDBj4VziCdRBVkMfF1jc5z34Owc2b6QtQPfwM0hWVb6Yt8JUZ9by/08pwkT4qg==
X-Received: by 2002:a5d:64a7:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-3997f8f832cmr2380613f8f.7.1742563012049; 
 Fri, 21 Mar 2025 06:16:52 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a345fsm2338128f8f.24.2025.03.21.06.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 06:16:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Subject: [GIT PULL] Please pull u-boot-dfu-20250321
Date: Fri, 21 Mar 2025 14:16:48 +0100
Message-ID: <875xk2frr3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Please find the following fix for master:

Usb gadget:
- Fix NXP UUU tool compatibility regression with dwc3 gadget

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25275

Thanks,
Mattijs

The following changes since commit 7ad543619463e8817b3044041ac74749a217bbe0:

  board: verdin-am62: remove spl_perform_fixups (2025-03-20 08:02:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250321

for you to fetch changes up to 0916053ebc566245b06d0a179533f6622b6ad392:

  usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool (2025-03-21 09:37:40 +0100)

----------------------------------------------------------------
u-boot-dfu-20250321

Usb gadget:
- Fix NXP UUU tool compatibility regression with dwc3 gadget

----------------------------------------------------------------
Marek Vasut (1):
      usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool

 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

