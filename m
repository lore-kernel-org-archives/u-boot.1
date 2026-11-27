Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB83606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zomZ2Wnv;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=gXhY244l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B87440A67;
	Fri, 27 Nov 2026 12:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1TBenm1PK2co; Fri, 27 Nov 2026 12:56:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B1A440A5A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784202;
	b=fyjaT1Ch/xYrlGW1qz9TljaKkW4sYFto2NRzuDjXCsQBs8xRmEmimyV5ONp/Cm+OzuzA
	 dmI4SzIBh1rKCbEmfjp5J2qfJtRljLtJ6Lr7IpeoqfeUIzUy8xhWP7rNyUT8wnDjEcNy5
	 MJ4eYX7L5D/BUyuYYpvq/gIOMHhLcIpedJQvsyFGD1kTQCLxgJ0znpSe5fC7lAiglF7Vf
	 XFvjXN/0I55SrnbLSfgVxRvUSC9Vd8AnbN3nsvURFBVAp3Do5nkMCpn80Ga0t1bu5M/RR
	 V1pZyuYZP+HCvno4i++H/p6PSNLMojPh4Q/E5IdVJKY9fPBYml4O12DxPkz8aHRkqig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y2Yk/yjQnrpM5f8zoZ9G2QdLx7Rf8bShcwp66gHwEkc=;
	b=FjAPnWwajrvtEYMM1cptf0YnOskTqN/IWanzTOXp8Y/g+o+j155etWn3Yp6fo+kOxC/P
	 zrUu0hp6dwQJ6U1+45U2LykKPhZfeABDkczHHcXfmSE4pRtTpCx6TJ5Z4UuGEMxLxiKZQ
	 0QEDKwDu86ixqVa7U2uI1UpexqQgzvTeYpqDF8ed+b4pcslKZ+Wslqz1RiGOaBgTV/j9b
	 XT/oS8Ziv4AmfsW1E8jKPzsRaIZ+ruldK/Jgfx7WP5qRAoeR2VNMvgzDmqSFPY+btemzh
	 ClbJnOSybmUY16E9sYiJlE6SG8d7P2Tn1EyqR69e20XtozHpSewcyHLMdnaoQ80Cm5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784202;
	bh=Y2Yk/yjQnrpM5f8zoZ9G2QdLx7Rf8bShcwp66gHwEkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zomZ2Wnv95Tcb67bDQ3GtvGBY783mewScM/TuLqXd5l+MKw6dIafSxuLRcmE7fYn1
	 wAV/sg+Iwzx5wmXdixz+2xto3sE4IltM0T+di68fEs7zgnDJeG/ait2RgrRy+0wv8P
	 XuB6PjlPtE7gKWA4nCRaQ7tn0G+DCb5UXxbUqgUUHA/ga4xYiVHicryVyGjhJVEkbW
	 QPFmbgZCkmJWxA0TaqKKWzIHhGxczJ0CaaFzr/AXwbGJC1MeX429X6rzbPur+X37xH
	 XRIDSigL9Zrc8jqrNNaa+fyYK9oVTU36AYLbnxBlTUOksnr2nv4lNpv0X5TBDHxZ5K
	 jUXyfiuF2Zcug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B1A440A5A;
	Fri, 27 Nov 2026 12:56:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 796CE26D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 609784004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbAgOexLKvzY for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4E332401D2
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=gXhY244l
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E332401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Y2Yk/yjQnrpM5f8zoZ9G2QdLx7Rf8bShcwp66gHwEkc=; b=gXhY244lMpSx5Q6lt7j9uDm4gB
 LiTLH0zSRyC/c6ksdYfh64wiPMani8YJ5tbkvwRe5xLcV9aNvIWhTnFt9DpeBzzyuQUhGIJa/slQ4
 jktJPOKamOsMfq5NnltO9MR3Ad8OsNzXoyi+y90U+RLT1GSBhB+Vhm6EXXTjPZks7ahUa6tEu62Fc
 5s4W74dMWqp3KgLrVXLdam3prZnjuYGCYk4WFskR9fOpIVohzC06P/DYxho5xnhQ9KBxAiwfqwum8
 DNUFuqNHzOS5UAJoRvAZMl0MQbTKHjeKB0DZFAFqG+f0uE367Dh1vO2BYALKTjbXF2FvKE5ZD9YXZ
 +BCbyXnQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV4-0006NY-26; Fri, 27 Nov 2026 13:56:26 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV3-0003Uw-3A; Fri, 27 Nov 2026 13:56:26 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Fri, 27 Nov 2026 13:56:25 +0100
Subject: [PATCH v2 5/6] board: tqma6: add support for TQMa6 with 2GiB DRAM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-update-tqma6-v2-5-3465ac0d32eb@ew.tq-group.com>
References: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
In-Reply-To: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
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

Add 2 GB RAM support for the variants with i.MX6Q/D and i.MX6DL.

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

