Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D4C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85D706073C;
	Mon, 24 Aug 2026 08:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUDdtQI2d4Rk; Mon, 24 Aug 2026 08:51:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561478;
	bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L60s/pxbhthFcVC2d2YHOs0LiATk5ck0nOJdsbUIM3jQCWvQys/dDUcLqqOMsldYZ
	 rnEwegdllWzHzY3U3rMNcA2kK5pjIr4bh1fqN4Rb/x12AmDzT5vakUM6hiMDTT+xnv
	 GBUDv1eAb1ljBSuap3LB7JqPgZCH+Tb3jijo03QONkEFALkYZKMiJlZnjifsukBI6J
	 c/YqzwVXEJqpRIFZJSVJKdBWNFA4eS+Q/0EiipyDt1jE9Z+OWEkV1cKn7T3fP4Ak0b
	 7lBP6G9QcNdKp/hD+hWqyyyks8cYaidw1cHOnD1DGNQ7ex7koHr7rh+THMPs5HYhSN
	 2la2/DrnQf+bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACF6660622;
	Mon, 24 Aug 2026 08:51:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B52BA336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B9174005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vfnUXVLrTirm for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=fK3L6ifm
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DD35400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:15 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso3237801b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561474; x=1788166274;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=fK3L6ifmWMvd634ZMVV8ZZm0tYaZW7k1TdSAi9JrhvvLG0Hm3MukXtSm4uQjGCcoMx
 ZtfZw7Ygn5LOMBWS9GIyxQWEGEvHHjCU7lEgDNOG/V0jDXVuKWPzX+4sos5966o9UnPy
 C9U5KHaVS7oKvR93HIbm69pt1P5n/9iC45AXbBp/Xri+/SY0Xn9xyIdYaTonhwEu2Vvr
 FrkJUc91InEKbkC0VEuy0uUC76iOlE3b6o0VljnfxREwCTP7herabuPmCFLnCwzbWdeS
 /gYlZ2iriBAw9TQxiQdYtLB226OntX3C7K3BY9dikMHoOUiefn+iZJ2F3HQinZ3Px3XM
 SL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561474; x=1788166274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=SdrMMmsUtS8mjsZk/sfajkm+JVPWQDwSLWx06NMGTPqVbKW6Iir7pFGszOr0/sHXhn
 IK3floYNSG2aldTHsiNb5PsDeez8SiCijF8TOmSsdyW82RsEwvjiBRA4ymeroay6pFph
 fuef9ooJgos3uQsOKB0v2mze4ACJFA4x7TMfYA64pgL+W6Md9aEdzvtV7bzrZkrogkIq
 2CaW+1PXwhZLK6JkLhpEqNsDHoibXB7lXwM0gWQh4o52ZnKg0URThvt5nAyybJSsRmSE
 UJgFvWUwXoUmV6zWsKyyRbcJHa8or3/WStIynXSIbPmJvS+yrVuYDD2rQ/YJL29l5zsx
 9kQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdJVfJCVlcGnhl6OIq5uXVa3/iR+pmIAItDqgJj/JFgfqMeBRnrOr9Xggc8FgxE5IV987+cPo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lIhKU6k6+Ezi1it1jKuyeIZZNxPfjMSQlEY/kcqwiODZF/kC91
 l49oYCcjsY2zQr9v6rCd8pN4mZ70915x765pmWjujU32OHtNosRpkZlqnRuGdWLn9Bk=
X-Gm-Gg: AR+sD10TpV0BcFWltnJvmXhBk+L6Ehy17uk60J7aj01nMzHelaD9aQ0bsQwNI4lcbN0
 I2nkxvWtuBYoMTPXa4GEga+NwHSTiFQRS8rai70o1nOB9dBPSacQiGv0FB1Uo19VZFOgclYZ/PU
 JgsYNnbKsP/MiprR3QoliwQm7RGalMtrdP5XOvpCmjLzJXyFbmM3p4z2sHconQ3BrAuL+fuTE4f
 y1CaDZLnbfpZJrWDY9QdY5wA/w28FIQUbrlyb9d1mgy5ah8jJTZrqQJO2ptGJHUPsIpTCj8fQOs
 Z6zNPrCqKPAPkBIX6TWpUL0Wb5iNwBJMR6fwzbxrw+O72G1Ywq8V2krYp3iw82XwnX0uGl65hW8
 UfPJdHpUxOS/XruoaKGXf+2GKMAeb+3o6UHQtiH4hk1kcjo8mDbNGwxfc0iaeBRppoN23Lt2TgR
 uzY3p3Y7DqT9sygG+f8s6CwGkqTVQv2/U0PcTWWeBhYgv4FJJvRr48EwRV3547HxRK9itRemS+s
 8KpoLkhIte+PY1H+BhIDDVO1FElENJxH3hdIKHncgfaRYZAVg5EqxrGVXlj6qI/OyQLZ1Fzhk2D
 RnOj0a0eecPcaILbTdl+efs1LQ==
X-Received: by 2002:a05:6a20:e212:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3cd4bb987ccmr28361989637.10.1787561474466; 
 Mon, 24 Aug 2026 01:51:14 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:13 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:39 +0800
Subject: [PATCH v10 04/17] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-4-5e0adcb1edb9@riscstar.com>
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
 Eric Chung <eric.chung@riscstar.com>, Anand Moon <linux.amoon@gmail.com>, 
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>
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

From: Iker Pedrosa <ikerpedrosam@gmail.com>

Add SD card controller infrastructure for SpacemiT K1 SoC with complete
pinctrl support for both standard and UHS modes.

- Add sdhci0 controller definition with clocks, resets and interrupts
- Add mmc1_cfg pinctrl for 3.3V standard SD operation
- Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
- Configure appropriate drive strength and power-source properties

This provides complete SD card infrastructure that K1-based boards can
enable.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Vincent Legoll <legoll@online.fr>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Link: https://patch.msgid.link/20260515-orangepi-sd-card-uhs-v10-1-094af27e310d@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 2d77e577109967ef65f269c1fc1d6a659d4260fb ]

(cherry picked from commit 785af36511c3d3664204be1427c5cade3ce9765d)
---
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi | 40 +++++++++++++++++++++++++
 dts/upstream/src/riscv/spacemit/k1.dtsi         | 13 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
index 34d88334e95e..4e9a62d0e85b 100644
--- a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
@@ -590,4 +590,44 @@
 			power-source = <3300>;
 		};
 	};
+
+	mmc1_cfg: mmc1-cfg {
+		mmc1-data-cmd-pins {
+			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
+				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
+				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
+				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
+				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
+			bias-pull-up = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
+
+	mmc1_uhs_cfg: mmc1-uhs-cfg {
+		mmc1-data-cmd-pins {
+			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
+				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
+				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
+				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
+				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
+			bias-pull-up = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
+		};
+	};
 };
diff --git a/dts/upstream/src/riscv/spacemit/k1.dtsi b/dts/upstream/src/riscv/spacemit/k1.dtsi
index f8747190d2e1..acb608ee7b53 100644
--- a/dts/upstream/src/riscv/spacemit/k1.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1.dtsi
@@ -1214,6 +1214,19 @@
 				status = "disabled";
 			};
 
+			sdhci0: mmc@d4280000 {
+				compatible = "spacemit,k1-sdhci";
+				reg = <0x0 0xd4280000 0x0 0x200>;
+				clocks = <&syscon_apmu CLK_SDH_AXI>,
+					 <&syscon_apmu CLK_SDH0>;
+				clock-names = "core", "io";
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH0>;
+				reset-names = "axi", "sdh";
+				interrupts = <99>;
+				status = "disabled";
+			};
+
 			emmc: mmc@d4281000 {
 				compatible = "spacemit,k1-sdhci";
 				reg = <0x0 0xd4281000 0x0 0x200>;

-- 
2.51.0

