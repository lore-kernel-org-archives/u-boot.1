Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8AC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 09:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F42488127;
	Wed, 20 Mar 2024 10:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Na5k6gLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFF2880F5; Wed, 20 Mar 2024 10:02:26 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5532E880FD
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 10:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710925337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MM8YFgBvk+NsCOs8tkumbYtoF9qpkl06R6eslH8hMs8=;
 b=Na5k6gLcZAVSb7lJr5/IJp/I6EXin3Okc3NzY5xEL5V0GAf9nBlZSliO0peEUMnyFpLPKv
 C78N3rPw67VBYgdy0rRPzrtFfpeRbiojJ2B50LH9HjShYCzjWPcuyF7EjoFsD3zApL+C4k
 h019qHGlntuHkKBoaO6lHY8qgPichFT3WjjJooXTFs7hxD+UmdV+YdD2G3oFM7ivEgpD8R
 fVMzm7HkMWZ92UenVPZgk2fSGRxsZc9qazpg4doAB9/n75j1IrdvWfswLl6eNrXTt4COMX
 Y03vQA5kBhAV4wm4Sd21Uf5Q+GkCcGm7gYHgiY5O3+jie2fR0LP9C5rSCDaA3A==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 5/6] mtd: nand: raw: atmel: Fix comment in timings
 preparation
Date: Wed, 20 Mar 2024 10:02:13 +0100
Message-Id: <20240320090214.40465-6-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-1-ada@thorsis.com>
References: <20240320090214.40465-1-ada@thorsis.com>
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

Introduced with commit 6a8dfd57220d ("nand: atmel: Add DM based NAND
driver") when driver was initially ported from Linux.  The context
around this and especially the code itself suggests 'read' is meant
instead of write.

The fix is the same as accepted in Linux already with mainline Linux
kernel commit 1c60e027ffde ("mtd: nand: raw: atmel: Fix comment in
timings preparation").

Link: https://lore.kernel.org/linux-mtd/20240307172835.3453880-1-miquel.raynal@bootlin.com/T/#t
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v2:
    - initial patch version (not present in v1)

 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 75da15c157b..bbafc88e44c 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1271,7 +1271,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-- 
2.39.2

