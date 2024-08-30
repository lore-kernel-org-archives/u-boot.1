Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D3DCA0EF9
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF8588DBB;
	Fri, 30 Aug 2024 11:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GdiWLEMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B961D88DB3; Fri, 30 Aug 2024 11:10:16 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E605088DA2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009014; x=1727601014;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=djec8zNkhVW0t6r+wHhGLkwiDksmJijHyYlHB9XoXmI=;
 b=GdiWLEMMNbY1SYIE3Td5WI3VlLKug0HtavTPWBfS/5do02C77OjWMMLundc/SKtR
 9W6dSujO+HeXaCo2zAUleyd9klpJ2IA4Dxuydlt5PjeTDMvtsZG4RZZx4atvMr36
 uTFgAk78b0OQR45GVtJzK3zRiASMJHzpAZUdTEnEVWs=;
X-AuditID: ac14000a-03251700000021bc-3d-66d18c7665eb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 53.52.08636.67C81D66;
 Fri, 30 Aug 2024 11:10:14 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:13 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 11/13] configs: Add phycore_am62x_r5_usbdfu_defconfig
Date: Fri, 30 Aug 2024 02:09:38 -0700
Message-ID: <20240830090940.2592157-12-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBR7es52KawY7FJhafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZexZeIO1
 4DdbxfJnp1kaGJvYuhg5OSQETCSmfH3H2MXIxSEksIRJ4uK2k8wQzn1Giad/NrGCVLEJaEnc
 2TKXGcQWEUiS2PVkGVg3s4CLxOIbH8BqhAVcJZbtOMEIYrMIqEp0dnaBxXkFrCWOn33ODLFN
 XmLmpe/sIDYnUHzz1wdgtpCAlcTxaefYIOoFJU7OfMICMV9eonnrbGYIW0Li4IsXzBD1ChKz
 t01mhJk57dxrqPmhEkc2rWaawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U
 1E2MoEAXYeDawdg3x+MQIxMH4yFGCQ5mJRHeE8fPpgnxpiRWVqUW5ccXleakFh9ilOZgURLn
 Xd0RnCokkJ5YkpqdmlqQWgSTZeLglGpg9D64LfiTWeMurvsh65032c4+I63Vt2C/2xOWF+9e
 yvnzXn9y8MKW3oeOV0oEDrosWxfG9iDC99fJw3dy2yRiElOX9v2yO1pxt5VHZiXj0zOKLpfc
 OC9fSj7Rmh0q4FaTmLS8LHnj/9dNZa4/c9SXKkgrHLqj3lbC43GLeVlZlIRfCUuqzwNRJZbi
 jERDLeai4kQAiQ9KLmICAAA=
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

This config includes the phycore_am62x_r5_defconfig file as well as
the am62x_r5_usbdfu.config fragment. We need another defconfig
because the AM62x has not enough internal SRAM to support all boot
sources. The normal phycore_am62x_r5_defconfig should allow to boot
from MMC and OSPI while this new defconfig allows to boot from USB.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_r5_usbdfu_defconfig | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 configs/phycore_am62x_r5_usbdfu_defconfig

diff --git a/configs/phycore_am62x_r5_usbdfu_defconfig b/configs/phycore_am62x_r5_usbdfu_defconfig
new file mode 100644
index 00000000000..237f5d344ce
--- /dev/null
+++ b/configs/phycore_am62x_r5_usbdfu_defconfig
@@ -0,0 +1,2 @@
+#include <configs/phycore_am62x_r5_defconfig>
+#include <configs/am62x_r5_usbdfu.config>
-- 
2.25.1

