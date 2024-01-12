Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF93C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2A1879B5;
	Fri, 12 Jan 2024 09:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bosEyozK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629AD879A0; Fri, 12 Jan 2024 09:53:24 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45267879A8
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705049598;
 bh=n1j+uEkFXm2GIie5novKjMLhQ2xL9NgtdA63X3G2GBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bosEyozKWSlz/7SdK6F/mJbZcnf2QKykPfLM/KI/DbKrZSrhasdPV2eaLgKMDA4Ds
 o1EDieXQxVJrWc3LTH/lP+Rh62h5qMWYeAleA+M0jPqXL/33jN/FL04uQHqTYp4m9O
 TXuJlaBgCmUI96d0Ztj7zq6dB7bYbJ4Z8PCSjEnuaHeLWrpvYWDLd8N8GV+CIro0tm
 h8VQLi8eyhmKBibkIraR4GM/Yk2wq3eZHZyDC5/JqBCiKPFp/eEWnvtGRCW3ZGgxVj
 Q9NfJopTdC7woGhx3PjZYmoNi11fMvUAWmvgHIAqzqLec5NILpmZTpkZjWyjOWNmv6
 bkRknxg2bWbUg==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 857583782031;
 Fri, 12 Jan 2024 08:53:18 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 2765C9ED7CD0; Fri, 12 Jan 2024 09:53:18 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/7] arm: dts: k3-am625-sk: Enable usb port in u-boot
Date: Fri, 12 Jan 2024 09:52:19 +0100
Message-ID: <20240112085317.1866449-5-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112085317.1866449-1-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
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

Enable usb0 in all boot phases for use with DFU

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v4:
- Don't force usb0 into peripheral mode

Changes in v3:
- Enable usb nodes in all boot phases

Changes in v2:
- Only enable usb port 0 DFU in SPL

 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index fa778b0ff4c..67c9fa2bbc3 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -46,3 +46,11 @@
 &cpsw_port2 {
 	status = "disabled";
 };
+
+&usbss0 {
+	bootph-all;
+};
+
+&usb0 {
+	bootph-all;
+};
-- 
2.43.0

