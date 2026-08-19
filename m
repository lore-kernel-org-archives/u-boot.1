Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACDCC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C43080E7D;
	Wed, 19 Aug 2026 03:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSCyjIPxeJsU; Wed, 19 Aug 2026 03:56:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111770;
	bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Se+5zevFOxndGM3IbK7zU1Lx9vKswUedaBoiMtMrEWYvB/hvbSkttbE1OOJnF5jQN
	 P4kOFZV0qLOE47wi6vyWkQAeuv1OdG77le54YWMS0cifm1pOYY3ewqQZh1jHdJRrME
	 pWNznY4vLk/4n4qcakEQWXjh+LUYUvHIWlf4lUrBFUcvAwZgSxk0ep/aOo/L85ioDk
	 jujD54k2euN3NXIygZE5p8kJPiCdu0cAFiRymB+f5bNI/EmUMipmGiNKhO39xNqhOK
	 744R9PwqLvP+7un+urxfQk5WnEKjexzBSmr3HM95VhTu6lqGMgJ3IVGZgActGVlzes
	 siVScwV7ZkM7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 930B280C2A;
	Wed, 19 Aug 2026 03:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63B931395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49E2A40681
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CdYEvViULjh for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=sN74OHEk
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B7F640664
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:08 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso6188415ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111767; x=1787716567;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=sN74OHEkNen2bfJ6txXjRSODpt9eB8Ag6XpWRzSVJknMMx/meGEE2Um1RxL9EWHdH8
 o7ODwNmb/3GETOjjziuwzIZA42w/5jy/5ruWGECtek+4GW56JdDfX/Ad/mIPTxQUhNqQ
 DcQ3Zv7FKfhgBTS03Hp8jvSxBjPuHfjU/xIBijie3+ZzaYcP4H57xgQHVqSFFoP3EsW+
 KY1mq3ST3r9jvi9zzFSxG8doFbc845tYu0YrwAmA10T9cH//wYhTDGPYEtv63MJy/WOC
 ZqnYKbG5p7xTcN7Jw0uwQ/vrxei83efpNt7eJAKz+Bp3beRSPVX/2lE1f8Wnj8ImdvFS
 e+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111767; x=1787716567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=TpCIHeTuW7RBDg05qIbyetUc2YujGTh58rMY4JrWyBNZ7D5HnqPnuoiT8qQh3Wu0aH
 ASmU5ZaiVeOqk2WXMLf3JXf6GeCQcNS/zOmgmB1jJitD+jYqsaAuqNWU/14g3g/2Yd27
 M4grsySguzuCqLl256Jx+v7kmrNLg2DcN+cLa2Tu/id1NxGmwv864K+GECrOKggynwn3
 xwLCu8th8rmoEZ9E+hkvJqjpLnR80q31M5heMR3fRkMtDqAvGSaD9x8xyld29kknNd9Q
 L29UID8FuLR1dvWtfTHNUTJ1FeyPIRhvzkMfV7M//fCkAheZlZSoLzY31x0xfASTkfUo
 GjSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgeOcJA0PmDLyrxM/2pJ6gA9DWmsCGPELUHxe5kpdjrh/FNA40WK31QYMCfOCPsPDvWQbRtjc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyKGRqQPpBalyxDdw6xCtvkHAKy1fqTtFpazuPzlr/Qm8tRLmyA
 DDxhysVT45YXy+vghvZBStDlZL+S584bW42m55jx4YJoArwbdR4h6GjbMJQNN55YIXg=
X-Gm-Gg: AR+sD10Uc3JbHzxSYw2riCdI+EZ5JiRZJ4tEazyx4o4LNZXts/GD2DgqKeXfqQUIxOA
 QNPAekS3Pu1LzfPreuZCGISsgiBvV7wJiaJUzr2qc35u88w499Ct1DoRRVX0Gq2pQKBlK8JobhL
 yjB10Kewuly0CBhrOBmJaLKvpsS4DUpSjYgxfFcDkayCzzjEBHz88a7DKFoDsO6+6GOI9iKJkxq
 s5b2JXHzrNw84y+o6cfxqDVbPssZG4hXnpBH+NKUWabFYDhRKeanv1giNfPNOa8osQ7S1UQ7UDn
 HKG0DscSVq0c9bweO1TBpP+N7YWHT1V2qQaFGgVRcNdFgeKcxiQKy+0KuCHJqK++F7tygeSvBYn
 4jcXWYbypt11zatl4vZsY3WcW6eoo2dLjqmhk8VGmCeiyRtZ57DOPCTzeP83YDDLbCorqeQvfxZ
 wa2I9Qb/SGR2HA1iUYCyTo202/DcSzl9ahuo7gr4BzheU5LrFKo1ICZc5W2wz482ohnVWiCT5Un
 pkLOm5SAwUqx+qVDILwkve+OW59nsG58djLwW09iawt1OaWp2dN0bqEyMvx4Feuad3/QoHu7eun
 SitJZiIH+uXHI5G3uebdbJNUMA==
X-Received: by 2002:a17:90b:268b:b0:395:5f66:15f1 with SMTP id
 98e67ed59e1d1-395812349ffmr3231465a91.17.1787111767447; 
 Tue, 18 Aug 2026 20:56:07 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:06 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:47 +0800
Subject: [PATCH v9 05/19] riscv: dts: spacemit: define a SPI controller
 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-5-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@gentoo.org>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alex Elder <elder@riscstar.com>

Define a node for the fourth SoC SPI controller (number 3) on the
SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Reviewed-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Link: https://lore.kernel.org/r/20260502-spi-spacemit-k1-v10-3-f412e1ae8a34@riscstar.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: c580774185426ea316396b1dc3f1737a3ad3800a ]

(cherry picked from commit 2eec5923556990fcd34c88c549dd11a5843d7fce)
---
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  7 +++++++
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    | 20 ++++++++++++++++++++
 dts/upstream/src/riscv/spacemit/k1.dtsi            | 15 +++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
index 5790d927b93d..9429189354d6 100644
--- a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
 	};
@@ -335,6 +336,12 @@
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
index b13dcb10f4d6..34d88334e95e 100644
--- a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
@@ -570,4 +570,24 @@
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/dts/upstream/src/riscv/spacemit/k1.dtsi b/dts/upstream/src/riscv/spacemit/k1.dtsi
index f0bad6855c97..f8747190d2e1 100644
--- a/dts/upstream/src/riscv/spacemit/k1.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1.dtsi
@@ -983,6 +983,21 @@
 				status = "disabled";
 			};
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>, <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 

-- 
2.51.0

