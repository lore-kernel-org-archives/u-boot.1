Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71125C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9583687EDC;
	Sun, 21 Apr 2024 22:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lT3JlUYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99DB882EB; Sun, 21 Apr 2024 22:09:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67386876D3
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1713730161;
 bh=7i90EHuQhGJSN6ysB1vWnTsz1JDB4VvRmoMJToPS+e0=;
 b=lT3JlUYkB/Bg/00DLs+HQcJEruxuRSbbEpx4GZROzL8TNyTa7rM8+ObDsLqFxdl01VdKJjPpZ
 guuZ+yMTBHX/yuMe1zIBqL+wj/byZX0a8HmOiuMJC40ezK9yPXsAR+xrD4ga9jSsWwcsoeRK6eW
 P58zcPO/UFRI6BhXODIivRtnLR5Qo8PRMa3Pq0glWORNSKD0xVVgw4Qdmr2msLCro2ywqZbleLW
 yRdyc9R+SIR6GkoN+c7MqzhwpJmX0cyRqIjruqDk+39YRdeq5PUfolRoKgbFDt6v4f8GRNwNEmh
 0VG61bJdDpE72zBPYM0okD9gHPk3fCHe5Zgu7XJiJ8sg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] rockchip: rk3328: Add IO-domain driver and speed up
 boot
Date: Sun, 21 Apr 2024 20:09:00 +0000
Message-ID: <20240421200908.518855-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6625726f9034f686f09c15f4
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

Before this series init time is around 4.1 seconds on a Rock64 v2.0:

  => bootstage report
  Timer summary in microseconds (11 records):
         Mark    Elapsed  Stage
                  63,628  SPL
      284,173    220,545  end phase
      342,709     58,536  board_init_f
      967,537    624,828  board_init_r
    2,980,332  2,012,795  eth_common_init
    4,141,289  1,160,957  eth_initialize
    4,141,545        256  main_loop
    4,146,525      4,980  cli_loop

  Accumulated time:
                  71,396  dm_spl
                 329,994  dm_f
                  12,355  dm_r

After this series init time is around 1.3 seconds on same Rock64 v2.0:

  => bootstage report
  Timer summary in microseconds (12 records):
         Mark    Elapsed  Stage
                  63,628  SPL
      284,173    220,545  end phase
      303,282     19,109  board_init_f
      942,973    639,691  board_init_r
    1,194,831    251,858  eth_common_init
    1,363,405    168,574  eth_initialize
    1,363,609        204  main_loop
    1,363,738        129  cli_loop

  Accumulated time:
                 113,648  dm_spl
                 344,913  dm_f
                   6,788  of_live
                  17,895  dm_r

Changes in v2:
- Rebase on latest master bransh

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

