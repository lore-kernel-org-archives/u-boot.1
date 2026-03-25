Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBC7109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5428784073;
	Wed, 25 Mar 2026 23:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REucWrnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12E583FD9; Wed, 25 Mar 2026 23:33:10 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95D18406D
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8cfcb045909so55452085a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477987; x=1775082787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt71RVfAcgT3okoIF7giI6uwtKrp9vNiM2mFNC4c8bc=;
 b=REucWrnfIueI/vaMeHZ3HqhiAy+tQ9EiDPUmPiL62evpUWMJDbxV10H/BK4UIft5zc
 lWdaK49bJy/w2pBp/cjNwJEzwQrdCiMPh2eYlaTrhLpB6AoJ7daYxIMOO0qaFCco+tHy
 F3+xFmdaFHAN5b1Gb+UDQlZw7Vnc6/Fo9JqE/kBl2eh/nLpEJ+hhp1yhhJ0ysuMAAK9V
 Rcxmv38cVOBhgxH9tG3EvqMOlqZiNp82mZLYeNiBQc1jPG9nnzJSL2Ld1aYinKMlVsMo
 +KWkxUlqD3tNnE95Kv5ygu/b/tguH1yMeSyx4i0GlFEG84ySxXsw7YNjQS3Xx37sW/fe
 ix8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477987; x=1775082787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt71RVfAcgT3okoIF7giI6uwtKrp9vNiM2mFNC4c8bc=;
 b=rTmm9rzFTPhBt0awpZXcQzAlIhdWvZDKZwLJ4gdR2DedcWAAScnEYCFpTOTwIjrFiX
 rpkXq+OoJ+l0238Yzb1oiZ7wEKNccPDdu8u+6WAJken8AS4cxTYiUz2bIENfxCOgWV+h
 7AbtSl/CVzidtR9aaqpP+34uWd7WyfKDWqXukr8Fp1AnuIjsGlKrZHafv1F3nFnENiBt
 aI/SSySnLU8xSo7ESO5laTanABYiYANLbKXRIQT2S7+hI2WkV5yTtxYlbup9BJR1LPsk
 2WrMNuBS1KMe6w1TB6ab1avB+YhZMw8bOgo4+3TVOLuyDtMXavlqxUCybEoebD0c8QlU
 TwmA==
X-Gm-Message-State: AOJu0YwWZ8TneuPX1TesI4eOqacXglCyt2byCtKG7m7WA3PqZV2NxcAZ
 I+cg8eUIqet1o+ShRKSxfNJQ2BZUR1tF114E8JtRapM5Z7Lu/d6xKleRFmQN0w3w
X-Gm-Gg: ATEYQzxz6kNSpGL0cxQEC0tO4AeBYPXc4jhi84zjvBetKw4UoXmLsd2eegUB2n4BpkS
 JmXmHpf8KLWQolSFFExnnqmH8JfH7HDHrF1+v1AuDkhM9hfrzCHbXvQJ1VhExKo0nRIq+ChisEj
 JFPhtU2okb5LWK8dwjRF4BS9gz/AJjjmx602Z1SYep+05HMM1GsotgZNtsjad//npOHmy0EpKtn
 4fE0TKn+PUgFSJaoim0xKd3CKCfhcL6BaJa9EXQWGSN+VYuAoheLGd0glzyFfjw1r4yNKSrjqM6
 EA258MD9GDSKxVSXM69pwk7fYPkpQZSfVlfJgfUAhdyuRQEngv63z3xH4ET7zHouZtGnAtlJdKO
 48fs4urMKYa52YtZZixP+wj9e7V1xMO/VTNmAAiKdt/aQpQpmctKQPNBe9jnyJHmBUzhneDZsFB
 LrqscRJr5iSTCVVPuuwbX/XVP/QYwttdbmrX0IspFOBzwGUAJAW8HSJOKF5zpMe2730OCRsJMm8
 ro3yu8P3mw=
X-Received: by 2002:a05:620a:d8b:b0:8cf:d441:c7c0 with SMTP id
 af79cd13be357-8d00103ba75mr736205185a.34.1774477987296; 
 Wed, 25 Mar 2026 15:33:07 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:06 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 08/16] dts: k1: enable clocks in SPL
Date: Wed, 25 Mar 2026 18:32:24 -0400
Message-Id: <20260325223232.1553212-9-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable clock nodes for K1 SoC in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v3:
- None.

 arch/riscv/dts/k1-spl.dts | 49 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index c7196c2d722..a74eaaf6a8f 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -11,15 +11,62 @@
 / {
 	model = "spacemit k1 spl";
 
+	aliases {
+		console = &uart0;
+		serial0 = &uart0;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
 
+&vctcxo_1m {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&osc_32k {
+	status = "okay";
+	bootph-pre-ram;
+};
+
 &soc {
 	bootph-all;
-	serial@d4017000 {
+	system-controller@d4050000 {
 		status = "okay";
 		bootph-pre-ram;
 	};
+	clock-controller@d4090000 {
+		status = "okay";
+		bootph-pre-ram;
+	};
+	system-controller@d4282800 {
+		status = "okay";
+		bootph-pre-ram;
+	};
+	system-controller@d4015000 {
+		clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+			 <&vctcxo_24m>, <&syscon_mpmu CLK_PLL1_31P5>,
+			 <&pll CLK_PLL1_D4>;
+		clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+			      "vctcxo_24m", "pll1_d78_31p5", "pll1_d4";
+		status = "okay";
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	bootph-pre-ram;
 };
-- 
2.25.1

