Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA06EC25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA5A88616;
	Mon,  6 May 2024 16:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Du6wyN5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED54D885E3; Mon,  6 May 2024 16:39:05 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F4987EDC
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715006343;
 bh=/6tAP1AY4HJSN6Wi3r7drHvLJih7ShAEojUmWF7vFw4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Du6wyN5QXfmFyVznZYygeb4ElAxvrmDCTStewS5ItmhFUEnZfqMYadMORpRfIsn9L
 8K2SJH69Omq5NxURAt0Oc/Ox+XbPASjnIfNTlLyGGpckBTn1AM26qZPNWSDbG+rIaC
 buPWeEcNLRk3097mT2Q2YpWyeLh33hWttOJrm/iKVsgSB5vTPaFss5eiV07A1u1I0O
 XHYAgxxiyhtKYcOVBLPHgjlavo4H7Tpo2OpNbr5pM82GxzdXM6rfkVl1mnPfNL68Sp
 dUnvo04Mk33sSwnnZG2H5pd1+9nuOFIhVTHrMYIS+UCFyazpmbiMQLcLpayG4NFJR5
 pNsKO/1Ic1WxQ==
Received: from pan.lan (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com
 [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 41F003782140;
 Mon,  6 May 2024 14:39:03 +0000 (UTC)
From: Martyn Welch <martyn.welch@collabora.com>
To: Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v5 3/6] arm: dts: k3-am625-sk: Enable usb port in u-boot
Date: Mon,  6 May 2024 15:38:43 +0100
Message-ID: <20240506143846.1252377-4-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506143846.1252377-1-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
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

From: Sjoerd Simons <sjoerd@collabora.com>

Enable usb0 in all boot phases for use with DFU

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
Changes in v5:
- Forcing usb0 into peripheral mode reinstated

Changes in v4:
- Don't force usb0 into peripheral mode

Changes in v3:
- Enable usb nodes in all boot phases

Changes in v2:
- Only enable usb port 0 DFU in SPL

 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index fa778b0ff4..1fc0d407cb 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -46,3 +46,12 @@
 &cpsw_port2 {
 	status = "disabled";
 };
+
+&usbss0 {
+	bootph-all;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	bootph-all;
+};
-- 
2.43.0

