Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08486C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8286082A7B;
	Tue, 13 May 2025 11:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Ulg8h2wI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C4A82A7B; Tue, 13 May 2025 11:07:33 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D13982991
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C2A0D25BEF;
 Tue, 13 May 2025 11:07:31 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qp9P1ReAIyfD; Tue, 13 May 2025 11:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747127251; bh=GLBZ0nzYwAmNhwSH6Pd3RVKclVUtp029OqxWkgharac=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ulg8h2wIJJ6k/NPMqZqT3QbALp7DdS/YLJXxzK7Abk67gxl93CcV7IPpQU+XjIV7i
 +m5GLR24SVU0dad5576hmZrjmji0CXSnbd1kT8Akl1Hz6nYraoCRQ1kgpE+o6S1CnU
 c8tCZ4gJxXPS/FfCxwLRjCTr3ljMETHZPBRY7sjVx94cqOZN0xCSuh5PEFqgje1E2P
 7vFcS+w0qqx3D7xlkGR7XVTQMIwU8w39ND1IAqeLvYjFMu+YKTL5ncxfzxWsd2zn+a
 n0DFHAlfG84odo/cHibYnEgm6c2uKsBdVS1DtwEXhYOpYQ6ZYbudCohZE/OYjtPfSh
 Mw1VJCO/61ZTQ==
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
Subject: [PATCH v2 07/10] riscv: dts: th1520: Add DRAM controller
Date: Tue, 13 May 2025 09:05:00 +0000
Message-ID: <20250513090503.46670-8-ziyao@disroot.org>
In-Reply-To: <20250513090503.46670-1-ziyao@disroot.org>
References: <20250513090503.46670-1-ziyao@disroot.org>
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
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/dts/th1520.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index b34ac323503..4a523f8048b 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -371,6 +371,16 @@
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

