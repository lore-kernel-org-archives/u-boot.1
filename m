Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7DE77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4968B806FB;
	Thu, 16 Jan 2025 05:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000345;
	bh=MG+5DeL3Sp3SggsPtbBHClpuIzDWF003cWRkY+9b9Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIGGwbXWhwfVZpDxQ2B3FZaFStUXQjcVO6jeX9T85N11k3x6LeuKWGQIwflSm+mFT
	 aHtJpnzzWeCbMNDILIy2hPPdmiJnywTBEy46b4nvYS1+CjZoQ6UduWkqgrR/OWZJq7
	 F9B2uCnK+zKoyB/5PU+ZzHO7u19t3+hucjFoJb8NRWWwprRmu2A5FReArjVH+5pgwr
	 ZgTWulmTevVGcMVeU37Z/SrLwmzgU2dYcict3T/U0xw8xUzjCab6yVuYN+CY3ALOM+
	 716PW/sLiVH8034aBB1mKn17soPykuN8/MxrFiefnMDyRFLyQRclMOHxy2N+4ERMsO
	 rk3uVHvpd3Ciw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B819C80713; Thu, 16 Jan 2025 05:05:40 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B53B5806FB
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ug37cWi6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AB40109403D9; Thu, 16 Jan 2025 05:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MG+5DeL3Sp3SggsPtbBHClpuIzDWF003cWRkY+9b9Bs=;
 b=Ug37cWi60cziohUJjUjW2QjI6a+IYyG62hWQRa9Ed4AOtsxqdSra80AgdbyAtE1nLzEj62
 6yww1y8xyJHFI3Ndi3ve3ipa3WTF5AAMfadHxKcajwDuDv+/XExc0CBrz+v4jIo4fLlDF8
 ZFyWtgVVHPGw64EmiqkiGan6RrAAmovz0W3cbx44vOKCRFH15VnUkz7IncTYm1uJ/zNhtL
 b0QfrRWiOg0Fu6IKvESFuum90oLsN2TfZygBeNEYyyxWn3SgKnTCY+0GPvfyRy+3faqSCw
 IUt2WEbih7W63o29JP79BA9imL/SHuB1R2Xr8w++ZhwJ9kgComwBUhHraR3fnA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 04/13] net: fsl_enetc: Pass udevice pointer into
 enetc_enable_si_port()
Date: Thu, 16 Jan 2025 05:03:21 +0100
Message-ID: <20250116040449.306098-4-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
References: <20250116040449.306098-1-marex@denx.de>
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

Pass udevice pointer into enetc_enable_si_port() so tests like
enetc_is_ls1028a() an be used in the function. No functional
change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 826b1971bb0..615646b76a3 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -437,8 +437,9 @@ static int enetc_write_hwaddr(struct udevice *dev)
 }
 
 /* Configure port parameters (# of rings, frame size, enable port) */
-static void enetc_enable_si_port(struct enetc_priv *priv)
+static void enetc_enable_si_port(struct udevice *dev)
 {
+	struct enetc_priv *priv = dev_get_priv(dev);
 	u32 val;
 
 	/* set Rx/Tx BDR count */
@@ -571,7 +572,7 @@ static int enetc_start(struct udevice *dev)
 	dm_pci_clrset_config16(dev, PCI_COMMAND, 0,
 			       PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 
-	enetc_enable_si_port(priv);
+	enetc_enable_si_port(dev);
 
 	/* setup Tx/Rx buffer descriptors */
 	enetc_setup_tx_bdr(dev);
-- 
2.45.2

