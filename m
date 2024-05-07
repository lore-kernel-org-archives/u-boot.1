Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137F4C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F3B8875A;
	Tue,  7 May 2024 12:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="c+HXBARC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F9888744; Tue,  7 May 2024 12:04:39 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17EE8873A
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a934ad50so648681266b.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715076275; x=1715681075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEoYJCWC0+hvqMQyC2wNI8nJ6/kCzwwBeEaWdHGCqA0=;
 b=c+HXBARCx7oh5/ZlngcYddObbOcgoJYEGthm9/B4gLjb1EX/XzLpUercQa1viEebgN
 97t3Y9VTIIOG3FYy3KtoUsG7P4+dpz6uGOBsPybFO+6tpJvU+2PVuuo+zjZZzsbpRamX
 a+/ciyBPdJDhj3pnHn3F4B4f0aMHt40SSPcqOj6/zIgGJsgtFU+GETXmSSDSUpINLUh5
 DSec9wfbTw8k6+f2+BW1vku7ai1iDvoJJn1yTBfyYSFLKOJJlkGxe3UxNCtAsR0IZSlL
 QH8gNeSsrih7QLW0Y6NrzJdsVSZUOwAdfaBxJJtoVKEc3g7qZu7hk0p7j6tzxpcArMn7
 r2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076275; x=1715681075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEoYJCWC0+hvqMQyC2wNI8nJ6/kCzwwBeEaWdHGCqA0=;
 b=Q/KPBq7Kg7xE+gmYb1wenfojo1Zrcgkln3rqfIIl8doohNYHp4njmdx/GRv2Cs32CT
 YEpOw77452GCoXFm7z+Mp/hcf3DtwQip2JjnCNfGzEKcP/uDjthdXk7c8pe9dNRKja2z
 Q4WTpn0SzN28OZv7XH8ALPUKZJFyh3pXCHj/ZBIvJX0KlOA0FegeX4F8pNCNl/ZQySeO
 gjlCLwf7rp2ChQ9MJOGrHBKD1DXgN689KSbcytgvW19w285CVTkgJnXBRb01bbiOF/e3
 F02FQLEpg96dn3BBA62VzjMlUKqGbQlAIW8EIq5e74SWcL3KporWgGpDEdcoT5yx+7bo
 lSLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLdaTvSgU6RVx27yDRQBdS/z3JRYD1swk8sO5ObAm2Gu737pkYdJc297xa5mxxapGE0J1YBQUkA3GS3o0tB76FyQX0eA==
X-Gm-Message-State: AOJu0YxvSc7WnAouOVIZhOLHUlyqTXzYAgQxKzEuYg1uJSXVv1w3pQiy
 C2EMqGqxxDYo/tAReKs+SfPhc7cnLaBdkoYDLWkEktVFrh+WP2x9lWK1FodUDIc=
X-Google-Smtp-Source: AGHT+IHZPYBaRdntq2pVvSgz4rNGOO6kCWyJ17CajTnEfP8CfwO87d1zXhfILjajhCZEpxdLcpA2/g==
X-Received: by 2002:a17:907:7248:b0:a59:b784:ced4 with SMTP id
 ds8-20020a170907724800b00a59b784ced4mr6480013ejc.75.1715076275192; 
 Tue, 07 May 2024 03:04:35 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-59.dynamic.amis.hr. [188.129.46.59])
 by smtp.googlemail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm2878350ejq.120.2024.05.07.03.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:04:34 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sjg@chromium.org, trini@konsulko.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [RFC PATCH 1/5] dm: core: add on_reset method
Date: Tue,  7 May 2024 12:03:49 +0200
Message-ID: <20240507100431.206670-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507100431.206670-1-robert.marko@sartura.hr>
References: <20240507100431.206670-1-robert.marko@sartura.hr>
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

Currently, we dont have a specific method that is intented to be called
right before calling board reset.

Intention for this method is to be able to exit 4-byte adressing mode on
SPI-NOR devices before reset.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dm/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dm/device.h b/include/dm/device.h
index add67f9ec0..19713d958c 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -344,6 +344,7 @@ struct udevice_id {
  * @probe: Called to probe a device, i.e. activate it
  * @remove: Called to remove a device, i.e. de-activate it
  * @unbind: Called to unbind a device from its driver
+ * @on_reset: Called befora calling board reset
  * @of_to_plat: Called before probe to decode device tree data
  * @child_post_bind: Called after a new child has been bound
  * @child_pre_probe: Called before a child device is probed. The device has
@@ -379,6 +380,7 @@ struct driver {
 	int (*probe)(struct udevice *dev);
 	int (*remove)(struct udevice *dev);
 	int (*unbind)(struct udevice *dev);
+	int (*on_reset)(struct udevice *dev);
 	int (*of_to_plat)(struct udevice *dev);
 	int (*child_post_bind)(struct udevice *dev);
 	int (*child_pre_probe)(struct udevice *dev);
-- 
2.45.0

