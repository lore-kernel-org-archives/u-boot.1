Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BFFC98332
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 11:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13C394068E;
	Sat, 26 Sep 2026 11:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MiAUIfZsy3uf; Sat, 26 Sep 2026 11:29:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FB4C40ABF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790422169;
	b=UvfqSQOIvcRfB+E8fSfwlUWi9GXM91rGOIs8J8zryprGjjTah600gC8j2sMjqSLkTYBS
	 3a3ny6jUKVWF1cVXseUn2CF5PurbwpSIeeLBqrnYbPv90MegGxtakOU2yKJAmuVyJ32rv
	 xSqb8PZjS5DVkNuhaelfStOXivevOld1eaNElfTYa9jPlZgvKoU6eUNeg5hQ87Mh/xoUV
	 qlZeG0TNcO8AB254pCGp3zfVPpMa3c3jrqzM7aIpAgMnKpSPHWYseINldKfMJiQx6Jd0N
	 Z5f1FhR6RgRh+vStJg88WB58ZbaCeqzN9TtVS1SoC0mtpdtwQc+5gLq5vSjIRITb6bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790422169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NTR0q9UzFu+ocLZNOIX5TaFG1Tv9Vm1e9Rj4pSMHoow=;
	b=bgsv75QFSdh/tRRrFPp0BhPhVy0dMpHXqRPUEu2Nb1mfXqcqL8re/MG8SWuZNpbsd30z
	 gjUJPiUN/A+c1wGiXrAyNCUDG28MXYKlu9CDwMYP8Ml1SpzigWTAqRGRDObkg1orruDLO
	 +lw0Ec+055Ua7f+36VRMv51XYeUf7UiHgzlrwM8hbeGAYYFPtQm/7wC5qJoVvnnE+Xrxp
	 /9iVJZEaewivFzUTnTnaLIDqweK6XpzmNQYwXdab8RTgvmo+/0vsRePw2/r4ff52fGLK9
	 yAxKalw502WKXgF16L5sx2aViN66fQHNyAnlnCZ6YryV5ytpwmgW33vQOtPXS4MxJrw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b="nJ0Jeh7/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790422169;
	bh=NTR0q9UzFu+ocLZNOIX5TaFG1Tv9Vm1e9Rj4pSMHoow=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NSK34K/q7tMS+2ooj3DJeFoO2t9iE5NeiX7Fxw9+OLrb8vaY+JnP+TukPG/kSs751
	 xrzUwGCd8jgK1QscVdag5LQpWjuRvDbaMmNpt4QMBs0igHr0FqubqvskyDSx4zAuLJ
	 k1O/TnMJ8pKdbxL/KmOvwRQBqXLgA2UqZScdItq2857z8LeyV0rqPmaZOqjb8IWevL
	 qUkN3OifW5sk4M27gtD+fJABE0t63rB2OxWbTvgxl9wcM3XM1P9e//cnpUtSujZGSy
	 ROaFRiQ6EqRvCgS0NI7pPG3YAvprYaW2fAxw+V0/EumwWPhcIu7RpijKBdLRI7TB0K
	 RYaXcQyY14CsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FB4C40ABF;
	Sat, 26 Sep 2026 11:29:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83B33194
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7582040ABF
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HyvGrHgjvJV3 for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 11:29:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 975FC4068E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790422166;
 b=A8bfiPHZ2jA2fRfTgnjiH2F241Au4ycEVRHqeB1jvZrED5IhI/EzL4PxTKuAtRatAmYS
 LyjfZFQi0PjgaZBEMWXaHxCsq2g0YM3Jxd+3QdP603bTo7ojIyVaZwDfWHohRbSBu0xA4
 qOy6zyvXBqu6m0QIDxVZ7szCSyvYrJxwk5w6ldKlT/R5roxfVvmvsvrg8vf6/gF9JUKH7
 TLz95PjCAVLO7qpcm+5eFM9t0NP33t99qSBxbL1pPSpz9yNEmE9KFsqQwv8/OQO+cdRYf
 pYakoin0cLpyZDJ4NCii/24CqMZIVCUESPpzt9xcBHj3/AtmcvNxAprE7crqR3oDXnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790422166;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=NTR0q9UzFu+ocLZNOIX5TaFG1Tv9Vm1e9Rj4pSMHoow=;
 b=LCBbWkjNw9gA2YA/dQiAXYzP4dUCt0DwagUIPyHjAT16ng/3mG8+pw/BEtN8rSxuJC2a
 xjt4PNm5Y042LJFwzNUcrmPtZXP9GVwXlx1gtw+frFPnL8LybaYGsb321jdFgiWT/kd+4
 NF28zGI5XoYvGLyjdPy0ZIde7c8o2Njcnxf8ED0i9zoqBT+bBAtrNiPDbsRdqfeBmjzXS
 0jAK6Q07XHZWZuw4T4ZKRhfoC4UKrmzNsbASXAO260jgwuec1oeHUZ+vprEhto1kMwTK+
 GBsc7gNpcE0nBN3lz6GxeE3zIN2NUtCOCkKscnArt2WGM6NClbAmpTgsbBSg6kc+SIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="nJ0Jeh7/"; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=nJ0Jeh7/
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 975FC4068E
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 19C7CB0055A;
 Sat, 26 Sep 2026 13:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790422163;
 bh=XiG+bSikjl6AYjrSbkcwPCCeBD3XIlKVmBt7gRsVYcM=;
 h=From:To:Cc:Subject:Date:From;
 b=nJ0Jeh7/3bqlzBz6atDu02et/1JudLRM19wFGh+YdI7vXb3TyuONx+jzaAbVc4Ouy
 N3v+kVNN5BFq6anBS1mQq+jbJ1JjgGHpo67Pup428tsvTnwmTza3m+9a97gkQ7coTG
 ipN+olmFmrrsNvN3NPqbeD/KXoPw8BqOlTb1QkTHqCbdTIBzrbsDx9TgfpNnAJy7vW
 bDBUC4IXAbpxL1WNV833zGMqFaQL/VFGtl+gKcLxybsYTj+GZUu4fg1ppiVD/ssUhv
 Sz+XKXn0doRCWyelw2K6esYG+UzlHXwb3rg2WHQuQSq0VkHNT7wEs/h1mOjRe1Lvcd
 kjBhCnM9ks/XQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] net: fsl_ls_mdio: add match fsl,fman-memac-mdio
Date: Sat, 26 Sep 2026 13:29:14 +0200
Message-ID: <20260926112915.471021-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Align with Linux to avoid the case when a board is using an
upstream DTS and then we end up with a "mdio list" that displays:
  "No MDIO bus found".

Note: for DPAA1 CPUs, drivers/net/fm/memac_phy.c matches the same.

While here, terminate the match table: sentinel is missing.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/net/fsl_ls_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/fsl_ls_mdio.c b/drivers/net/fsl_ls_mdio.c
index e3c37d9045f..b7100f2cca1 100644
--- a/drivers/net/fsl_ls_mdio.c
+++ b/drivers/net/fsl_ls_mdio.c
@@ -136,6 +136,8 @@ static int fsl_ls_mdio_probe(struct udevice *dev)
 
 static const struct udevice_id fsl_ls_mdio_of_ids[] = {
 	{ .compatible = "fsl,ls-mdio" },
+	{ .compatible = "fsl,fman-memac-mdio" },
+	{ }
 };
 
 U_BOOT_DRIVER(fsl_ls_mdio) = {
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
branch: for-upstream/net-fsl-ls-mdio-memac-v1

-- 
2.43.0

