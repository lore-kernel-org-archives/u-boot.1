Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD0FC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A1280740;
	Thu, 16 Jan 2025 05:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000347;
	bh=E0hwmpns7+PbyXrw9xbCzZxIxvoiFq7pAh4jqDA9ywc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXIMMTVCymCBPlMu+5T5DXZrM1OSgXpIsprVZIPVnS6ZmzwBdSn4b72VvFRrlqfNx
	 BtUFd6XgG7g5FakfKM4KbW6l6yWwNslf85dx+ib1AMWX9gV5a7oL95DAkgTAcx6R0d
	 MKEWRdn5olqCInOvt4Rax05Tnj2OH2qo3HS7CepEjTwpD1pKGgTlKCgGFnCc7ROnMn
	 iRQOW9p82IC/24YJ9MTE725LIv8OoqwsrUGlG+ye0sqyC7ucJYmVpOMRkRqcC/GGWm
	 DnL98uVIgbGYdPdQljCQEliYU4yY22ZjvkdGyGD62iOcJzgqloylfwYkeNzZOGsFk6
	 o61nsmbvv5EkQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4622B80658; Thu, 16 Jan 2025 05:05:45 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D43B80713
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QbFG3vfG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C11B01093C3BD; Thu, 16 Jan 2025 05:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0hwmpns7+PbyXrw9xbCzZxIxvoiFq7pAh4jqDA9ywc=;
 b=QbFG3vfGdrBvi22Hs4QLLM9J7Oc9PH9oB5Cx42ulOU8E53KPftMCtu+hI4tWS+z23qCVH9
 0MQJ5OpohkZYTsUGa7X/E66+OIm+crHlrLaw49kThUm/hxSDbeo5dLIaIpE+W5kF9u8oWN
 IYR7cdtUxJL2I2Zz/OhyvSIIr/UFG/6UYK2UtiH5aiwI9G6PlA0nLngJPdYq8/ezGKegp5
 l6A86IZ1j9Oh5iDXoE328YLXe0dNdmx7BpjRNwB5X/HjwFjk1eFRA8nK+CGQGEz9b3mgOL
 wWvfg4N4dtsk5r8IGZ/j2XKK4RxUNk1WxAbd6OIq6atjGkrpGq84dLdruz6qwQ==
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
Subject: [PATCH 06/13] net: fsl_enetc: Introduce enetc_dev_id()
Date: Thu, 16 Jan 2025 05:03:23 +0100
Message-ID: <20250116040449.306098-6-marex@denx.de>
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

Introduce mapping function enetc_dev_id(), which converts PCIe BDF of
the ENETC into linear incrementing index usable e.g. as interface index.
This replaces the current ad-hoc calculation used in the code with a
dedicated function. No functional change.

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
 drivers/net/fsl_enetc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 639853539a1..e6f5ca633aa 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -32,6 +32,14 @@ static int enetc_is_ls1028a(struct udevice *dev)
 	       pplat->vendor == PCI_VENDOR_ID_FREESCALE;
 }
 
+static int enetc_dev_id(struct udevice *dev)
+{
+	if (enetc_is_ls1028a(dev))
+		return PCI_FUNC(pci_get_devfn(dev));
+
+	return 0;
+}
+
 /*
  * sets the MAC address in IERB registers, this setting is persistent and
  * carried over to Linux.
@@ -109,7 +117,7 @@ static int enetc_bind(struct udevice *dev)
 	 * PCI function # and enetc#N based on interface count
 	 */
 	if (ofnode_valid(dev_ofnode(dev)))
-		sprintf(name, "enetc-%u", PCI_FUNC(pci_get_devfn(dev)));
+		sprintf(name, "enetc-%u", enetc_dev_id(dev));
 	else
 		sprintf(name, "enetc#%u", eth_num_devices++);
 	device_set_name(dev, name);
-- 
2.45.2

