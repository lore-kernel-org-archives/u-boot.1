Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BFEE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 18:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E603E8036B;
	Mon,  6 Jan 2025 19:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QbAq3gcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB9A801E8; Mon,  6 Jan 2025 19:22:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11533801E8
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 19:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=48da=T7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1736187767;
 bh=ZMid3qTOH3d2Z25tTLjsSJr3K6BpJw9y93wOeS5Sq4g=;
 b=QbAq3gcgwQlhkw99K7UrE0fN97AsRmgD2mgrrhKlNXCjuiki5vSB5ucxqWZbbIHupTs+ulCAm
 TZYwnQpT/+QFSl5worI8+gizbyfSITTEBrGZBBLBCvBLPOPnEbSvxHjBpdcITHi5GGcvfjnz48Q
 Vx9ZqlvWm0/fk4xSyZqAa0IvdTIOqilOt5vbl/FiZ2X3PL8R2e7JHq77AqP22QgVfkB4K4OaEsr
 w1lbux0rBJTUkXdm5XQel9O7JQK97Tr3+2WvjEPztQCimqmLrJgMiIRc/rI0qVdOJrnT8pXJm2h
 RP5k266ymCbNNm8Ll8HvRBMctTwZxlvX1mA96dRG5keg==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from bionic.. ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Mon,
 06 Jan 2025 18:22:34 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Ricardo Pardini <ricardo@pardini.net>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3588-nanopc-t6-lts: Add missing board -u-boot.dtsi
Date: Mon,  6 Jan 2025 18:22:29 +0000
Message-ID: <20250106182232.3741304-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 677c1f707fb9a1c4e00fff46
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

The commit 7cec3e701940 ("rockchip: rk3588-nanopc-t6: Add support for
NanoPC-T6 LTS") added support for the LTS variant of NanoPC T6. However,
a board specific -u-boot.dtsi file was never added.

Due to the missing -u-boot.dtsi file the LTS fdt included in the FIT is
never tagged with bootph props.

When ENV_IS_IN_SPI_FLASH is enabled, not enabled in defconfig, the env
can successfully load from SPI flash on the non-LTS variant, something
that does not work on the LTS variant due to missing bootph-some-ram
props in the LTS fdt.

Fix this by adding a LTS -u-boot.dtsi file that just include the non-LTS
-u-boot.dtsi file.

Reported-by: Ricardo Pardini <ricardo@pardini.net>
Fixes: 7cec3e701940 ("rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi   | 3 +++
 board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi

diff --git a/arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi
new file mode 100644
index 000000000000..b18f958c8a28
--- /dev/null
+++ b/arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-nanopc-t6-u-boot.dtsi"
diff --git a/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS b/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
index 63ff6fafc8d7..27853188e59e 100644
--- a/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
+++ b/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
@@ -5,5 +5,4 @@ S:	Maintained
 F:	board/friendlyelec/nanopc-t6-rk3588
 F:	include/configs/nanopc-t6-rk3588.h
 F:	configs/nanopc-t6-rk3588_defconfig
-F:	arch/arm/dts/rk3588-nanopc-t6.dts
-F:	arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+F:	arch/arm/dts/rk3588-nanopc-t6*
-- 
2.47.1

