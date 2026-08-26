Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E136C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA9580C38;
	Wed, 26 Aug 2026 13:42:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6_TqJpVSf_P5; Wed, 26 Aug 2026 13:42:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751764;
	bh=z1eMRiIqdFYEQVFMnrl8Kw4UTUZGTyX4542pAGol4pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PArF0r6CIrJHxrvVRkgjgSAbCXjP735StPSySSWHzNYvUtTA3S04LC/3Lrg+PzwVh
	 xfac5AYIu58dZoy2VxtmBtUqwIgMEVuDmOb3aO8ykFi/h6oBn7i8IR4cr+eoht3BWL
	 O6KtkvXiFf293BKvI965+NJu6dypcFen9d9KiFgLw77jMVb35LMDiQ23J2/MDEWB0Y
	 zS4gJp4Tqm06BfbNIp+gxx3OYp7K2ij4RePtJc9Lh2Cu3OBC/bQOy4G/Dnq3abIwtG
	 D7eV0l/W9r3QAqBSH4jAlp2g3fjaJ8T2S4UYtbBYwcTE5V9ggPGh38VnuP0G+Lo+W+
	 34uRNXWmBj2EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E28F480C2A;
	Wed, 26 Aug 2026 13:42:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E5043C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7010E6069D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aA0fBsyYYRfa for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=WnrBoVaB
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp3.osuosl.org (Postfix) with ESMTPS id 907526068A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751307; bh=z1eMRiIqdFYEQVFMnrl8Kw4UTUZGTyX4542pAGol4pY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=WnrBoVaB5BizQS4I72g7oVnR6fud9XGtoJpvqVEOgykNikJwVOg1/t0lZRAfembK2CrT+Ss5nhbKUnYajv8g59JyaERA/2M05t3s9fwR6nVk9xzQy5aMzmzTkgj+m5PO2mNO4+jlCuSsPo3SVkkujKvazvCR3T7tOUW08LvctT5Ic+vxY1o8n6NVfaYeWtvMVO2OXvxh//2+GBqhqYpfR8TWd9mKu9y8iiOjHhDYZscDlOP5NnPLCiySwVjiWiOLUZfsihZI2yyg9tGWzOqOiDiZnfzEv/htOtSoj9gF2kILCnLC9dfdom7m53lsuR79kLDG9Qo/BMf+38EDrT/GFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751307; bh=L7JBV7roo3BPD6y3l68rPnzGf7Yv2/uf9U6mtyzywpd=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=RPTFgH2302kiJmz7qEGHh8fMG9/g5Sy9EAIWmlCf42vjz5AWTA/KPaPLWA9k/CrFhIlKpYbaWTdTI2r+27EDjcYuKTS6DiWH03RdvAjtfTttmf6LqHUdntpt3mkKIW4xwj6lDdmQT5L686TBhkNdzdlOYOkEeQhvkJ7eP8JFVcI3sUde5awK7+QSAlJffqaYRIR3kspjW7GcVYXwO9blfCPAheHadkllQBK92O0NftVpy2nQg1SfQmcyfBJS8/CcfnMLnsd1q2f6f2M5ODHEzQC09Z5mqgn+CXmA0vaSiYt6otpKGAlIsc88v5nc0Y/kfIK1e4XGJnCISEUWob6NVw==
X-YMail-OSG: 01uJudoVM1nqaEw6hJpBt1KpVxh9x07.8VZ3HIri7aOE5l6FfzypG0FD8vfOwxf
 snFwm68D2XlMR1YuE2idFs.SiNJjxbUh2fXP4Ccq.62m_x16vZnJRjc6UnTF3LEqjxGHvqapFmkj
 aaQAwhqVXQeJJT1fgIomqUN9UW7hIDo7GhDCm7Hmj11zAlgicRR9h9fIjgMLN6XWVyi0P5thYIks
 biZicNQtaOj0nzQSRLjNp44unoSe8mg7eW6xetGv3KvbCWfMRykEJAIaxjuK1d.vpPPtzX4BvA0r
 mFDh33rc4pxESsEn38.9WmQFWb2IjfAoIH43i3kCo7fyqoVSwYgceHzQs4POVXXMITWBVdO6rIwi
 NEiscLGCI9rlKqN6Em5FSQBap9BeMVDjjk08FwKYTR1qnPXBe5cYPt71IFqo9iO73DVncAETSFE5
 nbOZ3jwmfSoRn.R71iJ_LCmpVUJVpYLfUidauSvQtHWeKGoqLb6BucU1Em35442KOaPhKQ0YAI4Z
 jKObeRPHcnoUBC08AW1FKOkisjlIYK9Dk_E5v5Jd4C_qvLdSR4EBCZd6dqSo84Hk5g3gPltocvgQ
 6xUbyiW8syHqBYhuS3NNqYejYAgGzqxNa6yzde2Eqnuhkx7awqCDodnK3XNNCqKuRIQIJiDmIgcl
 ZEW.D7YW1DVzkjR6aCsbEKs42TG_buKZ4c7i.Go.HgQBQhrm3tx7oI5wrK8kPiOCDyd6SIol8FN7
 zFHvNYHk3QQlZR9cAnyk7ZV4URpLRLzGDCHq4_V0MSYitcReeyArVg0p0nYxWJq8Kp9C5kK6i7l9
 ykP3hkj1guLnUDF02V66cTO4BmGToLvjuSclYjq7BpkEoSFlNcVe9Xx8w2xAxZc4Fw3_w_czPQaT
 fynVGDsJtEN5tq3HxT72ospEXSZIZDTzfQdhsFNClWwubrwN5386U2lx.o.Ru.F5Yx2V.Y9VgtL0
 4YE1XchoDnUeHPR.IDM0iKNDw926wOgChzcgv3BARvE4QpYdsWYMwUwv5bjMShszfR.64Fm9TMS6
 vMWDUHkpN8NvHDPijZJ.8VFRJLG1jblldOSPpNS0TMSRkU5iR32FQr85fKRB9oCD5WjhFpzs5YFa
 aihO1hme89E550EsEbBHQIGbsmaR31KCwyVcc4B7yL9.gfKu5ectV3p.bsx24PUsPTcW8e2uEnA4
 hsDeosWXlnYqiy2JkUeKoek4xjVQtHLG8LMfy1oBzgknV0sCJe88z_mgXhgIRNKpkc2hWf5UpOzT
 NGRQpFaVfUDSBWdHViSpD6bBl8tRexWVm04s2yBglIMIqiDApOLXUiMReY5SMBMcty2g25RlZfbY
 yjyX6CWSxp4kP_NkdmK3zRQke96jr8cUYconBcVcwv.0r7fROFl_WEVKB6.oy8PxNd49Z0GCKrqz
 U6xJn0N3.s.2ChNu5XI4j4DEXecksNwrdmBDZ5jk7gS5v_90juQVqyxNqiYSf34BVKvGp7AcOPA.
 88YFykO.wkihNu.2kDXOLNf525y_EVyK6W8DDwp_qS4Rj7kWX31aMgr2arqtAf3CmvvkPl1x_v_V
 rty9uA0BgaFZvQbJWaT8M5h5WRvV73Rd0p6TYt8VPEiQ6fw7l7ovgtnFNMgf3aqZRkjwkIi4ZwNS
 GrxV_jWq9r5vmFjHeDhMZ4jhB6TCROtl5LdTKMuuJH2wjcFg9goYo6ESP7cJLJrVe4gI02CY.vtj
 DV.ZiF7n0GuDkZHjYfRL5zu09tXRv_gPvD.1jQpB6c4WQIZ2wX.IlzpcKCIU7.BJE5MVZrqXCIU4
 xeBSq2rXw_1Xtk7Rj4.zTd6imns1eFAsTby92R4.t8Qt9iur3aBVl5fwbjB1Iy4_Rvg7tsik4eeD
 NjXWV5xSFJw5xeFz1tXLKKvzXKPyGAcU8tZ44dwhxfCzq54DGO.GAQCTYak77jnzOnts9hsR1G6l
 UmqLOFUrxGtOKt743owMgRHr7i9sfaDAyFvaBWMxgS5MJJbmCxI6v_V9ZfaEqjoJhwpGG.g9_Cus
 xuCWHDaQilQ1V72rPYqPXKja44_WdFBZglY94IC89XTrbIrBXuxNoVaZVYjPD2IfmGJg28z_gDy6
 IVg--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 6744bb63-b02e-4b07-843a-372d517d2680
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:35:07 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:35:02 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 6/9] mips: dts: add EcoNet EN75xx device trees
Date: Wed, 26 Aug 2026 19:04:40 +0530
Message-ID: <f41977b210c10de6fa742ad1b624df2e2759f65d.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
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

Add the device trees for the EN7512 and EN7528 reference boards and the
EN7528 RAM-boot variant.
These device trees are not yet in the Linux kernel; the bindings and
device trees will be submitted to the kernel and kept in sync with U-Boot.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 arch/mips/dts/Makefile                        |   2 +
 .../dts/econet,en7512-reference-u-boot.dtsi   |  58 +++++++
 arch/mips/dts/econet,en7512-reference.dts     |  27 +++
 arch/mips/dts/econet,en7512.dtsi              |  88 ++++++++++
 arch/mips/dts/econet,en7528-ram-u-boot.dtsi   |   6 +
 arch/mips/dts/econet,en7528-ram.dts           |  72 ++++++++
 .../dts/econet,en7528-reference-u-boot.dtsi   |  62 +++++++
 arch/mips/dts/econet,en7528-reference.dts     |  25 +++
 arch/mips/dts/econet,en7528.dtsi              | 154 ++++++++++++++++++
 9 files changed, 494 insertions(+)
 create mode 100644 arch/mips/dts/econet,en7512-reference-u-boot.dtsi
 create mode 100644 arch/mips/dts/econet,en7512-reference.dts
 create mode 100644 arch/mips/dts/econet,en7512.dtsi
 create mode 100644 arch/mips/dts/econet,en7528-ram-u-boot.dtsi
 create mode 100644 arch/mips/dts/econet,en7528-ram.dts
 create mode 100644 arch/mips/dts/econet,en7528-reference-u-boot.dtsi
 create mode 100644 arch/mips/dts/econet,en7528-reference.dts
 create mode 100644 arch/mips/dts/econet,en7528.dtsi

diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
index 7c4ee8b6..3e0347dd 100644
--- a/arch/mips/dts/Makefile
+++ b/arch/mips/dts/Makefile
@@ -6,6 +6,8 @@ dtb-$(CONFIG_TARGET_AP152) += ap152.dtb
 dtb-$(CONFIG_TARGET_MALTA) += mti,malta.dtb
 dtb-$(CONFIG_TARGET_PIC32MZDASK) += pic32mzda_sk.dtb
 dtb-$(CONFIG_TARGET_XILFPGA) += nexys4ddr.dtb
+dtb-$(CONFIG_ARCH_EN75XX) += econet,en7512-reference.dtb \
+	econet,en7528-reference.dtb econet,en7528-ram.dtb
 dtb-$(CONFIG_BOARD_BROADCOM_BCM968380GERG) += brcm,bcm968380gerg.dtb
 dtb-$(CONFIG_BOARD_COMTREND_AR5315U) += comtrend,ar-5315u.dtb
 dtb-$(CONFIG_BOARD_COMTREND_AR5387UN) += comtrend,ar-5387un.dtb
diff --git a/arch/mips/dts/econet,en7512-reference-u-boot.dtsi b/arch/mips/dts/econet,en7512-reference-u-boot.dtsi
new file mode 100644
index 00000000..36d97c26
--- /dev/null
+++ b/arch/mips/dts/econet,en7512-reference-u-boot.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/stringify.h>
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&binman {
+	spl-img {
+		filename = "u-boot-spl.img";
+
+		mkimage {
+			args = "-A", "mips", "-T", "standalone", "-O", "u-boot",
+			       "-C", "none", "-n", "EN7512 U-Boot SPL",
+			       "-a", __stringify(CONFIG_SPL_TEXT_BASE),
+			       "-e", __stringify(CONFIG_SPL_TEXT_BASE);
+
+			u-boot-spl {
+			};
+		};
+	};
+
+	en7512-uboot {
+		filename = "u-boot-en7512.bin";
+		pad-byte = <0xff>;
+
+		u-boot-tpl {
+			offset = <0x00000000>;
+			size = <0x00008000>;
+		};
+
+		ddr-blob {
+			type = "blob-ext";
+			filename = "arch/mips/mach-en75xx/en7512_ddr.bin";
+			offset = <0x00008000>;
+			size = <0x00004f70>;
+		};
+
+		spl {
+			type = "blob";
+			filename = "u-boot-spl.img";
+			offset = <0x00010000>;
+			size = <0x00040000>;
+		};
+
+		u-boot {
+			type = "blob";
+			filename = "u-boot.img";
+			offset = <0x00050000>;
+		};
+	};
+};
diff --git a/arch/mips/dts/econet,en7512-reference.dts b/arch/mips/dts/econet,en7512-reference.dts
new file mode 100644
index 00000000..b8a3aba5
--- /dev/null
+++ b/arch/mips/dts/econet,en7512-reference.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "econet,en7512.dtsi"
+
+/ {
+	model = "EcoNet EN7512/EN7521 reference board";
+	compatible = "econet,en7512-reference", "econet,en751221",
+		     "econet,en7512";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&sfc {
+	status = "okay";
+};
diff --git a/arch/mips/dts/econet,en7512.dtsi b/arch/mips/dts/econet,en7512.dtsi
new file mode 100644
index 00000000..0f13159d
--- /dev/null
+++ b/arch/mips/dts/econet,en7512.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "mips,mips34Kc";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon: syscon@1fb00000 {
+			compatible = "econet,en7512-syscon", "syscon";
+			reg = <0x1fb00000 0x1000>;
+		};
+
+		sfc: spi@1fa10000 {
+			compatible = "airoha,en7523-spi";
+			reg = <0x1fa10000 0x140>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
+		sram@1fa30000 {
+			compatible = "mmio-sram";
+			reg = <0x1fa30000 0xc000>;
+		};
+
+		dramc: memory-controller@1fb20000 {
+			compatible = "econet,en7512-dramc";
+			reg = <0x1fb20000 0x1000>;
+		};
+
+		ethernet: ethernet@1fb50000 {
+			compatible = "econet,en751221-eth";
+			reg = <0x1fb50000 0x4000>,
+			      <0x1fb54000 0x1000>;
+			reg-names = "fe", "qdma0";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gmac0: mac@0 {
+				compatible = "econet,eth-mac";
+				reg = <0>;
+				phy-mode = "trgmii";
+			};
+		};
+
+		switch0: switch@1fb58000 {
+			compatible = "mediatek,mt7530";
+			reg = <0x1fb58000 0x8000>;
+		};
+
+		uart0: serial@1fbf0000 {
+			compatible = "econet,en7512-uart";
+			reg = <0x1fbf0000 0x30>;
+			clock-frequency = <20000000>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/dts/econet,en7528-ram-u-boot.dtsi b/arch/mips/dts/econet,en7528-ram-u-boot.dtsi
new file mode 100644
index 00000000..94512540
--- /dev/null
+++ b/arch/mips/dts/econet,en7528-ram-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* RAM-boot: no binman image; just make the console available pre-relocation. */
+
+&uart0 {
+	bootph-all;
+};
diff --git a/arch/mips/dts/econet,en7528-ram.dts b/arch/mips/dts/econet,en7528-ram.dts
new file mode 100644
index 00000000..196f3296
--- /dev/null
+++ b/arch/mips/dts/econet,en7528-ram.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "econet,en7528.dtsi"
+
+/ {
+	model = "EcoNet EN7528 RAM-boot (bootbase-loaded)";
+	compatible = "econet,en7528-ram", "econet,en7528";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&sfc {
+	status = "okay";
+};
+
+&ethernet {
+	status = "okay";
+};
+
+&switch0 {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+/* Flash partition map (labels unused on the RAM-boot path). */
+&spi_nand {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "bootloader";
+			reg = <0x0 0x40000>;
+		};
+		partition@40000 {
+			label = "uboot";
+			reg = <0x40000 0x80000>;
+		};
+		partition@c0000 {
+			label = "ubootenv";
+			reg = <0xc0000 0x20000>;
+		};
+		partition@e0000 {
+			label = "ubootenv2";
+			reg = <0xe0000 0x20000>;
+		};
+		partition@100000 {
+			label = "kernel";
+			reg = <0x100000 0x1000000>;
+		};
+		partition@1100000 {
+			label = "rootfs";
+			reg = <0x1100000 0xda80000>;
+		};
+	};
+};
diff --git a/arch/mips/dts/econet,en7528-reference-u-boot.dtsi b/arch/mips/dts/econet,en7528-reference-u-boot.dtsi
new file mode 100644
index 00000000..dd0e8d4b
--- /dev/null
+++ b/arch/mips/dts/econet,en7528-reference-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/stringify.h>
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&binman {
+	spl-img {
+		filename = "u-boot-spl.img";
+
+		mkimage {
+			args = "-A", "mips", "-T", "standalone", "-O", "u-boot",
+			       "-C", "none", "-n", "EN7528 U-Boot SPL",
+			       "-a", __stringify(CONFIG_SPL_TEXT_BASE),
+			       "-e", __stringify(CONFIG_SPL_TEXT_BASE);
+
+			u-boot-spl {
+			};
+		};
+	};
+
+	en7528-uboot {
+		filename = "u-boot-en7528.bin";
+		pad-byte = <0xff>;
+
+		u-boot-tpl {
+			offset = <0x00000000>;
+			size = <0x00008000>;
+		};
+
+		/*
+		 * en7528_ddr.bin is the 0x5a70-byte FE-SRAM DDR3 stage extracted from the
+		 * vendor bootloader (see doc/board/econet/en7528.rst).
+		 */
+		ddr-blob {
+			type = "blob-ext";
+			filename = "arch/mips/mach-en75xx/en7528_ddr.bin";
+			offset = <0x00008000>;
+			size = <0x00005a70>;
+		};
+
+		spl {
+			type = "blob";
+			filename = "u-boot-spl.img";
+			offset = <0x00020000>;
+			size = <0x00030000>;
+		};
+
+		u-boot {
+			type = "blob";
+			filename = "u-boot.img";
+			offset = <0x00050000>;
+		};
+	};
+};
diff --git a/arch/mips/dts/econet,en7528-reference.dts b/arch/mips/dts/econet,en7528-reference.dts
new file mode 100644
index 00000000..d029f41c
--- /dev/null
+++ b/arch/mips/dts/econet,en7528-reference.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "econet,en7528.dtsi"
+
+/ {
+	model = "EcoNet EN7528 reference board (DASAN H660GM-A)";
+	compatible = "econet,en7528-reference", "econet,en7528";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&sfc {
+	status = "okay";
+};
diff --git a/arch/mips/dts/econet,en7528.dtsi b/arch/mips/dts/econet,en7528.dtsi
new file mode 100644
index 00000000..49d04936
--- /dev/null
+++ b/arch/mips/dts/econet,en7528.dtsi
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* EcoNet/Airoha EN7528 (MIPS 1004Kc, little-endian) */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "mips,mips1004Kc";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "mips,mips1004Kc";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* Capped below the 0x1fxxxxxx MMIO island; DDR stage
+		 * publishes the true size at runtime (dram_init). */
+		reg = <0x00000000 0x10000000>;
+	};
+
+	/* Dummy clock/phy so xhci-mtk's mandatory clk_get_bulk()/
+	 * generic_phy_get_bulk() succeed without an en7528 SCU clock or
+	 * T-PHY driver; the real USB clock is left ungated by the bootbase
+	 * and the xHCI IPPC block does the port power-up. */
+	usb_clk: usb-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	usb_phy: usb-phy {
+		compatible = "nop-phy";
+		#phy-cells = <0>;
+		clocks = <&usb_clk>;	/* nop_phy_probe() calls clk_get_bulk() */
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon: syscon@1fb00000 {
+			compatible = "econet,en7528-syscon", "syscon";
+			reg = <0x1fb00000 0x1000>;
+		};
+
+		sfc: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x1fa10000 0x140>,
+			      <0x1fa11000 0x1000>;	/* NFI: driver uses up to 0x55c;
+							 * U-Boot regmap range-checks (Linux
+							 * gets a full page from ioremap). */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
+		sram@1fa30000 {
+			compatible = "mmio-sram";
+			reg = <0x1fa30000 0x20000>;
+		};
+
+		dramc: memory-controller@1fb20000 {
+			compatible = "econet,en7528-dramc";
+			reg = <0x1fb20000 0x1000>;
+		};
+
+		/*
+		 * EN7528 Ethernet = same EN751221-family FE/QDMA as the EN7512,
+		 * feeding an MT7530-family DSA switch (GMAC0 -> switch CPU port).
+		 * The airoha_eth U-Boot driver binds "econet,en751221-eth" and
+		 * self-initializes the "mediatek,mt7530" switch.
+		 */
+		ethernet: ethernet@1fb50000 {
+			compatible = "econet,en751221-eth";
+			reg = <0x1fb50000 0x4000>,
+			      <0x1fb54000 0x1000>;
+			reg-names = "fe", "qdma0";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			gmac0: mac@0 {
+				compatible = "econet,eth-mac";
+				reg = <0>;
+				phy-mode = "trgmii";
+			};
+		};
+
+		switch0: switch@1fb58000 {
+			compatible = "mediatek,mt7530";
+			reg = <0x1fb58000 0x8000>;
+			status = "disabled";
+		};
+
+		/*
+		 * USB3 host = MediaTek xHCI (same IP as mt8173), driven by
+		 * U-Boot's xhci-mtk. "mac" is the xHCI MMIO, "ippc" the IP port
+		 * control block (a sub-region of the USB T-PHY window). The
+		 * en7528 USB clock is ungated by the bootbase (the kernel node
+		 * carries no clocks either) so &usb_clk is a dummy fixed-clock
+		 * to satisfy clk_get_bulk(); &usb_phy is a nop-phy (the xHCI
+		 * IPPC block powers the ports up itself). USB reset/PHY-reset are
+		 * released by a direct SCU poke in board_late_init (there is no
+		 * DM reset provider in this port — see board.c).
+		 */
+		usb: usb@1fb90000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0x1fb90000 0x4000>,
+			      <0x1fa80700 0x100>;
+			reg-names = "mac", "ippc";
+			clocks = <&usb_clk>;
+			phys = <&usb_phy>;
+			/*
+			 * USB2-only: the U3/SerDes path needs SCU/serdes config
+			 * we don't do, and leaving U3 enabled makes xhci-mtk stall
+			 * on an unstable U3 clock (per the Airoha AN7581 USB PHY
+			 * commit). Disable both U3 ports so only USB2 is brought up.
+			 */
+			mediatek,u3p-dis-msk = <0x3>;
+			status = "disabled";
+		};
+
+		uart0: serial@1fbf0000 {
+			compatible = "econet,en7528-uart";
+			reg = <0x1fbf0000 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			clock-frequency = <2000000>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.53.0

