Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E83CC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1B782CB9;
	Tue, 20 May 2025 16:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PBaeb+SU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD1C282C87; Tue, 20 May 2025 16:26:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8ED82CA0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 875415C5653;
 Tue, 20 May 2025 14:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 222B2C4CEE9;
 Tue, 20 May 2025 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747751159;
 bh=attEk5vOeLbXp8GjjUtKoHcqyQKc6hHkOc+Hg6czHV4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PBaeb+SUerrA9bcYgIeXV8D2EqCQPfQ2WfTVNIJ6sSbbzkp8bSPTnEixOWomJvSxP
 oLaVkuycAIcx+ZGGgC73xkeYxanY+cPgwjSRdruJSHmDsFSR3BDDmV7r7dG055EIf1
 1kg19M4vdtSWwviCUJT+FXIrH2TojLHb169I0ff7y/eHVGMth6SHiYt3sAu6YCf+IL
 Y9qJ3iy25dRTaTfZ+IUcovXZjvOquCI9XjGO8gmy44TLXQQ0nlZruWEs0XB+h7oSLS
 z3fwiArocGfy0X3tjuc7kQ/2a2IcDJcErsexogUG918kEVgVWv5lPmZBjj4w8dUNTO
 tbXGjcLrB0+pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 15846C3DA6D;
 Tue, 20 May 2025 14:25:59 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Tue, 20 May 2025 22:25:59 +0800
Subject: [PATCH 4/4] usb: gadget: Introduce usb gadget vendor/product
 default id for ARCH_QCOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-sc7180-android-boot-v1-4-3075a84ea094@gmail.com>
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
In-Reply-To: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747751157; l=1027;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=GqK0WVCZk8iWoMSZ7t6DB+MXl/Suedu5OgUA7VOZdkY=;
 b=m75ZHwpBDrOXQt1BQ50jI8/9zrWEC9EUDQZdwngm3zUNOOwTQ2DkkUCwIe4W7b4vicYBdMjfU
 FXj3aaPGzyADmeiGCpyDTgI1VgzxgkSCnteYRiycvCONtJDfU/fDSjR
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Tue, 20 May 2025 16:26:13 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Currently vendor/product id are both 0, and that might not as we want.
Set to some arbitary known value that we can make it work more smoothly.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 drivers/usb/gadget/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 46a83141481..2a56e360b5f 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -60,6 +60,7 @@ config USB_GADGET_VENDOR_NUM
 	default 0x0955 if ARCH_TEGRA
 	default 0x1f3a if ARCH_SUNXI
 	default 0x2207 if ARCH_ROCKCHIP
+	default 0x18d1 if ARCH_QCOM
 	default 0x0
 	help
 	  Vendor ID of the USB device emulated, reported to the host device.
@@ -86,6 +87,7 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x350a if ROCKCHIP_RK3568
 	default 0x350b if ROCKCHIP_RK3588
 	default 0x350c if ROCKCHIP_RK3528
+	default 0x4ee0 if ARCH_QCOM
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.

-- 
2.43.0


