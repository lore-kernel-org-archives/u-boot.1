Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E89EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 18:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FCA8897F;
	Wed, 31 Jul 2024 20:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722451262;
	bh=j2OIfLKmzNLqCtN/nM/d1ZE3fQB/WZB3jdwzsYvGkTw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BNNCHEoReltJcXFd9jBqFikxQRcBn+A8/EqI+u+Ce4q8/Xely8jVOX2iJBh/21qR4
	 Pf/0f5Ju11lQ/yC527to0BBwSMk9dM//TuVwuLJ1P229iC9mzmBqgYToQrQmfUEhNZ
	 VDOWxehi9g+exQfaireJZCwFHdj/bqr2kTCjJps8GTfeAgzyxS4dcnmUzKWBY4k/PD
	 5VyC3M+odkBVq9rlbgtT/W57dIeBYbyG1lcLM5iR7iuNxheLKxNp4WSqeSKVYgI+HT
	 rHnGlAEBFGz4pmfjPK9NtLf9cb/upWl08L3dfvioPyLGHAr9itK/WP+lGxJgDBD9rI
	 zXjyKfYfjas2Q==
Received: from crub (p54833c06.dip0.t-ipconnect.de [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B316988934;
 Wed, 31 Jul 2024 20:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722451261;
 bh=j2OIfLKmzNLqCtN/nM/d1ZE3fQB/WZB3jdwzsYvGkTw=;
 h=Date:From:To:Cc:Subject:From;
 b=FfMbh9R6yE2ryncF/ROzG72d9LoN/2yVMh0z1KUXgvexYK+5LhJkO5JyuaKm7axSs
 MbDC24w1qSnEYR3BtUIB81iBu/xiSBkcL5ppbA2B2k6enE8UtUDL7kCSmEUbfD85z5
 pfWZe/7w3UAbscpgyMcW/3tjC8QNihrjs409oBtuNlfrHk3u0s82hGHRV5JxF7GwE8
 LOXQctYqY5N8npmQovQU9W7a3PmuPu1ZxyOe4uePtpdoMGOr5xtvdly5yc3SxlePcp
 L/+Jg2ZxGbZtvI2PGuAFCgTaq7wFs3Gb6Q6bN4V+ZeQj/1oi1X36qlw3jGcTTPrbQ3
 7f4z9BWtNHSLA==
Date: Wed, 31 Jul 2024 20:40:37 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] u-boot-video/video-20240731
Message-ID: <20240731204037.509e2017@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

please pull video driver updates.

CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/21823

Thanks,
Anatolij

The following changes since commit 8877bc51a8a4d921ba2f163208b8b1a57ba47c18:

  Merge patch series "led: implement software blinking" (2024-07-30 14:31:24 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20240731

for you to fetch changes up to 521d377f7852c037e338c66756982084b1cb0132:

  sandbox: Drop video-sync in serial driver (2024-07-31 16:56:06 +0200)

----------------------------------------------------------------
 - improve video sync performance with background syncing (cyclic)
 - fix dropping characters when pasting commands over the UART
 - enable background syncing by default for boards using VIDEO
 - make sandbox video more responsive

----------------------------------------------------------------
Simon Glass (5):
      cyclic: Add a symbol for SPL
      video: Move last_sync to private data
      video: Use cyclic to handle video sync
      sandbox: Increase cyclic CPU-time limit
      sandbox: Drop video-sync in serial driver

 common/Kconfig                    |  9 +++++++
 common/Makefile                   |  2 +-
 drivers/serial/sandbox.c          |  2 --
 drivers/video/Kconfig             | 35 ++++++++++++++++++++++++++
 drivers/video/video-uclass.c      | 52 ++++++++++++++++++++++++++++++++-------
 drivers/watchdog/Kconfig          |  2 ++
 include/asm-generic/global_data.h |  2 +-
 include/cyclic.h                  |  5 ++--
 include/video.h                   |  2 ++
 9 files changed, 96 insertions(+), 15 deletions(-)
