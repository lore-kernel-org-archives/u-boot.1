Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B11CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2732883804;
	Mon, 20 Oct 2025 19:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cMJ0e24j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D3982C84; Mon, 20 Oct 2025 18:24:33 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D5D82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FDA162077;
 Mon, 20 Oct 2025 16:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5CBBC116C6;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760977469;
 bh=61qpp38ef7H0U17cFP6t18atMndKMQV53i2Fsy2H0ts=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=cMJ0e24jIT3AT6tFk+Ycn8KeejUq1K9w9UTZimbm03wLVK7BK93WNgsD6AvifgX5m
 QA6b6FXOTy/qMlY5ewhaqvTnO1nqtDwDp+8THimruVCVnDqht96qt+sBX0q2xyzDDH
 0IECorOqEgiEHcnKKHrbnUwmE4sJ1MHwdDImTrmu268DEPgWSzbeMydzUADy43bUba
 IFPawJVtG6oVhfMpqyeCtji0X29lNCNlCHwD6fNjkZ8MJFaY6L5L2e+JfwA0dCrp9v
 zXuOurJ+0abUNWQFGW9DzCVPAj5v20UXz5NQ5RTAOaUmyXTDS/QHwxskgkk7Nh8sSC
 qWOJ6by+ZJRHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C8397CCD1A7;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Tue, 21 Oct 2025 00:23:59 +0800
Subject: [PATCH 2/2] usb: gadget: Introduce usb gadget vendor/product
 default id for ARCH_QCOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-sc7180-minor-v1-2-9fe33c73365e@gmail.com>
References: <20251021-sc7180-minor-v1-0-9fe33c73365e@gmail.com>
In-Reply-To: <20251021-sc7180-minor-v1-0-9fe33c73365e@gmail.com>
To: u-boot@lists.denx.de
Cc: George Chan <gchan9527@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760977468; l=1201;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=ldgJNz2wHJliI43avdl9F3gBvhVbCT7sU2a1+PlLkQc=;
 b=yzwIYFFhQ1s/v9g4wNlMCn99XpUcUK5n3AxzYTZVS/XFBa4kw2ryZF57xIvV34V+KnzRiwQKD
 fxbVWxXiulgBX2efE9WwRLVwlxyC3OQnpLVfpxZQbz3ssR+GyYIRELc
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:28 +0200
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: George Chan <gchan9527@gmail.com>
---
 drivers/usb/gadget/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index e845e46e0b7..008f8c99a58 100644
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
@@ -87,6 +88,7 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x350b if ROCKCHIP_RK3588
 	default 0x350c if ROCKCHIP_RK3528
 	default 0x350e if ROCKCHIP_RK3576
+	default 0x4ee0 if ARCH_QCOM
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.

-- 
2.43.0


