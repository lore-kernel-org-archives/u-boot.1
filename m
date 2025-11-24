Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A992CFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A7583F75;
	Tue, 25 Nov 2025 09:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DJ0Epv5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9062683F20; Mon, 24 Nov 2025 23:44:36 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3916783EF5
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4505b05e7b5so1087362b6e.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764024273; x=1764629073;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6VPsWhjaRR0ZT35DQewbQder2dzfEIk7Zp6XaUFbN/I=;
 b=DJ0Epv5NEmUloHuT7TCYTBypD+gql3EbNHXI9JwSfEYO/b1Wxy0vVZgBYVJ1MfmVbI
 iSBR+4YUmLF8LPi1hhQC4Bh82qDjZadSJLCNxSjPBrRWajRU6hpn0j9LkxoRp+SW8oyG
 NDhpoZCpI5gvamZChXPnUte8UIQDI2ZM05lp03x0CDbbDHo2sDeenKs9GPOQ0abRh7/Q
 kcWHQKxADbeekZcim4CSFOHM6iPHv/bK2MMm0F9umfbxq12+gUqtiUzSOZa/gVHIEREr
 PgXL5Cj9B7H7ybtk//dtK2Evg2NITg3gx4U9f/MiNBiwVZ+zTa9MtRq0ebnLexfp5P50
 ZFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764024273; x=1764629073;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VPsWhjaRR0ZT35DQewbQder2dzfEIk7Zp6XaUFbN/I=;
 b=ey+92HFgYbSKHwkxVNcM1iM4bLW4hmykmtdOshGr6TJWyFds3WqQkpTGNa5aCWhpIM
 TsFOzWnNjF8CrnFOf4SYFtYWtzMq1PHpS3saGrn4hf+p/zAnmtqTwXjvkWAhGg4HtFAm
 gzyyuNz81Nny0KyPy49VxRY9KOw1XI8u6wacV+HczY/ZkIvrV3MNxHIbdtqFRH0SfdWg
 rwlwBqBpV2tfArMFKvIunJ+9pNtjUNkqLHbQBVYp8nXSynvjT2WxhgnYHoJO2B3FJ73E
 wa8w3aunuX90RqT78fQd2a+w6o7mcGSaK1MR1fYXGV22khvGBrhOoA1Hew02XG/XGBDD
 28IQ==
X-Gm-Message-State: AOJu0YxSfwIVqdL7kG5CqtWnJnF+5TX0X4wjLYE6v/LCjwO27oC+39Ng
 yhhGhUHhA/xrcAKzbfrJB/DIz+GsTLvQOAU9OHsKOyXGk502QnLPuU7oZtpeBBzIeK8=
X-Gm-Gg: ASbGnctISW4qT09yQdktsAULUlktG2MtMj5OKFvfhLzR8Yw9WZPfmmwbTj/x2rqYhr/
 25y6DtXWYs0gVc+KrDFxrzGiTfHJ1azT31884q+7qiwuTzHNKpx0kxxdAlC0QQmPozkeZWC31Ea
 Cl4l4K4VBKSPwRFdurj/93aNjEvO04GMI8QAIsb2DhwBZn0lEe8Vduq+aUAZUvS9zwtC1+ZxWN7
 Z2KJ/yDULxfCb328p2UhtjdTz5vynmJM54Kmnofocz6Rn5JVrpmLuwteef85EXJir08c0cfWtkn
 F9Rxv42J6jTjS5WB5fbpd+7opbJuAlLDwZlIkASZ2PYAlYdqQbj0lLAe65Ma15ykr6lVHY7ePlz
 jsn85+1yYz/ZD1tQRUQ45RZBsvoRU/noE150v5fw9BYqJ9KIT8ptfkUdXCy2rFSWSWeiJNa9cjQ
 2Tb3ZBPX5RKktSog==
X-Google-Smtp-Source: AGHT+IEm+Vx5PPn3qBJeKcdH0r9LR/01S7LzeEUAqVKqoX+6eLPBibWgVBnuO441nv9/zbTvG1EgNw==
X-Received: by 2002:a05:6808:6d90:b0:44e:c106:8192 with SMTP id
 5614622812f47-4511294ed47mr5163296b6e.11.1764024272950; 
 Mon, 24 Nov 2025 14:44:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a36:4d72:5018:118])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe65e6asm4095918b6e.6.2025.11.24.14.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 14:44:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] doc: pytest: fix hook script env vars
Date: Mon, 24 Nov 2025 16:44:05 -0600
Message-Id: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXfJGkC/x2NQQqDQAwAvyI5N2C2emi/UnrQbNRc1iVZlor4d
 5ceB4aZE1xMxeHdnWBS1XVPDejRAW9TWgU1NobQh5EoDBh3xnwU8YKL/tDZNBeUVLFO5tg/aaB
 IPPOLoUWySdP+g8/3um6E1ZuQcAAAAA==
X-Change-ID: 20251124-doc-pytest-fix-script-env-vars-03141d1cbc9c
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QKOwr8cvCj2M/BUzsYU5SRPNOMUXD2Bx63+xtCL6xM4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpJN+6IwpNY8UoaZCY/fBbyoV0RbCZOAC9yzq/w
 eWaJlVEpEOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSTfuhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcXwH/0lhHnTOzjp+d1YFm2k0eJ3RWcekLzX4sWyps6O
 S/Sd8a4qajMxWWh5PX/tdzJt2RWifNZ9UfXEe7eoHSLpl4dGPEKML0zr79L2ESdtor3XjkjAwhp
 Pjtfo6SVDp0I2rBP17x36Jg887ctmIMua00rdjcmHeiefswtU6EJHl9zQxNveL7f2qoAxmQwPJi
 Wi5LLfOVlIu6tI4TCpRCcAMlQuSdezIco9QYEiAjLmmukaFESEpUNtL2nnrBVR3CYmqyFH7xd5M
 kvC3LFSfbD7FaFe6f0dCAqHcmJwX13IKuGap7oMuuQ8odJ2+Xlnjfx5Q734PtOybGSqfDeha/m+
 Oi1Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:47:59 +0100
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

When I tried to follow the docs and make some hook scripts, I found that
the environment variables mentioned there were not actually being set.
It turns out there was a typo and they were missing an underscore in
U_BOOT. And I also noticed that some more variables we set in the
environment, so there is a 2nd patch to document those as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      doc: pytest: fix hook script environment variable names
      doc: pytest: add missing hook script env vars

 doc/develop/pytest/usage.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251124-doc-pytest-fix-script-env-vars-03141d1cbc9c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

