Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F34C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D4A6407E2;
	Tue, 25 Aug 2026 22:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5z-Ie36UOqK; Tue, 25 Aug 2026 22:51:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698235;
	bh=xk5O2TBGuLcX9Of9TDiOMz+D5xVPe3Ri/3EG8vHPfOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PgzT6FX9F2uxNBM31vNTvZ79C+qw6AERg5pOpwps3Yd2I768jC5SjDw+WxbB/Asf
	 FqQRoB5NPDpmFa1ncx+52RLFbO3qEobsUmwpJ9JLk1HpHHJjPa21Ql28giy5e8gB47
	 zgZT08aoXq2y8+awPLGxsH4cwpQHF+RtlZhKT4G7rvqzo8XsVDYGxNpiRY8Xnfd9Pj
	 yV5kad/qS1FhHIOID/RhLU+Jj3a7MK5cpdRBdGmL9F+FLF9XqRWXb983bpu0v1XUBn
	 5fijtBDt9P2lejkPoKJQmpEbRYnOL9klefcHZHWos1Vc4GhZ+E+FQwlk/wjFU4o0sf
	 aj4qEaxe3/+qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 143E8406E6;
	Tue, 25 Aug 2026 22:50:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 545A48F1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46BF06070A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBBS5iyiT3fA for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=PJZVz6YU
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp3.osuosl.org (Postfix) with ESMTPS id 71F85606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697857; bh=xk5O2TBGuLcX9Of9TDiOMz+D5xVPe3Ri/3EG8vHPfOc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=PJZVz6YUxXuWF1mLWczGg4czBLd7OxxQQDG7n45wMzqQ/NUXn2H+N5cvlwSSArqT+9FzODe4ZSzKUqWtDuJATrtJvZt7O29548TeqIoSN6fUeYEbg2GhLqtnEwh2FDOOOgH93spFTlg914Qhox6iStvxqvEaR6k4BdeTFnvbNfD6o2XqSgV1bhO/s0W3glYBULCA6nYL+GvSwIn6mDI62T39jATXL4V1WUIJSJZdKihlQ/dB5w8QW/6lYnr4uGgU8RhvcwWJAaJIi6zt/vjqUuAQ/tT4t25qOdLhWp4KUgSWftTwgBx5ZanIcFDlA7pSKT4sCpKJKl/E2wuUBC1u2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697857; bh=oiCZUB3ywazpgNXxRMDgBZxn189ceOFz0whscvFEVNe=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=LFX6uQcVht+wWdKMqk1XPIGYCh4G+Qa0HBeBf/8bdAJm6eFTXq1oq0SkskPGstUvijgHNEjFl5UTT4IdsICEhgUlT49N/QKYXMCx9+7rCenB6FB0dlnf9QIuRwhSGg6gEQ5AbM2CgN4RbfBg5+uOrGiv4W3pmRmBuKk0l24qgE6GH4nom5ugJ1DKqUyvPMWoDQoYKjQfk7ZXvMYloPgAKummsRkj3wV8qZeB4YY8bQWif12qRBuQSR6nYv6dfav3hAqibVPlXwVjUx13OgRfTl2LcGH+4IVvONiNp9d6dikvzEbt9upTb8/ezCwUcq3tm2hfcorrFYZ1GUoLbXJNQg==
X-YMail-OSG: jn35jcYVM1lAL6bIQuC6jfcaZ9buiIt7SRpWBAsYrMlj8k3OJzeoNwUETMqt4MH
 7GJgU18iyaO2_rLP_tbOTRMdFOM2ttZHZ_YXH_O27JO.mwZqeXRtRxfyqBNn5PJDObMk7J8uinMA
 AZTqunDAwQssM.XeXXLmpeCPfhz9zrWi2cEivUKqTeuioSPnC1fRaa6j4JN.rC6hJohFB9mRh8xp
 AsRf2w6vEQbB5.Rtkvmn9b4ENM4zoMzxxUFWnp2Vl5mCgTuUEouqqBTRF0c9.dUsLKfuRtnQtXaU
 URJ233bwf9ir8VM.unveRJ_rihYarfvPBOsni_2Z8cc3ooXu25iYMYd33.T4oz3KezF5GGWyJhZX
 4jO25efpnioz3AdxoH4A3ej3_X0k8GpdmbjFnG5cUZ2Or5P1JoouFC5CI4UfBjQLkaI8Cxj9zd6o
 ZqfCsOPLHxTf7yYaJ8bHrTsgsksQcMDbV8Fqjia_YQCb8_xNAUXvRvd7IpyETEMIGvMxdGAUT.mB
 Q2bKYcYtG.BBcmRAtuRV8ZG5YXzAVxG3OI.RQ0RvgtFbT6SPUdxJiQ6Iu2cUAIC.cSGQN9kAGf3P
 SYeN5NLyFhViExQKUor6tCOWwVDBr8vQoGNnyoM38cE_zT2CCcYx7KUYE_AGtStTI9ohceE440Th
 mIZRf9ks5MpQXeAwZloCTW8waVGvk2vRsOFdDzKUggJYXqJp5o4T8saH8RE1O1mMCrp88MYZ2c__
 QDW6YmVUKf4ApfJ.6emnQYNaO1m0jb2FqtPGR0IR4G9rxfm0G3TDK7E0zbdEzEeDqzz8ky1mnloa
 Jv5tAFBYv1BrJQiR_vLEGEoPu.7mqjwqjnUpa09H8Z67JrCOarC1Pzjj0Ep.zizghlJob0PtS3_M
 6n2y.C7B6nmGbpJHQoA3aeVeadWTklGu0kde5JFEuWMM6aP80LMig6mXenYGHTFOpCQaZKei1kmG
 6ApqQ9ehI0.EvhL9XaXYDWcBuHlzWZ2t1FFtYw9VQOfXQvNNfjnVi1o_BO1jgG.B3X89negujRHV
 XcOost8KwTLeiRw2YdPvcly9fvkm0bBXBBOcBSWazNo3q2A_vptqAsWQ62g8QnL6otdf_dKY7.n9
 QLuRSdgA0yUTXWpPUvwYIutuDGp4I0xQ0yHyYp_lnDxNQokr7LVQVNnScXml0zgvQY.QeFPn8qDy
 u03vn.4M3.SdIaKCCDZs0q6l.do4FS.QNQRHgPtfy02ZfzY.E8AFBT5h3x.uiAiGRxum0ltBbbCT
 Hdqjea005BV1bazQJphJU1ONVR5QfBcHJepR0N1.qLC90nJhksL9OTaIq2pa9bMyOqkCE5BcWJo1
 SfaRIj3HFga46yWND6ch3O1_ieAEOWA5nq_WguJB3M4T3XCt6_trbd9_kZRiJwES88v63riIDC.d
 M7O7q8iGSOjrRUjP._LmrVKGJUPLeQWc_ptodJlWiRkEFF8abCGoJkVGO3Rp5aWXmk6s7mNjjAOu
 YlvKu_PJ4U15buclmxdAU17lnReWAgJMl8u1KhbUTZ0gEGRDUfW5QXGCLRPnmadYm9XYQYtMxdgI
 fNazdTlHt0GzOuLgbEjk2Wv.FgEKefuag3WQ21pTS3zzSLX0GF7iQ_yxT03mghKYcVdSXzjpXPd0
 VTczw6N._Qz_VzS1CJkkLfzLO3X58BL6moBsiUCwRhFAARoT0icnXWjGvgGa23QKnnuNhyIR2UVN
 mB3ukoHJjMhhKNN2IPIw1P3k8pq3rTzFKZYTcD0I8uGevhwoCIP8Z9U3E1C50sL2FBqmXin41mAO
 N0BKDmbybqByO0L8OEyFDWwnwdQNePqN7ow9LMACuVRbck3Tq.VgLMjUxYnYfOSM46nHcre7XRAU
 .girvd6aGZKEXVuI9sdkqMdwe.cJJoybUBuEnmd95wBBfWzXr51RyR1_pq9LhNrinPyKRc5Dn8Q1
 2ArddX8_Jbt4CVKUe.eO95qRYlp5Mt2_Bc2xf5ao0a23NOZ0sEw5EVpCOpLBCVYELNM2TbHwYhBz
 rCLPOAUnqqmEGAv6wXFgMMnjtcjWNTxcf76F.Q4AP_zm54xBQMiTcR77cgQaYAwVdXGxV5xQK_V.
 BeAiklw--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 902ae9e1-e438-4193-8b6f-e7460e006cb7
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:44:17 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:13 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 09/12] mips: dts: add EcoNet EN75xx device trees
Date: Wed, 26 Aug 2026 04:12:04 +0530
Message-ID: <20260825224330.713151-10-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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
 arch/mips/dts/econet,en7528.dtsi              | 164 ++++++++++++++++++
 9 files changed, 504 insertions(+)
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
index 00000000..0c5a59fb
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
+/* R3-hook map (harmless on RAM-boot: extra labels on spi-nand0). */
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
index 00000000..f0ded2b0
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
+		 * en7528_ddr.bin is the 0x5a70-byte FE-SRAM DDR3 stage (JCOW407 V1.6) lifted
+		 * from the stock bootbase (see doc/board/econet/en7528-porting.md).
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
index 00000000..b8b4668b
--- /dev/null
+++ b/arch/mips/dts/econet,en7528.dtsi
@@ -0,0 +1,164 @@
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
+
+				/* Vendor bad-block remapping. bbt-table-size is a
+				 * per-board constant: EN7528 uses 250, not the 1000
+				 * default, and a wrong value fails the BBT checksum.
+				 * assert-reserve-size must match the pool size the
+				 * bootbase prints ("bmt pool size: 163").
+				 */
+				econet,bmt;
+				econet,bbt-table-size = <250>;
+				econet,assert-reserve-size = <163>;
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

