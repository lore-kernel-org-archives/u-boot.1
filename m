Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8E0C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 14:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E025186D85;
	Thu,  7 Dec 2023 15:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Wp/ElJj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC6D86F40; Thu,  7 Dec 2023 15:28:25 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE9D8269F
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 15:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso4560925e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701959303; x=1702564103;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VntyrWc/jYjW4kXH7Qwq7TkZMk86hPLLvWO9ki9un80=;
 b=Wp/ElJj3RVVV3ChWRZ/1WBr8x7yoj2OnhHYDdKM2QCUoIOGdZzQjUzD39DGPsOBTOs
 rHv5hiqZsqop3nFTbrXNm9g6EVyKVa93job7ocgKOZ2qJ2k4FHp41CliqVM+V1zkWsE2
 FNEtCUoXq9nT7VKNR34ULY0ZoCpE5bNkz+6GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701959303; x=1702564103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VntyrWc/jYjW4kXH7Qwq7TkZMk86hPLLvWO9ki9un80=;
 b=rgM+vX3b/SWdnUZzHJ7L3iOddNGVt8EdxiGAc5E23vCI+6uyrG0zZ83eONNXss5Eyu
 EbEs/HUorcGJbAgZA52JXirlJx37TnLs0PS6bhuO82k+P0MLSnkPlt8CDFOZTXa68htS
 pDil3tOVvcc6DGFeaHWLbXkn66r+laHcvkfpw2jrcaDuy3vwJTyArWCetUIYUiEkv/7Z
 omC6GyW2ZKLTfkdOYlsZsSEo3uLqH8UYGWz/qcUFt2P0MYpS7i3cHe5wthuQr21kkw/d
 zr1viDNbdL7rT0a5+emCZSkhJYFu7iBJRt1G4LqwU4R47uQNvwKnmAm6LPMFXDS8dlUN
 TMyw==
X-Gm-Message-State: AOJu0YxkBAaGqqCMZzo1JLh964iPCZe6R5X04uRakBq0/VTBAMlmAH7o
 xAbwqmXw5h/HYsx5StsOmGE5Tg==
X-Google-Smtp-Source: AGHT+IFOL+fKMCb9k+T2sd73EMac7NNFRzdUIOqJ/9nli7OKDTzx6ubZ04nQhWESkW81NXSxAqyiVg==
X-Received: by 2002:a05:600c:2352:b0:40c:2100:60b1 with SMTP id
 18-20020a05600c235200b0040c210060b1mr1513091wmq.178.1701959302992; 
 Thu, 07 Dec 2023 06:28:22 -0800 (PST)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6474:ebbf:55e:f958:69d5:35de])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a1709064ec600b00a1c85124b08sm894568ejv.94.2023.12.07.06.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 06:28:22 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] pxe_utils: Increase feedback to user when fdt file is not
 found
Date: Thu,  7 Dec 2023 15:28:19 +0100
Message-Id: <20231207142819.1511709-1-michael@amarulasolutions.com>
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

extlinux.conf can set fdtdir. fdtdir look for fdt file using
information found in the enviroment variable. The function does
not report any error in the case the file is not found

Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
Scanning global bootmeth 'efi_mgr':
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Scanning bootdev 'mmc@fa10000.bootdev':
  0  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_ /boot/extlinux/extlinux.conf
** Booting bootflow 'mmc@fa10000.bootdev.part_1' with extlinux
1:      am62x-sk-buildroot
Retrieving file: /boot/Image
append: console=ttyS2,115200n8 root=PARTUUID=c586a30c-0bf1-4323-aba8-779c814ee135 rw
		rootfstype=ext4 rootwait earlycon=ns16550a,mmio32,0x02800000
Retrieving file: /boot/k3-am623_ccm_m3.dtb
Skipping fdtdir /boot/ for failure retrieving dts

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 boot/pxe_utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a92bb896c6..83bc167785 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -700,6 +700,11 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 					       label->name);
 					goto cleanup;
 				}
+
+				if (label->fdtdir) {
+					printf("Skipping fdtdir %s for failure retrieving dts\n",
+						label->fdtdir);
+				}
 			}
 
 			if (label->kaslrseed)
-- 
2.40.1

