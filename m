Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00214E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763E983BF4;
	Mon,  9 Feb 2026 19:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mw7por2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2044D805D7; Mon,  9 Feb 2026 19:07:33 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2262A805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-386b553c70eso25094381fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660450; x=1771265250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+sH4NY+UBPc2b/KOuFeLdMaC8m6cmlozh5qoZApzPRc=;
 b=mw7por2cKJmcT0W4gFQD8BMqpBi9UWiRpwv9EjnKAnfxzxRtQhDbKQSiRZDgBqD83D
 IhzmeI8DMJqAQW/L81DZ1QrNc5bUNwRqkZ6W7l6UEywUImM0h1WK1TdN4zdDMn4i3Gml
 YiZHCniOgzCr3r0xd+VW7jmuqym2juEvDi+uHChHy1PbOs/DDLnej2hMqbmBnWCuckAn
 c/2XR7zNwNQUpaXm1+OfN/1TCOkqy8hrKCm+M+GoxCSOiitodnF1ge20XegXz6TI3DYZ
 hhu/mUsFaILFqAbjLya1C4mRfU54uDrFyfhA5Vbyba+Uri2Z5pQf7FDRcSy9Fpn5rTvA
 Qnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660450; x=1771265250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sH4NY+UBPc2b/KOuFeLdMaC8m6cmlozh5qoZApzPRc=;
 b=IoPr5WvuPsZyL8brsslsQMmLUdq5I2I1WQ+OZtRT8s28dktNymI4Z3s7C++8BnV9mV
 /DJtCHUF8jrcJl/0qtH9SRgEeYe7KWbzYpOCa5bWId/KBnjE0DikEmTykVeYQU6AXHHE
 +9B1C8aQJ6ZSTiWcN5pDwn5OwIEdA6BXo+uzLlF9RprvajZbaVmEed8vhMxaJWRjeySE
 UYbkouDxbDmr2clNJmcIMSFswCCW4iiVJDRfcds83CvjajZK4L6hqWF4hMQEzDhgchlb
 fq9bP8eVZHHJWNdIb3uxCgB4eWa+vBZ0UW0+2i7Vnp2WMyxhf2XWwhh8ZYWo9nxmkiUz
 B9KA==
X-Gm-Message-State: AOJu0YwZOadYw0GkXmcdnL84BbsIJooVP7tPrqUtB0ZFBU6McHAF5Kx3
 zWuoiO68GW23CiZHo/rVNjyF5vJHSpJruX25nTXa7Rv0SQro1ukRK9fz
X-Gm-Gg: AZuq6aIwb5DAxphpyo8ptu3lqActD5a0k/h3Sw968bUi9SPaCQnoVD6YBpIkSModhZO
 yVovySsN7qYdR8gCE4x2irEBwHNneF9dxDmCnjwdhXbnLryjnsaAx6+2SoHhTy68nGDC8E0wtRw
 QYsPJEmEzXE0qxFSDc7oQeZ0jFToEQwx4E49hAjcp5C5UOo8VNbBbBDZKi0Qy7IRLb8R1OKSpuB
 iP/cJe1KyuceJ04fVUADBtn2r+Bc1NepDWiiaMMqplMujkAmF9n2jWsB3Y9SmsoWpQPzJQOCQby
 52n1OSf1jqod62OPfW4XBd09zS95EjpPe3G76IIAXNCl+bI3R3WYWDDKl0PQibbX9Qlo4snoy9d
 HqViGs9c6X1/5sYlU+RTCySsIDpKaxFdUl830KWTNmJao+hx7/KMXx5yg958CsraUcmRlrKm2in
 HL
X-Received: by 2002:a05:651c:25db:20b0:384:9b92:c5c5 with SMTP id
 38308e7fff4ca-386b69becadmr24804831fa.31.1770660450226; 
 Mon, 09 Feb 2026 10:07:30 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b624d4afsm27397751fa.17.2026.02.09.10.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:07:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Ivan Vozvakhov <i.vozvakhov@vk.team>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] led: led_pwm: fix active-low behavior
Date: Mon,  9 Feb 2026 20:07:17 +0200
Message-ID: <20260209180718.32451-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In the case of active-low behavior the Duty Cycle needs to be set to 100%.
The PWM driver takes care of this but the LED_PWM driver does not take
this into account. Adjust LED_PWM to take into account polarity of PWM.

Jonas Schwöbel (1):
  led: led_pwm: fix active-low behavior

 drivers/led/led_pwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0

