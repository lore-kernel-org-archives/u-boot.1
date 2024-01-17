Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D217CC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5026D87BA0;
	Wed, 17 Jan 2024 18:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mnk1r+tH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F908879F7; Wed, 17 Jan 2024 18:17:28 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F0187B7F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so1186019366b.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511845; x=1706116645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=mnk1r+tHuGnGcA2dI/7rAf0ywTqhNuHLloR+NxoZyXJSy+SD5euKGC13Xfrj+SKOP0
 xVGU3iWkfefj0wG5m4zxqSGCWZ8ECiVklYya0iGg0YJHsL9PGgBrCJkM0F57DtGgG5IO
 +aa/vxExHZqVoV+knrt9Oqf+pAB/5geIJ7k132LNQH9jLfvTzm/Ri8W2be/8DAAtdFAK
 sdZFK9AAEZijyz79aUTOA/EW3NIOg5jf5JbiqEMDQXggA8VVqL9uiVoD56eTy/utQN2C
 lLzYJcZf1G6jLjfG7NUORT0jZJumQBiZXEutreVxxJuqRjhnnos11tvthMr4LA0WY4T7
 JaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511845; x=1706116645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=hwcafg4XP+dMe9hf1SMjI0EaloEecpVDBt+NS/mLlNQinpMdN3j6dBylw8qXfSJFD1
 9WEuZNtBeQLKxGj2UwKTlpYwwyzuMjqNRiRwt6uZwM5WKMY3OW1BH5HbWMQksYM/4lvm
 cCB1pJ6q9+SppGg5pNmG80rN+ojFJeef2XBEp8ptCbqZ/ClZtYBROePTBrbzdXxumH8Q
 nBw+uOmbNHWaXR7NtQjU0n4/vhmOGQAHTrxs9k9YJes/7MTfJoHaQzlObOnKq/ce5q2Z
 f1SLX358uYCrBE5qderegvN/MoUbDyIZM6suFy7wrlg8V4dMWr7UZQIhLg9PohnOw2aG
 H6FQ==
X-Gm-Message-State: AOJu0YzumV3+D9xO/IEkw9U8UVXRRJmjjx79xaKa2czxpn10lHZPWIKG
 W+RanmHvQESoWia0h7hLOxrbL+q7LL1UeEj0
X-Google-Smtp-Source: AGHT+IH1m5pXOatb0IZEONmPprh/jRpGmZx5UJZFpRxh+EfE4cdZJdsiR+7JMWtzS9tUuIAEy6ZZ/w==
X-Received: by 2002:a17:907:d311:b0:a2c:be06:5386 with SMTP id
 vg17-20020a170907d31100b00a2cbe065386mr5108484ejc.94.1705511845198; 
 Wed, 17 Jan 2024 09:17:25 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 05/13] video: tegra20: dc: add PLLD2 parent support
Date: Wed, 17 Jan 2024 19:16:50 +0200
Message-Id: <20240117171658.22324-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

T30+ SOC have second PLLD - PLLD2 which can be actively used by
DC and act as main DISP1/2 clock parent.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 0e94e665ef..56a23b3c97 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -304,6 +304,12 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY)
 		rate /= 2;
 
+#ifndef CONFIG_TEGRA20
+	/* PLLD2 obeys same rules as PLLD but it is present only on T30+ */
+	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY2)
+		rate /= 2;
+#endif
+
 	/*
 	 * HOST1X is init by default at 150MHz with PLLC as parent
 	 */
-- 
2.40.1

