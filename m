Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17394C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD0487CBC;
	Fri, 19 Jan 2024 14:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ms/pPTzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FFDF87CBA; Fri, 19 Jan 2024 14:32:09 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6711D87CBB
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EB1E6617AE;
 Fri, 19 Jan 2024 13:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 924DFC433C7;
 Fri, 19 Jan 2024 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705671124;
 bh=2DDQplc8tNctMkxLFzzAYfpzqf6Xoeofir9bEV9nppI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ms/pPTzwMhgiKZSX3r5tdUvJ97I+PUQ5Tv7IrxZ2jSmUXju3phogt71kbA+tJ7XKB
 F+SnOmWeoAqLsiENCA2KeUMg43ML2Xpn16uI+dRoayHU8DCYSwdJmHJh5Asgo8UMdf
 aif1ITWhqZhVKiVpDf3ATAGyhg/vMo7THLXocDo6zr6UQxkteH1vdkj11MZsSgFiVW
 4ZgJSVmnZdkiL+AlB7VM1uYBUAHpD+dK1bJetHFRNO1skohvYAPH9B1tvTv8nNwJYL
 I20uTcND2N24T7pbFCPqxsUU17B9f4OEsWYO3uYY7rF+YYwjfSPso6vuoHrluXQSz6
 2sr6m1b2Fs+Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7F62DC47DAF;
 Fri, 19 Jan 2024 13:32:04 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/2] clk: add HiSilicon CLK framework
Date: Fri, 19 Jan 2024 21:32:03 +0800
Message-Id: <20240119-b4-hisi-clk-v1-0-0694a8a52283@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANN5qmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0NL3SQT3QygKt3knGxdCwsDc9MkE7NkY1NLJaCOgqLUtMwKsGnRSkF
 uzkqxtbUAFBaX4GIAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705671123; l=957;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=2DDQplc8tNctMkxLFzzAYfpzqf6Xoeofir9bEV9nppI=;
 b=bMggRQ5W2F+KvIPxCzKg1qU2ypKhiW9e0ud+pTgSrBNxQqTikrILGOS+y3Xo6ZZVwqYVPCkSv
 8ZqXgf9kPRjB4kRrz/HtEL+vn/eapVZ38ZNgzpMravdmM6l6NwKS3R2
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

