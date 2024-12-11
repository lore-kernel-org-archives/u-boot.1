Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC93E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686F7803D0;
	Wed, 11 Dec 2024 19:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g6oOQd1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204FB8022E; Wed, 11 Dec 2024 14:53:44 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D4C80209
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434f3d934fcso23957445e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733925221; x=1734530021;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t+Xwn1L/UKaex6dxOb+LW5T3XGyB4TCi4WT2GmBn7xk=;
 b=g6oOQd1Q0uxuprh9/FNfcIVEO7Ygpc3fyHXhVvuE6EmKbK7peQ9DYbiUKPt6BoOls3
 5Kl5EkbwTqgBCo74jFOkfQ7DZIPTIlI1BFA5vieYpmyAmWuasnmXKvodYHcbK3RyAflI
 GJIT1MVmF/ksN8z+Ly6DKQ6081bjoUm50LsEFx92OHJC1pTstr1MI8PLD5/VStUn74Ee
 V7jr6gy9UB3NF8ZRetG8lgp97goJjmATaehV4ptKilW2yUJqST2SJU26V/iQkzwNq83L
 zprZvIlbW/813rx9s/iGcCmdnybmP9wpuH18FbJHNLSTKVA1MsZLW+bz7T1Xn0faTzxL
 gZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925221; x=1734530021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+Xwn1L/UKaex6dxOb+LW5T3XGyB4TCi4WT2GmBn7xk=;
 b=XVdTQj7yDNJ91kWU4qc0Gc8yVO0vkXFMjONCzPdKPyUOFkrmbvJL4UBOknCVbSNnDT
 2LE7U2a98WA/KVeyKSw1zu3gGOLTpNDMvNfsGVZk+vdHfW6YeVaVoIe6uLJAfpJVnfvu
 pOyNRpUodti3jMjdb6bqNnq2MQN4gmL6/8VBofd6LWLh6ZFPLNdAHXJNBt+juQbrrVd6
 fx4F/1IhJoCNVUuAd3O1nkbiwdDfpsdm9sPlEWebi3oV1mXqcb6X5jP/d57RCeJwTEIa
 tyk5on59M7TdTNowSbPMYSkaMBMU+dp6fgHumgsmubhCkQ3KSpJfAnWG8uCj/okn06PW
 jh4Q==
X-Gm-Message-State: AOJu0YzTtoALgAYxF/9mPpGl7telffC3AZWKneTfsqWANVxxuiKz0azQ
 wGNR/Mm6ZdLv4Y+sQby+/jF+nB8RdQIjbqUB3sBoiFBIJvzUTkovrRXzL2Hg3Ms=
X-Gm-Gg: ASbGncuHiShv9yggHNBoOqgzn1ET8hezSTJ5I790RcUqFHT5J5NkxKFzhPj+ijIUFcN
 z6J98EzaozsQhVuZJyLTNGuGN50j8o+s97PBX8HdhguKawYXJh8MxMJGsy8QcxY/KL84jFmTSTV
 vIzbfqqintEksMnac48xOpOJZJ/hP4ivLLSXIK01gQsz9dN8IfX+gghV2LUNBFOHfpNK4bTZNhh
 BYYSm8BK4F8H74t7pGQ86Cs0xlbLjmmK41VsuKJAipJOlOpM5lpeXU=
X-Google-Smtp-Source: AGHT+IFR6AeElKxTlNKkQNE5dWjiAj5lF7QRIvF/lDklx4mVTIU4QR3ScWD1sRgsVUW3TkGCfY1BJg==
X-Received: by 2002:a05:6000:1fad:b0:385:df2c:91aa with SMTP id
 ffacd0b85a97d-3864ce4a77cmr2196632f8f.7.1733925221567; 
 Wed, 11 Dec 2024 05:53:41 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:1b92:49fd:8154:d517])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521845sm1316013f8f.106.2024.12.11.05.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:53:40 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Wed, 11 Dec 2024 14:53:25 +0100
Subject: [PATCH 2/4] boot: android: free newbootargs when done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-bootargs-concatenation-v1-2-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733925217; l=683;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=OE1Xy5cljnPKV5UMtkvgBVpVgy99P855DXz1GjjjNgc=;
 b=9oL3TDOfsDZj2fSmTmIIP3N6AUz0rLVO2+jHIfUry5pSxpjat1iEdlico8aKp90cCa2XJnrAW
 hEDogbTn3GlBIK083KpVufNTe+BacU0KctmomN+JZKmgo9SWgiB8ATJ
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
X-Mailman-Approved-At: Wed, 11 Dec 2024 19:54:12 +0100
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

Free newbootargs when the concatenation is done and bootargs env
is set.

Fixes: 86f4695b ("image: Fix Android boot image support")
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 boot/image-android.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index 57158280b41c6552c82838e21384d925d5f7cde4..362a5c7435a3a8bcf7b674b96e31069a91a892b5 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -322,6 +322,7 @@ int android_image_get_kernel(const void *hdr,
 	}
 
 	env_set("bootargs", newbootargs);
+	free(newbootargs);
 
 	if (os_data) {
 		if (image_get_magic(ihdr) == IH_MAGIC) {

-- 
2.34.1

