Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AFCC54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 14:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE35876BA;
	Sun, 17 Mar 2024 15:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z5lB6Hr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB1887E0D; Sun, 17 Mar 2024 15:54:53 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E04D86F67
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 15:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C5BFD60AC5;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BEB4C43390;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710687289;
 bh=GHsx6X1WIlFwSlzUjkLM+TSgi9zdmDPgNrNQSgJxM0Y=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Z5lB6Hr9WlTfGgINqZ0wN6m0toBiArXd6iU8T/OawtVZ9LZuni8qSe69A7rgJbyb1
 j3/d+UiY609Z2dwt0wPGJOtO5sCMFRicHm2Q+sUZX7xE6spICgdg3btBHNKup3rYed
 2XYxcZQv9c+SWP/bwU0HlV+iOMBL5YhAGfS+qvRwGNTclVtfUyCC/Qjwi3trxAydbc
 jmZ2ORICF3W1PFUs/5C2QZunkj0MBtktU/AqgIjn8+7LWtbkgMHAoVWwQomYmt33nL
 nms/oeOphfAgz0OpZNWMVBaeY/sNMW1hXjWqP8o/5ydmyHlBohhEuZUS2aC1HhMyDh
 EAwEyq9XuFWnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE46C54E67;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH 0/4] configs: apple: Switch to standard boot + small
 adjustments
Date: Sun, 17 Mar 2024 15:54:46 +0100
Message-Id: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADYE92UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Nz3cSCgpzU+OT8vLTMdF1LC8O05BRLAyOLJEsloJaCotS0zAqwcdG
 xtbUAFJllBl4AAAA=
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=j@jannau.net;
 h=from:subject:message-id; bh=GHsx6X1WIlFwSlzUjkLM+TSgi9zdmDPgNrNQSgJxM0Y=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtTvLOZX0ycU5D7YXNAWGLI8uXtyh8dxuW2bts758+hx6
 Z8N3yZ5dJSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZiIziFGhtUlu45+4EmNTfr3
 f6/qC6/iZXaSu5bW8C6d/ZZz3xrhJ+sZfjFf223xqXYSU4//vey4xnuPHffK9iyKXFlpwbf+jLf
 AJQ4A
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
- enables 64-bit LBA addressing for USB storage devices larger than 2TB

Signed-off-by: Janne Grunau <j@jannau.net>
---
Hector Martin (1):
      apple_m1_defconfig: Turn on CONFIG_SYS_64BIT_LBA

Janne Grunau (3):
      configs: apple: Use "vidconsole,serial" as stdout/stderr
      configs: apple: Enable CMD_SELECT_FONT and FONT_16X32
      arm: apple: Switch to standard boot

 arch/arm/Kconfig           |  2 +-
 configs/apple_m1_defconfig |  3 +++
 include/configs/apple.h    | 24 ++++--------------------
 3 files changed, 8 insertions(+), 21 deletions(-)
---
base-commit: f3c979dd0053c082d2df170446923e7ce5edbc2d
change-id: 20240317-apple_config-981fcd9028b9

Best regards,
-- 
Janne Grunau <j@jannau.net>

