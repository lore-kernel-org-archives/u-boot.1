Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544A6C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 20:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C0E82BCD;
	Wed, 18 Jun 2025 22:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jI7407sz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rkRVVPEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBAF82C2F; Wed, 18 Jun 2025 22:33:21 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3565182B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 22:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bMwRg0McDz9sSQ;
 Wed, 18 Jun 2025 22:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750278799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GthegdusjiliGdu0olgJHtXk9egqWoa5U/Buj0wNiKk=;
 b=jI7407szNttlt7tJxj95jOEb1nzWUUJYDx8S2Fzem8x8QWBe1/P6N/U9aB0ep5dHqpk0nc
 pwLS2gKzS4iTPHxui/lQyAgKWQMbjtOIBPHu1fmoBGrEBAeocegqQTApzTxlXOGDrilAh4
 8WMBIV80AFzktypXbyJRoOltVgiT+b9M/bQmo0Qx5bdINR/1IFZ1+BUFdpfQgXuFGp2+Ar
 5bYVl4x1wP0hk52LKJGbdbpehkyI4R5BNmyhUF2e+zmujBVNDqW4WqA+kal8tAAbtquTi7
 VQ4fRH8CAogIazBm6B+Fev2tlioYIGXxmeswUQ3KAvbr9uC7GwOQPRoO13ajUQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750278797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GthegdusjiliGdu0olgJHtXk9egqWoa5U/Buj0wNiKk=;
 b=rkRVVPEZPBQimFsoMzrb6XTZ0yjP8TJrgjmI6Rq+OvLPXUSxH8beYFM4qHc6BgqC+UydPx
 FDH5s7VWNwfbHT2WYjxg5rhOukncHnfzAxh6Afm3slv1gyetf5cov+/ujwybFmvL2S+f68
 aZYcTdzq5e1M3pqxQEDAlAvtYFUmbsDiGVDU1aQJ0BOgYp1e16d8A+6Jt/OQqc2Kwod715
 9c1hEdXawAVnsaUTyca7ig/wMleTXY22vmUgom0amYvfKUw6E8tuBFvpgTI3l3/2yNxdOw
 f58jX9xiadlDpkNAIhO1OonXaDW1opbEKZdImjAHoiIshbd6AUmJ+l1LOEJPHw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Wed, 18 Jun 2025 22:32:47 +0200
Message-ID: <20250618203306.181857-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wxq6j5mzxxj3jboj9ui93bw1t5qzpbkq
X-MBO-RS-ID: c84eb31dbb0334c21fc
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

The following changes since commit 17012e3068d047ad71460f039eeb0c3be63f82a0:

  Merge tag 'u-boot-dfu-20250616' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2025-06-16 07:53:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 668b2d791d94d4fd6a4be6d7dfa822b072017378:

  arm64: renesas: Move early SPL stack into System RAM SRAM on R-Car V4H boards (2025-06-18 17:18:43 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      arm64: renesas: Move early SPL stack into System RAM SRAM on R-Car V4H boards

 configs/r8a779g0_whitehawk_defconfig   | 4 +++-
 configs/r8a779g3_sparrowhawk_defconfig | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)
