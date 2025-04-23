Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA264C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 08:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F5480F9C;
	Wed, 23 Apr 2025 10:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fXsutyWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFAB80FA8; Wed, 23 Apr 2025 10:58:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DED80EE5
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso58723095e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745398685; x=1746003485; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhLK6RRjeGJ0Y3JMB3VZh9HjJgoWOUJ4aTVRvBhg844=;
 b=fXsutyWwqJuFyrK51N3700NHvNUC4WdNg3bEVA2GmMS0tuBoktj94/TKp3dFoSkDx5
 l2PTGIdY0oVjapEa78d9D/BijnJmQ1goJmWY74PpT/xbd2g45vlTQAKsf9L9RhW7AUjf
 06tmddlq21L96eTheLLB1TqcEBk+k4lbgXlMQPpKVk7B2rDNnNXd1itXpGR2sYgR7sYM
 HYAJUTMo1PSu0Rrj2rOjaFJFXXMGzLbmnSbIGclZGy8gQSH9N3FqErRR/nD6Ewih5SAh
 T26Zb0y3RVJodlV+O7vmsjcmow0CrlhsxU2pgnkIYPwWwvFf73Yt6QtkRWZlwoDoSo+B
 qrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745398685; x=1746003485;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fhLK6RRjeGJ0Y3JMB3VZh9HjJgoWOUJ4aTVRvBhg844=;
 b=BOXPfS9NvujwwU9I6Cc5bVvko6DyngGyO7eYX1lokOnyaPiAVfDdjXkGFYCkshNVZB
 U0AtcM7vkx+tsaDV/iQVSWMPqmPSsIynzZYGAa0PSypbUbDZ48wlnfIlYLL36NtxJ5UF
 WvAZ/4ov202X/4Dyw0fN0qF3bC8KcZ+bI8BBL26JPZZv+Yn3AuVoSVEN3GXsNiZbwnpB
 YPstbaH2c0TntK8eyOMpYWr4verjglw+tBi+A0LUz1LMjxgINvynQfwcX/zF3rZtKcjE
 T5DvoqqRbHu50jm7pX15dKqxrtVKGJpRbDFzdSFDM9KnTNDKL/YWnR4IJiLrl6M3hoNV
 Oqxg==
X-Gm-Message-State: AOJu0YzkHk2FneTh0YWhycSlHanhhlv/qWCzoda3waaiTuOKYobmN3eN
 j77I4Y4ngeyHwXMEUFvqFAmddBLJk7J16xbJ+gt3VP33TjJi7gfGbJ10sSnxF9OCUbZP+IAUxvg
 q3Nj29g==
X-Gm-Gg: ASbGncu9AQtvbovUZRtyKzIdqPQFAWJWz6fHV4WRjljpuLUYMH3A1UeKgkvvYKgKLj7
 N5wrPmhDnkpVO7Nm8jPRPoTaQDsQxPnSadCN7lRTMabgvzM9K+TWUhT/M6UzPfZzALGN4Sph9IP
 lTcznpkCDwlLHpi+CFk6aAVnOsopBglv9xys61YSXxsD4lgUp3zX2SFFR6o0hhdZ5zEprVcS0w1
 6+XGEFXzXYvg8ymal9Iej0W6zrx4uqh9sBLjCWJMtPzSqMHT/QyZa+KYHA1U5slWYkDCWikVMwJ
 KQuZzvZdHN0bZllxUvTnxyjU597Aum7KIKqMDtXUJ2wRJ4tVFBn79IEIEeIZTSvT9iRm5QJNVad
 BXbVjePX/RTaoFPBfPQ==
X-Google-Smtp-Source: AGHT+IFAELQA9/baUue0Ogah8yWipS9t8IpNXj+aon0Kdfx3ALeKy7rOnIwLuUZ2rjXifErb302K2g==
X-Received: by 2002:a05:600c:4e4a:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-4406aba7c2fmr173080905e9.15.1745398685057; 
 Wed, 23 Apr 2025 01:58:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:13dc:9cf9:ad6:a89e?
 ([2a01:e0a:3cb:7bb0:13dc:9cf9:ad6:a89e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d16e60sm17976685e9.3.2025.04.23.01.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 01:58:04 -0700 (PDT)
Message-ID: <cf77132e-2a29-4d9d-98a8-a7c5c65fee5e@linaro.org>
Date: Wed, 23 Apr 2025 10:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20250423
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

The following changes since commit 4446bc331c65d3efb8a9321d6368c61edb56479b:

  mips: mt7688: gardena-smart-gateway: Increase CONFIG_SYS_BOOTM_LEN (2025-04-22 15:16:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250423

for you to fetch changes up to 49ae68536f234c423c78e89913c64ae9b87ed0e8:

  CI: add sandbox64_lwip (2025-04-23 10:02:49 +0200)

----------------------------------------------------------------
Pull request net-20250423

net:
- Make initr_net() invocation command line agnostic

net-legacy:
- net: dhcpv6: remove excluded middle expression
- net: dhcp6: Send DHCPv6 using multicast MAC

net-lwip:
- lwIP sandbox tests

misc:
- cmd: Remove CMD_NET protection

----------------------------------------------------------------
Bryan Brattlof (1):
      net: dhcpv6: remove excluded middle expression

Heinrich Schuchardt (1):
      net: make initr_net() invocation command line agnostic

Jerome Forissier (11):
      net: lwip: fix initialization sequence before a command
      net: lwip: provide net_start_again()
      net: lwip: add restart support to ping
      net: lwip: use timer_early_get_count() when CONFIG_SANDBOX_TIMER=y
      drivers: net: sandbox: add support for NET_LWIP
      sandbox: provide static IP addresses for eth{2, 3, 5, 6, 7}
      net: ping: make do_ping() available via <net.h>
      test: dm: eth, dsa: update tests for NET_LWIP
      net: lwip: allow DM_DSA=y when NET_LWIP=y
      configs: add sandbox64_lwip_defconfig
      CI: add sandbox64_lwip

Michal Simek (1):
      cmd: Remove CMD_NET protection

Sean Edmond (1):
      net: dhcp6: Send DHCPv6 using multicast MAC

 .azure-pipelines.yml             |   2 +
 .gitlab-ci.yml                   |  11 +++++
 board/sandbox/sandbox.env        |   5 +++
 cmd/net.c                        |   3 +-
 cmd/pxe.c                        |   3 --
 common/board_r.c                 |   4 +-
 configs/sandbox64_lwip_defconfig |   5 +++
 drivers/net/Kconfig              |  14 +------
 drivers/net/Makefile             |   1 -
 drivers/net/sandbox-lwip.c       |  85 -------------------------------------
 drivers/net/sandbox.c            | 240 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 include/net-common.h             |  15 +++++++
 include/net-legacy.h             |   3 --
 include/net-lwip.h               |  10 ++++-
 include/net6.h                   |  10 +++++
 net/Makefile                     |   2 +-
 net/dhcpv6.c                     |  15 ++++---
 net/dhcpv6.h                     |   8 +++-
 net/lwip/dhcp.c                  |   3 +-
 net/lwip/dns.c                   |   3 +-
 net/lwip/net-lwip.c              |  86 ++++++++++++++++++++++++++++++++-----
 net/lwip/ping.c                  |  11 +++--
 net/lwip/tftp.c                  |   5 ++-
 net/lwip/wget.c                  |   6 ++-
 test/dm/Makefile                 |   2 -
 test/dm/dsa.c                    |   8 ++--
 test/dm/eth.c                    |  77 +++++++++++++++++++---------------
 27 files changed, 376 insertions(+), 261 deletions(-)
 create mode 100644 configs/sandbox64_lwip_defconfig
 delete mode 100644 drivers/net/sandbox-lwip.c

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25903

Thanks,
-- 
Jerome
