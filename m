Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4E3C5AC7C
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EA344070B;
	Thu,  6 Aug 2026 13:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hpcurhur623Z; Thu,  6 Aug 2026 13:05:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F61E406A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021508;
	bh=7Fx2CliTqi5oyAi77EpiR7XLSeXYGZAlzigdstg8CSo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rnCfEzSojeeyaxE3emYrVIPi7RhVlauJnzovEygZlT548xOUsvIkDdbw6SUxrcFJm
	 ca8jlhhMe+0gFqrTkL0ovbdDH95aF0AslEXbkOGPNq7pETLyNpXM3rvNt6BAZZvvx1
	 2qz0lFajPsHc71abYYpOJtTYypybzn4x1G99EA0uPtfWShYVzxVxadJr9KgqiHEf93
	 ZcDHJhrDUz3AYm+bDDmwzvxw+swhTi2qBbjKURY4DAUqGyonR0sxupEchb1j7D4CZY
	 JGv8aodUr7DakvKrBOC1db+ivnGqH3QFuuIu3voS0emBfbuWKLjnUVXZ1DmhVJOYiO
	 tQ0UBLDfDXs2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F61E406A8;
	Thu,  6 Aug 2026 13:05:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF1B5392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC82E80DCE
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfUHlTDfgY0u for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:17:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C9A4780D3F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9A4780D3F
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9A4780D3F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018449; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gCxGWepJf54ceE//b2+tQoodAVJ3gRHAnoQKKvYt0uP/HgU6gcYaO9sg1HxPf5fcxCeHQomdRqdQPG/Hfnjn23EihNG7XR2rJ5pfU4+RUitvewKZPIYPX2olaXPbpdUEyTwL+mw0xw5NvFXOssCgnFdTKC7Fhhe0Jg+RiCM0f6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018449;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7Fx2CliTqi5oyAi77EpiR7XLSeXYGZAlzigdstg8CSo=; 
 b=dQhrbFfqussTkAs1REXEFu/6J7PUjYa7Bv+toWLjyVQnZNkWor/h9QO77oNsEV18v0XnZgPm7gUo9MyoJ09bJPmizA9UJK3Ym5Z4A57csfWBret99JjTl+FoE1amGG3zedTwxFTNItr8QUFXScIdfj2Ng8BTYPZ438WOEK/utI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786018446206369.5528498622789;
 Thu, 6 Aug 2026 05:14:06 -0700 (PDT)
Date: Thu, 06 Aug 2026 20:13:24 +0800
Subject: [PATCH v3 4/7] riscv: milkv_duo: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227859fc682150f138e677e6a9500003baea9b0d0de3ccbe64b6ad7605a518f3edd1d848ff9431613:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018449; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=7Fx2CliTqi5oyAi77EpiR7XLSeXYGZAlzigdstg8CSo=;
 b=OhaPEgrXK/ORimQilYDeSxEMqLT/V6slEJ6X7PRl3Cv9leeMYuGJcJ1GR6do1nP6
 cbCJ2puNzNC8WsQXxpFmRwfUga82gHPbsBKpUGeysnlVtwvTauJqq88YycjeqXigENe
 RLO/fZI1RACophrvjZpKbhqEzODWwBvtXqK9VoOc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=OhaPEgrX
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Switch Milk-V Duo to the upstream CV1800B devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/cv1800b-milkv-duo.

The upstream devicetree keeps the Ethernet MAC disabled and does not
describe the CV1800B SPIF controller. Add U-Boot overrides to preserve
the existing networking and SPI NOR support.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 36 ++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/MAINTAINERS           |  1 +
 configs/milkv_duo_defconfig                  |  3 ++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
new file mode 100644
index 00000000000..e34d105ba4a
--- /dev/null
+++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
+ */
+
+/*
+ * The upstream Linux device tree describes the CV1800B Ethernet MAC, but
+ * keeps it disabled. Enable it here to preserve the existing U-Boot
+ * networking support when using the upstream device tree.
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
index 651a0592f7a..a6ff5585240 100644
--- a/board/sophgo/milkv_duo/MAINTAINERS
+++ b/board/sophgo/milkv_duo/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/sophgo/milkv_duo/
 F:	configs/milkv_duo_defconfig
 F:	doc/board/sophgo/milkv_duo.rst
+F:	arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
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

