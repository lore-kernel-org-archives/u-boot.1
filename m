Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78604CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CA5839E2;
	Mon, 19 Jan 2026 20:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BsYH1th7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B858313B; Mon, 19 Jan 2026 20:07:26 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3204583A64
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 82E3E40453;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62EA6C2BC86;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768849640;
 bh=eU9SnUarYYSNgbeK4/7MfGiBb1xq7Xrr/s53iZOVZ/U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BsYH1th7a6odnAKChaiRIQpQPSXGKkjdX2WKwNFa7j9mOpmaXBF7U5KdCwZ6tl7gH
 wSKCz2DScuCBMzsRB24PbTYq+n/9fAHyU4IzynwUQKRmZmFLm48dYftpyc6o+hk68K
 TJr66EDQzvEM5zsDk4l78aKoO2pUYZa89k2m6w3P7DkNAUnfG08IU95dctm8tlku5u
 C3vGKtNOnYhkVvrJMSgpizhMwy3oFhMO/f2Qwe7gWogq2wm0y0H60EuVp2pcJFbxS+
 yqlu3uNV13oiYpaWS+0XcgMDlsWQp6cCYnaHMh4kFuYcAS76IlKkS0STaHRKW6EDhB
 PhgIfFyn2xIkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF99CCF2F7;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Jan 2026 03:07:20 +0800
Subject: [PATCH v3 3/6] clk: add uclass id check to clk_get_parent()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-clk-reparent-v3-3-0d43d4b362ac@outlook.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768849639; l=845;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=z8RAmI39MslmxtsJNWHoIU88HjZWrYeA9Sj3Gni2MDQ=;
 b=eA3SH0a3h3MAHezL7mbybBTXNKIrnN+gdOIPjNxGUpLzNnS1J8191zYh09ZARzisqpQdlfg+q
 MP5UUucWlweBmMdEpr+USFYFP0Kh9tBFC331Fd5TYaFOl8r864eqQeV
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

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 0584429bed65..559420c85056 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -507,6 +507,10 @@ struct clk *clk_get_parent(struct clk *clk)
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


