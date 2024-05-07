Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E76C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F3588746;
	Tue,  7 May 2024 12:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="UNJtnyBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F405788754; Tue,  7 May 2024 12:04:38 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E695588744
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso654988866b.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715076276; x=1715681076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN8R3yFYxBl2uw5OglmUuCxQs3m7FqhK4SCJsxeCBUM=;
 b=UNJtnyBVpbTiZAAF1Mxa9VdK5o1mtCOxn1nl4igB9IsuaQ/pXH0GV5G28rbUvyZ6nP
 IVdsC50o6Co/A3J16D7x0IOxjYdiS7sE4d23tQf/JppRKjL3s+jZZh1WPcwNOGNlS0WE
 YKoxSXonIhqYvgF+eYWOKcYPMvw/ExJoebqj4TWwi5jkvtre5YS0uxDxJOdb5pG3Hc4U
 o6XRi768O5ynRodZ2NXWIBo9S5kKkrWvu3vHYFg2iNJvqASr+OzT1pOajhxEsVx9kYMi
 L//VJJLhWkJP3Laxmdr3sYhbRYm07NG2dKrHs8Z3sbrvjmk7XisMxzLI9Q0OBUSXmyy/
 hOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076276; x=1715681076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN8R3yFYxBl2uw5OglmUuCxQs3m7FqhK4SCJsxeCBUM=;
 b=fw9OROev16awVVM4S58Jk/xh4lpK+XHZJZHfQEN9XBALjauXQv8i9V0Q7252GlbSSR
 QgJ6rHAqetVJ54YeQ0JrROORbFXdtQLb3Qt60ojbxBCy+KWUlblPzMbZ89+Qr/tUQZj3
 9KklbIl5Bf3T1P4sAQG9o+IrIA/haV5W8Twuo/Tutwnme12VtGr2cyp94MCEKcJREeKO
 xMYdwCxiki0y4aMMM79qR8VyHvqkBcxxIBxrCINP4beqarBVpRJ5Ml4Q/y1UpUfAg61E
 Yqikf14I5ITwn1kVxcP4K+9cfX9Xbr61BcF//LogawwafmsAAYhw/53/LdRwN6qdxoYU
 3GPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4lUfNJUPqOX8cG88aYpvN1OCccOIK26km+TIpJnzQQQ4dqB/m6wzqGHnknJEJyljq5Q1+Fz3D6gO2vcq8KicCBTGu+w==
X-Gm-Message-State: AOJu0YzN/bbO0Tr1oO2sa47AQ2qhzag5ZTWDmp+IXWiONx3kpH5y7vvf
 sH7zcgdHwW19ObU7Wru/4fQfxyE7B3KxMhrYKPISfPAiTMwzUhbE42OIfCPNuQM=
X-Google-Smtp-Source: AGHT+IG5HOqvMcnofa+yr9M5SzTRG0BW3H0ko7D7eylygKbXHV6jm25QZ9ocWY8pVds3XUcZXr6JAA==
X-Received: by 2002:a17:907:7203:b0:a59:c31a:91be with SMTP id
 dr3-20020a170907720300b00a59c31a91bemr4391019ejc.16.1715076276313; 
 Tue, 07 May 2024 03:04:36 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-59.dynamic.amis.hr. [188.129.46.59])
 by smtp.googlemail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm2878350ejq.120.2024.05.07.03.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:04:35 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sjg@chromium.org, trini@konsulko.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [RFC PATCH 2/5] dm: core: introduce uclass_id_on_reset()
Date: Tue,  7 May 2024 12:03:50 +0200
Message-ID: <20240507100431.206670-3-robert.marko@sartura.hr>
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

Implement a helper to call .on_reset method for every device in a
certain uclass.

Intention is to use this helper for UCLASS_SPI_FLASH before board
reset to exit 4-byte adressing mode.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/core/uclass.c | 13 +++++++++++++
 include/dm/uclass.h   |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index e46d5717aa..bed5553d5e 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -831,6 +831,19 @@ int uclass_id_count(enum uclass_id id)
 	return count;
 }
 
+int uclass_id_on_reset(enum uclass_id id)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(id, dev, uc) {
+		if (dev->driver->on_reset)
+			return dev->driver->on_reset(dev);
+	}
+
+	return 0;
+}
+
 UCLASS_DRIVER(nop) = {
 	.id		= UCLASS_NOP,
 	.name		= "nop",
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index 456eef7f2f..57eb1b144f 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -454,6 +454,14 @@ int uclass_probe_all(enum uclass_id id);
  */
 int uclass_id_count(enum uclass_id id);
 
+/**
+ * uclass_id_on_reset() - call on_reset for devices of a given uclass ID
+ *
+ * @id: uclass ID to look up
+ * Return: 0 if OK, other -ve on error
+ */
+int uclass_id_on_reset(enum uclass_id id);
+
 /**
  * uclass_id_foreach_dev() - iterate through devices of a given uclass ID
  *
-- 
2.45.0

