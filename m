Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B88C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB58A8310F;
	Fri, 23 May 2025 15:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i0jgQBHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1969A831FE; Fri, 23 May 2025 15:04:17 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB4D83108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6023cf146d3so6114080a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748005454; x=1748610254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DCBLaEKhpywZWHtr43L99LcPV09Nk7X1dDZxnwaMSUg=;
 b=i0jgQBHiocDKvrv03qJWCoBNIJ3XH/I/7SXHKHBD3C7PPnXxxYRc4d/au1fmAE4MQe
 76D3QK+IBCT2vEC+3wZ67xH0hMfu2EMQ+emB8JSB/b//hhV/cy8HDcXcDSPxESLUJK9q
 x3QfaSdnYwv961Hr/BLTCIqq6ffqYRkxl7lxQDslJilI267WgMAG1TpDZaJCu6cLX0lR
 WPnWXj+ZtHZaAZQ9aUQtuicm+c1WgkbuM6OQ4dm5sDQkZ1PThKAKpsxjr24ELvNbSd6I
 aQCWzp/gxqqI7gJDDxoZ4vXHtl5jQBrRK+0L1sk7N5UjAi4GsQg/Tmrqm8jRX/dcJhMR
 Evzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005454; x=1748610254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCBLaEKhpywZWHtr43L99LcPV09Nk7X1dDZxnwaMSUg=;
 b=j1Fpld/k8Rwc10dbIMSyBo2C9hMINC3YoioXLNNz4dPeNa3lb7I6zzwurtIob+NNZj
 GbO0TvPCjnmF0EBT3Edt/Q4JCnRuCUQu3lH14yjN8OMCSU/telvhYQFOLWTonU2bTWCw
 O71Eh/XpOEP647qIS/ZBs8qF1v8ZKkJhZOPa1So2LhofcjcENYnvO4MROO/bYKzOgnp6
 Rz24p9L/NnlBVBcBIC1n4SPywgGZrmGQSG/ulOv/x/3+/qFgjInPA5ZPvjRm/8PubRVQ
 06tdhMkF5Jq8Lm0j75zWVswVPR3b7ouxVhq/T1OAzwyDXP6YLD/ZrAtQzQpbDnYKZtNf
 QLag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbsRGIlRPc0CQSBHUOevLvMdQP7X0GWnmY7r8PE63cGRpDewcRcsfkUHPWNpPuhQxDx7dAHeg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1xx4Ubsa8JS6hv0lQt9jmHZjqKieb+dfoL7ZKlWh0OgN02huG
 Rxss+jM5mP8j+/4jWVmbdJpqnfWjKdx00R+E+P9fq02AywzOv9DBDnOjAF4ybSPtEXU=
X-Gm-Gg: ASbGncvTCLXFXTFOkIB+b0mtT/qw1ySr89otbtV2wrVoDt9rmvjzQd9g/AcdnQ38NnI
 uB3oplr8cNLS+TjiLJ4bdIyzHdM+/RUxuEL/Cy5Ae6pHzsX/0d6qzLiFTFdtUvv27dQX9RYRg7N
 LFAdyd8a3+FZAFU7vN5dnV1Y4l3Qm1K6ra82agmulutb9pbE/Ocb4qToocPxZiJWRnqKYQeT35m
 akqVBPeuepSqx+fk5kIiEWcWijPRVFwv0XWfZth6r+li3xsLwL84IR/YxbLy6+RCIEoe0RcS21Q
 h6m9iLPpQ2U5WxMhtySZT0JsS3R6rI/4BM+yXUdEzHhVrRunT+Us6j8S8bgdiV6jXUMVH+ZQ09E
 =
X-Google-Smtp-Source: AGHT+IExkEABDD8H1QQEdmp62ou6SyFHdQ9KvRqujIMw7s1UiEqV8a14bKz4bDXRXxR9/CxDpgQVpA==
X-Received: by 2002:a17:906:68d5:b0:ad5:3a97:8438 with SMTP id
 a640c23a62f3a-ad53a979ccdmr1948467166b.41.1748005453637; 
 Fri, 23 May 2025 06:04:13 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04f263sm1216545566b.1.2025.05.23.06.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:04:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: michal.simek@amd.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Run dhcp if an http boot option is selected
Date: Fri, 23 May 2025 16:04:04 +0300
Message-ID: <20250523130404.2646298-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

The EFI boot manager relies on having an IP address before trying to
boot an EFI HTTP(s) boot entry. However, defining it as a boot or
pre-boot command is not always the right answer since it will
unconditionally add delay to the board boot, even if we don't boot
over the network.

So let's do a DHCP request from the boot manager, if 'ipaddr' is
empty and fail early if we don't have an address.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c0df5cb9acd9..2076630648f7 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -479,6 +479,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	if (!ctx)
 		return EFI_OUT_OF_RESOURCES;

+	s = env_get("ipaddr");
+	if (!s && dhcp_run(0, NULL, false)) {
+		log_err("Error: Can't find a valid IP address\n");
+		ret = EFI_DEVICE_ERROR;
+		goto err;
+	}
+
 	s = env_get("loadaddr");
 	if (!s) {
 		log_err("Error: loadaddr is not set\n");
--
2.49.0

