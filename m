Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6183CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCA383D77;
	Fri,  7 Nov 2025 14:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="Psr/sZC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B6083D9C; Fri,  7 Nov 2025 14:03:10 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C07883D3C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2zkb01sHzjKS;
 Fri,  7 Nov 2025 14:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762520582;
 bh=FlE3DQoQ+mF5HGt3fGZmeB4kR2dMGxWEu2XvLYyM63Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Psr/sZC//QPZNPomq71L3NT0FyRpG9DoeXcluSmKt+wDw4AUfT9GWgD+TO5nrxoyv
 gNMT/YDywTcPcz1qd2FZw7b01kDnPwOnN1js4JQM3akp1e7mGM1StR32qQjjayIbN/
 lGi2j/qMueF4gB4zlJq9CvqD/Yt9K96oBFIEeqTc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2zkZ2wDzzR5P; Fri,  7 Nov 2025 14:03:02 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 Hari Nagalla <hnagalla@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/6] remoteproc: k3-r5: cast size to size_t
Date: Fri,  7 Nov 2025 14:01:01 +0100
Message-ID: <20251107130216.3084134-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107130216.3084134-1-dev@pschenker.ch>
References: <20251107130216.3084134-1-dev@pschenker.ch>
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
Acked-by: Andrew Davis <afd@ti.com>

---

Changes in v2:
- Added Andrew's Acked-by

 drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index c738607c1092..e7bd97a9088b 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -341,7 +341,7 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 
 	k3_r5f_init_tcm_memories(core, mem_auto_init);
 
-	ti_secure_image_post_process(&image_addr, &size);
+	ti_secure_image_post_process(&image_addr, (size_t *)&size);
 
 	ret = rproc_elf_load_image(dev, addr, size);
 	if (ret < 0) {
-- 
2.51.2

