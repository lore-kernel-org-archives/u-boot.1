Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B059CC47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 22:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D33EA879A3;
	Sun, 14 Jan 2024 23:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GgIDtaSn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ne8oTZ2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CB9879BD; Sun, 14 Jan 2024 23:47:07 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F82C87861
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 23:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TCr4S1kYjz9skk;
 Sun, 14 Jan 2024 23:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705272424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IbtGrZ27YzBNf6lPBCaBx3QHqbqiUgrsbCf2voibcXg=;
 b=GgIDtaSn+5MPQ0RR9kk6gzlCqRNOTapTxZXj+rXdqmnVb1zPusiIK0hpOQQ/rR/TAJqONV
 VRt/tC3L3nkwDvUCmKHZ2gkziqUk/HeBT20I2HKl2cg/swxPPDWXsyLIJAkiVVVaUiUw1w
 6SEelZAoHYRDwPC5CvVp2Rvi8SooXH7w53G0oiAdKfRjq0KJRIxQYf5UhB8/dOMeOt0Aqw
 OIC74mmnAPhGNvPABUNZHd2PdvdoLufWp/NncrySwJclngeljop7su+Dj55YrpzCwRQUIK
 g9Ddu/Fj+JjMtJhKkLAhw9y7nkBmov4m/WBq1jgJu5GMpyoEzv2qh8G87R+03g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705272422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IbtGrZ27YzBNf6lPBCaBx3QHqbqiUgrsbCf2voibcXg=;
 b=Ne8oTZ2dXy5i+XTdAymN7//Wd9LwRF7CQkoHYUlAhTmPRXxBJUTdB9lTbKWNXUkc0CJqH4
 bw7GTeM5SwbHfJAHUQLqBdHk0LG2kyKerh5PFChzmghMK8y0tzKqml6keK+tcRl+picd63
 Pll3DJhAUwtZbALF5XWRLczm6RA7JTDDxPzVhRoGjbjRF5lMtIkoKyzyLMbEsucoQN6qIJ
 kALWHU9YP+S3eBRlJ1XA7at9pBImu3tXjwr1pqeIqLdp+BfRW0oKPVaI0tmo3fblJZUrUe
 w0fLJ3b0vK6XfMQWP/OIC1km0kihBaAvW3bbciE4NzulYED5juTqwKqxYp/6Yg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-sync-dts-663
Date: Sun, 14 Jan 2024 23:46:02 +0100
Message-ID: <20240114224641.14950-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kzy17skdpn459qeahsi6btfg1bsgwk8b
X-MBO-RS-ID: b59a9e5d293c880198b
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

The following changes since commit 817fdce324cac70fb4216ba42976f7b9c2ba9f99:

  Merge tag 'efi-2024-04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-01-14 09:34:14 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-sync-dts-663

for you to fetch changes up to 73595fd4c007d03765acdbf5420539682ef270ba:

  ARM: dts: renesas: Synchronize R-Car R8A779F0 S4 DTs with Linux 6.6.3 (2024-01-14 20:35:21 +0100)

----------------------------------------------------------------
Marek Vasut (12):
      clk: renesas: Synchronize R-Car R8A77960 M3-W and R8A77961 M3-W+ clock tables with Linux 6.6.3
      clk: renesas: Synchronize R-Car R8A77965 M3-N clock tables with Linux 6.6.3
      clk: renesas: Synchronize R-Car R8A77990 E3 clock tables with Linux 6.6.3
      clk: renesas: Synchronize R-Car R8A77995 D3 clock tables with Linux 6.6.3
      clk: renesas: Synchronize RZ R8A774A1 RZ/G2M clock tables with Linux 6.6.3
      clk: renesas: Synchronize RZ R8A774B1 RZ/G2N clock tables with Linux 6.6.3
      clk: renesas: Synchronize RZ R8A774C0 RZ/G2E clock tables with Linux 6.6.3
      clk: renesas: Synchronize RZ R8A774E1 RZ/G2H clock tables with Linux 6.6.3
      ARM: dts: renesas: Synchronize R-Car R8A7792 V2H DTs with Linux 6.6.3
      ARM: dts: renesas: Synchronize R-Car R8A77970 V3M DTs with Linux 6.6.3
      ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs with Linux 6.6.3
      ARM: dts: renesas: Synchronize R-Car R8A779F0 S4 DTs with Linux 6.6.3

 arch/arm/dts/r8a7792-blanche.dts        |  2 +-
 arch/arm/dts/r8a77970-v3msk.dts         |  2 +-
 arch/arm/dts/r8a77990.dtsi              |  4 ++--
 arch/arm/dts/r8a779f0-spider-cpu.dtsi   | 22 +++++++++++++++++++++-
 arch/arm/dts/r8a779f0-spider.dts        |  2 +-
 arch/arm/dts/r8a779f0.dtsi              | 17 ++++++++++++++++-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c |  3 +++
 drivers/clk/renesas/r8a774b1-cpg-mssr.c |  3 +++
 drivers/clk/renesas/r8a774c0-cpg-mssr.c |  1 +
 drivers/clk/renesas/r8a774e1-cpg-mssr.c |  4 +++-
 drivers/clk/renesas/r8a7796-cpg-mssr.c  |  3 +++
 drivers/clk/renesas/r8a77965-cpg-mssr.c |  3 +++
 drivers/clk/renesas/r8a77990-cpg-mssr.c |  1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c |  1 +
 drivers/clk/renesas/rcar-gen3-cpg.h     |  1 +
 15 files changed, 61 insertions(+), 8 deletions(-)
