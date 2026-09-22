Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E118C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85D6940DC4;
	Tue, 22 Sep 2026 15:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qaRd84ZZhy9A; Tue, 22 Sep 2026 15:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3165B40D91
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090113;
	b=PBFjQE/K8sxDap4EitZOjlxUJ3pDLkvgsRQ30IcMlXl7xBuxnTmQRbVLsbaFGr7h2H6I
	 VYgDz2RL/PbIQ6zk9IDCmTX4IGGeb6zpxNGuxv/iaBaj+TszdsB/aSLPDZKHQ8nChyKUm
	 wGJR2cunTG9qbMTl21EJTH3yNfAK+RKWmFP0fsbgLU5bhIpk4zAePPgAHe0xBtnyjMdrd
	 AXBJ4L7f0LUJJ2Gt3cOrrKquTCS/izTgNZT+VTwQdUifC/QQ/i3Tr8NE5gHzP/ZVFFYpu
	 k0CMpiJy8qTiHHpd4u+2gZIEbAAw0AUoYtxvXJVY/vLzpkHMZbrciGp2VTzoXhbnLTg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
	b=EouxoKWDLukuO4y08tjA9jpfh1MEuKaSca1bWzI2a3JUidAstUaSmUyl5NBf4xZLpDiQ
	 WCJKmpTmak2a7Jc3JcCsRlaOQ2con1qSQSW809XMiLP5xXuR52Tkj63WFwEkhMVnivTWK
	 1vW3eUJK1whozOsnPYbyOvpodcA5WipEoO9pVDa4MkKj3+kJo1b6iraIW0V2Iw1pavqqA
	 zcatVSWmHM9PNmGwpKqkrkDd/kUe76VyCYnYNL9rTsNtAt3vP8tTN1a++w+M5cSlQwpre
	 INWPjFxSY2NV2w73eiSVOT/RFcPVegjjvXHmDwr3ortytxh6wKApVQeAnLkMZYNO03Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=APehag3t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090113;
	bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4IrPnz7iKWzAm6XJhAjhCWM0n0g9jcf5anARW+iada2mgrRTdpe567bPkr2sS6Jf
	 Ar1gHqluJEr+kf62y8k7UXzWPAHW9WImLkbczE3j1h3r4vT8d1t880PHDiuwpFu3wg
	 dIsA5NQ2DYU2Tv3SGlvIpjYETvFSrMUWQ8R0lecdObz1mW+JXO61wTSc/+sFmPYNjl
	 HIiW9lrRXSrzf3A4GVExElylnsRrliDO01Kn0RnJC1yDnUiJbLtbTrPt6I3zL5iJu4
	 IUaDRf75VmljiKGyF3YvKb2KXv9Bu9LywlvTjBJPp22gE/tGFOJQxDaNBIBuxt1dge
	 58FgJmLJ/Qscw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3165B40D91;
	Tue, 22 Sep 2026 15:15:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50B4B9CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 429CF40AD9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:09:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id feVewn9yWyJJ for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:09:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 65B8F40AFA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.92
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089751;
 b=KVGvJ8IYmTq+2ibfhlv5pw1uWyzCJ+SMksQUbBjlmVjw3/eimZdlEp2mOSB3x8Y120Zj
 zomDT3kr876D3wgK3dAdYiVtItqEjJuvpTHTNgNFqZTb89TbOpZS6c/WGewt1VdFxvO0p
 En9/dh69A0tDNKRMl2hJOsuT+rHMGLEUJusfwFj1UoRFAGmdgOfDML4I+mCHG4AZRUEhR
 /frPieMIvXv6lb+3XJYxwZ6Gu03xQoMYmdoCrI5dyuTIqSzIEJCxKEry0u9pTsDMLUVwH
 BwYKfLzRTUHBK8glMz6LbORhttKtIAmZmBwaXLJ+Zh1P20B0hltGg+o4AS0EdG1rBQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089751;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
 b=ZlVsNW2ENGY2VgyDxMXbjHGzjNRbs2M2iCcPzuUiFlwccdK/G+qGeOdCiq9oqP7/0eJv
 y1OAYIpiwLworCfd3FKAhh63g/2HHPEaA6UAIAPtlHXUXKR3EMs/27T6rn43e6N3dug6c
 X3wpDsoLADMyFgy1OZH4pV0hQiGy0WG1rO8Met2J3B2gSsGg9ohWnTPE9nV6ciKwWrSNK
 t2qsBTuxaAUbcJm6HWMs0rGZ3LdJjPEFAz4Hgv2BYnluG4vu+GS8f7vnDKCvrzx0oqrVa
 /MlR66KXuRNfGZDy7p81O14U/oDCE4rXOr35TeGm6pjL1ixjZ/+aOxJ/GzRPzx2Kzeg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=APehag3t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.92;
 helo=sender6-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=APehag3t
Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com
 [165.173.180.92])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65B8F40AFA
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790089237; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ADJXV8FUStCUeBabfrDDkaceBoEaTS1eNjv3Wh+BLdDPQ3YHmARoG3nxlYP8YG4APUkk3yp3LrjaBdLIiYpfeJ2R4vcMxsH16ZegOPdUG/D5meeViso9S8YinJZcmez2TglUkmIuchRkkvjcxmbRrvUe5CRx6uYWmbeE9UuBfp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790089237;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=; 
 b=GK7QwLOmUdwCJBsh05OM8IbHjhABp1bmoYTCRWsyh3+IfDe2KYnc39d8UE+E8m+LosdvJJu8PIpSgM5QyPBvuihn/quMGAdvwHnQMgdT7q1WOAr5aO72zKagxYykH8e2uO3pX7flo1IIeXrp1jOiPbg7L1YxtC+qUmDnRPR8QuE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790089237; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
 b=APehag3tFitRwbd5Z7wjvrCNMvDCwByw7fn0g6WQ5xIVZ3fynquyIsWr4nb/Uj0G
 Tt1j5ghfxv7df2xwkU7RLEvFdEd8rngQq2sG+CkMxUNXjEFmPjHh7UTgXH9K2JVtJkx
 0yQuWho7BneivTurBJGzTZ6+tphgSlrOJ1XZVSbQ=
Received: by smtp.zohomail.com with SMTPS id 1790089236163557.7257829858845;
 Tue, 22 Sep 2026 08:00:36 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 22:59:13 +0800
Subject: [PATCH v4 06/11] riscv: milkv_duo: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-6-d45b74dfad36@zohomail.com>
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112271c3106395f232dc0e6d8cbcf0000bdbf98a44964c2a471a3fedfdb5704a140cf1088d724e9dff7:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:15:02 +0000
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

Switch Milk-V Duo to the upstream CV1800B devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/cv1800b-milkv-duo.

The upstream devicetree keeps the Ethernet MAC disabled and does not
describe the CV1800B SPIF controller. Add U-Boot overrides to preserve
the existing networking and SPI NOR support.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 35 ++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/MAINTAINERS           |  3 ++-
 configs/milkv_duo_defconfig                  |  3 ++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
new file mode 100644
index 00000000000..3a1d01e8940
--- /dev/null
+++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
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
+&{/soc} {
+	spif: spi@10000000 {
+		compatible = "sophgo,cv1800b-spif";
+		reg = <0x10000000 0x10000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk CLK_AHB_SF>;
+		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
+		status = "okay";
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <75000000>;
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+			m25p,fast-read;
+		};
+	};
+};
diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo/MAINTAINERS
index 6941dc5b376..8ca551426ae 100644
--- a/board/sophgo/milkv_duo/MAINTAINERS
+++ b/board/sophgo/milkv_duo/MAINTAINERS
@@ -1,7 +1,8 @@
 Milk-V Duo
 M:	Kongyang Liu <seashell11234455@gmail.com>
 S:	Maintained
-F:	board/sophgo/milkv_duo/
+F:	arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
 F:	board/sophgo/common/
+F:	board/sophgo/milkv_duo/
 F:	configs/milkv_duo_defconfig
 F:	doc/board/sophgo/milkv_duo.rst
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index f1f3930564b..9d6b80362d5 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
-CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/cv1800b-milkv-duo"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="milkv_duo"
 CONFIG_TARGET_MILKV_DUO=y

-- 
2.55.0

