Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883BBCA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 15:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E23801BE;
	Mon, 18 Aug 2025 17:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DZfdtzxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7FF801DD; Mon, 18 Aug 2025 17:02:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4BD80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 17:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45a1b0b2d21so20071705e9.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755529336; x=1756134136; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXW5QAIhhjtW80CL+kKnOt9jJZbWYbF2tPP8F0tvXcA=;
 b=DZfdtzxk7kFQIbos9uaO6bCWAaV9hAzCg7Sn+ZKG4LRDJcpGZk61y5Ahz4V4/yoDih
 n1wcGRYLYjJco/ieS9Hs93KgptsSGGNS6OYHd9u9DwVbJb2v2xT6dPvvFwq1U3gm1U5B
 CoKGaclCBrBQwmCMbwws6yrEiWV/DC3ihja58Rcd9+FgpSGlb7+dr92Q4qAl6gTwTqtD
 YvrgvbD+QasBnNd69O7Yo5datimr2MqUE0ZoFWTA0+fBwxFIbpxuUa+rBG88/kQdfSq/
 vgXDjH1a5CqFxNhECWxX3swMe/2aRNXrBWYP7Tg+w70DUQQ1get8NmmjkaAcM03sKj7V
 ZLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755529336; x=1756134136;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bXW5QAIhhjtW80CL+kKnOt9jJZbWYbF2tPP8F0tvXcA=;
 b=j21oppNdDpZSfKCHPWHasXvCunOG40R3zZ8DQQ36mAJP7H0AzR04qP4y06CI999oPw
 me+vGEYwAUQNllPEF032dHz3xs85nH5YMymyuDsP17xPeX+yau93Fi98OFMdnVWdMQnJ
 bX48Ai3VQ7OfPcZqgEiP8cUDRp7lty/zRaFzRaSUoZkNoLJbHOlGrKm28LbnHMsIjMxb
 66lBSMie/FQQliGYEIBAbve0OckU4aPP5tIgEgPJIQBUBvmG5errQ5oGdue0MAyEoJGd
 BHj1UtfvGP7YE1JvVscmMU3q/OrVhYxjUWqojxiCfesbQpe3vS5qzDeqwL6yXpNwgYga
 mCPA==
X-Gm-Message-State: AOJu0YyANh0zdB73cdyippsSZ7cU7ivTxNigsTriz/3AG3Ak0ESS2xbJ
 sfrKzjw2TNsfgacJ/WJGVpaEQAi4UWFi9C5ce5CXHoFTuaITs3jgA0HSo36f1E1ZhMZzhQHiPAY
 2uvutmCCC0Q==
X-Gm-Gg: ASbGncuBPAmqePfjxQo8Hm5sEP9FHLgR8yts7GYlZYmWyDXAzpG/ZMkOkTtx3WeJuXv
 m6HWu58Eg+R2iPVVRBrbtjjG1BzfpiaOttTf5/VEKs2a+Vz8el4Sn8u+b8dB/J7/XT/mFFovKJA
 x7a+xQ87OMkboFqyENEM43WHzGf+Tl2hqvmN/ZbXPah6bdIYrZVU6A4x2+r+peyKBjm77BTpPxN
 z+/m67K4RvD5f+pH/C/ERsgHjPfgbv3KZaVyyzPyYxV0b3MBYsxKpV2T2M+Q42ghtAFal5I6169
 /Yedd1oW0kFOqfCjbqimxj/2qjSY9J+7HehdO/Wlnj6/trS/m830Pkh9TexS48o6AFOTaMCED65
 UyjqOCyuJddnVqT6gWYidv9nwpaTYOCa8k6j3F6lxNgDpuzYGw2GNiQUmdSeZ0dJRfN20kwqOp0
 kr1A==
X-Google-Smtp-Source: AGHT+IEYWa0Hfc8ewvKFPW2vmPgQGd51JaM6fPzJScz16/XQoQiFlOSB/GZjCn0YuYnh2uAID9Noxw==
X-Received: by 2002:a05:600c:b8d:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-45a21848eb0mr73405735e9.23.1755529336142; 
 Mon, 18 Aug 2025 08:02:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1e2e:5ce2:b8aa:4ac1?
 ([2a01:e0a:3cb:7bb0:1e2e:5ce2:b8aa:4ac1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42a6d59dsm3343555e9.2.2025.08.18.08.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 08:02:15 -0700 (PDT)
Message-ID: <e31cd4e9-78f5-4876-ae28-af5eda292cb6@linaro.org>
Date: Mon, 18 Aug 2025 17:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20250818
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

The following changes since commit 0c558bbad9e7581808b358091d1fd979f860e8ac:

  bootstd: rauc: Change global method to check any partition (2025-08-14 09:18:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250818

for you to fetch changes up to c4526c390a3c4ea1c4f244b6436ebbb74902769a:

  phy: cadence: torrent: Set an error code for return (2025-08-18 15:47:58 +0200)

----------------------------------------------------------------
Pull request net-20250818.

This is mostly code cleanup and fixes, mainly for issues reported by the
Smatch tool, plus two small features for NET_LWIP as well as support for
the BCM54612E phy.

net-common:
- Fix a bunch of issues reported by Smatch
- Introduce CONFIG_DNS
- Add support for BCM54612E phy

net-legacy:
- Add missing SPDX-License-Identifier for files originating from LiMon

net-lwip:
- ping: initialize net_try_count to 1
- sntp: remove redundant sys_check_timeouts()
- tftp: resend initial request
- Add Kconfig option to show ICMP unreachable errors

----------------------------------------------------------------
Andrew Goodbody (19):
      net: octeontx: Remove unneeded code
      net: octeontx: Remove unneeded test
      net: octeontx: Free allocated memory on error
      net: phy: vitesse: Fix incorrect test for timeout
      phy: marvell: Fix off by 1 limit checks
      phy: marvell: Cannot test unsigned field to be negative
      net: ldpaa_eth: Fix buffer overflow in memset
      net: mediatek: Use correct variable for return
      net: mv88e6xxx: Fix logical operator instead of bitwise
      net: mvpp2: Fix impossible test
      net: mvpp2: Return -ENOMEM for failed alloc
      net: mvpp2: Cannot test unsigned variable to be negative
      net: mvpp2: Use field just assigned in error test
      net: octeontx2: Restore default value for err
      net: octeontx2: NULL check before dereference
      net: cortina_ni: Fix typo accessing wrong phy
      net: ks8851_mll: Remove unreachable code
      phy: cadence: sierra: Remove variable that is not assigned to
      phy: cadence: torrent: Set an error code for return

Jerome Forissier (6):
      lwip: icmp: allow reporting ICMP destination unreachable
      net: lwip: add Kconfig option to show ICMP unreachable errors
      net: introduce CONFIG_DNS
      lwip: tftp: resend initial request
      lwip: sntp: remove redundant sys_check_timeouts()
      net: lwip: ping: set net_try_count to 1

Jim Liu (2):
      net: designware: Fix get_timer value overflow
      net: phy: broadcom: add support for BCM54612E

Max Merchel (1):
      net: add missing SPDX-License-Identifier for files originating from LiMon

 cmd/Kconfig                               |   2 +-
 cmd/lwip/dns.c                            | 108 -------------------------------------------------------------------------------------------------
 cmd/lwip/ping.c                           |   1 +
 cmd/lwip/sntp.c                           |   1 -
 doc/usage/cmd/sntp.rst                    |   8 ++++----
 doc/usage/cmd/wget.rst                    |   2 +-
 drivers/net/cortina_ni.c                  |   2 +-
 drivers/net/designware.c                  |   4 ++--
 drivers/net/ks8851_mll.c                  |   5 -----
 drivers/net/ldpaa_eth/ldpaa_eth.c         |   2 +-
 drivers/net/mtk_eth/mtk_eth.c             |   2 +-
 drivers/net/mv88e6xxx.c                   |   2 +-
 drivers/net/mvpp2.c                       |   9 ++++-----
 drivers/net/octeontx/nicvf_main.c         |  49 +++++++++++++++++++++-----------------------
 drivers/net/octeontx/smi.c                |  12 +++++++++--
 drivers/net/octeontx2/nix.c               |   2 ++
 drivers/net/octeontx2/rvu_af.c            |   2 +-
 drivers/net/phy/broadcom.c                |  37 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/vitesse.c                 |   2 +-
 drivers/phy/cadence/phy-cadence-sierra.c  |  13 +++---------
 drivers/phy/cadence/phy-cadence-torrent.c |   1 +
 drivers/phy/marvell/comphy_core.c         |   4 ++--
 drivers/phy/marvell/comphy_core.h         |   4 ++--
 include/net-legacy.h                      |   5 ++---
 include/net-lwip.h                        |   2 ++
 include/net/tftp.h                        |   2 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c        |  74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 lib/lwip/lwip/src/core/ipv4/icmp.c        |  17 ++++++++++++----
 lib/lwip/u-boot/arch/cc.h                 |   7 +++++++
 lib/lwip/u-boot/lwipopts.h                |   4 ++++
 net/Kconfig                               |   8 +++++++-
 net/Makefile                              |   2 +-
 net/arp.c                                 |   3 +--
 net/arp.h                                 |   3 +--
 net/bootp.c                               |   2 +-
 net/bootp.h                               |   2 +-
 net/cdp.c                                 |   3 +--
 net/cdp.h                                 |   3 +--
 net/lwip/Kconfig                          |  13 ++++++++++++
 net/lwip/Makefile                         |   2 ++
 net/lwip/dns.c                            | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/lwip/icmp_unreach.c                   |  38 ++++++++++++++++++++++++++++++++++
 net/lwip/net-lwip.c                       |   8 ++++----
 net/net.c                                 |  13 ++++++------
 net/net_rand.h                            |   2 +-
 net/ping.c                                |   3 +--
 net/ping.h                                |   3 +--
 net/wget.c                                |   2 +-
 48 files changed, 394 insertions(+), 214 deletions(-)
 create mode 100644 net/lwip/dns.c
 create mode 100644 net/lwip/icmp_unreach.c

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/27402

Thanks,
-- 
Jerome
