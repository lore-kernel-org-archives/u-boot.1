Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54613FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17233842FC;
	Sat, 25 Apr 2026 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="UAF56CgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D723C843E3; Sat, 25 Apr 2026 19:10:17 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F344B841F2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 397E9207A2;
 Fri, 24 Apr 2026 12:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777027340;
 bh=Nw5zymD/5ImHgiNS9dyk12ggfLPo5WQfyy2fNjJis64=; h=From:To:Subject;
 b=UAF56CgHYIEMzCk/SYfVKbZqW+Th2YYZQR7fOSqToJk/uBLLZpLBuaJYgVCtKWILw
 osQCiusjqxrSpZ+cf49Zs2lEzW/WyNQTG3OJ+CbPPxAjn1q8pTslK+cJZDJy0+OOWS
 +rEK09aa8Ti9UaBwLYTWkehNLStoMRCxFlM7KzUvmnvcHG9K6Fs/qe5l3gRTB+SDVj
 9OmvIKvSzktdDGaI2WJCYvuKSOcJfY7jzfWUuBJHvI2ykH0EggJtVY0s71sF83NYeR
 SJSTml4AXmMvwLyzcjIQx29uOCeTmZZas6QbMtWRzBLOruNaxxJsF+Cgkurl9ptAoV
 MHglGn4DJEDDQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 00/10] configs: toradex: Enable EFI
Date: Fri, 24 Apr 2026 12:42:02 +0200
Message-ID: <20260424104213.303752-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Enable standard EFI support for all the arm64 Toradex boards, as required
for booting standard aarch64 Linux distribution, following the ARM
recommendations for SystemReady compliance [1].

The RTC used on these boards is not currently supported by U-Boot,
therefore it is not enabled at the moment.

Link: https://developer.arm.com/documentation/DUI1101/4-5/Configure-U-Boot-for-SystemReady [1]

Francesco Dolcini (10):
  configs: apalis-imx8: Enable EFI
  configs: aquila-am69: Enable EFI related options
  configs: colibri-imx8x: Enable EFI
  configs: toradex-smarc-imx8mp: Enable EFI related options
  configs: toradex-smarc-imx95: Enable EFI related options
  configs: verdin-am62: Enable EFI related options
  configs: verdin-am62p: Enable EFI related options
  configs: verdin-imx8mm: Enable EFI related options
  configs: verdin-imx8mp: Enable EFI related options
  configs: verdin-imx95: Enable EFI related options

 configs/apalis-imx8_defconfig          | 3 ++-
 configs/aquila-am69_a72_defconfig      | 2 +-
 configs/colibri-imx8x_defconfig        | 3 ++-
 configs/toradex-smarc-imx8mp_defconfig | 3 ++-
 configs/toradex-smarc-imx95_defconfig  | 2 ++
 configs/verdin-am62_a53_defconfig      | 3 ++-
 configs/verdin-am62p_a53_defconfig     | 3 ++-
 configs/verdin-imx8mm_defconfig        | 3 ++-
 configs/verdin-imx8mp_defconfig        | 3 ++-
 configs/verdin-imx95_defconfig         | 2 ++
 10 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.47.3

