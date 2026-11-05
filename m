Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8037606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UxkF7bEk;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cKjr3r8g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FD8C8117F;
	Thu,  5 Nov 2026 14:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0luc40jY961v; Thu,  5 Nov 2026 14:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B08781172
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887764;
	b=QgJUKVBCCsFL3jXYp8wjyjZUGa5ugssHpAMB1dK26MiR+T9jRoc6O2MQmngT8sITkDIh
	 PwIioybnHAmsqA2hk4IaY9Rx931v3Rk8IPhxzETaQ41eNCuN14jKoJU+SAq1bITI0SkBY
	 QOe9BVVx0xUt816MKxwQPZiiFXk8zQKgp18ZEiG+vSsmtuhRpiO9xi1yIPsDHfLMWCMHY
	 hLfNnTpXAsnDF2U0lBTwbexmqJIJC71uN9TcoDIoHTXd08MjXpRoEF1TnyqX7IJ2GcLu/
	 hDFdTSNmfaQiHfzixZBQzbO76TKwZL3PPEw5y2aAGj4WNiKQ+uijPWHmk6U+OOpNsSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ndhfp4kUjbbmn3G3YnHOT0A4IlDunWCDBK7XTxH7Lf8=;
	b=K8PplRD5pI6yHtswLL6bfgs94+VGcPGeczMnDcTwTh7Zl3aD1EtHKKK1AgmvTu9pYKYT
	 krF22QXB61kF1MBZ9YJPN66FRg3D3CuG63jHft60OMasriao0/rzgiypq6vHKP6bZoqJZ
	 xp2GWE86ocjMwD0Xg+yCCR6XofRVsSrZa070fEq5VSb6FalLOj5NHJolX0a9OHcfuPb08
	 SbM9qiFtX9QTpWSYz7PPadNRjUdms/oXFpPZfn1QytkWaWu2+GWQvJoXu0PC67cfGkRiF
	 fhLFV697uH6n1b/nxmVCT8lpRg2kfhL6jitTr7nW3QERlNwUOde2I7a6idF6lDOYveQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887764;
	bh=ndhfp4kUjbbmn3G3YnHOT0A4IlDunWCDBK7XTxH7Lf8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UxkF7bEk3HOFftxPuMRM8EDQ6VmJOeb52ojlVrVsJLEpET7p6fTo63WWmCeT40uUI
	 gSWXwGziaXb/SOKq70HdczbvxXdyQfEvTRMML6fkghjdAl6w8hqlPkd2I1yHNJZtDL
	 AbeTQ+eqWs0mQ5mFp+lhn6AY5gGCtfv4o0wXaeW3OmajTTtlCSWdZ9tZ1hQ9V2sctG
	 89wX4W9od3ISQvszpWkask/3ulzbNlO6Lnsro0cEFe8snSz4ZN03yriAGig/r+a1qY
	 uBO6Fq8NyjLKYVEdcnYtRgyNJH/OkHSywuDgXjTC2ncwxuG2S3tok2ceJ/zGo+bDT4
	 EqtT84LfSNwiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B08781172;
	Thu,  5 Nov 2026 14:09:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08378235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05D1B60778
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:09:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gs4IPfJstTF for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:09:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 267BA606AA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cKjr3r8g
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 267BA606AA
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:09:21 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jL41V3jcyzKmwc;
 Thu, 05 Nov 2026 15:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793887758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ndhfp4kUjbbmn3G3YnHOT0A4IlDunWCDBK7XTxH7Lf8=;
 b=cKjr3r8gqZe5VtYaEWrsIZDdlTpst2i5E/7rGvpa/rVfk9Zoh2n725b+SiHvKV5QyAAjMu
 /Hs/DCGbhPqoM8GN1uQ1eFEI5dBNmnNr/B/Sm8lwucoJpuqrrEX7w766E7MJUy3aZa1sW1
 0Mmlf3zy7eZdU37BcK2abdNjidqh/G3DRBKTCgP8fM/ehDVZ5WPLtFt5IbzpX/RuSLRI4o
 al2S7IgXwKQ3JrVxiNQYoybTcqUw47lNUimhoadzCUBCM0aLl3JPh6hOarVaD74UakGgmn
 qxG8TLdtFEiid9210w6PgzN1YT/VEpsWAohdG5NJqJCuPi8dZa5eDFIJxzqoDQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Vincent Jardin <vjardin@free.fr>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v2] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Date: Thu,  5 Nov 2026 15:08:57 +0100
Message-ID: <20261105140915.10682-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5919df8702bfa7fb0de
X-MBO-RS-META: agyk8d9rbmerzk863uhydrojcg4k5mn6
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kenichi Nagai <kenichi.nagai.ry@renesas.com>

Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
with Post-Quantum Cryptography, SPI, Quad, Octal and DTR .

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Signed-off-by: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.u-boot-project.org
---
V2: - Add RB from Kuwano-san
    - Drop product page link
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 67486d7a945..fce22300b61 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -670,6 +670,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25q01nw-im", 0xef8021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q02nw-im", 0xef8022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("w77t51nw", 0xef8e1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XMC
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-- 
2.53.0

