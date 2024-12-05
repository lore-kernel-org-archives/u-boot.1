Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF2BE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07C58952B;
	Thu,  5 Dec 2024 14:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EIC47HxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088E889512; Thu,  5 Dec 2024 14:54:50 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0BF87BF4
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58E4D4000C;
 Thu,  5 Dec 2024 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AnVZjM/OW2i2BOPx5DIcGJU7sxSDlJa5cOyQEliPv8=;
 b=EIC47HxW1wvuHcIkFoU3p84oO/Mjmx94WiL/zoCwFifR+ja9y/or2rPC/L0B8fgU8v1kYo
 MpPKagybmaUky356LVmbIQPBfH/7+31CyZELM0JGMnQ6h9Jl4pqbS6pNVeY2XBea26Whgd
 3SewRccmnX0aWxH7TiV0M3AVPqMfGKnVyp13IdrZZtPH5Eq7k3X38t3u5fNnfMtff7vvXJ
 w9l9WcYhoPIy0ZgyC3hsPbaaBMt+SF9CM+GtW6DKGE0mzWFFHx2BoWokaQEOB21BzAwxDb
 3wt/iY7X9cNYG91WZMlUOlke615ovJ14sHFhjGbom7BauxnRtsG1k4L2Q038pw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:09 +0100
Subject: [PATCH v2 03/13] sandbox: Add a fake display controller and link
 it to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-3-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

Use a graph endpoint representation for that in order to test a new core
DM helper going through these properties.

Display pipelines typically include graph endpoints, but the helper is
generic and would work with any device type. We do not bother with
creating a display controller dummy driver but instead use the default
testing placeholder compatible.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/sandbox/dts/test.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 36cfbf213e4cfe17d9ca98d6e40f7caf95631254..983a94d1e8c26f9bcb5fa05449705ff1a84a0d48 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1359,6 +1359,32 @@
 	panel {
 		compatible = "simple-panel";
 		backlight = <&backlight 0 100>;
+
+		port {
+			panel_to_dispc: endpoint {
+				remote-endpoint = <&dispc_out1>;
+			};
+		};
+	};
+
+	display-controller {
+		compatible = "denx,u-boot-fdt-test";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				unused_ep: endpoint {
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dispc_out1: endpoint {
+					remote-endpoint = <&panel_to_dispc>;
+				};
+			};
+		};
 	};
 
 	scsi {

-- 
2.47.0

