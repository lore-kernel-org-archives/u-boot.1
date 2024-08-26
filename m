Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E3AC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8365388B9E;
	Mon, 26 Aug 2024 18:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iiuJQGnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C8888B5F; Mon, 26 Aug 2024 18:50:11 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB84988B05
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4503ccbc218so44206351cf.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691007; x=1725295807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3WbrfezvK8DjRqjjexWHQaLJeIKs5iHe5PznCN3V65c=;
 b=iiuJQGnfzAsHV+p3peS6w4bcr2W+bZJOxopux6KE3lOY9lMgU+uPNmJtDqYv1piXz1
 EtAS2wDO4c3CE9PS5zqRdLlQVgp/3D4nZozjjwhKML2kMl5Wn1KYa6/3mlKDQKeaoHya
 Exv1LVUdTCKCl/pQ1KQP3wuX0holkAG7HFGiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691007; x=1725295807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3WbrfezvK8DjRqjjexWHQaLJeIKs5iHe5PznCN3V65c=;
 b=qw4bahlcKncnP4vim2tXsmr2W9CYtsPTTiBSXE3RHy0f3nX5AbBij1YXgDV/2aBEOE
 FoXd139tzjJxTtryGg1i7NT78AqimXTPjQijLiseD/VPIKh0Fe/IBzhn23NiK/SanYUt
 1NuhtWe+Lgqt5y75LwsjK3K9JKZDKlvklP1BQgFAQ9fFFw+3NX6t2Q72rMB5ogP7Jp7W
 wf4L1oTQhCm5aq2k4rWb7YHN/ZDS9mhM1zanF1W94xq0ifACvuNgKbPf5CkG4i8JjB8Y
 dmiIRvl1UoBvJJfq2jeBmRkLTNsqwmQUcqwYGRQisGudvFRf0Zo21D62tT+HtMjo8GDe
 Cl4Q==
X-Gm-Message-State: AOJu0YzjY4IoOafV5tswcjRSFtE51+OhCnIdoVLfQPQKe+KQGlzd0G3Q
 cPfo1GNIuQ9tC+bR5hd1VJqvVnY0E4OUls+DOLT6XMTKoJlaHzixjp7Rhxi7Auz2mRfYUQ/srvu
 I
X-Google-Smtp-Source: AGHT+IGqtwClk4nw1L3CQwoxKI8ktRyUqdgg8uq+LY+6ehTzz9Q1a1iHtPYSg8Wjoue08UliyQzf0w==
X-Received: by 2002:a05:6214:2f90:b0:6c1:84ce:8f31 with SMTP id
 6a1803df08f44-6c32ad296c6mr6627836d6.0.1724691007450; 
 Mon, 26 Aug 2024 09:50:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/6] doc/mkeficapsule.1: Update homepage link
Date: Mon, 26 Aug 2024 10:49:55 -0600
Message-Id: <20240826164957.2789525-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826164957.2789525-1-trini@konsulko.com>
References: <20240826164957.2789525-1-trini@konsulko.com>
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

The project home page is no longer the old wiki, but
https://www.u-boot.org/

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/mkeficapsule.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index c3d0f21488ad..eaaba2cf2329 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -130,4 +130,4 @@ The directory in which all capsule files be placed
 Written by AKASHI Takahiro <takahiro.akashi@linaro.org>
 
 .SH HOMEPAGE
-http://www.denx.de/wiki/U-Boot/WebHome
+http://www.u-boot.org/
-- 
2.34.1

