Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F25AE77183
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC0280212;
	Thu, 12 Dec 2024 11:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ay0OyrPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463E780209; Thu, 12 Dec 2024 11:13:42 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A2B801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so685663a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998420; x=1734603220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Rv6Py4XYOZIn0AqgZfjmXqeGiLRjb67GiRi8PTzuVE=;
 b=ay0OyrPSAm/b6wHfAAoeUaPRJ7p3zASgW6HVbk8ln/PTSztit6VE1TJ8qVvCMY1lsK
 PqEq8ZBp1lwzjE5zo2FIVnWAdJIOVJ+UQh4EbTWJsuFyi4kI70A9PIzgm/Rq8I2UDbil
 S3NtwwiI93plbHmE2uwvQh+g94CWnInu4/eJJNC7TR+l3ILwEhKOxudiPc4ltuBGlPKU
 435drVdFkyjdeI6PIwiPsV1mN98XBl4VblunWRDXn6ecjM8wuDQDQ2WmHY5kgcyw1s7J
 BPIyLL9pf5wI0OKHmqOLwnN6J3NtpFMNQUZ2U9thkifrXT7F1+Vtu6Cp9RPBRrI2t/0B
 Pa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998420; x=1734603220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Rv6Py4XYOZIn0AqgZfjmXqeGiLRjb67GiRi8PTzuVE=;
 b=j4+GeFV/JlQxEkRoXZ7u5cBPzOxReJdOJaszLQRcHXBgy333aXbHjMPXZe0rI8DF8Y
 vj+gZI+3PGCXEP7zO5kMThMpRqzgnxAl5w7i7KJPVleyDh9RgZJAQGoidK7acL2VEJqU
 WSgNPXP8RwQACoeGTwDt9rhRCrj+VtnNXTTDx3e8tkiD1iEaj9j8RUSJwg3h8gNFKWuZ
 3tyn/JfI1B3a3NlIw8k/ihL6PvNlLxT9IhmYb94rVvQz+KkhDhK0gomvS8unHMUIwT6f
 xXMvIHQqvKojFTUXNJUKc8SV3AUQn0fTaIa7VjzmSpEokyxPUCEAKIuc4EtgjBpy3zlU
 Px5w==
X-Gm-Message-State: AOJu0Yyn5ArxRlMzI/YEZ31Sx8OM85Xkio5OOOoF4bmqpYn9a+jCmALX
 jhRyEFAwylLSdvTr0qTV2MOvrPm/eolODlcJh2USion+vhiZrlTh
X-Gm-Gg: ASbGnct/67JhjoFQ8MppCtaj7rdYFqft9oyKWOn5dqtEX1LfDPxrfRT0k1kxKNszX4g
 qwT5o+8poYl+sZHXh1In9mSma2fwJGSIt3UXbWgUk/Jo6qz2ZLM3KCneh8OS9LWp0KmFw90Jbee
 Ri5mky76ta1cTPcLJaL2xS/ruNGAdqaD41BSlB+bsUDKDpJkAnZqRh7U/Tbc9TBqyhLITTURg4P
 vZNAcI0iko9g/q6jAMhUilT9dnWflm+5DDVCiNmpufCeY2/
X-Google-Smtp-Source: AGHT+IEu29ktmnK7wu4AAn1ZoUwOJKhZpizyy3C+6QaJ09hc3ssIODxPhC6/wMJPykNfv3o4fuxpFw==
X-Received: by 2002:a05:6402:2116:b0:5d0:bcdd:ff97 with SMTP id
 4fb4d7f45d1cf-5d4e8f64753mr424655a12.5.1733998419623; 
 Thu, 12 Dec 2024 02:13:39 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cdcsm10192647a12.9.2024.12.12.02.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:13:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] ARCH Tegra improvements
Date: Thu, 12 Dec 2024 12:13:26 +0200
Message-ID: <20241212101331.6135-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

- Expand plld2 support for T124 and T210 same as for other generations
- Sync common tegra30 and tegra124 trees with upstream (DSI nodes)
- Mark DC with pre-relocation flag for T124 like other gens have

Svyatoslav Ryhel (5):
  ARM: tegra124: clock: implement PLLD2 support
  ARM: tegra210: clock: implement PLLD2 support
  ARM: tegra30: dts: complete DSI nodes
  ARM: tegra124: dts: add missing DSI nodes
  ARM: tegra124: dts: mark HOST1X and DC with pre-relocation flag

 arch/arm/dts/tegra124-nyan-big-u-boot.dtsi    |  7 ----
 arch/arm/dts/tegra124-u-boot.dtsi             | 13 +++++++
 arch/arm/dts/tegra124.dtsi                    | 39 +++++++++++++++++++
 arch/arm/dts/tegra30.dtsi                     | 21 +++++++++-
 .../include/asm/arch-tegra124/clock-tables.h  |  2 +-
 .../include/asm/arch-tegra210/clock-tables.h  |  2 +-
 arch/arm/mach-tegra/tegra124/clock.c          |  7 ++++
 arch/arm/mach-tegra/tegra210/clock.c          |  7 ++++
 8 files changed, 88 insertions(+), 10 deletions(-)

-- 
2.43.0

