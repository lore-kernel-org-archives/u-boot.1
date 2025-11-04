Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE876CCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 09:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2FA8144A;
	Tue,  4 Nov 2025 10:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iKbzi5IB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B8D82A9E; Tue,  4 Nov 2025 10:53:57 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFE5B8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 10:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-378e0f355b9so22223751fa.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 01:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762250034; x=1762854834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qSVH0/7dzz++bl54TU9yeIrXBswxAq2eErOfH+vVd6E=;
 b=iKbzi5IBS43bX5ZWWdg1CbhsAoN+oYT7BCPW2EjQQw7wX4HkCMpkJrZuKit3L3RmXs
 5TSXORUJsOf2X2U8DF8egAtd7+ZiEuiiLC+zZmZw64wAKsvsqPXyTQdGwVUPaaXgK/qs
 10u86ekxLilADZn/vuGEHWJLrKSXUnLxdYG5GFBDez1Ivn4bd7p0k+bSDCU0NfFfEg5S
 1o4oz2yDoYrp3IT7f5ezvxr9XdeEN0eqcYXRcoMIKJ24D1VfcN/3lJuioiRNVsCeccXO
 VKPo3vSAd3qXS7YB4ihW+BNWI6vqqA3rqvlaotR7ZUo1UprefJFv+f0ftkKFER8UBq60
 bjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762250034; x=1762854834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qSVH0/7dzz++bl54TU9yeIrXBswxAq2eErOfH+vVd6E=;
 b=BWo8kzkeKUhpneB60UOEW8gM9rAxwzjRMrD3z3yb+kaiQVMarnYW9L0mb5RNJydA+v
 aKiv4pg9CgwFmIFSIaOQr1p5v55oQpFDywfzq+95ojK6TLfkRRwFQLKA8CRCnIqsKX7Y
 G+xJ5cJs+pLKmxFFT1RTJBSNl3dVZ8Fpe5u9zzrkF0g5DB/GFAiRhbjLR7Xo0QukPox7
 frJgviHmjx7aZeVx9L+DBA8OrKLk7qJKICzWV0b/upKK7aOSV4uYIG5P5K+1t3n0H0Xi
 ldTD/G3SEWkQoOFUWhB58+RN9msxssUZgR1YmVGAsVtOCZnnH9Vm14TWmyaouCQPketm
 fxGQ==
X-Gm-Message-State: AOJu0YyCQz2hESU5nK/REtGwBr6AqPP6rH+07K8MbBHZEY2CT6vQcJI4
 BmWNwiWdsAol8k1SwnGWJ8hx7Xqtj77V+O+lrFlkQgJCSNT2nNBcXClFKBf+Og==
X-Gm-Gg: ASbGncv5JYkraCqxlopnRg+Sj4Qt/GOPKUKUnKKud8AjwvbSBvtSJ2OAzEJ68NOoqA6
 Q2/9qt/U2B0v3LtFv2oaxf7MrZVRDVlrSMDrEBfw4GQFT7zy32/2ki94rgbuCk2iVQjVO2tTEHk
 3eXiZ+TnsGYvIJL64qTP8sfyLPkfza0X8uv2vtQnXv9RjUzQf8O9rd5bIBeVtmE4CxSeIRW0mBD
 OO9oGCU1gsYtpmlDy8JMlhuZBfFYmlp7rL8ax/qwsemUcfwjSKbAplRa6jtX+JIr1CCa4gSggb6
 sEBbdLwHieEJ3PB129vUBXsobZcIoSN3TrHPYG1XmWde+glphyc8RjwHRbt2Q++mlYgOIH0mKho
 Rk53f16tIZuo9pvNqBtS9ePipa3WY85AStMLS+skFmhf9i+lj5jvvd/FjadLRGIMJtA==
X-Google-Smtp-Source: AGHT+IHDIRpQGuE5drhwMxyDlI6UmIWVuFwYyTu26jZ9E07/yvlgeLDcDuaIMdNOK4lPSLF7fLt0ag==
X-Received: by 2002:a2e:a984:0:b0:378:d5dc:17c2 with SMTP id
 38308e7fff4ca-37a18d90ad0mr47469801fa.11.1762250033777; 
 Tue, 04 Nov 2025 01:53:53 -0800 (PST)
Received: from xeon ([188.163.112.74]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37a414a0dcesm5749591fa.1.2025.11.04.01.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 01:53:53 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Tue,  4 Nov 2025 11:53:39 +0200
Message-ID: <20251104095339.7406-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Dear Tom,

he following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:

  Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 200549b09614e3cb17214e652aeb191902b8b303:

  gpio: tegra_gpio: convert to use set_flags (2025-10-28 11:27:44 +0200)

----------------------------------------------------------------
Andrew Goodbody (2):
      video: tegra: Remove unreachable code
      video: tegra: Incorrect operator used

Lukasz Majewski (3):
      watchdog: Add support for Tegra watchdog timer
      timer: tegra: Bind watchdog to timer node
      gpio: tegra_gpio: convert to use set_flags

Svyatoslav Ryhel (1):
      configs: tegra: remove ATAGS support

Tom Rini (1):
      crypto: tegra: Tighten TEGRA_AES driver dependency

 configs/chagall_defconfig          |   3 --
 configs/endeavoru_defconfig        |   3 --
 configs/grouper_defconfig          |   3 --
 configs/ideapad-yoga-11_defconfig  |   3 --
 configs/mocha_defconfig            |   3 --
 configs/mot_defconfig              |   3 --
 configs/n1_defconfig               |   3 --
 configs/ouya_defconfig             |   3 --
 configs/picasso_defconfig          |   3 --
 configs/qc750_defconfig            |   3 --
 configs/star_defconfig             |   3 --
 configs/surface-2_defconfig        |   3 --
 configs/surface-rt_defconfig       |   3 --
 configs/tegratab_defconfig         |   3 --
 configs/tf701t_defconfig           |   3 --
 configs/transformer_t20_defconfig  |   3 --
 configs/transformer_t30_defconfig  |   3 --
 configs/x3_t30_defconfig           |   3 --
 drivers/crypto/tegra/Kconfig       |   2 +-
 drivers/gpio/tegra_gpio.c          |  40 ++++++++++++++------------
 drivers/timer/tegra-timer.c        |  10 +++++++
 drivers/video/tegra/tegra124/dp.c  |   2 --
 drivers/video/tegra/tegra124/sor.c |   2 +-
 drivers/watchdog/Kconfig           |   6 ++++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/tegra_wdt.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 26 files changed, 159 insertions(+), 76 deletions(-)
 create mode 100644 drivers/watchdog/tegra_wdt.c

Branch contains minor adjustments and fixes along with Tegra watchdog
timer bringup, convertion of gpio driver to use set_flags and removal of
ATAGS from Tegra boards.

Thanks,
Svyatoslav Ryhel.
