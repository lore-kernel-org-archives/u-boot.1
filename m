Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57016C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD6C82EC6;
	Wed, 25 Jun 2025 15:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p/Lt4siu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA4082F2B; Wed, 25 Jun 2025 15:21:49 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210BB82D88
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so58850885e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857686; x=1751462486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MkxAdTelwffmJHog0EHdOTiRAVaLWb9mLUglRkKKvv4=;
 b=p/Lt4siuoRci7IxdosXj61QEK+ohLDXdQXTLHWoUE5TchurQPVGiFepFjB7gKOcuxF
 5zmudXJklsg05UBgoIMNU+I6HkrartbGIQuSWjjG3pwlFoV2Ab101Foz6KUssquTHf54
 sO7ZITvJc7XzTt4y0ohPvXQdAoB9mBaQvDvYL5BJC+Ar+NXwE3SYNOsGxmzKRA7GyOfS
 AEvy0uP0wzSaNOwfg3l8Bn7XdRiyY0E6gH0FX/1GUNb+bMhq2gyNoYa6eL/oQ+gMAwr0
 gVrniIpc3CegtHIcdvSm2nCVmWoayjd9gQYc2UgkijoDUkboglWS+Zd1183xpIscxy51
 508w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857686; x=1751462486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MkxAdTelwffmJHog0EHdOTiRAVaLWb9mLUglRkKKvv4=;
 b=hZOhfKcJLfu4au64eW0Y8xRsFm2QjS7IddBrmW1eBWyn9+OEOZldM2Z7AtEFWN/E3e
 V0SBOyHvBo9/EqI63hHAqbCRQpU8RdFf6PvdNbkC029lzCeEvht59tC+oG0aDPTJ/Elx
 kZIFGaxJC4W0xW7F1MeijbemFb/ClbrvtL1l5tnjL99n/W8c2D52+gJ5eUZ+1kUGzvLH
 RlPgul54sKaY5XQJrDeTgT8ERARD+e1dN8XttW1MR5vxJPGuPlxEoXbi7c2VxnU9qs7N
 dh+KR+0T3bH8tq7wpMz2m8nW4/6Nm+UDk/boYjcwF7J7suc4p2wHfvQjHXezVYCyDDbt
 9SGw==
X-Gm-Message-State: AOJu0Yw+v/r/nZanNO5TTb8Wl1j+c63cfIMLJr+EEliu4ftrttZd+3VL
 A86b9z+PvV44v+YBXCfA3OeVQmbHyp0731aPrZ5iQRajZ3rzBCj0qRzG2ZJH8bmGWuwTIqPG+Hr
 f4/dtdxw=
X-Gm-Gg: ASbGncua2kxRNllVk3+QvT62Y7a41lVEdzs+g4derJG9V+nWSFN9aOS/JlwmdH+4G24
 N3/4cZru2hp2TQADrndUgDctYR7ABUO1cxUJnJz7RNclUKXsGiVEt0WvNiDNiRLvV1j6dEi+cWc
 fNhvmjKAgzMF3A0NbbZDt8tetyPQCmwROFAOfRVCp1kzOJg2NOjvH8sDEFvkIpcG/2gFbq6+1WG
 03Q2IrIsRLGTPFzR48+X8yYfvemxp4rxi+NeIfHTo7/8iZwJwGZsjTVA1uEo7cgf5wJMHbQH943
 Bso8nHC6VaE9pbDD1XU2oa7pQsG7G3TBF/y4/RcaWSEC88XHvYrXf1YIdJzBFylVJkZkAwM=
X-Google-Smtp-Source: AGHT+IEhjPIJExvWb4nFleaTY+WlBxDzpyooa4QMwlG5uWpDXQskXSf27feJKh5t9eGdqD/GOjb1jQ==
X-Received: by 2002:a05:600c:3582:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-45381a9caeemr29117945e9.3.1750857686152; 
 Wed, 25 Jun 2025 06:21:26 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:25 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Greg Malysa <malysagreg@gmail.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 00/13] sntp for NET_LWIP
Date: Wed, 25 Jun 2025 15:19:08 +0200
Message-ID: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

Changes in v4:
- Fix documentation
- Enter cmd/lwip even when CMD_CMD_NET is not set

Changes in v3:
- Remove doc/README.SNTP and create proper documentation for the command
  in doc/usage/cmd/sntp.rst
- Remove #if CONFIG_IS_ENABLED(WGET_CACERT) guard in include/net-lwip.h
- Move files from net/lwip to cmd/lwip before splitting cmd/net-lwip.c

Changes in v2:
- Move the network commands from net/lwip to cmd/lwip. Some commands
  such as dns and ping can be moved entirely, others such as dhcp, tftp
  and wget need to remain partly in net/lwip because the protocol may be
  used even when the command is not enabled.
- ping, sntp: accept host names in addtion to IP addresses
- Update doc/README.sntp

Jerome Forissier (13):
  lwip: remove net/lwip/eth_internal.h
  lwip: move net/lwip/dns.c to cmd/lwip
  lwip: move net/lwip/ping.c to cmd/lwip
  lwip: split cmd/net-lwip.c into one file per command
  lwip: split net/lwip/wget.c
  lwip: dns: do not return CMD_RET_FAILURE on successful resolution
  lwip: dns: do not print IP address when a variable is specified
  lwip: add net_lwip_dns_resolve()
  lwip: ping: accept host name when CONFIG_CMD_DNS=y
  net: extract function net_sntp_set_rtc() from sntp_handler()
  lwip: add sntp command
  doc: add doc/cmd/sntp.rst and remove doc/README.SNTP
  configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP

 MAINTAINERS                       |   1 +
 cmd/Kconfig                       |  13 +-
 cmd/Makefile                      |   3 +-
 cmd/lwip/Makefile                 |   6 +
 cmd/lwip/dhcp.c                   |   9 ++
 {net => cmd}/lwip/dns.c           |  12 +-
 {net => cmd}/lwip/ping.c          |   5 +-
 cmd/lwip/sntp.c                   | 133 ++++++++++++++++++
 cmd/lwip/tftp.c                   |   9 ++
 cmd/lwip/wget.c                   | 221 ++++++++++++++++++++++++++++++
 cmd/net-lwip.c                    |  50 -------
 configs/qemu_arm64_lwip_defconfig |   1 +
 doc/README.SNTP                   |  17 ---
 doc/usage/cmd/sntp.rst            |  72 ++++++++++
 doc/usage/index.rst               |   1 +
 include/net-common.h              |  13 ++
 include/net-lwip.h                |  15 ++
 lib/lwip/Makefile                 |   1 +
 lib/lwip/u-boot/arch/cc.h         |   4 +
 lib/lwip/u-boot/lwipopts.h        |   4 +
 net/lwip/Makefile                 |   2 -
 net/lwip/eth_internal.h           |  35 -----
 net/lwip/net-lwip.c               |  39 ++++++
 net/lwip/wget.c                   | 202 +--------------------------
 net/net-common.c                  |  23 ++++
 net/sntp.c                        |  23 +---
 26 files changed, 579 insertions(+), 335 deletions(-)
 create mode 100644 cmd/lwip/Makefile
 create mode 100644 cmd/lwip/dhcp.c
 rename {net => cmd}/lwip/dns.c (90%)
 rename {net => cmd}/lwip/ping.c (95%)
 create mode 100644 cmd/lwip/sntp.c
 create mode 100644 cmd/lwip/tftp.c
 create mode 100644 cmd/lwip/wget.c
 delete mode 100644 cmd/net-lwip.c
 delete mode 100644 doc/README.SNTP
 create mode 100644 doc/usage/cmd/sntp.rst
 delete mode 100644 net/lwip/eth_internal.h

-- 
2.43.0

base-commit: fdc0dcbb2c84c4c63fc10315bcf042575198610d
branch: lwip-sntp-v4
