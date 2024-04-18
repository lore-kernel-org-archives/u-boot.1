Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8733C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DAF8869C;
	Thu, 18 Apr 2024 21:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s/caDXfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85894885E5; Thu, 18 Apr 2024 21:00:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D0188697
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 179B8618B6;
 Thu, 18 Apr 2024 19:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D22C113CC;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713466829;
 bh=wszhNZ4MU9ddNHRZ14s0fd0fyOXux/wMrPcWH5LuASo=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=s/caDXfUw0cCsG/LfZ6wi0j0Gv/HVlxAz8uEGr2raLQd8BWZksFGhYP4bbqI0DQsU
 nIiq8RqAWWyuFFFtyLDVboqKIIQoowLf+uH9ruQ4YnmMa1OlPLxJvq1zPSXjFX9Rtm
 +dUkQpVjnTQuwzQnx5ZHZSNu1oBS2YJLkSRfqa8X2LKVo7yNLbcUv507XqHZo60zGZ
 LnX981bOLn9/mtVJYagSvGlojWfWJFYtnl96c9P5rJycO9ui7Hf5/4/FJobJy+hePy
 2aTXksjTr+zEyxjwnJqYU0vAqoq17WaJEDaN2QZKMPbF36UFh3nNr42Le9FLBttPmc
 k1tgpVewZ0apA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A4DCDC4345F;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v2 0/5] configs: apple: Switch to standard boot + small
 adjustments
Date: Thu, 18 Apr 2024 21:00:24 +0200
Message-Id: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhtIWYC/3XMQQ7CIBCF4as0sxYD2Ghx1XuYxgAd2jEGCNRG0
 3B3sXuX/0vet0HGRJjh2myQcKVMwdeQhwbsrP2EjMbaILls+UlcmI7xiXcbvKOJqU44OyouO6O
 gXmJCR++duw21Z8pLSJ9dX8Vv/QOtgnEmTHeWxoqWa9U/tPf6dfS4wFBK+QIaqNVNqQAAAA==
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, 
 Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=j@jannau.net;
 h=from:subject:message-id;
 bh=wszhNZ4MU9ddNHRZ14s0fd0fyOXux/wMrPcWH5LuASo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhjTF3NPdi/s+Tp3ip9P+1DI5a0PW+fa3czZtVSk49cziq
 4nwbuf4jlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABPR/8bIMCd0p0CaYGmD2zdJ
 HjH2N6eZrwvUZl2bNq+k7L2okbDxeYb/MReaj1b7zt54LvJ/XXcw/xem5T/ezb83fV5fu3qe5lc
 eXgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series contains a few misc config changes for Apple silicon
systems:
- switch from the deprecated distro boot scripts to standard boot
- allows EFI console resizing based on the video console size
- enables 16x32 bitmap fonts as Apple devices come with high DPI
  displays
- enables 64-bit LBA addressing

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- added Reviewed-by: tags
- switched to BOOTSTD_FULL to enable efi_bootmgr and make interactive
  use easier
- override BOOTCOMMAND to not list the bootflows
- rebased onto v2024.04
- Link to v1: https://lore.kernel.org/r/20240317-apple_config-v1-0-1b862bc140a9@jannau.net

---
Hector Martin (1):
      apple_m1_defconfig: Turn on CONFIG_SYS_64BIT_LBA

Janne Grunau (4):
      configs: apple: Use "vidconsole,serial" as stdout/stderr
      configs: apple: Enable CMD_SELECT_FONT and FONT_16X32
      arm: apple: Switch to standard boot
      arm: apple: Do not list bootflows on boot

 arch/arm/Kconfig           |  2 +-
 configs/apple_m1_defconfig |  4 ++++
 include/configs/apple.h    | 24 ++++--------------------
 3 files changed, 9 insertions(+), 21 deletions(-)
---
base-commit: 25049ad560826f7dc1c4740883b0016014a59789
change-id: 20240317-apple_config-981fcd9028b9

Best regards,
-- 
Janne Grunau <j@jannau.net>


