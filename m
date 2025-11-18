Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98461CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40ADE83EDE;
	Tue, 18 Nov 2025 19:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MQTP3/NB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7D983EDE; Tue, 18 Nov 2025 19:04:04 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333B983E69
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c75b829eb6so1900745a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489041; x=1764093841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MaBBvguzh/3Xu9A68dZW9BRwSzmbHrfohIM1l3ucmjQ=;
 b=MQTP3/NBr6jkcSyVkQ560PCqWayCsFdFXrBAqhUC6rZVgRzI4zoCNBZU1GXYiuIc0Y
 9HYavQdRFCyv44x7wveQ+zUl/xAGVg3I/GV2LkZrPzVxF/dQZSsYoZUHkFluxVSRitTE
 KLPOy50as74s4Un30iU34o937y+R366iXJ2jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489041; x=1764093841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaBBvguzh/3Xu9A68dZW9BRwSzmbHrfohIM1l3ucmjQ=;
 b=jgZ3zOhQW0uHrqQHQaKn3DmQsdGQ/AhqO09GIhP8m5EfZkHZnH+S4DTU+dXq7j9vLs
 m6q+9bqedwFS6pYomYOVG/vEdV7hLqCXlKvPVvrWG8uTKECqQpFuolPn4HY/c/0NNJy/
 lNpykWVKKXK879cwd5ZGp5AyWmJ2KFcGtveJpCSAONSYkBj3Nrb+GH1ffzY44xRMhbfp
 MvE4zl+/kJokQv5u3lC4zY+w6U00S4IbbSLjEEFAm21NVUNxtQXqhLadkt6r63yEvjyq
 6t0N7QG5Y7nXTd45HnWLONAH51WbpKIOCJji2/VU0/0wFAABNFhaN7XpPjzOyxLHy0RA
 S1eQ==
X-Gm-Message-State: AOJu0Yz5wg2cvb25wQ2dkhZVegXFxaJUXP3llcAi7stv9jWT7rW3KjNB
 J7IXzJXnj3qSWIElJtUI5x+DrnkR1ZTmXTbTcgyJnQhm5DQyp3dWc7vvPgzmTNXIAKlyHUWDZ2r
 EKNx55x6Z6g==
X-Gm-Gg: ASbGncs2mfDAPpdCfbU6NuTmtXQTDU65T5CP7kmCFJ/891h2OfhoevoLmF3mDeuS+eF
 J87RfxzFFgO8A+rI5CTUY+X14Ysd1iBjsPnnKZvsZQkYbG99ejKMm6GZ2MYolQKVV03T6h5Xr7j
 qn/lnjs8JYfQj7fLEPYVehRQm5MxFNdQTZn0yWD3tD1yTG0CtYZJjQVD9rD7pEdZhv2fEsMh5R9
 FnbRyB8qBu2M5UcwGR3RoZNSETljqFQKgO33EOKPIoSBldWtAUj0pu/Dkd/Y0pIzAhiR9VStSiD
 Sh1CmVG4LvMKfKSxVsFy1JjRP61lJHW4Ghvv6LRxy3/mmIlPLoT9XgctsjX59h+AWuwH1hDIUjJ
 JhvCVIK5bYgblBnoueWf1SHaguXMkZQOO70UKJUl0dcbpUzQSmNfkBguVmP9PIhrlNksRVWfHYI
 1DDJm4o9rmwBtxoXBKIdNbKeZn09RQCZLjk5xyChnDk72LKRvErxyI
X-Google-Smtp-Source: AGHT+IESQagEtRZYCJq9Ir5jw2rN/30SwAElzEubaDz/1B4C+fZNH4yM4NYITUm4bnGYEKvFCzHi0A==
X-Received: by 2002:a05:6830:6409:b0:7c5:2ddb:5fe4 with SMTP id
 46e09a7af769-7c74460aa84mr9547747a34.35.1763489040688; 
 Tue, 18 Nov 2025 10:04:00 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75610f638sm3410967a34.21.2025.11.18.10.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Simone CIANNI <simone.cianni@bticino.it>
Subject: [PATCH] imx6dl-mamoj: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:59 -0600
Message-ID: <20251118180359.591085-1-trini@konsulko.com>
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

Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Cc: Simone CIANNI <simone.cianni@bticino.it>
---
 include/configs/imx6dl-mamoj.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/imx6dl-mamoj.h b/include/configs/imx6dl-mamoj.h
index 8abb58b06918..1a48bf646b6b 100644
--- a/include/configs/imx6dl-mamoj.h
+++ b/include/configs/imx6dl-mamoj.h
@@ -24,7 +24,6 @@
 	"scriptaddr=0x14000000\0"	\
 	"fdt_addr_r=0x13000000\0"	\
 	"kernel_addr_r=0x10008000\0"	\
-	"fdt_high=0xffffffff\0"		\
 	"dfu_alt_info_spl=spl raw 0x2 0x400\0" \
 	"dfu_alt_info_uboot=u-boot raw 0x8a 0x11400\0" \
 	BOOTENV
-- 
2.43.0

