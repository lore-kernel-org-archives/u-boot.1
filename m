Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC4EEA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D7383DEC;
	Tue, 10 Feb 2026 16:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KODNkt9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F2483DEB; Tue, 10 Feb 2026 16:15:37 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D376B83D3D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-896f8feee14so26694906d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736534; x=1771341334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxwoNAXBchBGwKkkfE6HhqVQ931k6OijhfNrqcOWvjw=;
 b=KODNkt9noNyzdfURNJgLPt5WuI3xr+wOc/Wk7O7/fP0eCrWFvvsSl8mkrqHHndQ38H
 S4I46Ng00qEksUqe9WXnr23b0hsdr7cv9A1Ikc6dK/ZvBQ/pidpzkqg9SUDPO3f0IXde
 luJQhSAtM3wrZxcy7HnmvX/s8/Or41sLdDrZvvcDX5XK65rXt7u0zhgbVomvJAL6Dqy6
 8k86SdV0xTkacKqYWC9B1tMIM0WK1uL1KoZwCZTDgHmp6Hx1HbDSMXYaQ0w/zLarR3g6
 ZuneDiMwDteAsA0yMLQz9O+GDStRZGFefEZVbUkBZIMbdDPWW6/Os1WQIjFiAAg+OjNo
 HPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736534; x=1771341334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IxwoNAXBchBGwKkkfE6HhqVQ931k6OijhfNrqcOWvjw=;
 b=DtEjvrdg3BHm2Du0t/d0qV7Kg/cKEb3Ol7j/XgEJEP1Z4HginadR+avLac9KC+wRjy
 c2Yt9cFiwdHExc9mQPWN7473ei5CjSoRt0Nz/u2Yr+zV58joM/blNagqlz+tWjADwqxA
 LJDirwwj5eisfJgUEnrewMn7uHvc7TTHvYXZ4wDj92txk//9gNWgc3xdpg2NMjrLL1MN
 WxzmH7DGZum4hf2jis3077VNPnsXhEdYO01xoHTnaPHb98eBopFZwRpiHQQxmiC4kGCj
 qVosPlX5EMkevjE3xNM4/uoyYQ3FW99BWmqzyqi4kOz5OaQ48YBvQUAfuHp7jtJ+9GA+
 0r9Q==
X-Gm-Message-State: AOJu0YzjzHWdigUUVPdoDO8uy6CBUBYV29mSoW9c1eCR9BZAATo+vI5w
 YT6CXYmieVw6zSVMRO/6VC1QDGNOKYCsWV98wJb0Y7GjAeRj3MhTmy9bxLyJfA==
X-Gm-Gg: AZuq6aIW7FL3uMoAm7YC1o5iIqABzcvd1F6OGKC5ciPMPIfmEJl/XANjsdDbzAKZGab
 jV8FWZ3c8yXcWZOsEGvTEH6xY1e8yMzhpBSYfTWf3dEsbGA3XqU7HhbaIlApHDGQ+EO/21cctRT
 c0ks3dX+dnHAhYtdx4r3ko6BIcpfR4lqXmO7YnbHN9yl0hvajm+39bZXvQRU80sLpXntRXlgw3M
 QhPWyTsJ02vBiCtSoOKnd9s+gCzCW2CcGZp6XFecldoUb0GoKoD+2VIt/SDAXQXnm+tTwCl0Bj1
 rCPoVip5dvc8Buu92jL2Ouezx+VTZmKjTcemcdewU6YXMrBOfTEaJMcg2Wmy2hZ49zhjy7mxgRl
 GJMr+VmFavkENrl3Mt9JIO5JjpBFMJ1KyUj41L4CIMOcwFwapKPqEOi08nOUxXA4M453yDlcXqH
 MHhbxQIOk12if4vit4vJB29w47akdTl1nXzbXA25JiaRXNMid+8h02xCgLTdUVK64Zsfra0tPTn
 mW2KrKcWGI=
X-Received: by 2002:a05:6214:cc7:b0:894:6a89:5ee2 with SMTP id
 6a1803df08f44-8970e2a4c60mr31007516d6.31.1770736534307; 
 Tue, 10 Feb 2026 07:15:34 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:33 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 08/16] dts: k1: enable clocks in SPL
Date: Tue, 10 Feb 2026 10:14:51 -0500
Message-Id: <20260210151459.2348758-9-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

