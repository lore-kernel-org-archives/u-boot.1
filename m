Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9185D5C0C4
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4791783734;
	Tue, 16 Dec 2025 03:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZtjZXZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6574E8036B; Tue, 16 Dec 2025 03:48:20 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1808836A3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso6093375b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853296; x=1766458096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YU3EJeetq1rR7ysjlZAJVudTTyIxo21fs5oafyqCx+4=;
 b=kZtjZXZaaMt43TYGAKYN9rwgrrFSdNhepOolkoPfRt0Ky0bOkTKrXjMPDXp8aViVYN
 oVel0rO/w6cmUYi4j4eL4gs7fE5Zibc+/6hR9QEeBIeIMaiY3EBJyGenv6YhEum0xHpH
 AoxNxq/zsJFH7OHv3X2pozLps3qn3hAH326KEyq/k40j26P1JprX+xP3F4zfucjU++oy
 1txgOtuqH9NWJtbqj36z7qke5GXMzObl4xX2D6dsl/GOQi4NQVmBxKSc6eF71hl02Vc2
 p1ZmuD5Kmwe4+y26NFQXdutAksvFUGVsZCaT+xuG4OA3WuuOpZuhxuYKE3JljQa93TK7
 EUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853296; x=1766458096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YU3EJeetq1rR7ysjlZAJVudTTyIxo21fs5oafyqCx+4=;
 b=KDBKEiBXxdDfwfLLCpLunwiNHtO7G39vgUzOpiND0quhC34e+2N8/Tvv+UWYtjIlzM
 gTWI3pqnt/0dtFNNiI3tn0nTRnefzxgQuWzg+Ukh99hdLZ4UfvVJBvQpi6azDSJrQP6b
 lMhuIzJL9prl+DKPv+0jY1cA0V0LtmQBEzkErbBTZJu3AxLigz3FMxOAFWaMK5M7cAsJ
 jYGAaWNvtqFdSRpg8yppfM2Cx/0/AXDbCmjJIUjoV+kY/TSLT4olQZdQ1k3wKW4zdepp
 lR820NG2l0axwkO1LHCANBy+dD9Ap3F1kDY+xsTK2bD5BuSnZ0B7fTCwACxorMbqmVDA
 zgPQ==
X-Gm-Message-State: AOJu0Yz7LWeabMqEccvB3mJTu3qzTNLP96EMC84xtV9IRDT0vvKyHSoq
 hFaCEfhQeaUySRfRbObMfqJsZIsK9MFuLRFKSOF0mJY6YcQCbQAz6jDrt064/b1B
X-Gm-Gg: AY/fxX6E3nFyYa3/mtrpihQ8TzN6UeNcQweql8cgz6iDkoi5s6F4KmZg+AXXc3SjpVa
 CEAegCWUJnZlYDlpnq9xh+K0bSdozXveN6EbkSDmLbSzlqi+V72/LMoxm+ORY8WuABOJRivNaMA
 f3K9jdifHLXXrDzEwoEunJekSe2YEnmXKmwyDtH3o4sZN3CeRtAbIOwaYk2Z01o3Y99KB5fs0rw
 MqDySU/7DYV4XuhtnfElCr+bnAtYQYxZdfqRGg0o1gXdeQFAdXk46TtEj43bW1EWDFhN/c2HpLr
 HccNo8xT9dAD013bV6gC86i1FAeCvCMLa3+PzzK28MOqCxhGG6RNWG3UmST9v4fG9TC+gRWMqMf
 k9PWhyk0iU463XmWrAdA8JB7HiBlESgcYKud3kjtcr0c6S81NAH0BZWM/psZgm3P0Hs1Kma2vDX
 BQT+Wezqgy0xev5JYQHStxfQ==
X-Google-Smtp-Source: AGHT+IECTN/NImnnBvPxmQdu6h2zjSQ04mppQVMdYRVPHyvluLbXF3rRSK7E5mPAWXfRrWyXj8h1Jg==
X-Received: by 2002:a05:6a21:6da9:b0:352:4411:6785 with SMTP id
 adf61e73a8af0-369af8133d3mr12376723637.44.1765853296369; 
 Mon, 15 Dec 2025 18:48:16 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:48:16 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/6] gpio: sgpio: modify persist check condition
Date: Tue, 16 Dec 2025 10:47:28 +0800
Message-Id: <20251216024729.1031306-6-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
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

Modify the persist check condition to fix init error.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/gpio/npcm_sgpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/npcm_sgpio.c b/drivers/gpio/npcm_sgpio.c
index fcc42087d57..d0fad08be07 100644
--- a/drivers/gpio/npcm_sgpio.c
+++ b/drivers/gpio/npcm_sgpio.c
@@ -301,7 +301,7 @@ static bool is_gpio_persist(struct udevice *dev)
 	status = npcm_get_reset_status();
 
 	if (status & PORST)
-		return false;
+		return true;
 	if (status & CORST)
 		regmap_read(priv->rst_regmap, CORSTC, &val);
 	else if (status & WD0RST)
@@ -320,9 +320,9 @@ static bool is_gpio_persist(struct udevice *dev)
 		regmap_read(priv->rst_regmap, TIPRSTC, &val);
 
 	if (priv->siox_num == 1)
-		return (val && BIT(NPCM_SIOX2));
+		return !!(val & BIT(NPCM_SIOX2));
 	else
-		return (val && BIT(NPCM_SIOX1));
+		return !!(val & BIT(NPCM_SIOX1));
 }
 
 static const struct dm_gpio_ops npcm_sgpio_ops = {
@@ -363,7 +363,7 @@ static int npcm_sgpio_probe(struct udevice *dev)
 	uc_priv->gpio_count = priv->nin_sgpio + priv->nout_sgpio;
 	uc_priv->bank_name = dev->name;
 
-	if (is_gpio_persist(dev)) {
+	if (!is_gpio_persist(dev)) {
 		ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 			if (ofnode_read_bool(node, "persist-enable")) {
 				rc = ofnode_read_u32_array(node, "gpios", val, 2);
-- 
2.34.1

