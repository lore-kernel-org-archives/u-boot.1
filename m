Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B03DE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A62080602;
	Mon,  6 Jan 2025 15:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VYLmdxMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB46E805FE; Mon,  6 Jan 2025 15:33:03 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E28880601
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a9cb667783so112658985ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173979; x=1736778779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hSyd1PULWCTmgR6E9Rcx+Khr2hPT1z85vFUYlsF6Bg=;
 b=VYLmdxMMbjaE7zVUnm4JpcaecMrhUIgKDxgcQtEVj2e7WNVjH1JzZe4JkoVXbOmTg4
 8PQ2/cNbSOl0hDZTauvNtXREywTVIj9EXhQcdd3dm236hN2YVTKaTMiQ0uH3McsE/sGx
 z/lZw14qLkyoVhQNMpmSPP5tHU6X6/I+/eTjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173979; x=1736778779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hSyd1PULWCTmgR6E9Rcx+Khr2hPT1z85vFUYlsF6Bg=;
 b=QcT6N90jz4kJwS3gRn11HHK67YRXZZ21O+DVgWKkpw4sE8XIc+Xy5wdIBl50WXQFhT
 W2sldZDuKTkQ5SczIpOdCZTs8wx9UGkX0Og1/pjq35HfS2gnLB82Zg/9x9Md6imn0tUW
 NyBHRgj2qFOJ5EExu+JN/ccKcIeGlyb/VFWQiCTUMuqzWj4IUVrdZ0OhNCKY2/4nFnQ4
 YrUW/lEDuyxA+A3IuwLnaKHLGXybBkHQHZ+WuJ8jp89yL64OcIXEYDSaMJ+uZbZNB6b/
 sgIMH/qUqbzTVy7Lw8HAyBcsC73UW9N4N+GyiEplxA1Qyt4+BD4JAtwK/9yYW3ckyhXz
 6SAw==
X-Gm-Message-State: AOJu0YyY4SKR2IoQci8SnXplryZd2cFeWzWlHbkJfUGPI7UbvEu4GhAD
 wRUp8CGCi0Hvg27mspbOpNvuSoptv8mwRWrcdXDu2C9MzRg/+Gys/HREihGtHTJ5okdMZFZxqus
 =
X-Gm-Gg: ASbGnctMxky8X1CTa0+GnapHz1kx8/kudOpzMxTT3N/0BjhUK7PHYW7bXbuIMQq2lKD
 QsAO0oqkgjqcRTbGtJpazBZGLuF308KZNNyg2I+IXJztdRHa94toWvbzcxXvwbGkI3XRjgjfLPB
 bys3zWM3NfSBwJ6c52g2QBnnrhT7iiuKiCEvUI65CByp84t2c80EYoZW8EPYsgvoogCEOX/u5fO
 gpwuHcBcUhIYAfQIJ6FfjXIrSWespRpDM5cmo6ae+GWqMSe3c9KVQhZdwo1pt5N3CyfXMNLOoQC
 badjIdKCE520mKZvmA==
X-Google-Smtp-Source: AGHT+IHLnNI6QY273uzecqf97rOJNDWDvQt2ovTUgGpzni8qi/RONQS4pyQ6Lk2al1XgvY6wrF+OoQ==
X-Received: by 2002:a05:6e02:1686:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3c2d277f709mr464392405ab.7.1736173979689; 
 Mon, 06 Jan 2025 06:32:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/33] serial: Support info() method in ns16550 xPL with UPL
Date: Mon,  6 Jan 2025 07:32:04 -0700
Message-Id: <20250106143229.3023771-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

UPL needs to pass the serial details onto the next stage, so adjust the
condition to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/serial/ns16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 3f6860f3916..5126cf8bc1a 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -473,7 +473,7 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	struct ns16550_plat *plat = com_port->plat;
 
 	/* save code size */
-	if (!not_xpl())
+	if (!not_xpl() && !CONFIG_IS_ENABLED(UPL_OUT))
 		return -ENOSYS;
 
 	info->type = SERIAL_CHIP_16550_COMPATIBLE;
-- 
2.34.1

