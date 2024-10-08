Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4ACCED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941C388E14;
	Tue,  8 Oct 2024 09:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="HeLBtb8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E7688DF4; Tue,  8 Oct 2024 09:54:46 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9E488E0A
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37cd3419937so3195244f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374082; x=1728978882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sy3pvkBHGqUUFaSoVrvan+Pqd6nrhkRANHJKprORedE=;
 b=HeLBtb8GLtQk2GDjyfCdYNnnOXwnA4nzTzBo9YmE+/PJ5Z5fMZdKJP3030DCGfr9Vk
 0cww3mxFohNp0iru/MzlTZO0NhUc5Q+m85xOJzijJ9x7Tyct3JYgA8/0fhpK/58Wagx1
 o9Vr/z3QtUd4Y+adlzTSrhJgzscQ6GGmi+Si0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374082; x=1728978882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sy3pvkBHGqUUFaSoVrvan+Pqd6nrhkRANHJKprORedE=;
 b=LCM/jkVKOfh7sLiERn/FZcEime3l2V4WTrdyvUtq1QyilYNQw3ZyXV2GyC6MRP5nJW
 xm5eTkohncYRUUkUMNNBOQYy/Isrkvh5/WHWQcOPkAlqlT9jiLYz5fIUDjq6TwdPy1F9
 DBP8xIskDBZFqYq6agIl0gF3dj/NRo9oasVbhlpGtOb3OY0tF9gtHBoXTQ+/564NmgCD
 qa1Oj/FpNMKXBODtJRCODHP6DYGqBW+UOIzq+SORi1ixjQ8mQpgc4JeqOODrWjFDcFdu
 RwJfF8AYLQl5uyEsulx+5SZPnvQIRMXEcvW3/DRy9g+N0b30zRgZBWRgtxz5PgaiB4yo
 +0sw==
X-Gm-Message-State: AOJu0YwH2cUsT0crXy9fvkuqhQKRVwYx/CLbY1p84aBr2wAPq+ZUrmuD
 GqJTvt1RYAbEusbVDzVJbC6oK/Dp8b7MgoZs1zbb528KBtzGdxsimFPOopms4cvnKGdb0X4bnRi
 p
X-Google-Smtp-Source: AGHT+IEbFh0l+Fhm9Ji7G8IQ9Qidye+Kpy27Djp3WOZT0djjkVunT4Gsj0thLF5V2adSjajoEjfwQQ==
X-Received: by 2002:a5d:4609:0:b0:37c:cd57:d91a with SMTP id
 ffacd0b85a97d-37d0e6dacf7mr7420209f8f.12.1728374082329; 
 Tue, 08 Oct 2024 00:54:42 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:42 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 3/9] net: ksz9477: add KSZ9896 switch support
Date: Tue,  8 Oct 2024 09:54:26 +0200
Message-ID: <20241008075435.1572727-4-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008075435.1572727-1-romain.naour@smile.fr>
References: <20241008075435.1572727-1-romain.naour@smile.fr>
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

Add support for the KSZ9896 6-port Gigabit Ethernet Switch to the
ksz9477 driver.

The KSZ9896 is similar to KSZ9897 but has only one configurable
MII/RMII/RGMII/GMII cpu port.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index e67012a071a..c8c6595d4a2 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -541,6 +541,9 @@ static int ksz_i2c_probe(struct udevice *dev)
 	case 0x00956700:
 		puts("KSZ9567R: ");
 		break;
+	case 0x00989600:
+		puts("KSZ9896C: ");
+		break;
 	case 0x00989700:
 		puts("KSZ9897S: ");
 		break;
@@ -576,6 +579,7 @@ static const struct udevice_id ksz_i2c_ids[] = {
 	{ .compatible = "microchip,ksz9477" },
 	{ .compatible = "microchip,ksz9567" },
 	{ .compatible = "microchip,ksz9893" },
+	{ .compatible = "microchip,ksz9896" },
 	{ }
 };
 
-- 
2.45.0

