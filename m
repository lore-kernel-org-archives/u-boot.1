Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C10C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 20:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1B587EE3;
	Sun, 17 Mar 2024 21:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QD303ivE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4441787EDF; Sun, 17 Mar 2024 21:49:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2231A87E01
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 21:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2d81=KY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1710708571;
 bh=7vDF1b1P9yB2bqNiVfaFTctlsklj/nti0+AJcvnBP4M=;
 b=QD303ivE5lwrsthEXtZn+RCpWraVi6TyCQxhxTm0mwHb1WDICnetj6lsdL8JAu5R/aJEKDSpL
 lXf5cgWTgnCyrI9kY46oX2y+LsFz7M5Jh2EKZZ43yPA/XA+fVj+aS0JWFFj0htPeJfS9LmLJDdd
 aVUG5zAb55035ayzDT/4VCNIM0WZ0wew2wOo096xM5LBVB04o8UNDKnxFUkO/aO9NmYCNzTG5iS
 C8T06Ozeoc2ANZRYhBUyTek1LBE39wEZfE2bKLnletGC13fbAOkFmQJ76LRxWjK2q69ZH+hz5s5
 hd9zBkBRxc9NX4MaMLC7u67J3DUjRyTLtrNXwopamrWw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: rk3328: Add IO-domain driver and speed up boot
Date: Sun, 17 Mar 2024 20:49:14 +0000
Message-ID: <20240317204923.219908-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f7575931e1d1de60440941
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

This series adds support for RK3328 to the IO-domain driver, it also
enabled ARMv8 crypto extensions and OF_LIVE to speed up boot on rk3328
boards.

Before this series init time is around 4 seconds on a Rock64 v2.0:

  => bootstage report
  Timer summary in microseconds (9 records):
         Mark    Elapsed  Stage
            0          0  reset
      337,470    337,470  board_init_f
      956,864    619,394  board_init_r
    2,780,894  1,824,030  eth_common_init
    3,935,118  1,154,224  eth_initialize
    3,935,373        255  main_loop
    3,940,666      5,293  cli_loop

  Accumulated time:
                  12,313  dm_r
                 327,343  dm_f

After this series init time is around 1.1 seconds on same Rock64 v2.0:

  => bootstage report
  Timer summary in microseconds (10 records):
         Mark    Elapsed  Stage
            0          0  reset
      265,803    265,803  board_init_f
      904,140    638,337  board_init_r
      979,531     75,391  eth_common_init
    1,148,105    168,574  eth_initialize
    1,148,308        203  main_loop
    1,298,735    150,427  cli_loop

  Accumulated time:
                   6,793  of_live
                  17,891  dm_r
                 344,821  dm_f

Do not fully understand why OF_LIVE have such big impact on init time.
It does not have such big impact on e.g. a RK3308 board.

Jonas Karlman (3):
  rockchip: rk3328: Sort imply statements alphabetically
  rockchip: rk3328: Enable ARMv8 crypto extensions
  rockchip: io-domain: Add support for RK3328

 arch/arm/mach-rockchip/Kconfig                | 14 +++----
 arch/arm/mach-rockchip/rk3328/syscon_rk3328.c |  3 ++
 configs/evb-rk3328_defconfig                  |  1 +
 drivers/misc/Kconfig                          |  2 +-
 drivers/misc/rockchip-io-domain.c             | 38 +++++++++++++++++++
 5 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.43.2

