Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B4E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B799584248;
	Tue,  3 Feb 2026 14:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Q56Dp/Re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C931840B1; Tue,  3 Feb 2026 14:09:21 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B928483FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8B11F27673;
 Tue,  3 Feb 2026 14:09:14 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZ60vpRdBA46; Tue,  3 Feb 2026 14:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124154; bh=ajz7dNYGtZDQySyuAFhoj1g1MU9h85oJSvIVpIwdLE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q56Dp/ReTtXdzxApKit4pSl7bSa37D4Z8upeHcuJgRaDUEd+fd1T/WaLHdpTJlDvH
 IbXaiuavZSMyRBSbFHdMThCZjmkw3OPj8qxNXbjzR/prCuC3Fidr4Ars1tpNX6Z14U
 AFG65ToKosv0+ehw+qR9a0KGag+cdOSlV4EKAgQa6XTkMpnJ3PpHOqM/Rs8hboHer5
 C67cVFqwu9HeorqfzxPiKrGNvcDlK5+5cjT8s2JSbUyojE/sKLBlK08egjWY6wFqVs
 0fES/cAHuUozwLLrP8tSw+sPvTvUGyXY0x2o7pcOF4tJFEtlJPT/Oj59c2rhUQUqdT
 o4Q18kiCF99Ug==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:47 +0530
Subject: [PATCH 09/11] ARM: dts: exynos7870-j6lte: add properties to make
 S-BOOT happy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-9-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

Add properties in the DTSI file which is required for S-BOOT when used
an external device tree when booting into U-Boot. S-BOOT is Samsung's
proprietary bootloader, which chainloads U-Boot.

Since this device has multiple bank nodes, add memory nodes for each RAM
bank. This is the format S-BOOT recognizes, and (re)populates it with
the correct bank sizes.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi b/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
index 9d944b127ee..aa499ecf479 100644
--- a/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
+++ b/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
@@ -4,6 +4,11 @@
  */
 
 / {
+	/* These properties are required by S-BOOT. */
+	model_info-chip = <7870>;
+	model_info-hw_rev = <0>;
+	model_info-hw_rev_end = <255>;
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -18,4 +23,24 @@
 			format = "a8r8g8b8";
 		};
 	};
+
+	/*
+	 * S-BOOT will populate the memory nodes stated below. Existing
+	 * values redefine the safe memory requirements as stated in upstream
+	 * device tree, in separate nodes for each bank.
+	 */
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x3d800000>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x40000000>;
+	};
+
+	memory@100000000 {
+		device_type = "memory";
+		reg = <0x1 0x00000000 0x00000000>;
+	};
 };

-- 
2.52.0

