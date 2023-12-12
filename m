Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6356C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 21:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C0F8760D;
	Tue, 12 Dec 2023 22:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="H8px/9KE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFBFF877C2; Tue, 12 Dec 2023 22:02:39 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED4D874D0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 22:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1702414955;
 bh=46g6zvckFSGMigzL/oV3JCK/hBwoA9GDsAhelO0HHY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H8px/9KEojTF2iXlsYymqSZbAbOkfY+nqe40VsvWeEB8j6gfpucAkfih/nK+ruBkt
 5laHutsGXCCwXfIs1yG9mfNmWoZ7KDsRGF74ih2d2rlHXYZfRGeKGdsocgy7aeXThV
 vXNI8nPfh5joDdx6TFH/Kvnbryn+rIh2DvmWC67+vo5Zr8rqTgVXD9hdOiANkAaUz/
 VdFqD+FNqeGfsQ0rIk8+jZPcONJ7437/3fCQsDap/oJphsGAk60068WED/BQqT/YV5
 /HK6w5WemTZivlImArkiR3Oc+wjXeDmnSlFLmApD2o245PKlHbL7gloJiVg7crPFzp
 fsLJ0orTXEeiw==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6A2323781478;
 Tue, 12 Dec 2023 21:02:35 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 09715984A543; Tue, 12 Dec 2023 22:02:35 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/4] arm: dts: k3-am625-sk: Enable usb ports in u-boot
Date: Tue, 12 Dec 2023 22:02:23 +0100
Message-ID: <20231212210234.509309-4-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212210234.509309-1-sjoerd@collabora.com>
References: <20231212210234.509309-1-sjoerd@collabora.com>
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

Enable both usb0 as a peripheral for use with DFU and

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v3:
- Enable usb nodes in all boot phases

Changes in v2:
- Only enable usb port 0 DFU in SPL

 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index fa778b0ff4c..1fc0d407cbf 100644
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

