Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E5BC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 19:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA83F876E4;
	Sat,  2 Dec 2023 20:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dPsa2U8T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K91Y7LRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422B1876F6; Sat,  2 Dec 2023 20:09:25 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C68687651
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 20:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SjKH643tqz9sd0;
 Sat,  2 Dec 2023 20:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701544162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+snJVydv4jnlkYQ7enldhDKKT5LFI6IG79N+B+4NSHk=;
 b=dPsa2U8TPvrqk1Udz6pPaml3tmJW4dcdLfEggGegxeNmvwC1WcGwUo/NPZk3uJsMqne5lf
 CtUmctrmRwEhONdYj8o3rjEX80XUvVkV/SpNZFP3ohpozi746WrWXcQRF0a8mnTyCiHAVg
 x2RnPHorNNSBiSG8pqNWdsznFvHwGeTylpoalLNrko/JhxMikh9T7av9id+XeOGn3+t3GS
 O0ocVaNOVX7ZqTtss38x4sj+4Kausw0zXeyAEsx2qi695Z3gxUkp+SS/Ws/WYxHKvLVtsX
 nlOAjegQVFP1mV/9LVosAyDPV0p11G648I2bkJV/YJi/ZFvV2f0uTNgx9pMLfw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701544160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+snJVydv4jnlkYQ7enldhDKKT5LFI6IG79N+B+4NSHk=;
 b=K91Y7LRr/vFlkjaJZ0LF20rUGGr0rgDryaF2uB7+7lKhxmzcuDoHFQuZJRfhTuzHTPMfqw
 St8SL8wWUrck7mon5vVVRdlszKnvs+NXCsIB0MyF0jZgQ3MjYf7/I5PIkuQszJi5IEz/Ru
 UEFdGgswejvXUQNH2W762XyBiVhLpvGLotxxt/ikVl6BzWF5qnxHH53zdjKYXhCmkQq8RX
 4EGGIKHVPKdPc21u5GlNLinlV8pyPc5CAms9yVI4uz8QjVgIMWPcd1DAzFGrXfdllaxc7z
 oNKpOS5lmC/qHu9ec3tu0eIcSgCqjr0trR9QpSvC/FUR17wSUMU52ET9JWZ9Xw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-rpc-off
Date: Sat,  2 Dec 2023 20:08:40 +0100
Message-ID: <20231202190907.62645-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f062a9a4c832d6a7e77
X-MBO-RS-META: htbwmwte668xuoxjnj7enpxepmuem6r7
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

The following changes since commit 43f2873fa98b1da6eb56d756315c7bd7db63db27:

  MAINTAINERS: Step up as co-maintainer of Tegra SOC platform (2023-11-28 11:23:02 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-rpc-off

for you to fetch changes up to 13bdb6a269108d3f9b953bf4b73079d66ecc37af:

  ARM: dts: renesas: Disable RPC driver on R8A779G0 V4H White Hawk board (2023-12-02 17:16:01 +0100)

----------------------------------------------------------------
Cong Dang (1):
      ARM: dts: renesas: Disable RPC driver on R8A779G0 V4H White Hawk board

Marek Vasut (1):
      ARM: dts: renesas: Clean up R8A779G0 V4H RPC SPI DT node

 arch/arm/dts/r8a779g0-u-boot.dtsi           | 18 ++++--------------
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dts |  2 +-
 2 files changed, 5 insertions(+), 15 deletions(-)
