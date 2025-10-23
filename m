Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2805CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A970583655;
	Thu, 23 Oct 2025 11:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="FIMWAGwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB1E8363D; Thu, 23 Oct 2025 11:47:35 +0200 (CEST)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918C0835B0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4csh5x2VZnz8qR;
 Thu, 23 Oct 2025 11:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1761212853;
 bh=9mBMoYAm0xPk/22ZeESo5rj5WTlbCu8ShMENkZmzVvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FIMWAGwRb2jdWK0wIqjnnCVbJ5orjHRwe1SHLfUi9/avYB0XGKcs87BW07cTbFSDU
 gRhjoTRLt7F1aa44PtsjtM9IVIpucFevl48z8G2T64LwKBzmOU8VAS12zESYYmBaNQ
 FPGmudls42C7VxQAT5iEYphu9a7f30wXYZLiRvz8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4csh5w4686zG5R; Thu, 23 Oct 2025 11:47:32 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/6] remoteproc: k3-r5: cast size to size_t
Date: Thu, 23 Oct 2025 11:46:20 +0200
Message-ID: <20251023094631.16742-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023094631.16742-1-dev@pschenker.ch>
References: <20251023094631.16742-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

When compiling for R5 core with CONFIG_REMOTEPROC_TI_K3_R5F,
passing 'size' (ulong) to ti_secure_image_post_process() caused
a type mismatch compiler error.

Cast 'size' to (size_t *) to fix it.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
---

 drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 48401bc6eb67..9d591aada276 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -341,7 +341,7 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 
 	k3_r5f_init_tcm_memories(core, mem_auto_init);
 
-	ti_secure_image_post_process(&image_addr, &size);
+	ti_secure_image_post_process(&image_addr, (size_t *)&size);
 
 	ret = rproc_elf_load_image(dev, addr, size);
 	if (ret < 0) {
-- 
2.51.1

