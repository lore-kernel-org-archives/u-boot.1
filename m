Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53D1E8536E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D87C84129;
	Fri,  3 Apr 2026 15:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pes8Gew8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F9284150; Fri,  3 Apr 2026 15:52:32 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C9984129
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a04f39d2so2860755e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224349; x=1775829149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6gNfR6ZZoUTpWaJRQqYzHmkEbA4ySXi1SJflZ4cFIDE=;
 b=Pes8Gew8J90tIMJxNYopbPzGUXFCCCS+0A3Gulo5WVrdbWw/Px7LR7kYScuYeqgUc3
 hKbzLeEDmQ3OS9J5c66EsHnOqQGE2TZkCL6XVz/XyjljQczhcqVxFNRmR7oIUjcen86U
 Hc7v1RLW65XtKYq1HDrUw5xfWxvYVWN1ULpIzQzxRos6GAhc2LF8Yvz1XpdgR6j7sLUi
 koqe7KKMM5g73I0G42vzwGGXknvvyN0bWaGvuJuH/YQB1f/s5lpMSvNT1BI5LyWaVy+n
 3URjzHGyPrjLa7QbcuS5e8dMFqYRkpe2HUKf8SjsyW6cxeCwolaWFoAdVqOsyvNLxdy9
 U/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224349; x=1775829149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6gNfR6ZZoUTpWaJRQqYzHmkEbA4ySXi1SJflZ4cFIDE=;
 b=d7kwFzsBRIyZHtODGFgQEEDFfjU+oGjpfQUYAgThrDNjlkW7DGwwcGBdYtjXEkDvT3
 WeE2qVQIxs3uEh+QoP+WX+i3/SW7SShpbFKzMqz8bIW4Hzbj+hrL3OurJk7o/gNK9kMq
 pkikhxh0KXN20xJjwyHpbHGCh3n9CvYIWITiATHTUJXvj3qzSOUJTpGQqT9CjNxJMDZ2
 aQ8jNF2yc0X/APIlYTX1F4iY9TNBuy3Cd7dF71Aa5GDCfG6Zeflb+A9aPZYFq2KkQJfp
 PrlD8aGF6oH7bAb+c5EQByf7nmdkuEboQ2Hae6I90ao3T3d3xlU024lWkuaXOIxZGxKm
 ywUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiKB4mBA99n8jnCUB+0s6xduXW8K67PedNuRpn5Q57BWnKq5kVcmryOdFwpA75OP+Tqh/5YyY=@lists.denx.de
X-Gm-Message-State: AOJu0YyhBvNGsKz01ktEvBen+ooR5TFsV92ZAx9cs6FEE+kTYGB5MqFv
 WvmAmhBzpqrY3+2UUKbWtwfFx7ks/xawx2jW1JVjF3cN/ZjQXKfnyk6D
X-Gm-Gg: ATEYQzzSrVNy1M3Yo+unkWlqWKd8lwcuRLjA/3tRUjjr3k6/QuO+is7Y8/9Bc+luNsd
 +npX5I4Mq59B+keTFxFQ3i7cGdhfyofyF+TAAQQh32bvlPqV/EIvPEoq24ci83/FpT4wdtEodXY
 1NjU+nQ1cxMxvxRA5uFEiSDuDdEYa/lyIpLikcDU4EAfrfxotTz8kyA2x2O3cmEDbosv2JnNRrv
 XLlVInjj3rnP98Q6Mm88+6UP0CuHyXy6QnOobKeFYqNk+TyfvZVo9zmsBtRX86A8retu6BYOUtk
 Z7v9/iuBLPScuawThY+wsWnmMAMK3LcTqYQXHnMTkCgti7aQb3IK8FtnZ88H6RMh4wgjhL6gPNA
 WU1PEiqaR4iYWXI5XxB7gObKrpj+5S4gBXfFt81+8JEN6N4wfjbYX4dCwxp/swiquM5Z8cNRjct
 RdAdJhNkonlnQfsm/sdsH3+ZU=
X-Received: by 2002:a05:600c:630a:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-488997eed8bmr49638255e9.24.1775224348765; 
 Fri, 03 Apr 2026 06:52:28 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 6/6] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Fri,  3 Apr 2026 15:52:03 +0200
Message-ID: <20260403135205.26979-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403135205.26979-1-ansuelsmth@gmail.com>
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
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

Update documentation for Generic Firmware loader, generalize it from FS
specific and add new property and example for FIP loader.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../misc/{fs_loader.txt => fw_loader.txt}         | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
 rename doc/device-tree-bindings/misc/{fs_loader.txt => fw_loader.txt} (77%)

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
similarity index 77%
rename from doc/device-tree-bindings/misc/fs_loader.txt
rename to doc/device-tree-bindings/misc/fw_loader.txt
index 542be4b25a0a..44d9c076ebb8 100644
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ b/doc/device-tree-bindings/misc/fw_loader.txt
@@ -1,9 +1,9 @@
-* File system firmware loader
+* Generic Firmware loader
 
 Required properties:
 --------------------
 
-- compatible: should contain "u-boot,fs-loader"
+- compatible: should contain "u-boot,fs-loader" or "u-boot,fip-loader"
 - phandlepart: which block storage device and partition the image loading from,
 	       this property is required for mmc, usb and sata. This is unsigned
 	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
@@ -12,6 +12,8 @@ Required properties:
 	   required for ubi and mounting.
 - ubivol: which volume of ubi the image loading from, this property is required
 	  for ubi and mounting.
+- partoffset: valid ONLY for "u-boot,fip-loader". Offset of the partition to
+	      parse the FIP parition from.
 
 Example of storage device and partition search set for mmc, usb, sata and
 ubi in device tree source as shown in below:
@@ -46,3 +48,12 @@ ubi in device tree source as shown in below:
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
+
+	Example for FIP from eMMC:
+	fs_loader4: fip-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		phandlepart = <&mmc0 0>;
+		partoffset = <0x100>;
+	};
+
-- 
2.53.0

