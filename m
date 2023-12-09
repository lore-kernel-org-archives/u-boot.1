Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B80C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4BC8744F;
	Sat,  9 Dec 2023 19:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="gllYQa+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6C9875D6; Sat,  9 Dec 2023 19:05:52 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444A287215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336166b8143so602607f8f.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702145149; x=1702749949;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q7tyX5GW+vxZId60pQjxYqy8LGZfH/FGEXCxeotPuDo=;
 b=gllYQa+zGaSKczvOtuqNAekhS4N5kXJ5BGX/3110h4wn11bvuDEOscD2iqaNEJ3RwS
 MexDeJwCKBvQrgB5vHt2AL/9akVkpK9hbVvt39TdBmiG8d3Z+jYGCh2T7s3O9K6pfOFu
 eZjK9uSyzcsUcvGaOK1dOc9k5cXo2ualCYH1Syg4RLqFHd/57IDHAN2xlI0ZCT79scRC
 R7IaA7Ut6eWSpeM1blc1HTzQ7hlN/st66MyIVvt0RypafdTRl5bimCgFlRkmQ7LE16Na
 NdAM9Ahw8Jkx3lCPmJlGZl8MTEgp5GYh292il2+pLN9Fuwm9uMLk9a+Q0cHdpRHU10OT
 U65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702145149; x=1702749949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7tyX5GW+vxZId60pQjxYqy8LGZfH/FGEXCxeotPuDo=;
 b=aUchy5WV5GwJtRWPg3BukKjeYQFYOV0lirhWpw76tu5RvnRlNDQt3ckafsGQ5cPJpe
 aYsn/8iYYor6Coz7GoyVS19Q2WyvK7IAIvtEBTimr8gFiB9G3beP5jWQhbvJrFC+qanH
 8vk+g5BMSh+cjRkR1p2cv7obOEub2bfRdeOiHuTtHy0eaRtEuGjwLksbvoCoT92zojFf
 pSpLTD6xqtuNMvyQGvtJzpqNTCc6Q9/0SNcGmH42rCS8RXDWN8MIWvAZxprclbrwX62F
 wpsqtmr7v1CmuOB8cVF/pgMavSkt49v5wXjt+50oTUdxCQ61LXFePEvpaRvhYfj5rww4
 uN/w==
X-Gm-Message-State: AOJu0YyNZWP9VxicE9v8KMRRuA+Y9O9qknue9oHLp+/JfCm0aWCERW9C
 1a6NiU3tklL8i+NJSlY7z6/Psw==
X-Google-Smtp-Source: AGHT+IE+zt0sz0znxe31ZF3hRFaS4nHBq5aZ0qpPe3JHT+4SwQFepj0dWxVWnsezDd6u2uxBdRRjZA==
X-Received: by 2002:a5d:540c:0:b0:333:4a10:ddc8 with SMTP id
 g12-20020a5d540c000000b003334a10ddc8mr884272wrv.110.1702145149513; 
 Sat, 09 Dec 2023 10:05:49 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 h14-20020a5d548e000000b003333fbb68c7sm4762541wrv.112.2023.12.09.10.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:05:49 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: marex@denx.de
Cc: clamor95@gmail.com, bmeng.cn@gmail.com, Shantur Rathore <i@shantur.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3] dts: rockpro64: Disable usb regulators-always-on
Date: Sat,  9 Dec 2023 18:04:37 +0000
Message-Id: <20231209180437.330969-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

USB port regulators should be controlled by PHYs
so we remove always-on property and let PHY manage the
regulator.

Typec port has misconfigured phy-supply in upstream and
now that we are removing always-on, we need to fix the
phy-supply until its fixed upstream.

Signed-off-by: Shantur Rathore <i@shantur.com>

---

Changes in v3:
- Split up patches as seperate series

Changes in v2:
- As requested, added fix for regulator-always-on in RockPro64

 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 732727d9b0..638d567357 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -22,6 +22,18 @@
 	};
 };
 
+&u2phy0_host {
+	phy-supply = <&vcc5v0_typec>;
+};
+
+&vcc5v0_host {
+	/delete-property/ regulator-always-on;
+};
+
+&vcc5v0_typec {
+	/delete-property/ regulator-always-on;
+};
+
 &vdd_center {
 	regulator-min-microvolt = <950000>;
 	regulator-max-microvolt = <950000>;
-- 
2.40.1

