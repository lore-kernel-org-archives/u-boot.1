Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54B0CCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 09:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F278206E;
	Tue, 14 Oct 2025 11:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="E1x8IeUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC2482991; Tue, 14 Oct 2025 11:17:28 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A4F807C0
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so947283866b.0
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1760433445; x=1761038245; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QXvyLs3gXw01qx9M6BLLQmodiyYljfkrjbYpIGw3mXA=;
 b=E1x8IeUOrpysWCS7n9UmxuzJ/46943mZ4gwvrXwYkSSSAmGwKAb+dxAjafjKiov1w6
 l9POFEzhtFbyPgRKx2+RvpGOYloKaMcHkz7zeSJGiWq7+Az0vrTxRhKlrulFuek78s5E
 vkHiTv9KehAhMUAVRXRcH3WL5CemiXbmPwv5xQcssXx5osFMRiXvegiOlHh4qtADhB3d
 2HUGzSMdho8L8eYMLVrYkuk/6q4sMw1QWLffPgydSJ8GQyVzvRRlQ7MQoZ1ObVaBUQ9P
 oVWorWG3ptq/40Va6wnCZfqAULDPPQtz823jSLwBCZd9Atc5iYJVWtdipAOpoK4ukJg7
 DDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760433445; x=1761038245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QXvyLs3gXw01qx9M6BLLQmodiyYljfkrjbYpIGw3mXA=;
 b=NkrtnD8JJWsIK61RXevBGTHhYtCBhg5njrkWa5E0qLTjj3XKE5afiT1BbQ8kV+ia4d
 N5RPBqyF+HlDASYXHOsdlMv1oXxEBq5AGKtuV3u9h4/OXpa+aS8OCMP7CPNGDUGXnEFN
 DknodnzkplcBq2jYTEbKE4mESG9kmcbPGIt22FxWNsIF+HrGq2sKvGlbD/AAH1sMFgVA
 T/IaoU5YvTfBQb2XXVTJAHHZCXuE5Sy1lbdXm04cp2XrC4Seeyq5VZ5+WnGyR5rmaCrc
 md1JccN6k+9WfgL1aMJ/39nFihpR32b1jbkt+AtmSBHkVaIcbIYjg6HXCeHjDe+OaAZx
 Wk9A==
X-Gm-Message-State: AOJu0YzgdHUEkASurS48KqIMjPYJoTktkP30vsOsBvBjh2LXyubFRR+q
 diwLD4Vj4VOagZwQ92hdvbcVfBXpF73Blj/s+rRuxGFBLiA9tjxmdF9zD6U0Gw==
X-Gm-Gg: ASbGncvSPQHTyKgla+ubjLTcC47MWXzMmlcWqfhuixTLXWnbkwInRKlXdPtjhU7kFOq
 gnfNsMVEge5JGswKVNQbxWxYNHX8YdtXOu6eEBhY3HnHe+F8eH0iz3EgiAQRXeJJxFkb+Pani63
 FGo22vQd+G+Rfu8s5SuAz5YtHGb+Uh3E/m7d66IvxDUsbkdxKtu9a437ykx8I44As+WOeUKaEsd
 tR+uJfM83jVaeWUwLd8yQ0bNZHk9sfy5eI9iV/+So0299aVJhWFC/dcnbRrNsdjRSpTDBz3p/K0
 wNkQsZ8XYe+EAzwl6Y1XlU7uemJA4MPGghjonaD0JLaISJ3FYbzm11yoqdQudP6vVGKGEaIo44T
 6ZgQMpspN+o6b9EVDdps2VII2pmYi8B0YzMgBFHkwKSIoGRQKlqGzsYTYOOsPRIVjPgKtA3+WqZ
 KgHVWvf3p11h16rf9j7qnnrw==
X-Google-Smtp-Source: AGHT+IEYm3PUf/2fvul/q/bGF6syTrjfzKGiIWwxHI0bIPpFRfjGXkqMXwAEfAaGsqf1WKhar8IWNg==
X-Received: by 2002:a17:907:970f:b0:b41:a3db:a53a with SMTP id
 a640c23a62f3a-b50a73da0d5mr2596343366b.0.1760433444419; 
 Tue, 14 Oct 2025 02:17:24 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c1132fsm1114824766b.54.2025.10.14.02.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 02:17:23 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] .gitignore: ignore more image files
Date: Tue, 14 Oct 2025 11:17:17 +0200
Message-Id: <20251014091717.309468-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

This expression covers various images files like, for example:

mkimage-out.spl-stm32.mkimage
mkimage.spl-stm32.mkimage

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index fa2db08dead..1ac737d2718 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ fit-dtb.blob*
 /SPL*
 /System.map
 /boards.cfg
+/mkimage*mkimage
 /mkimage-in-simple-bin*
 /simple-bin*
 /u-boot*
-- 
2.34.1

