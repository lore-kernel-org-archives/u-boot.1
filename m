Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6802CC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B96D40649;
	Mon, 24 Aug 2026 08:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zDMnOykbPAe; Mon, 24 Aug 2026 08:51:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561472;
	bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=al6RGIURF5H/E3oeA1RaEQ1st6cFi5tNq9dSUuDjlmhUK1OlpHrbo0mZyuPbD52rS
	 4Po5KtlM8vV6FDzfO4qaDlMXNHRHX9umbgh14L6sxuQo5ykSD8Ry+HVB0ZM+eDIqwi
	 oORvFJXvOXOP59nQndnxpdLM8Llqx9DQy9ehdHvyeRuq+CvD4CQC4yazlED1/J48N1
	 jWcnQHsISpeN/gd4vWtQVK20+1J6ZQTkZqVc085lHuc/w2HN1yu6m06kuMR14cPGJA
	 EMOe4bSMaVBNzIwPyJbQ1BJ3MKVMuZ5AenaJEZ6BwnUSE+koJpQ3YmhYFaMTbF8o2T
	 jnV5udTKprqBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A7C1406CE;
	Mon, 24 Aug 2026 08:51:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD35B230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF13A60631
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOiF3PclW58j for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cwmP9pFt
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4A006060A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:08 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cacf197759so42124145ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561467; x=1788166267;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=cwmP9pFtWnj+H/WqewWKe1l366iLx8ufRCBgUrHcxdCYHnxnwFpK+Ux8891Q8sBxyH
 OcNRHZ9GpaCgW0QkCO8u4DbeuDd9o0BKpn5EueqMrhW6D02MGuC0PxH00f9wuowvml74
 FHT1xieupsonOAfClET9BoQNT+WJ3ZMX7ALVkcDujpDlP2P/+ZCNZRYvBuD8N/99t2kE
 /0IEOzC/mzuyRS5G1oWkw/Z0SjLVPtD8O1nPEdEfQwcih9CqxTqoiClF5ByOjL+XnR3z
 dSDexWX7tL9OFOun5p8AAGmmFDbcJaSeDmqCNUQ5OUbodK244BJzqMkCo2jPsRNxOcjW
 B/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561467; x=1788166267;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=O6e+W05srPpVvltKUZ/N9C5/utmCgTXRhPG44ro+dD1akMhWbuJesPSaGE3q5HznVr
 eWpCwLtZ6vFTOlp/99rlYZfPIflxGMwUMhsJrPG6BV1HhFO0tNmHsch5vNptz5Bnv3al
 Ewe99CCzdCX7ZLr1gGRYw3gxLZHalpLp8FvclQaAR/yZ5xGMiWPVzGzfNq05kBBMYIaZ
 0PZnX7wGbZ2EJrxRr92w9XMhPePTbvTTBCOJ6+Sayd7hnC2XCpz6kxtk+Iw4O6TdWrKj
 2A1hg2PwU/60LVfbSL8gQovvikM/KrRu+OlUVo4q90NQrFekUZptlCsX+kejLa3aaarG
 qzaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW5Uck8YMGItKQfJHHH/F12eLBW0Omr0fwJNknsqxy/iBzfL5MAZ/Nm/9nDPShbOKEjnRqy7g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lNpot9IEF8pNrVLGRZGcL8SR55gqnmEMjo6Z4r4Aj25eFqE/dK
 3ZQuxFDwsPrMnRNOLR3BKII9OmmXw2poO/DYemYzyOQTXDn0PqL9X00c4dlIVPn2WJ4=
X-Gm-Gg: AR+sD13l/1ZpMMrKSZdAQkPkyCn1X49dUITWn9kcjuyHYtxcSMbyhT/4MC9WWAPCNFA
 lDl8lWUQh2xabQkcNbHjMT8kl3Ab15hRasEwKP2D+AyZo6fMZ8/4S/TrU2LVvZQszQXS2luxv6M
 vVnZV1F+FL5bxrVDAuz0rz9/qxZNbD5hTon99JFxWfp/7t1+us9ATfOw25qOgudReukl6n+M2Hp
 z6jKYZPZUhli8Sk7HxYeJkfdwREIgxOqXDUkmZBwdnmSNK25JMAEC1gTUwmJB977VPWJe5Fshju
 xAi6kllC6LRZtvJS23USpNnsfwDji8BNBiL6Wf21kxW8eEBCVsGFUOs442nUJNzoxh4/bCE7SVg
 JoPeKIfuNWl+2VzHlTyXaQDKbNuZ5rQRDfPcYCUZBDY6FT/TICqmuIXHdbu8QW4FnxSMf2FOIjT
 GJzC3Z2zK0XwYrMAmb937A3BRElPWOE3Je9n/MthdQm3092mD4mJwhSAukmg2ErRPu9yu5GK5YN
 fUTTIOdvSnRtFaAYm7TJDmkSeinPtzeuh08tHRp8dm0PBtq/Js9RvuM71Vw5xjjw/Pro/3zoRzB
 PUaGOBAy+Pq2X72vuK0CjEorJw==
X-Received: by 2002:a17:902:ebcd:b0:2cf:ccc2:6088 with SMTP id
 d9443c01a7336-2d64af6b6aemr492074355ad.4.1787561467581; 
 Mon, 24 Aug 2026 01:51:07 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:07 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:38 +0800
Subject: [PATCH v10 03/17] riscv: dts: spacemit: define a SPI controller node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-3-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@gentoo.org>
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

