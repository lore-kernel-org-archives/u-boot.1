Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A84DCD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF4D8465A;
	Sat, 16 May 2026 09:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="LhEgQqSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5071583EF9; Sat, 16 May 2026 09:40:39 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BAA984099
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c802803ac17so225707a12.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917236; x=1779522036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPT0u/p3Cx0fa7/C6PMMMedxuAs+vVkTrlpsQQfmkio=;
 b=LhEgQqSpDvxPwcVJcbzBmtgyUtWZ0DFUmkQskK6G65WSwlAL8X7EEsYpPrEiqsKZfT
 QFn7EweOw6eouGru6SYbA2i92sHIEKQVRGCkhgOtpseHzj7ILOBXbnRfgmbg+Zidbjuu
 QSGO0fZN5q3AkcAgHR4yq1pB0f1TqLCnSyZnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917236; x=1779522036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPT0u/p3Cx0fa7/C6PMMMedxuAs+vVkTrlpsQQfmkio=;
 b=o+Yn9NmfXgk/R+1HykH8ymU0F9EtjESp2K48YqNBsWIJeCYT2ZsZB7CV0oY3yo+W4t
 B+iwnvXZQFIyfVR4nkXSp9MrU7wNYiRNP7AF+RBZcsZHwdz6p960RQeZof1BqR5gUEGF
 8QTAwxBHiUe6v2RUJw+hIzMHzi9OBPaHJ0w0ITjiN8EJ6mbPYwR4asH9+SgQKlhD4OYE
 eFz2h6qUJhxnNHZehfQii0gD1WZV7O7vK1sK8lx/dqAJy9urSoOT3ScMdZfgLhDlI2/v
 OIGJwk+b1k0twk1qyBVnG4SgzpAPVqcATOFRZPglrXP0kgOzkI2+reLEe0xqA5md3lU+
 njvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dQ49dW4AD/AAuL4aSbbsp5SDfqc5NqsHACq3KtPoByh2s5rM04CdkgxE/sKS1Ra4XNcOBP7E=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg0AQ/wEakhYKAnrKityPi6vCMBPmhKjyfqMvSkLxgI/apqvXl
 6VohExAyMK254Jun8zPqJzoNmeDdTQx+PCVDcUhoPJMzK92i120NsE1Fng5IyrnHBn0=
X-Gm-Gg: Acq92OFEHhBBnG5uYDPGcmz2JewDvu7/NmAdGvbuyZL5wvXghkJqoZ6U2g/L7Y/3+ZU
 MFCVfMnS3c2Ed+maeMpqU12GZZahNK2T+mcT8kj4S+QlOxiCtcurKBOzDPO5dG8TPRk7amCizIN
 fYyZfw2qI1DVOwEYwW8qxnh4Upx/OhxHL1EwGvE+p9P5JL0pMjsx8YXz3wMK1fwmik+DmZLf/14
 6SC41meBFpXV0OPb05RVSItnRDlUo/PHdmB2IpD8UH2nxi4SR9O8W8k9t5fbfCwYdDx4Jj9SBDL
 9uHedRUEEQQpZ+2qSp7sRqBeQGSSLWWr32guNKsMiPx17CEZUTRN4HjK+wcRD0PHggSx+wiJflM
 3EYvwte30IQJLDbSJpcgIw7sSIB4mo4NeSU6SCz1V06N91yWHGsTlxpPxn9nxU087Fde3UeELJ+
 jgIrYqrqzUGkezs0L4e3weZPQSgurGRe1keUzLyd2kTg2u4LluCPvFFJUIU5suOOjxbfRqOwmrk
 UIj34BMQ9pj7g==
X-Received: by 2002:a17:90b:1344:b0:366:4782:138c with SMTP id
 98e67ed59e1d1-36951b971ccmr7714595a91.17.1778917235638; 
 Sat, 16 May 2026 00:40:35 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:35 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 1/9] sysreset: qemu virt: Use map_sysmem()
Date: Sat, 16 May 2026 16:39:53 +0900
Message-ID: <20260516074016.885146-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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

In the platform data there is a phys_addr_t (an integer) for the address
of the register and we pass that as-is into writel() which is fine in most
places because we don't need to do any mapping and the macro for writel()
does a cast to a pointer.

If writel() is a static inline function the address argument is a pointer
so passing it in as an integer without casting it first causes warnings or
build failure.

map_sysmem() handles the casting part and if phys_addr_t is 32bits when
on a 64bit machine.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index e7cacc9b6e98..61b38d507fc5 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <qemu_virt_ctrl.h>
 #include <sysreset.h>
+#include <mapmem.h>
 #include <asm/io.h>
 #include <linux/err.h>
 
@@ -24,6 +25,7 @@
 static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct qemu_virt_ctrl_plat *plat = dev_get_plat(dev);
+	void __iomem *reg = map_sysmem(plat->reg + VIRT_CTRL_REG_CMD, 0x4);
 	u32 val;
 
 	switch (type) {
@@ -38,7 +40,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+	writel(val, reg);
 
 	return -EINPROGRESS;
 }
-- 
2.53.0

