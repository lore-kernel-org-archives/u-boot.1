Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C2CD4F35
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 09:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C2986660;
	Fri, 22 Sep 2023 11:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FHaq+r9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE706864E9; Fri, 22 Sep 2023 11:09:46 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B063D864DD
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qjc9g-003rQN-KS; Fri, 22 Sep 2023 11:08:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1695373784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=abZt85cUYugNUjHEv/kOur5tW2ziN/VbgzfDKOKEfi4=;
 b=FHaq+r9uqq7/t3yzFsdSUWe8RdE+lbGURuYpAJ7dV+JLnIP6AI8u9E/4ixldSuLHxeameW
 qfm6tCWHPTh+evSiVQPrbjxPRE5o2WXJCqBB1OsWZGSkFvY3LtMScBLvO28zkwmXnHJRDG
 MmH2L66FHUpRyffyOzQu7B30UZoSRei/I29Z18nUEe6clfMU23jxj0tfowPEVcsDrpu8B3
 ZXIy/TaBNQvdcJQRIUbVvbbW4EK+TbDZ7GkY8diKvQ8f6inesQaAjCe+mBRQCcSPRWVM0y
 9DO/6izwuvcHDoE+CT9ubcs2gqUkkeMCk9TkidbkUrzZCWkbsJQiWrSs1slqLA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 0/1] mtd: nand: raw: atmel: R/B gpio on sam9x60
Date: Fri, 22 Sep 2023 11:08:55 +0200
Message-Id: <20230922090856.920303-1-ada@thorsis.com>
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

Hei hei,

after sending v1 of this patch Eugen and Michael discussed what would be
the right approach in U-Boot here.  Actually now I saw I did not
correctly port what Linux does here in v1, but this v2 should be what I
understood would be the preferred solution and should be similar to what
Linux does now.

The original patch series had two patches, from which one was applied
already.  To not confuse patchwork or mailing setups, I send v2 with a
cover letter too, although it is only one patch left in the series.

Link to v1 below.

Greets
Alex

Alexander Dahl (1):
  mtd: nand: raw: atmel: Add error handling when rb-gpios missing

 drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


Link: https://lore.kernel.org/u-boot/20230808130250.188588-3-ada@thorsis.com/
base-commit: 5d2fae79c7d60eaf7f50322e4ec125d2f58544e9
-- 
2.30.2

