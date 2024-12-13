Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B4E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 891C180192;
	Fri, 13 Dec 2024 11:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W4+tLfSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85097801CF; Fri, 13 Dec 2024 11:23:38 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280C2800DF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 660555C6B33;
 Fri, 13 Dec 2024 10:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21880C4CED0;
 Fri, 13 Dec 2024 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734085414;
 bh=D04WeuwHfIuqpHtOvE4PKJyTYJf09q6GCjjapTPMHHE=;
 h=From:To:Cc:Subject:Date:From;
 b=W4+tLfSdBoyV5wq4XcLBP/9RZHYTLb4wAwIvpolxkj2ik7FP9CFK7XZLKBCL+VUDN
 NorcaX5VG4VqxGMwBCFb4ZwHJkzCg3AE/oy5TCBHF6jXipSzbyPKncSp+GmAgOy1GW
 YO9+DNhLSXaGMXoEzdNFzvCEN6upcpu9O6O7dloFzv1SmjI2OGfehXGfWfy/yZPgsd
 amcQSU9QOUTCWaLdNprVyzRUYaBVdncMmHxwMUyE+5f9twnrc2IKEUii3OAtyaMTVA
 crusQ4j9JYRUbVUIQ1I47UodTvBMeo9a9K4jEl0JgHdNr8QQM44hxQVAG4Mj65u8cM
 IjKsjeLejqSFw==
From: Michael Walle <mwalle@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, heiko.thiery@gmail.com, thomas.schaefer@kontron.com,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/5] board: sl28: various fixes
Date: Fri, 13 Dec 2024 11:23:16 +0100
Message-Id: <20241213102321.2166920-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Give the sl28 board some love and fix various issues. Most of them
were due to the transition to the upstream device trees.

Michael Walle (5):
  board: sl28: fix linking with disabled watchdog
  board: sl28: increase SPL_SYS_MALLOC_SIZE
  board: sl28: fix network on variant 3
  doc: board: sl28: fix table
  board: sl28: fix USB0

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi |  4 ++++
 board/kontron/sl28/sl28.c                         |  3 ++-
 board/kontron/sl28/spl.c                          |  3 ++-
 configs/kontron_sl28_defconfig                    |  3 ++-
 doc/board/kontron/sl28.rst                        | 14 ++++++++------
 5 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.39.5

