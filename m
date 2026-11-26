Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF00606A326
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b4Zt7yoc;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Xl/nc+x4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB9CB408E4;
	Thu, 26 Nov 2026 10:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zEwfXpYd4WJ7; Thu, 26 Nov 2026 10:47:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A985F408C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690023;
	b=gCHIgoB7bJPNBzaSPCVNa4SuY8Yd24ZclabZphzjTO2n2/uFDN02SPrQepah94E648ab
	 y5ODTEcVGZQ3tfZkrBZj3wbpcco8ll7RxxTPp2yD68JwilMn/G0GOuST+Hwqlkgzt8Z7t
	 VFjjrp9KeGf02cNnCb+CvD6OKVPCUJ9qvxzFUbM6Dh+J3FfRmgUkdAZp+YHpzE4hKfAEH
	 jTLelpVnL3Zu2JQRU/rf9qLXxUKoTMxhFaeTHyYc8PoUOOUcT+Z+bS2/+fWwhMvZ8E2yI
	 0anpkmzNR7oUjRLt/nYbFSKFrOVvfUKSLtoIeU5C/GQHuquNvlN5LuTR1wVd7gSNEgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/wDSsaQf+mxSANZX7TxGBI7PbDUa2kpAlTQKU9QMuMw=;
	b=La8ox6mY4UzDaq8DoC4U+vGp2sm3WuyOd2FHKPuyQsvniEkKleHAJ1Hz3BBObGnLibWA
	 NLMnqD6N2Qxii6tRI2J+3JUXANlxF+ZYHFfmF5d4NiS4NrZGwZpfxguRYoOL7pH00SPg1
	 qPse6+0SFmq06OMX7twUtEE8rZuGWEBu/WiFhf6+7jw3j9KWEj6zwWW7obZx5a2kJ56nB
	 lYGrcLutK7wNDV7ke2zy9UCvbhWKUPalkDXdhrOHE7hQdQpYtMp2V7lcmYqZOD7XS6Ga5
	 8E1RdMRtu1WhXbClim7TVxhxb3uR7CyRGecSk6OhhHFal872AwOFMYJsCfTn86BrYyg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b="Xl/nc+x4";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690023;
	bh=/wDSsaQf+mxSANZX7TxGBI7PbDUa2kpAlTQKU9QMuMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4Zt7yocTs8ABsj7ci+Gd9AYlkpB3typqJ97RVuZARSMaRtfRrNoo2wWLDqNjMjhH
	 mowisnKBPO+m84JSWzoqm9Mj+UCXTu4Oauwk/6uqKG3Fn8XPKYiFMumCwT4OTwGiHb
	 f/G+hc/oTLUtr0qa7GuH1StWGWc57kTz2MCwVFU+wCyMV026H3GYejIsjvP3ovebyn
	 T41EDUrbv7SWNSBBgTHqa+UyVPm3YI5X0YtTBWv411joovWbnKys348tOjuNaKdAXb
	 dNoVsPqtUOvGJ1riaBvqA3NnzkvbI9PqdY/hCzGsFiilqIKH7+LvFgiPHZ2idcBQt2
	 aCsUqdHKmq1gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A985F408C7;
	Thu, 26 Nov 2026 10:47:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66BD710B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D1A9408CD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKw9yRglLEz8 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04042408C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Xl/nc+x4
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04042408C4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/wDSsaQf+mxSANZX7TxGBI7PbDUa2kpAlTQKU9QMuMw=; b=Xl/nc+x4XgLxkeSpr7Yshxlq/+
 TIaXHeVFqSRnCmeZ9687RwHpAyLR14ZncLZ9j64KfAXgfpwNEbJKZIfdE5bwE2WAqiryrh1YFCFqy
 fXTnI5kENRRbeQAU0jGEvd6RWcOkqavTp4KbRb1beI9HxOQrgkhkn+mLzquAby7Yp2uKbgN24UYB2
 6n64E1qQfG8Kr3FqyIrxW6mDFxhsDEZYrHYmWXxlpmqgXaTPQ/BAYay/U/BUKJ/7czr5gg/uDY4Hp
 OFsrEWi7qxVqrGACGvRIniRtv6mJBfqXohQEu3zAzCm/zDr45l7m65YZgMmgdasJUOxVcvELuphGJ
 focIOAKQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX07-000NvC-2N; Thu, 26 Nov 2026 11:46:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX06-0002PX-2C; Thu, 26 Nov 2026 11:46:51 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Thu, 26 Nov 2026 11:46:50 +0100
Subject: [PATCH 5/6] board: tqma6: add support for TQMa6 with 2GiB DRAM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-update-tqma6-v1-5-a105aba78868@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This add 2 GB RAM support for the variant with
i.MX6Q/D and i.MX6DL.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Paul Gerber <Paul.Gerber@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig           |  4 +-
 board/tq/tqma6/spl_tqma6dl_ram.c | 89 ++++++++++++++++++++++++++++++----------
 board/tq/tqma6/spl_tqma6q_ram.c  | 87 +++++++++++++++++++++++++++++----------
 3 files changed, 136 insertions(+), 44 deletions(-)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 42b61cb620e..ab327c74730 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -24,14 +24,14 @@ config TQMA6Q
 	depends on MX6Q
 	help
 	  select TQMa6Q / TQMa6D variant with i.MX6Q resp. i.MX6D
-	  with 1GiB DRAM
+	  with 1GiB or 2GiB DRAM
 
 config TQMA6DL
 	bool "TQMa6DL"
 	depends on MX6DL
 	help
 	  select TQMa6DL variant with i.MX6DL
-	  with 1GiB DRAM
+	  with 1GiB or 2GiB DRAM
 
 config TQMA6S
 	bool "TQMa6S"
diff --git a/board/tq/tqma6/spl_tqma6dl_ram.c b/board/tq/tqma6/spl_tqma6dl_ram.c
index e18ac733b47..940398b34b9 100644
--- a/board/tq/tqma6/spl_tqma6dl_ram.c
+++ b/board/tq/tqma6/spl_tqma6dl_ram.c
@@ -14,9 +14,13 @@
 
 #include "../common/tq_som.h"
 
-static void tqma6dl_init_ddr_controller(void)
+static void tqma6dl_init_ddr_controller(u32 size)
 {
 	debug("SPL: tqma6dl ddr iom ....\n");
+
+	/* Disable clock access for reset */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x031A0000);
+
 	/* TQMa6DL DDR config Rev. 0300D */
 	/* IOMUX configuration */
 	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
@@ -93,24 +97,56 @@ static void tqma6dl_init_ddr_controller(void)
 	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
 	tq_som_init_write_reg(MX6_MMDC_P1_MPMUR0, 0x00000800);
 
-	debug("SPL: tqma6dl ddr config ....\n");
-	/* configure memory interface */
-	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002002D);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x00333030);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x3F435333);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xB68E8B63);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
-
-	debug("SPL: tqma6dl MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
-
-	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x00431023);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
-
-	debug("SPL: tqma6dl ddr mdctl - leave reset\n");
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+	switch (size) {
+	case SZ_2G:
+		debug("SPL: tqma6dl ddr 2g config ....\n");
+		/* configure memory interface */
+		tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002002D);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x00333030);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x66435333);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xB68E8B63);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+		debug("SPL: tqma6dl MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+		tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x00431023);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000047);
+
+		debug("SPL: tqma6dl ddr mdctl - leave reset\n");
+
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x841A0000);
+
+		break;
+	case SZ_1G:
+
+		debug("SPL: tqma6dl ddr 1g config ....\n");
+		/* configure memory interface */
+		tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002002D);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x00333030);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x3F435333);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xB68E8B63);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+		debug("SPL: tqma6dl MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+		tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x00431023);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
+
+		debug("SPL: tqma6dl ddr mdctl - leave reset\n");
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+
+		break;
+	default:
+		pr_err("ERROR: invalid/unsupported RAM size ....\n");
+		hang();
+		break;
+	}
 
 	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00408032);
 	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
@@ -131,14 +167,25 @@ static void tqma6dl_init_ddr_controller(void)
 
 void tq_som_ram_init(void)
 {
+	int i;
+	/* RAM sizes need to be in descending order */
+	static const u32 ram_sizes[] = {
+		SZ_2G,
+		SZ_1G,
+	};
+
 	if (!is_mx6dl()) {
 		printf("Not running on TQMa6DL\n");
 		hang();
 	}
 
-	tqma6dl_init_ddr_controller();
+	for (i = 0; i < ARRAY_SIZE(ram_sizes); i++) {
+		tqma6dl_init_ddr_controller(ram_sizes[i]);
+		if (tq_som_ram_check_size(ram_sizes[i]))
+			break;
+	}
 
-	if (tq_som_ram_check_size(SZ_1G)) {
+	if (i < ARRAY_SIZE(ram_sizes)) {
 		debug("SPL: TQMa6DL ddr init done ...\n");
 	} else {
 		pr_err("ERROR: Invalid DDR RAM size\n");
diff --git a/board/tq/tqma6/spl_tqma6q_ram.c b/board/tq/tqma6/spl_tqma6q_ram.c
index 0a48b5ff6ab..aec68575fb5 100644
--- a/board/tq/tqma6/spl_tqma6q_ram.c
+++ b/board/tq/tqma6/spl_tqma6q_ram.c
@@ -14,9 +14,13 @@
 
 #include "../common/tq_som.h"
 
-static void tqma6q_init_ddr_controller(void)
+static void tqma6q_init_ddr_controller(u32 size)
 {
 	debug("SPL: tqma6q ddr iom ....\n");
+
+	/* Disable clock access for reset */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x031A0000);
+
 	/* TQMa6Q/D DDR config Rev. 0300D */
 	/* IOMUX configuration */
 	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
@@ -94,24 +98,54 @@ static void tqma6q_init_ddr_controller(void)
 	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
 	tq_som_init_write_reg(MX6_MMDC_P1_MPMUR0, 0x00000800);
 
-	debug("SPL: tqma6q ddr config ....\n");
-	/* configure memory interface */
-	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00020036);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x09444040);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x545A79B4);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xDB538F64);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
-
-	debug("SPL: tqma6q MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
-
-	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x005A1023);
-	tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
-
-	debug("SPL: tqma6q ddr mdctl - leave reset\n");
-	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+	switch (size) {
+	case SZ_2G:
+		debug("SPL: tqma6q ddr config ....\n");
+		/* configure memory interface */
+		tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00020036);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x09444040);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x895A79B4);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xDB538F64);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+		debug("SPL: tqma6q MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+		tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x005A1023);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000047);
+
+		debug("SPL: tqma6q ddr mdctl - leave reset\n");
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x841A0000);
+
+		break;
+	case SZ_1G:
+		debug("SPL: tqma6q ddr config ....\n");
+		/* configure memory interface */
+		tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00020036);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x09444040);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x545A79B4);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xDB538F64);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+		debug("SPL: tqma6q MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+		tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x005A1023);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
+
+		debug("SPL: tqma6q ddr mdctl - leave reset\n");
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+
+		break;
+	default:
+		pr_err("ERROR: invalid/unsupported RAM size ....\n");
+		hang();
+		break;
+	}
 
 	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00488032);
 	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
@@ -132,14 +166,25 @@ static void tqma6q_init_ddr_controller(void)
 
 void tq_som_ram_init(void)
 {
+	int i;
+	/* RAM sizes need to be in descending order */
+	static const u32 ram_sizes[] = {
+		SZ_2G,
+		SZ_1G,
+	};
+
 	if (!is_mx6dq()) {
 		printf("Not running on TQMa6D/Q\n");
 		hang();
 	}
 
-	tqma6q_init_ddr_controller();
+	for (i = 0; i < ARRAY_SIZE(ram_sizes); i++) {
+		tqma6q_init_ddr_controller(ram_sizes[i]);
+		if (tq_som_ram_check_size(ram_sizes[i]))
+			break;
+	}
 
-	if (tq_som_ram_check_size(SZ_1G)) {
+	if (i < ARRAY_SIZE(ram_sizes)) {
 		debug("SPL: TQMa6D/Q ddr init done ...\n");
 	} else {
 		pr_err("ERROR: Invalid DDR RAM size\n");

-- 
2.53.0

