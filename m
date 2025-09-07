Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AEECA1017
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 20:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACC3802C1;
	Sun,  7 Sep 2025 22:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CavwH35d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZqfY3QIY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B32803CC; Sun,  7 Sep 2025 22:22:50 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386B8800D7
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 22:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cKhN76jrXz9shj;
 Sun,  7 Sep 2025 22:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757276568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qCa3xEfT0xn0ki7mTaDrOQh+ltsC7mWcqFhjI+e2Xv8=;
 b=CavwH35ds3B64AIx5dhL4aydbqii0yqCTbYrtOl0NgZqMvU4rqjpK+rsQ6V/1f+GA/YUEJ
 MHFCG4Xszm3QfWBo/WdKTUWHMAX94YkTQk2MEYU/WXFN9nezh3+TJRTroRm64fsklet3ch
 R+4FFObFKCZTFAHxrUXk3lA0caaxzpsgDe0kyfd33BCXizkCMjxmORnKZfMzgbkQv4Qshe
 EfmMUwr5sAKg8+b57JY1bSmNZJQ16jzHPZCTNzz9lv1EeFtrzMyXE6AH/wZx0Sf5ySXnkS
 vR3zvZAjHIOlaBfYfXCNpn108mvn+XFaKn9fKV3RkruntFM8OVZleIJ9KIhDuw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757276565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qCa3xEfT0xn0ki7mTaDrOQh+ltsC7mWcqFhjI+e2Xv8=;
 b=ZqfY3QIYikSAXRa1sHv1ZKDy9qOQqiaunKtCXc8QDrwoCUv5qcc5B3EPBKhiyxi12YVqvj
 gD91gx22XWwK47Z0GNpJ5OroGYa9eBjCwb7P4TlokbwlIbfIK9xW5BhIebtVNztWaQtpwz
 Q9GWCsquX/AzodE/yeI3kR5clZ5hQsjcYg6o8daLtbShQKe6ihg8YVso1rZmXCag5VN6ZK
 GMTGEi18P1gPCHbkHKw2qcDJ26QfOyfksfBjzpZ9zTM+S7GjK0jMTgNFsJRaXxHSxxIL20
 weI/bFo6dVyKfcwnqrVcw1kS//LHGzUtASpyWtjLlB9aVkDtU9SlCoom75Cc/Q==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun,  7 Sep 2025 22:21:57 +0200
Message-ID: <20250907202229.385685-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7ad6cb9ffd2f08b435e
X-MBO-RS-META: 7kkxqzo4jzdpqbr84cahuu176xzhemak
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

Trivial last minute fix ups.

The following changes since commit 328747974a0620d0996113fe2b3906b06e96de00:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung (2025-09-05 08:15:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to b5294efd21369db75cf2176fdce93d14cd8485ca:

  arm64: renesas: r8a779g3: Use $loadaddr in bootcmd on Retronix R-Car V4H Sparrow Hawk board (2025-09-07 20:29:50 +0200)

----------------------------------------------------------------
Marek Vasut (2):
      ARM: renesas: Enable CONFIG_ENV_VARS_UBOOT_CONFIG on all boards
      arm64: renesas: r8a779g3: Use $loadaddr in bootcmd on Retronix R-Car V4H Sparrow Hawk board

 configs/r8a779g3_sparrowhawk_defconfig | 2 +-
 configs/renesas_rcar.config            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
