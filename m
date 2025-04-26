Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5A0C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBAB82045;
	Sat, 26 Apr 2025 19:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="l3b7k61V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9D9820FE; Sat, 26 Apr 2025 19:02:02 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D776682103
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A49F925F6C;
 Sat, 26 Apr 2025 19:02:00 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9z50lbjvONzt; Sat, 26 Apr 2025 19:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745686902; bh=GZQo18j6ncm/CEznoA3CQnnbdhARR/apHeIBWI2P4xY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l3b7k61VMqzo0/wWnnP5SqqsSJ+vooyx31Woc0jZyTOeH96kWhwujsy+AcCr4iWIu
 4opPAKKU3xuaGe68QCK12EDaBf/U8RoI6eHGELUsxyhTRtKdHj+NsdPyBXJJy7A8ns
 63XHghAuCuSDISG7VNBVxBqV320+5WAWiiUoNDbJ5o+xqcn3qKlwu3XSGLcdEIxjnD
 EGBjJFpovSEWOf0TDbb070tCRctNNZ0/l5qmGBzV830LQueyccC3v0VDpzJGRDZxP0
 lIYvBu6X07zQiY8KA/s7U+FvpJeRs8OcRFSZNdgSHzUnEk+DviTxLGqiNlcq03tcpU
 5JVFAf2tuJt0g==
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
Subject: [PATCH 06/10] riscv: dts: lichee-module-4a: Preserve memory node for
 SPL
Date: Sat, 26 Apr 2025 17:00:55 +0000
Message-ID: <20250426170059.35571-3-ziyao@disroot.org>
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

Memory node is necessary for TH1520 SPL to configure size and base
address of DRAM. Let's preserve it in SPL devicetree blob.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520-lichee-module-4a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/dts/th1520-lichee-module-4a.dtsi b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
index 86a81bdcf77..20dbc4c7d24 100644
--- a/arch/riscv/dts/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
@@ -14,6 +14,7 @@
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x2 0x00000000>;
+		bootph-pre-ram;
 	};
 };
 
-- 
2.49.0

