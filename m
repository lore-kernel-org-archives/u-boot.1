Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0161C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 00:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FCD87849;
	Sat, 11 Nov 2023 01:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vuoqLd4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276D587851; Sat, 11 Nov 2023 01:35:49 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B2D87844
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DB2053FB49; 
 Sat, 11 Nov 2023 00:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699662938;
 bh=GITuyHhElzYR+2fZLOndVMd0bRjqoxDIFOwugNcip3o=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=vuoqLd4OP98OmtYhnZBhAZbibmsGywqipKWsN0RGgxHAlYDH1g43n2Qk7Y1QgSDIi
 bd2Ww6KQTz8YiNPi2KihvQH3jabOMnWjQ8NNMpGCtyKfEwaXd0DpOhSv7A3+QjT0FI
 3/kklcJzulsJoODD5Ok0EmH/Y3x2SHbIxwPNc8M1KVLPg9iSJeblpt7lYSWhFnfmEc
 oFa0ouFeN8aii5fYTeO2gwZIMVzYoPzZoPlC5SyLXTg6WZ1HfKCaHVnOc5XbsExg3E
 OTWiqFyc3vM7+tb2qKfo1eK8laeVPwM2oYliTFJwwqhQQUhIVhgX76MaswbE9kHvwf
 2iQ9P/HWXMidw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tpm: remove superfluous check in tpm_tis_send()
Date: Sat, 11 Nov 2023 01:35:30 +0100
Message-Id: <20231111003530.20369-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Checking if variable chip is NULL after dereferencing it makes no sense.
As discribed in [1] it is not expected that the variable can ever be NULL.

[1] Re: [PATCH] tpm: avoid NULL pointer dereference in tpm_tis_send()
    https://lore.kernel.org/u-boot/YaFwDtKKYRr7qzWc@apalos.home/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/tpm/tpm2_tis_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
index 985a816219..81b9210056 100644
--- a/drivers/tpm/tpm2_tis_core.c
+++ b/drivers/tpm/tpm2_tis_core.c
@@ -224,9 +224,6 @@ int tpm_tis_send(struct udevice *dev, const u8 *buf, size_t len)
 	u8 status;
 	int ret;
 
-	if (!chip)
-		return -ENODEV;
-
 	ret = tpm_tis_request_locality(dev, 0);
 	if (ret < 0)
 		return -EBUSY;
-- 
2.40.1

