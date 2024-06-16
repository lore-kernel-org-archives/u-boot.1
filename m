Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726DAC27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D018812C;
	Sun, 16 Jun 2024 12:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r8vaviV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716B18812C; Sun, 16 Jun 2024 12:18:57 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351828813F
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W28B46bPFz9sR1;
 Sun, 16 Jun 2024 12:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718533132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iatwvTtMhxkxCg6eb9A2pAfYLOXu2bljI9DlEAlL0m4=;
 b=r8vaviV/Hz+iCYMusg6WajUGIbO79l6RuUNlNvrojZL4lwTVlRUu3Km24teyOKcpB3By5N
 HuSQy04MxlcL1C2HyqgHTKOXFE8bMP2YbSIhztxu6DwWuk3WkgFjtw557jqL7WY18jmzFd
 HOV3KazmDf7ZtpblqMjYwIacHI+/LQJdvTdO4Cm8qCeLe8V7HnvjbBMQk6YmLHnciYnpWD
 q9GeJlWeWNNYKzOL1CcJh/D28PMeXRTBfY4VCkEQbwDPdxsGoklnuId0oUgymUCkW58VVn
 QihmCtVXM7FOTEbDwbWLnIHfhTstWuLOq0d+qVXw2lrBe568joJJjW36U1EsKw==
Message-ID: <683ca5ff-1f70-4ca4-99c4-33abb16b60f1@mailbox.org>
Date: Sun, 16 Jun 2024 12:18:52 +0200
MIME-Version: 1.0
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: Please pull u-boot-watchdog/next
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: mpmnwoc9adsc1spg15at11o9zbfp3x38
X-MBO-RS-ID: 2d144e144ebec3bb0e3
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

please pull the following watchdog & cyclic related patches:

----------------------------------------------------------------
- misc cyclic infrastructure improvements (Rasmus)
- watchdog_reset cleanup (Rasmus)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=369&view=results

Thanks,
Stefan


The following changes since commit 0786dd573d0793417852e009dee3148ebdd163f3:

   test/py: net_boot: Add test cases for net boot (2024-06-13 16:31:24 
-0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git next

for you to fetch changes up to 85c476759a42dfedb2d66e9734f8c05b7cfb62d5:

   powerpc: mpc85xx: remove dead watchdog-related code (2024-06-16 
12:14:18 +0200)

----------------------------------------------------------------
Rasmus Villemoes (10):
       cyclic: stop strdup'ing name in cyclic_register()
       wdt-uclass: prevent multiple cyclic_register calls
       cyclic: make clients embed a struct cyclic_info in their own data 
structure
       m68k: remove dead code
       wdt-uclass: watchdog_reset cleanup
       serial: ns16550: fix comment to mention schedule instead of 
watchdog_reset
       sh4: move reset_cpu() from watchdog.c to cpu.c
       sh4: remove watchdog.c file
       powerpc: mpc83xx: remove unused watchdog_reset() function
       powerpc: mpc85xx: remove dead watchdog-related code

  arch/m68k/cpu/mcf52x2/cpu.c        | 108 
-------------------------------------
  arch/powerpc/cpu/mpc83xx/cpu.c     |  15 ------
  arch/powerpc/cpu/mpc85xx/cpu.c     |  31 -----------
  arch/sh/cpu/sh4/Makefile           |   2 +-
  arch/sh/cpu/sh4/cpu.c              |  10 ++++
  arch/sh/cpu/sh4/watchdog.c         |  60 ---------------------
  board/Marvell/octeon_nic23/board.c |  11 ++--
  cmd/cyclic.c                       |  12 ++---
  common/cyclic.c                    |  24 +++------
  doc/develop/cyclic.rst             |  26 +++++----
  drivers/serial/ns16550.c           |   8 +--
  drivers/watchdog/wdt-uclass.c      |  57 ++++++++------------
  include/cyclic.h                   |  37 ++++++-------
  include/watchdog.h                 |   3 --
  test/common/cyclic.c               |  19 ++++---
  15 files changed, 102 insertions(+), 321 deletions(-)
  delete mode 100644 arch/sh/cpu/sh4/watchdog.c
