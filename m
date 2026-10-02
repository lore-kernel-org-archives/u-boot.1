Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B0CA5FE3
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91E988132B;
	Fri,  2 Oct 2026 16:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwOmOsWq9EBF; Fri,  2 Oct 2026 16:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81C9181325
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959661;
	b=AzUTikRRHtWeYq7r4noVHE/G/o6v7I+E/wYCIP+PJ0DbCeovfZqB51LlKiYdCJOBgo0u
	 J6R+k7wX3V5rO8Nc+rwSzPhj+NLWv6+KCnW9MxpVwBw6rM5Xa7griEcxdr1h74OBrHf7J
	 uPVdDJdoWpLODC5NrX2GA7rSXkGYrxqXXjjo1swPidQUwceBnMRMOkGS721IrakGR6eMe
	 tfKP70t8FMOQhRyws0hU0nhEMcmoDdJXYjvZXRDuigWrO4jv1LlXKxCR39Df5Oic1GWc9
	 dCZKpZSF5Uu6V53e0VLYiFQo6XhbSlABgqSS/dkshYQ5BKSod/IYv37WM/Qfpsg1lMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=heDv2D81dUQ8cl3Z4uccJzlxnC0UJ5chrTZAFWe432I=;
	b=bcEZW/QuEQEL4SZf7sLh3VOc0Hpk4sWEWP+OI4+K5PJsnzn7By4vi+GbbFQZtL3CFSqU
	 Uu9nO7C/Kitz9sOuaCQYEQjcK9w4wJxutIoYgda0GGRlnftpJxTSEMp6pJcbbLBnFdnD6
	 0vz+UEbmqlV+CD8TNinmnk7PZucxXGZWBfknXTcEiSC9/I7vJYvpeuDDUTuHivRRLtHQx
	 pr2vMhsTzMqLz5u1/QvOvbWxklC6bC7sGKbhyTu82CenR7h1QFYb6PARhJw/MLWiXB8i6
	 1Oyu5hDPfUF7KsAKtjrYf8Q+GAZb/K1WcddZbyiVtx8V6OjAOBC/Y5iv1G+Hx4zMhBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959661;
	bh=heDv2D81dUQ8cl3Z4uccJzlxnC0UJ5chrTZAFWe432I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LlnQu1lc1CteYiBL+1uJ/KwUaLuedS3NPTYgUn0gq1SHiCQJKXY9wqopdDC24nx1f
	 PXtc+y7w203ggy05lYweIeSeITW7mfmOsRnarc4Ng/gGZrDOoZkDNnXMqnXcJfqGZx
	 1sS5HkSLkkWzDHY4Qmpw5P3Wrtk7hGqNSc726MJjwW8ukxORxhNPckLurfpKI3mG2+
	 4WstuEKbZg//EGol51S9nCXwk5wb92Xku+tIqMt3PBYlZpOj6KbAAh7PStnYZ8wzY3
	 FTSXHOOW75ZcOaTHN/rXAGYjJCwtf3Wmt5b4UrMu7qtIdcGRHVjXkjT8EeE7P8GLw9
	 Iv6+uv0fDwGcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81C9181325;
	Fri,  2 Oct 2026 16:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D9BD34E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 338FF60BBB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKcymHpS5q5z for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0A61660BBC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946882;
 b=Xa8ZkRbfOv6kdsV0ZhMbChue3wyjqAI9eRf3ebrY1g0xlJHOaJcBAAVRjI4AfPBH+lok
 pQ6+SmT7NJczWTmxaxH0q9J6ySzqqCjYVKOOBKwUo03jAqVEfcP2F/BnHqsuaVZwksF6Y
 4QHbgaQJxqNeUcGDhN/0MEKZ+YpgEQBjLppXXa3wC6JiIcVUkJyWMDBL5oa9MqZsCG9dY
 CH3P+TF1o70VSqp6lI7iPNx8k0dXvpnKNjjJJo8UafdnwrYBYGzUmqMWgd+zqA25pbhDw
 0RIz9Myb4jwRxTllQZluitMFnNtb4usjkJvaBldd6j7XOKJ0uC3Dr7Tj1fH5hTvxYVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946882;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=heDv2D81dUQ8cl3Z4uccJzlxnC0UJ5chrTZAFWe432I=;
 b=oGYYKCaFWNEyXVwmuzVgZmybBblI3DbIMXLRisE4dJwKnnIV2Ul+06UhLNIh6auaDuFS
 O7btjAeQmujZZ0wVbszeMUYQZdxWUvnAbbYQxW88sPO17180BMCLvw7DI3kRZmhWNRq4l
 QVwHtDfKG5zniSK+wXQoceso/4s0UOXdrU91Lb1shxF1U1pOQsE0zcxHB5MLdrSpcKT2t
 ZLyyJNnM+7HAIEDoiPM3M7noqK/jZYTKD1szD7MXHWCnocCLJovvuusVmcSxHIyXMlj1s
 /bi+ibVyVMjc55alKshAvT+bSv+ad6GfRiPGU3piMx8oG3vy7hZAPKbCYlE8wCV++cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Kf6HWlWX; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Kf6HWlWX
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A61660BBC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0B41C4E4111B;
 Fri,  2 Oct 2026 13:14:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D344C603DC;
 Fri,  2 Oct 2026 13:14:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 057A2103281E3; 
 Fri,  2 Oct 2026 15:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=heDv2D81dUQ8cl3Z4uccJzlxnC0UJ5chrTZAFWe432I=;
 b=Kf6HWlWXGjqqvm5tbDs7Bba8vph/yFPg6fananIqfGAeDKOXCS8rJ7m0ix1H2jYzKqHWYt
 GIMkWtnU4XiEmgl90cgANsCYGIbdXgBdr+dQF4fNRPkVGMMyhQkumLqIlrk84BpDmMNBA0
 QSn4sOk+3oquqkAQuAzGbmBwl1ncSj+eaF/eVLx+YRvj9GXANXUhcah6+BS627k8VhjLdb
 0rR8Hl73Gl9cIlT8Aa/MCBefelKY5H5zkb2H9iMeeA+yjEWZpUTB3pICdXHIWatbcHA5TB
 EkcK226EK2Omf0MNsEGuP9If2yo317Aejcu6dL8iT25mdS2PuEioQtM50TpUDg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:27 +0200
Subject: [PATCH 09/10] riscv: dts: add MT2824 SoC and MT5824 EVB device trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-9-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

Add the device trees for the MT2824 SoC (mt2824.dtsi) and the MT5824
EVB board (mt5824-evb.dts). The SoC integrates:

- a dual-core Andes AX45MP with 256 KB unified L2 cache
- PLIC, PLIC SW and PLMT interrupt and timer controllers
- a DesignWare-derived SDHCI controller
- an ATCSPI200 QSPI controller with a 32 MiB Macronix NOR flash
  exposed as a memory-mapped device through nvmxip
- a DDR controller with its firmware mapped through a "fw" reg entry

The u-boot.dtsi overlay marks the nodes used by the SPL with
bootph-pre-ram and describes the binman FIT image packing OpenSBI,
U-Boot and the device tree.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 arch/riscv/dts/Makefile           |   1 +
 arch/riscv/dts/mt2824-u-boot.dtsi |  66 ++++++++++++
 arch/riscv/dts/mt2824.dtsi        | 219 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/dts/mt5824-evb.dts     |  34 ++++++
 4 files changed, 320 insertions(+)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8ba75fdb9f5..b13e0436b98 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -3,6 +3,7 @@
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
+dtb-$(CONFIG_TARGET_METANOIA_MT5824_EVB) += mt5824-evb.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO_256M) += sg2002-milkv-duo256m.dtb
diff --git a/arch/riscv/dts/mt2824-u-boot.dtsi b/arch/riscv/dts/mt2824-u-boot.dtsi
new file mode 100644
index 00000000000..8155fe580eb
--- /dev/null
+++ b/arch/riscv/dts/mt2824-u-boot.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc. All rights reserved.
+ */
+
+#include "binman.dtsi"
+
+/ {
+	cpus {
+		bootph-pre-ram;
+
+		cpu0: cpu@0 {
+			bootph-pre-ram;
+		};
+
+		cpu1: cpu@1 {
+			bootph-pre-ram;
+		};
+	};
+
+	l2: l2-cache@a000000 {
+		bootph-pre-ram;
+	};
+
+	soc {
+		bootph-pre-ram;
+
+		plicsw: interrupt-controller@c800000 {
+			bootph-pre-ram;
+		};
+
+		plmt0@c400000 {
+			bootph-pre-ram;
+		};
+
+		rst: reset-controller@1000000c {
+			bootph-pre-ram;
+		};
+
+		ddrc: ddrc@10060000 {
+			compatible = "metanoia,mt2824-ddrc";
+			reg = <0x0 0x10060000 0x0 0x1000>,
+			      <0x0 0x14000000 0x0 0x800000>,
+			      <0x0 0x70080000 0x0 0x20000>;
+			reg-names = "ctrl", "phy", "fw";
+			resets = <&rst 17>;
+			bootph-pre-ram;
+		};
+
+		serial0: serial@100e0000 {
+			bootph-pre-ram;
+		};
+
+		nvmxip@20000000 {
+			compatible = "nvmxip,qspi";
+			reg = <0x0 0x20000000 0x0 0x2000000>;
+			lba_shift = <9>;
+			lba = <65536>;
+			bootph-pre-ram;
+		};
+
+		mmcsd: mmc@4100000 {
+			bootph-pre-ram;
+		};
+	};
+};
diff --git a/arch/riscv/dts/mt2824.dtsi b/arch/riscv/dts/mt2824.dtsi
new file mode 100644
index 00000000000..cd11a949f22
--- /dev/null
+++ b/arch/riscv/dts/mt2824.dtsi
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc. All rights reserved.
+ */
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+	model = "Metanoia MT2824";
+	compatible = "metanoia,mt2824";
+
+	aliases {
+		uart0 = &serial0;
+	};
+
+	cpus: cpus {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		timebase-frequency = <20000000>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x00>;
+			status = "okay";
+			compatible = "andestech,ax45mp", "riscv";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm", "xandespmu";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <900000000>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <0x100>;
+			i-cache-line-size = <0x40>;
+			i-cache-block-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <0x80>;
+			d-cache-line-size = <0x40>;
+			d-cache-block-size = <0x40>;
+			next-level-cache = <&l2>;
+
+			cpu0intc: interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "andestech,cpu-intc", "riscv,cpu-intc";
+			};
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			reg = <0x01>;
+			status = "okay";
+			compatible = "andestech,ax45mp", "riscv";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm", "xandespmu";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <900000000>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <0x100>;
+			i-cache-line-size = <0x40>;
+			i-cache-block-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <0x80>;
+			d-cache-line-size = <0x40>;
+			d-cache-block-size = <0x40>;
+			next-level-cache = <&l2>;
+
+			cpu1intc: interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "andestech,cpu-intc", "riscv,cpu-intc";
+			};
+		};
+	};
+
+	l2: l2-cache@a000000 {
+		compatible = "metanoia,mt2824-ax45mp-cache",
+			     "andestech,ax45mp-cache",
+			     "cache";
+		reg = <0x00 0xa000000 0x00 0x40000>;
+		cache-line-size = <64>;
+		cache-level = <2>;
+		cache-size = <0x40000>;
+		cache-sets = <1024>;
+		cache-unified;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&plic>;
+	};
+
+	clocks {
+		ext_clk: ext-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <20000000>;
+			clock-output-names = "ext-clk";
+		};
+
+		pclk: platform-clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <900000000>;
+			clock-output-names = "platform-clock";
+		};
+
+		pclk_div2: platform-clock-div2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <450000000>;
+			clock-output-names = "platform-clock-div2";
+		};
+
+		pclk_div4: platform-clock-div4 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <225000000>;
+			clock-output-names = "platform-clock-div4";
+		};
+
+		pll_soc_out3: pll-soc-out3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <180000000>;
+			clock-output-names = "pll-soc-out3";
+		};
+
+		usb_otg_ahb_clk: clock-usb-otg-ahb {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <60000000>;
+			clock-output-names = "otg";
+		};
+	};
+
+	soc: soc {
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		ranges;
+
+		plic: interrupt-controller@c000000 {
+			compatible = "metanoia,mt2824-plic", "andestech,nceplic100";
+			reg = <0x0 0x0c000000 0x0 0x400000>;
+			interrupts-extended = <&cpu0intc 0x0b>, <&cpu0intc 0x09>,
+					      <&cpu1intc 0x0b>, <&cpu1intc 0x09>;
+			interrupt-controller;
+			#address-cells = <0x00>;
+			#interrupt-cells = <0x02>;
+			riscv,ndev = <0x47>;
+		};
+
+		plicsw: interrupt-controller@c800000 {
+			compatible = "metanoia,mt2824-plicsw", "andestech,plicsw";
+			reg = <0x00 0x0c800000 0x00 0x400000>;
+			interrupts-extended =
+			<&cpu0intc IRQ_TYPE_EDGE_BOTH>,
+			<&cpu1intc IRQ_TYPE_EDGE_BOTH>;
+		};
+
+		plmt0@c400000 {
+			compatible = "metanoia,mt2824-plmt", "andestech,plmt0";
+			reg = <0x0 0x0c400000 0x0 0x00400000>;
+			interrupts-extended = <&cpu0intc 0x07>,
+					      <&cpu1intc 0x07>;
+		};
+
+		reboot: reboot@10000004 {
+			compatible = "metanoia,mt2824-reboot";
+			reg = <0x0 0x10000004 0x0 0x08>;
+		};
+
+		rst: reset-controller@1000000c {
+			#reset-cells = <1>;
+			compatible = "metanoia,mt2824-reset";
+			reg = <0x0 0x1000000c 0x0 0x04>;
+		};
+
+		serial0: serial@100e0000 {
+			compatible = "ns16550a";
+			reg = <0x00 0x100e0000 0x00 0x1000>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&plic>;
+			clocks = <&pclk_div4>;
+			current-speed = <115200>;
+			reg-shift = <0x02>;
+			reg-offset = <0x20>;
+			reg-io-width = <0x04>;
+		};
+
+		qspi: spi@10120000 {
+			compatible = "metanoia,mt2824-spi";
+			reg = <0x00 0x10120000 0x00 0x10000>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&plic>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			clock-names = "spi_clk_src";
+		};
+
+		mmcsd: mmc@4100000 {
+			compatible = "metanoia,mt2824-dwcmshc";
+			max-frequency = <200000000>;
+			clocks = <&pll_soc_out3>;
+			clock-names = "core";
+			reg = <0x0 0x04100000 0x0 0x00100000>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&plic>;
+			sdhci-caps-mask = <0x80000006 0x00000000>;
+			bus-width = <4>;
+			disable-wp;
+		};
+	};
+};
diff --git a/arch/riscv/dts/mt5824-evb.dts b/arch/riscv/dts/mt5824-evb.dts
new file mode 100644
index 00000000000..207051e8a14
--- /dev/null
+++ b/arch/riscv/dts/mt5824-evb.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc. All rights reserved.
+ */
+/dts-v1/;
+
+#include "mt2824.dtsi"
+
+/ {
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+	model = "Metanoia MT5824 EVB";
+	compatible = "metanoia,mt5824-evb", "metanoia,mt2824";
+
+	chosen {
+		stdout-path = "uart0:115200n8";
+	};
+
+	ddr: memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0000000080000000 0x00000000 0x80000000>,
+		      <0x1 0x0000000000000000 0x00000000 0x80000000>;
+	};
+};
+
+&qspi {
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <0x4>;
+		spi-tx-bus-width = <0x4>;
+		spi-max-frequency = <100000000>;
+		reg = <0x0>;
+	};
+};

-- 
2.55.0

