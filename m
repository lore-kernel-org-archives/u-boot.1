Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71F4CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499268313B;
	Mon, 25 Aug 2025 15:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="BARKSlCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEAA830E4; Mon, 25 Aug 2025 15:55:43 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8CE830B4
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16E0AC994C; Mon, 25 Aug 2025 15:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130141; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=O7xx8EKaGjU5dfUHkrhMwvFWewbl7CjTm8bW7bg/JJo=;
 b=BARKSlCLjgeKItpITsxcp7OIEjKBxCTNhkvpCtbdujEEqG31ybjddNSE1MzR36Wh4q/uS8
 v5W0ORb0TA9uLrh2e25jwpuFLRclvifesaeN4yp3/xZ7b7GfKBXLxf7wy7dAb7mW8fuX90
 eWiJKILhri6j99QOL94ui3StcD4qS+1p+f+gkjjTF6+3xuA4Q8N2XKde5MWEEZJB6zmGtR
 oZgfQjuHj748gwnBjcusRWeRbXpoxsqmbm9THAWM+FXGNpcHXWfbZgSO6m3dxrqP6K5m2Z
 OGsPADYab5N676FmrxSK2/SY3qUl7T0pfZCDqWpwhUFBucuYPQoj1vhWu517GQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, Marek Vasut <marex@denx.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 03/11] imx: kontron-sl-mx6ul: Set CONFIG_SDP_LOADADDR to fix
 SDP boot
Date: Mon, 25 Aug 2025 15:54:27 +0200
Message-ID: <20250825135504.193004-4-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

We need to set CONFIG_SDP_LOADADDR to a valid RAM address to make
SDP boot work. Use the end of the DDR (256 MiB minimum) as other
boards do.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index b04cd75a7d4..7ecf2bbaa9f 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -107,5 +107,6 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x8f7fffc0
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
-- 
2.50.1

