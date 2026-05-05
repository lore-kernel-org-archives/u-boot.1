Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED2FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 16:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2918497A;
	Tue,  5 May 2026 18:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IuZn1fif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E498F8497F; Tue,  5 May 2026 18:36:28 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC22484974
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 18:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so3563943f8f.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777998986; x=1778603786; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J1vgrSdQo9Ai9LE1dyWR6t0tMAFpUgJSTS1lsSAh5eg=;
 b=IuZn1fif3LlH66JxmNOWPqeBEJm0824C6DErTvZPxKc7uqNdNKsACsXW3bcZH57Jf7
 EA/bY6xVz4KdVhLVE54zLqO/OI8c8PeL2uFYKDBfPga0DNK0CaJ1NJfo31imZly+lG8b
 mYH889aT/rIzCHHDgzx/ibquZuJKDeNhPFB84Uo+WDLnd/htAURGOURFFZWYhScPM89z
 FDJ7J41hR8h65hI0kCHSc6ZoX649ebpVRYtmmlnKGiZzY20DItnutR7sEAnVQlKbVD07
 PFoMsYOAXWPeFb9CpWwcRF6qZ1MSakQd8Y2pfG5eBEpvkZKm0XJTn1gmf5V/bTsy4rTi
 XFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777998986; x=1778603786;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1vgrSdQo9Ai9LE1dyWR6t0tMAFpUgJSTS1lsSAh5eg=;
 b=sxH68p26zT10BCo/b+iNG7werM7CJhu5TDT4M5G/lb6qXSC6W4ZSkE1xYQR4AUF2R6
 Rx0XdVGe5JgexKfiWzPgs546MJkewq5o0+MYUM64/ypSo8SthUHc6bIwJp8FikcX4b7U
 2kT2Slj8slUOu2kH2xOWSzFzkNSSvlp5agaFbU8dY/HkqEfQtmbEGr27/CBUNTJxd1ul
 QuYxviCz02ZD9jKb4A/Kcn3mBGKE/2h11LWSNw6adXYKk2bo0ZqEJmZZ+5LTM4qr0Zvm
 U+s36ncCS8F6DXLwwhthhKMy4OlLPx37j2tO2Z3yIqQyFwvHyoxI3oKdt7b7p5jpsgjL
 5tkg==
X-Gm-Message-State: AOJu0YzNNVJf67pPjjvr5pmsK5H0PqtCumZEH0kzj1qsgzYWJ1Op6cPX
 WJyoBi7+em8Z9imeayykW9K/r9D3Ejx38NQYSRhVecw8BWeglkdUaOwb5kcg0brc5nU=
X-Gm-Gg: AeBDiethgzuZeD+vJTmaoYZWJPKxShlgJzi9X5w6L5mWGlsnPWw04emkVJ9YaswyBVo
 5QiF/1dTeXO5UcaAYOnPHhPFON45YKgzAerUam+YGV4aqfiFPfR4QfZ6jU/4A3bwtF9AJK9ZECu
 f0jnlhVfMu6yEXJ1kVJ52RYLGoxwvOVIYDeG1FwYe5zhoqk2mIw+umYluW5QDwkjmb2z32AyKHk
 2qOjmTJCskL4vHOGwH6blykEEsv3Uds2mZm501gwLN+z9W26y3kIIkF3nrKHJMuDegPWkCe4WF3
 DeDhs6iFh2qrr85qVbZSLoZ9ysbvtft/H+SuVe4J6WA+M8iOcChommKc1ixXcNxTFRjAf8zWSbC
 g2vBc/YPkCI7kKkK+CVwMpFwEJyp6V7V9tMiywsrzLnT1uIiTdND8a3jXkr5eBS3J/mqxpbSGwO
 hXOVXu9jhAtlrukipSIMRScVtn4vBnfxaS6YxtHX5Mxco7jRK7nr5xfXwRzdPgRnTS66VwVP1kl
 xtufaXESQqARPEcbu+Uhx6ZN8xMxLdauhH5ww==
X-Received: by 2002:a5d:4d0d:0:b0:44d:261:54c5 with SMTP id
 ffacd0b85a97d-44d026154e5mr15138606f8f.30.1777998986109; 
 Tue, 05 May 2026 09:36:26 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a4878fsm5546326f8f.9.2026.05.05.09.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:36:25 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 05 May 2026 18:36:24 +0200
Subject: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
X-B4-Tracking: v=1; b=H4sIAIcc+mkC/x2MuwqAMAwAf0UyG6hC4+NXxKE2UTNYpQVRxH+3u
 BzccPdAkqiSoC8eiHJq0j1kqcoC/OrCIqicHWpTk7HGotuoQ79vkwZhzHTxRmZqyJJhaT3k9Ig
 y6/Vvh/F9P9msHrNmAAAA
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Add nodes to the binman configuration to create single binaries that
combine tiboot3-am69-*-aquila.bin, tispl.bin and u-boot.img into
firmware-aquila-am69-*.bin, with the proper offsets.

These binaries can be used to flash U-Boot via a single binary of three,
as it is done now.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi | 66 +++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi b/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
index 63b37e522927..f91cdf15aff3 100644
--- a/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
@@ -78,6 +78,72 @@
 	u-boot-unsigned {
 		insert-template = <&u_boot_unsigned>;
 	};
+
+	firmware-aquila-am69-gp.bin {
+		filename = "firmware-aquila-am69-gp.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am69-gp-aquila.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin_unsigned";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img_unsigned";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+
+	firmware-aquila-am69-hs.bin {
+		filename = "firmware-aquila-am69-hs.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am69-hs-aquila.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+
+	firmware-aquila-am69-hs-fs.bin {
+		filename = "firmware-aquila-am69-hs-fs.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am69-hs-fs-aquila.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
 };
 
 #endif

---
base-commit: 57460fde4ba84d67de4066ee1141e89e8139ed23
change-id: 20260505-am69-combined-binary-dd676560de8c

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

