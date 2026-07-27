Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA8BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4796606D6;
	Mon, 27 Jul 2026 09:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fw5D4xm4QxY3; Mon, 27 Jul 2026 09:09:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F7C8606A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143383;
	bh=vt+dOLUyNp4cBlUG2Li73Utpr8m5+gU678wgglhnsns=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IOgYuByQHRpiVzu9n3AJPIBMFto54L+XeAKIE4SdQJ5+JohAze5i3yCrFcdBW5cgo
	 t2yh/WEl4G0gRGpQF8s2WTmMTflf+xXF1I8oycjnkY9S1cz33UV++xH6hQNarl21cc
	 t8m1uC0HS+J08Ky1oeWwlPan3bqfI6gBZMBKzNnPMHDgQ1Qf0eBnKVYE8p/2emVbqa
	 5Ej8EFM1HhioynjO0X2MLKjZoQBf7E7hCwIyG/5cfCptokPpVf/bIXCnMlwIEe1Cmh
	 QQTwaBFFGXxoBSURtG//ZbGnNYkjgosvUmZDQxq5jZrTMAnilzlQUEJOcb1S5+uDNi
	 69bDkMQpQmWzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F7C8606A5;
	Mon, 27 Jul 2026 09:09:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C87F69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A952605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:11:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Vb3RhQ3dt7l for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:11:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0136A605ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0136A605ED
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0136A605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135201; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Oi49rox3dYQ1vVQwhVOUA0yBKeHTfHZ1Svx5wUZy5Cxfku3BI0L1TIXDPJkc4Nq2dzXQmBnNXQ4WzD76neHQDw2WCuR71ICWra37ktjm2txK3egIBHqGAN/4NoXvIQTDrBO4ZjQFEeA/PQFZqsxeB/unlbGdk7kpJF3VGECBl7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135201;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vt+dOLUyNp4cBlUG2Li73Utpr8m5+gU678wgglhnsns=; 
 b=fqRKEF1u/Pz0Bui3QWBzkbSJ99FjNHgSs1tbmEqO/obj1Jp55QwljE3tLu3ZOYgYcipWNIpb+me/4uIUpS2j6xVMoG57/5PPryTV6IiKSXGx1Tw5S6pB3Sh0g6xZpWiiZVJufy8YxOidXxfTIYNS52H21f8UqiTCtAZrVMgb+Do=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135197925905.9099683593562;
 Sun, 26 Jul 2026 23:53:17 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:13 +0800
Subject: [PATCH RESEND v2 4/7] riscv: milkv_duo: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-4-51486b4549c7@zohomail.com>
References: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
In-Reply-To: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
To: u-boot@lists.u-boot-project.org
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
Feedback-ID: zu080112270026f2aec68da651076d6f0e00002dc1204b77ae655d3238486c501c71d888720e36d1d8737ca6:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135201; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=vt+dOLUyNp4cBlUG2Li73Utpr8m5+gU678wgglhnsns=;
 b=Eqm+jbqT/YdjohMS2M436EO1YWoOx/A5WN5mIM3F/wp3Jsxbm7GuHbiY2if8yk2s
 TNpOeRoWPx/Xg7DHqGpa1Ro4Tmt7098SM4ABa3wgnc4ONuj+lXA3F5PztDr5btVjQCS
 qUcNjXwa28rfeUUKnnv2LkqawTfL5rOVqCb7/2os=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Eqm+jbqT
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

The upstream devicetree keeps the Ethernet MAC disabled. Add a U-Boot
override to preserve the existing networking support.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 14 ++++++++++++++
 board/sophgo/milkv_duo/MAINTAINERS           |  1 +
 configs/milkv_duo_defconfig                  |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
new file mode 100644
index 00000000000..509d99936e2
--- /dev/null
+++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
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

