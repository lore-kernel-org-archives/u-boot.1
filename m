Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418BCC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A87C480708;
	Thu, 16 Jan 2025 05:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000345;
	bh=IHbO24qvfWZnzZh/J2vu3pGzBhcWxpM7ee5+p3QUeFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FMZRDLFBJehlLDl2zRVaJDfMRtUVYyGbO4B30eKNNNHkZg8EkdAribRRhUoVjgnuL
	 hANjDWjluXb5SvIL3+Py+pAoIdXJHDN9R1avX6jKs9lBkAtXmjyE/nbhxcRDNyPUHy
	 y+Z3H28FKqCEFC+zgThNYI+uhNGTk4bZ85hquQVMZBH9nCprjTTYvSZ7QtO/4SP3Rm
	 xQTQ/3tS36dnwkDe6UR169AAvcsLaAycHi1pbFCXGs5aEl5ozkwbMDbWPu67GqnwBT
	 QHUfDSMiJHaBhKlQCokLxgb691EN8ud3Y8Bh/4RLWPLgfr1xy/xsWGtcJMe5XJQPbH
	 YJZFnfeLVp7Ag==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 257B180756; Thu, 16 Jan 2025 05:05:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E6180708
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="flFPenEh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2E3171040DBDB; Thu, 16 Jan 2025 05:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHbO24qvfWZnzZh/J2vu3pGzBhcWxpM7ee5+p3QUeFs=;
 b=flFPenEhP95A8yWpdWmns8GsXj2ibRL+9HPrzn8kf+f9/0E60B2M54xy6JZ58VHd6uUuzh
 s3vkP1BZDZED6LAJMPjMG1Gx3e3jtCEw/kjjHrqeL4mv7aYf7/qS7ESlNednlDxLuDIQLj
 pYqvxxwgs1H4+XYuBDjhwYJotZiSHZs1S3h7tbniwYXl9FaZ5JTDE41iWMouqYJ/ayBG4e
 iYFWqaQkWG39ckRYBW1idkv+kE/g4d6+EayZmXEvzh6OcKlxuLOqYKredWvwYod3ynGUOs
 6WcSbIgQNhLmvJ1ONbCaO95NGCbTgv3EwK8TJtAF5GbDRVg+QgVUoYC73VznVA==
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
Subject: [PATCH 05/13] net: fsl_enetc: Rename the driver and related structures
Date: Thu, 16 Jan 2025 05:03:22 +0100
Message-ID: <20250116040449.306098-5-marex@denx.de>
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

Rename the current driver structure and matching ops and PCI IDs
and add _ls suffix to indicate this content is LS specific. This
is done in preparation for addition of i.MX95 ENETCv4 which will
require slightly different structure content.

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
 drivers/net/fsl_enetc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 615646b76a3..639853539a1 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -689,7 +689,7 @@ static int enetc_recv(struct udevice *dev, int flags, uchar **packetp)
 	return len;
 }
 
-static const struct eth_ops enetc_ops = {
+static const struct eth_ops enetc_ops_ls = {
 	.start	= enetc_start,
 	.send	= enetc_send,
 	.recv	= enetc_recv,
@@ -697,20 +697,20 @@ static const struct eth_ops enetc_ops = {
 	.write_hwaddr = enetc_write_hwaddr,
 };
 
-U_BOOT_DRIVER(eth_enetc) = {
+U_BOOT_DRIVER(eth_enetc_ls) = {
 	.name	= ENETC_DRIVER_NAME,
 	.id	= UCLASS_ETH,
 	.bind	= enetc_bind,
 	.probe	= enetc_probe,
 	.remove = enetc_remove,
-	.ops	= &enetc_ops,
+	.ops	= &enetc_ops_ls,
 	.priv_auto	= sizeof(struct enetc_priv),
 	.plat_auto	= sizeof(struct eth_pdata),
 };
 
-static struct pci_device_id enetc_ids[] = {
+static struct pci_device_id enetc_ids_ls[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_ENETC_ETH) },
 	{}
 };
 
-U_BOOT_PCI_DEVICE(eth_enetc, enetc_ids);
+U_BOOT_PCI_DEVICE(eth_enetc_ls, enetc_ids_ls);
-- 
2.45.2

