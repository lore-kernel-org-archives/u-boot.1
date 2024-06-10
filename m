Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8949C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB7C8857F;
	Mon, 10 Jun 2024 15:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KzSGj2zV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428DC88581; Mon, 10 Jun 2024 15:34:15 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C5188546
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026450; x=1720618450;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cf4BNj9y5kogbO0R70DzYRbIM3avyCXqhT1bYyIWJ6Q=;
 b=KzSGj2zVf4cKc6Ufmbqmd0QT7jM3xVFOaEtDpudwQKuwcf1lFHKqXwKVf/aQnFiG
 ItGaU9BJyeD6QqNoTLplvQRQB8X7lSyyUkVaolko0POUkOVeh2AHnWYIngA+Qetj
 Nt8bYGAUCZ0Z+kyZA27VF9hfp4Pv9cJnS24W4ilN0us=;
X-AuditID: ac14000a-03e52700000021bc-eb-666700d265ad
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 47.7D.08636.2D007666;
 Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:10 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 07/13] arm: dts: k3-am625-phyboard-lyra-rdk: Enable usb port
 in u-boot
Date: Mon, 10 Jun 2024 15:33:46 +0200
Message-ID: <20240610133352.2473414-8-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWyRpKBR/cSQ3qawdeZihYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 uHZhA0vBCtaKf683sjQw7mHpYuTkkBAwkTi49hI7iC0ksIRJ4tZJvi5GLiD7MaPE78YnTCAJ
 NgF1iTsbvrGC2CICQRK9lz4xgtjMAh4SW/9uAIsLC4RJ3F16gBnEZhFQlfh98DjYUF4BS4kd
 yzqglslLzLz0HSzOKWAl8WPNXlaIxZYSiz6tYYGoF5Q4OfMJC8R8eYnmrbOZIWwJiYMvXjBD
 1MtLvLi0HG7mtHOvmSHsUImtX7YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5BRmVJ
 arJeSuomRlDAizBw7WDsm+NxiJGJg/EQowQHs5IIr1BGcpoQb0piZVVqUX58UWlOavEhRmkO
 FiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGRs/Xyrdc/l9xeq2+aXf/KVX+D1m5X1peB90z
 0edSeLvzyWtXpjjVzGWa8pd9xedf/nrvPFdmrm3YLo8Li1bJvPgcveyQk8iE+xm9h6xEjrPb
 T13lsU93+W+7xtTzla97Y53Drro93bJ8d1KJi+DUgLibi4OXaK44aZoqW3o+ufNuQZb2m/ff
 JiuxFGckGmoxFxUnAgAe/0PcZgIAAA==
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

Enable usb0 in all boot phases for use with DFU.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index 7c76acc0d59..2bc5acbec23 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -168,6 +168,15 @@
 	bootph-all;
 };
 
+&usbss0 {
+	bootph-all;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	bootph-all;
+};
+
 &vcc_3v3_mmc {
 	bootph-all;
 };
-- 
2.34.1

