Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB983C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63543801BE;
	Fri,  7 Feb 2025 18:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bZ84v2pI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 705F980737; Fri,  7 Feb 2025 18:23:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52151800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87C873FE71
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738948948;
 bh=icRF3SbOVF7GqVL6kUqahLFn6RuDypfEirtRKmjyyIE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bZ84v2pIhr7vw9+04FBPsaPRQYo1il8PpCkIsmACQngDzB5K9OP/DD1WIvr61OjNN
 rEteo7blzJ07bnwcgqU0j83KHyWwI8UMXYxu5UMtY0ZeL9rtVPDqDpmD8mWgmNT1ht
 UTkzGCEnkzXpevm79J5CC/orpr/PeG/j7MdeWeerEVGZMeJkDp2HoxSam6mxiH0c+D
 QkrrYYdHtcfHitKstenfaQimJlPPixuOGX02o9F4+tNjP0e8OTuadkU3OPR9HVhBGV
 5uaUUZZjOqvMZyOf9R6zQO80YX7fp1JZ/yXb+1ibwpY/vdrQO27xPb8p+CSbivsitZ
 Ub0Lcrr2L14dg==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d9fb24f87bso2722783a12.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948918; x=1739553718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=icRF3SbOVF7GqVL6kUqahLFn6RuDypfEirtRKmjyyIE=;
 b=oaGTey37ub1yUg7BDp1pb+p1aySpxUE+pYna49sYltU1f7h48ltgqWWLNXLgZPlnjI
 ozwHVnIJJT8zr3bW7C8lI2DNgfLsltQD9odtPfjHzoUYF8AqXQC34zhLVJn+qL6UDpmd
 hy6/D0rDDqaY8QwegIyDcCt64b2efqdW64ww+ylWRnHzZbMZx4XM1fgU9iV0p0p92HeP
 dw9aavCDhW2oi4o7WC2+IDDmBGaqhWe4gE51I085tQZQAU4EgHUKbHfelaMoTfClMUS/
 aA5eEB9Vjt1hp6I/51iuqfo+afJboV/bkiHn5UK0rOc+s1YJXqmU2OxvWs28TOZJtwR5
 QN/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM5CPOu89pxUbx9JHEtn/C/sS8x6oMULrzIEuYaitApnTBhFE9vbjxBhnYKSnBikTuZPBIvXc=@lists.denx.de
X-Gm-Message-State: AOJu0YyT0gFbf/ZJoj+nIV+dBGwaTuNkjoyT8NtwT9SfpfUM45kTKDRB
 rGvSTDqxJDw9U4UW1cV3b4UFWD4EkxzD0NPJpKflxwnQcta65PlOgTdbZ0DFPPcC7saxYxRKmI9
 HexjoPMG2EMroEcD4moYQwk5rF+DZmORWpPmoAZRSQoAW8bw2fKAJmPrN1wFMIXizvlI=
X-Gm-Gg: ASbGnctn267VG4cai+uUVjLPgVhneq69Gitfu1fUcBYNHWUMuPfDXG/218SA0PvrLfe
 +q6N/kj8LU7efxHZfqDpiU/5Jseb4Kd2v6y+uLEGK7IM5AzsNhRcrGzvyQzadEmgNjYnXtPRIPM
 Is/Kw+qNKJ+Q12C5wqMlgXyaCljUP5W5FkIKTevYnyhiz3mpnoGFNC/zw+R5I6Wr7Gni5Vqdza3
 IiEG5JN6YKfYZTnNAeppkTbYLzaOQZixCqRykmKaq+Zmi+nHhhFdEp9f4x7w6CFZIEQrTj5T4m0
 wE5hv9Hu4lBANCmiNYavUGpzzmbQHqY6hKyoCZ0o3Zl0v7bM3FOh/BFpuZJF8CH9ovH6bEdcTxh
 pwuKCx2E=
X-Received: by 2002:a05:6402:3484:b0:5dc:94ce:42a6 with SMTP id
 4fb4d7f45d1cf-5de450b0d9bmr3944614a12.22.1738948917927; 
 Fri, 07 Feb 2025 09:21:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaP/lt37IeC4cSF1ZckBL7DHTAWj3U5D6kYwki/8ZsjUZ3JavGHulS1/yPbhT1WJi+CCNUsw==
X-Received: by 2002:a05:6402:3484:b0:5dc:94ce:42a6 with SMTP id
 4fb4d7f45d1cf-5de450b0d9bmr3944583a12.22.1738948917438; 
 Fri, 07 Feb 2025 09:21:57 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:21:55 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/6] board: starfive: DeepComputing FML13V01
Date: Fri,  7 Feb 2025 18:21:10 +0100
Message-ID: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

We use starfive_visionfive2_defconfig for supporting JH7110 based boards.

The DeepComputing Framework motherboard is a new JH7110 device with
upstream kernel support since v6.13.

Add support and documentation for the board.

Heinrich Schuchardt (6):
  configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
  riscv: dts: starfive: DeepComputing FML13V01 binman config
  riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
  board: starfive: DeepComputing FML13V01 fdt selection
  board: starfive: spl: support DeepComputing FML13V01
  doc: add DeepComputing FML13V01 documentation

 .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |   7 +
 .../dts/starfive-visionfive2-binman.dtsi      |  17 +++
 board/starfive/visionfive2/spl.c              |   5 +-
 .../visionfive2/starfive_visionfive2.c        |   6 +-
 configs/starfive_visionfive2_defconfig        |   2 +-
 doc/board/starfive/deepcomputing_fml13v01.rst | 143 ++++++++++++++++++
 doc/board/starfive/index.rst                  |   1 +
 7 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst

-- 
2.47.1

