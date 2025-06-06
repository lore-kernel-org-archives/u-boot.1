Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B0CC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E6F81FEE;
	Fri,  6 Jun 2025 08:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fGUhuswu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06FB8291D; Fri,  6 Jun 2025 08:42:26 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93897800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so13412995e9.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192144; x=1749796944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VIcWnsQVDnMa0n10NmxEFgV5ioRQo6nIOqc6y46hoBI=;
 b=fGUhuswuvKngCQVBU6G57rBSCRGWi2Qlb8774CCAcoa2lmy2drIpoweVuiFtZOg2yD
 GdxBysgzThsedGrxUZ6jp0pGG/eYU3lM1C8ONeOokk/5nBeVWlh5UDy/4jDekKF4RYIm
 ssD0yVupsSgeU9Vic3z7TGqPdHTVpaxQHLCTrGyn45KStItDqfLzTkS4Pu+F4wDuxX8q
 IeVU/CWXN6t4rrwRsfY7v0/1sepREYt7cEUZ3fOWukZJC98ExwnDHNn7sjK8x89mBgRe
 9wwpLOK7RH+/XEZIKsfBHyrAtBdhU3x1SprBQkYWvXe59LIP8EWvqgyQAPSe92shop/1
 VGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192144; x=1749796944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VIcWnsQVDnMa0n10NmxEFgV5ioRQo6nIOqc6y46hoBI=;
 b=hy7+kAqB6FpjKFyKYulR1QhIrdzd06uvRsG7C/UfwhdaZaXZV7jeI7UnRRnVk0SQJS
 tpF9mX02LKnwMoVFEXwIvqK9TVGS6NsmXJuYmnO0sg/TOIzdOmDBwrSevadyPgVa+GT6
 n9aUUbJKUT1kdw6UQdfmadcvubKmh1iiEkJ6JgR9pX5SXghuJ/aXU42McjEKCYCgBjaz
 q6MYhA0TnZLtr2kwwZtQBG0I4kuBnU396dL32+7DJcYOTBpwsi+siPfkIRbc/8etCXKa
 QggFi4zcSRHYtN5uG8FbcKEVUUhDRAcbruNVS9wfRAP6TbXw0dqB6+fY6lco0RpeC301
 NLDg==
X-Gm-Message-State: AOJu0Ywcsu62O7dq/itNcmxRX6Qy+gnEemC2mHPmi5k4mXPSTzLhTlOy
 8WFcIIs8AET5zfhrz5MG8On27lMXhthOURD34KTQq5r5z9f2ZeB7K0ZgWJyCgurplCgPxgJCU+F
 av3jG
X-Gm-Gg: ASbGnctqZ3S6oE3CE1/N64QMd+2Xa4w0mNGEQFu+8MN/2CCWEM2ATpemeQZMlOM4lLU
 Wg+4au/kKF6s8Tsae6EvSjDbHWk2zhP3TIvq3Elfb0JkDDhWrZst0+NUAaHrxAAevQNlgnoubvp
 KHvEpd/O4L2nFqvBztTBkvAhdIlS/Jy0MJDB8kwvgAc/ki3cJn3d190XoUScINw/AaY0rWb4Lf7
 5wn1Dq+XaOxtZ1xMYA+ZqLP08f06bvM3hkjcGA5zcUCUJzC2i77XUCBEug7MN/VyNgvbkUeEWBt
 PqUdLMEtOyWYHw8eaIac97kZWwOmUdn+3X5IhhuYsm6iGErg4WUeBToaW25UGPyMH1czt5U=
X-Google-Smtp-Source: AGHT+IEKNx1PzIfM6ZzncYAG4hOfARNobalUJdGegJOCUNzXcRrA0EaGOMIvgFGjSm3tMK1HDbt90Q==
X-Received: by 2002:a05:6000:188f:b0:3a4:fe9d:1b10 with SMTP id
 ffacd0b85a97d-3a531caff2dmr1579277f8f.45.1749192143620; 
 Thu, 05 Jun 2025 23:42:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2 00/13] sntp for NET_LWIP
Date: Fri,  6 Jun 2025 08:41:36 +0200
Message-ID: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Implement the sntp command with lwIP (CONFIG_NET_LWIP=y). SNTP is
supported as an app in lib/lwip/lwip/src/apps/sntp/sntp.c so this is
mainly about adding that file to the build and writing do_sntp() to use
the sntp_*() API and run the receive & timer loop. There is a patch to
extract a small bit of common code from net/sntp.c to avoid duplication.
The QEMU arm64 lwIP defconfig is updated to provide the sntp command by
default for convenience.
I could not test the case when the NTP server IP is provided by DHCP. If
someone has access right away to such a configuration and in case it
does not work, please let me know.

Changes in v2:
- Move the network commands from net/lwip to cmd/lwip. Some commands
  such as dns and ping can be moved entirely, others such as dhcp, tftp
  and wget need to remain partly in net/lwip because the protocol may be
  used even when the command is not enabled.
- ping, sntp: accept host names in addtion to IP addresses
- Update doc/README.sntp

Jerome Forissier (13):
  lwip: remove net/lwip/eth_internal.h
  lwip: split cmd/net-lwip.c into one file per command
  lwip: split net/lwip/wget.c
  lwip: move net/lwip/dns.c to cmd/lwip
  lwip: move net/lwip/ping.c to cmd/lwip
  lwip: dns: do not return CMD_RET_FAILURE on successful resolution
  lwip: dns: do not print IP address when a variable is specified
  lwip: add net_lwip_dns_resolve()
  lwip: ping: accept host name when CONFIG_CMD_DNS=y
  net: extract function net_sntp_set_rtc() from sntp_handler()
  lwip: add sntp command
  Update doc/README.SNTP
  configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP

 MAINTAINERS                       |   1 +
 cmd/Kconfig                       |  13 +-
 cmd/Makefile                      |   2 +-
 cmd/lwip/Makefile                 |   6 +
 cmd/lwip/dhcp.c                   |   9 ++
 {net => cmd}/lwip/dns.c           |  14 +-
 {net => cmd}/lwip/ping.c          |   9 +-
 cmd/lwip/sntp.c                   | 133 ++++++++++++++++++
 cmd/lwip/tftp.c                   |   9 ++
 cmd/lwip/wget.c                   | 218 ++++++++++++++++++++++++++++++
 cmd/net-lwip.c                    |  50 -------
 configs/qemu_arm64_lwip_defconfig |   1 +
 doc/README.SNTP                   |  23 +++-
 include/net-common.h              |  13 ++
 include/net-lwip.h                |  14 ++
 lib/lwip/Makefile                 |   1 +
 lib/lwip/u-boot/arch/cc.h         |   4 +
 lib/lwip/u-boot/lwipopts.h        |   4 +
 net/lwip/Makefile                 |   2 -
 net/lwip/eth_internal.h           |  35 -----
 net/lwip/net-lwip.c               |  39 ++++++
 net/lwip/wget.c                   | 206 +---------------------------
 net/net-common.c                  |  23 ++++
 net/sntp.c                        |  23 +---
 24 files changed, 522 insertions(+), 330 deletions(-)
 create mode 100644 cmd/lwip/Makefile
 create mode 100644 cmd/lwip/dhcp.c
 rename {net => cmd}/lwip/dns.c (88%)
 rename {net => cmd}/lwip/ping.c (94%)
 create mode 100644 cmd/lwip/sntp.c
 create mode 100644 cmd/lwip/tftp.c
 create mode 100644 cmd/lwip/wget.c
 delete mode 100644 cmd/net-lwip.c
 delete mode 100644 net/lwip/eth_internal.h

-- 
2.43.0

base-commit: fdc0dcbb2c84c4c63fc10315bcf042575198610d
branch: lwip-sntp-v2
