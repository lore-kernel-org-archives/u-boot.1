Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA24C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 20:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8B187583;
	Tue,  7 Nov 2023 21:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k7UuSn9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C68875F3; Tue,  7 Nov 2023 21:13:54 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE9287581
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 21:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-581e9b8e5fbso32158eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 12:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699388030; x=1699992830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u3FOi0WQ7tsGBpa2e4v+2UAHTTyk9aqfahsjrUDgY2U=;
 b=k7UuSn9YOVNxnOqFaTndZTF/65PluEXn/5OGR2KVLsILFqTvFkqMzvFGXMVFA+4x0P
 +eN7tpAOXAvSG2LdFqUMFojKKNRSPEjE5ASvQyvlW1hlK7QLxvxNR8+eHTzIT5+aZiVe
 QdGrBAJNeo0Y6gb9fub94Fk4PW86Z8XS15rLM8zInzoDgHfqF3dgKdiCYLO2l2utHk02
 CHnN4uMvNBvcSvJYyjU77y28Szh38p9KoXUL6fjLa1qcTfJMbHmWl1PTv+Y7KsWIqs2/
 IY2jBPKa/06UiVhbR6UE3+sr3uJM/zWB2TE2Ne9RURFhFrR2xMkc4m9KtxXgR7ri3qTj
 FaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699388030; x=1699992830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3FOi0WQ7tsGBpa2e4v+2UAHTTyk9aqfahsjrUDgY2U=;
 b=B8j6bppOptPLfbeAZCbWQceDxQBB64LI+YL7NXLZ1hLYSI5Mb0u4HDd8aMEKYwPnI7
 vp75gnIgLevelVr9ewpHyQrkb5+K0BcighG3o+yzhs+7yWaTtIPYVeqieYoVdtJTjZ+t
 +qg7H7y5D6NQlMdycY31VsvappWXUzoxBCoSXs3Jvj2r6ufPFtcrzNLp2KRsGwTXZTW2
 sFUTQ8QBLb3Xu8N3YoYOu7J5dknRTOS/9gWopdYh2WNAsovRhQtYj0IVE9R64D90eyUY
 3S3lkpsJRp5UjJcM+iqPK+LSbad7VKuBY1lG9111Ee8E/0Tm379EcTzyg1SsnvRAWFA4
 CSbQ==
X-Gm-Message-State: AOJu0YzaUz0sdun4SqsSAiCzgBXtK5JPqbG9UK9YDUPRuEMWjbhdSZIE
 ICo/VMI1AEC4sJ8j5CP5KHfsRA==
X-Google-Smtp-Source: AGHT+IFxQCzLpTnKCopafy9CuexePMGKgMWTSDS9bATzv0EWWHa4YKW0QDwQUSchNhhVgosMI1HklQ==
X-Received: by 2002:a4a:df54:0:b0:581:d6a6:478a with SMTP id
 j20-20020a4adf54000000b00581d6a6478amr1581394oou.0.1699388030629; 
 Tue, 07 Nov 2023 12:13:50 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 v15-20020a4aad8f000000b005737ca61829sm570889oom.13.2023.11.07.12.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:13:50 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
Subject: [PATCH] serial: s5p: Use dev_read_addr_ptr() to get base address
Date: Tue,  7 Nov 2023 14:13:49 -0600
Message-Id: <20231107201349.5775-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

As the address read from device tree is being cast to a pointer, it's
better to use dev_read_addr_ptr() API for getting that address. The more
detailed explanation can be found in commit a12a73b66476 ("drivers: use
dev_read_addr_ptr when cast to pointer").

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/serial/serial_s5p.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index c24d9bca84c9..7d04dcff54fc 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -221,13 +221,11 @@ static int s5p_serial_of_to_plat(struct udevice *dev)
 {
 	struct s5p_serial_plat *plat = dev_get_plat(dev);
 	const ulong port_type = dev_get_driver_data(dev);
-	fdt_addr_t addr;
 
-	addr = dev_read_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
+	plat->reg = dev_read_addr_ptr(dev);
+	if (!plat->reg)
 		return -EINVAL;
 
-	plat->reg = (struct s5p_uart *)addr;
 	plat->reg_width = dev_read_u32_default(dev, "reg-io-width", 1);
 	plat->port_id = dev_read_u8_default(dev, "id", dev_seq(dev));
 
-- 
2.39.2

