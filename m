Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F023CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 15:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D202E84701;
	Mon,  8 Jun 2026 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NhX1RhvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B24846A7; Mon,  8 Jun 2026 17:48:04 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B636283EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 17:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36bba9a1089so2640637a91.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780933680; x=1781538480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ps5xiFW5Zj8WQf9awi/q/UznfOwTjykb8k7y7w88k9s=;
 b=NhX1RhvJkIm2GWsJTkD6uPPgss29b4s2KA5IEuD7EYzbf1FFf1scv4ClI6lUnoT8Ey
 HmvEQI3SaO1jtntbB5stl5BlASz2RUVSyVdQfY4UYpu8x9dsZzhoZXRTKnffuQPqVBMW
 gjXwGG9vVTQnpVYcQUXUyolylcCjHol+BbBhgJn52wV8yD5hpax9YkQQhNIzfLC3im7I
 HDbtnUX/WDvQ3WkVbq7MyKeozAMSDfggC0cJn3yXUKuLOqzWQESmI/UbKjuoI5xczTyL
 nBTxN++hEOemA431D1LSmV0newKK9skgCULbtpJgLSNzE1STpXnQ8hTb9yUFuuUVmgyQ
 9WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933680; x=1781538480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ps5xiFW5Zj8WQf9awi/q/UznfOwTjykb8k7y7w88k9s=;
 b=R0ynh7x31Qi+VhK54xuthyGRab81Zs2TydcixhxA08bpc9f47N+le9pvuqAzI4fSLq
 0vKm1MN+y+Nk6+qL0GxDTlp0aUq1HDIflc2+qbvCgiPh/mLGFn4BnJawP3Hq34O55Vkp
 Ni/62XQT2Z7zZ7nK4qASplVF3OaqwUXjrr5zuZ92enWISoqJFay+F8B4NaA98S1fz8gB
 WRYxQVlXSLmKD9RtZm+Un0ehYQZUTx7YGUAJS0bjlVeS/1tS5BEo94pVxq+rmCoVLm75
 dZS2J4YguI1jfMzoEcbvVZaVRrNNQDTV9rZjbJL0KxZbtk9kjtjfmZRIq1CRLE1xNAtg
 h+Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sTTb3sZjc0CUnn7m532SS5xKColPOf0CtxNJD+fnu+ygiRDV+Uew6VwRGSf7TQ7qiNN8ykdo=@lists.denx.de
X-Gm-Message-State: AOJu0YzD2AwdaFHyQTs7w2AkGB2s5qERDB/iV6T4bMw+Z8vD9EPk0ME4
 qaPxx9f36fZwSApMonuWZYE9UxJKJNDc7CmTqXGZcEI8Zgtl4+zYCFwr
X-Gm-Gg: Acq92OE3BwoefcZ1iI/0BPn8vjZxLo3FlTHpA+heO/Gsb929aSX34bPjyIrvSeDlmux
 GIo5I6KMnC2+LVKaUMctdp6+4JI4ZPlFz7uJKXpQjVfvvYtRVhl+l/eWHD9FKDu8FBvCVEmroSw
 Tdkv3zkrgZLNFT0dlhpWJOmZEw0j5/0qrCbdQFgOKPrc5VVo+2g2eV7KI2uG+uV57mixGKTPe2M
 7iDUf/dDWnL2ibKx0M1VD8Ke5WiTq8r4PI7UJ5WXZTNVdsTq/tKvlihbd03KyPO5V94XtJmpPAW
 Sgx9bV4Whan25TN1tArsYFoDIHFrlzSqQtKHtir8WM/bBxUEyFPr6SDekyfMakhy2brcp7QZRcQ
 1l1mgYxgZu+M1IIiVRoefv5dMVYWvpj0FixIfvHHiJBhlJrOCndmTP7cZ0Dqep/IX80I4IHV2tm
 Cv2Q4roQKeUiA2lDUMCpDXEHQKevQzS1lBT5aWLhH9JcVL+0HSuEEV5HXhiKe/wl3di/Sc2Jzk2
 FZ/Fc4nLsZn0CTxcXku7CRGEB3+T9vHGQ==
X-Received: by 2002:a17:90b:1fcc:b0:36c:e254:4d5 with SMTP id
 98e67ed59e1d1-370ee5450aemr15675770a91.4.1780933680013; 
 Mon, 08 Jun 2026 08:48:00 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf827f1sm19778621a91.3.2026.06.08.08.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:47:59 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: naveen.osdev@gmail.com, u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] goldfish: Return error when device address is invalid
Date: Mon,  8 Jun 2026 15:47:47 +0000
Message-ID: <20260608154749.1190658-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
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

A patch was submitted by Naveen for the goldfish serial driver to
return an error immediately in of_to_plat() when dev_read_addr() fails,
rather than deferring the failure to the probe() stage.

To maintain consistency across the goldfish driver family and better
align with the driver model's fail fast design, this series applies the
exact same logic to the goldfish timer and rtc drivers.

Inspired by Naveen's patch for the serial driver:
https://lore.kernel.org/u-boot/vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim/ 

Tested on qemu m68k virt board with date and sleep commands.

Kuan-Wei Chiu (2):
  timer: goldfish: Return error when device address is invalid
  rtc: goldfish: Return error when device address is invalid

 drivers/rtc/goldfish_rtc.c     | 8 ++++++--
 drivers/timer/goldfish_timer.c | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

