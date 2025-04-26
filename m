Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B4EC369D1
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 16:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7380C8206E;
	Sat, 26 Apr 2025 18:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Uvj3wi3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44696810EB; Sat, 26 Apr 2025 18:57:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FB682063
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 18:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3037225ED7;
 Sat, 26 Apr 2025 18:57:39 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4640qrobRqOw; Sat, 26 Apr 2025 18:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745686658; bh=3dzUtVuUxk4jfenqGeXgcZuMERNyB4OlgVGfo1XwcA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uvj3wi3gGbcWpQ6adfSKF9NOZA9m0tsOr297Ql8MnAZBq1ry9YIKRf+3yk4oHs0fB
 /LI0pn0qMZvab2dmkLxzWirLfuSXC5JVSag2CCO0YZZZ2cGOFh2ghRcHX0YjOk7kyu
 kTs87iJojAUWIQtQy7i61YCJpjX9UwNaNa4P/ZRngO+7S8HKlVSPMS8JB5j8cx6Bdf
 6oP/GM+H4OYWeCvCc6zAi9eTpc/CVPXLM9DAWIBKHMy/xs60MwP+wVSbU99LMWduIq
 TDDAKkH9CabQ74gSO6G1iYTidRZa8lkTUkbXgVBdyTHa/OH9BzCzsuFtGICfmAQe5s
 UlkXikJQdy48A==
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
Subject: [PATCH 02/10] riscv: dts: th1520: Add clock-frequency for UART0
Date: Sat, 26 Apr 2025 16:56:56 +0000
Message-ID: <20250426165704.35523-3-ziyao@disroot.org>
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

The BROM of TH1520 always initializes its clock and configure the
baudrate to 115200. Add a clock-frequency property to provide such
information without introducing CCF to SPL.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index cbe3481fadd..e4c8cee66bc 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -175,6 +175,7 @@
 			reg = <0xff 0xe7014000 0x0 0x100>;
 			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&uart_sclk>;
+			clock-frequency = <100000000>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
-- 
2.49.0

