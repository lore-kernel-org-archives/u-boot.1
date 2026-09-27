Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65C9C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B23D981025;
	Sun, 27 Sep 2026 15:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uX8XxADMas-e; Sun, 27 Sep 2026 15:06:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 82A8C8101F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521560;
	b=dr2WGtG9P2gps9gG/EzWOUIwXfHXIEjmIZMeBh5w5+Dh85NNpR52V2JnUiUgebWd0h0G
	 MOYXioBbFxpOR+VD97N95DvUP3TwSrbd8aqadumAKRUDCrYvOnrtnJirXA3Ma/69meja+
	 UeqWR6VHOdcKa9a0Zf9qaopzyM0YpBXJZHo0LC/YV/J6/952zxo1lyjjqvmpVdE+4PbEs
	 00vOcEqjYZObhjfdVhhYBREN/bi+GmVFoC9kvkW2vsfC1/+xpZvm3lIbhmOjUUmukauF3
	 zg+Cz9p5nPVNZ5dUDqemRjmGDbXWwvk2sQDMoSaWOJIYX7uhTPcFIhWreXRfjp/p0gw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
	b=ccMWyJqflNOWSIwELCiHaqw8LJma9IcpAlO6ToYW+RyS8gi7hNUPpYJMXRPbi1kkMKZt
	 JrqewkoQGUOrw0fwjdDRi33BvS68OycLSFgy3KzAL8mQZee2A3N4M1VLnqYKaiaM9uP8O
	 8QKnQgqXhUiSzUB4BiezJQw6BmisDj80J1hSF3cv9oJNDGq60Xfb6BW5xzIAAkiz8nw+e
	 8JMCcDdl7SYWi+W5PJ0oW1blBUC3qTryNksD+ZbzuEEIbslkmVytF1Nlfp6ldEGS/O6Bj
	 FZcRALhdDF9meJGBrUbWE9kT5NHlovhH1YxucRxVjAAsL7ceXljUTPhlQM/OSwFxxig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521560;
	bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3vjiyIVzbFUYRHQVaEVwm593C6rUtyHa7ok3QM0Oj4c6s99h6OUr8seQEhCJgG/W
	 9SmE102ABLs5rK6waCr9Fr7GZxRw2ZIRQj97dx7eQUDfl3OENNhiE/Fl7ocwAIM+FQ
	 VAU6W1pYb4pfaVSWZGCmpAxU0mdJxD6tU6ctIsBxMgj7/7GslncBZuuPoIQXHPdqBc
	 KKkHUelgRIhxxbgmsKzWS+F8aapOPRC1ImZ7FFJSN667qto4dlYubv1hdp8S6eeuG0
	 B06IUvFMYY4eRSp76OtcymnIonL5EIY8XMmI4FJnPHvQFoyi0FBAbz0z2rVu/TCwYf
	 vkEhNZQ4qk2Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82A8C8101F;
	Sun, 27 Sep 2026 15:06:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC48572
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A272D40576
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCSLNBGgKBHX for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 13:38:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E020406B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790516338;
 b=Z1C1vm+iIiq5L3cEI4JkxIkP1wXSq/iufq7/GoFf+xuEzJykgu/oT/6Q1Iu+8AEEYSrL
 yCFrAdIOlX+4utBM7oeMJj0+xejQI9+5DHNdBRsv5HmwH0BJ+Us9U5JGndzmT2bAoFtea
 pJ7cs5ippzxe0bWVXlL7CuAdwSHzAfat5L30vzudpNrLDqV+FT+4bAXWXhUWXXUH+60GB
 0wZ9nN5R8qJ737W+mj22Pka/ApW9zZNsiTk4Cr/2S+RTUInKljSdDTiCEoJvIYSgNrQ2M
 AqPpo/pEkwHUvaIaMw1jM8aJ/HrP3O8f0W2hZoS2yjxXB3PLe33uE7HSgpDxTUaF0fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790516338;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
 b=kXvpcPAOwstBvLoUYPbTCOJ8rcTdd3mRoEPAhEImJYFo12GVpz75QSTMNCW0iA4XeBbI
 HfeFAkKp7nIta22ZhidBwdmFhLwgUNwIZqR7+n2zvFNMBKEjlHxK+Hq8a5mI8jy8pOUUh
 xnj/5GwQB4NugfbI4Q+CHvbv3DIWDWoAfLNSxIg9gboYp9UxwmHeqK4VHRkXBfZq/OTIO
 DpRms17iqrz7wIBkhrkhoe9pQg/wkR8PspjmvMjLe7o/+QJg4QZOfVmq+1a7BsX+XDq/X
 YVO+1477gV7aJe1AtLCVMOlp+rTFjdDy1M51L1OASl4aAFr9kERXw7x2fusGmw9Dmmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=HKzeBJrD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=HKzeBJrD
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E020406B3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790516214; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dyAosgRsn6Kv5usyTMgvGHenO3gtvG2/voB92kFeIf0OWGmfrPXarnfNuAhU1nQ8gK4jIpw7CU2Mtr/6tFoh99CoEgNQO8hX+CE3+TG4st3y5uvCei8DtxdWGSCsqVbJiSQJZLithZ4rtIgYfpoBbrFuCM4L6TM596dShqUXtss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790516214;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=; 
 b=DfhYHjOmkhZlSgECR26jai1KwCjcBvE7wFLwtMI6hac07N4rumCkgsc/lIOnKF0ey2+6g1Kqp7sqoxy1MGqZQcGSO5OK0j0JDNIKvwYCzim/r1IVh1fS42hbN3gQ/hHlxz9FHik2p83Xv2NwZBDrZAgrRi81JdLz/VQ3co/v73g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790516214; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
 b=HKzeBJrDrKDj+y67IMm2RUt06snymj1eQ6AP2ev4PFOfEi32Xl2nEWAkdmpkmvdG
 8OqRBmJBsqoU1PK2JVKt4w/DZtzPiKnMH8UMGM/R6l7BBFmrRBwlOD/B3foOlV4bFIZ
 jttlhMIrYs0nn24n6kiM83mTXMm8hd5CPrWjD2nA=
Received: by smtp.zohomail.com with SMTPS id 1790516213888773.7646303500137;
 Sun, 27 Sep 2026 06:36:53 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 19:45:59 +0800
Subject: [PATCH v5 09/10] riscv: dts: sophgo: Drop local CV18xx devicetrees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-9-f95d9173b7e3@zohomail.com>
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
Feedback-ID: zu08011227a9ca078d20b808008c996bef0000d1680addae7cbdaf8a6079cf6bea9a56d2b83618d8b0fb123b:ZohoMail
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

Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano now use the upstream
CV1800B and SG2002 devicetrees.

Remove the remaining unused local devicetree files and their Makefile
entries.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/Makefile                   |   2 -
 arch/riscv/dts/cv1800b-milkv-duo.dts      |  64 ---------
 arch/riscv/dts/cv1800b.dtsi               |  22 ---
 arch/riscv/dts/cv18xx.dtsi                | 232 ------------------------------
 arch/riscv/dts/sg2002-licheerv-nano-b.dts |  45 ------
 arch/riscv/dts/sg2002.dtsi                |  34 -----
 6 files changed, 399 deletions(-)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 71c5c13d221..c588ce546bf 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -4,8 +4,6 @@ dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
-dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
-dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
deleted file mode 100644
index e7cc0e8bd14..00000000000
--- a/arch/riscv/dts/cv1800b-milkv-duo.dts
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-/dts-v1/;
-
-#include "cv1800b.dtsi"
-
-/ {
-	model = "Milk-V Duo";
-	compatible = "milkv,duo", "sophgo,cv1800b";
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
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x3f40000>;
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
-&spif {
-	status = "okay";
-
-	spiflash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <75000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		m25p,fast-read;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
deleted file mode 100644
index baf641829e7..00000000000
--- a/arch/riscv/dts/cv1800b.dtsi
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include "cv18xx.dtsi"
-
-/ {
-	compatible = "sophgo,cv1800b";
-};
-
-&plic {
-	compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
-};
-
-&clint {
-	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
-};
-
-&clk {
-	compatible = "sophgo,cv1800-clk";
-};
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
deleted file mode 100644
index 8530527aa39..00000000000
--- a/arch/riscv/dts/cv18xx.dtsi
+++ /dev/null
@@ -1,232 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/clock/sophgo,cv1800.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus: cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		timebase-frequency = <25000000>;
-
-		cpu0: cpu@0 {
-			compatible = "thead,c906", "riscv";
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <512>;
-			d-cache-size = <65536>;
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			mmu-type = "riscv,sv39";
-			riscv,isa = "rv64imafdc";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-	};
-
-	osc: oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc_25m";
-		#clock-cells = <0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		dma-noncoherent;
-		ranges;
-
-		clk: clock-controller@3002000 {
-			reg = <0x03002000 0x1000>;
-			clocks = <&osc>;
-			#clock-cells = <1>;
-		};
-
-		gpio0: gpio@3020000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3020000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			porta: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio1: gpio@3021000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3021000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portb: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio2: gpio@3022000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3022000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portc: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio3: gpio@3023000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x3023000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portd: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		ethernet0: ethernet@4070000 {
-			compatible = "sophgo,cv1800b-dwmac";
-			reg = <0x04070000 0x10000>;
-			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_ETH0_500M>, <&clk CLK_AXI4_ETH0>;
-			clock-names = "stmmaceth", "pclk";
-			status = "disabled";
-		};
-
-		uart0: serial@4140000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04140000 0x100>;
-			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart1: serial@4150000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04150000 0x100>;
-			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart2: serial@4160000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04160000 0x100>;
-			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart3: serial@4170000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04170000 0x100>;
-			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart4: serial@41c0000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x041c0000 0x100>;
-			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
-			clock-names = "baudclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		sdhci0: mmc@4310000 {
-			compatible = "sophgo,cv1800b-dwcmshc";
-			reg = <0x4310000 0x1000>;
-			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_AXI4_SD0>, <&clk CLK_SD0>;
-			clock-names = "core", "bus";
-			status = "disabled";
-		};
-
-		spif: spi@10000000 {
-			compatible = "sophgo,cv1800b-spif";
-			reg = <0x10000000 0x10000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clk CLK_AHB_SF>;
-			interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		plic: interrupt-controller@70000000 {
-			reg = <0x70000000 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			riscv,ndev = <101>;
-		};
-
-		clint: timer@74000000 {
-			reg = <0x74000000 0x10000>;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/sg2002-licheerv-nano-b.dts b/arch/riscv/dts/sg2002-licheerv-nano-b.dts
deleted file mode 100644
index 9871a75836c..00000000000
--- a/arch/riscv/dts/sg2002-licheerv-nano-b.dts
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
- */
-
-/dts-v1/;
-
-#include "sg2002.dtsi"
-
-/ {
-	model = "LicheeRV Nano B";
-	compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", "sophgo,sg2002";
-
-	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
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
diff --git a/arch/riscv/dts/sg2002.dtsi b/arch/riscv/dts/sg2002.dtsi
deleted file mode 100644
index 0f97000fa8b..00000000000
--- a/arch/riscv/dts/sg2002.dtsi
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include "cv18xx.dtsi"
-
-/ {
-	compatible = "sophgo,sg2002";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>;
-	};
-};
-
-&plic {
-	compatible = "sophgo,sg2002-plic", "sophgo,cv1800b-plic", "thead,c900-plic";
-};
-
-&clint {
-	compatible = "sophgo,sg2002-plic", "sophgo,cv1800b-clint", "thead,c900-clint";
-};
-
-&clk {
-	compatible = "sophgo,sg2002-clk", "sophgo,cv1800-clk";
-};
-
-&sdhci0 {
-	compatible = "sophgo,sg2002-dwcmshc", "sophgo,cv1800b-dwcmshc";
-};

-- 
2.55.0
