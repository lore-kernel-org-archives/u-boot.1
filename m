Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664C1CDDE67
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5DBA8926F;
	Wed, 23 Oct 2024 12:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729680920;
	bh=rv7qeP+IKCEujHhdwA6yWMuiydsx61D/vb0WVCTkO9M=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b6EgZ1Xl4C/ZjJiZtapuc/VbbEPRKqoZtwVJyJiPe4EGMCT8GHbwTiwkOD/iJQZBY
	 ERnantCvK3chUVkQ2lB4V1tL3IYj9URV4/60KW7BRFidn4wXphymV1SF1zRtguh64W
	 Crbkm+zosuY2faX55O+8n/3bUtMQUndROeh0ZFZHRCk/3WM/eU0xXbdjwC/O5hOF83
	 QIWA/rEte+YW/4YJAzcE3WTuIGPeQhFfft8M6XkyxkSalov9OScjXavlRWjqNTOXZd
	 rJONCCrsMNODdTdui5hqyFbQWBjnnngkE7J0SS1xYZhOZPhJGr6qgUHOFkTsZ7X1RF
	 8KViN2GkRNZrw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7788A8926F; Wed, 23 Oct 2024 12:55:19 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D2B892D8
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYQtH464kz9snB;
 Wed, 23 Oct 2024 12:55:03 +0200 (CEST)
Message-ID: <87707c04-dc76-41f0-8fca-5782ca37091a@denx.de>
Date: Wed, 23 Oct 2024 12:55:02 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
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

please pull the following watchdog related patches:

----------------------------------------------------------------
- watchdog: gpio_wdt: add support for stoppable devices (Rasmus)
- watchdog: Add DaVinci's watchdog support (Bastien)
- cyclic: disentangling cyclic API from schedule() (Rasmus)
- watchdog: introduce separate SPL symbol for WDT_GPIO (Rasmus)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=378&view=results

Thanks,
Stefan

The following changes since commit 392ff1449f7d30cc48fd4d17320d05882cd68f2e:

   Merge tag 'video-20241022' of 
https://source.denx.de/u-boot/custodians/u-boot-video (2024-10-22 
14:11:20 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to ed3410ee6049a7683718e8255575ad55ee1bdefd:

   watchdog: introduce separate SPL symbol for WDT_GPIO (2024-10-23 
07:02:25 +0200)

----------------------------------------------------------------
Bastien Curutchet (1):
       drivers: watchdog: Add DaVinci's watchdog support

Rasmus Villemoes (15):
       watchdog: gpio_wdt: add support for stoppable devices
       doc: cyclic: remove reference to WATCHDOG_RESET
       cyclic: introduce u-boot/schedule.h
       led: include cyclic.h in led_sw_blink.c
       m68k: asm/ptrace.h: include linux/types.h
       fs/cramfs: use schedule instead of cyclic_run as callback
       test: dm: wdt: replace cyclic_run() by schedule()
       cyclic: make cyclic_run static
       watchdog.h: change include of cyclic.h to u-boot/schedule.h
       lib/sha*: include u-boot/schedule.h instead of cyclic.h
       i2c: rzg2l: include u-boot/schedule.h
       ddr: altera: include u-boot/schedule.h
       boot: cedit: include u-boot/schedule.h
       global_data.h: remove unnecesary include of cyclic.h
       watchdog: introduce separate SPL symbol for WDT_GPIO

  arch/m68k/include/asm/ptrace.h    |   2 +
  boot/cedit.c                      |   1 +
  common/cyclic.c                   |   3 +-
  doc/develop/cyclic.rst            |  10 +--
  drivers/ddr/altera/sdram_n5x.c    |   1 +
  drivers/ddr/altera/sdram_soc64.c  |   1 +
  drivers/i2c/rz_riic.c             |   1 +
  drivers/led/led_sw_blink.c        |   1 +
  drivers/watchdog/Kconfig          |  16 +++++
  drivers/watchdog/Makefile         |   3 +-
  drivers/watchdog/davinci_wdt.c    | 131 
++++++++++++++++++++++++++++++++++++++
  drivers/watchdog/gpio_wdt.c       |  27 +++++++-
  fs/cramfs/uncompress.c            |   4 +-
  include/asm-generic/global_data.h |   1 -
  include/cyclic.h                  |  24 +------
  include/u-boot/schedule.h         |  24 +++++++
  include/watchdog.h                |   2 +-
  lib/sha1.c                        |   2 +-
  lib/sha256.c                      |   2 +-
  lib/sha512.c                      |   2 +-
  test/dm/wdt.c                     |  14 ++--
  21 files changed, 225 insertions(+), 47 deletions(-)
  create mode 100644 drivers/watchdog/davinci_wdt.c
  create mode 100644 include/u-boot/schedule.h
