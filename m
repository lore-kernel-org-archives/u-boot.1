Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8902FC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E379D84AB5;
	Sun, 19 Jul 2026 20:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="RxLmHrYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B7284A52; Sun, 19 Jul 2026 20:04:13 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B3B8494B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-80c5cb9a888so80025727b3.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484250; x=1785089050; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d4ADegBBN86KYaPAL5O2SQBuxFcj0wpERtGpku+4OqA=;
 b=RxLmHrYwflKlwvPNCyD7B0WaIUKZoLvHXRNgyfgLEaZSHqU/cLa6jsTvSmoo9qXybt
 YxJbZmISGEHw78G0wf4rCnNUlzEclnK2v2icd2Lh/1J6jD/t047YXQgo84BR4CkdISLv
 zAUR6ucgKZ2FN8kba86xFMmVdEWQmCUJ74df/FdGD3/uZ5qAopXVO3pn/CxQ6EkBADml
 araeCJA9/dorutNE35tJ+8008obCwB0NALgHJr0gTI6bAtzO1OXCbAH79d/ziaY3HzjN
 4SEm3gTda2Vfn8B6lAEaShAapQDAxbB/pBAkoxIGVk09QmxQtcYLfSqFxeu9KfCQprqs
 7uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484250; x=1785089050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d4ADegBBN86KYaPAL5O2SQBuxFcj0wpERtGpku+4OqA=;
 b=Kpvtv2EOcsasL/x9leNsMN9Kr0r96jG5BA60NJ17XHiQ/1UB9YhQ+kzZIOkPTo17Um
 Yx99DWsR+VNHi5cvMkEEb6JLqo/b6nRAIfkdjjJ4jK6LEVRZnEvhme3u8SOVHxcrZ+Ky
 2timDFNXyVIuhXWqY1cv86cTNYrdhmomUbtKfkD5LsXTTyV6uz0DTg2UKjqGliFdevt9
 zo5ASoVgMezUQI7EC03H3m5DqS7Y057ok85u+Z4Ame5JfZLP0OTw0IJR2PjM0au9AyuD
 EYPJrKOVm6DptizuWZa0nHPtsXEONq7wQB/aIKovMbH6J+mqNyc7uiaxvYuKmRNZqOnD
 drPw==
X-Gm-Message-State: AOJu0YytxtZ5abIY3kED5/sJqC85fspcCP15jAxoCl5FYc0NAm9vXB2U
 h1q9VPVtFC38EuscMmpx+wL4PyseE8oZDpAKDYIoPAnhe7lGUtJ4N/ELPbB8Pi+SJOE=
X-Gm-Gg: AfdE7cnkEwyLTHNMrrjG+hxMd6i+ZFwONt0yPqKPtRPRxwbsJTScM83MmBBFVNxvwPe
 oLLvHLGglFdsLKkL8GQO8ZjOzS4dsQLJF0DCFJltJKKq3cxJRW8Ey9xgEydQ7dOUubzB0h3IuYh
 p2Q7/9Xfx5mLXkGWOVIDm6zJJYe3ZMVWpgDkGHDV7s24wJA356lw5t8Fd1LS5TKCDk62RlUEtmy
 JtohS5u9MGb+idahiwtTAjoPohNy2dVunixsHWnMcII6JxnvHsA0ETyRjompFgVMSWzHvd7JaMp
 QML+Q4UO74Mi9+BpcnuWGQ0TukFqm8/DQzEotBBnMtaXxS3NcmJ9JSECCX6s4rQPtxQQxBB16/f
 YasYq0p40lClq9F36wdAsNKCSiGtJfig23QRofECSeL41wJf5dQ+CPSsi953XqzrxG+JqgKIoI+
 967V6lN9D/A5E4DVPi6NNzYfTv+zKUCinDI8rJ3kI24iJHktpsOEvYZA==
X-Received: by 2002:a53:d60b:0:b0:664:def5:2ff0 with SMTP id
 956f58d0204a3-6683bb6899cmr2372181d50.34.1784484249869; 
 Sun, 19 Jul 2026 11:04:09 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:09 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:34 -0500
Subject: [PATCH 3/8] bios_emulator: use driver-model functions for PCI
 config acceses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-3-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

To allow BIOSEMU to build without CONFIG_DM_PCI_COMPAT, update the
PCI config space read/write methods in BE_accessReg to use the
dm_pci_read_config8/16/32 and dm_pci_write_config8/16/32 methods.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 23392d3c86e..e02c9fc636c 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -435,27 +435,27 @@ static u32 BE_accessReg(int regOffset, u32 value, int func)
 	if ((function == _BE_env.vgaInfo.function) &&
 	    (device == _BE_env.vgaInfo.device) &&
 	    (bus == _BE_env.vgaInfo.bus)) {
-		pci_dev_t bdf = PCI_BDF(bus, device, function);
+		struct udevice *dev = _BE_env.vgaInfo.pcidev;
 		switch (func) {
 		case REG_READ_BYTE:
-			pci_read_config_byte(bdf, regOffset, &val8);
+			dm_pci_read_config8(dev, regOffset, &val8);
 			return val8;
 		case REG_READ_WORD:
-			pci_read_config_word(bdf, regOffset, &val16);
+			dm_pci_read_config16(dev, regOffset, &val16);
 			return val16;
 		case REG_READ_DWORD:
-			pci_read_config_dword(bdf, regOffset, &val32);
+			dm_pci_read_config32(dev, regOffset, &val32);
 			return val32;
 		case REG_WRITE_BYTE:
-			pci_write_config_byte(bdf, regOffset, value);
+			dm_pci_write_config8(dev, regOffset, value);
 
 			return 0;
 		case REG_WRITE_WORD:
-			pci_write_config_word(bdf, regOffset, value);
+			dm_pci_write_config16(dev, regOffset, value);
 
 			return 0;
 		case REG_WRITE_DWORD:
-			pci_write_config_dword(bdf, regOffset, value);
+			dm_pci_write_config32(dev, regOffset, value);
 
 			return 0;
 		}

-- 
2.43.0

