Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2AEC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B674E887D9;
	Fri, 12 Jul 2024 19:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oG0Lfw/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D32887CE; Fri, 12 Jul 2024 19:15:11 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A80386E40
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 19:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CBE1FCE1B50;
 Fri, 12 Jul 2024 17:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DBDC32782;
 Fri, 12 Jul 2024 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720804506;
 bh=H+1F+5yo8YadnoaWpnGRidu7+rprL11HlIccFkzw4xI=;
 h=From:To:Cc:Subject:Date:From;
 b=oG0Lfw/CNDdBVDeL7ygvYPCJLhXvee7oqPm7kmmRBZnOHTZ6JGyn0iUxnfk0QZaI9
 uAmi7l9dHBpG/KWMdsQX/gtu+4E9mA/amQJmPjHkkp6H19pnzMf2vmshp9HYS7TpR0
 4WdsBueJmAh+xfq8OKYIu1PyU7E1LiCnlXaWepsEUPCsIRmy0Mhgv/Xq8l8K5/Ico4
 soq3xMPe5Y8Uq7RTRudcTitHNJthIyNu1sN2P/Q0vD+5BqqA19NN6PhVhVDemq77Z4
 jnHUMe1yAJtrpD12pawytrJZFvW/0ZqPYvuMh6XQgLxjcWyAXvnBTNLogb4z1pheGW
 v1pYxvjvMPBRw==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/2] spi: sunxi: Improve the loading speed
Date: Fri, 12 Jul 2024 19:14:55 +0200
Message-Id: <20240712171457.3104804-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Right now, the maximal transfer speed from an SPI flash on a V3s is
about 240kb/s. That is pretty slow. It turns out, that due to an
error u-boot is setting the maximum frequency to 1MHz. By fixing
that another bug is unearthed: one cannot set a clock divider of 1:1
due to the handling between CDR1 and CDR2 handling. By fixing that
I achieved loading speeds of about 1.5MB/s.

Michael Walle (2):
  spi: sunxi: drop max_hz handling
  spi: sunxi: fix clock divider calculation for max frequency setting

 drivers/spi/spi-sunxi.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

-- 
2.39.2

