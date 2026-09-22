Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388E2C98307
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBC8680E7D;
	Tue, 22 Sep 2026 16:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cpmoWjKII0yN; Tue, 22 Sep 2026 16:50:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AEC9780EA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095807;
	b=Sv2/hYi5MWOMmRnKWqheyThR9W2tJw/A7dSrbbkp0C16kX8oe/sdgB+Yzlc1qm06yzK+
	 m1IuZkweUc/bocJAUPobKV+lGQi0KksCLki3jS/uvrFp52DU5R+RyuM8YAP8Ele7anf+f
	 JJAp/rEtLPPh2drexT5WWBHMntmLdqpl8ULaVsPKK0kXhghDgqZnGc1LekoUH8MCjmrDo
	 loQGeZhrMOEcyL1yJIhpmbToXyAAgM9tAaPI6cyE3K01qVdxlforilPKEzkoyHkqZZ95G
	 9FO1UGMjZuPIBGH7u5Bveqx8Y4H6Ap0WgM/XlYh5BhDncZ6wLjzG59P/lwHDMMNUXoA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QCbqKGCVQe3nPXFU+K3Dd5lAmU+Z9HjE1jQmI4Y9msg=;
	b=ivj/sDukWe6oarJJIOQRd8oTX4L02Eoj4wV8q++5G71fpAJRoI7zyCF2u79dHt/xrjnt
	 MpNg1qElSwgWK563sHnhR//YeAZUz4pWR9ukRBN0yQbIL1/24Hy7IIHublQGz1yc/SUr/
	 jybFbSQJ29Y/eA4yaA6HP3eITVN/ZnOctHCF5CgeHxYrl90PKbmDQi0DdRggBBpa5NKWq
	 TOyyrSSKfp2FmfDnNXGstZEE2hNRaJpdFf54pblgnJOPCRfmuEXk7ftqYHoKG49GIKy/I
	 YURLkX3t1/XmQjjLeeNoi55ixmkfiQDbEP9ddePLpbhDYxXssqSzoWmJ01tZFoqgqmg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095807;
	bh=QCbqKGCVQe3nPXFU+K3Dd5lAmU+Z9HjE1jQmI4Y9msg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a+rTcHpqtfQFS1pEHr/gaBE/5rUPlsBYgsoicK6FI803rizZvLavMGYfBBYSH5YXw
	 OdUu6rqzY00E0MBc+Kc9D7kKxDDnzrQHGc00gtD+FH5kZ3tLGxts6aVjtNTP702BX2
	 l0GJ7njX6ifjoiy8Nsi/Gb/tTo0TGZvhbx0UAHBLRUXKWXYJoaxJZNeVjouBvWT6j+
	 Yw3HCQNxkUqTL0XqXmYOuui85ybrqQIPFmNVm6mR9ELb627ZbR7YGJpZYj9CAd1VZU
	 17AEgLOQns8fFUw0GOu2X++bksJPYuWZ1ucQEM3dj3pPjII439HovO/x1HLQ0mbpFi
	 zwA2BNfomqznQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEC9780EA1;
	Tue, 22 Sep 2026 16:50:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B8F309CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F612402D6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZNCftKgKL0s for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:18:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CD7D6402CC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790093914;
 b=sRh01vwzgFciPOqgXOMEkI9X2qj1AtIjEDrwZeh4ZUXXJFNM+cwO5Xb2b1IcwCWTOe6s
 Kgd6KtW+fK+/EXdS39anQynaIpyjh0jXHfkv6xS4M/08KRgWb6mSpcEUoIN63oeTLNdFJ
 OgELZ2s20e8QUwA+WFqmojO+Bt+OtfCHWVwkyx7JEwblWIcXQGgdx6Qwq0Gtl3BziBn8t
 /2jB8xZ3GjnqnRhaSGPwhyMaMEOEb7E5bHsi+au13mKOykBRwTaaXwERHkcEo5BM+Vfwv
 nw8QZC4tXbwettMf8NWGrHDxgii4xeFWVqfVNHKvq3+bBhm0cl1eP5q8oazdNNCVlNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790093914;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=QCbqKGCVQe3nPXFU+K3Dd5lAmU+Z9HjE1jQmI4Y9msg=;
 b=W5PT1P2PXzCIc5lrz8uNKOqmi+18mAqicnDdiyQ5crYDa/XwW5bdFqaOdxP5jaVYd1mj
 Sa0eiHCx9/AIzPQeXL1Oq+eKkobjtDUJmKd2RVWTRU720aYiqhRJDB8qZ/2vTJPmv4+NG
 bvcbFCnfl+HAE/Tf+8s2DueiX+1EbAG9O01OKI+JhcWORpIXHUG3pefBeMN3T9k8Ehq6+
 VyLIQ92LlHWJzp4ZdTG8h/57Sfm/XfC3OjM0lTOlkxklpWCH13xf82H4LAOnaP8SsRwgD
 L0QkSkQgzRcV8EL4sGFw+IabBQneQB6x6DxXYHG9Ivo1Yb4v+R2FEszTPi6+xRUxrVA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=gBX3fpfU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=gBX3fpfU
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD7D6402CC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790093859; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UPb4s1/TCdQUKTBILq1Gt7tExnBZxIluxoSbB3tOxBU7bOrzvXnQhowOr8cpdkGBwyXQ1Tim56mBIdnyidHUBuHHB56Y9xTpMU2WZE7LlBWwMszXugF8CGW+TTUcxGf5cg+CZa5swZ20KRCF39xG9/J/SXMt342CgwF0dy1wakQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790093859;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QCbqKGCVQe3nPXFU+K3Dd5lAmU+Z9HjE1jQmI4Y9msg=; 
 b=I938NjtORB9AhatsqvonpS7VTKwDvKzzzgWbsALMkypSJ9XEApYHleByuForB+ytzE1cUZBZKBYp2DRfsotneFjTxQ+PIN84M6Cjidjrb40seUDxtmf1Fze2rkbeJCyVE2vBwEf0ZWIzPaLGvOxitY5WyS9HoPGEyWI0IJ/WFjE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790093859; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=QCbqKGCVQe3nPXFU+K3Dd5lAmU+Z9HjE1jQmI4Y9msg=;
 b=gBX3fpfULIP3jy2R8p8bi/gCRSOsbycI7415TPobGosTcEBminCg0tjrJ5ywT9Se
 dyG0kILFRHidpXXW4n9+74EelHN/xSUKu7kTLbaZLqHdV1Ouh90ZzZa20shFyQrR+g0
 zLBg0e2pHOyGKAVjhmoSErnMZTykCVyPOHmHwmOs=
Received: by smtp.zohomail.com with SMTPS id 1790093856673613.1382071927271;
 Tue, 22 Sep 2026 09:17:36 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 23:46:23 +0800
Subject: [PATCH v4 08/11] riscv: milkv_duo_256m: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-8-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu0801122722bb304e73b969016c2bf2ec0000aaf0481362699268647a8688f69e6030c3a75695d1260c5d6a:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 16:50:01 +0000
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

The upstream devicetree keeps the Ethernet MAC disabled. Add a U-Boot
override to preserve the existing networking support when the optional
IO board is attached.

Remove the local board devicetree and update the OpenSBI build
instructions to use the upstream DTB.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/Makefile                         |  1 -
 arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi | 16 +++++++++
 arch/riscv/dts/sg2002-milkv-duo256m.dts         | 46 -------------------------
 board/sophgo/milkv_duo_256m/MAINTAINERS         |  1 +
 configs/milkv_duo_256m_defconfig                |  3 +-
 doc/board/sophgo/milkv_duo_256m.rst             |  2 +-
 6 files changed, 20 insertions(+), 49 deletions(-)

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
index 9d92eec6394..436bdb1549a 100644
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
