Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41050E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982E789400;
	Sat, 23 Nov 2024 22:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nrYhpwPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E019893FA; Sat, 23 Nov 2024 22:46:48 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85C189349
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8099A4100D; 
 Sat, 23 Nov 2024 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732398402;
 bh=LJ05b6vCBY4VJKvS4/v4LN21CxatYjXYubNKAJjFozs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nrYhpwPTEKTWoX4Sn1OSnyAw/41OvJe7l1cZkvRCo9Lb+bddjFQ67DnQKh4ImpgUM
 /8iud53hsfaXL02wKM3lKgnz2aock9A+IKBb4TNnSjZ0h9sq05o7ttRCOK/9J8OyWb
 bsoN19UPfJf6q5gJ98MUQdtu9lhntRlBbVoktwwrU+86DA+FZLW7J4uTp8+7ILMxt7
 GQWGuCTtSsfp01F6mrZfcA0KGzVf/B5c97bV0Y4BMykHZlk+ff+lrzWlACuil3nmQc
 dC4e4oJY3Il7vw+6KR6522hAe/lgaezh7cDYdiv678vx+T6BPqeh332NuDrL+/zKWT
 d/s3+SSBQuKSw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
Date: Sat, 23 Nov 2024 22:45:51 +0100
Message-ID: <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
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

The CI uses the following command to launch xilinx_versal_virt_defconfig:

    qemu-system-aarch64 -M xlnx-versal-virt \
    -display none -m 4G -serial mon:stdio \
    -device loader,file=u-boot,cpu-num=0

'usb start' or invoking eth_bootdev_hunt leads to a crash when function
dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
relative to the register start address 0xfe20c100.

Disable CONFIG_USB_DWC3 until the driver problem is fixed.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 configs/xilinx_versal_virt_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index c8f166c1221..06a240173ba 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -153,8 +153,6 @@ CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_DWC3=y
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
-- 
2.45.2

