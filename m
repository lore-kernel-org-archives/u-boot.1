Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E52CD3423
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD3688D82;
	Sat, 31 Aug 2024 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qEXe/10K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s7NVlBFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2747488D8B; Sat, 31 Aug 2024 22:30:47 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2363B88D3D
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wx6905kGWz9sqr;
 Sat, 31 Aug 2024 22:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v0n5SxvbrONXQJ8Gf7ucAQagEs3KzGA6msdPgGTXV7c=;
 b=qEXe/10KyJS8QnSEIY1hHoYu3lPcSxfpNY5gD5lb+RoE4vB1/kw+u8T9sHp88EjJcO9a14
 yqvcxzzQ2032mvnEXGPeWEhDtHFddQgnO0gvxsDALY3PeAN5d0zxS47/q8f/OvjoR4FXyX
 L5mJwSuqZ0cwWgIonwW4AZT+v2PBi3OldGAt9x4PNdSv8wIacXAd+IA2KC0Xey8LdiWPgt
 xr5sl7HizVQNFzcx2yOR3g1Wf5WSIzSojI+2+r4h64XT23gPfsV22e+Dxy5aHq8P6V8nQ0
 8oeQ34P58rANyU0tfcIc2Gld7EfdpULXt5Pq3XFJ6r0SvtjUtjmg++qSsr/Aow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v0n5SxvbrONXQJ8Gf7ucAQagEs3KzGA6msdPgGTXV7c=;
 b=s7NVlBFwhwlRv9r3A8Kf0T7J7ZyX7TCMzk6Uia0tzEjnOtDWzQjYW/Y/FKEYQmdqZu4V87
 rYN/Js6DmZHMxrIZYvEjREniIaUWnCzYgnENLVP5arqEkhuRwvpNOoqVpJ1Jsiw5b30oti
 CElRILASKpxbUgINzKyK8NV+JIFQVwxatj5GvB00Pw1av8Ao+aqRs5n3Q7auobNcxSs052
 HuMYB74Nlq8u/42ktBa0uI0pHeJJexfxBlmd6vfg96tqxULbuv7yDbF9j83GawIJkgme+N
 U2hHg1q+b4NLK20gEDg/G20n8Jomoks9n5NgR5P1phsb0ql39IcArL3/LTldyA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Cong Dang <cong.dang.xn@renesas.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rpc: renesas: Add R-Car Gen4 DT compatible
Date: Sat, 31 Aug 2024 22:30:19 +0200
Message-ID: <20240831203023.547650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c763165w577x8nwxjm9ud9awjg5cfw7i
X-MBO-RS-ID: fbc977962cfcb5eec2a
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
Cc: Adam Ford <aford173@gmail.com>
Cc: Cong Dang <cong.dang.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/renesas_rpc_hf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 941f2040983..03545822b07 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -387,6 +387,7 @@ static int rpc_hf_probe(struct udevice *dev)
 static const struct udevice_id rpc_hf_ids[] = {
 	{ .compatible = "renesas,r7s72100-rpc-if" },
 	{ .compatible = "renesas,rcar-gen3-rpc-if" },
+	{ .compatible = "renesas,rcar-gen4-rpc-if" },
 	{}
 };
 
-- 
2.45.2

