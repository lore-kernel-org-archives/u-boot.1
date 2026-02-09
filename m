Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403EEE81BA5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03CC83C91;
	Mon,  9 Feb 2026 12:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5rhRD03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9DC83BDD; Mon,  9 Feb 2026 12:45:29 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BD283C23
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so33039495e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770637526; x=1771242326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWJ9t0kdnBxca7LMKo9NDJoYYEBsOv4msLYLr1vwpVw=;
 b=F5rhRD03zObrNIB+aDd/64ZdVp8FPpsx7Lyy6gCCEuopGKU4tWx9LFBCiXtWPxVrCy
 v1V2xTRZAFDJhgAp0pIIReAf7PiPQ+C63GH08Aqh/FS1SNLSNOSZJguzoANODeyXopyE
 OR+vu8z3zdGI3XEgC2E5hiv0RPkisAVa+9lPxUI13BsCpx25y4zlueq/w0A4hhgSK7un
 bxb5IMhixdQZ0ZPMqJ1nnsDOBZzLIeNTC+3MYp5Rr/6Q7vjf2jp74ilnkLsGlyDQpWPG
 egobkh5yHC+TWxI7NNwNhekb40Il1l6oeP8tXm3YpWk9Zx6qrTZjCOdpf7w403agdNNk
 QdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770637526; x=1771242326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWJ9t0kdnBxca7LMKo9NDJoYYEBsOv4msLYLr1vwpVw=;
 b=pIwAJq/fSvixn0Tx3z8hCAT8oljik3MF7NkwXmE7dLF2A7kw4eGY4xAn8YcwoCQ43N
 f/ixaBwGqYBAtMOBiv8PVjZufVcye/AYz7XFw71Vnij+BrbpF7zxa95GL1Yw7CLu5zi4
 NPHv45SZm1/wVQr8jMwl8olDwRUKb+qPoSEqBojRh8ILzGjsXoEfQQ1up6q3YRKMGAOt
 Ur0CICRHxwXD3lpqsnxE7I/Dwe80wPrdiHwz0JmrgUxetHmx5mCuWQrik7QJgUASPzx7
 r373ixvcS6bI3CZ3coYtrqStjgCh3DOYz5Wks2mdSL6YDvae82fwfIWG5LwNhFflFpSs
 rSag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsFdredlvqUBHN26h+S9ms40WL4by4dZKYm2V6CCKOdkjqxYVGW7Q62UmTjNWDk1T1r+i8NQY=@lists.denx.de
X-Gm-Message-State: AOJu0YzFiLmQm8PhEdKVO96eugTd829gHV9A0rGR32vKRAsq3yZYh1qI
 D6HX6NEsi2s/3x3EYvl24b07CStgGAawbewHKHJB50/C07kBRfZoF34a
X-Gm-Gg: AZuq6aICwmUjVwM2PvhlbbGbTwPv7zAkv7frFUPdwz9yUiborFCSzBySBXB/BVf6Ijb
 NJjZEZUvmIKZo0pAJ0QNR9FTVgohLFWtGNgTnjCVkCITrk/9gxtTTbFqelrToH6YzQwUxfYNb2O
 OIodjP9zYJqzb/ifQCf06w6NfzkBCfIZT+HUGHmRrGds7p9A4jLJpvjgtC95d4DLAxzE9oiMptg
 VOTnaeDMEo3D8//9dscSYeiqRmfopf9ZuiUdSNDEcJ36Hu8qWZ73YD9vOERqokuotXQVWH5L0HJ
 ja0LMsIYreT0cYLDTua4x3BPcxmDGTaK6iECm3wCXxFEu20J+ZofszhSHdTf5Edp4D2wTihZD6D
 Z0dTX88Ucw7l79ayeTXsW1m6suweEGq2uTkgpo+vW8vZ+w7Ji5ZRhYSdhhRqSBydIe+8UlwgXfa
 iF/Zv8KBmn8Jg0idil5nSEYvnAfpxeV72RzPMfbIRFenA=
X-Received: by 2002:a05:600c:1388:b0:480:25ae:9993 with SMTP id
 5b1f17b1804b1-4832021477dmr114771915e9.20.1770637525964; 
 Mon, 09 Feb 2026 03:45:25 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-125.ip49.fastwebnet.it. [93.34.90.125])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436296b20fasm26297380f8f.6.2026.02.09.03.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 03:45:25 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] net: mdio-mt7531-mmio: improve parsing of switch register
 on probe
Date: Mon,  9 Feb 2026 12:45:06 +0100
Message-ID: <20260209114515.1916-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209114515.1916-1-ansuelsmth@gmail.com>
References: <20260209114515.1916-1-ansuelsmth@gmail.com>
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

The MDIO node is ALWAYS a parent of the MT7531 switch node and the MDIO
registers are in the MT7531 register space (in the context of MT7988
it's all memory-mapped)

With these assumption, we can simplify and permit better usage of PHY OF
automatic probing by binding the mt7531-mdio-mmio driver with the MDIO
node instead of the switch node.

For OF PHY to be correctly autoprobed, the MDIO driver needs to attached
to the MDIO node (the parent of the PHY nodes).

The driver will reach the parent node (the switch node) and will parse
the register address from there.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio-mt7531-mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio-mt7531-mmio.c b/drivers/net/mdio-mt7531-mmio.c
index 58cb6e503b8..930454a9b0e 100644
--- a/drivers/net/mdio-mt7531-mmio.c
+++ b/drivers/net/mdio-mt7531-mmio.c
@@ -149,8 +149,13 @@ static const struct mdio_ops mt7531_mdio_ops = {
 static int mt7531_mdio_probe(struct udevice *dev)
 {
 	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
+	ofnode switch_node;
 
-	priv->switch_regs = dev_read_addr(dev);
+	switch_node = ofnode_get_parent(dev_ofnode(dev));
+	if (!ofnode_valid(switch_node))
+		return -EINVAL;
+
+	priv->switch_regs = ofnode_get_addr(switch_node);
 	if (priv->switch_regs == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-- 
2.51.0

