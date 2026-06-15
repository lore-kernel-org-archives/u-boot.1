Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4C5CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 17:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A979784869;
	Mon, 15 Jun 2026 19:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUNVMgIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7A884704; Mon, 15 Jun 2026 19:51:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090D584105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 19:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joaofl@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-491b390f9e9so29670625e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781545881; x=1782150681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdbhGPGzE5BQeOsyo/xq72h3yWzNNWm4sGuCa++L0J0=;
 b=gUNVMgItvGzGGLQuQsGfs8g468gyK4tskPIM4/KcEYIZEvh45BQY/qgH720pnVprxn
 QQlx9BTg8/Li419se1LFq978QlPkvkeER4CntfUWSGseEwY66IVffNzFuNGLykFxlYk5
 chSCX7pj7hNLchXQTnwTQRSwEWnLFaprs7Mmp7EmMrFa673ObVKCzOM8xliQl8y8+83i
 VMHEzWpJeTT8MxoLPMka+klfuNTs8lDKp2bTqjYwaKUY2w8BLcccsrpnyoVC3mGCFLhl
 li6BnZlIO6ZiaMVbA2EWJi+AfdRbAmgLHgaXvJzk//efuAj+UzVXNhHHJXGUs2kLQcip
 vP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545881; x=1782150681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SdbhGPGzE5BQeOsyo/xq72h3yWzNNWm4sGuCa++L0J0=;
 b=a0OSBRCX1JRvsU3MCpufvqKyai1F/AhGepWaq4khJ8iBHjZHmotcpv+DobQAJrsCLh
 97//4fSpK+th8ydykhH+BptUns7b2R0BIi+H+s9fWMaT7kxU0BY/2BR0dnbfDJmPEeKL
 fCjOE5fCqThBJVB6odu/GwXXVA59QNEfmaaqjdp4tJxTjLKMxfuHC3pLgr+ASr8gVO5N
 C+cnEMqltJUM9gEOfncGJT1czdh0+xiMaU1Y2qCBo6RPPKuJVAsWLvxoX/MfUiGDcl/D
 WPG6FKHkrdGHqBLgIkJtDDHTiFwUWNIRFrihyOOBf1xuP7hm3jGklNOIW4HkaI/2TYzL
 hTRw==
X-Gm-Message-State: AOJu0YwNDLwYDM2LaxLCi8OZOtn/JaYi0SUzvqpNZi8JWcvjjecWjLzd
 uRvy2/9Onp9WOjDQJyB85KpZpSJZNJNTAhGQDciFupE08LJCtglOMpTx2l5bbA==
X-Gm-Gg: Acq92OG0qBBW7fWDoULckZLNfn9RfmTpSiRPMcnMEYoKz8lwn1QUliFyjS6Od1y5xyh
 j1aDdO8CVzoiD/UhQUCXqnUeAC1rx1XxGVFrS2CNJ05XdF62sjCd6e2zrXC/xOqL8J09BxIyCma
 vrlo1DYYwZRkK7ccEDcteZLPQH2cvYuZN+FiqbBB4jojbGcDAD4Mx15v6tvDDDX1IN758mrjM8U
 1nlfUdb1GNzpfn/9Z2HFOLFHoYYJOw2eDuomv1MwpgdBt/ioQHb5NyjcXVPlDoM3Z50I6t1jGqA
 Y5EVzTnLI9XjpRzqBdTMLHjD7s18ylhLKPNhZyIiuGWXo5BlgDW1f4fItE1aedJqqfaD9wAcIel
 a5VGU1OMO2opHaRYujiev6xqtiCWAvJETMowIlxJzlvdbQNc10b4SkV4ddrh0OiSB8KgHOvzutT
 9YVak6jbLcY+oys5+jVym3NafRNXadYUzMeN29fa5ZpTQELas+ZSTOwW6i7h7DlR6JPP91Pww3W
 Ey9AaYb2CDd50c4hreP145sA8Gb2hav3w==
X-Received: by 2002:a05:600c:4f8f:b0:490:b99c:9337 with SMTP id
 5b1f17b1804b1-4922ff938d6mr4068995e9.10.1781545881263; 
 Mon, 15 Jun 2026 10:51:21 -0700 (PDT)
Received: from lap.lan (212-51-142-79.fiber7.init7.net. [212.51.142.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm36032769f8f.3.2026.06.15.10.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:51:20 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v4 0/2] spi: Introduce initial EEPROM driver mode support
Date: Mon, 15 Jun 2026 19:51:16 +0200
Message-ID: <20260615175118.53720-1-joaofl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610221200.167711-1-joaofl@gmail.com>
References: <20260610221200.167711-1-joaofl@gmail.com>
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

This series introduces an initial SPI EEPROM driver model uclass,
analogous to the existing I2C EEPROM support, currently providing
read-only access. Patch 2 adds a sandbox emulator and a test/dm test.

v4 addresses Simon Glass's review of v3: the emulator now frees its
backing store in a remove() method, and sandbox_spi_emul_get() gets
full kerneldoc. Patch 1 is unchanged.

João Loureiro (2):
  spi: Introduce initial EEPROM driver mode support
  sandbox: spi: Add SPI EEPROM emulator and DM test

 MAINTAINERS                    |   8 ++
 arch/sandbox/dts/test.dts      |  13 ++-
 configs/sandbox_defconfig      |   1 +
 drivers/misc/Kconfig           |   6 ++
 drivers/misc/Makefile          |   2 +
 drivers/misc/spi_eeprom.c      | 185 +++++++++++++++++++++++++++++++++
 drivers/misc/spi_eeprom_emul.c | 128 +++++++++++++++++++++++
 drivers/spi/sandbox_spi.c      |  37 ++++++-
 include/dm/uclass-id.h         |   1 +
 include/spi_eeprom.h           |  91 ++++++++++++++++
 test/dm/Makefile               |   1 +
 test/dm/spi_eeprom.c           |  45 ++++++++
 12 files changed, 516 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 include/spi_eeprom.h
 create mode 100644 test/dm/spi_eeprom.c

-- 
2.54.0

