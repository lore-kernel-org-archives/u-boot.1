Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743EEC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D4387C05;
	Fri, 19 Jan 2024 14:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pG9RKLWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16AF787C05; Fri, 19 Jan 2024 14:36:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079CB87C0B
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C691E619B2;
 Fri, 19 Jan 2024 13:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF5DC43399;
 Fri, 19 Jan 2024 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705671379;
 bh=2DDQplc8tNctMkxLFzzAYfpzqf6Xoeofir9bEV9nppI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=pG9RKLWhUprtO5kEZq3pZWuzGyrUDpT0P0WG06xIwRzoYC0MXt9os08hp6rfxH1mf
 QQzOJkZcEMxeo76f/FkqC+2pdBdxg47RzdwcOwNYdVeUPhwsV1kMQ5Uvp8iYRRvc4/
 0tWNWudsblYcMV09eBynK/uWlIaG2B2g4LKT89Fog42h15jy2YrFn9+4dGG9mom6X4
 47LtbWQvUmPaW3A2Rj0mEtg9nob6dKrMInFB2Li9FiDiw3kX3iqfga2PWwkHqJdc5T
 hLGpZ3JjjKvwgjrs3A5cpcGbtegJ2ZViWn+f2LHS/zemuhU8bBt/YNTPx7IFUPV/YG
 AjP4V0jLOzbFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC18C4725D;
 Fri, 19 Jan 2024 13:36:19 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/2] clk: add HiSilicon CLK framework
Date: Fri, 19 Jan 2024 21:36:17 +0800
Message-Id: <20240119-b4-hisi-clk-v1-0-279e38c95ca2@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANF6qmUC/22NQQ7CIBREr9L8td8AhUq7MjHxAG5NFxTRktZio
 BJNw90lrF3OzJuZDYLx1gToqg28iTZYt2RBdxXoUS0Pg/aWNTDCOKG0xYHjmCnU84RSkoMYeKN
 r0UJuvLy5209Zu8LlfII+m5lenf+Wh0hL9HcsUiRImpYrqQRjsj669zo7N+21e0KfUvoBFUDRK
 a0AAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, David Yang <mmyangfl@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705671378; l=957;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=2DDQplc8tNctMkxLFzzAYfpzqf6Xoeofir9bEV9nppI=;
 b=6IlkPz3+o6z36+4F+uPNDuz5mQK1QBtmlcJjRU06rd4mY26zvssLmF3AVAhbqMY6nK0S73Gq9
 5Oiw85G9Ir9DgkRQDv00V3foUUQ8TJcqqLqf3aCINB+Bv51MUGtc1CO
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

The first supported chip is Hi3798MV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      clk: ccf: Export clk_register_mux_table() in linux/clk-provider.h
      clk: add clock framework for HiSilicon SoCs

 drivers/clk/Kconfig                     |   7 ++
 drivers/clk/Makefile                    |   1 +
 drivers/clk/hisilicon/Kconfig           |  14 +++
 drivers/clk/hisilicon/Makefile          |   8 ++
 drivers/clk/hisilicon/clk-hi3798mv200.c | 213 ++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.c             | 102 +++++++++++++++
 drivers/clk/hisilicon/clk.h             |  55 +++++++++
 include/dt-bindings/clock/histb-clock.h |   4 +
 include/linux/clk-provider.h            |   6 +
 9 files changed, 410 insertions(+)
---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240119-b4-hisi-clk-88075b46c359

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

