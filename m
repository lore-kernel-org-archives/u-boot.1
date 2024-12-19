Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080B9E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADF480383;
	Thu, 19 Dec 2024 19:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RPGnDJBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068AB802B4; Thu, 19 Dec 2024 19:29:39 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB7C803B5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a777958043so3611605ab.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632974; x=1735237774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqj2YVVu9L1AkthObNEdMZy2vUhvoT4ahnmRMzhQ574=;
 b=RPGnDJBafjsE9LVBdP7V0Y2CmhYQ222MUZ9XHyeC0bvBOgZr+jD0Ou8sTUODjOqlBu
 CWBk8NXULSi4giU3osL4dHUXbIgYYxr7POO2fwfqN7e0v4yo3i4BbjERhBoJKhMUCB3R
 CJD8lZIk7woP9OXQCewYuFiXCnvfvu0IeYDrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632974; x=1735237774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqj2YVVu9L1AkthObNEdMZy2vUhvoT4ahnmRMzhQ574=;
 b=T9e5pFREYxDPyeZyq6vWygx1Rum3OZjbS917MSL2HVZLuLBWwNtlAHk88i1x/83IoN
 fm3eklut+5YutIQEzOdMptAOgZidBHlmbJxtLwdA5VN0wcNyZknNOsyzisPmzMfKrv1l
 YmKUVznfHVTwPQXH8n4jrb7QcFMSByBTbRSz9iU1hMV7owNm1w6dBYgjVxyPZGNe06yX
 vmwUWWWbLIJWryPwXN/G7Dv6zCLxLW4YJ05JXUqEFc3cPemhRQiI3oBvErS5tR95ioI3
 ryJf1hndDWtlVD+ESGmBktz3+5fuXMxa5Ig+gG/P1xgQVvK6/swL8UnuMdDw8all90dH
 rxcg==
X-Gm-Message-State: AOJu0YxNAf83JHno/Z3hANumcQoGQibeZqv+h5Dj5KG8d/MH6sb5Hx/2
 vWfH7R/491TmVdi7NBihFZw+UjV4kiHen+AeNnpSVIMkdpArIqfkc4MmQHkJJuOWvNWP3NzO//o
 =
X-Gm-Gg: ASbGncumiBmVFkSfXxGEBjAluR3fDirfPrqA1cL+/C6tn/7dr4L9UjKRsjzVkOqAdBC
 xhK3TT7iWVJ/aWPglc4is6b26miLlXcx6qRCt2X/lXwqqHfZ26hHMuV918a2vYIKx2yUokWy1xd
 AkiDJusvU9tCPazPTxNsGSCM1r6CzGBYQOpfdWIt0pD8OER2Rnr8zrmo8g3b1E2Bp13XR7DF3mp
 DLC7vaI1HaYodLnwcwJ1CZJf6+D2/lT9MEQOf15b0dT8s0qSgGr4ElNMkxK7sibjzDhZ28lf5qc
 iMNppjJW3t+/VLiMrQ==
X-Google-Smtp-Source: AGHT+IErtENYVWMUJfip9tGJmOAz32hfGQ2NLqEZFF1+UFUfqMWvahHPerd+0tibAX/mOQZCXkoUGA==
X-Received: by 2002:a05:6e02:3201:b0:3a7:e286:a560 with SMTP id
 e9e14a558f8ab-3c2d1aa30b7mr1292415ab.2.1734632974260; 
 Thu, 19 Dec 2024 10:29:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 09/19] spl: Report a loader failure
Date: Thu, 19 Dec 2024 11:28:57 -0700
Message-Id: <20241219182907.2609704-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

If a loader returns an error code it is silently ignored. Show a message
to at least provide some feedback to the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 1ceb63daf31..7c57eb8539b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -612,6 +612,7 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
+		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
@@ -631,10 +632,13 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 					     "Unsupported Boot Device!\n");
 				}
 			}
-			if (loader &&
-				!spl_load_image(spl_image, loader)) {
-				spl_image->boot_device = bootdev;
-				return 0;
+			if (loader) {
+				ret = spl_load_image(spl_image, loader);
+				if (!ret) {
+					spl_image->boot_device = bootdev;
+					return 0;
+				}
+				printf("Error: %d\n", ret);
 			}
 		}
 	}
-- 
2.34.1

