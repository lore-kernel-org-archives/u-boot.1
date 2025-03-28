Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779A5C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7546C81273;
	Fri, 28 Mar 2025 14:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtQqV9ak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9DE82149; Fri, 28 Mar 2025 14:08:48 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8BA8219D
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b40a5120eso61495339f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167324; x=1743772124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEW5KFwxPTgg9S8AXpCDNBTBs8qIZhWI3UpCQ/si2Sw=;
 b=TtQqV9akez4stYY/FCKUAUELOiz/JA/5hyHdEQpxAmho+NIhtvfIPQjyLoZHpVldH4
 CSmdJTDapHPx4XESfSKgDDtfqAjHxtaXuXwf4Gd7ZC9TV+dy3b6RfYqVgkUwLAhPV2Kt
 jxA3MibsGcY0D0VU7hkiuhnHt36gHTA6p9CX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167324; x=1743772124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEW5KFwxPTgg9S8AXpCDNBTBs8qIZhWI3UpCQ/si2Sw=;
 b=BuBqK4nl97Ilq0yTeTl283FE2QE7uZtJxU8l+l2LLVyj6CpNm/0kZ/OUecW0dqAASW
 8jx8nlnU7/+MAkH+pswwMMd8vo0FpGcOSecX81/7TbLqIbqXxJQUC1jur8lfRFUWKZQh
 DUJ8e1rPlSWmr5ot07GDruX/E8+Tsnm3u7tu0ixrZ9mVxK1heClLwDUVQnDIAHQm2fpz
 hMIZQGWYWA5BDMjHwqCM1ie+xui88YyQD6S7L6Sc638WkmtfGdXgQriFeATY9pRV9Ho7
 E458ihM25ncHTc5S4fTDPYvt4YGelHH0PJrfJNzCcvO8QAuoGSOMEID75hCGQqdxCye/
 9DAQ==
X-Gm-Message-State: AOJu0YzSVVFhKOVMQhGsKHp3EylTTkoY/dnpQTITXKMn9EBpH1w0zE+0
 P9wYZGdQy+QKgZ0c1+bd0xQ6pMxDZwlB9vC2B+rtqpj1q7ZwZWK90Tq7cld9cJmrMocHWv4OTE0
 =
X-Gm-Gg: ASbGncvBrz0n7WQU+sfVgcgQxJELRzyUklMoMayJ7BfJgg/lTvERqcftNLhM07VUEMN
 gtmaWwV2JlO2+e4ZhNKM0F5HTtLIiPJHHdxbEa2Y0Eh7ySMcjL2c80u+D6sT8XhhjE0UbBwm1iJ
 GUElYzOfSoWaDlojcothrYTUDUDKkK+WXNNH+rOoTXSfnBpRshy2W46s2iP1/if8nEJ4TvxbtFh
 tEcg1Fsa4lMhf2GiEWNuinHj8z0/Tmp0tnNTRWpFea5mpH4OvVzQFO0HMXS9CR85CVZSamrM5G/
 BRSiIEv96HE5c1v9t3BwXovlW95qgdlXjsaEkesFgWts9NTwuCya3SdhbP3XJu57LJDmMc7NnN8
 FEZvbow==
X-Google-Smtp-Source: AGHT+IFxT4uxlYrDRmF+JUJj+tQslOId7sIqKQRwl/6Je1eLPjpMpHn2q22RamZaxlQ5BdHJcO4dUg==
X-Received: by 2002:a05:6602:408c:b0:85e:181e:1bd3 with SMTP id
 ca18e2360f4ac-85e8203bbf1mr959597739f.1.1743167323983; 
 Fri, 28 Mar 2025 06:08:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 45/56] expo: Use a simpler name for USB media
Date: Fri, 28 Mar 2025 07:06:32 -0600
Message-ID: <20250328130713.2612648-46-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

For USB devices we use the string 'usb_mass_storage' which is a bit
verbose. Use 'USB' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index cadffcf259a..986334e95e2 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -84,7 +84,9 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 {
 	struct menu_priv *priv = exp->priv;
 	char str[2], *label, *key;
+	struct udevice *media;
 	struct scene *scn;
+	const char *name;
 	uint preview_id;
 	uint scene_id;
 	bool add_gap;
@@ -101,7 +103,14 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 	key = strdup(str);
 	if (!key)
 		return log_msg_ret("key", -ENOMEM);
-	label = strdup(dev_get_parent(bflow->dev)->name);
+
+	media = dev_get_parent(bflow->dev);
+	if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
+		name = "usb";
+	else
+		name = media->name;
+	label = strdup(name);
+
 	if (!label) {
 		free(key);
 		return log_msg_ret("nam", -ENOMEM);
-- 
2.43.0

