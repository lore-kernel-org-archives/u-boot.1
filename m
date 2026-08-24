Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE5CC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02AD14070F;
	Mon, 24 Aug 2026 08:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLMz7pHaF2Sg; Mon, 24 Aug 2026 08:51:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561502;
	bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tODphPYzRAd0Ya2tfALq+gFGoG7psQBfVSHvCO7EhqqFIXLVM1sceuzsrczaJb014
	 0mPB8SZmEi6CvaDEPvgF8rKUqAiOAQc8XCisRjUmC4OJRTPVouTGLTYwJZii8Q6e1/
	 JQaxMHpgQEGmcy9+t05n3zhpwtqH54DWHVqCVnsz9vlsu0bt0mCVxFI/igWoSezXbd
	 u3mRFKbS8UlBuoZ9cf6gCLc1/dHYGe6yK4hic0XPGBg0/AYfU7C5UigKn+E38wdar/
	 LbSx6/cJoTjHrzgDV7hDlZC1ADWjyRJ4X6K/ZxmipuVLk6DYRNzGW6jfWgfxV/Nk4f
	 4e+/STuEt9c2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32D17406A5;
	Mon, 24 Aug 2026 08:51:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7C0F230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0B31400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EGU_fg08v7P4 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Y11/G8IO
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12D004005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:39 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so2192643b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561499; x=1788166299;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=Y11/G8IOA+EVdl21YkOuw0OjsOiOEkPfrxASpcOlp2ZpoH5vYpA7XIOLR14DyFnheW
 g7IJg+QlSPD7ww0RWJ2W4MLLGxkBaii/r3coPzEVSyuYoJztA6BUI90fyXwlOg71wNVG
 9lC56ENOL89ICOP+6M1BP5kWDYPUchEQMa6BjhAp4iJDsH/TyDLrtE8hkg0S3IrqE1Bh
 f3AUYjISkgxz9J8l3XgRrwC6o8jYRPsrSMdNc6lrGlyKjmwfZNOkxAGdolobhh5Wpb3C
 Tpim3iBVTzUBW6GZ5QDxOl+QCOMUQkBj/XmZigDdTeCT1zuVs+FNb44wuz3N8eYBdWQN
 Smlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561499; x=1788166299;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=X55JRcNmytDabXxSgrVr9vYnf/MeBETUj1P+O9GBx6k9rnHiHnta7Twdf44YYTRF1r
 x7Q6yvSi4JjRH72wuuZBPNQKIfAXjWkYvcHk0v5GGxNzg7EP/dQqrP3ZrnRHl1Wfq6D9
 ZeprDrokjrRGRyb5RZh06e+mX3B6ybn+iglxsgnrEmyfW4rYGVaZrJIh3O3ih7F+G5kw
 F6I17HYe8X1XDidL2PkEUjjjq8zGivwGR6AwJvroO9Q7/E4YfOf/XZ5lh8DlUMmqydzE
 uf2fm3pBqQDth1eP9FiGslKQkcZoyg9v9BuxebVuM2z+ORjtzlpbd6BO9R8JHVayuVLY
 I8MA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roy7VC6kS1nJG3Zg7GcvdtA9epnYQtR4GA5dciUaKcl8X2fqizMeMGB9jV1ZScuJzuEU+l3R8Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n987sgWFYhvoa97zCOSR94/XlQNof1L5LQphdJTdfTS5drA/Z5
 Lroy5pt5izc0/Zq+1Vvkx8ODmVbP9x2t/AlUsAPGO0KJlz57CtedEmTYLhRy8S3QF6I=
X-Gm-Gg: AR+sD11PMPkGDU0H81kjKOYhXrTFkNbEO6S/BRt2RLsE6rt4FOVv0GjER+9btSsrJFP
 IpDc6sEKR0IyV3OamTt7NaBzbgiUohGK8uOQznPop2V70WDlnogTMK26WESQaXe7FKqQEsBP5fN
 DrcvWycAOuKMbQvB4v/h4VAI1ZObGd0JhbGQJszFnqtpL2jrBu27RfsyE2tk9VWGoQKrvHMdgbu
 OFpgVeadDV50IcdlT0h1hv/fC4hasBpfQponfwURQrzURyjnZ+BiOaNBlsEKpM8cGjbDSCX6bFx
 3F/K8CQZjQBUEeyDKrvUWinqs5FhnRQe+22vsy5Fh91rWRInDz4lirp/aNgxhI7O3pyNsQV3WxD
 e78VdZyU5E5Q7pXF75+FZqW8vhXBCdlioS3D0qSWxf7uFJUAclLzsRIXUg6MEczYxIPWg44jID0
 pSCybVZe6D7xkacu+hBaRT22CxK+C8eM98noSSLTDFGUL60cNVmCxY2zPrHOsHIspHX9Zgm5A8d
 /0qEUA7w1B6qdj4glTiHPL78eYVbJVviT82aOQ5N4aQq9nhja6RAQmValXSDlnOE8mENEr7B7Oh
 Xt4HLt6xqXmMEaSLnm6UIpN5kUtY/xiRRcDM
X-Received: by 2002:a05:6a20:a10a:b0:3cb:e8b4:f03b with SMTP id
 adf61e73a8af0-3cd3013c9bemr44666366637.17.1787561499169; 
 Mon, 24 Aug 2026 01:51:39 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:38 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:43 +0800
Subject: [PATCH v10 08/17] riscv: dts: spacemit: k1-musepi-pro: enable QSPI
 and add SPI NOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-8-5e0adcb1edb9@riscstar.com>
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
 Eric Chung <eric.chung@riscstar.com>
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

From: Andre Heider <a.heider@gmail.com>

Add the QSPI controller node and describe the attached SPI NOR flash
(Winbond W25Q64FWSSAQ).

Add a corresponding vendor flash partition layout.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-4-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 735b1b205d07bf7bfa55b1f50f5485b9cc42a251 ]

(cherry picked from commit 30ccfd225cc1aa971a0748faefa14e735e49807c)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index b8e73eed8e62..74841cffd5f5 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -44,6 +44,15 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_qspi_vcc1v833: regulator-qspi-vcc1v833 {
+		compatible = "regulator-fixed";
+		regulator-name = "QSPI_VCC1833";
+		regulator-min-microvolt = <1833000>;
+		regulator-max-microvolt = <1833000>;
+		regulator-always-on;
+		vin-supply = <&buck4_3v3>;
+	};
 };
 
 &emmc {
@@ -239,6 +248,47 @@
 	};
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		vcc-supply = <&reg_qspi_vcc1v833>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootinfo@0 {
+				reg = <0x0 0x10000>;
+			};
+			private@10000 {
+				reg = <0x10000 0x10000>;
+			};
+			fsbl@20000 {
+				reg = <0x20000 0x40000>;
+			};
+			env@60000 {
+				reg = <0x60000 0x10000>;
+			};
+			opensbi@70000 {
+				reg = <0x70000 0x30000>;
+			};
+			uboot@a0000 {
+				reg = <0xa0000 0x760000>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0

