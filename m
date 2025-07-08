Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B4C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 09:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F7383145;
	Tue,  8 Jul 2025 11:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SpYn3F1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3DB8318E; Tue,  8 Jul 2025 11:36:35 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC57830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 11:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso8049449a12.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751967392; x=1752572192; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pV9kUn/OmzvX3I7LtUHalcBnFd2jfgdmIRFDnE2Wvg=;
 b=SpYn3F1Uao14Ecz34r+yZ0mb+0evH0gf2FTlQn4GeH58VUDtZgGe7/Iyymz+g3I8ru
 x0obbIwM2bt0Iqvipp1A+gN0iliLooPUGXNqOxzJQ4+55Un8kDzV6XFg+l2I9UWV8A50
 EsFs7xc6nj8UUJY5R7+6mB/qwSJ4yGMLNSNl6Wd+ZqDbTyZFw/6iH4qqzMCMBiScmL+3
 lJ8QrmNjj1sNvM7/03UNgVJ00lWTmEYtcae29zC0v2aYhi3W1ulchiXhuBAnyNQgyHBx
 hV9LIEbEfJTgDjJbyf0n5RHpxwAm7/rTC6fYWtoGM+Y6y+PVF0IXsRpN8Edo4vMkVZdu
 1bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751967392; x=1752572192;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6pV9kUn/OmzvX3I7LtUHalcBnFd2jfgdmIRFDnE2Wvg=;
 b=wDwBLImVcGmzSaLtugKpgIN87V/z7U+Immg7SZyUXa66etBnHY+TeKm5WZK9aco4P8
 KvP/AOCXG3ZuBs4UFi9iayhPjT9gcD1aHwktprgyMo+xvfsxxbEcxulcM+uSljjzP5Tg
 zwItiXz91idZQMDYyq8t05nebTEAsfhaILdGe9v8aptoDySxnOBC1rbedmTCehV28b4R
 LvTVSh1oY2wU6tKlsixe2bXyX7ylQiktZLVVXAy94vxejcIm4RfV94hVSuPuT7NO5Ikq
 9DODEI9IQ/z/Q06ref1yyBQ1wgU53QOpA7gtfz99ffU9Dxnq3o4MdgBcfu4zh5RiUByZ
 QVTw==
X-Gm-Message-State: AOJu0YzuhwC6nibzML4YC7nHrll1I5ipFvVE18sbCytrH2BX+uItwlJL
 qTeAmiyaXM4y2qU6IvS6Pj6AnCMI4mCQoBPiepM5w7+dYdHay82gEfGzrqC/66cBb7qMZo/0Ol7
 wqg7QjDkq+g==
X-Gm-Gg: ASbGncuGADLRSX5Jya1qPo9bIJSucU/3OanBltCW1KtonuNlF+4SzzQLWm2ELRlq7UJ
 Q5dGXXxXsSoFlom7LUAjkdEr2vf0CdXJRZtWUs7Tx7yO/wBGlVyzs3sDjdb3VMgP1MX1KF/NKOw
 DH2APbIsfHrIfbHtYvZ7aEfestEyRaoj0tPM+LAir+HW3kZ/S+ue4MyWMGZfDobEs5zsUmYp5ZA
 yx9CDxVssCIcJPVGEdjzSIWVgeFTSZnjrjcr78WfnKuN7Ak583eRZmB+JVZICy++XT7/Zljq8ce
 tc+boqEA4soJLznZr5krkX54JFbkTJ3aylklOs+p70/w0I+EFF7pjjyXUROMkzfz7elhQ5hR4Q=
 =
X-Google-Smtp-Source: AGHT+IEAdXILVpD3XJcQJXJtXY0K4wWDapHTSYA3y6Gs5/ArZfkP6VmniSLlCWR6HmvK1CePwXPFzw==
X-Received: by 2002:a05:6402:2345:b0:607:94d:9bb0 with SMTP id
 4fb4d7f45d1cf-6104ae2fa6cmr1986183a12.22.1751967392241; 
 Tue, 08 Jul 2025 02:36:32 -0700 (PDT)
Received: from [10.100.0.2] ([194.15.111.161])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fd3895ac7sm6656457a12.30.2025.07.08.02.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:36:31 -0700 (PDT)
Message-ID: <da51a8dd-0171-4197-bac1-6571f134d6fa@linaro.org>
Date: Tue, 8 Jul 2025 11:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-next-20250708
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom,

The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:

  configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20250708

for you to fetch changes up to 203be3197de1016236f55652ce8ee4cbfe3035ad:

  configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP (2025-07-08 11:07:37 +0200)

----------------------------------------------------------------
Pull request net-next-20250708

lwip:
- Call sys_check_timeouts() and schedule() on RX to fix an issue on
  boards with a watchdog and simplify the code
- Enable IP_FRAG and IP_REASSEMBLY
- Add support for setting the TFTP blocksize at runtime
- Fix DNS initialization in wget
- Add the sntp command
- Move code from net/lwip/${cmd}.c to cmd/lwip/${cmd}.c

----------------------------------------------------------------
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

Tim Harvey (5):
      net: lwip: call sys_check_timeouts and schedule on rx
      net: lwip: enable IP_FRAG and IP_REASSEMBLY
      net: lwip: tftp: add support for setting blocksize at runtime
      net: lwip: move dns init to common function
      net: lwip: wget: initialize dns if a hostname is used in a URL

 MAINTAINERS                       |   1 +
 cmd/Kconfig                       |  13 +++++----
 cmd/Makefile                      |   3 +-
 cmd/lwip/Makefile                 |   6 ++++
 cmd/lwip/dhcp.c                   |   9 ++++++
 {net => cmd}/lwip/dns.c           |  33 +++++++--------------
 {net => cmd}/lwip/ping.c          |   6 ++--
 cmd/lwip/sntp.c                   | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/lwip/tftp.c                   |   9 ++++++
 cmd/lwip/wget.c                   | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/net-lwip.c                    |  50 --------------------------------
 configs/qemu_arm64_lwip_defconfig |   1 +
 doc/README.SNTP                   |  17 -----------
 doc/usage/cmd/sntp.rst            |  72 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst               |   1 +
 include/net-common.h              |  13 +++++++++
 include/net-lwip.h                |  16 +++++++++++
 lib/lwip/Makefile                 |   1 +
 lib/lwip/u-boot/arch/cc.h         |   4 +++
 lib/lwip/u-boot/lwipopts.h        |   8 ++++--
 net/lwip/Makefile                 |   2 --
 net/lwip/dhcp.c                   |   1 -
 net/lwip/eth_internal.h           |  35 -----------------------
 net/lwip/net-lwip.c               |  81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/lwip/tftp.c                   |   8 ++++--
 net/lwip/wget.c                   | 207 ++++-------------------------------------------------------------------------------------------------------------------------------
 net/net-common.c                  |  23 +++++++++++++++
 net/sntp.c                        |  23 ++-------------
 28 files changed, 637 insertions(+), 362 deletions(-)
 create mode 100644 cmd/lwip/Makefile
 create mode 100644 cmd/lwip/dhcp.c
 rename {net => cmd}/lwip/dns.c (80%)
 rename {net => cmd}/lwip/ping.c (95%)
 create mode 100644 cmd/lwip/sntp.c
 create mode 100644 cmd/lwip/tftp.c
 create mode 100644 cmd/lwip/wget.c
 delete mode 100644 cmd/net-lwip.c
 delete mode 100644 doc/README.SNTP
 create mode 100644 doc/usage/cmd/sntp.rst
 delete mode 100644 net/lwip/eth_internal.h

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/26989

Thanks,
-- 
Jerome
