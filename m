Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F0CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77CE874D3;
	Sun, 12 Nov 2023 01:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eNVNDk+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F5F8701D; Sun, 12 Nov 2023 01:10:20 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044AC87091
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35aa43c92daso4188855ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747783; x=1700352583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbDFNp4gAz6ncma9QA31DYiuDsCC6LPujz+voZC0ZO8=;
 b=eNVNDk+WuZlKigRnb8PI1VhWZBRmGo3Bpn1ks3FMKeODy7jzuD5EpVR0FaWMEoOp9m
 RZhpDMCvdSgaYqO6ID5CDAMYJBbIncLM8VrgBgTA0LY4kzBxM/GFhHbXXNvf+pQFW/29
 ut0Rma5aZh6Fu5rUREPBV7ROiPt6HZ1aggsak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747783; x=1700352583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbDFNp4gAz6ncma9QA31DYiuDsCC6LPujz+voZC0ZO8=;
 b=eDYFLc4nLqA8jTymurxXXC0wCslTOQB6Z0soFk6z2ksA2jsSAp4+OYUGZfhjzzPAlP
 ecRJgvfUdyrEYoV3gbxe1MSvTZ8D0zsPQRAUhXq+8Lf2oqu9DN0GoQMXijg0cVaq0Smm
 WUCB3DzxfQHFzOvPLf5msj4pSCBlHoA+quuRA5hiF83XWwGecPeE4i2X7Ea7+YLz9MYw
 X2U2ZP16BPlZz32ymsoVSE1iQIuaAkMNsqK/NapLZy8FtKILeTgoAzmfnpvLACJpIN6j
 xwfscu6IAgUVxFxSibYshG9UX8xzlDnSbMB5qt1TxxBd3x/nPnwJehnMlrstOiVVvNQ9
 LuWw==
X-Gm-Message-State: AOJu0YwA3H4RbSsD9a5CxzptqSpi3YenFstuFB65SSy6+AkSOi9mD8c1
 9I/o8KDx641Gy+clDs6E/PJuUtw6C3NzNg+IL6E/qw==
X-Google-Smtp-Source: AGHT+IHE3js44GToEJx411KyhYht1FgZ9nbOBwgAgX+tBQPLWVxJhWZcNEjShDw4aNFL6FOrUBCrCQ==
X-Received: by 2002:a05:6e02:174f:b0:351:e6e:7729 with SMTP id
 y15-20020a056e02174f00b003510e6e7729mr2917989ill.12.1699747783322; 
 Sat, 11 Nov 2023 16:09:43 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 14/29] bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
Date: Sat, 11 Nov 2023 17:08:59 -0700
Message-ID: <20231112000923.73568-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

This is a misnomer since we don't necessarily know that the image is a
FIT. Use the existing BOOTSTAGE_ID_CHECK_IMAGETYPE instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c        | 2 +-
 include/bootstage.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 5e3b5e940734..a64c253069f9 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -233,7 +233,7 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 #endif
 	default:
 		printf("Wrong Image Format for %s command\n", cmd_name);
-		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
+		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 		return -EBADF;
 	}
 
diff --git a/include/bootstage.h b/include/bootstage.h
index affb0e5c6a6a..59a76d0f0c40 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -147,7 +147,6 @@ enum bootstage_id {
 
 	BOOTSTAGE_ID_FIT_CONFIG = 110,
 	BOOTSTAGE_ID_FIT_TYPE,
-	BOOTSTAGE_ID_FIT_KERNEL_INFO,
 
 	BOOTSTAGE_ID_FIT_COMPRESSION,
 	BOOTSTAGE_ID_FIT_OS,
-- 
2.42.0.869.gea05f2083d-goog

