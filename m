Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B37C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1375580104;
	Tue, 11 Feb 2025 11:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDCA880842; Tue, 11 Feb 2025 11:29:55 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B57D80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ysd410gylzy8h;
 Tue, 11 Feb 2025 11:29:53 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ysd3z5WhXzCrb; Tue, 11 Feb 2025 11:29:51 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] rockchip: remove u-boot.rom generation and use
 binaries from simple-bin in simple-bin-image
Date: Tue, 11 Feb 2025 11:29:41 +0100
Message-Id: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJYmq2cC/x3NTQoCMQxA4asMWRtoO+jCq4hIf1IbxKYkKsIwd
 7e4/DbvbWCkTAbnZQOlDxtLn/CHBXKL/U7IZRqCC0cXvMcW7abyxDcmkReq5EduPNAGY+KOpa4
 +uVMsoa4wK0Op8vd/uFz3/QesKV54cQAAAA==
X-Change-ID: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

This gets rid of u-boot.rom generation as that was used only on Rockchip
Chromebooks and their maintainer (Simon) seems to agree[1] that
u-boot-rockchip-spi.bin should do the job now so we don't need to
generate it anymore. This was agreed for RK3399 Chromebooks, I'm
attempting to do the same for RK3288 Chromebooks as well so we don't
have anything requiring that u-boot.rom anymore.

Since HAS_ROM is only guarding this u-boot.rom generation, they are
removed too from the individual configs.

Finally, this also fixes an issue reported by Naoki[2] where binman
would try to find symbols from proper to install in xPL binary only for
it to not find it as we do not generate (on Aarch64) the proper binary
in simple-bin-spi image node, only in simple-bin, so it cannot have
access to the symbol. As to why this triggered only when some seemingly
unrelated symbols are enabled, I do not know.

The first two commits are cleanups. If they are controversial, they can
be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
{rk3288,rk3399}-u-boot.dtsi binman nodes.

Note that none of the patches were tested outside of a simple build
test.

[1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
[2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      rockchip: rk3399: do not generate u-boot.rom anymore
      rockchip: rk3288: do not generate u-boot.rom anymore
      rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin

 arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
 arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
 arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
 arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
 arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
 5 files changed, 10 insertions(+), 66 deletions(-)
---
base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

