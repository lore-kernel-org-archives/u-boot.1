Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8522CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2790660776;
	Mon,  5 Oct 2026 22:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-4lxX7yv7Tk; Mon,  5 Oct 2026 22:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0EF0C606E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791238279;
	b=BayYvnJ5s4uYgRcJBzzh7VGOFHNs/LyiHND6r+HZwZF4HXYcq/tu1EpVCR2mQk9NyWPm
	 I0GD+HOBeXLlPveTgmrA53b1orPmYd5md5IMVOOJyDnUWtj8NKQumOYOEJGVJJfrG0gqu
	 knDSeovOBj00hTRtWIlzKfe9P/w1ygkfiaPAbeoWKVHI8GsHZL0QZ45EjR2hArafciqX1
	 bZrd8nKYRCZcXPTc+Slw57o59fz0hJKER+9ggeF8/riXFaKxtQtxNH8vODcbRrh+VSSnk
	 yakgXGizTypIjHcRreirTuP+rajJOEkV/Yu7nMxWt5p54pKs68ePZ0fs3N+Ev9WmGBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791238279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=86FzSqyBFs1ikFZbHc3uCzpvPiG9xoVdbjAzPtXLTBE=;
	b=ao/PsjDHOoqXMmyinhC8YJVn5Y1wl3llonSMjMfezeFDAqJdvulFIYg5jgydz966SDLq
	 rEQvUaJF41zBH+LEchan9FPS9V85EkbzWGe95WNSwfpZ5gthbLkqVJPVdPy+46kYwbcJu
	 pXzwUTLsrhifBDT+rPEl2HPjmdCE30Dv9yEEcJThYjiduC2+E546NF9JmKTFn9TeM4FbT
	 dFzp/6oLrNP0LAjvGw/MZMidqQK86oFz86T4PnCAOhhgZY/tYphtOxd40iVAFfV5WiMqR
	 qXz4tUrMkt+CfT/byMFYiQuy2ncNCHAQHw9wfQrK83y+7EN3jI4xndPIqAO0Mg32uiA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791238279;
	bh=86FzSqyBFs1ikFZbHc3uCzpvPiG9xoVdbjAzPtXLTBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/AF6xJSoY5UAP/ffzoRpAbuwrxLvZzwiBCXDsrrJ43fQ6BU4WkkTx8V5MsOrOF9S
	 TOeqJlBHi5CimqgVSVk8UxObmGu9NXaMcSUv3lBVDAoSVPe6ook9fKfuUm/pZJIqub
	 Cul8Q5Gbyh6E1uDb3bvnSozZDG0krZCG1cR7gvfL6fh9u4TcI1Erai4ThDCBECROIj
	 o4LAVkkr8pJiUHmeXpej6e0iHTnd2xSSAT6nLB78j/xVQax4G9EogehVoAyAUIUpJ+
	 dZBC2SroazUhj2RNeoZzr0MBCgkC1/T4A06nKCdQQBo8wdeiY8THVSjqlJMz3/IOrc
	 LQOWfbZYG4b7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EF0C606E5;
	Mon,  5 Oct 2026 22:11:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE93934E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9332980AA1
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0jJrC6VY8DxR for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 85BE480A66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791238109;
 b=mbJCent0P65HsTFAwa0MGwPj20+h3wmwX3EXPbq7/NtPSexOWvYVHgAlpitZfLT9/g7C
 CMFH29yR77ClDtimLqHUZA3AdWQGSWjzrltHMEaJJlWg9tP+O+0nYScthNvsVueZoZbH8
 ICxsTRlMGnz1qRDOiwLfEES7YXC1MT4lHDhcp2vLMg61qk5xavpH1Bm2x0YpAucjI7L9t
 uuxC5sSPOmt8V8eNvxT0R9RoOxamyuVk18vzIjp4j9SNzaoYoeMhjvVon9bLS8tsOiYnN
 CnJXxweUnO9r8SPyxDZBrHy+m67Sp+OxqGoOAwFjRfM3EE8TAxZwRZqAlVVdXmDT/Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791238109;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=86FzSqyBFs1ikFZbHc3uCzpvPiG9xoVdbjAzPtXLTBE=;
 b=DAZxo1LWbwYpkmZ41q1aAe92vATeRTrXFznZuUvFPYkMwQLwtjb5IRq9ySiXffqbFolB
 KwPYaK3PLdsScA1yHuKkQwoRZ1N966pyIjQf5sYNrSORAhHe+Mb1K92G1HXX8J18xxtQs
 lMrRlqxBWxexNjK73983dQVa5RgGRX4RLwhKR5LCsYHtdI8apDeV9faI7MjctZUfnI98f
 n0IHPv+ftqjsEdqtoW+RfZgUc8I2wSkAK1yUeuXSoYqnHeyuOhkiIZHM0djbHdTC1Cvmj
 JUE+NtOybZilKwPi2ky9qVF7Gp5oPci90UhxEnfhnq0Tr6IF2nEYWEGMGWQs03VutZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jPVcrq5c; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jPVcrq5c
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85BE480A66
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:28 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-823d139c181so1730534a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791238108; x=1791842908;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=86FzSqyBFs1ikFZbHc3uCzpvPiG9xoVdbjAzPtXLTBE=;
 b=jPVcrq5cDD4J+ijwFOsbSQrfpVKrpS7OyTsxqnzXE8UZiFk5dqdP7S1yJRJ1CKnFsP
 MctqlUI2EcR/tKDjkTN5RyyfOPv9Cu2C5+NG8yABu3odIbe3/H/cRPeP4ME91d5ZteQL
 qYATz6gMey/Ctyh7CtWv1OZjAymSRctf2YlOAo6lLvcw+ikfoWlCnNVU3JVZdSMSUtrX
 b6NnTTsRF40n/qDVMxx9KGQlGfwoY6JTj8MhIFUJmnD5BQyVKdW6YPKTCbuVg3uX0sz/
 VbsgTXV43Dn+E1Acs1khi1h0p0bohgSZA7GbxdaEruP/cwJ50BUuFp51Aw9+Szr/yc3i
 F0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238108; x=1791842908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=86FzSqyBFs1ikFZbHc3uCzpvPiG9xoVdbjAzPtXLTBE=;
 b=2i4lBRtGsVcOoWrYwrnu40Q0S1i2bEE8PxEZo5p63jip/5PPC+XKgQHYIi9LD77EYa
 3mW8V+IH9m8A6o7sCQqRICI79DiT3lzhDY80bCzRsNBIRhqCROWSQnx6X/mmq4g27wfB
 ET4qUtJ1VWzP3T6WGU2TJ5EBwUXbcXajK/xgEpUqBKlW2Ez0Pz7XoqcZ/kCfc6PtvPp2
 WZPxp72tW8Nx1NYZwSMNrMfs4a1prRohT/xy04NStxt0c2jjhEi7G31dLLMoCpXakcgP
 pXd82WHkc6iVmwnDZc+jKXq/O3l+zag0HycIMtWxAfaKt+/UXXBg+s0td2Y3B2nP3WR4
 h52g==
X-Gm-Message-State: AFuF++nxhCArjzfBkg1xsE/e+WB07gPTIZbAtAkS1rasSZrO0zXpP/NN
 0NbBqOM0g/uCRYaN2o5fil8XwF6JQM0cdbJXY7xp2yxYpGpHawV0mw5jtiJOiVVcZes=
X-Gm-Gg: AYBFou11O+/kKnpc9zq38x4SWttbEu5MJcXY7wH4T3EYr6uSk37hEJ+7G6p80Lx7Ei/
 1K910hw+xwO5byFhOLv3hYM/GiRsG1dl8zctb1JbXJj3MrT5K+UuN3IXU6JR2Xq9Sjkr5fn1Mxx
 dIicaQq6ffJOzhODIAx+Rvl3GKto2nulrNTcC7UQSLo0wH6XPwrwi3xFKUv0tdgBJ5B/OEOJiRO
 l8jGtF0HrsLBN7zGm+y2Pv9IBXKPk9xkVRaZ6V6xniVIDU05ksDEIF+41rAKZI5ZSHoawstb46I
 FNpx5XpWNfp4YipqXU9WxMPvB2cUyIoT1Fd0Emht3aiVLfH8Nbde/n+DQ+l6ow/u+js6Wp9rfg+
 4cXoLTRtxadu8zUlGAcuUIeo704ZXlRIhy+mZtmLV/oshDZ7uNDFLtggF+uI5QENslKx97h1djh
 naYOzsS5vIVZGKVGTuJyorpy2KXbkDTrYa9/0ri/qaNKrFtRlDOnxVtU1vgPxjxBmDhrKT1wmng
 AA=
X-Received: by 2002:a05:6820:200a:b0:6df:428f:f17f with SMTP id
 006d021491bc7-6df42901d69mr10755731eaf.47.1791238107740; 
 Mon, 05 Oct 2026 15:08:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8281db4582esm655718a34.3.2026.10.05.15.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:08:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:07:49 -0500
Subject: [PATCH v6 3/4] arm: dts: mediatek: add Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-mtk-genio-360-bringup-v6-3-630f99bf3ce3@baylibre.com>
References: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
In-Reply-To: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13528;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=XYBpESs4eHcYsjn0e6N1amEJ9EY9ae5mTyRXvdEYLCM=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLKOyJ/aeFGV1ZFXyNRxvuhJzaR77qrn0pTSHG5xx6yLe
 D/HL4e3k9GLhYGRi8FETJHljcTNeUl8zdfm3MiYATOIlQlkiphMSk5qckZeapFDUmJlTmZSUape
 cn4uAxenAEzhhRb2/9XyJdIaJlp9KTn/5U+uXqnD55ctmy6vrN9s83XulKKAXJYJem84dn69l7z
 sQ8hli1NOnNtkGKOmdhppV3rUW1w5pHh/9ZQ1UfcYuAMf+vDneGry2X1JXdsd3mj+Lax+4dyr/N
 vy0rhn1eQoyzpacLAr+j1kkHU8Khk+rzjX2C/11rRlTfOd3OdoPPU5KBDlU7K15HvH4eMnZadc4
 rmTyPPkQdouabb9cYsfi4i0yKY3F9jyRwtWpyXKXkh2n7bFqED5WVTQpY9Nf6QefDklv+T33O/S
 VQXR32aFyf3Vmmbx2GHbqeSSXcrzmf9I1E7xm1fQcC3m9tJfc4NmhGj3sH720g8PWuWw37TbYBs A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a devicetree for the MediaTek Genio 360 Evaluation Kit board.

Upstreaming of this board has not even started yet, so we will have to
carry a downstream version of this for some time.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 509 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 3 files changed, 524 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aafa941902a..6759224389f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1069,6 +1069,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-rfb.dtb \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
+	mt8366-genio-360-evk.dtb \
 	mt8371-genio-520-evk.dtb \
 	mt8371-genio-520-evk-ufs.dtb \
 	mt8391-genio-720-evk.dtb \
diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
new file mode 100644
index 00000000000..37618b8605d
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include "mt8366.dtsi"
+#include "mt6366.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &eth;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* 4GB */
+		reg = <0 0x40000000 0x1 0x00000000>;
+	};
+
+	firmware: firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		/*
+		 * 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	usb_p1_vbus: regulator-usb-p1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-p1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/*
+	 * Panel VDD and IOVCC rails are switched by the same enable GPIO,
+	 * so both -supply properties on the panel node point at this one
+	 * regulator instead of duplicating the GPIO across two nodes. This
+	 * works as long as we don't care what the voltage is. Technically,
+	 * there are two separate regulators though.
+	 */
+	regulator_dsi0_lcm: regulator-dsi0-lcm {
+		compatible = "regulator-fixed";
+		regulator-name = "dsi0-lcm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_lcm_pins_default>;
+		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm0 0 500000>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&snor {
+	pinctrl-names = "default";
+	pinctrl-0 = <&snor_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&disp_pwm0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pin_default>;
+};
+
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "startek,kd070fhfid078", "himax,hx8279";
+		reg = <0>;
+		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pio 63 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel0_pins_default>;
+		backlight = <&backlight_lcd0>;
+		vdd-supply = <&regulator_dsi0_lcm>;
+		iovcc-supply = <&regulator_dsi0_lcm>;
+		status = "okay";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+
+	port {
+		dsi0_out: endpoint {
+			remote-endpoint = <&panel0_in>;
+		};
+	};
+};
+
+&mipi_tx_config0 {
+	status = "okay";
+};
+
+&mutex0 {
+	status = "okay";
+};
+
+&disp_ovl0_4l {
+	status = "okay";
+};
+
+&disp_rdma0 {
+	status = "okay";
+};
+
+&smi_larb0 {
+	status = "okay";
+};
+
+&smi_disp_common {
+	status = "okay";
+};
+
+&pio {
+	disp_pwm0_pin_default: disp-pwm0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO64__FUNC_DISP_PWM0>;
+			output-high;
+		};
+	};
+
+	panel0_pins_default: panel0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO63__FUNC_GPIO63>,
+				 <PINMUX_GPIO65__FUNC_GPIO65>;
+			output-high;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	usb0_default_pins: usb0-default-pins {
+		pins-vbus-valid {
+			pinmux = <PINMUX_GPIO54__FUNC_VBUSVALID>;
+		};
+	};
+
+	dsi0_lcm_pins_default: dsi0-lcm-pins {
+		pins {
+			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
+			output-high;
+		};
+	};
+
+	snor_pins: snor-pins {
+		pins-ck-io {
+			pinmux = <PINMUX_GPIO57__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO59__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO60__FUNC_SPINOR_IO1>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO58__FUNC_SPINOR_CS>,
+				 <PINMUX_GPIO61__FUNC_SPINOR_IO2>,
+				 <PINMUX_GPIO62__FUNC_SPINOR_IO3>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+	};
+
+	eth_default: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO13__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO14__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO15__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO23__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO22__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO21__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO17__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO18__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO19__FUNC_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO25__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>;
+			output-high;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO28__FUNC_GPIO28>;
+		};
+	};
+
+	eth_sleep: eth-sleep-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>;
+			input-disable;
+			bias-disable;
+		};
+	};
+};
+
+&ssusb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_default_pins>;
+	role-switch-default-mode = "peripheral";
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host0 {
+	status = "okay";
+};
+
+&usb_host1 {
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+};
+
+&usb_host2 {
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	mmc-hs400-enhanced-strobe;
+	hs400-ds-delay = <0x10100>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6366_vemc_reg>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
+	no-sdio;
+	no-sd;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	cd-gpios = <&pio 94 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&mt6366_vmch_reg>;
+	vqmmc-supply = <&mt6366_vmc_reg>;
+	no-sdio;
+	no-mmc;
+};
+
+&eth {
+	/* The TX clock delay is provided by the board, only RX needs an ID. */
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&eth_phy0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default>;
+	pinctrl-1 = <&eth_sleep>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-idc0ff.0421";
+			reg = <0>;
+			reset-gpios = <&pio 28 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt8366-genio-360-evk.dts b/arch/arm/dts/mt8366-genio-360-evk.dts
new file mode 100644
index 00000000000..ac33cf14f42
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+/dts-v1/;
+
+#include "mt8366-genio-360-evk-common.dtsi"
+
+/ {
+	model = "MediaTek Genio-360 EVK";
+	compatible = "mediatek,mt8366-evk", "mediatek,mt8366";
+};

-- 
2.53.0

