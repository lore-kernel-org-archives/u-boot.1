Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CE3C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8161F87C08;
	Tue, 23 Jan 2024 09:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="gfF7KR/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834B287BF6; Tue, 23 Jan 2024 09:16:24 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840C1876A7
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33931b38b65so1989420f8f.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 00:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1705997781; x=1706602581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWx7NeUGkf8iEuquwQjaeX3om9IFYMMhlq8/zURAtwc=;
 b=gfF7KR/XGh2i9W5rlNYakq62Kt2DM4RK+a1j8KcxxaG323cOHjSmmzj5MLNlHil7FV
 FE13zNu6vGyCZCQ8/ermtnAn+VoAWDV9zPRb116mxL2GkTBEcJaGFkNVJldcR+ElQNyh
 7OCmiHls3+6u79JXVlmzQyvz1xXe3lfpZ7yU5FVBQz7KT+2Ta2+WKMpNNZ3bGNSK+Uvb
 F8UzSKtSh78pgXs9mCb3VzifEElnNZKe3GT4DUpJPkUWMnvRq7bO+GMYEtmLGLFB1zlh
 Qbqptq33798KncllkiHdDy58ndwQmBBeX6sw/TdDLFepaJmonhHOqJYSTvV/X2Kswtn4
 3T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997781; x=1706602581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWx7NeUGkf8iEuquwQjaeX3om9IFYMMhlq8/zURAtwc=;
 b=gCATlghGCvjhiRq4bjkC5SiKHi+dtuD+0jGXqPff6wuIs7rekARAVh2jhOoI7jtPrK
 yxQYJgYmNN7rc687MBb/784qLJm3XIABEeTBy1Pvrr2xfFWhtZT37IS35vQsOceCbXtl
 kVnXA/boxjaYdb7Ji76Jz/1bvob5qYX8DhU3VSmkP9lEaDCAspyYZsXfSTiF3IIE0LzB
 3CIVC8scpa0gc+oLahFd+aCiJVUOBQXBGWp7FmrbYmAIVyGRNGR79/a1Mwx2qPXhLGUR
 A74FTKuM/QR3lTgUcvKln7bhZ9DsKjfejQcwi3MtcEGFfoBO9fvqv78fRR/AgYwUZOms
 hhQQ==
X-Gm-Message-State: AOJu0YzkKOsVXmFGY7xB4TPAMrTMnAs453GzinrURcd0co+ZJFGj1OwM
 V/0E0O5mcoKUFACBX6yofsZOVzKtLDzWqjfRGFHplNXrGvNqXmS6XMK6pXnQcGpLzeyVbSwaMLH
 n
X-Google-Smtp-Source: AGHT+IF+f5IedbdbqNLG2n73w220VFIKLCLBKFVwR54SQYIo0TizV2Gk3fxU+erTYZuR4/+Rv4YyYA==
X-Received: by 2002:a5d:5542:0:b0:337:c700:6429 with SMTP id
 g2-20020a5d5542000000b00337c7006429mr1237161wrw.282.1705997780854; 
 Tue, 23 Jan 2024 00:16:20 -0800 (PST)
Received: from hugo-IdeaPad-3-15ALC6.c.hoisthospitality.com ([84.199.249.162])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b00337d5aa55cdsm12614205wru.53.2024.01.23.00.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 00:16:20 -0800 (PST)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>
Subject: [PATCH] image-host: Fix error value paths and emit error messages to
 stderr.
Date: Tue, 23 Jan 2024 09:15:56 +0100
Message-Id: <20240123081556.418900-2-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123081556.418900-1-hugo.cornelis@essensium.com>
References: <20240122233057.GR3652023@bill-the-cat>
 <20240123081556.418900-1-hugo.cornelis@essensium.com>
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

Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
---
 tools/image-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index b2a0f2e6d1..06b05dcacb 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -351,12 +351,12 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
 	ret = snprintf(filename, sizeof(filename), "%s/%s%s",
 		       keydir, key_iv_name, ".bin");
 	if (ret >= sizeof(filename)) {
-		printf("Can't format the key or IV filename when setting up the cipher: insufficient buffer space\n");
-		ret = -1;
+		fprintf(stderr, "Can't format the key or IV filename when setting up the cipher: insufficient buffer space\n");
+		return -1;
 	}
 	if (ret < 0) {
-		printf("Can't format the key or IV filename when setting up the cipher: snprintf error\n");
-		ret = -1;
+		fprintf(stderr, "Can't format the key or IV filename when setting up the cipher: snprintf error\n");
+		return -1;
 	}
 
 	ret = fit_image_read_data(filename, key_iv_data, expected_size);
-- 
2.34.1

