Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE0D5E130
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23808903B;
	Fri,  8 Nov 2024 06:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043315;
	bh=hEiBcb6PhctFr0Nin2Y8hJGejGgYSeB598E7fQ1BNEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9rXEu9dioODyoxqGsqGKWBtXVlZMJOQWObf5sJ5V4/ZXf8IkByp+GaAXjCAp48Ut
	 LAUrPW1HM61qvrRsJd0gKVL1lXKjvSlo9AT895yFkir0e2IFn0FXnK0CAB5SmxAEQA
	 Z+mxrWq0zNeVP57AxABMsllDJDN63eU8/r3o5GmDqIVI8nC66sJ8roKza/3D1Lzhew
	 z78P72V05ZHzX8QKwdC2FPfIQ9TWjcRdkn/qf+cnfYV97RdHbDDkQUf06hw0HlO7R4
	 26CeFDeOgGXBt4gtRUzDGEzK70p4fn+Z0nOLuebiJEPBYbfhg52vb/WrBXZ1KgNET2
	 w+YJ5hfRwwolg==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B97A988FC8;
 Fri,  8 Nov 2024 06:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043314;
 bh=hEiBcb6PhctFr0Nin2Y8hJGejGgYSeB598E7fQ1BNEU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YWxijGSk4oZHOVMFUDTpclorC2QrDRwgDx9CvhZAqcYd4HGJ9cJWizh2MSeWY9QKQ
 eWU9I+Q92uRnsaoamVQp9i8ZPxqrCKiCy5EQD/BIJWgaUcormlO0dTC3fWObjihiNK
 YVfXbMwdNa+a9m8sNc6bqfaInpFVuAy1VCvB1cxNkFQVv+sQn4Hiaf7At+lUk7tA+Q
 tZPk2ibum6Wf82m/5hZj64zjBDWckQ2PoLQnrZNGNzmZ21Sb0svEkJQmoLk4oQeTQx
 6UQbriPJ5Uo06W0E/1kZIGJkAgiJ9zfbKGDalo/iN9N6Ae1Kh6UKZDw9RvKBU98iRG
 kWkf1BSdoARsQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 03/22] tools: imx8image: Improve error message
Date: Fri,  8 Nov 2024 06:21:24 +0100
Message-Id: <20241108052143.26874-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

Improve error message "header tag mismatched"
Add filename to error message to see, which file
is wrong.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 96ece28bd6c..b22e8b21c47 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -733,7 +733,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 			fclose(fd);
 
 			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched \n");
+				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
 				exit(EXIT_FAILURE);
 			} else {
 				file_off +=
-- 
2.20.1

