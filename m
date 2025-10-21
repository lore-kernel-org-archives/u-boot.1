Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F5CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 14:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D9882B20;
	Tue, 21 Oct 2025 16:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="N+Bp8UPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFA8800D7; Tue, 21 Oct 2025 16:21:59 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7A0802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 16:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CFDD925D5A;
 Tue, 21 Oct 2025 16:21:56 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hKtneWANpH3w; Tue, 21 Oct 2025 16:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761056516; bh=4UhFHSbBxnFZtiHDioPxCW43CPnycSHHzGFPcO3sMGs=;
 h=From:Date:Subject:To:Cc;
 b=N+Bp8UPzh1IRBdF+ctfQgSJoDRUCtBKcOPZQpgh+OpDE5RDduyZdWtLXpnjhF1+uD
 6n8krpUjfrwg0TNbGnqOcYRoZqP/Rf2bOCa+DL1A3akJtzcx96F8HGQMuCvr58KVKj
 cYz1xMJXGBxF0vjWaeY8g+IWJa7UyvEXJSamnEB5qRihTHHg6B+9Iz5bWnoN7yMsBa
 /b0Itg5zUGVcx7VU8uo0818EnUlMONKtKheFScUf3byf3q4nLzCs6VmgG7zcunRgIk
 PUT/O5/VSJTKqSeaI/RQWy069kULF4+BXWPjQfJyVjdTlnR/qD6t01YklLvo9dVTll
 qkLRKzLFCMfdA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 21 Oct 2025 19:51:35 +0530
Subject: [PATCH v2] gpio: s5p: increment bank base address only if bank is
 initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-gpio-s5p-bank-fix-v2-1-eae4b37e7e73@disroot.org>
X-B4-Tracking: v=1; b=H4sIAO6W92gC/22NywqDMBBFf0Vm3SmZYPpa+R/FRTRpHAqOJBJaJ
 P/eVOiuy3PgnrtB8pF9gluzQfSZE8tcQR8aGCc7B4/sKoNW2pCiFsPCgsksONj5iQ9+ITmlLuO
 gLdkr1N0SfdV7895XnjitEt/7Raav/dXOf2qZkLAlZVR70qO3pnOcosh6lBigL6V8AH2cP6e0A
 AAA
X-Change-ID: 20251014-gpio-s5p-bank-fix-1d008cb2a1a9
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761056512; l=2035;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=4UhFHSbBxnFZtiHDioPxCW43CPnycSHHzGFPcO3sMGs=;
 b=AVAowUX2fvd8+i7LCnEI5oXyirKPHBtz7y3f2WSP9bO/qJpkjvqgOpfnJP/ofelMyu3qYFujq
 1dq7fg/c75iCNjubbS+1V6QP0j6y2B2iEzsrVvNtlZFtJ1XbVa9S1gu
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Tue, 21 Oct 2025 16:24:00 +0200
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

There is a condition guard which ensures that the GPIO node, indeed
describes a GPIO controller.

	if (!fdtdec_get_bool(blob, node, "gpio-controller"))
		continue;

Since the bank base is being incremented in the loop, it is done so
irrespective of whether the node is a GPIO controller or not. This leads
to the incorrect resolution of bank base addresses.

Move it out of the loop, and instead increment the bank base address
only if the driver successfully binds a GPIO controller.

Reviewed-by: Henrik Grimler <henrik@grimler.se>
Fixes: b8809e60cdb5 ("dm: exynos: gpio: Convert to driver model")
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- collect Reviewed-by: tags
- add Fixes: tag (Henrik Grimler)
- Link to v1: https://lore.kernel.org/r/20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org
---
 drivers/gpio/s5p_gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
index 53dbbe97b5a02d09fbf0124268faaffa31b1315f..c072f146514c63cdc98e907983a904f05cd118e7 100644
--- a/drivers/gpio/s5p_gpio.c
+++ b/drivers/gpio/s5p_gpio.c
@@ -319,7 +319,7 @@ static int gpio_exynos_bind(struct udevice *parent)
 	base = dev_read_addr_ptr(parent);
 	for (node = fdt_first_subnode(blob, dev_of_offset(parent)), bank = base;
 	     node > 0;
-	     node = fdt_next_subnode(blob, node), bank++) {
+	     node = fdt_next_subnode(blob, node)) {
 		struct exynos_gpio_plat *plat;
 		struct udevice *dev;
 		fdt_addr_t reg;
@@ -341,9 +341,8 @@ static int gpio_exynos_bind(struct udevice *parent)
 		if (reg != FDT_ADDR_T_NONE)
 			bank = (struct s5p_gpio_bank *)((ulong)base + reg);
 
-		plat->bank = bank;
-
 		debug("dev at %p: %s\n", bank, plat->bank_name);
+		plat->bank = bank++;
 	}
 
 	return 0;

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-gpio-s5p-bank-fix-1d008cb2a1a9

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

