Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA7C98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABC2B6069D;
	Sun, 27 Sep 2026 15:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVYI1pfApMiS; Sun, 27 Sep 2026 15:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B05126067A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521558;
	b=oKbJ3fqMi0guz+ws+m4vjbKJgwOfWCfCO8lNN/AfC6m3a9yZh8Q8lk7ZveKvG+911MWi
	 48p/mE7RAkYpTbG7gdMac7Xxl8evsAYO0WMogV0l5kvYbhnIWFrJX42m0N+d8pgCcC/qg
	 UBltaXBM3D+ArH2we/L5ENQ6JNL97R8MvwfVomL8sHrUkySE9SlHbJvRY5FqSXtxPP/qb
	 UnRb1AO/ahIsnMaihbYHRMT4nZ22sPydIxlUD/H6b2dGV8iJS6fNOI6kG3rTYFuVame++
	 ieljTPDLdST6KQzUCr3DYOur7VVMc/Eosir6t7v9nWDVj9EFZ+CyUr7E5CJBTC7aagg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=go25V8ci4Nx38N/mbY5Y1TR0n5/UUFMfKhk2LYz/p7E=;
	b=BenYW66pqH6YXjEKO2gAwsOo9Ej7GWilhnHrTD3VPqvDhwyo+4hebpZg+EpgAADilKBI
	 Yb3lSRwlz01daFmWVje1JQYf1KY+hM0dcz+1CvpVIPAbnYV9X/zMsNBPWfuibYJiuaJCy
	 1/15ykb1z2P0gleJK4gV4MgX+sSYlwfYHnwWE/gPnVTRmfjtq1Roin424BNcdnB2gd9Xs
	 hCuR46Tm+XrohK3lFhELLS7XElpD9E9Y86VqZO4P7zc52/j1GgnD/3dDKQi/6JORNV+Bx
	 rXJ7Ja2a8WYLfkFh8BOE7uwIy8H93bQhvjFpIPBGmWXs84+67qhE61az6EkBdhJfqBw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521558;
	bh=go25V8ci4Nx38N/mbY5Y1TR0n5/UUFMfKhk2LYz/p7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MTtU2a6CwF/n6n1FSBX9Ws6fFXGL5iq2a8w5n9Zn3pGeSy3W4E9w9zJ3zMCvF6HRJ
	 KpQih5TgZt+rR8g6LBac/F9RF2NDqjq8nWwFuM9POmIXeBTnttIvvcGqKp9s/ZvFoN
	 87myZxVf3EmVUucAxS1mqGNfmGSkqqwiEFr6IAXhElU/Fr3X8l7tGKtzXxiDKdBR58
	 sO7MnbE0XVcvNOgREmeQ0pb1gpOBj9Nl/qr0jOVW5lUtv/TpnMiSmbmhQagqDDgU/4
	 z/sXy0RKEHZcOubxAHqqcqM/0g+MjUX3ikyzrNgyTmddSLPmc/bwB6eSjh57stwNM7
	 Utaun/yN7YVkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B05126067A;
	Sun, 27 Sep 2026 15:05:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BC6D72
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51C6680DDD
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hR9ooo0o-LOR for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 13:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 71980808A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790516273;
 b=KhMN0EsirrbUy5rskzy1ToM8xM5Us4DUbZbEDPZZcgB58VrJyUqBuKoKasgPAHpWcGSe
 b2yoiH6fEJDXL13LtsVC0i5f/FOuIfy06+rIxU84mqqJlrWnp8Fv0FGCgzRAQdz5c22Aa
 yG5+hwOD0CZkr2vLtFOxDDPYdyq9Bl182Eh1hm11lRAPHWG1eTfU2QLrfLT7fhTwq0tYo
 gJ+r+Ct1eJcN5jVdD6nhdpo8+PXlW8G+ns2JLzzJ3zfnQul9+/jeoUQczKdlEB+1xJFd2
 TK9rGCIaGdzsVm6XiOLwy732l3E7PuT+Au1LglHobKNNoNPtVclRCkI1M0tf+WWDeDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790516273;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=go25V8ci4Nx38N/mbY5Y1TR0n5/UUFMfKhk2LYz/p7E=;
 b=nQAm3zFd8T8naHII1+1ZW211ipL9Izt9VigXqP7IF9eyDoZdamuPR+b3+wSk3kAMNsUv
 xI27iMlNM52q/fU2W1HbLZ2+dzKILyYV+JTpq7P2MrNU49spQ7O4NMznaSCCfLDhdFyy4
 GZMeqc8MqRg42qpEws8gwDtEUsgLlbjK1LUiaGFJikY43qc7b6BcOQCBYe/o+5bBYBkBS
 MiHlTfSBolfQti1AIvfe4lNgzbUWOCtSblHSIjnEizeaVrf3aB1Vmd3B9FjTUZ4vMCKJD
 auKLaVy5CzM7IIkxVMhw5s5gvJxd2rHmSjqol5NkqSzB9sxefxP1+RHbsjeBEj9P7Xw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=DhvDFN1h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=DhvDFN1h
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71980808A0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790516188; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LYijJvEUVXg8AhufTDblJA539n19SSyz2NpU7HbF294ETUQG3pEPM9Go35soAT87sxoF3B7cfziq7S4IKadL4FGBW6S8KLA0LMtlHSYuguMz5yojVMdS3vg8Y/Oj5Ieok7/UqMX2pYQuKcsM/OaB9TbJIpwVDcNxzYFrmIPVgH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790516188;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=go25V8ci4Nx38N/mbY5Y1TR0n5/UUFMfKhk2LYz/p7E=; 
 b=YhBRwd0yM1GeJNF9fTU9to9qGSPqZBJPbhoOnGRTEVWv34f2hcK3ilbWOVrqLW3yMJZi4YIsMDvdwLWSWyRu1K6+/2GDeRFVPaD2FVbwWTCTGQ2+F6sa0t9o3KwS6cVQ6cH0RKfhBPT/WS/7lgJ62KGlvrTQ0cQg+lWxchipnys=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790516188; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=go25V8ci4Nx38N/mbY5Y1TR0n5/UUFMfKhk2LYz/p7E=;
 b=DhvDFN1h4zoxUntVkmTWe6AT8zK28PBJplGr+l4Foa67D3Ybs4WIctFOpef1LcFp
 N4lPt9Nl63bLnlNXuk5ouiV7QMhs81c49hkh1jL2drGq8N2VVnQ1T452J1V23YiZd2o
 vQOhjC0VGm8jh+yGrz40pwQbqH2I5R/fMykvvx/s=
Received: by smtp.zohomail.com with SMTPS id 1790516187695443.1080532166268;
 Sun, 27 Sep 2026 06:36:27 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 19:45:58 +0800
Subject: [PATCH v5 08/10] riscv: milkv_duo_256m: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-8-f95d9173b7e3@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112278980757dd708601f12047214000055dd25e707982fd490e1ea131979608a565df5ccd75b2a2a91:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 15:05:55 +0000
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

Switch Milk-V Duo 256M to the upstream SG2002 devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/sg2002-milkv-duo256m.

The upstream devicetree keeps the Ethernet MAC and its MDIO mux disabled.
Enable both nodes with U-Boot-specific overrides and add the MDIO mux
drivers needed to preserve networking with the optional IO board.

The local devicetree used phy-mode = "rmii". The upstream
devicetree uses phy-mode = "internal" and selects the internal
PHY through the MDIO mux.

Remove the local board devicetree and update the OpenSBI build
instructions to use the upstream DTB.

Tested TFTP on Milk-V Duo 256M with the IO board attached.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/Makefile                         |  1 -
 arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi | 16 +++++++++
 arch/riscv/dts/sg2002-milkv-duo256m.dts         | 46 -------------------------
 board/sophgo/milkv_duo_256m/MAINTAINERS         |  1 +
 configs/milkv_duo_256m_defconfig                |  6 +++-
 doc/board/sophgo/milkv_duo_256m.rst             |  2 +-
 6 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8ba75fdb9f5..71c5c13d221 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -5,7 +5,6 @@ dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
-dtb-$(CONFIG_TARGET_MILKV_DUO_256M) += sg2002-milkv-duo256m.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi b/arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
new file mode 100644
index 00000000000..3872343636f
--- /dev/null
+++ b/arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
+ */
+
+/*
+ * The Ethernet signals are routed to the RJ45 connector on the optional
+ * IO Board. Keep Ethernet available in U-Boot when the IO Board is attached.
+ */
+&gmac0 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
diff --git a/arch/riscv/dts/sg2002-milkv-duo256m.dts b/arch/riscv/dts/sg2002-milkv-duo256m.dts
deleted file mode 100644
index 4ad86ce39ec..00000000000
--- a/arch/riscv/dts/sg2002-milkv-duo256m.dts
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2026 Hiago De Franco <hfranco@baylibre.com>
- */
-
-/dts-v1/;
-
-#include "sg2002.dtsi"
-
-/ {
-	model = "Milk-V Duo 256M";
-	compatible = "milkv,duo256m", "sophgo,sg2002";
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&ethernet0 {
-	status = "okay";
-	phy-mode = "rmii";
-};
-
-&osc {
-	clock-frequency = <25000000>;
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <4>;
-	no-1-8-v;
-	no-mmc;
-	no-sdio;
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/board/sophgo/milkv_duo_256m/MAINTAINERS b/board/sophgo/milkv_duo_256m/MAINTAINERS
index 929960e7251..3488db28145 100644
--- a/board/sophgo/milkv_duo_256m/MAINTAINERS
+++ b/board/sophgo/milkv_duo_256m/MAINTAINERS
@@ -1,5 +1,6 @@
 Milk-V Duo 256M
 M:	Hiago De Franco <hfranco@baylibre.com>
 S:	Maintained
+F:	arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
 F:	board/sophgo/milkv_duo_256m/
 F:	configs/milkv_duo_256m_defconfig
diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
index 9d92eec6394..fda0baa3277 100644
--- a/configs/milkv_duo_256m_defconfig
+++ b/configs/milkv_duo_256m_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
-CONFIG_DEFAULT_DEVICE_TREE="sg2002-milkv-duo256m"
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2002-milkv-duo256m"
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="milkv_duo_256m"
 CONFIG_TARGET_MILKV_DUO_256M=y
@@ -25,6 +25,7 @@ CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK_SOPHGO_CV1800B=y
@@ -34,7 +35,10 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
diff --git a/doc/board/sophgo/milkv_duo_256m.rst b/doc/board/sophgo/milkv_duo_256m.rst
index 9e2cbddf4db..9562e6c48fd 100644
--- a/doc/board/sophgo/milkv_duo_256m.rst
+++ b/doc/board/sophgo/milkv_duo_256m.rst
@@ -46,7 +46,7 @@ To run u-boot.bin on top of FSBL, follow these steps:
 .. code-block:: console
 
    cd open-sbi
-   PLATFORM=generic FW_FDT_PATH=../u-boot/arch/riscv/dts/sg2002-milkv-duo256m.dtb make
+   PLATFORM=generic FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2002-milkv-duo256m.dtb make
 
 This will generate build/platform/generic/firmware/fw_dynamic.bin.
 

-- 
2.55.0
