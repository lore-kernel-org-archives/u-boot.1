Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C30FEB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0830A8857C;
	Tue, 10 Sep 2024 12:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H9IpEpUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3218857C; Tue, 10 Sep 2024 12:52:15 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6744488498
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so28679625e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725965532; x=1726570332;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QumShDrC0HnwqDn06Ety+UdZI4rnu3BzUaOKspAB5Bw=;
 b=H9IpEpUYid3opoAdfiBBeBEVg8DYGT2eEJm1tH2WGwqZn6zZFW8Qd43jS+Z5ijGyvR
 SSYs4gazXxlyRJvDe10p7VDqcorECz93Z/O7p0ENwzWLTPJIfeXn/rnJIkWzGtdizwVL
 ImaRXYMbZN+8KSyZDZBSdi2b/RUtGPcjZ8S+Iw8MLYp6wn8DOHYMgKdhMKcZGDqkcogP
 C0Bx+J05MjmQRFJIcPj8LOuHt5x16+SL+PuFPxbWh3odUyo6SdpnVzzWSeCtnS+WrrAX
 QWuUmsCFrPZ1TEA1zg6982GZwtJqeHkEorrQ/4EPO1bMaS62bG2IQs+G2KM3/hBeap0v
 ACQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725965532; x=1726570332;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QumShDrC0HnwqDn06Ety+UdZI4rnu3BzUaOKspAB5Bw=;
 b=IOmAj7776XR+WDxUfVxr6Qpwq1qzpZJ5F8Hp/s7NG5GCmzP7ktlngYLfACaiM82LvH
 3oOErsAqYYUKzk3ObCy9piIa60i/FjEZjR+iwBCdLwNNOWSzV8wBc7UVPcMVDOgaJ81p
 fPdsD4a4qZ2VMDrsz/zGnsJiN2sQFd3l8e1TEf8CHx1a6e53t38xMNyBZbX1BC9Vp5wW
 YsU3Jye4I04/MEXEQ2/dJRkls0sua05T1qw2UJi5H8t3N+OhlgPCLE57u+3NUPu8Auan
 1RchH39MmjRG6DqOLcZ07qnKiRhH1RfUiPbNtUGBlPqdKw6BrqP9jDtTfr0UqaNuBAOZ
 r78A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQfnIeVPAU7Aj7L39oJbSOEIjmJhsrTCEsyQ+Dls9Cka6iuXwQXoHpxNHFLx5mVTzA5BObXiA=@lists.denx.de
X-Gm-Message-State: AOJu0YxEr0skvwjW4ANAonU93wAK4iLOhRO69N+hWsp2OfinNYVPW6su
 Ol7FnuMxP2ucU+ATSearxIXm3QW0mcSNHEtYX+fttYe/FxSSJ/YsorwM7cFE8Dc=
X-Google-Smtp-Source: AGHT+IEt3qPCls8ykXDKldS/HeikJnwR5XKlCFpbrO3z3YaD1BhvQiobMUo2Gl1aVqf3t0xJwwhROQ==
X-Received: by 2002:a05:600c:1c9f:b0:42c:bcc8:5882 with SMTP id
 5b1f17b1804b1-42cbcc85cf9mr33129585e9.7.1725965531072; 
 Tue, 10 Sep 2024 03:52:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb1e3a5fdsm93574825e9.48.2024.09.10.03.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 03:52:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Joshua Watt <jpewhacker@gmail.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20240910
Date: Tue, 10 Sep 2024 12:52:08 +0200
Message-ID: <87seu77pd3.fsf@baylibre.com>
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

Please find some fixes for master:
- Fix ANDROID_AB_BACKUP_OFFSET unit to bytes

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22302

Thanks,
Mattijs

The following changes since commit 1312faac5f52d27cfb45dfe1a5a93a2944ca5c21:

  Prepare v2024.10-rc4 (2024-09-02 14:07:53 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240910

for you to fetch changes up to cc2f60c13f6aaf1bd277cf10c8b375c2e4a695b7:

  android_ab: Fixes: Fix backup offset calculation (2024-09-05 08:55:04 +0200)

----------------------------------------------------------------
u-boot-dfu-20240910

- Fix ANDROID_AB_BACKUP_OFFSET unit

----------------------------------------------------------------
Joshua Watt (1):
      android_ab: Fixes: Fix backup offset calculation

 boot/android_ab.c | 9 +++++++--
 common/Kconfig    | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)
