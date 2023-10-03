Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0637E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6A587228;
	Tue,  3 Oct 2023 08:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GullgI68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED5F871B9; Tue,  3 Oct 2023 08:29:52 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6AA871D2
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-503065c4b25so662978e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314590; x=1696919390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3wAw5LDOglxf9VQBepswseXzI3AUpshqMI4S0gYa5Y=;
 b=GullgI68xZdIzISOz/0YK5I0rXc3tw8C6rT/kvKGLd/qCj34A6KjCShiL+f9JXhBIe
 pM29YEOljwcJ4Cc4WSRh6xAGBQ+fKc6mHSzXnE6pogt09C6mYPwSALCyN9k/MFbVf4xa
 90+CZBdLgWHW6oPfxtTk4jMAZRKZPDZqi55on7AeDv9wB4Xa5wQHhlsEsHHVdoOPmZXp
 CxubAE5xAWJuWuYGYcsScOmgY05ziUrG+BaAYWjOELh9h1F/mBVVGbu5Fz528urZdSEb
 fFMBM0BjTzQxR5eMrqr6wHbZaQ2L9hAfkQarKepiaCdRO6rs6NSlskUU++1LFgUkTeSK
 5VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314590; x=1696919390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3wAw5LDOglxf9VQBepswseXzI3AUpshqMI4S0gYa5Y=;
 b=j3OQpM/gB1MZIuaVaxLCq1eWqUdCIBxuG/5PHNDO3XTrGgdlGKDZ01O3aAWHx8QR3G
 fcxrSJVH/dTMYffDHZHtT25tn1HjkfFqZtceyH/9OP6kpRdH+UkaM7sykBRXBZ86v1xP
 vMkUneo1WXaKrCp7qM1eobQP7MOzMjlr31h+3gofynQ7nL2o8eGRmMeUkoQRJAldby0k
 Q3V1LZUa/gaz1xa47enJkbQkVTnmC0OrCOFpAS3dRZMU4mgtLDRyk/tIP3B7d7SpCaJN
 /kmWYuPfiKos8vTvWjf4uNOy7fpbymQnnxhkuAz6Wj0VrTu6eWAtZb3eZ1sjJoE3TsQH
 JDgQ==
X-Gm-Message-State: AOJu0Ywz02ItDk6o+KynnzJoemAeETd9eYVOCxNScSmOzxjg7iOgxS+n
 cega5vfWQ7Gu6yh6EziITn5cFRdTg4c=
X-Google-Smtp-Source: AGHT+IHYOpfkFk+4iYlLzmdjLOw6dmyVBkwHzg9O+54+o2GHZ2Wu3ufHMFHPP5s5hnC129yLs3VzIw==
X-Received: by 2002:a05:6512:31d0:b0:503:186b:e0a8 with SMTP id
 j16-20020a05651231d000b00503186be0a8mr15313631lfe.60.1696314590164; 
 Mon, 02 Oct 2023 23:29:50 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 1/8] power: pmic: palmas: support TI TPS65913 PMIC
Date: Tue,  3 Oct 2023 09:29:34 +0300
Message-Id: <20231003062941.42501-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062941.42501-1-clamor95@gmail.com>
References: <20231003062941.42501-1-clamor95@gmail.com>
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

Existing PALMAS PMIC driver is fully compatible with TI TPS65913
PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
TF701T. TPS65913 shares same structure of regulators like TPS659038
so data can be reused.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/pmic/palmas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index eb83c88d56..b2e8a2930c 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -88,6 +88,7 @@ static struct dm_pmic_ops palmas_ops = {
 
 static const struct udevice_id palmas_ids[] = {
 	{ .compatible = "ti,tps659038", .data = TPS659038 },
+	{ .compatible = "ti,tps65913" , .data = TPS659038 },
 	{ .compatible = "ti,tps65917" , .data = TPS65917 },
 	{ }
 };
-- 
2.39.2

