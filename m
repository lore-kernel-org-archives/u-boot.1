Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68574CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E5D84898;
	Tue, 19 May 2026 17:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LivHoEFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DBB84886; Tue, 19 May 2026 17:21:13 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A9384895
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbd23bc684so1975718a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779204070; x=1779808870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izw38Wg4K5JVLnI7OKZwi+V5+TWBNF3bPEqsASn+QGA=;
 b=LivHoEFZqeXSmZUeRAIEt7fnvfwcjJ8/qja2wNjXthfFrRGIRFNkh4dH+2zW1dSkhn
 SZ2RPhfr5ARdeuNofBLe26zPgCfQYtNLBYWjOcbrHHPbKHHQCS6VAESUwVugFN3+PXCu
 tdqBq6Wz1ZczC26vCYMEQi3K5d1mocV7gJJZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204070; x=1779808870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=izw38Wg4K5JVLnI7OKZwi+V5+TWBNF3bPEqsASn+QGA=;
 b=bf81qtR3crv+XAbN/TJ6TDfo/6eVnOw9mPWiQB0N1Sd7+K3wRXwzcpt0Uz7J6YIdiQ
 dWH0AjN16jkHB8cDRsxN759eszP40H7L7iwrEkpSZ18ceAJueEVLa2/0rSEFKa5rkB+w
 OXtX/ptU4VIyGP8cbDEVH+e9SUTEJib8pHJ2fCefduYzx9fIcOAk947zTpVzF/ch53G/
 NVYPm0P4ejppnmlUOOe+Sk3jnL2Uqdvtgt5khryjy6Tw9FEMEn3aRXJWqQEHO90Jo9sP
 HWg/zGo32lo3T+6nZEHfp3sR28u6Zn8f5VVL4vE+O3pt6aHAiNS5gTXdjoJ7yVWBC4ZM
 omow==
X-Gm-Message-State: AOJu0YxicmlCf5dRl82ey82ecddXTdUZ+28n1QRccwQG6QcmftGSQxdI
 07isnYtliXC8hhITdQW0yCuGVl//hDJceKvt440sGr5CgbkIZSiK+C3JedaoyfhpyucrTujGf5+
 4dzdqDVtvq7lS
X-Gm-Gg: Acq92OHV/rWL2PxJk0ThnYQK8LKphj02mov3bdhjf3OSZNVwMR0ryJsynQL0SGprsiN
 sFrA4BcGV42Np4U5r39RZVNavOAAnInF/oQfM1WakVYwp+hliaTrOXb38yCI4xfgi+4wjVXeQNE
 GOiPVim2vM93cywkjAMpCAL7tYj5C3KzKT6KhtTjuqskoOxfEFYy5WLY7qUiLG703YIJfBS8XgH
 MbzKYeoAeGoRtn16dK7p2mwTprSyvhsTzC3ZXUBEqd1XlWhMwMP5qI9zkBQu3Xs0RY0RBw7dO4b
 I8TVzmU5f3lDGh2Ny2ecpBNq7bwFGATJEvbtdLGYCyi4kn2Cd7COAfuM/uuNb8EbUwXNSkOsrBl
 BUMMwFGtuzdwJSY0FBgBg+uNEn3ystrFUnu5g4IMZBH3lfJ09NtP64FlGC7omlIbVE1j+WZ1xU5
 6vIW908Cz0PS5L6qovjePpiLbDEjGalXK4/5htBElhVUgtrx7cig99RgefZxljwSNqaKbraP5k/
 d5Dsne1nr44Gk//QgF33YMCYWxBJuzLQsGIzEslXgb+gYf38d7mS1jRGcxzlGU+0/0CtB5pOng=
X-Received: by 2002:a05:6820:8183:b0:696:2cb1:a005 with SMTP id
 006d021491bc7-69c94317db1mr12837918eaf.25.1779204069919; 
 Tue, 19 May 2026 08:21:09 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7170167fac.16.2026.05.19.08.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:21:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 5/5] virtio: Drop empty bootdev_ops structure
Date: Tue, 19 May 2026 09:18:20 -0600
Message-ID: <20260519152101.716714-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519152101.716714-1-trini@konsulko.com>
References: <20260519152101.716714-1-trini@konsulko.com>
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

We don't need to provide an empty struct here now that the caller can
handle this being empty.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/virtio/virtio-uclass.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c36e9e9b3a77..a871a1439d40 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -400,9 +400,6 @@ UCLASS_DRIVER(virtio) = {
 	.per_device_auto	= sizeof(struct virtio_dev_priv),
 };
 
-struct bootdev_ops virtio_bootdev_ops = {
-};
-
 static const struct udevice_id virtio_bootdev_ids[] = {
 	{ .compatible = "u-boot,bootdev-virtio" },
 	{ }
@@ -411,7 +408,6 @@ static const struct udevice_id virtio_bootdev_ids[] = {
 U_BOOT_DRIVER(virtio_bootdev) = {
 	.name		= "virtio_bootdev",
 	.id		= UCLASS_BOOTDEV,
-	.ops		= &virtio_bootdev_ops,
 	.bind		= virtio_bootdev_bind,
 	.of_match	= virtio_bootdev_ids,
 };
-- 
2.43.0

