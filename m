Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD76C83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 08:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B759582E08;
	Mon, 30 Jun 2025 10:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jKomprL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A8682E86; Mon, 30 Jun 2025 09:57:13 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A2E82E08
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F01AB4627F;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4754C4CEF8;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751270225;
 bh=0kWYPyP9EbM2SF6yg1Nfbt1LzhFeR0kZZ8alS/Fcd2o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=jKomprL6qd4JfT0a+s3aSdO5nRbl9S9WyfjWkaaYQykrDXs9At0o7CDSd9VSZZAEH
 FpO79ZyS83RVX6r4Xy9J9gM0kwI259br2+AAHo6dlZotehH53Ycg65TFRExH+PpRfN
 kEesNEw/qLIv8Jl8/EnO1cFeq+msn27vU5x2LG8Bcb9NQzRZNY1YLmuxJgkAqlD+ZD
 ZXJFzC2eTuq9JvLI9npEJ7wA7Wi+Nfwaji0+0cht4QYUwqeGppbz9aLzfsavxROw0Y
 5y43EDbG2EwY7gNInx/O7fBaX8KYs3kiVtkHOSlhJgwzPdzSLrNh3byU9S/DRGw03u
 vVVtqfDyOgA8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CB7C5C7EE39;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 30 Jun 2025 15:56:55 +0800
Subject: [PATCH v4 6/6] usb: gadget: Introduce usb gadget vendor/product
 default id for ARCH_QCOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-sc7180-android-boot-v4-6-24cdb50e860f@gmail.com>
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
In-Reply-To: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270223; l=1201;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=i3CjPUv7tDnbX1a1ToJTqfyheK3BG5MGFTksS5RV3ig=;
 b=xA6zlJ6wvxC0BUq/qprXc1BOQF01W51hnrkZSn7rn6eZtKGyVHf9IYB108aYkmCcV9VS0qDdL
 H8VYaIj6r28CdZDSEtEq8SBq0MBOho+KDf+fxOB1Xa6rwkarSrT4WF8
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 30 Jun 2025 10:02:49 +0200
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


