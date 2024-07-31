Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05FEC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D1088A95;
	Wed, 31 Jul 2024 23:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="GgGKB7ug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C6188A35; Wed, 31 Jul 2024 15:43:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5E488A44
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso2777522f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722433419; x=1723038219;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6SJc/RkCx+Qh4F3UdjfV7x5j0idtMwby+oFCYIxoaU=;
 b=GgGKB7ug4coJJHT0/MvXr8+4lzRtbjbjadX4qeYtkM/NXvQHyvjgpSztrskVhmPdEi
 hZYTL9vDUeSrTgd16dsq2G5qFA9Y8xOO1b5sOsD7nibZFrvVwv1jZJTAyXCJtMNQtsse
 Ih1CNZbsdH3Tt8JYVQCsViJPAbMXX19oxVRee7lyEbceCcsu5YNyO1eS5rVIE2oPlTje
 vwFmmSPThq7hJ7eg3Jvy+6D5oibeiQseevtu8n6IkgmIsNqUEJ2s5uTghjownZzmFJri
 zA3/MBh4DQjok3CXHI1PsF/jTlqk3JZH4SNWtZoZW6aq+op8f2JCl/v6RWnKraofTeUQ
 uUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722433419; x=1723038219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6SJc/RkCx+Qh4F3UdjfV7x5j0idtMwby+oFCYIxoaU=;
 b=jFiufuCVwXb6qpG8nq99yVf+3lEN0UrBm9fbHerl7TPMH8QzDo3n/Fq346XyFjDqlX
 O3qmFCgSqaIzTyiG2qeG30N4ROhD0JHW+OzA58E21h9ToFOYHERGszxf4YJjULgp9EXa
 iG+RjJAy/tfZ33yXuZW8IAS4+ymxU+DFybTd4FJpRGm1TsESHJ/u9DnBXK+UWQGU3+w3
 qUdByaWbKchC7vblh1U0dpxGYJbXe9HpTgPg7xgW/kn/q3NeMkcYwQjwXpmiPULgSzoe
 LbNRgegwV4nlAgyzJ2pZ/WFAiYJk105a/bs6WP4enLwUvoCulU4jiNmwBsUKQ7YvVw+h
 h1oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPCf/B0NIFoIyWpPI431fax1Oi0UAywrAsG6x8wYshf3V0DmhS34fYqlJoGRfDcj0t6CB+AzGPjNgIKQ9pD6Z4BR/Rjg==
X-Gm-Message-State: AOJu0YzRcAX3QC43+1Ms2N8XpOV+3bE2/EKmWcQ+ks1xCs2MI8hUEiCr
 2key6/8lDtLIkTMTDLZYigkXAZEXi//WEqC1+cBGfnXAVqw2R1/AU3vA6l6jlj4yU4UJEaqaGnQ
 ACHniBg==
X-Google-Smtp-Source: AGHT+IHQ4eYPDkT6o0kkXeHsNyWMW+ofxTzHOhDrfuJA0q01Oo9SBiNjMD/B+EhiCqKzjhdC8Z1I3Q==
X-Received: by 2002:adf:fc8f:0:b0:368:3ef6:f049 with SMTP id
 ffacd0b85a97d-36b5cee2e36mr8339975f8f.2.1722433418615; 
 Wed, 31 Jul 2024 06:43:38 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm17063739f8f.93.2024.07.31.06.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 06:43:37 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [RFC PATCH 2/4] dm: core: Show device sequence instead in
 dm_dump_tree()
Date: Wed, 31 Jul 2024 15:42:17 +0200
Message-ID: <20240731134257.686017-3-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731134257.686017-1-admin@hifiphile.com>
References: <20240731134257.686017-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Jul 2024 23:11:08 +0200
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

Currently uclass index is shown in DM tree dump which ignores alias
sequence numbering. The result could be confusing since these 2 numbers
could be different. Show device sequence number instead.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/core/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 5ec30d5b3c..c812d87fa4 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -40,7 +40,7 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
 	/* print the first 20 characters to not break the tree-format. */
 	printf(CONFIG_IS_ENABLED(USE_TINY_PRINTF) ? " %s  %d  [ %c ]   %s  " :
 	       " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass->uc_drv->name,
-	       dev_get_uclass_index(dev, NULL),
+	       dev->seq_,
 	       flags & DM_FLAG_ACTIVATED ? '+' : ' ', dev->driver->name);
 
 	for (i = depth; i >= 0; i--) {
-- 
2.45.2

