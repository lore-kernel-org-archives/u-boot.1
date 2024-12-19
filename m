Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF462E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8959380352;
	Thu, 19 Dec 2024 03:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R/dBXUo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFCB8021A; Thu, 19 Dec 2024 03:39:24 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 221248022B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso26843039f.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575960; x=1735180760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I65WH00bdpQl5qUCsoqdcvCwhkDhT/5Wk3OKKrB85bE=;
 b=R/dBXUo+ihHOdiurkB4r5x+XyUQT/TWUnzbC9wpLCkScTVOkYVAeoP6bVqtHIGLa2P
 X8KsgewDjufqpP9fxCdV/nvIZqPKJviCngCZ4Md1vLBEcjXeaKvQZMijXh37HciEthlY
 Esi8tCzItS8VA74xS2fBcFlSvRSBf6E+e5g/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575960; x=1735180760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I65WH00bdpQl5qUCsoqdcvCwhkDhT/5Wk3OKKrB85bE=;
 b=PXqOT4zsJKWyAD1YxNl4qNBM7k5zqSlthYKiytgw6p28tb7oeY/7L4d1+U4oFTsxHa
 KX+gg1TZBd+pxoX26HlqqxbGghWsB+zWwKB8dd8ovfwoEDzKwFqcgMOAmia48NFFA9P5
 E0+CYSlr4QER9sKFlO2qR85+zXhzw6sI/8UIjZENcfI0jJX4Lr54M+jKWjlB6fMWdkDA
 BT91XX1fWhgv4CYzLIdoAijd7Q+RkTLp2YFRzD2sPqR+/56HrdMnw/o7Asu6uFIEpMm2
 ggHL7qsC+eWqiBXA/3NTcRUrzrRQ9wCS/XTUaUruSyTaVjbBiXuQEFecj8JhqMjlyk7p
 Lnhw==
X-Gm-Message-State: AOJu0YxpviFl7/Dvt/QYeLZs0RxL/M9KqzGI6jOgX36OK4aRWBFW0mgF
 Iq/56oK+S/Uw4/W6OY7PcyvM5fdckrok0rNFMTj4sx9ueJHNchLlbjz3ugtoZqBBEY/VzOoqBUE
 =
X-Gm-Gg: ASbGncv13z78lQ0zsxUAJDpXGiul8r1azrMaQMt7rOj2vgxMNBFeSKAxjJhkeLPYn0e
 /4LmYCQzbv8hVa7FD70Od4GyivepFIPx7gazJ4IKkv+KkiwzseHRM4z+wqI1QxrdC5uYLbUHEUR
 OzwTzlRTD7V5016rkF9U0AkOAX/3G+aaMMof3Upad5fbWJwQi5V1mwumKLkgidlMFc3RzXq/31d
 JBbByfSbfg79sXDJob/+2ylAU7MjHSTr/Gy8lJGsxIqC2ziCOvu/rI5aCkCw6Ht18E/0dltqRNU
 kWqvCP23EiO7SzZ8gw==
X-Google-Smtp-Source: AGHT+IHBq7MsFPBw4x7xjPh+SKVs5XBQhP+6fbI//EL+rTdRJHet7TOyi7j+8i5QkNVcFVBR/gI9Ug==
X-Received: by 2002:a05:6e02:3f0f:b0:3a7:a2c6:e6d1 with SMTP id
 e9e14a558f8ab-3bdc437aa80mr44754885ab.16.1734575960325; 
 Wed, 18 Dec 2024 18:39:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 7/7] bootmeth_efi: Support PXE booting
Date: Wed, 18 Dec 2024 19:38:32 -0700
Message-Id: <20241219023832.1098689-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219023832.1098689-1-sjg@chromium.org>
References: <20241219023832.1098689-1-sjg@chromium.org>
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

Finish off the implementation so it is possible to boot an EFI app over
a network.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to support PXE booting
- Rebase on Tom's tree (i.e. without the pointers/addresses series)
  https://patchwork.ozlabs.org/project/uboot/list/?series=436241

 boot/bootmeth_efi.c          | 15 +--------------
 lib/efi_loader/efi_bootbin.c |  5 ++++-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index fa7f66c9a0b..de7ae2d2ee4 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -210,6 +210,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (size <= 0)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
+	bflow->buf = map_sysmem(addr, size);
 
 	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
@@ -217,10 +218,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("bootfile_name", ret);
 	bflow->fname = strdup(bootfile_name);
 
-	/* do the hideous EFI hack */
-	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-			bflow->size);
-
 	/* read the DT file also */
 	fdt_addr_str = env_get("fdt_addr_r");
 	if (!fdt_addr_str)
@@ -294,16 +291,6 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 		if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
 			fdt = bflow->fdt_addr;
 
-	} else {
-		/*
-		 * This doesn't actually work for network devices:
-		 *
-		 * do_bootefi_image() No UEFI binary known at 0x02080000
-		 *
-		 * But this is the same behaviour for distro boot, so it can be
-		 * fixed here.
-		 */
-		fdt = env_get_hex("fdt_addr_r", 0);
 	}
 
 	if (efi_bootflow_run(bflow))
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b5d15a723b4..249de3cadc5 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -302,6 +302,9 @@ static const char *calc_dev_name(struct bootflow *bflow)
 	media_dev = dev_get_parent(bflow->dev);
 
 	if (!bflow->blk) {
+		if (device_get_uclass_id(media_dev) == UCLASS_ETH)
+			return "Net";
+
 		log_err("Cannot boot EFI app on media '%s'\n",
 			dev_get_uclass_name(media_dev));
 
@@ -342,7 +345,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
 	ret = calculate_paths(dev_name, devnum_str, bflow->fname, &device,
 			      &image);
 	if (ret)
-		return ret;
+		return EFI_UNSUPPORTED;
 
 	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
 		log_debug("Booting with built-in fdt\n");
-- 
2.34.1

