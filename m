Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA58BCA0EF7
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA2588DA9;
	Fri, 30 Aug 2024 11:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KBCzyxoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A7888D9A; Fri, 30 Aug 2024 11:10:20 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C4B88D08
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009018; x=1727601018;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iy88FAp4yyUnPgpBHzLxea0RFBOYXAHeNTixwYjsfaE=;
 b=KBCzyxoierya3Br87nQ2TkVf2GHewwyxlftCEGRh5yWKjK+PxyS4pTt1/UEKxyJv
 Qe/oSrqFQULPYXTZNuTmalsAZrnNcXeY8nMCWxwaX8H1xoRzpn/S+QzShWH/Q6Yi
 /7wPPcY2Nl4Oh7rmpHEgmkTJi4oAYL83+pz8mbNqxRk=;
X-AuditID: ac14000a-03251700000021bc-49-66d18c7a9514
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 37.52.08636.A7C81D66;
 Fri, 30 Aug 2024 11:10:18 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:16 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 13/13] configs: phycore_am62x_*_defconfig: Set PHYTEC as
 Manufacturer
Date: Fri, 30 Aug 2024 02:09:40 -0700
Message-ID: <20240830090940.2592157-14-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBR7eq52KawcxeJYtPOx+zWkydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx/Uz25kCWKK4bFJSczLLUov07RK4Mq417mAu
 +MxVMfP3KqYGxhucXYycHBICJhKbDz9g7mLk4hASWMIkMethIwuEc59Roq/1IQtIFZuAlsSd
 LXOZQWwRgSSJXU+WsYHYzAIuEotvfGAFsYUFQiW2z5kLFmcRUJVYcGEyI4jNK2AtcfXXYxaI
 bfISMy99ZwexOYHim78+ALOFBKwkjk87xwZRLyhxcuYTFoj58hLNW2czQ9gSEgdfvGCGqFeQ
 mL0NYj7IzGnnXjND2KESRzatZprAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9gozKktRk
 vZTUTYygQBdh4NrB2DfH4xAjEwfjIUYJDmYlEd4Tx8+mCfGmJFZWpRblxxeV5qQWH2KU5mBR
 Eudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamBcm7iQd7HEZpP3US6FVQLRL+/tCOwMimOcW77z
 hIxViXiRyM+Lj+Y9XLeqd87vjZtWWe3+Pv2g0+Tz/+vP5sqf2LxY2/LKz6zI72HTuZxmpO2w
 OHpW6hfHz+bQ2fe/qP9zqZ1y/oTKzuqvLt93CFcy3HP5Nm1hnehvhYa3Z3wXJP4y+eH+9u3U
 VUosxRmJhlrMRcWJAFWW5f9iAgAA
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

Commit 371b379edbf3 ("configs: Make USB_GADGET_MANUFACTURER
consistent over all PHYTEC boards") made the USB_GADGET_MANUFACTURER
value consistent over all PHYTEC boards.

Update the phyCORE-AM62x defconfigs to make this config consistent
as well.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig       | 2 +-
 configs/phycore_am62x_r5_usbdfu_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 246b8743da0..5a1aa52c1ba 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -151,7 +151,7 @@ CONFIG_SPL_USB_DWC3_AM62=y
 CONFIG_USB_DWC3_AM62=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Phytec"
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/phycore_am62x_r5_usbdfu_defconfig b/configs/phycore_am62x_r5_usbdfu_defconfig
index 237f5d344ce..1c05950dddf 100644
--- a/configs/phycore_am62x_r5_usbdfu_defconfig
+++ b/configs/phycore_am62x_r5_usbdfu_defconfig
@@ -1,2 +1,3 @@
 #include <configs/phycore_am62x_r5_defconfig>
 #include <configs/am62x_r5_usbdfu.config>
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
-- 
2.25.1

