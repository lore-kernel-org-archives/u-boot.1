Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA2CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 09:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7C288D3F;
	Thu, 26 Sep 2024 11:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=at.encryp.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=at.encryp.ch header.i=@at.encryp.ch header.b="kz531qNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5614888D15; Thu, 26 Sep 2024 11:41:30 +0200 (CEST)
Received: from cheems.de.box.skhron.com.ua (cheems.de.box.skhron.com.ua
 [IPv6:2a01:4f8:231:76a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10DF888CB9
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 11:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=at.encryp.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lekkit@at.encryp.ch
From: lekkit@at.encryp.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.encryp.ch;
 s=20240721-cheems-de-box-skhron-com-ua; t=1727343687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=a3SgzFyj17Zdvoom28tt8Y769IWG/Q6IhFSU9dqB9/E=;
 b=kz531qNs5ml4NshFNEQ4Vemgfe3WKnNsgoMSg2qGTIRMqArxGN7dCTiQ/HkT482PRaSA09
 3f1CMsPVhd0vPOeSDKKnOVPCKbGJP9K78gcQdXbpFvAsJ9lzTckODz4LULMHfD8DxDPp39
 ZYHIUq3pLSKnVez4p6D2A1EhX6OHPwOkxV7jbUxrVCQYq9yubV4fU5EIYVyYSRTvJY/nIz
 sY5v5SI4qN3XZR4szq2dmLwVTgk0EiV7ty4E4Qxuf/seI4tKMxCIwL/Kt94LEolzz2+UQg
 YO26lCU2CKgrKNltkppXbpwCV/yJf/y7qlnSit6gKeCsHIk0CbmKyuJcFkpYoQ==
To: u-boot@lists.denx.de
Cc: nyandarknessgirl@gmail.com
Subject: [PATCH] video: simplefb: Fix build warn with CONFIG_FDT_64BIT=n
Date: Thu, 26 Sep 2024 12:41:03 +0300
Message-ID: <20240926094103.196416-1-lekkit@cheems.de.box.skhron.com.ua>
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

From: LekKit <50500857+LekKit@users.noreply.github.com>

---
 drivers/video/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 33bb78bc..f497bb1b 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -28,7 +28,7 @@ static int simple_video_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	debug("%s: base=%llx, size=%llu\n", __func__, base, size);
+	debug("%s: base=%llx, size=%llu\n", __func__, (unsigned long long)base, (unsigned long long)size);
 
 	/*
 	 * TODO is there some way to reserve the framebuffer
-- 
2.46.0

