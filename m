Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CD6EF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 14:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCCC8366F;
	Sun,  8 Feb 2026 15:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D8na3KM7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fXu0B3+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4662083AA7; Sun,  8 Feb 2026 15:51:52 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C548341A
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 15:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f89l80QKCz9t74;
 Sun,  8 Feb 2026 15:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770562308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vndxtjHm29VT0gojYr/7v//Bcntic3L4Nr7f6sVoFis=;
 b=D8na3KM74zndYtdyjEvpB9R/1DbfR3L1XkxIO7iw5VNtV3aXe0SfkxAZPYFpft79hvo7fJ
 1a15DX4l8Pc82x04lZpIeoFS939bDKZ9RmQciFwhavo0SHbFtsX3HIiJtA2RCplFHp2y5L
 zvTFSwMkOU3HjfTUTKt7rbBULDBXb9DVVJj2Uiok8gEZIDVCdC4BfIkKnbFVsUauXt7q3I
 MuyNINXo0pdv5hZY1xNQbGpZ99dcbiWgS8mEB4bYFreRSxPFMn7ywdzcyVqsXzT5k3dLXo
 1qG2mAm/zsq3e0SX6iB23+qsF+lubqWEH/Z9lUOtfTIbhSoyJm6jIUXuxzic4Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770562306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vndxtjHm29VT0gojYr/7v//Bcntic3L4Nr7f6sVoFis=;
 b=fXu0B3+0RaF8Mag09tFsia0GRsc80+j8F1/mM9EkkivRzCZuPneaRSnV8iXwsk3+mkM3J2
 97bmimJPZ/vto1itzA4uDwgs2ERO6OkQMRYRu7LzeyEndxCLnKDqZqUhDRdNDpGB/886tH
 +Zw/eQkqd/YEkqxmXzTefyhg/nJ4tSVPIRyDKjfzOmYPp36EtUSdPAhY1oTMdCfwsX4jcC
 /uNC9KPi+DTZl7n7Jh57ROJaILI+UbRyzCpEJRLNYkSNt6BPW5rDvSW/Kle5UoK9+/Atzx
 suvUB0UO7V7EKLD+OlJCkZKhiv4v4gKsr58nZvZA54g0pu9JIHIRU095JqQN/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH] cmd: mmc: Drop trailing space in Name: before newline
Date: Sun,  8 Feb 2026 15:51:03 +0100
Message-ID: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82f989c4d9c73117826
X-MBO-RS-META: g4zuxi5rdzirnipnc3iowh1ehfs94f86
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

The Name: line of 'mmc info' command prints a trailing space before
newline. This is not useful and shows up as trailing space e.g. when
the output is checked into documentation. Remove the trailing space.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
---
 cmd/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 6cb1ef5dc23..81b1ca4ad84 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -29,12 +29,12 @@ static void print_mmcinfo(struct mmc *mmc)
 	printf("Manufacturer ID: %x\n", mmc->cid[0] >> 24);
 	if (IS_SD(mmc)) {
 		printf("OEM: %x\n", (mmc->cid[0] >> 8) & 0xffff);
-		printf("Name: %c%c%c%c%c \n", mmc->cid[0] & 0xff,
+		printf("Name: %c%c%c%c%c\n", mmc->cid[0] & 0xff,
 		(mmc->cid[1] >> 24), (mmc->cid[1] >> 16) & 0xff,
 		(mmc->cid[1] >> 8) & 0xff, mmc->cid[1] & 0xff);
 	} else {
 		printf("OEM: %x\n", (mmc->cid[0] >> 8) & 0xff);
-		printf("Name: %c%c%c%c%c%c \n", mmc->cid[0] & 0xff,
+		printf("Name: %c%c%c%c%c%c\n", mmc->cid[0] & 0xff,
 		(mmc->cid[1] >> 24), (mmc->cid[1] >> 16) & 0xff,
 		(mmc->cid[1] >> 8) & 0xff, mmc->cid[1] & 0xff,
 		(mmc->cid[2] >> 24));
-- 
2.51.0

