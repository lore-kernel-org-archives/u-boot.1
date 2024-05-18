Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483CEC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 13:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7454A8865C;
	Sat, 18 May 2024 15:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20230601.gappssmtp.com header.i=@dowhile0-org.20230601.gappssmtp.com header.b="AjDllbyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610868865B; Sat, 18 May 2024 15:06:43 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B398858C
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 15:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=javier@dowhile0.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-420180b5898so8856275e9.2
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1716037600; x=1716642400;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NhWlwT/pT1fmUODA99kY/A/9JxHW00PIxAWnT4pFUdE=;
 b=AjDllbyHZzyoviqGwOhcASg+hidTtfrTbrSVz3w1kEpFeVbIiVsvuVDOejoBYacH6x
 WG4zVXqlHyWoy67cjIe76MjQjFIXY5m2lOWx1osxUHnrXm17kRbMU6m3Zi9Tpm9mb6kE
 09AaVivUBZfuMlm1TyvawZ5DayViVjYMwKb2mzB5msXxhSrvbkapshO+dBNzq2NBdN1n
 A+OzPY/NQhnP8uSO9icXHC9nbdyKDUT0jsj6sqPcWzh3PcjJZJOndKpOcMOsHvtwo2Z+
 fhujf7AUmquWuF6z294zOxKaUrqOzovLWV1C5tnMH7gHMMeeX+EhFYmV2k2de5ssDoAP
 EHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716037600; x=1716642400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhWlwT/pT1fmUODA99kY/A/9JxHW00PIxAWnT4pFUdE=;
 b=Z/ipOvCJgA5nXk1OuUaTe6V8nnW9NXXdW1NPfFQ/9N1/gTpDzN3iU6T6yclS20OQ32
 9Czf4PqG4AcWjbhzXU2pX9obxIlrv6IiYzGWHgVxUgW79FVECUVrk8B6xBszNLW+vbwB
 9XL9ovhsBEoDWX25a6xQOdonLlLFppTnhOBagveOY6apLC5OIYuUujZSGt4IKuMq1KpK
 oxbAV54BR5K+G6CE2S7d4C7n57NUHj8zjSql/lPrVI/hcAi5rDk2zNYjv75j5rE3Mkui
 XRmc4OTHWqwD9XsgIMLJLktzkZrBWm3SvMMqF0Us8U/r0DYaXRwFsqOhs9KniH723fpS
 h+mw==
X-Gm-Message-State: AOJu0YytGFopNRj0Fjy0BgQdn1Fr6b3PEpzw7EfnaLMQAeOwfP583mKf
 86Hc9K16lzTc0JT22GTrOscxYEPlgEMhxOyipW4oQk5VkUkc3eRHJQU1M49DkKGfBcz6IkcR2fZ
 4
X-Google-Smtp-Source: AGHT+IFiwd/yv5i39VMQN6KqdnN4Q6pD5Nat40VNE3weszlmsTDY5LfLUbs/yWP3ZzjbrOp16Xzwtw==
X-Received: by 2002:a05:600c:499a:b0:41a:fa9a:d86b with SMTP id
 5b1f17b1804b1-41feaa39369mr165566445e9.11.1716037599833; 
 Sat, 18 May 2024 06:06:39 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420273cff03sm122048335e9.26.2024.05.18.06.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 06:06:39 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javier@dowhile0.org>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RESEND PATCH 0/4] omap3: igep0x00: Fix boot failure and modernize
 the boards support
Date: Sat, 18 May 2024 15:06:11 +0200
Message-ID: <20240518130622.219031-1-javier@dowhile0.org>
X-Mailer: git-send-email 2.45.0
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

Hello,

I noticed that the IGEPv2 board did not boot anymore with mainline U-Boot.
This was caused by a driver change to allocate its platform data before
relocation and U-Boot not having enough pre-relocation heap size for this.

This series fixes this issue and also makes the board support more modern,
by enabling DM for SPL and migrating the IGEP boards to use upstream DTBs.

It is a resend because previous emails were blocked on moderator approval
due not being subscribed in the mailing list. Hopefully this time makes it
through, sorry for the spam to folks Cc'ed.

Best regards,
Javier


Javier Martinez Canillas (4):
  omap3: igep00x0: Increase malloc() pool size
  omap3: igep0x00: Drop unused SPI support
  omap3: igep0x00: Update for DM SPL support
  omap3: igep0x00: Migrate to use upstream DT

 arch/arm/dts/Makefile                   |   3 -
 arch/arm/dts/omap3-igep.dtsi            | 247 ----------------------
 arch/arm/dts/omap3-igep0020-common.dtsi | 261 ------------------------
 arch/arm/dts/omap3-igep0020-u-boot.dtsi |  14 +-
 arch/arm/dts/omap3-igep0020.dts         |  47 -----
 board/isee/igep00x0/igep00x0.c          |  12 --
 configs/igep00x0_defconfig              |  26 ++-
 7 files changed, 14 insertions(+), 596 deletions(-)
 delete mode 100644 arch/arm/dts/omap3-igep.dtsi
 delete mode 100644 arch/arm/dts/omap3-igep0020-common.dtsi
 delete mode 100644 arch/arm/dts/omap3-igep0020.dts

-- 
2.45.0

