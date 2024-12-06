Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44065E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA6F89756;
	Fri,  6 Dec 2024 03:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QQaYlhyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB2189776; Fri,  6 Dec 2024 03:38:20 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8259589761
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a814831760so320655ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452696; x=1734057496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoWeoek1tAJaSsy88HsYiS60U4m3iWD9z9iWtihJc0A=;
 b=QQaYlhypn/mh3jW3OHiN0OcZp9wcMnCUi8nVqRV9/Fng4kmSuIRPmaBMMHTGsOV+ff
 lMS59CA4Y56WC6RS1t5DBswijEgiG53cX28YvPbQeeOhl9y6JMnnkvh0BK6+yiTEh8JP
 4a0CYr0y/tEji8DbY7huMku/AU0G9TgH3BILM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452696; x=1734057496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoWeoek1tAJaSsy88HsYiS60U4m3iWD9z9iWtihJc0A=;
 b=pa0TGXfeZPNW1E/6lsr/wkPaWR7vha7AiZgQJj6USuGpkZlwjwEdvALg9pFoGbpH2X
 qKqvtS6mNbg1U8TatQh+PcwWXDexEMPpeNQ1SZbxPcQefX7Y9qzfU9S4LLmBELmgrsky
 +ynMFGUAH5ObW59K2AfEruMBqXxHDQOsd38svHCEe7Zf1Tr5JhSt6UEJ0a9G8oqOSkdd
 iGPLaU44MppD9EUMe+rkSWHxWX8wYBNgbQXFlJk0C6JdID99u6fl+IWaIQ+h8Md3c1MV
 0fx7wPq7doO7M59N4lVhqOpAOS3t5HSzwvxD3/aZ0vu8fJ3IteYwRGzNzTcmWpwUDS0f
 kNlQ==
X-Gm-Message-State: AOJu0YwAHYN4Eq4Ar/lrF8VxkrynRf5NBSi+fUWjIQn0oQtzUHJarlrU
 ZJVR2NSrgD2+9OwoVGxkGpupZi0NYODMkvirE2g7epftkEssU19u6d19k/iODPLaU8A6s8zU+Ok
 =
X-Gm-Gg: ASbGncuAfKBIfzmq/WCStNc0i3NXcnOzAp0Slzd6swEBiS3R8BboICmUEQTLVt8E1H7
 QJEgwp7V8WJ/aN8B+BeQkKagWONKFLd5NL0xjop9wlpXFb0mzV/z7SSid6gR1yqJdnM0WlTlL+C
 gaH5ONukJN9A2cGINdQBst9cDc0zeXlfejiFyJFe21++LKHIUh0/QH0cHUqMk2NLETfB/Ngl4e0
 TQ8y30eKlcFE+8Vvnkor+3s4xjgONSa7/JIL/Ls8VMIe6lElXWe6cB2N74bk2g1lLNQmLMNP1qW
 GUCudeFtqx4=
X-Google-Smtp-Source: AGHT+IHwvZqmoTgPNWG4XtMQVUuX57hZBg6CagLizi5RevXSrEt3sT2pahOEd6cvOkOY3SG9HpYI7Q==
X-Received: by 2002:a05:6e02:19c8:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3a811dcca00mr22398465ab.14.1733452695760; 
 Thu, 05 Dec 2024 18:38:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 39/46] bootmeth_pxe: Drop the driver-private data
Date: Thu,  5 Dec 2024 19:36:18 -0700
Message-Id: <20241206023626.2456858-40-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Since this driver's plat-data already contains a PXE context, use that.
Drop the priv-data. Use the extlinux_info which is in there, as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 6b3cb3c4b91..a9608edcef9 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -140,7 +140,7 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context *ctx = dev_get_priv(dev);
+	struct pxe_context *ctx = &plat->ctx;
 	ulong addr;
 	int ret;
 
@@ -188,6 +188,5 @@ U_BOOT_DRIVER(bootmeth_zpxe) = {
 	.of_match	= extlinux_bootmeth_pxe_ids,
 	.ops		= &extlinux_bootmeth_pxe_ops,
 	.bind		= extlinux_bootmeth_pxe_bind,
-	.priv_auto	= sizeof(struct pxe_context),
 	.plat_auto	= sizeof(struct extlinux_plat)
 };
-- 
2.34.1

