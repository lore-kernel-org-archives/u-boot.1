Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4DAC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFDDD40703;
	Mon, 24 Aug 2026 08:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eoLgcrOf6vuE; Mon, 24 Aug 2026 08:51:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561483;
	bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=udkqEYAlCfFk+fddbAK+QQ+51M1o0A3UJZJsEgfSVQMqS1OyUmRuYp4kJxHIp3iI3
	 a8fi4bLrrOJbuI5ANpd7NhYAlPp1Z21LdR1xCL0E/jWHYztpP2VXaQJKsEOgo0wAtY
	 pYyqZqXLZk4hSJrO4LKp40vTbQKyWl2GN1tk14nVewwWUMiwrAKDEsAsLIF1HnP1J7
	 g1l8G7OvQ64zOO5yB9g29eyaLFn7dw7zOlYOMggm2+qLUwPUasxHQrTZGxrh8OaMnw
	 OyQ9zY+Ok/DBnD2iDV2drNxLZ1oPgOTZjq9oBNg90w5fPnj0bq8QT9KKh9mwPoxqVi
	 fQwswOqMHvzAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE64E4068C;
	Mon, 24 Aug 2026 08:51:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 24CC13AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B48B400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZeVHtCcUXAS for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=SNdJ1p2D
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36CB64005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:21 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cf52d15d88so26303605ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561481; x=1788166281;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=SNdJ1p2DxPbVyUjJVnwDav8Dz4sORdRe4AMVOD57QwE/uQ6dZh5HOuAzcFS/z/VyZz
 bkEOYNYlVxy6475CGfB95n3STpPq6GEMF3pjOBR+bhUspXd7TmY1IUD//90zJEHErYEO
 4Q22YPe/X8vBw21V60FYSlM8jwIHIrvTv+OIbjs5dl7NmOTDdfwK81I8+nbLIiKuybBh
 W5Qg15trm7hlHa2B4MqTZAiheX8BmGRFq/f/lBjnozQ5qFCO4O5CpmG+RKaehHlnedgC
 jmb5m24Bhjuga4cdFX5mMQqKwxUgd4EbpxHaYv9Z+97nNxB3QTuNVZs8eSuD+JThjXF8
 S9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561481; x=1788166281;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=eSlKePrz5MArFPd8YXnG6TcNKmIfof+GRRNqwVCVwNxkqX+BRabC8iNfVWX8TZ2TBQ
 +REaQDJjje17dMf/Mu+azm+huOxN79UXN7CXK0/1dgOXl/7vXNMyteCP65lPre8/Wcxk
 96l+2KF2gJUEBh+aNxV0j9HJz7es4n25hfXi4VJZQ5LUI9boq97dlLxzygvSlP1IC7AT
 bkPT2iQ9Rvb82yFyeQsTItWlpYU8OrTi7VtjwaewlkCz8oGJIWqyjJ4JUltUBD4YW178
 scDk76ki1OFtwDPd09yDppJapZQKp3I6yWVKLkjfSVIn5WORG+O/bfauO1Qm/Aant2lR
 6HnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrueOJqWnI6x/HnG3B9CghW+8bka5umFQuWDP3i2GH75m87fWwud/tv/32rzVIo18p45pCirYQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nYpMqtM6YMmQ8SiyVJsqVdDRRvB7enRdc5IiWqaNTzfiMn//X+
 nFHxy1BZdVkR0/KWFccf+J9xI3wgkt031suUkfKkUhwIv98SoRMl/lmtbz1NhTfm7PU=
X-Gm-Gg: AR+sD109sOxNfHV8LouXil0V6LljsHuuMiwk6WLMTKbXmNT+BOT9tv3d8q8LidU145S
 EsiCV+PlKkW0AAoxwTyWZGDxPd3U//hfs3fD+Zbq36rM39D+t3Wuzp35CWVA65QFosOmMj3Kh5L
 wjvMRfTuvbGZssr0FB/y1OMPNM4oCj66WDoYvSQnxVlZ4iOPRxqQF2q1LzcDz15TMRsESFZOyn5
 A3KWfzUH5pEIBziWM+m8iWleeID0P39MQ8jLz+a2KCsaGk5geLbe8KpyCdPYM9KD4P2aXCQH4U3
 tRn6PwE3wOwLWVd6vakc1tpL9u1mer7+qo7gV/DdyArEE1jnAi3wyPIAaJGKC3KJIwe0TUvi6x3
 yveHpftCOmyKhhZNNfsmMzDBupKbYhgBHbyyhKuD7Oape5Bs9cRjbiO8SGWLC1x7HUmEH5FBjqe
 UiMCYzSgKLtLrGkwIQjMDbD8YS5X8Ay8a2VZDqlPNj3F8qY4w2ZLCNB3nYd1IYn2z6LtmeX6g8A
 YFnXOrpg5tlhs4E8F9PJhNaO7V5l7i0H99/DkF/VqKxN5XZS3x7hQG9mAtXshe9bC6Lda8ve3ZS
 ZP6nX9+o0iVa4WZjjK3yjm9h8A==
X-Received: by 2002:a17:902:ce0b:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d64add8343mr507525005ad.7.1787561481111; 
 Mon, 24 Aug 2026 01:51:21 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:20 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:40 +0800
Subject: [PATCH v10 05/17] riscv: dts: spacemit: k1-bananapi-f3: add SD
 card support with UHS modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-5-5e0adcb1edb9@riscstar.com>
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
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
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

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with GPIO_ACTIVE_LOW and internal pull-up
  support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Link: https://patch.msgid.link/20260515-orangepi-sd-card-uhs-v10-3-094af27e310d@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: c76e2f058cbcab84e4a703f26857a58bdf6a0042 ]

(cherry picked from commit 3efd965004f1604c204001dcead9a44f729d5d58)
---
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
index 9429189354d6..9beb8947f12c 100644
--- a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
@@ -17,6 +17,8 @@
 		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -221,7 +223,7 @@
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -242,7 +244,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -374,3 +376,21 @@
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.51.0

