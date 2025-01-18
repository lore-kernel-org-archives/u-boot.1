Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988A4C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A7F80657;
	Sat, 18 Jan 2025 12:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b/yf3WbP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dcw6lu2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F3F8070C; Sat, 18 Jan 2025 12:18:48 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A8E8063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZvHT0KXHz9sl3;
 Sat, 18 Jan 2025 12:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lIilwQU7jBbA7QLCo/jFi/9Oj2d6aazQzUqbqmoVLT8=;
 b=b/yf3WbPc27LRyvJuEZbZxUUS60DeH1QAICr2RjwPyleVYdRrYKhm1XqKuwocNoIg8gpVv
 k/lEflVo+VmHcPHmpLqFbPE/l7ZOWbwRh+qd6H4odZ8Cq8vW6Kggu5hnS0AiywYeDrWE3u
 5Hm+JXvxgPDvFSdAjBPKqlo7lH13prQ2aVtqMOhuerPWkERkBirdsnNyKXqi0zwirERi7t
 Uyqijj33IFBUkcVYGP/XKnghDusrmH3PmtbXwhN4lgqqGAoaHz9bFXsUvo9js6eqTDlado
 4ETYZz6XIpgoxLselCFbjco8j3+yiDpfhJJ83sECjV1YGFGyThx29+nu/471vg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lIilwQU7jBbA7QLCo/jFi/9Oj2d6aazQzUqbqmoVLT8=;
 b=Dcw6lu2g/aA/u9Zy7433yUsXhdvaT2+lxaJZXhC+wxXe5Pf1KOeUR6BPYApPbT5KAnMyly
 HrfhXDHlYQOVCU3GyV7FlnEmDmOLUtzdjq87RcC5HefKSh9REExQ7w6w8SnNgJ/CelrBoQ
 a6nnDH3FutkDHtCTGnTSl7XluehV32ky3d4AW+fGqvKGCRJr7mt/SCgo+0HmHSHcXPz5T/
 sOFordQsfC1pzr0joXA0iB5UaI2GXlxKXvScZqO+9r7Dzyldz8NHUtLQIZcRtLUCKvWH0K
 Z8UcABhwMuNPeRcfsBPLVJMjbFB+2rvIydjhvyetVZe/Mm65hV38waqDerPJ8g==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sat, 18 Jan 2025 12:18:17 +0100
Message-ID: <20250118111830.362667-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0dad0127074d5cfbc6a
X-MBO-RS-META: u5ip31uggf633r8jwdb7s5eeada1jnpg
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

The following changes since commit c11dc783fb4418393dd08d39ee01debfc2dea4d4:

  Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2025-01-17 08:27:40 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 1487c34efa7b6a439ee7396e333cfc3f789f564c:

  arm64: dts: renesas: Deduplicate extalr_clk bootph-all (2025-01-18 09:29:17 +0100)

----------------------------------------------------------------
Marek Vasut (2):
      arm64: renesas: Rewrite u-boot-elf.srec base address if PIE for R-Car Gen3
      arm64: dts: renesas: Deduplicate extalr_clk bootph-all

 Makefile                                |  9 +++++++++
 arch/arm/dts/r8a774a1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a774b1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a774e1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77951-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77960-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77965-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77970-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77980-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779a0-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779f0-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779g0-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi | 12 ++++++++++++
 13 files changed, 32 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
