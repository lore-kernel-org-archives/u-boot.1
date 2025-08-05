Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E6C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E477D83839;
	Tue,  5 Aug 2025 16:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qZ1kLEKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CDE0831E0; Tue,  5 Aug 2025 16:25:39 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B221A83855
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-32f1aaf0d60so55249611fa.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403934; x=1755008734; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h1u+iVVx7HItuT0LG3QzKJO4QU33BudNduVxwsThoek=;
 b=qZ1kLEKKpcMvqS1UX8mPoCM0bWC5Eo36MeJXdbz1mhvodvU4nkaBQ6DiQN99Wew4PR
 lWggUqCYN53FuhA/Izv6zgP65jlKVVim564MXqaJBcFpniz2HRCIeV56FXBojR6Ef+k9
 zEMAZQriJqijxmUijqkEteYBX3kjDa67j19IhVET/qX9K5L9l8+XT4yHhlGItYvl7Kgh
 3D+YCjfc10tRzisU9CzMarlvpfL1Jb+ou9Fgj27SteXBmCPw8Ql9W370ZTa8bthdUUNn
 ghMhyQwq/yyMHg4l5qf3z0pfuYlJQ0E1Djfs2pYm/uqY83t+bpR7cm0EVZ7cKrXvgnGe
 AMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403934; x=1755008734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1u+iVVx7HItuT0LG3QzKJO4QU33BudNduVxwsThoek=;
 b=NQ4JzgO1tDNZMabfi6RRjHkNLEhKiIKbl88v+xTuCdw3sS5+QHtgRhRFOG25QLF0bd
 rUlhVpSWRJPXY34T9/hjxoh0AOTpz0E7I2CKXcs8dacIAot9suOCs5IawxEQKWW42Ecx
 KupBAZIr0OPGCpiHNuxwX3qhhgvLNv7XVWU/6xALVexD1zYTG+3v0k2E4Dcmbhbjz4uu
 gdAIIzEpZn34g8Jk555wCQVWH55AP0lkLBbZQBONIzVsoWYavFneBs75sbE/U/WvumPF
 X/Q/1mouQgCnSUN+LrvwQBnEITyOZUfU9fJpsjNckWdnXPXoapU2AVUQXxOIhPzjxFXH
 a0wg==
X-Gm-Message-State: AOJu0Yx7dvRsREMGaQCBjMuVPjv5M14pMMQm1YryzZFYYFeaOHBha8C5
 K01U2gpWEVyCYV+4RoEUgwJKD2B3pxPikvV9U4Ax26QCuDcsjZF6kXfceUC1rggooFwYTCUYYpB
 A9A2O
X-Gm-Gg: ASbGncsILDUs3qZauT6kx1xbxG2sBMlZuBxWeR+Rv9W4zJwbHFC6McAwKuKLAfBBg7g
 bba/OLCda42lgKJhxazcsi7v4A107q5NXhzDklwdq6ml89DSV5U66GLaMaoq5E46V/KeH5vvaoe
 6aCntSSv8Rcxj39670PcpturmXeUuo50uvjERluIU8TxdAd4Dn6NH9sW2mSPv86SvlcaU+xIGMQ
 FRxqSYw/zDMP1DdlNnwzv3TtsyWx24RwCqCjc0kSjGp8enINhnwecq834Juqz1oeGKaxZrkhz/7
 g+zx30zAsCX3/QS3UGpp2DaN6XFxFAyRIqxl1eiXJlsLceCkuVpKMgMJp1Kh3PjjSwKJpt8LXLY
 /vC4lHBLxVClxN30OplyhpFOMIhMqFfgQxwbyGPdX2NRo3AoaJzE=
X-Google-Smtp-Source: AGHT+IH4RNZozlF4vPYGNFrg38UYBJzoUox1w4czU4bmIPPqcJeYNW48zAR/ZNykDpm48EUHgLfGug==
X-Received: by 2002:a05:6000:2910:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b8d94c37e5mr10772640f8f.44.1754403499736; 
 Tue, 05 Aug 2025 07:18:19 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm19307801f8f.47.2025.08.05.07.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:18:19 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 15:18:17 +0100
Subject: [PATCH 2/4] net: mvpp2: Return -ENOMEM for failed alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_mvpp2-v1-2-624ef87cadb9@linaro.org>
References: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
In-Reply-To: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Instead of returning -1 on a failed alloc, return -ENOMEM.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index c0328345973..b68d305a0dc 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -2329,7 +2329,7 @@ static int mvpp2_prs_mac_da_accept(struct mvpp2 *priv, int port,
 
 		pe = kzalloc(sizeof(*pe), GFP_KERNEL);
 		if (!pe)
-			return -1;
+			return -ENOMEM;
 		mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_MAC);
 		pe->index = tid;
 

-- 
2.39.5

