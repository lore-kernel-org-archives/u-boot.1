Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A615BC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64428859A;
	Mon, 29 Jul 2024 09:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="B+YHaiXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCA18861D; Mon, 29 Jul 2024 09:19:16 +0200 (CEST)
Received: from mail-m242.xmail.ntesmail.com (mail-m242.xmail.ntesmail.com
 [45.195.24.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F02883D4
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=B+YHaiXm+hMf9y4DDNvUJ8uxoehVkJMuW91044uVsb3iIYLwOzIVTk2HwbAxFWcdO0KAtEzZf94c+nKou4iiiUK38HXPkpk9rUcPHc3nNQXD8SbNoUGpM1gRqECbqXzqsbPcK3Ygzbhy0dS9VupqTwm3yYG7B4ZFcE+TiPHCDM0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=FcmXjeAkKvtdC+ugyemXAcabljIvjviQhtEuBXWIglE=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 47D5B900141;
 Mon, 29 Jul 2024 15:18:52 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: dts: rk3568: Sync the evb board name with kernel
Date: Mon, 29 Jul 2024 15:18:50 +0800
Message-Id: <20240729071850.918007-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5DS1YYSk5KGktLGUJOTUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90fd5b3a7f03a9kunm47d5b900141
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6IRw5HzIyTDIrNShWMS8u
 IRAKFB5VSlVKTElJSUhMTkhISU5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0pPNwY+
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

The name of rk3568 evb in mainline kernel is rk3568-evb1-v10.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 .../dts/{rk3568-evb-u-boot.dtsi => rk3568-evb1-v10-u-boot.dtsi}   | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/dts/{rk3568-evb-u-boot.dtsi => rk3568-evb1-v10-u-boot.dtsi} (100%)

diff --git a/arch/arm/dts/rk3568-evb-u-boot.dtsi b/arch/arm/dts/rk3568-evb1-v10-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/rk3568-evb-u-boot.dtsi
rename to arch/arm/dts/rk3568-evb1-v10-u-boot.dtsi
-- 
2.25.1

