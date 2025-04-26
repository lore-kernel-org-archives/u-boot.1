Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA9AC369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4043D82063;
	Sat, 26 Apr 2025 19:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="beasXQHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBE08206E; Sat, 26 Apr 2025 19:01:54 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AC082045
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3076B25F68;
 Sat, 26 Apr 2025 19:01:52 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxeNytmIQuNy; Sat, 26 Apr 2025 19:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745686910; bh=GKuYetfnF+soj6H5nL7fz56zoa0gmdWw4lLexjK60bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=beasXQHYaFIyirJMH0pUso6OwOmaDhPLKzDcDTLXUPIWWrJxhNbCoxntB1KgEZHon
 DWxPpAaiSuiMGCm8ns6Lw51qnT6UcA2jaW3UInzfsa5bvO+Qu+SnoNs7NQHVSIHIT5
 BztkLpsPngfcoCUh3atoGP+lKy1LJAiZd7YGrDzCVmv6pbQVU+VzqMCpmffD1EsQYQ
 Y8UDqxL8uy+boL0WK6xglpuVUyinE1Gg68GWMCHPBzvU1dBOqXrZu+Jsp/pAADLM2u
 /GJajhjzBHqxiQcCCqz6l0aj9TKSZ6RfFNMxQingu3uuQronA7qrXgbx2TPn0Q39V4
 /C2vBLbjZhIlQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 07/10] riscv: dts: th1520: Add DRAM controller
Date: Sat, 26 Apr 2025 17:00:56 +0000
Message-ID: <20250426170059.35571-4-ziyao@disroot.org>
In-Reply-To: <20250426165704.35523-1-ziyao@disroot.org>
References: <20250426165704.35523-1-ziyao@disroot.org>
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

Describe DRAM controller integrated in TH1520 SoC and preserve it in SPL
devicetree blob.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index ef84d8cc265..b908eb37e41 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -372,6 +372,16 @@
 			status = "disabled";
 		};
 
+		ddrc: ddrc@fffd000000 {
+			compatible = "thead,th1520-ddrc";
+			reg = <0xff 0xfd000000 0x0 0x1000000>,
+			      <0xff 0xfe000000 0x0 0x1000000>,
+			      <0xff 0xff000000 0x0 0x4000>,
+			      <0xff 0xff005000 0x0 0x1000>;
+			reg-names = "phy-0", "phy-1", "ctrl", "sys";
+			bootph-pre-ram;
+		};
+
 		timer4: timer@ffffc33000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xffc33000 0x0 0x14>;
-- 
2.49.0

