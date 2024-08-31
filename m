Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0E7CD13DF
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0729A88DA4;
	Sat, 31 Aug 2024 22:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PTR1qVSa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tDD7AFY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0141888DB6; Sat, 31 Aug 2024 22:32:18 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195F68861D
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Wx6Bl5v74z9scZ;
 Sat, 31 Aug 2024 22:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eiptkV8sDTaEm5WUBlRCYJu5Ra8tt8mqwB3Vw0awlU=;
 b=PTR1qVSasOW/PvpE3Fwl2DNW/XlvXzKXP/XP779LCK8pXT0CjrADtatbwXfZfFx4n4PP1v
 9eO6Wn1NVLMeVuBvBWn5YDfBHND5+tzNSgvAieeck5zMkU/1Ua08zuzDDRdoXfKRxKv8T1
 mmY3jiYwFp+6XvXHF74Zo7tLVxWvH8l1EFGo8cqQXf7aaG64FI5njXSsZsudu4rAGFdEcp
 cPQnbEW6EWAvTqt5hOnVKCn6lrCiM4RublMFe+jCF1rtBzTp2o4XuuNbJwySYIl7utKcfh
 v8YyVQOpPGgs4TopJWdklgZnGFt72yORHr0y9RfqyOpiHSKNtw16KQy3U8Ti9g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eiptkV8sDTaEm5WUBlRCYJu5Ra8tt8mqwB3Vw0awlU=;
 b=tDD7AFY2aiuDj0pg2zgRRPzMYzCS2jQzCV/KHW9CzeMcv20ldSTlOId5M/smHNXGaTkJ9C
 tIioyZUbir58hoNl6xNLxgYHbDaqfMoP5IOQcKQQq6vGs3cIgRVZ6kvdKYcKMmwFOrOLPq
 9hP0utjpIQ+soB6dn6YtTZWk5IWQMmMQD7wV22hLL8MJftxp/bbxb4ZLJrTpKR/h8RmJSp
 kicidjP3pNUsJnjmDQBCswfhMjP+fNK0hQBk9GX+tR9NSiNh7Pigvtfoe5AGb6ex9knme0
 ycl37wxCUsBLzADQnyVoxdLOyyz95g5/VvouwMdSWMgtW5hrlJ4y2HF4UEuvHg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 5/5] mtd: spi: renesas: Add R-Car Gen4 DT compatible
Date: Sat, 31 Aug 2024 22:31:48 +0200
Message-ID: <20240831203153.547743-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
References: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0031977272fc2e6a3ce
X-MBO-RS-META: 6wtsdy7ms1ckzhe5j8bra38tkaf6ajcq
X-Rspamd-Queue-Id: 4Wx6Bl5v74z9scZ
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

Add device tree compatible string "renesas,rcar-gen4-rpc-if" to
the driver to match on upstream RPC DT node in R-Car Gen4 DTs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de
---
 drivers/spi/renesas_rpc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 9aab71db1de..f1e6f9f4e01 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -465,6 +465,7 @@ static const struct dm_spi_ops rpc_spi_ops = {
 static const struct udevice_id rpc_spi_ids[] = {
 	{ .compatible = "renesas,r7s72100-rpc-if" },
 	{ .compatible = "renesas,rcar-gen3-rpc-if" },
+	{ .compatible = "renesas,rcar-gen4-rpc-if" },
 	{ }
 };
 
-- 
2.45.2

