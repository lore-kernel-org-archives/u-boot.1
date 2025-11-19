Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C748DCF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDF883FA4;
	Wed, 19 Nov 2025 15:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JBowkdc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB0D683FB2; Wed, 19 Nov 2025 15:55:28 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D962683F72
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450252e3bceso1546388b6e.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564125; x=1764168925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nBONmvLsceTcC0zDU81uQA63tFmSVsCpBaGJ2oKsdo8=;
 b=JBowkdc+3AiRLQ+3tnEQXNl8S42lMadKxQey6II6TdTci2QpUqP62zBTFFg7HR0jHV
 PZWUHbOhnNvYUCs8BYChlMjhZix5HQvGIZYs2++8tKN8bFLUpbbjQuOTGfYsiaVEnKAr
 rW5qnFc9a439eRe2kbqyEJ7098DqhCdp23Eiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564125; x=1764168925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBONmvLsceTcC0zDU81uQA63tFmSVsCpBaGJ2oKsdo8=;
 b=ms3ImWerIeDr1KUqS7pp3hHbV/01V3JiJLkc7dONdWvwyabe0U5/Y+U7PmabtKM3Ha
 GptddrWyb61kvRMNwjSAxGn5ZC7Im0JVNOTqeLWfydhsJpzktSbWTdjerPc2jZllYDrh
 nSoc1ZRgPiYvl5DnE0lHk1RM2smCklhm5UaCPZ0Zvov6wQO5xOizogUsACe1qDrpoGJl
 i6JoCBPStzF7/qE92iH2/fytLS9QjKpVzshrrOLmSeX3+Yx+461yRhZ2wQtiaCkTpYra
 Eim7f50vuxPLjy42G7jk5WbOy2KCDCOkqQnk/gLQCXeYVRrNlMJxNc1811VOp5uWnIv1
 17cA==
X-Gm-Message-State: AOJu0YzHH50xHPyDfMZGKxKNe0/7LRKH59+3raP1+Hu5n5m4OxVcQLWf
 +cgo9op4HSC21c5ZDUat2hMPNBRpBLahGGVRi+ro8vHxgr+usPQolTYHM0cP8RedQVztwjmFIWh
 xjEGOOya8Cg==
X-Gm-Gg: ASbGncu0tnwgDjVN2Z8HBsdKfdtLEp3BTzxI2+EmArFsspFIWdWqhhH3mpZI7nfwetk
 UzosKsSiWChkAFwdxXDU9j8jYy9K4gglBO5NdGL96L/O6dJqL/1qh+PUBxYfPb8K/OAsx61RBpu
 yIxkv7Qdps6yX8uLLbQddd+/MYm9hlQrgk+Pa4PCVt31sdv1wBt3yfIiaRjkRbe+YSBNeKjrgUs
 yspxlGs4rjjHjItRyI5tdRMgOlxjIlK3TX6iDkfDtxmv4wlzT9zIQBbrIFb2bTDOO/6G3u56149
 wccytnC1hVrpd7ODrK6s+qvUlvxuvDiFCdJLPBbzBBw4tSQDhljCeQ1/PbP1mE5nBHy/AbBDMMu
 OOlMRYvCNQ+QsLn0qimf2tcggHB3/xFAkuD9hF2PQfNw1Qt7RgKaP3M6ht5qyBELtYji1pA9aPo
 jeDecp7n/XykHHRFpy4/s5kNwNDtvwRP3eZEV4ogY6oQVH0XoHjOo1
X-Google-Smtp-Source: AGHT+IG0kacNAmF+rCf29sDYsWCrmx1WhHjUbx9q1FdrPKSMglbEG4nSaIzubhr9wz4utenhzJCaJQ==
X-Received: by 2002:a05:6808:5294:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-450974328f0mr8427509b6e.22.1763564125600; 
 Wed, 19 Nov 2025 06:55:25 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450a5f5e1a9sm4048127b6e.12.2025.11.19.06.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Subject: [PATCH] dragonboard820c: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:23 -0600
Message-ID: <20251119145523.843230-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
---
 include/configs/dragonboard820c.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/dragonboard820c.h b/include/configs/dragonboard820c.h
index c6d9182ccc9d..8e408d8aec3e 100644
--- a/include/configs/dragonboard820c.h
+++ b/include/configs/dragonboard820c.h
@@ -27,7 +27,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"loadaddr=0x95000000\0" \
-	"fdt_high=0xffffffffffffffff\0" \
 	"initrd_high=0xffffffffffffffff\0" \
 	"linux_image=uImage\0" \
 	"kernel_addr_r=0x95000000\0"\
-- 
2.43.0

