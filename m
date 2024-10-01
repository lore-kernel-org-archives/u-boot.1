Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B99CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFD2891CB;
	Tue,  1 Oct 2024 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JkcVu9oF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9533F891AC; Tue,  1 Oct 2024 14:25:48 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957D6891A0
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so50576505e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785545; x=1728390345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7NyQOArAFzKziYhSypcdQLWi8ysIxzZah6Z3zuiDMw=;
 b=JkcVu9oF9oWdVJ74JT0PxaP9cR9whZPSn46iW3swEVfWuErnjBoTKntRJ3X9pnotws
 wMXsXp7VK6AZS+DXTo+5iorDPNXaiUxL+m+H33pDSzMmn5L5RlaafVAmMFRdJDyjk8tr
 Av6Qsd04C0hbdS9DzldzLM4uEuK5YpM7YVKKMqTuwmx9BxjKIdD8rNBPN55JCcD1pGox
 UPUYStWdAlBcJzVpf2T3GNmmRO83dw8EqXQbXsoaj9eHJswCXkGDRlMzcKaj21im2oFO
 aEDQhRUxEVg4PdruVFX3p1vtFyqnDw99zLONtzt5mgcMb7nZMilG+hlQ50C1FL8xJ9HD
 a/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785545; x=1728390345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7NyQOArAFzKziYhSypcdQLWi8ysIxzZah6Z3zuiDMw=;
 b=bdIxVaKJQNGg+NFFaCCUpDweIG85IiKmOi3Q3JeAtJBFKcUGQYR7OmcPlfBAziYXeQ
 9dUkB6mQ/8w2OmXuyMPJpehOBMg/I+N61l6Bm1cJLS1aZTTe/lkzvnrXATfufC6t06An
 GYBdifrmYKpni7DyHNZvwP9l++iQiY7KYvcYMDQNl/PAp7Lvz7ZFbUPA+/k+Z4UsX6B8
 FGmcqSG+7O6OY6q+FNoTmAN6Gqmmvl0Z2Rb/fTONL8CrWMc2UNrD7YTDzPYAbR478v3n
 DbrrQWnmDuu5OHfBmswZW0lTc8d3dFra+HcfD0rpC+z9e/A/RQd+Ux+GfAVpqqgPSynn
 y4nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlHLWhuyfciJAv1r9uGexFhzA8tgrwUfY/nzRh79w1JijWDbzo2KEFfGDycGtrW3yyk/TKnMg=@lists.denx.de
X-Gm-Message-State: AOJu0YzW7Ijmiis+RlHXaaFpPPHvX0IivSRvGHYG8nhosPKjrrXH9pqA
 9Qm/B3/3oGSqvaiCaIcyqzNhkFgYSGrCqh+nZLGSMGaZ0mLTBUSJ
X-Google-Smtp-Source: AGHT+IFuOAvRt+ztd6/5ocQiHYqx55ufbEgCxaCTwYvMtAt9wDrcGSEq6xxBVE7IBouxhF6mbEe2ig==
X-Received: by 2002:adf:a413:0:b0:37c:cc96:d1cd with SMTP id
 ffacd0b85a97d-37cd5aaf9f5mr10101886f8f.34.1727785544697; 
 Tue, 01 Oct 2024 05:25:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 00/11] led: introduce LED boot and activity function
Date: Tue,  1 Oct 2024 14:24:33 +0200
Message-ID: <20241001122511.8832-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

This series is a reworked version of the previous seried: 
misc: introduce STATUS LED activity function

This series port and expand the legacy concept of LED boot from
the legacy Status LED API to new LED API.

One thing that many device need is a way to communicate to the
user that the device is actually doing something.

This is especially useful for recovery steps where an
user (for example) insert an USB drive, keep a button pressed
and the device autorecover.

There is currently no way to signal the user externally that
the bootloader is processing/recoverying aside from setting
a LED on.

A solid LED on is not enough and won't actually signal any
kind of progress.
Solution is the good old blinking LED but uboot doesn't
suggest (and support) interrupts and almost all the LED
are usually GPIO LED that doesn't support HW blink.

Additional Kconfg are also introduced to set the LED boot and
activity. Those are referenced by label.

A documentation for old and these new LED API is created.

(world tested with the azure pipeline)

Changes v5:
- Use led_get_by_label and don't cache led dev
- Improve Kconfig for /options location
- Add Reviewed-by tags
- Enable blink also on MTD read
- Drop additional get_state in led_sw_on_state_change from v4
Changes v4:
- Drop led_set_state/period_by_label
- Switch to /options/u-boot
- Rework to cache label and dev in led uclass
- Add multiple patch for additional helper
- Rework patches to limit ifdef in some place
Changes v3:
- Switch to /config property
Changes v2:
- Drop GPIO SW implementation
- Add fix for new LED SW BLINK

Christian Marangi (11):
  led: toggle LED on initial SW blink
  dm: core: implement ofnode_options helpers
  led: implement LED boot API
  common: board_r: rework BOOT LED handling
  led: implement LED activity API
  tftp: implement support for LED activity
  mtd: implement support for LED activity
  ubi: implement support for LED activity
  doc: introduce led.rst documentation
  test: dm: Add tests for LED boot and activity
  test: dm: Expand ofnode options test with new helper

 arch/sandbox/dts/test.dts  |   5 ++
 cmd/mtd.c                  |   9 +++
 cmd/ubi.c                  |  13 ++-
 common/board_r.c           |  28 +++++--
 doc/api/index.rst          |   1 +
 doc/api/led.rst            |  10 +++
 drivers/core/ofnode.c      |  33 ++++++++
 drivers/led/Kconfig        |  24 ++++++
 drivers/led/led-uclass.c   | 162 +++++++++++++++++++++++++++++++++++++
 drivers/led/led_sw_blink.c |  17 +++-
 include/dm/ofnode.h        |  41 ++++++++++
 include/led.h              | 147 ++++++++++++++++++++++++++++++++-
 include/status_led.h       |  13 +++
 net/net.c                  |   4 +
 net/tftp.c                 |   5 ++
 test/dm/led.c              |  72 +++++++++++++++++
 test/dm/ofnode.c           |   9 +++
 17 files changed, 579 insertions(+), 14 deletions(-)
 create mode 100644 doc/api/led.rst

-- 
2.45.2

