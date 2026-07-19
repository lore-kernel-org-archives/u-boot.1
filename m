Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C9CC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E50584A60;
	Sun, 19 Jul 2026 20:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O8qy2Ssk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rw+pJ2KF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5AF84A29; Sun, 19 Jul 2026 20:13:14 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7800884A4C
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h3BbD1y9Vz8tyV;
 Sun, 19 Jul 2026 20:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j84fbVmbxU+v7iCd/HR66BesVHJFplgomcFUiorWIdY=;
 b=O8qy2SskCdIzxIvd7vFtsA6WCP9+d+50pzK/XL40PiO9DZdauhNwyusS2f5kKwuASvc67R
 DOP1DwPIRh2bQiCVCmfyj62KULaA7ro2Hf2ivgevx6wEQBRK5PHb8FJGp06KxexCl5KKOA
 /VE5+Ee9hioLAojbriBm+4skCa/dP6hAV94W5C7Z4zVXfC2+YTmoQR25X9iutNddJbz+rI
 z+A1qscMIahgTcylr9m4Dc78CKmH88rEAJaXtrdpAb/7dmX8HQq+bEI2QD1wqDM6znZSGj
 /Y9XMz4K8op4xRMfzqti81mCBB/btvdLywuOGhfRsNuttewpSV9qt53qTH8LZQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=rw+pJ2KF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j84fbVmbxU+v7iCd/HR66BesVHJFplgomcFUiorWIdY=;
 b=rw+pJ2KFqjTr5CpZi2v0fBk17QvBzBlJ5xuSY7knr/OK4DCRpicb5m0rrDvZO/WX5Btr7P
 BBZsVX/Z84ElpzJvmVZouXNwqx0sPvc08Uqzb0IB99oM+VmZFvJFNj3btRMxSnti6lQWgi
 6fWhOMajUGJowO+HuUyoGqd0hF+QxQXm4x0shtxITg1lnMXJde2/xkyxnXbf66WbpoqCVW
 XI1QJP/AIjIpD37d6Tw/Mq2kT6o/W3a4x9twTMLXprmrWOd0OE8RHd8dAjz7ewlpur9fiz
 G+ZExgIsrrsoIGh9sK87oGJusZN1i9bUHNYKEz7E/Xc3i58nxUsFtDyTd/Pc0w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] pci: pcie-rcar-gen4: Handle always on reference clock
Date: Sun, 19 Jul 2026 20:11:50 +0200
Message-ID: <20260719181303.245004-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
References: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fb52d615970e85ada71
X-MBO-RS-META: 9k441wpo9auficqn17kt81ze9o3mz3ry
X-Rspamd-Queue-Id: 4h3BbD1y9Vz8tyV
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

The clock controller driver for the device which supplies reference
clock to the PCIe core and bus may not implement .enable / .disable
callbacks in case the clock supplied by the device are always on,
in which case the clk_prepare_enable() call returns -ENOSYS. This
is the case on e.g. 9FGV0441. Handle the -ENOSYS as a valid return
value and proceed with probing.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index e165271f58c..8c5c8095c73 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -451,7 +451,7 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 		return PTR_ERR(rcar->ref_clk);
 
 	ret = clk_prepare_enable(rcar->ref_clk);
-	if (ret)
+	if (ret && ret != -ENOSYS)
 		return ret;
 
 	ret = gpio_request_by_name(dev, "reset-gpios", 0, &rcar->pe_rst,
-- 
2.53.0

