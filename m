Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F3C4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D42878ED;
	Thu,  1 Feb 2024 14:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LrCaX+0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE1687C13; Thu,  1 Feb 2024 14:16:16 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B18DE878ED
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3B82961C00;
 Thu,  1 Feb 2024 13:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEFE2C433F1;
 Thu,  1 Feb 2024 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706793372;
 bh=QMfwBw1MGvgmX+baE1mQW7yqLnFCwlhOHl1tI9+cRFg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=LrCaX+0Wvf/u0hsZT1D0AlnUmg9UVKt2zH1ahMbpVap7trPx8YxlS4O5enAD6cyVx
 LPkYY+whMK6YpMYp3P+uPwHc3vOijraa4eS9juTD1b2M0c1m6g6B2bdSrVNoiwrQ2W
 9diYlcfVYfKaynR2alZq8cdxFxnatVK+19bdpAAlZzccjxY4zT4arwk5NMz3TONfcR
 +5FPM8Z2GFPx7Wvw1ZHKh2oHMm2RyWACnS+ZaAYl5NG1XPr4SWgEGu9mznldzxQyRo
 I1jD2pe/A/JfQn7G5UAzRfuTnlzOWfmfGnmyg8n0XEPeGvgEZPP5rlziVOaEVV+py7
 VLuIGR6kvs0WA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C11D1C4828C;
 Thu,  1 Feb 2024 13:16:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/3] usb: ehci-generic: setup a bulk of phy when possible
Date: Thu, 01 Feb 2024 21:16:07 +0800
Message-Id: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeZu2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwND3dSM5Exds2TjxETzFEtzS2MjJaDSgqLUtMwKsDHRsbW1AGJ0p4p
 WAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706793368; l=837;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=QMfwBw1MGvgmX+baE1mQW7yqLnFCwlhOHl1tI9+cRFg=;
 b=AcptH8CJIHYl6WPhhwqTXaRNTKyPseQaeOnOYgZ81rpcLuozTj6WD/+UYkZahlWe5zhqP4iiD
 1ePLJJACsQqBeRf9X1IWv15iUEcDiDsKtAVgIxZ9CnqGZVl1eCmE6cI
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

one USB controller can have multiple ports specified in dts, all of them
should be setup to make use of all possible ports.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (3):
      phy: add generic_setup(shutdown)_phy_bulk()
      test: phy: test generic_setup(shutdown)_phy_bulk()
      usb: ehci: Make usage of generic_{setup,shutdown}_phy_bulk() helpers

 drivers/phy/phy-uclass.c        | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-generic.c |  8 ++++----
 include/generic-phy.h           | 29 +++++++++++++++++++++++++++++
 test/dm/phy.c                   |  4 ++++
 4 files changed, 70 insertions(+), 4 deletions(-)
---
base-commit: b6d8969bcb94321dfed1399f2eaa8768ba42caaa
change-id: 20240201-ehci-6c3aa7d97932

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

