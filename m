Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D84C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFD887519;
	Sat, 18 Nov 2023 23:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="oDoy3QXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CF786FE4; Sat, 18 Nov 2023 23:08:07 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0F887504
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so6444575e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 14:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700345272; x=1700950072;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8c/Oz5EM7xdY++8Gk9nGYmrmMDOj52I1Zad+HbkO20=;
 b=oDoy3QXfQ10KC925jm/e1GHkYfDNa972zocUDVICLFWiY0P5ud4IbJeqa5XNB3jZVu
 dFOBGHuZVaaU/L4tHmLiyREEtz/BfCsYpyUVnGwVBquMUtiaCnxkoHtd2v8OJstBJbQ/
 Uj9oATaQ+yVOrhr9Md5BIKdDcIm7W9mspPAVZn32VYz2GHOeBG2rcf/xQ8YtXAscHLIv
 P2KG6lQLxONScpXTx73S6/2CqvT+F+Y4M8qo0/AXjzRi8Ctz7u+1OWmG0X8RfpeIef//
 c/JZplK7Q2LzOOGvO3k/CE23xuDGSA/2du2xPtMEmrVBxnjJdIycDdSZlMQ45W+3xIC0
 uqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700345272; x=1700950072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8c/Oz5EM7xdY++8Gk9nGYmrmMDOj52I1Zad+HbkO20=;
 b=FZ9ak0r8mRk0ixj8CtJ1ePQKhukM5T9hqpfPimYEZaMDosFD7J0284F4kcvWoEIgcu
 Ea2wVsx6YCHy9FncUvww3TUCyNOhNsiw3ECamGnIwg6FdiiIB6uIG2LtDLjpiekgYPb+
 E3/FYDjiXbph5b+mXC518iXBUWkjucSkBBiEOliKgWUaVe5O2UZXLT08Hc3O+7s/CqqX
 PsVuzWHyY7o11tEq7q6pfHKFOOtXW83JqZlJF3+LZo0AygSiCUhm7SCukLfEj5er65da
 gESmBggiPkyRD3bQ7MazTInQr7XwwN6r5JOD0kdt7DmILN/7FZFRMoxljyfH6TriJ20y
 e8Tg==
X-Gm-Message-State: AOJu0YzK1yNQr8j3AnB3RSMwGdNphw74ALneG0wutwjetQxzCqwME+Su
 i87Okz1uOb/RwDRFmxa7lGs0CVDjKg2D7JAgHGnclQ4p
X-Google-Smtp-Source: AGHT+IGIBNqBDWyXROz25RLFxhhFcsZebRr7UQ6NHPpfdTwO8QvjO7lLXiKG3+0FwWw7EJVmtbK21g==
X-Received: by 2002:a05:600c:4f04:b0:409:101e:235a with SMTP id
 l4-20020a05600c4f0400b00409101e235amr2295615wmq.28.1700345272064; 
 Sat, 18 Nov 2023 14:07:52 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b00407752bd834sm7791581wmq.1.2023.11.18.14.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 14:07:51 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 4/4] bootflow: bootmeth_efi: don't free buffer
Date: Sat, 18 Nov 2023 22:06:34 +0000
Message-Id: <20231118220634.1271886-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118220634.1271886-1-i@shantur.com>
References: <20231118220313.1271556-1-i@shantur.com>
 <20231118220634.1271886-1-i@shantur.com>
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

bootmeth_efi doesn't allocate any buffer to load efi in any case.
enable static buffer flag for all cases.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 370d6fba9f..93f096896c 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -160,7 +160,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 	if (ret)
 		return log_msg_ret("read", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
-	bflow->flags |= BOOTFLOWF_STATIC_BUF;
 
 	set_efi_bootdev(desc, bflow);
 
@@ -404,6 +403,12 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
 
+	/* 
+	 * bootmeth_efi doesn't allocate any buffer neither for bulk nor net device
+	 * set flag to avoid freeing static buffer.
+	 */
+	bflow->flags |= BOOTFLOWF_STATIC_BUF;
+
 	if (bootmeth_uses_network(bflow)) {
 		/* we only support reading from one device, so ignore 'dev' */
 		ret = distro_efi_read_bootflow_net(bflow);
-- 
2.40.1

