Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2A2C0218F
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2C781276;
	Wed, 29 Jan 2025 11:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oa7S8PQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530E781F32; Wed, 29 Jan 2025 11:22:14 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841C780FA6
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 844BF43188;
 Wed, 29 Jan 2025 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1738146129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVD5sHnIpAI9ZC+Mu2/Pl1CJxa/RtGELqDFn9Ad+1og=;
 b=oa7S8PQEg6pwxUfL2uurTSCGG35iX6j1xyWI6PMnxh5pv3N7H28PjEzSg0xpvMvmuhPe1S
 iF8OUJsBYhwS8T7QWmeKIu82gSSE4LMQy76+L3zuhGo339M1N9BmFmXZKyJI8WdaPhOSDZ
 oNJbFSE/DlfRtMh6j7YILEyPrzOs93sgx/PsVLFPyp2aayXi1tyxKWO37S3YfLhTI2/L8l
 SX5ZI+sO7hVkQHCSXvjB8ewEKizAd+5rNSDmZoutdVa5dOsbnZRyTvpNy6sz4njFjKToXb
 YrbhM4OWH2iCni99SX/Hm/Hta+mkLmEkdacJVE/Xbg0L+tIuNPEqAZpdCO5KJw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Jan 2025 11:21:57 +0100
Subject: [PATCH v4 03/12] sandbox: Add a fake DSI controller and link it to
 the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-ge-mainline-display-support-v4-3-a43b3657ed7c@bootlin.com>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
In-Reply-To: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghin
 hgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
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

