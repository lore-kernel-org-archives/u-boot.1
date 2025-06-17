Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AFEC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 13:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C15482E40;
	Tue, 17 Jun 2025 15:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JjPScm6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7AC82CB6; Tue, 17 Jun 2025 12:07:45 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7B380C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a510432236so3992406f8f.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154862; x=1750759662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sfrwT5MaZ1tnqfjhAOiXaWvwOv32c+4XxCpL48FlolI=;
 b=JjPScm6eBj1ceYYAReHPxXg8yzF7PbfHtN2GRfRyW5uiz3K8uIzvy3ltI9zTe1L7HI
 l9XSgVZfInvjo8DV/7S9LztByrvdV6A2i3wqC8KhuoKKZx27kVHR3kYku89Wx38YCHlt
 b1cMw0obkT86OaRu4StsOd1W0hT7mWaHqNffSMmQrswWPKoT5jmss/jJU5wSfBk/Lmg9
 Wiwnv0/Y39b7fftF6al+v03QINvuzYKFnwispMcQSqGHjnuxaQgozydr6xqnjxUgpecp
 8hC6KEHcabWQg3pI4X1tSY3pZInPz7+2R0IzPHpjo6nTonk1sp0VH9c3Y9mFVk+rJCRH
 GM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154862; x=1750759662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sfrwT5MaZ1tnqfjhAOiXaWvwOv32c+4XxCpL48FlolI=;
 b=BRGkQTSctmDwDrESLPitEr5Mn52mzqdD3cjF3PsuvFr80odBY6imBQEcwjG3k56keE
 1cjgYN+S/R289HPsFikuVZi2NHYbB4VZ03If1R2qQxoH1GcsXbyL6xhoNAJYluDLb35j
 Uskpow0wLiYz6KstE21irMifa0FBlTMu9GKEUhDna2WvdwuG0bsSUzVxr/XNQmr+esti
 bKElRQH5plKJIKuzgxZ96C0PaKXx4fP60S8OUeKpdY2iMG/2Zx6ZAQv2ByNeFRi/UIK+
 vvdIkQchSgfjPOU6783IfPPazLNz55auI5pSQJ12/438gmOUPo9qPNECCjXZICe63rIc
 JSjw==
X-Gm-Message-State: AOJu0YzNM0nmsaMGpBe44IlY5C7yeFWH+Vxs1bjGMyz82v0xaFRSpvYx
 tlMBhRztQccvr1wbbuqBZrg955QGoIVV7tQIiWitxoEMZmiR7EPt4ol2sFE0Vp3XQWGr8gixeYK
 oSv4H
X-Gm-Gg: ASbGncs/31jRNF51x3DJT2gsSwFG/gHWubLasQpNQxyi3MHZW1c/VjcLC04hi8Zq+JS
 cizv8RO8wv6nZtGqcPzPQzk+mxh2Og+MYrt1Tc8gjDfU2wvdYP/0nAG2PYhxCn7/oPQfbpEfu5x
 L1BDN0cdygbwJK3F3PTvXZByXofyDLcJSBFVUFchVDqB9175E48V4j6bhOHNYqkbwFb2lkozUdq
 C7o+Qp9br1hE4h1s1Tsz1rPOgBahUh0n36BCkAg2+KdQaP056xyp8Jh0ytneDegKrGJ2B25XZNJ
 VCyK07mYL3FMNvtzOy9ho42sqOI+lhH0aLtSS/0l0pgKDxe2rfrfyH8T18/SFZQOWGQGS7bk/oQ
 XP8x4mg==
X-Google-Smtp-Source: AGHT+IGIu58WYYpklZ48jOwI/onH9J7xQ786v7eQ3tEn5wmeQAVa447XTubTIwCz7mzHeZOvLGWwKA==
X-Received: by 2002:a05:6000:1a85:b0:3a4:f70d:a65e with SMTP id
 ffacd0b85a97d-3a572e6b9f4mr10683883f8f.37.1750154862272; 
 Tue, 17 Jun 2025 03:07:42 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Greg Malysa <malysagreg@gmail.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
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
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wang Jie <dave.wang@rock-chips.com>
Subject: [PATCH v3 00/13] sntp for NET_LWIP
Date: Tue, 17 Jun 2025 12:03:50 +0200
Message-ID: <20250617100720.2544758-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Jun 2025 15:01:33 +0200
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
 cmd/Makefile                      |   2 +-
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
 26 files changed, 578 insertions(+), 335 deletions(-)
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
branch: lwip-sntp-v3
