Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD71C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F061C80269;
	Mon,  3 Feb 2025 18:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L8byD9hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709D880214; Mon,  3 Feb 2025 18:43:20 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B03780562
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb7edfa42dso2571357b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604596; x=1739209396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DymTwXIsTWYTvNtruCsTqiWv7pt5/rSzmj0APQDMRGs=;
 b=L8byD9hnN6f+l8dueogWkYFP89EFMBrXgzk4gjSK59Io/MorBkO2LzVkEBzEnz9n8U
 3poSYgzRdsjPhFVyAVoMg3rMrvvboB/dUklnhG40Sig9JqJvAyMe9uZbNCQxBGYv7GXl
 weUwjozFZ79QzrEEQpr9cRfMRqOe2LBIC6RsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604596; x=1739209396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DymTwXIsTWYTvNtruCsTqiWv7pt5/rSzmj0APQDMRGs=;
 b=m/zAhA5BivGG6NaDw3eCLhJYYNTqxQmMUvOCha53VLCHivMQkT2gIU/Lna0QdJhD1v
 MenY1EMSotxWWYybKu/0BIibvZx9aUp6dc0J5wi/erAf/jR4Ji/cZVBmXFn1zwNTqzx4
 l7Nwq9+6dtfkxST9GRWw0aSNgwrT1VW6I93CD0dATukGHcqkzBRqaq1j3z/K049fDsUP
 UtTVQY71hzBFyQ4WAgSaQq+xSZl/J8hbIA1Q2JN75yGFPSv+CotFQgXR0prAw4foNZYO
 fWn59qqyq7wcAIY59M1tylSRR6HfGbS3AuHFDdgG+dmdz9zqqFY4/nIFyXmbdHLWpmdk
 6M2Q==
X-Gm-Message-State: AOJu0YzFHLBNHrLaZitHbODX1TujUNGSUU57j1sZ8OcnNMtj+BKkWpJp
 yA7n9W28bVVyKv/SsTUHd9OsLsxw5eQ03gJI3Msaf1499EV+9WA5/au64DVtJfrnJlwP3mvwpCY
 =
X-Gm-Gg: ASbGncsILeZON6nRg6B0cCaGcouDkuLmrj6CpHqCd4O+T89T+tikICQqsjU4kN3Jy3S
 RvTKUp64fywd34D50UN4mhgo57EiYdmqOlwVx8hA0J+UUC67AI4XDZ1AvhRV5KWDBUcp3xWk+pq
 VTKg3fsNYHX+4eSJrwRWmgcBrPHqHmFy3yWWreyYWvEh+kE3cuug9PKtIHMAcvvuYzKUU7HUedw
 XvEMyZ94fTikf6/0nPAOj6it0hxgtp6qtT+58d6AKClhpnHZks/dbUyBK3Upqj7OIeEJGPH/tds
 WykfblFeamb1ZfP6/XXsyhBYy+mjvTWzG712QzSMkABybHaftKPs
X-Google-Smtp-Source: AGHT+IHyDuDX9WA/kiRUgl9jp+y+89UcAMRKTJwmMpYJ+GjQsxS/tS/jBdJXKFrFoHsHaxkdTQOn9Q==
X-Received: by 2002:a05:6808:1c07:b0:3eb:71d7:246b with SMTP id
 5614622812f47-3f323b5f278mr16142816b6e.39.1738604595707; 
 Mon, 03 Feb 2025 09:43:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/32] video: Use a local mode_info struct in the EFI driver
Date: Mon,  3 Feb 2025 10:41:57 -0700
Message-ID: <20250203174245.1331464-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

There is no need to use the global struct provided by PCI. Declare a
local structure instead, so this can be used on ARM without including
support for PCI ROMs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/efi.c b/drivers/video/efi.c
index a7b6d47f9a1..94d4c93dac3 100644
--- a/drivers/video/efi.c
+++ b/drivers/video/efi.c
@@ -183,6 +183,7 @@ static int efi_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct vesa_state mode_info;
 	struct vesa_mode_info *vesa = &mode_info.vesa;
 	u64 fb;
 	int ret;
-- 
2.43.0

