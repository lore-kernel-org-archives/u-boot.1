Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A41D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5710089667;
	Tue, 19 Nov 2024 14:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TcUAukeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16736895A6; Tue, 19 Nov 2024 14:20:22 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A620A89667
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a777c67c45so2749875ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022418; x=1732627218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5tmLvblB447Vtpk3sbWOOAwGvba2gPRHYU/f9JYyvk=;
 b=TcUAukeQQWLsirHNiVQbltOczH+T+x+Pony781ndFBoESRCRnzzU/Ni12+nzRLUoq2
 KRlW/MnHFj3edMNQjZ+q7rsl5rEkphj7mCo3W/shY9HoYOe5icKVMdZ88+8tMxvRgNzw
 /X3TkOwEFBwVQfCKoIO1Q9yLOxxFycDvNkMW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022418; x=1732627218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5tmLvblB447Vtpk3sbWOOAwGvba2gPRHYU/f9JYyvk=;
 b=fE3mfSio/RCPF08K2WXWx4OLsCXelYMQ0PzjHcag4eM5Av2fzo94dsm5exkvn4gtM2
 zBOb3DS4k1WNneVTYIhBpvhuIAHRVvHgqiDe1kUzhw1rwykr8hW1eueWD2SgliMaHVEH
 TEaEnrlI29wwavSqJACGuAU9XmEWLY7EPecidfHH2mPypek84V9POTEGOVlpzED6k7ag
 D0IvQsr3KBkDltVwPP62YYdOpTcg/eh9QJzAKItP8PfDR67dU2PiktwZ+jr45VaT7M5+
 d6su+QYHE5A2Bpv4BRHlLhvYJHJPUzz+DID7wSA0x3qw/mzGiy7QX8JysJbqy6FMYSLj
 zW9A==
X-Gm-Message-State: AOJu0YzXfxZvYpfYNEpaXFbqpez8oZEwt+FDSfV2i6bhG97TgMZHZmkF
 xiXr2qwZT60abIS7XBXBVXVcLNLnPXGYIPsHHVR9Xnmj0aZkXH4ccTgWnbILo45EksohlLpY99E
 =
X-Google-Smtp-Source: AGHT+IFpuy8DakWcq8KzUrmp2Hgo258AxMTRbhGAyZu14E/WMR3nhtyUWc43ZdEVjHMErUy579kjMA==
X-Received: by 2002:a05:6e02:1a88:b0:3a7:6e6f:d04 with SMTP id
 e9e14a558f8ab-3a777419edcmr27724755ab.5.1732022417871; 
 Tue, 19 Nov 2024 05:20:17 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 32/39] bootmeth_pxe: Implement the fallback option
Date: Tue, 19 Nov 2024 06:18:37 -0700
Message-Id: <20241119131844.4078144-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Provide this feature in PXE, so that it matches extlinux. Use plat data
for this, just like extlinux.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_pxe.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index f2b9ffaae89..6b3cb3c4b91 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -139,16 +139,16 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
 	struct pxe_context *ctx = dev_get_priv(dev);
-	struct extlinux_info info;
 	ulong addr;
 	int ret;
 
 	addr = map_to_sysmem(bflow->buf);
-	info.dev = dev;
-	info.bflow = bflow;
-	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &info, false,
-			    bflow->subdir, false, false, bflow);
+	plat->info.dev = dev;
+	plat->info.bflow = bflow;
+	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &plat->info, false,
+			    bflow->subdir, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
@@ -174,6 +174,7 @@ static struct bootmeth_ops extlinux_bootmeth_pxe_ops = {
 	.read_bootflow	= extlinux_pxe_read_bootflow,
 	.read_file	= extlinux_pxe_read_file,
 	.boot		= extlinux_pxe_boot,
+	.set_property	= extlinux_set_property,
 };
 
 static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
@@ -188,4 +189,5 @@ U_BOOT_DRIVER(bootmeth_zpxe) = {
 	.ops		= &extlinux_bootmeth_pxe_ops,
 	.bind		= extlinux_bootmeth_pxe_bind,
 	.priv_auto	= sizeof(struct pxe_context),
+	.plat_auto	= sizeof(struct extlinux_plat)
 };
-- 
2.34.1

