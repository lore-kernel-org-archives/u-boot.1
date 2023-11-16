Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1DAC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E7B8749E;
	Thu, 16 Nov 2023 10:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4NjIM/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EAD87497; Thu, 16 Nov 2023 10:00:06 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A2F87479
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso79689066b.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700125189; x=1700729989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yLGYIdAc5e+QxV9QDjYK29kNJM3f/bu+mq5Gj+lrSUw=;
 b=J4NjIM/Jy+iHWlFHf5RWx9LS7aVBiNpat0rtVM9/O5ppVLIf1ArTkqCkNVgs9u/C69
 muA0lW+mDb+1jK0wqkx2oGRAdesORzSIZ2vifbaGU1s0AVRf3Buqkz5KroDkhyoZ0rA1
 hWkljmlZaaNaJIf4JOUcnKtXaiHgujvzBzB3/IAtdGE9IL14QnMYVPHiKOk0xeEF4/Xt
 Fk1LP5oQUhu/1lIDnPdSrKCikh23X3lN4RI0tXWZbC2viq59avW9lYyAdsGRL9t+BiTf
 TkSClza3zTYU9fHyBbK3YnPYCM/kLC2rZHRRntkx8V6acUmhx4bQa2fyBSpuvcNK01T+
 M49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700125189; x=1700729989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yLGYIdAc5e+QxV9QDjYK29kNJM3f/bu+mq5Gj+lrSUw=;
 b=LTHv0VOoXW04/cViU06Mwc8f+NhWKVwcS5UEccttXb2d1GDNSWXiN/bdsS8VQ4Nzz3
 6j8MqpxQtRMJrge+XuOO0PcGYjGEx9XeR+8HFA9y8PPcERTYEXF1p1iKf5T51PThjme3
 zqKXM/MgE3fRQTYd4tQDDkBoRVu5pWUUx0RgXuiGu65qCBXZ3Kzpicc5Pfc7PzP+xYo2
 HPSq3f/6zzgIf2qddR7eVH8aiHFsgkjRfURdhISH3CvWTS6ZfeFCZzJIDSbhpigSoVyx
 fqjPClyROlJs6+Im4phqBgrcF8SXvibsa1p3C0Yg5oYM/STBeDJpIIwRt1q9Jwrg0fiB
 MQHw==
X-Gm-Message-State: AOJu0Yz8HC9bx7+GehWUSEVoySqYjnWjsIdXOsMPTf6hIAf20qUramWv
 TjSlF02XwkhPWIlbYf/0NS8=
X-Google-Smtp-Source: AGHT+IHbi/7pmT5buY68e9llyz5JtFOwMTAmEWHuOCWiR8pmLfnJnS7njb4YtzcDrSIqfVo0/osGCw==
X-Received: by 2002:a17:906:4555:b0:9de:52b:6938 with SMTP id
 s21-20020a170906455500b009de052b6938mr11056470ejq.9.1700125188632; 
 Thu, 16 Nov 2023 00:59:48 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906601500b009e655c77a53sm8093259ejj.132.2023.11.16.00.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 00:59:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Implement support of simple PLL
Date: Thu, 16 Nov 2023 10:59:28 +0200
Message-Id: <20231116085931.411707-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Simple PLL clocks like PLLD2 were omitted since they do not share common
4 register structure with main clocks. Such clocks are contained in simple
PLL group. Only clock_start_pll function supported them. This patch expands
this support on clock_set_rate and clock_get_rate which should make
simple PLL clocks equal to main PLL clocks.

Implementation was tested on T30/T114 using PLLD2 simple PLL (PLLD2 can
serve as a video subsystem main clock and this is how it was tested).

Patches pass buildman
./tools/buildman/buildman tegra

Building current source for 33 boards (12 threads, 1 job per thread)
   33    0    0 /33             colibri_t30
Completed: 33 total built, 33 newly), duration 0:06:25, rate 0.09

Svyatoslav Ryhel (3):
  ARM: tegra: clock: support get and set rate for simple PLL
  ARM: tegra30: clock: implement PLLD2 support
  ARM: tegra114: clock: implement PLLD2 support

 arch/arm/include/asm/arch-tegra/clk_rst.h     |  3 +-
 .../include/asm/arch-tegra114/clock-tables.h  |  2 +-
 .../include/asm/arch-tegra30/clock-tables.h   |  2 +-
 arch/arm/mach-tegra/clock.c                   | 78 ++++++++++++++-----
 arch/arm/mach-tegra/tegra114/clock.c          | 22 ++++++
 arch/arm/mach-tegra/tegra124/clock.c          | 12 ++-
 arch/arm/mach-tegra/tegra20/clock.c           | 15 ++++
 arch/arm/mach-tegra/tegra210/clock.c          | 15 ++++
 arch/arm/mach-tegra/tegra30/clock.c           | 22 ++++++
 9 files changed, 146 insertions(+), 25 deletions(-)

-- 
2.40.1

