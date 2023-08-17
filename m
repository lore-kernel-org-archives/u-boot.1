Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF19AC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71A386BC5;
	Thu, 17 Aug 2023 19:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HMaQxNkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D5C86BA0; Thu, 17 Aug 2023 19:04:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0670D86BA4
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBC262DB6;
 Thu, 17 Aug 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C00D8C433CA;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692291853;
 bh=3rsdCAHmW7bXDABvX1K2uwvqI7fO4x0bP2S1wrRUc58=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HMaQxNkdydWEE6qoDjsQ+8Z3RqBruKBmEKRc3Q7jkWjs4zDDz0tdUYUUra0rSqejl
 qw+N2Nxtl5WeS7zyZQi7UYiBVVP2TWdZZpLhOP6bu0mJkr+v9drS3VZp4+Hd+rEifv
 rQqvXZYDnClBKHx92OFmXpVmE7KyBqCE4DsHqxXw4mX/pYvfidp2sKAH/XdrpPX/lQ
 2hpjQ1jHs70jetasa6O83qU8MEJiSaDXmIDFDj6aviIEUryzCIspZV4uQlM4afo4u/
 zhCFJ93fZzL2WA//af+stVwGtE3Pmh8MCKIG5FKiJTdrHVdfMIEL6ixjcE5M1Y8fT7
 +K+SsMSLchGkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A8F1DC3DA5E;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 18 Aug 2023 01:04:01 +0800
Subject: [PATCH RESEND 2/5] clk: call log_debug() instead to avoid console
 log printing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-clk-fix-v1-2-49ec18f820bf@outlook.com>
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692291852; l=944;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rF0dwZvgeJOMiuqcxICJYTlilfkM8yDDIOepIOXVwHY=;
 b=rSvWzZEYw1wZeS/cixeh4ZFcbGRiAF40fm9cqVlCBXKweMo9QX/eS8eJmOn+bXXvdbjyYpoIY
 ZExhG7evb7jAMW7FbRqcmsOZEj125Puht4Dusis0PamlH+rXemItOQi
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

it's a very common case to register a clock without a parent, such as
clk_register_fixed_rate(). Replace log_error() with log_debug() to avoid
useless console log if not debugging.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a5a3461b66..a38daaac0c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -24,8 +24,8 @@ int clk_register(struct clk *clk, const char *drv_name,
 
 	ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
 	if (ret) {
-		log_err("%s: failed to get %s device (parent of %s)\n",
-			__func__, parent_name, name);
+		log_debug("%s: failed to get %s device (parent of %s)\n",
+			  __func__, parent_name, name);
 	} else {
 		log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
 			  parent->name, parent);

-- 
2.34.1

