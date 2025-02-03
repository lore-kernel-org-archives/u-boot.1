Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337EEC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 21:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF9B801FD;
	Mon,  3 Feb 2025 22:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OXNKoNsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E422480050; Mon,  3 Feb 2025 22:54:46 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5DDA80087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 22:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 513Ls3wV3032233
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 15:54:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738619643;
 bh=D+I9PjDWkCbAQYDy4CFUAGGSyjry05it351bnSxFsh8=;
 h=From:To:CC:Subject:Date;
 b=OXNKoNsj5st4YOBYNpz4oXwUbwXq3RlT7oD2ayCM+BmgVzr4Bjxw0buGxnX5Q48ff
 3KbFylo+1WmflpiNGIiBwOwrWTmR59Lptefr8wg98jpBq41L76LbNRL6gzgXbJtd/J
 eMn/HaFof1dcUspOWFqYOnpd2G85Ppcv5OCrbDTY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 513Ls3uI048145
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Feb 2025 15:54:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Feb 2025 15:54:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Feb 2025 15:54:02 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 513Ls2kr058821;
 Mon, 3 Feb 2025 15:54:02 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, "Michal
 Simek" <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski
 <lukma@denx.de>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/2] EFI Capsule update explicitly sets dfu_alt_info
Date: Mon, 3 Feb 2025 15:53:49 -0600
Message-ID: <20250203215351.2840144-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 03 Feb 2025 22:57:27 +0100
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

For capsule update, explicitly set the dfu_alt_info environment variable
before the DFU operation, and then restore it to the original value.
Previously, the dfu_alt_info environment variable was set with the
set_dfu_alt_info() function.

The problem with setting the capsule update's dfu_alt_info setting in
set_dfu_alt_info() is that set_dfu_alt_info() lacks the context of what DFU
operation is being performed (eg, capsule update, DFU boot, listing the
alt_info, etc) so the capsule update setting was overwriting the setting
for other DFU operations.

Jonathan Humphreys (2):
  efi_firmware: set EFI capsule dfu_alt_info env explicitly
  board: remove capsule update support in set_dfu_alt_info()

 board/beagle/beagleboneai64/beagleboneai64.c  |  8 -----
 board/beagle/beagleplay/beagleplay.c          |  8 -----
 .../aml-a311d-cc/aml-a311d-cc.c               |  2 --
 .../aml-s805x-ac/aml-s805x-ac.c               |  2 --
 .../aml-s905d3-cc/aml-s905d3-cc.c             |  2 --
 board/phytec/common/k3/board.c                |  8 -----
 board/ti/am62px/evm.c                         |  8 -----
 board/ti/am62x/evm.c                          |  8 -----
 board/ti/am64x/evm.c                          |  8 -----
 board/ti/j721e/evm.c                          |  8 -----
 board/ti/j784s4/evm.c                         |  8 -----
 lib/efi_loader/Kconfig                        |  2 --
 lib/efi_loader/efi_firmware.c                 | 34 ++++++++++++++++---
 13 files changed, 29 insertions(+), 77 deletions(-)

-- 
2.34.1

