Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD09C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 04:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EEA040688;
	Wed, 19 Aug 2026 04:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUCVxuIdx339; Wed, 19 Aug 2026 04:52:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787115142;
	bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5CgoFSdgXWCcgprzt4fvG/nBItPvBglbyfYRwsm8omq2Het2z9KG8DotT9Ga1iwR
	 nJRKYJShZuTpCczCPipd7Vfpxxn/TN9SyLOYoWlOKvZS8I3NOA/MKMKg+4uF1pfQca
	 iMF4QhZsryjRBEGiGN+WF3f6972ypMqOruEIJhIMKHCWhHrK8cJ6FVws+uuUPjhv4J
	 9SkMTwMuXOATpdltCAWCzJ6rq67V0jr6Y1tXPRi6MLZbGjKzi8ZjK92UvLGYZ844ZV
	 6HkR/BZIqCMoWQ9poMSIoZKJLitPkXrnIDzyi4RyFHzlqWNQbK41ilu5Jt81s1j9AX
	 KM6EvLHk0ybpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47E1940674;
	Wed, 19 Aug 2026 04:52:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76FEF1395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D14E40664
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFb97XY62riJ for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=jRW5EFI4
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8554B4065E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:16 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso833233a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111776; x=1787716576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=jRW5EFI43fesWeTTMm6vBwi+qN47+NbCxLMgpOzwkXZPRYZeicSH/38dSmUzIroPMp
 kr1i5JLlgEGDc97Pe13TU2i9JfXWxUb1PEE0FklFBaBgcovwNPpb894DV9soh67RQis6
 pqj4s88igDBlbksNpp4LEnN/PRXrsIUd07Gr8GPCg4kDA7ggJxiX/T154LpF+86qtdnr
 KyMCFsOmgBdX4hKYKXURAcUAEuXBLLG1HA00VEaujlnrAFmIWT6ymAJQ2e2zhOqWOVVg
 Zo6X+gP3xCeQsaBZ9x+o2Y4egR5ccWWNyJqJy3R5oZ2FC5zSg+mguW04+23CbggrA5EC
 nbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111776; x=1787716576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y488lD/LPUcdmxiGKtXZHiNdQ6OU6sXQfr5XP3nutCg=;
 b=o1E5G6VhI27pIJy7Rt6+FVNNby/8IZ4bT2fDIWC41dy1lsPh1lY/yGODnL+8LjEFRO
 5lkxxGO0x3d/nGxYkIopGTRWLR5LKF9iTjsg2foJo0p8vq2aOcx0VAiwXe/EPxlSXI9v
 Xjctx8n1VrbcylRUWKaj5v8TDsmRNwrvuQ3XpHpiJp5nOHW7f+zyyEdWcNiU5DDVxKvW
 gmBMSONsRHU+5gxxw87MIP8NhgjwmB203ZRc0kJs835sS1qVX+xQ6wBIJnaxgOHMLYVA
 HxgXXY4pXRcRii0KiUqE4/7hpVVDOup7GEjfu5VtN7BM+bWvlyLZfgQ3JJ0Sr6MyH20c
 L3nQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHIkbNun2ke6Gaal0wVYmtVYLM+VREuGOlo3TK4BSPM8EkbKMnAO31JOSRCrJSJ7Alh3Egfnk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy6vn1kM/b7QJ3Flm3W2ZXXgx8walXvLgbmjTXPFERWt6bioO05
 cNpvREaLmC+N9ziEYAgEg+GZ84kBbIpb+OR0sUaIauEK7QbiHNfkZYrda3nZirthv0A=
X-Gm-Gg: AR+sD13ELOQ5Ide4c+1+X3kDhMPPQ6LW1t8M3Kwx5XRZ8lRXPGSDTPuQBKra+5h6gBg
 COlq3ZHCbhsP1lHyEPskxgkyiwUIJjJP1rAUh7IOCpMJ4KoSBHYm2A3SGIDcjlyl5CVZrf4Gzaw
 5OP2Jd/HJYRUnMcaxMrttfffvK4PJN3scS9hjM+rkHvdC2zOMBA96qC+8PClgL5PN9K23cE5F8Y
 bk5liQoWunW2AXsSdAE9bLY6NLsWZY9dYCIq2f0VdfE1b8xmyNuMR5AtHJKJkzrr3vvyL+ycMHv
 V7ACrQMcfGeCU6JRI2noFHUv/PRvXEumTvTpBguJpdysPp9d1/GjmonYtMBiqcky9wLanfeRi6K
 6nnX5uQ7AD2V1H6Qq+lYBQnRe/B5GMJgHpuCv+1jNWQhjdseVk8uOT8y4DSY6XCpIkDadNQemo6
 OUCI8/cDmcf1LwaNqGYw8jZUf6UQy7TNMJyIi/MlciC/vzF/dgvfiNydGxmK6k1em6+8k/61kiL
 QPfDE7QzR9osdCP0HnZmv349fVNYxmrgs4GRynRfMnQg97HYZY6/aGsAZxIPgP8OeXc1ZFHdvZs
 MWfltvGpWi/43ZDmM29Mmy75ljI=
X-Received: by 2002:a17:90b:5903:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-395804b57e0mr3572414a91.0.1787111775621; 
 Tue, 18 Aug 2026 20:56:15 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:15 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:48 +0800
Subject: [PATCH v9 06/19] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-6-6e66016392b9@riscstar.com>
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
 Eric Chung <eric.chung@riscstar.com>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 04:52:19 +0000
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

