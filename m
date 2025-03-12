Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C40DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4093481D42;
	Wed, 12 Mar 2025 19:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLNnxcf/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C87D8192A; Wed, 12 Mar 2025 19:15:41 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1C881782
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso36451366b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803339; x=1742408139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIImzHenkO7BVJr1rlYV6b8GcVt9dMTW4VoeoW7ytbc=;
 b=DLNnxcf/S75Fpli3OVBuvOjGzAxg63WIb6WnKnwhUj0BvPRXpkEEm3cmiIqe1PlP4Q
 WmaJneY94hTcQcIRkB2BpU36HwU9IdCs3RigMMeIdcYSjZg3jDMjHrpMqOERhAB+LnZ/
 yhgKXShTgZcKr9n4v5zB/5U7NQC/idoImqDsaz+pD0St1c7k58ra7p1RMo+sLwhEdB1q
 HurQWFJdiLFKCRxUE7HrOGVUNZwbRAfdUF6Py2vB8XZfKb/SXOfOVDd3WNRGKH2xyWZR
 adoCQwakCHtVrae4uwteDQ6JvC8xHwsI56X2EtK7c8inK7FnqK92sEV2Z+xlTJwLVjXz
 ImKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803339; x=1742408139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIImzHenkO7BVJr1rlYV6b8GcVt9dMTW4VoeoW7ytbc=;
 b=l5Y3MIEfhRxYJ/oQvKSezbIkCrAziHiJQZEX+CvlSn6pXGjX4/HUObKY3B43E2tfZk
 D8W9Iqb8TiFisnlmBhy4gVNoRxA+fN4PL8ddYBj8ju8T4n5LTj22MhIBBdhp/H7HouM4
 QLdzz6OSW9rnMVSLwYZ918FMtbuluHF+ZUkxjnE+LKsfoePLLQdYYxNBibo4IalU/xAR
 6YMOz8xcsJdW7o0xikAmBKBgOxOlpKt50T8dTGsltY4a0mlrnqBe+62u/Tveuozegr4A
 odgZ97ISUCUxMRoO2FzHyBIZvxoMl5PpKLoT7vrz7F1tHJtPFWDPuX5Px3ben0d4MecD
 eemw==
X-Gm-Message-State: AOJu0YxV37npF3SmCZjF7+PGzJtvMAjOwmyjDSFQKLu2HqV3sElnis1A
 RnX3j9elJVzLSfYW8pDQLzind6Z/pFQqm+WBvDqhj8GWii6hXu6P
X-Gm-Gg: ASbGncuHWsG5uS652DIxclsIpMmf4CHP/3ALK5vUwOfcBZZuR/wTi4ZRbycXFYmUfge
 yUEfcmvShTyfYmM5DO2f5aPRO5MLntd+/yU/G08jT4FzUZ6+1bcPYEyjv07eU/u22frimxK0SO+
 eANhiCRbkkKj17zTTYO85imr4iVA4zWbp1UhYSvb0Gc3WGjESxaNl3hypCOyey9Hq/RVIuJ74Fx
 W0wRD+NDQvyFYVec/XJNoiKc91nNSoOa81wGbE6F3iVByX1uu7RI1uIxpmWNHsXnlcpk/qX7xs/
 CbC/NBnWP3YC1ZVHqpXGuVEwySViSG7ALcvL
X-Google-Smtp-Source: AGHT+IFwqkrhtgT5KBWtskx71dc21mZgio2DrhIgJulyOGHWoeEm4ZuUlHN7xXp7lmdCtn/zq7onWA==
X-Received: by 2002:a17:907:9452:b0:ab6:362b:a83a with SMTP id
 a640c23a62f3a-ac25274acf4mr2674383266b.8.1741803338927; 
 Wed, 12 Mar 2025 11:15:38 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 05/11] video: renesas-r61307: adjust compatible
Date: Wed, 12 Mar 2025 20:15:17 +0200
Message-ID: <20250312181523.121313-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
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

Vendor prefix of Hitachi should be "hit" to comply Linux
vendor prefix list.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r61307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index e3623d72635..8552c3dd959 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -295,7 +295,7 @@ static const struct panel_ops renesas_r61307_ops = {
 
 static const struct udevice_id renesas_r61307_ids[] = {
 	{ .compatible = "koe,tx13d100vm0eaa" },
-	{ .compatible = "hitachi,tx13d100vm0eaa" },
+	{ .compatible = "hit,tx13d100vm0eaa" },
 	{ }
 };
 
-- 
2.43.0

