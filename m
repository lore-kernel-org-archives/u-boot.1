Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6FDC3814E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 15:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0BE88644;
	Sat,  6 Jul 2024 17:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G924ITfa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gEW1UyrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C53098864F; Sat,  6 Jul 2024 17:46:32 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8679C88630
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 17:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WGZVt1FRqz9sc0;
 Sat,  6 Jul 2024 17:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720280790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QFf0mVWLmG8O/Gc8O+I9JlNjuDBDuelZL3JcH6tUkw=;
 b=G924ITfa5zILRiSbLcZqaygS9r/Tgc2gRsHle9qx206oSsF7T9syr4I1mRqj3Pdx7je4Tr
 onXiopY5KsKy/uw6z0iXXv5bdQpwcx5LKJ3TjotKdtLye9vk+vwju4jJLXmzxHjqqYtrxa
 C8MhB5X5OaOWpr8+0SetZBaNbCjnxddGPl3K7yRjPWRAsXAG9JFcQNlBbKmz3KLyVXW63Q
 bZnGylDGh7dGU6jcTd6OBnB+jeacUvBoQ7cHtNofvmNNeagZdNpgCuqF3VBlImdfBAqoob
 CgOTJCl1XRmfMMoMw6RwANOToEkcgNDUyxJ2AgJR72DDi/Y8CE96SsiH25DUYg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720280788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QFf0mVWLmG8O/Gc8O+I9JlNjuDBDuelZL3JcH6tUkw=;
 b=gEW1UyrI5RVd9r8rx7wfbt3l9bLe6scWhDZenbII1hEXO0JTXJFeKUgBRsusbXuAsKIvgE
 rYMgByGwtTRW0/ICavU4WLL0B2G+s6ecwGr6oi7NsIjbWXNKym9sRPKMsoAknGE5EVrKw2
 dVuUzeo0YwOY/5DjATzc2aTsWGKWaeXlmrh5rvh61qDoCTh3I9ATAzzd9SEsJukk8/LZvT
 1uKG3+iovEjgZOmDLWm7pVgwcEMneYUwMv17fVO9h2S7uT7YMT/LtyLzSplu4s9O7nD83o
 K8Q3cEtKDmzkO4Hy7y+DOgcLz+RRoMKLWGzuO74etrJ/mIXoPdJnQ20aol+WBg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next-clk-sync
Date: Sat,  6 Jul 2024 17:45:22 +0200
Message-ID: <20240706154608.63504-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a8stynh3zkaygx9wa4nro41qxgx9z8f4
X-MBO-RS-ID: c95b54de48f48158f48
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

This is for master branch .

The following changes since commit 1ebd659cf020843fd8e8ef90d85a66941cbab6ec:

  Merge tag 'u-boot-dfu-20240606' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-06-06 08:24:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next-clk-sync

for you to fetch changes up to 3c4ee884b73c8c21a1afcefef7d44d6a96fe9bf2:

  pinctrl: renesas: Synchronize R-Car R8A779G0 V4H PFC tables with Linux 6.9.3 (2024-07-06 14:47:13 +0200)

----------------------------------------------------------------
Marek Vasut (6):
      clk: renesas: Synchronize R-Car R8A77951 H3 clock tables with Linux 6.9.3
      clk: renesas: Synchronize R-Car R8A779A0 V3U clock tables with Linux 6.9.3
      clk: renesas: Synchronize R-Car R8A779F0 S4 clock tables with Linux 6.9.3
      clk: renesas: Synchronize R-Car R8A779G0 V4H clock tables with Linux 6.9.3
      clk: renesas: Synchronize R-Car R8A779H0 V4M clock tables with Linux 6.9.3
      pinctrl: renesas: Synchronize R-Car R8A779G0 V4H PFC tables with Linux 6.9.3

 drivers/clk/renesas/r8a7795-cpg-mssr.c        |  3 +++
 drivers/clk/renesas/r8a779a0-cpg-mssr.c       |  2 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c       |  2 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       | 14 +++++++++-----
 drivers/clk/renesas/r8a779h0-cpg-mssr.c       | 15 +++++++++------
 drivers/pinctrl/renesas/pfc-r8a779g0.c        | 14 ++++++++++++++
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |  1 +
 7 files changed, 38 insertions(+), 13 deletions(-)
