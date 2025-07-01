Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F03AC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CA982B18;
	Tue,  1 Jul 2025 15:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PqBCoz7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DE482F6A; Tue,  1 Jul 2025 15:38:29 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBF882F6A
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso33727715e9.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751377105; x=1751981905; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8tPcb4NbDp6IKrs6qpoPjiepOsjTQwyb4x6lZhIXKS4=;
 b=PqBCoz7wLkJvnPaj7Xr6lOIyhZYGbclEPJlyNkNGD0sRRbbQul3k7H3XGB1DPRK3xO
 VDV2pMBJubyWC2U1aNebPr2mJAxOXcGibwvNAgSqJbEtSCd6kT9eXWmCi215o1LRt2AR
 16XFdJ4t/YMSqR0CANbRkIfh2TnEBKw0b8SWdtjdN+dWNr3GDW5qE8py3PQA9nxCnJPP
 AI+edu5hondEhPas+clXukL4xjLPE8MTbXt1O4JWmcutfHo/RzqtZn43dxlyGS29Ou12
 KIrJgld47od4mIaOghv8qokEe1b8GQbE++lioNFSTQk1TkmNwkkC07HZpVqrEW4OJRR2
 yu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377105; x=1751981905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tPcb4NbDp6IKrs6qpoPjiepOsjTQwyb4x6lZhIXKS4=;
 b=wE+eDHZfGjkeDYChbixFc2OF2OPLwOK48Rl+ig8CEfLddKAHrnTXmpBMyieXA4JXQa
 oJAo1dBP8NyYfjBcVBcMoWf3h7owJUaak9LrfDQZTk/vjW9RLnQLgoIaAVpe7U/joOcT
 QZQaZlktI0OP1jewaJwACgWS5mQ9y9fwEVxnpJfT7/NfGEzO429bncIqA+kS8BGXaO/w
 EzXXHoTPBbOPWdhOEQ7NVpbh9Njg9S5INmiyyCPsf24YXiA+7YZxJXgJpnXfNhs3rTvM
 6vZR75hs6zCHbFukyExMpEdea48q773tFt3dHCI3vEDieCNNywHZUJMTXlcXTqNVWMvo
 bmUA==
X-Gm-Message-State: AOJu0YxIhJtawB9bhJgCdVMCGPVhKd6bav0r4nRcpP/JOM/FLp70QzSh
 Y7eZwjT6orTrK110026l1TYS3UOdYEF6g2NmJZUjLX83k47g7QaLHy6xx00QecCgF2M=
X-Gm-Gg: ASbGnctcPUMRBnvXmHisyUSBjyqqUqqGGXv6WaBSty4PcG8pu77L/kZTsliPBX6lY0o
 krOGu7fOuJfXYupEsGiXnnoDaTcoA8JYvqJhojPStmxpJsdeQMjR+6Wm6malNOIo6yv7y1X2Ci4
 lJpvaYWB13epuO5n/lAB+FicvlDUDl6zUx2C8LzNKVcz4HrGyk6602LxPAxmjgT5Q59zD6Xe0go
 2SckVK7JeRT6nCRCgW/3oF7rQjZgjXasW+cjAVs9cSTq6ce1mCc8xPz/YDEiS8+nlL8x7K9q020
 1SVaGAtT8qpTmHbE+kgwhEzghXD7abCzfRPzF3xOJirsIWWleftQymJDKXcM3UrW0VIsDbkkOVt
 seeTo/5jRFCzJuqo=
X-Google-Smtp-Source: AGHT+IFK93JAH9G01FjvjR16FN28OvdiPc9YrVYod7cdF8/va7MmhHOKnloO7u0gtZAjAoHwgkXD6Q==
X-Received: by 2002:a05:600c:674f:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-4538ee8384emr164962715e9.19.1751377105431; 
 Tue, 01 Jul 2025 06:38:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:fddb:f4a6:27d9:d8d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6fa2sm197268095e9.27.2025.07.01.06.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:38:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 01 Jul 2025 14:38:23 +0100
Subject: [PATCH 2/3] efi_loader: Prevent dereference of uninitialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-efiloader_fix-v1-2-f3c6e0b0ae43@linaro.org>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

If phandler is returned as NULL from efi_search_protocol then
protocol_interface is never assigned to. Add a check to prevent
protocol_interface being dereferenced in this case. Small refactor to
coalesce the two identical NULL checks of phandler.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_http.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 189317fe2d2..ce3a7a831ca 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -463,18 +463,18 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 
 	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
 
-	if (phandler)
-		protocol_interface = phandler->protocol_interface;
-
 	ret = efi_delete_handle(child_handle);
 	if (ret != EFI_SUCCESS)
 		return EFI_EXIT(ret);
 
-	http_instance = (struct efi_http_instance *)protocol_interface;
-	efi_free_pool(http_instance->http_load_addr);
-	http_instance->http_load_addr = NULL;
+	if (phandler) {
+		protocol_interface = phandler->protocol_interface;
+		http_instance = (struct efi_http_instance *)protocol_interface;
+		efi_free_pool(http_instance->http_load_addr);
+		http_instance->http_load_addr = NULL;
 
-	free(protocol_interface);
+		free(protocol_interface);
+	}
 
 	num_instances--;
 

-- 
2.39.5

