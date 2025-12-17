Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92934D6406C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 02:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A6983979;
	Wed, 17 Dec 2025 03:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RHp6uqOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B842839FA; Wed, 17 Dec 2025 01:57:05 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC8B8334F
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 01:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3f13043e2fdso1714413fac.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765933021; x=1766537821;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RYOAx8epyQCkgLkhD3A+dng80qt7YCOjqiIz0IehK1M=;
 b=RHp6uqOH7dEItLiJzn+qdHpJodSGHJCFn0ET6XR+B9/W+pPCbkgc0rDuiyno3RZrHf
 FbSkapk5oyWmlhoaLmtxfakCPtgahmUohXByb+8F9oN/xGq8lfAU42w24IVofCiX8omF
 aIgNetBeIphAgm6qFvZ0Z5AroTwOizeJ9uvy4NSRC3fgjS9uQtBiyaPWueKlneQWrzna
 f2GvHFpPt57S5apTHv+a3E/UrHP4Ptdtt3DYrLVnMq6lGOgI10I9rSqd4vvCmMVbnuZ6
 HZpxGOQ8ne4VvuU4FB1LrED9JLYv8Fgnl9ugHyd+2HazGbseO3fUOiLOhBcWkMdgp2Dx
 wlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765933021; x=1766537821;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYOAx8epyQCkgLkhD3A+dng80qt7YCOjqiIz0IehK1M=;
 b=dpXhWfc4PdV8l7sNSI7lrmlQ3NRh+DZylx9TirmajIM8T1w0LwKbwvBXoiaH7TG/tX
 zdUQkO1Sg3PPTEr0eypOjr6FGTwrEYFgrf1Ezm3Okz1yPeOoY+su21Nx4itpzB15WsF+
 rx4SNI3xQIdFCeiFUczlrtfg7/9P348upqlqw1zCkxlUiOh7oErXBTgLy1PzVjvWl85i
 loArBcAtnH4PzF6ln+ZqWBnGVxctn59R/U4DcsYD3o6+mX6xA/14VgX8Peatg1mvLwcL
 7h/nCQHKLylzxea1l8HspbCPhQXoz/a1Jk5EBiBsPno697p//HwTvkVf/DGX06Zsd2GO
 Atog==
X-Gm-Message-State: AOJu0Yx9SfkGazK8zyPQHBSEMgQyY+qWnMitnywPiA/RSXAWRt6zFhWx
 cnjyZv4tY9AiWzKm+XYTovqxE6yw53ROpDHR2XQuQcQISeOAYQcgjNWLFHirjDQC4bs=
X-Gm-Gg: AY/fxX4w5PQZ0Nwh7mmNMZPhDbFLRG6JCHtYntpYwFXGFu7LS7dbXKBi+HTDwJRrKZk
 cuh3pz/JQC92eSz1q5PRYmt7rFAzMW+srY1jji9Lcs/cTbLRIqi4o+v2mE6vzcXxXZpInlLWKzy
 bMsY8aOxFGxpD3+17KCFFJDhQa3hoK9jaZ5ocVqnEg+Smn6sPuDXDPcCi/H3NtBa6llY7zx7roW
 WbFEX7saB4was+VW5AXb39o555enRmnqvG9vHxGs8zaUAL0T5dL9ckPtCdepNJoWtVYqxuHj6n+
 SMMkxcLdoUk8L/G2sPm4OW4Zmh3iFuYi6zNBfEpSJ3cxrizfmYxT+Jz1NhCV5rVL7DiM5w7R8m5
 Hz9qhDikaE0/UKyaqopzVbxdAd0QL3p4l/DApWszIo+6Mqc5vBLylR1rVPFB/bEzmfL+WwXwyYq
 0cxM3K7YfcMmz1+w==
X-Google-Smtp-Source: AGHT+IGFDyjU1WiySsrXRT+sTXXb4if+pMdm7sHlppx5lKiIAplocoY5X9rBjwKo7C8O4bnajN/eCQ==
X-Received: by 2002:a05:6820:820:b0:65b:3376:a89c with SMTP id
 006d021491bc7-65b4520c4b4mr7997225eaf.67.1765933021360; 
 Tue, 16 Dec 2025 16:57:01 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:11a:676d:852f:9349])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b35f2b1e5sm10490709eaf.3.2025.12.16.16.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 16:57:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Dec 2025 18:56:35 -0600
Subject: [PATCH] pwm: aspeed: replace %pe in dev_err()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-pwm-aspeed-no-printf-pe-v1-1-fd7d1ca726b2@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgO2oqBXEYdYU81gDa2oIN7d4
 viG/x9IHIUT9MUDkU9JsocMUxbgVgoLo8zZYCvbGGta1GtDSso8Y9hRo4TDozJOxhN5qt3UOci
 1RvZy/+dhfN8P717U8mkAAAA=
X-Change-ID: 20251216-pwm-aspeed-no-printf-pe-b1faafa3cb9c
To: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=dhKBIO52ZtYp3WUaXiT7BljNYAzn0JKCdG1cVYfYoyo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpQf/UGAP4L/H9Ae/wWzx/n6oH/PcPKbv5Yl35B
 2bocYoTglOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUH/1BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1m8H/i3p45OSft3CLtkdEJ/ys5C1+l2Bb4ESD0aBKV2
 67KHMeYTsz9R8SEMYTHOAJZ+zwAVqDzJYLq8aqFwct2Phfc4WNUYHTBW9MWYB8MaXiQPymUZzBV
 iMBDLCT5tuCuY575gNS6t+pG79aYp1yZq1ZAl5wwJdHSkqa1/9cPaf5S5vmsgpwOEy1B3aGFgX6
 9g5KRghSr6c9sckI57T5sgVlmdQFQhettzZeCba3eO/qGUmWtuN9FLLUKPzqCJ6HRPtQKy+DbFA
 NiFSfvi8MeWMZggnZ+w+Z8fivPj/RT+FOxzQAk6tlCOxF+5h9W360eqtoRUwBaE3Po8EyvOHz/x
 RfsA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 17 Dec 2025 03:37:40 +0100
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

Replace %pe with %d and adjust the argument accordingly in a dev_err()
call in the pwm-aspeed driver. U-boot doesn't support the %pe format
specifier. Likely it was copied from Linux.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-aspeed.c b/drivers/pwm/pwm-aspeed.c
index eefe018448f..74e79686dfc 100644
--- a/drivers/pwm/pwm-aspeed.c
+++ b/drivers/pwm/pwm-aspeed.c
@@ -211,8 +211,7 @@ static int aspeed_pwm_probe(struct udevice *dev)
 	}
 	ret = reset_deassert(&priv->reset);
 	if (ret) {
-		dev_err(dev, "cannot deassert reset control: %pe\n",
-			ERR_PTR(ret));
+		dev_err(dev, "cannot deassert reset control: %d\n", ret);
 		return ret;
 	}
 

---
base-commit: a333d9e59f6675c9541c34643f334dbf50898647
change-id: 20251216-pwm-aspeed-no-printf-pe-b1faafa3cb9c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

