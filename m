Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD10E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06D9896B5;
	Wed,  4 Dec 2024 00:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EL6abuMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B62A89696; Wed,  4 Dec 2024 00:47:52 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49911896E9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84198253281so216052239f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269668; x=1733874468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlzJGU4+LZ7F0oEmRxjQ2/0xIF3Ehh/AF5D318jSqeg=;
 b=EL6abuMWqof9P92aPvHz0RSf/QsaGDAqNeoiRFZ6XFj2yMfjbbat8fWOdXGQiur4nV
 4mnGJeH68JzM9QrdcIiILauJz1TigiUpuB23FGAxgcekkQBA3LFq3/U905jPFTbFyqhV
 RhQyLDFwzZEMuARm49P2Y3zcYl3jd+cBJYK2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269668; x=1733874468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlzJGU4+LZ7F0oEmRxjQ2/0xIF3Ehh/AF5D318jSqeg=;
 b=onHyo/QKFbhmku9VX9XAhk7p23QNT7M8ggizl90f6SlTLhz2lrukkEuHLVynoMtbVj
 wD4YeQD6tzyNuVYKanOiOPKWsiXuFzH0Nfx1qOVmSVCEd5bVqvgGjHRtAh3MwhfM7xi/
 ksR2HhwAZw9P43MT96IS5d1t/osZ97E7WV2pN6MLnmm8rScwfVvmmBGsgBamUCjdDYuf
 6RQYzxFyLyVYPoOcKdg+E31Z1IkIrHWxufhMUISnQzGCp1IWFN8+KSquqGOK9ZxIHNRp
 KgSznt8pAloONb3x4EZkkSkMvaStHGpEOP2olsO62E9jBJl6wHFTjxVypDz0j3E9lwUi
 oRvw==
X-Gm-Message-State: AOJu0YxzV7uhJmGptFuP8+ZLgRI8cl0vB03p9aww+xKf8CPg1lf2reeX
 U3Hfdv2XuzTizIz8h3AJtP1rlfDSbpt/wCeg/t+BP/XBf/9opowPcdmQYVQYFOF7eU0yDaRWscQ
 =
X-Gm-Gg: ASbGncuj5XDvv7K6+9zMUOd8MRj/zcnZDlbV5NbFhbq2Dz0XF5eV+vaOiRBZlkvdjFe
 P2KBB71+SpKIehGGhBL6OaA1d8Cm+FhmEWApbPqnxYmCN8rPE+QcnJhrQiHPjRDis9aYVJoaWIR
 syV7O06qTcVy5q3VLFK22PCPX10VSD0iCeT181P5dPvNaZbRPs51VSgQoWHUy8ZJNItYZD/VMFA
 3lOnX5reSSEGrRNvUOKO6l5n+F/N1hc1Ekq7aPezoCjlRDoKSjRINeGKZSbmU00nQuwe28Vqwup
 aMB6oaGLobc=
X-Google-Smtp-Source: AGHT+IF0KyOARW/5gpbmzWx6kMjm81WO0ubfCa8uHcFaTwl/6gNf2ynOetzElEhky0+y18fEZppo9g==
X-Received: by 2002:a05:6602:2d94:b0:834:f2d5:c758 with SMTP id
 ca18e2360f4ac-8445b5e23bamr490771439f.13.1733269668602; 
 Tue, 03 Dec 2024 15:47:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 34/41] bootmeth_pxe: Implement the fallback option
Date: Tue,  3 Dec 2024 16:45:52 -0700
Message-Id: <20241203234559.2938192-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

(no changes since v1)

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

