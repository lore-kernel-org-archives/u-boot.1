Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC1DC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 23:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12AEF885EC;
	Sat, 13 Jul 2024 01:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="bD86c4jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C65088637; Fri, 12 Jul 2024 16:19:17 +0200 (CEST)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F206B88792
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 16:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1720793954; x=1721053154;
 bh=roajSpeTKlVgI68uvNAzEi5FfrsvjXrZPTi/Rw1sa7Q=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=bD86c4jjh/aGhicwXVNVcItiZJP0GFWK3iC0XRqhaCpq1c2QJWToXXVImFRskawrF
 1Eb7U5n4oqZ4xhd5jGEo6NtsGT4OsMa/KtLU4hl0SkTBnvQwKI10kCq+YkomEBCK5k
 CeGdXQLaDU8LKOdqJozPRCcLGIcblAuGSnigqDWwWSUF65nSb5pvS1AI7bog3xnvbv
 bTmfmDvfkc3YJ0h7K8hQwDwaaA0KrzVNoyzCmIUBHcJ2mC4k+fTuDL9s3e/Zf2Qs9H
 E9k67yie1eNF0t80yd+utEVVTQe0+GjtV5jgPeKJdh6eDJbLG2RZXOm+IEbDIpH3ER
 HEJuKbeqOnCkQ==
Date: Fri, 12 Jul 2024 14:19:10 +0000
To: lukma@denx.de, seanga2@gmail.com
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk, u-boot@lists.denx.de
Subject: [PATCH] clk: imx6q: Add definition for IMX6QDL_CLK_I2C3
Message-ID: <20240712141907.27677-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: 44e8a43ab05e39ead1562a10032530b67e5177e0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 13 Jul 2024 01:10:01 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Commit 727fa4539ca2 ("clk: Add support for I2C clocks on NXP's imx6q SoC
which use CCF") added I2C clocks for I2C1 and I2C2, but not I2C3.
Consequently, devices using I2C3 fail after enabling CONFIG_CLK_IMX6Q
and thus CONFIG_CLK. Therefore, this commit adds the last I2C clock.

Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index ba9923d8f6fa..5994155735c7 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -128,6 +128,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 =09       imx_clk_gate2("i2c1", "ipg_per", base + 0x70, 6));
 =09clk_dm(IMX6QDL_CLK_I2C2,
 =09       imx_clk_gate2("i2c2", "ipg_per", base + 0x70, 8));
+=09clk_dm(IMX6QDL_CLK_I2C3,
+=09       imx_clk_gate2("i2c3", "ipg_per", base + 0x70, 10));
=20
 =09clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2("enet", "ipg", base + 0x6c, 10))=
;
 =09clk_dm(IMX6QDL_CLK_ENET_REF,

base-commit: b4cbd1a257d4027038b4f997d73bdb0a066db045
--=20
2.45.2


