Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E16C87FDA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 09:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C44E83E18;
	Mon,  4 Aug 2025 11:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754300622;
	bh=tvTPohJY2XSuq5SSvEWYxadhdw3iE/XizwQxFwgIEW8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wVXztJtpgDI2LQEJ2q5xxYCjw306BoruoYm3VLGxBpZsKvnVkKRykPcupvEM9zqSl
	 DWxSlUa0ty2kYIkmvneLiIB4YXF/X7n2jYzTaBcjd/vtWZdrzlj51HbW1VCrAJYhKy
	 wEiVctommX8h+p8sqZHcD4+hMiFApGzrYch95NoTmPWy/uQLaJGUJ/0PzI0Z0MGP+R
	 wCAhLvgJhJoGBgGwOJgXlIZMlVQ1gcNQobq6WRU1QukLiCYrxlAEIVXC5KzmkwRSNH
	 lUmnezqSal4TJehi0elabQEJ+bg2n5Igz8q35D6Obh36xnx/ojOUoUvxNJeSZuKAVO
	 g1+phPCdo+Cbg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B3183F1F; Mon,  4 Aug 2025 11:43:40 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3329E83E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YhNh1cCF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58E901038C126; 
 Mon,  4 Aug 2025 11:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754300617; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=tvTPohJY2XSuq5SSvEWYxadhdw3iE/XizwQxFwgIEW8=;
 b=YhNh1cCFO3aGbYwRnClcsqwe1+1rCGubC3hPxT4c9obm2DsroucxKe6RfeRVgsiYa4RLLp
 3fKTj3UovHoKGcFGetYppy5c/4C/PxT8xJeAco4HJWgW4yu9k2yv4yV8NjQxiPBo8fw7oL
 EQQL+VHn09Kkkf1TS2kD+qVqOTqD34tvz5hz9JKLKNV+eCZJzh48S9IaOpjYldvpzBLBHR
 6oacJqN1i6dK+oFIVFPBXOKM/orhW1q3UdZZkpzIoNQ6uVok1mNZapHhfyIRTWg830swiB
 V7GnKS5MLjo18zntVNPGKdld1L7GH0IXqEgxJ5rz2eZkD3VQYjbFNQyyGKNoUw==
From: Heiko Schocher <hs@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@denx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] cmd: i2c: fix coverity issue
Date: Mon,  4 Aug 2025 11:43:29 +0200
Message-Id: <20250804094330.118675-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
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

coverity scan reported issue:
** CID 583415:       Integer handling issues  (INTEGER_OVERFLOW)
/cmd/i2c.c: 369           in do_i2c_write()

change the length variable into type int.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=183&view=results

 cmd/i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/i2c.c b/cmd/i2c.c
index f0aae93073f..e021067e68a 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -299,7 +299,8 @@ static int do_i2c_write(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
 	uint	chip;
-	uint	devaddr, length;
+	uint	devaddr;
+	int length;
 	int alen;
 	u_char  *memaddr;
 	int ret;
-- 
2.20.1

base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
branch: i2c-coverity-issue-v1
