Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A9C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 19:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0724B8860D;
	Sat, 13 Jul 2024 21:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OGpqPHII";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L4jwQKNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F748860D; Sat, 13 Jul 2024 21:35:42 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C708855E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 21:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLzG34h1Hz9sZL;
 Sat, 13 Jul 2024 21:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720899339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wRiV5TGwJffjaJY06LLSJa9rSnoLOS1boi08A7ClMpo=;
 b=OGpqPHIIR6embzL9WXH7ekLYb1wEB9+LMmeCpfkTotB3Lqxaafea+atFMq2Xo0PC9hoy5N
 tZ4ZtW/rskXsmR5VdvVplLU/u1r/92qiGZbHBOAj8a+wjKU0HIUDwdkMzKj9faN0k0+nUK
 jD9A1OSRUmmQ1Q9/vvFQzp2BxjGciUiaRnVeG+qPSsXPJ4AS0ZEfCvPNTGsDU9LH00jfEY
 CzkJ2x2jOuMuYSHddP1id3AIJuvHEpKgJtg0MAN/dsSTCPTOLIP++ZLd2xrk8wMirNqPQh
 9sUrr4qlGyvLA7wGWyjlgdlzCss0IF6h9W8C/qCmLoNAk2UOTF2fTeF/Y0/yvQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720899337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wRiV5TGwJffjaJY06LLSJa9rSnoLOS1boi08A7ClMpo=;
 b=L4jwQKNxfHLYNs30t06VdIMNW8QPrg7guesh8mn3ahYt4Kj6yVgwLXQVtmu0+IwUZ1ksGM
 UQZ6MXcNMjzswlsyCzHUbhwkjx3onGQxzFK07+MRpPtmeYrMOrY0Befo7Ct41f11MkcYMf
 8Cc33mQ/fpeheLwdpqLCkJAlUDL7XnjwxapyiWRDTT0csqHKNgiWgiGV13+OKmmi5gK11B
 x4dDKky/g5EqviBxDTbBAqPQ6R5jsT/OE0DBe8ow7wKkJ33C2Fvo00qd/erXeVLee0G8Ag
 kjAmkk03vJIdN/Y5WEWHia27zExU9z74Lg9pUCRnCkITyTyMAWK+Zp8IMi5JvA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PULL] u-boot-sh/master
Date: Sat, 13 Jul 2024 21:35:07 +0200
Message-ID: <20240713193523.122675-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 12db608e1c6e080d3a5
X-MBO-RS-META: 1wbz69g5mc5qn76r6raqntnrp86ekfq9
X-Rspamd-Queue-Id: 4WLzG34h1Hz9sZL
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

The following changes since commit b182816c1fb436916661949213c543bf4d42250b:

  turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 5485f53289b37aeab4bf20c3980927cfc3dbf247:

  dt-bindings: clock: rcar-gen2: Remove obsolete header files (2024-07-13 20:08:09 +0200)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: clock: rcar-gen2: Remove obsolete header files

 include/dt-bindings/clock/r8a7790-clock.h | 158 -----------------------------
 include/dt-bindings/clock/r8a7791-clock.h | 161 ------------------------------
 include/dt-bindings/clock/r8a7792-clock.h |  98 ------------------
 include/dt-bindings/clock/r8a7793-clock.h | 159 -----------------------------
 include/dt-bindings/clock/r8a7794-clock.h | 137 -------------------------
 5 files changed, 713 deletions(-)
 delete mode 100644 include/dt-bindings/clock/r8a7790-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7791-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7792-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7793-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7794-clock.h
