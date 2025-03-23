Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60838C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0038288B;
	Sun, 23 Mar 2025 17:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745738;
	bh=SEq/ZdKybxLC9wfm3gNzklxlHYVnfcy9mEJ19PgRBko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gl1IpCy5A6EfsCXErSL2JB2sDfJ5ATybqAEsBEOQ2UkvnnlqfsF3/l27JDTdfedRq
	 GB2+Uv1Pm6RmdXsaeLBehbgXYBlAECsHNzMZ3DT+X4MUMUDiTV+KKpCNP+Pt32EFvA
	 YpAZOKpyq0WSWs9dkTx2rUMS8yirG04cAhDpmokv/O4Cr/RRDRH6t4XWViB7DMqg0L
	 /jPYAxjRDlcnq1P/Qon4AE7s93W/DvVBmoV5OptHzb6sLo11u1yq3klRuk2lslTHUv
	 U33JkY130Xj3+bauLsZYFF+/0iKPlqZTA1rzKh6erbGducnsvjSgWzUfMb4jzJkBsB
	 mCz5kRkRoqH9Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF2E82115; Sun, 23 Mar 2025 17:02:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F84782093
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DzeBlyeR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1138310290253; Sun, 23 Mar 2025 17:02:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745733; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=SEq/ZdKybxLC9wfm3gNzklxlHYVnfcy9mEJ19PgRBko=;
 b=DzeBlyeRo5M2y6JxUolVEC1aCKQWznUYa7ub6AB/+Av5XrYXSxM11GW9hTKSt3FvWIMwZR
 gVzIBys00qwjfdu1E7PNHmF3TPPBgY3GY2TjiJS2esHrW1pE4rQaEoTgVF2pMkLPzNbcqo
 hld6P5PtqYVUWNU7SQDUzxZI7LFl00JHqYXwnbnyeWbfPKx1lYfLUQ98Dk/fkP1D0EGkur
 26OO1Ooluk86/bk5WglM6gJiMZU0a7EMcfA9tWkLnaurUp6P/6VVHYj8HnH38fWTadSzsq
 rpkpp8y44T712PPuti6Kq9pusHTrlR5AOZsWOPggYukRfgr+Kzg6tBaIC7zItw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 21/24] clk: clk-divider: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:50 +0100
Message-ID: <20250323160107.145749-22-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Use clock-names property which is accessible via parent clock OF node
to look up the parent clock by name instead of depending on unreliable
global clock name to perform look up.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/clk-divider.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3b4b3c4fa5f..e692b9c2167 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -218,7 +218,8 @@ static struct clk *_register_divider(struct udevice *dev, const char *name,
 	clk = &div->clk;
 	clk->flags = flags;
 
-	ret = clk_register(clk, UBOOT_DM_CLK_CCF_DIVIDER, name, parent_name);
+	ret = clk_register(clk, UBOOT_DM_CLK_CCF_DIVIDER, name,
+			   clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(div);
 		return ERR_PTR(ret);
-- 
2.47.2

