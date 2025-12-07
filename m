Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C855D1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 14:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55FF183993;
	Sun,  7 Dec 2025 15:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="idVxLOe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9CC8399B; Sun,  7 Dec 2025 15:50:33 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D4483990
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 15:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4531eb3964eso1017508b6e.1
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765119030; x=1765723830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mf9S/1Ovc8zIFWqeBj6pQdM5tKAsQMW8GfAFCOMCpQs=;
 b=idVxLOe8R2esmc+f31ED0DhhKtf2Gyge2obX9+hhFhlvsblHhhFMUs8lcwklUzQqT/
 bvyDkh5F1GG/NkY3hF3SeGvgUuk7wqAHgEVz62gBCWWzcv5RGDtvvszujs4RaPdbzQIk
 wl2oJnc67YytudUGIyjTPwyNXN5PEMgpH/9eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765119030; x=1765723830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mf9S/1Ovc8zIFWqeBj6pQdM5tKAsQMW8GfAFCOMCpQs=;
 b=rO5eYXuptHgv4ZGH1U7nkLvlUPt6qj+RxwRm/OT67TT689wyGLU+C4j2vUoeqAUlJ0
 Bvt8f07tydyo8CGvznGcJ5CO9P6FCmZ5nr0W4O6a3m917qzPZsuAGTqEMfp8Kb5XORk7
 l1u55wKOxyLfc7FBcDcwxv//przBS1NC9NP5yZX8A3K1Db2QOXg72K9RYRrJNk900blF
 ABrQjcp1wuo7vb6hcQYrQeCcp2CDW/8K7fJRg6OdSCdI/0BRYAYnfECpzGhGwd9xWDxb
 XJU5YunTyAnkb3OmaBZu6nT5Izmr5ZpbatoDJ431Omg2f7eJqQRiYuUA10Yc5VfrmTfL
 aUNg==
X-Gm-Message-State: AOJu0Yzqh5cqNPRDJk0CbXtuW8lNekBPm7jmMTnQWepqNckdL5ReWY4y
 J3z+egCeVAU1QZACxDt/elnYJlSqQm0Kj/O88B5i0uTFEwGr3SZaZYbabTzL5wv1sfnwb9sb1Ts
 E20dyCW0=
X-Gm-Gg: ASbGncs2DNE2fizq8bXbrQTmTqTitk/KtQo7DnzIjnFuSUFh2u6MYe1puzvdolpbKTL
 /z4/MKMF+A7qchY2Gj11xHNAuJaXc8xGQx3pFJcfsNP7qo/UO9m1Q8t2I/JTJpLgsdTZPNI3M5V
 hGoi91G3CgKb8f2VHwjH47v0+inKZCw0kAqSu67C/+0FvoychHA4qEJ9ItA7W6IyW33GXTL6o/j
 +PlY69aqSBxU4BtA/SB6OSrXisEcQWQWWGIzP+WGj8NHX/GU/CDEZyqwr7FELJDsUKx0LBF2vNv
 M+z15fipYgMTuNmhQUd3zbqZeYFE/YmD8N93TPKD9k3J2hadFzvZ3U4Rr8un2d+CyBJYWoTBtUg
 sQhJ1Tx9mbQYUR+WDIDZS07HTiU9iojaodObUWcz4P6msA5wu/y3nl47dQReCic9hRJvDy/CjTN
 9+7ZpyUDs6ODo3MITMxMqXQME73liv0h+i2fdn/6WqDEkI3/wSqLOrS5if4u1QVx8=
X-Google-Smtp-Source: AGHT+IGdeW0pq2eZR2erp04NKqSlDd0NWbh1BocLjX/yl7+ePjwuOU+q/ymgir4xyywkK7wK07aMXg==
X-Received: by 2002:a05:6808:138d:b0:450:d7b1:4fb5 with SMTP id
 5614622812f47-4539dede186mr2231483b6e.12.1765119029912; 
 Sun, 07 Dec 2025 06:50:29 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8fa21asm8874939a34.1.2025.12.07.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 06:50:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Derald Woods <woods.technical@gmail.com>
Subject: [PATCH] omap3_evm: Take over maintainership
Date: Sun,  7 Dec 2025 08:50:28 -0600
Message-ID: <20251207145028.2902758-1-trini@konsulko.com>
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

After talking with Derald, take over the maintainership role for this
platform.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Thanks for your time and contributions over the years!

Cc: Derald Woods <woods.technical@gmail.com>
---
 board/ti/omap3evm/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/omap3evm/MAINTAINERS b/board/ti/omap3evm/MAINTAINERS
index fb4268b312fa..491ab4fbed7f 100644
--- a/board/ti/omap3evm/MAINTAINERS
+++ b/board/ti/omap3evm/MAINTAINERS
@@ -1,5 +1,5 @@
 EVM BOARD
-M:	Derald D. Woods <woods.technical@gmail.com>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/omap3evm/
 F:	include/configs/omap3_evm.h
-- 
2.43.0

