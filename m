Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A04C5DF7A
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20368607F6;
	Mon, 17 Aug 2026 13:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oQap5bDKxuqv; Mon, 17 Aug 2026 13:34:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C19FB607EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973654;
	bh=CS39o5Q4ieQPqWn7qoHPFvTc4oOXYIl+02TWt/wxcvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jMPgblFun5qPnmy88KcKzAbULlT3RCkIZ8R9kxMT8T2VzkCWfN50czYxJE9uGk3iK
	 nTLXz/rPSU0lJ5miv5PBTNiyTQowqOA+Q8x05RCJaVVscE05gUKRm8t8lTLjRNwXp3
	 2e0IQuVIovBi1E2U8ca9GRHOoYAoGS0Zzg08YPYThnJeQsaZXUlRY3suewgmcS8gKy
	 Rbi55TLvw06j4eFeUUbiGLNZBPpe7+PHEyVndt0dMOEzPjWmlf1XZRinPKy3jdQJmh
	 8GMVMtTwH8LuHWUeVC7AVyCrP321cj+eP4PVYt7liUuiSRSJ2XS3u/qz2FWYHiJ6g4
	 tHJJpZp7Xhrrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C19FB607EA;
	Mon, 17 Aug 2026 13:34:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E4873333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAEE040169
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ciro6dNS2MEl for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AA40D40087
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA40D40087
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RcnsKKcw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA40D40087
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C5AD1600AE;
 Mon, 17 Aug 2026 08:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495881F000E9;
 Mon, 17 Aug 2026 08:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956265;
 bh=CS39o5Q4ieQPqWn7qoHPFvTc4oOXYIl+02TWt/wxcvE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RcnsKKcw/BM77z2ZkmdryIhMNFbQZCxfCQOgDZEAP7t4LpBOzgMiYfhYoaFAtv62K
 5Yie8J6o3AUof4I6yfLBJZazuBSIySR30X7uq8DljAI98z/D96pQPP7j8rN3RxX1qT
 vzUYK+gGzkuOvuuFgkjxg4OOwLbL7a5mS6lB0gyDKH6eO2+cGnzELsyCNb/LTdUwZN
 wJ1NoklXdhR9QxClu2SD5ocgD6n/zCMCp/5yLiAexQZrF51fe0JtmtTa6Hh15gGjrP
 zRjtlL04V+BZSJS2vuHyF2QUH/mFyBZ1gte8ENK+q/FpOaCedExvgrm61UcS3NGmA9
 0jfnyu5EwhhPQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:10 +0200
Subject: [PATCH 6/8] configs: stemmy: Boot EFI from external SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-6-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Replace the fastboot-only command with standard bootflow scanning and
enable the EFI loader so the removable SD card can provide the default
ARM EFI executable. Filesystem probing is handled by the standard boot
framework and does not require the FAT command.

Disable mkeficapsule because generating capsule tools is unrelated to
running EFI payloads and adds a host GnuTLS build dependency.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 configs/stemmy_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 631ccababf1c..57e794c5c88b 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -14,10 +14,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="ste-ux500-samsung-stemmy"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
-# CONFIG_EFI_LOADER is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fastbootcmd"
+CONFIG_BOOTCOMMAND="bootflow scan -lb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -43,3 +43,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x685d
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MCDE_SIMPLE=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.55.0

