Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720EC2BBCA
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA59088327;
	Sun, 23 Jun 2024 13:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xwuRG62P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7C1882E6; Sun, 23 Jun 2024 13:48:50 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868E9882B8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111aeso4073383a12.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143328; x=1719748128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYtWenobQtR5aOmVQ8zApI9sPDX6wCJfo/xL6dG1i0Q=;
 b=xwuRG62PvUIl6Dmqijk2StAs2y4Auy6PYStAuevDUYHjptBKXgyWsnhudAOsSzjwVZ
 FA2OUqpTvfaJaHSIgaexFmZ5tgPx+tgdXn1b8Yg7KsPrOQqwXSBqjubVwYfanPyFSFAW
 lBaUzjMA0zSQecqCKgL+jidrvKpxQmGwgbt6Lf8ZQ8FymRPqgNdrQL9LcRvvrSnFKqqF
 IRHZc78Xp7xgqoXJDWwm7V/Ivix1ObF6DFidXzFMUzvhwvNF5fo6SCYhVyU+dgP/S3o9
 XIlPGil2OZHDscNEQNh9GAgnz9Exl6rM6Ik4vy4gHbF2FvQesJ9r4QuQDsxYjRhXcPZI
 j4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143328; x=1719748128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYtWenobQtR5aOmVQ8zApI9sPDX6wCJfo/xL6dG1i0Q=;
 b=QzugKZoUTdKMy8MsNXavuT7Ua/E5k7Stmp8Mtb5e7n6QY3wsu5IiprMO7XgaNQPf3+
 clKUXumfMfeqU0PRPnAdM+yXt/EuH1K58WY5GDWFcIYVu1QioRq57L0QkZVUanHqYcic
 w7nQmPELjIGczSpr8AxXzvxIZQkNfAoyQqtYK//Ha92HLM+AhTPNqPuA3FkQo7kTeED5
 IUrBS4kr4asPPlRGXFkPCnA+IYOXlwb82roiUvgxyem7zCS1szEE8mb4vEIqkOGQcgt3
 joZ5WdXs+xAj9b9Ta9ZgNCnqLSnGhxUGHY3QfXeRGaM+Y4yHBpd8Fh28G5rWHD8MrMV2
 XmKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUprfb1LTV8c+67Awv+JBNJsH6PxrxTvqIPs7agH9vuoWBYNGl+n6xzNl2h82PR9EyJe2cxFB+/He/zvOnwIIShHNKO0A==
X-Gm-Message-State: AOJu0YzRP4aKFb1HqHJK5dejRvz4nZ0Vd8zleIi74khha2r0xLu4s3+E
 O+y3Gs5L91IZWXXBy8FS0LbG/rBh6TvqEIU+84osRw6x0XO0kyK3JFqCGDFj9Xg=
X-Google-Smtp-Source: AGHT+IErDuKiYlO2gwT6QD1wwopQd+NXjtjyx04eP8YKUxfyw0qqgw1idIrmaNv2rLOBXtkv/Vqxpw==
X-Received: by 2002:a50:cd1c:0:b0:57d:4ca4:61ba with SMTP id
 4fb4d7f45d1cf-57d4ca46204mr1382805a12.10.1719143327615; 
 Sun, 23 Jun 2024 04:48:47 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:48:46 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/8] tpm: fix the return code,
 if the eventlog buffer is full
Date: Sun, 23 Jun 2024 14:48:11 +0300
Message-ID: <20240623114838.14639-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
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

We currently return 'No space left on device' if the eventlong buffer
we allocated is not enough. On a similar check later on that function
during the call to tcg2_log_init() we return 'No buffer space
available'. So switch both error codes to -ENOBUFS since we are always
checking a buffer and not a device.

Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tpm-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index a67daed2f3c1..91526af33acb 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 		if (elog->log_size) {
 			if (log.found) {
 				if (elog->log_size < log.log_position)
-					return -ENOSPC;
+					return -ENOBUFS;
 
 				/*
 				 * Copy the discovered log into the user buffer
-- 
2.45.2

