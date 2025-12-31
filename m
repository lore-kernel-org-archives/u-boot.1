Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8C7EEB56D
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109318418A;
	Wed, 31 Dec 2025 20:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PGuRcx1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006E8841C2; Wed, 31 Dec 2025 20:52:53 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104FB841BC
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C777560054;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F156C19422;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767210769;
 bh=hQtkw/x0l0+5RDcfYMFNzLF9RDDtF5FOvjE4AT9Mnik=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PGuRcx1tjrJjeSa65Fc8NFi0fjFEsWJn5lrx5jgJAF/A10aKaVldavA14XEe4rrx2
 R4DxZlriUcV04FD9MTvRWCuhMSpHvNX+ob1L9v8LcUYKJ0B2pABpVhmUMFSwyNlrts
 8ZWk+3r3V6r9G6ickC5MSezfvHetKJVseH7noJmcABxgE8NuX6Tb+TWGbPV2VDeaYN
 LYsosuplJyWjYQLpy/2tM3wHqOuLVl6utR9aZ5Ma6P0PhHyYFjJmSLddWkQVrJqTE1
 RvYNGEqIfIxzfyjLhxRXVzxGEND2ucjgL76g2KZzEPuqLHvEMCt0ZWazF+vn52Co7a
 e6WnSpGGmwMVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 72277EE57C5;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Jan 2026 03:52:48 +0800
Subject: [PATCH v2 2/5] clk: add uclass id check to clk_get_parent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-clk-reparent-v2-2-3eb42b78c7f1@outlook.com>
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767210769; l=791;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=ekHy6JW3OFPDeKcnpOoMx+HO2QaD959tyRe/0bAViCE=;
 b=ZavlkEVSCLsdF5iRqiRFOCYbs9kXJECOWQT26/wSgxhDwISszV0g9M3QxY0BQRtnwR+5htyXH
 x+Zz9Svpyy5C5e/rBtRsSsq6ir1ZVmh1gvtNXer1nuCxQ+P8oEK32nA
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

Check the uclass id in clk_get_parent() before casting dev->priv to
struct clk *.  This sanity check can be also found in some other places
and should be enforced.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 2167cd5ad0fe..bd18de972bb9 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -502,6 +502,10 @@ struct clk *clk_get_parent(struct clk *clk)
 	pdev = dev_get_parent(clk->dev);
 	if (!pdev)
 		return ERR_PTR(-ENODEV);
+
+	if (device_get_uclass_id(pdev) != UCLASS_CLK)
+		return ERR_PTR(-ENODEV);
+
 	pclk = dev_get_clk_ptr(pdev);
 	if (!pclk)
 		return ERR_PTR(-ENODEV);

-- 
2.43.0


