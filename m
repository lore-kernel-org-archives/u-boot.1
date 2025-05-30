Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CD5C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E18583236;
	Fri, 30 May 2025 11:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QQtgK1Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5EA83214; Fri, 30 May 2025 11:49:23 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C727583236
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 94A8625D34;
 Fri, 30 May 2025 11:49:21 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JTfXqh1e-Rt; Fri, 30 May 2025 11:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748598561; bh=WHPn3Ppa4OdRWCvvik+cdkkguQ8Nvqz5Kw0MuqPqKJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QQtgK1JwrA5Vqzh3xW2n8KK1vdzqtQ8ih/oPE8D3k2PheKyI9eS5srxbz7bMrXhwH
 L4anBzxN3Km6AHsHMSUWt2X5HLEuiVNVYpGQK4ZB+m758c13TgkZlcBLtRZ/uaJlyo
 1RisinrapMr9QoMz6L1lv+Jd/9Rop8Jwk88WofXyMELB575Y51fdQgPmlGL7dhFHZX
 Ztl5Yh6BfGFZ+k0VTXWA2VD0+KHjheWyS1MHecEboeBTaoMDZu2vhlNvn4rGI9AVN2
 3W0J8SFpB93fyn+NaT8/x3K2Y8ccSxbfoYSxXkm1+tT/gii7/pYHHWvS7ezpi7GIs4
 57+z5muwasImA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/5] riscv: dts: th1520: Prepare binman configuration for
 loading OpenSBI
Date: Fri, 30 May 2025 09:48:49 +0000
Message-ID: <20250530094851.57198-4-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
References: <20250530094851.57198-1-ziyao@disroot.org>
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

Add an OpenSBI entry to the FIT image. As it expects an FDT to be
passed, corresponding FDT entry is generated with of-list as well.

As SPL now passes a full FDT for following stages, proper U-Boot image
is packed into u-boot-with-spl.bin without a devicetree copy included.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/thead-th1520-binman.dtsi | 32 +++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/thead-th1520-binman.dtsi b/arch/riscv/dts/thead-th1520-binman.dtsi
index f060639e1c6..7b535e8402c 100644
--- a/arch/riscv/dts/thead-th1520-binman.dtsi
+++ b/arch/riscv/dts/thead-th1520-binman.dtsi
@@ -30,24 +30,48 @@
 		fit,fdt-list = "of-list";
 
 		images {
+			opensbi {
+				description = "OpenSBI fw_dynamic Firmware";
+				type = "firmware";
+				os = "opensbi";
+				arch = "riscv";
+				load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+				entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+
+				opensbi_blob: opensbi {
+					filename = "fw_dynamic.bin";
+					missing-msg = "opensbi";
+				};
+			};
+
 			uboot {
 				description = "U-Boot";
 				type = "standalone";
+				firmware = "opensbi";
 				os = "U-boot";
 				arch = "riscv";
 				compression = "none";
 				load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
-				uboot_blob: u-boot {
+				uboot_nodtb_blob: u-boot-nodtb {
 				};
 			};
+
+			@fdt-SEQ {
+				fit,operation = "gen-fdt-nodes";
+				description = "NAME";
+				type = "flat_dt";
+				compression = "none";
+			};
 		};
 
 		configurations {
-			default = "conf-th1520-lichee-pi-4a";
+			default = "@conf-DEFAULT-SEQ";
 
-			conf-th1520-lichee-pi-4a {
-				description = "th1520-lichee-pi-4a";
+			@conf-SEQ {
+				description = "NAME";
+				fdt = "fdt-SEQ";
+				firmware = "opensbi";
 				loadables = "uboot";
 			};
 		};
-- 
2.49.0

