Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C89E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 18:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59ACC8060C;
	Fri, 10 Jan 2025 19:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DNScpOgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE2C8069D; Fri, 10 Jan 2025 19:43:07 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C008060C
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 19:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BA9F60010;
 Fri, 10 Jan 2025 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1736534585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVD5sHnIpAI9ZC+Mu2/Pl1CJxa/RtGELqDFn9Ad+1og=;
 b=DNScpOgVadioI1hNGd56hpprdcvNL5Towme+XJkIXOb4HTmsHAtSrW3dws6qpOIC5g8T/O
 lTzdTL8Qw/aJaLa8XbigjpoqHzrV13/HMCxkJENRgG5P37mxZr5g8l8ZtDARezV1xt4YzB
 3MrOuca769mA00RhUk3uuUCRat00IN09rtvYI4VVx/iHbxOcDmDohPLOXi+s83Em6wpPNp
 Eq5cbDh/DaYEMVjYqDp51LjiPxLs2qAKUPtja+tUDqzhWTN9yI5f3mr9M7ePSCopMA1gkj
 zzeE151ToPmvP6LYbSto/bSNaf0qlnzqwHdAl5ry3a+yq8DFBZhRdohik3cVPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 19:43:00 +0100
Subject: [PATCH v3 03/13] sandbox: Add a fake DSI controller and link it to
 the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-ge-mainline-display-support-v3-3-d2c0acea6feb@bootlin.com>
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
In-Reply-To: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
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
generic and would work with any device type.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/sandbox/dts/test.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 36cfbf213e4cfe17d9ca98d6e40f7caf95631254..f7d4d9824454207f2d4650739e43a36e4936ef9e 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -295,6 +295,23 @@
 
 	dsi_host: dsi_host {
 		compatible = "sandbox,dsi-host";
+
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
 
 	a-test {
@@ -1359,6 +1376,12 @@
 	panel {
 		compatible = "simple-panel";
 		backlight = <&backlight 0 100>;
+
+		port {
+			panel_to_dispc: endpoint {
+				remote-endpoint = <&dispc_out1>;
+			};
+		};
 	};
 
 	scsi {

-- 
2.47.0

