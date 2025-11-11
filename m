Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E3CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 07:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B9C83F4D;
	Tue, 11 Nov 2025 08:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="NGpW6lvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E1383F3D; Tue, 11 Nov 2025 08:18:43 +0100 (CET)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 874D083EA9
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 08:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d5HvP22RwztwC;
 Tue, 11 Nov 2025 08:18:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762845521;
 bh=VQWQVbKMtzp7uuuNT8OeP+NAEeRM7c9H53IB1Po+GTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NGpW6lvu4zz9XVf0STkyLDFWAtxHHxITOafUNWjLudmDUIB2fwWN2Ga0Uw2eqLzW1
 73400D2CL7DHQhtwp5G0l3zXBg6akH/cc3zmgfRMucvWedlYSeuqB9uW8W6+XZDeEb
 TpVTmHm+AeuiXf1m9wYtWPymbaCHqjfa+OH+lm0g=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d5HvN4wlCzxTb; Tue, 11 Nov 2025 08:18:40 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 5/6] remoteproc: k3-r5: Use verified image address
Date: Tue, 11 Nov 2025 08:16:29 +0100
Message-ID: <20251111071756.1257488-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111071756.1257488-1-dev@pschenker.ch>
References: <20251111071756.1257488-1-dev@pschenker.ch>
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

After ti_secure_image_post_process() authenticates the image, it may
relocate it to a different memory location and update image_addr to
point to the verified image.

However, rproc_elf_load_image() and rproc_elf_get_boot_addr() were
still using the original "addr" parameter, potentially operating on
the unverified or stale image location instead of the authenticated
image.

Use image_addr (cast to ulong to match function signatures) after
authentication to ensure all operations work with the verified image.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
---

(no changes since v1)

 drivers/remoteproc/ti_k3_r5f_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 48ebdaf06931..c6356729e9db 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -346,13 +346,13 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 	ti_secure_image_post_process(&image_addr, &size_img);
 	size = size_img;
 
-	ret = rproc_elf_load_image(dev, addr, size);
+	ret = rproc_elf_load_image(dev, (ulong)image_addr, size);
 	if (ret < 0) {
 		dev_err(dev, "Loading elf failedi %d\n", ret);
 		goto proc_release;
 	}
 
-	boot_vector = rproc_elf_get_boot_addr(dev, addr);
+	boot_vector = rproc_elf_get_boot_addr(dev, (ulong)image_addr);
 
 	dev_dbg(dev, "%s: Boot vector = 0x%llx\n", __func__, boot_vector);
 
-- 
2.51.2

