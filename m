Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E6606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pdPYb9ST;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ly01Kwyy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E44A80D8D;
	Mon, 16 Nov 2026 17:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaBOGetxtOna; Mon, 16 Nov 2026 17:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7955680D4A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850444;
	b=ML0EjvQy6BDhgNro+rboBnM+2E8Krae+1+JN/JMTZkzanW0r0K9kZgVs/eU1lkGwkRPf
	 3OsaGEU4lgB9zi8m5/E38zaxUoxA1UZYVL+H1eL3cBsbZori9orjGhxVt+JB6ImhwtgxT
	 Vyy8AqhpqCxW+6K2N6mL4/b+RIzP5FkVcrUc5cf2wSIa+Kc2EsoSwQw3BEla2i056IFbb
	 p7ALBAOZgxdeHSrJbrKdawEF+GPaFo2QmnMh2fflXOA5uzKQcbuSRw38asN9Y2ZVrEkc1
	 pnhcR2a0tEPJpCS+jrTF4mNu9wGX4uaCXl9Fmsd5+kUCU4HXhEiAla69hGrtbbrfxmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0wBmzSWVheUN3i49xx8GijhwcpMv2GVpfrE+Yt5oxOM=;
	b=M7wJ7vfRc2x070KJ63YPLqu1SlD0pu97jq3TcC8+FAZzzbar5CD2kq/blvBxbGWiBcZ7
	 TmCVchbV1FdgZ4ZeBSqbK8ibZM0tIFUT/dSrE28XKkYy4t3oxy+SUrSxRsoM1zKU+eUTY
	 z7+Iv7LcVZVH+DafoYz2Fd1auaxRlnZFYD3gR1eMmV7dY1B4BMGanFlVpjCYtYQUpr6uv
	 CZC2+o3CIszD0ng19sGOsnxsN6T0xWxEvQHuEzJxd17immo3I6IWEH3Fc99vtPZwevAXs
	 Kq69cMrvWSp99q7vUMqQj6wUBjrOBsUalL3kdQDdQx3rL/ANjSXjVUWhSd+msFpsdpg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850444;
	bh=0wBmzSWVheUN3i49xx8GijhwcpMv2GVpfrE+Yt5oxOM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pdPYb9ST+ef8i9cDXOArZgLKdVob8qoXlO3DFKKzuFErA2HKjRvoJpu1FkxlCvoD0
	 ul0BWQYR+qDFa2ek1H6hNyaLBUyGqmHmIfn2e/wqYS08W/sCP6SaCdh10VrADtuZmi
	 c9YcjX7ZG7LjTgTfl2NLgXDBeaf3T1poxxYpg/Q7h02zouw1bX5RleEp0VtxpGELAB
	 cMBXb29ADp+0oIK74JLva2epJ3OdF16KjXwWMwlDYwE8FVDgk7kMVvOg9aju+zEJjU
	 26j2d40hCvVwM+p3jMio0G7HNVSwlyUevMU5Wexdxqqk6IuvbjWbDEtcC8t0zKS/Z8
	 ZvFTG0gpHvj2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7955680D4A;
	Mon, 16 Nov 2026 17:34:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CEB6528C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5184605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63gj0xvgkc8q for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A219605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Ly01Kwyy
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A219605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:00 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw2Y68bqzMlmH;
 Mon, 16 Nov 2026 18:33:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0wBmzSWVheUN3i49xx8GijhwcpMv2GVpfrE+Yt5oxOM=;
 b=Ly01KwyyXXDR/q/fkbYoEp45aQJjNOrZrSmmAAtUx0XmoyeiN/L21emNXk+zbFr5PsPU55
 VR3ub4DVIwfSmy/MCT+CIgsscDKGF4CCi+iQCFpoVt0XY+MVoPifkblJzaMxqNpRHzVnSR
 HKZgFTCO3ACoz82XTzcQlHdh1lEIrBrmh32BtDv5MNCkB3P0preEh8g+60ODZUoX2k6jKh
 3uTGd7jhYeCGO0Oj88Bzt6uV0tYaY1P/y0e5dfLj81Bxy+7WQjHWE46Iz1klJ8Srftvfth
 zGrwJysqj5vsbyKcjH/ycexF/TVAfxBKb0rnxX+tD7ekE1MooACUJgouCEJGBQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] spi: octeon: Align space in octeon_spi driver
Date: Mon, 16 Nov 2026 18:33:32 +0100
Message-ID: <20261116173354.3487744-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 22625f6a3feab8188d0
X-MBO-RS-META: jd66wbwyxfzp5qhgf6df5ji34bdxg3ty
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

Reduce amount of space and align the assignments to column.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/spi/octeon_spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/octeon_spi.c b/drivers/spi/octeon_spi.c
index 0e6e0f7dbe7..af77c96c719 100644
--- a/drivers/spi/octeon_spi.c
+++ b/drivers/spi/octeon_spi.c
@@ -607,10 +607,10 @@ static const struct udevice_id octeon_spi_ids[] = {
 };
 
 U_BOOT_DRIVER(octeon_spi) = {
-	.name			= "spi_octeon",
-	.id			= UCLASS_SPI,
-	.of_match		= octeon_spi_ids,
-	.probe			= octeon_spi_probe,
+	.name		= "spi_octeon",
+	.id		= UCLASS_SPI,
+	.of_match	= octeon_spi_ids,
+	.probe		= octeon_spi_probe,
 	.priv_auto	= sizeof(struct octeon_spi),
-	.ops			= &octeon_spi_ops,
+	.ops		= &octeon_spi_ops,
 };
-- 
2.53.0

