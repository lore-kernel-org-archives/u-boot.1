Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4322CC9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E32A940820;
	Sun, 27 Sep 2026 13:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtWZZRqZVOEt; Sun, 27 Sep 2026 13:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A6EC94080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515049;
	b=nPlF8NFecnCWVGzjhtdbZfFGae+VRVwbcjxIfwqv9ma5GJKXNzj/FQK1NHuaOi4qb3Bi
	 ECTbXurBcY668kJVuyDSsiyvJNqlqw/rhlL/w94dQlAUC7WrvviI2iGG9EDDCailC59L2
	 7BOCKW9PZeSTik4JtvZVUh3PLpNsMcGpHGz4fmVb+BbUBjtNPLQoicSmC+p2571z47LT6
	 e3qolAZnEFJ5oluYvuBhBOPwJqgYek27E9AUHrvG42aWkywe7WJRS/l0PJK49m6R1nbbG
	 yMJiB/oMmCaLqT6uAfRmDK/Ph8cOMOXYORHOBJjifFyeqbQazbGasQT2w9PoOVnBRGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515049;
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
	b=mujQulEawpBWhGKSFHTwLiJABxs+nFw9Sz41G3+7nPLpT1mvftR5U9DCj2ICUqngOooO
	 PkQh6kWokd3Ou867i2ofPOjR8epLQXsxZSdgGVe+JI/ZKyMCG4TrA3qL1ilwklIIJEBKq
	 n1DoWbH0jbhFTY4rs+Tj98MZ57YxGck86tPT5TtkmsphZtemzdYB+6z0m10hmS5X/NAcD
	 eGnb9xRzBVTrtxl139XIPJPoVIgiUT5PzRMmhLfjnFN1DyLTQuC7dwvP17s7qMcAVPvd9
	 IdBu3HBGv/isxQGVN807o0KpSaQupuIvppf41Zt8gi4nK+hhR4wEU/f2xxhop42PRVg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515049;
	bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BYtzykoKVgqjH1cmbRHSb36fSjTZtXeOUZshOkDRNX5ogB8sijIj1gatAIxaGCmJi
	 f9Ihg99nmxM0a18vjB6wD20lW2JWQeTG3jsviSMOMjBlfxkdIXK+3B2GWKGeRLma1K
	 di20EArx0PcK/fDwLrIDiI71LqcxWt45JjCmyl1XtLJ07z6fYfoHLmjPKj3JL8MDn3
	 iQAAKpX6IzHRNFHkkJU1O72bRhviZ7AYWl438blrhJ2mVyq0LVf/7xQYYXe0pfYWOu
	 TXMWziJYxFxQ28F94fS4/JaIgeSAZ65hFB4QiGelucgslFN8dp7NK/vMJrCSkaSp+u
	 Fb8eYkyiAGRfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6EC94080C;
	Sun, 27 Sep 2026 13:17:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D987A72
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB3D2400AD
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Puwr7koE_MaH for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0CF0440068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511438;
 b=kEKLA4M0712R1JqUnx+x+fkYzIaCw/cbeQgUP1iVCtp/PSaXW3au+4aCMJ6hs0jI/gho
 OMJ6qoaraiLJaylWBnT2VIw0kOvQbAafSXFcdSXf6MuI+n9MxAwwstYhm/QCJLVUXvM1M
 H4/7Tvgt669C6FeU3ImLA5/2iM3N06o6qqs/SdTpvb1z7fx3+IQHd12/2KV56kmerU0Ea
 bKVS2O/WI0GOjZi3CckIiqRaj3lOvki5IrzP3QrSXq4jGZ6XTu7i8KfUVvxUVDJr0YR+t
 Lio5hEucqgYnzcG4zxjAz9uWt8uOYGxRBJMv9RCBBIzcdomBci8rO/avbFQ6FlqLeow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511438;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
 b=Hwr4+hiRnhIIYC6qMb7h+j+QZsQ4bQ6BgFscJ8nCpPkhu0Tyfy4eUydq4UcW9+VGVaZL
 JgQce3b4V/MXbwx7rA7KnNnPJ4uzA4hXcVCIJFSd8vUsqU9pt64bUfIxDaf9iVDiuWLOR
 VVNUIKaFuJc6srqaxa0eiFjDZp4jwzmGoyhzcCCduzs6aT5YjhYMGGNnEC8YX+91X+S3S
 K3HLU+ovWPpiKTUwjRjvZMdFzmgcWy2qhbeVd4p1yIqyDF7GGXKZMTea4uEqPkHsu8vPK
 5Ydrs6Kqv6b4zYIK/VznYv1oq5/ke6Jg6/ZiUUrcqOrAV9tja9R7cCVV2q9yk6m5HJA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=YO0MJKt0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=YO0MJKt0
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CF0440068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790511027; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AsQi6Lr9q5rBJxFJ13/KWPISpFr44eL3IoDFNy7XU/SIHnWl5z+PREV+ZtWyB/AxPMXljbpY5bQNJVLg1616HWHWHYSaP8UKEr7NiDqXAx+yhAucEHIt6Z/ZAjwvJpQJadHmILD+vDGd1Weg4wAMYOTncUmfQ2Q0gYl24oU96/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790511027;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=; 
 b=jw4C/3d4CUJ24TwnsjQoe/GmE6Lwc+BwW/rggNBksN0IvAOPbuIOGMShZHefZoljyHzNhXD+rLSNOZmst2t+huOf5XMUAbdV5lUxDxsFvtvAYI0Blx2TbrLijCaPntxppAiXZdhIj0NyynIKGAeNKGjoIm/34UpkBJO0FarSZVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790511027; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=RWvcZgKP4O2+OQCYXYC8ojZq+qZY7C4AlkWoc9eICzQ=;
 b=YO0MJKt0NmC4s2EorixtMC+p4yQWeiJA6TQ2Lrc000KiXH1CfxVN1cy1Q/zrWcaH
 4q+B5seemt4GMm+9R75D0wnO2lCWFGjHQRtrUWeM7kJTx8UnDMusnEXKObhd9JazHej
 yIxwg0bBtgY7gmVO2TcekYc7LprUmVHdjpIJw29Y=
Received: by smtp.zohomail.com with SMTPS id 1790511026763668.034378095058;
 Sun, 27 Sep 2026 05:10:26 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 20:09:01 +0800
Subject: [PATCH v5 06/10] riscv: milkv_duo: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-6-7f64983e59e1@zohomail.com>
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
Feedback-ID: zu0801122781e121c7339f0f5d4c1d70c30000f921a448f6dbc64d3d55aec43d0e21292cf8a73a8a3d1a3b8f:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:17:14 +0000
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

