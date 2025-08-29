Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC192C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2691835C7;
	Fri, 29 Aug 2025 10:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NochwPUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F00F83447; Fri, 29 Aug 2025 10:17:02 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BD08364E
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ce772ce0dbso967389f8f.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455418; x=1757060218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIJpuOR7CYdxFQEqE6oyXLCYBfVsmaoE/vNR84YeqxY=;
 b=NochwPUiC7VUPxm9yQGQq9lAX+TOb4b2ArbdS6ypVgZW9R/Al81F24gFomoX0TBj7s
 +Cu85ZPnkvZ/piLJUaBS4tUwZrfExJM7N9AfTos8faIJ29msWtOHytyKVd5b6JeBpWnU
 SyfgL7vZpzwoAuHLmcbVSimWFi66cbyf8Woj4L8rduocoZ9TuLOz1/LlVt/HJeqSZA0l
 swTQGVqbWI+ubI4FsSnpEhrVGC8EzkZwnCOTSYbp7sMXgNfiOGfMHO3uLeb0ba+AIDhs
 Nw4JIj9FlIVUZfo7XSRXF237Ymf1rO8ffuz7Dq7jTzzhEkiIPxd5giJaf2eZQodIKAjN
 o6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455418; x=1757060218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIJpuOR7CYdxFQEqE6oyXLCYBfVsmaoE/vNR84YeqxY=;
 b=py1NVrSQAfXIjAyu8kUKw97nlZdwDK7Ps0SAK5kuxR/60hS1Lgiryh1+VOTiFaIUCS
 hc48YHoQjeLMe+esNn9f8bI+aeUUc/9vkHnQNfVmC6pLU2ZwbMx1HmuCZWRmyhkneCc/
 RWoM9meoe1gQG/zsOCRTHgQ6/NCfbJ7Atr090RfqH0oCUqtzVX5ZC6yMPGOWJoPpQjLn
 3ddCZ67PbAvJ+lHgw9yI59BP5WwOFNuVB9flkmUj6vEYiRX3uWLPUQADNk/8tnBXGMRG
 K2J+DVdDQMojjHxsz0bCquhRBbgjG5HFbyPcyQDcK7s4R2GFQl8ULW7OajZePwbMfpKO
 FzDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQfhvaUkbgjXEqEboRvZOphft93QJkwDmSC0j9mjclRhzQ8hTqzx6zhSsjXr7RM91MKK+79HU=@lists.denx.de
X-Gm-Message-State: AOJu0YwzKFkeeq/fol0sSUYIB7F8yUzFsM768y+3GuVOw9K1wTlPrzfq
 sECwpS1sp8X+kL38XirRtx+Ld6yq/jeJ3C0lH/9vPMuKBmDumbqOVNaokHKrVZYO+fs=
X-Gm-Gg: ASbGncsq2NpNCtOY0bd3TiTT7jA4NbTPIQe9E9ZN+XFLtgwHancFGxcesHSxwW18iGL
 8qyXzSIVXdvCQF6nF/GkiZnClhUkI3SEb//f0rwkm7gVzrmvctPRW6pFXRuXVo2M8ofILRCCoN7
 scV3jpzZsOQEOK8AKgxcLmNVHvSDq5dVIAKEn5TCbvPz4YRRQ0KWBxdmJ7KnAsAMCwqeICyjXcX
 TC5s9oIa4N8L89CIZ8WpWslvQsJWjZ5uTDyrOA6MEoKADLPrjPfy8XUAYAOhCpA50ObjHm7CID6
 aGSF+H3f52/1rfbEcYaf3uPTCOUvCzmmQMgv1Vlla20KHiqsJs3KhNiziB+J1K8Zwh08VXtX0RR
 vvg4v+YWl6Q82FFNIArQ4nEpKeNw2ZVpqiTlKfH+016Ra4DKMh3SlAUCkP1v99orJIT+ADzxLaC
 PXXuiuymD6/JArr3R8DjTJRy5menw46unGgX6XZrsD5k2LnAEyCdf8qB+B3prbqXTmAq9YgVW8p
 vrTbwRfH6euY3HUeGa2qXLsJYoHFXHtVitWVVB880PmLg==
X-Google-Smtp-Source: AGHT+IE1ErC+qmOURbB64HhVEuExqQXGL9e+K6YxTFUwGRmY0GWrwSHeiI38cx4/kOTQq9ya8xDihg==
X-Received: by 2002:a05:6000:2404:b0:3c0:5db6:aed with SMTP id
 ffacd0b85a97d-3c5dcefd13fmr22768254f8f.54.1756455418199; 
 Fri, 29 Aug 2025 01:16:58 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de
Subject: [PATCH 8/8] tools: imx8image: Mark imx8mimage_check_params() as static
Date: Fri, 29 Aug 2025 11:16:22 +0300
Message-ID: <20250829081628.2327372-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
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

The function is only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/imx8mimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8mimage.c b/tools/imx8mimage.c
index fe1aff35b4dd..3e974923652d 100644
--- a/tools/imx8mimage.c
+++ b/tools/imx8mimage.c
@@ -49,7 +49,7 @@ static uint32_t get_cfg_value(char *token, char *name,  int linenr)
 	return value;
 }
 
-int imx8mimage_check_params(struct image_tool_params *params)
+static int imx8mimage_check_params(struct image_tool_params *params)
 {
 	return 0;
 }
-- 
2.50.1

