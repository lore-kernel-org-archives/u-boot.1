Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA8606A330
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=he/WkAiX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cJ1Sladr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B66C0810A4;
	Mon, 16 Nov 2026 17:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id td47hRws6Vvy; Mon, 16 Nov 2026 17:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12958810D7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851420;
	b=YwrXat2JKGA94qAhEPK8FA9eoaaqXeXSsIUCZ+V39kkNprgvevHEIKxfkGTFCTxbI49g
	 g5KELAowe6sHD0l6w76QynVcQ1UBTJ6fdxLh1snSnGkCRxTo2TyfaW9vhPWYtUuUR9FEt
	 lIJaf/0PgXOOIUz3mhOzRK/IzKEkamr+oFgFVtzPjP7/4LmiVP3CR6hPUe1U5HIaABdD0
	 mRHrFIU7/REuenSfgUYoxlATPcSZfk4fCuej9QqWvL0IC/FvcpFmzcnLprReZtHYComcb
	 HGLpf44QIPHqAk4QZEyd/wlz1dMkehP2jQDK9HJUU9Ig+RqkG3fMV73aI+EtTt153fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4GD/Q/aHsP3dVq4NKbQ34warISh53ChBtKU1K1erlH8=;
	b=XyjXPPfe5VtbzZIADEPXr/aQaaxnmY5HraWOqoJmOieXFBz//TBNzfXtlUXqnDd80N7f
	 dGf6KILnDCi4J7p2vJe3WLSEJXOKm5FmP2qNIDEw+bzLRyqtE6RnmcLHX+8M/d92lTqlP
	 rmmdHmVA8it5G+VDPRnb50SVF16tY7YLnif0klyhdLF8gooyzI5a23eOOMPD0fwyj52Nv
	 kil45j9LX2HFz2d1wEF4vdZhLvUq86y7bZMrC2XQD4sTdngC05suHd/jP3SliHhJ170aG
	 KtUuXwcghI/otnvxAktuMmQvgawkOysDFuLhMnLaI+V9TBqi2gxOdNqxOucNu9BVbkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851420;
	bh=4GD/Q/aHsP3dVq4NKbQ34warISh53ChBtKU1K1erlH8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=he/WkAiX5LANY91qohrBPmi6kQXN8BNyiTcAJCgUtKwVW1hu56Q2bwK1WyC7qbYZJ
	 G4hc8EQHwyiDId5mCaMnrvh3G6+Z8vgB0Y1KY1Z0YWkYbbdpNFJN31f/TeBuFEFXlp
	 b+VCkwJLxe073ySH1ppOFJO2ed4HHEImkqg61TcY5oa87Clwb5FzVVYJi+/xAKAXda
	 lAg8MxCct06elnMqYK+ka4JPlbd1/lz5BoDX/zUs09/CQM2DTV+gLNLAoydR2EoVAm
	 MbsVSR6KPoAs4a+cDMNOXrwwOdbC/nFmwmIKnh48yx88wvyq2ngiEC3IJPno6Rf6bG
	 +8J3MuoyvNRpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12958810D7;
	Mon, 16 Nov 2026 17:50:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E7E54DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 800C7607B2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:50:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0QK64_-nAHL for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BEDB60763
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=95.215.58.207
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.207;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=cJ1Sladr
Received: from mta1.migadu.com (out-207.mta1.migadu.com [95.215.58.207])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BEDB60763
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:50:10 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=IMYjFvlUHovUAcnAR/WQvC1vT37ADoUVW1JikD0T+lA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794851408; v=1; x=1795456208;
 b=cJ1SladrYHnwUA0jYUgGaKWD4Amzq0Z1TdwJDlUaDuxhU/mVo6pHrqZuWMDf4rvORx7Zw10t
 TvZRurTPk1TBZ87kama4r/X92BHg/79kF6s/CqorM7NjpDgQ7C12YZ8/ySRSX4Ptjg6Hw8xnOZ6
 Ee2b07+yu7YzP6emtdbW52pQ=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 90e0c04383764514;
 Mon, 16 Nov 2026 17:49:03 +0000
X-Mizu-Trace-ID: 90e0c04383764514
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 17:49:03 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
CC: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Bin Liu <b-liu@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Joel Stanley <joel@jms.id.au>, Julien Stephan <jstephan@baylibre.com>,
 Mario Six <mario.six@gdsys.cc>, Minda Chen <minda.chen@starfivetech.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ram: Constify driver ops
In-Reply-To: <20261116174226.3488225-1-marek.vasut+renesas@mailbox.org>
References: <20261116174226.3488225-1-marek.vasut+renesas@mailbox.org>
Message-ID: <D69AE280-3918-487B-B782-7A22247010A3@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16 November 2026 17:42:19 GMT, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.

Acked-by: Bradley Morgan <bradley.morgan@linux.dev> # PowerPC


>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>---
>Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
>Cc: Bin Liu <b-liu@ti.com>
>Cc: Bradley Morgan <bradley.morgan@linux.dev>
>Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
>Cc: David Lechner <dlechner@baylibre.com>
>Cc: Fabio Estevam <festevam@gmail.com>
>Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>Cc: Hal Feng <hal.feng@starfivetech.com>
>Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
>Cc: Joel Stanley <joel@jms.id.au>
>Cc: Julien Stephan <jstephan@baylibre.com>
>Cc: Mario Six <mario.six@gdsys.cc>
>Cc: Minda Chen <minda.chen@starfivetech.com>
>Cc: Neha Malcom Francis <n-francis@ti.com>
>Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>Cc: Peng Fan <peng.fan@nxp.com>
>Cc: Ryan Chen <ryan_chen@aspeedtech.com>
>Cc: Ryder Lee <ryder.lee@mediatek.com>
>Cc: Stefano Babic <sbabic@nabladev.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Weijie Gao <weijie.gao@mediatek.com>
>Cc: u-boot@lists.u-boot-project.org
>Cc: uboot-stm32@st-md-mailman.stormreply.com
>---
> drivers/ram/aspeed/sdram_ast2500.c   | 2 +-
> drivers/ram/aspeed/sdram_ast2600.c   | 2 +-
> drivers/ram/aspeed/sdram_ast2700.c   | 2 +-
> drivers/ram/imxrt_sdram.c            | 2 +-
> drivers/ram/k3-am654-ddrss.c         | 2 +-
> drivers/ram/k3-ddrss/k3-ddrss.c      | 2 +-
> drivers/ram/mediatek/ddr3-mt7629.c   | 2 +-
> drivers/ram/mpc83xx_sdram.c          | 2 +-
> drivers/ram/octeon/octeon_ddr.c      | 2 +-
> drivers/ram/renesas/rzn1/ddr_async.c | 2 +-
> drivers/ram/sifive/sifive_ddr.c      | 2 +-
> drivers/ram/starfive/starfive_ddr.c  | 2 +-
> drivers/ram/stm32_sdram.c            | 2 +-
> drivers/ram/stm32mp1/stm32mp1_ram.c  | 2 +-
> drivers/ram/sunxi/dram_sun20i_d1.c   | 2 +-
> 15 files changed, 15 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/ram/aspeed/sdram_ast2500.c b/drivers/ram/aspeed/sdram_ast2500.c
>index 0d6ab79f96f..6a63b72a8f8 100644
>--- a/drivers/ram/aspeed/sdram_ast2500.c
>+++ b/drivers/ram/aspeed/sdram_ast2500.c
>@@ -420,7 +420,7 @@ static int ast2500_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops ast2500_sdrammc_ops = {
>+static const struct ram_ops ast2500_sdrammc_ops = {
> 	.get_info = ast2500_sdrammc_get_info,
> };
> 
>diff --git a/drivers/ram/aspeed/sdram_ast2600.c b/drivers/ram/aspeed/sdram_ast2600.c
>index 2cf9296468d..5bd3ed8c4ea 100644
>--- a/drivers/ram/aspeed/sdram_ast2600.c
>+++ b/drivers/ram/aspeed/sdram_ast2600.c
>@@ -1158,7 +1158,7 @@ static int ast2600_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops ast2600_sdrammc_ops = {
>+static const struct ram_ops ast2600_sdrammc_ops = {
> 	.get_info = ast2600_sdrammc_get_info,
> };
> 
>diff --git a/drivers/ram/aspeed/sdram_ast2700.c b/drivers/ram/aspeed/sdram_ast2700.c
>index 8605a92abb2..b8c2f5336b2 100644
>--- a/drivers/ram/aspeed/sdram_ast2700.c
>+++ b/drivers/ram/aspeed/sdram_ast2700.c
>@@ -1021,7 +1021,7 @@ static int ast2700_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops ast2700_sdrammc_ops = {
>+static const struct ram_ops ast2700_sdrammc_ops = {
> 	.get_info = ast2700_sdrammc_get_info,
> };
> 
>diff --git a/drivers/ram/imxrt_sdram.c b/drivers/ram/imxrt_sdram.c
>index 3df106c9b79..f5a1e5e60e0 100644
>--- a/drivers/ram/imxrt_sdram.c
>+++ b/drivers/ram/imxrt_sdram.c
>@@ -434,7 +434,7 @@ static int imxrt_semc_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops imxrt_semc_ops = {
>+static const struct ram_ops imxrt_semc_ops = {
> 	.get_info = imxrt_semc_get_info,
> };
> 
>diff --git a/drivers/ram/k3-am654-ddrss.c b/drivers/ram/k3-am654-ddrss.c
>index 21ff9d761e1..13a11f0626a 100644
>--- a/drivers/ram/k3-am654-ddrss.c
>+++ b/drivers/ram/k3-am654-ddrss.c
>@@ -1078,7 +1078,7 @@ static int am654_ddrss_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops am654_ddrss_ops = {
>+static const struct ram_ops am654_ddrss_ops = {
> 	.get_info = am654_ddrss_get_info,
> };
> 
>diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
>index c406998b20a..4595ef47b9a 100644
>--- a/drivers/ram/k3-ddrss/k3-ddrss.c
>+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>@@ -1011,7 +1011,7 @@ static int k3_ddrss_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops k3_ddrss_ops = {
>+static const struct ram_ops k3_ddrss_ops = {
> 	.get_info = k3_ddrss_get_info,
> };
> 
>diff --git a/drivers/ram/mediatek/ddr3-mt7629.c b/drivers/ram/mediatek/ddr3-mt7629.c
>index e9791697066..597f9e51ad3 100644
>--- a/drivers/ram/mediatek/ddr3-mt7629.c
>+++ b/drivers/ram/mediatek/ddr3-mt7629.c
>@@ -750,7 +750,7 @@ static int mtk_ddr3_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops mtk_ddr3_ops = {
>+static const struct ram_ops mtk_ddr3_ops = {
> 	.get_info = mtk_ddr3_get_info,
> };
> 
>diff --git a/drivers/ram/mpc83xx_sdram.c b/drivers/ram/mpc83xx_sdram.c
>index 28a663289a2..9003febd7d1 100644
>--- a/drivers/ram/mpc83xx_sdram.c
>+++ b/drivers/ram/mpc83xx_sdram.c
>@@ -1074,7 +1074,7 @@ static int mpc83xx_sdram_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops mpc83xx_sdram_ops = {
>+static const struct ram_ops mpc83xx_sdram_ops = {
> 	.get_info = mpc83xx_sdram_get_info,
> };
> 
>diff --git a/drivers/ram/octeon/octeon_ddr.c b/drivers/ram/octeon/octeon_ddr.c
>index ff2899d7484..23a36fc32ae 100644
>--- a/drivers/ram/octeon/octeon_ddr.c
>+++ b/drivers/ram/octeon/octeon_ddr.c
>@@ -2710,7 +2710,7 @@ static int octeon_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops octeon_ops = {
>+static const struct ram_ops octeon_ops = {
> 	.get_info = octeon_get_info,
> };
> 
>diff --git a/drivers/ram/renesas/rzn1/ddr_async.c b/drivers/ram/renesas/rzn1/ddr_async.c
>index 4d470aae191..306193f8678 100644
>--- a/drivers/ram/renesas/rzn1/ddr_async.c
>+++ b/drivers/ram/renesas/rzn1/ddr_async.c
>@@ -250,7 +250,7 @@ static int cadence_ddr_get_info(struct udevice *udev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops cadence_ddr_ops = {
>+static const struct ram_ops cadence_ddr_ops = {
> 	.get_info = cadence_ddr_get_info,
> };
> 
>diff --git a/drivers/ram/sifive/sifive_ddr.c b/drivers/ram/sifive/sifive_ddr.c
>index c555d2af2d0..007989c4f16 100644
>--- a/drivers/ram/sifive/sifive_ddr.c
>+++ b/drivers/ram/sifive/sifive_ddr.c
>@@ -387,7 +387,7 @@ static int sifive_ddr_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops sifive_ddr_ops = {
>+static const struct ram_ops sifive_ddr_ops = {
> 	.get_info = sifive_ddr_get_info,
> };
> 
>diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
>index e151179398f..9083f421b41 100644
>--- a/drivers/ram/starfive/starfive_ddr.c
>+++ b/drivers/ram/starfive/starfive_ddr.c
>@@ -138,7 +138,7 @@ static int starfive_ddr_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops starfive_ddr_ops = {
>+static const struct ram_ops starfive_ddr_ops = {
> 	.get_info = starfive_ddr_get_info,
> };
> 
>diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
>index 954995c499c..533892582d6 100644
>--- a/drivers/ram/stm32_sdram.c
>+++ b/drivers/ram/stm32_sdram.c
>@@ -395,7 +395,7 @@ static int stm32_fmc_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops stm32_fmc_ops = {
>+static const struct ram_ops stm32_fmc_ops = {
> 	.get_info = stm32_fmc_get_info,
> };
> 
>diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
>index 5f9b91d50e4..1c50e3164f8 100644
>--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
>+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
>@@ -397,7 +397,7 @@ static int stm32mp1_ddr_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops stm32mp1_ddr_ops = {
>+static const struct ram_ops stm32mp1_ddr_ops = {
> 	.get_info = stm32mp1_ddr_get_info,
> };
> 
>diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
>index 79cf0a51e47..ae2b421e1cc 100644
>--- a/drivers/ram/sunxi/dram_sun20i_d1.c
>+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
>@@ -1431,7 +1431,7 @@ static int sunxi_ram_get_info(struct udevice *dev, struct ram_info *info)
> 	return 0;
> }
> 
>-static struct ram_ops sunxi_ram_ops = {
>+static const struct ram_ops sunxi_ram_ops = {
> 	.get_info = sunxi_ram_get_info,
> };
> 
>

--- Thanks!
