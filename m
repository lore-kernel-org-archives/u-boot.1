Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B534E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 06:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6044B89540;
	Fri,  6 Dec 2024 07:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HnY6EER1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D738895BD; Fri,  6 Dec 2024 07:01:53 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E547389358
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 07:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ffdbc0c103so15196221fa.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 22:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733464910; x=1734069710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hSw72IHHFDalv6w3ydEFNq9Y4HY7XokYzjT0mKEDFxs=;
 b=HnY6EER1TKUI4m2Un+JDQxieghaqRwrKgKh92TAiDGlLLs6cHK4KkwMGA1wK97negc
 XxLJ1s6fttY2oyzMiX5+jpitvzjS5dkz93oAR5VkNGkuwuZV8XgMJT8r3aqFUhsACmyT
 JFfN8dhGNgiVkQPtIFigSQZOmuQJdDTT9lgrQaBH0kLwtrXzC475ZKe3Hy2P1DonVLjZ
 Ox3Tvso1OuzY+YlsgdESwyHmnIVeT/ijxE66ynTk3U/WqYFEHfOj+/wNqP/w648/wr2c
 F/wOxoazT/4niGakpoLGqkqR2qBz0FTszBjN9qPulE9AwS9RWjNDJXMmvbq/zHTJWCuf
 VeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733464910; x=1734069710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hSw72IHHFDalv6w3ydEFNq9Y4HY7XokYzjT0mKEDFxs=;
 b=OhOU6zYBv2wmsFD01RoN7EQD8TIGua44/YVEdzyI5ocIno8c0mzBeu0GrS7YLVm+rS
 vDvkHeca676KfuWGW7VdpIsTlVqDWjlYVh/HrxvnT33NXevXkMihqBm1kqV6PdZYqhLT
 XkgofhtALam68CAf6mQoNJfPcjRQ+E419lTGy0X5jZeUIvx2m8Zp+c1d/vq8zdSvyO8W
 ahmiWxwaeA7VkCEbz16wavVwHRMrAX5XTFdUrhqytHgvd720gn9/Y1N18rMTUsvkNLGe
 eHNF42OHxbW+jon3ffmScGZ0j+lBcZM0Amdd7hDdC5CcbgamGGj1YXS7F8jWzBta/mJq
 Dy1w==
X-Gm-Message-State: AOJu0Yz4yNpnEXeFEgWp3NSqSUZOp9jGWSyqj4ieHOcPM7nf+xABS65P
 HBKqHgYUa2zAGCnAFOiPH8KYhKo90j4XmWSrJ14/7NrZE92BjSlv
X-Gm-Gg: ASbGncsZz4ho0Ox+5y+roA1amOq+K89lZfTV4aDpT2x0TuVSchMGi9fGdc7v/qCAz5n
 KvC3uoPdN1cwZwAt2sAYcRgaTjPEhkTBXPtqv6g1cyYQNl9OotjqRgy4Nn3jDtE6ZGnpbT34gbC
 xPYf8JI501ADk0s9LL2VZTFFrKtNVXjylq4zK2uSL8XT4ym1l8exBfhrbaYeehafX7c7pXrX1Ad
 vvn3o4LFhKi1HRJebFSHrSoJK8Ml1lhjCP4+WRx
X-Google-Smtp-Source: AGHT+IFYW8s6m5kDPv/lVIxxWTHC8GYqZGOaiSHfG0GRNv9mr1HZJ92iO6E0gGQzOsPsMr2nqY8vMw==
X-Received: by 2002:a05:651c:19a5:b0:2ff:c8a1:c4c9 with SMTP id
 38308e7fff4ca-3002f62f8damr4217521fa.1.1733464909849; 
 Thu, 05 Dec 2024 22:01:49 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020e20e23sm3890941fa.88.2024.12.05.22.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 22:01:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Tegra: fix clock init
Date: Fri,  6 Dec 2024 08:01:14 +0200
Message-ID: <20241206060115.4346-1-clamor95@gmail.com>
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

This should fix https://lore.kernel.org/all/20241201164810.GT3600562@bill-the-cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5

Svyatoslav Ryhel (1):
  driver: clk: tegra: init basic clocks on probe

 drivers/clk/tegra/tegra-car-clk.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0

