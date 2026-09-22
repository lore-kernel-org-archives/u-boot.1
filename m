Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B689C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FE4D80ECB;
	Tue, 22 Sep 2026 16:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vglRSu4IeL_z; Tue, 22 Sep 2026 16:50:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2870A80EF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095811;
	b=F0JVFEE4mG7qfGr0CIoI/IFfoPlkrWkCRJGfcTPJDqTdLZu24xmAv6HfL9/uucCLp0Ea
	 UNvCZhlLJeB/RgsVv5xYITqnKK7T/h70eHwxpmCI2GEGDP+bN9agLjhoJnWnrtPBOdb5e
	 CM9Melqb4BsCiCCKGlucoGuK3ii3dfZ15A+b96LJj5TVCGzmGvSV9hGUfGJZh5hS7GoZj
	 kN/zBDnyh0f5ePo8jIUMJNqQKZWRUTupt+ejhEyFP+6g5qqgL8ZQoqqoNkVEPHuhyB6Xo
	 VNkptzXzZESfDtVhNpb6bOKCrsSqzslOHv7O+Tft7a5Ts2xdYjyoCappaLeECFqyuVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095811;
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
	b=nd+R05BtkGyySx19hUoFFZZDgWLc4Zv/94ShnTUdsVDQi0/Zit4mVJfQKj43+jYfko8z
	 yG3kzek8cXaF4vs7M9G0NlwU3c1iiTIr2Dlj//Qcfa3nQevXL8T1LaIOA9LN7MO8gg9Wo
	 D8ZOagH3p9ZDO1W94DE3t7h0B62VdrjsjCa7vsQ9zpBZYgda3MVYQNz4KvXrXy3xIXKzx
	 1f4Jm879ZeCwyFrHu1a7P+LbaXhA0zJbXYXwa5vPZCTFjstseRz5iL93FSlYXsWC66bX5
	 wOULpzEdttQ42wXyFKepZkdl5PjmSyJUIwarXt/feuv7UoIX6kj+hxPoMQfhErt+fsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095811;
	bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yd1FpQkTBRklAm069BJecy4RdW70iahdihFjuW+EoC5rhghfut53GWEsbMvPbEy1P
	 ykpAXgisiqFOxmdogrQpxJEbZUrKjdeOf0FkaSE56+QFgYwZndPzuM9gt0tWU8qudd
	 dFBrX7zgmlybbZ1Si8gvCjeDf8/koUyYkpPlHYjRfJGWGID5MfDNQZMk7H/iMzNlYm
	 FvYymvBK4BqMsqs9IYzznlO52UqP3qzkTO15rdrTPaZx6F3n7lsfGyyuQ/Iedw2vhx
	 oDFovtTnfd2WtGxZ0RavVptFn4NRCwUKu+znLY3yNYA11K9qAu84dexCqp8Zr75iul
	 7MmPWtPXorAdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2870A80EF0;
	Tue, 22 Sep 2026 16:50:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFAB49CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C202340D8E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kB0_x47JIuAs for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B486440A52
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094076;
 b=d1Fx+p5MMohDSdKxyp6R21Y5K+ETk1WPSalewkTwx5+/5hebgFHSjSvR+zOPBX+1ibgv
 GjJhJPN418ACV6Ewtg9xU0xUe28YVUDq7+2vkDoC29mKN40pXOaPOr+qxfn+NrPzbSUw+
 Ae2g6zzGvFS9+C6/mJ4Z1hzIJ+4tWKX6w1LPiqB1ovYCbxreyqBUQQ7Hn1yPoVrzc7sbx
 MZTj3QX5DhqBRP+EDoKRJKHRgqLCp1dumD2bn+S5g4iTnqUQnYzsSr8pjlsP5O5gKh/TH
 hfgqV0fOSDzAnRI3K8FpfCRhsPYlFkGIvBCbJO9T/fnvlMAay5bU+YIYsmRNmVwzbAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790094076;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
 b=WYWXJ4BK+O+bQbobc0wzPmlUJqX7CnyfPmsFG127QEhmbmrNQPQ8CeRe2Rk9I88Zor+s
 fSVUphHPkPdrHC/RKzwKVSDJQ+S1tQJUXuX9M8wh30W5e9NsLqQykojNa9EIzaRaEl1sh
 87NCzSryaUSw6o0S22DuGAT8Sah0GFDK11PZn1vZbj9H3OBb+tQ1+XF2jClmv5RcoavYh
 QSADv+M6HEkS6Kcy27G+RHXMoj7IvQgOF/FRRTz3sYkZEcRFdbdJlkfl4dC8H0950w7oq
 u4SQSS1V5LkmVzsoJZk9U6/LnWgP5WIVA8heQgGR5+bNlCxdPOdzOmGNAbVrbdS38rw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Ec570rhi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Ec570rhi
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B486440A52
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790093991; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VdrDjDI0K1QkOMiqY85vebzEcjdj1n5YsVi1QTTN3iDvIoH+4N0yxHoixpUXnEvR1WCDmXvq5/KRO6ddE2SbID6V1NGSpI8tjtei4hVuDCT/k0kuDUW84bFRI5OfZ17JBQ38SiZS91Q9Z9Zv+/eQen8229G/Cp4bBxDAlrCXGRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790093991;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=; 
 b=h/E/mPM4T+iMr8g5bfPd1IKcXNUQblNBUCz32D1bLUxBd7LShq7jNqVEHAVxK9jvmwrhU43xhIACk4vNxvUz65DLtmfm3TpEdQEM2pSqy15XTkzPOFvuZLlQ05bFQnkFDummK/fx5UKr8voYhs4RjNU2n/QjKXuWhTJ5BVYAEKM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790093991; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=qcBeg1sHPYLsT2HaqJ/C125hzxWpaAAsyR/MTDtPGnw=;
 b=Ec570rhixOsnHkljB3nWFPlQyEVWWq/54M0qJCOJ8n81KkoPrn3uzMb6pxj6olvz
 y/RHCBhZCVHfjoEr24G3f4A778O74UkPiqLY8uAVoSG+mdyuJg2YGqnXQ3Ibp/akKQW
 nuTbMcOZLtfFbeTtvq4MsW2FpeaJAuM0HIfIiVGM=
Received: by smtp.zohomail.com with SMTPS id 1790093990118886.3247472951125;
 Tue, 22 Sep 2026 09:19:50 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 23:46:25 +0800
Subject: [PATCH v4 10/11] riscv: dts: sophgo: Drop local CV18xx devicetrees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-10-d45b74dfad36@zohomail.com>
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
Feedback-ID: zu08011227aa62078e5d2986ffbdca0a6900009a3cfb36e0809334d64940fdeb6f40bff8ec742b70c854f478:ZohoMail
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
